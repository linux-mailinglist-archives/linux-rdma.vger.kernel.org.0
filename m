Return-Path: <linux-rdma+bounces-22750-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wp2kIfL/R2q8iwAAu9opvQ
	(envelope-from <linux-rdma+bounces-22750-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 20:31:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEDC704F1E
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 20:31:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=YBDuVQGp;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22750-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22750-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9530301A1CC
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2026 18:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EADC30E835;
	Fri,  3 Jul 2026 18:27:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891331D5160;
	Fri,  3 Jul 2026 18:27:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103256; cv=fail; b=IrcNhk9HJl7tue5XuRBW6t7fRco0/KeQUrWpf+TINwDNVRy4HKd1aakLiGFsvYN4NgmBioLGLkULU9IzVb4s2N+f4eax+0FfLCvYWic/jLqbdRmDWM6Oh4yTjIWeCtbMERBXwTHxdoYt4hvFshcR1G1s5j+tNKDXUJbacbXfT4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103256; c=relaxed/simple;
	bh=verobwPmUKSK6+Ss1t58v8Vh/jFdQOWlIp3U8bc+7Vg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bs/KQvk9dTD21q4nBJ2sY0oPQq0c0pOFR/KKnY75z7YtheKIDhOM2e8uJWkIKcgK+O8OvTFr49og1dEZKqNNul0ASSzfLCEpcaW/aJ2Zv0mbmSVtpKq8pvSonvNGRitth5joTH+OAgp1M/1LiYsBEWnXxKmfCjCQX0WM7iZJMHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YBDuVQGp; arc=fail smtp.client-ip=52.101.62.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JED6OIAgRPfN+bWZx1xhhDet9JPgbGAyXeghXqmayimlK1lpNGP2nZnpa1ajQBF/djP3eZFnG7ZrtpyJWkYH8mCyVasROS1mIV+ErLRnAqEryfO41ZjuRgCZEBA3pdDOerhlvFwxMXGjl9IC6juY+y2U958J9D8DZEiwFu2d3Jxe1hEJWlUdvcjT1cCH8BegxZvrAgZa0Pb2df7YcnA5c0UCV6iGgsjivvGgxbXKxxVaNImdM3IPO7RzV3MFQ4TPbtrSwKLXZ4hn46NVvlKaEqRztHr9L/xejdPWLUHw86k7P8Db2+kNvN5DiJVF+hVfnhljxfyD646UpZl8KgYgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N96Ja06MtHj3V5C9F/Ltwi8ulyCyEQt17RKtFBBFW80=;
 b=RRjNy0hVpiUhAW3xtt9BSPNzlkmcuQpi6hxgUoEXBEzWyu7Y1hg2ttMdQ/ESQbn8vRWQFuapCunnNR+5Pv38vx6HVN3wsL5imHOsZcX53muzAatZlsm3pOqtzWns01FViJpjCo4bt3bjGwFXNwTSz3QPOCCkQ9XwijuL2pAiuctV2xWOLKQexbqT5gDLlA5UDs2qPU+Eqifv/jada6Vp+uIRlEiOJT8nNHFDpzMkN0HyBfzPSt2Uz9unXwbDByOEhHicIJV1XKzsK8bt+soH97SNaPP0KRflhpgdfnVAmFpXkVK4PZMbNBL0mVrqsNhr4kOzvr/fL7yKjQ1NvjOktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N96Ja06MtHj3V5C9F/Ltwi8ulyCyEQt17RKtFBBFW80=;
 b=YBDuVQGppNOLMOrtqOA5/Kmb7FoUwcKbMDnCwAmuoOZZOsPByYsR7QrlC6nJ3hVUSjA1572SstQxdlEfKgv8jY2XpQhS530UbFEaadKodO8EKmRR5joSfguB08jQMpjcEp//E//iYqRatNffhaf/nHF3TcVSJnNIfuL1qwhGZQ9ImsaBh3ORI6BLVuKgtnnb4yup0iJujwsTO8YXCeBz8EMleruZuJcaAF9emBiJ4YnL3Qxes5h6ihcejY0qzPDd/ebYlZtgyGYojC1atOjk53Qvvwxx3z9fRjFZZJt8EYg1qXd3W7pjOg6i+HDUXlhBYUyeS5xANDcHPp2fzpB9Tw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 18:27:31 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 18:27:31 +0000
Message-ID: <4fa57470-0d4f-43dc-af4d-e66ddb450923@nvidia.com>
Date: Fri, 3 Jul 2026 21:27:28 +0300
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
 <1d4ca929-82b8-4891-9058-1451bf71a660@nvidia.com>
 <akUfXyKioGNAO_iB@FV6GYCPJ69>
 <ecaeeef0-c463-4f10-885a-02ad2d648be0@nvidia.com>
 <akYX4pMrDTnxa6yK@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <akYX4pMrDTnxa6yK@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0272.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::13) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: efd6f0f6-d73a-4779-cafa-08ded930be65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|3023799007|56012099006|4143699003|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	VXIc1Sykzg50xqN403jezvP3+e4Z/W/XkQRys3wWdCZX5QsjC35E/SDh1FfcEzG0c5+0cVVnyAl8cNeaaQ7uyLO0j2FyGzHMI4i5iyhj2aKaHEaQroIgkU+NxH076K/OkFvkHPXuQsxTfwtTKHaoQfMuhGTtPbO4xDEHwlZfvJEpHezrJo6C1mcqjATFBbqIfLyiAHKRFYunr0bIwspYddu9k2zyZKfYFnJWEnFP3YVSk+l7UEzM97wMUSAmFP5D90KS6oTjS3c/XvTFdJww4ib4pf+WG9DKCSA9eDABkacpc0aX908QnXtYTr5+xnH0s/146fLu6V5/Oytp/7TgeNXi+4f1T379hLRBnVJtucevR9P2aVT6UD60yq5mqXmHK4rM9KdGHp3PoFrhg+C00uaE3nvlJvJKOgozQIy19NVv9JIImd37icOO8b4SVHcTR3mtMBA3pFstnodfd2Ei4Yxpg2cLb0bqDyfblFA8asjCps6v4tzvZONw8o0R1L4nc6c1B7VW5Pb+aSVE1BGUa1Qdr9HGqJtbIzM9E5/vHH8vY+Ijh7+UGAzYICt+KslACh4hbOZS8rzQWZBRcfXhL2aAetcfT0yB+OV33lJqH3dHPRctntMiEoRAEyd52qBIViJwvqtDtHIeDkagi3qleemBQZxrfLJAMnw6sE29wvU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(3023799007)(56012099006)(4143699003)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3VxK3JCbDMzUnZLbll1WUIxODFqODJJY0hvQ0NIb3dHZHZIYnc4UExJcGt6?=
 =?utf-8?B?d3o0MTFjMnJCWHQ4V2pSK1RBTUt2Uzd3SlB3YVQvQmJoM0ZIYXhJbWZMZjAy?=
 =?utf-8?B?Q2VlMm0rd0F6aUEzVE83RjdxdXRITEFnQTB6YUlMS3lMckYvL2lBZk9talBK?=
 =?utf-8?B?L1IxSUIzR1VMZExxNmRnNkZ4VUw5Nisrd3NZQk5YalUybTJQek5YK21HL1kx?=
 =?utf-8?B?VHFFUUtWRkw5YlNqK2RVVC9GQ1h1b1ZnQ0t1MEp2WkxYM2U5NDJIWmo1M2gr?=
 =?utf-8?B?bGdkUWFmRkI5TnZkVUtBT25ObzRzd3Z2bkg2UkdPN3Nkajc3RjVqVTdnMmxw?=
 =?utf-8?B?NjBObWhONWw1YWg2Zk5vQm5wNlBjdDBPV2dhdlBvN25qeHQwaTFKZFdmSnQz?=
 =?utf-8?B?WnM2b1RhdjJDdFI1dUhKKzcvMVpINHdGNWRYTFl5c1ZiYm9QT2h5Tm5HQ2J3?=
 =?utf-8?B?M2EyeDlWMTlYem16cXZHWUZ2d1ZvWTIzNkNZa3BHNWlGQkJjdHhFd3cyc3dO?=
 =?utf-8?B?STVFSVltQy9YYmR0bGlnSXozc3R5ME84aHRaRHF6ZC9UL3VZVXFncDBJZ1ZF?=
 =?utf-8?B?eXdncXZvTFRSUm1SRnBjVmtvejA1djZQM2dMbTZqeEZUT1NUb2ZCZDVMdkZK?=
 =?utf-8?B?STZRVzlaeDZDRDh6SUxzMC9zY3E0NFgwbndQUmdrbmR2R3pPa0hObWtBREd0?=
 =?utf-8?B?dDZUL0wwdWEwbFZUYWFBUXRGU3JRMlAvQUVIMzlMay9JeUowSXQyeTJmc2dN?=
 =?utf-8?B?NjNuc0daa2xXZk9wd3J4cEw0NVA0Qm9BdXdPclc5OC9QYmtkMk5iTktyVWlj?=
 =?utf-8?B?dnVOcC9nTkloVkhxMi8zTHJxUmw3SHFITmZWMTVwcDJLbXFydlpOdUJOSmd5?=
 =?utf-8?B?KytQdmkxNmlLVzdpNmZ0b3lkY1drT1BiYXU3cDM3UzFITmlxaE1DUFpld0Nv?=
 =?utf-8?B?SWFnWjUzRnVucU5ZdEh4YlgxS2FYYm1lempTYkxiR2cranJoNGVHczNJTWpU?=
 =?utf-8?B?dENseDB4RXN5dGp0ZTNiOGpBSlhIZUZjNHZxZGZkaC9WQUQwS0xXTGhtMWI2?=
 =?utf-8?B?ZzlFRFd0K2cxUFd5UWNPVVh4RmUrQ0hLOGgwYndTTVo2NitkYkEzTXFZUFdk?=
 =?utf-8?B?M1BJbngwZW5SU28vTWwyNVNFMHZhNlJzdGxXckswYnczVWUvRTFibHBIUVhi?=
 =?utf-8?B?TW5nNXBWU0JTMDRPZVFvWldUdFZQczRUbVVnd0tYWDFpUCtMcFZJbDZ1M2gr?=
 =?utf-8?B?dDA4TE1yQjhPMWRDYzVqbWRsY05xd1ZXQkNCSE4yT0gwaDROQUJSSklhWWNo?=
 =?utf-8?B?NTVIbjdkbjZFZGFWYUk0Z2VPdzgySjVxWC8ySis0R1dtZld2UnNPSnBHa0Jp?=
 =?utf-8?B?NGlSL2NFSDlSS1B3MUZaV2lnME4wdzNVMWxGYUtZNWtIeXk1eHJDdFF5dEw3?=
 =?utf-8?B?SVFmWXVhdG16K2dYSmRvK1g4aHh6V0tYYWVmb2R2UDNjRG5nQzlZMklQYTJu?=
 =?utf-8?B?WU1MaGwxSnljbVNDNjQxNk5hcDRyRnQwdzRkNDVjNGNEMStSK1AwZUIwQ3Zl?=
 =?utf-8?B?MzFpZExsQnhrbkkyODJ5V2hlWHIrejV3VHZZaWtHMjNYUERJTEpJVzNPS1JO?=
 =?utf-8?B?WEU2cU14a05kTnlCMXFkV2xubkZqL25iM2MxNS94V3dsaEVGNDV3TGMrMVdU?=
 =?utf-8?B?Z1ZPWXJIYmxHNW5KeVlBQWJjbWVDTEJZMUFkdHkvMndXM3p2SDhDVFZlN0FG?=
 =?utf-8?B?N0FKNDlIRDd1eWFiaUZMUmlZTVJHSTh4cjdUMm1nRTdqWlRlOVNXMU1sa0Fz?=
 =?utf-8?B?MHZwcUlUTE1wY29IZ1E1cDMwRmI0QnJlYUVzQmdnRzdhWExBVG9KOFJpMkZ6?=
 =?utf-8?B?Tms2KzEwVGdOSlc1RjlLRnkxQWdRcEpjalgxM3BicTdQYmdrR29vNEhkcUNw?=
 =?utf-8?B?elZiSUduWmpVaDVSaE9pSUxzSWcxL2dhYTRGNDJHakR6aldoTnJveGhlM0th?=
 =?utf-8?B?eEFMNG10dUZLZVB4a2hiUkx3K1BDOVZCMmoyY1RiZ1V2dHNDdUQwTWp4QkhD?=
 =?utf-8?B?TENHbDNoSnN3Ym1mbmZINzRTdlI1YkZGRXhHbTZIbFRCaHBqSDJUdUlzbis0?=
 =?utf-8?B?TXVJSHdVeDFtVEJzYjZHbWZVWWpiM1cvWDlCWlZuVWozZEFJbHZteHI0QUpH?=
 =?utf-8?B?SWwyU0NGZ3BSVGxjOVNJb0VwRlBYMnF5VkRhdXY4aUJQV1NPK3VCRlZJenhL?=
 =?utf-8?B?dExJQ0tFMmE3bEZNdTdtSGp0SFNBaCtkcmFYYlREamgrQlFZY0I3QnFyT25O?=
 =?utf-8?B?MVpsS0xiZVptb1cwNGh2NTVsUVFJRDViUmhaR2RIbjBLdjRnNnFKUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd6f0f6-d73a-4779-cafa-08ded930be65
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 18:27:31.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ej2StVvPytg/gzUTLtfwaCiH+N+azvDy/4aGS5nTgssBUWaHk/QRXFNK199nB/xoDydTddHxVQ3UoIeXptvxdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287
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
	TAGGED_FROM(0.00)[bounces-22750-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEEDC704F1E



On 02/07/2026 10:52, Jiri Pirko wrote:
> Wed, Jul 01, 2026 at 07:42:57PM +0200, mbloch@nvidia.com wrote:
>>
>>
>> On 01/07/2026 17:09, Jiri Pirko wrote:
>>> Wed, Jul 01, 2026 at 02:57:21PM +0200, mbloch@nvidia.com wrote:
>>>>
>>>>
>>>> On 01/07/2026 12:48, Jiri Pirko wrote:
>>>>> Mon, Jun 29, 2026 at 08:20:59PM +0200, mbloch@nvidia.com wrote:
>>>>>> Apply parsed devlink_eswitch_mode= defaults after devlink registration
>>>>>> and after successful reload.
>>>>>>
>>>>>> devl_register() may still be called before the device is ready for an
>>>>>
>>>>> How so? I would assume that driver calls devl_register only after
>>>>> everything is up and running and ready. If not, isn't it a bug?
>>>>>
>>>>
>>>> You would think so :)
>>>>
>>>> Some drivers, mlx5 included, call devl_register() while holding the
>>>> devlink instance lock and then finish setting up state before releasing
>>>> the lock.
>>>>
>>>> In v3 I tried to enforce exactly that model, move devl_register() to
>>>> be the last thing the driver does. Jakub pushed back on making that a
>>>> general rule. So in v4 I changed the approach. devl_register() only
>>>> schedules the work, and the actual eswitch mode change can run only
>>>> after the driver releases the devlink lock.
>>>
>>> Wouldn't it make sense to use a completion instead of loop-reschedule of
>>> delayed work?
>>
>> Just to make sure I understand the suggestion, this would mean that the
>> work waits until the devlink lock holder drops the lock, and devl_unlock()
>> would signal it, something like:
>>
>> void devl_unlock(struct devlink *devlink)
>> {
>> 	ool complete_apply = devlink->default_esw_mode_apply_pending;
>>
>> 	mutex_unlock(&devlink->lock);
>>
>> 	if (complete_apply)
>> 		complete(&devlink->default_esw_mode_apply_ready);
>> }
>>
>> That would avoid the retry loop, but it also means the queued work 
>> sleeps until the driver drops devl_lock. It does keep one worker
>> blocked per pending instance and adds this default-esw-mode signalling to
>> the generic devl_unlock() path.
>>
>> The delayed retry was meant to avoid a sleeping worker and keep the
>> instances independent. If one devlink instance is still locked, we just
>> try it again later while other instances can progress.
>>
>> If you prefer the completion approach I can switch to it, but I don't see
>> it as simpler overall.
> 
> Yeah, I don't have preference. I was just wondering. Feel free to leave
> it as is.
> 
> Maybe, instead of "complete", you can schedule with "0" delay in
> devl_unlock? Well, it does not really need to be delayed work, right?
> The only single schedule may be done from devl_unlock. That would help
> to eliminate the rescheduling. Am I missing something?

