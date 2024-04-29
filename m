Return-Path: <linux-rdma+bounces-2147-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512D98B60E2
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2024 20:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082042820CC
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2024 18:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DE51292C4;
	Mon, 29 Apr 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="feXDQZBh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11020003.outbound.protection.outlook.com [40.93.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0838614C;
	Mon, 29 Apr 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414113; cv=fail; b=I93frS770xXGR25/UJ0YfT+1va/sNUyUhpWiocTI9SNWtEoXZ4VydRvdrOerHcxQAkmToda3vlfij9A6STsaaZnG0BqYfZn2qJYx5cjtVgRQpvdK5Y8m59ToFpIv/eEr/kjuRo37cLeZsiRWl9iaMjguPnZkVgVppwns6jJQdyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414113; c=relaxed/simple;
	bh=6+aBC6a00/jBzBDPFNovD24OIC+UcfmZMzks+0xt2oE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pQtzx4/RGJeAFwpZNW9oyILKOIC2pIwG5gFcBeFG4Ws2ivUubrFS0BUArya3U2C1i6M/Kon+xbaXPcLiRwETVh43KV5cbJWlKCT39HYZQWZC1/KnMVl/MVry2evV86iUPU8MieI+X8JOUAJNA05ClYv5SFfUzp88qtYXIKyU1Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=feXDQZBh; arc=fail smtp.client-ip=40.93.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0Xnpr8vPs8gaEUv44OklsYBE4ZVe1M8ZcTtP1JQRKyUhC0sRO4rmrmz4q8YZX3pNTUvwn1dEb70RJHEWd0F2rSm/a9zT5bOPXHHW64Jyk5j5UXXZoi8f3m7xRdYmHovmGuZnBhpAAdhapCDVx2oc0jNlBsHraQDaZeQw2eK8WIUc6ZVo/u1cGq/yQNaHopCJLkjcvE4tvRsTtY89Toff+BPejZfmzGVYJcfaha14JN0+OkGb4nFcKinhE+n6DumArZF9HyREE3ljzoRlI4BygAnTrFIrKp5qA1EMn/r3zy8gBc4E4SkhclNN8I5TZKNqP8IZ+fO+CU5Dwmty82j/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CccGTKr+hshhZpzFr5ue8WpzM1Nb46EcLbryrkO+VrM=;
 b=gvxeR2kSUqxX5GNOWpQDnfM0hcdJGf3iQdQDd+okXenK4SZBxFPwCyzF0fz2K8DIYrONUNQd1nW3hLMjzmCqhG1fUECXZCbu7rVqu0pfGdj+DLWJCFughMZQ7LlYhHfkv5RoM10QSXPJpAzSI4CEgbK3hVMdCcIN6rqFpY+/PnfHcTVJKENHjU53axjmWX5sKc9h3MEKF4bQSIQcmRRQSvrFiOEzn6ea2jIK0YM5l6AVr3t710Ywb1hu54UHT3qfW1R+DmPZk5jBV14RFh9N7yHABxRGcxDmwt8/ItGBBZBddOvMbyqJiKeDZswaWBDAXDjTTg15068lB0hP+bQ1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CccGTKr+hshhZpzFr5ue8WpzM1Nb46EcLbryrkO+VrM=;
 b=feXDQZBhpxGcMRrOkil3hy1KFjwHVb9TkvJBEYKQiKeiEwme9FUsxvOsYwuTetOtTrPhkZdl4GwfBEvW9XLYlSbbZPdei8nJHKw+Cm3PV/KVftAuWWWyHDIMlu2F1o6XCFoW2kS8Sf9PQyFOxztlFJdbgvWDymMUFuVMRP+dcPU=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by IA1PR21MB3595.namprd21.prod.outlook.com (2603:10b6:208:3e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.23; Mon, 29 Apr
 2024 18:08:27 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb%4]) with mapi id 15.20.7544.019; Mon, 29 Apr 2024
 18:08:27 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 5/5] RDMA/mana_ib: implement uapi for
 creation of rnic cq
Thread-Topic: [PATCH rdma-next v2 5/5] RDMA/mana_ib: implement uapi for
 creation of rnic cq
Thread-Index: AQHal9t008XqsRzWOUiSmiSGonpoubF/kHbg
Date: Mon, 29 Apr 2024 18:08:26 +0000
Message-ID:
 <SJ1PR21MB3457722A994F429FDE0C46FACE1B2@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
 <1714137160-5222-6-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1714137160-5222-6-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fad8713b-ecb4-44a8-9989-0b4ccf5bc06f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-29T18:07:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|IA1PR21MB3595:EE_
