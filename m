Return-Path: <linux-rdma+bounces-16237-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFmZL5J4fGmWNAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16237-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 10:23:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8816B8E05
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 10:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3C31300292F
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 09:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6499350D7D;
	Fri, 30 Jan 2026 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="D5jU8SIl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011021.outbound.protection.outlook.com [52.101.125.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2DA32B9A9
	for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769765005; cv=fail; b=YHScBOjwfVkrwYO170hsNR74UZfL8NlxDTw+QlFzNYhLSIwxVAiyjydPT2YGYJpEnEdtdLtSm8lAE4hxnriWqI+OzPQnzoRsJbrTEWbRbUo4cAGpOVzjzc3Ct+GWq9TziFZ+IWLBhUo/4fhv6TuxM7RLpdKueTItbvwttFGpURI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769765005; c=relaxed/simple;
	bh=O4dK4JWdsG2yCqdOyZaBPS6VxiCTkc1ShoYy9TaF2FQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nSufg1Ua3FzPtxIq5xC/mcZiYjG7+FbNvtKNJCf2cSFWmYJiqzZsel+GueM0SNoVcpS6M53pambrDG7hO54w3jfJ2shpCB27qIYIMzEG+4tKk17bmefHUuSvj7kWLqWvtd51rYLaKsw0dTyc0jXq1j2h7fu1ks2nbrj5h5lwvN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=D5jU8SIl; arc=fail smtp.client-ip=52.101.125.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfQsDSdn+A52DotUCgozm8VuCEwgwUnD2h/sfFvZbc1VqEym5ytUy0Ay8FHGNB10UEz7dcD6PlbXuWMTYy1ue7nnmkr4mrWq1drV1X44/HLOfZuhc5tmcltQaJQ4k0mdevE/FS2Z3HHr6pUBLAfuSWyic9iMxcUKRSC70+4c6yC+iNwvM3zBoLK/MWm6frMc1M38md6UaZxSWjsfd3nYGjJ7dqDxdqwn++5Grgm1zDzXg4CXsyux9qiLLrLEni37JSEWZ6/qpcCwhqLPFqlUZQtR5xKIaBwIo8Z6HwuFeZbmf289JKGZNcswIpzX7IE3LdCH78oaVHGejwxLoeVjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4dK4JWdsG2yCqdOyZaBPS6VxiCTkc1ShoYy9TaF2FQ=;
 b=cz346YL9vZjnSIUA+OjlPC4skispOaJ9DjJLz5i+Sdgs8RB686BMkm6yprTj5dRfRsixpyL/JditVivowIB6bHHOT8DA5zoHKctotOwHL4d9Z5LkYxM0nDbl6qrZGXAB/0KqFOFGVu4k+7wW1sCfalJcddcy+pZ5KdOOF1PojvCcPROBAN9REzsoFRTJrEACGLe1T+2XMCem4hBK/LW+/+wB+ohL02uo9FeC/MKrc/HBn5/bEhhnHSLn4oNWxYm6N2y82XufbiABCjMGJItmRsGrenptZnE+CqgCotxImnen59CGcmUX6yH40f9MeB4hroOUPFePHlmoj/wljw007g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4dK4JWdsG2yCqdOyZaBPS6VxiCTkc1ShoYy9TaF2FQ=;
 b=D5jU8SIlBSGA7UK3x80mIw5H3DdHTjFkyVWF7NZFOeyJUxPGWVmubRp1c96AspfrnS76dwd5zXfw5wytgRxAeRU4N1VAPsVxN431udwc+APHUKP5p6t9YkrG0Hmkw5gIXTpe0h1ch10wSgePPpgup9A9gDv0sGu1Em3zjysIuZmZAppHSXrz4T/CAKQ8hlszIU3wFyXrfx0/689IzBXrGq54l4iWBpJHIcv4mSs69fn9JfC1u/4n/wBDNwILADQ6Vwg4zUu1GPsISLxZnUx49pHcut0F4zHR0Ap6/WxHi5H0NNYD4g7XjcMaXrbZO4AbALykUHWkIy4OH/Rj0Znaag==
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 (2603:1096:405:32e::20) by TY4PR01MB14465.jpnprd01.prod.outlook.com
 (2603:1096:405:238::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 09:23:21 +0000
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f]) by TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f%4]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 09:23:20 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: YunJe Shin <yjshin0438@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Joonkyoo Jeong
	<joonkyoj@yonsei.ac.kr>, "ioerts@kookmin.ac.kr" <ioerts@kookmin.ac.kr>
