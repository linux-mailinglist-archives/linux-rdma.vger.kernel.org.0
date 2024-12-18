Return-Path: <linux-rdma+bounces-6622-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D119F64C1
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2024 12:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50FB7A1DA7
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2024 11:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F67D19F41C;
	Wed, 18 Dec 2024 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K5fjj3rt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A97A19ABC2;
	Wed, 18 Dec 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734520959; cv=fail; b=mnnqZe9GwEgJ15DQySCNp/rFG+IWpgZU5DIlFILQTsl+ASFRhCMv8cpt0aw74qMHSPmImCehbpajGRDL70Je4TysTnb8b+swd2kY8i7maL/at4GDuHLurG46bptH3IRCHPFz+ZZOuyRcXoV1f7tGf8tfZ6lbsBWSYpnqoI1JdWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734520959; c=relaxed/simple;
	bh=7a95kWMYXR6EbXJ7p8EzFHN8qDJSUiQ5G/KlNmEhpoI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cX27wZ9jxIr5aW+bm15X+hqqQXzW/bXbqsIhfeF8uRrmH04b4Sg/5tJOqkDSXqAP1yzUtVrtanSQN2BM4Jpjh9A4A6c3n1OlPjGnMweG/OqU30NUiqqyG3fwCyVQaUZxaBdXFTL/p6kNq0ii1VkJy+mp9n1a6cNQBOwTVACs9hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K5fjj3rt; arc=fail smtp.client-ip=40.107.95.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLLsoI87yhEeFPoQnZRLwpbFKqa1KNg26pLxA+hyKvgAqyZ52LgA76BN1m8bZBR+BMlGeMm8lUm+YlpqmH1S7dvl5juplktUi1VG4s2358OHa7N99zha0NOkf1/zfjmbSPRCdSVAQo3JjmB3Lm2S71IYowydMbXb+RSxtbiWhpcrhu9bh1d6pfzJI8e/eS5669UZf/OPVttlWypismjTjPXlBWy16ugabRiDApKfaF6JmF+sHolVkP5FbLPGQB1dfJ1wsbhJme84zCYUNFP8aiifgPspOxtUN9A1cw2J5JWmOGTEkOPTNdkKgvgWgWq89HDBTUjLq334WbzIT5pt0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a95kWMYXR6EbXJ7p8EzFHN8qDJSUiQ5G/KlNmEhpoI=;
 b=E8ZI2CAfaXaGtMLHazn1c0FGtUyBFd1phyLVuZKrSfxn2vHxaNnD7IZzLblGSwAP146mjeE1CLADd/GaJ881N/UZZIFgLUAIjckab5PYmGi04EzXUZ7bAG8cuTloBUQOZkHPnWdif5AEVdGm4ycQME3Pggf3/VBgNykGL9SHAZYUQZhLZIv39YHmAXZIXOAf0yW1FzgcP10rd3vFVDTaBSRA2je3YrJMpMfSEjcTCWkMYy3EJ1EWCmhGTY3zPNpOESh0L89UADoWws2rBRAm8lZqiulIYo4t1faXCrCO7AHdexHRSKY0G5dYlBWPGhttJ0/BAzgN8CU0BmzM+t9GvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a95kWMYXR6EbXJ7p8EzFHN8qDJSUiQ5G/KlNmEhpoI=;
 b=K5fjj3rt7Lw/UiwuErLeLNw1RxNk2yj4607parwoim/BmJqPn9r1vjNEoQQeOtcE5f2tDAWqCR/gYia1+Oi3qoD5PyZm8EAPyhPkg4BoXs4HvbkDeOpRb2yrTx86t2EeoT19Um2qUiKkGNRUazRD2tqdr+HUi+n+RYyhweIl+OMj8VXvtV3/V8C6RfIwJo2E0QYjzffoPiEyo41oJCs+EBJdb0lozI1fhi9ZhtEkD96ebGsrGIXULAxZzERGm4ChDM6P9JVXTIm4oRcKmDx1ke9RnmEV3xPFl6XS7UdmnSHxvCRUVIc0gvf25DnvYAWOKeIC1nA29aur0pfX8WidQg==
Received: from DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) by
 SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 11:22:34 +0000
