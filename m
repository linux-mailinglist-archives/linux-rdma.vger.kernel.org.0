Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2DD21FD75
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 21:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgGNTgP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 15:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgGNTgP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 15:36:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E497CC061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 12:36:14 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so2173799wmc.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 12:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mYq0lLfoChjF6fyT3Yv4jD48nMVUJnRN3eRJAiDbrDU=;
        b=GDsvb0Sns0yslIjkyrD+GopNAbDG9fJi90G9U/ytN8SsVJ3C8zDmpQ97myDxX5NstP
         yhIXq+kB8ljA7lLI46pwCJR2mkeScHZqPHDiy+4l6fotFGVrQVa7eskKeUSku94Nd3J/
         YG6M698ELg7IeiwbRGbhzolUUicSeBQsOdKFX8W9egaE1uzDbDSavxwUoxGDTpPKDacc
         0w/gEk3u4t6rtNK+ByY1l/EkkLZFjT/N3nHAS0sQ4TvUUbSGh3a3pWclS+jBF5rNImHn
         bpiAujfJpgs6F3zOruISDGNoycUb7n1ZhwzEFrSO2ijACJQABLak52cdDNIFdFVyL4+R
         sHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mYq0lLfoChjF6fyT3Yv4jD48nMVUJnRN3eRJAiDbrDU=;
        b=GyjQkXaUqcWKAm6lyQbvSCv9CitJQmWaXirTyjy8WMggXc+Cqgw9+QzFLYxhmpnEYB
         ILH2CTMWD2KOyXFV2RMshynEdee8D+swq13fFVgD30iYTcPxn8yDRtY7ZM2uYh7x5tcA
         pFsTFgu4GxtNWp5O5IzJCCLsqtcMGDNfU69G+QAAClo54udrG/PH53Znaa4qABpgbeU9
         Ck+JOkL+DocrwHrPuapNsouDR9GN/gYhEI80mc9AaTZtuQ45QPAPvmOQyHUCKjNQuWxi
         erfhgwtj9lGPQJn6uVCLyvlrONjba92wG3KmCxUtOfmz0aNmJZyjBU7NHMNdWbZvjJpW
         rsog==
X-Gm-Message-State: AOAM532j7ZxO25StsNfS//G56pbhoSXH0lq+XX0GarbRfL48bTu6IwbT
        L1IMRfnePpR0CJOd9rrE/MJ1wnK39EQ=
X-Google-Smtp-Source: ABdhPJx21p9siKC0/+nDl+3Exqye+PQNXRLo8vsSwxZmNrBPal0IWViaQFnxazo5x9KeCWetIdQfIA==
X-Received: by 2002:a1c:5a41:: with SMTP id o62mr5275197wmb.16.1594751681422;
        Tue, 14 Jul 2020 11:34:41 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 190sm5728982wmb.15.2020.07.14.11.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 11:34:40 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v1 4/7] RDMA/siw: Remove the query_pkey callback
Date:   Tue, 14 Jul 2020 21:34:11 +0300
Message-Id: <20200714183414.61069-5-kamalheib1@gmail.com>
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

