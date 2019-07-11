Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9E6529B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 09:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfGKHoa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 11 Jul 2019 03:44:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfGKHoa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jul 2019 03:44:30 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6B7i8S9118925
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 03:44:29 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.119])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tp035j89k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 03:44:29 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 11 Jul 2019 07:44:28 -0000
Received: from us1b3-smtp01.a3dr.sjc01.isc4sb.com (10.122.7.174)
        by smtp.notes.na.collabserv.com (10.122.182.123) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 11 Jul 2019 07:44:23 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp01.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019071107442246-171529 ;
          Thu, 11 Jul 2019 07:44:22 +0000 
In-Reply-To: <20190710174800.34451-1-natechancellor@gmail.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Nathan Chancellor" <natechancellor@gmail.com>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Thu, 11 Jul 2019 07:44:22 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190710174800.34451-1-natechancellor@gmail.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: E93E0F86:E35CE856-00258434:002A83CE;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 22511
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19071107-6115-0000-0000-000006627147
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.378364; ST=0; TS=0; UL=0; ISC=; MB=0.000118
X-IBM-SpamModules-Versions: BY=3.00011408; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01230525; UDB=6.00648152; IPR=6.01011801;
 BA=6.00006354; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027677; XFM=3.00000015;
 UTC=2019-07-11 07:44:27
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-11 02:51:54 - 6.00010150
x-cbparentid: 19071107-6116-0000-0000-0000B1669CB6
Message-Id: <OFE93E0F86.E35CE856-ON00258434.002A83CE-00258434.002A83DF@notes.na.collabserv.com>
Subject: Re:  [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-11_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Nathan Chancellor" <natechancellor@gmail.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
><dledford@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>
>From: "Nathan Chancellor" <natechancellor@gmail.com>
>Date: 07/10/2019 07:48PM
>Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
>clang-built-linux@googlegroups.com, "Nathan Chancellor"
><natechancellor@gmail.com>
>Subject: [EXTERNAL] [PATCH] rdma/siw: Use proper enumerated type in
>map_cqe_status
>
>clang warns several times:
>
>drivers/infiniband/sw/siw/siw_cq.c:31:4: warning: implicit conversion
>from enumeration type 'enum siw_wc_status' to different enumeration
>type
>'enum siw_opcode' [-Wenum-conversion]
>        { SIW_WC_SUCCESS, IB_WC_SUCCESS },
>        ~ ^~~~~~~~~~~~~~
>
>Fixes: b0fff7317bb4 ("rdma/siw: completion queue methods")
>Link:
>https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_Clang
>BuiltLinux_linux_issues_596&d=DwIDAg&c=jf_iaSHvJObTbx-siA1ZOg&r=2TaYX
>Q0T-r8ZO1PP1alNwU_QJcRRLfmYTAgd3QCvqSc&m=1dqKSwiEVgePsLNbxXRmdhXDxww4
>AEGxKq-g-MmQHBo&s=IFwaU5yLu598NLBtKkAxLXzRNmACfnhxCpg3QVeJpB0&e= 
>Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>---
> drivers/infiniband/sw/siw/siw_cq.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_cq.c
>b/drivers/infiniband/sw/siw/siw_cq.c
>index e2a0ee40d5b5..e381ae9b7d62 100644
>--- a/drivers/infiniband/sw/siw/siw_cq.c
>+++ b/drivers/infiniband/sw/siw/siw_cq.c
>@@ -25,7 +25,7 @@ static int map_wc_opcode[SIW_NUM_OPCODES] = {
> };
> 
> static struct {
>-	enum siw_opcode siw;
>+	enum siw_wc_status siw;
> 	enum ib_wc_status ib;
> } map_cqe_status[SIW_NUM_WC_STATUS] = {
> 	{ SIW_WC_SUCCESS, IB_WC_SUCCESS },
>-- 
>2.22.0
>
>
>
Nathan, thanks very much. That's correct.
I don't know how this could pass w/o warning.

Many thanks,
Bernard.

