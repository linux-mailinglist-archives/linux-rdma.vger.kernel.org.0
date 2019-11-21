Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61721104ABE
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 07:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfKUGWp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 01:22:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54123 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKUGWp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Nov 2019 01:22:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id u18so2367244wmc.3
        for <linux-rdma@vger.kernel.org>; Wed, 20 Nov 2019 22:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zS+4DfAFhREpqSUQWMZ6TYr3xge9UYBqHXLfZYf66uo=;
        b=HlCPvHdQDe61MLQBz/qeZtx3ky0iWThUotVyTHRTFZSs11pqZLjMJI/u6MAje8KTUY
         kzAOntBVMG62G8+xSDOtVrLoxf5GK5nJ+JxybOXLVpxqKR+Ysek22P0Z2uYHr1YTm7qc
         BdwRVwDcMVezcgMmmonXiyFY6+DK9vRbx8Vn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zS+4DfAFhREpqSUQWMZ6TYr3xge9UYBqHXLfZYf66uo=;
        b=RuzpjVFeDYjmGioMWvRgdcHnxpEhdTuxG2lRYnKGSDWPL/nESElWra6Gu397+AETP3
         UmbvMlOdXOlBpULjFX7sB097qcMWDRva17ZUaG8gZpl0kYQw8h/IAh5zI5WDYkXwlQ2A
         pkvOkQTR8PWcmDcj5kn/O8EjlPedZMLmWspQceFylOVJ2PZ33ZvIeaqkHpK2RFuBfwUD
         nVlbO5oF/2gDZJzEwt7I5pksxrmgs41dIDI7tD1xy1uY84Ds7JlGWSmVT7F03YXhGNDj
         vbeYHxV0RUqHUBce+vdK6j/wVZytrYXG0KBNVljWI8EpU2qjsRvSfLR39zCpv+3KfZay
         sQgQ==
X-Gm-Message-State: APjAAAUsde+C6A9nWTvqe2mHeP2haRRC1HkvHFI7a8uRtwsxX6QkZf20
        nH2QXOScjrmMS/qBY61+ndcxwg==
X-Google-Smtp-Source: APXvYqyR2rn1m7yv/Teo7ZyAgSyXTaG6yPKfWu6d4ksx+/dLHk7dRQhem0SYrQAZ++/SanpjoP4PpA==
X-Received: by 2002:a1c:1d10:: with SMTP id d16mr8109869wmd.14.1574317363437;
        Wed, 20 Nov 2019 22:22:43 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y11sm76377wrq.12.2019.11.20.22.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 22:22:42 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V3 for-next 2/3] RDMA/bnxt_re: fix stat push into dma buffer on gen p5 devices
Date:   Thu, 21 Nov 2019 01:22:22 -0500
Message-Id: <1574317343-23300-3-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574317343-23300-1-git-send-email-devesh.sharma@broadcom.com>
References: <1574317343-23300-1-git-send-email-devesh.sharma@broadcom.com>
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
index d6785b8..a2ac88e 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -494,6 +494,7 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
 	bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_STAT_CTX_ALLOC, -1, -1);
 	req.update_period_ms = cpu_to_le32(1000);
 	req.stats_dma_addr = cpu_to_le64(dma_map);
+	req.stats_dma_length = cpu_to_le16(sizeof(struct ctx_hw_stats_ext));
 	req.stat_ctx_flags = STAT_CTX_ALLOC_REQ_STAT_CTX_FLAGS_ROCE;
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
 			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
-- 
1.8.3.1

