Return-Path: <linux-rdma+bounces-1542-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC7988A94D
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 17:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94DE1F67124
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FCA15F306;
	Mon, 25 Mar 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vz0PfXj6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BDC148FFE;
	Mon, 25 Mar 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376978; cv=fail; b=Uu+MUJQD6IF1p/g6tMeha4L/mrPF3fO9GsSg/VI5LhC6DmDu7jDcw81coEZfKsxkutcgyVG3OsSRuNZsvo50eX2FBl1RgDEVNL0B9//Je7vdvCJyXl7FCBAvPKXqOcWCf1rzPKHobs9+VV9W44ekaJdxvXEogOBfjaswyNJEa3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376978; c=relaxed/simple;
	bh=mU4J/HqOwBx1SR1jGfuAcpIevId8pZO7sQvljxwnXSw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hAAm/SVF22nENMn8w18hKR/FjZSQvUh7JgAlRCgaTzoO83OblFB9lGvMdfEAuOvb33WLqK/n0Bmyheki7DCi++9cCOOn2JX20ym8fMHzmAgM0FKFLIuFZb6QyQ1OsI4WM1uAcD0fG+f7U1C8fB7tDLaGE0qUciOXX9uza+j8W2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vz0PfXj6; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oT+EHUMerCHUu0ROCGUS/YbIhsA+cnwdB/M/KQ0zZblRRBJdgzD7fWGAzcplr9xz76tq2ereY6X6mfvjyd0FkyFQJ6qv24k+TymcupvbG2MMzPU4h6oXoo/RDo2PG+l1Ba1xLEzfMEuKGHlHxiCwyPw5mG+iDxgwb89ci7dVdScoZ/DFjMpNExNwlTBXXGnb2mpQCHvBx52XWqA72ZYHtOTZ//3yVlAPEya/dm/rz9Vl+lklhmAuLIzQkp2Ugqo9xkamPwHGhGAYReW8/BuQ2qoGdZJn2pJGascW9LCvFEzYgy5ucWeWmtOoElOB10f9oW+XDEpUE4pOXyV/gyItig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1cf1ybIQ719TWll5sHnwDP9q2eXxYq4Sn2sZqkrOg0=;
 b=FEGDxUCAV9RU/XiKe2lDBTDQ7gd1/NIYLVG/92HBqh+Nx/J4mUf+Rhkjm+di4iMllTd7YCWukLVvn4jqxEJoIbDCinlIprvMH9i80OQ9YRyDmEFYGuhT5Y9wOUWXFxtYKHkBfEaaVr4bavZT1JzjsraeKzUt13gpEJRHYe/7meuJ/4OCzs8yKe1P7moJo4A1EminNTiwID7sfhmEhJQgTg6ACO9z0OxWPOmt7CFHyYixQS4scfwwncGzOJGKzM38JcUhTaDBmIvk5q1eIroAalEauYwz7pgPjFK6UCtvBuJ948v2ounJJz1bU89VXxU2qRVkqmwRAYAvFNCN8IGdIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1cf1ybIQ719TWll5sHnwDP9q2eXxYq4Sn2sZqkrOg0=;
 b=Vz0PfXj6hCgVQvf1IaNyd4n5XpkTFbe8gp8+imE3YLYeNGlocXBPnzxOj27QOUVjAxYNNoY0S1L78BcRDTFjNqrZ6vJlRSZ0ac+CZm8WapaJ3j0WMCv9N3gO0yHF3Z0SZKJXDsVVIbbDDyQGiVZGaO6haqcLP3ILmBDXrNSvsao=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB9146.namprd12.prod.outlook.com (2603:10b6:610:19c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 14:29:32 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae%7]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 14:29:32 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Manivannan
 Sadhasivami <manivannan.sadhasivam@linaro.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"ntb@lists.linux.dev" <ntb@lists.linux.dev>, Lee Jones <lee@kernel.org>,
	David Airlie <airlied@gmail.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 10/28] drm: amdgpu: Use PCI_IRQ_INTX
Thread-Topic: [PATCH 10/28] drm: amdgpu: Use PCI_IRQ_INTX
Thread-Index: AQHafoOKlUhYM8aBa0G0tfj2QKDt0LFIhGoQ
Date: Mon, 25 Mar 2024 14:29:32 +0000
Message-ID:
 <BL1PR12MB51440D32B6A0969FD72665B3F7362@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
 <20240325070944.3600338-11-dlemoal@kernel.org>
