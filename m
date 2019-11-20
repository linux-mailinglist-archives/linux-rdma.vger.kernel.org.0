Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE3C103441
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 07:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfKTGUh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 01:20:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34550 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfKTGUh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Nov 2019 01:20:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id j18so4224170wmk.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 22:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kMms/Y764ZCYDBYwMWs0FXH18Gmx1KkXXZPTiNKK92E=;
        b=AEFGcw1grAICBa2o/zf4RDRRsKL/WopcYLmyoJ1FPVTFxtata8TNt/ebqMmLQ3ulmu
         8zCXcL0egZWOtV5Cf+o/2GtuOhvv9L1CTQzpSzIzJpCev5JMJb2uIS9yh1ZqJQEqcXD7
         SjlPQSrzBuHJ2N05tXTKvYFhUjNZyVkiMWU9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kMms/Y764ZCYDBYwMWs0FXH18Gmx1KkXXZPTiNKK92E=;
        b=GFM2cATMrhqUiFfDhEuR+Nu5YXbWrHJc3peGNHXkXlSEAaw+ylkCB7dwKTwDoYZ8kM
         qPIrQG3dGQ5Jwx3Wps8qYsW9g9FgVAP1MMcWZ4D1pkXzEN7iETt1911cvFO3dBss8IMz
         8Sc2Z8s8Ew9q0fFHCiKe6Mret4SqgMWzsRzNNpl9FPuUStQNrX+MkLi7DQz0Ir/GlXhD
         6zw2Q/LOZ+OsZ6xa+jqiM7DmlgKGbMmhCpNd7970CleH1RG1RYZG06uyLXEbPzmaISU+
         iA2VoH7WDdjc7QdKNtgExc5FJEeoBLbatLdStvlPxSnFjT5GYGjTI+OmEXc+RoqPnUUI
         KBpQ==
X-Gm-Message-State: APjAAAWVzs4K4tZa3zgk5MaN+XS3gNA6J2MuG7leuaEd1mT+8NVCEmwO
        7DxFVwCBTnyLy4mAeXfRn6J/CmmiJu4=
X-Google-Smtp-Source: APXvYqwh45YE4ThKOFWmUaocLZ0wNEPONLsK6v8FPYZgqGVir4wOZ83iw6HUBJakkZvFAvA/7QVjVw==
X-Received: by 2002:a1c:7f54:: with SMTP id a81mr1204141wmd.48.1574230835369;
        Tue, 19 Nov 2019 22:20:35 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j7sm32466705wro.54.2019.11.19.22.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 22:20:34 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V2 for-rc 2/2] RDMA/bnxt_re: fix stat push into dma buffer on gen p5  devices
Date:   Wed, 20 Nov 2019 01:20:18 -0500
Message-Id: <1574230818-30295-3-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574230818-30295-1-git-send-email-devesh.sharma@broadcom.com>
References: <1574230818-30295-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Due to recent advances in the firmware for Broadcom's
gen p5 series of adaptors the driver code to report
hardware counters has been broken w.r.t. roce devices.

Making a change to match the expectaion of newer firmware
version when stat dma buffer is created. The new firmware
command expects dma length to be specified during stat
dma buffer allocation.

Fixes: 2792b5b95ed5 ("bnxt_en: Update firmware interface spec. to 1.10.0.89")
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 30a54f8..2ee2cd4 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -477,6 +477,7 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
 	bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_STAT_CTX_ALLOC, -1, -1);
 	req.update_period_ms = cpu_to_le32(1000);
 	req.stats_dma_addr = cpu_to_le64(dma_map);
+	req.stats_dma_length = cpu_to_le16(sizeof(struct ctx_hw_stats_ext));
 	req.stat_ctx_flags = STAT_CTX_ALLOC_REQ_STAT_CTX_FLAGS_ROCE;
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
 			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
-- 
1.8.3.1

