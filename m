Return-Path: <linux-rdma+bounces-7526-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FEBA2CA21
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6C11692C5
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7A9194C9E;
	Fri,  7 Feb 2025 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YbZNxO4J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021122.outbound.protection.outlook.com [52.101.62.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742CE191F95;
	Fri,  7 Feb 2025 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949203; cv=fail; b=kcI4dEkYee0ZLVdaJK93D0nWh1qSiNMnLdxNj6JRxaIEeC0cV/PwSl1W7c5WvDEeHXY++ICffmmPa4M7Aw0KdHmyS4/WvR2v6+Io4jXtiHn9SLoOAPufn0WozAMdXAJ2T3j4fnkRYiSwIG6kjZlirthxs2voUUF+6A7lAumsfRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949203; c=relaxed/simple;
	bh=NEm87uarWnM78an+8q2MQw5Igqeo30iSqy821auUFy4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CpBpeksu0Bk21CPgVWToz03TAjxMBll+aHM9S1wZU9Q4tA1Pn2x9pWznBwkmP28PsBvPsHmyO+6RmXPUtAnM/VMiRkHDII+UMXVA/tejrjuGmp0m9iMOK1RR4DLHK1QhhjWcbGMfNTG8CvCv7SLJeAXwM+XnTGBH+k5HHgigt1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YbZNxO4J; arc=fail smtp.client-ip=52.101.62.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyVJoYR5kYE7PbtAj42pGLEYK2fOTKu+ySkmPvdlKN9GHa5G6UUYg21aJxqJSv6zjJNL33Xh5g8+TU84zNjqqVhOxXRKm1kcn4cPx/BFSu66dbncPa23VGHpGOk9DjRt+VhPjKKZo7ctkFvqFvoX0IgQ5EzXOI1sECkZqku62pXQyIk0NPq+8kcaJ+2kGKv7abGjPpEQsTjRMSo6VqLFGV8KlwaF4p8NmB5fnygJPjC8hFOGbcNKL9UJ7T8aLD1lp8Wz6YX+toxd5NXGJtORqZyoPvcUO9FVGBGpVr9DvfSSoZfXgRM4kcJMQwjywUEaBt3pjGPkepQgXM9zORVSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf86esOqftn6DamydQ+ejG3Myztgs0HnQYivrLcmy1o=;
 b=EN3mxwn1VknXPgKwKKZfcf9T3KpEs0ERN2otyCZO+HRh4Tjc7ZD5G+7QVYZ9ihOleYZov/mWfcAYGVtzStNo1zL5erBwvDAa2sdDw61fGiSibd9QdwrAboVphe7FzbtHO5Xhdb4que9tb7ecjfTGyUWT8/yKKoUs0KC+MAILeoKTXekA2L6HdmkekqcDftOKZM9t8muJDP6+L0EVaZkELVHmOQbcpJYvLJ9vu30xda7F3uvZn2wsMgulIN9A6i8JIo1XNFkBKaNeTWjznP5dE5zQ5aQaoDe69Pc3F/mguXN7WXOkg9v2Tis/fQt2Mg79QqM24hXbalRTZAqcU0SqBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf86esOqftn6DamydQ+ejG3Myztgs0HnQYivrLcmy1o=;
 b=YbZNxO4JffpOFVnI335Dm/8WjdNIbQ/kV9PFAOsYAeowv05UkCQ+6hMvXIvEc3cW7tE+/GiuFtxk861vS4wuCVSReidsr6FKjXNJDwQ3O7nU/d/akB28ACjmEYmMYbLutb1d+OJ/1pqTNDNt36sRcklPDidu4OZfcCLq9JxnJo0=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4209.namprd21.prod.outlook.com (2603:10b6:806:414::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.8; Fri, 7 Feb
 2025 17:26:39 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%3]) with mapi id 15.20.8445.005; Fri, 7 Feb 2025
 17:26:39 +0000
From: Long Li <longli@microsoft.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Konstantin Taranov
	<kotaranov@microsoft.com>
CC: Ajay Sharma <sharmaajay@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH next] RDMA/mana_ib: Fix error code in probe()
Thread-Topic: [EXTERNAL] [PATCH next] RDMA/mana_ib: Fix error code in probe()
Thread-Index: AQHbeUDvGHPi0oncJ0yJ3OK83fR6srM8GCzw
Date: Fri, 7 Feb 2025 17:26:39 +0000
Message-ID:
 <SA6PR21MB42317A411C6A2309ADD73493CEF12@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <2bbe900e-18b3-46b5-a08c-42eb71886da6@stanley.mountain>
