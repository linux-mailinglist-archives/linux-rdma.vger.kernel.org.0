Return-Path: <linux-rdma+bounces-12682-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF21DB2297C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 16:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF760683013
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 13:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065F72857F0;
	Tue, 12 Aug 2025 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IpsuQlZL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A36C2B9A5;
	Tue, 12 Aug 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006545; cv=fail; b=jOvqfvVjgow+q4ES3WPB29bQ4X0Tj/EPD7Fzne5zi8LvkbdFMXq1unSXntNng6YxUewZWeCWf92WMkJX2B5oyEdtBmQw2zsXCfET4XOUN86nqRLxhyt3Mq9hK/38QlVKTQN9aIMfAlTwb39ViB1JZDE6WCcwEYB1ykStpj1c/Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006545; c=relaxed/simple;
	bh=6/9XS4g1vhXlqh0HPKJovZPN/QC6YcjPimOvyClZwa0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MLvHcu1hkvIu9cVG+IdBd53pBdj+eljv9kuaPWDwTKkvz9xjyIjmZGThYw5+gIBdd/L+jcuo0NWKkHzmUknlpiFm7rSWe+W1QzEUUOkftYLDTRw5TtUaooXWxCqtfglywgDTSI0s6yAYR+XK3JR7TvpBG3e0ig1Ah79u2jKmGtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IpsuQlZL; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkuPvXRuADj8Hh6WI9u0Z3Gxoywmb4bqJ5m1wILHrZQ1PhZgeW4LVHJO1gDlFNoimb5VsJsZg9ujnZW9Y2BtULAUTT5TcS0JWsihS4PeCIOXRS2EhiGN03/JZ263ILENaSdIVQpHi3qXdvSsBVyVUNBvqwrddZzvWqSjMpv1OjWc1A4GVs2wHNb+cfZhcLANmtIMVb0Su2nWlrHhtApOc06wX94m/0g/s0Df0WfJ+E4ywHSGJxvo91jX+89UqZgDIFy9o5d6tSUmK55Bt0TZKNEhaxsgprdEScGwnvHpbz2tjO1iVV3sYGCkaJWJ3hoREg+Sxai+RWqwDGO9Z+/2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/9XS4g1vhXlqh0HPKJovZPN/QC6YcjPimOvyClZwa0=;
 b=w7aVazVMIusHuGf/PjE0L+kE+szEdBydNDeoyHWRGppCexXblpUxCX0fR5xUiVNPkF4l89VKWDBpxsNwm2OnnfiEPtCRqFD9dEM25sKpscLVv4iuWipS46fjaQ6PI6O3p/dnTnLj6q3wp7c90gIZvfn667/0KspLjMopDivAzDwJawzAZUWhOtqfS5LarvLIIQVKpXzMnkUI3l9/Fq6xJ9g0LQHwJtwxYjHuM17yF9WtpkB329kWubzyE5SMIk9mz+oVrsYIhENpGSFQjnq1szIBp0B6LavQ4EPrAxzDTlzlEwivND2Udo6Z8aLWLYDlVXO0mkDUkCiMMYTaAqLNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/9XS4g1vhXlqh0HPKJovZPN/QC6YcjPimOvyClZwa0=;
 b=IpsuQlZL8H6zPni0LDESVGKq1Qw3sekCtiu0q+3pYoDHuEBomXSVScOtZJF04GSuMQWaUevnfEgaWVXJqMsOJZQR1KR59tRDcRPTY9egThz6Jilt7XU7L4lVFs5iTQ6Z5+6y3JqHnY3FE1aH6TYP1B6z5u2GpblSssK8YUKPczqshOOL81repP8e4qaJpVM1dztR+EDR3x4MUpr3UlgDKItfnnOb9Ea23t143XNjVhECQQkXry1W1d5j87vTpS2UGv35lyYWx/YgpqTWtjl1Xun/7S4vkLS1X1a7SwgrYWiJOXKYfUCR1J4MARskwXS/WBGBIqY8EAMlYw0yhxwINw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA1PR12MB9738.namprd12.prod.outlook.com (2603:10b6:208:465::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Tue, 12 Aug
 2025 13:49:01 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 13:49:01 +0000
From: Parav Pandit <parav@nvidia.com>
To: =?utf-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Chiara Meiohas
	<cmeiohas@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yuyu Li <liyuyu6@huawei.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>, Yishai Hadas
	<yishaih@nvidia.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Wang
 Liang <wangliang74@huawei.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Junxian Huang
	<huangjunxian6@hisilicon.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/core: Fix socket leak in
 rdma_dev_init_net
Thread-Topic: [PATCH rdma-next 1/1] RDMA/core: Fix socket leak in
 rdma_dev_init_net
Thread-Index: AQHcC45ckMrhTjvYBkCXRQyDFygJlbRfCAxA
Date: Tue, 12 Aug 2025 13:49:01 +0000
Message-ID:
 <CY8PR12MB719547A39C4B93FFA6FF40EEDC2BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250812133743.1788579-1-haakon.bugge@oracle.com>
In-Reply-To: <20250812133743.1788579-1-haakon.bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|IA1PR12MB9738:EE_
x-ms-office365-filtering-correlation-id: 36df3fef-86db-490d-dc28-08ddd9a6fea3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?akpvclM2bW9OK0MxTXZyZVpUYUNWb1ZhZkxpNERNSGorTnQ0VExoVld1cUVa?=
 =?utf-8?B?dVpsY1hCdW9LZ0RaSnhaMmhaUWdLZ2oxMFFkL0QrWkZWN3FkK21pMEFVZlI2?=
 =?utf-8?B?b0FoalhoeERKaVhtbFEvSG85NUtBL1lzVDFCSlU2WTYzdHczNTJuV2lBYzNY?=
 =?utf-8?B?TDQwK1o3Vm0rNkFIcGQ4emdhWFd2VlFTVlJUY2pHSGVoa1JHdkJXZzVHMXJK?=
 =?utf-8?B?bkYvVEdGV0c4N3lacCttOWJYZzE1dGc5UGpSNTVLaFNjaFJhTkMrdk1zUUkv?=
 =?utf-8?B?Zk8ranZkeTNoMHJhU2JKeG5sTGV5MjJkZlBadTBpSnNuS0IzNkZxc1IrWklT?=
 =?utf-8?B?RHlQQnpjbEpiVWozMkRsR2xFNmNscmRUK095K00xNHBXUzlKMWtFTTZFYjhh?=
 =?utf-8?B?UUJQSlVMaS9rYU1KdHJZUkNDcXIvSmVuNnN5ZFgveVAvOFd3eENDby81VXFj?=
 =?utf-8?B?WURGWWdENE05YkdvRGJHd0pJTTIxMzFtTEVDb1NIaGQwRlJpdjlCU0JRT0hI?=
 =?utf-8?B?WENLRi9lcEM5NCtkeUIzR1RMaTZ1dlgzUlhlVEZkdHhJZVp6RzZpMVVpRTNH?=
 =?utf-8?B?cFdzODhJRkw1QU0rNXBtRjNSQ2dMUk5SRWV0Nlp3TmFYWDlLaDF4R0Q5VGRT?=
 =?utf-8?B?SCtITUZsSFl1cVpNVjZST0ZoNHV4bGcvWU1XN25qZ2JOZ0lvSVRnOTl3YkFD?=
 =?utf-8?B?TlVwUmF5b092U0NucHJzeElBY3lqL20zMURxZU5tRkk2WGNmWkRZYlFIQnJx?=
 =?utf-8?B?bmMrMVd5Q2gxWCtqS0pHTFNmcFdWSnZIbmRZUkxpcWtaR3NMOWdheWJiWXZM?=
 =?utf-8?B?ZVIrUmtlOGZrNzVFbEVmMmJmWTRuWmliZy9OeVZTV004MW52b1p5K09CS0k1?=
 =?utf-8?B?NklzcTlTaDVwYWp1Z0R4OC90QXBlUDRGWGl1ZWM4SkxSQUFpZ085aldMcmFS?=
 =?utf-8?B?WVNzMGhOVEpvT2hrMDMzTE1DYlQrcnh4MkhtU0U3b1JwMU1IWmZVeGJCTEVV?=
 =?utf-8?B?L01zREhCOTZXYWVndkhIMVBVbFd4OTB5am15a2JISCtVSXgrV3ovZm5IamV5?=
 =?utf-8?B?TUVpT1pGbkdiMUdiNzFQb01SR2tlWkxZZVExS1l1R0E4NzNFai9nTzFiVnBw?=
 =?utf-8?B?RUF3SGhMQ2ptdmd3UWdUajlHTXBqdVRDcllicStBb0FsRTQ4cmJPK0psMzRa?=
 =?utf-8?B?THI3V3p3MDd3K2JvN3p4K2FnWDRqZ1JkdEN1YjB2ZDJFNm5GZC9wcm05Vkh6?=
 =?utf-8?B?dHU2TS9oK0hNTDFoSFNnWGFpSHZUTnVkVlhqZHZMb3Y5RkFNcUpCbnpMS3ZP?=
 =?utf-8?B?NTBMUjJvMXNhTXIxYjFRbStiZVNveVQwYnc0U0pqYmVzWEdPVTk2RW5LZWZY?=
 =?utf-8?B?dXR4SEFkaTQwbkNIQ0krYlZzaXJSSGtPa3RvQTVXU1hodVhzTnBJb3N0WGxp?=
 =?utf-8?B?QVhQWHd3ZmxVMVNvUCtVa3ZlVk51YzlEYVdTdU5qL3FsOVVjMjBFS1lUNXQw?=
 =?utf-8?B?ZjEzalU5bSt5dW1BcGJKTW14UjhWdktrVVJ4dlM2eWszS2FpNkhhN001cU1Z?=
 =?utf-8?B?MmxTbWM2YVJ1Y1NkZDVoZGlCYWFFaUd0OUhJbm1SV24rdTMxUE9vT3JsSGhE?=
 =?utf-8?B?aUN0ZlZqSFlzS2NhUmxTZ2diMzNJakVhNm8yc1o1TDFOd3lXYVJTaHBkWnhW?=
 =?utf-8?B?SkR1eDNlRUx5N0lObFMwYXVqakxXNEJkYWVyNHRoelhmZXpaazV4V0UrTS9z?=
 =?utf-8?B?RUJoOExCZUxkQ2FUMEROOVJjY2hPaEM1NmJiNkFhOEZRL1J1YlNJQmQ1Vkt0?=
 =?utf-8?B?SGlXZmFrc1RyNWlGWG1nb29XcGgvL1NFV2ZyejhsNEhrQ3UzVWtyQVA0dklW?=
 =?utf-8?B?R2I3VUQ0bkRmbEFidXdqRjR3TVRjMnp3VWxsQ2RyZzBYdUI0S1Q1YUQ3NUJj?=
 =?utf-8?B?OU5DZUp2eDEyQU42dkJCeHlYK1NzcVhZck40TXZZazMxK1VvcExGZkFuOTNV?=
 =?utf-8?Q?NsnrvnbMpnbCUht6WgWAV1bI55uZ4c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUk1NzlDdU1sWWRKSDVhWHBNS2o2QkFHUnluTStLanpZQnBJUnJQQWE3L3dP?=
 =?utf-8?B?YUJpblo1ZXIrUHpUZ3dkV3k0NkZROEM2UmZyR0hmdmY5dndXOHhqcGRZWmdL?=
 =?utf-8?B?T0oxdSt4UUNVMFpQSnBKUGxrMHM1M2lhVS84eXkvejdaNUFSVDV2MnRyVm9y?=
 =?utf-8?B?YTlNMmVXZm9rRUY4YTU4bE9wSDliWDNTQi9udk1oaEcwemczekRxVlpSZHpV?=
 =?utf-8?B?OForOXd2aFV6WWVBY3pFWFpUeWtuVDhDRXJYWXA2ZzNBYncwZFVCc2VaOVNH?=
 =?utf-8?B?T3ZXMnlJa1NsMkRZbkYxUFFGTUJKRWI2WEZ2Q2dlR0svNXJWcWZLRlBYNkRJ?=
 =?utf-8?B?cG1JTDltTm1QN2NSRHpPOE4zRFoybDAzK3c4bkV1QzdJcFVVTXZJSTROeDZX?=
 =?utf-8?B?cXA0UzA0WGlSZTdTUmVzVW1PVVdJVVU0QjdURWswTXh6N2JBTzJkMWRYZEZk?=
 =?utf-8?B?WUV2Q2J5MlZLU3ZZU3ptdkVsak9wbGVlL1JzU2NyLzZYM0FJZXhDeW1ndnVS?=
 =?utf-8?B?Q0YvNnFhZjd2UkdYUE13NWRQemNnNTFqUEFjZ0tjYnNURDRYeEVuZTVuNWVj?=
 =?utf-8?B?NCtHSnRxS21yby9tNHpVTFpKZTJhZmNVTFFYUW52WG9aYkdCK2NTR3FtMVJ1?=
 =?utf-8?B?K2JUZHRIY29rZHZnRTcwTFJLd3N3eFR2QTcyNEQvU29Gc2NSYnA2akwxQ1Bj?=
 =?utf-8?B?WE1XcnlER00wUDNiRWpwZklwTkRZQzk4OWE5SFpqU3lCNWUrK3NxYmNDam5B?=
 =?utf-8?B?RDZqampvMGZlYm5oSnN5dDRmc0o4Sytpb0RyVGtkQzd1a0pZa2xobXdoZ25B?=
 =?utf-8?B?TG9YditZQUh2VWM2c0dmZHRDS2tVR2tXdFFYL0RJa0pLK3czd1ZCKzRJSmla?=
 =?utf-8?B?eVREQ0xsNWVXMFdTZ2hzNlNrb1IvMVNQcExMVW1tVFJiUFJLMFNRZGxTcVhM?=
 =?utf-8?B?SWppMDk0dGxYdzVSSmVuL0JOTGRVZC9RallkYWN3V0N4V3F3L292NnFqZG15?=
 =?utf-8?B?WXVEVE1oQ2MvNTAwSDBhY0xFZ1ROaW82RjBYdnRjUjhDSFh1MFhIYy9qSGtz?=
 =?utf-8?B?U1I0cUpTcTdxUXJVK0tRdGo3N2RlRE14ZEZWWld5emNUNDlYWEp3Q2JtZDkx?=
 =?utf-8?B?eUtTV3FPVDN0YkRDMldFSjYyQ05NS3pFSzRMVFJKZ3pDRmhoVnZDcEhRcHFz?=
 =?utf-8?B?MFhOZk5weW9VL05maG9STEZzK1U0S0lkVUZlWk9taHpjMEMwQ0ZnZkx1VlJs?=
 =?utf-8?B?WTRlK1RiOWZFWXNTQXFQeUxnUHpkM1RiVjl4V0tqbFFRVjYrY0F0WmVNMVA1?=
 =?utf-8?B?UTFGUUJ6bGV6WFBiZUkvWVowWTZuNDloT1ZuNnFXbkVpSkIyQXdiYzhBK3A4?=
 =?utf-8?B?UGhIR3M4cTU4bTZJMkJWZndDMHErRXRFVC9hVFZrZ0p4RFBQQnNDTGQ4VDZW?=
 =?utf-8?B?TE9SZnF0dVZuNUJVVVdIYytSY1dVT2M4NExRcWs0c0tpem9HTmRmY3YzRzBG?=
 =?utf-8?B?cTNHc0tYUGpyZ2hmZGFjbHI4ZjV4OUJzeEtLSWt2ZUZNOS8vYklrcWx2RUY4?=
 =?utf-8?B?L0xDUHh2SU5kbDZ0SWFIUnh2QXNneUxFMEpIbk5MUWZqbEQ5b1FaRjUxN1ox?=
 =?utf-8?B?M2xkTkltWG9DQW4xa2NmQ0JDZlRxZnZLRjEvd3ZUcWhzcG1ndmVZNTVJVUJr?=
 =?utf-8?B?OVQzS0tHbWFkbzRYbGg1NHNUSko0Z3grY2RMSDRpNkNyVm9LdEdFTWhIeGpF?=
 =?utf-8?B?c1grSVYwREpFTTYybEdzazFlZm5iVnROUmFSRFpsUjQ0ZlE0YStFTzB1clZu?=
 =?utf-8?B?ZStXNjBIcHYwQldvNGY5SkFBWnRJRFlxRWpFMnYrYWpSRHluN3kwdThwd3cz?=
 =?utf-8?B?dTNKb1JzT2cyWlkwTTdwVkV5TFpFM1IrdnRMNktRdVhxSHlaV0Rhd25LWWN6?=
 =?utf-8?B?ZDEyOG9rWXAwT2dtdHhpTWdDY3ZpMDY5b1lUenV3QitwNUUxdEJ6c0FaU1R4?=
 =?utf-8?B?WWY1dW5LQ25aeHJvQXFBVVlPMEZ1MmRIOWRHU3lJc2FoTTdPOU1qZGxqZVhT?=
 =?utf-8?B?NzNuTDRsbXo0U0VsVmkxS2ZRU2dlQjU0R0pOVmNTazlUREJmNDAvY1BlczY0?=
 =?utf-8?Q?54XA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36df3fef-86db-490d-dc28-08ddd9a6fea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 13:49:01.5925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+8HiEVwq0siDMfn5H9n4Mkbbj11xewY9OnS9SeHZ+MPX2zM9EEqKb1Wf9MdKlnxZR2n149pQEheo2m8rocksA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9738

DQoNCj4gRnJvbTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4gU2Vu
dDogMTIgQXVndXN0IDIwMjUgMDc6MDggUE0NCj4gDQo+IElmIHJkbWFfZGV2X2luaXRfbmV0KCkg
aGFzIGFuIGVhcmx5IHJldHVybiBiZWNhdXNlIHRoZSBzdXBwbGllZCBuZXQgaXMgdGhlDQo+IGRl
ZmF1bHQgaW5pdF9uZXQsIHdlIG5lZWQgdG8gY2FsbCByZG1hX25sX25ldF9leGl0KCkgYmVmb3Jl
IHJldHVybmluZy4NCj4NCk5vdCByZWFsbHkuDQpXZSBzdGlsbCBuZWVkIHRvIGNyZWF0ZSB0aGUg
bmV0bGluayBzb2NrZXQgc28gdGhhdCByZG1hIGNvbW1hbmRzIGNhbiBiZSBvcGVyYXRpb25hbCBp
biBpbml0X25ldC4NCg0KSG93ZXZlciwgdGhlcmUgaXMgYSBidWcgaW4gaW5jb3JyZWN0bHkgY2xl
YW5pbmcgdXAgdGhlIGluaXRfbmV0IGR1cmluZyBpYl9jb3JlIGRyaXZlciB1bmxvYWQgZmxvdy4N
Cg0KSSByZXZpZXdlZCBhIGZpeCBpbnRlcm5hbGx5IGZyb20gTWFyayBCbG9jaCBmb3IgaXQuDQpJ
dCBzaG91bGQgYmUgcG9zdGVkIGFueXRpbWUgc29vbiBmcm9tIExlb24ncyBxdWV1ZS4NCg0KTWFy
aywNCkNhbiB5b3UgcGxlYXNlIGNvbW1lbnQgb24gcGxhbiB0byBwb3N0IHRoZSBmaXggdG8gcmRt
YS1yYz8NCg0KIA0KPiBGaXhlczogNGUwZjdiOTA3MDcyICgiUkRNQS9jb3JlOiBJbXBsZW1lbnQg
Y29tcGF0IGRldmljZS9zeXNmcyB0cmVlIGluIG5ldA0KPiBuYW1lc3BhY2UiKQ0KPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtv
bi5idWdnZUBvcmFjbGUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2Rl
dmljZS5jIHwgNCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvZGV2
aWNlLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9kZXZpY2UuYw0KPiBpbmRleCAzMTQ1Y2Iz
NGExZDIwLi5lYzU2NDJlNzBjNWRiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQv
Y29yZS9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9kZXZpY2UuYw0K
PiBAQCAtMTIwMyw4ICsxMjAzLDEwIEBAIHN0YXRpYyBfX25ldF9pbml0IGludCByZG1hX2Rldl9p
bml0X25ldChzdHJ1Y3QgbmV0DQo+ICpuZXQpDQo+ICAJCXJldHVybiByZXQ7DQo+IA0KPiAgCS8q
IE5vIG5lZWQgdG8gY3JlYXRlIGFueSBjb21wYXQgZGV2aWNlcyBpbiBkZWZhdWx0IGluaXRfbmV0
LiAqLw0KPiAtCWlmIChuZXRfZXEobmV0LCAmaW5pdF9uZXQpKQ0KPiArCWlmIChuZXRfZXEobmV0
LCAmaW5pdF9uZXQpKSB7DQo+ICsJCXJkbWFfbmxfbmV0X2V4aXQocm5ldCk7DQo+ICAJCXJldHVy
biAwOw0KPiArCX0NCj4gDQo+ICAJcmV0ID0geGFfYWxsb2MoJnJkbWFfbmV0cywgJnJuZXQtPmlk
LCBybmV0LCB4YV9saW1pdF8zMmIsDQo+IEdGUF9LRVJORUwpOw0KPiAgCWlmIChyZXQpIHsNCj4g
LS0NCj4gMi40My41DQoNCg==

