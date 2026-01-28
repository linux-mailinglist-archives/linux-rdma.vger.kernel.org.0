Return-Path: <linux-rdma+bounces-16140-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB+KCWbzeWnT1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16140-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:30:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1E3A071A
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BEA4302BBC3
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2538C34DCE2;
	Wed, 28 Jan 2026 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iz3eE2Eo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5434DCE3;
	Wed, 28 Jan 2026 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599706; cv=fail; b=FRmawNCbzAKAfPLJ7rfeGyH9brgIiaMfZs/kvooH4slnrXJzhkdvgG9QPvb4gRARtm5qlW+v6B0RLBbDha2dRsMgihGi8K9OuGp1quw8k9vr4GZ8t+OyqxZ16/46Kc0wGf9c/vVhmJQvmODVQzF1YnzEYQfFv1c5F6dshRoj4/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599706; c=relaxed/simple;
	bh=fk44EojnvYM6C1hyToE1dWGGzYqsbyH6vIu2JbJ+txE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vw7luAngYUidzZX/9D/FznrTfpUdVODonmO5NlQfSX5oel6nKOwSFECuK4Bx6S9oPNxepU2QHF8m4JqGruqXb8Ki7XyhiJ7+qLG+iArdBf9XuKkYeXmYSzZCmrCPpyeHhwC7MudB89X0aO4uKU7wThOwlzD63S+KOP+CppHyM28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iz3eE2Eo; arc=fail smtp.client-ip=40.93.196.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvInpTTiPJcYYwEnAIdgNnYQRs+Djn4WFPS1i1NhG5VDYIclTAQAYjpGR6+7e4BRId6v7J/2QXviWPgq9iy2Fe0xAWzae/Z4fkDaWEUt8TJic8Rxpd+v2jV2DGua2XRa1EqqcBAg6CsZfFrjos4AieVFSHxmD40gGiWIpXD9tN3gR7jnvpte3dGDbCfYMadThw4p5K+dgaVtPqA3zNv+TbKYc3Qz3iIVJFm3SBF/3CekOOoEJBhkgvg29m7Z5tSPCW/VxZHmgF3p24q4oq5QAJYdcXC1Pc8DRfaAfkx3KqgYlJ2qnZ8+7pmSwAaFED1QzeLBUexscdfREnA5YTY6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QcZm+TEpuF/SUXQZiKmsSNIqswR7yPtUu1S/KsU63c=;
 b=hwm4MW6KutgTv6llrhDUr71hDmo94yUMGGXy5JKpsm6WIol5k0gkotWFC3iL/3JIY+6zVI9S+rbxMC7zRHVzBAlegDSeyUMNeXuGWkdm+cs5B6p4E/htFZZ4a6B7+GnwsXYqEhr19M8dz58VTKOWnt3u4prDToMe6prqgS6rlHiuUOLea+JbMc65coK/x02nThEgz8NRPz5ckGveYF/jidWVeziXuMDw+yNJ7L7gJ2E9wI+OM2LGTc+p3JKPhKMyz9c0cg3EFCLP/zK/H4AyXWntyxy01o9w4OjFCChBE/OYQxqclS3W+xHNbipf9wEKmPIRatLsYH7psP1JkMY8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QcZm+TEpuF/SUXQZiKmsSNIqswR7yPtUu1S/KsU63c=;
 b=iz3eE2Eo+B2G71dznbCTBvwTjBCQ8Pnh9Gtsv23r1ACGlaF9Wc69DOuKyZ7MLBGbK8FKauePl9B0Uje8RB4s9RCmyiCfq48CC8hK1/OQWH9Zs11ZRFWmB8ztBoD3zfMgvo/NWjhF/xQc/DI5OgAaJ+/EAPiKAawqDX/J/CJKglFwTAJXm7CLWjYBUe3QSZDJXxzdLqi7mgk9QExTJGtgMskC8cXw2q2oxjTxSEo1Wv2Na68Wi/i51FAYxqjFFLwawv6f9XhlIiBxcLYixQyKscrHs3mPpPmZX0gGoaPJzePlB83vTe7+TlvSodjOKtZ4wW1zrOGVKU9HdWWazHULhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 11:28:22 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%4]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 11:28:22 +0000
