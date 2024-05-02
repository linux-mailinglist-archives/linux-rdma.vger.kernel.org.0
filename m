Return-Path: <linux-rdma+bounces-2223-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AFE8BA265
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 23:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006E11C22017
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 21:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B17818132D;
	Thu,  2 May 2024 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="HKntRaJR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300B179972
	for <linux-rdma@vger.kernel.org>; Thu,  2 May 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685867; cv=fail; b=oIZISrJJFPM/KZWeDOdOw2mgVs8VPxxbJnJLRz7e4HF+0nKvzLEfEnq+x4rY/yHZuCLgrvoDWjbM6envb0Ip2zOMxDBcPnbyuUxCxWTL0i6GhsSs+UNn78AbVHLiR3eO831lLkCcjnYEfWhp1tyc3ECXdeIOEE99C8Y2XPl4xcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685867; c=relaxed/simple;
	bh=v5BswDlQ4blZw1SYubQxFWfCNmU8ni3dSBnHxvBvS08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cwN4rQacZuqgxAmG9iRTWzLR1hq8QVkuzt5dQT8GsYdRv2qw14H/XC4uiDYeLH9ikBdeOgELm/v2zEWP8jshGotfvYrnxlIPc+sCNqggOKR1/+GnQs/jl197AV9AT/m24LM6Zu8+5uy9VoPcFJgzB+U3rUjO5jRfT35V/VnJGPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=HKntRaJR; arc=fail smtp.client-ip=40.107.223.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfj3iNClwLtk9ofqcoYa3Xdlf8WfPjB++ygM5sSX1uviHWV+X/nzxIpvvfFXDqLKBsM2PRVayUZlal5Zeue2o0xVX0BklSsw7z2p7M9nqYhMnxG4r4yRMepmpi1J67LjOVXmIlf9HeHY6Zl3+7L9T7LPTiSuUGDwp+eNM0krhcQeXZR8gugveaAzlZCuuRizvbEFRfgYQmcfCPaXKs668mePZelg2Typ1Q/Qvo2jK6PNuxfn7otebrPI00uVd9Is1o330IdV42vtH4IIVGxoU3kQYMi9ONLQKxUkc9sUHkYrecuojK3v/qUVi6ctZ2zX3H5eci87STu+BSl80CsECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OB1+JWuYYr5QYLCBoKqY8P2+F5wM6/vVAYfGuZsIj/o=;
 b=HTeRbqy8MYJCCPozbjJoc4/UDrzzwMas+vnn161/QUHLuj1034rcr91UB3F/wis7uXM4YayXI2BgKMD4Avcm3Z5KMBJsxUIc4Bz+dBF0RmcCIXrcniqw2CeThPJYg/asKQsUEfs+MYkND39BGuPOdnbAW3JlLIgt+Opzy14lQT2vHaIZG53MMrqnjJZ99v91aWO/90E+ISmXUrYgHv11ooHwfl6CPW+Ec3f0N5HfGyhIpdBbf20UwV97C8mM7FXgvjTRY5865kwk7u/nbcODt3d+LVlR1jaHbY2Z0cQH6/2P++wZbWFBpeEIh2kJAHk4V8SofUHlDJmh0/yADhA9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OB1+JWuYYr5QYLCBoKqY8P2+F5wM6/vVAYfGuZsIj/o=;
 b=HKntRaJREIoUWK7wBdgmv0/09pjRYC5MSDr99j8K9fdqKeY4TRVxKBR2kjcApoaIWnvuGzhirHDONBOcHjFBFAtUC9bRaqz1A3qt9oV4RFoNz9UBq8EGYQA3iUaeUyKm3yvT1bKcnaDGBGUHlwlT0IdYYVVdxFQbJebyY97IBOLnmUnxUh5TmTzU9VRblPnr/2ac/+ZH0ImEJrBA7dxULJxusD9LvxJnH9WCSP9+ZTm8Q2RtZKLn2JgkjCZlWB8c3ng22PDswdifKcLERWLtEJM5wMoWqhrvYu2/yM4+hMkeCRDEF+Ey+DVva2037jQdtKIBp7p8ZUsyAmNOP7d3fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 DS7PR01MB7710.prod.exchangelabs.com (2603:10b6:8:79::13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.28; Thu, 2 May 2024 21:37:40 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::4946:4176:3c9b:fe38]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::4946:4176:3c9b:fe38%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 21:37:40 +0000
Message-ID: <dc2783fa-de8b-4609-8ce6-f168b5dbfeff@cornelisnetworks.com>
Date: Thu, 2 May 2024 17:37:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] IB: sw: rdmavt: mr: use 'time_left' variable with
 wait_for_completion_timeout()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-rdma@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
