Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CDE2A9751
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 15:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgKFOAz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 09:00:55 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:5803 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgKFOAz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 6 Nov 2020 09:00:55 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa557150000>; Fri, 06 Nov 2020 22:00:53 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 14:00:53 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 6 Nov 2020 14:00:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqPNsg/cRQAZCJP5ZN3yqRnXVsD4WB+DFmgSSipkKUZwRqckf80S95lHUOTfgA37QAyPyLK8t3J8XM2a4mQlumBlp69DpWEGsKNco7OSdmGwT8I7UXY1G8+TZJTVI6Q8+M2zI/EzgrrexAOVeZjmnJ45UIrh8ltAfnh3dDirf5JASXgGP4ebV6ZLZ9qCSw1ZnAbFDto4piblhVxaum6TAReQeoJWtflKA7ruC4PN2GK+ToPnL78Gru3b4JhhkXaW4Wnfd57J1ZIyLrFSCxJpmsmJTzQvv4SFryRVWgRqxZ++I/UMA3n7KnvQSo8Y0xeK0sxLfn9DUC5V5umgoyMHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpbTElqGg/D3B8gWmULh5BuqkLpFFTofDsH1KrdV/uA=;
 b=SdtDtR6CO+p5pmfnbCcogVyXJz4R4WdpDwVPtTND41pabXdRlwDrz1DXNcsoY1QAwxD0HKPKYTdq9ESA1go4D8N3O6Gh5a1yIpRl1dx18CwffjwQRZsrDc8anvZO55IBh5Uu2Z8ty2ut4/IjtKG8I65DXaYrVG6VuREIhnUe26AT4v3WCEffMgpHspUZR987JiKGscutiTGTD3jOuP+MWODvznHH5u/kNSJWQbJdAyFMQlS/3sb1nPtfiJSJ6WUd3/AIWIqw/8D6/p/c5Ha2EtBvDo3dqU4RwEw9M7q4QrL805i6ngNdPjI6PEeLCBD+Qb6vbbjMWzen/BSqQNwNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2489.namprd12.prod.outlook.com (2603:10b6:3:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Fri, 6 Nov
 2020 14:00:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 14:00:51 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Zhu Yanjun <yanjunz@nvidia.com>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>
Subject: [PATCH] RDMA/siw,rxe: Make emulated devices virtual in the device tree
Date:   Fri, 6 Nov 2020 10:00:49 -0400
Message-ID: <0-v1-dcbfc68c4b4a+d6-virtual_dev_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:160::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:160::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend Transport; Fri, 6 Nov 2020 14:00:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kb2IL-000rXH-8O; Fri, 06 Nov 2020 10:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604671253; bh=YtuUkPhXof3Xet0fyY+bYpTArJE30vQhLeFxWRqGfSA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=GqfUNM6cL/lH6B2Hbw7xlvaWaLpIz+6lZY+ySHvTeGzwjbCyhGvxTg2xSstc6uTTM
         SnM53/VIftgQ2deMM9LXVzOikZrlR4B+kGCmS9ialVuzU3CcK67iVGR4cH2Hnonc10
         X4CQ6Gd3meRs2osudVvvmt2fBqYrt3MtLbzb2wL8BVYKWiPr19zk3cmaPyZ3hYL5UF
         2fKoKsu8g5p4nSds4M4Yhgwo6sTu3QJXGM8iwemiDKxv70ZgE0KqH7ng6AMRHgcDvZ
         akS9GHhJHfjncGrEmthKCxcOtYbkZCQJSitPopS/pLsYq1iiiDgY+8t2PbJxNT5PVf
         DSSwsRR5qM8sA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This moves siw and rxe to be virtual devices in the device tree:

lrwxrwxrwx 1 root root 0 Nov  6 13:55 /sys/class/infiniband/rxe0 -> ../../d=
evices/virtual/infiniband/rxe0/

Previously they were trying to parent themselves to the physical device of
their attached netdev, which doesn't make alot of sense.

My hope is this will solve some weird syzkaller hits related to sysfs as
it could be possible that the parent of a netdev is another netdev, eg
under bonding or some other syzkaller found netdev configuration.

Nesting a ib_device under anything but a physical device is going to cause
inconsistencies in sysfs during destructions.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c   | 12 ------------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  1 -
 drivers/infiniband/sw/siw/siw_main.c  | 19 +------------------
 3 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rx=
e/rxe_net.c
index 575e1a4ec82121..2b4238cdeab953 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -20,18 +20,6 @@
=20
 static struct rxe_recv_sockets recv_sockets;
=20
-struct device *rxe_dma_device(struct rxe_dev *rxe)
-{
-	struct net_device *ndev;
-
-	ndev =3D rxe->ndev;
-
-	if (is_vlan_dev(ndev))
-		ndev =3D vlan_dev_real_dev(ndev);
-
-	return ndev->dev.parent;
-}
-
 int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	int err;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/=
rxe/rxe_verbs.c
index 209c7b3fab97a2..0cc4116d9a1fa6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1134,7 +1134,6 @@ int rxe_register_device(struct rxe_dev *rxe, const ch=
ar *ibdev_name)
 	dev->node_type =3D RDMA_NODE_IB_CA;
 	dev->phys_port_cnt =3D 1;
 	dev->num_comp_vectors =3D num_possible_cpus();
-	dev->dev.parent =3D rxe_dma_device(rxe);
 	dev->local_dma_lkey =3D 0;
 	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
 			    rxe->ndev->dev_addr);
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/s=
iw/siw_main.c
index 9cf596429dbf7d..97cf43bf0244cd 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -305,24 +305,8 @@ static struct siw_device *siw_device_create(struct net=
_device *netdev)
 {
 	struct siw_device *sdev =3D NULL;
 	struct ib_device *base_dev;
-	struct device *parent =3D netdev->dev.parent;
 	int rv;
=20
-	if (!parent) {
-		/*
-		 * The loopback device has no parent device,
-		 * so it appears as a top-level device. To support
-		 * loopback device connectivity, take this device
-		 * as the parent device. Skip all other devices
-		 * w/o parent device.
-		 */
-		if (netdev->type !=3D ARPHRD_LOOPBACK) {
-			pr_warn("siw: device %s error: no parent device\n",
-				netdev->name);
-			return NULL;
-		}
-		parent =3D &netdev->dev;
-	}
 	sdev =3D ib_alloc_device(siw_device, base_dev);
 	if (!sdev)
 		return NULL;
@@ -359,7 +343,6 @@ static struct siw_device *siw_device_create(struct net_=
device *netdev)
 	 * per physical port.
 	 */
 	base_dev->phys_port_cnt =3D 1;
-	base_dev->dev.parent =3D parent;
 	base_dev->dev.dma_parms =3D &sdev->dma_parms;
 	dma_set_max_seg_size(&base_dev->dev, UINT_MAX);
 	dma_set_coherent_mask(&base_dev->dev,
@@ -405,7 +388,7 @@ static struct siw_device *siw_device_create(struct net_=
device *netdev)
 	atomic_set(&sdev->num_mr, 0);
 	atomic_set(&sdev->num_pd, 0);
=20
-	sdev->numa_node =3D dev_to_node(parent);
+	sdev->numa_node =3D dev_to_node(&netdev->dev);
 	spin_lock_init(&sdev->lock);
=20
 	return sdev;
--=20
2.29.2