Received: from DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b]) by DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b%3]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 11:22:33 +0000
From: Alex Lazar <alazar@nvidia.com>
To: "jdamato@fastly.com" <jdamato@fastly.com>
CC: "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
	"almasrymina@google.com" <almasrymina@google.com>,
	"amritha.nambiar@intel.com" <amritha.nambiar@intel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "bjorn@rivosinc.com"
	<bjorn@rivosinc.com>, "corbet@lwn.net" <corbet@lwn.net>, Dan Jurgens
	<danielj@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"hawk@kernel.org" <hawk@kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"johannes.berg@intel.com" <johannes.berg@intel.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "leitao@debian.org" <leitao@debian.org>, "leon@kernel.org"
	<leon@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, "mkarsten@uwaterloo.ca" <mkarsten@uwaterloo.ca>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "skhawaja@google.com" <skhawaja@google.com>,
	"sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, Tariq Toukan
	<tariqt@nvidia.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Dror Tennenbaum <drort@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: Re: [net-next v6 0/9] Add support for per-NAPI config via netlink
Thread-Topic: [net-next v6 0/9] Add support for per-NAPI config via netlink
Thread-Index: AQHbUSTTpLzfyThV+U+tYxzrE1zIMQ==
Date: Wed, 18 Dec 2024 11:22:33 +0000
Message-ID:
 <DM8PR12MB5447837576EA58F490D6D4BFAD052@DM8PR12MB5447.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5447:EE_|SJ2PR12MB8182:EE_
