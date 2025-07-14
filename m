Return-Path: <linux-rdma+bounces-12116-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D43B03981
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 10:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41836169BEC
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 08:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCD723BD0C;
	Mon, 14 Jul 2025 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DtTbhh0a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D120AF67;
	Mon, 14 Jul 2025 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481446; cv=fail; b=MS2O7jqvLSRefxmPm8O7AUz00+uJnMy/9O0Sha3h7ZtXnkjEC5OYZkjUc652ZSzwtL8XO3yYRZKWPHIvhjSeEZZi4oaVOX8rz5Ppb5CqURnzzQu24virUd0tSDCjbOOEyJ75MDySZMkElSWPXXx/BllotzN35SD2nD5ajyThDhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481446; c=relaxed/simple;
	bh=1G2WXmuonU3b2nidIsrCknOjUR8EJbTS9WY9RFnAO8c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sxYJjDIWST2ZsusJBPM/TCRqcdi+p1Nl8Hy+pky6PzOV6El+EZu3p2gMcgSMPf8e+QcrKn3dcLDtfCE2eLu5l75DhS/wzCFSxGxU3a2ytK9wCFTR9YUeXR7KjAUJsDOtSZx9CE0FPEUoYD/3BSYYHI8QIJeWkRCTHIwbReGYaXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DtTbhh0a; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYIcXrFvIdbqek6yeSgHfn9OIDMZ/uPyL8OsHzqrZor2pkDraVzM2VUN1sMrfVo1J3vEEHCF6gWKE77gxlWg+O4dxg+6plM4zizKvsEaVRiUdbIx4c+5BHpkaKcmyk0sFp/VnLnEdYHVuyPcddZ4nF+qqyBuYGC3KKvtWICA8xCDrcnhPc2gQNvOBxQbDwCJvxFP2WtGyRetsUzjdVH8V63mfVfh419AOc91U8M6GHmTbzi+Vwu3zz2fhHFC4mpjcG4HdirCR/Z5rC/86iFpyFR9BklUJUJI6Um2rWhkKe1AeSTQbiPigvd2YOvgIqYDuzlze9JtJujWFkcQ1MKMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tmedp25F0Iny6XfKY5zROQp++7lpwTe5ceDr5SvfG8=;
 b=mSlcY22GRa0cfw6PnKbxEdzARAauc1xtANjoa+21eWi7pRGAhqOTsvx3W/Ic+jnjv9ApCbeT8vxV9xvy/EmD1n+TWw3yqLbJQEC9QjGENnjvnxyU/oBoOWCSNTeHLxCPlBkpgaCXv4I/tTI0NoxhovVwsXlXktn+JX0BRqApjtC47WRZNLe3BBT7D6SQ6S1pNn/Q2cwfzT4y0lEAzpm9BvLKeEVzEIN7aw2VrLZkNp6NKMgZPNYdEWGqKJGKPDaNGoSYAt3pdm9I4QdDJUjCcN39Za4SjJSNtd7U0dghO1307VlVgfB9UEymGswBn/6MqcLK1cGVae0XxKNB2R+Hbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tmedp25F0Iny6XfKY5zROQp++7lpwTe5ceDr5SvfG8=;
 b=DtTbhh0aTuFUF7DxVXQnFhcSN1TzZY+75WItOepjPkYOJvZG1BjYCKCiomJ4sPSXme2jRLaA2VSzHlrbQmO8qPr0Q8Pa2P9ne6TD4LNBWrqKt941OrbfUU+ewFTbAtoSOQn56aXnlSB15ikHJR1mNlY6N9uXqOxGPUFtChQFUAjnXi4G/EtjsCPXmoWbQ4t4KwxWOXSBBlJGES9WoPBuHlb0VXgy+vyNQZFI5D5SvAHdx+nfe+IC6Q7BPqZabUTyHd+gqntrqdSyWO+y+b8u1vR/RMKhxxUjLFQpQZqjSkrFMgdG8MTi91tOr9OBqNAINz5NKOKnqnFE/UeG6E2DCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Mon, 14 Jul
 2025 08:24:00 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 08:24:00 +0000
