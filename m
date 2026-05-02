Return-Path: <linux-rdma+bounces-19862-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGlhCflY9mn2UAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19862-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 22:05:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E114B35A7
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 22:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85A18300D97E
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 20:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A54A3859DE;
	Sat,  2 May 2026 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZGnaRDTs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C1D1B86C7;
	Sat,  2 May 2026 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752307; cv=fail; b=lE0lNZvmAS4Pxv7ADa+udqkIl+7Y/Tw8VopBLt5EEZYCA4sAnMT5EE48inFDn1GJJMiOoWe8MNM+hYpvP8QxCbledK13cNBmSR1eY36J6mcxZtRhFVQJyid/hHDWQ8WxfGMcnXsHiurznnpFtTbzMpFFvWNSPVrxgKs7vw2ZfA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752307; c=relaxed/simple;
	bh=zBJfcir8HYCIyT4HpjBStNX44Y3V05tqD1+GO//gXM0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PXaYQScVnvma+0lhckAY/QARUThFQT+9/Xx1CWYF02a10L9XZiqZhSRb/nUXkJ8nZyiC1RVVeGssVqFu36jH6LqpbHrt0RG5wHzsLw3BzXkvyyRZO9cn1G6+ihJAtwaxRDbuunOc7mC+YiMZWk43oRV64n4375+B/qwuSIear2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZGnaRDTs; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnzreWAVlR6RtHsnw9HHwX9lol1BMJ3yIgNd7vDyPk/+Ahc84P5L/8zF4EWp/NFJr5n/fZaUdOdNGlMxx4A3HdU6HZLhi+ZtBK5tLy+BUKoT9v3N+uRvRT5jKqHoJpwA/FZei9poicyuD+oi/3VLFMhmPE1HydUyrz2Io7Ox5ev2+Pe+af68g/2R+t4urTPp4M0ynn0iDKrzHvIXrNsbxePSyhZCXS1r/GQn2ConTEhcqbvy/6j4HPOEzmvhVflJR4UMZD1HOmyAmQ0hXzEDs/Ui89jyVk/4+zlDIzdvuiiCbHL/BA/DyhVh6es+5/Rc7fr9YP9TFY2I9W4/6KyRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scgw2iQyDVMTgq5XBOB2k+PB1YOXTX7uktWcx3fY+Rc=;
 b=VmLwn/+CzdqlMZRyOZ5+1fmrzSej1IrcGmrbfi2Mc2624QIMietGT1OcG4OpbHGMD1IsHuQdfRilfm+56kqsI/PjHJXZZc4Y3zddxZT7UNJCRCZu4k86GqjtuGpdGIoeBGQXBIWuJNe80SEr5N2LIEPCk4Zc8DkSWIIm6fWgHw/bndxCqKt3s80ULoL46PTbTGe5HPJaWbG1SiIw8WhtsBVh5tLLc3pNQ1vWpZn7ViXS7LNVMpo6plXB6yDNQT96OZfG9oSJVvyqXdFS0CQu+NicikPrj6SDDVGR/IC24O2qy0sygp9uVTfLVYmQeqNlc6PFwBqJ67DM9dTZIFW2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scgw2iQyDVMTgq5XBOB2k+PB1YOXTX7uktWcx3fY+Rc=;
 b=ZGnaRDTs5StsRWySzCvZ3fbe9zLE1+x5RqSt1lWIDuzfEU0tCmqMkNtLpjZcdoMsEL+g8piZXdDYgIxWcbg6umE31RlgbB9QwmdXPGNuL7Uz4c52SCEUxaeFwwA+niZ/kk9wKnVj+M2xWmwxDJ1ScUngpUXXkUvtQeveWOw0m66V8NUEcIC18zchev3xPwkyGRrsTGv+URwFLvzo2UTa9lXLbrhgt65shEZ7B9Jodrwx2QZOvSl3eSRN+ZYLbNIVBEtxLIAk7s9VHidhuecRQh1dKtAbb93SbPrhVUKLza8P/OVJwGSjpaYycZzUx1QAL5pKKIV187FzBkgcvCEFJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 20:04:59 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Sat, 2 May 2026
 20:04:59 +0000