Subject: Re: [PATCH] RDMA/uverbs: Validate wqe_size in post_send
Thread-Topic: [PATCH] RDMA/uverbs: Validate wqe_size in post_send
Thread-Index: AQHckchCHRHhlacY+0OFEaUBGP7skLVqcJOA
Date: Fri, 30 Jan 2026 09:23:20 +0000
Message-ID: <151277c7-c155-4b3a-94a5-fe8c9dd70f25@fujitsu.com>
References:
 <CAMX6_QHfPsyybbO_79u4RpbGY9H28xhpaVPHUD-wu2U+V5W=7w@mail.gmail.com>
 <20260130090945.2426003-1-ioerts@kookmin.ac.kr>
In-Reply-To: <20260130090945.2426003-1-ioerts@kookmin.ac.kr>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB16837:EE_|TY4PR01MB14465:EE_
x-ms-office365-filtering-correlation-id: 7d50aeb4-7f47-4263-c98e-08de5fe135a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|1580799027|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b21GZlJtSDV0WE9aUVZpWEEydXMwd3R5VGN0MS9CL0Zxc3ZUQ2I5NHhOLy93?=
 =?utf-8?B?bmd4YkMzK2k1MlJHSE9RVkF6ME9WL1R6UEVYaWhhcDdLU09pSVVtUnhZWVB2?=
 =?utf-8?B?V0ZML1NlRllWaTBkQmhqNWNaTmVXY0tjV0Z5enJVbkMzRXAxa2JXaHlsSmxQ?=
 =?utf-8?B?b0pWeG9yMXlCczk3ZWl4akEwd1YzVm1PektKWUxQeDdSNGN5K1dZOEQwUG1J?=
 =?utf-8?B?cTdlZ2ZVN1NQcGI5ckpLMmgrNnNEWkZVSW8xNjdHVng3ZFJaUWdPSkNXVXlE?=
 =?utf-8?B?S1E0SFZsU0prQjBKZWxNbDlCblBVVTFhdy9KZXZ4MjFvUmFWSkkrTURGV2FS?=
 =?utf-8?B?bHVyTEloZTkyNDNNazhCWGZWQzJRd0dCc2creGZUNkh2d2hKLzFoNDJmN2Nj?=
 =?utf-8?B?bFk5bjRNL1pkOWVLeGZPU25XdE4rMjBsS0Y5ZlVyYWdHM1RnYTgwRmhGYjRu?=
 =?utf-8?B?NHJ6SXVwNm0rY1kxRnV0WFFSZ0lVeDFCOXQyM3BSOEI2TFpYOFRTd3o1SGdW?=
 =?utf-8?B?SEhhWkFaWC9sbDA2NDZtRzBXWTdzOUxodTFNSFR1N3Q4WUVVRDBkdWw2WmtZ?=
 =?utf-8?B?U0pXazR5L0hjc25NeU1JcDhKZFF3YTRqbjZ3bTJvYWFUZUZvVkY2c211RnVi?=
 =?utf-8?B?OXRsV1hJbGpJSE13d2pWbnVMV1JrbCsrQ3VtNFFVbCsvYjJ5R1c1a1dRK3ln?=
 =?utf-8?B?YzJ3QktKVFlQUmQyeGJBZmtxMHd5N2g5UnR6WnRLWFRpRlFrWStpQlc3L2xj?=
 =?utf-8?B?MjNIV09ucnB6a3VVSFVqRHFTaXZMTGlzVkNrdmtUQUdwaTRJWGh3dXF4eEFo?=
 =?utf-8?B?eW1zeDRFd3RTc1VqTzlTay9mRmlERUZ2S2tZVE5yQ05DaVp2dXFjMEUzNU5x?=
 =?utf-8?B?Q3dheTY0UmkzM0E4dThSR1hWWkx4cHluUXIzNkM2UFN2ZXhJL2ZhV2VsZUQz?=
 =?utf-8?B?MDJHbEhuRHgvSzVCemY1akhsalpZMkxtcDhRdlEySHV0TXFkTWlSWTBSSFF2?=
 =?utf-8?B?cDJyTEc4RTgwc1h2dTV0aURYOUc4NUxUVUJTeHdaaUpqQWYyS2N4ZGYvL2Vp?=
 =?utf-8?B?eStRU3BQaTdjR0ZQeFBJWUpjL3pKSVJzQVVjVXRBTk1HSkMzUzNqZEZQaXUr?=
 =?utf-8?B?WXhpWFkxZVhQYVA5ZWltTVlqTURIZ2NPNi9yaVEzK0RMOUpyWFFNWDQ3MHlS?=
 =?utf-8?B?WDFnUUdxWllCcmpSZHZORVBmZzJpeDBLWVdCKzNlVUFBSERTbEZqejVBVUQv?=
 =?utf-8?B?WHBteDkzTjBqRzdIb0F2YVZGMHVMelpwUnFNb2xDTzlteERiZGE0cGU2UW81?=
 =?utf-8?B?UWZUWWFHM3BPcnorWEw3ZTg3NTF3ZGRVRjFEdlYrZlVlQTRHQkZPakpuNnd3?=
 =?utf-8?B?dlhXOUplOTIzcXJpSjJmQUhKTzR0a2hRdnB5OXJGRzM2MzEvZkxHN3dKY1di?=
 =?utf-8?B?WEE1SW5EWThZQVVkMXhXZXhsNWkyRDRYMmlXSkhLZ1d5QzE0aGJ6a21pQngx?=
 =?utf-8?B?aEc0YnRDZDVqY3NicCtaRjhCT2RwNlNYTUZCa0pMcnM1TkRwK09qUmIrenVo?=
 =?utf-8?B?SitCdTlUaUVzNXZSNW1ha2h4ei9lOHFjc05zNit0YkZIMFY5QmF6eGRQUTVn?=
 =?utf-8?B?dzB4R1FYcEZNY1VRSG0yb3FWcWVoeXhXZVloazNNQmZPK0NDeUNNdXdMdERp?=
 =?utf-8?B?VDNHN3ZCcGRwREVCQkV0dG1aU1YzR0x3VWtkNytrZ2dFNHd2eUZybVpVYWd0?=
 =?utf-8?B?b3AwZGJqOHQxQVdWTFdnb0pNTGs0UXZtRG1LUEgwM3hqSGx3VDBjVlNrc2Y4?=
 =?utf-8?B?LzBzTDN3bEJyMFZFNktLblNhV0ZPZUF1Sm91Q1pRa0dXUWllMytTeVBhTzA4?=
 =?utf-8?B?Z2ZEV09BbVg1NXUrUkswUlJieDl2VHFwcjVNUSswMHByMENrSzVwUTlxOVJT?=
 =?utf-8?B?ejFCajhaRHQvQU04UHByeU5nb2Z6cytaK0svTVp4UXI1NCtpa21KOGxQYlVK?=
 =?utf-8?B?MmZ5aVFJT3JFZXVPVDAwYzA0cWsxQjhHcW9oalZkVWlteG1yTXl1RlpGb3VZ?=
 =?utf-8?B?cGk0MncrQ3FUVkl1ZVdkTXRZa0FiUVdjTUVsNDg2VEY5Q3RpWXRlK1VzV0NI?=
 =?utf-8?B?ZGRxZWZpOEVLRnVOU2ZTS1pERUliZ1pzNklnWlBiRU1ZbmUzeHllTWhCRDZn?=
 =?utf-8?B?Qm5JVlFIYnRQOWNjWDlVVmtNdWQrT1ExcG5MOGRyeDlidDFiMWtqR3RBbHpq?=
 =?utf-8?B?cFBIbWRaTTBQMmVsT3RlTmMvaXBnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB16837.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(1580799027)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTVSVExmYUlubGJiaVBOZ0RRNE94RUZGb0lBTTFRV1J4NXFkNGwwSlZmWjlO?=
 =?utf-8?B?WGR1d2FqOTRMTDZPL0N5M09WWlZCd2hRUFEzWTRNT3grNFAyN1JpakNrazQz?=
 =?utf-8?B?UXZhTU5NMVlEZ0pnTEVQd0tiNmxWQjFSZ0gvVmY3UUN4WWIvWkZUNHk5aHR0?=
 =?utf-8?B?dmRtSDZQSC9zM3p4eGRzMzZIUHZpZnlESHRNNmVOR3ZVT3RpeTF4MWhCaWtQ?=
 =?utf-8?B?c1JCZTgyakpNZ2xYMjBCRnlZZUhVdTYvNEhkVlRHM2pkd3FRUmYzWFBwTXZY?=
 =?utf-8?B?QlNtRHhyNVlRZys4RUxWRXVWb2g4TlFxOTZWb28rTmhVK1lnRTBYQWpzNVc3?=
 =?utf-8?B?RFF6QTBwR0lhKytaWDVSZ0xzSzgrQXRJc0hNUThieGJhUS81QWc1QkR6UWx3?=
 =?utf-8?B?Y1g5dHdmLzJLUDlEN1NnT3FheUtmNHV5NkFmYzNzRCs4V3FxRmUxcGROZVRD?=
 =?utf-8?B?dHZncWwxZ0c3SWNDcHJVdmN6VjgvU3hIUlN3cGpwd2VpT3BweTF1NWgvUVJL?=
 =?utf-8?B?SXk3SEFMNWlEQkRoMzhCTCs0SXFkVEY2SDNabHVDWXh3c24xV1cwVWwrdDBz?=
 =?utf-8?B?U1lOL1NOUG00RWJpc2d5SGMxTksvMlY4MkZZb0xBQ0pLS1YveFBTNERWWkRI?=
 =?utf-8?B?dHJsMmNwZXp3cXdTenltQlM4TkpQZlVzL0tBcTJhZHArbXNQbmNjUzMwN3Ux?=
 =?utf-8?B?SEdQcWpsZXJBSFZjYnlqZHlhbDQyQ1pSblNEeFhMNlRFdEI2UnZzRG9jZ0cw?=
 =?utf-8?B?VWhCZW11N01BTnlhVUVXZHN6bUc4SFU2d2NYck1hU3Q2aUdIQlY0MHZObTdu?=
 =?utf-8?B?S1l3blUwMlAyNHF6WUd1RlBrZi9kOWsxdGs1WWMyYm5wY0hieUxMTEIycGZm?=
 =?utf-8?B?V2JLalQwQW4zdEg3U1NybHNkUUhnVUhOODZ6aVdjNzBvVXY5eW9seng4Sy9L?=
 =?utf-8?B?N0l0cURDQWhIOXYzSXFDY1R2NTdqMHQvdE5ZdjBrSDBpUW00U2d5clZiV1Fi?=
 =?utf-8?B?b1NkUUY4aFp5L3hyRWljS1hLY3oza2l5WmpVYnJ5b2VNTjhWemw4MUJmbURz?=
 =?utf-8?B?eng1K2FxRHVDR2xzVHAxbWU5QmtKQ2U1N0pTd2tMZmlHcFRKUXFid2dLZ1RY?=
 =?utf-8?B?UGtWTzlWcDNyQXE4QXFMcjRhVklRcmtXYWIxMGVwWThZbWxVSHU4Y0lSUzNC?=
 =?utf-8?B?R2ZXemJJbGMvVmQxQmVJZWFBTXl4Z3RJN3U2MHBmbUdibjRKTXVrSm8rZ042?=
 =?utf-8?B?QXpGelkxdjhoU3RCNlY1QlowRHVmZWdmL0xjU1JoSnZGMTR4MGlCVitReEJU?=
 =?utf-8?B?ckNWeXphYmVLUTR0bGczWWtBY1pBYVpUNFZOa1hobXBRc3RBbWRTUmJRbWdz?=
 =?utf-8?B?d2NkTzI3UEl4REdIV005cm1RZC84emlqMjJMYldvY3VyKzUxWE0rZm1BK09s?=
 =?utf-8?B?WHZuR0ZvdjZ0LzNQREN2VXZlMmwzVkt3dGNsVXFQYXNZdDZGTXpHVkQzdmR5?=
 =?utf-8?B?QTYxVFNxczBwczI2NkJEd1VmMEMvNUhvOWo4UnBlZldtQXJib2FBdnUyaDR2?=
 =?utf-8?B?ejBBd2wvazJ5TzhxNE5SbGlDU2cyalYwcThNcFdlQ3duMHVpNFpxeW0xU1h3?=
 =?utf-8?B?Wk9NT2dJdUJUTGZiTE5WU0x5Z28rdXEvOXFMampSMWw2RWFWdnhnRTBXayty?=
 =?utf-8?B?WmpDL3pZajJZSnhSajYyUHdlV3B0bjhldXVmL3NmNThlVW5NZTlobU9vZytQ?=
 =?utf-8?B?R0ZuZ21icTVINHVkaCtrRmUxa1VrUGdVdWIvYlZGZ21vSXJTTnBIcXpVNUJo?=
 =?utf-8?B?MVdhZDE2UisvMzBibzd4a2kzTnZKaXdPQjF4a2c3Nk9DSkRCS0R6RmFEdXdW?=
 =?utf-8?B?QXc0cDM1RjNoN0RZTmZtcHo4Lzl4M0ZCcXJHeWJLVklkajZOcCtESlVLamtR?=
 =?utf-8?B?cEY1Wm1QRUNFWHVFUEtYOTdDVS9EM2NobHBCcGM4WGJCNFFMWjBKVlp1NUV2?=
 =?utf-8?B?MUhSRkNyYU55UEhMSncwbnliVGVnSkNQNnB3YlY2Vmk2bjF1YWlGdWNZRmxI?=
 =?utf-8?B?SGxkZE5EalBqTjBmMnlVM0JGZnhHcEFhWE90WnRBMjVLR0p3U2JFaUNOeDRN?=
 =?utf-8?B?RFRUK2loZzFBV05FOU5saWhzSy9UL1d0V0d4czRCTHkrRXI0L0hvTnBHRU9x?=
 =?utf-8?B?SkRtcFJPOWQ4S2lrVXVOR3VXSExnV3VTU055bDRoVkx0bUFBd2dHNUhrKy9h?=
 =?utf-8?B?bGtpNDRDbEpZeWY0N2R1cmYyb1lxeEVyUklXR2pXdGlvQWNMMUZCdThHM0Rz?=
 =?utf-8?B?UDhsY2QxL3ptQm5IUk4zU285Z2ExTVZUTkVReDllOHVNekdNZE1uRUZBNHpm?=
 =?utf-8?Q?SlI4Qs4dQNJy+oH0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B68AC33E40B20940813BA2003E0F731B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB16837.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d50aeb4-7f47-4263-c98e-08de5fe135a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 09:23:20.4908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ky7dIYrIrD7iR7hSSnKiaaTUuNQrtH/e0EaccsXiAv9xRnxBxoK30FdObcYuQCUe3X99xJlV7AZNw9KeJaUjsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14465
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16237-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhijian@fujitsu.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kookmin.ac.kr:email]
X-Rspamd-Queue-Id: B8816B8E05
X-Rspamd-Action: no action

