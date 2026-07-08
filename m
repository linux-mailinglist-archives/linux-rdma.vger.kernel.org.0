Return-Path: <linux-rdma+bounces-22896-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TN5BKNlETmq8JwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22896-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 14:38:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B777265DC
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 14:38:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=BMYia2zV;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22896-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22896-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16BD7301F6FE
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 12:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B42544E05B;
	Wed,  8 Jul 2026 12:38:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2944DB61;
	Wed,  8 Jul 2026 12:38:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514285; cv=fail; b=PB+343FqNAuVzcVpQcVLPWxDKOTKTY1ecS0gexJEU+WYh5pNoHNX1JIJm2uSfpZwOpA11TB0Xs9gyBSF/QiCVMFqYvc284fiaP3lsrqI9y6XUZi+bNoNiynLfChG9pzAoDLcv1JtDZAAxDjsyv/X7A/m6gCnGK0jXmRGTr++k2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514285; c=relaxed/simple;
	bh=zsuuiweL4NCf6TO2xn1h7bnsbMFgpL7DdPOm4ODyEVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ayo3Cp1aomTYddjoaXu2o4L7WxNqKnKY13O3JpER23hEoHov0BzWLi2K2J9Q3QdGR7WeprsUiO+0A2emLByJTkSY1TadJzxfYA/0cth65yv6RcL1HzPPw85wjbL+B+QyRSRJnzPZSuuG5fZpHNTo+59YV0BO2trELSwzCOqbpzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BMYia2zV; arc=fail smtp.client-ip=52.101.43.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=db12v+HTPZa4h2Yt6Ki+3yYemTnyNCVHZ9z3poMofu0FpS/4kmryTrdAfmQ4YScuQdbgYh55NHQAhwDBZq3n0ZvqzcHkSvUpnZhtNO7DvPn0Mb0TPjBWCafPCQK1xDzvmjNUkKqqN8bq14xyoJpEPvjr5mywAINljgR6rifEjih/nP+5i5esDUh4uK7wah8N9KrDmA1M6yYo9KiDxPP65g9B0QJVWaiVaI/ilo0x3X6SjkroWLxV46W2oK3sVCDDrKA47WWbK1CrqquBUlKQxRuOMu+spljKr3oDC/sWEFz1pkInSvLoG1Jrg7uYDxtJlQpUR7xVBmSf+tLP6dd5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsuuiweL4NCf6TO2xn1h7bnsbMFgpL7DdPOm4ODyEVc=;
 b=t+L4VN+mssVrADxKZYviSDpdBiChCQsXWQHwNS4XCDY9M9BRDjJqLLjWFvI1fq7tpSmf1eBZByDNWNde8JkzEJRTezqLPESVRKmNMR1NEAVcS5bJ8zXx4ORUf8UJahCVWR5hwY3k0KiZWWQyKI7ppmhk4dM4hH11nKD6/Iagh/pEjRX+CpQT9MU4q9WbFskGIX4VDpKr5lS9QwzqN3W4d4MgozG+ArdUUpB7p5wswlHoc+X0pX56RtskY/5QGawViS8RXxAhOrBiWp1Wlbb2+4v0GiKVs60kh0pafSNJxBZjJtuCf2v0zU89xUt0BqjTSRPIT6fQxGVGvqQlNSnNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsuuiweL4NCf6TO2xn1h7bnsbMFgpL7DdPOm4ODyEVc=;
 b=BMYia2zVeWAJX6ksvkGWH4kVW3nZb80Gk07sIQFpi9QB0nw4WS37XT49iLIEg/bhLLj+0UxhELuaLfTpfjXXjRBaFnBYcqENbr6n5j2z+mjKRvQzCYFNQY5uya/lwvT5t9scN3QPWG7qakiSMsILF0JC0bRNpzd2MryPOUlHdhp9nzGJvy9e7jK0aHBjprVtyJ6nyBrLG4kogYTUWyvQO50/4Cuu+nY1FaJsT8n4bxfpQH2hi6OaT9nFc93lo8AJNPJB9NUY+shTOIbdXAJTYANn8gr2fJSp21T1aqx/rCFQYo+82ANP6nBEhFXJkFZR2bfC/P9DkRiKBTsXYapSXA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CH3PR12MB8993.namprd12.prod.outlook.com
 (2603:10b6:610:17b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 12:37:58 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e%5]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 12:37:58 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "daniel.zahka@gmail.com"
	<daniel.zahka@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: Boris Pismenny <borisp@nvidia.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, Jianbo Liu <jianbol@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Raed Salem <raeds@nvidia.com>, Chris Mi
	<cmi@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"sdf.kernel@gmail.com" <sdf.kernel@gmail.com>, Mark Bloch
	<mbloch@nvidia.com>, "sdf@fomichev.me" <sdf@fomichev.me>, Saeed Mahameed
	<saeedm@nvidia.com>, "aleksandr.loktionov@intel.com"
	<aleksandr.loktionov@intel.com>, Gal Pressman <gal@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 00/15] net/mlx5e: PSP cleanups and improvements
