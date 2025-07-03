Return-Path: <linux-rdma+bounces-11855-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B142BAF6AF5
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 09:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357824A2E09
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 07:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2A02989AC;
	Thu,  3 Jul 2025 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Wq16mH3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA02980B9;
	Thu,  3 Jul 2025 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751526000; cv=fail; b=FVyAGntEhkTkP+uKWs2WfR8wx8b7+03s6AzgK9mHLj91y1wVKzRK41JEIiABYj/R2VDkwwW8ae3iYBGMgdmkQq1kpo2rYXpv3rl+1TFZzTMN/bnvmNvitRQEdxd9ThH+8yfKh6OCEBSiU1D93cJ0+7iY5hd7zE5jOAg8wTwNkdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751526000; c=relaxed/simple;
	bh=AwCtrKEGkuHg12kBJHfcII9rz0Tz4xYH02zWzfZZqVo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lQDrvSYt+WrFsu9qsWEj0hmIaUC+OqlbiICHH+a3b3/URZgAC+8WVQZX/4MniVD13SGe2n60BIZCNn9zFMN6H3vz+vAXQuxfAM0GlTeHjA7608vQ5uj6BsHYfHvP+MVHyb4mjp/4XTwhqYlTwk6NxGPWlBqwUkO16yPvvQWzDDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Wq16mH3; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBm/ABdyl3LQ7DVctuiHIe00/fnbxSJuQZO/C+GRkXdw9CdCeFBNKusQ1t69Xy1fMFSbXGf0RHidxdyA2Fkralel+msbFcHetY/RvYaDTskCtPq3hG46+tkeOv2uUO6Jb/h6rhIeKQbqn+RCcHt1j6HGm2lBKY6lSrrvjN7oweAMe/nXELIXfb9IayOdEbf1sIz7EpUyU+ENzHzBUoa7SrZTl5i0ub3JLL4cRdMdPDQkrmLudBZNPO4bk0Y7vikYy8iwr3MKS/YHmcdHrassxc11XwsBxMEQspKaN3KqHg+TwalIlV202D9uJtqKPcqvHTM50ekEzendyD/ESFgBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeWy3Kl02ykoqJ+TdBrRafr4ThAOHLFxh8cvzNpNXDk=;
 b=HWbdQohZ4ghINYc76mkBq1GFJLk4hadS6vpAPsk7KwUzQRLggEUrGXQxgZZUBgAgGJk4we/+l9vk2XmXsDh+opGV1163YrbjJGMie5zFVa7knDh5Xqh9pzFtEpBA/wAL+PMLPntHtWs3HaKM8TcF0TGXK6ZgJ2OfBjg/XRHKFVRCFamQVKjIhtH3Gw8YuWIvprgkGOQFn9cwmbmr8QjNBtMmsTp6HJSKw8bCT/2u/B+OoJZMxhd2Ue27gzNAmzqqwIy3cjmvAeI3a71ZluDLCgiygZPHuQ5w1QWEa3VyXnv3SmFgu2XGro8UyuAHSLIC7YgLHtKPES7AEMckqRWl5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeWy3Kl02ykoqJ+TdBrRafr4ThAOHLFxh8cvzNpNXDk=;
 b=4Wq16mH3+e6jKvz+uBysPEd52DBH79roZYv3uE9lYKRa8+fhg4CkRE2SpNWhKs/P+7hDeYGTmnoNrEQlU5GmSA6syXwloRhMQlwIJzpupVnoPiE7bBaRlLZHqS7+Tj8X7Gh2ILYEe40zown5up9Xn5SCkBmdrnMBdAwPILteDBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 3 Jul
 2025 06:59:55 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%6]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 06:59:55 +0000
