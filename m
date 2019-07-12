Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF766BAB
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 13:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfGLLiV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 12 Jul 2019 07:38:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbfGLLiV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jul 2019 07:38:21 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CBc6f0144257
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 07:38:20 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpry01e0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 07:38:19 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 12 Jul 2019 11:38:19 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
        by smtp.notes.na.collabserv.com (10.122.47.52) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 12 Jul 2019 11:38:14 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp04.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019071211381356-350470 ;
          Fri, 12 Jul 2019 11:38:13 +0000 
In-Reply-To: <20190712085314.3974907-1-arnd@arndb.de>
Subject: Re: [PATCH] rdma/siw: fix enum type mismatch warnings
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Jason Gunthorpe" <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Jul 2019 11:38:13 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190712085314.3974907-1-arnd@arndb.de>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 85440727:0E9065F0-00258435:003FECCD;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 49099
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19071211-3633-0000-0000-0000002A1888
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000254
X-IBM-SpamModules-Versions: BY=3.00011414; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01231074; UDB=6.00648486; IPR=6.01012358;
 MB=3.00027690; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-12 11:38:18
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-12 09:31:32 - 6.00010155
x-cbparentid: 19071211-3634-0000-0000-000000461981
Message-Id: <OF85440727.0E9065F0-ON00258435.003FECCD-00258435.003FECD0@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Arnd Bergmann" <arnd@arndb.de> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
><dledford@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>
>From: "Arnd Bergmann" <arnd@arndb.de>
>Date: 07/12/2019 10:53AM
>Cc: "Arnd Bergmann" <arnd@arndb.de>, "Jason Gunthorpe"
><jgg@mellanox.com>, linux-rdma@vger.kernel.org,
>linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] [PATCH] rdma/siw: fix enum type mismatch warnings
>
>The values in map_cqe_status[] don't match the type:
>
>drivers/infiniband/sw/siw/siw_cq.c:31:4: error: implicit conversion
>from enumeration type 'enum siw_wc_status' to different enumeration
>type 'enum siw_opcode' [-Werror,-Wenum-conversion]
>        { SIW_WC_SUCCESS, IB_WC_SUCCESS },
>        ~ ^~~~~~~~~~~~~~
>drivers/infiniband/sw/siw/siw_cq.c:32:4: error: implicit conversion
>from enumeration type 'enum siw_wc_status' to different enumeration
>type 'enum siw_opcode' [-Werror,-Wenum-conversion]
>        { SIW_WC_LOC_LEN_ERR, IB_WC_LOC_LEN_ERR },
>        ~ ^~~~~~~~~~~~~~~~~~
>
>Change the struct definition to make them match and stop the
>warning.
>
>Fixes: b0fff7317bb4 ("rdma/siw: completion queue methods")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
>2.20.0
>
>

Hi Arnd, this got already fixed.

Many thanks!
Bernard.

