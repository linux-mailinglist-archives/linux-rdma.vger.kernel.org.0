Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA0F22062B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 09:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgGOH3o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 15 Jul 2020 03:29:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728888AbgGOH3n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jul 2020 03:29:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06F72VfO133829
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 03:29:43 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3298ebd4vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 03:29:42 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 15 Jul 2020 07:29:41 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 15 Jul 2020 07:29:37 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2020071507293689-108407 ;
          Wed, 15 Jul 2020 07:29:36 +0000 
In-Reply-To: <20200714183414.61069-5-kamalheib1@gmail.com>
Subject: Re: [PATCH for-next v1 4/7] RDMA/siw: Remove the query_pkey callback
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Kamal Heib" <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Michal Kalderon" <mkalderon@marvell.com>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>
Date:   Wed, 15 Jul 2020 07:29:36 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200714183414.61069-5-kamalheib1@gmail.com>,<20200714183414.61069-1-kamalheib1@gmail.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 4351
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20071507-8889-0000-0000-000003201BFD
X-IBM-SpamModules-Scores: BY=0.246526; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.020623
X-IBM-SpamModules-Versions: BY=3.00013471; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01406015; UDB=6.00753254; IPR=6.01188262;
 MB=3.00033015; MTD=3.00000008; XFM=3.00000015; UTC=2020-07-15 07:29:40
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-07-15 04:08:42 - 6.00011602
x-cbparentid: 20071507-8890-0000-0000-0000AC9C2C1F
Message-Id: <OF2258F6B5.BE0884DE-ON002585A6.0028F6F6-002585A6.00292995@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_02:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----

>To: linux-rdma@vger.kernel.org
>From: "Kamal Heib" <kamalheib1@gmail.com>
>Date: 07/14/2020 08:34PM
>Cc: "Doug Ledford" <dledford@redhat.com>, "Jason Gunthorpe"
><jgg@ziepe.ca>, "Michal Kalderon" <mkalderon@marvell.com>, "Potnuri
>Bharat Teja" <bharat@chelsio.com>, "Shiraz Saleem"
><shiraz.saleem@intel.com>, "Bernard Metzler" <bmt@zurich.ibm.com>,
>"Kamal Heib" <kamalheib1@gmail.com>
>Subject: [EXTERNAL] [PATCH for-next v1 4/7] RDMA/siw: Remove the
>query_pkey callback
>
>Now that the query_pkey() isn't mandatory by the RDMA core for iwarp
>providers, this callback can be removed.
>
>Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>---
> drivers/infiniband/sw/siw/siw_main.c  | 1 -
> drivers/infiniband/sw/siw/siw_verbs.c | 9 ---------
> drivers/infiniband/sw/siw/siw_verbs.h | 1 -
> 3 files changed, 11 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_main.c
>b/drivers/infiniband/sw/siw/siw_main.c
>index a0b8cc643c5c..18c08259157f 100644
>--- a/drivers/infiniband/sw/siw/siw_main.c
>+++ b/drivers/infiniband/sw/siw/siw_main.c
>@@ -288,7 +288,6 @@ static const struct ib_device_ops siw_device_ops
>= {
> 	.post_srq_recv = siw_post_srq_recv,
> 	.query_device = siw_query_device,
> 	.query_gid = siw_query_gid,
>-	.query_pkey = siw_query_pkey,
> 	.query_port = siw_query_port,
> 	.query_qp = siw_query_qp,
> 	.query_srq = siw_query_srq,
>diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>b/drivers/infiniband/sw/siw/siw_verbs.c
>index 0d509f7a10a6..adafa1b8bebe 100644
>--- a/drivers/infiniband/sw/siw/siw_verbs.c
>+++ b/drivers/infiniband/sw/siw/siw_verbs.c
>@@ -176,7 +176,6 @@ int siw_query_port(struct ib_device *base_dev, u8
>port,
> 	attr->active_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> 	attr->phys_state = sdev->state == IB_PORT_ACTIVE ?
> 		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
>-	attr->pkey_tbl_len = 1;
> 	attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
> 	attr->state = sdev->state;
> 	/*
>@@ -204,20 +203,12 @@ int siw_get_port_immutable(struct ib_device
>*base_dev, u8 port,
> 	if (rv)
> 		return rv;
> 
>-	port_immutable->pkey_tbl_len = attr.pkey_tbl_len;
> 	port_immutable->gid_tbl_len = attr.gid_tbl_len;
> 	port_immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
> 
> 	return 0;
> }
> 
>-int siw_query_pkey(struct ib_device *base_dev, u8 port, u16 idx, u16
>*pkey)
>-{
>-	/* Report the default pkey */
>-	*pkey = 0xffff;
>-	return 0;
>-}
>-
> int siw_query_gid(struct ib_device *base_dev, u8 port, int idx,
> 		  union ib_gid *gid)
> {
>diff --git a/drivers/infiniband/sw/siw/siw_verbs.h
>b/drivers/infiniband/sw/siw/siw_verbs.h
>index 9335c48c01de..d9572275a6b6 100644
>--- a/drivers/infiniband/sw/siw/siw_verbs.h
>+++ b/drivers/infiniband/sw/siw/siw_verbs.h
>@@ -46,7 +46,6 @@ int siw_create_cq(struct ib_cq *base_cq, const
>struct ib_cq_init_attr *attr,
> 		  struct ib_udata *udata);
> int siw_query_port(struct ib_device *base_dev, u8 port,
> 		   struct ib_port_attr *attr);
>-int siw_query_pkey(struct ib_device *base_dev, u8 port, u16 idx, u16
>*pkey);
> int siw_query_gid(struct ib_device *base_dev, u8 port, int idx,
> 		  union ib_gid *gid);
> int siw_alloc_pd(struct ib_pd *base_pd, struct ib_udata *udata);
>-- 
>2.25.4
>
>
Thanks, Kamal!

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>

