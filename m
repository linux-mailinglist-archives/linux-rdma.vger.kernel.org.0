Return-Path: <linux-rdma+bounces-2543-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E738CA2C6
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2024 21:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52DA1F21FF5
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2024 19:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB391AAC4;
	Mon, 20 May 2024 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XpH2G8QI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2095.outbound.protection.outlook.com [40.107.243.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503BD1095B;
	Mon, 20 May 2024 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233875; cv=fail; b=IjOvFwSMQ9U3+EMImw254UDbAnzwZfFoeCegA0/NjpPRSTjU7e00fnc7tr+F/spCIOWReYVq4mW+O0/hw0+QXEoIZzpwwgcB9WNNKDUXssTN7W3rFmdewrnYgY5beqUHTrKczIDlF4NFjVuaHsn2IX37jMaQX6JqLRr644Muwyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233875; c=relaxed/simple;
	bh=9ozTYqYDzWiXim3O4LRYW8uG6hAeyDa+oLota8vDLNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eHYP63qlaN7KdupdA35UMXwcj+f+1RKarrFZ3evXi6SUdR6kxPuZ/+zJaMQjEDlZYb2rJsayHSMAgVlxizjTZMXGhToE9ukpLLnkqalgnoIpwGPHTLec+q7sFqcDt0f5nJVdM2j9ZhkcROkmKngyMqMwtW5H9BewbO902eLphEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XpH2G8QI; arc=fail smtp.client-ip=40.107.243.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xab23ypVZuvxU5KcCk9gZtGWZaSnbWPDXYFcgZ5XNguJ+8ue+E+8eBi7ypi0SYqG2VwiCsQSS37LXwciV3L8HBc1eIsLidIDi2lSsAsMErHauC+NTkDZ0QxaxwtTdw/QIHGh6yXmtfvpPyBHbyixm1xDka7NFXIs1o8QKmdGL502tuc6M5BLK+dK+EMnR2V5YYPEKoAc6NmuabuT1J0bVbOk5BXmPnfMUXBajGzp7mDubFLN9He6jdtRv8fosDwYciF2kpOU93YQ8xcuhm4o9YG45seoAW3WPB69mfg19OrQ/P32ToW1L4onyysa7rU+9DNanm9X6QT4kVaR2Zr3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9hoLvTQR65DEW1zHWd89c+BSkrX9Q3NtsUsim2cINw=;
 b=X1qyTGxgtR1+J9OPGZG/tAPdUqManYsWY3TsLyVVvFMnKOmd/B8Xnim0F7ODYyCNLYHu1cl1j+tzJaPztj4rlplLlhsNCR0+l2mJ9dq/OflR842q+qq/ILuyqOEw2hFFmLOGjgUAdoRbNEDLFhYBEUyO0pYLXRWo1ezlC/WZAsWQm8KABdiMTJuH+5j1hU4AWU9yc5ynKZFNlLhdmHoQHDpKWFStc0XUIrvaXTqJYMTdZsJi3uDsinUAdq3bOyhcpPLTUnIn9GSKUVEUJpHd4l1HTYXPt2AZb0sqRUAOwYYguuSBC8iIekXzS+YOlHmqC6zDGdKaotapBimJ3SU+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9hoLvTQR65DEW1zHWd89c+BSkrX9Q3NtsUsim2cINw=;
 b=XpH2G8QIFdDdwbtOlHB1ZbYeZiVfYVb//SGcUWFFkx8Mx39eje7lAcSoCfYfG+/6Et2ehp60vUl3PGoh/eCip2UBXpG+4It6WSOTlM6XDjMo+Ps5jWhXYb2BmdqP6fhfaYZq+FEFP2qnidjKBTc4i9dfO/Ghr94uvbc/2qG/Qfs=
Received: from PH7PR21MB3071.namprd21.prod.outlook.com (2603:10b6:510:1d0::12)
 by SJ1PR21MB3456.namprd21.prod.outlook.com (2603:10b6:a03:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.0; Mon, 20 May
 2024 19:37:48 +0000
Received: from PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a]) by PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a%6]) with mapi id 15.20.7633.000; Mon, 20 May 2024
 19:37:48 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 2/3] RDMA/mana_ib: Implement uapi to create and
 destroy RC QP
