Return-Path: <linux-rdma+bounces-11958-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBE5AFC73B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 11:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9701E3B11DF
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 09:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B187F256C8D;
	Tue,  8 Jul 2025 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PmdO6+GA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1CC262FCC
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967630; cv=fail; b=BjU7Y1ac7DnLZ+Fa2Jh6Bkkgll59fCew4bmJXi20C54yVm0bbpbadt/bKUlHpcR01wQex3eIDaVQuFTVrPOJdqWxUTdIlZszgOiCSGkGgnYSpkVPzL+UVJJ1wAjVRv5cvdzItkR3Q9AGA3Odr/0y9MQYObLRklzYgg3G3KvUgIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967630; c=relaxed/simple;
	bh=7wuSI6OyTErruxEtg28LYkSrCMoOSmSUn24biTys8HU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cJLpoiewlMWxxd7His6eeqTTtK1gylmTXWTAPygsF1L81HULxhOkInQXGCSVnMx6EGx2Yrl1PfzdYYVaGCBirLCoHqP/d7IynTvCUUyi4Y975n37i54YdXu+k1VRTcpQRn5qsjNgpSS6G74L6sraU0OJ2VmDjwWHJEH1zKLw4q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PmdO6+GA; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3Pqh26EnVDSNibbUDvUWdK1XG3eQf31sr8yZSSJXmF4GidjhoXeHlgQr2R1UinNh7qOj4l/0ehdhApaTcXfUD6SlzdtC7Ola4gBJCYE8sBhChl7Pek58BYb4NkLIThkRinZWUrCNXo3kAwweEDUZatbRr+sxHiD3TrZEes15ocx2gOq0cP9r10JRVq9tQhHcFSUbsUXlpopuQTFkt5J16QNVkUCAcQn+0rM5dRVDAL9lG9ssYify8j6ZDO2p0wjNsCiuBdgYDbz6a7BSMIV4uFS0yw9ra0SPZaeSOcrB6oAYtdFsgWWuUfbxM7zxmNihIbRxsYW9L90HycC9Kb72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEbGwatYRoVI6SJ5EKGgWalKhkNlTt7ELbf3qfO5Zhg=;
 b=AvDpG+mOPYMO6ksmZCkLmHneT1q617lkiKBnfPLntbCb643hBDDUWP18kIrPL88+r9oLutJnfsM+7pxotcTl9z44jDJwpahThTvaw1l0R/QRJm8lKkgv8jiE+iTJpknpCxRPsa9jiSPOTPtY97DzoYT5JXswEaTI43/o6Wwv8br7/pFT4HizdpIlD9El+OxKBK/59LwJ7PDfaHIrZUxo+K++Fz0j1X5AVTRYgm/54KkIes0cbkOKgqtGbDEPtX85vI2WNLTLSaYSoEGP0pjhDvc6/4KTaWqdzqQcMD10cz+Dz3nD7wIOiQWlYZxMT+tsf8yQL0Gf+cJEZEUsZm7kZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEbGwatYRoVI6SJ5EKGgWalKhkNlTt7ELbf3qfO5Zhg=;
 b=PmdO6+GAcVzaK1pnaGWIxLK8qzYT1ybIlLwd04tP6pZOmSzAz49edopAvGZ67egNWto9bA7+xDceXmXWB6kYieR+Xrddp/41rydqkPsDIewuHx3gNY1QA3Wg5wsSxYM5HhEnBzXUIOXzrwVUc/82G1L8/QgkHu3m86siL7DaDD/xjYeQJcoSGehe7HiGQZCC7GbC+yEu8Tvzh37LB90CeQX92y1POPXm/q1kPwweqouqHvowWfSMKQ/q1VKCkn8vEyptHMoaS0gwk8FrfM8vL2oyP0hojPpjaXpn09Gqi5gqt/DkS9A2dp5qA8l0PC/vMb6jSxKX80fXQUbgCa/yOw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 09:40:23 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8880.029; Tue, 8 Jul 2025
 09:40:23 +0000
From: Parav Pandit <parav@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Leon Romanovsky <leonro@nvidia.com>, kernel test robot <lkp@intel.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/uverbs: Add empty
 rdma_uattrs_has_raw_cap() declaration
