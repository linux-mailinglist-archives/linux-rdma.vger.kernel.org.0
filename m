Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D39D968292
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 05:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfGODSi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Jul 2019 23:18:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40761 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGODSi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 14 Jul 2019 23:18:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so6996994pgj.7;
        Sun, 14 Jul 2019 20:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KYF1ZTk0NtUB4/vGzgLc5BTvblesxGEYHhSa1UYpx1A=;
        b=P66gBr622QmKRDowgoX4BM9N0pS3NaBB0HlkKMg9Qbi+FokZIv7jqR2Cj5DIJUBbLE
         1s7qLPUuaFeCVJmHvUIxNNVGe64DUoXB3znCYuGRWzsXu0r2dbjqrwOcqjf42drkHZfJ
         XQNICUTDhmTTq78SUz38AraKqzAyqXpOkmMdftzSNWIgPB7IZbNDL8aeMpo8N7gD1Yz7
         vaN9ePPYIn4QsUoIz3MqUNU4FnvsBK2RlocCvXk8KDc+pUSub9s7Ce5AmsvgUvRdx7Zc
         aJYKbujUKC0x4rmXHC/tQqAxmy5PLuN/f/lPcCFnifXAr8B2P8fn9GZxVTHuHrSdrYHW
         XQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KYF1ZTk0NtUB4/vGzgLc5BTvblesxGEYHhSa1UYpx1A=;
        b=FC3CKWYHiqFp++7mDAvimHV7OYn88Va5pjgQWVYsUEzjS2qhlbBIj7YkNk73yiHWZ+
         ox68e3DM44wusgmny0TzH0HWyGvYOOhNrW1Lbbu37n+K1ffXKKmNHq7Ush3OFINqAjdd
         KdtFSDX/FQq4N6Rxwz6A9F7Al74lClLl0SX21YhYQbXEUrx/tuiLR4j3exVh2iDmpFWK
         dUu8thF+4Rzvew6Hu8KweHqhBAFJqx8orngTHl01gKykwTpArbR0WMyPzzhknnkZkALd
         GPJZvhWkwoC9k0cRUsJnpfPhRLD8O0vGOhxE0VCkao0v0jZyPQ5xctURLM156tJ5GtfX
         GVXA==
X-Gm-Message-State: APjAAAWP/Jj/wPoPfOmjT0I8tja9t32EWlItc0L7B41AyVrxf9l3exdh
        HtxrCaDtJ8UlnR4/m9GQ/EA=
X-Google-Smtp-Source: APXvYqwWvbWT/M43tSZ75x/LkZ56pcuzh5yrV6nv/pnQlQrQEFFf4TxGahcuWWxuX5AzAREN0AjrMg==
X-Received: by 2002:a65:5a42:: with SMTP id z2mr25060649pgs.421.1563160717077;
        Sun, 14 Jul 2019 20:18:37 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id t17sm17812964pgg.48.2019.07.14.20.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:18:36 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 12/24] RDMA/ocrdma: Remove call to memset after dma_alloc_coherent
Date:   Mon, 15 Jul 2019 11:18:31 +0800
Message-Id: <20190715031831.6751-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/infiniband/hw/ocrdma/ocrdma_hw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
index 5127e2ea4bdd..6e07712eb3ed 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
@@ -1351,7 +1351,6 @@ static int ocrdma_mbx_get_ctrl_attribs(struct ocrdma_dev *dev)
 	mqe->u.nonemb_req.sge[0].pa_hi = (u32) upper_32_bits(dma.pa);
 	mqe->u.nonemb_req.sge[0].len = dma.size;
 
-	memset(dma.va, 0, dma.size);
 	ocrdma_init_mch((struct ocrdma_mbx_hdr *)dma.va,
 			OCRDMA_CMD_GET_CTRL_ATTRIBUTES,
 			OCRDMA_SUBSYS_COMMON,
@@ -1690,7 +1689,6 @@ static int ocrdma_mbx_create_ah_tbl(struct ocrdma_dev *dev)
 		goto mem_err_ah;
 	dev->av_tbl.pa = pa;
 	dev->av_tbl.num_ah = max_ah;
-	memset(dev->av_tbl.va, 0, dev->av_tbl.size);
 
 	pbes = (struct ocrdma_pbe *)dev->av_tbl.pbl.va;
 	for (i = 0; i < dev->av_tbl.size / OCRDMA_MIN_Q_PAGE_SIZE; i++) {
@@ -2905,7 +2903,6 @@ static int ocrdma_mbx_get_dcbx_config(struct ocrdma_dev *dev, u32 ptype,
 	mqe_sge->pa_hi = (u32) upper_32_bits(pa);
 	mqe_sge->len = cmd.hdr.pyld_len;
 
-	memset(req, 0, sizeof(struct ocrdma_get_dcbx_cfg_req));
 	ocrdma_init_mch(&req->hdr, OCRDMA_CMD_GET_DCBX_CONFIG,
 			OCRDMA_SUBSYS_DCBX, cmd.hdr.pyld_len);
 	req->param_type = ptype;
-- 
2.11.0