Message-ID: <23018193-6db4-c0be-05a8-ed68853bd2ff@amd.com>
Date: Thu, 3 Jul 2025 12:29:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 09/14] RDMA/ionic: Create device queues to support
 admin operations
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 jgg@ziepe.ca, andrew+netdev@lunn.ch, allen.hubbe@amd.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Boyer <andrew.boyer@amd.com>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-10-abhijit.gangurde@amd.com>
 <20250701102409.GA118736@unreal>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250701102409.GA118736@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::9) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 0049b0e1-8e03-4fb6-2f4a-08ddb9ff3715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SldPVkVYNlNqUURhU3N1ZTVBM1FvVHZKdXJBWi9zcW5hNDBhUUNzVVNKY1hw?=
 =?utf-8?B?blhrUTNHdHRBZ25pYWNtd2l6blJ5R0MxNHJ4cXFmNU5ncCtveW95TjhDclhJ?=
 =?utf-8?B?RmdnQXpoRE9sM2M0NkZod0xNd3p6OStSbGpPU2dhUjJXSXl5VXV5MTBBSHll?=
 =?utf-8?B?M2dPWW1qalp0RjBnVjBHOFNMRGU0dEo2d2pRZTRVT0tGckJwMUdTTXR4clRJ?=
 =?utf-8?B?dURXUSsxeUtrb0M2TUp3bFo5bXpFUWxMbjRnR2JLaTVTNUlKOTBOMG5oRTZp?=
 =?utf-8?B?aHNONTFjbkIzdTgveXJmK3N3NnVNOUFTTEVjb3lqa2J1QVVYcEdiQW1nZGdu?=
 =?utf-8?B?ejViYkI4bm5UYzRCSEJSYlZtZHFxWWVqdm9Dc2ExUStiSGRmeG9scHZtYWZB?=
 =?utf-8?B?NHZVUHBMcXRFUUxZc0o0Y3ZwdkZuL1V2czlZcjN0cjVLRW5BQmFLMUQ1WmNj?=
 =?utf-8?B?c0s3MitibEcvUU5NSmZSdEppZDNSRUcwdWQvSUk3enhiU0hrZURuaEJkNUQ1?=
 =?utf-8?B?dENrcS9RZHNHUEg0emZUYlE3Z0ROeFp6bTdqeDNlNGNkeU5zRXU4cVZ0WnJm?=
 =?utf-8?B?Q09GRFhBWWErcTBPbEZlSk5JZ3E3Z1M3L0k5YUE5RS93T2FlYjk3RXV5ZkEz?=
 =?utf-8?B?R09GQmFTU05DbXBkOE5rZlFQWndZS0dmYW5vcVFjS2RTa0Q1TEVIQnhVY2Jl?=
 =?utf-8?B?V3BZRE1Kd081MzA0K0FRdHJmZVRXVjhjNEhudDdXV3RWWmRZaStGcFlXdkNR?=
 =?utf-8?B?YlphdE1xWnFuSVJPV0JsRHhMaHVrcndUTjV3dnpBOTZHZzVxWFArVW00ZW8w?=
 =?utf-8?B?TlZJYlVwSVQ5Z2xzdDZSaE04Y3ptZzdHWmhtTmRmZnI2QjF3R1hTZ21QS1JM?=
 =?utf-8?B?NTc3akpDaUtBT1g4bGc3NDhuNGcwR3NzMVFvdnA1RGU5SDFPVlg1MUlOWVZ5?=
 =?utf-8?B?YmJuQ3hxUUZsUVZnRDZQelI5UEJjNmVnTVh1V1JKUHJRdWI1YnpLbTNYUmIr?=
 =?utf-8?B?UkxvZEJsZnR6QzlYUUpjZkZxejhENUd2clUwOE5iSzk3T1VycTM4bGxnMlpF?=
 =?utf-8?B?TEFuNmtrRktxVFlJZXNMTU9RaGUvU0hvNmFzZVFOZStFS2tnTkg3Z0oyMDRq?=
 =?utf-8?B?ck5pSVdFNnpYSzRPdUFQMU5la3orNkZwcjV1aXJ1enU4WlBBMjFiTmhXY1o4?=
 =?utf-8?B?bGFBeHZ3RGFWZXRYZkVrUVE1UDMvK2pkRi90UGxVdFVNSnN0cTU1YjRTbW9x?=
 =?utf-8?B?ZTZ3WHNoeVBVS3lVSGpXaDVaL3hDSlNyQTRDdGFJbVlwUytVQ2I3ZFB2QXc5?=
 =?utf-8?B?QjJMYzViT0FGMlpxOFE1OGJqTGxsL2dFR0VtdDlpTEtYUS9pR040QWFyUHdS?=
 =?utf-8?B?NVZKbVp4MzVjVVk0M3JjWDdtcmpoTFhpYVBxY0NlcnJZRGY5L2M5ODV0eGZL?=
 =?utf-8?B?Vi9xaStMK25TelBWbTNlcDZ4Tk9FYzhXWUE2MkFCNnZlb3p1NFYweWpiczZO?=
 =?utf-8?B?YzV5SVk0aDhJTDdyT3ZPY3h0QU1zNVNmM1ZPTFN1WnJMTzhmQzhhOWNIaVEy?=
 =?utf-8?B?a3dueXhsVk1aN3NtbncybkdyQzg1TjRaRCtFWEt4aEFOOHJTczV1ZW1jbDVr?=
 =?utf-8?B?SzF3KzFMdVJMMzc5Zjg1TklqdGlXd3ZyUExFTWc3cUFBSVA4U3hNcnhxR2Jo?=
 =?utf-8?B?VkZ3aWhvTGsxNDFia2RDOXgyby9LcERwd1JXdGVnS2M2S1g2ZGZRTFh0anNs?=
 =?utf-8?B?OCsxQ2U3LzFEdzhzVFFVMnB2dmdHTS81WHVtSmVwTGhWWlRGQi9IdzB5MStw?=
 =?utf-8?B?VnVYZXFNYUdRVko4VHBHRldIN2ZtbTY4YUEwY0ZsOVpSeWNZR3VYNXpkSm85?=
 =?utf-8?B?ZUNBMkVqN0dLTEJVRXpkYU1FRlVOK0NpMk9NVXF1UHBPUFhNZmVkbFMzYzZ5?=
 =?utf-8?Q?pgs1YEC03r8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1pGUkZWaTdSendIWGtkaWlISEIvbktmOGVGZVRxNVRlU0l0ZDZZZDNOQ1Nn?=
 =?utf-8?B?dGgxUVhkUTNuSVp3T0J2VVg4NHRPUnRJMTVHZlJTT2djQlhDZkFCMndLOHZz?=
 =?utf-8?B?cDV2cVZDZGpBNURJQnN1emVsWEJUOXZYUVJzaUcxeERvQjlpa1hDUWZNSitT?=
 =?utf-8?B?ZjVvbEVMQUhMZXgzMC81aXJkSVFaaElubzdhanl0NnovbXB3eXZFdVRsUFkx?=
 =?utf-8?B?amlJeS9waFJXSXhCb3RkMWZQeTBXemp3UUdRUjNIajBOVEN2NlJORVVIblI3?=
 =?utf-8?B?UkpqWnNPajJOc2JZaHRpbEIxWkJPdUtES1A2cUo5b05wZlg5M2tLRVZEUWhX?=
 =?utf-8?B?QXQ0YTk2YXJMcktoZkdRd3pYQmxmMXFKcTZJampWYmxQT294V2V5TloycGp4?=
 =?utf-8?B?aWJDTVo1MEdvY21VdkoxbnJkS0VwY25qN2FJNEFnb1ZLVkM3K0doQ2IyV2tU?=
 =?utf-8?B?WjZuYmVBQnU1bGtWUENrRE8wRkVUVlJFVHVXRnhnWkhONllUTTZjcTFpN2tW?=
 =?utf-8?B?WXdTWUd2M0JIQlY4N0dkbDJrYUdRTUpIbVN5ZWFzMmJIdXdrbFlBbzRRQ1BP?=
 =?utf-8?B?dGJRc3dnTkNGTXNjd3cxTlZsUzU0bzltNEpSWmtJanowN1dOdEgvSzFFU3Qr?=
 =?utf-8?B?eldKRXFNb1ZrMEtxZ0pNcFRRQUluUjUxWXRRYmE5US96TmtIR1JRb1RmRFZp?=
 =?utf-8?B?QS80MEVVY1l0Z2t4UWRPaWFTeWZydFVtdjY1ODhMQ0ljWEtzUm1MM0g3Q0RZ?=
 =?utf-8?B?dkpaV3FsL3hWSjl5QW9hTTcrWXY3UUNRUXJoUHRDNUdTY29HNEJNcnZmZVVW?=
 =?utf-8?B?NFIrZGlkS3lyMDl0QkQzZ1JnQVArNVpRbWpoTWpxd1I4eit0M0piU0RNTUU0?=
 =?utf-8?B?UThYVTk1bUxpWU1uZFVPcjdjRWhJdytoZ2dlSGxrd1A2WFNQckpPQTQ3Y2Mr?=
 =?utf-8?B?QnVCYnVQL0t0dXFCL3NabjZPS29BK0tlQTJ2TDJ4QjJnS0h0SnZVdzB3TjQ5?=
 =?utf-8?B?MEYwVW1qcVhEOHF1YTByOGUzR0VGbStodTl0VlN5eVhOUU10RDdJc1djdW9E?=
 =?utf-8?B?ZlBxQW5RWWpvVTZXMUQzWERWeWFpMllFTlpmSXRrcVp1UHJPTUFsUGRhUGFR?=
 =?utf-8?B?cDhWZmhmMjBNSXBYeGxCQWgzMktxNUdaK1o4MWZJUTZYUW0xSlBUSWsyVlB3?=
 =?utf-8?B?NktZOTdIWTNvNm4rVm83Ryswa0FEaWJ0L2hldFBBVzlkbFMvaHRVbGVFaUdk?=
 =?utf-8?B?bkFEY3VBQjlEK2lzYXo0LzQ1bzdKZjRwcG1TOE1oU2k1YXVqTmNlaC9pZ3c1?=
 =?utf-8?B?MzdieHJwajl1U0Z5Y0IwSTl6L3hLNnc1d28vNXdteUJUV242UU8vSVhTcURD?=
 =?utf-8?B?RzhiaGZRZE5iRlA2VlVrWFlHcjl6eCtORWFEb25YYXpPUnRnYW1lZG1hV3BK?=
 =?utf-8?B?UUhWb2J0cWVsaWhvdjZ3TGc3UzNIY3BNcFpGN1p1WVZ4b1RpRkk2VXFnUEVK?=
 =?utf-8?B?SS9VT0tQc1R1a0l4UXl5S0g5ZWdvNzcwY0IxNjJISi9xalhQNFlYcHZwczZz?=
 =?utf-8?B?TDJ5d1NpTkoyTVUvNnppM3VhUTZnb0dacWtMV1J3bENkZ2JKcExPK1l4U09K?=
 =?utf-8?B?QlYrdkt3UFRRcE9abXBRWE51OXQ3Q2M5MDFVcDE2cXdJYkJsU1c3ekhyajVO?=
 =?utf-8?B?dDR2NkZSVDFGUGdtZVhpZFRwZy93UXg2ZzNLU2VISzBCUHZFR01WRlVVMDhC?=
 =?utf-8?B?Tllqd3R4SGpNdW1sRFdCUkRONEJaS21hOWM4RFl5TTltN1JGYlNjWEtUK2Q4?=
 =?utf-8?B?TW51WDhnbmRqTGxJUTF3NHF3c1VkNkdZRkFKMnR0T2EvbHUydGlneWduWDNY?=
 =?utf-8?B?elhtQWZabTl0Y3JLN3Y1cGE0bEMzWFNaQkRhVXZ2dkUxRzZxNTNwWU55NE5y?=
 =?utf-8?B?alJjRTA0WVA4Tld3R1FVeXpYaThPT3N5MjlTYzVZTmhWUXVwVGpaU2FPeC9u?=
 =?utf-8?B?SlAxKzRzZkxTSHhMajV6WDY4alJrV3h1QjRQMXM1RXpUZGFCZlQxOEhLS3lJ?=
 =?utf-8?B?bDdDampwWS9SbjVRSGZ5TGdSN3NzYWtveTY3VmhzUU96S1M5dzMwM1hsZUtV?=
 =?utf-8?Q?ty932yfE3no0ucZ+olF0fZqAh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0049b0e1-8e03-4fb6-2f4a-08ddb9ff3715
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 06:59:55.1794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKKup1pBJSnjj/faz0HeJn+393PekwxbMezjZnyrdbQjfbYOcLjjZXgBQ0hqHP1QuJ3QVSRiXtHrRjcojGxSNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442


