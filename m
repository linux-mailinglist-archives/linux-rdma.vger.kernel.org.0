Return-Path: <linux-rdma+bounces-8911-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C18AA6D3AE
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 06:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E72816BCD3
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 05:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A771EB39;
	Mon, 24 Mar 2025 05:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="gpQKBT/H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F276AA7
	for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 05:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742793392; cv=fail; b=EJW52JCcqP+oTaZN52LTIzps2AFtF6Erht9dGxpd4Vv1RRCFHJvd+3jCnPWBg0Gihtaz2vrZ1bGLmGIhbArQDJkg90qWYTXps4jIxQ5qjERI+HEXJI+reb4kAB9htkG7DTCLAVbo6ddenAL18laCMCCkEpw6BbCBehRyUonxg1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742793392; c=relaxed/simple;
	bh=2vaPr+2QSPoV8pRFZ9JYQW0qK9dY7Vh2M9NKXgK99/8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ksw/H5a95+svTzTF/RaQnvvCsq+yCV18VhFBn9yu6+KDE/sCi0QvCdTGDR1gNFSoNjWlvG1cTrQnYHb3W5yraqDRzBUrcCTYHQS2fH/BRvpTE9BTWDHZkWadClXzbONjeOAldEkcs2NG+9aqb7QmW49theWlcStOLCUjhFWBnYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=gpQKBT/H; arc=fail smtp.client-ip=216.71.158.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1742793390; x=1774329390;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=2vaPr+2QSPoV8pRFZ9JYQW0qK9dY7Vh2M9NKXgK99/8=;
  b=gpQKBT/HqiakW0Hb5x9Gk24dv/ztRYol2qVlXvqu29nEhFz1in+3meuD
   ZSKfkozG80B5gln/IrrssvSZeGk2Dix10srxPGh76taJUNc/BEme4Vhib
   JSQC2tYKMkLfw+6hJdR81gx7G6PJV2LQPfeuo3pH1LmZnO0vJTE7yeGP5
   lQbFB+2UqS9Xz6IuCdiANix7XfkDoOPLDNrX8ZVYa0m4vUFPhpwW2b3+0
   Ph7jv32qr+qMMqAUj9yRq/3JGKPqguuk9BzIWybCoaHo06lcvpy6QwmGc
   fflkk7xwg2LoMRgbvTmy/HWgNwTQrO/xZH77GTOe3hwtQc5VX68Tvkpw6
   A==;
X-CSE-ConnectionGUID: 4ynN80stQTCgt2P+E6OX4Q==
X-CSE-MsgGUID: V9l+Dj1KQ0KmTLojqDzWEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="149882223"
X-IronPort-AV: E=Sophos;i="6.14,271,1736780400"; 
   d="scan'208";a="149882223"
