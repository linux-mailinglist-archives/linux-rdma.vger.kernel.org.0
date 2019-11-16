Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3189DFEAB7
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Nov 2019 06:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfKPFPN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 16 Nov 2019 00:15:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42537 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfKPFPM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 16 Nov 2019 00:15:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so13127093wrf.9
        for <linux-rdma@vger.kernel.org>; Fri, 15 Nov 2019 21:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AQhcl/J2PJzqg4Z0N2+55FmGvdp6p+Q8OHXDYw468i0=;
        b=Ir0mJ/POtEA5B2mh4rF9HcAXrkQD+wK0tExuS91QyIgS5hCoDtuo4I+xnAbMBAa2ic
         DsSCC2euEoh4UZ3zZkcXt7WNkv2DRNQ5XtsUo1+NW5RzF0W5c3YgNUx+vO4nvjcotYO1
         aAdH6Ly5C6E2otsMrLjchvhSzKV9XTRwefnj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AQhcl/J2PJzqg4Z0N2+55FmGvdp6p+Q8OHXDYw468i0=;
        b=hHyX+na7QADvlB/BiFazD7EZ+P5ZTxw4n8I0JdjIu4US3BZ6t4Ow1UKFXkM/KbpyGF
         dGtGmxY+dCM5ERj9/MW0tPf9uHx1CsL2F7y7ooDBX3+tznBVNhfNJTUtsZ9RtBva3yoc
         qoBDOdIBPXYhFmSEnErQtovHx7tzXc/idSLSrt08tB7jDU+zD/RgWp+2T7gncJrI3vOn
         g0qo5m+nhnpUvDNX9MKGjBLx+qSUd1v6zKhF2U83ggXTZgZqYT5U7dU21L4DJZ11cMMg
         KRyd8GR2Tx8bnvMh8L4FwllWZXp08o69T0cTqAnyh3NwzrD0dW2R01SPeiaMEBfXQ9Ui
         eefw==
X-Gm-Message-State: APjAAAXh05444gneCDZN+RzumN3sC944Q7zui1r0FWASmbEe+7J4nKE8
        IqkZBLL+B1RmkVGDgak6PO721w==
X-Google-Smtp-Source: APXvYqyJC0UM6vr9hl3roRCPR0wQcqltBrAL2v1+1hWvelVB5HIV4nBWVcgnDz6n+QI9MsjNwHNnfA==
X-Received: by 2002:adf:e8cf:: with SMTP id k15mr20580702wrn.256.1573881310531;
        Fri, 15 Nov 2019 21:15:10 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z11sm17104864wrg.0.2019.11.15.21.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 21:15:09 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Luke Starrett <luke.starrett@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH for-rc] RDMA/bnxt_re: Fix chip number validation Broadcom's Gen P5 series
Date:   Sat, 16 Nov 2019 00:14:53 -0500
Message-Id: <1573881293-3494-1-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
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

