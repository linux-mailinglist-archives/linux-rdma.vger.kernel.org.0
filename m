Return-Path: <linux-rdma+bounces-8792-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BA3A67B16
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 18:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D293917B09F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2016F20E6EC;
	Tue, 18 Mar 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HWw7tk7J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021073.outbound.protection.outlook.com [52.101.57.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61889191F92;
	Tue, 18 Mar 2025 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319463; cv=fail; b=PkGso3Pl176uxwuRgxnVk+JKfDYvQkkUwH+/7+f1qFQAiyxdqL8VGVflBfs3Y6dbz5HTKNeGehmLHSga/FCz+QmycDJEqWGuA5EaWdZUAdEjbSEbfMZKPBwUmCCQkVeTmBo/6h035pUxvBd5hkg5QY/QQe5KxEJ85yTo2VbKUaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319463; c=relaxed/simple;
	bh=ch2ISjKp0JXilmxMyCHzEhXPKbHqo4y1dFyZDWH4Xtk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IVNQFybBNXJmuL3Cpk5joNKJnArofGGmHbjW8Qz3hhs5FR2EHPhXv4x8QfuzHVItheJpVa492TgbgLLpcuz3rAJ4+7Se1z4Gx5kZZ4Dws2pNxYYOT/AgjcNYTyH9weIttE2LEcFsly6RE9B5ocjL97gMOd+hiw8cTi5lamtDqF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=HWw7tk7J; arc=fail smtp.client-ip=52.101.57.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFd8spm/1mPud82vl3KrsjdvtwCzaVj126TkSOtoUdhe1Q0PlISisTgTWSPCcRXBy7nBWdcvSKjoJ4MS2AogNM9S67DcDDbTsviVtFtX0uc8lWbaUmJJKedMKekGgtoQ+3jLKc9KdlUN53tbDbqEIMRXRk7VqmUzqdNlm7tUM/9SjcdMVik3Hny7+bzMP07TJvYorvPgxpe2G4qS667sZ1vhHKZ2v3aT8hIEbZV1NLd8XkaqFZ0FbnWu9fEr0RnoaoSLAYDin0IsIcCFV7gXJqY9FPIDD6GvZVjy0OSCuVgKFE3XtEju6x6boKaN/1gFLjIvKglZ0jCPYyVhBKD5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QE3wqlS4zHjyXSnUvOGaC3QIupx9wddIiHzP+p+fmHY=;
 b=pk0YcOUrlWQyipVXxoMyOimHnkAl5JIysEEzzhuiuJJW+v7RtG8aUlLeDeurEuARxeSp7iYInUbXNiUb6GtIssGgMRRjL0Oy7F9hIJy3OI6yZVR6nk/K4GtOSNdTWZKxaRL9QM/eJ78ggHUGkm9+l1UJ+pAUuMBXopVS9tp7T+R9X7tPC/gh48w+x6anUrnLofIHQ/agXpjYzNtdxy3bxQXUp/kH8stDsQqIugHJdC4bCOZdDHcSe8ZhHogYsbLUzDmKsNjgfg2581EN1JfrTr6Wuv7YiSzk79I1udXOLaUSzUlnZZR/fsz5ZSi8atRmH1rOLllBRiU9uuyPUnPX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE3wqlS4zHjyXSnUvOGaC3QIupx9wddIiHzP+p+fmHY=;
 b=HWw7tk7JepEimFaCfiivreohE+2PDtq5fAgLZzngdpxVmNnbhnh/V03r03Q+zTgQZY4PzDl48Ef/DXzCAk+BTVsI2fvRCZxQD3F8FN1TnA0/ijGBh13B8g0vlmds8PHqTLkyqL4cvrfhi0CTJz1uiSF8CDSM12oPr3W+lNwneQA=
Received: from LV8PR21MB4236.namprd21.prod.outlook.com (2603:10b6:408:263::19)
 by LV8PR21MB4275.namprd21.prod.outlook.com (2603:10b6:408:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.9; Tue, 18 Mar
 2025 17:37:39 +0000
Received: from LV8PR21MB4236.namprd21.prod.outlook.com
 ([fe80::fbfa:6b1b:d4eb:1671]) by LV8PR21MB4236.namprd21.prod.outlook.com
 ([fe80::fbfa:6b1b:d4eb:1671%5]) with mapi id 15.20.8558.024; Tue, 18 Mar 2025
 17:37:39 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 1/1] RDMA/mana_ib: Fix integer overflow
 during queue creation
Thread-Topic: [PATCH rdma-next v2 1/1] RDMA/mana_ib: Fix integer overflow
 during queue creation
Thread-Index: AQHbmBzRl5iH4j6VWUyWc8UjUaY85LN5KIaw
Date: Tue, 18 Mar 2025 17:37:39 +0000
Message-ID:
 <LV8PR21MB4236C2474B900EB82EAA49CDCEDE2@LV8PR21MB4236.namprd21.prod.outlook.com>
References: <1742312744-14370-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1742312744-14370-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0302c7b9-cc79-4d6e-9fb0-ea9916dbdd9a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-18T17:37:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR21MB4236:EE_|LV8PR21MB4275:EE_
x-ms-office365-filtering-correlation-id: e2f6df05-d745-4c31-504a-08dd66439448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UUgcyx2CgbqlST2bE/Dsdm9WTK+ZxinfQfVNE8r0Jt1BXy2rxma9QfpGMOM/?=
 =?us-ascii?Q?90aIKEZEiO0XIfxsYq3aVfKxeMJGDAihaimxsjhwZ+WjjnP0nnHYJC+WqMo/?=
 =?us-ascii?Q?zLFLSRENiNkHWKNuCAV0YbgMpsFeX5EoHzTLhEcdrvjMb7VMQKZXli34JV7I?=
 =?us-ascii?Q?GUMfKz2xX0GlVrGIaeUa0tTFUENHyVGpm/5RXIF2nI2rvI0ttadrYeZbPb3T?=
 =?us-ascii?Q?YgdwJB3bhgnKNvjrHT19AQEroVgQg6Ra+QH/ngq8/ZwNpga/ElXT9MJ2p3yb?=
 =?us-ascii?Q?w3amvb2BWMf/Loqy373QnzLqG/LNKB6R6W9olcX6OiU/eg4CbI3pOpwkLY+d?=
 =?us-ascii?Q?ZnlGA2eyHBSBMWwP9TDDwYPDL6JhWouoMeMCuhdRZCvEIZt6LDtBI0diq3/5?=
 =?us-ascii?Q?DlxUfHAajgEckMvMXyXete1pUc1HoJfakhiUiuQP4uzrJtYBXOyvQGbMD3+D?=
 =?us-ascii?Q?FA8rZg4lZ8zYsjbriWvRtHclzqFy2pxMmlnIKnG7g+sjI7HOY/9n8CV3WN0u?=
 =?us-ascii?Q?hPB/RRSXD96H8AnSNwFM3h6q30CUwU74rQw7KXxDb3rZX5frAn81GOzj8NtG?=
 =?us-ascii?Q?Ce4meJOr+uvRIf57M6DTGW899262yM41qc3X0yJFhQ0CefxzwpHmQV3HJEy3?=
 =?us-ascii?Q?ij5hmaDnRCQE4XAahBI9R0OuPy5DSMmiOnwcOqntuYvuyoHWNRtCH5N10ico?=
 =?us-ascii?Q?DYLAIedEHIEQroGI/vBOEI5/ZDZdlAX4uwL51hllq8ZW71KLRxSWxrzw04vN?=
 =?us-ascii?Q?JXtfeh+VN2wXt+aJ0xFGYBiXLQumctqtD/m1QHzAldn5Oqx6aORnbQ28NRFV?=
 =?us-ascii?Q?7ukomXF4IzBf7co09OrGNehe5PYuQMTvrbrB7uqak8ShU8XdfIGs9XufmSwq?=
 =?us-ascii?Q?5rmvuKtHbghUPu0yJGO8wTWXMzYq+hndNS9CxrfuhxuemYn4q35UiAjgW+aV?=
 =?us-ascii?Q?14gzgfcFECYb5n+J37rJRQn41wTfvu9rTTPExOp97AvDBlX3AIWqjAjVCm9I?=
 =?us-ascii?Q?baX8xt4JqgFw5RIZjRslxGYUkPHSWvwcxj/pnzuVMKDQ0hzodPsBvWm8ER+c?=
 =?us-ascii?Q?7wQYnmD2b7NqvXC74lW8ozkSZRLw910ggT+tF2hb0fNP183RSGMypkVhOyxl?=
 =?us-ascii?Q?NzEOIoxpnVY1djY7jz+LSytBLVS4rMbHIUAP0I13H2+YBdytuB4YFithEDaC?=
 =?us-ascii?Q?p3G8sd+kDR80f8gPmjaVRrQqpVkL3waVtY1is0tHzVQJWmmIwiYKP4Xj+c6C?=
 =?us-ascii?Q?1FG0yq31eXPy/l9KE7G7uxhtmJGLYoS/M88Xu4nBmPKKa1bBXfN9uNSFuY9z?=
 =?us-ascii?Q?xie6v6wiKqHRIox3Y+UHHgJZ8R2pTEFMUQGBVfUQA/1on87oUaAPyjKVKLVO?=
 =?us-ascii?Q?25bxbuQ01CGIOOtSFpSrK9k1v9tJPVPMDD+9WiKx3q30ZiDCmzdf1E0cxTm1?=
 =?us-ascii?Q?ipSkXofkaR6rNkdXF0LmFFAUBvtcwpDg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR21MB4236.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mD8k5gPN8SxeYLA6FaZ2jop0QCY4X3SgFYDCs59dKKX8b/tJzv/8s2jLZbLN?=
 =?us-ascii?Q?XM59f2+vPr1QG7a7xYqC6DZJyScZyiuZgCgcHPmbji37oGhHTrmNor9kFBon?=
 =?us-ascii?Q?GZ5ilmzg541DgjyqYjhpPH8JL5awlVYglyVj50Aon4P6m/EatefW07yVg1Jf?=
 =?us-ascii?Q?Hu++l7+imDpOz6vd068aQJSgJSpDswMrSjh22YCAo6KSC4qISFUbuXEH+i3v?=
 =?us-ascii?Q?NeOTlzRNKoS6pYOew8dlG64TCcT7ONFQ1PRgngi+wrL8w9h5YJEOJT6dlXTE?=
 =?us-ascii?Q?ezrprXmRx2uCbyvlzmd3TiGjuOXBeCl78UakgNlKIcwgPk+0Aje/d+hFiL4x?=
 =?us-ascii?Q?E8EPg3L2fZFQVGCiHxvUdwkcpHmHGI5b0FCId7O763VpfcXisZCO+dez7kym?=
 =?us-ascii?Q?CwGWP3Ec52JXy6D//F7CtyOpFK4uSl7q+ukO/cerfT+Ezq4+YwNlugS4lzwn?=
 =?us-ascii?Q?BIomkcOscW8uD/jlQkmwZRI0ygxh2y81CfaIKL/symcFhyWLdmHjLk+UeKw1?=
 =?us-ascii?Q?JVia0m56uuaLVMrQtpzV/YmJZPn2b+P0J1GOV72CgkRtjgmUiOhHOSB7pBFk?=
 =?us-ascii?Q?5Z1w+H8HdiJcZgnpyjtyAku5Dldtu58EBAoQAifCVq49hfRN982r/qOGl9DJ?=
 =?us-ascii?Q?fcsBtEmo2+rwhKJSZfik3c2AGdMO8/f/llcrZpKAEYmXtRRBJ/Hu6/YWF8K5?=
 =?us-ascii?Q?jBMEEvJanHvq8g8Z3NvJhFUVmPYk75bzxRqE87mt0s54BNr8rx3ryGmqupPa?=
 =?us-ascii?Q?qTQrn7l48itz2s5lvOZy1prVHSmr/fTDgWfu2PorOY/bcRCP7q7zsEUs5oij?=
 =?us-ascii?Q?iYpBqEw1BAPrJHZmyBsd0bi+gT3zPOW7aVvJBrik4v0MgMpAQ5rCU12EmljB?=
 =?us-ascii?Q?e2ur7qNtlzr7elUcpWqCge1SJf8ZgvSFior/gf6t6KyE3oeNatN/GhcuX3Bg?=
 =?us-ascii?Q?qpqlrqJK9My2Ny/QMUJX4Ck2v3rUhsHdNhCUEeCxqVzjfjWWIdhmtOsRRxLi?=
 =?us-ascii?Q?fHgMIePlfoEEcnjWaaxq0voEwWhqjA28NmpiUei6tXSJYRVxf4k64UHCdffh?=
 =?us-ascii?Q?igtc8t6kZAUVFVN0t1Sn4bLyyFu4layRjpxaSIABhpHA0YL8AXs7f/0RL0zt?=
 =?us-ascii?Q?c15ntG9ljEhr+oeq304goChAMseBde4y0wMfTjA556AcBLnuCfNITt5OPOj/?=
 =?us-ascii?Q?RKfwJK+LoGXxlOoZ8pglK4JI9CsC1V7+taU/69c4YkexhcwTxPw5K9UxVPKt?=
 =?us-ascii?Q?GaUIeZOtNC72shdHhx5vgpTm8zT/mfuDj1tFDECZblh53NIrOByeN3kHeiTa?=
 =?us-ascii?Q?jc3PXnsbvCUU/OtaYYUrCHMoQ9V64f8YOu5vk7YjrdvtpGIJv3qkWgcq3usU?=
 =?us-ascii?Q?TbSNLFnqN3SJmB25ex1wKEDzP1XRg2seKlm9IYYzFNQ1yYjbwRDKjGSpI1c9?=
 =?us-ascii?Q?w19t1VdHnncxP0SkwBbdv9tXt9G1v+CFliAJyUspR3ntNJyk0dXfWBk/A//a?=
 =?us-ascii?Q?EQ0tqQWN96uuF2JhtfS+wY+QxfzYXUXYaJsU1h36HFzR47N0kjOBNFVeRjFn?=
 =?us-ascii?Q?NHel02MMqKJpOTjCZFqbOI/SblnFouX3D41BsRW9?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV8PR21MB4236.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f6df05-d745-4c31-504a-08dd66439448
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 17:37:39.2864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXrw5ZLQwTsGo3vrod3J9LE2LtR+MdHkaMHqvyJimldtPzpl3nfyAawmtfrYsgFsJPVOJy+F6JnVa6saGl1mxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR21MB4275

> Subject: [PATCH rdma-next v2 1/1] RDMA/mana_ib: Fix integer overflow duri=
ng
> queue creation
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Check queue size during CQ creation for users to prevent overflow of u32.
>=20
> Fixes: bec127e45d9f ("RDMA/mana_ib: create kernel-level CQs")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
> v2: Only check the size of user CQs
>=20
>  drivers/infiniband/hw/mana/cq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index 5c325ef..0fc4e26 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -39,7 +39,8 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>=20
>  		is_rnic_cq =3D !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
>=20
> -		if (!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr)
> {
> +		if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr)
> ||
> +		    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
>  			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
>  			return -EINVAL;
>  		}
> --
> 2.43.0


