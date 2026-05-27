Return-Path: <linux-rdma+bounces-21343-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKlBJFaXFmq1ngcAu9opvQ
	(envelope-from <linux-rdma+bounces-21343-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 09:03:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E06F15E0287
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 09:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 822BE3020D55
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 07:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3FE3B7B90;
	Wed, 27 May 2026 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WIcSAzU2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186503B1019;
	Wed, 27 May 2026 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865423; cv=fail; b=FoQhZxxb+LDuxHPiwILIbyzGUDw/QdzFFI+b6gAFIJiR/3+mtItVshhcTMDofNarYFTcF5OUCQqHSYn3gp21XEVCRG0JHPyKApb9nKaxwFb+mj5z97R9i6j08yK50J9xQKbA8V5H2OkE8BgCH5jgr8ASy0tXdmFAWWoGbDazvec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865423; c=relaxed/simple;
	bh=nQ/GRC6zcurvvowAgnnifiNarTuBifV42fJfTWUb0II=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sm7XAEghKfj90L4OKO/E7YdqPRc7UKc4TisiL+vqZ8SmITVQNR3KRQ8tjNxF85pgVSQCYqZJIdQcDwny4W4XM6quUQC8Nm4NJyfHl4XXejy7G3Is8e3pB/M3q3g3SG9FHJ4OI3qK2AV0X5JKqsWncxx2y9CK2AUaDVY9oPqLSbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WIcSAzU2; arc=fail smtp.client-ip=52.101.56.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0+h7ImDpV1lQkbFV2PgIo+OSiy4qeZIRvHmvFSLr7bUGiy9hYcElWowMT41N/gxJFpdTdEWNF97j3LaUww8RSw8j4oUvLOEQ+ui2I81XwrrbyDtp1OcJzI0Unrf/NgOVk2Wganoak+W2V9dtxspx4Lh0zE5JcSOHI5/jCJwdZ34EjztLkzXLbUeaae2xgodhPiBH24cLUjNcMVKyMrzH7UYBe6Bq5IqkmOo+0/YGZmMU4odlmOPoMFq1mMq3bRF9R+V0up/zhIs0vrAbzG/gbYPyVLmZf0SYZvE0r4xbdI7HPMvuWXQdPvKXvaBhDPpNnmZ/kvpaivKnNIqXn2Gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0mfx2oUZ2I+yZxcIYdHAHCQv4aAh3dlUb4+fdcqQNs=;
 b=Ks3v4xRR9uIMW4Ep3x06F34PGheHo5o4JqQEYtV18xVWf5BJe4nmskfsiJFR7rlLLaPgZ2Buf7GP4LEzJmhRh0AE1yS6X3qf9gbEa596bE7Ols9UvLrOyufhjUQ9h3gKOqR+jG+GxjMIJXKxCLg36jpTvSG0PpZtxUt29bTd/xai5YN5qbweKpffjwpO6d1PSvjA41KOtzU4VMqnWwJYgIUBmIt8XM521XlCI0bMtx0QwoQpSFt6MpMWKZmTeP9NLh1s122r8vrn68g9GBAee1/1lS8fC1llh7vEkr9mVukAxNSRArk3QhMmtvdnrkmcGbHdATpVO4GZmhGJ/uns+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0mfx2oUZ2I+yZxcIYdHAHCQv4aAh3dlUb4+fdcqQNs=;
 b=WIcSAzU2uXvCA/U7DINfToTkplOhS0BOh6n7P8MtXHhn472aPIyJxaoRrP0O8C/VPeiBoLrF9KFd0k64L9/dWNLpX5TyAkVhEaGb1HjwrlHqUTURk4wGgQNh1W9lWsb6/4af6MPJ314XwVGMZFHyHGrF45QsxszOUwP9DXMUDzKYwS9q9wb9k1m12qJ6WGUeata03tmpD4MOVZdjhef3T5+ELV1Wj7jJeTTZXoh5iOftPFfP7Nq8a43jmGqomxO5UD9/4h7MvYttpezHjr47+rx650lvml2eiMx2U/fdgjWs9TcvgsD1XRbew3w51cqcRSnJlLpxSSeDRDmyg5N0Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 07:03:36 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 07:03:35 +0000
Message-ID: <b26b9866-440b-45bf-9d2f-7c4d3193c793@nvidia.com>
Date: Wed, 27 May 2026 10:03:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: Apply devlink default eswitch mode
 during init
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Feng Tang
 <feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
 Marco Elver <elver@google.com>, Li RongQing <lirongqing@baidu.com>,
 Eric Biggers <ebiggers@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>
References: <20260521072434.362624-1-tariqt@nvidia.com>
 <20260521072434.362624-4-tariqt@nvidia.com> <ahVPASuh4BZGOfx0@FV6GYCPJ69>
 <8c8df8da-62a9-49e8-84eb-572d54cfeb1f@nvidia.com>
 <ahWm4NXph9gdazV_@FV6GYCPJ69>
 <9aa7c295-35cb-428b-9031-13a2f507ae4b@nvidia.com>
 <ahXF2aQZNOwHdCG_@FV6GYCPJ69>
 <b9105eb7-de56-496e-998f-7c49c660b880@nvidia.com>
 <ahZ9CgIWdjny4N4D@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <ahZ9CgIWdjny4N4D@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: f7494788-3fc0-4cea-d833-08debbbe1214
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|11062099010|5023799004|3023799007|11063799006|4143699003|6133799003|56012099006|7136999003;
X-Microsoft-Antispam-Message-Info:
	CTpU9vz+ZDdrzdbaMOdI3qKMRKkSeSE/Mrit85D2eerStABz94xL2RU71FUIJ9WQ42uCUmYXiigCxOQ8vTxcCbs/Mx1JIT+FcCkiu3J/+8J9aYCU9+lBAK4pZfvO9dUNN2P+XuvyUMH7BFp8YrPywcNoBgH5gvcbE7jGMewJ5S2XgZtQQfJz6fDEmlQvTAhOOTWfAgVr5TYhJPIW/pLuUp8lD1XC8mbzkLduPgOKyEde10QOqN+jcEcBNkoLcIWl8mebJ/PewHcKwEnthGT9ydrTojha/7v9g6rt52qrvdqB1f4b2e6wLC6QKPUBt75CFgUYiZImnUMlfrIH27a9ylWJWxNZbE838uMZHXE/hTM5lMMZkVYNdLxosT8RXJ19OC6xsWI/bCNF6DnWf0js9zW/Y7Fib1mr2dbC4OOdulJaKXkW4qBur0AW54o8Ifh6WmfdXGKzymqYuroLWE0VjcDv0hrBhoT5xPS+aWWjZ2QGp+IE+i34PcvEUnNEaTtu+TA5LiOZLFMnGX2mRDvxevyx7K3LEFq9x4uZMZ637oYIbbNGYNJgEGqJncohcZd3/b96YLlaZWBz7A/54nfwVDkoysMjnaXFAeYHrdQRollj1G55iLaMzVs74yQd9zRN82BCjrA46Yn5lIqIvbh/XOB27v1Zuz9nmdyBwl7X9YziauGZ/yzo6mCkbK3vnEs6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(11062099010)(5023799004)(3023799007)(11063799006)(4143699003)(6133799003)(56012099006)(7136999003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGlwMzF1MTZsWGRPcTFkb0ZxVTlNYW5vS3hyOWtMQ3A0UkxpdWU1ZFFpWGlE?=
 =?utf-8?B?QUx0R2s4M0l2cWZKM2VnWGo4ZU9kdlNvTU0vYjNkbTZUN1ErNjBJOTBLVnlL?=
 =?utf-8?B?MmRxdDAveUNTQTBnQnBORklsa2hwSmdNcy9yb1ZMdkJrVFVPQzR6SHNwVFhj?=
 =?utf-8?B?VS8weGRzMjVsUnRobUwvSDRGL1pqaEtUWHdMVHlxemxyMmlXNDFpWkdaUFIx?=
 =?utf-8?B?T29XZ1VOMUVWMUxUNkJPNHVxSGRDTmttTkV5WHQ0S0Z2emlQaGluQlgrYWFL?=
 =?utf-8?B?Yko2TG9JdVVDUGM3bEVUTlVFSHdlV3RnQ2Q4RzdqNmtrSGxvN1g2ZktmYVBh?=
 =?utf-8?B?ZkV1U2NsazgvSGF0NTd4T2l5Z2l1YTlZeS8vNDhERWxwc1pJeXV5cVpxNHVn?=
 =?utf-8?B?RWpyQ2pKOCtSWVYzc1BCUXp2a2VyRGpTR2tJWWRlbkhRcTBmKzVUejB1QTFH?=
 =?utf-8?B?VFhHMUFjR1pSbmg1ck12NXQ4RWQzQmlRVGFNQWJYbXRsT3RiWkZORUJXRTRh?=
 =?utf-8?B?ODduTXArc1FwWjVabGd4Q1R0N2xsUXcydyszamdSUnF1YW01ZkY3MTFnemMz?=
 =?utf-8?B?WGQrdllTUUtHQnpsbTc0RUNjQU5IaUk3dXVybXNZM3hYQi9mSm5acVRId01O?=
 =?utf-8?B?NUVQbCtPenYwTFFIL25MckpZY0oyb0tIcDNEeEVGTnVSaE5HSHVWNDhyZkRj?=
 =?utf-8?B?cHAyUzlzT1daMVNPQ2tBS0JPamJwSmdMUm92QmpzS0RZMTFMczF2bVVtdTNr?=
 =?utf-8?B?RThyYm15TUxDUjFhZ2IyNmlGRE5XVzdmYng1djd2cDZNWmVkdTFmNlNTTk1G?=
 =?utf-8?B?c093R0R6akw3ZlNmRFkxMWxJSFduQTdhZlZpMDB4Ni9hNnZZYXdhZHlwaGor?=
 =?utf-8?B?R1pad0FtZ3pKTUF2enZqcW5YZWVMVVN3UlJtUGIyQyt4ZndlQmNQK0t5TzF6?=
 =?utf-8?B?NndRRHdVRFl0SzA1Vkh5ODF2alpodnFxaHFuMmJ3eFBJY1gwTzkwOUV2cVJI?=
 =?utf-8?B?K0lISm5IelVOSGorUzNqSGZuVDA5ZVc3cEdnMFVlT1ZCUkZLUHMrN2xkeXFt?=
 =?utf-8?B?amloUVBzRzBVNjY3WHIxb3F5aDR1UjNUdHA4cFFOUVZzSWt4d0ZlaERGQ3NG?=
 =?utf-8?B?TXBCcWdzejJQY1hzdGZkbUlaVDlkUVJrQ3hJZVNWdmYweDM0TkpvN0NwN3BV?=
 =?utf-8?B?TnBCNzFhRzAzb3RXWit6dzVNN3hzRUYrK1h0UytuQ0RPVkpFZWFUbkpaRlNu?=
 =?utf-8?B?UDZFSFJwa3FBbE1haDNPa1RpeUhsdHZNSEtwTGdFWE81dlA0QlZpdWtFMU1W?=
 =?utf-8?B?WnpVVnJ0c1NvMHFZeVk4cnU2SzZhRG54SVhMNU8yQzZaU05XS3lhazVrODFw?=
 =?utf-8?B?b3hWdER2bG1YNHNQanlNYThMVG5HcHZOdWdLRXFsNFc5QVFObU5Fck9xQXhO?=
 =?utf-8?B?anpNQmZITUl4K3FKaEtuMTMxN2hzRUh2bnBGN3JXK1JoWWZqbURMRDBHdmpY?=
 =?utf-8?B?ajFxUTh0aTNGQWJzcE5seG1NWWtESWRZVGpaRXUyeTBHMHA0V2tvbXRvcmM2?=
 =?utf-8?B?VC8vR21PZFdYaXNWZ3dvb2JCT3hYRzVURDN6S3hnMnpPeS9XZjBvalZqTnRl?=
 =?utf-8?B?dnVEVjZKdDI4OU8yZXdxODlmUXpVTlIvREFaQVJydjExUW5iZEJ6dFc5UGFv?=
 =?utf-8?B?ZUdMNTNXcFJ4NGxUZmQvcEh3eTJXOE1iZ3Zqa2V1TFhIRWFJY29QaVZ1dzJB?=
 =?utf-8?B?SzVZa1JzZU9XK29iQWJaa1F5eDVKSHBZcTZmYlJqYmE1Q2dCc09EaVo2aXBk?=
 =?utf-8?B?UzkvSHVPQXYzamZRQ0ozUUVGSWZJQTlvOEVDVWl6K0x4ZGFmSnlaQkJ5MkhV?=
 =?utf-8?B?MVVTWFhKT1hoRC9QSHU1M2VtN2xlQi9pWXFTekxCQWlLb2tyUmJ6YStSKzBJ?=
 =?utf-8?B?aVBRR3BBaWNQK2NteFAyWW43ZEN5UkJ4emxncmE3TmtuMG9mZmlKNnBJNkZa?=
 =?utf-8?B?YmNWUjFWQUU4bkxEOUFhQ2JoUE1BZUIxQzVZbFdTMlFrUFFLdThReW8vSkx1?=
 =?utf-8?B?VnlrWUh1K0g1YVRWOTBkaUZFTW9rbDlzd2E4VWxBd2NjRFVMODZ3ZGhPc1JF?=
 =?utf-8?B?VWdrMXUyU0RtRityNi9iRXNDWnZDYStUT2FMTzJKV0lDeVFNRko0YlRycEow?=
 =?utf-8?B?ancrb2NOa256aHVUZHd4T0grNnFtcjJzOXgydGZpZDV1U212dEsvQUZMY1BZ?=
 =?utf-8?B?LzhOMmpFcUVHakhLZTRtR0JxcXVIZ2RRVHRlblhFTEdWS3lEYjY3d2dMT04r?=
 =?utf-8?B?QXltTGEzdXJ2alRMQitXVXJSNzZBVVRyNzdUaDY0ZWJ5b2hObEgydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7494788-3fc0-4cea-d833-08debbbe1214
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 07:03:35.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuCQXIg1EfSzWTXqJ2bNTlYXxnPGPIuK0Hi8ytEUS1jXdN0xKvJb/nZY6TkbhkMZvlwe6rTwRRu4NkYpcaxL5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	TAGGED_FROM(0.00)[bounces-21343-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: E06F15E0287
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 27/05/2026 8:14, Jiri Pirko wrote:
> Tue, May 26, 2026 at 07:13:46PM +0200, mbloch@nvidia.com wrote:
>>
>>
>> On 26/05/2026 19:23, Jiri Pirko wrote:
>>> Tue, May 26, 2026 at 05:03:57PM +0200, mbloch@nvidia.com wrote:
>>>>
>>>>
>>>> On 26/05/2026 17:07, Jiri Pirko wrote:
>>>>> Tue, May 26, 2026 at 11:44:46AM +0200, mbloch@nvidia.com wrote:
>>>>>>
>>>>>>
>>>>>> On 26/05/2026 10:44, Jiri Pirko wrote:
>>>>>>> Thu, May 21, 2026 at 09:24:34AM +0200, tariqt@nvidia.com wrote:
>>>>>>>> From: Mark Bloch <mbloch@nvidia.com>
>>>>>>>>
>>>>>>>> Apply devlink default eswitch mode for mlx5 devices after successful
>>>>>>>> device initialization while holding the devlink instance lock.
>>>>>>>>
>>>>>>>> At this point the devlink instance is registered and the mlx5 devlink
>>>>>>>> operations are available, so the default eswitch mode can be applied to
>>>>>>>> the matching PCI devlink handle.
>>>>>>>>
>>>>>>>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>>>>>>>> Reviewed-by: Shay Drori <shayd@nvidia.com>
>>>>>>>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>>>>>>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>>>>>>> ---
>>>>>>>> drivers/net/ethernet/mellanox/mlx5/core/main.c | 17 +++++++++++++++++
>>>>>>>> 1 file changed, 17 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>>>> index 0c6e4efe38c8..4528097f3d84 100644
>>>>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>>>> @@ -1391,6 +1391,21 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>>>>>>>> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>>>>>>>> }
>>>>>>>>
>>>>>>>> +static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>>>>>>>> +{
>>>>>>>> +	struct devlink *devlink = priv_to_devlink(dev);
>>>>>>>> +	int err;
>>>>>>>> +
>>>>>>>> +	if (!MLX5_ESWITCH_MANAGER(dev))
>>>>>>>> +		return;
>>>>>>>> +
>>>>>>>> +	devl_assert_locked(devlink);
>>>>>>>> +	err = devl_apply_default_esw_mode(devlink);
>>>>>>>> +	if (err)
>>>>>>>> +		mlx5_core_warn(dev, "Couldn't apply default eswitch mode, err %d\n",
>>>>>>>> +			       err);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>>>>>> {
>>>>>>>> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>>>>>>>> @@ -1437,6 +1452,7 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>>>>>> 		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
>>>>>>>>
>>>>>>>> 	mutex_unlock(&dev->intf_state_mutex);
>>>>>>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>>>>>>
>>>>>>> I wonder how we can make this work for all. I mean, other driver would
>>>>>>> silently ignore this command like arg, right? Any idea how to make all
>>>>>>> drivers follow the arg from very beginning?
>>>>>>>
>>>>>>
>>>>>> I have a follow-up series that adds the call to all drivers which support
>>>>>> setting eswitch mode. When going over the other drivers, what I found is
>>>>>> that the right point to apply the default is driver specific, drivers
>>>>>> I have patch for:
>>>>>>
>>>>>> 46e16c6d9836 net: Apply devlink esw mode defaults
>>>>>> ab4f54102ba9 bnxt_en: Apply devlink default eswitch mode during init
>>>>>> b48cce1607bb liquidio: Apply devlink default eswitch mode during init
>>>>>> 4ea54b0fe04a ice: Apply devlink default eswitch mode during init
>>>>>> b7faddaa1c90 octeontx2-af: Apply devlink default eswitch mode during init
>>>>>> 74b0c22c47b9 octeontx2-pf: Apply devlink default eswitch mode during init
>>>>>> 5000e4c3d768 nfp: Apply devlink default eswitch mode during init
>>>>>> 97a218e95e41 netdevsim: Apply devlink default eswitch mode during init
>>>>>>
>>>>>> I don't think doing this generically from devlink is realistic. devlink
>>>>>> doesn't really know when a given driver is ready to change eswitch mode.
>>>>>> Some drivers need SR-IOV state, representor setup, or other init pieces to
>>>>>> be ready first, and the locking is not identical across drivers either.
>>>>>
>>>>>
>>>>> Low hanging fruit would be just to call ops->eswitch_mode_set at the end
>>>>> of register. Multiple reasons:
>>>>>
>>>>> 1) end of devl_register is exactly the point userspace is free to issue
>>>>>    the eswitch mode set. Driver should be ready to handle it.
>>>>> 2) all drivers would transparently get this functionality, without
>>>>>    actually knowing this kernel command line arg ever existed, without
>>>>>    odd wiring call of related exported function. I prefer that stongly.
>>>>> 3) you should add a there warning for the case this arg is passed yet
>>>>>    the driver does not implement eswitch_mode_set. User should
>>>>>    get a feedback like this, not silent ignore.
>>>>>
>>>>> The only loose end is see it the void return of devl_register().
>>>>> Multiple ways to handle the possibly failed eswitch_mode_set(). I would
>>>>> probably just go for pr_warn, seems to be the most correct.
>>>>>
>>>>> Make sense?
>>>>
>>>> I see the point, but I don't think devl_register() (at least not the only place)
>>>> is the right place.
>>>>
>>>> There is a small but important difference between userspace doing
>>>> "devlink eswitch set" after register is done, and devlink core calling
>>>> eswitch_mode_set() from inside the register flow.
>>>>
>>>> Some drivers call devlink_register() while holding the device lock.
>>>> liquidio is one example. If devlink core calls ops->eswitch_mode_set() from
>>>> there, we may start the full eswitch mode change while holding that lock.
>>>> That mode change can create representors, register netdevs, take rtnl,
>>>> allocate resources, etc. I don't think we want this to become an implicit
>>>> side effect of devlink registration.
>>>
>>> I believe your AI may untagle liquidio locking :)
>>
>> I didn't try to solve that one with ai. Most drivers were fairly simple 
>> so I didn't use ai at all. bnxt was the one where I needed a bit of help :)
>>
>>>
>>>
>>>>
>>>> For mlx5, the placement after intf_state_mutex is also intentional:
>>>>
>>>> mutex_unlock(&dev->intf_state_mutex);
>>>> mlx5_devl_apply_default_esw_mode(dev);
>>>>
>>>> We can't call it while holding intf_state_mutex because the mode set path
>>>> takes it internally, and switchdev mode may also create IB representors.
>>>>
>>>> Also, devl_register() only covers the first registration. The mlx5 call in
>>>> mlx5_load_one_devl_locked() is for reload/fw reset recovery kind of flows.
>>>> In those flows devlink is already registered, so devl_register() is not
>>>> called again, but the driver state was rebuilt and we may need to apply the
>>>> default again.
>>>
>>> Call it from reload too, right?
>>
>> Yes, that was my first thought: apply it from devl_register() for the first
>> registration and from devlink_reload() after a successful DRIVER_REINIT.
>>
>> That covers the clean devlink reload path but....(see bellow)
>>
>>>
>>>
>>>>
>>>> Same for reload, fw reset and pci recovery in general. If the driver tears
>>>> down and rebuilds eswitch related state, the place to apply the default is
>>>> in that driver's reinit flow, not in devl_register().
>>>>
>>>> When I went over the other drivers, the right place was not always the same
>>>> as devlink registration. I'm not an expert in any of them, so I hope I got
>>>> the details right, but for example octeontx2 AF needs sr-iov and the
>>>> representor switch state to be initialized first. nfp can do it after
>>>> app/vNIC init while the devlink lock is already held. liquidio should do it
>>>> only after dropping the PCI device lock.
>>>
>>> Idk, perhaps do it from devlink_post_register_work of some kind? That
>>> would allow you to have the same locking ordering as a userspace cal
>> l.
>>
>> I thought about a workqueue too, it was actually my first idea.
>>
>> The problem is that then we race with userspace. In the mlx5 version here the
>> default is applied while the devlink lock is still held, before userspace can
>> come in and issue its own eswitch set. If we defer it to post-register work,
>> the devlink instance is already visible and userspace can get there first
>> and then we might change the user configuration.
> 
> Figure that out and expose to user by setting xa_mark only after the
> work is done? This is doable.