Thread-Topic: [PATCH net-next 00/15] net/mlx5e: PSP cleanups and improvements
Thread-Index: AQHdDhH7PELuU083kkWlRqf026mokrZiYReAgAEv+AA=
Date: Wed, 8 Jul 2026 12:37:57 +0000
Message-ID: <9c6a65b7e54a31dea87e7ea1c5b1b3931240f3ac.camel@nvidia.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
	 <0dfe5f6b-dbc8-4104-8883-e88e8e59ab58@gmail.com>
In-Reply-To: <0dfe5f6b-dbc8-4104-8883-e88e8e59ab58@gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CH3PR12MB8993:EE_
x-ms-office365-filtering-correlation-id: b60a1492-798f-4a6e-75a2-08dedcedbd87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|38070700021|18002099003|6133799003|22082099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 iKFvlzmH8WKCuzbQbdKmzZFyfMpHSnk9WzNzpJvaOTSh/VGGyv0VlRjVsLD1aRq1JQOjK9Ui1J//SIj96d9r6xpgigcMNaw/olW91wxjIHvmPdFJv1GRAFcXxcZhHhxioAx8jyAPM6JtV4ZiGcGV8MtDHanurHowlGWyKK+1qrWna6CfzOXlp0KssUR+bC0vbMwt145pYF41/zhBWhlddoH4Jy5XAdnKOwHNECanDKT2NCNxLZMRFJNWlMqa5M8lp4LqCUee2fKuJYaAPOW7V6dQM1Rvn6Bhgscx4KCT8xOXineMnXxngxmsT9fCWtm9pUQx7wcn3DyEB1sUZYoN1ws2H5ntDzzknFFPgxQY1Q4UUlibzscVqLIO1pTAy5vFclMEdGbPluTYTqMVhq3bin5i01IMcykiozxa3OgAWLlvUCKCK8mwYCcnK3vldl8y7YmZWk3Wi34M4Wv0bY5U/OYc8MEoW4NEAD5igHGcKUMg6BaXFoUgshmRrB07NegC7fdiFpddtmbKJKiML4mj4Wg7Y7jcWoHt+UWeYOPPFPPpqiRiTjk+AnXxHeWX0psxjTl1YVHr7noNC1qwMRkbLCn5IXrJHpLYdEDRo75Pa2kABAAo0haTsFJS0vDrqvKGn38gl1iahuK70hF7C72ZyKm7t0iiz+TecIG+68e+Ihb8HUFOZw7QU3K720f9qnCxPpynmRX8dLYK9ffHYW16iD8QtzbrmtKHUHEJkO+/w90=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(38070700021)(18002099003)(6133799003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkRHNDBzTHlONHBWZkNRMms3UmlGbmRHYmY4OGFpeGNxMnJvTWQrQ0FzTXFo?=
 =?utf-8?B?c0JYTm1SVkc4NGt4UmphK1EwWWVVQUJ6NDhQc2hPTWpFK3luazc5NURabDlt?=
 =?utf-8?B?ZFY4a2FWbkNkSWlmNU5uTEExQVpIYUgzWTV4bjVBVWxGVGpJK0wyVktHMFF5?=
 =?utf-8?B?S2poOFVWUFJLZkIvTThFclNtcUxjdzdzUjhoM2xTZ05zY21uUHFrQndjK002?=
 =?utf-8?B?SUtkbk9NNjY3L3VZcHM4L3R6QlUvU2dVVkcwc2JyOFJtTEJQUXpVSkQ2VUJv?=
 =?utf-8?B?N05jcURWUGJiU1J1dnFLNExReHYyZ0xFdncxak51VnhyUFRWdDc2OTFEMFlW?=
 =?utf-8?B?dndHMW5VRWdlU0UyUzVVT0swZXlkU0R5N2FodnErYjA5ek1oeEkzRXBxbzZ5?=
 =?utf-8?B?OWlRdEZjcDFhMlBvU0pwckFwTjd5b3NKM0RWaFBYQXlNZmEyK3lmVHo3YUdR?=
 =?utf-8?B?aVRCVWM0NFVUVDVHMk9kaENKQUs4cXM0cDFSN3JHMENhMGJiSjFUM29nWEFx?=
 =?utf-8?B?Rm82YU9YblA5S2FxOXJ4WmF1dHlFbjhIcmFNWlp4ZFp4R0JUMlZHMVJjNE9U?=
 =?utf-8?B?S3ZiWFBqWi8vR1l1REFzOTRFS2djUmlhcm1YaWJUYzlzdTlJTklWZk16SVRN?=
 =?utf-8?B?Z2grOVNXeDJMMk9hd3JMVlFQNXZTRUdkekYzNFdVOTJRZjB2RStwcnBvSHJq?=
 =?utf-8?B?RTNRa3ozdm9tYXJGcUtCZ2ZhMHI0MGxNYklPQkV4MWdjZ3E0U1dsY1ZiY3Ev?=
 =?utf-8?B?VDBNTTFLL2ZJRk4yaTZSanBQLzBFVTlmbG9qQ1hvUXlRSEU5YThBSkZvZ2pC?=
 =?utf-8?B?SEFpZlJ1blMrcHgrMXcxLzFBeXl4VklCQlo3N1U1KzJHZ3FUbTAwYTRIRklh?=
 =?utf-8?B?Y0dMeUVqRzR6d1BFWGlmUER2Uy85Z2dpc3A4a21Lc3FueUhadGx6UjNaQnBX?=
 =?utf-8?B?OHl1aG9jemlLczcwS0Rncy96dnArNlVHSnBaTUNaU0pTUHNQNnMydzh0Si9N?=
 =?utf-8?B?aTRpeTZCM0lBSmZsclhUOWhVZUd4UHQ3L2RCVmVKY3NYenJxNnZjSXppUy9Y?=
 =?utf-8?B?MWFLSzBTOE9YWnlvamozYmdSRWhsL1BBNG5ESG5lNU1GNUJCNWJyT0xIU3lj?=
 =?utf-8?B?NytacTBxNEJUV0RwU1NDUEE0QUVkZlNIS2MvZjRDdTc3RlFCcy9JSS9NdXdJ?=
 =?utf-8?B?ZHBxVUF5WmVuK2prbW93N01mNjI4YTMvUHpWb3p0RUMyZHpZSy93cENOZmxU?=
 =?utf-8?B?eU82UlNrQ3UxNGxJdE5oTkFQQTdMRFVlNGw0eVN3dnl3NW5GNDNOeDNOUlJZ?=
 =?utf-8?B?NFZoYUV2UWNNc1Y0bTJiQkVDeGYxWkRhcDBHWWtMNVVTNGRCZHM2SFFIeVZq?=
 =?utf-8?B?Ym91N2E0WWJCTU9qUGF2V292WUVRaE9oWjRLZkR1dWFYNkVPV05laDN1eUcv?=
 =?utf-8?B?STZldDNuMlZucStPaXdoQm56WmNJakpoS2tQc0JXSG4veU9DOHk4bS9henEr?=
 =?utf-8?B?V1hNUEZKOVk0R2lNcEUwRVQzU09zMXZTcUhiWGhKem9wYk1MMGJQVE9Fb1Az?=
 =?utf-8?B?cHF5NVYvb3MxS2g3S2tDeXYwNnZhUkt4SnVMU25DcENSTE1GS1NNS0doQmZy?=
 =?utf-8?B?dllTdjBHWm56WFhxZS9kTGx0TC9wdWlZWDU3MnlFQVIydW1xeVgyaCsvZXNZ?=
 =?utf-8?B?VVlpVHB5YjVnWDhocS9EaWdjWkIyMmRUOGVVV3NzT25sQ0FHU0dEWm9WcVhr?=
 =?utf-8?B?Y3JNSzZxbFBoeHdZOVhIUkc0TEpzSUZ1bjBuOVRlZ0VLay91WDRHYUgyZWlG?=
 =?utf-8?B?bTVQUXhpbWlHNzRWUDl1b0p2Q2pqWklvSm1ZUWVqblJWbzlidWhEZ2haYTlk?=
 =?utf-8?B?UUFyWWEwYjNRZVFnYk9QTFFYQVJmcXcwdkl0SlA4NEZKVDQ4S1ZqaGJIYTNo?=
 =?utf-8?B?NmNWelorVUVKUGg0TE5ycGhnTElGemJFY1N5c3pnb2JFcG9NYXAzdHBVL1hR?=
 =?utf-8?B?SVJRK3BjVEVvUkhmTzA1dXZUeGRSaHhmRi9FMnhQUlQxZlhXMDF6QlZhYnBq?=
 =?utf-8?B?VUZSQkFVNVJJSFBtUWo3MWYzcFptblZEb0VSbWFSaUNQM2M4Q1UyYVNTYlZk?=
 =?utf-8?B?VXJyM2M3SDRwaEpDdlgzNHFsVnd6OWxaMElIVUcxbUt4RXdscFBUMVY5V2RC?=
 =?utf-8?B?Q3FVaFRBRjk2eDgrMFRSeWNYYmxRY2lGbEV4d0VHazY3THQ3U3RVelAvM3I3?=
 =?utf-8?B?Q3BTeHlCZWZ0TXZVT2lnR3prczlzRXYwbVlPbG5aVmNSQ0ZGK3kwUUk3MTQ2?=
 =?utf-8?B?OGloMVV6WnBaTnQ3c0NDUjNZbXlBUzRjbFRhcjhuZGhJTnl2S0M3UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37BB54F2FA7D8248A92643776D4ACC56@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60a1492-798f-4a6e-75a2-08dedcedbd87
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 12:37:57.7751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8za0atpnjqpxHrBbXCmLIGU8XEkJwyZIhdZayYyXJKJGP+P5IPnUa0Vqnm1oBBdmsaEsX20AKEWiu56W2AmpMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.56 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22896-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,nvidia.com,redhat.com,vger.kernel.org,google.com,gmail.com,kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:tariqt@nvidia.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:daniel.zahka@gmail.com,m:kuba@kernel.org,m:borisp@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:jianbol@nvidia.com,m:leon@kernel.org,m:rrameshbabu@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:raeds@nvidia.com,m:cmi@nvidia.com,m:dtatulea@nvidia.com,m:sdf.kernel@gmail.com,m:mbloch@nvidia.com,m:sdf@fomichev.me,m:saeedm@nvidia.com,m:aleksandr.loktionov@intel.com,m:gal@nvidia.com,m:lkayal@nvidia.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,vger.kernel.org,fomichev.me,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31B777265DC

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDE0OjI5IC0wNDAwLCBEYW5pZWwgWmFoa2Egd3JvdGU6DQo+
IA0KPiBPbiA3LzcvMjYgOTowOCBBTSwgVGFyaXEgVG91a2FuIHdyb3RlOg0KPiA+IEhpLA0KPiA+
IA0KPiA+IFRoaXMgc2VyaWVzIGJ5IENvc21pbiByZWZhY3RvcnMgbWx4NSBQU1Agc3VwcG9ydCBp
biBwcmVwYXJhdGlvbiBmb3INCj4gPiBIVy1HUk8gc3VwcG9ydC4NCj4gPiBUaGVyZSBhcmUgYWxt
b3N0IG5vIGZ1bmN0aW9uYWxpdHkgY2hhbmdlcyBpbiBhbGwgYnV0IHRoZSBsYXN0IHR3bw0KPiA+
IHBhdGNoZXMsIHdoaWNoIGFkZHJlc3MgYSBsb25nLXN0YW5kaW5nIFRPRE8gaW4NCj4gPiBtbHg1
ZV9wc3Bfc2V0X2NvbmZpZygpLg0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gVGFyaXENCj4gPiAN
Cj4gPiBDb3NtaW4gUmF0aXUgKDE1KToNCj4gPiDCoMKgIG5ldC9tbHg1ZTogcHNwOiBSZW5hbWUg
dGhlIHNhdmVkIHBzcF9kZXYgdG8gJ3BzZCcNCj4gPiDCoMKgIG5ldC9tbHg1ZTogcHNwOiBSZW1v
dmUgUFNQIHN0ZWVyaW5nIG11dGV4ZXMNCj4gPiDCoMKgIG5ldC9tbHg1ZTogcHNwOiBSZW1vdmUg
dW5uZWVkZWQgcmVmIGNvdW50aW5nIGZvciBQU1Agc3RlZXJpbmcNCj4gPiDCoMKgIG5ldC9tbHg1
ZTogcHNwOiBNZXJnZSByeF9lcnIgcnVsZSBhZGQvZGVsZXRlIHdpdGggZnQNCj4gPiBjcmVhdGUv
ZGVsZXRlDQo+ID4gwqDCoCBuZXQvbWx4NWU6IHBzcDogVXNlIGhlbHBlcnMgZm9yIHN0ZWVyaW5n
IG9iamVjdCBtYW5pcHVsYXRpb24NCj4gPiDCoMKgIG5ldC9tbHg1ZTogcHNwOiBGYWN0b3Igb3V0
IGRyb3AgcnVsZSBjcmVhdGlvbiBjb2RlDQo+ID4gwqDCoCBuZXQvbWx4NWU6IHBzcDogUmVtb3Zl
IHVudXNlZCBQU1Agc3luZHJvbWUgY29weSBhY3Rpb24NCj4gPiDCoMKgIG5ldC9tbHg1ZTogcHNw
OiBSZW5hbWUgYW5kIGNvbnNvbGlkYXRlIHN0ZWVyaW5nIGZ1bmN0aW9ucw0KPiA+IMKgwqAgbmV0
L21seDVlOiBwc3A6IEFkanVzdCByeF9jaGVjayBGVCBzaXplIGFuZCB1c2UgYSBkcm9wX2dyb3Vw
DQo+ID4gwqDCoCBuZXQvbWx4NWU6IHBzcDogQWRkIGFuIFJYIHN0ZWVyaW5nIHRhYmxlDQo+ID4g
wqDCoCBuZXQvbWx4NWU6IHBzcDogVXNlIGEgc2luZ2xlIHJ4X2NoZWNrIHRhYmxlDQo+ID4gwqDC
oCBuZXQvbWx4NWU6IHBzcDogRmxhdHRlbiBzdGVlcmluZyBzdHJ1Y3R1cmVzDQo+ID4gwqDCoCBu
ZXQvbWx4NWU6IHBzcDogTWFrZSBQU1Agc3RlZXJpbmcgY29uZmlnIGR5bmFtaWMNCj4gPiDCoMKg
IG5ldC9tbHg1ZTogUmV0dXJuIGVycm9ycyBmcm9tIHByb2ZpbGUtPmVuYWJsZQ0KPiA+IMKgwqAg
bmV0L21seDVlOiBwc3A6IFJlcG9ydCBQU1AgZGV2IHJlZ2lzdHJhdGlvbiBlcnJvcnMNCj4gPiAN
Cj4gPiDCoCBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4uaMKgIHzC
oMKgwqAgMiArLQ0KPiA+IMKgIC4uLi9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vu
L2ZzLmjCoMKgIHzCoMKgwqAgNyArLQ0KPiA+IMKgIC4uLi9tZWxsYW5veC9tbHg1L2NvcmUvZW5f
YWNjZWwvZW5fYWNjZWwuaMKgwqDCoCB8wqDCoCAxOSArLQ0KPiA+IMKgIC4uLi9tZWxsYW5veC9t
bHg1L2NvcmUvZW5fYWNjZWwvcHNwLmPCoMKgwqDCoMKgwqDCoMKgIHwgMTAwNyArKysrKysrKy0t
LS0NCj4gPiAtLS0tLQ0KPiA+IMKgIC4uLi9tZWxsYW5veC9tbHg1L2NvcmUvZW5fYWNjZWwvcHNw
LmjCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDE4ICstDQo+ID4gwqAgLi4uL21lbGxhbm94L21seDUv
Y29yZS9lbl9hY2NlbC9wc3Bfcnh0eC5jwqDCoMKgIHzCoMKgIDEzICstDQo+ID4gwqAgLi4uL21l
bGxhbm94L21seDUvY29yZS9lbl9hY2NlbC9wc3Bfcnh0eC5owqDCoMKgIHzCoMKgwqAgMyArLQ0K
PiA+IMKgIC4uLi9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX21haW4uYyB8wqDC
oCAyMyArLQ0KPiA+IMKgIC4uLi9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX3Jl
cC5jwqAgfMKgwqDCoCA4ICstDQo+ID4gwqAgOSBmaWxlcyBjaGFuZ2VkLCA1MTYgaW5zZXJ0aW9u
cygrKSwgNTg0IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IA0KPiA+IGJhc2UtY29tbWl0OiAzMTgx
NmZjNWQ5YWNmOGNkZjIyNmNkZDBkYzI5NmU4Y2YxNWNjMDMzDQo+IA0KPiBUaGFua3MuIEV4Y2l0
ZWQgYWJvdXQgdGhlIHN1cHBvcnQgZm9yIG1seDVlX3BzcF9zZXRfY29uZmlnKCkuIEpha3ViDQo+
IGFuZCANCj4gSSBoYWQgYSB0ZXN0IGNhc2UgZm9yIHBzcF9kZXZfb3BzOjpzZXRfY29uZmlnKCkg
dGhhdCB3ZSB3ZXJlIHdhaXRpbmcNCj4gdG8gDQo+IHVwc3RyZWFtLiBJIGp1c3QgcmViYXNlZCBp
dCBvbnRvIG5ldC1uZXh0IGhlcmU6IA0KPiBodHRwczovL2dpdGh1Yi5jb20vZGFuaWVsZHphaGth
L2xpbnV4L2NvbW1pdC9iNThlOWE5OTU3M2NmNmI4ODRlNWZlMzIyN2M5YWY3YTFmMGQ4MGIwDQo+
IA0KPiBJIHJhbiBpdCB3aXRoIHRoZSBzZXJpZXMgYnV0IGFtIHNlZWluZyBhbiBlcnJvciB0cnlp
bmcgdG8gY2F0Y2ggDQo+IHVuZGVjcnlwdGVkIFBTUC1VRFAgcGFja2V0cyBhZnRlciBkaXNhYmxp
bmcgYWxsIHZlcnNpb25zIHdpdGgNCj4gc2V0X2NvbmZpZygpDQo+IA0KPiBUQVAgdmVyc2lvbiAx
Mw0KPiAxLi4zMA0KPiBvayAxIHBzcC5kYXRhX2Jhc2ljX3NlbmQudjBfaXA0ICMgU0tJUCBUZXN0
IHJlcXVpcmVzIElQdjQNCj4gY29ubmVjdGl2aXR5DQo+IG9rIDIgcHNwLmRhdGFfYmFzaWNfc2Vu
ZC52MF9pcDYNCj4gb2sgMyBwc3AuZGF0YV9iYXNpY19zZW5kLnYxX2lwNCAjIFNLSVAgVGVzdCBy
ZXF1aXJlcyBJUHY0DQo+IGNvbm5lY3Rpdml0eQ0KPiBvayA0IHBzcC5kYXRhX2Jhc2ljX3NlbmQu
djFfaXA2DQo+IG9rIDUgcHNwLmRhdGFfYmFzaWNfc2VuZC52Ml9pcDQgIyBTS0lQIFRlc3QgcmVx
dWlyZXMgSVB2NA0KPiBjb25uZWN0aXZpdHkNCj4gb2sgNiBwc3AuZGF0YV9iYXNpY19zZW5kLnYy
X2lwNiAjIFNLSVAgKCdQU1AgdmVyc2lvbiBub3Qgc3VwcG9ydGVkJywgDQo+ICdoZHIwLWFlcy1n
bWFjLTEyOCcpDQo+IG9rIDcgcHNwLmRhdGFfYmFzaWNfc2VuZC52M19pcDQgIyBTS0lQIFRlc3Qg
cmVxdWlyZXMgSVB2NA0KPiBjb25uZWN0aXZpdHkNCj4gb2sgOCBwc3AuZGF0YV9iYXNpY19zZW5k
LnYzX2lwNiAjIFNLSVAgKCdQU1AgdmVyc2lvbiBub3Qgc3VwcG9ydGVkJywgDQo+ICdoZHIwLWFl
cy1nbWFjLTI1NicpDQo+IG9rIDkgcHNwLmRhdGFfbXNzX2FkanVzdC5pcDQgIyBTS0lQIFRlc3Qg
cmVxdWlyZXMgSVB2NCBjb25uZWN0aXZpdHkNCj4gb2sgMTAgcHNwLmRhdGFfbXNzX2FkanVzdC5p
cDYNCj4gb2sgMTEgcHNwLmRhdGFfc2VuZF9vZmYuaXA0ICMgU0tJUCBUZXN0IHJlcXVpcmVzIElQ
djQgY29ubmVjdGl2aXR5DQo+ICMgRXhjZXB0aW9ufCBUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNh
bGwgbGFzdCk6DQo+ICMgRXhjZXB0aW9ufMKgIMKgRmlsZSAiL3Jvb3Qva3NmdC1wc3Atc2V0LWNv
bmZpZy9uZXQvbGliL3B5L2tzZnQucHkiLA0KPiBsaW5lIA0KPiA0MjAsIGluIGtzZnRfcnVuDQo+
ICMgRXhjZXB0aW9ufMKgIMKgIMKgZnVuYygqYXJncykNCj4gIyBFeGNlcHRpb258wqAgwqBGaWxl
ICIvcm9vdC8uL2tzZnQtcHNwLXNldC1jb25maWcvZHJpdmVycy9uZXQvcHNwLnB5IiwNCj4gbGlu
ZSA2MDgsIGluIGRhdGFfc2VuZF9vZmYNCj4gIyBFeGNlcHRpb258wqAgwqAgwqB1ZHBzLnJlY3Yo
ODE5Miwgc29ja2V0Lk1TR19ET05UV0FJVCkNCj4gIyBFeGNlcHRpb258IEJsb2NraW5nSU9FcnJv
cjogW0Vycm5vIDExXSBSZXNvdXJjZSB0ZW1wb3JhcmlseQ0KPiB1bmF2YWlsYWJsZQ0KPiAjIEV4
Y2VwdGlvbnwNCj4gbm90IG9rIDEyIHBzcC5kYXRhX3NlbmRfb2ZmLmlwNg0KPiBvayAxMyBwc3Au
ZGV2X2xpc3RfZGV2aWNlcw0KPiBvayAxNCBwc3AuZGV2X2dldF9kZXZpY2UNCj4gb2sgMTUgcHNw
LmRldl9nZXRfZGV2aWNlX2JhZA0KPiBvayAxNiBwc3AuZGV2X3JvdGF0ZQ0KPiBvayAxNyBwc3Au
ZGV2X3JvdGF0ZV9zcGkNCj4gb2sgMTggcHNwLmFzc29jX2Jhc2ljDQo+IG9rIDE5IHBzcC5hc3Nv
Y19iYWRfZGV2DQo+IG9rIDIwIHBzcC5hc3NvY19za19vbmx5X2Nvbm4NCj4gb2sgMjEgcHNwLmFz
c29jX3NrX29ubHlfbWlzbWF0Y2gNCj4gb2sgMjIgcHNwLmFzc29jX3NrX29ubHlfbWlzbWF0Y2hf
dHgNCj4gb2sgMjMgcHNwLmFzc29jX3NrX29ubHlfdW5jb25uDQo+IG9rIDI0IHBzcC5hc3NvY192
ZXJzaW9uX21pc21hdGNoDQo+IG9rIDI1IHBzcC5hc3NvY190d2ljZQ0KPiBvayAyNiBwc3AuZGF0
YV9zZW5kX2JhZF9rZXkNCj4gb2sgMjcgcHNwLmRhdGFfc2VuZF9kaXNjb25uZWN0DQo+IG9rIDI4
IHBzcC5kYXRhX3N0YWxlX2tleQ0KPiBvayAyOSBwc3AucmVtb3ZhbF9kZXZpY2VfcnggIyBYRkFJ
TCBUZXN0IG9ubHkgd29ya3Mgb24gbmV0ZGV2c2ltDQo+IG9rIDMwIHBzcC5yZW1vdmFsX2Rldmlj
ZV9iaSAjIFhGQUlMIFRlc3Qgb25seSB3b3JrcyBvbiBuZXRkZXZzaW0NCj4gIyBUb3RhbHM6IHBh
c3M6MTkgZmFpbDoxIHhmYWlsOjIgeHBhc3M6MCBza2lwOjggZXJyb3I6MA0KPiAjDQo+ICMgUmVz
cG9uZGVyIGxvZ3MgKDApOg0KPiAjIFNUREVSUjoNCj4gIyAjwqAgU2V0IFBTUCBlbmFibGUgb24g
ZGV2aWNlIDEgdG8gMHgzDQo+ICMgI8KgIFNldCBQU1AgZW5hYmxlIG9uIGRldmljZSAxIHRvIDB4
MA0KPiANCj4gSSByZWNhbGwgdGhpcyB3b3JraW5nIG9uIGFuIGVhcmxpZXIgcHJvdG90eXBlIG9m
IHRoaXMgZmVhdHVyZSBmb3INCj4gbWx4NS4gDQo+IEFyZSB0aGUgc3RlZXJpbmcgcnVsZXMgc2V0
dXAgdG8gZHJvcCBQU1AtVURQIHBhY2tldHMgd2hlbiB0aGUgDQo+IGNvcnJlc3BvbmRpbmcgcHNw
IHZlcnNpb24gaXMgZGlzYWJsZWQ/DQo+IA0KDQpXZSBkb24ndCBoYXZlIHBlci1wc3AgdmVyc2lv
biBzdGVlcmluZyBydWxlcy4gSWYgZWl0aGVyIHZlcnNpb24gaXMNCnJlcXVlc3RlZCwgc3RlZXJp
bmcgcnVsZXMgYXJlIGNvbmZpZ3VyZWQuIFdoZW4gYWxsIHZlcnNpb25zIGFyZQ0KZGlzYWJsZWQs
IHN0ZWVyaW5nIHJ1bGVzIGFyZSByZW1vdmVkLg0KV2l0aCBubyBzdGVlcmluZyBydWxlcyBpbnN0
YWxsZWQsIFVEUCB0cmFmZmljIHNob3VsZCBub3QgYmUgYWZmZWN0ZWQuDQoNCkkgd2lsbCB0YWtl
IHRoZSB0ZXN0IGFuZCBkZWJ1ZyB3aGF0J3MgZ29pbmcgb24sIGFuZCBnZXQgYmFjayB0byB5b3Uu
DQoNCkNvc21pbi4NCg==

