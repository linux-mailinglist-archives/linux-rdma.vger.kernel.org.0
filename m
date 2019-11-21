Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A425104ABD
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 07:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfKUGWo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 01:22:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54350 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUGWo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Nov 2019 01:22:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id x26so2072521wmk.4
        for <linux-rdma@vger.kernel.org>; Wed, 20 Nov 2019 22:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b1VMUXLMfFtqtg1d5fgksjrRHSmcXvmqNc/pq4Zicfc=;
        b=Diz+QT1lsk/30eJhnEQ2DZYIKXNKWkUp0v4Zcves4B7avjmtqHZ5bebRYKEb/NRP0d
         ygZk0GpovEqI/IM8FaXPbjLi9JoG/nctC9WV6UZSg6YKi2PLkoRcDV2ezHi0Dcf4KRET
         yowO+vDh4cjPDQ4MNkka8EL4iDsXWBXA4ms+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b1VMUXLMfFtqtg1d5fgksjrRHSmcXvmqNc/pq4Zicfc=;
        b=Y5KRRIO32QIluR2nRRvAZjJKmzEVUXn66oyurWD3F8tcP7PGKCz6zplhFpLBcEnL07
         Iyp5QmlTnyGFQbB1Lni+VPzOol83JcjKR+RDtA4eu5cX7Z6qMVGsKnrypWVapYWEi+ER
         /ebDOBZMnkUaIOqQ5iuBmLRn06pO/s8HaKUdHgiYpmxFciy0pQn844qv4/KpTc+CelA4
         HDhfETUk/Fw1+H7XsjAt7CNR6VrCyzZ+rqSds3xkoeUqTFO8XR/Y7WllM7f2gT+LerhN
         0MdLk/fMM1WZVKFsyesgc5NiB13/E0UPj86CEUgU8hqnVUNFbSDsm80BNUO4skMiQzVk
         nA3A==
X-Gm-Message-State: APjAAAUjnGgwNRlsj67udJ8tyHdjCYAuIp5WY0oRGf72M6jlgFVpQRqv
        5C+AIByRRHon5bDye91zByRSmw==
X-Google-Smtp-Source: APXvYqxyaj+zQFlG7v+PKoF6c0Dj2K45S3KJ1+eX+4WJbY9lgvJbsujclncVOjfCi3GoPvrnncOS9A==
X-Received: by 2002:a1c:2395:: with SMTP id j143mr7607671wmj.128.1574317360700;
        Wed, 20 Nov 2019 22:22:40 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y11sm76377wrq.12.2019.11.20.22.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 22:22:40 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Luke Starrett <luke.starrett@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V3 for-next 1/3] RDMA/bnxt_re: Fix chip number validation Broadcom's Gen P5 series
Date:   Thu, 21 Nov 2019 01:22:21 -0500
Message-Id: <1574317343-23300-2-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574317343-23300-1-git-send-email-devesh.sharma@broadcom.com>
References: <1574317343-23300-1-git-send-email-devesh.sharma@broadcom.com>
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

