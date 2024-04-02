Return-Path: <linux-rdma+bounces-1741-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3216895851
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 17:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABFA28476D
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3416C131751;
	Tue,  2 Apr 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQID7hbB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2098.outbound.protection.outlook.com [40.107.220.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA1E12F398;
	Tue,  2 Apr 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072209; cv=fail; b=EAkvaNi7rPN6vRiMNF9U5f3eNUqu0jbWGPTzfthYSr1f13nawWxMKCKsq3vJz/dGA40yUJrkb18b78s1wvs/k3eQKTN2NQ8vSRlk8tFGDVB6u5XF2IQEHb9Lxzc+kTTGlVtW4bE8ouoK4B6prakkHPL3d6VGQslNuPlPAgLUfbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072209; c=relaxed/simple;
	bh=4ypgjYeaqKlgyLTmqWWM9EG7t0PfVuGuWWdYVIqdkQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sh1gdl1T8pnVi2NKYZ6Bs/9ejZhnJdqCvKFKUDaV9KOQeHyOOp40i05Ak0VkdxDls7bFX9VnVYTjRotm7DCH6AHgdSgFC9z9m0ybPS1QEr27oXxNgGQHAkZg08gR5ZzuQtcnzLOlHPYCaiRfEwdTfU5YhTdJG/YnZxoGKI+DJvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pQID7hbB; arc=fail smtp.client-ip=40.107.220.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLSohzt6a4zziAg8DC5PhLjq+m3ILzCo0sFOYB7V+6HBHNdvaftgtYJGSXiAPBgfH3sCvruvxfSNF8xi22pz7VGV7rTYjRzTOPr6yQGixA+C/ayHDwmmZ8nPJToRd+n46m37bNl2x+Ky7mEgoUtd0VSdTjciMlIfcFf+l5+e7JuOHK6N9dez3kmtQCc1sVZmeYF0JfsZP+rz9RrqUSv42GXSmOUkoHpKV/LqhEkMSi7LtkLBmh35dRzGFERG4apYVAcFBoWJZummKIZjShZ0OHq4vad19XduTln1TcpxN1xPC/L5Qv8LWm/sjfxTk99cgk+fVWUIwBI15Xw+ZXNiOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpPux0DCH9Ya9EpcwkT8zCwo1hWaV4ylTYFmQpYQZ+0=;
 b=lj7YOvWmkaVoSv3Wwsj2tao+hAK6LQ3bSh8jvbTSGuWiDC7D0ffFbB6/KowtH7adGUNuZ0YI2rSqhveBmG2ScPvPUrcdgyZO09j/b7L8fZ08zP/u9esYBq/AhFYHqvvfPGvLwg8BPYMAHJXndZQ8JxSoZlMzEfDNMaBMVY22/lTbNvZaBApzlBVfxiavgt+h5N6bM73986wj28TvTEm1374/LavYKOwizFH9o8Eu7XzXJM7A9KFVJmQueOb8hO1hmFS/YEBSP7dMjFNhp9p+D/VFOw0hLOHJJUJZZ3XB7w5IDOzKFtW0koIMCDIf7PU4x/vJKIVjiBwX0O3wxJ0Faw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpPux0DCH9Ya9EpcwkT8zCwo1hWaV4ylTYFmQpYQZ+0=;
 b=pQID7hbB5NN05D7y9J4PKvxM8rbmzDBdlVypZTSGJggvuJTYQH+t2gGgSaYvfkYsB1ONWZf2Wm8jgdgshwUFi0Or0ixf3wmiTG2ZVXrN1OUMGvngQbFuWYwMCrRGK50axe2QU24pNT0VTGAUImkYlB0NbS1OkBeAMzQMhoIidoMSISLCDz2LOAHrFKC7Oq4zftzfZpwDnvEuSV2QrZRW52vxtCYyDk6vcJ9rGjuMJ88WbEOLeU1jiw3GY1nDn8zn0bI6cRmhpVxG8DCItq1f2KNfckbrEjZXBkULCOHQIy17MOtd9HAGgYdjEo5LB3iHLNW/t8Q+T4F00mX9tom5AA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 15:36:44 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::6894:584f:c71c:9363]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::6894:584f:c71c:9363%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 15:36:43 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>,
	Saeed Mahameed <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, Shay Drori <shayd@nvidia.com>, Dan
 Jurgens <danielj@nvidia.com>, Dima Chumak <dchumak@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Jiri Pirko
	<jiri@nvidia.com>