Thread-Topic: [PATCH rdma-next] RDMA/uverbs: Add empty
 rdma_uattrs_has_raw_cap() declaration
Thread-Index: AQHb7+sjl6Ku2+rZm0Skfd+fRo95KLQn9s8w
Date: Tue, 8 Jul 2025 09:40:23 +0000
Message-ID:
 <CY8PR12MB71952963687B23913A4ABE38DC4EA@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <72dee6b379bd709255a5d8e8010b576d50e47170.1751967071.git.leon@kernel.org>
In-Reply-To:
 <72dee6b379bd709255a5d8e8010b576d50e47170.1751967071.git.leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH8PR12MB6818:EE_
x-ms-office365-filtering-correlation-id: ac32be21-7d18-4989-071f-08ddbe03761d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?V0JjHyIoDNALQDjBm0kmZ+dn9bqbH5YvJBbc/yihHV3D7UEZ/TWP8s6lFAh8?=
 =?us-ascii?Q?0zQAIojGpmA5/RmiGCRmsjXErreFkAjLChHNllzw6tbkMXE+3pPmb73yDjZN?=
 =?us-ascii?Q?vXPPKRkeUrTrfkPcKHEyZTCgGtQIfqQlzlV0WReA+o/bTTX3OgVmepL/RAy2?=
 =?us-ascii?Q?r2LjWKYXwrJ+yFVsIJjTFEDy6MXoK4DrQy/UMeJq2Yt+xRdGbc6xybdMmbLg?=
 =?us-ascii?Q?6PH/fi4feB8bJDhBxaK1LX1TPr7QK9lqXg2g5gaQseAj8fvddEgDPYBUFk/6?=
 =?us-ascii?Q?ixa+zfqg6YQgt1/H2/cx4VNI8uwamd7s2sAH+NGaHtq/VlK8dhO2ud7h5y28?=
 =?us-ascii?Q?iBGzzIqDIsjyWthEAZhlq+zd5A/hKa7XaP3QgeKJ+hHW1ZVrDeD8QGDSwvKe?=
 =?us-ascii?Q?l5eDP65E7pwcw3UV1h1T7Gj6dRIcIt8kesBfv/glCF1/ypjP5VtOMiCUydxA?=
 =?us-ascii?Q?EGUxrH/P/okajve4b1VJ3BRV1u8iTe01+NtwqF+okLC6OngURqOR/U6xesGF?=
 =?us-ascii?Q?SaZ8fVq8bRIyY2g+VoSagKCozrz6sO8ObmD/gBrUy+PdZv9ftCM31JR16kGT?=
 =?us-ascii?Q?/mpmBXGgzwHvoyxLCv9Efza/bjOqFsB/B63nMzCA6rO2SrM7bqwkd/nxZOTn?=
 =?us-ascii?Q?eZ62k2o0mHraK85IRXZA+8NmbkPf8Yeks9wALE2vX7NUG5wHV0cl/nL7yXlL?=
 =?us-ascii?Q?CF+VTiPJL5QzHgD4numKe5XzQmPbmMDBGcSnAOK2y97naokdm90oC4aVNTGd?=
 =?us-ascii?Q?8vdTzSaa/OkqH3DBgns39nZyqZs2iXSurJJ5XRDcfni0/OBfBOEQ31CTSbNP?=
 =?us-ascii?Q?hjGNd0F2gTnDx9HbgYPAbBOHLvMuLzfza8NQXTvMyKWs7bVj2lUrAoKE4UPr?=
 =?us-ascii?Q?gjJ1B+HMCnIkmJ+6DkqiJYy25KUEKdNxYX1LZH7WABLvRVFaJk8Jyo4PUpgV?=
 =?us-ascii?Q?wQxUq2vemTwMP/XTyPKDFz27mUXCikoLQobWwQP1Y0PcsR7uBQQ6bXneSTj4?=
 =?us-ascii?Q?/QTtKhhlPWo8A8acsU1msgYCuXTOfEIhn9qBAHwTuIvIoUbwcTHOz2W5YZ2a?=
 =?us-ascii?Q?JYcaLSJd8UfXRhzG93FH70BJuurbsDrnwkNrixFIP1ntynkpK2TTjWQhB6zf?=
 =?us-ascii?Q?ktnnU3v6bbAr2Gur+dzmijkeOdIIRWgfFm4wnVIOyqeYVovKY4J14dn0BFdz?=
 =?us-ascii?Q?z8dAqVnJO/ibO0AISRmbnLxlpDFhhcP1GYXe3EimmLDb+DY9IX08y0Bj23Le?=
 =?us-ascii?Q?j2jAXDhpdKLmFuM22vSXJY6BcdnebaYtpQpfjJ4fkgjsmglwI3t+zwc8Vv7u?=
 =?us-ascii?Q?eguzBzj+pNdMXiVyc0hqvvHkKVQKZn4PM8BFq9Ra38V7xy8wIlSw1D+6Np+z?=
 =?us-ascii?Q?rz9eHpVw/WFzPj8OguU6Srlri/+N7QpcLuM/PplJ1Z2PyDDyrioIlH2+m8hA?=
 =?us-ascii?Q?ICY0IlRrpU4nOCZFBFzISpg9/g8k7WN+f6g+SCco775fy1PScdS26rH3rO6d?=
 =?us-ascii?Q?mQcuG8qNXtqpnM4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q/E8OOquolX4EggdwfdLeW5bdaHJ2rP0iuU5xIDHZKeQb4jp1mKpQAa76DND?=
 =?us-ascii?Q?CoQsir1l0N6BhSuD4J6WRgjO0Lr+1BtQY8X+gQ4wxLld3fkqfwzxD85Mn6Ld?=
 =?us-ascii?Q?n/lhPPMLQG+k4XH4R8mcFk5wwfiK324lXAfT+b7gihvTgtb6TjchhPGGZdSY?=
 =?us-ascii?Q?y6PT0w1ohguBkBXhlhdswn7TscyBlRCGDl9jjy/FxekYTihnK4PvBcwHGyw9?=
 =?us-ascii?Q?Kp02XfiRSUNsP8y0MworguqViyx5f8aowoq1GZKdRx7AASGqUaj0xzBbJHE6?=
 =?us-ascii?Q?91UFkG0RIqG35LrzPtZqzcA+N86EUi6or7PWniUL0c6w0iV9u0Z1aY081HPa?=
 =?us-ascii?Q?BwWDWqTG/pQpmJ2ZKacLf/uo5oHdhOpu8IDaVrrSqtlir2z977opPyRNtTfY?=
 =?us-ascii?Q?OL3bUUgbIGyhdp3IJNyR9Yw3OP2EqU76RcUkdv+jH7kortp5iQxwQlsrZsQj?=
 =?us-ascii?Q?CeG6KsfG8cLqMMQPiq9SWHZFb7CaJ6UKJ3f88NqAVZz3ZOVoDSSyVoAE8pnP?=
 =?us-ascii?Q?sB46G3A9ysrySkgEIHvm2aGp9ED2b/xr43muxycyapcVvisbGXkFhNMmafHB?=
 =?us-ascii?Q?00K7kG0ikQF1C/oggj/4ibT1/+gbtEkB9CMFRnrp4lpD4Qzexl7zYgxd+wTq?=
 =?us-ascii?Q?Z0dPWQjHtd+z8kBXJGMJL66OHEbTu+GuiuSToNLBm+Nb9wOPxnoA254pQc7w?=
 =?us-ascii?Q?SBYP1tWJg3ht1OgCu6WXFvMmUKwEJpHBfWfddnUdGEZ0yPQPbLWEmQ405GVE?=
 =?us-ascii?Q?r8uefuKCzSqS61JCoLiZiqjzecuOdroKXzCC5+rr2uNz2IZYH84jlRzKbp4/?=
 =?us-ascii?Q?pwkeV3ArUE7hRPhEONolh5gIq5f0MH1ZxJtgwpIcnvB2T1LT+KV9lzQIUzIk?=
 =?us-ascii?Q?n8j3kHt1q8NwZAs3ufnyMLp3cgQozA84QXBrTdN687VtZv5Znb4NNhM7XGHb?=
 =?us-ascii?Q?IwMA4jdWJ2Xtev/IYImdY6z3H7eyeu4uNL4OfsIYSxvyVGTle3T7NyJnbF8p?=
 =?us-ascii?Q?yIEo4/jAtZCVMc3QtjOPODFMEGWd4Nnzg1ie+8t6OfB4J+dW0gXrE5dEbwIn?=
 =?us-ascii?Q?tjfDpfN7w6xkpp9OHGE3mF3LWlusD51R/ZkRg/av/x2jpC0HoirYgNxR3f33?=
 =?us-ascii?Q?kfymkPKiHMIdFagWgdPgISmlAnv+07ozczOhucZN2g8eryYcajQRd8P7opS2?=
 =?us-ascii?Q?rekEywmrWfgUL5LjPI7Oez9rpBQuhR0polUkgcDIFndHRXoAJhTuGDj3hmvL?=
 =?us-ascii?Q?SfJvuV3b5bgYyTFyBupF1m3K9fCrSuCXFMgcgObhSZCuxikAgXeu5THg9OJt?=
 =?us-ascii?Q?+GecLhhXkPuY3VimygXP16PCRb53vOkYo7LGGOPOf+7CoJrV12vCga6s9mDO?=
 =?us-ascii?Q?rdppJky6whFljcsv3ATUymbq8SJs5gjzw0VIwRyrhX0qZvlK0X8yT7h707KH?=
 =?us-ascii?Q?ddfXSwEY456aZgCMk2JrhPqQsDcMx+SDlcIwX+at/2NbyQSw2YB0khXvwYwh?=
 =?us-ascii?Q?5cLsCEb03FJcX0eCyxPeYjJCKkG6p6Vq5dsseurTxoBVCCYzS8emtld2yTrV?=
 =?us-ascii?Q?R9mauPG9wXXRSNE/e/c=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac32be21-7d18-4989-071f-08ddbe03761d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 09:40:23.2224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1784WrlA4OmhKablLByjEuyS3vvA5d/b20b9D9toLHeEIZwynIpBqs9q/AgWuoqXQOV/rFloM2zVTvHqipDgMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818



