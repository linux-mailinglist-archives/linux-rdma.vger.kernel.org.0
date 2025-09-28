Return-Path: <linux-rdma+bounces-13695-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F738BA7002
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 13:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8FA17905A
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 11:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F362DCF77;
	Sun, 28 Sep 2025 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eMipnw4i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC872602;
	Sun, 28 Sep 2025 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759059630; cv=fail; b=A+urvnPoP3ZLWum6zyyflm/+jf4T9dvfQqyrRlwUuPfBCCwa7qqVEjucfzhmlhvXfdryuySwDajn0ZDOoU8W/olCBLKVHvJaxOuOiUdK7v+PwQ+jox1kT/b1mgwLcboVOI9i95j+F8gV5gaZf1HRk1/RCiWvuXnz3uJg9MWGsrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759059630; c=relaxed/simple;
	bh=QCNS1+M9lm01oBI7j4n+Ii3341SgIoEEjFjGBiLDRio=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d9AWAKmkaHkvt5OMwDxNfPgnZTvYoATvZpMANN5SK/0Lqb+UlRJIVw1ynzg4fsXCVgx4PFl+A5K6V7U9npLQnMpUM/jmTns6zlXS+oUQ7icyn+/ZqB4AQjv0p24i2WEqrN8CnvK2poRPFLpkAQfDdVHYONWQGEDzB7RKEK0aiRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eMipnw4i; arc=fail smtp.client-ip=40.93.198.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpsRxsBtIaT3bcVNI93rMwuR2c/n01X+C3/XyRs2/ECGMlzTE8KNAXGEX6FKWdFHP26S/UgT60AC12gZSvOoXTsEMJ+bsyU4cqrkZeYZ55FJQmOva4m4x6PPo4K/3JGz9LJtHO+9Kp6GtY8wxbf2hzsoU73Oj4IF4YY7h5Tgj/nt0FzXe/SJHf4l6MYlFSO7+WQUn4jU3kX3ELwyOIgW9y/tGy4FllX36OzTmwRsHzSxYHlEutoRGPPHumQ6N1iV22BO5/6N0AZjzDKE5rML4iL4RoxQDXT+cffupFY78yNCcrRbT8D1aD7wPxby+qyeWGGZMbfstHb4x/30GIJsow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vas0fL30w6ZfUzmoHh6sgiioSdO0kLdEwYJ3Crcs4is=;
 b=eTEvUGOCgD24XPNp8TG/xtDrxZBIalV4YPsLAfiaIMKqT/1fU7FFew/XJGTgE3/oLUll2RC2oiOGiITsi1qkQT2q41jl2oix9vL5UWCNls1GaFC9pCOx0aHm7rLJzgKtZueI5n/NV0twKEJdhaG2wt/BWw12nDPJ/raWDFAX708PAZdzT2wHbsEjxgJPzLTKXhLRkjHH03YV/I0qU9gAn5mH/yvZxI5Rj4pN8awSR5gy/9bN+8u8qGBxsqIKXUJppFoa2nGu62HVp44PnFhjjhKwnyJQ+BfvlXuUEnixd581jbpoFFhXyUMNwbH3tXdTV4Nf2cZkzBkueIKJ0NgN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vas0fL30w6ZfUzmoHh6sgiioSdO0kLdEwYJ3Crcs4is=;
 b=eMipnw4i0blyXTyJgYkIG0Im56ipToRtleTTTGlw3E3TaSrZtqGoTn3W95QMuoCEJSH9kAkpjshHA1ik54k++jDYq/5iJ6pCYRQxrGhkXRj6kerzr98vqSUcHDVZa3Offn4GMol41FnmIph8PeeIsONADIOU44IU94dt/9Lkig2bvZLEk2DrTC6fj2OvW4ccxcYGwyoSFykyb/u0/DPu/xuIU2H1eFmgMdSRbui5jF2XNKXtLZkpoaC+8SE87/TsTV8Y+nWNNqTCPJBbjx9dE7Ev7nKcbQnSswBNDcWwx7dos17ZoF5T2zGPgmzxwpnBOZbhVj6rbAcafCt2GTonMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA0PR12MB8861.namprd12.prod.outlook.com (2603:10b6:208:487::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Sun, 28 Sep
 2025 11:40:26 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9160.015; Sun, 28 Sep 2025
 11:40:26 +0000
Message-ID: <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
Date: Sun, 28 Sep 2025 14:40:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
To: Markus Elfring <Markus.Elfring@web.de>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
 <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA0PR12MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: c20b565c-c331-4729-c760-08ddfe83d106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXppbnkyMytLc2t1NjJyek8veXpWZVloSkVya0YwVWx4bG9mUkZpM0JISUM2?=
 =?utf-8?B?dGdBU0dYSFhMWUpidzFScGZpTENhYkRycmUvTFhnL1VtRldwSlQxZk9GOUxI?=
 =?utf-8?B?VEI5d2dQa25nMjFqR3FzTmJSVHFNMTZwN0JBUFFoTUJrR2E3QkYxZ1hUam91?=
 =?utf-8?B?U2V5VmJ4cG1LV0c3YzhKeGFTaVhmb1BIUEMrOHRhQWdkS0daak5lY1kwZjZw?=
 =?utf-8?B?RHJydEc2bjg1STIrR3RZb3V3OXhDZS9WZitRQ0JwTlh3aXoxN1FoUjhTNmVE?=
 =?utf-8?B?OGRTSElvamgxSkRMcis0U2hrMThUemNTcVlES0UwLzR0dXpNamV3WnFoMEhT?=
 =?utf-8?B?WEgzSFB3aTNlZGZXbzF5bDF1cHBHTm1PT1MvYWZlSk5NRnFJQy9iRDVQaDZv?=
 =?utf-8?B?NzNnNmJYYmlEcHczYy9kMEtCSTZQRDRqaS95V1lYQWlvNC83U3FjMlhxSURa?=
 =?utf-8?B?TzVZWHN5UjhENGlaUzBGRTBMeWh2dFFXUDdyOTR2bDcyaXpaK1BIaHhyUncr?=
 =?utf-8?B?ejdRRVRwZjNvczZhTFpROTlOcmFtYjMwZ1dPYkd1ell3UVZmZWJUSURnYi9H?=
 =?utf-8?B?WjJqS1c2VzA5Z1ZNVytoeGIyVGtVUXVubk0rdytyaENXbzJQS1h1SDNBRjAy?=
 =?utf-8?B?MUNsWGZFNEJnVUUzTTA1K3BXU0NIaTFVYkpsbG5pdWVnU2Y2aktQWG5yNVFH?=
 =?utf-8?B?eEsrZGhMNGZvMExmbzg0MkdWNG5uaVBOTndKM0lMNDY5UFpMa2ZUMFBWZW0y?=
 =?utf-8?B?MkJKeExDV0NhN1RieGllR0x0QnN4aDJ5TC9pb2VjZ0NXZ0ZoNkUvOHJQd05h?=
 =?utf-8?B?T0dvVXZiWU5MNWZPNWEzY3h4eWxmbU1uRDZVa05OeGZFeldwby8vSDZ1bFJh?=
 =?utf-8?B?NHVlQ1dWRDdsMk1NSXZkaHZYUmdwN2laZTFCTXB5NzVJVHc0dGorNzJwVDJP?=
 =?utf-8?B?RzZqWU1KTGUySDljS2FPNFNucnE0TG1QLzZUMXd2RE9BQXVtM3pLSE16OGJE?=
 =?utf-8?B?ZWNGU0hqdUlTOXNzWGlQTW52YjBXYm1SMHowUXFNWUdEK2lZaHJ6Zng0cGly?=
 =?utf-8?B?UmF1Vkw2SFdJd25UNTgwcFRtemF0RjdIQnZkcjJQaHVKTXZTd1VzelJGRWhh?=
 =?utf-8?B?Y2lYZXljcW5TTWVsbTZrVGErYXE5ZEFmSDRYYWJjTjFpTWlTdVFHVzh2ZHNV?=
 =?utf-8?B?QzQ3ZkQwNXV2THM3SmFQZEV2WEx6Q0VxN3RoNWQyWkVFRG5oQXBMdi9jWlBL?=
 =?utf-8?B?K3ZENmR0K1dmcTZIZUR5RUtEQVNGS3FibVhzZ2pYTWZYL2pSRk8wUy91ZG9L?=
 =?utf-8?B?OVJON2VxQmoxSGFEMFZmNENxcnBKVmdEbE0xM1Ztci8ySlUxYXJrL2xpY3pE?=
 =?utf-8?B?dk5vazg5SFNtdStaYld6UHBSQWYyNnNtT2V1U0Fsc0h1bW9HbE0wNE9vRzVj?=
 =?utf-8?B?b2IwYkVzcC9MU2RBTldULytoNHRkN0c1aktab0hyd3FJS1pWTStMTXN0azZ2?=
 =?utf-8?B?dUkxckVmSElWeWtsL0t4Vkh2Yk9PR1VxUFR4QzhIQWpHRHpMWWZqMFRXTXlK?=
 =?utf-8?B?Y0N1c2JBbzY2cGV2cXRMc3dTRDR5bHdLSTlJNXNuNVVkRXNwdnM4ZThGRngw?=
 =?utf-8?B?blNGQXl4bmRyQUEwRCt4WUszRW82OVY0TDVvbm90VkpsR3ExRkRlbXZGMXlt?=
 =?utf-8?B?RzhjVkh2S1lOemluTzYydlRTQ0lySWJyRkJ2OE5pcGJ5UHFza002czFjY1Q1?=
 =?utf-8?B?NDgybE1hQk8waUlvVEFpbkN2V2l1eERlR0MvRGd1dmlqWU5OZGJMd0NvYS9o?=
 =?utf-8?B?T21pTzQ3WEhiQjlFQkZsdm1KU0tmcExtd3N2d0R3b2NGbWdoU3lVRm9ibVdZ?=
 =?utf-8?B?Y3VmZDVUb3F5Uk9LVXdUVE5WSk82YjVVOURWdFJWWmpxWE9BUEROK3JTdzlK?=
 =?utf-8?B?Sy9mTEZuM3lXSFQ3Z1RZbGVlcTlYRjV4OGQxTTVHT3Iza1ozN21QNGx2MVVM?=
 =?utf-8?B?alpHdjQ4V0pRWEZmRGIwZ09hRGxKUkx1YmdEMjVSc0hCZ2J5MmN2bU9BV2ww?=
 =?utf-8?Q?E2qh1K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a211UU1lbmROb0hvZExuMDk3TC95YmhZOUtya29waXlVVERiUkZXQ2p5Skkx?=
 =?utf-8?B?RHEyQlFQck1DQjBJU0l5UlYxVUF1K1A1NEM5V0t2Y0o5bVVxMzRnR3JNTmpP?=
 =?utf-8?B?WFJRZXlkU0NxSjh6TjZ2Q1pVSVJVMVdHNGJPWGw3MkZicjJEWXp1ZE80clhp?=
 =?utf-8?B?U1JudFVVdFVJMWVRRnN0THUyeWtsNDk1TDQ3YWNjeTVLZHRvY29HdUZhMS9Z?=
 =?utf-8?B?TEpxL2cxQjZ3V0V4WGN5ZkVGZHBhTHh2NUUvQitwTWhYcytMdXJyc2k2SkZM?=
 =?utf-8?B?L0M1ZHJ0azVMZWhLaDZURTg2YjlnM3JQMVI1eFFRMG9LNmwxLzVtbkZ3ZzE3?=
 =?utf-8?B?MUtnZFFySkJHL2d1T0NvSDdqQktlWnpDZkljU2V1NkJVUGtZcmFQOFNZTzlG?=
 =?utf-8?B?ZkM4Sm1CVFdZRU9idWF1MlZHUzhnQ1NkTkIvRklRTC9kditaZDQ0ODg1RjJI?=
 =?utf-8?B?ajJTaERaOEFSQUpLbnNYa0ZhZkxNNk5TMEozWldWckJJL0thQnlJSjBnTmUy?=
 =?utf-8?B?WE1TT2xicFZCTi9zN1N2Nzk1Q1plUVlHQ1hYRmJHUGZZQkMxNExvbzJIRDNl?=
 =?utf-8?B?dTd5WmFidENlZFlwakIySWNvWG02eXNoRytLb1JMU3U3RnY4Rm5kQ09UOVBx?=
 =?utf-8?B?eXZXc3dneGRBQWV0bVJkemlYQzQwK2tUU1RYTWZFaVB1dUE2bng5RGlmQzBH?=
 =?utf-8?B?VmhxaFJLRm5rK1FjNU5WdW5xWHdIcjhhN2V0Vm5qd1BFVlRicnF5VVMrZlUy?=
 =?utf-8?B?QWRQdm5qa1FSajBQYU5Pd1FlMmRLVytxZGREdm5MVGQ2eHNmbUR2clV3ZUo3?=
 =?utf-8?B?UU02by9rVFdDZEdCOVM0eWNiUnFJbmFuYlVCWGcwd3RuR0NubVc0NFlBYnE1?=
 =?utf-8?B?UHVSVVBEck16WHRMVE96TWdxOGEzT0Njc3JadUFBOHBSY3MxM25YSU5EU2p6?=
 =?utf-8?B?Zk9Eall1TFcyL2I2R2puVjdxMGw5UXFRWE1wYUkrTmFvWlZ1Z29yMnlDREI3?=
 =?utf-8?B?L2luNldrZnA5TXJTeDJMN0hneTJ6L3JJL2lyRWxDNllPa0xCOHl2L0NjU0NO?=
 =?utf-8?B?dk54RW44YzZiR1lxYVJNUStwRSs1Wm5zQWNKMGJCVjgwcGlvYWtHN2VhV0hK?=
 =?utf-8?B?ZmFVMzE0aU00azZqUjlwaHZsVm5kMGNtK3NlVFZTMm5waDVqZmRjQVRxaVJU?=
 =?utf-8?B?MzY2RmZOUFhPcUR4Y0pVSVI4ZnJoazhhM3B5aGU4Qlp1SU1RNXNlcnhpOUx5?=
 =?utf-8?B?S0VYT3ZsL2FpVDFXUXJCb0c1QlVRek1LRnBnenkxcWhnbEpxZWpFbEozSFVt?=
 =?utf-8?B?aHRqbDd1ZnFpdm5OV1Bmd0ZLbHJHektzanp4LzFyaVJRS0cwM1FZaHkvN3dh?=
 =?utf-8?B?WnBxc3c0SXQ0UUwwSmxoRDh6bHFrL1kvTWJsMmc4MFZlVk9sRUJNSUVhTDJz?=
 =?utf-8?B?VXNJVlI2RmF3OUpLa3psSEJpdFZzbUZPVzFGSzUya2hHbEowTTR3eDRmSWM2?=
 =?utf-8?B?cnd2aFliSmRJN0pFMmMrQlZMZFFLcWZXdFFWeHBwL29yanU1dGxMTldteTRW?=
 =?utf-8?B?RW14em1Kdm9aQ0gwWFFTbFBsNTNJS3BTbDlxMmV3bnZScWlzMUNsalN6dmxV?=
 =?utf-8?B?TVQxSGFvcktuRDg3VW1kM1daekdZWUE4LzEvNDBtd1BWWGdLMDUxblF6ZUZs?=
 =?utf-8?B?QVlTTDU2Q01GUDZKQVlEV2dXcytFTkRPWHhaeVBGbVcvZ25jeTdYWmZEeWd4?=
 =?utf-8?B?STF1NStYR2xmRFJtMXVMYmlhL0hRaWxxc0hmZmhqTmxDbG5rdHpyc3FzbzQw?=
 =?utf-8?B?SE1ha0QrRk9yTEtPYmRJRW8rTlE4QmFKc0g3VnhDcmQ3azdOZjEwZmNuVFcz?=
 =?utf-8?B?ZFp0cXdRbVM1cm9DSW5kK3dvOXBXRFNxajlzUHpETEE3WlBpS0RZa1RtRE0y?=
 =?utf-8?B?UGsyMG5GeEpaa3VEbU13NHpIUDlZNUFQZXVTeGFwcnVkL2toYnQ2ajA4Tmpi?=
 =?utf-8?B?Z0sxNk1DU0w0ZTVrYk91RXg2dWowSEY0U1pkOWdnSjdxbXZLZ0w0UXVqbzZm?=
 =?utf-8?B?TTQxQ0VnVm13R3FsZGNLaElQZHJZdTExMU5ZVk1UZUNEL0xBQW9lalM2amdX?=
 =?utf-8?Q?CzRPyks+8YwjB2j3g5RdqetFR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20b565c-c331-4729-c760-08ddfe83d106
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 11:40:26.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eGGKqnu+57zrw5h22Zb+nSiPhdGijqIa1/HXxcKdqzLN4Jn2knD4zF/YfV5qpD5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8861

Hi Markus!

Thanks for the review, forgive for being a total noob at coccinelle,
hence the many questions.

On 25/09/2025 18:07, Markus Elfring wrote:
> …> The script supports context, report, and org modes.
> 
> I suggest to omit this sentence from the description.
> 
> 
> Will the hint “scripts/” be omitted from the patch prefix?

The patch was merged already, so I'm skipping to comments that can be
fixed in a followup patch.

> 
> 
> …> +++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
> …> +// URL: https://coccinelle.gitlabpages.inria.fr/website
> 
> I suggest to omit this comment line.

Sure.

> 
> 
> …> +virtual context
>> +virtual org
>> +virtual report
> 
> The restriction on the support for three operation modes will need further development considerations.

I don't understand what you mean?

> 
> 
>> +@r@
>> +expression ptr;
>> +constant fmt;
>> +position p;
>> +identifier print_func;
>> +@@
>> +* print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
> 
> How do you think about to use the metavariable type “format list”?

I did find "format list" in the documentation, but spatch fails when I
try to use it.

> 
> Would it matter to restrict expressions to pointer expressions?

I tried changing 'expression ptr;' -> 'expression *ptr;', but then it
didn't find anything. Am I doing it wrong?

> 
> 
>> +@script:python depends on r && org@
> 
> I guess that such an SmPL dependency specification can be simplified a bit.

You mean drop the depends on r?

> 
> 
>> +p << r.p;
>> +@@
>> +coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
> 
> I suggest to reconsider the implementation detail once more
> if the SmPL asterisk functionality fits really to the operation modes “org” and “report”.
> 
> The operation mode “context” can usually work also without an extra position variable,
> can't it?

Can you please explain?