I agree that if devlink can keep the instance hidden/unavailable until the
post register work is done, that solves the initial userspace race.

The other part is the reinit/recovery case. For that I think devlink core
needs some explicit indication from the driver that the device is now in
reinit. Something like (at least that's the code I had initially, but something
along those lines):

void devl_dev_reinit_begin(struct devlink *devlink);
void devl_dev_reinit_end(struct devlink *devlink);
void devl_dev_reinit_abort(struct devlink *devlink);

The core can then mark the instance as temporarily unavailable/in reinit
between begin/end, and the relevant lookup/dump paths, for example
devlink_get_from_attrs_lock() and devlink_nl_inst_iter_dumpit(), can reject
or skip it while reinit is in progress. devlink_reload() can probably mark
this state by itself around DRIVER_REINIT.

Then mlx5 would look more or less like:
	devl_lock(devlink);
	devl_dev_reinit_begin(devlink);
	ret = mlx5_load_one_devl_locked(dev, recovery);
	if (!ret)
		devl_dev_reinit_end(devlink);
	else
		devl_dev_reinit_abort(devlink);
	devl_unlock(devlink);

This gives devlink core a way to know that the devlink instance is registered,
but should not be used by userspace at the moment. It also allows keeping the
default/config apply logic in devlink instead of adding driver specific calls
to apply it in each init path.

