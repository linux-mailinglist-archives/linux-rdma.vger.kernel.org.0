Return-Path: <linux-rdma+bounces-1456-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C5387D266
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 18:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7183C284F84
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 17:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D745647E;
	Fri, 15 Mar 2024 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YxaNthRz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR05CU006.outbound.protection.outlook.com (mail-eastusazon11023015.outbound.protection.outlook.com [52.101.51.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96064CB3D;
	Fri, 15 Mar 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522235; cv=fail; b=UJghxfsTJmUu8/xVS2GrTyC4CusybpB6z21xKxmbRjBn+KfCWxCrwR5YDLjJqsWPcY5/l5qI2sVJKiVqFmxoESE/DUfiNRcjMaN5uah8VLDsaBRfP1iOm/Cj5lR9CZ+CAcjWg+6SdU3V1uoA0qvfSIdDZX+GquMYN32t/VwrNEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522235; c=relaxed/simple;
	bh=21f861TOGz6Lyca57y/nRYdKVu4AnDfY3hRxpDYooK8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D0Uw4cnRDMfiZAzHCf8slWS8ntm14f1ZfioiGWAu979yoHX8OyAsqxKpGI+TzgoRYkv8j/m5r4o/iX5VOnFayHLP+GxHA2Zd6bqFCCIpWTJhSbRQY/vGo5oq2N51fOMjGYvtZklS3J4VDaNXrOU7CeM1akuRuns45Fb5h5HoWLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YxaNthRz; arc=fail smtp.client-ip=52.101.51.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaziuX0UjkF435020AZvit0csxgAJkUXXQfNbuZPbej2osGQT1NiGCnnSyligfIAHZQJdExn6k1KBP0w0Nmi9mz+P9vGWjAI6vUYyH+/zp8lAV2YYX4OAjB7zFFexL87QqipmwArTRcBmpoPJ6gBYo0TxPKIbDU5DeHF0CDs5d28YQC7NJS0nRYh0KArykjr1eJwC72VtzV7guGaNtJjeUotuTtwAGrOvBC8zFIyPX/BpaMEjdInuodJR4pmtkqLFa5CosAYQw/NvMauRPrF+235KE+5bah/Yxcr5ZDC2Q+L4RpjEI3WpGZNYMbWwoY0sEq6G3YVfd/ZuqBSpQSiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA5lv1GTcv6akyZ1WvbKwpPYxOv9TvUKCVrZEUj0TUw=;
 b=e2WYl4Ily2Znxm4lmsEqN2lW3d5fBcw+kZ1IZX97KCTwYxy18979o1lK3/yE3Yu/5ZIMYrKHyLmVnsCDBuNJ12wcDVPWuCFi7quRrPmdisp65Mhh8fyzw30S81OQNQi7TNYaBfjOC/BNJMqp45OfbXlMZ2qNs2F4lqKz4wMXYbhDdvGlo+9vMVYNYjEJK6ZFCIJAsiaJwhbqvoQhA5D9/1N42PrTzaBBKWl3n0/qi0d9lBZq3sB7ZRd+is+bKXwwIyn0H9dAT0zfQ4eFc2/XdEE26wdR3yKitKmRePEE6xKMf6l/XYohe6CN16wMMyAMYH9Bf+qrwg5WZD82fPELDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA5lv1GTcv6akyZ1WvbKwpPYxOv9TvUKCVrZEUj0TUw=;
 b=YxaNthRzYu5VzGkO+/EItb8Yq5g6SF0Gf+lNtrrchtFMEqz0LvHOoHB/MBNADRdrpd51oKut0JPLdDwyqdseapImKb6rNxPUwRJYgQm21rIEiRhO/8nih5ZttQaps9TlzfibM6ikPlhOXJB90Ox9R033wPDBTKBnM9bwSTtc9oQ=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by DS7PR21MB3220.namprd21.prod.outlook.com (2603:10b6:8:78::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.9; Fri, 15 Mar 2024 17:03:50 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7409.007; Fri, 15 Mar 2024
 17:03:49 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 4/4] RDMA/mana_ib: Use struct mana_ib_queue for
 RAW QPs
Thread-Topic: [PATCH rdma-next 4/4] RDMA/mana_ib: Use struct mana_ib_queue for
 RAW QPs
Thread-Index: AQHadUnf/J0cqITF40WUrHrnjuprzbE5CceQ
Date: Fri, 15 Mar 2024 17:03:49 +0000
Message-ID:
 <SJ1PR21MB3457C456D13346088AC78356CE282@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1710336299-27344-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710336299-27344-5-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1710336299-27344-5-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3cfefbec-3478-4290-a2e1-726f68dc64d6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-15T16:59:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|DS7PR21MB3220:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 F8WSm6EuGaBf04Oq74NF/83o7bsDNuV3lf+lgjj5lqWZrzqYZmpptEHYLV9qEHUa7jLQySpff2Tk4ZaOP8eFTVRCpcLZRqeb1Oo8+k6H5LOda/BxRo9ARUS9ie6ki2HCY3Ph7QcCTxtMyiLMjvyJzxxGx5QHWb4bdhN33WsYR4ikzN4YgIkfE0n0kqZVbYN+zKDFM3fwByA6HwtvtljpfV0GKF2WcOW2fbEMe9Wotj4KG3n5jCLHM4DxawLOPOnMU9dir9heODj6yTFHD7B7a+SQFVArAH/E6Oa7An59YIbX+mzyflcLxHi+/l+Q/XEvOTQO28+feOQfVMeYrlpRxoKUpymOV2GAgL0qpOFKbED5hwYTgJuHswfb04tvXFQ8PeF+hV8XpwkDq218QgOGeOkVjjN/7v2oT3d0IxxE9Lx24OuUV2u9MzSti86u95U1+DFrXGYMCGjUdTtz3QlAHoxT/L3SbX85ivHf9KGSc64oDyIXTajhM9NMA1LWcDzIzpj4MZf685W0W8CFGtxnoAxVkilBxUjxufR1ew2WDc0DQSWSaSWG5VXG0ssgEsImA7XWsv6ZQ68S/UoJ6vLR285dzSg5S+pmrN1q8dBiGPnwLwR7Mxqohg+g0Xq7vUHaGx0paVTtSYQTtwbJc0x1f59ZhbcPGMPvfkhlyeK+T/k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DdP/nzkoDhLiH1CdCk6coUR+xvuxHGGMwD4zgxyZ5il6/++bfppJ4IUSe04Z?=
 =?us-ascii?Q?kBugNGwW8bqITmPE0sz17RoC4tIGDbAynl65RSFRin3sVVYKD5wi01kWzpNm?=
 =?us-ascii?Q?mqG/ZrFVOOntHDzHC23ygjABJPl6FpHdNB7t2NrZZ7KsuMaUfFzwYl1JkDZ9?=
 =?us-ascii?Q?TIlyYtK3Wq8vntZ0BBzCirynz850gyNXkpCsMtvAS/OdLew34ph2poUfy2Fp?=
 =?us-ascii?Q?1mvulvNWoMbhTzohaufkwoOwaaHiWdRWlM0/O0uJjMRJ+mAd8RSrjdv0lOtr?=
 =?us-ascii?Q?ZRaYtaIMs+vwehdUSH8tjmdSS5drEDXSQjMXASrg61JiiQXFygst5EFpDYGh?=
 =?us-ascii?Q?LkjYPcZeAYglIHnKvIG8U2Jyz/Rud8gnNLN9UfYa62gIsnFioBEHxR0vjHTR?=
 =?us-ascii?Q?AfJHSZVmhOfXINiMbEEpgkAg1C1reU5kDgs/tjVUxdUU8UDEjBS9fpmk867L?=
 =?us-ascii?Q?86z+9S3on+we6mfE/XyeQloqMC96X3nfYtCAp7ZWu4VbsL6Ib5AL/iMIl5LN?=
 =?us-ascii?Q?W7nQ/QfC89GOL1p+ZoFmbBV5uqBiiyU4qzyTQ0nMz1265VQwS36lW4ZXVNrN?=
 =?us-ascii?Q?U9YWB/wJNzMFgeJQLurClcAtrVpgQ3lSD3rttdVvD7ftAzh85Icstypsnb2b?=
 =?us-ascii?Q?hUtdiqEu8l6cfybx5hPiYvEUHN6VjKvoi7HPJQzS3RqJxMds1Zc8/uhTbi7b?=
 =?us-ascii?Q?bJr6c0L4KuisPCUfMdGyX/TcolJGS3Q1sbM2CFnOU4zDqwcPuTQFmTWKSn3y?=
 =?us-ascii?Q?x3XNclJvWm8hLIwyAju1xr/4bwFXf3lHJEsVJhSswN1xtrhTFpAtXt6ioXuZ?=
 =?us-ascii?Q?pJETmru20BpDozC6VBNuvXs9livdX6xIbah9aKTB3KiNiMudioQvIoc6uRBB?=
 =?us-ascii?Q?Yv3v0amJUCyafeC+2oE/j1w01O3toOKysO0Cu8YrvfsKE6H7Pi7hSRFXANT2?=
 =?us-ascii?Q?WrOetzSS30/r0DgnZiADLbBCLEpaWk6CpGIJ8hknxYBtRkxc2Q6eBAYKq70F?=
 =?us-ascii?Q?VH/xmycMi46CA8vAJeU9tgWVXJu5glFHXjt9UPlZWRwlukTaxAAUIv77jpP+?=
 =?us-ascii?Q?CwmMSHX2B65gjKA3k5gcyoMfUjGHAW9yGIMz91RqMNH22KrSo8KSY/FcYyl6?=
 =?us-ascii?Q?MW8pAfO2jELe663CYwG+MURe3jXPM7OM3JdYWWzVV6uSMQtZ4mBPs9WNoSqQ?=
 =?us-ascii?Q?BGvX3A0P9UDD6KSc/MPe9liQX3cBwy0aLQPfyKrKd0vDsBfYS8tqGF3mHKBi?=
 =?us-ascii?Q?EyaZTxQ1ZD1IVNPcbgTU6P4KuCI+lrTPz0z+tkJp7BHh9XjGCsQFwReJpewu?=
 =?us-ascii?Q?LNx4ywohTYfAgA6LTGTmFkdzahUKY6sjVIHazVjpYdBg/oSLavpIsurM2g+f?=
 =?us-ascii?Q?zseaKjhL2E8Ui15V3kl9iQqXUDcu9As/+WCB+bT7PBcxTyxF3ACpjhSL0QLT?=
 =?us-ascii?Q?oahwKGXSh9Oh4DhFx6kUHsawgxWcQG1bApijU6jUERYv6lmRq0nKPaxj4x/k?=
 =?us-ascii?Q?qPYAIAmkITpJmw1M/V8rTqFkkhM6Ws/JloePPXk3cegnCdo9vdm/S6wyZzfP?=
 =?us-ascii?Q?UwD18AQhboEXLZrNBeiRX673mrXf/KbV3E2m81dB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e98f746-fbf2-49b3-83e0-08dc4511e29b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 17:03:49.7883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ot+omA+1MQv9U+bn0icNNCzqDE+S/JohUeaVT4lywDdiD7tEo7UiGGvdZ3E39dZ3kM6N8CClUOhJ/8GRdz44g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3220

> +struct mana_ib_raw_qp {
> +	/* Work queue info */
> +	struct mana_ib_queue queue;
> +	mana_handle_t tx_object;
> +};
> +
>  struct mana_ib_qp {
>  	struct ib_qp ibqp;
>=20
> -	/* Work queue info */
> -	struct ib_umem *sq_umem;
> -	int sqe;
> -	u64 sq_gdma_region;
> -	u64 sq_id;
> -	mana_handle_t tx_object;
> +	struct mana_ib_raw_qp sq;

What's the naming scheme for RC? Maybe use raw_sq here?

