Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4032A8825
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 21:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbgKEUc7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 15:32:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbgKEUc7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 15:32:59 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5KWMXp169844
        for <linux-rdma@vger.kernel.org>; Thu, 5 Nov 2020 15:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : from : to
 : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id : subject; s=pp1;
 bh=+cNySr7BIpCmfbWAk2jyZopLe5xWv2B9gDvRj+y56Ec=;
 b=WiwtWO0Bf9gr5vGCfiYa14uD43u/y2/XdQlMIPMorMOGPoxJUSN3SL/IXv4TPYhYCS8z
 Llq2LD0z/0mcOswCmRkDZD6YWJBpbM5HDVKJn0lYhHY7cxTxjSzEyRwtFl9De9BwtR2A
 aUFTDe8Iv1L5kNu2etC16S9KkstqG+7xSblo0HsqWlm89Xya4J50G9TH41WLdxNaQBes
 Txc8X5cwN3oqR/OlV3+f6Y6M4Mt+uet8vto8AQGXdi9F5cY3dlPTvKr+Bw+dhRt/y+re
 21NqrR1jEDOKyzoJjyL6YNcq4j17pijjwrXLDB2XKLY76Esi/NrFmUefFSrEXpUlTSI/ Vg== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.90])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34mmmh8acs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 05 Nov 2020 15:32:58 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 5 Nov 2020 20:32:57 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.141) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 5 Nov 2020 20:32:54 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2020110520325426-756408 ;
          Thu, 5 Nov 2020 20:32:54 +0000 
In-Reply-To: <20201105074205.1690638-2-hch@lst.de>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Zhu Yanjun" <yanjunz@nvidia.com>,
        "Logan Gunthorpe" <logang@deltatee.com>,
        "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
        "Mike Marciniszyn" <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Date:   Thu, 5 Nov 2020 20:32:54 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20201105074205.1690638-2-hch@lst.de>,<20201105074205.1690638-1-hch@lst.de>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 39923
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 20110520-3649-0000-0000-00000459AADB
X-IBM-SpamModules-Scores: BY=0.057312; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00014137; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01459673; UDB=6.00785411; IPR=6.01242325;
 MB=3.00034882; MTD=3.00000008; XFM=3.00000015; UTC=2020-11-05 20:32:56
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-11-05 18:00:52 - 6.00012035
x-cbparentid: 20110520-3650-0000-0000-0000C15DD2EB
Message-Id: <OF012640DA.380B447C-ON00258617.0070E025-00258617.0070E031@notes.na.collabserv.com>
Subject: Re:  [PATCH 1/6] RMDA/sw: don't allow drivers using dma_virt_ops on highmem
 configs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_14:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Christoph Hellwig" <hch@lst.de> wrote: -----