x-ms-office365-filtering-correlation-id: c7bbb733-2dba-42df-1ecf-08dc68775e23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?r4AqgYNMHcgnUml96Dsg1IliokryXV9u+w81HvD5Rbnk7lydSgdRqNLKG+cw?=
 =?us-ascii?Q?UeXXxrmfnjMaD2Uit6gtA8lU9NmxCswntdHg+/GxfusTc/w9yevpd2SebBa5?=
 =?us-ascii?Q?GX27bQrMjwAxUl8QuvFquo5tjKgx9zvIZw54TaPOoxryn09s+i0ujdoNPgU/?=
 =?us-ascii?Q?6N9gCSJay5G34kXMUVVS32NrwODf7vto3rJx8zyg52bsUCuWaV+Z5TeGX+jF?=
 =?us-ascii?Q?UgZh6yMnzN5QIbMtp4R4PpK9u1DKl0l3FW86RXh/I1yClaypXyYNXPKKQ9b+?=
 =?us-ascii?Q?K67XrSE+iDnKYGZM8si8nzwGbV59jaDNKpF+6l3FPu9Y1BEuan/SLQKHwXIS?=
 =?us-ascii?Q?u8uSLXuenKB6jnppW5FMzeXFpB3rZF6jQIwa2b6ZYjcx9K5gByfr47AHXezT?=
 =?us-ascii?Q?ygPxRZOFVTK2dJfYXTCV8hE2Z3TM52tfSUrHPgtdnQBi+taQAP+32jg4yG8G?=
 =?us-ascii?Q?rv1e5CXuTUkKx/Th6FxwqFhUWH4wNfZbYJeVkYKgQHYYKnj97QRdCzFlx6mO?=
 =?us-ascii?Q?lseoY+Y45RSFVYh08aL+kBMdGrY80fs/aDS8bGUlB8DlVxZ4Gv+Z6+1tv1P1?=
 =?us-ascii?Q?Eu/LKFp9ApT5jo+Ug9daQuO/kTOmlen0swGdaG2HPkWrurcodGbh+hyTIfS6?=
 =?us-ascii?Q?5pZYWiEd/tFGTryK1AyWbaCcNbZV070XylRXI/eEtGt1iYamxdhjZgbXNp+0?=
 =?us-ascii?Q?EAzgMrzhrASMj82OSuX/xQ138Ru3YJyTSWoanHKgUtYad26gjoqlXC4FYiwW?=
 =?us-ascii?Q?tcMY+va62WSa4Ufp9g9/wRIj0EkyNqy/D0ogfW3qUXiwmbuBp3sgjcRFeJKF?=
 =?us-ascii?Q?KJRxFUtLrwEvAkiSudhq/x5O4FGtWTmJrX4Gq6pz9JL1MfAmSm704+0rnDqY?=
 =?us-ascii?Q?LGoMvXTwQov6t9Gh1TOOF4J/MqJGIyLN+M9/y9/Ltdw2W6+Q56nxBazCdKv7?=
 =?us-ascii?Q?jg4Q10JG3VGG5qdRPYO7TPCvwLODNrUVf8vpENTcT8wpkffk0iFRVZa/uCI8?=
 =?us-ascii?Q?j9i/zLctzmfqXX3BQ0aGKRR8mO8QxKPlrE4Zj5yKfjoqvzqjb0ocUBP8SRm4?=
 =?us-ascii?Q?255IZXl3hOIc8OeeG84sqmSR5p81TXLpefUH0ugFXE8fv316el6nmMOuwvY8?=
 =?us-ascii?Q?YGwJmM3kF5geECMIy5CWXs89gpSf5eyMoLSESwLzMsfkYaNtCQowCtNd7cGN?=
 =?us-ascii?Q?1QOfQF76+4WCORn9GFD1os1ai7cwCcbjYojOv+y46uxVgOt9KdiK5Z+hAaDS?=
 =?us-ascii?Q?tIO8MfE1K7FpAzwijeLeGng3kBhbK6I7xDf5lbCNCYk8nsouAp2//smxIEnE?=
 =?us-ascii?Q?FPYKCPkSdMDlg6v5MkEuPgsYA+fem8T6HDaVDXIgv3W49A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LPbvXL6iU9Fju1sWEod8GRQoHyMongxg4YmuZPQnp0XPxEOedhmHgtj6bezC?=
 =?us-ascii?Q?TSAX7wJUZIzS0xee7oifkQwdgZwG5MRkzPA7CEoqDw3hSNnljq79WVVkY4ph?=
 =?us-ascii?Q?kG78eIH3xNEO1pZBxpBxczymAOGxCeWMqkVt+YjkvNv9OaASCjCz+YNLuaMh?=
 =?us-ascii?Q?we1jttvrTlBYjBGasPZR0BnEPkPYYhVaDg+8k0B13oU6hfLqN9qU8tsdVUU4?=
 =?us-ascii?Q?p3VRJinTk7gX0KxARwCjSXAQiopuHdQQpG0A13SfsJ5SjbLylmksOGJeeOEb?=
 =?us-ascii?Q?p+UM+nIYPTVMEMmj1UStgVOFXJxerYaSuoZ4t1ngd37GK+Lq7hFb8olGTouB?=
 =?us-ascii?Q?0oU2knOAc0tOiZcF//5NoxZqhRn42R0FbCUeZOeMCS9Afa/bsvlI6RFTqm+j?=
 =?us-ascii?Q?qj/AVyk9TVyQP/IGYne/Z8aXEZ3+GXGgPIm5nac1uVI2c7vRzdNvHjQvx8El?=
 =?us-ascii?Q?wTLSvkQ3x2l1ZS05Ph6+4MGCxjx6PZj8JZOkTaGnvynfhbOTFI1ews+wUwqp?=
 =?us-ascii?Q?dfSOpEP0wf9yJ3uRsXUlMHSoHU/Ki7DRMpVauZiblae9WuYSg1zFI/QkBPnY?=
 =?us-ascii?Q?5I3RL0PzRH5Th0na1VTZo4kXkxdPq0WZtl6mKhAAzCW2sNTwhcyn+VfummUW?=
 =?us-ascii?Q?DaghVdncA61gNec+DercC/oZmF2H7S+8oZWubMk1PwmFKzhjXbqmAZdu2TKY?=
 =?us-ascii?Q?PopvbwUhtJU03HwPmo6MKxccHyc7MVhxsTJarZDvlK/uTZr7RCLHy3RVc+m7?=
 =?us-ascii?Q?cKJGosbOpaQWhyZU5UvPZh8uwSZGj1vByQFYpd87KsbcteDEXSymGXVwJcL7?=
 =?us-ascii?Q?bYpoQR13zS+AFfR2vZ6lIn98asRoPSokYvDSZsjt6tw+lpvnFFoXEwFZa6Sp?=
 =?us-ascii?Q?4talkPNgrj9DSGNYcbiImbRzrgAtUnsy/U3qYa/lKzGuAjszc3cqCFtXYW5W?=
 =?us-ascii?Q?yrJSNSBNlChllB93Z2dYPtGeTT1Dzw7L3FfiGoSG26vlHKRlvrnLWvqe2QHB?=
 =?us-ascii?Q?cJIGebkW/k/SLnaaJ8QeVFv1MV/ZVEO+JTo8i3foDm5QF90yWyCTKMCjg/19?=
 =?us-ascii?Q?UL3s61CQ3Do6zzWGdvpOdm4YTIjMbZ+yEIgxT6WdfkHR1CUBLUS6wlSZBDsP?=
 =?us-ascii?Q?6/mK2mFd0RnhUEPThnWjSfPOJqtFSf0O/ZsodfY2gUEvEPx/ksDFAOEXIDFV?=
 =?us-ascii?Q?87gyHiDClkoqEZuOU82EqonSO9r329hdQPRF/w1ePBd1YIXR+dFtcti9a/gB?=
 =?us-ascii?Q?uRuDyF3AfpkYFfdnJDxGTMh0HWcdMPW3U4R0CbZIpoD7MriB98yMnC3PSF7K?=
 =?us-ascii?Q?Vd/ppLIvHpp1gh7qQ7ZYc3NV+I/NpWzKeQ5rDx7htlaCHvWja89xFM3gKcQd?=
 =?us-ascii?Q?DD5wU4q/su7HqtEqxa2PgqknjhcRokEih6MBYf09dJi5mbw0admosGAtXU8u?=
 =?us-ascii?Q?s7nYb2olWQWxxtKOGeGptMBT9r5Dww1GHpPGAkSlKzBuG4R+8Z7oZzhHEWls?=
 =?us-ascii?Q?t75FdUvGZ+5eqs3IbCO91T7YLkUGdiCVV7+cmKBhi0ks7iysQfNSD2rOCrZv?=
 =?us-ascii?Q?fxTHFWdAaslm3k+wYx6lezs7uIWiVHzSC5pukMgf?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bbb733-2dba-42df-1ecf-08dc68775e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 18:08:26.9171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MsRoCbJbqr+/+bfKEZLsctEUM9f27dUvXIw93nPbKEMYSG1PdaeaOR+FB+nD8M2MQU/7ptMzvfWj0p21+v/hyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3595

