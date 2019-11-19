Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C57B91028A4
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 16:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfKSPtV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 10:49:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45929 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfKSPtV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 10:49:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so12348368pfn.12
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 07:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dm7pwqskUQg9AAcdSj5JfWWXFSWciy198ejCCVgYVao=;
        b=KBtvLe9E2wXvUj4crE8gH2QAV4+XsUr1lbzPfL2d5KGj7ijQB8xZAU7uu7xjwkDzqG
         x/KNGB5/hUEqENYTBxZ1P27WMw2TJHur4z4v7tg9yqzd/GwvK7OS1OQjm7XDxJ6IR+IM
         t7kTDcJ2b7rKBkc3HSPz3b2QXJTXkfrYT8xYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dm7pwqskUQg9AAcdSj5JfWWXFSWciy198ejCCVgYVao=;
        b=GneNyrt6Ww3m/S1BjGyBoKU9InFMFSGpbU7DXcL/nhvc8BAyUilifb94QB4T7iDuHY
         wSi1SNjIolTzolNli9lXNyP/62id3mz1Vm+obBSsGRvECo6idp42iLLDZibxYoEo0Cbm
         J2py5M9Z61ZcIrs5Q5TJG117QwTuMFyMg3on4Qca14JkmsMnFsKpmlBWs0lPM7f0ZqXQ
         BwLf87AAa4EcGr0QI/lvYpiRZrVAFXBJfFET01J+Rdm3xkRd1bC7h1+Lq5W+HL167wKt
         vdkwmwt3e4oqPjQMT5mWz8id776ztiiAY1HrJvNNt7SvGAjyfSoFIlcbh0WNsMU1vJe3
         GLoQ==
X-Gm-Message-State: APjAAAWgjMxUn/SDdk0IbhbmBfNcbTw/WbsqLLLc//bpNKPFbrs//DMR
        xcuPt9VLy69HAHSji3TWb6ji+g==
X-Google-Smtp-Source: APXvYqx9YAYAeQpf1jd2TZx98xF/YUNwlPIptNlz0pB2vEpMktujEsaMi47UzEbtR3bwsH7BCxmL9g==
X-Received: by 2002:a63:1303:: with SMTP id i3mr6344046pgl.430.1574178560222;
        Tue, 19 Nov 2019 07:49:20 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 10sm24263620pgs.11.2019.11.19.07.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 07:49:18 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH for-rc 2/3] RDMA/bnxt_re: fix stat push into dma buffer on gen p5  devices
Date:   Tue, 19 Nov 2019 10:48:50 -0500
Message-Id: <1574178531-15898-3-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574178531-15898-1-git-send-email-devesh.sharma@broadcom.com>
References: <1574178531-15898-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Making a change to fix device stat push from chip
to dma buffer. The new firmware command expects dma
length to be specified during stat allocation.

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

