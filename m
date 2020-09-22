Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8973C273DD7
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIVI6Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 04:58:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34724 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726366AbgIVI6Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 04:58:16 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08M8XKj4152419
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 04:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : from : to
 : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id : subject; s=pp1;
 bh=ZPmSXjWJpd9E9d4O3n7CccjDWyy0fYiaDn3rcykkipo=;
 b=mXkDwBfp8ft1FXDb5/l7UHkKJhYxBQmR03vVABGFirMd5CEo8yEnW8/wtDBERgggiU+R
 lKa32X3BaZEe9Ma+dKOORONRpfIz1t/ie9zctS6+O6GgLirhjYSMhYE+mZPyVfSSweOz
 3oF0/zgHTd/l404mZP9O9Bwg0Zqig8tLOS+J4W9sD9s8en8RJMAIZ2mp3cASqAq0JAXe
 r/WvJHqjqfsti5qG4vD2Vtnz+MmlLvoSvV1C0lHXMsrEoWmkv2gPOsnxzmi5uas8UFUp
 +SEuM390YZLQClliRgg9rMwutfqk3Pi2q+VIagtdyxa1VfoC5pJQTa2DL6q+83qjS4rJ gQ== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.66])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33qdcys7dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 04:58:10 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 22 Sep 2020 08:58:09 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.127) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 22 Sep 2020 08:58:07 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2020092208580668-173849 ;
          Tue, 22 Sep 2020 08:58:06 +0000 
In-Reply-To: <20200922082745.2149973-1-leon@kernel.org>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        "Adit Ranadive" <aditr@vmware.com>,
        "Ariel Elior" <aelior@marvell.com>,
        "Christian Benvenuti" <benve@cisco.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        "Devesh Sharma" <devesh.sharma@broadcom.com>,
        "Faisal Latif" <faisal.latif@intel.com>,
        "Gal Pressman" <galpress@amazon.com>,
        "Lijun Ou" <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        "Michal Kalderon" <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        "Naresh Kumar PBS" <nareshkumar.pbs@broadcom.com>,
        "Nelson Escobar" <neescoba@cisco.com>,
        "Parav Pandit" <parav@nvidia.com>,
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        "Selvin Xavier" <selvin.xavier@broadcom.com>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>,
        "Somnath Kotur" <somnath.kotur@broadcom.com>,
        "Sriharsha Basavapatna" <sriharsha.basavapatna@broadcom.com>,
        "VMware PV-Drivers" <pv-drivers@vmware.com>,
        "Weihang Li" <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        "Yishai Hadas" <yishaih@nvidia.com>,
        "Zhu Yanjun" <yanjunz@nvidia.com>
