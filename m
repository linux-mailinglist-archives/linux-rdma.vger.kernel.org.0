Return-Path: <linux-rdma+bounces-19188-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL+NIuX612luVggAu9opvQ
	(envelope-from <linux-rdma+bounces-19188-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 21:15:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B223CEFD6
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 21:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4731930193B8
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 19:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AB9242D84;
	Thu,  9 Apr 2026 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZNCoAs1S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011041.outbound.protection.outlook.com [40.93.194.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6BD2D8DD0
	for <linux-rdma@vger.kernel.org>; Thu,  9 Apr 2026 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762137; cv=fail; b=LsaivcgyNHDWvC0GZq65rUv3/vMXMlILPtXwVWdsxWkJxSyWwY1tfhQk9paZ7/M5ZTxAW5zvHhSYIPu47HZXAsOrdEJEl/bl2inHd5Xcnoa9fSWWr3tPRb1pqh3pY1itBOJoa/YDFfmpNLxdk3ZhTxCWuHPKJEHy8/Ip3GZEH3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762137; c=relaxed/simple;
	bh=NGJzEFTspQdJk/nD8Wsn6+YGOPkmt/rn7Hl1Q67jYco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c1CqWzNt41BUoOc8OZeOkSTNwksTQg3KZY2wTjIZxcMmOjeeUzQJjhMGWoSysv+GUR7UjkvxhimS5ycKE8Gj8TaBgxd8jpRvyExvU9THLS4AxvISVV4ZBeyrWpiF7A3kNeZr0qgr2x2egAIu25CduinE7lTU7XANQkhvgVV1Oeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZNCoAs1S; arc=fail smtp.client-ip=40.93.194.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DezxjBJSU92leHkbw8j98lhoEyvYLR3EJ6QVuKOPFWSy2gNCjdxYcaD7h+UoTtIFV1i0zMrlq5I5EEhbqO7AeInWzUZ7pf6j4bWWB32xmvIiFJELnZhomdePgs5IqgWAwBbgTJIQArwiqbRLmlAgOAQWOY/EKvrMi6mn4tQopRN0rRIWwMELilHi+O1J3ptNKk2/z7P3A7AjeMEH9vnQgyOPJaFJj0AV/b2tLtXOwFcPWOOmI4Zfax/XycrBfAVYniNStypr/tME5cbsaDpxdWwldew5tSDKOfDiOhiaUnZb4ccgCEOfVhvs3XpJ97629tgBlrk+DgxA757ysVGZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF7xWtMNvGWFJNWchBYLuYxQ53gFj48sHIyRYD0+mzw=;
 b=MsA3ulA4n9JoaITqwp8FVeExoHg4GI3nI+mLBnBU3oWjXD44aDmRIsOwBWPvv1obVt86domxULGs3g9zgLvF3zxOYTfFpesJKmTfIgh+Ko72i9LNp0GIqvnU82466e387lP0+6A6TS68ZgM5M9zjKPKk05dmZ538LKPVaACQsnEA24p+99ANBRmbSvivBXlwkFa7Xmmg7+LxmHREzgBSd5/LjPmfX2sDZWxaicdZZV4EeWOupmDYIO9NCNPp7zfNgEstEJwnlM/AprHJf0wvepMRvezHoqO/NvTrDwaB/j8r1didrQqWCAUDtLU3sGEN028QTL2KZi69jSLFTU/V5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF7xWtMNvGWFJNWchBYLuYxQ53gFj48sHIyRYD0+mzw=;
 b=ZNCoAs1SbMqLyABmZxuiiHvx+QmAVQeKAhEPHqsajaUCL1FQklikOffkAwHhi+8KYEo8wnWgOzVtLu9sEJFAxs+v0kKlLctdK606tsmWsUL1pqoJKqm/J4vTVIoygonC24qhIdutiG5iwJxzUpBxIz9+u2JB54fKmQPXiRUV2HtUGUWw7GdxFt8ZwCv1v/B4tf5rElrjo/ze7pwaO+cv9ike8l+6kRHpQCYZHa6KYxJKp2eIRQs98FxJxXS89zLL9EQMeRo8lo7IJoSoebpgEnhL8TXxnUAHtYGwOcFiMzA31u0rKHk/XAdt5oGWkJ5PZPrFUKDPN8a01B415HM3yw==
Received: from CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.41; Thu, 9 Apr
 2026 19:15:31 +0000
Received: from CH8PR12MB9741.namprd12.prod.outlook.com
 ([fe80::43a6:8d0:7081:65d7]) by CH8PR12MB9741.namprd12.prod.outlook.com
 ([fe80::43a6:8d0:7081:65d7%4]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 19:15:31 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Michael Margolin <mrgolin@amazon.com>, "leon@kernel.org"
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"sleybo@amazon.com" <sleybo@amazon.com>, "matua@amazon.com"
	<matua@amazon.com>, "gal.pressman@linux.dev" <gal.pressman@linux.dev>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: RE: [PATCH for-next 1/4] RDMA/core: Add Completion Counters support
Thread-Topic: [PATCH for-next 1/4] RDMA/core: Add Completion Counters support
Thread-Index:
 AQHcxoXIlexf2vrne0qPvD6VDq3DZ7XTpX+AgANBVICAAAPdgIAADTVggAAf94CAAARncA==
Date: Thu, 9 Apr 2026 19:15:31 +0000
Message-ID:
 <CH8PR12MB9741DAD52C2D8078B6D366DDBD582@CH8PR12MB9741.namprd12.prod.outlook.com>
References: <20260407115424.13359-1-mrgolin@amazon.com>
 <20260407115424.13359-2-mrgolin@amazon.com>
 <20260407141731.GC3357077@nvidia.com>
 <20260409160007.GA24340@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260409161357.GL3357077@nvidia.com>
 <CH8PR12MB97416FB899448DE69BF3082EBD582@CH8PR12MB9741.namprd12.prod.outlook.com>
 <20260409185537.GQ3357077@nvidia.com>
In-Reply-To: <20260409185537.GQ3357077@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH8PR12MB9741:EE_|PH8PR12MB7133:EE_
x-ms-office365-filtering-correlation-id: 131d33a2-000c-4779-30cb-08de966c5e3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|22082099003|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info:
 x5cSywCg7+kz1Pg0ZwjQqJr6yFlOdXGpyVtBEU07RNnqD4FtBP4bqC1f36/iUzCofQtBE7Sw7Lq5jqykCC02iYwX5HpVIuZAo3mLrkIqH9lt38TBhEjguuVLfAC/dXJ+lSIlewBpmFLEEQxEfhjGFnHT9k3kmLGX7fbBkeAhV44MHAckxgLZNxxUerBw0rIEJ+kOaE+GqKYi3Fdyo8RSiN1CMPXxKBFbRWguOL5BXroJXbHSRSSW6YmFKUlvW8FjHpVN7u8n2+JPgT9U+Wv3JVxqE0qT64yPeGRES5iIsgvlb15beYyPpn1NuKywaS/JJyKhnBgEkZMHIX6+b8t5a5BCSAjhYdfjsmqw+ykMd8NW2oMFve2XZ0GX76ph/b1qwzuRSJPm+gaWLFdCebe5QulvNie6isSTF18mF6rLyGEcudunQiNLZM2FZhYZJV1LD0jGsul8DNSoLdAOcjy6Wz+mZNEnPm7qNUh/hcFSXN3So7zm0UV4vcn7xrPIWVtkC8+lgshjMnao9aYJ03BrzA+r0FycwY3/orgYAzK29n6AU49mWnl2833E+sajwjjrk+Y455NyyVh9Gse86KVbUOqCHYxsmCamMVi2Sfwf7x7FMHz+VkS1XlynapwxdsH6W9vkSdKgBB+o+FquWYL/AkPDzLetq6dEgG5fsGklqcEofFrB0UJ2aKyezTY+b96+05maQGpnq4olWBVJBz/9hlPWWE5bqcPA6aL53ljmoi2M3Eh+n4SOv+RXAPfNKd8XnMjmAJQKub8XqV6TC+G/dg67JaDhiH4RrLcb2zDh2kw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9741.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(22082099003)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SM1hJq+6Fxy+aTzHtdDukJ0K7L8L9YoQLOUekR8xVPnpPgmTTWRJE10yDa8o?=
 =?us-ascii?Q?SGXFXsw83n3JNWvqFMllLxRXmXX6GdLnxCTh2Ik6SiXpmMMUdK6IybfJZshm?=
 =?us-ascii?Q?+7DSTWDU2AakpxESgJ3hrD/Zov83aqTUSRv7NqEFHNSctuCPI1z+y4fBArqP?=
 =?us-ascii?Q?A7DdUwW6Gt3HewaLG6HvRtVS1zrhUOTq6hGjy+bOx1++qNVlwh6qRKopkD9D?=
 =?us-ascii?Q?uYD8gR93XPYpRwzx+amQj9OdCwuwf43he5E/7TnKv/dR5yT5+hA/P3rlVndf?=
 =?us-ascii?Q?0HbYjfFHJitn4IlwuGnMkJVkHTx2C7SVtDR56jR1MR3yYiUBxRMRMdRKZp2G?=
 =?us-ascii?Q?fRvzWuzxw4UUsDmNOnhc6SHn5eJ+pdfMU74+5Zrm3C0s2rkIrpT2Y2Z8jlTC?=
 =?us-ascii?Q?W903Ka5xofAdcvL6MzibaWAr4paf+ObdCSGNbRDjVP1NwtaOgjW60cUOTzK/?=
 =?us-ascii?Q?+QFBHLtDZ02RYhvN4utaZjPCqOHaHZzVINJAVITMxaBjBjIpevUsFRBODo9b?=
 =?us-ascii?Q?xcdnzuUt+ZkiOcE8JR/cpgywSdpRlKS7gNwfKK0pGy8mVsJuvn3tfHLXrKYV?=
 =?us-ascii?Q?+d7QJOGqBpfMCltpoTdqJlWkJOEhSyiaRwHem2E5PmABuHXXuCZ4A3Fsr/9U?=
 =?us-ascii?Q?xm/dCSJ+PTDdCA3ugbzntPdQjIMS3016qX4OYNF5Wkjb39bVKXUx5p2D82Rn?=
 =?us-ascii?Q?Wh2robuOx4j70Ugp37WgM8+Qvx98ceuCIUVaetAwXmTx1V+lG++pSj0oituJ?=
 =?us-ascii?Q?zNK24rOlx2YxerxiNqCvJqaGTrQ/trQA2QTUXkhkYR4MXAut0bXFvdgZAj7t?=
 =?us-ascii?Q?BJRb+pNcfeGkgAjoDwKGJVr0gWVJklyHjQxgznWxywh2YJS74T4qV30nToH5?=
 =?us-ascii?Q?Y0S/GXMXUX+yQsZtPD5N694Pijg6JK0chP4cqOzWkKIe675iKvxuFmpCoxfE?=
 =?us-ascii?Q?zFgm1GWvlK9GE/sZ32F+tTD8YfZJeNymSdiu4F7uTA++PGWzheGKNQ0+3TLj?=
 =?us-ascii?Q?9lmMGeXoJNOf2B3ywV0qiQRTSQYuwVtxh3JYPg2kiK+GS4ffg8fjJDE5b72Q?=
 =?us-ascii?Q?hKxjhNUqW1edlgBXZqaAcrvkbVEUgEIBVDU/pMF9+hNG7xWeoI2hQJqJcNew?=
 =?us-ascii?Q?AdIERs6Q9o/Oa1ZK/LVHKPBuDdrruNypxCFDSBXnUn+vriLd+aa7pKMBMvFJ?=
 =?us-ascii?Q?vu80+7SVlmtZE/RmC9gPOc4znAlIooBluKsHmkTTzDcJiTa/UWS6B1eMpO/X?=
 =?us-ascii?Q?DHDTX6zBO6Y071QppbCNusYMNDMSgHQnuiS9EXlvOnRVI4SbXp1N+RXtEagp?=
 =?us-ascii?Q?VLM550+w7AuXav3yIggHYE44KufprR6aGRdpWVckNngMxxpw1rHu9HCHW5+6?=
 =?us-ascii?Q?UGHTGvKEOrI3csHALRryxXpJ5vEZduUZ9q97VedEoCnLxXqUCIEWN4pWebrR?=
 =?us-ascii?Q?Yen4WxMy79OTR6Xcuj7z8qFcBwOux3mCAn6wwf7DNKK1Kv488wUXut7ekjdJ?=
 =?us-ascii?Q?a1x1IksBqNHB6IDNkSmffKsVhmlMfRvtWMZMLDshrT1K3siFeqVbV4tjDP2z?=
 =?us-ascii?Q?M+WiIyCOCPtA4iBXuRf83LORGruY6B1Wufmgdf5idg1Kf6vJ0VyxJ99+rPXR?=
 =?us-ascii?Q?m1uJe5dUeVVhOXea+OFJyNaLa9PUFU84IQQc146J5+R3DdqrxSWXOgTVD1eM?=
 =?us-ascii?Q?hj4QMFo4/9wwCQ46Gguriqm8u4FSi40Tjk/v6DtnkZGQJy4yfYpQe3fHdJUE?=
 =?us-ascii?Q?IidqiwaFmw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131d33a2-000c-4779-30cb-08de966c5e3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 19:15:31.4735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86nFV4yvF7b4n+f/oBNHwyXhqTLXJMYKY7pOyxjshKxAYzNVZ+iTF28gKJY1oqkdaEFpCM4w4ffD05D7vMaUNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19188-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shefty@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21B223CEFD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > I view this as an implementation option.  One vendor may implement
> > independent counters, which software can then piece together.
> > However, another implementation may have a tight coupling.
>=20
> Well, this is a problematic state to end up in when deciding the OS and l=
ibrary
> abstraction. If we don't have joined counters then we can't really suppor=
t
> implementations that have tight coupling
>=20
> But if we never see an implementation like that then we wasted our effort=
s
> making them combined.
>=20
> It seems like if portals and libfabric defined them as joined together th=
en we
> probably better support it that way too as someone probably made HW like =
that.

Can we make this some general counter array, with properties applied to the=
 array and no concern with how any specific entry might be used (at least f=
rom the view of the kernel)?

