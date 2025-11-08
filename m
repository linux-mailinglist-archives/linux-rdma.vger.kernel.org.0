Return-Path: <linux-rdma+bounces-14326-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544E7C42BBD
	for <lists+linux-rdma@lfdr.de>; Sat, 08 Nov 2025 12:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E717C3A5F1E
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Nov 2025 11:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7100C21C173;
	Sat,  8 Nov 2025 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dCWaApXQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF93C2B9B9;
	Sat,  8 Nov 2025 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762600640; cv=fail; b=LKvagfpZ0NwfAyLyUZq7MuZ6GxNPiOo+SpXsWxtov+ds0T4oPkWa8FPLaqE6ODixu8MAcvJHlikU6+U6zxLWP9slR2JeW+AOy478+CD/FNJ93mYInT3TF3Q83jgt2IRQ1JCP6vADMsN+YY3D7kxP1j/0rnkWtcCmJdQRhqe3IUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762600640; c=relaxed/simple;
	bh=GbYTV8crjE7/A1KH9CEMPGcjAuCrmyExygASOL/fCu0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jlwYdlh1hS+LjlFz8WabgjQVqcbqgBZpjnZlUMp52r7LcjSxIb60Xc2cYcnO3AIwbstEBMpihIR2JCCUfB1x+Nl8djbPB50aBIwwkDu/6xJ0pqf8qBGZGOJf72HwwXaOvji+RRPLspmySEXgaBkKko7sOxaIIaKxNJWGBpfz3yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dCWaApXQ; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQIL/C9MxCYzIKURh8o1mYfAVBT7CmO5gB1vK//FKYux0+OTcYiax/baxfltu3dFNlljQPkqDXSG453mU4jr1rFhjzrCEZHDAthBXq3nSZVwccFD7YVssRxYOMmKrUIlGSR7PCq8q4DL7dqpnI7li21XBcmwwxkrsUkSBrIgFSogTVMrhaso+2z1p937aOZ0NpI45vgs3xCg4T0Mqwa8+KuN8W7yiKLloD2+uPTVuACnK4jQeBrhdT0G6m1btgDNUCZs5A73BQJcc6nh+tqYluroibMKHFsJkkh1QN/CsfnbSkMHPaK/2+ri+PuRxSF751XYyXni7slC5OhId/z0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdLBbCNWqs+1xaxtjP5bj/G1Nbv7ym/Q3TesPYa22Ew=;
 b=dRQT5EeL+x26ZlOB6hmf9cJr2yZ38672zKXcbxs0yZhB8xvaRdtqmZvo1wR6JXTnZXWN4/GJemXzFsB0FrAdn48ZHcH2WO+q118UungchoPK2JlbIihpZO94SVhDPt9diEZTOOv7qunW1x8bmiFUIsRGLdXcOioL4Pku51RvEb/rDCpcZpSUVhlhYER+hE3V6RCZWYJHBogBukJvNWLXg5y/3iQbIckGgYkZuyv7KOuvDNSN6HyDLYF1Q1nvIaAmTwOwSO9BTGF+sK5YrB/zyBwK6MYUrw60ijHbR7sdT+B6HGcCsVUQen/6a5/iZjcvrrj9kH59eoSX5lXYW/ZBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdLBbCNWqs+1xaxtjP5bj/G1Nbv7ym/Q3TesPYa22Ew=;
 b=dCWaApXQITFAaUjw1KiaAx/n4iSXAL9jHkEDcF14edvRTS3vCZooT1EHPtU2kDulyBLNQ5mnue7GS6EOKJYnBIf5LB4ahb4ICy74T+v6bbRTqh0PQjG7mrSsdxzma3WDed2aGGCzZHwS9wlNyqWIF6lcKD6s//dL2JnGSeFVj2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Sat, 8 Nov 2025 11:17:15 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 11:17:15 +0000
Message-ID: <93fd05cd-b227-42ab-8d96-7873a830e6be@amd.com>
Date: Sat, 8 Nov 2025 16:47:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iommu/amd: Don't call report_iommu_fault()
To: Jason Gunthorpe <jgg@nvidia.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Christian Benvenuti <benve@cisco.com>, Heiko Stuebner <heiko@sntech.de>,
 iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Nelson Escobar <neescoba@cisco.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Robin Murphy <robin.murphy@arm.com>,
 Samuel Holland <samuel@sholland.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
 Yong Wu <yong.wu@mediatek.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, patches@lists.linux.dev
