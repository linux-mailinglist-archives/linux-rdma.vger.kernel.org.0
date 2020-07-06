Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7FA215A19
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgGFO6C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 6 Jul 2020 10:58:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729224AbgGFO6C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 10:58:02 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066EXmGC104673
        for <linux-rdma@vger.kernel.org>; Mon, 6 Jul 2020 10:58:01 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 322pam6dkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 10:58:01 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 6 Jul 2020 14:58:01 -0000
Received: from us1b3-smtp07.a3dr.sjc01.isc4sb.com (10.122.203.198)
        by smtp.notes.na.collabserv.com (10.122.47.50) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 6 Jul 2020 14:57:58 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp07.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020070614575763-481002 ;
          Mon, 6 Jul 2020 14:57:57 +0000 
In-Reply-To: <20200706091119.367697-2-kamalheib1@gmail.com>
Subject: Re: [PATCH for-rc v1 1/4] RDMA/siw: Set max_pkeys attribute
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Kamal Heib" <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Doug Ledford" <dledford@redhat.com>
Date:   Mon, 6 Jul 2020 14:57:57 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200706091119.367697-2-kamalheib1@gmail.com>,<20200706091119.367697-1-kamalheib1@gmail.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-KeepSent: 3A64F2C7:2B20CADD-0025859D:005235C6;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 12839
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20070614-1059-0000-0000-0000024B338C
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.021591
X-IBM-SpamModules-Versions: BY=3.00013418; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01401903; UDB=6.00750823; IPR=6.01184191;
 MB=3.00032877; MTD=3.00000008; XFM=3.00000015; UTC=2020-07-06 14:58:00
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-07-06 13:07:11 - 6.00011568
x-cbparentid: 20070614-1060-0000-0000-000054AE3625
Message-Id: <OF3A64F2C7.2B20CADD-ON0025859D.005235C6-0025859D.005235CF@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_11:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----

>To: linux-rdma@vger.kernel.org
>From: "Kamal Heib" <kamalheib1@gmail.com>
>Date: 07/06/2020 11:11AM
>Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Doug Ledford"
><dledford@redhat.com>, "Kamal Heib" <kamalheib1@gmail.com>, "Bernard
>Metzler" <bmt@zurich.ibm.com>
>Subject: [EXTERNAL] [PATCH for-rc v1 1/4] RDMA/siw: Set max_pkeys
>attribute
>
>Make sure to set the max_pkeys attribute to indicate the maximum
>number
>of partitions supported by the siw device.
>
>Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
>Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>---
> drivers/infiniband/sw/siw/siw_verbs.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>b/drivers/infiniband/sw/siw/siw_verbs.c
>index 987e2ba05dbc..bef35d566aee 100644
>--- a/drivers/infiniband/sw/siw/siw_verbs.c
>+++ b/drivers/infiniband/sw/siw/siw_verbs.c
>@@ -151,6 +151,7 @@ int siw_query_device(struct ib_device *base_dev,
>struct ib_device_attr *attr,
> 	attr->max_srq = sdev->attrs.max_srq;
> 	attr->max_srq_sge = sdev->attrs.max_srq_sge;
> 	attr->max_srq_wr = sdev->attrs.max_srq_wr;
>+	attr->max_pkeys = 1;
> 	attr->page_size_cap = PAGE_SIZE;
> 	attr->vendor_id = SIW_VENDOR_ID;
> 	attr->vendor_part_id = sdev->vendor_part_id;
>-- 
>2.25.4
>
>
Thank you!
Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