x-ms-office365-filtering-correlation-id: 1f46b07b-517e-48af-cb0e-08dd1f5644a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?sSMY2kYzEjhoIIyA3mkPgUh7QH8NaM4CkoiYEHlPcFmZoUXRNFmGsgP4D7?=
 =?iso-8859-1?Q?bf3JS7a80npfsXI4HVLYiio3RNQo9IUvfYAh1VSbAaBLTClER9QHPQQwIP?=
 =?iso-8859-1?Q?QcwvjbNM96waeKV/LzkeaMwZPvea2n6OqStNZNghJIevzitsk1J/cXjWqt?=
 =?iso-8859-1?Q?gB7aVwKkVrXaoqd88kyNvpFCzTF9bnPngTHlU4FihFwmHaBAb4CvskMNsE?=
 =?iso-8859-1?Q?hjjx3pMloxu5hfp3xjOUx3UqNje9XY5lZXfyXiaIgi2CnNKznSL/PtWiQS?=
 =?iso-8859-1?Q?R6GPCz7HkoiWSvMgo2MKZhvhZXWrAQRElFgsYQO4h1nGeuT3j/7Unmqsmh?=
 =?iso-8859-1?Q?XqiP6ozdWMfL/RLMB2lTC6MOCnnvGUZeEb4SnBYA7IwFsnbm9pjxcUDFPM?=
 =?iso-8859-1?Q?zP72214v+lKlilS7WWBgh/rpDj0pQY909Um+IruF/9jRdofxr24/4aIx4w?=
 =?iso-8859-1?Q?u3KzgVJQBptFeMPwJ1SZ56LDBUK0fuw7G6FOJi16aK8eO8MgUryxqaYRDo?=
 =?iso-8859-1?Q?8hdnQmbqrLGRZYeRWu8iX1Izp6DMjop/oMfwo8BagUR2yNnwCqhEdxod8H?=
 =?iso-8859-1?Q?+CR9JG4lqSSfNcd8zult2TP73wL7S+ozYtO46Lq2ix99pCkJVkbsRPudx2?=
 =?iso-8859-1?Q?z1sGO0jN/ji1mxvEwszK4blfkA+BFmqNLEFpsmPy2XUHv41bDNE9qO2vzg?=
 =?iso-8859-1?Q?CkXzee+SjCfJihJIdN/E31v5GkvcE8b4WRIjmADwJf9BjjqUvaR1+SG7km?=
 =?iso-8859-1?Q?U7qAqvfX/tXYRlHslmn8hPvB1M7+GTOVh/5nBCMyF1BOR1xJveU99vwVUk?=
 =?iso-8859-1?Q?qjsKmRT9vG1JWDIYRdGNn6eSL52FrlgBJYLa01ydzg7McKsNHLwffRRe3e?=
 =?iso-8859-1?Q?DaaXseVv1OvIq8IrQcTW+UMLRDrqI5bpBtYDos6e9jN3pnywExDxE47pxU?=
 =?iso-8859-1?Q?NydCoVZVkIyx0Kg5zzYIxY2irLS3+ZHSrofFgvrPnTvlm2HW/1JGTraAb5?=
 =?iso-8859-1?Q?/c6avHcP7d/G356CJ8KIaSbfqXCu3N1ilswS4cQBkrd9LWfjT/DeuejGDV?=
 =?iso-8859-1?Q?dwAyTah2le464KWlBTNlQtB69WHHv76nxCCmKdn6JgQWHbNwoMmjqMln/M?=
 =?iso-8859-1?Q?+u5g76KkI7DCpa00lnfTHo43p9TttjIubg9nB8qs8fp11xu/vWebKGhPBu?=
 =?iso-8859-1?Q?DSPGNk8geKti6LDWOy+I3UKc3e2/ZwTNpQLIFzNx72zWjNa1CyiBGhpPX0?=
 =?iso-8859-1?Q?YDd2XpztY5jBhdmFl4aCrND5FZhRYt8AsDjH1hXahomrxdSj5H00FnpO4L?=
 =?iso-8859-1?Q?8DBJfSTvDtTxG2wh/CQhuL0GQS2OxBYT1WAGOKyupTcHU7dJo2Vj6l2Bih?=
 =?iso-8859-1?Q?555UdlYEam9sJSlhaPgBnJw9ATJTciGRA3mnJzsv3LLxDQ/im1OOQUKOAx?=
 =?iso-8859-1?Q?SjLYs/aNTGcmyh5NLilRPNRhoHyIA1djMPp/0I9P2Q3cUon+W3SEWx2rI+?=
 =?iso-8859-1?Q?OEqUELa8es9BCNyKM1BUoK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wqYZrycKMpBYxe1qDUaoa0AaoBtty1iqyieI1ac4Ha/5XtptB6xm7S/Oq8?=
 =?iso-8859-1?Q?0LMXpJfDAzZHSmyOLVNo2bg+4EsVDZe6vQGMwhncYIKvLChs2NIxGKpG1W?=
 =?iso-8859-1?Q?fxo/UkAo2w0/K6iyxbjZPLCUutecVEcksQgIiV9HmFUB1A70rc/5lauk1I?=
 =?iso-8859-1?Q?lejU3MeJfm+H6EHlapSMEs0ZTEg1q2NZNw23l15LVgSinIe9he9x7mjQ4V?=
 =?iso-8859-1?Q?Z9L24Thp9ClNLDepzt+sdTmpuZK2znTht4+6DBJhQ3okxjTv8maZl2esVq?=
 =?iso-8859-1?Q?8PjFQl4VOswSToyLsU5ju1nUHOzGXw4qqvirI6CU3buqUCBxWf+OEN1NNI?=
 =?iso-8859-1?Q?6rRb+i1YWKOiadGL4oBYzwHjjzH+KP1qy40aXCPB2qwxNG+f0OdqZwOJYf?=
 =?iso-8859-1?Q?dhfuIBRd+HKfw0ZNVCdo3uqqGPTei2EXqStd/53jT3oUdc9PVRuAnkRp5v?=
 =?iso-8859-1?Q?UIwVFop087VIJqKq0Xrt7okWOW043GmEoNV+AgnpIghEj8FoONYhV7CcTl?=
 =?iso-8859-1?Q?hQ7BNUyQRnNk7JMeysUo1FePTr6AXePrub7vl5gU9Gmc9g/yiJkO1vuMGe?=
 =?iso-8859-1?Q?/1BHy3tUpoBRhsKWoejFc/XCZ3N86xF4ZeQSjENp3fG70gP2AoK5jK5k3G?=
 =?iso-8859-1?Q?B5R5MVSDl9r8JyXPAerZeom9GvhQCR7Am/zYwGZh2jdi7Z8sHbtXfcuanM?=
 =?iso-8859-1?Q?rWKSokFpvPIJLyMEEKoLZPiEYm2f2cP7OtjuAmtMbNMAXengCvuioEN8I4?=
 =?iso-8859-1?Q?mlphoRaX6hdxvrFeJcp2QOPxxsTdV2B43KpJ5yxIzrEnL+/D+OrzEvEOxH?=
 =?iso-8859-1?Q?88hJmDxnM226mVwg9DJxwN+eMPUNGsXpVzfoYzkdf5O7xTSM4thJjcWdOV?=
 =?iso-8859-1?Q?g2mqc2MA5FS71S7houQ4mYaEfz6Rajw5LYQ6Jqi2yMggxrqTJ0QCkYyrBo?=
 =?iso-8859-1?Q?bvyJNvNJq5AnmUSyt49CORJNG+leJQde/9UNxzCO26Sp+DN7l3tBv34eBK?=
 =?iso-8859-1?Q?9XqRfFhjGxdlCE33PGNZq/XSiv6ViaPYoDpP2J+gSDlenDvVdKASfCTkzc?=
 =?iso-8859-1?Q?Iw/pirdzL6SUdUlOoNqVTfJLE9tMTcCiEXA4sPhOTI1fWhl0ghEb6F/eAQ?=
 =?iso-8859-1?Q?j68OjqR9ol+9HLaKcLPI4pC+kbfAV/XxcMUnlAFCFycXsdcX5bkFzHffHl?=
 =?iso-8859-1?Q?ifcHWjmXod8e74zlsBQSZxaEgxyY+nzbh0gBFH2SqztXe8VtdrdLxeLAbU?=
 =?iso-8859-1?Q?fe4X5hj2fqjgFQzKaHHi0wnTbavm+FcTXo7p4/+fyI9OUyOIz4FojafHv8?=
 =?iso-8859-1?Q?z1pe4Lg1UlXmx4DIAlHDejXkeVafP8zOlgmsebqMVT6g0tz93WpfUgRTbg?=
 =?iso-8859-1?Q?izlvAcih+HEi3U0gE9ZJCHyMijw/pUsELIUVfAkJHj8zkWTgnrSSbK/Ehi?=
 =?iso-8859-1?Q?4v+19qJ6eIjf8aav1NQx4YkKgERbPthm1q1Ab5i7STfT3ov5swEZSdB4WZ?=
 =?iso-8859-1?Q?Pqh4YGtAH7goe6SJLqcu1y5ufjRxyh8wC71tfPpATV1REqiM2FzUcGEPp+?=
 =?iso-8859-1?Q?y+nbQjA4h7lWDR1ETR5jWThGQIuQTyefj+tdpw28WvY6smPPh3hddEfhuA?=
 =?iso-8859-1?Q?WlLOqGclYjFnQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f46b07b-517e-48af-cb0e-08dd1f5644a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 11:22:33.5287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YZeKpgJbdlPHaScaa8O+A96JiEQ7btrnttnWg10LAgd80QOgQuqIhhrkL9pdP+bNrgUF8cWHdWPAP3f9fUjjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182

