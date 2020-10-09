Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AE4288F32
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 18:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbgJIQwt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 12:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389431AbgJIQwt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 12:52:49 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041E6C0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 09:52:48 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id i12so9608740ota.5
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/JtBANhH4Z/BdLlGjS0NlBGzyLw4E4xXrO1tS6ffJys=;
        b=FfIR+SY0vgqv7nI3Dq+qv4YG7Ur2GMmNgASA6vdSbh7SQ0VWHoKOb5/l3Uo+9UlZQo
         8XgbpCoa1nuMWvdYfnjImkTPFUud1Xn3GH+aPR1bVCuaeLjBXqOg72lELvLp5BzEeztK
         koQupRq5/8QrsljA3KH9DTxa8Qn3+R+rJk3Z6T1a5g3eHDWadzBr/ir72EmPT1FZSwpY
         CbAiJGvVqSkzghW6SOFvaXBnuJ7eey7D/1ykvnqyTwiDo6y8rQd45tMHCqU9jDrtyLiU
         9BHjyMb6Hco6qo1AJEOAI2Z652ILN/ey3CVYv1OkbGugRA8rEaVNVe0+EQ/wLHDJBaqY
         sjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/JtBANhH4Z/BdLlGjS0NlBGzyLw4E4xXrO1tS6ffJys=;
        b=jEJ3VkOAXpuzqOLtYk7nGRAPUz7vGXN/qgcJ7BuDctC9NNyhNthGZjGA56T2Np4ipe
         SE8bmfFlsA9/eQvP5rTfqaJdoE7mehdRyI4BDyiAFO3BN30q5gY3qAVEVw6dzYnCJ3h8
         aL5bZgVb+i9KDCd+q/Yih4NkNdFlNVB/WVl+PwO62AEwbphrTOTmf0XOHKbxtOxKYGNl
         +iOWdJaN33GxPW0VMelxPZ1mjMoMP/a9OQBtxOnyCdJsxfQiADgFd/Ie4HZR5crJ21gb
         O9AKvdEbGVaxydbpFxyXceVW2vIHfwEBhepqgAOOmQkIGGc+Q1rI4ovFJxCerZ1eqb7E
         aQlw==
X-Gm-Message-State: AOAM532Dq1yuNW9NofLd9mFWv+HbOC9OnAbShLovG8Cs+ZuXvb35doTj
        cQcwDjwTrkcClis/luEukEdAXxkrBkU=
X-Google-Smtp-Source: ABdhPJxf1NiRmo3I3T8TCEjUcliFk25NI+iTgnXCW8N2Lb5lED2LuQLF7io0JqV1XM65/cPMn5mZUw==
X-Received: by 2002:a9d:c03:: with SMTP id 3mr8039303otr.146.1602262368325;
        Fri, 09 Oct 2020 09:52:48 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:21af:60b5:ebc7:e8c6])
        by smtp.gmail.com with ESMTPSA id y13sm6841073ote.45.2020.10.09.09.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 09:52:47 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] rdma_rxe: remove unused RXE_MR_TYPE_FMR
Date:   Fri,  9 Oct 2020 11:51:13 -0500
Message-Id: <20201009165112.271143-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a left over from the past. It is no longer used.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 1 -
 drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 47f737736961..390d8e6629ad 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -31,7 +31,6 @@ int mem_check_range(struct rxe_mem *mem, u64 iova, size_t length)
 		return 0;
 
 	case RXE_MEM_TYPE_MR:
-	case RXE_MEM_TYPE_FMR:
 		if (iova < mem->iova ||
 		    length > mem->length ||
 		    iova > mem->iova + mem->length - length)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 560a610bb0aa..658b9b1ebc62 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -273,7 +273,6 @@ enum rxe_mem_type {
 	RXE_MEM_TYPE_NONE,
 	RXE_MEM_TYPE_DMA,
 	RXE_MEM_TYPE_MR,
-	RXE_MEM_TYPE_FMR,
 	RXE_MEM_TYPE_MW,
 };
 
-- 
2.25.1

