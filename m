Return-Path: <linux-rdma+bounces-4651-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BF396544A
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 02:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08B3286979
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 00:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B064C7C;
	Fri, 30 Aug 2024 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jGMaEYdZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020083.outbound.protection.outlook.com [52.101.61.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A716523B1;
	Fri, 30 Aug 2024 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724979364; cv=fail; b=Wjy7iHFXx5q2eMq2PBvVBm1riArnBS44yFxS96pH59BgMoaZ1CHgZthS/g6exeQkx8/tPc/G1F/akbR51Cm/VuiqjVlmM/4nMjWERhNiFC/q4TeE5Etn/S6AYA663voWN0zMmK02ypdQwlNdCDbmvD9SUIJR1as2xlvXrhuyXfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724979364; c=relaxed/simple;
	bh=KPe5k49IpDQ1srCGTbAq6TOvkphe4G8E4eDyi0jJScY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gbxJCpFe2dPgaOloTgQ0Ub+IWEF75dKA65wA1wKllZcloF84udvGGtPlBdCimN7TmDwvMEQla/fiDQUMGikCv4TMbszgy7UWwWLqZ01tgGgOYIuN50I9LX9dBvHceJDltktBZyvTok70iERexkblQTumK7geFEASZ90piY0LBiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jGMaEYdZ; arc=fail smtp.client-ip=52.101.61.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6qB059fKxJ6bf5VT7KZcoIH8GQeaWyInAi8VEZyVC7Kab8EgpZyedr/5YglxwDa0SCQ90gfFa3qV1aw9a/sqHsfA1eeprlBiXLVrI2U63x8TLpX2bx2Uv9Rybh0SMN1Kf3u+trhaT3JEoHyYOpfasA5b5FCiJTcdWS5tViUp2Mp57V4H3enqxtKMb7a3oU5IEo9rK+vTid0RBJEanRpkseEk0jEFtGsh1GmUmMNa5JbYNBdeVOShShzzUiKquwU0sj+IEyAsg2uAeTnlODBoGZcVQFQcDNe7lTmCFR9VV9sw6fqK/wQ9Cr2u0Jjy6pBcAVh5ZmaR7fnkOjNs7QVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBqKo5YfVSlwYb1uizzFvsyRb5yWBphon7Ap4c1Kmx4=;
 b=vPiCZqJePfyXKdd7LoF0fcVXE138DYDINGSVUCgqaOBkyQYMVnHJPgnufsZKjJ7X82wqwhLG/vHXjqedWyg66y5uxRBGvu5jhZSYZt5oki9c8pVHIPwZ5UxqIU5dN9p35XC+mC9WRi4T3wHU36k2d/N2PTYPNCf3dWQw1wOXZ0g+NEgpWnkyvw89k1msdtV72+OUQT95AvjirKAYVRsiLO4myNBblo2FyK8xlY9wwCSthWrfGQ7F67Cpnwt10vqzBr11kx3S3ZuiVCtFNB7qtbsOapHCz6adNwxPl/lG8rbMCmoCyCmUr5O3y4yfGEv4Bw9J1HUdP9NwahPMgA9fKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBqKo5YfVSlwYb1uizzFvsyRb5yWBphon7Ap4c1Kmx4=;
 b=jGMaEYdZPy3qXB3Bu5URzUfEZVryLkjnxPnS2AiRkR0cwFFp3nMoX5Elt5hLrzZteMoqah5ARUQICpUzW6oW0bWMr7GsaQR1KXlCS/z7xDKvPBgxYNaOpeoNVIIsq4PWhu8G+RhvHVpdvOsKo3r2r1vaTXIwzU5L1apmwMfyXqo=
Received: from PH0PR21MB4456.namprd21.prod.outlook.com (2603:10b6:510:337::12)
 by DM4PR21MB3368.namprd21.prod.outlook.com (2603:10b6:8:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Fri, 30 Aug
 2024 00:56:00 +0000
Received: from PH0PR21MB4456.namprd21.prod.outlook.com
 ([fe80::3a57:1b5a:a61f:eb1c]) by PH0PR21MB4456.namprd21.prod.outlook.com
 ([fe80::3a57:1b5a:a61f:eb1c%5]) with mapi id 15.20.7918.006; Fri, 30 Aug 2024
 00:56:00 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net] RDMA/mana_ib: fix a bug in calculating the wrong page
 table index when 64kb page table is used
Thread-Topic: [PATCH net] RDMA/mana_ib: fix a bug in calculating the wrong
 page table index when 64kb page table is used
Thread-Index: AQHa+YW+jEBcl2YhlU6Y+/k8GJJIwrI+CDKAgADzUpA=
Date: Fri, 30 Aug 2024 00:56:00 +0000
Message-ID:
 <PH0PR21MB4456DD41CA093EF33E29CB5BCE972@PH0PR21MB4456.namprd21.prod.outlook.com>
References: <1724875569-12912-1-git-send-email-longli@linuxonhyperv.com>
 <20240829102425.GD26654@unreal>
In-Reply-To: <20240829102425.GD26654@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f8e1e633-73b1-4493-89e4-f6b35196e592;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-30T00:55:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR21MB4456:EE_|DM4PR21MB3368:EE_
x-ms-office365-filtering-correlation-id: 8b235e2f-b6d6-40d7-ad1c-08dcc88e83cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eL9I/S/34uKP1xFeVPyDhsXmvwEomDACMTTALTErTUCdfMtNmOYnsigZ3jfA?=
 =?us-ascii?Q?7g6SvIUfaNemYzEn6/+9fr4J7Gu9/qVDi3BWHOVY24nYT09rb0sljBoC/zv7?=
 =?us-ascii?Q?oCjuTxkkCQlLMzlBQW/lxWSUmCl8v9OkirHUV+BqCVtqipTYyNzZahQaBrjK?=
 =?us-ascii?Q?YO423oDIfiUWtyLP1UOD4Fx9Qm9y7gcRwwWHeoE8VoHzbuPw5sRPqgZpzj8x?=
 =?us-ascii?Q?A4gSC1/DDyCoqUUZIgacbHyClkDNXwjqNL0czRP8kO5DocbDroNquBS3wIwQ?=
 =?us-ascii?Q?MjuZ11iT702GiUuKlaAckI9ywQX7ednjawCIyGmfS2mIYzgFM8+A62T1g9Bq?=
 =?us-ascii?Q?0ESfrBY+Dt5g+mBtil9E4OfTrue0DncSyc3RIMbkzS+gJ+I4cCKVQ4DZyrUK?=
 =?us-ascii?Q?myDl7JyC0ONVdo/1OF+bkVbjtuSUDldPxYXu/xfn2gtuDzf9erCLd/985ufF?=
 =?us-ascii?Q?bbuoQbkUXzXFh5LXBqvHajkkH7fexsonfM56sjAjARUFCneqrKj6KkHO33p6?=
 =?us-ascii?Q?uV3fdHtl/YqGIcvMolW3hG9oClbaZNSSyp5EJUbPTm3IS5K7SOLnxfFIfkyX?=
 =?us-ascii?Q?Y9VeAjIuKv/lSkZCCgm2zZwPo7wChlF04CIQK5mSPE7EewBO88RY1gVRRrpo?=
 =?us-ascii?Q?2vYdVC9PkLlHOr1kPQVDdPPSnL83Ijc+2BLfJcJFrunNn+gr1d1VVWStKvh4?=
 =?us-ascii?Q?v0OxgbD9jPF5CsEYIv/JpzifVc0ZeRF2Nj1ciCNLbzz8MBO4XhvmEeYR6Hyo?=
 =?us-ascii?Q?vo6kQtW9e2BkUKwNPaw6r0ZJXVZqkdSBnbQNwAAVxlN5VPeZTHBAIYA1zN4t?=
 =?us-ascii?Q?L2Llt/B+usMWYxO94cGGCPLQ0SG2i9UfNJsuM69YFkeDarQWkEnf8EABG3uM?=
 =?us-ascii?Q?VCdQf2IN6j3BOh/RxJCy7qM97l744159JlVDo9j4IyuvEdjS5zONkaRkpvcm?=
 =?us-ascii?Q?tgFLaETb8iIjrbsnsD7tSxkcqMIhkoTjBJTcPA+QDbBYLXQG09zshdGQHW44?=
 =?us-ascii?Q?2c8baXkuTvzraHyncVDRUomSmbArvbmpk8cMnnDrOGA/Dm0s3cI7gC8xV4c/?=
 =?us-ascii?Q?xBD6nJ/CR0IDKHMNhq1YO41PuvSKZOGiED8rbRGXydllJgm4eu1pW+LtfsyH?=
 =?us-ascii?Q?61OOk60KrIut+SE7Cuqc1QKsn+KxkTwO8lqDM2BPqBifS46RERipC/gFtGWR?=
 =?us-ascii?Q?I0KTWf5x2gYnHBL94sNXeia2J0NTQ0EYaxEhugkfLFzjXLVDKwnPgC437OEo?=
 =?us-ascii?Q?2xOqTffk7njvq1qR9qEECN+1C6yJZlNxX5wvGo5yvo92uzJVNGF7VdDg7LUb?=
 =?us-ascii?Q?goYc4j1RObqYNBsD+Q2P6ISrSh6R4v5ig3AZNmGsqW8L8JZOEKZH7pOx1rTe?=
 =?us-ascii?Q?EZ78vSa+LzK57gWm0uoc1ElabER8NT9tCNzEJfe0DW0bxBJh2w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB4456.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BONp2K8zotK/c/4QuFIoWnuATd28Lj2GV80kZ2Yk9Xw2PACOzJMYqdpHGL6s?=
 =?us-ascii?Q?r6QB5ulcj++kaWuEDj2w+fY5WrOX0mQBa1s1Kcb2iqMpSQg7SwIrCiaZW2uG?=
 =?us-ascii?Q?yhHfpigLN/34qIwrzDP6/mVT+kRbAHQZote/uyxTzY+RpOQ7cA1dRTg7FdOG?=
 =?us-ascii?Q?9ZO0/mGp9iIpSOOR/zE8z/HoG/CBHizopWjIajLZvyBoU/aslk8iHcB/TMq9?=
 =?us-ascii?Q?v9+IpqgMqbsx0gLNzDqyNCzyhBkCRvlCb9YYns4Mde/Ixytm8TsuNv7kVEOo?=
 =?us-ascii?Q?3BbatJ/BFwiSFGr0+1B+TsF7sCC5YilM9BdD1d11C369ygZ68dfYaxMZWdm+?=
 =?us-ascii?Q?KNdYQG0K/VQaa/tRsi7E+78zhZxtuMaYynfQ7aQF8EeSR3aOy9gWcSSXGQYg?=
 =?us-ascii?Q?StjskqT3rQyphEF5fhbgG3DMYiTDSzaN1HoKF3spcuPqGgXLm8slUjOShaHu?=
 =?us-ascii?Q?Q2+mym12X/e0tNI4Yh/sUd4j3+vXhcrlQZekrVsU8enhGbDBGbD4FqffdN4j?=
 =?us-ascii?Q?V0V0wAmlT9rqniliqMuJxSl7D9vcT5QWHjKMpp5l2SXuAdBXfo9K5IgcR14N?=
 =?us-ascii?Q?haEwjIx+LV/zFKfH2P+nkkY3TPpMrroroGlaY759AP/AFYKZ3gP5rMlkvSCt?=
 =?us-ascii?Q?jsGuzuWHVDzDzKmkU9CkCNVLdhmokGr/Z4b2MWzo9LiX6G/L1yS2D1OqrNhj?=
 =?us-ascii?Q?34mxIsgzcgMntS3eVM2V7wD30fP7PJb6B3jomX/sQY5sewLS3amTnWskzl3E?=
 =?us-ascii?Q?gSFCM4OCzy80xhdWoNcJjfmDh4F7SFNqiiLWMVVusBIqi3r3xIgBMfwjTBC0?=
 =?us-ascii?Q?Fe7ydnjNZxv+0Hh638RKhljVoP4//N1eIEszeLwNQD6bXaV/d9HVhxROK2e+?=
 =?us-ascii?Q?1KAUyQOOYoFp9uYuAu+JErjJegFvSxWPSFlETKjYoBxQNUDVUg8HwvBiQwmd?=
 =?us-ascii?Q?/swJyD+rnlYs8v0XGf7rz1FxtuV3PVtD1daCb6XJOhzmJzzaBGWM++aVQGU9?=
 =?us-ascii?Q?GD31GF+hPqEOuP7nlJJjCubjFQbj6N0p2nSLxsda/kk3USbSCgKS6H8OWqFy?=
 =?us-ascii?Q?B4fp85fAmpKQvai8XeeH65AtgTEPwclqg0sx2/KTs1btr8EUSFHp73VQzaQ+?=
 =?us-ascii?Q?r60bYaifPH30c1spP++yS1HrmLz7B+bIedveqSnZpcHc8EmAyaMhRQqk/Cy3?=
 =?us-ascii?Q?GpDCS0kGu7DGdkXonxvxlcLYBUtQa2E+/qXk59VW78eZ7Pb7SkFa26ytRSGB?=
 =?us-ascii?Q?BiEAFNeXlmQaHbEo9WqR1efjJDhhFS7w9uLWr+myZoYwbrRSuYPuXFyokw9L?=
 =?us-ascii?Q?2ToWBEdAEQnVZuzb3wdA6sdDEcFNpQ3Grxu5VC0RzSU7kQrLSM4AozG9X/ds?=
 =?us-ascii?Q?x9RagyIkqx0ITYkJsdFbPqqJKBjdr+UTIL1ASTxs4MN2CWq2yNVnitmVV7VS?=
 =?us-ascii?Q?MFWyL+vx3zJYA0zs+OkcbiInXJ8ACkbyn6FFTBWUaw652tG3krHjP/SRa5DM?=
 =?us-ascii?Q?DifK4EGPfaAIoWgDUdt/hr3syHqU5Z19eRJoYxigjP82touv1Io2i/bXUP54?=
 =?us-ascii?Q?eO8KsIUTteur+5KB+cU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB4456.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b235e2f-b6d6-40d7-ad1c-08dcc88e83cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 00:56:00.1609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aESlNwCBdylX2RnDyXuneQeyftkfU6ZdU9duEhpNFWNETgwr5aSEtVLNGk9z6WhwK002hDy5GYJT8S+kl+AScQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3368

> Subject: Re: [PATCH net] RDMA/mana_ib: fix a bug in calculating the wrong
> page table index when 64kb page table is used
>=20
> On Wed, Aug 28, 2024 at 01:06:08PM -0700, longli@linuxonhyperv.com
> wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > MANA hardware uses 4k page size. When calculating the page table
> > index, it should use the hardware page size, not the system page size.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure
> > Network Adapter")
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/infiniband/hw/mana/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> These two patches are RDMA ones, please fix the target tree, rephrase the
> commit title to simplify it and resend.
>=20
> Thanks

I'm sending v2 to have those fixed.

Long