Hi Joe and all,=0A=
=0A=
I am part of the NVIDIA Eth drivers team, and we are experiencing a problem=
,=0A=
sibesced to this change: commit 86e25f40aa1e ("net: napi: Add napi_config")=
=0A=
=0A=
The issue occurs when sending packets from one machine to another.=0A=
On the receiver side, we have XSK (XDPsock) that receives the packet and se=
nds it=0A=
back to the sender.=0A=
At some point, one packet (packet A) gets "stuck," and if we send a new pac=
ket=0A=
(packet B), it "pushes" the previous one. Packet A is then processed by the=
 NAPI=0A=
poll, and packet B gets stuck, and so on.=0A=
=0A=
Your change involves moving napi_hash_del() and napi_hash_add() from=0A=
netif_napi_del() and netif_napi_add_weight() to napi_enable() and napi_disa=
ble().=0A=
If I move them back to netif_napi_del() and netif_napi_add_weight(),=0A=
the issue is resolved (I moved the entire if/else block, not just the napi_=
hash_del/add).=0A=
=0A=
This issue occurs with both the new and old APIs (netif_napi_add/_config).=
=0A=
Moving the napi_hash_add() and napi_hash_del() functions resolves it for bo=
th.=0A=
I am debugging this, no breakthrough so far.=0A=
=0A=
I would appreciate if you could look into this.=0A=
We can provide more details per request.=0A=
=0A=
Regards,=0A=
Alexei=A0Lazar=

