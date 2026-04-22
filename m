Return-Path: <linux-rdma+bounces-19465-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDBdO7KU6Gl9MgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19465-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 11:28:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D5A443F8B
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 11:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ED793017F85
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9DD3C2787;
	Wed, 22 Apr 2026 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jQFkJBzp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6924081732;
	Wed, 22 Apr 2026 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849923; cv=fail; b=H2xkqX8CtwsyM0mFC9nHFGqMv4LGQz83ENd7hNnejLLy0jKcMGXEiUtqcVE/ZWPZ99arYQDWYB6KAHSwkpTuXjkrhunvGMQAt0uBCpbdvrW13YJIhltEvQ8zgFAILZTUR+3mepkCHLVhUgLThCgMV6s9ZO/bhmtHOcV1xaTe2DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849923; c=relaxed/simple;
	bh=UoimxLA5kLeGBGGjsOISemxB7JLGJDZCvvLSzyNB58g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BRUv+EV1mlkXFVqKgts8O9yCujZftBUbwSDUI03cQtuK/qEaoiCZN05vaNzlCEOFp4gI2OZiLk9i69CjnlSU+OLU8LGdoC8fK2c4eD174+ri4lNqWYooIRcGqrszkxgkYDR3svC6xIefwY+nHPmew6qwbztAkOcB3W5pp2MrOZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jQFkJBzp; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlA419+UbqpRmgpg+H8ZwJjWUztdiU8mN/+tmXvKPlgQKIpdWcpnE3VrCqhCJgwT4sZjlNU09zt/Tb0MWDpY8cz7FA3cNGp1noNQ//doYg4SsedXRtruv+aZiCIY0+YP7bPp16eg67g+N1PGFLB6fOKVKSj7ZaEuuPhXK1Jsm1fRM3gkKEAw5Dc8ODgJW/rcr8LCP/9l/A+kDeOyfZSqSvvJPHTs5xTRj8EHtGbdTtXAvHBJ+S+9CMroyVhVjyzxeZIx5hO4xVm/FvzDPOH/eiA5s6B+yQLH99XkRod2OVru//l3X8WkWF1dbVjZ1coFigcVSEjtzznMmzIFkqgIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoimxLA5kLeGBGGjsOISemxB7JLGJDZCvvLSzyNB58g=;
 b=xIMfnjiHOj/MjO1xjj7BQrGn3zMF7SHRr2jUcvqwibap+NEgfYHxoqsKsm4VIwlxDR9Zo8QhcyxO1c+sbFItEDGTjU8NVDrlUBj6w7aK5GpoZ7mRiaFtwyAr8cDKxKMjFcoKe4DdpDWhvvM9aaJKbmC3KYFIa51bDt6ywLCk9Z7fOXY/VHUMETkqzPOfAv5q9pRxNeMDKIoGbdkCZEKd4pQgywvsjDJvWNPMGH6anb4BYs9blfbHj9cJSCESWzcywgvlMcf5Cafan0ARTJ28cJWUctmI7Ker/18oIh9aNNNXKkUfRRcseSVdTA/vhU2Lo4tBQqIi6u1YL6UODjhoKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoimxLA5kLeGBGGjsOISemxB7JLGJDZCvvLSzyNB58g=;
 b=jQFkJBzp53b60ODfQlxgcRvGZADwGM41kPuFZQEnQzK99VNr1Azb3hntMIeaWmwPyBUVTh0mbqD6WE0K07UcdWjo0qcG/Ryjw1nEW5Vpm1HML04350qoh4GClYqvCtUBG97MpUQlnJJoMxVnsVUMa74LAAVRpyat9k9Y9zBglfhwnkvRhj7Gkp0+KxwFbepcDU7TSLOFRExQaJAWtX7WZigxMnDls2l2HA4/xl9kFc0eJvCYI1sCJ6EVGynULUm6AMPN9eHRIACoSKbQEjbl+vsNp5OxvmBDJBjVOiYVI7tB2MwbNc+n/dkcx4NGPbm1fcUw2kD94gxz6OmhZn0D1w==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DS0PR12MB8199.namprd12.prod.outlook.com
 (2603:10b6:8:de::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 09:25:12 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e%6]) with mapi id 15.20.9818.017; Wed, 22 Apr 2026
 09:25:11 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: Boris Pismenny <borisp@nvidia.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "leon@kernel.org"
	<leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Raed Salem <raeds@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "kees@kernel.org" <kees@kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Tariq Toukan
	<tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: Re: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Thread-Topic: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Thread-Index:
 AQHczieNmLFIHpbrDUuqFWyBz+NLKrXlMUIAgAKT6wCAAG9bgIABRBKAgAAgroCAAAIjAIAAChOAgAAoZoCAABAhAIAA+YAA