Received: from mail-japanwestazlp17010002.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 14:16:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtVsw0FkB99wz1KXhTIH+UNdtRkbfJ6D6yVdIuOlv3IqsLZvOPEB90OaOrN05dmLF3KKHArk8pidSkRN3nMoKP9P5l2iw2nvlbeaZJ9+s3tm1TD93gYyNHw/zrZ5TNt+X+rYoQayv9uP3RLA1D87fg3jhbYXG/ERsE3Zp44w26fKWEdg6wNy8WzsD8nWc28+fxYcn5xH0eXdo6/BZ0lLmZS4TnacitL0Lkjo2Re6mZD4b9vZ9NuZqjaApR1NixQjBM+IzpdnZLCooOHokABBGZLtSAC6dwlCYbNTtZxReRnzIHCQaB756IkZ+n853kOkrXmg6AFN65+lj7nxwjD5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vaPr+2QSPoV8pRFZ9JYQW0qK9dY7Vh2M9NKXgK99/8=;
 b=n028mKunrQkeVvJdyYG8SF1MkPcfa20z4mIEKR/kJdtej2vpieY0TbsYjfko+BZzcAD1879pCPcLx9sqinBa58u7C2oJJT/pdcvMlZm5vOkFn4NNVYREWft+o3IG9n75WqoPmPK/QbnFj1u7XiVRO76OmF6YM2+FRqbBdXDkPVmH/0BRYr9A6q03AMKaoyeSMah+yXY99HqCIByyQBFzIZT5sF1a0SrXvtN2n60tdgaNIJb9oBrt+SD3VwUTuSXhr8bIvq/oIFcWzu+EZwyMoDUhSzTr7CYtWfbKNJhx3SvFgl79tXoeWq4glndo1+vNUJhIZ0SKN1Cq18G0QJR2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB9872.jpnprd01.prod.outlook.com (2603:1096:400:22c::7)
 by TYRPR01MB13250.jpnprd01.prod.outlook.com (2603:1096:405:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 05:16:22 +0000
Received: from TY3PR01MB9872.jpnprd01.prod.outlook.com
 ([fe80::eeba:ef6c:641:7a88]) by TY3PR01MB9872.jpnprd01.prod.outlook.com
 ([fe80::eeba:ef6c:641:7a88%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 05:16:22 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "leon@kernel.org"
	<leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>
Subject: RE: [PATCH for-next v2 1/2] RDMA/rxe: Enable ODP in RDMA FLUSH
 operation
Thread-Topic: [PATCH for-next v2 1/2] RDMA/rxe: Enable ODP in RDMA FLUSH
 operation
Thread-Index: AQHbl+scPaZtwSZol0SEonAe+im3ebN7m0+AgAYgaoA=
Date: Mon, 24 Mar 2025 05:16:21 +0000
Message-ID:
 <TY3PR01MB9872B01F26908432F2E66ABDE5A42@TY3PR01MB9872.jpnprd01.prod.outlook.com>
References: <20250318094932.2643614-1-matsuda-daisuke@fujitsu.com>
 <20250318094932.2643614-2-matsuda-daisuke@fujitsu.com>
 <2cd35448-7ef5-42ee-8449-926986e4a064@fujitsu.com>
In-Reply-To: <2cd35448-7ef5-42ee-8449-926986e4a064@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZDA4YTAzMjYtNzM2NC00M2MxLWE4ZTQtOTgzYmYzMjE4?=
 =?utf-8?B?OTU4O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMDMtMjRUMDQ6MzI6NDFaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB9872:EE_|TYRPR01MB13250:EE_
x-ms-office365-filtering-correlation-id: 155b81b4-63e9-47a5-997c-08dd6a930432
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVVYR2x4ZXFJRkI5QWgzZGlZVGpFejFZaUpyL2VaU09PbFFnTDRLTDNlcTY0?=
 =?utf-8?B?TSt2RnQ0Q2FFdWQ4cWRBbDZZRk1jTEc1NW5VTlQvbmVQVnVpdnEvL0UwWm44?=
 =?utf-8?B?T2NoMkZFa1lBV2RYQnUxdWhPZGt1Zm9wQUlZK0lKZ3E1T3FDamFObm1GQlFS?=
 =?utf-8?B?alJoMmdpak9zZHdwRzZ3K0xmaDltRXlybG1xT2Y5ci9LSVpxNHg1aFBTRzhB?=
 =?utf-8?B?QmtON0RnL2x3bmlmYnhKYTRRV050R21EZWd4V2RHTE5FTEVHRFprQktZUWxT?=
 =?utf-8?B?TVM0eGVadnVuQ3VHVmp4S3ZvOEs2TXpBU0hDZXFTVlpRVDZxNlVpMmJwb05z?=
 =?utf-8?B?dzhmSktSYzRjTFlyQkRVRTlQbU95VEJWTkZ2TTgvbXArTGxwd2l6RmxXWmJ3?=
 =?utf-8?B?UVV4SE5zNjF6c2JhTmJhNjBEazZCSTJpcHRRYjlJMWJTY0dTV1NRMUFxYXlk?=
 =?utf-8?B?OCtIbHhiRytoMmZsTnN4QWZFb1lWdVYyek5BdmRXeUIyU0tnOGl4WFBkVFlJ?=
 =?utf-8?B?V2l5TTFHZittdEJ2ZEVPR2Jqb09keFk5SllsNVFWb1pKRGEvc0NRU2x3b2l5?=
 =?utf-8?B?UTJaM1JhZG56ZmZnWmZmL1orL1U4YkkreFBQOHNMYys1dTRLbDZzRVVzczh4?=
 =?utf-8?B?Qkh4U1g3SkhGaUNTZWNDT25xUWY3YWF2eHMxSEViU0QvaWhsVjNCSkFQS1VK?=
 =?utf-8?B?UEhheXBSTi94SXJGZHZsV3FyRVBydFdLNG1LQk1sWlAyL1NxWkg5YmNnRi9z?=
 =?utf-8?B?TWE3UlJNRXY3Y3d2dHA5RFMvUjJyQUhlMGZJVFZDQ2Y2ckk2MVlDWTE1ZFpR?=
 =?utf-8?B?Z1B2dktaMTlQL3A3MW9LSmE3VmNkdS9tcWIwRVJEbWhZV243OUNQbFlrbjkz?=
 =?utf-8?B?Ym1JdTN2OGxoVGRhbHdvL1FDbnJUT0VJd0F2K0UvaDUvZklpVjlGOGNuN2d1?=
 =?utf-8?B?SFVVRTFvaTQ3bkg2QjBEalVBZEs4V3lrYTBocGdaOVJ5c05INm9oRTRvdTRu?=
 =?utf-8?B?Z2g5QzdNNVJ4dGJKUmhQR3VoUW5NRTFyQlc2N1hPckNIU0doTHRQeGZobWhL?=
 =?utf-8?B?QWxIVkpGTFNCQnZOYkVIbUhLUHR2VEQ4eUhVOU51R2ZuWGV0NU9jVyttQ2hV?=
 =?utf-8?B?TUZ3eE8rbVNCVmI0S2VaNnQ0WWdFUlY5cXN0MHVWU1ZMcHpOY0p0Qkw3elhj?=
 =?utf-8?B?Q3l6VUJwRzVGZ2pvN1NTV0VrektVRFlrOW4zUDhoeWU5bGcvUW03cHJLeWIy?=
 =?utf-8?B?Y2ZIR0RqZVVMc1dyWjAzdmtGeFF0b210MkxPOUM1MmFLdXNaUDdLYlcrM0d3?=
 =?utf-8?B?QVFFNjdCYzZPQWFYSTNpV0w1RkJnMnEvbmtEc21jNFl4ZTFEeU1TbFJSN3Jz?=
 =?utf-8?B?TVZObTltdUlwb3FSZFJnWTczbEJtVkNoZzFlYjdwYnR2aDNUWllqTEFXOW5m?=
 =?utf-8?B?QkFvb2d1ZW9LNk1jMURLZUVDOXNOWHZFWFh4Q21zOG55KzMwSmkrMU5uOEJp?=
 =?utf-8?B?NGM5ZG9nTW95a0lBWjZZbTZCSWNDMXZDaGFiNGtTR1FkcEE2ZzE4N0pyU09r?=
 =?utf-8?B?dDlQT245STRWaXRaT0JiT3R1bWRia01EZVl4dXhqN3hIWUhXWlNmZEFIbE1a?=
 =?utf-8?B?bktqL3U0blRaQURIYVdLMk8xdEVLWVV3QXh1V244b2RxbSsrdVpWdm9SY09T?=
 =?utf-8?B?WXgweGt1TytZQ0xnaVVINnBscHRoM3F5SmJJdGdsUzdqN3ZRQ1JEbWVwdmVS?=
 =?utf-8?B?VTFuQ2ozWEo4RHNZeFEwWk56Z3FSaWhFd3dkc0tYNEl6SFVwazBaR080UDRi?=
 =?utf-8?B?SEhqSWJzL2FWYkZUZ0Rnd3ZuWWJROFhnZ2tqVjlHU0E3ZnEwMGpnMm5BRFFO?=
 =?utf-8?B?N2VBbEZuWjNmdlVURTlTQ21EQnI2cEVUdGRva0pYS1ViWXBFbzBxRWZjeFBE?=
 =?utf-8?B?SEx6Z1VDMXNVamVGZ21oL1VjVEtiZFlBcmtkYndLMDFUSDNwUzQ4cy9xNlM0?=
 =?utf-8?Q?/et8QR2C44H5hzJH0OZfV0hUH1Xffc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9872.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHlFZGFIUkRoZGlndW91QkZJNDRHcnNpTTdkdGxHd2FXUHMxelZlN1hzaTQz?=
 =?utf-8?B?YWttczlDeXFOZ2g1RDduUEwxaFpzM3BSaGU2ak1NWlNtOXc5aTdYUUZwYlUv?=
 =?utf-8?B?OTBhRWxMUUZFT2dLYmpGS29SZkppWW1DTDIzVmk3QVEyd2l1cGtXMmFvb0Fz?=
 =?utf-8?B?ZzhRZzNXOU9TTU9PdDJpMDV2MkR4SXFncnViYW1XTFNUS0hTcVRGYU82eHdC?=
 =?utf-8?B?TXQ5akRvcysrMmpWYU4vT3dHSHBPY3BPdmRLcW9TR1pjL0dKRG1TQm5peWZs?=
 =?utf-8?B?ZVZYWEo5U0NVZVpPTVYxemZ1WkZmUTFBMjlJUzdZVDI5YzFVMlZUM3Y0TDA0?=
 =?utf-8?B?TDIyMHBjN0JuMGN5WW5pKzJGS2hTL2hpc2JqaWNaSThZclYzb1NiZDBVbmxP?=
 =?utf-8?B?UTdpS05HeEUyUmJwRXlyVlAzYkIyWlNkRlMyODhhNWFUd0FiRWsxMHpTNWtw?=
 =?utf-8?B?ZTcwaFEyZEUweFJkc1NLZTdhWk5zdmpFOVo1Q2NLZXY5SURndE84cFkzZEho?=
 =?utf-8?B?VEYxUTFNZWZXK3lqcUlMSGxzazRTVGxFQkgxZFJsL3N6THhTamx2bHdRNEdT?=
 =?utf-8?B?dFh3czdwTVRFK2JOVUdMU042MEw3T1hDbXIyb0s0VHpjaC9MdHI5aUZ1b1Jz?=
 =?utf-8?B?TGN4STBtdFk0VDcxOWdGQlF4S2FMeDk4bGc2Ukp4WStRVHlvRzdJYnpoT3Vu?=
 =?utf-8?B?VmZYdi9RMVgwWUlOR01BTEpTR243YlhFOThycjRRbm1Qcms5Rjc5bXlFTXRS?=
 =?utf-8?B?bGR1RW55VHIwNzNTa2Q1L0IxdjRRTEtGV0VaVVNwM2k1TUpUOEVNNk9OcDJP?=
 =?utf-8?B?T2JGaDBCN3V6KzBHWmVISUpYdW4wVisvcFlqTFdCOGJxblgybWJ4QlRuaXZm?=
 =?utf-8?B?N1dLdk5zTkI4VFg3K3hCNS85bDFjTzNyTC9sMVJaR01SNlRrSC9yVldVOW8x?=
 =?utf-8?B?TkRySy9jampzNXEzNEplVHFQTWR5cmZEWFVaYlVWSjhEZldpOUVLRmFHUjFt?=
 =?utf-8?B?czdFdU5qbkhXTk14c3dDM3doUVJjYmtOaFdudEU0bjdKb3lpMUwrS3R6OWtp?=
 =?utf-8?B?S3BaU3EyVmZxdnE0aGlKRzBSTjFFeThoaG85NCtUbEw5NGI0ZTZ4MTdDVWl1?=
 =?utf-8?B?K2VZSUFwQmc2MmVpOWpjTUhXcnBLSzAzZ2kzcHh5UCtxWTk2cmE4clM4TkNR?=
 =?utf-8?B?cjZzOVZzNi9PdVhheW4yRXV6WFliQW5xMU5Dbjk2OFNDeWtDQkVXMnMrb2Nr?=
 =?utf-8?B?d1JaSUFyY2p4VjF3aG5ER3JSQnBSWnkxemhnTEhMMllGYVVsSklHcHlUUlR4?=
 =?utf-8?B?K3lFenNtV0NJTEN4U2hkZVZ3dUhubTQxVzhVYkl5eW1WN0JwaWFEV3lGUFYy?=
 =?utf-8?B?bDRmcWtKMlZxbGR5dTVWOTFVNXcrajBjMUZuRjVUa200dnlkQzl2dTJObVNk?=
 =?utf-8?B?QlNtbUJGTGg3RmNId05vZXhobC90aTRzS3VZM3krL09aTXVZQU9kK2M4ZGZu?=
 =?utf-8?B?MjBIUVRzcDF2MkVONEZmNWRjSys2cU1QL3Z0YndaejRVSXpDdWhpTndNaVpy?=
 =?utf-8?B?NVhMdEI2UzFxK3krd1R0MWRtU29VU3lRRERKYmRhV1YvOE1FMG5SYkZrRGlU?=
 =?utf-8?B?L29oYnhRUVVZZHdpSUFvb2t1OEdPSDI2YWswVkhvVGJ5S2o4akRTclRES0lk?=
 =?utf-8?B?QXFXMzJwNFlmeXkwM3NoOVk1MktwZitucjAzYXJUaU1rSHRPa254R2x3UW9j?=
 =?utf-8?B?RUhoU1ZiaWZoMzIzTkFiVmRvUGxNbUlLUDhsaTE2WFNYK3pGK2xTUks2ZlR2?=
 =?utf-8?B?aDVQT3NaVTkvZGVRWFg4MldtWHRaNHpvRlVrYllySkcvRGNyTjB1R0p3Slh4?=
 =?utf-8?B?TWdRcHlUQ1ZaZWM3d2ZnMzlYNDk3Tm5WdDFuTlJMbyt1Sk5YTVRuSEY5Q043?=
 =?utf-8?B?RDZwcmM4ZVBZck1uYVJGNjB2OGhiT3IwcnVlNHVQKzhoNXBtMldRalNJaFVZ?=
 =?utf-8?B?VG8xTjg0cm9MMGhsZGw1TkV4alVpUmtIeGtXVCszQ0VmRGR2R3ZRT2FwL2N2?=
 =?utf-8?B?T0lEMTZxaW5KZDNEOUE2eXJjdWt6ZUJpeEM0WTN0elh3RThvdTdkTmlEbGRt?=
 =?utf-8?B?UlVJeHA3RGdVVnJidTdKdDFjUWJMbmZ6K3cyZkRmenZUSUtkcHRWK3BUMTh6?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x3Rgq1YQx6kxaUIC+eoejAWaxoNSmP8WJega8+tmV0ujuA+6B6ueuFcSMfZB44k0FFCeuxeCqpWMwUGibyS5XI2WzBd8GpmHe6VI0C8/N2CO0MmUyIMoAaO3gh/C/AYYLisp94pts9SahVKEcmac6pp3as0ZdXGj0jeWLeg7OteY14nVNqk3YEK9y16jJKDAVTLFIh6Wpx3au+M+3Mt7qWcnAs+jDx+3XuXKpUWVGgMxUubbpZXxrw94Ir9OVE1+P5UM4eD2SJ+F+zUy9EO+5E/5yV9actB+TSYB9HWHKY+X57a/DjkY0FKnyLixQb/eT1KRMBxkqV5KVDzd9h+9iBR2f8uDPpDezrRqghzKjiemDTCUj1+mRhH31JfCA2lV2AqQdUH42MwCK6RZUGl6YPicFauVid40Lw2TJgOpXJgXh8kS/rg5Pj/USSETX7dy/eJiUzvwwiy/0AMtF/HmREwrIwl2TU+WovJnRc6xsUSAcRjLkDnd1LNXjXY8UQ2PCFWWkQmvFcPVasCiVniI/7NDFNiK823PQ5TWwsbQVmpY6dvYkJVQjsgbIDCrzHg5aThIyysUQtgZr4WtphWFty3KM/WMwVMcHBgY5VxfvSa47T6X712RznnddtgmPgA7
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9872.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155b81b4-63e9-47a5-997c-08dd6a930432
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 05:16:21.9540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibL0PNnI+8y111EPPe+ipK93wl6IAaEBvLhDkFj7NdnLAoPW/A7Y4ZToovkStzLabmGNivlPvLCgP+Uc/P4dTXNEbxQs+JKQ/emZ60tEJYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13250

T24gVGh1LCBNYXIgMjAsIDIwMjUgMzo1OSBQTSBMaSwgWmhpamlhbiB3cm90ZToNCj4gSGkgTWF0
c3VkYS1zYW4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaGVzIGluIE9EUC4NCj4gDQo+IEl0
IGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlq
aWFuQGZ1aml0c3UuY29tPg0KPiANCkhpLA0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IA0K
PiBIb3dldmVyLCBJIGZpbmQgbXlzZWxmIGhhcmJvcmluZyBhIGhpbnQgb2YgaGVzaXRhdGlvbi4N
Cj4gDQo+IEknbSB3b25kZXJpbmcgaWYgd2UgcmVhbGx5IG5lZWQgcmVtYXAgYSBwYWdlIGJhY2sg
ZnJvbSB0aGUgYmFjay1lbmQNCj4gbWVtb3J5L3BtZW0gZGV2aWNlIGZvciBqdXN0IGRvaW5nIGEg
Zmx1c2ggb3BlcmF0aW9uLg0KDQpUaGF0IGlzIGEgZGlmZmljdWx0IHF1ZXN0aW9uLCBidXQgSSB0
aGluayB0aGVyZSBhcmUgdHdvIHJlYXNvbnMgd2Ugc2hvdWxkDQppbnZva2UgdGhlIHBhZ2UgZmF1
bHQgaW4gdGhpcyBjYXNlLg0KICAxKSBFdmVuIGlmIHBhZ2VzIGFyZSBzdXJlbHkgbWFwcGVkLCBp
dCBtYXkgYmUgcG9zc2libGUgdGhhdCB0aGUgdGFyZ2V0IE1SDQogICAgaXMgdHJ1bmNhdGUoMikt
ZWQgd2l0aG91dCBub3RpZnlpbmcga2VybmVsL0hXIG9mIHRoZSBtZXRhZGF0YSB1cGRhdGUuDQog
ICAgSSB0aGluayB0aGlzIGNvdWxkIHBvdGVudGlhbGx5IHJlc3VsdCBpbiBpbGxlZ2FsIG1lbW9y
eSBhY2Nlc3MsIGFuZCBPRFANCiAgICBjYW4gcHJldmVudCB0aGF0IGJ5IHVwZGF0aW5nIGRyaXZl
ci9IVy1zaWRlIHBhZ2UgdGFibGUNCiAgICBDZi4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC9ZM1VtYUppbDVzbG9zcWpBQHVucmVhbC9ULw0KICAyKSBJdCBpcyBsaWtlbHkgdGhhdCB0aGUg
YmVoYXZpb3Igd2UgYXJlIGRpc2N1c3NpbmcgaXMgbm90IHN0cmljdGx5IGRlZmluZWQsIHNvIGl0
DQogICAgd291bGQgYmUgYmV0dGVyIHRvIGNob29zZSB0aGUgc2FmZXIgd2F5IHNpbmNlIHRoZXJl
IGlzIG5vIHBlbmFsdHkgZXhjZXB0DQogICAgZm9yIHBlcmZvcm1hbmNlLg0KDQo+IA0KPiBJIGFt
IHVuY2VydGFpbiBhYm91dCB0aGUgY2lyY3Vtc3RhbmNlcyB1bmRlciB3aGljaCBPRFAgbWlnaHQg
b2NjdXIuDQo+IERvZXMgaXQgcG9zc2libHkgaW5jbHVkZSBzY2VuYXJpb3MgPw0KPiAxKSB3aGVy
ZSBhIHBhZ2UgaGFzIG5vdCB5ZXQgaGFkIGEgbWFwcGluZw0KPiAyKSB3aGVyZSBhIHBhZ2UsIG9u
Y2UgbWFwcGVkLCBpcyBzdWJzZXF1ZW50bHkgc3dhcHBlZCBvdXQNCj4gDQo+IFdoZW4gYSBwbWVt
IHBhZ2UgdGhhdA0KPiAtIGZvciAxKSwgaXQncyBtZWFuaW5nbGVzcyB0byBkbyB0aGUgZmx1c2gN
Cj4gLSBmb3IgMiksIGEgcG1lbSBwYWdlIHdpbGwgYmUgc3dhcGVkLW91dCB0byBhIHN3YXAtcGFy
dGl0aW9uIHdpdGhvdXQgZmx1c2hpbmc/DQoNCkFzc3VtaW5nIHRoZSBwbWVtIGlzIGluIGZzLWRh
eCBtb2RlLCBJIHRoaW5rIHRoZSBhbnN3ZXIgaXMgbm8uDQpXZSBkbyBub3QgdXNlIHBhZ2UgY2Fj
aGUsIHNvIHBhZ2Ugc3dhcCB3aWxsIG5vdCBvY2N1ci4NCg0KUmVnYXJkcywNCkRhaXN1a2UNCg0K
PiANCj4gVGhhbmtzDQo+IFpoaWppYW4NCj4gDQo+IE9uIDE4LzAzLzIwMjUgMTc6NDksIERhaXN1
a2UgTWF0c3VkYSB3cm90ZToNCj4gPiBGb3IgcGVyc2lzdGVudCBtZW1vcmllcywgYWRkIHJ4ZV9v
ZHBfZmx1c2hfcG1lbV9pb3ZhKCkgc28gdGhhdCBPRFAgc3BlY2lmaWMNCj4gPiBzdGVwcyBhcmUg
ZXhlY3V0ZWQuIE90aGVyd2lzZSwgbm8gYWRkaXRpb25hbCBjb25zaWRlcmF0aW9uIGlzIHJlcXVp
cmVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGFpc3VrZSBNYXRzdWRhIDxtYXRzdWRhLWRh
aXN1a2VAZnVqaXRzdS5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZS5jICAgICAgfCAgMSArDQo+ID4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4
ZV9sb2MuaCAgfCAgNyArKysrDQo+ID4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9t
ci5jICAgfCAzNiArKysrKysrKysrLS0tLS0tDQo+ID4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9vZHAuYyAgfCA2MiArKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gICBk
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMgfCAgNCAtLQ0KPiA+ICAgaW5jbHVk
ZS9yZG1hL2liX3ZlcmJzLmggICAgICAgICAgICAgIHwgIDEgKw0KPiA+ICAgNiBmaWxlcyBjaGFu
Z2VkLCA5MSBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkNCj4gPg0K

