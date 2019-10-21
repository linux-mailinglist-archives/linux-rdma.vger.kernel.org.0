Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7256DE82F
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 11:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfJUJgJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 21 Oct 2019 05:36:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726725AbfJUJgJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 05:36:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9L9WKqs135964
        for <linux-rdma@vger.kernel.org>; Mon, 21 Oct 2019 05:36:08 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.114])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vs8r6v9cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 21 Oct 2019 05:36:08 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 21 Oct 2019 09:36:07 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
        by smtp.notes.na.collabserv.com (10.122.47.58) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 21 Oct 2019 09:36:01 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp04.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019102109360021-275057 ;
          Mon, 21 Oct 2019 09:36:00 +0000 
In-Reply-To: <20191021021030.1037-5-bvanassche@acm.org>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Bart Van Assche" <bvanassche@acm.org>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        "Doug Ledford" <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        "Christoph Hellwig" <hch@lst.de>
Date:   Mon, 21 Oct 2019 09:36:00 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20191021021030.1037-5-bvanassche@acm.org>,<20191021021030.1037-1-bvanassche@acm.org>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP59 September 23, 2019 at 18:08
X-KeepSent: 471AECA2:EB2C94E3-0025849A:0033B64B;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 54135
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19102109-1639-0000-0000-000000A89F9B
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000249
X-IBM-SpamModules-Versions: BY=3.00011975; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01278538; UDB=6.00677369; IPR=6.01060673;
 MB=3.00029172; MTD=3.00000008; XFM=3.00000015; UTC=2019-10-21 09:36:05
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-10-21 09:31:41 - 6.00010552
x-cbparentid: 19102109-1640-0000-0000-00003C1BA655
Message-Id: <OF471AECA2.EB2C94E3-ON0025849A.0033B64B-0025849A.0034BC19@notes.na.collabserv.com>
Subject: Re:  [PATCH 4/4] siw: Increase DMA max_segment_size parameter
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-21_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Bart Van Assche" <bvanassche@acm.org> wrote: -----

>To: "Jason Gunthorpe" <jgg@ziepe.ca>
>From: "Bart Van Assche" <bvanassche@acm.org>
>Date: 10/21/2019 04:10AM
>Cc: "Leon Romanovsky" <leonro@mellanox.com>, "Doug Ledford"
><dledford@redhat.com>, linux-rdma@vger.kernel.org, "Bart Van Assche"
><bvanassche@acm.org>, "Christoph Hellwig" <hch@lst.de>, "Bernard
>Metzler" <bmt@zurich.ibm.com>
>Subject: [EXTERNAL] [PATCH 4/4] siw: Increase DMA max_segment_size
>parameter
>
>Increase the DMA max_segment_size parameter from 64 KB to UINT_MAX.
>

Hi Bart,
Why don't we make device_dma_parameters siw_dma_params 
just a const in siw_main.c? Having it per siw_device suggests
more flexibility than we actually need and support? Probably
true as well for rxe driver. This is all driver specific.

Independent of this current patch, probably even true for
siw_device.attrs. We do not have those capabilities siw
device specific, but just siw driver specific.

Best regards,
Bernard.
>Cc: Christoph Hellwig <hch@lst.de>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>---
> drivers/infiniband/sw/siw/siw.h      | 1 +
> drivers/infiniband/sw/siw/siw_main.c | 3 +++
> 2 files changed, 4 insertions(+)
>
>diff --git a/drivers/infiniband/sw/siw/siw.h
>b/drivers/infiniband/sw/siw/siw.h
>index dba4535494ab..1ea3ed249e7b 100644
>--- a/drivers/infiniband/sw/siw/siw.h
>+++ b/drivers/infiniband/sw/siw/siw.h
>@@ -70,6 +70,7 @@ struct siw_pd {
> 
> struct siw_device {
> 	struct ib_device base_dev;
>+	struct device_dma_parameters dma_parms;
> 	struct net_device *netdev;
> 	struct siw_dev_cap attrs;
> 
>diff --git a/drivers/infiniband/sw/siw/siw_main.c
>b/drivers/infiniband/sw/siw/siw_main.c
>index d1a1b7aa7d83..041496376047 100644
>--- a/drivers/infiniband/sw/siw/siw_main.c
>+++ b/drivers/infiniband/sw/siw/siw_main.c
>@@ -402,6 +402,9 @@ static struct siw_device
>*siw_device_create(struct net_device *netdev)
> 	base_dev->phys_port_cnt = 1;
> 	base_dev->dev.parent = parent;
> 	base_dev->dev.dma_ops = &dma_virt_ops;
>+	base_dev->dev.dma_parms = &sdev->dma_parms;
>+	sdev->dma_parms = (struct device_dma_parameters)
>+		{ .max_segment_size = UINT_MAX };
> 	base_dev->num_comp_vectors = num_possible_cpus();
> 
> 	ib_set_device_ops(base_dev, &siw_device_ops);
>-- 
>2.23.0
>
>

