import { NextRequest, NextResponse } from "next/server";

export const maxDuration = 60;
export const dynamic = "force-dynamic";

export async function POST(req: NextRequest) {
    try {
        const body = await req.json();
        const { imageBase64, itchingLevel, spreadRate, recentChanges } = body;
        
        if (!imageBase64) {
            return NextResponse.json({ error: "imageBase64 field is required" }, { status: 400 });
        }

        // Mock response for demo purposes
        const mockResult = {
            triagePriority: "Routine Triage Priority",
            visualFeatures: [
                {
                    feature: "Mild skin irritation",
                    urgencyLevel: "Low" as const,
                    description: "Slight redness visible in the analyzed area"
                }
            ],
            overallAssessment: "The analyzed skin area shows minor irritation with no immediate signs of concern. The skin appears to be in generally good condition with mild surface-level changes.",
            simpleExplanation: "This appears to be a minor skin issue that can be managed with basic home care.",
            precautions: [
                "Keep the area clean and dry",
                "Avoid scratching or irritating the area",
                "Apply a gentle moisturizer",
                "Monitor for any changes over the next few days"
            ],
            otcMedicines: [
                {
                    name: "Calamine Lotion",
                    purpose: "Soothes skin irritation and reduces itching",
                    searchQuery: "calamine lotion for skin irritation"
                },
                {
                    name: "Hydrocortisone Cream (1%)",
                    purpose: "Reduces inflammation and itching",
                    searchQuery: "hydrocortisone cream 1% over the counter"
                }
            ],
            seekDoctor: false,
            disclaimer: "This is an AI wellness triage tool, not a medical diagnosing instrument. Always consult with a healthcare professional for proper medical advice."
        };

        return NextResponse.json(mockResult);
    } catch (error: any) {
        console.error("Skin scan error:", error);
        return NextResponse.json({ error: error.message || "AI service error" }, { status: 500 });
    }
}
