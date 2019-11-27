Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9735A10AE05
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2019 11:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfK0Knx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Nov 2019 05:43:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37511 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfK0Knw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Nov 2019 05:43:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id bb5so9582651plb.4
        for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2019 02:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ViIuyO3Gv6a7wDLuhwjZspkqlJjNUfYUkFdNpGhHua0=;
        b=EO34lUdDTkJKxhaShSlFWnWrkSVmO4uyc5GWSzFCa6GvS9B4HcuHpkiJj1K8tj+9I6
         R12oMeun5rtBCguFBhT7fi+CBe1FLHIFvCJsuIHow/tslfRUjRKXbhOFRjzyapP6bZHy
         5rzwGajWpyGUjk/hwK45FUqIlkESJ1sIksJpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ViIuyO3Gv6a7wDLuhwjZspkqlJjNUfYUkFdNpGhHua0=;
        b=WbWyNX0rih7Th8C8Nd06MmOsadyM8RpygToguGTF2kU6DiR5mADI4ZQUi26hc3I8GC
         7qgb/3NMgP0X21McGINUUzwrK0NZHe4vic5VeoJRabBKsfGdam8RB36kFw3n00qrXXMI
         5S9oMZisMbh9HOLQbCIoEaZMyubJfXFoYC/qluR53Du6EhAQUgRqQjPUYtmCG0aHFD3r
         2C7J5jgll4pVWe3CFJ7XyeUY+tNszL1SC5rcU6E3vUmLazg6uflC0qaLY6og4tS2tyTx
         VFMrtMk97xAp/QXyqj015YveEG31djWatMhLvjOf6j5Meb8wb/tU3HJx7OBmM3ZrGXOa
         n+6w==
X-Gm-Message-State: APjAAAXcguu7OJy5O5YtfadDEhMfMVgj50OToNNpF0ftGok0/npk2FNe
        hKOkyfukGFxjwokxq3Qx2mrggA==
X-Google-Smtp-Source: APXvYqx0FxP4nS3T7Z10ajyy0sbUKJ7yM+q8yRMHoiuuE3mvC6U1Wp6CmR4oJyhem/CPHTzu9921XQ==
X-Received: by 2002:a17:902:143:: with SMTP id 61mr3361768plb.343.1574851431783;
        Wed, 27 Nov 2019 02:43:51 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x190sm16104286pfc.89.2019.11.27.02.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 02:43:51 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     nmoreychaisemartin@suse.com, linux-rdma@vger.kernel.org,
        Luke Starrett <luke.starrett@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH rdma-core 2/2] bnxt_re/lib: Recognize additional 5750x device ID's
Date:   Wed, 27 Nov 2019 05:43:35 -0500
Message-Id: <1574851415-4407-3-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574851415-4407-1-git-send-email-devesh.sharma@broadcom.com>
References: <1574851415-4407-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Luke Starrett <luke.starrett@broadcom.com>

BCM5750x family includes 57504 and 57502. Until recently the chip_num
register always conveyed 0x1750 (57508). Recent devices properly
reflect the SKU in the chip_num register. Update Phase5 checks to
reflect this.

Signed-off-by: Luke Starrett <luke.starrett@broadcom.com>
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 providers/bnxt_re/main.c | 6 ++++--
 providers/bnxt_re/main.h | 5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/providers/bnxt_re/main.c b/providers/bnxt_re/main.c
index e290a07..803eff7 100644
--- a/providers/bnxt_re/main.c
+++ b/providers/bnxt_re/main.c
@@ -75,7 +75,7 @@ static const struct verbs_match_ent cna_table[] = {
 	CNA(BROADCOM, 0x16EF),  /* BCM57416 NPAR */
 	CNA(BROADCOM, 0x16F0),  /* BCM58730 */
 	CNA(BROADCOM, 0x16F1),  /* BCM57452 */
-	CNA(BROADCOM, 0x1750),	/* BCM57500 */
+	CNA(BROADCOM, 0x1750),	/* BCM57508 */
 	CNA(BROADCOM, 0x1751),	/* BCM57504 */
 	CNA(BROADCOM, 0x1752),	/* BCM57502 */
 	CNA(BROADCOM, 0x1803),	/* BCM57508 NPAR */
@@ -118,7 +118,9 @@ static const struct verbs_context_ops bnxt_re_cntx_ops = {
 
 bool bnxt_re_is_chip_gen_p5(struct bnxt_re_chip_ctx *cctx)
 {
-	return cctx->chip_num == CHIP_NUM_57500;
+	return (cctx->chip_num == CHIP_NUM_57508 ||
+		cctx->chip_num == CHIP_NUM_57504 ||
+		cctx->chip_num == CHIP_NUM_57502);
 }
 
 /* Context Init functions */
diff --git a/providers/bnxt_re/main.h b/providers/bnxt_re/main.h
index be57349..368297e 100644
--- a/providers/bnxt_re/main.h
+++ b/providers/bnxt_re/main.h
@@ -56,7 +56,10 @@
 
 #define BNXT_RE_UD_QP_HW_STALL	0x400000
 
-#define CHIP_NUM_57500		0x1750
+#define CHIP_NUM_57508		0x1750
+#define CHIP_NUM_57504		0x1751
+#define CHIP_NUM_57502		0x1752
+
 struct bnxt_re_chip_ctx {
 	__u16 chip_num;
 	__u8 chip_rev;
-- 
1.8.3.1

