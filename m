Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 016EB1028A2
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 16:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfKSPtR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 10:49:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39802 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfKSPtR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 10:49:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so11964223plk.6
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 07:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AeJSkx2kTbF412koD5SLlgijO+d9oJ/AcNJGEwZ6kSI=;
        b=Qmi+taPCTJzpLnPGv+Q6yxwuzP1StmA5EX+JEOE9eKAm/IP41utVA2mJt1sREfgWpf
         XoLCrMpmNqIbU1SlebJjFzspbi4cRAp1L53mFl0IL2dWUTTgPadk/MtPEAAs3t3388E4
         BN2IwMmF9nQm8LHkpqQs+BK1MNXprf9sqNzpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AeJSkx2kTbF412koD5SLlgijO+d9oJ/AcNJGEwZ6kSI=;
        b=gQx7/q06MCOjb0UR9a7vKOpt9zQwYFCIlmPqZD/psISZYQNr/9NXyvyWl2kHHswuA3
         MMV88DRQy2dPte3qRfpKlstRPu0NatlcqXDOucQMO2r/zNHUEPcjvxM1r9D7iSzsigVV
         Cu3jkLE1beib3WAw+mOKWzKTJ4QnvHAQ1Wgs0xQwNFZ6s6Ln+BDd1V4t68cMb0dKQ+7d
         8dyB97oa3SvcXuOfnhBw0G6OL2/mf2NaB4gecPSfOihVmGj+MflIz0tIW01ZXD2pDlLU
         c0itNwu5A8uSz81Xd4bwj6VDfPLZw8igNahsS01Hfn92wvlT0B4cAD0hm7NnP13twm7a
         E8cQ==
X-Gm-Message-State: APjAAAVIOjtxLTp4HmGOCZwmNmAqPFQ/TIVSFpVN41Wl2stZWuKrew6Y
        556D9E13o/BxEwq5WRhZKzRM1A==
X-Google-Smtp-Source: APXvYqztMU93ByoUkEh3oy/HpaLP/dFRcEZzacWMOEp+npw5CYgdxW55C4BSDauMyE0LqHsKWsKKZg==
X-Received: by 2002:a17:902:59c9:: with SMTP id d9mr34177622plj.229.1574178556313;
        Tue, 19 Nov 2019 07:49:16 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 10sm24263620pgs.11.2019.11.19.07.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 07:49:15 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Luke Starrett <luke.starrett@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH for-rc 1/3] RDMA/bnxt_re: Fix chip number validation Broadcom's Gen P5 series
Date:   Tue, 19 Nov 2019 10:48:49 -0500
Message-Id: <1574178531-15898-2-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574178531-15898-1-git-send-email-devesh.sharma@broadcom.com>
References: <1574178531-15898-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Luke Starrett <luke.starrett@broadcom.com>

In the first version of Gen P5 ASIC, chip-id was always
set to 0x1750 for all adaptor port configurations. This
has been fixed in the new chip rev.

Making a change in chip-number validation check to honor
other chip-ids as well.

Fixes: ae8637e13185 ("RDMA/bnxt_re: Add chip context to identify 57500 series")
Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Luke Starrett <luke.starrett@broadcom.com>
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index fbda11a..aaa76d7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -186,7 +186,9 @@ struct bnxt_qplib_chip_ctx {
 	u8	chip_metal;
 };
 
-#define CHIP_NUM_57500          0x1750
+#define CHIP_NUM_57508		0x1750
+#define CHIP_NUM_57504		0x1751
+#define CHIP_NUM_57502		0x1752
 
 struct bnxt_qplib_res {
 	struct pci_dev			*pdev;
@@ -203,7 +205,9 @@ struct bnxt_qplib_res {
 
 static inline bool bnxt_qplib_is_chip_gen_p5(struct bnxt_qplib_chip_ctx *cctx)
 {
-	return (cctx->chip_num == CHIP_NUM_57500);
+	return (cctx->chip_num == CHIP_NUM_57508 ||
+		cctx->chip_num == CHIP_NUM_57504 ||
+		cctx->chip_num == CHIP_NUM_57502);
 }
 
 static inline u8 bnxt_qplib_get_hwq_type(struct bnxt_qplib_res *res)
-- 
1.8.3.1