Date:   Tue, 22 Sep 2020 08:58:06 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200922082745.2149973-1-leon@kernel.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 28363
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 20092208-4409-0000-0000-000003B9233D
X-IBM-SpamModules-Scores: BY=0.250018; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.110536
X-IBM-SpamModules-Versions: BY=3.00013873; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01438442; UDB=6.00772795; IPR=6.01221128;
 MB=3.00034180; MTD=3.00000008; XFM=3.00000015; UTC=2020-09-22 08:58:09
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-09-22 08:55:00 - 6.00011869
x-cbparentid: 20092208-4410-0000-0000-0000974E3005
Message-Id: <OFA7334E75.E0306A27-ON002585EB.003059A0-002585EB.0031440E@notes.na.collabserv.com>
Subject: Re:  [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_05:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Doug Ledford" <dledford@redhat.com>, "Jason Gunthorpe"
><jgg@nvidia.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 09/22/2020 10:28AM
>Cc: "Adit Ranadive" <aditr@vmware.com>, "Ariel Elior"
><aelior@marvell.com>, "Bernard Metzler" <bmt@zurich.ibm.com>,
>"Christian Benvenuti" <benve@cisco.com>, "Dennis Dalessandro"
><dennis.dalessandro@intel.com>, "Devesh Sharma"
><devesh.sharma@broadcom.com>, "Faisal Latif"
><faisal.latif@intel.com>, "Gal Pressman" <galpress@amazon.com>,
>"Lijun Ou" <oulijun@huawei.com>, linux-rdma@vger.kernel.org, "Michal
>Kalderon" <mkalderon@marvell.com>, "Mike Marciniszyn"
><mike.marciniszyn@intel.com>, "Naresh Kumar PBS"
><nareshkumar.pbs@broadcom.com>, "Nelson Escobar"
><neescoba@cisco.com>, "Parav Pandit" <parav@nvidia.com>, "Parvi
>Kaustubhi" <pkaustub@cisco.com>, "Potnuri Bharat Teja"
><bharat@chelsio.com>, "Selvin Xavier" <selvin.xavier@broadcom.com>,
>"Shiraz Saleem" <shiraz.saleem@intel.com>, "Somnath Kotur"
><somnath.kotur@broadcom.com>, "Sriharsha Basavapatna"
><sriharsha.basavapatna@broadcom.com>, "VMware PV-Drivers"
><pv-drivers@vmware.com>, "Weihang Li" <liweihang@huawei.com>, "Wei
>Hu(Xavier)" <huwei87@hisilicon.com>, "Yishai Hadas"
><yishaih@nvidia.com>, "Zhu Yanjun" <yanjunz@nvidia.com>
>Subject: [EXTERNAL] [PATCH rdma-next] RDMA: Explicitly pass in the
>dma=5Fdevice to ib=5Fregister=5Fdevice
>
>From: Jason Gunthorpe <jgg@nvidia.com>
>
>The current design is convoulted where the IB core makes assumptions
>that a real DMA device will usually come from parent unless it looks
>like the ib=5Fdevice is partially setup for DMA, in which case the
>ib=5Fdevice itself is used for DMA, but somethings might still come
>from the parent.
>
>Make this clearer by having the caller explicitly specify what the
>DMA device should be. The caller is always responsible to fully
>setup the DMA device it specifies. If NULL is used then the
>ib=5Fdevice will be used as the DMA device, but the caller must
>still set it up completely.
>
>rvt is the only driver that did not fully setup the DMA device
>before registering. Move the rvt specific code out of
>setup=5Fdma=5Fdevice() into rvt and set the dma=5Fmask's directly.
>
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>Reviewed-by: Parav Pandit <parav@nvidia.com>
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>---
> drivers/infiniband/core/device.c              | 73
>+++++++------------
> drivers/infiniband/hw/bnxt=5Fre/main.c          |  2 +-
> drivers/infiniband/hw/cxgb4/provider.c        |  3 +-
> drivers/infiniband/hw/efa/efa=5Fmain.c          |  2 +-
> drivers/infiniband/hw/hns/hns=5Froce=5Fmain.c     |  2 +-
> drivers/infiniband/hw/i40iw/i40iw=5Fverbs.c     |  2 +-
> drivers/infiniband/hw/mlx4/main.c             |  3 +-
> drivers/infiniband/hw/mlx5/main.c             |  2 +-
> drivers/infiniband/hw/mthca/mthca=5Fprovider.c  |  2 +-
> drivers/infiniband/hw/ocrdma/ocrdma=5Fmain.c    |  3 +-
> drivers/infiniband/hw/qedr/main.c             |  2 +-
> drivers/infiniband/hw/usnic/usnic=5Fib=5Fmain.c   |  2 +-
> .../infiniband/hw/vmw=5Fpvrdma/pvrdma=5Fmain.c    |  2 +-
> drivers/infiniband/sw/rdmavt/vt.c             |  8 +-
> drivers/infiniband/sw/rxe/rxe=5Fverbs.c         |  2 +-
> drivers/infiniband/sw/siw/siw=5Fmain.c          |  4 +-
> include/rdma/ib=5Fverbs.h                       |  3 +-
> 17 files changed, 52 insertions(+), 65 deletions(-)
>
>diff --git a/drivers/infiniband/core/device.c
>b/drivers/infiniband/core/device.c
>index ec3becf85cac..417d93bbdaca 100644
>--- a/drivers/infiniband/core/device.c
>+++ b/drivers/infiniband/core/device.c
>@@ -1177,58 +1177,34 @@ static int assign=5Fname(struct ib=5Fdevice
>*device, const char *name)
> 	return ret;
> }
>=20
>-static void setup=5Fdma=5Fdevice(struct ib=5Fdevice *device)
>+static void setup=5Fdma=5Fdevice(struct ib=5Fdevice *device,
>+			     struct device *dma=5Fdevice)
> {
>-	struct device *parent =3D device->dev.parent;
>-
>-	WARN=5FON=5FONCE(device->dma=5Fdevice);
>-
>-#ifdef CONFIG=5FDMA=5FOPS
>-	if (device->dev.dma=5Fops) {
>+	if (!dma=5Fdevice) {
> 		/*
>-		 * The caller provided custom DMA operations. Copy the
>-		 * DMA-related fields that are used by e.g. dma=5Falloc=5Fcoherent()
>-		 * into device->dev.
>+		 * If the caller does not provide a DMA capable device then the
>+		 * IB device will be used. In this case the caller should fully
>+		 * setup the ibdev for DMA. This usually means using
>+		 * dma=5Fvirt=5Fops.
> 		 */
>-		device->dma=5Fdevice =3D &device->dev;
>-		if (!device->dev.dma=5Fmask) {
>-			if (parent)
>-				device->dev.dma=5Fmask =3D parent->dma=5Fmask;
>-			else
>-				WARN=5FON=5FONCE(true);
>-		}
>-		if (!device->dev.coherent=5Fdma=5Fmask) {
>-			if (parent)
>-				device->dev.coherent=5Fdma=5Fmask =3D
>-					parent->coherent=5Fdma=5Fmask;
>-			else
>-				WARN=5FON=5FONCE(true);
>-		}
>-	} else
>-#endif /* CONFIG=5FDMA=5FOPS */
>-	{
>+#ifdef CONFIG=5FDMA=5FOPS
>+		if (WARN=5FON(!device->dev.dma=5Fops))
>+			return;
>+#endif
>+		if (WARN=5FON(!device->dev.dma=5Fparms))
>+			return;
>+
>+		dma=5Fdevice =3D &device->dev;
>+	} else {
>+		device->dev.dma=5Fparms =3D dma=5Fdevice->dma=5Fparms;
> 		/*
>-		 * The caller did not provide custom DMA operations. Use the
>-		 * DMA mapping operations of the parent device.
>+		 * Auto setup the segment size if a DMA device was passed in.
>+		 * The PCI core sets the maximum segment size to 64 KB. Increase
>+		 * this parameter to 2 GB.
> 		 */
>-		WARN=5FON=5FONCE(!parent);
>-		device->dma=5Fdevice =3D parent;
>-	}
>-
>-	if (!device->dev.dma=5Fparms) {
>-		if (parent) {
>-			/*
>-			 * The caller did not provide DMA parameters, so
>-			 * 'parent' probably represents a PCI device. The PCI
>-			 * core sets the maximum segment size to 64
>-			 * KB. Increase this parameter to 2 GB.
>-			 */
>-			device->dev.dma=5Fparms =3D parent->dma=5Fparms;
>-			dma=5Fset=5Fmax=5Fseg=5Fsize(device->dma=5Fdevice, SZ=5F2G);
>-		} else {
>-			WARN=5FON=5FONCE(true);
>-		}
>+		dma=5Fset=5Fmax=5Fseg=5Fsize(dma=5Fdevice, SZ=5F2G);
> 	}
>+	device->dma=5Fdevice =3D dma=5Fdevice;
> }
>=20
> /*
>@@ -1241,7 +1217,6 @@ static int setup=5Fdevice(struct ib=5Fdevice
>*device)
> 	struct ib=5Fudata uhw =3D {.outlen =3D 0, .inlen =3D 0};
> 	int ret;
>=20
>-	setup=5Fdma=5Fdevice(device);
> 	ib=5Fdevice=5Fcheck=5Fmandatory(device);
>=20
> 	ret =3D setup=5Fport=5Fdata(device);
>@@ -1361,7 +1336,8 @@ static void prevent=5Fdealloc=5Fdevice(struct
>ib=5Fdevice *ib=5Fdev)
>  * asynchronously then the device pointer may become freed as soon
>as this
>  * function returns.
>  */
>-int ib=5Fregister=5Fdevice(struct ib=5Fdevice *device, const char *name)
>+int ib=5Fregister=5Fdevice(struct ib=5Fdevice *device, const char *name,
>+		       struct device *dma=5Fdevice)
> {
> 	int ret;
>=20
>@@ -1369,6 +1345,7 @@ int ib=5Fregister=5Fdevice(struct ib=5Fdevice
>*device, const char *name)
> 	if (ret)
> 		return ret;
>=20
>+	setup=5Fdma=5Fdevice(device, dma=5Fdevice);
> 	ret =3D setup=5Fdevice(device);
> 	if (ret)
> 		return ret;
>diff --git a/drivers/infiniband/hw/bnxt=5Fre/main.c
>b/drivers/infiniband/hw/bnxt=5Fre/main.c
>index 53aee5a42ab8..b3bc62021039 100644
>--- a/drivers/infiniband/hw/bnxt=5Fre/main.c
>+++ b/drivers/infiniband/hw/bnxt=5Fre/main.c
>@@ -736,7 +736,7 @@ static int bnxt=5Fre=5Fregister=5Fib(struct bnxt=5Fre=
=5Fdev
>*rdev)
> 	if (ret)
> 		return ret;
>=20
>-	return ib=5Fregister=5Fdevice(ibdev, "bnxt=5Fre%d");
>+	return ib=5Fregister=5Fdevice(ibdev, "bnxt=5Fre%d",
>&rdev->en=5Fdev->pdev->dev);
> }
>=20
> static void bnxt=5Fre=5Fdev=5Fremove(struct bnxt=5Fre=5Fdev *rdev)
>diff --git a/drivers/infiniband/hw/cxgb4/provider.c
>b/drivers/infiniband/hw/cxgb4/provider.c
>index 4b76f2f3f4e4..5f4f3abf41e4 100644
>--- a/drivers/infiniband/hw/cxgb4/provider.c
>+++ b/drivers/infiniband/hw/cxgb4/provider.c
>@@ -570,7 +570,8 @@ void c4iw=5Fregister=5Fdevice(struct work=5Fstruct
>*work)
> 	ret =3D set=5Fnetdevs(&dev->ibdev, &dev->rdev);
> 	if (ret)
> 		goto err=5Fdealloc=5Fctx;
>-	ret =3D ib=5Fregister=5Fdevice(&dev->ibdev, "cxgb4=5F%d");
>+	ret =3D ib=5Fregister=5Fdevice(&dev->ibdev, "cxgb4=5F%d",
>+				 &dev->rdev.lldi.pdev->dev);
> 	if (ret)
> 		goto err=5Fdealloc=5Fctx;
> 	return;
>diff --git a/drivers/infiniband/hw/efa/efa=5Fmain.c
>b/drivers/infiniband/hw/efa/efa=5Fmain.c
>index 92d701146320..4de5be3e1dfe 100644
>--- a/drivers/infiniband/hw/efa/efa=5Fmain.c
>+++ b/drivers/infiniband/hw/efa/efa=5Fmain.c
>@@ -331,7 +331,7 @@ static int efa=5Fib=5Fdevice=5Fadd(struct efa=5Fdev *d=
ev)
>=20
> 	ib=5Fset=5Fdevice=5Fops(&dev->ibdev, &efa=5Fdev=5Fops);
>=20
>-	err =3D ib=5Fregister=5Fdevice(&dev->ibdev, "efa=5F%d");
>+	err =3D ib=5Fregister=5Fdevice(&dev->ibdev, "efa=5F%d", &pdev->dev);
> 	if (err)
> 		goto err=5Frelease=5Fdoorbell=5Fbar;
>=20
>diff --git a/drivers/infiniband/hw/hns/hns=5Froce=5Fmain.c
>b/drivers/infiniband/hw/hns/hns=5Froce=5Fmain.c
>index 2b4d75733e72..1b5f895d7daf 100644
>--- a/drivers/infiniband/hw/hns/hns=5Froce=5Fmain.c
>+++ b/drivers/infiniband/hw/hns/hns=5Froce=5Fmain.c
>@@ -547,7 +547,7 @@ static int hns=5Froce=5Fregister=5Fdevice(struct
>hns=5Froce=5Fdev *hr=5Fdev)
> 		if (ret)
> 			return ret;
> 	}
>-	ret =3D ib=5Fregister=5Fdevice(ib=5Fdev, "hns=5F%d");
>+	ret =3D ib=5Fregister=5Fdevice(ib=5Fdev, "hns=5F%d", dev);
> 	if (ret) {
> 		dev=5Ferr(dev, "ib=5Fregister=5Fdevice failed!\n");
> 		return ret;
>diff --git a/drivers/infiniband/hw/i40iw/i40iw=5Fverbs.c
>b/drivers/infiniband/hw/i40iw/i40iw=5Fverbs.c
>index e53f6c0dc12e..945d30a86bbc 100644
>--- a/drivers/infiniband/hw/i40iw/i40iw=5Fverbs.c
>+++ b/drivers/infiniband/hw/i40iw/i40iw=5Fverbs.c
>@@ -2748,7 +2748,7 @@ int i40iw=5Fregister=5Frdma=5Fdevice(struct
>i40iw=5Fdevice *iwdev)
> 	if (ret)
> 		goto error;
>=20
>-	ret =3D ib=5Fregister=5Fdevice(&iwibdev->ibdev, "i40iw%d");
>+	ret =3D ib=5Fregister=5Fdevice(&iwibdev->ibdev, "i40iw%d",
>&iwdev->hw.pcidev->dev);
> 	if (ret)
> 		goto error;
>=20
>diff --git a/drivers/infiniband/hw/mlx4/main.c
>b/drivers/infiniband/hw/mlx4/main.c
>index 753c70402498..cd0fba6b0964 100644
>--- a/drivers/infiniband/hw/mlx4/main.c
>+++ b/drivers/infiniband/hw/mlx4/main.c
>@@ -2841,7 +2841,8 @@ static void *mlx4=5Fib=5Fadd(struct mlx4=5Fdev *dev)
> 		goto err=5Fsteer=5Ffree=5Fbitmap;
>=20
> 	rdma=5Fset=5Fdevice=5Fsysfs=5Fgroup(&ibdev->ib=5Fdev, &mlx4=5Fattr=5Fgro=
up);
>-	if (ib=5Fregister=5Fdevice(&ibdev->ib=5Fdev, "mlx4=5F%d"))
>+	if (ib=5Fregister=5Fdevice(&ibdev->ib=5Fdev, "mlx4=5F%d",
>+			       &dev->persist->pdev->dev))
> 		goto err=5Fdiag=5Fcounters;
>=20
> 	if (mlx4=5Fib=5Fmad=5Finit(ibdev))
>diff --git a/drivers/infiniband/hw/mlx5/main.c
>b/drivers/infiniband/hw/mlx5/main.c
>index 3ae681a6ae3b..bca57c7661eb 100644
>--- a/drivers/infiniband/hw/mlx5/main.c
>+++ b/drivers/infiniband/hw/mlx5/main.c
>@@ -4404,7 +4404,7 @@ static int mlx5=5Fib=5Fstage=5Fib=5Freg=5Finit(struct
>mlx5=5Fib=5Fdev *dev)
> 		name =3D "mlx5=5F%d";
> 	else
> 		name =3D "mlx5=5Fbond=5F%d";
>-	return ib=5Fregister=5Fdevice(&dev->ib=5Fdev, name);
>+	return ib=5Fregister=5Fdevice(&dev->ib=5Fdev, name,
>&dev->mdev->pdev->dev);
> }
>=20
> static void mlx5=5Fib=5Fstage=5Fpre=5Fib=5Freg=5Fumr=5Fcleanup(struct mlx=
5=5Fib=5Fdev
>*dev)
>diff --git a/drivers/infiniband/hw/mthca/mthca=5Fprovider.c
>b/drivers/infiniband/hw/mthca/mthca=5Fprovider.c
>index 31b558ff8218..c4d9cdc4ee97 100644
>--- a/drivers/infiniband/hw/mthca/mthca=5Fprovider.c
>+++ b/drivers/infiniband/hw/mthca/mthca=5Fprovider.c
>@@ -1206,7 +1206,7 @@ int mthca=5Fregister=5Fdevice(struct mthca=5Fdev
>*dev)
> 	mutex=5Finit(&dev->cap=5Fmask=5Fmutex);
>=20
> 	rdma=5Fset=5Fdevice=5Fsysfs=5Fgroup(&dev->ib=5Fdev, &mthca=5Fattr=5Fgrou=
p);
>-	ret =3D ib=5Fregister=5Fdevice(&dev->ib=5Fdev, "mthca%d");
>+	ret =3D ib=5Fregister=5Fdevice(&dev->ib=5Fdev, "mthca%d", &dev->pdev->de=
v);
> 	if (ret)
> 		return ret;
>=20
>diff --git a/drivers/infiniband/hw/ocrdma/ocrdma=5Fmain.c
>b/drivers/infiniband/hw/ocrdma/ocrdma=5Fmain.c
>index d8c47d24d6d6..60416186f1d0 100644
>--- a/drivers/infiniband/hw/ocrdma/ocrdma=5Fmain.c
>+++ b/drivers/infiniband/hw/ocrdma/ocrdma=5Fmain.c
>@@ -255,7 +255,8 @@ static int ocrdma=5Fregister=5Fdevice(struct
>ocrdma=5Fdev *dev)
> 	if (ret)
> 		return ret;
>=20
>-	return ib=5Fregister=5Fdevice(&dev->ibdev, "ocrdma%d");
>+	return ib=5Fregister=5Fdevice(&dev->ibdev, "ocrdma%d",
>+				  &dev->nic=5Finfo.pdev->dev);
> }
>=20
> static int ocrdma=5Falloc=5Fresources(struct ocrdma=5Fdev *dev)
>diff --git a/drivers/infiniband/hw/qedr/main.c
>b/drivers/infiniband/hw/qedr/main.c
>index 7c0aac3e635b..464becdd41f7 100644
>--- a/drivers/infiniband/hw/qedr/main.c
>+++ b/drivers/infiniband/hw/qedr/main.c
>@@ -293,7 +293,7 @@ static int qedr=5Fregister=5Fdevice(struct qedr=5Fdev
>*dev)
> 	if (rc)
> 		return rc;
>=20
>-	return ib=5Fregister=5Fdevice(&dev->ibdev, "qedr%d");
>+	return ib=5Fregister=5Fdevice(&dev->ibdev, "qedr%d", &dev->pdev->dev);
> }
>=20
> /* This function allocates fast-path status block memory */
>diff --git a/drivers/infiniband/hw/usnic/usnic=5Fib=5Fmain.c
>b/drivers/infiniband/hw/usnic/usnic=5Fib=5Fmain.c
>index 462ed71abf53..6c23a5472168 100644
>--- a/drivers/infiniband/hw/usnic/usnic=5Fib=5Fmain.c
>+++ b/drivers/infiniband/hw/usnic/usnic=5Fib=5Fmain.c
>@@ -425,7 +425,7 @@ static void *usnic=5Fib=5Fdevice=5Fadd(struct pci=5Fdev
>*dev)
> 	if (ret)
> 		goto err=5Ffwd=5Fdealloc;
>=20
>-	if (ib=5Fregister=5Fdevice(&us=5Fibdev->ib=5Fdev, "usnic=5F%d"))
>+	if (ib=5Fregister=5Fdevice(&us=5Fibdev->ib=5Fdev, "usnic=5F%d", &dev->de=
v))
> 		goto err=5Ffwd=5Fdealloc;
>=20
> 	usnic=5Ffwd=5Fset=5Fmtu(us=5Fibdev->ufdev, us=5Fibdev->netdev->mtu);
>diff --git a/drivers/infiniband/hw/vmw=5Fpvrdma/pvrdma=5Fmain.c
>b/drivers/infiniband/hw/vmw=5Fpvrdma/pvrdma=5Fmain.c
>index 780fd2dfc07e..5b2c94441125 100644
>--- a/drivers/infiniband/hw/vmw=5Fpvrdma/pvrdma=5Fmain.c
>+++ b/drivers/infiniband/hw/vmw=5Fpvrdma/pvrdma=5Fmain.c
>@@ -270,7 +270,7 @@ static int pvrdma=5Fregister=5Fdevice(struct
>pvrdma=5Fdev *dev)
> 	spin=5Flock=5Finit(&dev->srq=5Ftbl=5Flock);
> 	rdma=5Fset=5Fdevice=5Fsysfs=5Fgroup(&dev->ib=5Fdev, &pvrdma=5Fattr=5Fgro=
up);
>=20
>-	ret =3D ib=5Fregister=5Fdevice(&dev->ib=5Fdev, "vmw=5Fpvrdma%d");
>+	ret =3D ib=5Fregister=5Fdevice(&dev->ib=5Fdev, "vmw=5Fpvrdma%d",
>&dev->pdev->dev);
> 	if (ret)
> 		goto err=5Fsrq=5Ffree;
>=20
>diff --git a/drivers/infiniband/sw/rdmavt/vt.c
>b/drivers/infiniband/sw/rdmavt/vt.c
>index f904bb34477a..2f117ac11c8b 100644
>--- a/drivers/infiniband/sw/rdmavt/vt.c
>+++ b/drivers/infiniband/sw/rdmavt/vt.c
>@@ -581,7 +581,11 @@ int rvt=5Fregister=5Fdevice(struct rvt=5Fdev=5Finfo
>*rdi)
> 	spin=5Flock=5Finit(&rdi->n=5Fcqs=5Flock);
>=20
> 	/* DMA Operations */
>-	rdi->ibdev.dev.dma=5Fops =3D rdi->ibdev.dev.dma=5Fops ? : &dma=5Fvirt=5F=
ops;
>+	rdi->ibdev.dev.dma=5Fops =3D &dma=5Fvirt=5Fops;
>+	rdi->ibdev.dev.dma=5Fparms =3D rdi->ibdev.dev.parent->dma=5Fparms;
>+	rdi->ibdev.dev.dma=5Fmask =3D rdi->ibdev.dev.parent->dma=5Fmask;
>+	rdi->ibdev.dev.coherent=5Fdma=5Fmask =3D
>+		rdi->ibdev.dev.parent->coherent=5Fdma=5Fmask;
>=20
> 	/* Protection Domain */
> 	spin=5Flock=5Finit(&rdi->n=5Fpds=5Flock);
>@@ -629,7 +633,7 @@ int rvt=5Fregister=5Fdevice(struct rvt=5Fdev=5Finfo *r=
di)
> 		rdi->ibdev.num=5Fcomp=5Fvectors =3D 1;
>=20
> 	/* We are now good to announce we exist */
>-	ret =3D ib=5Fregister=5Fdevice(&rdi->ibdev, dev=5Fname(&rdi->ibdev.dev));
>+	ret =3D ib=5Fregister=5Fdevice(&rdi->ibdev, dev=5Fname(&rdi->ibdev.dev),
>NULL);
> 	if (ret) {
> 		rvt=5Fpr=5Ferr(rdi, "Failed to register driver with ib core.\n");
> 		goto bail=5Fwss;
>diff --git a/drivers/infiniband/sw/rxe/rxe=5Fverbs.c
>b/drivers/infiniband/sw/rxe/rxe=5Fverbs.c
>index f368dc16281a..37fee72755be 100644
>--- a/drivers/infiniband/sw/rxe/rxe=5Fverbs.c
>+++ b/drivers/infiniband/sw/rxe/rxe=5Fverbs.c
>@@ -1182,7 +1182,7 @@ int rxe=5Fregister=5Fdevice(struct rxe=5Fdev *rxe,
>const char *ibdev=5Fname)
> 	rxe->tfm =3D tfm;
>=20
> 	rdma=5Fset=5Fdevice=5Fsysfs=5Fgroup(dev, &rxe=5Fattr=5Fgroup);
>-	err =3D ib=5Fregister=5Fdevice(dev, ibdev=5Fname);
>+	err =3D ib=5Fregister=5Fdevice(dev, ibdev=5Fname, NULL);
> 	if (err)
> 		pr=5Fwarn("%s failed with error %d\n", =5F=5Ffunc=5F=5F, err);
>=20
>diff --git a/drivers/infiniband/sw/siw/siw=5Fmain.c
>b/drivers/infiniband/sw/siw/siw=5Fmain.c
>index d862bec84376..0362d57b4db8 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fmain.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fmain.c
>@@ -69,7 +69,7 @@ static int siw=5Fdevice=5Fregister(struct siw=5Fdevice
>*sdev, const char *name)
>=20
> 	sdev->vendor=5Fpart=5Fid =3D dev=5Fid++;
>=20
>-	rv =3D ib=5Fregister=5Fdevice(base=5Fdev, name);
>+	rv =3D ib=5Fregister=5Fdevice(base=5Fdev, name, NULL);
> 	if (rv) {
> 		pr=5Fwarn("siw: device registration error %d\n", rv);
> 		return rv;
>@@ -386,6 +386,8 @@ static struct siw=5Fdevice
>*siw=5Fdevice=5Fcreate(struct net=5Fdevice *netdev)
> 	base=5Fdev->dev.dma=5Fparms =3D &sdev->dma=5Fparms;
> 	sdev->dma=5Fparms =3D (struct device=5Fdma=5Fparameters)
> 		{ .max=5Fsegment=5Fsize =3D SZ=5F2G };
>+	dma=5Fcoerce=5Fmask=5Fand=5Fcoherent(&base=5Fdev->dev,
>+				     dma=5Fget=5Frequired=5Fmask(&base=5Fdev->dev));

Leon, can you please help me to understand this
additional logic? Do we need to setup the DMA device
for (software) RDMA devices which rely on dma=5Fvirt=5Fops
in the end, or better leave it untouched?

Thanks very much!
Bernard.