References: <2-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <2-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0213.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b93074-a0f3-46a8-fbdf-08de1eb85ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VENmV0czVUdEeDlNZDMvM2F1ci9SRmNUQ3M0ZjdCcS9jaGNva2ZrUEpsVnRP?=
 =?utf-8?B?elkwTnR1SGZ0TlIvdEVocFJ3TTd2YjRqaUNEejI0VnZhT2gyU3k1SExYVjZl?=
 =?utf-8?B?RkQrSTZ6R1JWSkhRbVVSRUtMRWF6Q29ubnlXQldTS1RnUUJFNFlwSjhzVnlS?=
 =?utf-8?B?dHY2NXlQdjIwL3doVGpxZGhyR2Y1ZnVGc2xmOGtYRkpHSE1IMU5BYU9WaG9a?=
 =?utf-8?B?bmx3VW41eGZ0aURmYUE3MGxqRXNDdkphK2JsVVBtMnkzQWI1UTZqcmIyQ1dM?=
 =?utf-8?B?WUV1QVFHQjBmdElJNk9pRWxZcUJBbU44UEs3WUZNWWdkU1pQc0E5cnBlbGh4?=
 =?utf-8?B?NDdkRmEwTXUzQkk0Y25ESUhtTURqblord0FsKytLVWZQNFNkOUtWQ1JyeWVR?=
 =?utf-8?B?aU8vRlljVzJLQ0FxQmtxSHpuWHkxdzBETDdUZXdlR0VyNWFpZkRYUXg4Qzhk?=
 =?utf-8?B?SVJpNDl5RW82UUhubkNXMzN2NkJxRGFBOFhhVTdUSmp6UllLUEpydlU2U3Jy?=
 =?utf-8?B?blVOZ2IxSjBOcmFTTUFNVnhjZ0VuS1JGOUJVNjhob252TUpJMkxsWHVnR2lw?=
 =?utf-8?B?dndrTjVjRFhXaFNrR3BkSTZCblpCSGdUVit3Ym9nOGdqK0MvbHhOWDV3REs2?=
 =?utf-8?B?SWxpaFJiQ0dCSDRGU0FFS0gvTGZTeVJnaDJZMW4yVGRWeFFSSDc2cThOelhh?=
 =?utf-8?B?V2J0RnFWdCs1MEdPZm1qTjBQbkFzVjNySXJFTnlHNWVmQUR0QkFxcVBqL0FT?=
 =?utf-8?B?Q0xOd3RRV2lkU1dVbFdqWW94aGxQMFdPcEIzQ201M1hPSklrY3hlS2pZRS94?=
 =?utf-8?B?eDlUQnc4NndZWFdJdEZpTCsyY0dSelF2ZWRSK01tbDUwVjlRSXVsQ2luUWMx?=
 =?utf-8?B?SFl5Z1dIemd1WGNzVG5Ra21CTHp5N2VuOHYyZnN5N1FSV043bTF0V1FsWnVT?=
 =?utf-8?B?MUw4NzdpcklCRVRYQUMzNmluNWNNQS85WFcwYysra0FoWGRCbHlEeEJHM0Fz?=
 =?utf-8?B?RkllUGQydmRjY3dBSTMwWTBmSkVIWlFtdm0wd21NcUppUkg3djIyRVQ4dHEr?=
 =?utf-8?B?OTVWYlI5VTRJUU5XckZyK3ozZTMrMk9uL1NsdHBaMWkvS1hoT2ZlTzY4MW5Q?=
 =?utf-8?B?T1ZGUm9udFFUcWVNMVpxTUExR09qb2NvcVN2dFJzeGloc2VCTUZ0QU93VXNU?=
 =?utf-8?B?YjE3bXkxWWViUUVBRU10a3dpbWdhdUJvZDlkRDdKRWtVeWRiL243Z1FtbFRL?=
 =?utf-8?B?NDhOenBKSU1kYnlTTWJES1NTc1owR3hIUVp3MXY3dGx6NTg0YS90RDk3Ri9N?=
 =?utf-8?B?aVdOT1lUZk9QN0hBdHVaekxhK3RSVzJQRkZOOUdPTDN5Szd5eWRmV2lDSmFl?=
 =?utf-8?B?eCszSTdmNWZPUWJySjdCbEd1RWVtL1dPaGNZRUllejRRbEdBRlNOSDRrbjg1?=
 =?utf-8?B?WndmKy9VVGFIQ3VlaTNkaERqVEF0S3c2V2pyUmp6VmpGRzJOR0Q0SGo1S1Jp?=
 =?utf-8?B?ZVVoSVRnU3VreXArTzgrQzA4K05LazlhajllczIrcjFoazJFQ08zclVtbE5B?=
 =?utf-8?B?bmxFZUlDK2Irc0VQT2t2eC81a2JjOS9VNHFxY0EvRW5Ycml0Um40Z0taNENH?=
 =?utf-8?B?SlVZdlRSblpoWVBLY21iVmJObms5dXVMY1RwUVJML3pwd2w0MDc5Z25SaTd1?=
 =?utf-8?B?WXRMZjVhaHY1NGRXbGZPc05PbFNwM05uMXdYSjI4aHg4M2RjdUQya3J4eHFz?=
 =?utf-8?B?ak9WR29IeVVHeUlZaENrTVlkYWJLS1MvdU0raS83ZDZzeGoyNUdqdHRwWmpV?=
 =?utf-8?B?dTRTelVUVk44TFkvTWRJWnlqU1NoM25EbExwanhkMkE4T21VdW9YaXpSS3Fn?=
 =?utf-8?B?OEtIR2ttR2dBcTlncTZEYmVTN0ZoRFVPblpQUXh5NklwTnhsZXNJUXZhR0w3?=
 =?utf-8?B?TGJWOHUydUF4cmthRWEycjkwN3Z1Ly9ZV2REaitIbnNYMDZCTURnRGY4dEti?=
 =?utf-8?B?VFppcXYvY0x3ZWk1eVNBZTE2aGdQOHhEOFFIbDBKNGRiakgva1pCOEhyTndE?=
 =?utf-8?Q?XZjVKY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnNxMHJpa0hXSU8zcWdaM0JGSDlDUGw2eUphczlaQ0x1ZGg2SGduRGZJeXJC?=
 =?utf-8?B?Sk81ZmQwemFpOEwwa0Y1SWFpSENFWDFGRmxZdWlSYzNxSkIvaXdSQlBieHdj?=
 =?utf-8?B?WnRhOGJaM3dGcTBvbit3UVRLYjl5MGlzZzdvRHRyZlpmbThqQnB4dEl5eEhR?=
 =?utf-8?B?cHdHNm9BQlduQnpCRUhkVTZWOFpYbGRSN1FySDBRQzJKRXFBSFJBa3M5SmtG?=
 =?utf-8?B?VDFKcjlMcDYyWXhDREhKRmVjRnN2VjlkUVFnOEVqNUl3b3pCd0ovd1ZEOEE3?=
 =?utf-8?B?SlBOTWhWdXBBZDNXUjVpVDN2RThtMFJ0V0REWXJQYjhFSWNYSURDN2xuWHJi?=
 =?utf-8?B?V1NGcW9FWjFUTmhKZnJuU2cvRGhxbHNDcjRiRmo3ai8yQ2RpRHFUVk5iZzBt?=
 =?utf-8?B?c0FuQUE0QTlBM3RvdXQyUWpJTXBXZzFPNGNPUTFHTDRDdm5Kak9JMk56OGhx?=
 =?utf-8?B?c2tqZG53NDNGNG5udHU3OTFlYlJmUVRnTk1aTHFmRTdhQWZqLzFVcmRLVnUz?=
 =?utf-8?B?MHZKNnEyZzdjZzFGb3ExTFRKVFVnaUdDWVlCcFJLMHluUkVQVU02UnFSM045?=
 =?utf-8?B?WEg1OWxoVVV1ZloxMTJNMjk0TGNwNWp5M0JxTUZKbGNKMGtGY3FwdzZxU0Nj?=
 =?utf-8?B?TG1Rbk1hL3l6ekUwYVE0Y1lkMFdWUFJzOWhIY3c0cDZHY3NyVkdGRW8zWkVH?=
 =?utf-8?B?bHQwM3pFOUU0eUpXU21PS1gxUXQwNG9xN0p3NVR6QlZWYmNyOU1QcUhpdUh5?=
 =?utf-8?B?N3V2YlpJVHcxaHhCWm1JbGNkSnJNQTNjRzJNdzN4RDhlQlBpcXc1eDNJZGx0?=
 =?utf-8?B?OStYRkJJRER0YVJ6RjlmdU1CRnJKWXhJZFNRZGc4dkRSUk5Iek1qbnpzaVIr?=
 =?utf-8?B?R0Y3ZkExR0FhQ1VKalhEZ3F0STk2K21mckIzbFVoS0xoZDlreVEvaHNvUlRX?=
 =?utf-8?B?OU5pNlU2Mk1VTlR5WEZwSzZyV1NjclYxSSthZ2hqdmdQTWJycldrbXdDMmpa?=
 =?utf-8?B?SmtEdGJwS1lmTnlLSldrNjg5LzY1NnpwSTJPaTR6alBleEY1VW5qSGZSOVB5?=
 =?utf-8?B?aFphWjR3bHpuelNORjFsRjlZR3VRQXlIMk0vVm4vQThPUm15bDJmdHp1Yml1?=
 =?utf-8?B?Qi93Y1g0REFKTlR3MnF0WDUrMmhnbzNLaDVtQ3dUNE9MNkxrOHgzbFlhUTdt?=
 =?utf-8?B?QjNkMTFnY0pNL201b21mVGdUcnk5czN0MkFTWDB6QWp3K1lDRE5IU0dtN256?=
 =?utf-8?B?T0EyeUdTQjZxUk1EdVk0VURMdmljeE1VVGpwT0hCak1wR1RIRVpKbndnbXNW?=
 =?utf-8?B?MjJqejI3OFovd2dhWUlhSDJCL1dXeGN0cW8vd0txQ2VRMmNKTHJ0WXNIbGsw?=
 =?utf-8?B?Z3hQeHA2NTJEWEJ2QmgxSDhneGRGaURJV3doTzdXeXY0ai9oTktRSWN2Qnd2?=
 =?utf-8?B?VXhDWEFzUmlGcXp0dVAxWUlQUzJCMWx6OExocUxPc1hWeW1ya1ByOU5xV2xG?=
 =?utf-8?B?aTltQnluWFlkN3JBQnVhRmMxcGlMa21OdDZBTnVjYWwwWkRvNmNVZ3hDTXlX?=
 =?utf-8?B?RkxOSlh5b1pwQ0dTajBMbUN1bWFwcDhnMmhPVkwxVC94QVhZSXJXUmE2NXNX?=
 =?utf-8?B?c3Z3SGNmTkh0b05OVkNjaTlmZTBwd2JXUktNTytJOHFWSlhQVUZINmxNN2VO?=
 =?utf-8?B?NTZ4S0ZhRFpIRWhER3JNZjR4TlZRdmluS3JMMGpxTzUzcllPWFdQRXpSKzVW?=
 =?utf-8?B?bnJETElaWlFvdVhPb0FaUHFUeHhVWXhUWTcxc2FBYWNidTVyV1BXM0tPTjdF?=
 =?utf-8?B?UUNFTUxIY3pXM2hIVFg5TzJZUmtvYTg3c1UxNEQzem1rYkY0cS9tNDFTZVNB?=
 =?utf-8?B?S1k4ZWpIRHZwMkNGa2dtS3VJKzU3WThkMkhndHdJMXpxQStLODByVUxvcit1?=
 =?utf-8?B?b1N1Y2ZkME1MSUpUOTc5ckpHNUsvaDhGY2VyL1FBTlpzWWV6SHpSN05OOERI?=
 =?utf-8?B?dmtxNVpzRDBSOGpub1VzeTlFdVpFVkFqRUxqVGlTajdTNVJESUZ0czdLajRZ?=
 =?utf-8?B?UFdtLzBkSnBOMG5YR212dU9hOFJPalRWMHErT256NU1tcHJVQnJjUDEzYWZu?=
 =?utf-8?Q?+qnaaSWeTKAYSmcI/Q+2eUIlC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b93074-a0f3-46a8-fbdf-08de1eb85ecc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 11:17:15.0310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UulNx2WX2yAqdQ7O/tbckoMxixI1UrG24t1/32YJtpYkXbvT0E56xd8SnWNZo+JJRYlf7XN9BNVpsDSGbxmSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733

On 11/7/2025 2:04 AM, Jason Gunthorpe wrote:
> This old style API is only used by drivers/gpu/drm/msm,
> drivers/remoteproc/omap_remoteproc.c, and
> drivers/remoteproc/qcom_q6v5_adsp.c none are used on x86 HW.
> 
> Remove the dead code to discourage new users.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


> ---
>  drivers/iommu/amd/iommu.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 2e1865daa1cee8..d4d9a5dbfa6333 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -854,13 +854,6 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
>  						   PCI_FUNC(devid), domain_id);
>  				goto out;
>  			}

If you're planning to respin this series, could you please update the comment
above the if condition?

-Vasant


> -
> -			if (!report_iommu_fault(&dev_data->domain->domain,
> -						&pdev->dev, address,
> -						IS_WRITE_REQUEST(flags) ?
> -							IOMMU_FAULT_WRITE :
> -							IOMMU_FAULT_READ))
> -				goto out;
>  		}
>  
>  		if (__ratelimit(&dev_data->rs)) {


