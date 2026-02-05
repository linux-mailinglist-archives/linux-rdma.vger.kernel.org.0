Return-Path: <linux-rdma+bounces-16599-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAXcGt22hGk54wMAu9opvQ
	(envelope-from <linux-rdma+bounces-16599-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 16:27:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3851F49A4
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 16:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F2CB302AE27
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3F421F14;
	Thu,  5 Feb 2026 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YyhLxiuM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E222E406;
	Thu,  5 Feb 2026 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305229; cv=fail; b=sq/CjiVLLbieHwG+eiT9TMjb8wfHnN5NeCUjVYYPZhxAffMA9Fr9lPydFqWV08MuELpyBwGCqs5GX9ZJgZx/72t5G9MMm25yL6hBsMTwzWuXG5FPKDRK3YHF/itOrkLavc+f0S+NhusZZdbyYlr3y34zGNk9skgfM0nR+8BwBO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305229; c=relaxed/simple;
	bh=RHDcic2P7G11NLNsuDo8Rynv50k4Q9CuJKzcj2IoIcM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XWH31LFzkoQep1DOTqItsvLJ4+a8KAZsu0o4pXUq6CaL9BsJY0lt3Y+BWCmqKS2a2gYkwfFg4dpPzT+u/oxIjhoRQWH1hv+HshzcP4mbseErNFyk75u9Jgzv+KnTlHwsU6eNRbyfDJdug9LHMBjV3usQ0V+rncK326QvBV5810M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YyhLxiuM; arc=fail smtp.client-ip=52.101.61.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doMCTCSj/8IuOhfZRmhYry2zd3QRqK1AIdCmSLxWLh3PVj0xMtUdcwOA4lzcyNKXZZEkQwfICk0jcPPA4GfGuBa1azEeFWPwVFgOciw0fuu/ScgMpUzrf8G2QhgaPwl3LOAgMfzBlb/r5kAYAXED5cXpmuhBEYxM04pf1KwV2xndBjih578a8c+jDsQdl8J+UcVcDSvmq0XaYXa6UGs796HgFOgs1sUD5ZS5si8LXGQOyluDH2NBQwbGuiYfdBB1/p66t/QUEIOiiCbe/WVYCrUBz9hjkHfmjyo6E/Trtm6g+Qh/tgMJFjh1Hr8rpGLv/48ClIkkL3bj1feS/Du/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hUOUUtH+tTgX/GY8xWks7xLOaa2c87IZ+BmtLou9dU=;
 b=nnymKq+2so39lAbN7v8cXwmJRZ/qA3V4+CtXWqVMt0BBMAfDQqS3fnpaGbHTQXivePzlC6mVwFjX/wMH0oh75g+IHygrcQPmXEr/xVK2lUdLbo1PGxybLnqKj1+8kEGEFbyejWvVYikTS3Sii7XUY2IXTTl7SBtLNiqxryVnGiduxs5S11kSTWImLnrxTLK0B4bInEweHIb+bTX2UWz1AU70oaKiHK/HVSb6r3bHq5eWhbKZkz5Mwm2XNpdykvTwtg4irRMQg+TdyHsXQ0TNeV6E2jpzw3LruVMCEmxAOyhwNcD/pnHHWgMF711s+hYZ89kfpdNk1J0p22JMR47VIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hUOUUtH+tTgX/GY8xWks7xLOaa2c87IZ+BmtLou9dU=;
 b=YyhLxiuMQlMbWFq8iEykyS0Db7DMor/bupnv2BWCMyLrDYs0iiB4eALf9ICRUT/o+GFzP9pw1S2+6xzbZxjeT8VlsDcgQ1xpwP0dpAqhcqv0Q1zK3E63Ab/9E/Nnu9IyM6xcu/UKThky4ofMfb5vfmO/61+NWu0NY0tvciSBOmwDr5LOAgH3imZHo4KPiuBtrIUXSgUXxRTuV9xpjZNjIyMzQP3U1jXqMTV5JvK4Fn+q130zGlExNEaa5x62IwWoycLkterxAtKanzq9PjAvqPiHc2Kjp3iva5K+hEuhBxjs7V0kXyv5PUdCtsSfPWskU4etzJivQp8S0ug1SyjtZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 15:27:03 +0000
Received: from CY1PR12MB9558.namprd12.prod.outlook.com
 ([fe80::920f:8246:c48b:7ce9]) by CY1PR12MB9558.namprd12.prod.outlook.com
 ([fe80::920f:8246:c48b:7ce9%4]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 15:27:03 +0000
Message-ID: <367b0cce-a177-42cb-ba88-eac458c7ac51@nvidia.com>
Date: Thu, 5 Feb 2026 17:26:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] devlink: Add port-level resource
 infrastructure
Content-Language: en-GB
To: Jiri Pirko <jiri@resnulli.us>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>
References: <20260203071033.1709445-1-tariqt@nvidia.com>
 <20260203071033.1709445-2-tariqt@nvidia.com>
 <rye7fponvzxqbeexkreuxwvjlder34vfkofib4gwrhkbw3vres@udo2xxeek6xv>
From: Or Har-Toov <ohartoov@nvidia.com>
In-Reply-To: <rye7fponvzxqbeexkreuxwvjlder34vfkofib4gwrhkbw3vres@udo2xxeek6xv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::8) To CY1PR12MB9558.namprd12.prod.outlook.com
 (2603:10b6:930:fe::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9558:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a858299-62d3-44e6-cff9-08de64cb0365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVk3WE4rRGZBQkVPYW12N3VISUpxNlhnUWE0L2hRcHJMYmpuM1JySExwWlpB?=
 =?utf-8?B?ajZBMFZ2RWVhQ3p4S0RBYmZ1SkJBbUNya2w5eWdVSHZ5anpwU1VIRVVXblZl?=
 =?utf-8?B?U3RNRFk4RFFOYnZYckY5ODU1U003RmcrWW1aaG1TQnh6UU83QzIvMTJLSVBx?=
 =?utf-8?B?c3VyQkxTcHhIK1NqS3BnaDBXNE5HWW41eVEvaW5JNmxvdWVXZ2xvbFFIbjdM?=
 =?utf-8?B?UHBCLzg0MTh6bWZhSFpyb0dsZFlDcVJRYkhHR0pGT2hwMWZZSzVZMy9ENU5P?=
 =?utf-8?B?UlpqTE0ya1hRMmhWZE9kVklMSC8zdU1YOFQrTDI0YjlKRWJ5NzdqV1hScW1y?=
 =?utf-8?B?alJLeGo2WjZMR0x6NVg1b3JIQzhjSDhiZ3UzU0J5SDZVMWRBZmswdElTZFdq?=
 =?utf-8?B?NS9vZERBa3RPSUNmKzhWY3JMbkhzbzAxQmdIYkc2U1dKMDBhMVk0TXYzUlUz?=
 =?utf-8?B?TFVCT3JnRFo5cG9vRk01ZHZTQUx5SkVlQmNGRkhuL1MrU0Q2V0hGODlXTXpH?=
 =?utf-8?B?UzNXWXR4NlJucmFXY1h6Q2hSSVo3VEQ0OXcrWEZzNy9lb0ZNTWNBdHhrN1Va?=
 =?utf-8?B?Nno1di9DdWk3KzBFamRrcmcwUkg1Q08zTlVEZ25HOHdPUkxZVWNPZ1RDc2Nh?=
 =?utf-8?B?MG9zN0x3VkRXVFJvM3V4QkQwNVMzWUk1ZXlDWjZpN1NhaFFIY0FMOWhvYkZ0?=
 =?utf-8?B?Mm5sdlVVRnBnQ1ZzbGhEaTEvaklKalY2a0UzY003Wkp3Vm9HS3JmZENCVlYx?=
 =?utf-8?B?b2xyNXlwNUNiRHZybzZhOUt0dUVzRGFEOHN4d0NNQjE5OE5PS0NsWjhBbTZQ?=
 =?utf-8?B?NndhZHI0cmNnbWN0L3VxWmVMazFxYWY4eVFwelg2Yit0eGZJUE9wTWlTK0pN?=
 =?utf-8?B?QUJWamtkVkQzK2Q1dFY2L1RybE9NSXdCcjB4K21oVUlOSHFGbTFoem1BWm1D?=
 =?utf-8?B?bUl0ejEvWWh4dkYxVGFpK011TjV5R09DR3h6ays1dlkrT0NVVEcwRjRYdEVz?=
 =?utf-8?B?ZWtVOXY5K3FDaWJXMEtLNDRHaGJGbDBmMk5EYStoVzNLY05GdnNGVGNvVzZu?=
 =?utf-8?B?K3pRR2xDZkF3L1dxTnU5cUt2RzRmZ1E3QytEV0pReVlWaEUzL1RhQm5MOHJ1?=
 =?utf-8?B?RXozeUYyV0NpQXptbVF3MXgzcUhyL3FZNmVBVERtQ0E5azVpUDNBa1NSd29o?=
 =?utf-8?B?NFd4Z24wQURSaEdZVWN6akZQOXM4MjAwd29PMFJnMFNHd01GNEV5K2lVN3Ez?=
 =?utf-8?B?WnljaWtJdnJGUTdOSWdXOFJIY29GVEdhVHpiMjEvelV3cmVnK3FNMUZWbkxX?=
 =?utf-8?B?dDc0UDZoUU9FWnkyQ2tsRUNvMDV2T0R4aVhsN1dPT2E0ay9JQ2VDdHhIbnRJ?=
 =?utf-8?B?L3lwMC9HYytXTUR6Mm9qYUZYRXJXelFqRTZRM1RsR3BzY3lieitRVC90NWY2?=
 =?utf-8?B?OGFPUlluNnpXWXZKRm90dDBwVURFZFlmTWg0MjhoaHB3NkI2MGtNQ040ckll?=
 =?utf-8?B?T3UwaTlPSXJHNmFoZUVKbGVMampUdVRMV0h1MmhhbmFSRk1BeVlqblo1RXRD?=
 =?utf-8?B?Y21TQ0ZWdUNjaVpVdW43VTJiZjNuOUVwTEliQ2toRDdzdnlCNlA4bHFMczEr?=
 =?utf-8?B?YWxQN20wUTJjbm56azlsMjg1M2QrUWtEblhZbmlFdHQwU3dBanNKc2xmNUQr?=
 =?utf-8?B?SVlLN0NYMk55Q1Z5QnBORVNlNUFOZEZiRUkxUmU0NC9ER0ZIb0pRR3ZjRkJy?=
 =?utf-8?B?NHZRQWw2bU41Zlg2UmxzeWp6ZGp6djNaWjlMSWcvY1hob1hoVllNbnd0blBX?=
 =?utf-8?B?dmU5VTFYNno1MUp3RzNmT3FUTGxXRVczR2tjblQ5WDZGZkgzRXI3enVDb3Nh?=
 =?utf-8?B?UU1kTzA0VS9Qa2djVUhNU09YbjR3SXRzZWJoYnFzd1VQQTk0bDJ2RFZlcXVi?=
 =?utf-8?B?UDFUY2hneWhxYS9sbmZ3b3FYZ3JVaDJ2NXp6OUIrVzVSczR3V2t6OE9DZHVm?=
 =?utf-8?B?S05rcGpVYnBRd2M5M2NQL0QwK2NZNnhReWJMd0FIcHBxQUR4ems5YmZsWm0x?=
 =?utf-8?B?RU9BUnFSL0JaOTl4VkMrTWd6Rlh1RGo5NC9OOVdKdHdMOW16aWUvZE1ZWmQx?=
 =?utf-8?Q?gqYU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVVFTG5jUEpVN0NoNURDakhXRVBicCtpZkx1M3UzQmh3RkNyVmxyRGxwRytL?=
 =?utf-8?B?ODJ1dlh0OFpHZVcwWlord214VHB0amU5aVlDczZsS1hJendDdEVTcUZRa3Nu?=
 =?utf-8?B?MnBJL3dQQmNDd3FqdUVtaGdjSW1mYzk4UTVlajN0dHlXY0ZNeG5pMlUreWJH?=
 =?utf-8?B?SGV2YlJkYkhxV2RJeGdySG82M2ZwTXU3UjB4NkdVRVl2L1ZkYUZobUNsWmdn?=
 =?utf-8?B?V0JOUVlmeFFMbXVNS2REdVY5WVNhakErdVl0all3TXVqaE9OTGpvVnYrZGFt?=
 =?utf-8?B?aUdrR0VOMFhmRTJhVmlzUVNramlUOWtiVGNMLzdYc043dnB0ZWFOKzJ1V2pn?=
 =?utf-8?B?anRQRlNyREc2dU9hZWtURHZNQUVNa0FENmwzVGtQUFBTZVNuT2lFWGozdnE2?=
 =?utf-8?B?bG5VcDM3d3FhcnBnZVlXNGNzUXFlRmVVYzJmZHA5V2JnekoxSVV2NERUVmJL?=
 =?utf-8?B?a0Q5SGVOWnFabGlKZTFaaFpUb2hDdjdPR1VodUkyZ1BxbDUvRXFXZGRiekkw?=
 =?utf-8?B?b2xNekFKV2NaejViN3BDVzNnTk44TXJxek9wdkRpckJLUVFrazBrOVdHMGZ6?=
 =?utf-8?B?UXRmaXZjclVnRVA2c2lDVXhGNXdiTFZZYXRMcUI0TTE4b2xtSTJQcWNiZmNj?=
 =?utf-8?B?emJRMEpHVmp2RjJqMExPTUhRam9nZ0xSdGE2SzVod2c3eVJDR3lIUFhvZG1O?=
 =?utf-8?B?amxzY2I0Tko2eDc5Rnd5SGs5VjkzdXVUOFR0Qy9sRTBjK3gvemFCVDFTTW80?=
 =?utf-8?B?TVhpUTZudVR2cGxKSFBINnM4SzBSbm14a1JSK0daQnpValBPSUE2blVhYjNI?=
 =?utf-8?B?VUNHcTZoMUZLRTlHZENSYzREejYyYWtpMFVDTElBT2VSNFV0blJxM1ZSNklT?=
 =?utf-8?B?NnNXVDBlQVc3VWFySElZS0FZZ3VPRE9qZzU2OWlmOVNoUXdtYkQzajFrczVn?=
 =?utf-8?B?eVJPQ203V2dqb2pqc2srQTNCLy9GYS9tZVZBQzNoR2J5cUk1QzI0TXNjNENG?=
 =?utf-8?B?TVVRVDZiMVdpbFJjRmhocDFHYmdSTjhPY0dwZ2pjMTBxK3pBUldoQ0duekhO?=
 =?utf-8?B?RVNOTkM5aCtPVklNcE4zaXd0SncvYmhtNVRZT3RxcHpPVlJ6c2xsUXZvV3Nt?=
 =?utf-8?B?U0txSFQ5dWNBdFc2S0VHY3JRRTlteTZwS1ZqYnRmWWV2d01Hdm1FMkhQazU0?=
 =?utf-8?B?SmNLRjZvckxhVHVVK0U4a3RXNnFiZVBiQUpWZllIY1hqWjkwYWdXdWloZ2hE?=
 =?utf-8?B?NEk5ZlY0Q3I4emF1bVdYOEl2YWpHNzNLczgxQi9naStvMnlRdDF5djV6d0dY?=
 =?utf-8?B?ZzZuZDh2UHc5ZktldFhiMi9abVg2VE53L3JFRjIvUXBNK2k1TGJERUpkUzA3?=
 =?utf-8?B?Y21LYmQxa2Q0aVpJRlh6L2d1UmVXSTM0S3VXMFl4cUhvR0p2NGdmQXZZaHNO?=
 =?utf-8?B?MGF0dFpyUklVZ25wenU3bWdwQjdVWWNNSHNzYlMyT2NGWHoyblVPU0VTbFNP?=
 =?utf-8?B?Zm16cTNqWDc2ajNVQ0hEVEh5N3dVQjVTZTNmeitBQ3VEVmVMZHpvbEMrVWJ3?=
 =?utf-8?B?bjNiRG9IVGwzYkhJQ3duWUQ4VDQwRWMvZVp5UGZMRXNZUG5EZEV6TmpIbzZh?=
 =?utf-8?B?SlJ0UUR6YlhQTHV4YXNqT2t2elJNTThlbFMzeEU3SXBkTUMyOW4vVmdhcFFJ?=
 =?utf-8?B?eXFjYyttRHNNa3hsMWI5eVFMNGFsRjhzRTZ0WCtORDVtcWh5L2Q0TnUvQWlG?=
 =?utf-8?B?Vm12ekxDckhZc1Rielh0aUcwWW9PcFZ2azErV3gxR2hvMjlmZ1JFejRIam1E?=
 =?utf-8?B?TnZ3MytQSUREVG04Ty9MQnlVK3ppNjRTMmUwVEN1YjlpMnVLUS9iS2RrVkc0?=
 =?utf-8?B?MVNJc0JSNzMzdGZSZ0VFYWJDOXRmMWxRS1hEUjhuQ3FUaHRYYzlZY1loSXFW?=
 =?utf-8?B?dnBKQkh2SHlENHRmY1hiaGpUWjN2aTBWVkFndWZoa05yZXJQNmh2TFMyQW4z?=
 =?utf-8?B?dm56dXdlbGdzWll1aG5aQTlSQSt5UkY4czhOelVkUHpIUE1ORjdMY0NBYW85?=
 =?utf-8?B?WTRlVmcyR0NZK0ZVOEpBZ25lYkNqRDN0Nmh2QWdDQi8wRHNPa2VDY05QQ0Fp?=
 =?utf-8?B?RjVjUFcycklySXV4ZVB3VThoT0dYVk1qdnEzNHVwY1ZzRkFaaEU4aGJVckc3?=
 =?utf-8?B?UGlMOEowMVNvYWZ4MFNxZ0xQd1NOektHd3VSVUs5c1oyZndOdkI2dUNoR0s1?=
 =?utf-8?B?VzYzVFJwNGdtczJ5K1dXMDgyZzFtVG9WRk9Jc1QzaWdHSUpYUzhqc1l3YUxP?=
 =?utf-8?B?TE9rT010TEdmT3ZBdnRZZlg2cG80Zk9qc2cvMmVIMGxPY2ZBd0RBUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a858299-62d3-44e6-cff9-08de64cb0365
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:27:03.4309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vGaZTECmDor6bZYoEPxYw2CRCnO74+eRi46ugHdFQ2kNlhE1STbOKrDm2xZhfWzTR6jZA7FeFJw9OqaQdw9jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16599-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,nvidia.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ohartoov@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3851F49A4
X-Rspamd-Action: no action


On 04/02/2026 11:51, Jiri Pirko wrote:
> External email: Use caution opening links or attachments
>
>
> Tue, Feb 03, 2026 at 08:10:29AM +0100, tariqt@nvidia.com wrote:
>> From: Or Har-Toov <ohartoov@nvidia.com>
>>
>> The current devlink resource infrastructure only supports device-level
>> resources. Some hardware resources are associated with specific ports
>> rather than the entire device, and today we have no way to show resource
>> per-port.
>>
>> Add support for registering and querying resources at the port level,
>> allowing drivers to expose per-port resource limits and usage.
>>
>> Example output:
>>
>>   $ devlink port resource show
>>   pci/0000:03:00.0/196608:
>>     name max_SFs size 20 unit entry
>>   pci/0000:03:00.1/262144:
>>     name max_SFs size 20 unit entry
>>
>>   $ devlink port resource show pci/0000:03:00.0/196608
>>   pci/0000:03:00.0/196608:
>>     name max_SFs size 20 unit entry
>>
>> Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>> Reviewed-by: Shay Drori <shayd@nvidia.com>
>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>> Documentation/netlink/specs/devlink.yaml |  23 ++
>> include/net/devlink.h                    |   8 +
>> include/uapi/linux/devlink.h             |   2 +
>> net/devlink/netlink.c                    |   2 +-
>> net/devlink/netlink_gen.c                |  32 ++-
>> net/devlink/netlink_gen.h                |   6 +-
>> net/devlink/port.c                       |   3 +
>> net/devlink/resource.c                   | 282 ++++++++++++++++++-----
>> 8 files changed, 301 insertions(+), 57 deletions(-)
> Way too big for a single patch. Could you split it in logical chunks
> please?
>
>
>> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>> index 837112da6738..0290db1b8393 100644
>> --- a/Documentation/netlink/specs/devlink.yaml
>> +++ b/Documentation/netlink/specs/devlink.yaml
>> @@ -2336,3 +2336,26 @@ operations:
>>              - bus-name
>>              - dev-name
>>              - port-index
>> +
>> +    -
>> +      name: port-resource-get
> Why this is not aligned with DEVLINK_CMD_RESOURCE_* ?
> $ git grep CMD_RESOURCE_ include/uapi/linux/devlink.h
> include/uapi/linux/devlink.h:   DEVLINK_CMD_RESOURCE_SET,
> include/uapi/linux/devlink.h:   DEVLINK_CMD_RESOURCE_DUMP,
>
> I'm aware that DEVLINK_CMD_RESOURCE_DUMP only implements "do" now, but I
> think both should be named the same, no?
>
Thanks for the feedback, fixed everything in V2 except for this comment.
Port level operations use get and not dump so I think it make sense to 
align with port and not device level resource
>> +      doc: Get port resources.
>> +      attribute-set: devlink
>> +      dont-validate: [strict]
>> +      do:
>> +        pre: devlink-nl-pre-doit-port
>> +        post: devlink-nl-post-doit
>> +        request:
>> +          value: 85
>> +          attributes: *port-id-attrs
>> +        reply: &port-resource-get-reply
>> +          value: 85
>> +          attributes:
>> +            - bus-name
>> +            - dev-name
>> +            - port-index
>> +            - resource-list
>> +      dump:
>> +        request:
>> +          attributes: *dev-id-attrs
>> +        reply: *port-resource-get-reply
> [...]
>
>
>> -int devl_resource_register(struct devlink *devlink,
>> -                         const char *resource_name,
>> -                         u64 resource_size,
>> -                         u64 resource_id,
>> -                         u64 parent_resource_id,
>> -                         const struct devlink_resource_size_params *size_params)
>> +static int
>> +devl_resource_reg_by_list(struct devlink *devlink,
>
> can't this be "register"?
>
> Also, why "by_list"? Sounds odd. Could you perhaps have it as
> __devl_resource_register(). That's the usual pattern for similar
> functions here, isn't it?
>
> Also, could you do this "list" abstraction in a separate patch?
>
>
>
>> +                        struct list_head *res_list_head,
>> +                        const char *resource_name, u64 resource_size,
>> +                        u64 resource_id, u64 parent_res_id,
>> +                        const struct devlink_resource_size_params *params)
>> {
>>        struct devlink_resource *resource;
>>        struct list_head *resource_list;
>> @@ -341,9 +344,10 @@ int devl_resource_register(struct devlink *devlink,
>>
>>        lockdep_assert_held(&devlink->lock);
>>
>> -      top_hierarchy = parent_resource_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
>> +      top_hierarchy = parent_res_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
>>
>> -      resource = devlink_resource_find(devlink, NULL, resource_id);
>> +      resource = devlink_resource_find_by_list(res_list_head, NULL,
>> +                                               resource_id);
>>        if (resource)
>>                return -EEXIST;
>>
>> @@ -352,15 +356,15 @@ int devl_resource_register(struct devlink *devlink,
>>                return -ENOMEM;
>>
>>        if (top_hierarchy) {
>> -              resource_list = &devlink->resource_list;
>> +              resource_list = res_list_head;
>>        } else {
>> -              struct devlink_resource *parent_resource;
>> +              struct devlink_resource *parent_res;
>>
>> -              parent_resource = devlink_resource_find(devlink, NULL,
>> -                                                      parent_resource_id);
>> -              if (parent_resource) {
>> -                      resource_list = &parent_resource->resource_list;
>> -                      resource->parent = parent_resource;
>> +              parent_res = devlink_resource_find_by_list(res_list_head, NULL,
>> +                                                         parent_res_id);
>> +              if (parent_res) {
>> +                      resource_list = &parent_res->resource_list;
>> +                      resource->parent = parent_res;
>>                } else {
>>                        kfree(resource);
>>                        return -EINVAL;
>> @@ -372,46 +376,78 @@ int devl_resource_register(struct devlink *devlink,
>>        resource->size_new = resource_size;
>>        resource->id = resource_id;
>>        resource->size_valid = true;
>> -      memcpy(&resource->size_params, size_params,
>> -             sizeof(resource->size_params));
>> +      memcpy(&resource->size_params, params, sizeof(resource->size_params));
>>        INIT_LIST_HEAD(&resource->resource_list);
>>        list_add_tail(&resource->list, resource_list);
>>
>>        return 0;
>> }
>> +
>> +/**
>> + * devl_resource_register - devlink resource register
>> + *
>> + * @devlink: devlink
>> + * @resource_name: resource's name
>> + * @resource_size: resource's size
>> + * @resource_id: resource's id
>> + * @parent_resource_id: resource's parent id
>> + * @params: size parameters
>> + *
>> + * Generic resources should reuse the same names across drivers.
>> + * Please see the generic resources list at:
>> + * Documentation/networking/devlink/devlink-resource.rst
>> + *
>> + * Return: 0 on success, negative error code otherwise.
>> + */
>> +int devl_resource_register(struct devlink *devlink, const char *resource_name,
>> +                         u64 resource_size, u64 resource_id,
>> +                         u64 parent_resource_id,
>> +                         const struct devlink_resource_size_params *params)
>> +{
>> +      return devl_resource_reg_by_list(devlink, &devlink->resource_list,
>> +                                            resource_name, resource_size,
>> +                                            resource_id, parent_resource_id,
>> +                                            params);
>> +}
> [...]