But this still means the generic solution needs some driver help. Drivers need
to register devlink at a point where the post-register default apply is safe,
and full reinit paths need to be marked with this begin/end API.

> 
> 
>>
>> Also, the bigger issue for mlx5 is not only initial registration or devlink
>> reload. Some recovery paths, pci resume, and fw reset flows rebuild the driver
>> state without going through devlink at all. I did not find a clean way for
>> devlink core to infer all those points by itself.
> 
> If you don't obey current configuration for example in pci resume, it is
> bug and you should fix it. All these flows should obey current eswitch
> mode configuration.
> 

I agree that the device should come back according
to the intended high level policy. But I don't think full reinit can be treated
as restoring the whole previous runtime state. There may be user created
steering rules and other objects which the driver cannot keep or replay. Today
full reinit brings the device back to a clean initialized state, and that is
intentional.

So the split I have in mind is:

- full runtime state is not preserved across full reinit;
- high level devlink policy/configuration should be applied when the device is
  initialized again;
- the command line default should not blindly override a later explicit
  userspace eswitch mode selection.

I am not against moving this into devlink core, and I am willing to work on it.

But before I rework the series, I want to make sure we agree on the direction.
As I see it, doing this cleanly needs a devlink state like "registered but
unavailable/in reinit", plus driver annotations for the reinit paths.