In-Reply-To: <2bbe900e-18b3-46b5-a08c-42eb71886da6@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=69173ac1-1ea3-4e1f-8159-bf0b2c66d5c9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-07T17:25:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4209:EE_
x-ms-office365-filtering-correlation-id: 189b5625-4686-4b3f-6ce2-08dd479c94e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0MdqVpFNM3Hr5T1TcwlTNa3og3YKtUxUULJMajxAicXPsOtI2PmdiQqxJpOW?=
 =?us-ascii?Q?QPNR/EKO4lp4zzp8dRk6SFK+H1jr4q1igcWg8C4jbq5soj9CDDIIOWPa70pm?=
 =?us-ascii?Q?Zmz9/DMAPEVUISS7Z8+J456TzNM1HLzmvMUkduoLeXsEKZ/U+TR/+qvDXC4y?=
 =?us-ascii?Q?O4TXiyxov7cdsiOS2V3sC0hKSZFwyrZt6d9baxn6l1n54saQ1MT+Da/sX2tP?=
 =?us-ascii?Q?5DrIetn2T+YGwU+tiTVJ9UtrivrEW6gDzZj44fnEqhLL05L80qc0V8/p3cOF?=
 =?us-ascii?Q?+gVzyLtcLRiGTwVV6Ms5HPQ2voP4++1+GmOV/crUVUjwKLIZDhyfBEurwbrJ?=
 =?us-ascii?Q?u4cBztakQxZdnec2l4vwxtLMkZ4womiQJ5K5HS+OedgGLfav4p/tJMq7k3nP?=
 =?us-ascii?Q?CVtWZKBJYT2vDunblxl11wsc0Gy/nRZfBRVca1jjDkH/svhQUY30TNJQ6Yyo?=
 =?us-ascii?Q?jHiUnWa/H53pz4k47cnJyHur+o8ieFflcxI726nplFaDzax4HbsyEDzSipXi?=
 =?us-ascii?Q?axfZPBwF/JTxV9a8kZmzTySoQ5EdVkyC0olCHjeebbTqAVO5rHrPh5Ptjqn1?=
 =?us-ascii?Q?si6vyD9t7W8NVOVDYGBXEC+KCsTEij5DJy/eu5rDRt/7eeuqBthRxGyI7veQ?=
 =?us-ascii?Q?8GagLwzhkcFJ3x+HiqmKsqJoVi9LP2zB64h/VOh+6Hsf60qMFikTSaTqbtBk?=
 =?us-ascii?Q?RPOWCL7HIno1yYp5A9t/NXou2PdUM1FqKmPVK0m8Z+/K8vDV/nub2Z9nqNXZ?=
 =?us-ascii?Q?NZSIq2Loxagkg4KP42Ve42tHGS/9cIb2qNi2wsab3y8oayZZ4j32nlhFr9jx?=
 =?us-ascii?Q?J8Rx6B4WpqqbIQv3G9czyYJesYaNqekRCu81XrXnnUomD0MfXGQayyHJjxuc?=
 =?us-ascii?Q?jlOIh2ebdeSG5n6CeMENldrxcMLut6ka+qeabGNX0FWJHmpUJgZWGfN/OO0q?=
 =?us-ascii?Q?3shj7yVVIPb9AhcjDkPGbbxOxtQ9UrSd5lTX3AIdxJPf0Qh3b3bKwaR4pRo1?=
 =?us-ascii?Q?nWEY6EcdAYqd38O5PpQj7Lz/vaXSO0MDwpoBlpkQnTfcoGTUMVjuTIlti8Nj?=
 =?us-ascii?Q?6KYB4pV/m675RFwZ3hNeFCrnL2Eofio8YCa5xb4JgiMs222ZdC/5tEprVFh5?=
 =?us-ascii?Q?Uohp6xQhmoIgDgD20cKXn60fdcbIv1fdCVdkv8d1qOlY4kkk/KTMHEj9ugTj?=
 =?us-ascii?Q?TZCE0rZ4JbIujwedfD8HnhS1cfyDuOaXlUIkhZfdxcZuH+zM33gecQ3eQNh9?=
 =?us-ascii?Q?7By0J+o8lvN2o7tRecWo3bIofEhcm3DEjdkg7LYeX6/ko5S103q5825R2tzX?=
 =?us-ascii?Q?Ynf3Ssbh5Mc3zG0B7+NDIdLui2S4irVb8pfLWaRhgA6NEHLbXfT8yCuagoI+?=
 =?us-ascii?Q?EYR55VUSMUZbhNiOSF2pP2CKQgnEQ4Do2DsyRD41yR/pELGlwKeCKu206KXh?=
 =?us-ascii?Q?5eJSYPq/j4UOoTIiAMJG+CyARuX7xC03?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f4Ha8CgNwGbBA4dOqlGIGz/1BCYL3NaWwCjD2hy7keJ1UQGGR11a5sQQyvKI?=
 =?us-ascii?Q?Vcsf91LFfI4BWO6SarY41vZhfeaDzaS9DwwGo794AjXcVNIhq5J18CT3dgz7?=
 =?us-ascii?Q?2atrQrEjmm5xGiSkywl62onII4ibRLRL4YLmcHBNJUxmoa5pHItmyF20nPIN?=
 =?us-ascii?Q?6MlsxuyAYgAobKHUYGwFcSwCaRuGiufWo9sHBQYfbhOEpxgBzyBchi1u278Y?=
 =?us-ascii?Q?hCO87OUCGMt1mglUIoMza0iRbVjTN9vvCAw0XOprnoYr+0clXPnc5ZKzVs9J?=
 =?us-ascii?Q?HG50Xs++PB4mvJw83LFZzTgIp5kCvpssliNZV5bkNUmlKjfEaUpxIyoRGCyP?=
 =?us-ascii?Q?TjQofwjL9Pu2c+S4rak7+BQIcvsrYxUtvlAQF2OpkpCJoJzKbYo9snLQC7ZJ?=
 =?us-ascii?Q?killCa0IGuPFvALRs0XnGrSRgZPmYltYAMqXdRCRRdHfERKmBcn4y+aVfa4g?=
 =?us-ascii?Q?8hrC5VbHanl4u6wt7P/TMMoayFYDejPiNYvTCWAbB0BVxttaBg0l8Y52uFbW?=
 =?us-ascii?Q?HAn9DJuiV5clxbZF4QqX385ZExQssaKZhpi5EitCOcNhL5poPRVLIAaHPxEx?=
 =?us-ascii?Q?Z5ZLa3p73UuA6sWlU1YvsqkpLn5Lv0C1qXHNF+6IHArJxFFyFhwdpyARlvnH?=
 =?us-ascii?Q?S1XzbVj1vQHLThsnQohe+Y7vfLsBaaHPh0CTMQtGFU3ScoF0dKKbnKG1Dt56?=
 =?us-ascii?Q?nB1GBBXRRHLT38I47sa07aBNLXkO3SaczlMGtXD5JWPCTc2zkc97FUMhXyn8?=
 =?us-ascii?Q?zIEtY0U9clPhFuOeL7vHdbkRcObdrFAGEF8+d46s5ubmiLM8WHXhp4qJoUro?=
 =?us-ascii?Q?VKsyfQCMlK+bw5MwJzSe9/ggrsp9mnJv83zQA6iP6LGwgSuXanuDk3XNrNC9?=
 =?us-ascii?Q?k8sgcsvl6tJs5EJp2bUH8DTjmKxS42HttFSZZW0Hea7PofIl+ShSt5om4k0r?=
 =?us-ascii?Q?cG6KD5o9NdTwuRCvSB78MPnZmhM668UYiFyEKPsEEAv63CQmoI870F4sB9BO?=
 =?us-ascii?Q?bKFzE32qJu9iPm3B0kQka5Eyjh0lc8MM+HkDxtI12/dXc5+YbLB/4g60CsyP?=
 =?us-ascii?Q?gRl3Gn5p2ha1k2p1Z3pV/gP26wj5iaqeG6vdrbXuorY5vsocbQizbkl6msEe?=
 =?us-ascii?Q?hg60sbq6doaY3AO+KJdlCJlnZW6dp5zgQfgguFInTgslaAR4i+qt5slfOX79?=
 =?us-ascii?Q?YvG+vycJ+LYObD5qX2t75q93/SYN4oY36S0V00Cl/Vhrj7Pc+HDiWLT+nbI3?=
 =?us-ascii?Q?L3BAeuXm16str/ZbbpY27QwX2p45LTv1G/Bh//unGXvcFdMclOS1aQroMAIT?=
 =?us-ascii?Q?jZxAOtGkMl+lBWmcHAVHPHZNGF/5WYhZxur5gkMb52FA9NLJQZoEp7tIM/95?=
 =?us-ascii?Q?A0CFu+QtG4r+xBfuBtWFa9tzNfJBdSJgXfxcxqv1ttN7D51mPqLLRa5P+EKZ?=
 =?us-ascii?Q?VGFNlNo4wQz+HvcisSUf+/kmDNGrE7beCCs2z7b7WlQSVYw7yaJDN1klH+j8?=
 =?us-ascii?Q?owXSOocG/d/j9BBOsPu7AQ6r+1osDXFE4ZJ88E2xufFkrD8ryyD3tAAiSSgU?=
 =?us-ascii?Q?yO8E1sP2M2G+u93UGJbg86kGuXFuCTdRr02X6SSh?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189b5625-4686-4b3f-6ce2-08dd479c94e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 17:26:39.4596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ve1WY+sxfPI+u9q5F0VdEfF/GD2AhI67ApFGmVlyqXHPT3dvg0CIKdeZtBeUrWhVHM0acfd5GF9yd3gQ58WvKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4209

> Return -ENOMEM if dma_pool_create() fails.  Don't return success.
>=20
> Fixes: df91c470d9e5 ("RDMA/mana_ib: create/destroy AH")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thank you!

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index 0a7553f819ba..a17e7a6b0545 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -144,8 +144,10 @@ static int mana_ib_probe(struct auxiliary_device *ad=
ev,
>=20
>  	dev->av_pool =3D dma_pool_create("mana_ib_av", mdev->gdma_context-
> >dev,
>  				       MANA_AV_BUFFER_SIZE,
> MANA_AV_BUFFER_SIZE, 0);
> -	if (!dev->av_pool)
> +	if (!dev->av_pool) {
> +		ret =3D -ENOMEM;
>  		goto destroy_rnic;
> +	}
>=20
>  	ret =3D ib_register_device(&dev->ib_dev, "mana_%d",
>  				 mdev->gdma_context->dev);
> --
> 2.47.2