DQpOaWNlIHdvcmsgb24gZmluZGluZyB0aGlzLiBJdCBsb29rcyBsaWtlIGEgc2ltaWxhciBwYXRj
aCBqdXN0IGxhbmRlZCBpbiB0aGUgZm9yLW5leHQgdHJlZSBhIGZldyBkYXlzIGFnby4NCg0KaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcmRtYS9yZG1hLmdp
dC9jb21taXQvP2lkPTE5NTZmMGE3NGNjZjVkYzljM2VmNzE3ZjI5ODVjM2VkMzQwMGFhYjANCg0K
VGhhbmtzDQpaaGlqaWFuDQoNCg0KT24gMzAvMDEvMjAyNiAxNzowOSwgWXVuSmUgU2hpbiB3cm90
ZToNCj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSB5anNoaW4wNDM4QGdtYWlsLmNv
bS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJv
dXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBpYl91dmVyYnNfcG9zdF9zZW5kKCkgYWxs
b2NhdGVzIGFuZCBjb3BpZXMgYSB1c2VyLXByb3ZpZGVkIHdxZV9zaXplIGJ1dA0KPiBuZXZlciB2
YWxpZGF0ZXMgdGhhdCB0aGUgc2l6ZSBpcyBsYXJnZSBlbm91Z2ggZm9yIHN0cnVjdCBpYl91dmVy
YnNfc2VuZF93ci4NCj4gQSB0b28tc21hbGwgd3FlX3NpemUgbGV0cyB0aGUga2VybmVsIHJlYWQg
cGFzdCB0aGUgYWxsb2NhdGlvbiB3aGVuIGFjY2Vzc2luZw0KPiB1c2VyX3dyIGZpZWxkcywgd2hp
Y2ggaXMgb2JzZXJ2YWJsZSB3aXRoIEtBU0FOLg0KPiANCj4gRXhhbXBsZSBLQVNBTiBzcGxhdDoN
Cj4gQlVHOiBLQVNBTjogc2xhYi1vdXQtb2YtYm91bmRzIGluIGliX3V2ZXJic19wb3N0X3NlbmQr
MHgxMDZiLzB4MTYwMA0KPiBSZWFkIG9mIHNpemUgNCBhdCBhZGRyIGZmZmY4ODgwMDdkZjQ3NDgg
YnkgdGFzayByZXByb19oeWJyaWQNCj4gDQo+IEFkZCBhIG1pbmltdW0gc2l6ZSBjaGVjayB0byBy
ZWplY3QgdW5kZXJzaXplZCBXUUVzLg0KPiANCj4gRml4ZXM6IDY3Y2RiNDBjYTQ0NCAoIltJQl0g
dXZlcmJzOiBJbXBsZW1lbnQgbW9yZSBjb21tYW5kcyIpDQo+IFJlcG9ydGVkLWJ5OiBZdW5KZSBT
aGluIDxpb2VydHNAa29va21pbi5hYy5rcj4NCj4gU2lnbmVkLW9mZi1ieTogWXVuSmUgU2hpbiA8
aW9lcnRzQGtvb2ttaW4uYWMua3I+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9jb3Jl
L3V2ZXJic19jbWQuYyB8IDMgKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3V2ZXJic19jbWQu
YyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3V2ZXJic19jbWQuYw0KPiBpbmRleCBjZTE2NDA0
Y2RmYjguLmE4MGI5NTk0ODJlOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2Nv
cmUvdXZlcmJzX2NtZC5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3V2ZXJic19j
bWQuYw0KPiBAQCAtMjA0OSw2ICsyMDQ5LDkgQEAgc3RhdGljIGludCBpYl91dmVyYnNfcG9zdF9z
ZW5kKHN0cnVjdCB1dmVyYnNfYXR0cl9idW5kbGUgKmF0dHJzKQ0KPiAgICAgICAgICBpZiAocmV0
KQ0KPiAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IA0KPiArICAgICAgIGlmIChjbWQu
d3FlX3NpemUgPCBzaXplb2Yoc3RydWN0IGliX3V2ZXJic19zZW5kX3dyKSkNCj4gKyAgICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArDQo+ICAgICAgICAgIHVzZXJfd3IgPSBrbWFsbG9j
KGNtZC53cWVfc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ICAgICAgICAgIGlmICghdXNlcl93cikNCj4g
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gLS0NCj4gMi40My4wDQo+IA0KPiAN
Cg==

