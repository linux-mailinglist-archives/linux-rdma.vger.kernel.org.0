Return-Path: <linux-rdma+bounces-14032-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFF8C036BC
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 22:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE5E3ADBBA
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 20:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7781DED42;
	Thu, 23 Oct 2025 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Z7kwVzCK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021094.outbound.protection.outlook.com [52.101.62.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00472D7BF;
	Thu, 23 Oct 2025 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252512; cv=fail; b=IVnmRrY8Q8annhzSwwtGqm45vKoUvmUNJR7wv2H9donlTYMMvphpX9EB+6tBD2lLBjBr3sJvdO0bfz5LgJVc+FUF7sraiiumXwu9imPPH/e6u6IR0KQmYz1JF+Hxnl4yfjUYdsvr6gH2PadUwxhl5BiRgqVvf5EFeD1CDRzfhpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252512; c=relaxed/simple;
	bh=4mOKR6teMrCa3PXboaQP34uedLPkQMGp8HJlUDenGcs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ip0DoZnRRvP+DN5vSHMbUyvgXbBEqJJBvq9bFeGySVAahCk0obREF5Cr3j5urIQlXmOmiZBXRFKcXy9GBPXVeDvmJVtDiQB/yNK5F0/poBoYCFhApjTiEv35WRHi2NIeed1aWx91rKGSiKcJIUzlazlFCG0KqFI0K7o5v2ChDoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Z7kwVzCK; arc=fail smtp.client-ip=52.101.62.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBRLbHCUA/P6Ap5WFs8URl6V0sOXs0N2taSIBqC/wjaLHqzzcLYv1IEF3VCHWwHZnxo3abq5hwnT1HyA7KyTyuu5xMAWpFzi2D+F4bSL48aYzJqoepUKm6fMpU/PXps077h9RSMwZmsSaDnuFZSV4agGuWC0iw/MbuYH8mOphfe67L6bF6EPl1QNdl/1r2N8MTdf1y3m9bHq8jBfWpN4d3F1Mb71aXknNPjUOlpZD6Py2MlrqzhaeEZxJuZQR6Neer87krvX/ShrsLp9Bnn2+/06TzTzpJwAGMGQht34y5mQwes9mivI+l4eeWiJrcR+0FnqqXtPF0M/ToAVZI61og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1+/MKJViYn1HYQgytMXm+6PoY1VXT1tOkU7qRvi3zk=;
 b=oS8x1QJ0z6WrfGLWmIOgIzvKZrNtMskWspKQw5Au8hi0KbueCvARAPAu+UqxM090KhwoXgnAEKeV3/t8+64xt2aWFfXmsouFF9JZLO6FQV1014cyGvf3tdFu91fJEf25e+PIj5BtXCm/6i7BbTMTpDvxaki5kYWIfZlA2xMxxPRGIpYgPRa0ylQP4IfRrIcqlvNhK1XsQ21pOI7yCcrU6S/dkzK2Bn3Kl9jqYhDx+P3dlDnyucTZotNHwcNaA7nacGA5JFDDSUFHQvrR9ww7bqdY74mn4dvthjwneFE8/qjkVCUCzCBM2/czvkzRmWLwY3R+jirbXk/vG9RmbsQgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1+/MKJViYn1HYQgytMXm+6PoY1VXT1tOkU7qRvi3zk=;
 b=Z7kwVzCKNSc91nhD1VNCP/f3VacKbhxY1vNSEVs9ovPLZeltYzTCYh+aVVC9icpY+k4XFH+z09EweLP84LAhvfkErYxKIFwDHwdV8yuQPCfCo4mhJlZaggwiZk7hGVpchYlg8Zgx6g6HpV5oP0QqEmanhRkq4Xa56PY7QbXGLrk=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DM4PR21MB3107.namprd21.prod.outlook.com (2603:10b6:8:63::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.11; Thu, 23 Oct 2025 20:48:27 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983%7]) with mapi id 15.20.9253.005; Thu, 23 Oct 2025
 20:48:27 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/mana_ib: check cqe length for kernel CQs
