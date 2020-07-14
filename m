Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9605B21FD6A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 21:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgGNTcH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 15:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgGNTcH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 15:32:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8F2C061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 12:32:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so2168196wmm.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VnEpEj7Wi5IT2YAweja/qAq4cg9UzJREPeiQX23JUak=;
        b=FM9nN5YRTO16nE2d6U7h5hNXtdh8uS/nrwyiPXIyS9APA4NpJQE5LtCZuP+5MSCvk8
         FANPmtXdUQtkbCdZpfF5v4GluMAMM1G0+wkGPsGM/B/s6DDzYA2OtyLhZNLiYSTj+R0Q
         sQeS4s/wygvRIe+xS/MHI5I4z4H2FTEfTSisarPSsYIeUdxrd+akUe5OBXplCA4bN8uU
         Mt6nNH+xyL4LSBrkBF+IT5j6Gp5K9C9Iu8X5eZr09Gz3GO+d7TzaYxyceOkfRRBzopOj
         iZxw7n9sgU5qs4ou+jhppMQ0uiav34cC0Z47pyn/vAO5Nmp/WAvahdNN4jU0BFT/qA6/
         Lfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VnEpEj7Wi5IT2YAweja/qAq4cg9UzJREPeiQX23JUak=;
        b=TwB+Fdm7B++RDcwnmTZUw9Yy5wlaYZ+EQFzpq8EsWk2+2taKXcfdiEhiS9ByfyQJZC
         d/ms1WKC2MgPpHgEAoOp1HD05vYTqgCdZ5bfZSf91uf1+hZFS/ijXPX2Daod9XCNdDWQ
         H2LdeVKs/E7bxsfYPjA2e6dHEG414GIKetC4nfU/tcJUwpDiNmT2sF5/xdmzqDgGzINV
         pEHULQ+cqI0mM4Irz7kZEUewYSxuTwg0gAuurdIHi8NLyKYe0HSPyKAn8dXRdOc1qVew
         RXiCEcJ3cN9MYhq1T/O3rfVNLMgT8jizOYPUmknsTVV3N/yGGdge3ZkX74r5N2Ny7842
         foTQ==
X-Gm-Message-State: AOAM532ylXwPhlz4+g/zdcKZExAySL2M0mUJdVik2Dxs2McwnlM3xWAe
        uMKrMxGLZRGqHxPvpL6Gzd39GXB0VQ0=
X-Google-Smtp-Source: ABdhPJzCEaiztsweMdla4nWQrXNHiC81XRDvrbnMuhKkcAmpq+P7dzxMQUoIVRJ4GHr4Gu1ZcFpp2w==
X-Received: by 2002:a7b:ce14:: with SMTP id m20mr5500323wmc.129.1594751683108;
        Tue, 14 Jul 2020 11:34:43 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 190sm5728982wmb.15.2020.07.14.11.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 11:34:42 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v1 5/7] RDMA/cxgb4: Remove the query_pkey callback
Date:   Tue, 14 Jul 2020 21:34:12 +0300
Message-Id: <20200714183414.61069-6-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714183414.61069-1-kamalheib1@gmail.com>
References: <20200714183414.61069-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that the query_pkey() isn't mandatory by the RDMA core for iwarp
providers, this callback can be removed.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/cxgb4/provider.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 1d3ff59e4060..6c579d2d3997 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -236,14 +236,6 @@ static int c4iw_allocate_pd(struct ib_pd *pd, struct ib_udata *udata)
 	return 0;
 }
 
-static int c4iw_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
-			   u16 *pkey)
-{
-	pr_debug("ibdev %p\n", ibdev);
-	*pkey = 0;
-	return 0;
-}
-
 static int c4iw_query_gid(struct ib_device *ibdev, u8 port, int index,
 			  union ib_gid *gid)
 {
@@ -317,7 +309,6 @@ static int c4iw_query_port(struct ib_device *ibdev, u8 port,
 	    IB_PORT_DEVICE_MGMT_SUP |
 	    IB_PORT_VENDOR_CLASS_SUP | IB_PORT_BOOT_MGMT_SUP;
 	props->gid_tbl_len = 1;
-	props->pkey_tbl_len = 1;
 	props->max_msg_sz = -1;
 
 	return ret;
@@ -439,7 +430,6 @@ static int c4iw_port_immutable(struct ib_device *ibdev, u8 port_num,
 	if (err)
 		return err;
 
-	immutable->pkey_tbl_len = attr.pkey_tbl_len;
 	immutable->gid_tbl_len = attr.gid_tbl_len;
 
 	return 0;
@@ -503,7 +493,6 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.post_srq_recv = c4iw_post_srq_recv,
 	.query_device = c4iw_query_device,
 	.query_gid = c4iw_query_gid,
-	.query_pkey = c4iw_query_pkey,
 	.query_port = c4iw_query_port,
 	.query_qp = c4iw_ib_query_qp,
 	.reg_user_mr = c4iw_reg_user_mr,
-- 
2.25.4

