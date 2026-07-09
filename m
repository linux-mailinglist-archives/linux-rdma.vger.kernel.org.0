Return-Path: <linux-rdma+bounces-22920-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n2GECHc2T2ricAIAu9opvQ
	(envelope-from <linux-rdma+bounces-22920-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 07:49:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F66772CE2C
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 07:49:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=eZSar7fk;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22920-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22920-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E70830A327F
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 05:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723A23AC0E6;
	Thu,  9 Jul 2026 05:45:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ACB3ACA68;
	Thu,  9 Jul 2026 05:45:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575936; cv=fail; b=pBrc96laUHxhSxHDiETEqDkypw9INRWTvAPIhCCa3DcW8Y9S1Vr1eTCFBHCcjBcG/1p9KRGDaYranm9VieJTblz/BYQHNFRHb+9QAgrO9sIgB3aW5aOAQ4A+4NcSo/ksspZQa/s/JfI1jfdJdT4VTW3sso7FuXsy657uo1qugpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575936; c=relaxed/simple;
	bh=+7pR7JJURI8FRyeIxUMek0qeqbaWNg/v5vMPy8eJrU0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e64GRUdkG/G1M2fIRcuNRbanivAQzQeA1drxKsmc3s41JXckOZkTBWA/CyyT4+DFvtq2/Us62odGjKsxh39tLnckHBVdZFEmd6HHcZDk2VpTWj737derAmX1S5s9O/jDPOAa5/zx7SvouJ0d06ScL1ewBI8bl95nb8+cF55oVpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eZSar7fk; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4LPK90+QZakbcNzcfFGHJ8L4/1MPBiLUMFpjxlBChEJj7VREM+bKKlNFOUjU71qj/kdByfObN5NWWMUoeR9gwZh9O0BWqRDnypXrYQaHYje1ta/DjT8gnSbgCR5uAswatATgsszZAW5yo6LGpnCv/akSFdBduhZqbTyaKsIrD+wGKOk18al9VvinPiOjhqtCgkSMZ+Jm2nnsicfEtT9R6rEzQUQqYGPhXtHu2YnqxbOWTutlpkKeeWQrdrSNTLK5u95i9uW9+vNRMQtGhJQSPv7FfSl0l/deV70nDoSRqUvzfLxWL+/eobWiDE6PSwlQceGR4mRz7NFyTh1fwbfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQOu0Jy0880pugTKI/YnhW3qx+N0oK30hZLV2dcoS0E=;
 b=mDCy3PBql804ZI0v8Vk2s7zWmGa/DkZF0GxE/Ax9QJSKxP6egFoKSH7DLn4/l0jhBskEgvOXVe63UIIRdp5+JQqwhbQkAc4sVU3/d9IxIzofLhCSoRuLK1xuvh+awELPObmCnwaTuWiQiYbd9B268nl545E3HgFYJYFg4WpnHwqRoxq+bOajVizven/fOlJ42Dd7161YiAZtWhdPo8b58N6RVbKYMR9h98v+kR8ml+8aziX8bRYripdxVjYaj1wq/xwbGPvTCnNPEEszF5/+7XOGYJ2hw+2vItxT5gPUhVQp0C7d6qLmEE6K5NGoL2NRI9uXGYcfZrtBMnOVBKrgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQOu0Jy0880pugTKI/YnhW3qx+N0oK30hZLV2dcoS0E=;
 b=eZSar7fk4tEHVKfLZHbFh4CffZpX0JLgudeCot54VKFSXrMi49ORYeDjP57Y+bTcwllpTkJ6JFDNrxY624rWzty4Nf5uEWqXk3MRXUfAcMgo0Bi+94il2fTrtWUTMtn8gf2jURhsRNKTfdNOSF0/Em8lmGgAD/3E51mJqNFF+psO/cipAZKjAZ7qGodoHGrri3uAF3PJyelAJVF90adqgbZFh2aw2Ddz4zWcB6qKw0VA+hmrZl/2rPxq8MmEMBE68vmiUtvA4qRVrm0TfvRIfX25YuVjp5iL8kNRNozVbBkNyewlGmCty3UXYmQDyt/FS8rLG63xVh1A+MsEiFWshg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:45:28 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:45:28 +0000
Message-ID: <e9445ff1-87b5-4111-8264-74016634d3bb@nvidia.com>
Date: Thu, 9 Jul 2026 08:45:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5 4/6] devlink: Apply eswitch mode boot defaults
To: Jiri Pirko <jiri@resnulli.us>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260707174527.425134-1-mbloch@nvidia.com>
 <20260707174527.425134-5-mbloch@nvidia.com> <ak4Muihtk40r3lfV@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <ak4Muihtk40r3lfV@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::15) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fdda06-b996-4ef3-5bcc-08dedd7d47e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|18092099006|18002099003|22082099003|56012099006|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	lkL7XhOLZKb1mKdMXckWjqO2yt0ZWHObQP4qfJvYs7prp7govH2/OLbspWGX6viUrlWXqEblTAbkQnbLmT6LfgvQGV2zdqYrBWscvOh4DZwfPtow1yYrWFB6jHrg2+J8AAfTfR3dnyE0Mqtylzjc1I1tCB3cqeFwQ37sPr/TxGt4tlucDixf7HKfR5Ml896CJV0vsBkzCC+jhHOvSjZeayWVJB+wyK3bDEB3Bm5PejtFA/mADpL496MO29z0Wg1m2kyaibPY6VvrFmhkILa7hiC7eE2tpffntocI062a4OdfOr6h83OM4qpC5u1tw6U15X2Pwa0ur7Q14TOO15PVMWQ06skZCzTrzU/uam+3gBz/k2taZQGxFpR6lnrEkoDK89SCRqpiaFYNDG3PhcMW+iNUfLMDK3muUlRjqfUndYHByGttt78Tvv2UbNMb4t/mDOd3HvgipKXX7gTCevM4axDofunLj+g1QZupkYJWihwH6Yhiinvhh0qpYIUflL5KzOKICD91sRvJ7CouWv2aPkUj2aSKg+01RP/CPo+nTTo8w9aVy9HKf01E1sBlWKf5Z+nyU4zEN45dL8EjwNrJh/GquXsp3p/DnuIxXyxzV4E62LyYLUSOTnGZcBClMAeuGRASiRtsRt1C6Djz20SqA4ntDgaA3qbsnWc3KOFYWsc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18092099006)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ujd3Y3dEa2tKK25rUVVuZ2F4L3J6NEJYYnU0b2NSSHg4cXdJc0hhUmJwRGgw?=
 =?utf-8?B?d1F0aXZuVWhXZmd3VC90WEp0QkJHUHhOT1NHMFpCSDBTTEtNM0R5dnp2K2Jh?=
 =?utf-8?B?T09tMFFoVXgvS1hzbXZHVUwvclZhMVdqRjIzNDBVM2NkUExaTWMxU2I5V2ox?=
 =?utf-8?B?OVhZUm1WTjJ6ZmhPblVHOVB0Z2g5VWVPeGFES2xOQmVLVTIwUnZGSnBlZXJi?=
 =?utf-8?B?VmNkR2RTMWlGR2ZReWRvblVSVWE0S3Y4RnhQWGxDTmxHOXF1d0xuM2ZHZUha?=
 =?utf-8?B?dVJBdTkvSnFHOVM2cjlDOG93TlpTZFBjR3MybmNCMjNaZ3dqSTlPZFZpbks2?=
 =?utf-8?B?UDJwQUJWcm9QanRsVzlBYzdaNEROT2dSamNwcnlESEk0a0JxeGFTdHFmSWMx?=
 =?utf-8?B?ZDV5SVZkbUU1dnV3bGhwODUwdGtwWTNkakFGRGFtWUltQWdvb01Ud09BZjNt?=
 =?utf-8?B?K3l6Z2JDVXRZWFFCcGdqTzV5TU1HRjNDOWdYRzdtUUZZQytyMEk5Y3doNmZX?=
 =?utf-8?B?OXd6TmRhQk9KRDh3K3JtUUpDbXgwYkRja0xVU053MkxuR0tGeDBqZDJTSUo4?=
 =?utf-8?B?TTlHVlM0b3FPa1R6WmNQS2RLUmNabkZSWXZhTEtnenRHYmV5U2RIdDBJL2FJ?=
 =?utf-8?B?TmhXVjN5UXdiaVlsbFNlNmVOanNJcUsxcDNrUUpKY05kM2R1OWx3RGd1T1FB?=
 =?utf-8?B?RFdzRWpmdlJGU3JSeHNPNjF5UlE0dVN5S3F4Z001ekRqTHUyOWRtbCtXNmZt?=
 =?utf-8?B?UVhoU2Z0b0VxUkQyZU9GUUJaVVBLQ09XbTZLNUh6bVQ4YkJFaDhPWEhrTnhC?=
 =?utf-8?B?UG0yeVR2Z1lBcWtIZU44cXQ0L2k1eUZTcjdUWnhqVmFLQmcwY2ZQVzEvNEpE?=
 =?utf-8?B?R1llRnVoMUpXa3UwZEpWMDZTUnlldnoyM0VPYmgwT3VVYWpDSUdsSjZQanVz?=
 =?utf-8?B?eG1kRlN6dzVUd2ZxcjlYZWlOeHQra1BSM0pxQy9XRUc0czFhZ3VROUlMeWVm?=
 =?utf-8?B?OXhxZk5LUDZHYStIUGluZHJUVHRHZWRxb0tDVG1ZWVQ4OS9UWE9VT1hHWFI3?=
 =?utf-8?B?TjlWc01Ha3QySUZDdmlKTVJWUFNHUEhOMTJVekVaVUdzR3JCWDBXZlBHaHRY?=
 =?utf-8?B?RC9jVXl4clAwMGJIMzV1RWJrRjZHajZZSStYYWphelZGK3pnTnlwRWRUOHJu?=
 =?utf-8?B?TlAwbTdzVkZVNEkxb1RVOHhsQWlIVFpZUytFSHhMWE5XZFJteWMvbXMwUFdj?=
 =?utf-8?B?SGV0NjhTa1Z4bnFrc1htSkpnY0IwTXp3bm1XNzd2L0tvUEVueGpXR3czN0p4?=
 =?utf-8?B?Y2xMVzdQNTd5NlhVVkVTeWs1WjN1QVZ2aFFMK0VwaXdXTDJzQkU3c05rMTAv?=
 =?utf-8?B?RUN3dVAyL3o4U0J5MjN4WkJ4RkpQVkQrTVRDWnBlOFVqQ0ZwOWplenAyMzI1?=
 =?utf-8?B?SHM2R1NFcTI3MC8wSWpRbTFoWnAxSmNJamI1YnF5V2J5RnpacFN0eWZSZ1hj?=
 =?utf-8?B?WHdjUGpkd2RPWnNiUk5uamtlejBqV3NMUmkxSkoyY1NEMTdvZEpSREpoWnFI?=
 =?utf-8?B?dm0wSktVZWkzT2FRbXl2UVRBdUlVNVdSSTJ5YkwxOUFSRWZJMmt2Z1RvQk5i?=
 =?utf-8?B?ZVR4M1Q5OTBPQ1R1cytlekZ3QVRyWnVpcmlJai9yQWR1U2M5SnFIL3hzSHJr?=
 =?utf-8?B?ZmFlOVpOa3p6TTBqRlJvUVFPektmQUZHSElSWEdSWVpISWpZbkZLVW9pdGhl?=
 =?utf-8?B?Si95bEloK1pLbFlEYlFoTncweGNUVlBLUkFsYnJhUFVrWnpiK3NaeFZsenVn?=
 =?utf-8?B?QVdkbGZoUkNDbEZvS1RkL3FwMUlSaCswYjd5L0VKVWxKMlV4aTJ1RHBJOTRx?=
 =?utf-8?B?ZFVtVm1OMGZQbVZBUXJxY3hKdTlGR3BZc2s2MDFEN3lXclRXa1VMOG9ITys3?=
 =?utf-8?B?c3ZWYklNOXNtQTNMeU9JSjRvL1hVMldrMC9qdFdpK015MTQrZktHZjM5Sy9I?=
 =?utf-8?B?YlhkN083TEtKZENUT3NLVGFtY2tiYUNDM3cxRTM3Tm4zaEp0VjJXUTVUWUlI?=
 =?utf-8?B?N2huUng0bVlISlBHZEQzNHlIaVZOYjRIY0pFS3R3L09MODdOam1neVlYS1dz?=
 =?utf-8?B?QllaU1NYYUczTmduT0Q0VXNZYlJVUDlnNHZZaXo3R0dRWGR5a3V1Z2c2MU0y?=
 =?utf-8?B?a2cyUG5qUnFPVVpNblI3YldZWUllcXpCek5DdndOVGVoSk9nTktkS2FpV3pQ?=
 =?utf-8?B?ekVQQ3NZSWhtYmxBKzNrNHk1TUdkcEVsNHgzOVhpZmozMXhDNDN1VHZlSmdk?=
 =?utf-8?B?d1FFM3JUYU96dVlRcE54RWtjYjFOcFJQem00UmFQbDZsUVNUUUs1dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fdda06-b996-4ef3-5bcc-08dedd7d47e4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:45:28.2065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Os1i5iEIcYrcDZn7i/cqL5mkEetA0J2w4BonDuxkX+ACx7DHXApY9x/Fk6z9VzqKoIjusjXRBSk63hSXtMHYKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22920-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F66772CE2C