In-Reply-To: <20240325070944.3600338-11-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b1c1248d-a2f1-4b4f-81c1-228a2cc72858;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-25T14:28:44Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB9146:EE_
x-ms-office365-filtering-correlation-id: 24beedf2-c2f3-4dc9-643d-08dc4cd7fd08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7sUu4jem5SUg6LkkHg24B8Haub110pvdDyq7PtxW3JsNtfpnouG4eQHb3vm1BXsbhiQrxgDIiB1OttR/E9KDWjNHbxwa8BK7wp4oTIDt6hFi9xjwa1KCZmjsWIuH8Z+oy/8sHA0zsCIwBWjKaJB4f5p+BmGQsf0+AtpT9ofbzflCwZyrfBm+mV8fH3Yj2XZb/UG6UnU3EzU4cHvQYoOZA0KVT5QmV/cCYBt7UjxgnzmRe/b0GoVSwIpT4FIdseOaF1k0iXk00mT2Iqel30wxftwZ4/xlvzY3DpIvVtWLA9uS5w1GKAsshwwaZMJ9Mc9czJsIVUmJaH42NFh5zYvg5JHxfsUV71Z5f0IloqKTa46sJhnHTl5CyqMzQNhaFJSMh6QeYt77EYNo8yx4BGOzYOEA9MJZqQY9eaPRzz1Y5eNEJnvlJs6Mcfe+Ct0CKo3sKkKuUj/5UvaNECoiGeym6mZMr3BWU3HE28TfBnRa6uX1F3poc50CIszTlz6PxayyPjr+3ZLn9tome/LpeteyI5y3nCFScOdV1Rwpn6WiW1w9AgaHLYgJw/zxLYsNKEC9vmFJo16jNUfN09LlD6vz8WPv+UT2nqUswAbPhRwBGvryocmlmuRt4xo5X0qwkXNcapqrqQ2X5hoJoK1AT1vpW1DnVZDbxG8z2m9mvf3fnpFYJiNJkiKY//67uJaJhzmqvWJPvTkMo0J82TMsMelsYGcu9QblpS7AZuXFGvuUN/8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dqNnZj7oblLLQZfgLVxGWwnLgPQYa8sB2fZl/03a+QOZ08SXWZxue4BW78DB?=
 =?us-ascii?Q?uX8je2UbmsCjtu3to+3uxlZbx3PpAu58yojhzm2ZevcjgQg/zt+bpmBe5wbH?=
 =?us-ascii?Q?SCXVwll6q+O8gS5ON9CYObnhJJrf7e2a8zUCEppsuKoSXNpgI/ruxDM8Losa?=
 =?us-ascii?Q?VWZk/fF3r78/oGLjd1zd+VoMEkyv24CXjSIiFTAATb3Qf6OqJtWa72wIX9OL?=
 =?us-ascii?Q?8/7KTThTM1aH1BoE+O+Ht54VnLxdZjB5LMBJflciIWilojVxTl0kDxCkw8Or?=
 =?us-ascii?Q?pvMts9x9waUgKAx8Gou+wnQosojtrKus1pNtney3e1edQA7o3uFp6yAtfpjH?=
 =?us-ascii?Q?dDoLkev/6FWiZ2jDyJvvuK7/S4TK7GP3i78O+TwQgLUSBLDjAa79ZHKTVuPJ?=
 =?us-ascii?Q?wa1ZjBvisaxRQD/YdbXDe2toVhzDMWlKV3hgPQB5Ikub8AKGJEuriKRQxhV5?=
 =?us-ascii?Q?AtGO0+pIwJmbY/QL1dg5lYTcFvv/TYAx5P/7bCgwYfc9rt29Ea+MqGOnx6Nc?=
 =?us-ascii?Q?jm2pfFkm9OVklfVF5U2NqUcUg+ZQVzUrUAKnrW5Lj5hEzpFIBw2g5iS96qWt?=
 =?us-ascii?Q?ykcxiYzAu5qbajHKgBOEllwBFTWcMEx8cTerwoCAG7JaD1fX+u8P5KXuwm9c?=
 =?us-ascii?Q?lbiNS/YV+DIqTE3qQ8vURwVSaX7ySQqDTkHe9veEbloNt7CQhcFMYX16DPQE?=
 =?us-ascii?Q?+st55DaAdAev8R6QdLNHOLkrIQwBp+thnhElcz0vr47s8dTyvS9uII8Jjqyv?=
 =?us-ascii?Q?fko755tHOtJTryxT5dXKk31ZDx/ReGVnll2AQjorqOxjT7aMePV+3KoHV5ik?=
 =?us-ascii?Q?Ptmw7dQsbDf6S3gxyVC0wgwjeUF31S9u0oPQwARPihVGDAlp0nVk3+I9iEkY?=
 =?us-ascii?Q?zKUDCqXD3ZqMJGfLGBDh8D8SyM3RpNxEUgRM63AM/sdnKPnQIRAkot8LJyyL?=
 =?us-ascii?Q?yanwO9/fLFRCTlBUA2nVwcl8dK6m9Jew73C6YKabniHyVzJpBjfVzCWgb/ss?=
 =?us-ascii?Q?sonzveISA0ftSBOGCj8O4Lc9uRXWa8Cbj3MyAgzCwmOc6HA4PLZ1CYhrz1lI?=
 =?us-ascii?Q?AtaYNqU2bYnhLPPxyomp5AYxTgshjyZnivbetpOzemcbavrUjlwDXEAnFrhN?=
 =?us-ascii?Q?wPJFDVyG9KChLffau5cDc1gB5NLtWnDvPAQ8mMR5tVgAkP4YIm1AlMaFTYhY?=
 =?us-ascii?Q?odF9fPpC4H51+re8Vjn9mwClp7MJwG8mmxWybJh3pAQqzYLftHrRhyckncVG?=
 =?us-ascii?Q?yMst6SqNPLg8CfMpl5FapZBlDg7uJMvMMOSwaQG/8kWhUAtLL2QwBKKm9qI7?=
 =?us-ascii?Q?CTijoLJjCAKBCzH+aNQt5djQbPW0WCp5IbkAeS8BqoQ6lrUJM3O7gTjLAhib?=
 =?us-ascii?Q?qHHKSJTpT58AAsLXXxNnFwFmyQQd8XKGG/JQYh7COiQ9IvobQ7UCMyBN/4zI?=
 =?us-ascii?Q?K0czqVAqyNaSnftGWeEl/R4MiSBIGh/ZJ6/LCcX3d+hS5SMq+GYOYCA19HoW?=
 =?us-ascii?Q?8ud+WYdqRXfKot7ljMKqvx2Z8jUwWqPsFNSxFtWjK+vv32od8lsmqUH8EKQ2?=
 =?us-ascii?Q?S2oyFX8gIO3Cg87hoEo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24beedf2-c2f3-4dc9-643d-08dc4cd7fd08
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 14:29:32.6058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YUQp0KlyzSsfIYumLiIbMdqJmZMQCH6iMPbspqv4rxX///SrCQDwYbJXb/9iEJZjWVIqOR9Jk/qzCWRK/p+EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9146

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Damien Le Moal
> Sent: Monday, March 25, 2024 3:09 AM
> To: linux-pci@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>;
> Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>; linux-
> scsi@vger.kernel.org; Martin K . Petersen <martin.petersen@oracle.com>;
> Jaroslav Kysela <perex@perex.cz>; linux-sound@vger.kernel.org; Greg Kroah=
-
> Hartman <gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org; linux-
> serial@vger.kernel.org; Hans de Goede <hdegoede@redhat.com>; platform-
> driver-x86@vger.kernel.org; ntb@lists.linux.dev; Lee Jones <lee@kernel.or=
g>;
> David Airlie <airlied@gmail.com>; amd-gfx@lists.freedesktop.org; Jason
> Gunthorpe <jgg@ziepe.ca>; linux-rdma@vger.kernel.org; David S . Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 10/28] drm: amdgpu: Use PCI_IRQ_INTX
>
> Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
> macro.
>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Feel free to take it through whatever tree makes sense.  If you want me to =
pick it up, let me know.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 7e6d09730e6d..d18113017ee7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -279,7 +279,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>       adev->irq.msi_enabled =3D false;
>
>       if (!amdgpu_msi_ok(adev))
> -             flags =3D PCI_IRQ_LEGACY;
> +             flags =3D PCI_IRQ_INTX;
>       else
>               flags =3D PCI_IRQ_ALL_TYPES;
>
> --
> 2.44.0