On 7/1/25 15:54, Leon Romanovsky wrote:
> On Tue, Jun 24, 2025 at 05:43:10PM +0530, Abhijit Gangurde wrote:
>> Setup RDMA admin queues using device command exposed over
>> auxiliary device and manage these queues using ida.
>>
>> Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
>> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
>> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>> ---
>> v2->v3
>>    - Fixed lockdep warning
>>    - Used IDA for resource id allocation
>>    - Removed rw locks around xarrays
>>
>>   drivers/infiniband/hw/ionic/ionic_admin.c     | 1169 +++++++++++++++++
>>   .../infiniband/hw/ionic/ionic_controlpath.c   |  184 +++
>>   drivers/infiniband/hw/ionic/ionic_fw.h        |  164 +++
>>   drivers/infiniband/hw/ionic/ionic_ibdev.c     |   56 +
>>   drivers/infiniband/hw/ionic/ionic_ibdev.h     |  225 ++++
>>   drivers/infiniband/hw/ionic/ionic_pgtbl.c     |  113 ++
>>   drivers/infiniband/hw/ionic/ionic_queue.c     |   52 +
>>   drivers/infiniband/hw/ionic/ionic_queue.h     |  234 ++++
>>   drivers/infiniband/hw/ionic/ionic_res.h       |  154 +++
>>   9 files changed, 2351 insertions(+)
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_admin.c
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_controlpath.c
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_fw.h
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_pgtbl.c
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_queue.c
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_queue.h
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_res.h
> <...>
>
>> +static void ionic_admin_timedout(struct ionic_aq *aq)
>> +{
>> +	struct ionic_cq *cq = &aq->vcq->cq[0];
>> +	struct ionic_ibdev *dev = aq->dev;
>> +	unsigned long irqflags;
>> +	u16 pos;
>> +
>> +	spin_lock_irqsave(&aq->lock, irqflags);
>> +	if (ionic_queue_empty(&aq->q))
>> +		goto out;
>> +
>> +	/* Reset ALL adminq if any one times out */
>> +	if (aq->admin_state < IONIC_ADMIN_KILLED)
>> +		queue_work(ionic_evt_workq, &dev->reset_work);
>> +
>> +	ibdev_err(&dev->ibdev, "admin command timed out, aq %d\n", aq->aqid);
>> +
>> +	ibdev_warn(&dev->ibdev, "admin timeout was set for %ums\n",
>> +		   (u32)jiffies_to_msecs(IONIC_ADMIN_TIMEOUT));
>> +	ibdev_warn(&dev->ibdev, "admin inactivity for %ums\n",
>> +		   (u32)jiffies_to_msecs(jiffies - aq->stamp));
>> +
>> +	ibdev_warn(&dev->ibdev, "admin commands outstanding %u\n",
>> +		   ionic_queue_length(&aq->q));
>> +	ibdev_warn(&dev->ibdev, "%s more commands pending\n",
>> +		   list_empty(&aq->wr_post) ? "no" : "some");
>> +
>> +	pos = cq->q.prod;
>> +
>> +	ibdev_warn(&dev->ibdev, "admin cq pos %u (next to complete)\n", pos);
>> +	print_hex_dump(KERN_WARNING, "cqe ", DUMP_PREFIX_OFFSET, 16, 1,
>> +		       ionic_queue_at(&cq->q, pos),
>> +		       BIT(cq->q.stride_log2), true);
>> +
>> +	pos = (pos - 1) & cq->q.mask;
>> +
>> +	ibdev_warn(&dev->ibdev, "admin cq pos %u (last completed)\n", pos);
>> +	print_hex_dump(KERN_WARNING, "cqe ", DUMP_PREFIX_OFFSET, 16, 1,
>> +		       ionic_queue_at(&cq->q, pos),
>> +		       BIT(cq->q.stride_log2), true);
>> +
>> +	pos = aq->q.cons;
>> +
>> +	ibdev_warn(&dev->ibdev, "admin pos %u (next to complete)\n", pos);
>> +	print_hex_dump(KERN_WARNING, "cmd ", DUMP_PREFIX_OFFSET, 16, 1,
>> +		       ionic_queue_at(&aq->q, pos),
>> +		       BIT(aq->q.stride_log2), true);
>> +
>> +	pos = (aq->q.prod - 1) & aq->q.mask;
>> +	if (pos == aq->q.cons)
>> +		goto out;
>> +
>> +	ibdev_warn(&dev->ibdev, "admin pos %u (last posted)\n", pos);
>> +	print_hex_dump(KERN_WARNING, "cmd ", DUMP_PREFIX_OFFSET, 16, 1,
>> +		       ionic_queue_at(&aq->q, pos),
>> +		       BIT(aq->q.stride_log2), true);
>> +
>> +out:
>> +	spin_unlock_irqrestore(&aq->lock, irqflags);
>> +}
> Please reduce number of debug prints. You are supposed to send driver
> that works and not for the debug session.