Date: Wed, 22 Apr 2026 09:25:11 +0000
Message-ID: <e9d10b11f73c0ff212a5dee0b08d9ca90eca5407.camel@nvidia.com>
References: <20260417050201.192070-2-tariqt@nvidia.com>
	 <20260418190848.204170-1-kuba@kernel.org>
	 <d7e2d46769e120a16ce12d345c51a47349733828.camel@nvidia.com>
	 <20260420100917.1e4be22a@kernel.org>
	 <f327ce67e69c27ed971f4ed38f46381cd2f97ec7.camel@nvidia.com>
	 <20260421072609.4b15e7b9@kernel.org>
	 <3ca1bee450608d37cd0f9199ebc44c52c084cb08.camel@nvidia.com>
	 <20260421080951.570e6e49@kernel.org>
	 <6d96452f67d5b58578f67f97f750101abd4af9f6.camel@nvidia.com>
	 <20260421113210.4f6a8eb6@kernel.org>
In-Reply-To: <20260421113210.4f6a8eb6@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DS0PR12MB8199:EE_
x-ms-office365-filtering-correlation-id: fa55935a-19ea-4d3b-fedf-08dea0510dcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 Fu3DeYjCJ+xbmtJlxZ3MixIQIHJISYsLwD6GEcrbeP1qyGhqx3uOvDEDtYTM7KpzMdrZZ5NxvW5O9gxW0ZzChQ73QbAHw9A4Xbo0+afcEW2ZJEOwN8t0SpKCmksdKMFoQ35cgBslwFts9UTXM2+ZZ0i/yhnBcz7ZNAwJG/lIeSCXweoLOcxHXHtYCNmSdzsRr2B+qhrB7HIsp4iE1EgTwQ2KohoSsk10ZIZzusTcuoSNf5u+POhkbbENT9LxqhBVUKFTXyc0/HxwqDqRgG7bd4g2MjfvJfTnLaAftCPYYBpnz5yuj4jWuD07izvj9/HzHGRKIJYdi1azKlTePoQ/ofAsTu356KvBDxdNhxfTd0y0lrakgItzWce1k9pBzgLOJq46I4bI02wcsT9MFRxETqqjauk9+k603gAytCElk8TlL9WCj87tFyPcr5cikoKyV3arbtDDDwBrFd4JdEbiiLc1OfK7hB9uOSd55ILO7brf6yZH7Bdc4RPiyiofKXIrIaHQoQ/wSHEOKgQrTChuhr87B5Y6z8+uKGjYbidq22qkJzTMevhtVNUNmsvc+vYqhmM+Wc100ycgHUboTWP9Fq23ldpWe+HqRS/n07xt3JK8T3KohydcdLQUPSYoQ/7xrLdJBjohZx6YXy+tWnUSa76Gz7LnuDd8tx9SZoBcqnro697SfIbjQXfk+2i/r34R7LuJXwcO+eK3gn1EJB3C/GTlMX8Myi1h8XhETs9THx4eqFUtRV4PVwB5iVI3sbSwmP71qzx4tsnbSWtajhONyiguVFksLGyyOSFV6BAiAqg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDJSSXBGTHZ2VFQ3L2xMNVZLKzFwQ0hUaWFDYTJaU3lwUVlocXR5ZkdxWndI?=
 =?utf-8?B?UW43MFh3a1ZZbHlORGc4djhJQlFpamJuQ1kzMmRHK1phL0NGNXFJYTF5bTJm?=
 =?utf-8?B?ZzlZY1BFQ3BlZHc2S05TQTJEbVoxTlpWaWlsU0Q0Z2tzVks4Y3o5djNJMG5i?=
 =?utf-8?B?c0pxU0c5QzE4SEQwR2dqTy9ZeHVMak5wb05WU2F6MXE1RUt6ancxWUg3cUow?=
 =?utf-8?B?TlNCTlhiMzhkNzQvZnVnRTVQYVVSVTJta2RjMFhmUmdsSkllZTcrRmJoTTJr?=
 =?utf-8?B?S29xYVU2WHF6TkU4VjBmZVRWRG9DR3gzVTZiY1dwSlgyc242WnhZdVJBczk3?=
 =?utf-8?B?b2hBb2NnV3JGcXlhS2xrVEJzdDBVb1JYNFFNclVpSnpRY3JnU3VNL2pNYURW?=
 =?utf-8?B?MlhnbnplNi91ZTdQNHZyQWxlOFFLQTZhbnpHcHo2MzJFQTI4Q2s3bE9kUnVL?=
 =?utf-8?B?WDUxT29qRE4rd1J1eW5sMWVmYVNrR0Z0NkgvRzQwUkFZYW9JTkluL2JlM2lI?=
 =?utf-8?B?WmhJYzR3TDc3amNXd1FNbmxLeEhNMjdMdUd4Qm5sdXVSYnpSKzlaL2pidmFE?=
 =?utf-8?B?VmloalFwdU1oTHVpZHJyRmZ3bmg1cVNyamJLM1JvRXgwUWNxU0VGRHZVaUZk?=
 =?utf-8?B?ZHUxUFFCa1phWDNiTmZWbmJpaVF6cGxKQTRUc3hweGlxUFgrNUF6dU5XTStN?=
 =?utf-8?B?TFNWRnhtdnNTTDZrSC83eG94V091T1FWeW5tUmxwc1JaSy9pL05ZVzNXdldG?=
 =?utf-8?B?bGhNTVd2MGcvek13ZGc3QSswQkl0WU1FeUR4YWxJNmwrODZlZ3RlTWdEVHVU?=
 =?utf-8?B?eHVIWlJqZWVpMDYxdmZ3S3R2YVUvRkptYnFyTVNYU3ljUS9LWVcrMXduRmNv?=
 =?utf-8?B?MnpKVTY0VmJBbUVSQU9PVGJRUk5RZUhNRmFDclZuN2Y1enVwc0dOV2o5bUw5?=
 =?utf-8?B?eVNDSzZuU1E1eUFlUE0wWkpEdFdOOCt1RXZaaHRzbjgyTTZrd2o0cUZjVG8v?=
 =?utf-8?B?MlpsdUQ0S0ZkUTBxS3ZGMVpGaGloYUJYeGxMbml4M3JjamtROUF2T2JWNHlN?=
 =?utf-8?B?UU9Kb0c5eUVZbUdzQ09YNkJSWmxYaGU5WkdVdWNiUkZ1QzRlZTZ4dkZDMmFr?=
 =?utf-8?B?ajR2RUxlNkdFMmoxUUJ2Z3VKdjJkUUtWTHpVNGpIYU5TZDNwdGNxVnduOVFT?=
 =?utf-8?B?Vm5tQmNMS0Q2blNwVjl0cmkwcDY0MFV5YlJrYVBqU0xkSHVlTURCZmFka2Z5?=
 =?utf-8?B?ckVKRVVzbmQ5MlNrcGR0ajIzaDkrdHd2Mm9McitucFdBaWs4TXA3RldzWnhO?=
 =?utf-8?B?Q050QXlmWWZzdTQrekdvZ25JMkRycGpZMm0yY2U2elh3ZmxKSG13L0l5dmI2?=
 =?utf-8?B?YWx6TEtRNlhBdDdjMEVhUm9yaW5hL2pYSVlWTEJwaUFzL3dmZGlYd2FYak51?=
 =?utf-8?B?czl2dko5bUlGeFl5SUZkT2g1RUFKWFpWUkxyM2thUDRKMTF1dFFLOGd0bDFz?=
 =?utf-8?B?MjZBYmxNRCswQXUwNGR1ZCtnZXAwWEQwVTNOemtYY0NEdndoOEJUbTZHRTlT?=
 =?utf-8?B?TUtaYnovRWY5NTlHdzdwM3NaUmg0M0dkUWRYZExaWEhrT1E0K3dWK09tREYy?=
 =?utf-8?B?MzhoYlFHU01yYkR5dG5kbG5qaEgyWVlLZmJuQVg4cFFXMnF0MEd1SU1wTVF3?=
 =?utf-8?B?elM4amtUa3U1T1ZWcnBDSmJmS3Nmdkxobm9iOVh4bWtPb1BwQ0IvZkpvQUdK?=
 =?utf-8?B?YTZjWWNzM0k1WUtqZnhETnprT0UyREhQL0ZLenltQzZLNzF6UFlMMVVZVHJN?=
 =?utf-8?B?ejBPWXk1NkNDaUt1SFRjWkRkWFZKQ3ZBc0V4ZGJINGhqMWQzVjVwd1packNJ?=
 =?utf-8?B?TXF1VC95RXQrRzNxSlFPRkFmNzdobGZsTUptT3NoRTZZRVo1MDZVQkMyd3BK?=
 =?utf-8?B?a0R3Y3U0b2hrLzdDV04wYmFubmZtOGRzZlZZUkh3Q28rRWU3Um5wc0h5dkZ6?=
 =?utf-8?B?R3grWnM1NS9qVDU5aU00MW8ybFdaTVhhK1h6SzU5K1dWTXZmRFZTaS9XRjNG?=
 =?utf-8?B?UExyN0tNeXVFcXBwNnMzc1NxU0hCLytvK1duWWlnajZrOWdDVXlETTYwOTBh?=
 =?utf-8?B?UHNUS2EySHprNTFtY3pVL0hLMlJwZ1pleDM4cFd2M3ByUnVLZmJzLzhjVjBT?=
 =?utf-8?B?RnFDaUJ4MjBhaFhVUW9CU3o0NXVxU3M5OXYwYUthcGVBcml1a2RUckZzeW8r?=
 =?utf-8?B?Y3luVUU3T1RrK0FVZ0ZOOWFUZlhCVmhvZS9vV3VOZjJrM2hRaTNESkQwendn?=
 =?utf-8?B?NDIzZTRVamhWM0JnVmVCOSt6TW9BbkhabE1BbHhNNWhBRC9aREVMZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4AC29CBAF3DA04CA2A37B7CA82D7699@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa55935a-19ea-4d3b-fedf-08dea0510dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 09:25:11.7347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9FWnfP69Q9HsQrKhF24D8gPr7NcXRIw2Cf9t6qHSEougK/M6sq6+uevwGDWJ4mcTMyyWzEfij/uEUmXLOV6h7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,lunn.ch,davemloft.net,kernel.org,vger.kernel.org,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19465-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:replyto,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 64D5A443F8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTA0LTIxIGF0IDExOjMyIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVHVlLCAyMSBBcHIgMjAyNiAxNzozNDozMiArMDAwMCBDb3NtaW4gUmF0aXUgd3JvdGU6
