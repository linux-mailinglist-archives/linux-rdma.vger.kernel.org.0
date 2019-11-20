Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF874103440
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 07:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfKTGUf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 01:20:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40686 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfKTGUf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Nov 2019 01:20:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id y5so263166wmi.5
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 22:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b1VMUXLMfFtqtg1d5fgksjrRHSmcXvmqNc/pq4Zicfc=;
        b=Lnqb/Kz65sfvfCnLkGQFHWjhyDz9bKe8DbWCLD3YMATLLK9Ay3V8XKmrbACwY6zRaz
         SBW4RVX45WL6fHYEKDgZ16Os9regzILlOj1UV10bKIXD9g8eLuw+qdObzmufDyWxsdaJ
         tSAvBF9KerSNa1QGWZ3oiFGJyp3NkrNTiOCwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b1VMUXLMfFtqtg1d5fgksjrRHSmcXvmqNc/pq4Zicfc=;
        b=rhvqUR6nS1PhPJKeFDHHKqUGSVAuqY+eGE+wwRn3xEUvsHboVbbPcAri03ThbVLT2Z
         33NQQq5Urwd3YvGtZl3dibaflkwd7keuBLkRLSYsjanmmFD3xf7/zGxY8moebGnYE45+
         0I3pSgNv6JPpnghZlClJgbpCKYW0hEKsb0K/lxSwxVGNZq5Z5NmdqhQC03+/M/RWaz3X
         BPm/pfz8b6p1WVF5lBBmMQivh2yOojJmrdWDSWQXBbxkNAZzS3lkKOW5BCE6p1WZ8Xc4
         5Ijk4et42PFNZkW8ZoD6tucnSaYYhjBZE9rQoqaOkVmDUqTrL6dfnvx9PyadWXBGsTsH
         ECZg==
X-Gm-Message-State: APjAAAXpmeBoHE9kqxN2VdW6AWNc0c1VizGzJ+KqIRZDJHMSEu7cgFYg
        dfGrl2MZO9KSXRSwAmsL2Hjgxg==
X-Google-Smtp-Source: APXvYqxtvKc55EI/JmPd4AYEwoSd1gjWkeXGUALAhJPrb29a9BmBoSIiWeP7U05nyi1pdugiQPBx0A==
X-Received: by 2002:a7b:c642:: with SMTP id q2mr1142150wmk.169.1574230832651;
        Tue, 19 Nov 2019 22:20:32 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j7sm32466705wro.54.2019.11.19.22.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 22:20:32 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Luke Starrett <luke.starrett@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V2 for-rc 1/2] RDMA/bnxt_re: Fix chip number validation Broadcom's Gen P5 series
Date:   Wed, 20 Nov 2019 01:20:17 -0500
Message-Id: <1574230818-30295-2-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574230818-30295-1-git-send-email-devesh.sharma@broadcom.com>
References: <1574230818-30295-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Luke Starrett <luke.starrett@broadcom.com>

In the first version of Gen P5 ASIC, chip-id was always
set to 0x1750 for all adaptor port configurations. This
has been fixed in the new chip rev.

Due to this missing fix the end customer are not able to
use adaptors based on latest chip rev of Broadcom's Gen
P5 adaptors.

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