On 08/07/2026 11:59, Jiri Pirko wrote:
> Tue, Jul 07, 2026 at 07:45:25PM +0200, mbloch@nvidia.com wrote:
>> Apply parsed devlink_eswitch_mode= defaults after devlink registration
>> and after successful reload.
>>
>> devl_register() may still be called before the device is ready for an
>> eswitch mode change. Keep the registration path passive and let the
>> regular devl_unlock() path queue the async apply work once the instance
>> is registered and the default is still pending.
>>
>> The queueing path runs while the devlink instance lock is held, so the
>> queued work gets its devlink reference before the caller drops the lock.
>> The worker then takes the devlink instance lock normally and applies the
>> default only if the instance is still registered and the default is still
>> pending.
> 
> This is very code-descriptive. What's the benefit of that?

The point is that there is still a window before the queued work
runs where the user can explicitly set the eswitch mode. If they 
do, the default will no longer be pending, so the worker will skip
applying it.

I'll reword.

> 
> 
>>
>> For successful reloads that performed DRIVER_REINIT, devlink_reload()
>> already holds the devlink instance lock and the driver has completed
>> reload_up(). Clear pending work and apply the default directly from the
>> reload path instead of queueing work.
>>
>> Preserve the user configured mode when it is set before devlink applies
>> the default.
>>
> 
> [..]
> 
> 
>> +void devlink_default_esw_mode_apply_locked(struct devlink *devlink)
>> +{
>> +	const struct devlink_ops *ops = devlink->ops;
>> +	int err;
>> +
>> +	devl_assert_locked(devlink);
>> +
>> +	if (!devlink_default_esw_mode_match(devlink))
>> +		return;
>> +
>> +	if (!ops->eswitch_mode_set) {
>> +		if (!devlink_default_esw_mode_match_all)
>> +			devl_warn(devlink,
>> +				  "devlink_eswitch_mode= selected this device but eswitch mode setting is not supported\n");
>> +		return;
>> +	}
>> +
>> +	err = devlink_eswitch_mode_set(devlink, devlink_default_esw_mode, NULL);
>> +	if (err)
>> +		devl_warn(devlink,
>> +			  "Couldn't apply default eswitch mode, err %d\n",
>> +			  err);
>> +}
>> +
>> +void devlink_default_esw_mode_queue_apply_work(struct devlink *devlink)
> 
> eswitch/esw - we call it "eswitch" consistently everywhere. Why "esw"
> here?