Yeah, that can work.

The only part I don't really like is adding default-esw-mode specific
logic to devl_unlock(). But if you are fine with that, I can switch to
this approach.

There is still a small race between mutex_unlock() and queue_work(), where
someone else can take devl_lock() first. So the worker may still wait on
the lock, but the window should be small and we get rid of the delayed
retry loop.

Mark

> 
> 
>>
>> Mark
>>
>>>
>>>>
>>>> Mark
>>>>
>>>>>
>>>>>> eswitch mode change, so keep a per-devlink delayed work item and pending
>>>>>> flag for the registration path. Registration queues the work, and the
>>>>>> worker tries to take the devlink instance lock.
>>>>>>
>>>>>> If the lock is busy, the worker requeues itself with a delay.
>>>>>>
>>>>>> For successful reloads that performed DRIVER_REINIT, devlink_reload()
>>>>>> already holds the devlink instance lock and the driver has completed
>>>>>> reload_up(). Clear pending work and apply the default directly from the
>>>>>> reload path instead of queueing work.
>>>>>>
>>>>>> If a user sets eswitch mode through netlink before the pending
>>>>>> registration work runs, clear the pending flag so the queued default does
>>>>>> not override that user request. Cancel pending default apply work when
>>>>>> freeing the devlink instance.
>>>>>
>>>>> These AI generated code descriptive messages are generally not very
>>>>> useful :(
>>>>>
>>>>
>>