Thread-Topic: [PATCH rdma-next] RDMA/mana_ib: check cqe length for kernel CQs
Thread-Index: AQHcRAQ4VcktIStFdk2UzfYQl6P6WLTQNJvg
Date: Thu, 23 Oct 2025 20:48:27 +0000
Message-ID:
 <DS3PR21MB5735443BE6D27B4AF076E4B0CEF0A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <1761213780-5457-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1761213780-5457-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=66e5cc60-fa36-4d18-bffe-7f129b1c37da;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-10-23T20:48:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DM4PR21MB3107:EE_
x-ms-office365-filtering-correlation-id: d1a7c974-3316-4567-3443-08de12758492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?db57jC7IFj4Du9wwUTrgyRo3FJDdiUBLfO0C61Li/iN9maHZ/FkzhQ/GwSwq?=
 =?us-ascii?Q?0mYn6T2rcVF/BCYriH7tSZ6qNHuOzIW5fYWyiWLik04qqXAMsfPZc6Ro300G?=
 =?us-ascii?Q?YobblTGymNNt1zVIYY0AvY/cjO/sxGHPSfThRduB+L8mt4sjjoMDxoq5iYyy?=
 =?us-ascii?Q?KGmVyCadLbw+acIkbN9mfikJs/snmm+TB7LfKr1cUzHdhFqWaBRqxgdcGQj7?=
 =?us-ascii?Q?fdh/VHsnkA8DP+8gMBUK5EfZHLsWTjeyFjbVhWkLb2Pvmk15w3SozAIYnjwq?=
 =?us-ascii?Q?s/rNJmvbQYv4YChl6Yi1vnziuvtC0N37XMAHPBDbS8Yu3R0WxSZ5gTJZjtmv?=
 =?us-ascii?Q?IZ5F+/3MI8H8qscphwNrTDevNJLixlFyLJiVFpdlwTpg1saygTgev7W6T8KN?=
 =?us-ascii?Q?TJZidAwIbw8lkRaL7GzT8R3h/5E1VSv+5VmWE+1mzeFUlxSLibHamgqec5IH?=
 =?us-ascii?Q?G/10g20+K8dWLfZhZ/zaQ4aQYMYCg2rn4RMgbhTVd6vVWD/5yOi7X4t0mG6r?=
 =?us-ascii?Q?O7bdfjt033FFJQvMuWRizLS3sgRmwo2PvAhHcGcgh5l+Q4x6oJJ4YheezcmD?=
 =?us-ascii?Q?AOjtPKzB6W+mEFRc575H+Nf6no76z+T5ZPlExKaXl01vRIqbak2RYMlb60Ue?=
 =?us-ascii?Q?1yx7VBAAwV8p74E8lYvMHj7G0zetUIzgFFKxkSL/y3ZWFgR/6isazwI9PTIk?=
 =?us-ascii?Q?zGZnydsEDif0nsn+gEBQ37swK5I6RBuy/2+tPZULVJa4tMWpQBMphBU7l57Y?=
 =?us-ascii?Q?HmtnT5iCKky8SYOGpUm5hNYUIozDOr+NHmZu/40UyrAOEDl1knIHqc+lTaHr?=
 =?us-ascii?Q?PZEiqLwDmWMZW/bbfpRlQm3zJAQuBIrNbQT+PrH9Q+zI1zABa7lJxncJYabc?=
 =?us-ascii?Q?t+nK+IKwd6lhtg+nwlDWpZ2zbpblIt13mIIBoGqRGFePP8Jtrs9CVe4pmSnR?=
 =?us-ascii?Q?tLLPMI3+2LKQD637gSBIdMrIXIjvGytZAkMp9FxOMrLMoegyILwf8Ce6gI2E?=
 =?us-ascii?Q?mhFaiJidZ0iaqDlvbyUQIipl12tpsvIS4kAC/gvi1vSdrMtd6nEtE0Id/9H0?=
 =?us-ascii?Q?biw8j141cqJfPiSupT57zNrb5AGFQTRV5LHJDYYgG8zk+YKP4QXx4JYNSyYY?=
 =?us-ascii?Q?Hus/DddDe1MMqTYmG6IhMMiooyygHsjNnV48RYZQbyKOgDpLuEOSc3PkHwpc?=
 =?us-ascii?Q?pDHPQdkZNoksYf67Phci3K+YMStWGFYe2JIzV74jSpveWrarK19/Ghj0w7r7?=
 =?us-ascii?Q?XDu9qyFit47sAwGJNH5y58F2zSfsmnEPGIp4DioRrJRhUZWceymgEBxDxhPI?=
 =?us-ascii?Q?+GaUTBVNGO11CLOH4hY9+takAwNgcgX6U0dv6O3KMiof+FeenRaIggVHyi5K?=
 =?us-ascii?Q?uvqlM0/D6sSRufLkiM2plGsBYWWUIGYCQXEBbkY5A1fIqKWO6fqUNOkoa0/I?=
 =?us-ascii?Q?/NdcqRwwWCo8O22tOtx5nODY1pYymQYZeET5nAmn7+v++RfnhTsg6Cf2Uus3?=
 =?us-ascii?Q?qbdsdLFgy86LtGBtnxGh++WBiTLi8TKR6Bc1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VTUldUvXLWeMI4iKrtdnTrTcv3xOikLh6PxHpxmD9Vx8YXbHOTVxDdJo6+Fe?=
 =?us-ascii?Q?HjLzq3qgHKSm1nK5tY2CBXL8L8KKmx56/8g9zaSOYiBcM7qhQ8x1gYTqwniF?=
 =?us-ascii?Q?KUgtSKDtmzSQAQZAodzHPMNtAA/54PopRCX5r6kzwyz5Foy6KdxmbGbLbYEv?=
 =?us-ascii?Q?By2O1Lglte7ow5VGV0+EcidtIqFYFbAyyT7K/XGvI3rPfCSnRr3ty2FUhpoX?=
 =?us-ascii?Q?BJMkQTlngOy0dUTuVyb03tkgoMNPMvdwr/GakAK6dKRdt29MDNOLB1dO8CSk?=
 =?us-ascii?Q?+IWQADCz4ADHFMN8ryL9xKta9whK35glcZkAM7pOlNMP1BdiNZf+7ijty5ed?=
 =?us-ascii?Q?dy1CZ5G+oRYeDLvJmDwURVDyycorbeqKeZzZxBvM45W0ZpqHRAhBy0nGn7Pe?=
 =?us-ascii?Q?s6EPUnpcu/3/MCgKYXvYY3i4WgiDHVxBsyyAJ7oHwAaHGmhkY2fazE1NQStl?=
 =?us-ascii?Q?tiLDsjhddq9yudaIRuuueIoWCNfABvrd4mlWmdrf1amoDKRJXgO7A1qXGDFC?=
 =?us-ascii?Q?PEDSp8qOpqBGv7Hn5LyujXvYBAk01THD5KBUhvD03pwVFEM5g3h/3dEL2ja6?=
 =?us-ascii?Q?TvKUofZsYUlqm8XYnI2DZOLYjXyaaJAkVi+uH1XEWmQ/gLXVUhzHIDtx9kQy?=
 =?us-ascii?Q?opNC3qOjYVsAyGOkKH59l/02nNTxCJ4ABt5dzZ3esuFqFKyMcaKuS6aj2Wxz?=
 =?us-ascii?Q?930nRNu5hlA17S2Z4G9Wj2T+ZH6YUNFkxqAGSthqsqeYk7ysJGIaXZ/tS+wo?=
 =?us-ascii?Q?2do3emU3rhhLqf0T615cBkDAs9mTSefmyKwzevKGNwNobVvGoKqx8g3rsHWW?=
 =?us-ascii?Q?ti1aExKmR+JEE2CrRrL3kFqrAJZ+5Z1wcRoplRv48OTSA8BJLnUJfAd18pRm?=
 =?us-ascii?Q?VYPKEPjWPtQ528YNxOOn4ssMj+5oxsDigZ579JgGIyREnRSo3L0WvK+UDZWP?=
 =?us-ascii?Q?XsEXD9UnXzBQ7Jtf3YpDMZimtl0SSsvEE3bl8A3v/58Ji4zWlU59t+503NSt?=
 =?us-ascii?Q?KQjOVd1YcD1GWGgR6bnUm/+Qx9Bm13Mw/AM64B6oFz3tc5YqKA+t6SJTc9se?=
 =?us-ascii?Q?6D9i/Zohd8BoAKPO6ZSbkBPvtn+2FJffnnh61BhijEqnC5Z2rIPttXTuuEsh?=
 =?us-ascii?Q?fLvKD4/y4tCHSlv4+A6onK5j6STATZvHm09yZP0qSJImTrT8hfEPy4K29VC1?=
 =?us-ascii?Q?67fjPKuG/TKJYFmivvQZ3+vuJqsqF7ZPABLWUcXec+2A7Gt6O+DvIZ4kVnXj?=
 =?us-ascii?Q?3p8Wtf96SVtneN1ofAf9E+YUFlnUSkbrdzs2xT4XyyLfr2tzBcWiSFTY/Dkg?=
 =?us-ascii?Q?HARx9GU6q9Sd60xHeszEVr+nDq/2RSAwhCaU3SwFy45/IuV/N97WIYgMYlwT?=
 =?us-ascii?Q?ft/+MnQwgPsNc0Z5c/hI8fDsMOuC+iCdJ65hjfWBpZhc6pzm85LfniUFF7od?=
 =?us-ascii?Q?41fhCEhAO8GCx870KETgD+yZwZVfAWheQSwm7i0pyD6zKGosuUXty1vn85wM?=
 =?us-ascii?Q?ex+yRjWqC5YmkB4qT2CTdWygvg8w/YY8FJ51CxBhyIpleLNCLcPSx2NSbUfq?=
 =?us-ascii?Q?RXqF64BjNYJS7xxprK4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a7c974-3316-4567-3443-08de12758492
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 20:48:27.7298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fFIpNcbmmi5CY2uU+ur6skOz+TWO+nN5uWQ2izg9HiKN6/Z4du3fjFIPD7KPxj23EMqbpdfRJOVYUwPZpg/yqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3107

> Subject: [PATCH rdma-next] RDMA/mana_ib: check cqe length for kernel CQs
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Check queue size during kernel CQ creation to prevent overflow of u32.
>=20
> Fixes: bec127e45d9f ("RDMA/mana_ib: create kernel-level CQs")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>


Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/cq.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c
> b/drivers/infiniband/hw/mana/cq.c index 1becc8779..7600412b0 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -56,6 +56,10 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  		doorbell =3D mana_ucontext->doorbell;
>  	} else {
>  		is_rnic_cq =3D true;
> +		if (attr->cqe > U32_MAX / COMP_ENTRY_SIZE / 2 + 1) {
> +			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr-
> >cqe);
> +			return -EINVAL;
> +		}
>  		buf_size =3D MANA_PAGE_ALIGN(roundup_pow_of_two(attr-
> >cqe * COMP_ENTRY_SIZE));
>  		cq->cqe =3D buf_size / COMP_ENTRY_SIZE;
>  		err =3D mana_ib_create_kernel_queue(mdev, buf_size,
> GDMA_CQ, &cq->queue);
> --
> 2.43.0


