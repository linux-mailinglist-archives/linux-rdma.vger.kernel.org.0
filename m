Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8E516290A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 16:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBRPG3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 18 Feb 2020 10:06:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46602 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbgBRPG2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Feb 2020 10:06:28 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IEwlDh026702
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 10:06:27 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6cban4v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 10:06:27 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 18 Feb 2020 15:06:25 -0000
Received: from us1b3-smtp05.a3dr.sjc01.isc4sb.com (10.122.203.183)
        by smtp.notes.na.collabserv.com (10.122.47.48) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 18 Feb 2020 15:06:21 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp05.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020021815062019-548494 ;
          Tue, 18 Feb 2020 15:06:20 +0000 
In-Reply-To: <20200218095911.26614-1-kamalheib1@gmail.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Kamal Heib" <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Doug Ledford" <dledford@redhat.com>
Date:   Tue, 18 Feb 2020 15:06:19 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200218095911.26614-1-kamalheib1@gmail.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-KeepSent: 2CD631DD:1E95C537-00258512:005287A1;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 61991
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20021815-1429-0000-0000-0000016D5F67
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.011680
X-IBM-SpamModules-Versions: BY=3.00012597; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01335738; UDB=6.00711568; IPR=6.01118099;
 MB=3.00030859; MTD=3.00000008; XFM=3.00000015; UTC=2020-02-18 15:06:24
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-02-18 09:18:13 - 6.00011019
x-cbparentid: 20021815-1430-0000-0000-00009B417351
Message-Id: <OF2CD631DD.1E95C537-ON00258512.005287A1-00258512.0052F9F4@notes.na.collabserv.com>
Subject: Re:  [PATCH for-next v2] RDMA/siw: Fix setting active_{speed, width}
 attributes
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_02:2020-02-17,2020-02-18 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----

>To: linux-rdma@vger.kernel.org
>From: "Kamal Heib" <kamalheib1@gmail.com>
>Date: 02/18/2020 10:59AM
>Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Doug Ledford"
><dledford@redhat.com>, "Bernard Metzler" <bmt@zurich.ibm.com>, "Kamal
>Heib" <kamalheib1@gmail.com>
>Subject: [EXTERNAL] [PATCH for-next v2] RDMA/siw: Fix setting
>active_{speed, width} attributes
>
>Make sure to set the active_{speed, width} attributes to avoid
>reporting
>the same values regardless of the underlying device.
>
>Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
>Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>---
>V2: Change rc to rv.
>---
> drivers/infiniband/sw/siw/siw_verbs.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>b/drivers/infiniband/sw/siw/siw_verbs.c
>index 73485d0da907..d5390d498c61 100644
>--- a/drivers/infiniband/sw/siw/siw_verbs.c
>+++ b/drivers/infiniband/sw/siw/siw_verbs.c
>@@ -165,11 +165,12 @@ int siw_query_port(struct ib_device *base_dev,
>u8 port,
> 		   struct ib_port_attr *attr)
> {
> 	struct siw_device *sdev = to_siw_dev(base_dev);
>+	int rv;
> 
> 	memset(attr, 0, sizeof(*attr));
> 
>-	attr->active_speed = 2;
>-	attr->active_width = 2;
>+	rv = ib_get_eth_speed(base_dev, port, &attr->active_speed,
>+			 &attr->active_width);
> 	attr->gid_tbl_len = 1;
> 	attr->max_msg_sz = -1;
> 	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
>@@ -192,7 +193,7 @@ int siw_query_port(struct ib_device *base_dev, u8
>port,
> 	 * attr->subnet_timeout = 0;
> 	 * attr->init_type_repy = 0;
> 	 */
>-	return 0;
>+	return rv;
> }
> 
> int siw_get_port_immutable(struct ib_device *base_dev, u8 port,
>-- 
>2.21.1
>
>
Looks good, and does what it should do, thanks!

Tested-by: Bernard Metzler <bmt@zurich.ibm.com>
Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