Subject: RE: [net-next v2 2/2] mlx5/core: Support max_io_eqs for a function
Thread-Topic: [net-next v2 2/2] mlx5/core: Support max_io_eqs for a function
Thread-Index: AQHahPCX9QoVgw5Bm0KG4UvmfwZK6rFVGC8AgAAD+IA=
Date: Tue, 2 Apr 2024 15:36:43 +0000
Message-ID:
 <PH0PR12MB548193D80A83300A72FA7170DC3E2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240402112549.598596-1-parav@nvidia.com>
	<20240402112549.598596-3-parav@nvidia.com>
 <20240402081836.30912d2c@kernel.org>
In-Reply-To: <20240402081836.30912d2c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5772:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pspxQK7tf8h6FRk7WAdZKMem2b8D3yBwoRTxf1zukwuBzGXmruD386+LcvfOuc+HDW6o2BVJNWy6AcfI1Tkqo2O92XbIY5I3eyMfXAFPJTmgCyp4zqdZabq9qqeZF/WYPQ6cSCP/9ShCP+Hb0mWT2tsulMlz3wD0k4NiLvT1K77fEGiuJ4HKWN3y73LW/dOwm29omUMqRzchlgyuvN1+xJap9GWQNS7CKMN6GExgCHL4O4TL6J4vq/JTCFVHQ7uKDJLaplXZyxuRNatDpJ1jNua4vXPTuPaBUbuBaqwVK1jmI1G/HbIfXiYm/w2i8cUx3+o+HB8GIDRSj1pf7OyCgknzOCq8XbaAK6DEG8XtaXPA6M1UyyAEGv/PgPPGtK5PId87fGKgqiEk3V0DepJ/UnIAoTrKVYaVTF2rEXfYny8t+dDc1auRaw718re8n2zrthnTtID+cx8Cd0889AQ8LPUDha6vL+LU4qCcx0g5QbEal2DYt6Ir1sJ95Ly4hEgbBbdwKHRFTuxEiN57sZdvo+f6x7H5tlG6qCMwFmZkhyTt7STd3FoTLMEufWb3awL0by0kQaXG4D6yuRSZl+5FE/eN1QFTFAspV4uRGgxdlT5eLrmGfjAI1dc9NuJqwZaXY7Jki9hNxxFKJ+YWOOZwAgF5c/k0uG539Q4YLzAODOQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8HB09lsjjBuHgfDT05kgHpAEg44Buof5KUNtKDXv2LfjUKh/D686MWdV1pjX?=
 =?us-ascii?Q?PVQa1gdPjPT+3NKkfqHjt4sr0HEBq3nMcS8CTcUvOhtzwljyz7H4zSBfsfOi?=
 =?us-ascii?Q?X8M0FxWYDlNVZmzgocpmLq3YQCgFtHQHdTa0szYgLkIO8q+xDYBgMDstHXuw?=
 =?us-ascii?Q?XJIQdCJ0/y3CwYCLdNt8DCCRtrhi0Ogq+S7SYqM03I665yriXvsyu2/+yyxR?=
 =?us-ascii?Q?m+u83YW3xjej0jtdX7Braom8F0bmbmBQTWutIOkpL1iZ4zULcWqh1OGsyj9W?=
 =?us-ascii?Q?p2YZ3evFAvRXwm9WL39wVWnKwxZYqsLMHDmsRK0lY951ljjCA8VrVGcSs7ij?=
 =?us-ascii?Q?05oKE9qxHlKsSJyQbxde8/kqkdxNhsxTA8EcAJBiBBoLWW0rbZ8CqUJKJC93?=
 =?us-ascii?Q?BxPkKmnr5vwTRiWBQdjEaiQqWnJvs9npyCUXmP97wMR+sjjYoqCrsw83br5B?=
 =?us-ascii?Q?IEeRnZRj22ZE7sgHfzcDJX43cvYFOSKD36L8qtKeglHWNs2kBSV6m+8Eed5e?=
 =?us-ascii?Q?lK2U3ltxcAlVLJbNKio1ITl4ShjSvtUDBReGg0zSOsA8f2d9iiKe2K2pAfO5?=
 =?us-ascii?Q?aVDTLmqQVAXG/s0L3nuVvKJvSZdxjvivcjTjhWw2mE2shYbno3GXQMQ4Zrk4?=
 =?us-ascii?Q?HIEeZfOF78iFFhR6qIrZlSQ8dgNGagYKKIuhfO2l6r5gzGqC2z/8+DwfwY8Y?=
 =?us-ascii?Q?FLUuxTdcf6Tcvmjopq8dS/eu4ZUDxg2KkPs0CsU8qjNqRRrzAULYv3ggQG5p?=
 =?us-ascii?Q?gVDr32uZoapODVIi21qfsCa3wSQEXaOtB89zyt10mFNcR07vpDesZZbMidqz?=
 =?us-ascii?Q?i2GI/ymZpZlSOzM1mMC1D7Myo86WEeS90ttZOf0eTGUYOeQQZdXHO8GPc+yZ?=
 =?us-ascii?Q?5tMptuVX6m8r9MugigVBdQopwHKu5hbXNy7vhon1+RCbIIrv7a/tPP3DTM6r?=
 =?us-ascii?Q?PKAwwgFoV6LpKb+bhsUzma4IWIoAM6wEhfaf8R5yX5siJCgLVODg0+I0prIX?=
 =?us-ascii?Q?3OWtCdB/Hn6AUC+QM8IUAKEXGwPEgbhmyfu/3H8gPmyAczuYVw8eoiUrEasw?=
 =?us-ascii?Q?jXN2hjRckDxmpvZWU3UZqYHCHDnFz1bs5zuOu4tSXT1hSUM4oEdjUvxx2+TU?=
 =?us-ascii?Q?18j67t6oPeQ2hK5gOPLt0zJSM9RWJ8XL6SwGfylNRQLcukDFce8avfddvDBL?=
 =?us-ascii?Q?J/Qx46CJz8jNDXg3nxRFukiipSH2QPF9o+8Z3lqcYGX/4U7991U68/pgcGyf?=
 =?us-ascii?Q?BmXp2ryxOiCqT2LB/g5jtpGKNErMRZML526mz8Ao86sUmzTNO5CDIJqRsuse?=
 =?us-ascii?Q?qvzoou4wjzRpKtaLOOFHb9U7z9mFV3oM6hN/utZLo3LOnrYktLTLYA4hzPTy?=
 =?us-ascii?Q?fGc5NyUHrfQzMt+7gH0MQ6sFe+pIOIt7xNDSyk5LkxAvSEiHhkFHc7J76Vyu?=
 =?us-ascii?Q?D7ri+PxKbailncDXzqpKQyOEhp71mLdBO5UWeThsR/CYqrzycfUODKWeFNRU?=
 =?us-ascii?Q?iz2mX2vZh7uGzrHgH5U7t6bLJsvjLK0ZdCp8oXH9YfDBNYHzFsaSuQcJEe8A?=
 =?us-ascii?Q?72qQ88N/BxHJXvrTRPxIWioT0GjSrz5So/BcdWTSXcFSH8dLj12tPSC3R0MI?=
 =?us-ascii?Q?VHrGfGqws+pddZEbFy9vWnZKmCm5rPFUAJajmD4b36bP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42794bd0-63ab-481f-f01a-08dc532ab2f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 15:36:43.5825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0qZRJ2UW9uIL9Qgr/saqW8FKBICGFA4I4ctub4308erLD1Wn+fCjZG9iqIhrQGfLcgRryvuOfObfFoEHpF8UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772


> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, April 2, 2024 8:49 PM
>=20
> On Tue, 2 Apr 2024 14:25:49 +0300 Parav Pandit wrote:
> > +	query_ctx =3D kzalloc(query_out_sz, GFP_KERNEL);
> > +	if (!query_ctx)
> > +		return -ENOMEM;
> > +
> > +	mutex_lock(&esw->state_lock);
> > +	err =3D mlx5_vport_get_other_func_cap(esw->dev, vport_num,
> query_ctx,
> > +					    MLX5_CAP_GENERAL);
> > +	if (err) {
> > +		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
> > +		goto out;
>=20
> missing unlock
>=20
> And before someone suggests we need guards, even make coccicheck
> catches this...
>
I am sorry about it.
I didn't wait for the coccicheck to finish in internal build.
Fixing it.
=20
> > +	}
> > +
> > +	hca_caps =3D MLX5_ADDR_OF(query_hca_cap_out, query_ctx,
> capability);
> > +	MLX5_SET(cmd_hca_cap, hca_caps, max_num_eqs, max_eqs);
> > +
> > +	err =3D mlx5_vport_set_other_func_cap(esw->dev, hca_caps,
> vport_num,
> > +
> MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE);
> > +	mutex_unlock(&esw->state_lock);
> > +	if (err)
> > +		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA caps");
> > +
> > +out:
> > +	kfree(query_ctx);
> > +	return err;
> --
> pw-bot: cr

