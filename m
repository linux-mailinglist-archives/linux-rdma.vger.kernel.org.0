Return-Path: <linux-rdma+bounces-19195-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yITSNQ8n2Gm9YggAu9opvQ
	(envelope-from <linux-rdma+bounces-19195-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 00:24:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 447AC3D03D8
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 00:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1EB73011C79
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 22:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD22338B13C;
	Thu,  9 Apr 2026 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ERwl6Zr0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F66138AC96
	for <linux-rdma@vger.kernel.org>; Thu,  9 Apr 2026 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775773407; cv=fail; b=ccgyQ+40kHO0XfqybHnISFX/YDGqnC8Gou67j7REO+tnhY1I7b9qBrFXGVzzC6gulRhWwEiPBn5/ExV19BUGJOnBEr1+OD7gPP2EJteTz1BylD2QPxtRDIjPq0xKwYZPTGU7yyYz3os19U3KmGlU4zSGTu2mhz/FvvbFnRD6Ayk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775773407; c=relaxed/simple;
	bh=QDORewXpFnjPVXrHJJksO9R3tUgwGudT2/lBNKzBqGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pLyK6HyKEepoH5bjlSnarKbpowQBQz3WUz9/eadR/QTIWmtlAK/uAVxo4cEdyhccHYae1bmJ46LHUHg+Q1NfF6A4DyQXfiYpc2MgbArd/vQiakV/YgbDy505U9wDVZaQHOBmf1dnvs/2q3wfIlxB3Bh8ML549ZiSO0gTaDrIatc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ERwl6Zr0; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAOiSTcMP7kRk/7Ef5Mw+o/ZpnhhH7vC3R1eIZ4FdXuMDZvtrZvkJTDutjCefYfbRIq/tczJaZtjxhKXBKvuVPXF17TGvzgWyCOUVZLb1/NgfoQK1RZRPy11UDee/PijupXbQerlmAIEoDL+e+ZaCenwYRa10c7qUg8PlMnqAyTp4kgvDqFF5hRx26XrdBO8nbwsmNBpEvLB7YNPjdHnyL1oFaUy6QCH77/HoBqU5A3sGvvRpuAg+NKpj9QaSrnVbHxb71ZIkAIGIwKf3yVpErmI4HKVR9b90PerkLTzgPRdzNQzBhcIhhRD5426blAgI/rnViGrHuxLVNwINuyFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGssITqvPLbMChyyHmYRsCDPU/M8idcwx98i1rgRha0=;
 b=Pgap7P6abuTXE0zznRZzaCCjkxuYfHpnsSxUm7ytdWkw4BT3Wr1aVgHnAdZrsoqfEy+1l2meYwpsIk8EWuhb/HVL7NHzow1pDAiyfFXIyXP8scPjfYlmEIuDjSUiDdGSo5r9n8StofMAvQL5/FZe6hY9+Wi/jes3C8E0mF2QWHJormav+A+IHK8Yi7TAuBcVEfhVJVCp6spkWLDPAowDuBsCSdiyn7l2uZ5f4uoiz+w4shjzf8Fm/mNd1duLIL9FAK32jerte/6Qqg0SEf2t4A0HLT9SY2iVLPSCRexlsW8FK7KmcbTx+zubupnbobHohxB0G0gOgO+OUDz6ehjnSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGssITqvPLbMChyyHmYRsCDPU/M8idcwx98i1rgRha0=;
 b=ERwl6Zr0EcT68GWf0sx0OZLqQzv+OLsln58dm8pF0HyJIrH8MqWrcLcnROpm91j0luVEYjexrWY3UmHYmDZKTjmt5qm7Nad3LO4d/FtrhxCShAEq6uXXMH2sy0FcHyTCiNZzzm+SvIQziKdMnU4wlLG7i5taTowbbbyYzeovUInWeckwfDtauhtNFGTEKyFMJN9DRii+PnrbQrQr/JimR1Bh+nus/eBpGSHD4+NjyJosON0lwKD9N7uCKnk2UAJE4yBIUYlWNkhMeDGEZ8gxlCGvAqMhBgMGFoP5J7KWSJ0OaWu/d+Ot321+bTT0MQDCiXOJg0gAPW9K+t29uWxlOg==
Received: from CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 9 Apr
 2026 22:23:22 +0000
Received: from CH8PR12MB9741.namprd12.prod.outlook.com
 ([fe80::43a6:8d0:7081:65d7]) by CH8PR12MB9741.namprd12.prod.outlook.com
 ([fe80::43a6:8d0:7081:65d7%4]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 22:23:22 +0000
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
 AQHcxoXIlexf2vrne0qPvD6VDq3DZ7XTpX+AgANBVICAAAPdgIAADTVggAAf94CAAARncIAACTUAgAApREA=
Date: Thu, 9 Apr 2026 22:23:21 +0000
Message-ID:
 <CH8PR12MB974152A7540EADBDE6018FC0BD582@CH8PR12MB9741.namprd12.prod.outlook.com>
References: <20260407115424.13359-1-mrgolin@amazon.com>
 <20260407115424.13359-2-mrgolin@amazon.com>
 <20260407141731.GC3357077@nvidia.com>
 <20260409160007.GA24340@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260409161357.GL3357077@nvidia.com>
 <CH8PR12MB97416FB899448DE69BF3082EBD582@CH8PR12MB9741.namprd12.prod.outlook.com>
 <20260409185537.GQ3357077@nvidia.com>
 <CH8PR12MB9741DAD52C2D8078B6D366DDBD582@CH8PR12MB9741.namprd12.prod.outlook.com>
 <20260409194420.GT3357077@nvidia.com>
In-Reply-To: <20260409194420.GT3357077@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH8PR12MB9741:EE_|PH7PR12MB5758:EE_
x-ms-office365-filtering-correlation-id: 9a16945c-75b4-445f-2646-08de96869bfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 ZBrLtwbupYm9lXIzaQd/zB6UZpIAUOA/YzpwiLul0ZxlNB62tI8QiVg5+k6DWREbbm6o5cWj4NcdYl9seBnZKueplbnxJr6LT+n6/pGKpQeN/LvRibXdCpGWUx0caf9ccFjD/dySLuGPVi2LgUR3vw9zOLXB/ucYVBUTt1xpms9pgem9QmLuCWUo4k/Bh4ES2ZD3ujPy2AKaFNT42jTjJptD0cicdI6XfPh6idl8psf22DAiRymLRUIHTJLlF80OB+TVlZ+RDhamFqWBZu1UXv4NG1EYdTwUyj27yrwYflMogh8LVek+zHGzjH3akNBIyX4ZzqVa2gi8gt7SBhZ+NOju5QUcoE7WhJkeYsAx7ZCPCXk3myB4KkevoEx2JjiCubIqAytLwKgIgy2prCUTtR0yvKhMG17eKH+mH4FCz/LbuR+pt59p8fI8hxmdwQ7dpCnz/8ECBBRF8TT1INb+546skYI8UDqLm0s8QWYXspMSxkJbRhBZPR+U6ZgP+9DMS7Vsdfqiejrx6QvlEDAVqnYSiDGZNjaofhFOUce4rxmsw+zm872KHFziPxxNheybtA6F+Xe4lwYi5WjexB4nFKH1po1ugVNdHIfyrrVRNTIh532WY5XrIUp+2WSFWOa300U3ZfNixU4iJKt+oAWqGWlvzBEqdf993Sk3ktL79uBFQzAEfcFK4Gyhj2dxpoFbWAzZFMdOBw6j/9IYsCmV1aK7S8FxCim4qVEQ2utB7LurXHArdDeyBlJ8adL7B8MZ924F2wyBKrwZ9N2QXR0odgGq8VRjOOcQU1XPPwJ3GrI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9741.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ufGc/mzTJukOXyBPKyn2kWi0EET5S64GKWBmicBSwTMek72sND6xy7IzV/d/?=
 =?us-ascii?Q?z6GeSMOi8K/bPyc8ugunPRg9wiY8XYAqRg4XSsrzuQWG6EwCogn56I7SQMMa?=
 =?us-ascii?Q?TXzP2IAQy09+M8Lo4ryorAlsPmedZ12iEcCzEDNiwviq60QeoLilKnaj1KwV?=
 =?us-ascii?Q?szkkczAII8axzO/2geOmkywbSw1ejlkSKariVYcXZt64vKA3KJXjGmc9WpmO?=
 =?us-ascii?Q?5JsFl7KPP/2vI9GdhcPW3KMJIiQNYtyLn/Ejs8FCEb/cNKTaDk9BaII26goc?=
 =?us-ascii?Q?FC8qEaKObNIwxmh0eAL7GnARJA+vDK6kInKziLUNbXFEYgWcEx6TNyNf7MlD?=
 =?us-ascii?Q?xdorC/xa6HcBaA7z6Nh/jb3n9M+cbuC7WFjbZsZGCKwYrGbYwPGn7N1NEdgB?=
 =?us-ascii?Q?aPuqhfYyEcDv1rFGIZZj4utrfQv3xsAwub+YqfY8SkOqhZwca8iOeF5cj7tl?=
 =?us-ascii?Q?8MFg+jm3945nCKEQECzycCOQBc5Wc3M9NGVkUyYpFISQIwHWBLFSFsR+B8Hg?=
 =?us-ascii?Q?jNN3yKXPm0kZRk9/rJSlPPKqWnDbldr8Ddhmmb8qVLMzf5CaKzNujkoD4RUL?=
 =?us-ascii?Q?Uw/dfaCKDROfDIlWkrlAfi2WD41ONO2pBTelyxVNA04jL3k3nXOE4p0SlPFp?=
 =?us-ascii?Q?Wl5T+EBTQS5B9LTJjg7KhDSM+SLSXLNsrqw+Nd4kNL1g6jnOMwTih4BWdaTW?=
 =?us-ascii?Q?gaqGiEDOTyxeKPts5p+QCwivm566b7q4mWwwIk52jGtKxvQ6hxw5eX1XcOE1?=
 =?us-ascii?Q?kwC5rYxovaJvf8eUCwaVSPwpAlV0wcyL8Gt1FGI99/zV6NdoEes7jibQDlcx?=
 =?us-ascii?Q?JgQvwXbpbgI4a+ItEZtkh8rlTBm5Rf9OTvWvIT7EFnfzBY4ERhy5aHhenkci?=
 =?us-ascii?Q?udhox9kY8SkgBXW3L7wh0C13iOvw6Si8K/CZccCIngDbiorJkYU4mCG0Hyga?=
 =?us-ascii?Q?4+pc7JgbwztKOouboNLInt/iVE2TGdwLfEE1o3Ez7QB3OxqpvjVOJ3e2fUsS?=
 =?us-ascii?Q?99Pl1imLbCEqhGKdfBvpMcUmXUr6gKEV8/2OKFTu/kIL+2eTUPv/Yayk48yD?=
 =?us-ascii?Q?1bv0X9AAkj6MBv1Ubs5M+aKzsGRk8HpfiDsVCrTtRzAMsjxP1pbRDnLfnCZl?=
 =?us-ascii?Q?1nmX6KMB4P2aDSdcSVXCpI7axK6kbNgmRQdgvcR5GI9vFsuWVAd6ASoxdM4I?=
 =?us-ascii?Q?UKhPwPJYVkaFGK/cXWLMsav8g2FRGC22K8772LcpJxTprMWb+/4kZWe0KJPY?=
 =?us-ascii?Q?3HhC/LTe/4Oity/aNChOnL40U+yZDmACtJU8n4Yq34tRuWDcwhznGrypC8Z3?=
 =?us-ascii?Q?ozsYL8Z4if/sZtLGGPxgihHgcfS1zo9E7MmeQ3TeXVC5hgjYlY4WmX/2kHpn?=
 =?us-ascii?Q?WqjbSogaG7YKfHEH/J8W2HbkLj1hHjvC3uPw6w+Deb+S8mZILvqB6n2OxFqM?=
 =?us-ascii?Q?FhPvrUOzUsMpGN+BsBaewifUPsGSYTYLBkMgdTeVZJeF0vcvOJqtFiFqXAlT?=
 =?us-ascii?Q?HA6NK2BxcZkfvbFhzjz3CVmRajCMdwQHRi+mRucJdOOapasVrNfkjimy/STs?=
 =?us-ascii?Q?A47hmGUQmmac+qoi24OZ9rsvbUHqmj4B4EvsMjtQYRsm8WAMzYHXuWlaA7MJ?=
 =?us-ascii?Q?Kv1DpS82C8Z8kPWsyCPQWJY6KyBC/izJCcmT0xfSUSP7N/VeESWMQakaqPK/?=
 =?us-ascii?Q?OJi3/yXmDoTFYuc2HA/D2r6rECejB+nZn/tV7ro22JlqnNu2GtkiktHFfEwe?=
 =?us-ascii?Q?VqYhkIMmbw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a16945c-75b4-445f-2646-08de96869bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 22:23:21.9830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fYCLbmftFQTefjb6Dj9VGZC3QS+NdARDupfvOBb8UB9CoJCht14Vq4jP5zwtdf224j18AFiitNC44K6Pn8gNcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19195-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,CH8PR12MB9741.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 447AC3D03D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > > > I view this as an implementation option.  One vendor may implement
> > > > independent counters, which software can then piece together.
> > > > However, another implementation may have a tight coupling.
> > >
> > > Well, this is a problematic state to end up in when deciding the OS
> > > and library abstraction. If we don't have joined counters then we
> > > can't really support implementations that have tight coupling
> > >
> > > But if we never see an implementation like that then we wasted our
> > > efforts making them combined.
> > >
> > > It seems like if portals and libfabric defined them as joined
> > > together then we probably better support it that way too as someone
> probably made HW like that.
> >
> > Can we make this some general counter array, with properties applied
> > to the array and no concern with how any specific entry might be used
> > (at least from the view of the kernel)?
>=20
> How does the API work? Who decides where the counter is stored?

The counters are treated as a group for the purposes of create/destroy/QP a=
ttach.  That is, they can't be individually configured.  However, they can =
be individually set/read, so instead of:

+       SET_DEVICE_OP(dev_ops, inc_comp_cntr);
+       SET_DEVICE_OP(dev_ops, inc_err_comp_cntr);

There's just one 'inc_comp_cntr' call that takes the group + an index.

- Sean