Thread-Topic: [PATCH rdma-next 2/3] RDMA/mana_ib: Implement uapi to create and
 destroy RC QP
Thread-Index: AQHaoGRnSgRJGGLlNEqrOLQaIRx7MbGgmSLA
Date: Mon, 20 May 2024 19:37:47 +0000
Message-ID:
 <PH7PR21MB3071EF8F3E4F9381C52225EECEE92@PH7PR21MB3071.namprd21.prod.outlook.com>
References: <1715075595-24470-1-git-send-email-kotaranov@linux.microsoft.com>
 <1715075595-24470-3-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1715075595-24470-3-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f547d5dd-f3e3-417f-9124-0981488d0d41;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-20T19:36:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3071:EE_|SJ1PR21MB3456:EE_
x-ms-office365-filtering-correlation-id: b6f3e1cb-e787-49d9-2865-08dc7904541a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lSQZl2PLcwK6W08bw9XVViQMfUV6PKOg9XKclHdMZMDU5ZkdabKFETlAfDUx?=
 =?us-ascii?Q?fUH5D6PtyxLa6DpFeBr/8/OzS/J1dQBG793ZRsOxTfUHS3Is2503tItYJBC1?=
 =?us-ascii?Q?JTLvt4AYIxobarfuAw/uQ5nqpEOhafOF3fASdx5kxr8PPwo3oKHpxXQkVh2a?=
 =?us-ascii?Q?uLP1nSeQLIk9+W4Jn2CJcm4P5h6OCu8ytrHQLyzyQzHmuDJuEofRSRiR3i4W?=
 =?us-ascii?Q?a2ce6s9KkpfiHTz+iFJ+d+AVjz3qqKeHC2MeGOhkGhDOxSCZOi4hpVNwL/PJ?=
 =?us-ascii?Q?pI8DkWNcSQEAQaCAIGJi4gcjuyg0GJRurPv0fn1GUg39jCb6X5bP3vHlJ51u?=
 =?us-ascii?Q?PswaeU3DbfsO7OEw0PpC6OOvt51vgLra04zCDY1oSCAg1E+CJi/tTZasCWkE?=
 =?us-ascii?Q?0qpx5I5cOfYotlV0TvIZjl8VALE8CMc60wdG71NMvM0ZysYGdjCrbdvpYI/D?=
 =?us-ascii?Q?JTHazBumZKLYXqTjTILi8m2rVlT/tmm/kTjXLaKkUUh2aFVgmVkjnW0bYHiE?=
 =?us-ascii?Q?GMUd0hYLuNdoAYZQOXEXDLG/A+Qz6VeEestpCn+1A1PgjETLfPa0Ewi+yrTA?=
 =?us-ascii?Q?uI0G0KghIwevFv8/NrW6ShdKkp9cZTy75NQL9wQ7OLWj/22L2+NazwkkCjew?=
 =?us-ascii?Q?kjA8U3O0X052SA6z8YYpmaFxo7RKOOhpXbjpyJIbOdE2YYIc3qHTCAVlkiXW?=
 =?us-ascii?Q?OJ+YGNfUw7/leICfZiAD7I9mDLoHLBcn+8e3ho2jQGMyJSQ29EZYZkO9FyLD?=
 =?us-ascii?Q?57aYCPNtwuAWWKM3g7xMhTHC09iOfsooHpK9D0iau5EJOOGiDNAHZUUVEEf1?=
 =?us-ascii?Q?spFtQXJRaRAwfrCo/SGSWJCJyw/GaRpap0y3lnZla6+vxGV0yLnGaTeCsZYT?=
 =?us-ascii?Q?9m7NEcBzBF/QMJmMKj4fTYB+0fdWMlYH92/q+eX6LEZ/nKesqGbkCfAqmmaM?=
 =?us-ascii?Q?OTsYSsve/qaPWfutuDtP7vxXieii6w8BSNOxz12ZL6GcYRgDZw7XloUf6KaE?=
 =?us-ascii?Q?xm5R1CLXVGmYjjID01zuRP46yrygpfu5R5/gb55r+J43vrf6HpT1WxWoz4ET?=
 =?us-ascii?Q?hsIjrg6yI9674GUkAOxteLT9X67wS6onuTGE4HISc1Ul5NpqcZ5JHE9imG/g?=
 =?us-ascii?Q?PnStfx9Cs9sR0UMYpaS/YI7j7tlCzpQ8sQECYTsH1ulThFOC+mUwUYmbpJsE?=
 =?us-ascii?Q?/7K2qFrq4zDofSul1qPS4JqbJhnABlA9aSakKrCWkfZT2ERBkft/7Wr4KMDx?=
 =?us-ascii?Q?yAAMpDVAU5VouCIlhPd3Ztk9Nqc76D18qqx/6HBbB/O0dNrxHNSahwWaIU93?=
 =?us-ascii?Q?6T+XwSXeDd8wU5hCxVP9fIwy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3071.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JsBiDGGU+/krBKCES+1aSrGyEivsdnadtLdHBj9Sp5z+2C6iLDg3mz8ZYSDi?=
 =?us-ascii?Q?CgnErmL/8hzhepau5ReUZhLz9XQGt5uMJxi7hroWCNkG3tfZyO7Ipwm1+c8c?=
 =?us-ascii?Q?+BCnzTr+axOSool3QfT0+0dOi8rPANVdEpwWaaxaAGaXXva/wNX6XAc41xQC?=
 =?us-ascii?Q?oehR+cfEgeZZRn2Qul2cWKCfxybFAiLkWsvbBg8Fh/+0h6owSRwzcSEEulAJ?=
 =?us-ascii?Q?yHT0/pBzg+u4Ew/w06VJ8PneH+QoKeMFOmIJaAI4SzknUpgg7exMlVSk8xWb?=
 =?us-ascii?Q?4rq+CoFT3x4S2pGOG2oQSjt/4Y0lcjExgl1XQodIAR1hBaAHMfRT14OcKcXW?=
 =?us-ascii?Q?VHG25T97ubj/REXkD3poXZlJJaMHB70yUPQeIcNyMKZWEetnE9IloseKZgWP?=
 =?us-ascii?Q?0b4VLHFUU484tyCWogKhLilHqbFrYvcBuFoOsf2K6o8pr4Z+jEsBnccZd8ZT?=
 =?us-ascii?Q?CWo2E273IBdxIOIuMTu+tyoCC2fRxlmll/m6zYw8xnV2MiRiCzr2YBTXSTDQ?=
 =?us-ascii?Q?qQKS+bu2oo8abMrxpjGiOysKsYv2MgJ50k7tYai2TiNTVZlG8Eknkh6daJIp?=
 =?us-ascii?Q?UmGXvox6MC74uBMbt14ZQyZqoxheqw9mw1vLa2ll4QpM9EehmI3y7Cmg4Gsb?=
 =?us-ascii?Q?ZWNrMOsyLj4ER1Rel3YETu3ge/dOhiJRSxK0ddu3RmKs0DOIiYbelIr0uM7C?=
 =?us-ascii?Q?P4qt0Ijnv2uqVXoeDBDmhC9Fss8WpdWBwU1taO/9gV0uRjvb6DT/UHpndsx7?=
 =?us-ascii?Q?p6Bdr5BTW+vXHC5xlFnFLNxwlFphiidJOueSf/KObyb19ck2zlLsOo9yc4KH?=
 =?us-ascii?Q?H+j9Xe3GYJQ9W8ywwLxo39j/ItPIiK7Bogh+n4Ej0Z/tXTtw8G1IMC3YP9QL?=
 =?us-ascii?Q?Q0mDu2aO164Y9zokSO0fCGiwRgDPYYowyU4vd2v/OO2F4EQlGWFH/Zmlkkzu?=
 =?us-ascii?Q?W5A7VuRNgUN63wVKA0BJpcW1KSnKltPcKBbYZYdcYKO6lQE9fxwl4GxcgUQr?=
 =?us-ascii?Q?m/UxAFyPlQZgpT/VluzBwRp4DVym8FXqVffkC1ZhFRGUEvmHUTRjPffJXIBM?=
 =?us-ascii?Q?IBpx0N9pVxrtXTkauf2o0BWxm41VsJ1g0D5EKfJj23hEztymXl0EakMdY4hq?=
 =?us-ascii?Q?JrQjSrQDBHSWp/39d0+Qp4qAy5yIpNgxPQGs0ujzTnljckwtN23F10bfqXWi?=
 =?us-ascii?Q?kWgKEDAs9PN4u06L0YIPk68xGR/0XfLop8KsZOspbhXNVKS9p1DJO46IzH2B?=
 =?us-ascii?Q?S1/tsgDHW5tk9KEEsEzNbWpeal2+ohKPt0GWK/+sjhcqWarrljNQ/Ry1BeOe?=
 =?us-ascii?Q?pCd8xXXNcz111T/jPN8lMNh0UhekV2yVB66C+ehXdsKJsi4BtDmNs7X8fhJs?=
 =?us-ascii?Q?A7ZuW19N0MEjRG3JQPu6X10hMBjAXBXfPpLc7n3eUMPEL9UEGI9N8elTFp3J?=
 =?us-ascii?Q?Bcrdj+Avjl5bRQobyjZ70OUP2og/q/5eaoW8dvvI1Q5zgwdAWqn5kVDWtTWs?=
 =?us-ascii?Q?bkO3sdmmTCHqdWETuv7WOErC843r8C+LyzSR0xj/r5bYyISAXQk0xa0Ss4FM?=
 =?us-ascii?Q?kGiarttQq0lHs7Hn5c+bqkUJr902lwuQ6Hb15Mrp?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3071.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f3e1cb-e787-49d9-2865-08dc7904541a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 19:37:47.7361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmfY7BcxUsMYQGJsuoO07XDo6lfhiPRpKulESqb630eQjqzYIOYihtE6HvPkihbv30XygZxr8L2pRcvG8Ov74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3456