DQo+ID4gPiBObywgdGhlIG5vcm1hbCB0aGluZyB0byBkbyBpcyB0byBwcm9wYWdhdGUgZXJyb3Jz
Lg0KPiA+ID4gSWYgeW91IHdhbnQgdG8gZGl2ZXJnZSBmcm9tIHRoYXQgX3lvdV8gc2hvdWxkIGhh
dmUgYSByZWFzb24sDQo+ID4gPiBhIGJldHRlciByZWFzb24gdGhhbiBhIHZhZ3VlICJrZXJuZWwg
Y2FuIGZhaWwiLg0KPiA+ID4gSSdkIHByZWZlciBmb3IgdGhlIGRyaXZlciB0byBmYWlsIGluIGFu
IG9idmlvdXMgd2F5Lg0KPiA+ID4gV2hpY2ggd2lsbCBiZSBpbW1lZGlhdGVseSBzcG90dGVkIGJ5
IHRoZSBvcGVyYXRvciwgbm90IDIgd2Vla3MNCj4gPiA+IGxhdGVyIHdoZW4gMTAlIG9mIHRoZSBm
bGVldCBpcyB1cGdyYWRlZCBhbHJlYWR5Lg0KPiA+ID4gVGhlIG9ubHkgZXhjZXB0aW9uIEknZCBt
YWtlIGlzIHRvIGtlZXAgZGV2bGluayByZWdpc3RlcmVkIGluDQo+ID4gPiBjYXNlIHRoZSBmaXgg
aXMgdG8gZmxhc2ggYSBkaWZmZXJlbnQgRlcuwqAgDQo+ID4gDQo+ID4gSW4gdGhpcyBjYXNlLCBQ
U1Agbm90IHdvcmtpbmcgd291bGQgYmUgc3BvdHRlZCBvbiB0aGUgbmV4dCBQU1AgZGV2LQ0KPiA+
IGdldA0KPiA+IG9wIHdoaWNoIHByb2R1Y2VzIHppbGNoIGluc3RlYWQgb2Ygd29ya2luZyBkZXZp
Y2VzLg0KPiANCj4gV2hlbiB5b3UgaGF2ZSBYIHZlbmRvcnMgdGltZXMgWSBkZXZpY2UgZ2VuZXJh
dGlvbnMgdGltZXMgWiBGVw0KPiB2ZXJzaW9ucw0KPiBpbiB5b3VyIGZsZWV0IGRldi1nZXQgcmV0
dXJuaW5nIG5vdGhpbmcgaXMgbm90IGEgZmFpbHVyZS4gSXQganVzdA0KPiBtZWFucw0KPiB5b3Un
cmUgcnVubmluZyBvbiBhIG1hY2hpbmUgdGhhdCdzIG5vdCBjYXBhYmxlLiBCZXN0IHlvdSBjYW4g
ZG8gdG8NCj4gc3BvdCBhIGJ1Z2d5IGtlcm5lbCBpcyB0byBub3RpY2UgdGhhdCB0aGUgZnJhY3Rp
b24gb2YgUFNQIHRyYWZmaWMgaXMNCj4gZGVjcmVhc2luZyBvdmVyIHRpbWUuIEFmdGVyIHNpZ25p
ZmljYW50IHBvcnRpb24gb2YgdGhlIGZsZWV0IGlzDQo+IGFscmVhZHkNCj4gb24gdGhlIGJhZCBr
ZXJuZWwuDQo+IA0KPiA+IEJ1dCBJIHVuZGVyc3RhbmQgd2hhdCB5b3Ugd2FudC4gWW91J2QgbGlr
ZSB0aGUgbmV0ZGV2aWNlIHRvIGVpdGhlcg0KPiA+IGJlDQo+ID4gZnVsbHkgaW5pdGlhbGl6ZWQg
d2l0aCBhbGwgc3VwcG9ydGVkK2NvbmZpZ3VyZWQgcHJvdG9jb2xzIG9yIGZhaWwNCj4gPiB0aGUN
Cj4gPiBvcGVuIG9wZXJhdGlvbi4gTm8gaW50ZXJtZWRpYXRlL3BhcnRpYWwgc3RhdGVzLiBUaGlz
IGlzIGEgbm9uLQ0KPiA+IHRyaXZpYWwNCj4gPiByZWZhY3RvciBmb3IgbWx4NSwgYmVjYXVzZSBt
bHg1X25pY19lbmFibGUoKSByZXR1cm5zIG5vdGhpbmcuDQo+ID4gUmVmYWN0b3Jpbmcgc2VlbXMg
cG9zc2libGUgdGhvdWdoLCBpdHMgb25seSBjYWxsZXIgaXMNCj4gPiBtbHg1ZV9hdHRhY2hfbmV0
ZGV2KCksIHdoaWNoIHJldHVybnMgZXJyb3JzLiBJdCdzIGNlcnRhaW5seSBub3QNCj4gPiBzb21l
dGhpbmcgdGhhdCBzaG91bGQgYmUgZG9uZSBmb3IgYSBuZXQgZml4IHRob3VnaC4NCj4gPiANCj4g
PiBJIGhhdmUgYSBzZXJpZXMgcGVuZGluZyBmb3IgbmV0LW5leHQgd2hlcmUgdGhlIFBTUCBjb25m
aWd1cmF0aW9uIGlzDQo+ID4gaG9va2VkIHRvIG1seDVlX3BzcF9zZXRfY29uZmlnKCkuIEkgd2ls
bCBsb29rIGludG8gaW1wbGVtZW50aW5nDQo+ID4gd2hhdA0KPiA+IHlvdSBwcm9wb3NlIHRoZXJl
IGFuZCBwcm9wYWdhdGUgZXJyb3JzLg0KPiA+IA0KPiA+IE1lYW53aGlsZSwgZG8geW91IHdhbnQg
dG8gdGFrZSB0aGVzZSBmaXhlcyAoMSBhbmQgMikgb3IgbWF5YmUganVzdA0KPiA+IDINCj4gPiBm
b3IgbmV0IG9yIG5vdD8NCj4gDQo+IENhbiB5b3UgY2FsbCBtbHg1ZV9wc3BfY2xlYW51cCgpIHdo
ZW4gcmVnaXN0ZXIgZmFpbHMgZm9yIG5vdz8NCg0KRG9uZSBmb3IgdGhlIG5leHQgdmVyc2lvbiwg
Y3VycmVudGx5IHVuZGVyZ29pbmcgdGVzdGluZy4NCg0KQ29zbWluLg0KDQo=

