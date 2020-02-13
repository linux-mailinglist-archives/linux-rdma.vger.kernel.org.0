Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A216515BFDF
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 14:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgBMN7j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 13 Feb 2020 08:59:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729971AbgBMN7j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Feb 2020 08:59:39 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DDx69G073461
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 08:59:37 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y4wutvcc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 08:59:37 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 13 Feb 2020 13:59:36 -0000
Received: from us1b3-smtp07.a3dr.sjc01.isc4sb.com (10.122.203.198)
        by smtp.notes.na.collabserv.com (10.122.47.46) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 13 Feb 2020 13:59:31 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp07.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020021313593100-459802 ;
          Thu, 13 Feb 2020 13:59:31 +0000 
In-Reply-To: <20200213130701.11589-1-kamalheib1@gmail.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Kamal Heib" <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Doug Ledford" <dledford@redhat.com>
Date:   Thu, 13 Feb 2020 13:59:30 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200213130701.11589-1-kamalheib1@gmail.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-KeepSent: 9565E197:68A7B59D-0025850D:0049D122;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 43183
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20021313-3017-0000-0000-000001EE3E3D
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.117664
X-IBM-SpamModules-Versions: BY=3.00012567; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01333331; UDB=6.00710130; IPR=6.01115682;
 MB=3.00030783; MTD=3.00000008; XFM=3.00000015; UTC=2020-02-13 13:59:34
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-02-13 08:23:31 - 6.00010999
x-cbparentid: 20021313-3018-0000-0000-0000DCA4438B
Message-Id: <OF9565E197.68A7B59D-ON0025850D.0049D122-0025850D.004CDC1C@notes.na.collabserv.com>
Subject: Re:  [PATH for-next] RDMA/siw: Fix setting active_{speed, width} attributes
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_04:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----

>To: linux-rdma@vger.kernel.org
>From: "Kamal Heib" <kamalheib1@gmail.com>
>Date: 02/13/2020 02:07PM
>Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Doug Ledford"
><dledford@redhat.com>, "Bernard Metzler" <bmt@zurich.ibm.com>, "Kamal
>Heib" <kamalheib1@gmail.com>
>Subject: [EXTERNAL] [PATH for-next] RDMA/siw: Fix setting
>active_{speed, width} attributes
>
>Make sure to set the active_{speed, width} attributes to avoid
>reporting
>the same values regardless of the underlying device.
>
>Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
>Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>---
> drivers/infiniband/sw/siw/siw_verbs.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>b/drivers/infiniband/sw/siw/siw_verbs.c
>index 73485d0da907..b1aaec912edb 100644
>--- a/drivers/infiniband/sw/siw/siw_verbs.c
>+++ b/drivers/infiniband/sw/siw/siw_verbs.c
>@@ -165,11 +165,12 @@ int siw_query_port(struct ib_device *base_dev,
>u8 port,
> 		   struct ib_port_attr *attr)
> {
> 	struct siw_device *sdev = to_siw_dev(base_dev);
>+	int rc;
> 
> 	memset(attr, 0, sizeof(*attr));
> 
>-	attr->active_speed = 2;
>-	attr->active_width = 2;
>+	rc = ib_get_eth_speed(base_dev, port, &attr->active_speed,
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
>+	return rc;
> }
> 
> int siw_get_port_immutable(struct ib_device *base_dev, u8 port,
>-- 
>2.21.1
>
>
Hi Kamal, 
Many thanks for looking after this! So there definitely seem to 
be applications which are taking care of those values. So, good
to get my obvious laziness fixed.

I tried your patch on a 40Gbs Ethernet link (Chelsio cxgb4 driver).
Works in principle, but reported numbers are off. I am not saying
I would get right numbers when using Chelsio HW iWarp (iw_cxgb4),
but it's closer to reality (using ibv_devinfo <ibname> -vv)

iw_cxgb4 driver:
...
   active_width:           4X (2)
   active_speed:           25.0 Gbps (32)

siw driver with your patch:
...
   active_width:           4X (2)
   active_speed:           10.0 Gbps (8)

Any idea how we can improve that, maybe coming even
close to reality (40Gbs)?

Another remark: It has been siw folklore to name
integer return values 'rv', and not 'rc'. I never
liked 'return code'. It's a value in principle,
sometimes it's interpreted as a code though, as in
your case.

Many thanks!
Bernard.

