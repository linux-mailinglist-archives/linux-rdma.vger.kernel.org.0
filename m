Return-Path: <linux-rdma+bounces-18033-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LbfEf/8sWkAHwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18033-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 00:38:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F4626B64A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 00:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B4D33074125
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 23:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F903A75A4;
	Wed, 11 Mar 2026 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YZ7vV/eT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022141.outbound.protection.outlook.com [40.93.195.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6700377028;
	Wed, 11 Mar 2026 23:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272314; cv=fail; b=esRHZ8tN9rxjAJrUVgtIywMFuMNcEFxGknbc8jY9DPGmRHw5SHgKhvW6TeEVaOeudngH21X48kFwkvlUbtrKl0NKS95q6xDbwZc26jcfpIWQwZhg1SMoiBiirrmoxClfQQxo5Fa/uk1sCwSbcdPLcq0DebQXsdUQXAbEQS+ZZS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272314; c=relaxed/simple;
	bh=sfg+1KHQaqUnPV6oUKVND3oIym8vnPzNCBlHmaGDOfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Aa6HqcJyPXL5T57nBFzSSaO0WwG8aC6laQUflfLkedU5gYGiax+zWW+jX3DtBdlVozWWKFHNJd2GbLkhEWQ1iQCN6Xzz6tWJkoJXu1iqk/4/4cac4mEqdreRaFp+edAK0wpI8MFjm776D3OeDNIt6SKFrv3PKPBFdrtqbxAT//c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YZ7vV/eT; arc=fail smtp.client-ip=40.93.195.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRgqv176Taiuj2k2pXolJvk6TYscP4Fb2vx5IMNzHqGtnQQqD1C4hxjVZMW1ZpHNnrXWkdDdiEEY4XeJHl9qZU/t42xIBtzsbw8YFTjfO34IhjMpZzik/ZvYNn4kOJ6R9jype7GYtBR5aMaN++PVhncEG7Xh8LkZeOkjHtVhAj6MnrcHPpwThrTpaSKOMwPMPYTI6gnNb5WPgEcuu5IaKxXE5UlosWUy7/5hOk75h+pJHepJV+acpOuPfMibVHiFmZXbSymSqTyN3JJCAQuIS+rQ8PFMzI8tcPyi1UBqw/cFGU6Rh148mRPHYdtmxaZmBodUhwRTvwXymgwzDJ7xDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKgwg40Y4IhS7F6jKabKYKbNU9bYBNEjnciH0TVxIfk=;
 b=i+i5UV3lBWtpYzfjrUOmye7cVDoKqnuvQsdouFEQ6e/8T1rfmahejNvU9YlTRUKj4myYkfHmUGEdHngNKEv+u9U6UPkpjt31FuCRqcE3ajI/8pnf51eudilu5u2zxAN7eiVFEKqc1azTnWSEWwXMtd+9UchQywcprFMGafJ23u1NoUdKid7J3BpNcMZs6JLysWHqpJoNB0tT9780P0zs5XisCzgngGyXmBet1Syj89CpgY2imrBO5Gc4oUtQNyw+CnJyPrnbm0nelREqbmWzGeSyodeTZOIEtMkYcHhiNS3IrjvzTiCd2pU2ny55C4zKOK1wbRuAYS7XhXU2wpRrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKgwg40Y4IhS7F6jKabKYKbNU9bYBNEjnciH0TVxIfk=;
 b=YZ7vV/eT0+WNCEWWcJ9jW20CuPVxdXdlZ6L2la7PKIv0AW8KvLT8u6rgtDlia0o3T4juD9fvijg9tiqcbObEwF/mu6qCbWisEfZVcYyusU9Kx+ZtNiEiyCeinVthi6+HWPeQsbYc2rbOrlhTYmxxJ6bRs5mFs6u8T2mq1lAZxx4=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6128.namprd21.prod.outlook.com (2603:10b6:806:4af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 23:38:30 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9723.004; Wed, 11 Mar 2026
 23:38:33 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<DECUI@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] net/mana: Fix auxiliary device double-delete race
Thread-Topic: [PATCH net] net/mana: Fix auxiliary device double-delete race
Thread-Index: AQHcr+mQzNnDDX8ANke8oHb9V/p/hbWqAETw
Date: Wed, 11 Mar 2026 23:38:33 +0000
Message-ID:
 <SA1PR21MB6683CC13882DEB1A8F9EAE12CE47A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260309172415.688342-1-kotaranov@linux.microsoft.com>
In-Reply-To: <20260309172415.688342-1-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1897ff5d-3306-4556-b44a-358ac03cd796;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-11T23:37:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6128:EE_
x-ms-office365-filtering-correlation-id: f6fc8c90-7abd-4fa9-db58-08de7fc74eed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 LIEfBFNBBeJaoqzDCqJg3tqzU2/OFxUC71iX8xoQeZFSqWgug0Yzf/76nh1WoP/UE/U/G7U5JPeA0a7tI0myvpq+udxVlXaz+ybW9HEBPzGsLOWg1tOBXGmN8bqmHUhrKw91tVHxx7ymeYjLYdzXDzNmPQPEXSZr8CWB0aDjeFjHm/V2TGG7Fg9BKUwRG4Y8MhVMmXM7BCBYahbEQFcnuHZg+30ZbqS6Fd0yfORw1wt6UF1gcJjYoOmEOQe9QhjcMw0cMs53bTVQ4pXx4x1k+QADc5Li3i6/YzUnCP/7XCEpKX2oTSlgNw1F2ll/V7NFTxYTHve9iKs4/6qdKJ4TS57sWPFtUkE5DtUKAIxbE+OEeIbzKKvhPf9cVHe4X+FP7RQ3mmCL5/YHEJaABDbYIU0afbytrQkLhPyhxSAvVXPlnmykAyjgelYRlocGpj9bTXlcOjcrKsu+JQilmVpTZVeyvY79tlvcyvg6ow7xW+jsolo9To1tPkEeaqcGcr6IVQbRhyy4NuCrA1MT5y8ZqJWyfLC1nUJ5by4vx4LPuTBCiFWX+ZPJikOMaxQoY/Opqvu9vdniaGh7D2027RE8rFC2QsJ3+Me9siQfttioCiskizFy0QjhUxoNH/ZWbKKDN9QT4GBl9Mw9JfkgCymPl8qQY7/QGSavgsWHUnB/hKydIiQsT2XTYMJkKggJEF5Pfn3FhnXBnRiSmmjB5NtHJ+dd+fN6YCXIF7RBQ1LZjMBWhaXQHLt+Ejqfn6c6V3dqCaouJOIHhRe3nEgxarZ8CR/cT2fQ/IFRaa+hWjcup9DQCesB0sFnhjeWoSEnhSdz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0t94f4prlLNBu9zh8qLPMDwuJn1Qrep7K4TWyn1+wZuJMW2ahlrfz9uQbRko?=
 =?us-ascii?Q?563HnnsEPAbFWmeySA9OtIdO+IKYRgE9FLU55VrDjduOC2jFRzQ1jnS7417B?=
 =?us-ascii?Q?aFq2Rdue1ixxd4JSlRiMLTB00SYrC3JVSLbBW223BPiIopzyaoBeM4uVdi+L?=
 =?us-ascii?Q?jh9H9ftC34auHFvT1d8bCJBsHMjQ+Xr+vVo2X5N6VhoC1oAiCZvBZc33yGCo?=
 =?us-ascii?Q?iB5kHljBxBqiLsCMN8sbfp/2Nb4mgZeeIzPk6I6MDAR6PqIGmxFyZ3CC8KSQ?=
 =?us-ascii?Q?5TZ8Eafp7vbeBf4wtjFiqELdfb+FUE+W4KtdjFHAJBqEQiol/Prv5yPWLnSW?=
 =?us-ascii?Q?a0/7c0WiwImnM8m4uRMzxIKgKAIae2qEBkjLivsZ46gAUcuYnNULxTolkfVM?=
 =?us-ascii?Q?g8eOSBG2FjRP2zUY2+vEe1uVCW025CQH0Sz0TlDlfRDiuLYwzEfrDlxxHdoz?=
 =?us-ascii?Q?pFmbkBL6zVNkR+GoRrP8z7WQRYdEDTHW4w2ar7o8uJDbtBFxbj+uWGVeLgHa?=
 =?us-ascii?Q?VmB4qQ/c08u1pstltYVC9AKHNUoPaCrO806MyYZfj2YGm/6oiS4VVwBMsDQF?=
 =?us-ascii?Q?Akl1zXBUjsNnQyy7w9SHcR9d6Lj5PLujdsio1KrQ1KthgrEKX064gC8PBwJE?=
 =?us-ascii?Q?24pk8KiJ0qYBv9iGadIuVykZXwy4tF9PVSaFZLrXu1yYC0Cq30/Kp+U2/RNi?=
 =?us-ascii?Q?cV24sWJ+Ke020nPpgXeI6IaAwNoXO9BH4tzihYk0kwSjIgasJGPWbB+iNVQk?=
 =?us-ascii?Q?KkhaxE01g4aIanS1wwu4DF3ORmNhJ3g8CnIHplhZaIcg0pNWPrk0jogzf9J9?=
 =?us-ascii?Q?sceWhzzZvmZBj1W+ds2FAwk0HYqZMsJlb+k5mzqA2H8hxYkZ/ueuym4MkDki?=
 =?us-ascii?Q?PbPlINiNgzZGcTRchzzuPbRCkv/4vZZ8nVnO0mHvTnwDjU44ilVwTdhkxBbH?=
 =?us-ascii?Q?swHl4no71TT7wLi71DrQsP95V5yfrGMhVAe0WdIm/uhqq/VY1smFhcrLWqxw?=
 =?us-ascii?Q?Ee+k9tT/rOFrPZYz5jd3SNpeOwESMFuLav+m31v6RCnpTfPBeqimX/T1ScaP?=
 =?us-ascii?Q?XbPdY9D3kNCsaOBJLjZ5FXIYajz3sqNaPHw8LJwyshR7gWvw2JIvCgBoc+hj?=
 =?us-ascii?Q?JwNiZ2KG2AQGpms4Fjn9P1IWMI6UeJA/OVXSyW2UBH8YG5W6zBGF2RUMp0sj?=
 =?us-ascii?Q?NJsU6sV0DP0AAzFUzen8RslyGaaX+23BAwM2+T15TqWLFUNtvFfD+LmmNVZn?=
 =?us-ascii?Q?E0lOT4jt9c8axxLVwos4UtX8IXZECwoBzXCuzu7bBJRHlEexnn/1W4FnwC9n?=
 =?us-ascii?Q?XYWt2o4vSnYTKFEGD20xJ4Ch85XqxRdTW3MZbIdTape2XXFS8LNdv8cBYBT4?=
 =?us-ascii?Q?gUiQmSrGzYhpJ53oURXVy4Bc1XoNqxHaJyDwRvx0K3jug18kKtlO10TfT+PJ?=
 =?us-ascii?Q?UfTrxsqd9hZvLHr4EKkrImLgE1weF0TG6ljXm+MG3HqBrcsPHSmCHUwE07oB?=
 =?us-ascii?Q?SaV81G/+WTH2dBV3jeWOmR4SlfxxGiE6rZK//6I0tY+lZFQ2zEzmdWSrD30u?=
 =?us-ascii?Q?v3whx1tIf93oLb0SfJ2ZS3ztpCqhlToX/8TBQAt8qeWYBQQlT4dTG3mjmz0y?=
 =?us-ascii?Q?PGtC9YisQv5tF8dfLwInrz7Q4Lq6AHqQQgiRvvqZCyw14OXwNOGiKqvSQeFU?=
 =?us-ascii?Q?Nv2LU/3mcIPdsBIWNPzyM6Z6KQFhGlEp/E3Yk6RBnK9eFc7a?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fc8c90-7abd-4fa9-db58-08de7fc74eed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 23:38:33.2444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yZIhzeV909uXTspLn4X9R/nYDZnEzwiaW8hRBLmJbrOaQbTKDHpzhLbjfqfn423hw2mJM96PaQw1ov2StSP2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6128
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18033-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2F4626B64A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Subject: [PATCH net] net/mana: Fix auxiliary device double-delete race
>=20
> From: Shiraz Saleem <shirazsaleem@microsoft.com>
>=20
> Make remove_adev() safe to call concurrently from the service reset and P=
CI
> eject paths by using xchg() to atomically claim the adev pointer. This pr=
events
> double auxiliary_device_delete/uninit when hv_eject_device_work races wit=
h
> the service reset workqueue.
>=20
> Fixes: 505cc26bcae0 ("net: mana: Add support for auxiliary device servici=
ng
> events")
> Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 9b5a72a..c45a66e 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3402,14 +3402,18 @@ static void adev_release(struct device *dev)
>=20
>  static void remove_adev(struct gdma_dev *gd)  {
> -	struct auxiliary_device *adev =3D gd->adev;
> -	int id =3D adev->id;
> +	struct auxiliary_device *adev =3D xchg(&gd->adev, NULL);
> +	int id;
> +
> +	if (!adev)
> +		return;
> +
> +	id =3D adev->id;
>=20
>  	auxiliary_device_delete(adev);
>  	auxiliary_device_uninit(adev);
>=20
>  	mana_adev_idx_free(id);
> -	gd->adev =3D NULL;
>  }
>=20
>  static int add_adev(struct gdma_dev *gd, const char *name) @@ -3473,7
> +3477,7 @@ static void mana_rdma_service_handle(struct work_struct *work)
>=20
>  	switch (serv_work->event) {
>  	case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
> -		if (!gd->adev || gd->is_suspended)
> +		if (gd->is_suspended)
>  			break;
>=20
>  		remove_adev(gd);
> @@ -3676,8 +3680,7 @@ void mana_remove(struct gdma_dev *gd, bool
> suspending)
>  	cancel_delayed_work_sync(&ac->gf_stats_work);
>=20
>  	/* adev currently doesn't support suspending, always remove it */
> -	if (gd->adev)
> -		remove_adev(gd);
> +	remove_adev(gd);
>=20
>  	for (i =3D 0; i < ac->num_ports; i++) {
>  		ndev =3D ac->ports[i];
> @@ -3764,8 +3767,7 @@ void mana_rdma_remove(struct gdma_dev *gd)
>  	WRITE_ONCE(gd->rdma_teardown, true);
>  	flush_workqueue(gc->service_wq);
>=20
> -	if (gd->adev)
> -		remove_adev(gd);
> +	remove_adev(gd);
>=20
>  	mana_gd_deregister_device(gd);
>  }
> --
> 2.43.0


