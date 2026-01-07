Return-Path: <linux-rdma+bounces-15335-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BBACFBCAD
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 04:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BF4B302037E
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 03:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F15F228CA9;
	Wed,  7 Jan 2026 03:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ioU1rUET"
X-Original-To: linux-rdma@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010023.outbound.protection.outlook.com [52.101.228.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8178F4A;
	Wed,  7 Jan 2026 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767754952; cv=fail; b=iBB+WeuQJSLXKmTG6uiOZrgnFkMh807C8oLikBNQNmVMc3CG5vqgBH2c1IMEJ2TS0MKnNLts4U9gzicdTRBOZ4bHoG0wQ3Yia+bchTeRfA02I7TjWu8tcWcBH/L6kSPCQTpMGKnhxKRqz1SG+h4WDd2VW6+psgEdkxijMlms14g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767754952; c=relaxed/simple;
	bh=oLI9KDn59QQ/A9GlCoTTqLm7xKHyScjo1I8wv8TMmeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VidGne8DmQPRosT0/hiUBHBYvWTJvefTreLdf+iivOL1isLK1bwOmgCcTIf9C39pmJQ7RFA2hUTj2/GazMB3ubVPfCX1q9QJo6s7/n7EgFHuUkq6WfFir+zG9tSTDwLAVK5B8tHvvf52XtmY52RBGjIz7xTLifDPnthLkgUF5rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ioU1rUET; arc=fail smtp.client-ip=52.101.228.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHypKqIQSUY80i16yJ5/hBHfAfSY+k1Bd2eukul+dCELGXPhgZvb/GnmqNHi81WeWJ9m06xVBOp7G+1DZWbO8QNLe8waNTOmDJL+5+uI+Vn1CgEIrM0GFOUxPcteZh7bjDhtMAuo8E7nc7Oe1hf0GjgHdd/PH4NYo1jNkpMA5b/Sd91L5XpiwVT3I+vJNN4H+i3LnuGRWfabKZ33FhGejjm/Z6Ie7i/AJ1KLuUqIGQs1OdDSi4a5vafxX01BOcERqvUTbOv5lEJgmLG3yb2ciRnIcl7WN1m/O1HUeRzjRuJCueTgBOMlJkQ+wxuNQ78ZEvbmgbOu/3YGaySxyF/OJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLI9KDn59QQ/A9GlCoTTqLm7xKHyScjo1I8wv8TMmeU=;
 b=ihpCehAY488zBOEIVJy0Fkect1RWWqi2fLizMGNKldkvquZ4dql2GykMBSvRt978eNI92yHEi0uJ2uaKn5Vh21Sxj07VoctCubWoC0hUJgbASStJUPvxZV6pXDNEIxMixNmqICOIktLaGmjXkHt6NpafLouXwwW6o63qefe3Qm7S90hkxnCKd6lQKM3Tt/+SzPcrXRXFD8G3q6IC78mrQUz9tprHo8/mP8NnEv/hXMvAsZqQIG3nr2r+qBLYZnnDqujLyHNtX5segnn+LDbAEs7vM9A1YGwLfm2oUwtH8gyfzwY6u4dUbTcaXAB0nrSL/j9OWcxicImH75ntMBI5+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLI9KDn59QQ/A9GlCoTTqLm7xKHyScjo1I8wv8TMmeU=;
 b=ioU1rUETFfA1NQelVaH7bV/AshPDQhZYAaxBM45FrXnkw+XExgNC6scvDQJDZb5EQAHT9nxvOcg1VjqPA8EYNkWAw6ROzpKijkDpl7NV8V4LLkaGA1ASCUWxM3Yuxz9QUpCFWtaLDMTjm0KATokC1949cLSfUx2o3DWhcBKdlm7aAdmE/NxoqzNZFrirBwGGeITy/p2Q7amuHGPnr+0cwICvIju+zb/UIExlh6fd1/0qj47cybAcW6XrE/OxWqGCVTR6Aq8uKhhEnTSbNJxboIO9R9brHfhmE+NLLboMAE7QutWD7OcLxTR4uK9pasUgms/hW17VrEzd4zLvb9Xh6A==
Received: from OSZPR01MB7100.jpnprd01.prod.outlook.com (2603:1096:604:11a::13)
 by OS3PR01MB8195.jpnprd01.prod.outlook.com (2603:1096:604:175::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Wed, 7 Jan
 2026 03:02:28 +0000
Received: from OSZPR01MB7100.jpnprd01.prod.outlook.com
 ([fe80::392e:5cfe:7cd5:92af]) by OSZPR01MB7100.jpnprd01.prod.outlook.com
 ([fe80::392e:5cfe:7cd5:92af%7]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 03:02:27 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "leon@kernel.org"
	<leon@kernel.org>, Yi Zhang <yi.zhang@redhat.com>, Bob Pearson
	<rpearsonhpe@gmail.com>
Subject: Re: [PATCH RFC] rxe: Fix iova-to-va conversion for MR page sizes !=
 PAGE_SIZE
Thread-Topic: [PATCH RFC] rxe: Fix iova-to-va conversion for MR page sizes !=
 PAGE_SIZE
Thread-Index: AQHcdk1rywJr32Xi+kGTH0jFIevMrrVDM+mAgAExDICAAbKKAA==
Date: Wed, 7 Jan 2026 03:02:27 +0000
Message-ID: <38f06731-1547-4057-89e4-5d0d5d5b2508@fujitsu.com>
References: <20251226095237.3047496-1-lizhijian@fujitsu.com>
 <cbbba297-7095-49f1-82e0-8f22d4f94e1a@fujitsu.com>
 <20260106010709.GO125261@ziepe.ca>
In-Reply-To: <20260106010709.GO125261@ziepe.ca>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7100:EE_|OS3PR01MB8195:EE_
x-ms-office365-filtering-correlation-id: 0892aa44-3812-4170-377c-08de4d9930e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aGFlM0t4cDk1akdpRHNSaWpib0xMaUkreS8zWUw5TkU0WG51cU0rRlZtWW9F?=
 =?utf-8?B?cnBMS2FDTDJ5YVhkV2EzYm1RaXV3amtEWi9BMHF2THJ5aGxWSEYxVWhENmI0?=
 =?utf-8?B?bmJINFkwMU56YnhaSy9icjVVZ0lWQjRqVDVHTzc2K0pSajRWcDNCYzMvTUI3?=
 =?utf-8?B?ZzBrU2FneU13dFhnbGlXM3g3OHg3RzRYaFR5SCtBeDJ6cXZCTXVEa2wrT1h2?=
 =?utf-8?B?U3Q2Zk9RN3kwb2dsc1FLSE4xdDJUamRkeUFxbFZOUWswS3VkZUFUdWZjZ3BZ?=
 =?utf-8?B?ME1xYmRTallRUWxpekxnaE1nbGlIT3Zab1dFRzR3bkxucFpPMEpnL1FnUW9a?=
 =?utf-8?B?dWNTRFYrRmlPd05acXB5enBBUEFvMzNJUlFxMXc2NHV0cDJvR1FpY3RaaHFY?=
 =?utf-8?B?U09yOFdKSDZRbXNLQ2tDK1V2Q0lDQVlSNlpuVVlsQys1ZzlXUHp2ald2RkFk?=
 =?utf-8?B?d3U0dEpNK1EveW45bG1RVThwZGFnTVh4N2VjYmxnU2JMRzNPSndKY0pyck8y?=
 =?utf-8?B?MU1EbTh2aU0rQ0paZWt5L0hqQVVQdWQvOVRJYURqaGdEZDFyMllUMXJ0Z0sx?=
 =?utf-8?B?dW1ncldBT1BrZDBVczNma3Z0MXNtMzlhWVZQYXZSd2ZaVzd3dmFjbWFkdFk0?=
 =?utf-8?B?R1lOMHRlaXZJSmpnQlZJZmhKWVdWWVZqYmU2QUNWL1AvcHQ3d2ZVcFFwR1o2?=
 =?utf-8?B?MXZiUExxZkxCbWROV1pPY2tnS0Zoa1FqeDk4Z3pUV3pmVDQ5aFpwM2UzdVRm?=
 =?utf-8?B?ZGpFYlhwcGF4Q2VINk50VEV1QmhFMVRlWjB2d25SOEJtRjZLaUxEMnBsZ0xk?=
 =?utf-8?B?b25yR0NScnlCRnhJN21hNERoVUZQR2MxRWRwN2RTMGExOEtZTHpJNUd0bFZs?=
 =?utf-8?B?S2hUdzNFcWJaSFJTbWViZHArMmY5OEJlZnRreWpITlhUU2hNRUROWlEvRHBX?=
 =?utf-8?B?VlJQNUVsVlg5UUlhMFdLZllUQkVvcTA4VlV4NG9rNUYvS2NmT3JHVmFnT3Vi?=
 =?utf-8?B?SmVqelg4TmMydjBQZGpzMlQzajRLVlRtNHB1UGdNZXRRQVcvREZHL2VpV2Na?=
 =?utf-8?B?emsxNkpxYng0WG1nTG9kU2xnYUhwc1lXeHBRbmFaTjBRT0thenNPQktxV3VR?=
 =?utf-8?B?TnNIMitRMjZ3bkprc2t3OVB4emZIbjVKeU9XWnpjRW4yekF2bjhxd085NjdB?=
 =?utf-8?B?ZElQRGwxMjN2Z0s3eDVuVU1YME8wOThUd3gzdWYvM0dRZFh3SEFGcnRWaHZD?=
 =?utf-8?B?Vnd5S1A4bW94d2JZRkd4VEVobUh6ekZMUHhiR3BqM29sSkY2TUYrbjFueTN0?=
 =?utf-8?B?WXdFRXNhZ0xZeEZTMnlGcElYbzFLRjNiN0ZCajJ3NEZmM3E4NGI0d3p1dWRj?=
 =?utf-8?B?VGtRTU9oWFdiN3F4R3dMSTNSVVZ6cSttUjQwSy9hTXZIS3M4dWt1SlovR3M5?=
 =?utf-8?B?a0hySTVHYnhmd0pKZ2lNQlZ0RlBNUGdaSE92V09nQW9tVG5XZlNoSmkrSW9O?=
 =?utf-8?B?cXdjczl5Z2w0ZG45VG9xcEUxWTY3Z1B0ZE0wT3RhSzJyWGFHa2YyMW96bmlX?=
 =?utf-8?B?TVM1b0ZnaDBCejlvMTcyUVJzVDg2a3R1R3hHdHBzVE45MXc1UnRiZDVkSU9X?=
 =?utf-8?B?Qms1OGtMQ1Bpa1NaQ3JWSHV6S2lCT2lCbGQ4S0JoTTJwK1k0SzZ5am1WVXJ4?=
 =?utf-8?B?THJ5Z0ZiWnBOSnFobGt0U1RnMEI1bThpL2hzOVJEcmQwQmxWTHkxTTZXVUc2?=
 =?utf-8?B?bkt6OHUwY2hWSURWcnYrRXFqMjBSbFBFMm81QnEwOVlveXE1Yjg0b1c3a2JC?=
 =?utf-8?B?bFRDWjZ6QWkweG0vU3BxKzJyam1wRHpCdUxSNTBpRDJIUlF6M0FoMzFuMGh4?=
 =?utf-8?B?Y0xEeVM3TEsxaHViQ0ZwUncyV01nWWxLdDRqQjdXUFVJWTU4WGxBTzJVaUZM?=
 =?utf-8?B?eFBvVlhodmFOS1dNNzFxWC9VWHBaMUxEbzdTVTJ0MnZudDlZNW1sS3VaMHRo?=
 =?utf-8?B?eFdmWnlLdC9tZ0ZhaGhzT0pCbktkZ2xLS1JacGxVUWdPd0pyWEN2dzRKYzU3?=
 =?utf-8?B?a01FSjRGNEJ3WVdlMHE4YkFJb3RrOWVQako3bVdwWDdCYjJ0MEw1a3Fqbk5o?=
 =?utf-8?Q?aSt0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7100.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ak54UFpFVzg2c0NsVnlIa3EvbUwvenBpdXphVXJKc2FZU2NuMVlEdGlJQVMz?=
 =?utf-8?B?VksyeDFRNmRYMlNrQ1VnakVXZzMvczgyUGJ0Yks4N1VLRlhCSis3QWFOM0I4?=
 =?utf-8?B?LzNCR0lkcVBVMnlBVW9QaG5hb0VZSm5PWVhZMjRVdXhRWmZINjMzblpZd3Zp?=
 =?utf-8?B?TE80SUpXaGZraUVyaFJQZFovT01kVis5TmZ0bktvV0NEWTBvNzVOczhxZG43?=
 =?utf-8?B?K2loaDBWd2NqT3M4TXF2dEFROEFwWkVIQktpUWZGbDJwUlUwQlpQRHE2U1F6?=
 =?utf-8?B?UG9XRWFrM254bWVDS0d3QTBXMzJIOEtsNEt1U05LKzVwaVR6emliRzJCVGp6?=
 =?utf-8?B?OTdzU1Y0ZHhaWExjYU8xR2JFKy96MEpFTFlJRnBkalNlOXF0TnNRSGhDRGE0?=
 =?utf-8?B?K1cvbXdkRDFreWF0ZUFFb2FDRVdsNHFTNVNnNzVGRkZkNXlOU3NSdElhMnVB?=
 =?utf-8?B?OGU1V1A2UmNUeXg1d0Y5UXE3aGxINS9WTFZ4YXZ5K0VpaDYvY2ovU0QxVUY4?=
 =?utf-8?B?NVhjQjVqc2puT0tMaEhyQjBPUlBZZk45WnVmcXMrQVIrWm1XWWFjQTh3a1hz?=
 =?utf-8?B?TGcyOHgyWGZ0QTlYSDRPMURxdkFtTThwWDZYSVA2OXN3emRBY0tKT3hURTl4?=
 =?utf-8?B?WTl2cEh5QmpsOHBQQmlzaHB3Ty9RR3pBZk5ONmduNm5DTlgycDJ5S0tSa2JE?=
 =?utf-8?B?QTc0WWJMSUpzeFZMOHRnMkc3V3gzdmVHVmdMa05UTE9TN2RRcEN1Q3BTdEVY?=
 =?utf-8?B?UVU2dVV5THBoZ3A4bDJScWhkRjhhSUorVDJ5K0RObStHa0Q3UzNtSmRaTXNQ?=
 =?utf-8?B?cHphZVdWNTc1bml5WXdXM2JWbGwvZEhzdjNvdHJFVnI0M3U3Rmk1MW9TNnNa?=
 =?utf-8?B?dkFyZnlUVlJoMDUwODFhQWdRL1JlVWJQbVRnM2xTeEZGVEt0R05XVVFvcXJ3?=
 =?utf-8?B?TWgyQzJlaW9oRGZERlZRc1JDZVEvWm9tTUZIM29Uc0o5VnZHRy9TUjNWTWtk?=
 =?utf-8?B?TmxKWkkxUHpwWnZSb1NqTzFyQU9VVnNNbi9DWlhhRERib3QyaHdkcGk2NndB?=
 =?utf-8?B?R1lFRU9oaGlYcmdMUXF3QjVpaEJaWlVMcG1FNnRia3lsalU2ZzJVdFBHQ3cy?=
 =?utf-8?B?TUJjNUk2eExMYWtRVWU0MWlFTUU0aEgxT3dTeldVUEN2REtaQUxxQU5IVlZv?=
 =?utf-8?B?TWM3cWkyN1Frd0lWZjIvLzE2YTRKOWpLWjJVWGJiTUk2eDZWd3ZZcUl4MktO?=
 =?utf-8?B?MEZHY0ptQ3U4NkswWUlDa293Z0xZakhEREpxVUxPQ2h3UHJCZWxZcjJlT3pQ?=
 =?utf-8?B?NmRsYnVBbjNiSDBsWmNWdDlBM1lZZ0VNbDM5VlR2ZUFuU01JZlIxbm1COVIx?=
 =?utf-8?B?eEx2WE1KK0RsYVlrVU1EMit5bkhBU2ZFSlZUTW1ZVm1NL1FuajRrNnl1eE1l?=
 =?utf-8?B?N0pRNmJOM2cyQjlRRU5RRWJxcGJFdmZydm5IcWtWLzZZaDRmNWlVWHRTNTlo?=
 =?utf-8?B?aGlIeWNiSE9WVGRxSk1RUzRoZE1DTVRlVzU3aUlScW9RdzRsYW9HY2s4YkpV?=
 =?utf-8?B?bFEvWUFwbXFqT0t5TWN2aTdlemRteDdQVHhHa1Uzb0tpQ3hpTXpXd1JhMXBK?=
 =?utf-8?B?N1AwdmtKNUM5NERpaUhMZEZqbDBMTGxiR1pkUktuWFZOZnQ5ZTRZQlVGWHRX?=
 =?utf-8?B?anE1TzVQbU5QSVhjcTJ2OXp5WjRpQkM1dE8xOEdnTzNDWk9VVFYwWi9DU2xK?=
 =?utf-8?B?Y3RDOUlRdkdZa0dsalhrRjFwRkdaZUNPS2srUHpEMnluV0dxbmJrWkc5RmlO?=
 =?utf-8?B?REkwK3JYb3lWcTFFM0hLbUdIdEt2ME5JalhQUlN6NUVDWThKVENzaTJKd1dk?=
 =?utf-8?B?bDllbDNFV2FObzdDcXpjZkVCc1FzQ2NLK0JSdjlJR05Kdjh1TGxsbnh5d0hX?=
 =?utf-8?B?NUtERFVyWU8vQ0NUeExOeGdieGJDbFAvMkRWWTNlZ0FRbkxRazUxVmZPQWgw?=
 =?utf-8?B?Z0JUSC9zR0x6OGVsZzZINWc0M3pOUkNvSko1cnZDbGNnOG4yVERqUEUwck1I?=
 =?utf-8?B?TEtmdlIyeVJZUXNWeUVtU0J2N1VwaklZTUNISDlBcm50N2t0b0RsYkdSZHA2?=
 =?utf-8?B?K21adkFMeDdLVWlNbXIya1BVZGREZTZQTGdXZ2xoS01TTWI1bjJ5c0Qvck5x?=
 =?utf-8?B?TUNCaXpmaTZaKzFwdG1ubGR1RXAxUzlvdXBBVjhFOXBNdkFaTUJQV1U0dkdo?=
 =?utf-8?B?S0FVcWdjd1VSZ3UvMi9OYjdndEI4YUczVnZ6UFRqV21TaFY1TlBSdHc1djRt?=
 =?utf-8?B?UjVzcWdOaHo2b3czOVo3YUhjcHFBQjkxdEQvN0xKbjloQ09yK21JQzY3L0l0?=
 =?utf-8?Q?qjDLzPiDhps8Bkj0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2843373385BF064E8CB12C2C4ACD9B3A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7100.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0892aa44-3812-4170-377c-08de4d9930e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 03:02:27.8173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wG1CUz1SVsNvFidnl+QmuNNMnKe4F7I2tmFmYXjtTGK4HQ06JgxYTPPjZzFTsGRnNl08TzhyIZWbvYUGhW8TQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8195

DQoNCk9uIDA2LzAxLzIwMjYgMDk6MDcsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gTW9u
LCBKYW4gMDUsIDIwMjYgYXQgMDY6NTU6MjJBTSArMDAwMCwgWmhpamlhbiBMaSAoRnVqaXRzdSkg
d3JvdGU6DQo+IA0KPj4gQWZ0ZXIgZGlnZ2luZyBpbnRvIHRoZSBiZWhhdmlvciBkdXJpbmcgdGhl
IHNycC8wMTIgdGVzdCBhZ2FpbiwgaXQNCj4+IHR1cm5zIG91dCB0aGlzIGZpeCBpcyBpbmNvbXBs
ZXRlLiAgVGhlIGN1cnJlbnQgeGFycmF5IHBhZ2VfbGlzdA0KPj4gYXBwcm9hY2ggY2Fubm90IGNv
cnJlY3RseSBtYXAgbWVtb3J5IHJlZ2lvbnMgY29tcG9zZWQgb2YgdHdvIG9yIG1vcmUNCj4+IHNj
YXR0ZXItZ2F0aGVyIHNlZ21lbnRzLg0KPiBJIHNlZW0gdG8gcmVjYWxsIHRoZXJlIGFyZSBETUEg
QVBJIGZ1bmN0aW9ucyB0aGF0IGNhbiBjb250cm9sIHdoYXQNCj4ga2luZHMgb2Ygc2NhdHRlcmxp
c3RzIHRoZSBibG9jayBzdGFjayB3aWxsIHB1c2ggZG93bi4NCj4gDQo+IEZvciByZWFsIEhXIHdl
IGFscmVhZHkgY2Fubm90IHN1cHBvcnQgbGVzcyB0aGFuIDRLIGFsaWdubWVudCBvZiBpbnRlcmlv
ciBTR0wNCj4gc2VnbWVudHMuDQo+IA0KPiBNYXliZSByeGUgY2FuIHRlbGwgdGhlIGJsb2NrIHN0
YWNrIGl0IGNhbiBvbmx5IHN1cHBvcnQgUEFHRV9TSVpFDQo+IGFsaWdubWVudCBvZiBpbnRlcmlv
ciBTR0wgc2VnbWVudHM/DQo+IA0KPiBJZiBub3QgdGhlbiB0aGlzIHdvdWxkIGJlIHRoZSByZWFz
b24gcnhlIG5lZWRzIG1yLT5wYWdlX3NpemUsIHRvDQo+IHN1cHBvcnQgNGsuDQo+IA0KDQpJIGFn
cmVlIHRoYXQgd2Ugc2hvdWxkIHN1cHBvcnQgc21hbGxlciBwYWdlIHNpemVzIGxpa2UgNEsuDQpT
b21lIFVMUHMgaW5kZWVkIGhhdmUgaGFyZGNvZGVkIGFzc3VtcHRpb25zIGFib3V0IGl0Lg0KDQoN
Cj4gQW5kIG9idmlvdXNseSBpZiB0aGUgbXItPnBhZ2Ugc2l6ZSBpcyBsZXNzIHRoYW4gUEFHRV9T
SVpFIHRoZSB4YXJyYXkNCj4gZGF0YXN0cnVjdHVyZSBkb2VzIG5vdCB3b3JrLiBZb3UnZCBoYXZl
IHRvIHN0b3JlIHBoeXNpY2FsIGFkZHJlc3Nlcw0KPiBpbnN0ZWFkLi4NCg0KDQoNCllvdSdyZSBh
YnNvbHV0ZWx5IHJpZ2h0IHRoYXQgdGhlIGN1cnJlbnQgeGFycmF5IG9mIHN0cnVjdCBwYWdlIHBv
aW50ZXJzDQppcyBmdW5kYW1lbnRhbGx5IGZsYXdlZCBmb3IgdGhpcyB1c2UgY2FzZSAoYm90aCBm
b3IgbXItPnBhZ2Vfc2l6ZSA8IFBBR0VfU0laRQ0KYW5kIGZvciBub24tUEFHRV9TSVpFIGFsaWdu
ZWQgaW50ZXJpb3Igc2VnbWVudHMpLg0KDQpTdG9yaW5nIHRoZSBETUEgYWRkcmVzc2VzIGRpcmVj
dGx5LCBhcyB5b3Ugc3VnZ2VzdGVkLCBzZWVtcyBsaWtlIGEgbXVjaA0KbW9yZSByb2J1c3QgcGF0
aCBmb3J3YXJkLiBJIHdpbGwgZXhwbG9yZSB0aGlzIGFwcHJvYWNoLg0KVGhpcyBzZWVtcyB0byBy
ZXZlcnQgYmFjayB0byA1OTI2MjdjY2JkZmYgKCJSRE1BL3J4ZTogUmVwbGFjZSByeGVfbWFwIGFu
ZCByeGVfcGh5c19idWYgYnkgeGFycmF5IikNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gDQo+IEph
c29uDQo=

