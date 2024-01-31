Return-Path: <linux-rdma+bounces-843-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F9A8448E8
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 21:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2C7B23A35
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 20:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEB43FE3D;
	Wed, 31 Jan 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XIn3jMBn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11022010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F3613BEA1;
	Wed, 31 Jan 2024 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732896; cv=fail; b=QPDcNeM9XHIr2MdYVCNk2v8lbi8ae65KCpLm4u/VgFrG1EwDv1qn/+vwY6Xr9+1tH7YxEqK+S15w97arTEvWeuw8T1P5qCzAFJjxYqG7xMY/QlAuJ6eCMQmTjQ3aU9qPq9Duc67enfQS3s/hgZKhAONC+2Igic5JrIQbky73iok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732896; c=relaxed/simple;
	bh=5fLjLmFGLUoUZeI3GQgP/mwpmIafg4cbH6izLtFY1M8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FIM+UyJ7UCPlKFOb3paK0O6jofg7+J5ipeE2SoCxPFh8nB1rwUDh4XCTqjDenzpN2SPuAD6bhvA6EPCSmDJOXpRQBeAkwitka+5mW2XMTNuPT43Pu+T2mGJOmSW2GnpCiGZLsl9U4nbi02eKDlHw8EfGIETCk0SRodoVDTe6LEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XIn3jMBn; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgB0wzkYmeZVLjRfJ/jzHkYPuwG3fNmDijWeh3w0KzIfqHi6zjWQlgvZhWWrI42gaIhFFt8iLCBXH7ebagiabbLXtf5i7Fgp3+s6pU/udlT7RlAKACCRjV7/YLe2XAF8xWoKR+UEWdK2alUo18jSYZ2CqC2/woW6qX7w+JCW8bDrRxLNqeVQIlIBA+dStBnYXSDP8EQwyF0DJKQpCZoqlyT4ky7saIJroymB4bFOj2SwTq2vXKGXHTlys8VwR112IFTet07NnS2HzLwuOON/3DVdl3N+FctWFaT9skHFTC2taZjRCwIOLLcw0GheiFs8xRzEO3p1eLfo+vP69cQ2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSO6+cX6OBSz/pYVz0Zgl8Bhw9OQ4UcTY/esOv6OAp4=;
 b=dWaqAQzcKt5vAFhvpwZhDF7ofa+T1TK10/t5a5Ztx1+GlFYvFsO2v3NsT7StbqvZWN4v+oHQEIbo7eySUEuDgTQcElZ9GR10QrBe9HJLAzfcjICwgBfOzTFQsvnfzfc/zsYMSOja6gfF4y7Hp1/iYglEujNx3JCKvN3AMbcIvu9YhxJi3dOqC70TQBFV4HUONTeI2jj1qauZ3vYtHJsRwR7jAG5ltDJ3lBvuzoVrb0A1cSER2M/NrfkVF8oGUZXrYmqauOgJzgJ13yrYMiWmnnrED3qpLUFraDk2pGWHCeUa8uoUCubh1ftikzRUKc45uqEOYRKnoMxjTP5IEwLvPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSO6+cX6OBSz/pYVz0Zgl8Bhw9OQ4UcTY/esOv6OAp4=;
 b=XIn3jMBnJdMWImo4L4jzz66jxAIDEsXXkwGX+dU0f8vCuG41aMWIzMLYxje05AXHuRKApHkleDnqNxFANULgxGU7q6gvj1Najgeb01d7ABq3KCFKLQladhsd/NbYLNc4N4Pew4i5JHJTz92D92xgUJY54fgr+8RDHn4vf3wnpis=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by MW4PR21MB1875.namprd21.prod.outlook.com (2603:10b6:303:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Wed, 31 Jan
 2024 20:28:08 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::38ce:7072:976c:bb15]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::38ce:7072:976c:bb15%3]) with mapi id 15.20.7270.007; Wed, 31 Jan 2024
 20:28:08 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v1 4/5] RDMA/mana_ib: Enable RoCE on port 1
Thread-Topic: [PATCH rdma-next v1 4/5] RDMA/mana_ib: Enable RoCE on port 1
Thread-Index: AQHaVDQUA/U/AGDmTk+xuIkzW24yqLD0XwKQ
Date: Wed, 31 Jan 2024 20:28:08 +0000
Message-ID:
 <PH7PR21MB326369CB38C5714D1294FE27CE7C2@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1706698552-25383-1-git-send-email-kotaranov@linux.microsoft.com>
 <1706698552-25383-5-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1706698552-25383-5-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=447472f6-7b77-48a6-9d46-53f657f92654;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-31T20:26:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|MW4PR21MB1875:EE_