>To: "Jason Gunthorpe" <jgg@ziepe.ca>
>From: "Christoph Hellwig" <hch@lst.de>
>Date: 11/05/2020 08:46AM
>Cc: "Bjorn Helgaas" <bhelgaas@google.com>, "Bernard Metzler"
><bmt@zurich.ibm.com>, "Zhu Yanjun" <yanjunz@nvidia.com>, "Logan
>Gunthorpe" <logang@deltatee.com>, "Dennis Dalessandro"
><dennis.dalessandro@cornelisnetworks.com>, "Mike Marciniszyn"
><mike.marciniszyn@cornelisnetworks.com>, linux-rdma@vger.kernel.org,
>linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
>Subject: [EXTERNAL] [PATCH 1/6] RMDA/sw: don't allow drivers using
>dma=5Fvirt=5Fops on highmem configs
>
>dma=5Fvirt=5Fops requires that all pages have a kernel virtual address.
>Introduce a INFINIBAND=5FVIRT=5FDMA Kconfig symbol that depends on
>!HIGHMEM
>and a large enough dma=5Faddr=5Ft, and make all three driver depend on
>the
>new symbol.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>---
> drivers/infiniband/Kconfig           | 6 ++++++
> drivers/infiniband/sw/rdmavt/Kconfig | 3 ++-
> drivers/infiniband/sw/rxe/Kconfig    | 2 +-
> drivers/infiniband/sw/siw/Kconfig    | 1 +
> 4 files changed, 10 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
>index 32a51432ec4f73..81acaf5fb5be67 100644
>--- a/drivers/infiniband/Kconfig
>+++ b/drivers/infiniband/Kconfig
>@@ -73,6 +73,12 @@ config INFINIBAND=5FADDR=5FTRANS=5FCONFIGFS
> 	  This allows the user to config the default GID type that the CM
> 	  uses for each device, when initiaing new connections.
>=20
>+config INFINIBAND=5FVIRT=5FDMA
>+	bool
>+	default y
>+	depends on !HIGHMEM
>+	depends on !64BIT || ARCH=5FDMA=5FADDR=5FT=5F64BIT
>+
> if INFINIBAND=5FUSER=5FACCESS || !INFINIBAND=5FUSER=5FACCESS
> source "drivers/infiniband/hw/mthca/Kconfig"
> source "drivers/infiniband/hw/qib/Kconfig"
>diff --git a/drivers/infiniband/sw/rdmavt/Kconfig
>b/drivers/infiniband/sw/rdmavt/Kconfig
>index 9ef5f5ce1ff6b0..c8e268082952b0 100644
>--- a/drivers/infiniband/sw/rdmavt/Kconfig
>+++ b/drivers/infiniband/sw/rdmavt/Kconfig
>@@ -1,7 +1,8 @@
> # SPDX-License-Identifier: GPL-2.0-only
> config INFINIBAND=5FRDMAVT
> 	tristate "RDMA verbs transport library"
>-	depends on X86=5F64 && ARCH=5FDMA=5FADDR=5FT=5F64BIT
>+	depends on INFINIBAND=5FVIRT=5FDMA
>+	depends on X86=5F64
> 	depends on PCI
> 	select DMA=5FVIRT=5FOPS
> 	help
>diff --git a/drivers/infiniband/sw/rxe/Kconfig
>b/drivers/infiniband/sw/rxe/Kconfig
>index a0c6c7dfc1814f..8810bfa680495a 100644
>--- a/drivers/infiniband/sw/rxe/Kconfig
>+++ b/drivers/infiniband/sw/rxe/Kconfig
>@@ -2,7 +2,7 @@
> config RDMA=5FRXE
> 	tristate "Software RDMA over Ethernet (RoCE) driver"
> 	depends on INET && PCI && INFINIBAND
>-	depends on !64BIT || ARCH=5FDMA=5FADDR=5FT=5F64BIT
>+	depends on INFINIBAND=5FVIRT=5FDMA
> 	select NET=5FUDP=5FTUNNEL
> 	select CRYPTO=5FCRC32
> 	select DMA=5FVIRT=5FOPS
>diff --git a/drivers/infiniband/sw/siw/Kconfig
>b/drivers/infiniband/sw/siw/Kconfig
>index b622fc62f2cd6d..3450ba5081df51 100644
>--- a/drivers/infiniband/sw/siw/Kconfig
>+++ b/drivers/infiniband/sw/siw/Kconfig
>@@ -1,6 +1,7 @@
> config RDMA=5FSIW
> 	tristate "Software RDMA over TCP/IP (iWARP) driver"
> 	depends on INET && INFINIBAND && LIBCRC32C
>+	depends on INFINIBAND=5FVIRT=5FDMA
> 	select DMA=5FVIRT=5FOPS
> 	help
> 	This driver implements the iWARP RDMA transport over
>--=20
>2.28.0
>
>


The complete patch set works for siw. Tested with siw as
nvmef target.

Tested-by: Bernard Metzler <bmt@zurich.ibm.com>