Ack

> 
> 
> 
>> +{
>> +	devl_assert_locked(devlink);
>> +
>> +	if (!devlink_default_esw_mode_enabled || !devlink_default_esw_mode_wq)
>> +		return;
>> +	if (!devlink->default_esw_mode_apply_pending ||
>> +	    !__devl_is_registered(devlink))
>> +		return;
>> +	if (!devlink_try_get(devlink))
>> +		return;
>> +	if (!queue_work(devlink_default_esw_mode_wq,
>> +			&devlink->default_esw_mode_apply_work))
>> +		devlink_put(devlink);
>> +}
>> +
>> +static void devlink_default_esw_mode_apply_work(struct work_struct *work)
>> +{
>> +	struct devlink *devlink;
>> +
>> +	devlink = container_of(work, struct devlink,
>> +			       default_esw_mode_apply_work);
>> +
> 
> What happens if userspace eswitch mode set happens now? Any userspace
> attempt should cancel the default apply. I don't see such mechanism in
> your patches, did I miss it?

devlink_nl_eswitch_set_doit() calls
devlink_default_esw_mode_apply_pending_clear(), which clears the
pending bit.

So if a user sets the eswitch mode before the queued default
work applies it, the worker will see that the default is no longer
pending and will do nothing

> 
> 
> 
>> +	devl_lock(devlink);
>> +
>> +	if (devl_is_registered(devlink) &&
>> +	    devlink->default_esw_mode_apply_pending) {
>> +		devlink_default_esw_mode_apply_locked(devlink);
>> +		devlink->default_esw_mode_apply_pending = false;
>> +	}
>> +
>> +	devl_unlock(devlink);
>> +	devlink_put(devlink);
>> +}
>> +
>> +void devlink_default_esw_mode_instance_init(struct devlink *devlink)
> 
> Why "_instance_"? Care to drop?

