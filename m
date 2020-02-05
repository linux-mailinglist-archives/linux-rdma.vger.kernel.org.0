Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA899153277
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 15:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgBEOGY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 5 Feb 2020 09:06:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726575AbgBEOGY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Feb 2020 09:06:24 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 015DoMJC033035
        for <linux-rdma@vger.kernel.org>; Wed, 5 Feb 2020 09:06:22 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.114])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhmn05f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2020 09:06:22 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 5 Feb 2020 14:06:22 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
        by smtp.notes.na.collabserv.com (10.122.47.58) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 5 Feb 2020 14:06:19 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp04.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020020514061796-439224 ;
          Wed, 5 Feb 2020 14:06:17 +0000 
In-Reply-To: <20200205081354.30438-1-kamalheib1@gmail.com>
Subject: Re: [PATCH for-rc] RDMA/siw: Fix setting active_mtu attribute
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Kamal Heib" <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
Date:   Wed, 5 Feb 2020 14:06:18 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200205081354.30438-1-kamalheib1@gmail.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-KeepSent: C2596FB6:EEA33F17-00258505:004D7B2B;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 61491
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20020514-1639-0000-0000-0000016938FE
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00012518; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01329517; UDB=6.00707857; IPR=6.01111863;
 MB=3.00030654; MTD=3.00000008; XFM=3.00000015; UTC=2020-02-05 14:06:21
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-02-05 08:41:06 - 6.00010970
x-cbparentid: 20020514-1640-0000-0000-0000570D440E
Message-Id: <OFC2596FB6.EEA33F17-ON00258505.004D7B2B-00258505.004D7B35@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_04:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----

>To: linux-rdma@vger.kernel.org
>From: "Kamal Heib" <kamalheib1@gmail.com>
>Date: 02/05/2020 09:14AM
>Cc: "Doug Ledford" <dledford@redhat.com>, "Jason Gunthorpe"
><jgg@ziepe.ca>, "Bernard Metzler" <bmt@zurich.ibm.com>, "Kamal Heib"
><kamalheib1@gmail.com>
>Subject: [EXTERNAL] [PATCH for-rc] RDMA/siw: Fix setting active_mtu
>attribute
>
>Make sure to set the active_mtu attribute to avoid report the
>following
>invalid value:
>
>$ ibv_devinfo -d siw0 | grep active_mtu
>			active_mtu:		invalid MTU (0)
>
>Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
>Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>---
> drivers/infiniband/sw/siw/siw_verbs.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>b/drivers/infiniband/sw/siw/siw_verbs.c
>index 07e30138aaa1..73485d0da907 100644
>--- a/drivers/infiniband/sw/siw/siw_verbs.c
>+++ b/drivers/infiniband/sw/siw/siw_verbs.c
>@@ -168,12 +168,12 @@ int siw_query_port(struct ib_device *base_dev,
>u8 port,
> 
> 	memset(attr, 0, sizeof(*attr));
> 
>-	attr->active_mtu = attr->max_mtu;
> 	attr->active_speed = 2;
> 	attr->active_width = 2;
> 	attr->gid_tbl_len = 1;
> 	attr->max_msg_sz = -1;
> 	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
>+	attr->active_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> 	attr->phys_state = sdev->state == IB_PORT_ACTIVE ?
> 		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
> 	attr->pkey_tbl_len = 1;
>-- 
>2.21.1
>
>

thanks, makes complete sense.

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