x-ms-office365-filtering-correlation-id: 3baa0f96-f396-41b8-440e-08dc229b232b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 k5xN1LPTs+LI7Wh+19scb64nEpSUNIVZFlq0RHCAltISDGLlHGaYLUDszyAnW2yTOrRcpdQUhemZjfgixoEN4ffiQfyqsg4o+7p7Sl+WvX2EMuChMZJK6SHkwtZ0fb7lLx4enisM+XPdl+eN7k7XomJq1fbxuQyPZmsaPlr7nUff4YHuMTGO0s8Hp0Ymmg9uEX29RlcmIt88VVVVrLbFAfBhdKHIiarMuh1G0eKV72kccUBXw4ZJWGRLqCOxM4RogCbtZycuCm7B+ZFPA5vv7tTglecQkiTdPOavA7aSjMqNT3tIHZxtSzIFU7R1mfpQVpK9RuBng23bHAc6f63eX7DEbX/O6AR1S+lTY82II5LUO/B/ReWE1/99Cbht3OeWeAD2Zc1zl16zUO0HCOG65L8Dxk6N8voIphkQL+siuFRt3P/PDvKeF+uL/gGbBzpzf55BDD0ZdkJIRb+lJ5unDC2XeV7nzihOqTj6YnHdLk3u3G8JZ7HZuAjO5tZthvCi3iE6ZjqAYdWaKg0saQE78ue/3LrtcCFY8V8wUYBFPwpXjGXtZX3Etv9vcrmdmANOz0PuxhHIWLEsd1SiPDiWPxe5aHpqKel/TrWNpbeGe382jaLJ82HE45WcCMOkRdLO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(26005)(55016003)(38070700009)(8990500004)(10290500003)(478600001)(9686003)(6506007)(71200400001)(38100700002)(316002)(122000001)(83380400001)(7696005)(82960400001)(82950400001)(64756008)(54906003)(110136005)(86362001)(2906002)(5660300002)(33656002)(66946007)(66556008)(66446008)(76116006)(66476007)(52536014)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GXbCahkBJUBpD6bb0+vTdKw5sNR9jIzsOd1BoQMoke8fAMeOWoDE2oP6KkNo?=
 =?us-ascii?Q?C/Sd3EFi9N4hCzfX3i1TsNaS2TjehG0bbp2JUCmITWV10HKz2G9m7tTPFaGr?=
 =?us-ascii?Q?D5mWNnsfMSDetJ2XONvzLZtVBNm6G5zaZAt3fJrkYJiBbAnxNRPr25T1lAVi?=
 =?us-ascii?Q?ylBdMUha22U4q7DLPTN5p7EVIiVeV/7Ogwg5MP6n97OQRDkNf/JQxee7/5n9?=
 =?us-ascii?Q?edQo5WcQLz01ZNnrdE9SnmeAou3xb+80+slNxqUvdHZND/ZptZc8beBYewQ0?=
 =?us-ascii?Q?dJkfcbiiRy56uYVKp7+tGumvAFiKBcUuV9W6cdWGqnsr6KyaOv7P4TgxOz+j?=
 =?us-ascii?Q?H7hGSbJBr9icWjexwVK7I+wbpxeunRwiuOa7wR7E8X2CUmBhko+EFA7/QGYI?=
 =?us-ascii?Q?QQfQ9gDNGK82Blmz/UndIeHw8RyiShREt4Ov9BnxTXvHNKPLCsjF13sYMSYV?=
 =?us-ascii?Q?nFOxMA1UsFzA+fi9/dwLDGl6MWCxw9INgUEIGUpDgPPujSpDREN1NqWSizwy?=
 =?us-ascii?Q?qSpYzlRBJc9RECZiSrqanNglfuSJhR8slDJzbpYET6DlgJBM+FttLyAwhXd/?=
 =?us-ascii?Q?NAMNysedsAFGpEL3ssbUB0DubATfrFVq83a4PuL0uHy0ZXmuDV6cJnxjiRUC?=
 =?us-ascii?Q?rbZpySDfl8w0dQPkTdxY4uD5vHkwyuycCA39pEGI9/zoSQgTsQVOlZRKyTz+?=
 =?us-ascii?Q?X704K0lasQnKjA0wZpDofgMUVAgXtQDslvZ+NNcnW31ti0qePmS5i7yBEPcc?=
 =?us-ascii?Q?kW2teriRNcF3bX8uH1jhbj8+WAIQ1LKio4sIFwycigp6J/qpWzrqfqBsTSSX?=
 =?us-ascii?Q?HD6zBm8lNJ35kLPrRHKiO64SLEtnax2nhXgQahfrMKUo+qjmy3dlrXcTb/CJ?=
 =?us-ascii?Q?wnM1f58v4K44+8GHW2nUKiPT7nLimQ6GF+zYlqme39qAqez5OkDEaREG3CCf?=
 =?us-ascii?Q?4OS9nmsauDh91G3mskIRYa70vbEBZQph/QoT5ml2Tb8wPWLI2fj3GK/xZM9g?=
 =?us-ascii?Q?SvDB6Zynxig+sUs9FCYdPNjDdu3jVF9AqazAH1vih7VUZRMhl7j3leROdDqm?=
 =?us-ascii?Q?zu/D1PYuEx0qoGn0xGQTSy60eHwPLLxtmJ84r1thIO2lp67Mc+7A5YBSpiRB?=
 =?us-ascii?Q?KwAIwAH2QuyQBDizjRyzBq/gjZbxcq1B5VPybltlLyAg6mm5/mGee301KKvc?=
 =?us-ascii?Q?WDXaeWUg3Sn3yLkqMA/pp3VbdYS6E1ENBbowhyeleYoNHohc74RNcJBI0YF7?=
 =?us-ascii?Q?rVduBWkFCJNKRCslYdtR6B3atLz1b96l+X4fHu5es79ueDrm6wh3PvIrA/fA?=
 =?us-ascii?Q?A6pAxYMmdw+l0RiBqzh+l5dT5QfWxvxcE7SUzn9qcJsfEnYVvoOWaUjyLZ6g?=
 =?us-ascii?Q?h3XzJGIRk7ez13mIdcsnLhLxUiWCrseP15GL9X2w0yVT2K9bWXubaqGhvXRW?=
 =?us-ascii?Q?cQ1QeSw6U7IRK2BjySwgb5NdLOoQ6YSZ/2dDA6dvP84FqsjTMYOgztw2rYdZ?=
 =?us-ascii?Q?KFGKITehZalIXnOwTE5iUzN5LritW4fOYPry6V/fJyGKG/K6P7NuLDP/W8F5?=
 =?us-ascii?Q?5CJF+URJrZ4eOA82KPyj3ULTDfO7oCery7GWZg01?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3baa0f96-f396-41b8-440e-08dc229b232b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 20:28:08.4715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZWw7GEOpaaFf5nwlv+UPb2+HURRKpPQCOTnrImp0+LolqMP/miuEy+MvB9PDtULCFz1/6O56yErC5Ueh7w2aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1875