References: <20240502210559.11795-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20240502210559.11795-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::26) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|DS7PR01MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dfbaba5-4cf6-4311-107d-08dc6af01794
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWFyT2xKMHY3S3lXYzN0L3RCS0ZpcW1HUlJUNFl4SHVjZkFYSGJFNWVmaW9E?=
 =?utf-8?B?c3FJenNkV2w3UEVWQTlNZCtCbEN4cEtWbkhPOGIrdmJwU2VEOFJGWE82amlX?=
 =?utf-8?B?L09LbHlmNFBGdG9YUVFPMFp6dlJXN2JMeGFveHVxektacVJ3YldIQVR3ZVA0?=
 =?utf-8?B?bW1zbGVtVTNKQWZmMkp1aXlVVi9mcEhPMGx2K1NwUFNKeExBODdaeFpTbjQz?=
 =?utf-8?B?QWt5dEFUS2NyM0dxTkpES2JsWE9sUThKZlJ1elJuTFNxTXV6TjU5NXNNMVZm?=
 =?utf-8?B?SllFNXhCaEQ4MEV5ZXlLOVczSUxJSm93bjNQM2h5UVEvS3RTdXRoWmxCK2xR?=
 =?utf-8?B?aWV1VzV0VFd1Q0NYUEhmSWtTRmR2ZEcxek1hMDZoZithTWtaZFZhS2V3OWlX?=
 =?utf-8?B?ZjdqU0RHd2UrQjRoTnF6U1QwcjlWOGorTzhINVl3WHd1eVZsRzBaWGh4VVdn?=
 =?utf-8?B?RVh6YWRNR2FRdTV1VVE2QkVDcUdFbWNucXFrUGdIV0VUT1owakEyTFhFelFZ?=
 =?utf-8?B?c3QvTm96Ny91c09QdTF2SWkrbm52ZUgxbEFZaXdVK2c4OHV1TjkrVHlHUmQ3?=
 =?utf-8?B?NnpHTFFBTHFDdklhWVE1dVl0QVZqTXVqNEtxdi95NlV0NzlpdGZhVUFDQmFR?=
 =?utf-8?B?bUtXbS9uSFFGQTdoaEN3cDRBM3lzZUhCVjQvMjJYdVJjK0Z2TnI1amxhMXlh?=
 =?utf-8?B?MnZMZ3R4bThQbGlDdHNIWWgrRGU0R3ZEaXdqb2dyOWQ0bUN0MjNpYW9MdUdp?=
 =?utf-8?B?VnN0dXNRRVo1dTVaZjdXMnJ6VTZQVnBxSGNjcjJiaXZMVCthL1k2ZVJqazJI?=
 =?utf-8?B?Tk03d1dHSVVCeThYbnRZRHd0RXNZQ05PSnhSa1ZDRkwzNmF0WGliS1JCVVll?=
 =?utf-8?B?Zk91cHh5WlZxNkg4ZjVwbFVVdUY0OU1XSVdhQmlpWDNWMUEzaTFIUkJGWHpz?=
 =?utf-8?B?eGFTeWJDemVIeWF0QUNvWFBVbE9ibXAxdkVsSGxwVS95Zkd4a0NNdk11L2lF?=
 =?utf-8?B?VTVaeXZwUnAvOTFZdkVGV1M4bUQyL2ZsN3VKTGduWnlPMG95M01nZ0RUZG1G?=
 =?utf-8?B?eitaVnhoUTdGMEdkTXhMTTBiYnp4RTM1L2tGaGllZlk4eEJ2TW5rTVlrbWZ5?=
 =?utf-8?B?Zy9WdVd1aEZkK0tJRmRGbGR0UWNRMjg5N0Q3clRPSkJ6R2tPMnVZNWNIQ2Vp?=
 =?utf-8?B?d3VBNFpqdmt1eFRYLzBSa3R1YTdjR1dUbE91dVBVWXRwN3BOWktNUzkwVU45?=
 =?utf-8?B?eE1nNmROSEFzbUJQdDhKTndKMERoUFl3L0FMNkkwbklLY0o5cVNlYXpqRUpD?=
 =?utf-8?B?dmptVVMxWG8wQWxzZ2xibjc5VHZycWQ3RWxLbWZtYmtqaWRrdFo0SHJ0eVV1?=
 =?utf-8?B?ek02bnUwNFQzSjQxdll1aldqdlZQOXV1V0h6ekQxanNaNHhHM2xoQTVsV0Y5?=
 =?utf-8?B?cnRYa1U1cklTMmZ3aUVaczlKMlZtYlRnUUp1dzhRRU1YWWdrVVdlemRLU3ha?=
 =?utf-8?B?V0dKcDFEM3FkMXh4a3pzM2FJMU9wZFBTeEp6bVZwSTZWelpPejJ3QStYQVQ5?=
 =?utf-8?B?MFJvdTA4SE1DOUFJaGdaVG1RaDgyamRVWi9XREZ4bktZQzZqd3orb2hYNWh3?=
 =?utf-8?B?STJCa2N0cDdnRmVBa3p5eFRacFVkRTZCaWpuNHlSdXpMaXk2d1JxYzNQSktT?=
 =?utf-8?B?dDZmQVI3SmJUOWdiYmhiNVhscnBaWmFjRVQyWDErVlRZaXRZaWN2Y1lNL0VX?=
 =?utf-8?B?bXJRWldQNGRydHA5cnJiLzljdzJYSC9VcTQ0a2paOURNYmtLMGxpMmpqQU9X?=
 =?utf-8?B?YlBiSmovK0xpV2Y1L09RQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0VRajFMSlpNTnNRWXJRdmwzTDhCT25zbmlpcWdmYnpjRDBFQ3VLZEp3S0po?=
 =?utf-8?B?NWYvU3VRcGpoS1NMV0NobzI2STVxQ3Fucy9FMFoyWHJIdGlvMlowOEdvby9j?=
 =?utf-8?B?c1p4VEhibXRpZTAzT3hEeTFVTnBGUHliNzdNL1VyVFYxS0MvcFgxdkdkbFhq?=
 =?utf-8?B?T1NWOGdmeGlZYXpVR1E5U1cwckhVWWxhcGJEWXV5dzZraHVkRjJuVTl5TTll?=
 =?utf-8?B?MjNBMi9lL3ZuUzhCTEk0a0MrYlJ0S3RPRysvVjRJRXpQL3V1alpQWG8zNmJU?=
 =?utf-8?B?SmtjSk9rdE5Cbkl5WktLQVkvTDJtWkllUlYvaG5QT0FCVUdFd0ZvZzdkYUdw?=
 =?utf-8?B?SGJxc1RLMlFzaHJNWktwd1g0NGxuN3lZVU04U2kzbTg3WVYyR0hpN2hycS9q?=
 =?utf-8?B?K1JON01yL3pFT256cE9LT2Q0b0lzVm1oeFozSGxET2tIamd0M3BnT1hzMXF6?=
 =?utf-8?B?eS9NVzZtMzE1VCtibmN1djNJNFJNaFBRYzc3SlFxQzkyTEozWTVCYXpucWZn?=
 =?utf-8?B?VWFJSGFuTTd2N2dOcjhkNWo0d20xd25vUFMvcHp6VGo0bmZmV08rdFZNaWZV?=
 =?utf-8?B?WmZYOWRkSFdUMmt6VnNleUpmVFZNWmFsRitjV3Z1UVp2RkF4QVVIbkJWczZz?=
 =?utf-8?B?NlZvcnJocjgzZlNLOU5iOXNHSTBoK1cvSkk5SHJhVnlCVjhDTnYvVlJRWkgv?=
 =?utf-8?B?dHRoamJOcUJxMzBGMTJiL2RHQjZxMzV2dkFOT1BjNW5HL1NDTmpYdWdRTzd4?=
 =?utf-8?B?MHo2YkliM3UyRjVuQXU0WHYxNkZBaWZCYUJSOTVXd1pHYXgzMnZjbXh0b0J2?=
 =?utf-8?B?Qk1NWFlpQjBXZFpjL1Q0eFdzQ1RhaUM2U25vMFFuTUNWQ2xDdVpvbUlYRUg1?=
 =?utf-8?B?dHpiUnZUc2JZN2dsVWhSRGhqUHpmUTlGb2tacUxOY3ZDTWFmTmZlWDRlaDdy?=
 =?utf-8?B?d0RJRXhUUFFDcU1Od1ZZcjBFTm1ubTZxajVpMUZvaEdvOTBWSVlNTjRFM3pU?=
 =?utf-8?B?WVAvZUpmS1ZmT2JOL3RUbFhvd0NUdGJrQjV6NDNRZWdabWZIZ3dXSEVQREwv?=
 =?utf-8?B?YUVMNjYzR2o3b0taNlI5VUpscHp5dEhlUEJvVXpuNEUySDAwejczNlBHU014?=
 =?utf-8?B?U1ZKNG9MQWtiRExpQlFELzJwSmc0a2N6K2hkOXhnVko0UjkrcEZaV0VwaUhn?=
 =?utf-8?B?UHQzRWs1ZHc5bUd0L0luMXFXMVpoa29QQjVzNm90ZzNZU011b2FBZG1TVUtY?=
 =?utf-8?B?YVV4MTRWNXVUWlFHd2VRYmh0WXFzZFNwTDFNTDhZdFVzRVR1OWdUOFVtc2Jw?=
 =?utf-8?B?ZlRab3lNQzJIWm9VaXlpU2xWZFhrbHc4dzVhQVJkeTJ5QzlKcXNRaStiMFlD?=
 =?utf-8?B?QVJQRjBYazE1SVpQMFo5V1VZT2lnZWtBQXQ1bnFFQXh0SVMxYzJVU2xlekFL?=
 =?utf-8?B?WDQ1VWlkL3hNQ0VoaE5ncW1lR1E3T0lPVmsvY0c2SGF0dHVQSVhSN2ErYXJw?=
 =?utf-8?B?a2g1ZFpiYyttOUhiL29uV3hyQUFBZTJDVmtWZE1uTkE2V0swSXNYTkhpVGxN?=
 =?utf-8?B?ZGdWK0xBbFcvRU9abXZtSytWOWdwdTE5dFpGL2ZpOHBRenBqZGJpRmhFWXhX?=
 =?utf-8?B?dHdkeFBzeW1vVitIWTFHd0kvQnZyU3RzSHZxV1hSazJ4cnJ4WEQ5djhLc21U?=
 =?utf-8?B?bU9sWWNyeW4yeVlmNUphWTRYdXJtQmYvZVJmY1FCMDd5NFdRcVdzVUZkeXNz?=
 =?utf-8?B?WFdzM0xxK1hGS08waUExWnFhbTBBaWJWNktzZm5ENHJvT1Y2aXpRVGdVSUtM?=
 =?utf-8?B?MnI0UUNCZjNrMnRqelRvNVY2UHZSdkFZMEZxYmVsN09SN3dJOHcvbHl0ZEI4?=
 =?utf-8?B?N1ZtaTJwV1QyVGVqU3pTd1QxMTgyOVhMMnlDTllMSHg2TEZDQWRhaUJlc3d3?=
 =?utf-8?B?czVRTEdJcmUxTTZGN2paYUYwRGtBMDVkbjVNQ016dFNuUnlyZENyRnMvVHpO?=
 =?utf-8?B?bjlxTkVSdnZ6MjRHWDNsaVN2T3lVa25EWEVGVXhmLzVXc2xHZllVK201UWho?=
 =?utf-8?B?c0QwVkl2MGFGbTdwcXdVOVVaeU44TUE5T2pQWXFTTGF0cS8vVVBpVE5GdXM5?=
 =?utf-8?B?VTAzZUNsbEFEenBvbTZ4cVZYRFlyYlVGcnlKKzZveEhLTGNRNmJZb292QXUv?=
 =?utf-8?Q?9bRejbe9lT4qu+z3N4hJNnU=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfbaba5-4cf6-4311-107d-08dc6af01794
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 21:37:40.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eREoNZcnqtZFWUDJwbABJ4+J50tiCA3RKnmEe4JlgEb8O5gKJ6FtxhGDNckw6/2KnVb8NBTz2V6LNQtUEnlnxtNffDRVNDBraCQagIOLaEL47IEuw7Lhi9rWniMZnfF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7710