Ack

> 
> 
>> +{
>> +	INIT_WORK(&devlink->default_esw_mode_apply_work,
>> +		  devlink_default_esw_mode_apply_work);
>> +	devlink->default_esw_mode_apply_pending = true;
>> +}
>> +
>> +void devlink_default_esw_mode_apply_pending_clear(struct devlink *devlink)
>> +{
>> +	devl_assert_locked(devlink);
>> +
>> +	devlink->default_esw_mode_apply_pending = false;
>> +}
>> +
>> +void devlink_default_esw_mode_instance_cleanup(struct devlink *devlink)
> 
> Why "_instance_"? Care to drop?

Ack

> 
> 
>> +{
>> +	if (cancel_work_sync(&devlink->default_esw_mode_apply_work))
>> +		devlink_put(devlink);
>> +}
>> +
>> static int __init devlink_default_esw_mode_setup(char *str)
>> {
>> 	devlink_default_esw_mode_param = str;
>> @@ -228,10 +325,21 @@ int __init devlink_default_esw_mode_init(void)
>> 		return err;
>> 	}
>>
>> +	devlink_default_esw_mode_wq = alloc_workqueue("devlink_default_esw_mode",
>> +						      WQ_UNBOUND | WQ_MEM_RECLAIM,
>> +						      0);
>> +	if (!devlink_default_esw_mode_wq) {
>> +		devlink_default_esw_mode_param = NULL;
>> +		devlink_default_esw_mode_nodes_clear();
>> +		pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate workqueue\n");
> 
> Why you don't "return"  here? I think that we don't need to allow the
> case wq is not allocated.

The function returns right after this block. It is not treated
as a valid “workqueue unavailable” mode, the parsed defaults are
cleared, the parameter is ignored, and no default eswitch mode will
be applied.

I kept it as a non critical failure so we do not abort the whole
devlink init just because the default-mode workqueue could not be
allocated.

That said, I can make this more explicit by returning 0 directly
from this error path.

Mark

> 
> 
>> +	}
>> +
>> 	return 0;
>> }
>>
>> void __init devlink_default_esw_mode_cleanup(void)
>> {
>> +	if (devlink_default_esw_mode_wq)
>> +		destroy_workqueue(devlink_default_esw_mode_wq);
>> 	devlink_default_esw_mode_nodes_clear();
>> }
> 
> [..]