Message-ID: <c5df3b60-246a-4030-9c9a-0a35cd1ca924@nvidia.com>
Date: Wed, 28 Jan 2026 13:28:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net/mlx5e: Account for netdev stats in
 ndo_get_stats64
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>
References: <1769411695-18820-1-git-send-email-tariqt@nvidia.com>
 <1769411695-18820-4-git-send-email-tariqt@nvidia.com>
 <20260127195252.10fa054e@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260127195252.10fa054e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To SA0PR12MB7003.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|PH8PR12MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d9cf98-869e-4725-869a-08de5e6057f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDRicDQ1cHlGTWFpTENFKzNpUyt2QlJ4TUVibHgvaGpmazh6dXBZa1phRGxW?=
 =?utf-8?B?SWFsVCtqK0FBYzk3QW4xRFVLc1I5bTJyTkV4Q1dQdmFFSkYreVR3TFRiU2xX?=
 =?utf-8?B?dGFWREpKek9iVklqRUFRa3o4b0RQNmtWUzNTNCsyQ3U4bG9pSEc5bXJSR05D?=
 =?utf-8?B?TWRvUjNGQ2JZOHcyUUtjcU83QU9qVitwNkRHdjZiZHpsd2ozQ3ZpWm51VzZS?=
 =?utf-8?B?UWs5UFFOQ1puZlhlNUxuaGtjTytHbEEva2Z6ejRCVkpacGNuR3MrR3FVbjdJ?=
 =?utf-8?B?ODU4WUZVQXZYbUxsNmIyWFAvTkxWd2wvbDI2L3czRVVOdENWeEk2eWtsV3hE?=
 =?utf-8?B?TmpqWmhqVkRJcGFXQ0NoMkxKQU9BRlJ2UTB6T3BjNGtvNHhPUGdPVlNPT25E?=
 =?utf-8?B?dmduZzYyVlk1RFk1dUdISEtJM3VaVXZ3Vm5hU000M3hmVGRFbk1YSWhXbU5H?=
 =?utf-8?B?aCtFazJZdHI5T2xCUDZpOVc2ZGdWMlBOWE9lSHUxQlVRRlM5MlBRbzQ1ODdM?=
 =?utf-8?B?VFZ2VXZHU0JuK01TWjl0d2NGQ0lvQmNsOW9yVkJEMVViMG5CWjd3aVdleVNS?=
 =?utf-8?B?OXNJWUF6cHdjS3V1TVBIai9CZkZaQkFySHp5b0NPSXdwSFRnQ3RLbFVGdDQ4?=
 =?utf-8?B?M1ROWUR1a05yaTdFK25wS1ZpL1pkV0JheElBb25BaWZXWFRNamR6OEY3T29X?=
 =?utf-8?B?M2xqU3V2VHlMdnZSTFN4ek8zbFlnaFNBMk9RblFkNGY0OHk5RDI3dmZMV3Er?=
 =?utf-8?B?Vm5PUnkvaVlKTW0xbUI1eU1zTmNmaHlZRmRTbkJOamRLaE9PMlROYjlUZDZ6?=
 =?utf-8?B?eWV3KzdIcGh5clo1MkdCNndDTkQwazMweVRiaStkUGpYQmhjL0VFZlZoNDZ4?=
 =?utf-8?B?a3YvZXpROVo2bjE0TmpFWjdXcHJycU1BczRIaGQ0VktieUR1dktiMGpwSGs2?=
 =?utf-8?B?eTRiZ3FPT0k2UTBDMXlERm1MbGdXa1JMTll6NGZrcnlPc0orSjEwS2FkVVBR?=
 =?utf-8?B?NURYMkJuUDBWUU5xbnc0bWxDTDZhblYyS0VqT29WUmFwTVVrUmd1VXZ5QVJV?=
 =?utf-8?B?RFpRUmRTM2dtQ29FNWQ4MEwwa3Yzd0U2UWpBYWs4NHBicytIZzhqRU1NN1pS?=
 =?utf-8?B?UmxMK2IydEV5NTdTRFZtVVRubmtZOHJSUUVRTWJkdmExc1BNM2U5RWNRWEdx?=
 =?utf-8?B?MVg0NXN5eE5zWit5UDZJT0tOQTVFaXZWVVJVVFpnNEZ1UHl0NDdja0VyMm1z?=
 =?utf-8?B?dVpwVytFZ2RXeFVKb05hWE9sZTdJS3FaUXJJWHVMcEFaUlBmYmhMd3Mxd3Jl?=
 =?utf-8?B?OTlsc3M3TVZXL2tQMmxRNmpkangyS3dGTDV6QkNHVjFQVHgrQkhSVE05cncz?=
 =?utf-8?B?WStwSnN3WUp1eDJiYzh5WkFOeGFvQnJsSEZWQkU4ZWlQNTdYZmpoM2RsSEJq?=
 =?utf-8?B?RUlCb1BnUVBZWEFtQkVjWWRCbm5NOFBDa3ZPN0I0ek1Ccld3UlhXMml0a2R3?=
 =?utf-8?B?OC9Rdm11aFFmL2dSM0ZYa0VMRWd4dXphUTdGbmZSZEY0TC8rMnBtOTJKT2hH?=
 =?utf-8?B?Z1hORjhHNTRxdEVNZkVGT3ZkNmZPRWhVaFc4QTM2VFZEaWVYTnJtdklmYUVj?=
 =?utf-8?B?VElCUTYvRkFwZmVCcUJsMGZJN2tJa1NBVXY0ZHh3bkZFb1RTZ2N6dEZOUFhx?=
 =?utf-8?B?My9OZ3pUQ1JQZ3d3b29jd3JMdFNzYU9DaStHZmtmeTZKYWt2N000WkRtTTJB?=
 =?utf-8?B?L1BaTTRUSUlyNGFObWpyUk41RVg0R2JRYyszS2t1WjhMUFk2OUp0OEVjM2wy?=
 =?utf-8?B?SGpYTm9XeUNCTGpYSzBENlMvblo1Q0JkODVVdTN4dnl2bFc0OWJRZktuQ0Fo?=
 =?utf-8?B?M2J5cGJoZnpzYmNPSkE5Y0ZoNjc2RzFhclJTRm4yZHRaRldFa1liSVdXbkdi?=
 =?utf-8?B?cnpLOEZ1SXo4QWY4bHlOMjNPdFpKWjdzMG9OZkVKc0EwQnljY1JBTGNidkpF?=
 =?utf-8?B?THdLeHN0ci9HeEdNdFJBWW03bXJnWm90UlpPOFNTRGxkVjBDVGYvYUNnVEIx?=
 =?utf-8?B?VzEyT3NMYXROTjhrQTVSdE04OElhYnh5dDBvU1RMVlNZOXhOWXVtNkFablh2?=
 =?utf-8?Q?cW44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7003.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVBmZVErUFJ6NWswRlZyQlVrcFFmOGNvaHNDMnBoN28xY1lnM0szZFBtTTRH?=
 =?utf-8?B?YXI2OFVZMGI2RjR1Yk05Ym5nMHFtVEVuaWhrSS93Sy95ZDJPWngvRVFuQXR6?=
 =?utf-8?B?RVN1VVZTaWxwdXZKOWtVVEFvSWl6aldoNkh0NnpMdUxXWUZRUUp6cTEveTBD?=
 =?utf-8?B?RitCYlVqQytKNkJDYk5SazVKMnAzbCtueTFjQTYvcUlxbVI2QlluNUx5QUw0?=
 =?utf-8?B?S0xzalRXMzdoSjRJTnFzZERrMm43eWZoU2U5M0NxSS9qOCtHK3VIa0hWQVpl?=
 =?utf-8?B?Zk1MSnUxTE5lZTErR2dHTmc3eUJZMTRsbEJrczJobndFemVjRDRRWm02Wm05?=
 =?utf-8?B?eEFLMnJYVjRyT3RDdE4ydlhKVFJ1bUMxRGNwTmt4ZXhQSk52RVlIZFRzV3hx?=
 =?utf-8?B?VEJsaHdEUFZLaElEcmlUUGlvaE9RZjVuR1Znc3RJd3plSHdyOXNYMm1HbjZj?=
 =?utf-8?B?SE1CM1NqWjhycHp2akhheXR6cmZZcWRvc3BkTHUvZUMxcDBudVNzTWliRm1q?=
 =?utf-8?B?clJhSk9ZTGtCejdmM0RXVHhtUDE4d1BjY0Zvdncramh2TDZQS214SVBmNElQ?=
 =?utf-8?B?K3Ixd1l0bkhNM3ovZ0ZvNCsvbXpYSHdrdUtIQjVKVXI1MFBxR2tmenZwcmF6?=
 =?utf-8?B?K21jUmcyZXJRV0hFQWVVYWlQUzBINDl5aXc4cS9GNy9lTFltTU91aDJja0Qv?=
 =?utf-8?B?QUgyTkNUN01Ud3BrdWcxUmVLRlB6b24rblF5cXNpRWgwQ1Q5TnFhckx1Q0FI?=
 =?utf-8?B?blRUNnBBOWFtRy94eFNyRUtNbTZodTNvYy9Ic1hJZEtrUThPRFV0ZlZobWpP?=
 =?utf-8?B?QlUwZW5FUVFnUFArY3V0Rkk5R0VaUndaT0c3dytQWFo3TXE2S2lreGNtVXFC?=
 =?utf-8?B?Z29sR01admVjVXpZRzgxRmpKZkdHVndkRzVDRWptbmFEU3JUZjBHTlNUSGIx?=
 =?utf-8?B?SktDWHgxeHhsTjR0clU4b013dzVKRlpzZzc2aERJdTBYU2RMWjFvV0RHcUwz?=
 =?utf-8?B?ZFdUR2lmMENYa1F2cWQ1UEJaY0w2bEFFSVZLMUEzLzlRUzZhN2N5Y1phUXQ1?=
 =?utf-8?B?WjFjVzBBMmZRaTEybHp4T3BMYW00NUx3engvTXNFMnR0T0Z5ZjFJdUVBVll1?=
 =?utf-8?B?OFYvcVhSeXJLcUVLSkxVOEpKS0Vvbm53T1IxZldnWlZGNnJkYXE3NllTd0d4?=
 =?utf-8?B?KzlRZTlVNUJTeVNlZVQvYWdvSFQxa05iOGhNWEhieGNjRE1qb21iNkplak45?=
 =?utf-8?B?SCtOdHBzQmxIcWtEVmkyTXp0MGFQbXFMcXFiMUYrSC9OQ3BDQzQyRTNSUG84?=
 =?utf-8?B?ZDVIby9XMTkrMFdEWU1NK2JwNFdYRVpuc3NEZjc4YXNMSlRWV3UyK0s1Tmpt?=
 =?utf-8?B?ZXA5S0NrbzFVbW5ab0c5OFhtS2Vsb0phak1tU2psYVpqTUFtekdhNE1yZGJs?=
 =?utf-8?B?eGZSdTJHaGhtQkZISC8wdFcwcEdUdSt1RFVYSlAxRDRPV0U2aVR3YnM3VCtC?=
 =?utf-8?B?RzRiTXhzbVdUZFRFVVFzek1CM2Q5K3lHVXJJanUzZVdUMWtWNjdST2IyaFF6?=
 =?utf-8?B?U3BjWFBIK1FEYlJKSFdqWlBBTWpqb251bWRkMlU4bjljUTIwRmdwTTBYaUJM?=
 =?utf-8?B?allQY2Q1SHdic2lyaDFXSVE2ZEh2VlpockJ3ajYvY3EwZHFUeWRhMlFuWC8y?=
 =?utf-8?B?SE9pQzZIUCtkQ3J5V2Y1TDZLTkdtZjJHSEJqNU5veVFkM2I4NWlFdXVHR2dk?=
 =?utf-8?B?YTNIWlF1SkNFVTlSV2FocVBUWjNJSWhZeTZGMVpDMkhFNHpsVThmd1JDQjlB?=
 =?utf-8?B?TFZNNjFocTlOMm56elZJMExqa0xZT1I1UkVyWlJMaG80dld2bmM1eGpEQm1M?=
 =?utf-8?B?a0NYc1F2ZEROVlFMZzJmTFhOclRMRkRtd2c3a2gzNnZvdHhjUEtJYnFIbVRE?=
 =?utf-8?B?MTZhSTRsUGgxbCs2NmFSaTBuOC8ySDBCZlhlUWc1M2pmdm1oZDk5VkxmTkJ4?=
 =?utf-8?B?VjhCU0Fjd0ZiRTlSOVVaNmRXRGFSbzdzV3o2bkplU0pWdGxEbjg4N2M5d3JM?=
 =?utf-8?B?TG9OV1ltNlBCSmpiNlZDdWZpRWM2Q2wwdm9yU2o0MFBPREF1NEhFZmNnMzZk?=
 =?utf-8?B?cVo0RElzOEkzeFJGajA0K0c1VTMyRnovU014YjQwZ0ducGJOWmR4YS9kcitQ?=
 =?utf-8?B?YXJidkpQVlNnSEVFcHA1NVRhRC9UaWUwU3BLM1hvb1E0RnFBcE5mWURmcUMz?=
 =?utf-8?B?RTdpTGJ3WnZzSjljWXZoUzZHU2NVbG9iaS9iL04rMDMxV1VvMndDVUpUdE5H?=
 =?utf-8?Q?kbGicEUMkmEtkWTrRT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d9cf98-869e-4725-869a-08de5e6057f6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:28:22.1514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3A2zTJeh+I90YMQ9t4wCiyFw4OZWcqxOQm4bgpGfPAm65SL3c+AY2ztB17+EZUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-16140-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: BB1E3A071A
X-Rspamd-Action: no action

On 28/01/2026 5:52, Jakub Kicinski wrote:
> On Mon, 26 Jan 2026 09:14:55 +0200 Tariq Toukan wrote:
>> The driver's ndo_get_stats64 callback is only reporting mlx5 counters,
>> without accounting for the netdev stats, causing errors from the network
>> stack to be invisible in statistics.
> 
> I cooked up a patch to fix this generically in the core... but I can't
> actually find any "errors from the network stack" that are accounted
> to dev->stats. Could you be more specific about the issues you were
> seeing?

My original motivation was identifying packet drops in the GRE stack,
specifically in gre_rcv() after an error in gre_parse_header() (in my
case, due to a checksum error).
Currently, these packets are silently dropped. I have additional patches
that increment the rx_dropped/rx_crc_errors counters in that path, which
exposed the issue, but they haven't been submitted yet.

However, you are right that it's hard to find existing dev->stats
increments, the use case this currently fixes is an error in
__bpf_redirect_neigh_v4()/__bpf_redirect_neigh_v6().

