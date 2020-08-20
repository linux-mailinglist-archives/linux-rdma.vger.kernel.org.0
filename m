Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5BB24C7EB
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgHTWrY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbgHTWrV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:21 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92580C061387
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:19 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t7so176088otp.0
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=429me9TE7Vhzd2q6YVBMVKKbtkPoL3HxIm0ExCPvfUs=;
        b=jxSPMpDu+xrCvBdfLTT++CzZTn3qlusA27+uUxdkrQEPte7zSqP016rdJvaX1gV/IN
         pknT1FnO+r+Rn663hX5GzI89GBudhoAJkS1/OyS8FyaCMJoQ+FlRZGcORcK3F46rnDA3
         GbrBOvaeMRfDNet+6PI2XnHKZZ/S9AU0OqEsFvMkYPDhBxh+r7UUy1Iol0uYekUzCodd
         MwsWYzHySjvu2Q2FkCLOlX+H05zjUUBIgDW/v5QQsyfX59CJ7oNHhBo8QGfqMP1rbbtJ
         87wcrCvNX2RDhKpahV9ewTXOT88nd/sc9xcag1DvCzEosv1iKOKaPTPOzqkdB97tPiHk
         JCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=429me9TE7Vhzd2q6YVBMVKKbtkPoL3HxIm0ExCPvfUs=;
        b=NfO/FLBQo+daATozzPZZsmxJ3ZRq+PKVxxPX6EyjCze+dbHbrU42Lg3NfcMtw9sCiY
         5w9Wg9ov49h4ebLBj3QhFCPvIAdPNxdcbFHe2F539bqC7pxAku6XvT65MsCkjFeg0Jna
         v+HOJwsQ2U/4VfBGwWH6kepPB/dM2Ud03G26q/DPNRl14Vfwsj5ipRu/JdMnH3VoTbwD
         EtWM/zh3KeAltea08STeSGkflxI64f1IW7U4ibTRkLhNXVAm4Py36HqlzZcPsFt2DgzW
         aozNgnJxwd02GCM0X3Z3Apl4calmAR1Cv5pklGwocN8h8tkIjJwOekQLhNcivEI6uCfa
         L7xg==
X-Gm-Message-State: AOAM531ucewfjTDL7l2OF6rU88WqSAxnxx2JT+8cM/pu5+X7/pnn+mGU
        20sB1JgUumUlC5AVUh3eSrWiPru1/yhSJA==
X-Google-Smtp-Source: ABdhPJw60sVQCpGXeaqhBAuLCzDFMmc4G9+xHlsPKGhOBkpNjJEPKnTIp3ZSkGW/ll7A3q6Y0ar4HQ==
X-Received: by 2002:a05:6830:1ad7:: with SMTP id r23mr99010otc.96.1597963636271;
        Thu, 20 Aug 2020 15:47:16 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id r10sm752160otd.65.2020.08.20.15.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 04/17] ib_verbs.h: Added missing IB_WR_BIND_MW opcode
Date:   Thu, 20 Aug 2020 17:46:25 -0500
Message-Id: <20200820224638.3212-5-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820224638.3212-1-rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Also assigned the IB_WC_XXX to the IB_UVERBS_WC_XXX where they
are defined. This follows the same pattern as the IB_WR_XXX opcodes.
This fixes an incorrect value for LSO that had crept in but was not used.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 include/rdma/ib_verbs.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c0b2fa7e9b95..05362947322b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -952,13 +952,14 @@ enum ib_wc_status {
 const char *__attribute_const__ ib_wc_status_msg(enum ib_wc_status status);
 
 enum ib_wc_opcode {
-	IB_WC_SEND,
-	IB_WC_RDMA_WRITE,
-	IB_WC_RDMA_READ,
-	IB_WC_COMP_SWAP,
-	IB_WC_FETCH_ADD,
-	IB_WC_LSO,
-	IB_WC_LOCAL_INV,
+	IB_WC_SEND = IB_UVERBS_WC_SEND,
+	IB_WC_RDMA_WRITE = IB_UVERBS_WC_RDMA_WRITE,
+	IB_WC_RDMA_READ = IB_UVERBS_WC_RDMA_READ,
+	IB_WC_COMP_SWAP = IB_UVERBS_WC_COMP_SWAP,
+	IB_WC_FETCH_ADD = IB_UVERBS_WC_FETCH_ADD,
+	IB_WC_BIND_MW = IB_UVERBS_WC_BIND_MW,
+	IB_WC_LOCAL_INV = IB_UVERBS_WC_LOCAL_INV,
+	IB_WC_LSO = IB_UVERBS_WC_TSO,
 	IB_WC_REG_MR,
 	IB_WC_MASKED_COMP_SWAP,
 	IB_WC_MASKED_FETCH_ADD,
@@ -1291,6 +1292,7 @@ enum ib_wr_opcode {
 	IB_WR_RDMA_READ = IB_UVERBS_WR_RDMA_READ,
 	IB_WR_ATOMIC_CMP_AND_SWP = IB_UVERBS_WR_ATOMIC_CMP_AND_SWP,
 	IB_WR_ATOMIC_FETCH_AND_ADD = IB_UVERBS_WR_ATOMIC_FETCH_AND_ADD,
+	IB_WR_BIND_MW = IB_UVERBS_WR_BIND_MW,
 	IB_WR_LSO = IB_UVERBS_WR_TSO,
 	IB_WR_SEND_WITH_INV = IB_UVERBS_WR_SEND_WITH_INV,
 	IB_WR_RDMA_READ_WITH_INV = IB_UVERBS_WR_RDMA_READ_WITH_INV,
-- 
2.25.1

