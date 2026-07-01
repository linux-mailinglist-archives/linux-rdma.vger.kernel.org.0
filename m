Return-Path: <linux-rdma+bounces-22650-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X/lyEnIRRWqf6QoAu9opvQ
	(envelope-from <linux-rdma+bounces-22650-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 15:09:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C976EDDCD
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 15:09:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=T4ED8TA7;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22650-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22650-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C6083098478
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F9A48AE0E;
	Wed,  1 Jul 2026 12:57:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502FC481AA0;
	Wed,  1 Jul 2026 12:57:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910658; cv=fail; b=u9OWPStjomRv+6r7ubzt0LWRy5hDbQLDgXt1IwFFj6HVBL0G0UbrLom6bz0u67VmfuHlzPeliXro+cAr0hnqIwPj5Aj8mlS9OoasrwFIey++gOKKQWKPXYBuWT5CnITLlJvbdFIjCeJ/5E4/rw+IhzosVY8hJg3+fZu+WH6FzKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910658; c=relaxed/simple;
	bh=Daa4SUPX7CmSAAa8n4mlHyzD5uiqOwbTSluXsEcNnZo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qZK7wbiihnl3qOF1rGgtswuoWNsIwRYE5XtUgbW2MuqVAg5KdSFEGm0GXVzwioamhxonYGyQ6Ye56zTRPI6NqDx1NQBFfH3xhOwiLhV0JU2G9yklo963IXJz4QBivx4HKZBoR6xQn8dsO8+KcXhG8ePPkcwxtzB9JSNE1V3/B8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T4ED8TA7; arc=fail smtp.client-ip=40.93.198.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbO8Xg2XKhe9zCe6bsYh34josfrSmfLY9hnXNcEi6VhopgrdLRHRlskN0PzljhuEvPyFZhp0SaveM95YwIYEtdflJJIrCvRpZEK0UjKCGsmt210Nwi7TcGdAI0hruA3atwFqYCOrESYXOBGdd9zywrwfLz4x7kyW0XaJ7O29YgRJrsu5tE057tI5iS8UwcDF9X2kOX+pyXQZ3CtlSFk/xX8iih6asYiBjZs8NJ5JoH1FTjXzjzWGq7eKYIh8SaELSc5yUcxBBjOwEOV7h1cQEJi13lxwLwvw7BY2b67k5k7dwwEfb80Yvm7wVitv/3S3/MPtJI6jumHYD+w4Wvz5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCXoGGuT/6DBFClE5vYHNEUFwwnY1aCRlkvAgJs5T/w=;
 b=DTbSvVGyGHCuyMOUl+2hIoIC7E81EfRpk7J5dytbLPSgVoNnvkFh2w52dp0bT5/hgDUiAnFn3trE1grRjoHhZqkwMzrIQqjbkrF6+XjotTO7hpVFDCssfGmsH7tb02zRcRpk+ezPEieI0kQBhkB4UMyIOWw+JEcmLHqKmidAJmpCIalkGpTQAR4RWh5dgk+fRUrJFTG3gnkQiT3R7wx52IFDaYFfMjD4z5DQaU9y9MpfqOQndlQpHFeIqBARtskRCZ/zr/aNSh7VjZpp8lrS253/VRdnYseDVFu1vZPBE4AA9m5Udwwt4q8D9qFe0wSZO6THulETD3uVPph8482Ssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCXoGGuT/6DBFClE5vYHNEUFwwnY1aCRlkvAgJs5T/w=;
 b=T4ED8TA7/vvwijDbaT2slo0Sz5ILSUEjB8c1QDpbBZRAx0KetSnrrOZv+JiCackir19VUKwBLz3sZoUEFK+nhDzTiuMyhM44MNw+nWIVgoXyMSpc2cprhasssFk/9QXU6QzMBqpeeIUn4thtDp2UjlyujRl9H/0oEbn19XFg9+LL9e+meMcZ031JVRTUBTpXxWzjtPK6JuDszJSh/D6/diQQYLyOEPBd88Zw4Ya+Xb0/f6xCqtuDzaO9gVm8aroVT1hu6Q4XL/6uO/ntmV5E+coOSKPT6aHyC22hmZ9KqAu32L2BqOFbNXAlbh84WHTfMvj4GNId+XAEuAWqa2W59w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 12:57:24 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 12:57:24 +0000
Message-ID: <1d4ca929-82b8-4891-9058-1451bf71a660@nvidia.com>
Date: Wed, 1 Jul 2026 15:57:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 4/6] devlink: Apply eswitch mode boot defaults
To: Jiri Pirko <jiri@resnulli.us>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260629182102.245150-1-mbloch@nvidia.com>
 <20260629182102.245150-5-mbloch@nvidia.com> <akThPmvUHvCMT2cp@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <akThPmvUHvCMT2cp@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1c51c2-1d64-4997-e9db-08ded7704be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|3023799007|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7C/zVCi3iN8zBfQKUmfWAAj/TkO3uXn5nRKgEc6pfM4PhTHR+SNYJ04fOqUotwQk1J0nIwct0LJCelwNElKXGMUZFDrX+sMg1fx9mVvdxSF/AIBJtc4lxKe11XaJNICYGNQk9jNhYeQPrnV3lzMgabO31pTI1qS+q+s8u21vg/iTxucwAyEFmZzMa0y5NIv0HUoQaxKMtnhraaJWjTpbZyWm9fi+rYvOAIdP2k6eru76czaxKumwK0106IOupqp0w0x8zieZ38J2jQQOOLQXuO59BGmoD1WvvOyp7TuwePOR2N4GLqjxBJ1U4oZcGXxgijp0cs5BU2mAxSINs8K+bbmu6Q8z+8guEMom2YK2cF8hm0kErTwRns9eZS/ARAcs85eGIOY6vC33ZWOGayTSgvUlwyPeGtrpkTrQqse+cnDJsZ+man34AAEW9he1gDOzuwdUT6eo8zQBmB5VsDsX8g2vhLBnw+C2x53s+MPKYFj9ZE4QYkLADk8fZSluVLeRyLcWfNwZ/+nUH4yu6vmOUzIH7XnkC/uEvrbenqDhKKtovH4ol2nkODscsnVLRo+CjZJFe30CJcnuCqOD33DKzIergST3d1MbJ/p6FIrv7q/vkX1ynYhUR1OsDR7w7CbdZw1f5YHAhCkRizo9Nt6yJdQilbkuWz5fAGsCAQURYEw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG1aVTNaNkpYRUdGYTFzTFBVZ3k3ODkxSTM5Nythc1h4L1lxeStid2ZFV0Nt?=
 =?utf-8?B?OVlEL1A5cyt5N2NzS2EzVXFFOWhlTm1Qcm9JMU5IdUJUVmtlMGowREdoaHA4?=
 =?utf-8?B?T3JCOVRjby9BUlNXQWFCQ1krL3NFZ2p4WnBaQm5oS0Ridml6V0ZVQ1FWY0pQ?=
 =?utf-8?B?VzFlQUZQKzhsNU53bWUwdWl4emUyNHIzb3FUOHM0dkhRYi9aYkk0MkFVSzJR?=
 =?utf-8?B?bTVObzRkM05JRThreTZiY3l2b2lwSGMzM1B0VWxBN1VRb2FBUTRlN3dHZmxj?=
 =?utf-8?B?RkhvQkQ0M21IUmd4V3V2T2dTZ1NRNWpvVlV2SnB6S0cwMk5qZXhJL2ozS0ZT?=
 =?utf-8?B?Ump1OTJoaHNrUlczMjVINVhBakpCMTRnaStBRnRieTNuRnZMNWdnc1BTSUVG?=
 =?utf-8?B?SjBQNVZjSFNQd2tlUEdJek9PNVgxZVNnSjJ4NnZPRFFGclM0Q1hja1pwMmU2?=
 =?utf-8?B?QTdzcTFVSGlnenUyNTN6ZGxwZ3kybTdvYjMwN0ZHTEIyais3Y0JxU3VYV2JM?=
 =?utf-8?B?S3h3ZW5tdHZEYVo3bzRnVFVVWE5RY2F2YVlkeWN2Z3prRnlCUmZoN0dDTGYr?=
 =?utf-8?B?ZE9QTnNKaUpUcEVuY1ZHZEJXb1NHV2NGdUxVbUl5M3ZqTzlaRlVwS1lxaEpZ?=
 =?utf-8?B?ZE9YRW9uS2pXRDNEU0xYLytraVVWaE5KMmNwaGVoeUprZWpzWm5kRFB6ZkFk?=
 =?utf-8?B?QzBic1ZTV1BwYTNQcm95cll3U1plS0ZjOWl3bG80WVNHc3pMVzZHaERscXRI?=
 =?utf-8?B?VlJ2c2gycFdPUUw4enB6Qms5SE0ybjJWL3RiL0JoOWN5NnoxcGRTdzBhWnQ1?=
 =?utf-8?B?NGhSU3M4TmE2REFjSHMzM0tpYjZYNGZPLzhpV0V5RXJUb2JpZktMMTdUOWsv?=
 =?utf-8?B?RzlPcUMzcEVIenU5N0pXNmZBWml6UmNDdVpkYURGVzBHWk52eVdaWGtwak9n?=
 =?utf-8?B?cmFhcE5IY1IwNW5TRWEvdHh6UWhicm5tS1J2alVpTkJLTEZvendwY2thNHZs?=
 =?utf-8?B?cGprOHZabU1jUmMwVVk5cjNvVG9TZUw5OTBnUUxOY1NVL3FvWnJJaEQxTnU3?=
 =?utf-8?B?R3FjTFJ0MmpCUk5JTjNPdTYxUzhOVTVJZ28wU2JYZ3ovN3E0OW5pTlllYVJn?=
 =?utf-8?B?dUpLTGNNSjF0UkY1WkNTNnJRYXdOV09vcUNZYndGeS85ZE9zdEpCVDMxYTBo?=
 =?utf-8?B?NCtTQk1jYmV6MGxUSWNRc2dlR2lpMk42TnRSRjJZT2M2a0pmdjNodEpzaXlE?=
 =?utf-8?B?WWxyQ0xZVERZWmpsRXFmS2dxOFlCb3ozVTNWY1hPRC9uZFgxa3JtR1p6T3Rh?=
 =?utf-8?B?TnFWdFFGd1ZiQzNYK2k1cGZTTmtDeCtTSU11aTc5WTZOMFNUZ2Z2YkpUbnNm?=
 =?utf-8?B?b1UvTTZVSm44N0twaWpjVEthdVZxLzdPMnZhQTBzZVdVbEJUaVhoREtPWWt5?=
 =?utf-8?B?cU5wM05INWZ3SWZuZnUxN3RUY0hhdCt3a2hJdTd3bGJKell0clJsbnhNZGpr?=
 =?utf-8?B?VlIvcmR2NUdETnZmV1VZSzdQTGFEenhkMFdpa3JManE5UVE1YWZkWEdPUVZs?=
 =?utf-8?B?d096THJNemdtY0ZBNUtLSkk5a2E0STZWSXFTK0g2bVRZT1hSNWc0cTdYaWpH?=
 =?utf-8?B?Njg5Z1UrZW1SSGk4TG9OSnF0RWtNVnNmVUJnRzh1TGNLYnhCU0IweXRUUys3?=
 =?utf-8?B?S1h2S25mdEhLbGpHeGhHRnVoaVQ0K2ZDcWpIZUpCVUZ3SWVCNHV6cmY3ZHU5?=
 =?utf-8?B?QWkzcUlISjZPUjliczUzWXcwZy9JRDRUdEhxaWdvNUpxbzJadlRJTFBPMDU2?=
 =?utf-8?B?ZFNvOTFQelVWUHBoQ2EwTkRVSzMzNUI0dlYrQi82UXFNWk1Dd2NiOVVCOTh1?=
 =?utf-8?B?a2JVYmtoNlp1NklPeTlHNkdHK1czaGdJMktvelZGK0dIZ1JYOEg1azhoSkpK?=
 =?utf-8?B?d3RoVEd1Umk4eGdBYkp1M3VLTHJwZ00xdkhqdmhJRWtxSEh0OGRPemZSSVA4?=
 =?utf-8?B?RDZxVk1rNFlGTGhDUmZRMFJNSFJLZ05reXExbXA2YXN4SUo3OVN5MEhMa0Qx?=
 =?utf-8?B?djhmaUZVYkdSc0lMUzM3VEM3YWJSUStnVUlXcXdvZmhQclFVWTlkYjgwZU01?=
 =?utf-8?B?TUYrTUhTVVRLd0hvVWpDRDZIMFJwZnZIMGVIdEJUL3NCdHpTYkthVWZaUTky?=
 =?utf-8?B?dmRVTnovdkE5bWFYNkpjWEphWG95N1JCOERrbFhQT0l2SkR6bjhyVUp5TVFU?=
 =?utf-8?B?TnRyT3dVQlNwakN4Uy9WdjJtOUphc2lVMjltelV3MWN2L1pIbTllcjhmVjAr?=
 =?utf-8?Q?/tBWRcvbzAcTekArqt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1c51c2-1d64-4997-e9db-08ded7704be3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 12:57:24.4267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdrHbGbX5a9l4gmFUSXBNSKnOgvS2MyFSAAwddxsf2zTGtIRk9C0OpYmkjhQtGEKS4r1qiRBgA2B1AOMNtXqAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22650-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4C976EDDCD