If this is not the direction you want, I prefer to know now rather than spend
time on a version that will be rejected anyway.

Mark

> 
>>
>> To handle that from devlink I would still need to add some api for the driver
>> to tell devlink "I just reinitialized, apply the default now". but nce I had
>> that driver call , it felt simpler and clearer to let the driver call
>> the helper directly at the points where it knows eswitch mode is safe.
>>
>> I agree that handling all of this inside devlink would be the better option.
>> I just couldn't make it work in a clean way.
>>
>> Mark
>>
>>>
>>>>
>>>> Mark
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> Also, since this knob is only about eswitch mode, I don't think we need to
>>>>>> touch every devlink driver. Drivers that don't implement eswitch_mode_set()
>>>>>> would just ignore it anyway. The follow-up only wires the default into
>>>>>> drivers that actually support changing eswitch mode.
>>>>>>
>>>>>> Mark
>>>>>>
>>>>>>>
>>>>>>>> 	return 0;
>>>>>>>>
>>>>>>>> err_register:
>>>>>>>> @@ -1538,6 +1554,7 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
>>>>>>>> 		goto err_attach;
>>>>>>>>
>>>>>>>> 	mutex_unlock(&dev->intf_state_mutex);
>>>>>>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>>>>>>> 	return 0;
>>>>>>>>
>>>>>>>> err_attach:
>>>>>>>> -- 
>>>>>>>> 2.44.0
>>>>>>>>
>>>>>>
>>>>
>>


