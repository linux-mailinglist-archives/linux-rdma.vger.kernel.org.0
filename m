Return-Path: <linux-rdma+bounces-12786-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53199B28B8C
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Aug 2025 09:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C231C886A7
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Aug 2025 07:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB6D23184F;
	Sat, 16 Aug 2025 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ItIhsOiC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A906621E091;
	Sat, 16 Aug 2025 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755330550; cv=fail; b=tVmpSQLLi0cQmXbnJT/2SsZWx/b6iChnYaejMrXYVdEyPbQiY6p+2kiS6tmibUEfC44MAF0a64XUczBIyfo0YFG0PopiZB7zUkAxMbaNxmVUjnRlbvxrfHA2J+oYAf1C60w2J1uL32W8vkILyOwTRgYVNz3YTLqSX7ZSbohhyGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755330550; c=relaxed/simple;
	bh=413VOUSJBQqg1odzKjbNIySRpEN+ZVElfEqXcaky1y0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SpjjWRWpUpUif55la19qnGP3npMm2iEgI05x62mN4zoh4fiPbuHMwhZrKp0dMYmnoidU/thOho2nHmNFfeo5xKYZEniTxA1a29c7953QaBoxrE+KOCwn7a5zDYxfTiAuwplRoZmhEl4igRq7/GQUWifoiadAiKvFeVZPi2tL3h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ItIhsOiC; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y00rF6bJoVFg9sXr/IQSejBdhzWRtfPodKD+M0VP6XJhbVsAQOgsANijOW2/ec1wvXRnk9cSwV1J6si6zQ8VQqCuN3WnaKv2SV7mhpr+JFRkkDr4g9LP+X5EWiUSnkE5bDg1f0QexhwDPUKIr3gEe450n0HMd2hsJQ+VLhj+iZxgabLqAu9oTl1mPfmS4qaahkhpMqJPoYyNc+l/LmNV3OwJqravT/3JWKQS+BdpNiXB/CyP/1eMu5jHs2CJ0TANi4WuUOX/GJqLJCIqS/jZA06wMUtGeEi/4Kfjc8z+E0Xh6B15ET3Uyq0clL9NVA9R+6P3UM6UMGG36vDehGpxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=413VOUSJBQqg1odzKjbNIySRpEN+ZVElfEqXcaky1y0=;
 b=PZRlvOwudYEZ4P10BUM/q0srIDIY6uI+JXBdDx08PTV3AtphFlHuy38xIeaS1aGt9TDkDsguqOU/o6Ea08r85oVMpSTMqs44mpjpQmFv8Xl7rLswJMD+GhlAJGQBwpQ4JtqIXRPzJkXdKLHste8sKJuBoTl/QhqGSdCJ9p6/UK0ekB8imckxRacTswoWPzqV4gnc3q4SJ7V9UZzivNuAzRNTaoM4toNU9bdjVteScJaMoD7WzpojEAmVn40mvbr8l5mW6jo6XmLwxwYBvSsQ+4iTGJDPspzT88wyp+ye04nXlzsMIt1M10XCjgguxxSgUBGy7XBmoMU3D2WEOBjGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=413VOUSJBQqg1odzKjbNIySRpEN+ZVElfEqXcaky1y0=;
 b=ItIhsOiCgVdqtrHL0WizIUfSxjCCqSQp1jiUv2g8c1s4uNnvsZBr7k8Tdd1Cw1NxxSNDsA2BrMK1uixFTernqpMmdCjwV61Hwtj0MzMzs9IyIc8S2Hp+KcejSqLiWmgmk6P8oiSWOwelsRvkvdgnCwX3RaTac4LXnX1XVjenUgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Sat, 16 Aug
 2025 07:49:06 +0000
Received: from PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f]) by PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f%4]) with mapi id 15.20.8989.018; Sat, 16 Aug 2025
 07:49:05 +0000
