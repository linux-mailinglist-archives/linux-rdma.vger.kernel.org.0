Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876B321EB0D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 10:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGNIK5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 04:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgGNIK5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 04:10:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA8AC061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:10:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so20210138wrp.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mYq0lLfoChjF6fyT3Yv4jD48nMVUJnRN3eRJAiDbrDU=;
        b=Rsiq3S2FdD9dm5JFrBTzvG6HgTqKBSucSpBnavArEEko+Pwxlw6NgAOnOoJqYJzfej
         Fy32NcyirLP9GRLDJR8Apjg1hJ6VsGY3UvkXzvZXz1r/1t6bSrmJ86aV2qZ2jdmyxazK
         cvOP7WH9HnRZucJO18i9C2l/Q8hpiP1Mfn6WGGFGL1Ek0Fy3OzF/bJjchp5+ThMqlQZE
         3UQeN33FTxpW8lc2XlQt41TU0wE8hAmFByd9KSKsNBhES8Yq7DMdQCk5Z2AJkAzQ9sAX
         /OG4g2ODu4xzC13238EYIz9sSZVz//n0bI17KTGxcgtuZET3FlOKtM2Xj7oB6pDZAsmF
         7w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mYq0lLfoChjF6fyT3Yv4jD48nMVUJnRN3eRJAiDbrDU=;
        b=Vayunuxa9QALgfEmDogOIz+MXzJnQYD+dqyy0DvYz23SWaJFbuLC3zKAhZTMv/jBhe
         g6UGw6bKY/903hSAQV0RbKUmb7iJM/6Mp9Bq+QvA/L84Z+lfYecmVfeeqfP9kIHQ2/Dy
         RsX1vbG1nQEPtBYB/K30q+2/3LpH6K1WtsfZNEicfLGyAi2ySUNh5ZqqZkVzz915gIO5
         MfuXnYp7ezM0S8oSKsoS7MOndTQgbYaz/Te+0QqhJmlcaHjOjbdLjzZEBL+nY63O0d1v
         U96M4mjYnrqSNJyCuTQ0BnjNE4KO8rfROoRHkHyOSCO1YEqFrLNXVCmMgHwwgeV4Mf3a
         Y9gQ==
X-Gm-Message-State: AOAM532TDZoiPdb0soUtgnnNFtMfysXXR+xeSWd9Vg3LvzsGKBnJWRdR
        0ZI4ehWkNh30eVfExURLreuXq9m11CE=
X-Google-Smtp-Source: ABdhPJwYLCHcgKRrhXxe7XCotYuOqu+d/onZ55Bf6mrHf2IFSbEVwD1PsIUpH2+8+jNNNliT3NuxkQ==
X-Received: by 2002:adf:c986:: with SMTP id f6mr3825097wrh.168.1594714255112;
        Tue, 14 Jul 2020 01:10:55 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-176-63-152.red.bezeqint.net. [79.176.63.152])
        by smtp.gmail.com with ESMTPSA id f197sm3403891wme.33.2020.07.14.01.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:10:54 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 4/7] RDMA/siw: Remove the query_pkey callback
Date:   Tue, 14 Jul 2020 11:10:35 +0300
Message-Id: <20200714081038.13131-5-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714081038.13131-1-kamalheib1@gmail.com>
References: <20200714081038.13131-1-kamalheib1@gmail.com>
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
 drivers/infiniband/sw/siw/siw_main.c  | 1 -
 drivers/infiniband/sw/siw/siw_verbs.c | 9 ---------
 drivers/infiniband/sw/siw/siw_verbs.h | 1 -
 3 files changed, 11 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index a0b8cc643c5c..18c08259157f 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -288,7 +288,6 @@ static const struct ib_device_ops siw_device_ops = {
 	.post_srq_recv = siw_post_srq_recv,
 	.query_device = siw_query_device,
 	.query_gid = siw_query_gid,
-	.query_pkey = siw_query_pkey,
 	.query_port = siw_query_port,
 	.query_qp = siw_query_qp,
 	.query_srq = siw_query_srq,
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 0d509f7a10a6..adafa1b8bebe 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -176,7 +176,6 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
 	attr->active_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
 	attr->phys_state = sdev->state == IB_PORT_ACTIVE ?
 		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
-	attr->pkey_tbl_len = 1;
 	attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
 	attr->state = sdev->state;
 	/*
@@ -204,20 +203,12 @@ int siw_get_port_immutable(struct ib_device *base_dev, u8 port,
 	if (rv)
 		return rv;
 
-	port_immutable->pkey_tbl_len = attr.pkey_tbl_len;
 	port_immutable->gid_tbl_len = attr.gid_tbl_len;
 	port_immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
 
 	return 0;
 }
 
-int siw_query_pkey(struct ib_device *base_dev, u8 port, u16 idx, u16 *pkey)
-{
-	/* Report the default pkey */
-	*pkey = 0xffff;
-	return 0;
-}
-
 int siw_query_gid(struct ib_device *base_dev, u8 port, int idx,
 		  union ib_gid *gid)
 {
diff --git a/drivers/infiniband/sw/siw/siw_verbs.h b/drivers/infiniband/sw/siw/siw_verbs.h
index 9335c48c01de..d9572275a6b6 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.h
+++ b/drivers/infiniband/sw/siw/siw_verbs.h
@@ -46,7 +46,6 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 		  struct ib_udata *udata);
 int siw_query_port(struct ib_device *base_dev, u8 port,
 		   struct ib_port_attr *attr);
-int siw_query_pkey(struct ib_device *base_dev, u8 port, u16 idx, u16 *pkey);
 int siw_query_gid(struct ib_device *base_dev, u8 port, int idx,
 		  union ib_gid *gid);
 int siw_alloc_pd(struct ib_pd *base_pd, struct ib_udata *udata);
-- 
2.25.4