> Subject: [PATCH rdma-next v1 4/5] RDMA/mana_ib: Enable RoCE on port 1
>=20
> Set netdev and RoCEv2 flag to be used in GID population.
> mana_ib is auxiliary device, thus we need GIDs of the master netdev.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@linux.microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c | 14 ++++++++++++++
>  drivers/infiniband/hw/mana/main.c   | 16 ++++++++++++----
>  2 files changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index 11b0410..b9ff3fd 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -53,6 +53,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,=
  {
>  	struct mana_adev *madev =3D container_of(adev, struct mana_adev,
> adev);
>  	struct gdma_dev *mdev =3D madev->mdev;
> +	struct net_device *upper_ndev;
>  	struct mana_context *mc;
>  	struct mana_ib_dev *dev;
>  	int ret;
> @@ -79,6 +80,19 @@ static int mana_ib_probe(struct auxiliary_device *adev=
,
>  	dev->ib_dev.num_comp_vectors =3D 1;
>  	dev->ib_dev.dev.parent =3D mdev->gdma_context->dev;
>=20
> +	rcu_read_lock(); /* required to get upper dev */
> +	upper_ndev =3D netdev_master_upper_dev_get_rcu(mc->ports[0]);
> +	rcu_read_unlock();

Should call rcu_read_unlock() after upper_ndev is used and no longer needed=
, or it could be freed after someone calls rcu_synchronize().

> +	if (!upper_ndev) {
> +		ibdev_err(&dev->ib_dev, "Failed to get master netdev");
> +		goto free_ib_device;
> +	}
> +	ret =3D ib_device_set_netdev(&dev->ib_dev, upper_ndev, 1);
> +	if (ret) {
> +		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
> +		goto free_ib_device;
> +	}
> +
>  	ret =3D mana_gd_register_device(&mdev->gdma_context->mana_ib);
>  	if (ret) {
>  		ibdev_err(&dev->ib_dev, "Failed to register device, ret %d", diff -
> -git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/mai=
n.c
> index 3e05a62..645abf3 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -462,11 +462,19 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext,
> struct vm_area_struct *vma)  int mana_ib_get_port_immutable(struct ib_dev=
ice
> *ibdev, u32 port_num,
>  			       struct ib_port_immutable *immutable)  {
> -	/*
> -	 * This version only support RAW_PACKET
> -	 * other values need to be filled for other types
> -	 */
> +	struct mana_ib_dev *mdev =3D container_of(ibdev, struct mana_ib_dev,
> ib_dev);
> +	struct ib_port_attr attr;
> +	int err;
> +
> +	err =3D ib_query_port(ibdev, port_num, &attr);
> +	if (err)
> +		return err;
> +
> +	immutable->pkey_tbl_len =3D attr.pkey_tbl_len;
> +	immutable->gid_tbl_len =3D attr.gid_tbl_len;
>  	immutable->core_cap_flags =3D RDMA_CORE_PORT_RAW_PACKET;
> +	if (port_num =3D=3D 1 && rnic_is_enabled(mdev))
> +		immutable->core_cap_flags |=3D
> RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
>=20
>  	return 0;
>  }
> --
> 1.8.3.1


