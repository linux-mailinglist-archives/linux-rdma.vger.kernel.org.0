Return-Path: <linux-rdma+bounces-8685-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B14BBA601B7
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 20:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E13E1891EA8
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 19:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93C31F3D3E;
	Thu, 13 Mar 2025 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KG9Trz0+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BD1EADA;
	Thu, 13 Mar 2025 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895969; cv=fail; b=Uei3AaU/rZS9xk02DZHWYLVVEbQj50Pz9rKLIIGhSyrdDceprStIsKaZANBYKBEhoR95ppDnelJlNaAqmFh+kQGT9OiHSiKaBFb9Si9n3bMRDS/hNyFuht+K8LAG0NuETtYCcvImtTK5FjLLnVzQ81PnoEbHLGhrKa+0nfU2pO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895969; c=relaxed/simple;
	bh=3wASSuTxWS4SonpdW1HqAGbLhjWZgGo/yt06zbZvwbg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TFlVMVhrAqsuuInBvE7nyh9EfXNNozyPK6MeteIDxV72/wh/Ib1kfMtKwNNmLMLqEe+j3ac6neh1GkRorDrH4uqquqM0c38XpfVJjpWCTngFLjEllhiO9yVqRlN5GUjV0RCry3o0fUUT4Fk8lje1sMhvp+Zsil8XpdDkXjDYmWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KG9Trz0+; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoNcpQKQP2G1EqONot5/NT1cJASdDHDIbn5LBcixvqaUFe0ra9XhwIMuqQ4OSre9DxSodJUeo1YCpxZLfZXX2X+AxYDAXOPZOVqPN7Hb/SemHPEw6vIlpgV9cPOCESKhdICd/f4SvE6vAPZGRi2jymFXHu+dZRgvnmShuaALN2QouKdxpDqTsg8B8ZgRS5XgctGfIGI/gnJNjwE1OiEVkC8xggqJzzhsX1OipFIBxQDYBtafIvoWHzUTxbsfg4S8Yeu3b7vAPSLRJVlwyxSvPU5ik/mlk25KbNmnTwAh6JIj3O/ENzFQkIxxzr7sfvjHwTnW/KTRgdSrDCVUjGE1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qxmI2It0spz4tK2uglLsthrOAFBqr9X1MIqork1FGg=;
 b=N0V/3RAir2PO+BUq/9PvBJczqgUF0B10tqbQ9gCUOb3m6zCLYAqza+h8DRifQDzge4i5ZGa9l4SlS9TS/AYiQ5aAhvizeb9snRZm1mtGaTl5lHiuY3eTt62rH8JGBCGO8Pdx7ow+pqoan3xebN+71lQkuVGjh3QZJtl/WFv8+381xTfEuB6FBwGScqxzoSFdTzTy7nxQEydO/Xa0qohJonMCTjtobzjVCcuBi9Sa9mee0WUyTQAoYWEDH+a11GD2Tsy6k0rez1vJzYjZtR2uH0QD/WBUqEb86Y8O4He6Uoyfnmz5ZLRMKxE9cF7C9+XLcvqgbIl7VzbKHC2Qyn7yMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qxmI2It0spz4tK2uglLsthrOAFBqr9X1MIqork1FGg=;
 b=KG9Trz0+uIW7UfvFCOBVku3YFedO6GvtRSUbZxYpKXYVE52J6khGO+v3OYvNtqolb2KO69FZfEACoRBbxG55/OYomfixmf+SF2KN4CLhgfv12yjHty14xS1LXj6QnjFJSmVL7wMNS1VA2abyjlUCqCo7V6fNEDzn0rX1V5BLr3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 19:59:23 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 19:59:23 +0000