I will keep it minimal.

>
>> +
>> +static void ionic_admin_reset_dwork(struct ionic_ibdev *dev)
>> +{
>> +	if (atomic_read(&dev->admin_state) >= IONIC_ADMIN_KILLED)
>> +		return;
> <...>
>
>> +	if (aq->admin_state >= IONIC_ADMIN_KILLED)
>> +		return;
> <...>
>
>> +	ibdev_dbg(&dev->ibdev, "poll admin cq %u prod %u\n",
>> +		  cq->cqid, cq->q.prod);
>> +	print_hex_dump_debug("cqe ", DUMP_PREFIX_OFFSET, 16, 1,
>> +			     qcqe, BIT(cq->q.stride_log2), true);
> We have restrack to print CQE and other objects, please use it.

sure

>
>> +	*cqe = qcqe;
>> +
>> +	return true;
>> +}
>> +
>> +static void ionic_admin_poll_locked(struct ionic_aq *aq)
>> +{
>> +	struct ionic_cq *cq = &aq->vcq->cq[0];
>> +	struct ionic_admin_wr *wr, *wr_next;
>> +	struct ionic_ibdev *dev = aq->dev;
>> +	u32 wr_strides, avlbl_strides;
>> +	struct ionic_v1_cqe *cqe;
>> +	u32 qtf, qid;
>> +	u16 old_prod;
>> +	u8 type;
>> +
>> +	lockdep_assert_held(&aq->lock);
>> +
>> +	if (aq->admin_state >= IONIC_ADMIN_KILLED) {
> IONIC_ADMIN_KILLED is the last, there is no ">" option.

Will correct this.

>
>> +		list_for_each_entry_safe(wr, wr_next, &aq->wr_prod, aq_ent) {
>> +			INIT_LIST_HEAD(&wr->aq_ent);
>> +			aq->q_wr[wr->status].wr = NULL;
>> +			wr->status = aq->admin_state;
>> +			complete_all(&wr->work);
>> +		}
>> +		INIT_LIST_HEAD(&aq->wr_prod);
> <...>
>
>> +	if (do_reset)
>> +		/* Reset device on a timeout */
>> +		ionic_admin_timedout(bad_aq);
> I wonder why RDMA driver resets device and not the one who owns PCI.

RDMA driver is requesting the reset via eth driver which holds the 
privilege.

>
>> +	else if (do_reschedule)
>> +		/* Try to poll again later */
>> +		ionic_admin_reset_dwork(dev);
>> +}
> <...>
>
>> +	vcq = kzalloc(sizeof(*vcq), GFP_KERNEL);
>> +	if (!vcq) {
>> +		rc = -ENOMEM;
>> +		goto err_alloc;
>> +	}
>> +
>> +	vcq->ibcq.device = &dev->ibdev;
>> +	vcq->ibcq.uobject = NULL;
> 1. There is no need in explicit NULL here, vcq was allocated with kzalloc()
> 2. Maybe rdma_zalloc_drv_obj() should be used here.

Will remove the explicit NULLs.

>
>> +	vcq->ibcq.comp_handler = ionic_rdma_admincq_comp;
>> +	vcq->ibcq.event_handler = ionic_rdma_admincq_event;
>> +	vcq->ibcq.cq_context = NULL;
>> +	atomic_set(&vcq->ibcq.usecnt, 0);
> <...>
>
>> +	aq->admin_state = IONIC_ADMIN_KILLED;
> <...>
>
>> +	old_state = atomic_cmpxchg(&dev->admin_state, IONIC_ADMIN_ACTIVE,
>> +				   IONIC_ADMIN_PAUSED);
>> +	if (old_state != IONIC_ADMIN_ACTIVE)
> In all these places you are mixing enum_admin_state and atomic_t for
> same values, but different variable. Please chose or atomic_t or enum.

admin_state within the admin queues is protected by the spinlock,
hence it is used as enum_admin_state. However device's admin_state
is used as as atomic to avoid reset race of reset.

>
>> +		return;
>> +
>> +	/* Pause all the AQs */
>> +	local_irq_save(irqflags);
>> +	for (i = 0; i < dev->lif_cfg.aq_count; i++) {
>> +		struct ionic_aq *aq = dev->aq_vec[i];
>> +
>> +		spin_lock(&aq->lock);
>> +		/* pause rdma admin queues to reset device */
>> +		if (aq->admin_state == IONIC_ADMIN_ACTIVE)
>> +			aq->admin_state = IONIC_ADMIN_PAUSED;
>> +		spin_unlock(&aq->lock);
>> +	}
>> +	local_irq_restore(irqflags);
>> +
>> +	rc = ionic_rdma_reset_devcmd(dev);
>> +	if (unlikely(rc)) {
>> +		ibdev_err(&dev->ibdev, "failed to reset rdma %d\n", rc);
>> +		ionic_request_rdma_reset(dev->lif_cfg.lif);
>> +	}
>> +
>> +	ionic_kill_ibdev(dev, fatal_path);
>> +}
> <...>
>
>> +static void ionic_cq_event(struct ionic_ibdev *dev, u32 cqid, u8 code)
>> +{
>> +	struct ib_event ibev;
>> +	struct ionic_cq *cq;
>> +
>> +	rcu_read_lock();
>> +	cq = xa_load(&dev->cq_tbl, cqid);
>> +	if (cq)
>> +		kref_get(&cq->cq_kref);
>> +	rcu_read_unlock();
> What and how does this RCU protect?

This is to protect kref_get against free of cq in destroy_cq.

>
>> +
>> +	if (!cq) {
> Is it possible?

Possible when HCA goes bad.

>
>> +		ibdev_dbg(&dev->ibdev,
>> +			  "missing cqid %#x code %u\n", cqid, code);
>> +		return;
>> +	}
> <...>
>
>>   module_init(ionic_mod_init);
>> diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
>> index e13adff390d7..e7563c0429fc 100644
>> --- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
>> +++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
>> @@ -4,18 +4,243 @@
>>   #ifndef _IONIC_IBDEV_H_
>>   #define _IONIC_IBDEV_H_
>>   
>> +#include <rdma/ib_umem.h>
>>   #include <rdma/ib_verbs.h>
>> +
>>   #include <ionic_api.h>
>> +#include <ionic_regs.h>
>> +
>> +#include "ionic_fw.h"
>> +#include "ionic_queue.h"
>> +#include "ionic_res.h"
>>   
>>   #include "ionic_lif_cfg.h"
>>   
>> +#define DRIVER_NAME		"ionic_rdma"
> It is KBUILD_MODNAME, please use it.

sure.

>
>> +#define DRIVER_SHORTNAME	"ionr"
>> +
>>   #define IONIC_MIN_RDMA_VERSION	0
>>   #define IONIC_MAX_RDMA_VERSION	2
> Nothing from the above is applicable to upstream code.
>
> Thanks

I will remove this.

Thanks,
Abhijit.