On 01/07/2026 12:48, Jiri Pirko wrote:
> Mon, Jun 29, 2026 at 08:20:59PM +0200, mbloch@nvidia.com wrote:
>> Apply parsed devlink_eswitch_mode= defaults after devlink registration
>> and after successful reload.
>>
>> devl_register() may still be called before the device is ready for an
> 
> How so? I would assume that driver calls devl_register only after
> everything is up and running and ready. If not, isn't it a bug?
> 

You would think so :)

Some drivers, mlx5 included, call devl_register() while holding the
devlink instance lock and then finish setting up state before releasing
the lock.

In v3 I tried to enforce exactly that model, move devl_register() to
be the last thing the driver does. Jakub pushed back on making that a
general rule. So in v4 I changed the approach. devl_register() only
schedules the work, and the actual eswitch mode change can run only
after the driver releases the devlink lock.

Mark

> 
>> eswitch mode change, so keep a per-devlink delayed work item and pending
>> flag for the registration path. Registration queues the work, and the
>> worker tries to take the devlink instance lock.
>>
>> If the lock is busy, the worker requeues itself with a delay.
>>
>> For successful reloads that performed DRIVER_REINIT, devlink_reload()
>> already holds the devlink instance lock and the driver has completed
>> reload_up(). Clear pending work and apply the default directly from the
>> reload path instead of queueing work.
>>
>> If a user sets eswitch mode through netlink before the pending
>> registration work runs, clear the pending flag so the queued default does
>> not override that user request. Cancel pending default apply work when
>> freeing the devlink instance.
> 
> These AI generated code descriptive messages are generally not very
> useful :(
> 