Message-ID: <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
Date: Thu, 13 Mar 2025 12:59:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
To: Leon Romanovsky <leon@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 "Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org> <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org> <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
 <20250313124847.GM1322339@unreal>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250313124847.GM1322339@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH3PR12MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d03064-7cda-4bc1-d850-08dd62698cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU05TGtHRFovTUVaOHpQNnFKY3FhVWRTWlUxYmRwUVp2ZWduYnpzVE5lL0ho?=
 =?utf-8?B?WkNYVXZlR3pVQzRIb2xGSC9JOTN5SCt4U1NDak9yWktHVlhzc21FVTdHaEZP?=
 =?utf-8?B?M0ZIdFVpN1Q1bkdVdGtnNkU1azYza1dTS1ZKUEtyOG9rdG1ocFpxTHdKYjRB?=
 =?utf-8?B?VlVjRU4zUXhXOXhpcXpLbm5rR2krU2FJaDFHbGxzMTV3TFQrQjJCYmdRaGNP?=
 =?utf-8?B?bFJGamRXS29tWGU3Y0JJVDdKT0tCbmR4cjkxT3BILzc4QkRKVzI4NmFFeUYy?=
 =?utf-8?B?bENvU1g3N0tnL2owbFR6ZjdOZ3p4TEdmb29iTFJTZllzcFhPaExPTEZkb256?=
 =?utf-8?B?Mk5iSU9mUFVQTlNHMVhsdkd0aUpuUjM0MU9RSndGbllud0E2YVVZQVRXSzV3?=
 =?utf-8?B?dnBrNEZuT29wT2lzdm0wS3ZGc1lVNVh2dVdJbzgxbUxDRm9NTjdyM1RuUGxY?=
 =?utf-8?B?YXJpcGJwYmhhcU10ZmtXcW1nMnVDWXdqb2FnY2U1MXdORlFIR1RMUVhqRUls?=
 =?utf-8?B?SVpyVk1xTysyZGxnRldyY3pGaHZxL0xKTGtVUEcwaktibHE2ZkZqa0NLaXp1?=
 =?utf-8?B?bGFoS2x0ZWVRSDNPbGpDQlc2bjR0YWVmSVlQQWhtZDBONU5DTFVreWhtajg5?=
 =?utf-8?B?N0x5aUQ5N0lSazJBRjFKUTYvY1pMWEx5MXJhUVdNYjN4SnNqeWo0NlR4OVZj?=
 =?utf-8?B?K29UcmRmWHBiYldtODFYOHJvdmxpVnhoc2Vyc2hnS1JYRC9jWVdZU0RlUlE5?=
 =?utf-8?B?R2hEdVA5bGFQVEx6TmM2QjBFQVloK0xEVVlqU0twdGFHQ0RIc2ZCNlJrZmhl?=
 =?utf-8?B?UkxBc1FCdVFodlFuRXlZQnZTVTB1cmtqLzNJd3dNV2pOYWlOQVFZTGFZM1dC?=
 =?utf-8?B?QkZSeG1jdVZ0ZEI3ZTBJL3JiSEpTMEx4QlcxeEFBb0JXN3lPQVdLWm4yUDlF?=
 =?utf-8?B?T2NvZ2JxVFFyMjVJRzZnd2ZRbWE5NFJNQTlZdEYwZzVvZ0FOZ09MN3laWnFY?=
 =?utf-8?B?VmRSR1FsYVpveFZBV21LdHNVb09IUzBJbUpnNG96Rm1VeUxuUHFCQkJ2N3Zu?=
 =?utf-8?B?QTZYalNGUk9xNE1BQ0gramZoeGhSZ1RSd0tNNjhmWm5MNENhMTQwdUN4RldH?=
 =?utf-8?B?dXRzUi9UTVRUN2t2ZWhyUnBLeDRjQk5Ja0JuL0thSFdWUW5JZ3NqczVzSjJ5?=
 =?utf-8?B?R25vOGR5a3JsZENVZzdBb1phN1FVYWRpbWhnRmljbWR5TnNQV0w5RVZSVDIz?=
 =?utf-8?B?akRHWXA5dHg0eC9LZ2Rlb0R2bVNQZHZSdjBaNHcyMUNNRitmMHdZclR4K0ZR?=
 =?utf-8?B?bjNLUEFHcndEOFBwSnZER0Q5OEpucEYzUmsvNXV2b3h6YkJUUTR6QjdPdGp1?=
 =?utf-8?B?NERXSVVqTEpXUGhNOTY5aThXRy9zdGlzaUtEVmpuNGRXeDc4N1VodVM5M0lo?=
 =?utf-8?B?clNNL05ZVWMwRnE2enQyK1B6NDR6d1RaNVN6N2hRVVZvV3RqSEpxTkRQbVor?=
 =?utf-8?B?OFZraHprbU9mSHlQZDk1dW9pamtGdXNkZTRobDVoQURPR05vTmRJbWpBUVBP?=
 =?utf-8?B?bDdtUFZQajZkN251dXJ1akxWeExyUkxTbTVZTjFvUXdBRHBuZkxwdWtEenJK?=
 =?utf-8?B?Q2VjbnJ0TFAxclZ3ckw0cUM3MFQ0M1Q4SnFNQzUvTEtjQ2FXV0lLUHB0ZzEr?=
 =?utf-8?B?S0tDaXk2Y21lek5KTFY5cTA0RjlmRFg4QjZWYmdZMm5GVXBRQ2paY3cydGt2?=
 =?utf-8?B?NGdwWFlISnVOQzVQY2xhNjA0RUd6UEs4Qy9raFBEMHFuMWpCU2VxdkVkRGRX?=
 =?utf-8?B?N1lCdUFQeE0vQll2UGtyNXN0c0g1YkJnSS81cTlBYmlqQkRYRHBLeEl3cFJr?=
 =?utf-8?Q?wHxhVSf2Lks9W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1RrNnFaQk9UQXNIOEFuaWFpVkoycHFLckduN2tDekVnTzFuQk1tMVlFQlJo?=
 =?utf-8?B?Ly9NR0s3cVRWZXM2NURUSUdzSmxna2Ird0lRRmowT21pVHRlZDhGSzR1M05l?=
 =?utf-8?B?Tyt5WTZkWkVRMDhwSm9TdTNNTHNnb1h4cm0rSVhjRkx3dXVFZWNvV285djE0?=
 =?utf-8?B?WGtDRDFSQXd2MnJPZlRLVk0rVHlVMDFOOXl6RlJ1dWFKbUExYnNIcDV5ZlVL?=
 =?utf-8?B?YU1XZDJJWVhSKytkVFpaUUFZTkRRZjFxbnRnM0MxNGRGNlUyd0s5THVHYTQz?=
 =?utf-8?B?NUo4czNLRUxYTGRXZnVSclpPM2l0NDlXQ3JVRTlLQmE0VG1mT05pRDdMdmVQ?=
 =?utf-8?B?cVkrTXI0STV1MzZxK0JHWHFvSnp1VTFmVi95OWhZSmRkTjFhMW9lMDlNYi9G?=
 =?utf-8?B?SzhONm41Z2hmN1VQdmhRbnFOdGJmV1FLUGxJNjBiZmpVWXYrVGpWcUE0Sk9s?=
 =?utf-8?B?cWlTY29VS0ozRjNEcFQ4bEhoM29lWTNDZzVmZUQ5ek5RVFRiYkovdFRLRi9L?=
 =?utf-8?B?T21kNHloOVV3MUxpV25YdENiMDRGbjFVOUMzcU9BMVJUYUEyM0ozbWxXbWJq?=
 =?utf-8?B?ODBXMFZyVEswcWt0WEVsdFR4QWFzSjBTMkhkMVJ4TlZBTEhRSWl3cFQzK0JX?=
 =?utf-8?B?MUYvMTYwK2RncWs2YjNvMkoxc0VwOGM1eStQN3ZPODVHamNtNmYxNStDYTZ4?=
 =?utf-8?B?Sy9GTWR2SW9qSzczeWh6Q1VrTk13Sk9NTEdzTWhuMXMyemxickxwaUJCc3lO?=
 =?utf-8?B?a2RjNVNPT0pxZ1hoSHpLWGVrS1E1N0xleDBob2RpOWFSZkcvL2lqTjIvcnJG?=
 =?utf-8?B?eGpqeW05bGhETFFvQWRhSGg4NzVTWFpXaVJSa3N1Q0VyWmxZalRwcnpReTRL?=
 =?utf-8?B?QnYvMUVnaElYUlJBODZjNkVzSStRMDUxM05iME5hSTZyelZleFB4Rm9qeHMv?=
 =?utf-8?B?NmdiYlZYQnZwNm9BOFlVMm1PKzdLTllra20vVzVzZXBTRGJGeGwrZE8rN3pm?=
 =?utf-8?B?bWFoRTMrZWMwTTlpQitYNWJUTk1uT1NmRnUxSUNsOHpGQW53NzZiMG43ekZW?=
 =?utf-8?B?RmVlTk84cHlLZkdzc1BaMU1Mc0g1U1dqdzdacmxDcXNFUDhGUldlRERDMmZ3?=
 =?utf-8?B?TkZXZ2NUT3kxcVlGOVJHd2xQVTlXTC9FelNuUHlmcG0rSTlXZmpvN1dhNG8r?=
 =?utf-8?B?cCs3SnJLMFJYYTlOVUVqZHlWUnVXS0ZMeU51VmJsTjhIdm53NXBmY0tqb2ZZ?=
 =?utf-8?B?ZHVWSG5jbnpJanFkS2RFM0hIQUZnWUVBdmJBdlJqQ1pBK21pL2xZK2dORDJy?=
 =?utf-8?B?b1h1eDZqNWs4UXVMMm85WjdMaHpCT2lZWXArWFFoeEpPaVZ0YkNyQWZ1ZVRQ?=
 =?utf-8?B?eEJhL3cxc1RHTFlyTVlmNHlDaUZHeEVRQVFLSzJTYWV6MXBvQkcyKzYyOHlK?=
 =?utf-8?B?TFRUOW9PblJCcjk2U0JtWklQbFBCMlhkMU9GQnMvcU8yYmNSdjlZVzF4dlNV?=
 =?utf-8?B?eHFOckNYYkp1dlpVNkw4alIwcFhSYjA5K21sNTJSejRSM0V6UWVqeHpQYktE?=
 =?utf-8?B?MkVyYlYyUlcwemw2bnozSW95aFIySjNhL0VacThYbmRXY21xcFpvY0o3VFpF?=
 =?utf-8?B?RUxLUWptK3Z2ZHY0RjZNaFVFMzZRNVFMUUlwcHJ4aDZEOWcwSzNHNU5rZE9t?=
 =?utf-8?B?Rit6VWRUV3dURmJmSkVxTnFZVWluOXI1dHRSdUVEZFg2ZUpXVFAwdFljU3J0?=
 =?utf-8?B?SmN2VjFQd09CV0VqQWROZG5MTXdxMWoza2lxVnkxQllmTVY5UVl4QnJYOWZi?=
 =?utf-8?B?THNGczdQMXhpR0ZGTEdseWttdm1aRzNwaHdzdEllUW8rdUhIM3BQdDAzOE5Z?=
 =?utf-8?B?S29qdGVvZmtzUktJekNKYkwyRjNjbkNEa0hiSTlSNlBrNFVoSlBqamN2R25i?=
 =?utf-8?B?bnNSTmRXN09WT2JpSUxZcE9ZbmJWTFREcC9EQXR2TDQrd2ozdUV2SDdrc0ZC?=
 =?utf-8?B?VXE2R1cwSGtPMU1qV3FNclNBQ0F3QTF2N01uSnFLM1MyaHBybGlsd1RrZ2o5?=
 =?utf-8?B?NEVkMVRDSlNVbithYThvSmU5ckczSnhTVEZOdzdZYzZ4YjlXUUhNVXNiS0N3?=
 =?utf-8?Q?s+HbGy1KSvUecgb7JPX552dS8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d03064-7cda-4bc1-d850-08dd62698cbd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 19:59:23.3208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mQVgJkDvuke9pGDm6m5j1/yU80l3qXnArSreV5uBLLVlqFku5Fzjx1dcQ4tYCaAYyYc9aL7lq1O4U/8k4UOeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499

On 3/13/2025 5:48 AM, Leon Romanovsky wrote:
> On Thu, Mar 13, 2025 at 01:30:52PM +0100, David Ahern wrote:


>> So that means 3 different vendors and 3 different devices looking for a
>> similar auxbus based hierarchy with a core driver not buried within one
>> of the subsystems.
>>
>> I guess at this point we just need to move forward with the proposal and
>> start sending patches.
>>
>> Seems like drivers/core is the consensus for the core driver?
> 
> Yes, anything that is not aux_core is fine by me.
> 
> drivers/core or drivers/aux.

Between the two of these I prefer drivers/core - I don't want to see 
this tied to aux for the same reasons we don't want it tied to pci or net.

sln


