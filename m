Return-Path: <linux-rdma+bounces-3624-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F383D92567F
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2024 11:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD921F2855D
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2024 09:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A8313C8EE;
	Wed,  3 Jul 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WzxNatvD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2106.outbound.protection.outlook.com [40.107.103.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87E13C677;
	Wed,  3 Jul 2024 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998423; cv=fail; b=Ob9ySUTCO0nvlbEFleOK2gd2k3QP4/+vN8TveC5ri4YfBWfRW1Whw8mKJ5s3IbbK+eZTq1t0VxzgTb7wdrllhDYRSPc1fTlVWlUgavEW21mlTa/pqtCNHNTd+w/NZArplf/eOGxN6hgIM35/xG7LDnAwoyvTStdvRnFWy4cXNwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998423; c=relaxed/simple;
	bh=dBb+tvNs/o6J4u+PqsKU9tpYZ7pFr16cToHz5DcK+wE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OugEYAyx8u1cz+O6aY7K6Ypk59Qe/IwgX7JiMmkZnwDSYDHxGsU60Q/y8ib0YJ0EXNx/xWsFM6wDBTwe0xrOW8n2S+VvlhfiZhwr/xFX59dL4CcSnsCeV7c3RxVYtO0IHmncRthKJJAvZNLOBc0QlP6pfxpoVliR4bvAkR0G/5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=WzxNatvD; arc=fail smtp.client-ip=40.107.103.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrRdo+YmKJIOACP5TlZ64fTKq2q3aWw/ACyznxbr2P6qneaCQDdobL3ckrnOkDliwnGrRpD7xB6z1nFxRvNGdFCbnR/P2uqAn0csrCItdT26Jz8IHIdyeT8U9hvRdynepa0sm7AuO7deZwjMuoW5vfdkqqFKs1ViZxpigR9wgLIH9uHopD2IupcGfQwe/ZcRCnMPgB1zNR1d2oxoookYJpaNiKkZHHzAanmr3VpqYSB9WKbmxDHKK1kFx3VwRznpZb80QtuJirKq+4w+lcTJihuqbjef3AH5WLYbzljURA/V3ila7J6Z4P3U538Ikcw/VI7DFTkolweWlwj8TGxLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBb+tvNs/o6J4u+PqsKU9tpYZ7pFr16cToHz5DcK+wE=;
 b=WA3g4K6kEKIB4IKBJSEYxtDOKhoX9JS0+xvAHc42ilKueGf/0QuvtuSCdPS3/nZqiNBjUl4Ayr4KgKprpZjXznOvzilMX8UNKDU4VMvWEW9zj+hezPfZQepHZ2pwAbYAFmpXp2YPA3BiDhFOPbMZp6D/1RF3ZImjKULeCthY0U4grtNcn8P0esE3eyML/i9gRt6swrPDXZ0xBvtFVaLG2GpgNZq1qrzwk+spWJMabHy9Qa0aMLe/OvZUsuNKbj/L7HmVit44wBUsVOMJBe8342A+013h8hExwE9a6KonFcCwB6+wND2PJH6sF7Lbl1/7OL5/y8OjferugXChkfWY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBb+tvNs/o6J4u+PqsKU9tpYZ7pFr16cToHz5DcK+wE=;
 b=WzxNatvD5+rUXCO1fa+ZqtZ6+b6CMh+YvK/o12ix7VA79qvUwqjv/IedttnlFNT9jVwWzQ6fLCLxoXRwvZ6Yk2+cuORRp6trVaL5jNEtEuHK5eNh8FtsGEyU4LLwMRszqNKAjEi7t0UAWJI+pVi67UV5ksC3294qaYqIKIsgkjk=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by DB9PR83MB0520.EURPRD83.prod.outlook.com (2603:10a6:10:303::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.6; Wed, 3 Jul
 2024 09:20:16 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7762.005; Wed, 3 Jul 2024
 09:20:16 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] net: mana: introduce helper to get a
 master netdev
Thread-Topic: [PATCH net-next v2 1/2] net: mana: introduce helper to get a
 master netdev
Thread-Index: AQHazSo3MF7q6sO+qECNANn4g/L4RA==
Date: Wed, 3 Jul 2024 09:20:16 +0000
Message-ID:
 <PAXPR83MB055992B967622803555AA64EB4DD2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1719838736-20338-1-git-send-email-kotaranov@linux.microsoft.com>
 <1719838736-20338-2-git-send-email-kotaranov@linux.microsoft.com>
 <5b418472-4370-4626-9373-064e7aaf9ae5@linux.dev>
In-Reply-To: <5b418472-4370-4626-9373-064e7aaf9ae5@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=14b7518e-3808-4c9e-a626-cfb48f73aefa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-03T09:19:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|DB9PR83MB0520:EE_
x-ms-office365-filtering-correlation-id: d06cc856-de13-460a-60ed-08dc9b415a24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVRvcFBLWTIwWEFjWDc2TWUwK0NLS0ZWMmV4UEpGam1va3JzYlFVelh3ei90?=
 =?utf-8?B?bGs2TWNKYzhCTENNR1k1OEVBUWJxZ0FTZ0tlMDdlbVA3bS9weE10L1d3dUNX?=
 =?utf-8?B?ak5FTFlQanZOaElPYytqYlFhWnFjQ3ZJY1BJL2cyRmN5bU9mRmYyZFZ5bHJw?=
 =?utf-8?B?ZXE2RzV3MDBiOElHQlVxZzZKZ1ZCd2E4WE5KclFFRmQxTm0vYW1GR0wza1Ew?=
 =?utf-8?B?aHE4dGRTZGNCaG1oSmFTRHByUk1hY2JkRDRRVjdkNU9QZzZRSU9GUEtLOFBW?=
 =?utf-8?B?YTVUZk1HUVdFQTkxL0grNjJyNjRwYWQrWDIzQ3B0UDc3YTlDVDl4eG02Rnl6?=
 =?utf-8?B?SzVTaEx4OVhQeFkwQlQ0dW9WN05EUkJkdFdZNFVqM3VsYSsrSzdiUnUxRk5P?=
 =?utf-8?B?WXNtdHI5YXRtcnE2QUNlWGFPY24rbzBWelZpQ1ZRQ0JNWHNIbmJoZjVkR3Iz?=
 =?utf-8?B?ZDFzeXpMdjJWRklxdTE5T3FWRng3TzZtcTBpRUxiTzlGcXY4enQrRGJhYndI?=
 =?utf-8?B?OVZXL0YxS3JVcWphWXBuYkxTaTZpSEFvOVpVTXlJWnQ4UHZGdm00dTQwOG1Q?=
 =?utf-8?B?QnFPOHp0dEw2dXh2VzRyaTRiT1ZDRy9yd2FZSXRxV3JLM1BEQ3kvNjY1c3JQ?=
 =?utf-8?B?dTNZaE9YTllid204Y2VVNVZyMS9SalBEZ3FLcWF0K0FOQVdCK3JFNlRtWEJX?=
 =?utf-8?B?bTJRdiswc25xV3lkQUtYZVZYeUc3YUVUeGl0MG1OaFl5VXlvMjEyOWhmMUlq?=
 =?utf-8?B?V1FSMWFDYWVRZkMyQ3RyK3VKdEJPNmRHZTlKNlZEN0Y1UTNSN1VySkZUZ2JC?=
 =?utf-8?B?UWtZZ0NsOCtGOTl1ZEhlUmlyMGtIcTFzOWozWXV3WjB6K2RWU1NsT29RU0VU?=
 =?utf-8?B?V2l5THRUL1JNdmQ0U1BrQkRUVU0zanJYQldBLzAraWVURlRqN1hSaXNSZnQ3?=
 =?utf-8?B?UXZqMFljRDM3VDFlOTE3WkcreWVzdTBpcVJMd0JKeEFxTFltT1VhR29UU29v?=
 =?utf-8?B?M0dnVk54K2NaNUg0STYydWhFeWV3RW1tUGFKcVhoekwwUTg5a2lObUZMU1lF?=
 =?utf-8?B?UktnSlM0eVFPOEV1Nm9sL2svL2FrMnhZT09aUG50NXFFb2NZMFpham5nS3g3?=
 =?utf-8?B?Q1FiWG8yb244NnZTa012bkhhSkttc015V3lNenVtTjl4Z25zbHlmZWhZTTB0?=
 =?utf-8?B?d2t5VStRL2d5dzRKcnowb1pQMG51RzJzbG1wTHpOVmU4aHc5Ty96bVRDVlZH?=
 =?utf-8?B?L3llZkUxUDRHamhBZEwvNFNsZ24xWW93M09YbWY5OUdmbHhsdXJhbCtVTlND?=
 =?utf-8?B?djRxVmlxVnc0ODJram00Z2VwV0IyYkd2M1hibUFjSVBOellMdm9wR2MzK2lP?=
 =?utf-8?B?TVQ4bXE4andVZFI5cVk3RjhvOGx2OHRnZDV1Z3g3WEpYaW9GYzBDaElOVGlU?=
 =?utf-8?B?Y1RuOVJLZ0VrV3hPUWlLM29FNHRGRElTVlVQWG1XcWNDcjNFYzNPKy95amxE?=
 =?utf-8?B?UmgvVmlseFJERXVjZzRyWSsxUW0ycE1yVGk1a3JHT0tBSFhYaERwOVVqRVcv?=
 =?utf-8?B?WXF3aGFkSVM2THlrTWcydllzT2I1S1dqVW03Slg1UDZGa1BqSXQ1RU9UVEFt?=
 =?utf-8?B?SDU4OVZXMGtMNTJGUUJ0cm5mZ0RkS2JPc2JnSExxemoyOCtCTjJDU3J6cjN0?=
 =?utf-8?B?ak5lWXJmTmNKQXRWUi85YWJQUGdQWXZmV1JTZjVhZmdiRGs5K3ZVeU5xdGpz?=
 =?utf-8?B?TEYvTFNSblN1Sm4zbTl6UW5MRDFmaUhrNVFBWU4rVTdVb2Y2Wm9Rd2lZZldZ?=
 =?utf-8?B?NlgrYlVnWmZXVnJUQTBkRGJKRkFUaGxRVGFFQm11YS83LzkzNlA5SzczSGE1?=
 =?utf-8?B?cDJGMFRiRy9RdUV3bnVueDJiSzNKSVExN0ppVTd0YWZHOW9uMjVxRFpwQzlp?=
 =?utf-8?Q?oWvuCbHk4Zc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGJvcGgwdk8rc2hlaXBTMlZVb2dlclJidlpoWmpra3VaR00yRmpoeFhXWlBz?=
 =?utf-8?B?WUUyRUlrWGdLZUVINjBPZ091VW9kczFHOGs5b3VvZ082aHBGenI1SVNyTVhU?=
 =?utf-8?B?elBTQkJhRlllNXNqeFF4Yk1ROWpaVzdKRnNpTkw2cXJ1Yi8rRGQyV3VpVVVs?=
 =?utf-8?B?Z1RESXZoZnc1M3NWSDBNbHVCaGZDNGdkeEhVTEVhRVVQSVRhVEdrUlJzSHlE?=
 =?utf-8?B?RGJYS3oyN3dKVEJhcXdCdm9UL2ZHc2hoRUVwNWxveC9UNiswanhmMENqODBX?=
 =?utf-8?B?dTlESnNBQjZXOUR5dGI1bEN3aUZpcFVUemt0dDEwMlR3d3FKMi9iWWpyUzVD?=
 =?utf-8?B?Zld6aEw4KzUwSUZWaTNGL05NT1Q5bDUwczBKZEdqT2R6Vi9jOFJsakNpY0hl?=
 =?utf-8?B?V0lxcE5XOElpaVhSdEhrMG54QUpnNldWNW1zYVQ1Q0VhVysvOG5VSmttV2Y0?=
 =?utf-8?B?eGppYmtDOG4vV2tKWldXRnRUTWluZlg3b09pL3FyWlBiUnY1VmZHbzNTbndP?=
 =?utf-8?B?R1hBMGx2QTJsWUVtNWlYM2xJbVBMbWVsTWNUc2Q4VVFqOGVrRnFkWS9wNEI5?=
 =?utf-8?B?d0RsUmlGVjY2RDg2Y3hDZFJKemhxcXZCZ01mSXFDUTZNcGNYQnJIS3d1Rmwr?=
 =?utf-8?B?cjEyQXQrWWo5VWsxSFVtOEEyOExuR0MycjB0Ty94VzFER2NHempHZ0NIOGx5?=
 =?utf-8?B?SFlaZVZ1Qk9rcW9DZGVCbnFSWWUreGtzeitPUG82UnpYL1gwOTdmVG5jMWZy?=
 =?utf-8?B?VXhpa3BuQWFxdzhKZ0lVNjJEWTZHbmxMczl1OWVqUk9RQ25mNnZmUHFrMWlE?=
 =?utf-8?B?UERxcXg1VGovUDdJVWlFLzRFN3lrT01OUnpNdVRBTkJEdCtPTzBOdk5iOTFM?=
 =?utf-8?B?THNBTnhURm5HN2gxSzdxTXBzN3FSTFVHSlJnMklOTVZPQ0F5MHpRaE54cGtC?=
 =?utf-8?B?eTkwdjZPQkNUcnJIWTQ0VEx2L3hqK3N5bGVoS1ZKSVV5ZXZZRTNqRVFJYXRt?=
 =?utf-8?B?MzhzNW1rWWkzTzRCZVJnN0FaWERPZHo3dDJ6R2lJQjh2cFB0c1NSaTBEanQ2?=
 =?utf-8?B?Zm1NWTA4ZURjTXVWYUJCOXJpalkrOVRSZU5xeVFyM0E3dmJESXMyN2RxMnph?=
 =?utf-8?B?RUdoSjFPekwxb3Z3dmViVEdPUEQ3NmFDQkFZbVkxeGJPL0V1SmhUYzBnYzdp?=
 =?utf-8?B?RHFzdERQcHU4dTd1WjJwKzA2VHplNFJuSkR4OFlmdWFQbFA3OGpkWThtUlQ4?=
 =?utf-8?B?WkE2Uk43NzNpQWNEWmo2aFFvY1F0bWwzdjVGQ0JEaXFVUDN0d2Zva1kwdEJq?=
 =?utf-8?B?RzA1eml0V3NKMnRWNFA2bTNUUlp2ZGdRUFZVeG92cS9jNExGTzZ0Y2NUN3NP?=
 =?utf-8?B?aHc0a2ErUUh4Zi9DV3Nzeko4SWJQeDBnNzVFYTVHWEdKV3kxWFdPb0h4OHZW?=
 =?utf-8?B?U2xBMUk5RHpTTTVITC9jQ0RxVnFQalY1Z3B3a24vajE2WGY5bGF6ZTk2bjk4?=
 =?utf-8?B?VlJ0T2xFU2h1Y1lwNEd5MzlKSXB4SXE4M3U4UjJYZmRhNE1ZWTFDVnlKdTlx?=
 =?utf-8?B?b0t2YlZabXVPVDRHd3FBVngzMythcnVlaCtwMlZtMFkvSUowbStiSnRIZnF3?=
 =?utf-8?B?ZXB5WUhrUVhMS2ZCOVhPdTRUTCtQejJRK3M4S1gwR2RsSWkyRUFwU0JieWtr?=
 =?utf-8?B?WEJ0MFNiY0JMamJCUHo4RjBoTk5scVpWSkM3VVg2NE53YUx4aytJREdnbEtG?=
 =?utf-8?B?V2FFVHFxeTQxb1llUTJRQTRkSlFPcjRqRVF1bk9ZdThUVGc5MStiZytHK0hj?=
 =?utf-8?B?R001SkZCbGtVN1d1dUxncHV6WXlmOFlQTHZtY3g3cjVpZitFalBIaWhTRWlI?=
 =?utf-8?B?bGs2TXZlVCtVUmJIeU90NGs0eE4xbG9RdkJHV2VQWmNnb2JOamFNc01xbm5S?=
 =?utf-8?B?cm1hU3ZyU3BpS25CUkFBME1mQTU3aEo5M3hxRkJiUU54WFBBNVRxVi9EOG1M?=
 =?utf-8?B?ckdjS3BLbGFKTnQza1lDOHgrcXlBMTdvYnp0My83YUhJai84Sm9nd201SHRX?=
 =?utf-8?Q?LCLmWz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06cc856-de13-460a-60ed-08dc9b415a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 09:20:16.7088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKa0WgG7mRSV18YV088hO+ZeQ7Rsp7KwHeVQt/+sw9Yw1oL8WgoKmxg/CIjloULf8czVF0vw3KcvbL4fWPj6Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR83MB0520

PiA+ICsvKiB0aGUgY2FsbGVyIHNob3VsZCBob2xkIHJjdV9yZWFkX2xvY2sgKi8gc3RydWN0IG5l
dF9kZXZpY2UNCj4gPiArKm1hbmFfZ2V0X21hc3Rlcl9uZXRkZXZfcmN1KHN0cnVjdCBtYW5hX2Nv
bnRleHQgKmFjLCB1MzIgcG9ydF9pbmRleCkNCj4gPiArew0KPiA+ICsJc3RydWN0IG5ldF9kZXZp
Y2UgKm5kZXY7DQo+IA0KPiAgRnJvbSB0aGUgY29tbWVudHMsIHRoaXMgZnVuY3Rpb24gcmVxdWly
ZXMgcmN1X3JlYWRfbG9jay4gQ2FuIHRoZSBmb2xsb3dpbmcNCj4gYmUgYWRkZWQgaW4gdGhpcyBm
dW5jdGlvbj8NCj4gDQo+IFJDVV9MT0NLREVQX1dBUk4oIXJjdV9yZWFkX2xvY2tfaGVsZCgpLCAi
bm8gcmN1IHJlYWQgbG9jayBoZWxkIik7DQo+IA0KPiBJZiByY3VfcmVhZF9sb2NrIGlzIG5vdCBo
ZWxkLCB0aGlzIGZ1bmN0aW9uIHdpbGwgbm90aWZ5IHRoZSBjYWxsZXIuDQo+IFRoaXMgY2FuIGV4
cGxpY2l0bHkgZW5zdXJlIHRoYXQgcmN1X3JlYWRfbG9jayBzaG91bGQgYmUgaGVsZCBiZWZvcmUg
dGhpcw0KPiBmdWN0aW9uIGlzIGNhbGxlZC4NCg0KVGhhbmtzISBHcmVhdCBpZGVhIQ0KDQo+IA0K
PiBCZXN0IFJlZ2FyZHMsDQo+IA0KPiBaaHUgWWFuanVuDQo+IA0KDQo=