On 5/2/24 5:05 PM, Wolfram Sang wrote:
> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_completion_timeout() causing patterns like:
> 
> 	timeout = wait_for_completion_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> self explaining.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/infiniband/sw/rdmavt/mr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
> index 7a9afd5231d5..689e708032fd 100644
> --- a/drivers/infiniband/sw/rdmavt/mr.c
> +++ b/drivers/infiniband/sw/rdmavt/mr.c
> @@ -441,7 +441,7 @@ static void rvt_dereg_clean_qps(struct rvt_mregion *mr)
>   */
>  static int rvt_check_refs(struct rvt_mregion *mr, const char *t)
>  {
> -	unsigned long timeout;
> +	unsigned long time_left;
>  	struct rvt_dev_info *rdi = ib_to_rvt(mr->pd->device);
>  
>  	if (mr->lkey) {
> @@ -451,8 +451,8 @@ static int rvt_check_refs(struct rvt_mregion *mr, const char *t)
>  		synchronize_rcu();
>  	}
>  
> -	timeout = wait_for_completion_timeout(&mr->comp, 5 * HZ);
> -	if (!timeout) {
> +	time_left = wait_for_completion_timeout(&mr->comp, 5 * HZ);
> +	if (!time_left) {
>  		rvt_pr_err(rdi,
>  			   "%s timeout mr %p pd %p lkey %x refcount %ld\n",
>  			   t, mr, mr->pd, mr->lkey,

Nah. Disagree. I think the code is just fine as it is.

-Denny