> From: Leon Romanovsky <leon@kernel.org>
> Sent: 08 July 2025 03:02 PM
> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> The call to rdma_uattrs_has_raw_cap() is placed in mlx5 fs.c file, which =
is
> compiled without relation to CONFIG_INFINIBAND_USER_ACCESS.
>=20
> Despite the check is used only in flows with
> CONFIG_INFINIBAND_USER_ACCESS=3Dy|m,
> the compilers generate the following error for
> CONFIG_INFINIBAND_USER_ACCESS=3Dn builds.
>
=20
> >> ERROR: modpost: "rdma_uattrs_has_raw_cap"
> [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
>=20
> Fixes: f458ccd2aa2c ("RDMA/uverbs: Check CAP_NET_RAW in user namespace
> for flow create")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507080725.bh7xrhpg-
> lkp@intel.com/
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/rdma/ib_verbs.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h index
> c263327a0205..ce4180c4db14 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -4841,15 +4841,19 @@ struct ib_ucontext
> *ib_uverbs_get_ucontext_file(struct ib_uverbs_file *ufile);
>=20
>  #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
>  int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs);
> +bool rdma_uattrs_has_raw_cap(const struct uverbs_attr_bundle *attrs);
>  #else
>  static inline int uverbs_destroy_def_handler(struct uverbs_attr_bundle *=
attrs)
> {
>  	return 0;
>  }
> +static inline bool
> +rdma_uattrs_has_raw_cap(const struct uverbs_attr_bundle *attrs) {
> +	return false;
> +}
>  #endif
>=20
> -bool rdma_uattrs_has_raw_cap(const struct uverbs_attr_bundle *attrs);
> -
>  struct net_device *rdma_alloc_netdev(struct ib_device *device, u32
> port_num,
>  				     enum rdma_netdev_t type, const char
> *name,
>  				     unsigned char name_assign_type,
> --
> 2.50.0

Reviewed-by: Parav Pandit <parav@nvidia.com>