Message-ID: <b9bc57d3-bc76-b4b9-e17a-02a083b7751b@amd.com>
Date: Sat, 16 Aug 2025 13:18:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build
 environment
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>
Cc: sln@onemain.com, brett.creeley@amd.com, allen.hubbe@amd.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 jgg@ziepe.ca, leon@kernel.org, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
 <20250814053900.1452408-15-abhijit.gangurde@amd.com>
 <095d545c-d3cf-4029-9b57-639e27a7fed5@infradead.org>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <095d545c-d3cf-4029-9b57-639e27a7fed5@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::14) To PH7PR12MB9066.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9066:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 84081a4f-8398-4cb0-f264-08dddc995fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlkwZzI4ZEJPWU1UdDlJd0Z4T2VOMStLd1JHdURHZ2VDT2NtZ25ESUM1ai9K?=
 =?utf-8?B?SCtZdkhvSGRaVWk2ODNqcGsrZjIzajkvSG8rb1lEU1l6c05wemUxelFlNzY5?=
 =?utf-8?B?TnZwaWw4WW8vQ3g0OFFJcUlibndCUnh1dC9PL04zR1NWeXp5d1YzQ3hIZjdz?=
 =?utf-8?B?VzhjY0Z0VXNFcGdlM0RlcFhaSzBjcmNOTWMvNFhWM0pqbmZ2ZW1SOHo0cUYy?=
 =?utf-8?B?c2pWajV0OUwrZGJRTUpNYW5iWUkrSlZVZHJWNVBDVms4NlBMNTRpSnpCSDZ1?=
 =?utf-8?B?VkpieWV4Tko3T3NGV3Z1b3NYVTQ5ZG5OWnREQTVSOGdwdHp3VWFMK0prUlo3?=
 =?utf-8?B?RkdKVERVV0pUNmZKWmpVWEd3Nk51Zks4VDFnblppaE85b0JHSVdBa2JTbWc0?=
 =?utf-8?B?TVBkZEFZaW9NaUhCcTNJcW1BNWg4Zi9lRnZqMGhqTDBwQzZQa0cvMk1rYVo4?=
 =?utf-8?B?VjBtc2xEcHg2N2czQmkyamV3dnVHWGM0YmplNDNqcURGWGZWVzQySUs3R2xH?=
 =?utf-8?B?bk1oWjdkcHk2QXExZmlrNUROUVlPcjM2QUJDUENyOThneXlZc1ltZ1NPVzkv?=
 =?utf-8?B?M0RXaWZOc3ZUejJFR3Y1dEphanBOM0NrSU1PbW9GV3FOSHhpK0ZlMkN0WDNm?=
 =?utf-8?B?RDdWYWVRNFBEd1k4N2xYcEZ2QlV2T0d4VWNkRVMxblQ2bFhJV052MzcvRXlx?=
 =?utf-8?B?M2FhSWNjZlliWHkzek5aVXBLNE13VkpEL3ZUeU5yMHRaTWJSL0VBUU1oMjRJ?=
 =?utf-8?B?amhqQ2N5Rjl1Vm83L091Q2pnUHpPYlRTdm5QdWQ0RnVzRjZtU2VCVGpxR1gv?=
 =?utf-8?B?L0VwKzBmYzBWVFFSREFkeFpUdlVnVG8walRGNFNzdjFMRDdsVmhmZmExUXFE?=
 =?utf-8?B?cDd5WTU5K1A4Ujk3cHh0RHdTdzlJRVQ0cVBlT004Y1VzdFllMFpEaEFpL2Ry?=
 =?utf-8?B?ZHRqRmxsRElpSzhGSDBDeFJXckl4ZW9YbnJtODkwVG01bGN1aERpODBYK3pG?=
 =?utf-8?B?Q3JDcVlMOUhUand1c0dCSC8yMGF0ZW9zU0hLV3NJZ3NGenVFSGJYWXZmMEZZ?=
 =?utf-8?B?K1VhYjZyalgrNEJxSCsrUHQvNXh0TGRoL0szdjYxQlljbzNwc240VHBydHlE?=
 =?utf-8?B?OU9hOTM4ZUlxUFpRaVJWUy9HRHNUQ1Y0YTdjTXVxUFJ0c204NlBMMDFKNmt4?=
 =?utf-8?B?MHM2bHppeC9vWWtXN2ZDRm5hSGlnY2pjcFBoSm15VU5qR1dBbkpkL253bHBi?=
 =?utf-8?B?dEZJbWFSNnhOWWFiNkYwdGJyTWFDU09rNjhTeGNVTkhIOWsvbDR3WEZiL3NY?=
 =?utf-8?B?eFdjSjEyTzRBOGFDekVuc2lKaVloSnBaUDdkM0psYVdkYlJPbXVqVTlnZGJn?=
 =?utf-8?B?NU9XeUlJeXovdDJJRUloUzVDdDlVSFNoRGdDVFdHU2V5VG9DTlFFWEpJdkI2?=
 =?utf-8?B?eGtBQ3NqUXlDc1RtUXhUTFpHZDJ0RmtqeHhTTWhqSG55ZENyZlRJZGczcVRH?=
 =?utf-8?B?RSt3TVhwMFkzM2tSQUxyTVJzWmZJY2JXanR2K25jY1ZtSTRZU0hpam1EL3J4?=
 =?utf-8?B?TUtOY2dvazEwbCtRTDdrS2k0R2ovd3JzKzBiT2xrbkVodDgxNGFsRVNoWU9W?=
 =?utf-8?B?cmZPRUxpR0V4eTVzTXRwbmhjRGxHQUkzTnhpRjEzWVFrTWNHV3JvUTh4cE1P?=
 =?utf-8?B?MCt3UVF2Lyt1b0dKeEpMN2dtWXlhWDRMZnZkZVJxejJaMU1JRzR4NTV1b3Zh?=
 =?utf-8?B?TFUyeE82UWtndkQ3SFoxWXo5YXFGMEFkZ1ZxL3dRQzVsalRwblFnN0wzbEo0?=
 =?utf-8?B?bDZoOURRMEphZ05la2ZJZ1I3NTQ5SnpUV0tMN0lHWHp6WUtPM1kyRHdQNFky?=
 =?utf-8?B?TDB1R3g2b3dZUXZPb1IveDlzVlBqUXlkWVdpd1dRdDRVbW9qVEkweDlqR0JC?=
 =?utf-8?Q?oIazxVQkOOQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9066.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTBEanRHZzNXZkJJY09jSVI2eHhxR3hMQnBJcmdiUkFsMjN1WnB5a0lCWVUx?=
 =?utf-8?B?cEdTM0NZWS9idXhYK0ZNQlp3cTY0MUNYNVZZekNMM1lHRkd5MlJCb3RTeU5o?=
 =?utf-8?B?NTllVy81WTNXZFhZMXA3TU5zVzNsOUo4NGtDVWM2b0lEbkVTc1cwWTkvVHB1?=
 =?utf-8?B?SERQbko0S0ZKZXFLMmlPOFcyeXNyb05NZmI5VWhlQnRYN0UyeUNRcTFPZXBC?=
 =?utf-8?B?WGtNUjRBZjM1M3lGVFVIQTk1SEpSbDM0Yi9JcGEySzlQUFdpK2hpWEZOSmEy?=
 =?utf-8?B?VXUrMVhRb2dhMnJuaktlMlgwVDhNVFVPV3UvWVRWNkY1OVNLQlY1d0E4NUpD?=
 =?utf-8?B?YVVkSmxXOXZWdXlOS2gwUEExRU1wN1NjazhYNGxGVGZaY0pVT3ZHYVNONmFB?=
 =?utf-8?B?Mi9pTnFqT2gwSWRTbWxkS0g2NTh2RTI0c0gyVFNmbERWVXB5WURSSXJBZVQ5?=
 =?utf-8?B?QnE0bFQ5RXhEcDUyaFBxU3d1U0RuVGp0VHluU2haYnhORStPVW1VK2k0dU1R?=
 =?utf-8?B?UmxZNG1mcm5lZlU3cW0vTHJaelRvdEdLMkMrOENYVGNzVkVlOWNseExkUW81?=
 =?utf-8?B?bU5GVG1TUjJ5QnNXUE5rVmlRUkJjY1ZBNUdzd0E5SlRxSVhXU3Z4OWNBTDlO?=
 =?utf-8?B?VVRUZSsvekdsUGF3bEVQM05uek0zQWphdHFvS29kK25LNEZvYjlRWlFTVXps?=
 =?utf-8?B?M1lUL1NUcTd5VFVKeC9RSUdWaWVPTnRWNjdHM3RmbG1xbFJuUHM5Zm1BTWNz?=
 =?utf-8?B?Z0JWM3Z2dEtlM2p3VHJUMVJ4a2NhK25pYW1YbXAyditKQzQzcVRNL2UxSm1G?=
 =?utf-8?B?ZEhnTTZjSkdIeWFxWlRaTE43ZE5MUHVWNWFoU2FLNXdVZDRIbDljWUFUVUts?=
 =?utf-8?B?ZFFMdzdrNnB5b0ZyaCt0clkvMlJHa2p0bnhtakpQcXhPTnBpK0xqSWxvUTZC?=
 =?utf-8?B?Skd3czVzYmZhYUhGSVZYZXNzL0lUU1FPSTVKbUJjbS9ZUFowclVndlIwU0pH?=
 =?utf-8?B?QllTNUFQSEQ4bUZiUXAwUEo2ZUF3QWlRdnNIejdsY1huUGk1OWxUZGFqcjFD?=
 =?utf-8?B?Zkd0Q1JhWGQ2clhhd2RlYThvbytHd1pXZG5keGhFd2pudk96b0pwQTFEb3pt?=
 =?utf-8?B?ODBOd01WcCtPUC90clcyRzhLMVlPemN4Qy92TzlOZXFZU2V1VHpzWk1qNXJq?=
 =?utf-8?B?WHdMVzlkUzlua3hCbDIwQmQ5TjBXVTF5b3Zjb1gzMWdZVy9xY3ZwKzFPcVp4?=
 =?utf-8?B?NnY1NWQrV25oQlBEY1pzR0owcjJuczZQSFUzemhtcVhkRWZMYlp3d285VXdy?=
 =?utf-8?B?N092aEIyVDlHY05GT1BYL08zLy8xcGNoa1d4Nmo5VXNodklxeFBUZ0NDMTNo?=
 =?utf-8?B?ZHRhZWF3ZExjUzJpZ1c0bnNJdTl0KzRKUlMzNzZrVmtJNUhRY014QWpNMVBM?=
 =?utf-8?B?QkxMSVY4S2xVVHlYeWlZd1FXQStLOE9RODhQenI2VUVQWjVVUHZicC9Db25u?=
 =?utf-8?B?RXltbnFJMlBQWW0wTWt6V0VyamtzYmZjdFpTbFE1UzlEQm55RDlmVXVyb2FU?=
 =?utf-8?B?aEJHZnpZVWpIYWJrd3Bya2p6L241NEk5WjNnbVFXbW5MMmh1bU0xUDJCWkNs?=
 =?utf-8?B?YVcrNTlXUkgvVTAxYWVxTWV3TStUQitsMllKbU8vSEE1L0dJY2NSdFlCVzcz?=
 =?utf-8?B?a2U1Yk5lYUlUREZ4ckh4Yjd3NUJYQm1wYzJnM05McTYxcy9GMG9YaGdiNHcx?=
 =?utf-8?B?OUQ3L3pBSTZKWWFCVUF6QlhBSkMvSmNUUXdlN2Fqa21XakRBckRoTkQySmJw?=
 =?utf-8?B?UUV6QXNwUjFXODVZeGk4a0x1WENBcnhHTHJWMTNCS1dScXg0T2pia3pHWmNR?=
 =?utf-8?B?RGRaelRndk9JMUdSSkNNTGVIYVR2WVc2U2p4MmllaDhrKytOQVA0VVRaczMx?=
 =?utf-8?B?dVVxSVJIdWZZUFlOZWxaYmRMdUg5eW5zYkxjdzZObGZTMHMxcmptalBYRGxy?=
 =?utf-8?B?WjNyaTNoWDBsUkdJRkRFQXk1cm9ZWUdTNjhaWlo1N2NnRksrZnJ0Q3FhZjlZ?=
 =?utf-8?B?cUkwcy80bUQyU2VSOHA2NzNqRy9KRndFT0pKMlpLbXhwdmNFYnptTHZBdnRJ?=
 =?utf-8?Q?8n2QtrjVdTykZP64GBZNJ3jL3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84081a4f-8398-4cb0-f264-08dddc995fc2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9066.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 07:49:05.5234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEBSzpFx4rLcbozm7om6795qrbUTlLac8noJvx+Xpi3/PKp1z/oleF8+aAvl0PeR02wvxxlSHduuzr2vLZUgOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095


On 8/14/25 11:33, Randy Dunlap wrote:
>
> On 8/13/25 10:39 PM, Abhijit Gangurde wrote:
>> +Support
>> +=======
>> +
>> +For general Linux rdma support, please use the rdma mailing
>> +list, which is monitored by AMD Pensando personnel::
> s/rdma/RDMA/ 2 times.

Thanks. I'll correct this and other places in next spin.

Abhijit