> Subject: [PATCH rdma-next v2 5/5] RDMA/mana_ib: implement uapi for creati=
on
> of rnic cq
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Enable users to create RNIC CQs using a corresponding flag.
> With the previous request size, an ethernet CQ is created.
> As a response, return ID of the created CQ.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/cq.c | 55 ++++++++++++++++++++++++++++++---
>  include/uapi/rdma/mana-abi.h    | 12 +++++++
>  2 files changed, 63 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index 688ffe6..c6a3fd5 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -9,17 +9,22 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  		      struct ib_udata *udata)
>  {
>  	struct mana_ib_cq *cq =3D container_of(ibcq, struct mana_ib_cq, ibcq);
> +	struct mana_ib_create_cq_resp resp =3D {};
> +	struct mana_ib_ucontext *mana_ucontext;
>  	struct ib_device *ibdev =3D ibcq->device;
>  	struct mana_ib_create_cq ucmd =3D {};
>  	struct mana_ib_dev *mdev;
> +	bool is_rnic_cq;
> +	u32 doorbell;
>  	int err;
>=20
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
>=20
> -	if (udata->inlen < sizeof(ucmd))
> -		return -EINVAL;
> -
>  	cq->comp_vector =3D attr->comp_vector % ibdev->num_comp_vectors;
> +	cq->cq_handle =3D INVALID_MANA_HANDLE;
> +
> +	if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> +		return -EINVAL;
>=20
>  	err =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata-
> >inlen));
>  	if (err) {
> @@ -28,7 +33,9 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  		return err;
>  	}
>=20
> -	if (attr->cqe > mdev->adapter_caps.max_qp_wr) {
> +	is_rnic_cq =3D !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
> +
> +	if (!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) {
>  		ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
>  		return -EINVAL;
>  	}
> @@ -40,7 +47,41 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  		return err;
>  	}
>=20
> +	mana_ucontext =3D rdma_udata_to_drv_context(udata, struct
> mana_ib_ucontext,
> +						  ibucontext);
> +	doorbell =3D mana_ucontext->doorbell;
> +
> +	if (is_rnic_cq) {
> +		err =3D mana_ib_gd_create_cq(mdev, cq, doorbell);
> +		if (err) {
> +			ibdev_dbg(ibdev, "Failed to create RNIC cq, %d\n", err);
> +			goto err_destroy_queue;
> +		}
> +
> +		err =3D mana_ib_install_cq_cb(mdev, cq);
> +		if (err) {
> +			ibdev_dbg(ibdev, "Failed to install cq callback, %d\n",
> err);
> +			goto err_destroy_rnic_cq;
> +		}
> +	}
> +
> +	resp.cqid =3D cq->queue.id;
> +	err =3D ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen)=
);
> +	if (err) {
> +		ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
> +		goto err_remove_cq_cb;
> +	}
> +
>  	return 0;
> +
> +err_remove_cq_cb:
> +	mana_ib_remove_cq_cb(mdev, cq);
> +err_destroy_rnic_cq:
> +	mana_ib_gd_destroy_cq(mdev, cq);
> +err_destroy_queue:
> +	mana_ib_destroy_queue(mdev, &cq->queue);
> +
> +	return err;
>  }
>=20
>  int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata) @@ -5=
2,6
> +93,12 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *uda=
ta)
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
>=20
>  	mana_ib_remove_cq_cb(mdev, cq);
> +
> +	/* Ignore return code as there is not much we can do about it.
> +	 * The error message is printed inside.
> +	 */
> +	mana_ib_gd_destroy_cq(mdev, cq);
> +
>  	mana_ib_destroy_queue(mdev, &cq->queue);
>=20
>  	return 0;
> diff --git a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h
> index 5fcb31b..2c41cc3 100644
> --- a/include/uapi/rdma/mana-abi.h
> +++ b/include/uapi/rdma/mana-abi.h
> @@ -16,8 +16,20 @@
>=20
>  #define MANA_IB_UVERBS_ABI_VERSION 1
>=20
> +enum mana_ib_create_cq_flags {
> +	MANA_IB_CREATE_RNIC_CQ	=3D 1 << 0,
> +};
> +
>  struct mana_ib_create_cq {
>  	__aligned_u64 buf_addr;
> +	__u16	flags;
> +	__u16	reserved0;
> +	__u32	reserved1;
> +};
> +
> +struct mana_ib_create_cq_resp {
> +	__u32 cqid;
> +	__u32 reserved;
>  };
>=20
>  struct mana_ib_create_qp {
> --
> 2.43.0

For this review, it will be helpful if you can also post a link to the rdma=
-core changes.

Long