Message-ID: <3661dbe1-2a17-413b-8353-af12f4f37038@nvidia.com>
Date: Mon, 14 Jul 2025 11:23:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Correctly set gso_size when LRO is used
To: cpaasch@openai.com, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Amir Vadai <amirv@mellanox.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250710182629.78456-2-cpaasch@openai.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250710182629.78456-2-cpaasch@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 92efea62-4f97-4acf-4876-08ddc2afc898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzIzQTRldGwwL3Fnd0k2LzRPZk1TbWswdUF1MWJSMnQzTGhSVkJNaFNBazJO?=
 =?utf-8?B?cUozYU41SUxYYmtoU1plVit1ZkdSMkduRkUvQXM3ZmExS2JhelVIUE9iRVEv?=
 =?utf-8?B?Y3hiR2NpMGNnK0hDK1NDbCtZMmNacWIyYkRYTnNES2pvdTRza083ZVdQUjl0?=
 =?utf-8?B?cUtOTW45UFp3OTBYU2ljRHVFMEJsalBKT2FyWmhhU2lhakF1OTFhU3FGTXR0?=
 =?utf-8?B?UmZNWkJUU2tvTnc1bmUvVWtuYTdkSUZVbWZTNGJTM1FUK3owYXBPUzdScUc5?=
 =?utf-8?B?YlBtWGZUNUZSSyszMWx2S3FJZy8xNXFpM2YzaE05ZXRqTVFlRS9QYWtwVXZ6?=
 =?utf-8?B?U3NvWEM4blBsbEFGQlFlVC9ja2lseEo5aUs3Vmk5emVTOWVxdFBTQXF2UTNJ?=
 =?utf-8?B?cVhyR29oM3N6YVp1TDVtbnluaHZoRDF1V0VMRDNqUmtac3BUd2laOGNOeHRw?=
 =?utf-8?B?MlUxYm9uc0dJTTFCd0ZUTC8vTlN4ZE5PUnU1eEZ0Q3cyK0EzL05MdjhURG5W?=
 =?utf-8?B?OTAvdlNDaHQ1a3U4ZTR4UUl5NURrc1h1V01EMHN3dmNTZ3NtVlJzMktiQnFi?=
 =?utf-8?B?QVlmQ0s0dWNFcHVNMEJWUk5YRkZ3Qk1aZjEzYndmUWZYa1F0ckVmNFpMUVhh?=
 =?utf-8?B?SWJ4UnRqem11bndpbFg4S2N2TDlnUURiVEVmdXZRU3c3UFI3S2lLb0JienNt?=
 =?utf-8?B?U3F5bzRpenhZTmJjekdkekNRYlNhc3RjOFdTOTdQSkVlZi9Ka3JSeDNUN0Q0?=
 =?utf-8?B?OHl1OUFtT3o2aWVLMHdFckttMkFrN0pEYzhvU3Z2bFppY0FTbmFCaE5mWVox?=
 =?utf-8?B?Z3RMVWFzS1VtQ2lMT0ZOeTNBeHppdURBekZUV0VvQmpzSk5oU0hPUTF1OGVN?=
 =?utf-8?B?L2dvYXJPVi94cXl4akVkUFFhcTFvOWRtY0duQUt3bzl3U0RsWThJRlVrdkJV?=
 =?utf-8?B?WkNaaFVDN0ErQXpSOHFUd2pzVStmMEI2VFBDd3ViV091aFVmSUVDMzZjd0FU?=
 =?utf-8?B?TWpFck5mZXg1ZFBvOHppQ205Y0tBWUhMQmJRRTVxOTk1dzRJMzBhQWRva0lz?=
 =?utf-8?B?bGFBbUc0L3M4VFBtdFl4UGMreXg5T3o4TWlPWFB0Zk9ONEtlY1F4a05Yamdy?=
 =?utf-8?B?NDZHanNkVEhGeDJXVEpYTVJFQXN6NlJFbzl5QmJMNGRFMTBRU3ZHZko5WjRN?=
 =?utf-8?B?SUNHZlkyYVgyVm5aekpHMXdJTmNCNC9SUFY5OXpDMk1oaDJYTXZUUzk5QXNj?=
 =?utf-8?B?KzZlWVh0K0FVckJPbWFFWEc2bnZBbWhVOEo4SjlBUEcya3NXTHY5ZzRUdzFk?=
 =?utf-8?B?SnBKWFFCdllobDl2VTVESEk1MlpNMkVRNXVNbzd1b0tkRklRU3dmL1hNNGJm?=
 =?utf-8?B?d2I4VU5CWkZyeENrOGhFMGtSNWhaeGt3cDkwcmRubmJ0N29ibFV6OTlTWXg2?=
 =?utf-8?B?R2FCUDkyZ3ZQRXBjOFNOaVlpcHBNalhFQ2IwT2RxT29iTGFLa0hOellxOTNk?=
 =?utf-8?B?MWY1ZHdHZTdxYjJ6eElZZ1I4ZW93Vm92dXdpbjhveVp6clZ2MnhFOFZLaFlS?=
 =?utf-8?B?MzlWZlBrNFZpRzlQY1YzdGFvT0VReDB2RXBkWnRvM2RIazdaVFdhcGYwbEhB?=
 =?utf-8?B?Q3B5M2F3R3RlYzZLVUVMN2FibWNlN2tVVTRETXV4aHJHWnJKZnVGejNRaHp3?=
 =?utf-8?B?dS9JaEx0RTdlUXJrSloxUWw3eUh0QjVxZGVFMytVaTdqOUFiRm5xTFo4YjVL?=
 =?utf-8?B?QjZYcVkwcmtOUU9NN0toaHd0MWh1NDJRSnZSRDI4QmdlNEtpTnNHTCthSUFG?=
 =?utf-8?B?YzBFbEp6bVBtc3cyYU4yR0p4ZDNQZ2QzbXRlV0FOMGJaN2tKdHp6MzEzdWtX?=
 =?utf-8?B?aVFPSWE0NGFqekJYcEQ3eUw5QklBK08yK2ZGVGV4Z25HYnNtcnJoVUlzM2dE?=
 =?utf-8?B?TUg0aUJNWVc5OEtCZmFJM3R3TGhOWDdvM2RBRWpzOW1VTCtLbHdQLzI2QUZW?=
 =?utf-8?B?L2lzZ3VHR0x3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVVVdk45a3pVWXhJWEVnUmV6ZWJnY3Y4cFJHWFlycG5ycE5hK2VFKzFEZ3Q2?=
 =?utf-8?B?c3FBeDF4Nzg5V3plS1dyclRuYVJ4cldQMW5DTzNLUGxMVnJRcytkZVZxSERq?=
 =?utf-8?B?bjZpSlFNTjQrVkhzL2kzckN4cjk3OTU3cGNqemlUY0UxY3djNXZmYzRBbjB6?=
 =?utf-8?B?RzM5Sml3cmx5d1RkVTFkb3JxelNhbmJZRE5jK2lrSkpYbVJTK3hoTHNtZXhZ?=
 =?utf-8?B?YmVEa1pwVk00a3JLU1B0aEl0c0tkNExWcjhzRjd3SnBNVmticW5oMDVvaTl3?=
 =?utf-8?B?czVHQ2tTTUZCOVpMMUQ0N0tLSHpaSCsyeW56NGFIR0xpMGtocStPVVk4eFJN?=
 =?utf-8?B?WmhoeHIzbTdPb0JkUkdlUUtJci9vaE1DZ0o3ODBhNUJveTNUOHRTVE1Tb1Zr?=
 =?utf-8?B?czdQRXFiQWs4NTRYOGpManNoUzR6TTlhQ0FZT1h5emlFUzNIU1hmL21HNkxS?=
 =?utf-8?B?NitqcXYveUl2YTJhWjhWeUlhMjdKTTRwUVY0ekFRcVhsUXZSQXZ3bHMzd3Vj?=
 =?utf-8?B?UUp0elp6cSswSTVkVG9ZT1Y1UGdLaTRCcEhId0VVY0NHMHRKcU5pVmFMdEJR?=
 =?utf-8?B?QzdNbUxsY2tjdEdlb0o4bnk3R04vQ2F2U25mSjZlajA0c3pxK2RSdTFIZE5H?=
 =?utf-8?B?Y3QvNjlCeUltc2owUEFGWENqYVZKRkhFZWdDNTlvN0gxQmlJUGFIZEswK1Nw?=
 =?utf-8?B?VEFFTEo0YlJ1OTF0TDVjRzJwK3pXQ2xpNm84cjU4YVdNTmF0cmdldzB5a29y?=
 =?utf-8?B?ZEdGM2xCU1F6VHFqdDVsYXVSczQ2Y29QUVk2aktaWktFdWlIS0NocDBJNEVh?=
 =?utf-8?B?YUFzL000SlpCbEJseVd5ZVQxTTlaN210aEhaeGh4U3U5Tmw5UHdtd3VQT2p1?=
 =?utf-8?B?RWk2cHI0UDNVN3N1R0pOUUVVNURXVC83cDJiT09nV1Z6OUJKM0plLzlVaHZo?=
 =?utf-8?B?UlYyNm9zUVBHK3hsZytVRUc1K1lmOGU5eVh1VllnQ3JZZ2hmVlVoYW9DQ1I0?=
 =?utf-8?B?bmRPb2p5TDZJNjB3eHoyK09zdFE2cHYrV2FwUmd3WkdvNTF5MEdERGVKYzZ4?=
 =?utf-8?B?Y3c3UHl4blRCazdkTjNuNEwzRmlzWEJpdmhpOWRwdGphbFBkdGoxbWdGamVV?=
 =?utf-8?B?SFl4Q3FTRWdoZUd3MUdyZC9XNHJVaUd6WURLbm9tcm01VHV6eFNQUFJkVC9M?=
 =?utf-8?B?SFFEZndFcnpPZ0c0ZmRreEJCNzBQODVrYmFXa2IraVhzWlZmWCthaGx0SVl0?=
 =?utf-8?B?VjJ1MC85NVY2ZHVoRm03a04wdE1COTVQa3paTWJDdlZ6cUpKemZmU0pJZkZo?=
 =?utf-8?B?RjY4VEhrN3pWN2dibkZSNkx2ZjZjRVBDMzlFckhvbXJPaGRxWUFRc2FRYnZ4?=
 =?utf-8?B?SzI2YnNRVDBtc25jUTdGZjFpZmZmMTZ2LzF5V1VWZGhLeC9OTG1WanZKd0tv?=
 =?utf-8?B?K3EzUTh2OUVxZElGc3pQWHg4dnl3am1qOEpLcmVVcjU0Z1NZb00xbjNZSFhj?=
 =?utf-8?B?ZUFuRmpBZ2E2bERBQnN6TW9ZUnlhQVNzeGovMFgwUy9UVDFIOEUvUFdicVZs?=
 =?utf-8?B?dTU0dis3L2pIblNNYTRBWVlNZmJvSGJpWXB1eW9aNjlBYkNuQzFSRXcwUjFk?=
 =?utf-8?B?VlU0TkZLTFl4ZThYZHRHZGNlQzJHdTVPZUNadUs3dS9MRFJ0d1VTS2tCbm9W?=
 =?utf-8?B?dVNYR2RxVDRvSmNNY2lZditxTWhPdkNHREdmbHh3Skw5b1JoWGhMZExrb01n?=
 =?utf-8?B?dVJxK2FPNEdxb1JFYVY5UDJFakVUVmlvWmpxUjJqUFZHM004NzRqWFVBcEdM?=
 =?utf-8?B?YW1BTng2VnB4bjlocjd0aGtOSW5rbk1JYWlUWnpOS3o2ZWlXejNYSFRLSU9a?=
 =?utf-8?B?ZnVPWmtTZHgzQlAyckNkNjdhSXpjMzBrOWtlaDgwQll0RUd2WGw0TUhYMzNu?=
 =?utf-8?B?bVE0aGFHVjdPUlFVYlJ1Nmptc0pmMXpFMW5PTkdXNTBsdkVqalY0aDRGbTJ0?=
 =?utf-8?B?UzhMN2VibC90cGdVdDYwZldpSEVxRTFjN2lDRTF5OW1NNk1zQXdOYS9nbHpu?=
 =?utf-8?B?VXg0MWl3NExpbGxRWUYveGYxaW84SFJSWmdPQVlaRlBXdFRCUVhiVXdmQXp2?=
 =?utf-8?Q?EY+36vDuL2nOwMKNtVENYJ454?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92efea62-4f97-4acf-4876-08ddc2afc898
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 08:24:00.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkzt0A05tuI0IXkmPy7FSvlujN4sii3eJ2BzMB56UmtwaUk2BBAIzGyUiycUvNCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743

Hi Christoph,

On 10/07/2025 21:26, christoph.paasch@gmail.com wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> gso_size is expected by the networking stack to be the size of the
> payload (thus, not including ethernet/IP/TCP-headers). However, cqe_bcnt
> is the full sized frame (including the headers). Dividing cqe_bcnt by
> lro_num_seg will then give incorrect results.
> 
> For example, running a bpftrace higher up in the TCP-stack
> (tcp_event_data_recv), we commonly have gso_size set to 1450 or 1451 even
> though in reality the payload was only 1448 bytes.
Other than introspecting the wrong gso_size value, is there a functional
breakage that can be observed?

