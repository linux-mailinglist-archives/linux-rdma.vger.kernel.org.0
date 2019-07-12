Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF766BA8
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfGLLhI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 12 Jul 2019 07:37:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbfGLLhI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jul 2019 07:37:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CBX3TG114386
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 07:37:06 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tpqya45ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 07:37:06 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 12 Jul 2019 11:37:05 -0000
Received: from us1b3-smtp08.a3dr.sjc01.isc4sb.com (10.122.203.190)
        by smtp.notes.na.collabserv.com (10.122.47.48) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 12 Jul 2019 11:36:58 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp08.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019071211365844-320674 ;
          Fri, 12 Jul 2019 11:36:58 +0000 
In-Reply-To: <20190712085253.3965945-1-arnd@arndb.de>
Subject: Re: [PATCH] rdma/siw: select CONFIG_DMA_VIRT_OPS
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Jason Gunthorpe" <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Jul 2019 11:36:58 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190712085253.3965945-1-arnd@arndb.de>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: FAD5C366:21FE2E97-00258435:003FCF45;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 19383
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19071211-3721-0000-0000-000006F517E0
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.011781
X-IBM-SpamModules-Versions: BY=3.00011414; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01231073; UDB=6.00648486; IPR=6.01012358;
 BA=6.00006355; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027690; XFM=3.00000015;
 UTC=2019-07-12 11:37:03
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-12 09:17:08 - 6.00010155
x-cbparentid: 19071211-3722-0000-0000-0000FEA51910
Message-Id: <OFFAD5C366.21FE2E97-ON00258435.003FCF45-00258435.003FCF4A@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Arnd, this got already fixed.

Many thanks!
Bernard.


-----"Arnd Bergmann" <arnd@arndb.de> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
><dledford@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>
>From: "Arnd Bergmann" <arnd@arndb.de>
>Date: 07/12/2019 10:53AM
>Cc: "Arnd Bergmann" <arnd@arndb.de>, "Jason Gunthorpe"
><jgg@mellanox.com>, linux-rdma@vger.kernel.org,
>linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] [PATCH] rdma/siw: select CONFIG_DMA_VIRT_OPS
>
>Without this symbol we get a link failure:
>
>ERROR: "dma_virt_ops" [drivers/infiniband/sw/siw/siw.ko] undefined!
>
>Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
> drivers/infiniband/sw/siw/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/infiniband/sw/siw/Kconfig
>b/drivers/infiniband/sw/siw/Kconfig
>index 94f684174ce3..ea282789f466 100644
>--- a/drivers/infiniband/sw/siw/Kconfig
>+++ b/drivers/infiniband/sw/siw/Kconfig
>@@ -1,6 +1,7 @@
> config RDMA_SIW
> 	tristate "Software RDMA over TCP/IP (iWARP) driver"
> 	depends on INET && INFINIBAND && CRYPTO_CRC32
>+	select DMA_VIRT_OPS
> 	help
> 	This driver implements the iWARP RDMA transport over
> 	the Linux TCP/IP network stack. It enables a system with a
>-- 
>2.20.0
>
>

