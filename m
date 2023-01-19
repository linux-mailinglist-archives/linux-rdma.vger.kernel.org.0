Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B2F674089
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jan 2023 19:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjASSGA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Jan 2023 13:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASSF7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Jan 2023 13:05:59 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A89B740
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 10:05:58 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id t7-20020a05683014c700b006864760b1caso1691657otq.0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 10:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxdCVE91lk8aTAYYJv6bUt4HbFBqu9XYKt+lJsg68Jg=;
        b=FpRekNI7da807uf5ggbi5L9LImPMUC0Dq4GNvgCxPjHQqVDuGaRFaD1KXRiDW+IPE0
         9eerpxxieoYtb2dIFJOQ8f57k5oNR1HyHGfBB7xiENWNdCKYtqfZDrJz4tGqm3G/Lt1h
         ypASn6bzcEdaAoZG93iEjcKda/bptAkPrGK5YhnVL0ItIccOgbAKX06tMn53ze3CfEuI
         sp7c6wSg7vwohLZYjMhEfVoJjmh2b15pVYGVmBkr3X5PQqaApVVrDcCZuRvL6NWYW/Em
         QfQQXRfm//FnNdrHii8HSwvHEpXMSIjRRzXSA5HP/WdNFoONEw7abuZNpEk3yBLAIXoe
         /jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxdCVE91lk8aTAYYJv6bUt4HbFBqu9XYKt+lJsg68Jg=;
        b=5qIVrleQL4vHlkFv31J4K3cSHwxiImskMPvS92y9yS1CTBM6vyY/BRRlvipEiaeF8v
         smn7SCCZ/b07p8ymzniW0gRKMiBf2R36h28NnhdVGDbltIdH8rZ7dwIofn4E0dbZ31Xa
         96w3FkkiDSMB6tszvnE00HWcgik+DvwkzvJWd26bXlAMLWz9ycewoLmXkqXL1yKnayU3
         1p18sUhpdEgp3sZaVJeikZr7y4aQcW8B8Ov6+0uDVpKKDB6TEfEQD0UHA/yrtDOZXr5x
         2JQkBH8thv9VTSiXPFilhh1EPIZlyrP9ul65/xexdqmqxwSlntE4iBIOVJdTaGPDmmUF
         y5oA==
X-Gm-Message-State: AFqh2krdxFdwOrCahiMzk+NV44x5YuktBchfVNCxhJsN4H9himkLbCj3
        ThPl3Qvpo2oE0hsPoYjtxiA=
X-Google-Smtp-Source: AMrXdXuPIQiskLM0hZGVwac4x2kPO3gBywUvZiVmgy4ZbZZERvWMpl21YY6cUaf23KNUoI65y8vTaA==
X-Received: by 2002:a9d:1b7:0:b0:685:134:b743 with SMTP id e52-20020a9d01b7000000b006850134b743mr5426593ote.11.1674151557710;
        Thu, 19 Jan 2023 10:05:57 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-d086-74d8-5274-c0f1.res6.spectrum.com. [2603:8081:140c:1a00:d086:74d8:5274:c0f1])
        by smtp.gmail.com with ESMTPSA id i25-20020a9d6259000000b0068649039745sm4702491otk.6.2023.01.19.10.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:05:57 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        linux-rdma@vger.kernel.org, Rao.Shoaib@oracle.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH] RDMA/rxe: Fix parameter errors
Date:   Thu, 19 Jan 2023 12:05:07 -0600
Message-Id: <20230119180506.5197-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Correct errors in rxe_param.h caused by extending the range of
indices for MRs allowing it to overlap the range for MWs. Since
the driver determines whether an rkey is for an MR or MW by comparing
the index part of the rkey with these ranges this can cause an
MR to be incorrectly determined to be an MW.

Additionally the parameters which determine the size of the index
ranges for MR, MW, QP and SRQ are incorrect since the actual
number of integers in the range [min, max] is (max - min + 1) not
(max - min).

This patch corrects these errors.

Fixes: 0994a1bcd5f7 ("RDMA/rxe: Bump up default maximum values used via uverbs")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index a754fc902e3d..14baa84d1d9d 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -91,18 +91,29 @@ enum rxe_device_param {
 
 	RXE_MIN_QP_INDEX		= 16,
 	RXE_MAX_QP_INDEX		= DEFAULT_MAX_VALUE,
-	RXE_MAX_QP			= DEFAULT_MAX_VALUE - RXE_MIN_QP_INDEX,
+	RXE_MAX_QP			= RXE_MAX_QP_INDEX
+						- RXE_MIN_QP_INDEX + 1,
 
 	RXE_MIN_SRQ_INDEX		= 0x00020001,
 	RXE_MAX_SRQ_INDEX		= DEFAULT_MAX_VALUE,
-	RXE_MAX_SRQ			= DEFAULT_MAX_VALUE - RXE_MIN_SRQ_INDEX,
-
-	RXE_MIN_MR_INDEX		= 0x00000001,
+	RXE_MAX_SRQ			= RXE_MAX_SRQ_INDEX
+						- RXE_MIN_SRQ_INDEX + 1,
+
+	/*
+	 * MR and MW indices are converted to rkeys by shifting
+	 * left 8 bits and oring in an 8 bit key which either
+	 * belongs to the driver or the user depending on the
+	 * MR type. In order to determine if the rkey is an MR
+	 * or an MW the index ranges below must not overlap.
+	 */
+	RXE_MIN_MR_INDEX		= 1,
 	RXE_MAX_MR_INDEX		= DEFAULT_MAX_VALUE,
-	RXE_MAX_MR			= DEFAULT_MAX_VALUE - RXE_MIN_MR_INDEX,
-	RXE_MIN_MW_INDEX		= 0x00010001,
-	RXE_MAX_MW_INDEX		= 0x00020000,
-	RXE_MAX_MW			= 0x00001000,
+	RXE_MAX_MR			= RXE_MAX_MR_INDEX
+						- RXE_MIN_MR_INDEX + 1,
+	RXE_MIN_MW_INDEX		= DEFAULT_MAX_VALUE + 1,
+	RXE_MAX_MW_INDEX		= 2*DEFAULT_MAX_VALUE,
+	RXE_MAX_MW			= RXE_MAX_MW_INDEX
+						- RXE_MIN_MW_INDEX + 1,
 
 	RXE_MAX_PKT_PER_ACK		= 64,
 
-- 
2.37.2

