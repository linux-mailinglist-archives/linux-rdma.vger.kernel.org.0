Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59343216EC5
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 16:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGGObJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 7 Jul 2020 10:31:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727895AbgGGObI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 10:31:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067Dn5WN157482
        for <linux-rdma@vger.kernel.org>; Tue, 7 Jul 2020 10:31:08 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.81])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324pvdg4uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 10:31:07 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 7 Jul 2020 14:31:07 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.88) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 7 Jul 2020 14:31:01 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2020070714305975-497310 ;
          Tue, 7 Jul 2020 14:30:59 +0000 
In-Reply-To: <20200707130931.444724-1-kamalheib1@gmail.com>
Subject: Re: [PATCH for-rc] RDMA/siw: Fix reporting vendor_part_id
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Kamal Heib" <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Doug Ledford" <dledford@redhat.com>
Date:   Tue, 7 Jul 2020 14:30:59 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200707130931.444724-1-kamalheib1@gmail.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 63355
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20070714-3067-0000-0000-0000039255E2
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00013423; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01402367; UDB=6.00751096; IPR=6.01184650;
 MB=3.00032890; MTD=3.00000008; XFM=3.00000015; UTC=2020-07-07 14:31:06
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-07-07 07:42:55 - 6.00011571
x-cbparentid: 20070714-3068-0000-0000-0000965658A9
Message-Id: <OF62223FF6.379FE201-ON0025859E.004FBDD5-0025859E.004FBDDC@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_08:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----

>To: linux-rdma@vger.kernel.org
>From: "Kamal Heib" <kamalheib1@gmail.com>
>Date: 07/07/2020 03:09PM
>Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Doug Ledford"
><dledford@redhat.com>, "Bernard Metzler" <bmt@zurich.ibm.com>, "Kamal
>Heib" <kamalheib1@gmail.com>
>Subject: [EXTERNAL] [PATCH for-rc] RDMA/siw: Fix reporting
>vendor_part_id
>
>Move the initialization of the vendor_part_id to be before calling
>ib_register_device(), this is needed because the query_device()
>callback
>is called from the context of ib_register_device() before
>initializing
>the vendor_part_id, so the reported value is wrong.
>
>Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
>Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>---
> drivers/infiniband/sw/siw/siw_main.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_main.c
>b/drivers/infiniband/sw/siw/siw_main.c
>index a0b8cc643c5c..ed60c9e4643e 100644
>--- a/drivers/infiniband/sw/siw/siw_main.c
>+++ b/drivers/infiniband/sw/siw/siw_main.c
>@@ -67,12 +67,13 @@ static int siw_device_register(struct siw_device
>*sdev, const char *name)
> 	static int dev_id = 1;
> 	int rv;
> 
>+	sdev->vendor_part_id = dev_id++;
>+
> 	rv = ib_register_device(base_dev, name);
> 	if (rv) {
> 		pr_warn("siw: device registration error %d\n", rv);
> 		return rv;
> 	}
>-	sdev->vendor_part_id = dev_id++;
> 
> 	siw_dbg(base_dev, "HWaddr=%pM\n", sdev->netdev->dev_addr);
> 
>-- 
>2.25.4
>
>
Many thanks, Kamal!
Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