Message-ID: <74c79e77-cd2c-4df3-8e61-57fefd50de5b@nvidia.com>
Date: Sat, 2 May 2026 23:04:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 3/7] net/mlx5: Lag, avoid LAG and representor
 lock cycles
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Saeed Mahameed <saeedm@nvidia.com>, Shay Drory <shayd@nvidia.com>,
 Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 Maher Sanalla <msanalla@nvidia.com>, Simon Horman <horms@kernel.org>,
 Gerd Bayer <gbayer@linux.ibm.com>, Moshe Shemesh <moshe@nvidia.com>,
 Kees Cook <kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260501041633.231662-1-tariqt@nvidia.com>
 <20260501041633.231662-4-tariqt@nvidia.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260501041633.231662-4-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::18) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: f7175125-e73a-431f-d9b1-08dea8861645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Akgu158P+fxGTrGrzCyZ0BNUg5PFMTry77IFGaPmLYgofHDrLnAilq6fygCv5QRmsJod4HZGlsWGpudMQjVlCh8cJAC8z64RbHKrS9A36y4KUxcsBbf7yq9R4IInAjGbSeQw6nHUuOJftKQpi6kpHRVnhDysZyvgKS7kG8B6oyH+jb8r6D1iM4T83F8QmP+/578Cibp/EG4iXIy1ruwcObtiB0GLfxhv5wuko1foBsaeQNtf+drwHLQJ0lb2GPlAvoOU/pTTBH/eKtpapbFhbey+BPeSYmFfq3Rkqqpjr3FUsSk3df9viUTM+ncmxkzaV33tbezD/mLzSDtILGl74KVczVAAPersPICMQ1caRaBRa6TOdKoAmwXXCROIuSYDeyvNL+cMPOvwYjfWG0CqtnzRo6vU/HkCWSbgtdSEKQQqlhDCM44oHC0FPHD62UKe/CJJe/zu2KIfkFnw/n3YMcWuB5SVWh6rfxCeuEzQvdpH5MRTdReMzyzERzqRzvghJnX3CQhOP+ERsLfeCOG5E0ZVvQey96+hxmcURwvUvwOaFgrso2kiiFCDvIZxGZSUvsXqKkdNWtYnHCa2PiA+BjY5IGXYiXhmE7G7vTBZU+dnjvkbrrjhAsK/GZhiH5Sb8Icpf7UvYwd/k+Qf1ekdlnAwtr3qt5cCGlmYBVkauOrT6idg0xVGgN8puVMx+OKr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUQrSkNlOERoNDU1MGlNN3A4QlZpOWxrbmoxZ3YyY09TME1rdm9OK3hwaEJ6?=
 =?utf-8?B?MFl4czRVZVh5S3dUdjcwQ0I5b1dwMnNaUUNWSHB5VS8vVFg5dVdYU0RCYUg3?=
 =?utf-8?B?T25seE1Fd1F3UHVwcHFJeDhGN2FJakdJY1pnT1RhN1NyMXlUZ1pOSDVGV0cr?=
 =?utf-8?B?c2VzS3U5dklYZ0ZiQ09YK1l2RVY4RlVacnp3SDF0RnhBK1RIRU5QVXNiU3lC?=
 =?utf-8?B?MWtWVEFmV2RSTE5RZExUcHVkWkhHQm0yQjFCNzAvanM2MnRJdHh2TVRHRzJJ?=
 =?utf-8?B?b3dXMnFwYnYvejdqRi90c0ZlOUdjS3RZczZFMjg0RlliOFp4VSt6a2k3emxa?=
 =?utf-8?B?dnVSR2dlbE56WldxYkJZV2NHclBsUWRMUHFFZ1BaUWYzMm9JOWJlVDB0Y3I1?=
 =?utf-8?B?djdPdXA4S0tMNzNvNTZOaS9NdVU3cGdIUE9ka3VkU1N3ZCt5Z0FOY205bUNn?=
 =?utf-8?B?QmtYcjJlTDdUcWcreURUVnpybG05eE5iOW9JOUlJVTQ4M3Z3ak1mL25vVEhm?=
 =?utf-8?B?dThDWEhLamQ0TWxxSXczMzZud0trOFJBMktwdkxlZVpBSXRjOGtzK2t1anFR?=
 =?utf-8?B?S1JKa1B6RW9GWVVOUkFXWGo2ajk4aE4wUE1rd3ptTGxXMGlXYzRweFZLTDY1?=
 =?utf-8?B?dUJieTlZY0lsZmxIRUJQL0gyRlowaWc0VkVGYXRxUm1tTCtJa0RRVHNHYUNJ?=
 =?utf-8?B?Z3daaE15N3hhZDFWWU5SNDBUakJyWjB1RkhpQjNGb0g4eGFSNHIyeE9CYzVC?=
 =?utf-8?B?bTNuUFdiSkU4Rml6dUp2bit5dUtORWV0ZE4vUnYzeWVZdHlBL1lieUpqOEhr?=
 =?utf-8?B?a2VaV2xGTWtKSm1sVnVUMEtkWGY4NTBKNXpSbW80d2NkZ2dUYWlYeVBYMEJD?=
 =?utf-8?B?S2krdWZvdTN1YkhqTm9zWER4NVcyTWsxT29uSjJGZlM2ZGc3Z3Noc1YySzBp?=
 =?utf-8?B?b21pd29rUzIxNGI5bkFDcUQzZllCTXQvMlJFOWlyOS9QZlVtWERsM3FJOUJm?=
 =?utf-8?B?N1R3RHR3T2FaUE16bE16cStaUFJXVi9LMXhoSEJ0QW8yR09SWDlZeVpDcDRm?=
 =?utf-8?B?cWtFVWU1ZjhEVFNUQys0WHBFVTNYZWxOLzdqQ3lCK2xUamt3c2RZWUFvUEVi?=
 =?utf-8?B?b1FiTlRGdE9IL1BuSWxzMmRYQ0hUWGRBUFNCZHIxaStSRytwaFp5VWV6dWZJ?=
 =?utf-8?B?T1F6Vld0MWZNVFEzY21EWWVtNTE2QmpCUzJpZWQ1cU1YR29EVjVQTkV2K2Zk?=
 =?utf-8?B?TDN2WUxvczhqOGRjdWFhOWtNVXkvbURIS2ViMUFnY050WFZSWW0vQjltNzZ5?=
 =?utf-8?B?ZEFENnFPRFBNaVdxR0gwOHdFaEZDU2Vqd0xzUkJ1TVprOE1ZclZlZEc2a3h4?=
 =?utf-8?B?UHNFZkpuTFZyUmhaVVE3SmdQS3BFVmVGdUw0ZW8vc21mVDhYMGNzYnZFMHpi?=
 =?utf-8?B?akJSaU5JRkxRNFZNRXNnSXdZTjIwQ2N4K1VwWG1sUlNPc3l5NXJ2dXZiUjIr?=
 =?utf-8?B?bzh1Rm01bWh5b3d3dzA4MS9uMGwvdXhteGppMzl4V3V6SXZVSlZLZnJaNUJR?=
 =?utf-8?B?R3pJeXNUKyszcUplelJGRTVxLzd4dTQxMlMyUk15OFNzMHJLWlB6TVEvSlNE?=
 =?utf-8?B?S2gwQkQ3Q1RzbXg2ZWZXbEpEMHN0MzRKM1VEdkRLNS9nV0NndkUvT0xyM1hJ?=
 =?utf-8?B?bVV6cFZkYmt3VUFUa1NiZEtmdzVkdHYrdWpIYjZoYkpYMWYrMmxURlpYREdY?=
 =?utf-8?B?TWVKTXFpbEdXWG1tRWhsRnRCMnFuSlY5RnR5b2VQYkMxN2lXYzZWYVV2c0l2?=
 =?utf-8?B?WUE0cCtWSWtmR1FBVDllNkM0Q1lIK0E2NEpTTVkrWmo1NTArNThyUWoxUEVW?=
 =?utf-8?B?VlhTdE5ZUWZZVnFWWmtQR1B1NC9nZDhmaVc5REc4S1oyOVFPYVIzSTBuMnZl?=
 =?utf-8?B?OU9RRWtnbTJmWkdhOGRwOWJILzErTmNGRUZrNjFTM2FmWTVJRzkySitGS3JV?=
 =?utf-8?B?eU81ZVlPU1pNMlU4OWtqam8zQjVmREdwcS83Q3ltS2pPYXFkODZLWDRObzYz?=
 =?utf-8?B?UTRlaytpdDJZakVod3dtdTRBbzh1b3NRMWVYWVFBbG1Hcm1td2hYSFQxNGtI?=
 =?utf-8?B?Z2N6YTZsWnRiZ1M0M1hMSTk4MEZUSE9GY1FqQmZOR0EwME9makJ6QkhuTjBT?=
 =?utf-8?B?UXFhamFKSHpSRGpYWXJqblZ5SWo1Z2JvMndteGk5K3M4eURZMzU1UGxFQ1I5?=
 =?utf-8?B?MFNrMFMzb1Q5WEk5cjY5N0gyM2VZbUk4aE9lSnVzdjBxb284Q1lvdWN2Szk1?=
 =?utf-8?B?dUhsd3dyT0x5YzJlY3FnL1NBWVZFZ1dzK0FLM1gxYWJrS3MxS0ovdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7175125-e73a-431f-d9b1-08dea8861645
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 20:04:58.8892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBRjQPHSzWQ4eoaEEyHljWVOdi8goINyce6KJEvhg20YNUzyiXuFbtsld3KI70HY8zwvjDNC4PLY9Ao9G2di7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055
X-Rspamd-Queue-Id: B4E114B35A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-19862-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On 01/05/2026 7:16, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> The LAG shared-FDB and multiport E-Switch transitions rescan auxiliary
> devices and reload IB representors while holding ldev->lock. Driver
> bind/unbind paths may register or unregister E-Switch representor ops, and
> representor load paths may enter LAG code, so holding ldev->lock across
> those calls creates lock-order cycles with the E-Switch representor lock.
> 
> Keep the devcom component locked for the transition, but drop ldev->lock
> before rescanning auxiliary devices or reloading IB representors. Mark the
> LAG transition as in progress while the lock is dropped and assert the
> devcom lock where the helper relies on it. This preserves LAG serialization
> while avoiding ldev->lock nesting under E-Switch representor registration.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 142 ++++++++++++++----
>  .../net/ethernet/mellanox/mlx5/core/lag/lag.h |   7 +-
>  .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  10 +-
>  .../ethernet/mellanox/mlx5/core/lib/devcom.c  |   8 +
>  .../ethernet/mellanox/mlx5/core/lib/devcom.h  |   1 +
>  5 files changed, 134 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index a474f970e056..e77f9931c39c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -1063,37 +1063,99 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
>  	return true;
>  }
>  
> -void mlx5_lag_add_devices(struct mlx5_lag *ldev)
> +static void mlx5_lag_assert_locked_transition(struct mlx5_lag *ldev)
>  {
> +	struct mlx5_devcom_comp_dev *devcom = NULL;
>  	struct lag_func *pf;
>  	int i;
>  
> -	mlx5_ldev_for_each(i, 0, ldev) {
> -		pf = mlx5_lag_pf(ldev, i);
> -		if (pf->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)
> -			continue;
> +	lockdep_assert_held(&ldev->lock);
>  
> -		pf->dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> -		mlx5_rescan_drivers_locked(pf->dev);
> +	i = mlx5_get_next_ldev_func(ldev, 0);
> +	if (i < MLX5_MAX_PORTS) {
> +		pf = mlx5_lag_pf(ldev, i);
> +		devcom = pf->dev->priv.hca_devcom_comp;
>  	}
> +	mlx5_devcom_comp_assert_locked(devcom);
>  }
>  
> -void mlx5_lag_remove_devices(struct mlx5_lag *ldev)
> +static void mlx5_lag_drop_lock_for_reps(struct mlx5_lag *ldev)
> +{
> +	mlx5_lag_assert_locked_transition(ldev);
> +
> +	/* Keep PF membership stable while ldev->lock is dropped. Device add
> +	 * and remove paths observe mode_changes_in_progress and retry.
> +	 */
> +	ldev->mode_changes_in_progress++;
> +	mutex_unlock(&ldev->lock);
> +}
> +
> +static void mlx5_lag_retake_lock_after_reps(struct mlx5_lag *ldev)
>  {
> +	mutex_lock(&ldev->lock);
> +	ldev->mode_changes_in_progress--;
> +}x

sashiko.dev says:
"
Is it possible this introduces an ad-hoc synchronization mechanism?
The networking subsystem guidelines suggest that using a flag or integer
counter to guard a section of code, particularly when concurrent paths
observe it and retry, can bypass lockdep deadlock detection. These patterns
also often lack proper fairness and memory ordering guarantees compared to
standard locking primitives.
Could a standard synchronization primitive like an rwsem be used here instead
of the mode_changes_in_progress counter?
"

The counter is pre-existing, this patch only reuses it while ldev->lock is
dropped, and all accesses remain protected by ldev->lock.
The transition itself is still serialized by the HCA devcom write lock,
which is lockdep-visible; the counter only makes affected paths retry.
I agree this gating can be cleaned up separately, but I’d prefer
not to fold that broader LAG locking rework into this patch series.

Mark

> +
> +void mlx5_lag_rescan_dev_locked(struct mlx5_lag *ldev,
> +				struct mlx5_core_dev *dev,
> +				bool enable)
> +{
> +	if (dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)
> +		return;
> +
> +	if (enable)
> +		dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> +	else
> +		dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> +
> +	/* Auxiliary bus probe/remove can register or unregister representor
> +	 * callbacks and take reps_lock. Drop ldev->lock so the only ordering
> +	 * remains reps_lock -> ldev->lock from representor callbacks.
> +	 */
> +	mlx5_lag_drop_lock_for_reps(ldev);
> +	mlx5_rescan_drivers_locked(dev);
> +	mlx5_lag_retake_lock_after_reps(ldev);
> +}
> +
> +static void mlx5_lag_rescan_devices_locked(struct mlx5_lag *ldev, bool enable)
> +{
> +	struct mlx5_core_dev *devs[MLX5_MAX_PORTS];
>  	struct lag_func *pf;
> +	int num_devs = 0;
>  	int i;
>  
> +	mlx5_lag_assert_locked_transition(ldev);
> +
>  	mlx5_ldev_for_each(i, 0, ldev) {
>  		pf = mlx5_lag_pf(ldev, i);
>  		if (pf->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)
>  			continue;
>  
> -		pf->dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> -		mlx5_rescan_drivers_locked(pf->dev);
> +		if (enable)
> +			pf->dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> +		else
> +			pf->dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> +		devs[num_devs++] = pf->dev;
>  	}
> +
> +	mlx5_lag_drop_lock_for_reps(ldev);
> +	for (i = 0; i < num_devs; i++)
> +		mlx5_rescan_drivers_locked(devs[i]);
> +	mlx5_lag_retake_lock_after_reps(ldev);
>  }
>  
> -int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags, bool cont_on_fail)
> +void mlx5_lag_add_devices(struct mlx5_lag *ldev)
> +{
> +	mlx5_lag_rescan_devices_locked(ldev, true);
> +}
> +
> +void mlx5_lag_remove_devices(struct mlx5_lag *ldev)
> +{
> +	mlx5_lag_rescan_devices_locked(ldev, false);
> +}
> +
> +static int mlx5_lag_reload_ib_reps_unlocked(struct mlx5_lag *ldev, u32 flags,
> +					    bool cont_on_fail)
>  {
>  	struct lag_func *pf;
>  	int ret;
> @@ -1105,7 +1167,9 @@ int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags, bool cont_on_fail)
>  			struct mlx5_eswitch *esw;
>  
>  			esw = pf->dev->priv.eswitch;
> +			mlx5_esw_reps_block(esw);
>  			ret = mlx5_eswitch_reload_ib_reps(esw);
> +			mlx5_esw_reps_unblock(esw);
>  			if (ret && !cont_on_fail)
>  				return ret;
>  		}
> @@ -1114,6 +1178,34 @@ int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags, bool cont_on_fail)
>  	return 0;
>  }
>  
> +static int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags,
> +				   bool cont_on_fail)
> +{
> +	int ret;
> +
> +	/* The HCA devcom component lock serializes LAG mode transitions while
> +	 * ldev->lock is dropped here. Dropping ldev->lock is required because
> +	 * the reload takes the per-E-Switch reps_lock, and representor
> +	 * load/unload callbacks can re-enter LAG netdev add/remove and take
> +	 * ldev->lock. Keep the ordering reps_lock -> ldev->lock.
> +	 */
> +	mlx5_lag_drop_lock_for_reps(ldev);
> +	ret = mlx5_lag_reload_ib_reps_unlocked(ldev, flags, cont_on_fail);
> +	mlx5_lag_retake_lock_after_reps(ldev);
> +
> +	return ret;
> +}
> +
> +int mlx5_lag_reload_ib_reps_from_locked(struct mlx5_lag *ldev, u32 flags,
> +					bool cont_on_fail)
> +{
> +	int ret;
> +
> +	ret = mlx5_lag_reload_ib_reps(ldev, flags, cont_on_fail);
> +
> +	return ret;
> +}
> +
>  void mlx5_disable_lag(struct mlx5_lag *ldev)
>  {
>  	bool shared_fdb = test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &ldev->mode_flags);
> @@ -1132,10 +1224,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
>  	if (shared_fdb) {
>  		mlx5_lag_remove_devices(ldev);
>  	} else if (roce_lag) {
> -		if (!(dev0->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)) {
> -			dev0->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> -			mlx5_rescan_drivers_locked(dev0);
> -		}
> +		mlx5_lag_rescan_dev_locked(ldev, dev0, false);
>  		mlx5_ldev_for_each(i, 0, ldev) {
>  			if (i == idx)
>  				continue;
> @@ -1151,8 +1240,9 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
>  		mlx5_lag_add_devices(ldev);
>  
>  	if (shared_fdb)
> -		mlx5_lag_reload_ib_reps(ldev, MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV,
> -					true);
> +		mlx5_lag_reload_ib_reps_from_locked(ldev,
> +						    MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV,
> +						    true);
>  }
>  
>  bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
> @@ -1409,7 +1499,8 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
>  			if (shared_fdb || roce_lag)
>  				mlx5_lag_add_devices(ldev);
>  			if (shared_fdb)
> -				mlx5_lag_reload_ib_reps(ldev, 0, true);
> +				mlx5_lag_reload_ib_reps_from_locked(ldev, 0,
> +								    true);
>  
>  			return;
>  		}
> @@ -1417,8 +1508,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
>  		if (roce_lag) {
>  			struct mlx5_core_dev *dev;
>  
> -			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> -			mlx5_rescan_drivers_locked(dev0);
> +			mlx5_lag_rescan_dev_locked(ldev, dev0, true);
>  			mlx5_ldev_for_each(i, 0, ldev) {
>  				if (i == idx)
>  					continue;
> @@ -1427,15 +1517,15 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
>  					mlx5_nic_vport_enable_roce(dev);
>  			}
>  		} else if (shared_fdb) {
> -			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> -			mlx5_rescan_drivers_locked(dev0);
> -			err = mlx5_lag_reload_ib_reps(ldev, 0, false);
> +			mlx5_lag_rescan_dev_locked(ldev, dev0, true);
> +			err = mlx5_lag_reload_ib_reps_from_locked(ldev, 0,
> +								  false);
>  			if (err) {
> -				dev0->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> -				mlx5_rescan_drivers_locked(dev0);
> +				mlx5_lag_rescan_dev_locked(ldev, dev0, false);
>  				mlx5_deactivate_lag(ldev);
>  				mlx5_lag_add_devices(ldev);
> -				mlx5_lag_reload_ib_reps(ldev, 0, true);
> +				mlx5_lag_reload_ib_reps_from_locked(ldev, 0,
> +								    true);
>  				mlx5_core_err(dev0, "Failed to enable lag\n");
>  				return;
>  			}
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> index daca8ebd5256..6afe7707d076 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> @@ -164,6 +164,9 @@ void mlx5_disable_lag(struct mlx5_lag *ldev);
>  void mlx5_lag_remove_devices(struct mlx5_lag *ldev);
>  int mlx5_deactivate_lag(struct mlx5_lag *ldev);
>  void mlx5_lag_add_devices(struct mlx5_lag *ldev);
> +void mlx5_lag_rescan_dev_locked(struct mlx5_lag *ldev,
> +				struct mlx5_core_dev *dev,
> +				bool enable);
>  struct mlx5_devcom_comp_dev *mlx5_lag_get_devcom_comp(struct mlx5_lag *ldev);
>  
>  #ifdef CONFIG_MLX5_ESWITCH
> @@ -199,6 +202,6 @@ int mlx5_get_next_ldev_func(struct mlx5_lag *ldev, int start_idx);
>  int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq);
>  int mlx5_lag_num_devs(struct mlx5_lag *ldev);
>  int mlx5_lag_num_netdevs(struct mlx5_lag *ldev);
> -int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags,
> -			    bool cont_on_fail);
> +int mlx5_lag_reload_ib_reps_from_locked(struct mlx5_lag *ldev, u32 flags,
> +					bool cont_on_fail);
>  #endif /* __MLX5_LAG_H__ */
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> index edcd06f3be7a..8a349f8fd823 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> @@ -100,9 +100,8 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
>  		goto err_add_devices;
>  	}
>  
> -	dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> -	mlx5_rescan_drivers_locked(dev0);
> -	err = mlx5_lag_reload_ib_reps(ldev, 0, false);
> +	mlx5_lag_rescan_dev_locked(ldev, dev0, true);
> +	err = mlx5_lag_reload_ib_reps_from_locked(ldev, 0, false);
>  	if (err)
>  		goto err_rescan_drivers;
>  
> @@ -111,12 +110,11 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
>  	return 0;
>  
>  err_rescan_drivers:
> -	dev0->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> -	mlx5_rescan_drivers_locked(dev0);
> +	mlx5_lag_rescan_dev_locked(ldev, dev0, false);
>  	mlx5_deactivate_lag(ldev);
>  err_add_devices:
>  	mlx5_lag_add_devices(ldev);
> -	mlx5_lag_reload_ib_reps(ldev, 0, true);
> +	mlx5_lag_reload_ib_reps_from_locked(ldev, 0, true);
>  	mlx5_mpesw_metadata_cleanup(ldev);
>  	return err;
>  }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> index 4b5ac2db55ce..d40c53193ea8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> @@ -3,6 +3,7 @@
>  
>  #include <linux/mlx5/vport.h>
>  #include <linux/list.h>
> +#include <linux/lockdep.h>
>  #include "lib/devcom.h"
>  #include "lib/mlx5.h"
>  #include "mlx5_core.h"
> @@ -438,3 +439,10 @@ int mlx5_devcom_comp_trylock(struct mlx5_devcom_comp_dev *devcom)
>  		return 0;
>  	return down_write_trylock(&devcom->comp->sem);
>  }
> +
> +void mlx5_devcom_comp_assert_locked(struct mlx5_devcom_comp_dev *devcom)
> +{
> +	if (!devcom)
> +		return;
> +	lockdep_assert_held_write(&devcom->comp->sem);
> +}
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
> index 91e5ae529d5c..316052a85ca5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
> @@ -75,5 +75,6 @@ void *mlx5_devcom_get_next_peer_data_rcu(struct mlx5_devcom_comp_dev *devcom,
>  void mlx5_devcom_comp_lock(struct mlx5_devcom_comp_dev *devcom);
>  void mlx5_devcom_comp_unlock(struct mlx5_devcom_comp_dev *devcom);
>  int mlx5_devcom_comp_trylock(struct mlx5_devcom_comp_dev *devcom);
> +void mlx5_devcom_comp_assert_locked(struct mlx5_devcom_comp_dev *devcom);
>  
>  #endif /* __LIB_MLX5_DEVCOM_H__ */