> Subject: [PATCH rdma-next 2/3] RDMA/mana_ib: Implement uapi to create and
> destroy RC QP
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Implement user requests to create and destroy an RC QP.
> As the user does not have an FMR queue, it is skipped and NO_FMR flag is =
used.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/mana_ib.h |  4 ++
>  drivers/infiniband/hw/mana/qp.c      | 93 +++++++++++++++++++++++++++-
>  include/uapi/rdma/mana-abi.h         |  9 +++
>  3 files changed, 105 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index a3e229c..5cccbe3 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -248,6 +248,10 @@ struct mana_rnic_destroy_cq_resp {
>  	struct gdma_resp_hdr hdr;
>  }; /* HW Data */
>=20
> +enum mana_rnic_create_rc_flags {
> +	MANA_RC_FLAG_NO_FMR =3D 2,
> +};
> +
>  struct mana_rnic_create_qp_req {
>  	struct gdma_req_hdr hdr;
>  	mana_handle_t adapter;
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index ba13c5a..14e6adb 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -398,6 +398,78 @@ err_free_vport:
>  	return err;
>  }
>=20
> +static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
> +				struct ib_qp_init_attr *attr, struct ib_udata
> *udata) {
> +	struct mana_ib_dev *mdev =3D container_of(ibpd->device, struct
> mana_ib_dev, ib_dev);
> +	struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp, ibqp);
> +	struct mana_ib_create_rc_qp_resp resp =3D {};
> +	struct mana_ib_ucontext *mana_ucontext;
> +	struct mana_ib_create_rc_qp ucmd =3D {};
> +	int i, err, j;
> +	u64 flags =3D 0;
> +	u32 doorbell;
> +
> +	if (!udata || udata->inlen < sizeof(ucmd))
> +		return -EINVAL;
> +
> +	mana_ucontext =3D rdma_udata_to_drv_context(udata, struct
> mana_ib_ucontext, ibucontext);
> +	doorbell =3D mana_ucontext->doorbell;
> +	flags =3D MANA_RC_FLAG_NO_FMR;
> +	err =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata-
> >inlen));
> +	if (err) {
> +		ibdev_dbg(&mdev->ib_dev, "Failed to copy from udata, %d\n",
> err);
> +		return err;
> +	}
> +
> +	for (i =3D 0, j =3D 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i) {
> +		// skip FMR for user-level RC QPs
> +		if (i =3D=3D MANA_RC_SEND_QUEUE_FMR) {
> +			qp->rc_qp.queues[i].id =3D INVALID_QUEUE_ID;
> +			qp->rc_qp.queues[i].gdma_region =3D
> GDMA_INVALID_DMA_REGION;
> +			continue;
> +		}
> +		err =3D mana_ib_create_queue(mdev, ucmd.queue_buf[j],
> ucmd.queue_size[j],
> +					   &qp->rc_qp.queues[i]);
> +		if (err) {
> +			ibdev_err(&mdev->ib_dev, "Failed to create queue %d,
> err %d\n", i, err);
> +			goto destroy_queues;
> +		}
> +		j++;
> +	}
> +
> +	err =3D mana_ib_gd_create_rc_qp(mdev, qp, attr, doorbell, flags);
> +	if (err) {
> +		ibdev_err(&mdev->ib_dev, "Failed to create rc qp  %d\n", err);
> +		goto destroy_queues;
> +	}
> +	qp->ibqp.qp_num =3D qp-
> >rc_qp.queues[MANA_RC_RECV_QUEUE_RESPONDER].id;
> +	qp->port =3D attr->port_num;
> +
> +	if (udata) {
> +		for (i =3D 0, j =3D 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i) {
> +			if (i =3D=3D MANA_RC_SEND_QUEUE_FMR)
> +				continue;
> +			resp.queue_id[j] =3D qp->rc_qp.queues[i].id;
> +			j++;
> +		}
> +		err =3D ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata-
> >outlen));
> +		if (err) {
> +			ibdev_dbg(&mdev->ib_dev, "Failed to copy to
> udata, %d\n", err);
> +			goto destroy_qp;
> +		}
> +	}
> +
> +	return 0;
> +
> +destroy_qp:
> +	mana_ib_gd_destroy_rc_qp(mdev, qp);
> +destroy_queues:
> +	while (i-- > 0)
> +		mana_ib_destroy_queue(mdev, &qp->rc_qp.queues[i]);
> +	return err;
> +}
> +
>  int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
>  		      struct ib_udata *udata)
>  {
> @@ -409,6 +481,8 @@ int mana_ib_create_qp(struct ib_qp *ibqp, struct
> ib_qp_init_attr *attr,
>  						     udata);
>=20
>  		return mana_ib_create_qp_raw(ibqp, ibqp->pd, attr, udata);
> +	case IB_QPT_RC:
> +		return mana_ib_create_rc_qp(ibqp, ibqp->pd, attr, udata);
>  	default:
>  		/* Creating QP other than IB_QPT_RAW_PACKET is not
> supported */


Need to change this comment as RC is supported now.


>  		ibdev_dbg(ibqp->device, "Creating QP type %u not supported\n",
> @@ -473,6 +547,22 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp
> *qp, struct ib_udata *udata)
>  	return 0;
>  }
>=20
> +static int mana_ib_destroy_rc_qp(struct mana_ib_qp *qp, struct ib_udata
> +*udata) {
> +	struct mana_ib_dev *mdev =3D
> +		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
> +	int i;
> +
> +	/* Ignore return code as there is not much we can do about it.
> +	 * The error message is printed inside.
> +	 */
> +	mana_ib_gd_destroy_rc_qp(mdev, qp);
> +	for (i =3D 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i)
> +		mana_ib_destroy_queue(mdev, &qp->rc_qp.queues[i]);
> +
> +	return 0;
> +}
> +
>  int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)  {
>  	struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp, ibqp);
> @@ -484,7 +574,8 @@ int mana_ib_destroy_qp(struct ib_qp *ibqp, struct
> ib_udata *udata)
>  						      udata);
>=20
>  		return mana_ib_destroy_qp_raw(qp, udata);
> -
> +	case IB_QPT_RC:
> +		return mana_ib_destroy_rc_qp(qp, udata);
>  	default:
>  		ibdev_dbg(ibqp->device, "Unexpected QP type %u\n",
>  			  ibqp->qp_type);
> diff --git a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h
> index 2c41cc3..45c2df6 100644
> --- a/include/uapi/rdma/mana-abi.h
> +++ b/include/uapi/rdma/mana-abi.h
> @@ -45,6 +45,15 @@ struct mana_ib_create_qp_resp {
>  	__u32 reserved;
>  };
>=20
> +struct mana_ib_create_rc_qp {
> +	__aligned_u64 queue_buf[4];
> +	__u32 queue_size[4];
> +};
> +
> +struct mana_ib_create_rc_qp_resp {
> +	__u32 queue_id[4];
> +};
> +


You are adding new UAPI without changing MANA_IB_UVERBS_ABI_VERSION.

For this use-case, I think it's okay because it will fail to create CQ befo=
re this. But it may not be a good customer experience for RC usage.


