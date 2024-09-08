Return-Path: <linux-rdma+bounces-4813-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3E59705DA
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Sep 2024 10:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D282822F7
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Sep 2024 08:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5333130E27;
	Sun,  8 Sep 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KwzBsMCc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C11366;
	Sun,  8 Sep 2024 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725785246; cv=fail; b=Bo8IXT/WMBk3Ld3SKd+aXTB00929Thrx6Ctp9oZiFML9fGdZA25NmNLjLS2+KfNSn7xq4WPvRkOwU6rhUk/c67TBFY7Km/FUHeg3MqZIvwvVjI0stOGUllGqqWkjioTUZENmTvB4pTU8TdbiW19NQ8X936IZlFnfJl3Bz8l7uSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725785246; c=relaxed/simple;
	bh=k5bsvn6RcCA0qeBbrSjxF/aOLZePXv640rcDweYN2TU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ULSmXdmjgXjXx9A7nW5HVwVOF5hDa3oyrffrI9qJLTYGTu2hTMZJ/lSijIfXBuhjj9Bbdg0fsSd6xxuHP76q4F20VCNSVgVYVf2U8iiNDuJRDIQI2V0tnt3avHjyn7LNJcxqbHWz31FjWeAnjx1bjmQQ3zo19mV7T/5Y5EgFo+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KwzBsMCc; arc=fail smtp.client-ip=40.107.102.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDo+T/xzfY7Q0RlZsyDm5286ZiZgntqjRoooJct59kcylD6cEZoRjVjjmVtA41DsJ5L/hb6TmXYw5An20pUTaEOmyTsWmEwiM5Ukp9sv8mABRchdmsBPMBEaLa4TF+j0P0ALoPHuYXwfPfwiPLH7O4cqXvrFEPCIpOQg5OAeMXyA3vdWkeL8dbpRY1BASWQelXzHNG/YgcpFyU4fpZteKebHwQeWQWQrElQ3xT1OkiuNO8z7G++MVl0lj3TvgIo2CWsdbd++9m0Z0kUnS1U+Qco2h9kP5jaC/Bg+SU4gPLY2INpFtMxRgXkdP730xyQyqNt45pTZWv3mP1NVsMhEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yzeR5n0VHzg0V/kcIKAvzamW4AoicnRFeYJfVk5MNo=;
 b=g2K+IChIlOFcUodpwsJObFTruKGLt0k2d863lY6nnbwBBW0y+NBHAnzKOg3FcE7OJ6wvKkisnpiezjyXkMPSLQ8GxMH36Da5oBlMkto/O7f23aWAUeBOp7D2fpU0mtm/jNb3Qy54QkC1rDL8VXkw9E4vgyOb+6RkEv+5NpWId5HJ/LmfDt1LRBJqKRrCWPUVkVPVzAG2L2B2kAivIQHi94aNZBswtyD8b8NE4mpWpwVJ/Gvo7GDBgJV70uDH5Gv8L4oqRLLBZH0Korv5k0Xx60vqV9enWaN6HIG4zBZm+xDv9yceXbT4+hkwm4mHsmrsMxhu+UuQIEXueMivA0+/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yzeR5n0VHzg0V/kcIKAvzamW4AoicnRFeYJfVk5MNo=;
 b=KwzBsMCctQRqDluCtBqxpl4RVbJQ8cuBlwePIlzlj0bt0TY5UsXdcQJxuxRnWqIqe5GVWhQhUm9W1YUlY0azZaZAkNn+CXxyf3MeCDPGrLFRXrFaCuPJSRh9ECzl+UFezU1fLQ3hPw5HobZ9Is0YAw9uueYg1UHOdY8s5gQ0LMuqTMcfSV5Jdn4URaxU3jaGVn7EXFb+iPcBTRAJb9wlqI8EPxZqkLSw65Nzy/pJdkcguD7bRdkh496+QPXlSaMZLlfEdUgB/WEATqeFZ3G2xTQQGQU8nPWT87J+9syLoGHSqvC3cIPc5h60QK3o51maCeKQH5tnJw0/zJ05681+TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) by
 LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Sun, 8 Sep 2024 08:47:22 +0000
Received: from DM4PR12MB6637.namprd12.prod.outlook.com
 ([fe80::fd9f:1f31:c510:e73f]) by DM4PR12MB6637.namprd12.prod.outlook.com
 ([fe80::fd9f:1f31:c510:e73f%5]) with mapi id 15.20.7918.024; Sun, 8 Sep 2024
 08:47:21 +0000
Message-ID: <fd165e4e-b6cf-4050-8a1c-05e7217ea8f4@nvidia.com>
Date: Sun, 8 Sep 2024 11:47:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 0/2] Introduce mlx5 data direct placement (DDP)
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <cover.1725362773.git.leon@kernel.org>
 <829ac3ed-a338-4589-a76d-77bb165f0608@linux.dev>
 <f0e05a6d-6f9c-4351-af7a-7227fb3998be@nvidia.com>
 <aaf9263b-931e-4b1d-8aea-1218faec2802@linux.dev>
 <09db1552-db97-4e82-9517-3b67c4b33feb@nvidia.com>
 <99b11f32-387c-4501-bd60-efa37618c53d@linux.dev>
 <a50bd6bd-5cae-49d9-8bd8-172f88035d18@nvidia.com>
 <144bf42b-8b9e-48b6-81f7-07af79cb0a94@linux.dev>
Content-Language: en-US
From: Edward Srouji <edwards@nvidia.com>
In-Reply-To: <144bf42b-8b9e-48b6-81f7-07af79cb0a94@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To DM4PR12MB6637.namprd12.prod.outlook.com
 (2603:10b6:8:bb::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6637:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 00269cdc-fc4e-4ff6-289e-08dccfe2da6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXlTODloQ21KaGNVVnlTV2ZyQzlMYmNBVXRTQUF4RmRVa2F1SmFxbmxHVnVH?=
 =?utf-8?B?cjQrV20wTzJKaUlIMWlxVHJzVUFqZHFzVXZ0WG4vRnZuMVNJakFkVHA5QUZ1?=
 =?utf-8?B?ajdiVEF6ZktFV0FBVy95dGZhZUFtNzZOSzFmaDJ5eW1CRmhuSmhuQlJHTWRt?=
 =?utf-8?B?UjZsTExrajdBd0pudXNKcjhIbEU1ZXlPUXNYeTRlUUFXUVlTQXB5YkcwY0xN?=
 =?utf-8?B?bUd3YWtzRDM0VUErUU9ZMW05b3YxZUJNTVJOSFArTzcwaGxteDlNWjNNekhm?=
 =?utf-8?B?NzV3RWo1VFVsSzl1MlNaSVNCNktTMVQ5SzJoUW1SN3BKZUhSV3p5VzFXS002?=
 =?utf-8?B?cy9LTDcvY0plM1ZRc21aa1R0M054M1o0ZTZxRmIzTzVFcWc1S1FKMzJHUFFp?=
 =?utf-8?B?N05PdlN1NkNSWVc2QUhicWZUM2J2SURmWjNXRU0yWjVOUFl3YnVnc2l4WnlK?=
 =?utf-8?B?RjNRWTdseFlESG4wQmsyczZtZ1hmS25HZXkrWGpkZzRFNHY3NEE0SFkvMk5m?=
 =?utf-8?B?cDdNSEIrWDFvcXluZ3lOK3p6M1FXT2FZQVV5cUNRTmc4THprc2hOL1BpeXY0?=
 =?utf-8?B?YjVZbmNJb2MyMFF5bVdZRDkveERBSVZKZzR5Z2I3UjV6U2dMNFRzUEl6bUZw?=
 =?utf-8?B?WHVaRVN6ZiszeVBnWXR6aGdTbm5uVjhteFpIK2pXZGY3bmppT3N3SHZoUTlr?=
 =?utf-8?B?Rjk2OEh4Q3A3c0dzdEhwNEZNR3V3cDMxS2FMRWhnUmUwODJsdW5pL1JqK2sr?=
 =?utf-8?B?azBqYkRjelMxTWxJeFlXUXdtWnZBZnV5SUF3QzlXeCtESUxOSzh2NitGVmxm?=
 =?utf-8?B?OU1PcTlRNk9qaDJDN0RieEVDYWpMREF3WTRROEhrTzdaVGtMRmVYdmo1TXZ2?=
 =?utf-8?B?V0ozRUVoTlpHUCtwbkdIY2d2N0FkTEVWeTFOZWNMSzM2dk5lNW1KZ2MrQTgy?=
 =?utf-8?B?eGNCSkp0VFZGSkZnZDI1NE9jdkNJRXZSYVFWc0g4K3huK0tWdnhWVGdSbmpX?=
 =?utf-8?B?RllFWWFDU1NDcWtSbTlDeityQUkycXZ2ODJSYlA5eWlrNG9UaEIrZVlvM2pK?=
 =?utf-8?B?SWxqSFh3VENPSGtvVWNjOXJKWEVzWUN5TkkzQzFVREtSNnVRYVVLWFY0MnM0?=
 =?utf-8?B?YjBiblp0T2ZKV3ZobDRVb1NIQWR4b1EwK2J5MUd1c3ljK28wQVBkMlNFWlJS?=
 =?utf-8?B?Y3I1c3VyaGZwdnl4QlIxUy9mS3FBdEVoRHN5bU9raVVqMUtjUDlEQi9yN1lM?=
 =?utf-8?B?SXhXQXRkSUE1Y08vRkNPSVhXdldVaGpHYmFIUk9yWC9NMmlzbkZtVkJPQ1Jp?=
 =?utf-8?B?ZW5rM1JEM2laZFNENEFlZzRWVVdobjY2cVd0d2dqZ1BEeGJjcThxNTVjUFE1?=
 =?utf-8?B?d1lsSlVRSzBwejRpR1l2V0tnRDlSRnY2Y2YxbXZTQ2t2MVhiREh6eW16Z1Uw?=
 =?utf-8?B?N1AvSk9hZVdLcUNqT0t2b3o2ME1QTnpuUTkrL0J3dVJsYWsyY1NZSzd6cVBT?=
 =?utf-8?B?aW9DR21yOVRDd0YrVXhxd0NkRzllSXdIb2FYT0x4QkZFd2I0SzdwSm0vV2hH?=
 =?utf-8?B?aE5kWjdzd21samdsQ2JsTFRJcVFHQklidDhvUThpbzQwTUgwd2JySzdtQUpP?=
 =?utf-8?B?SjdFeFpsTk55U0RMZFJaVWhBUk1tazM5azNSSXZoVnRzc0hDU3p5Ry9oOXJ4?=
 =?utf-8?B?NmZ4dU9BUHAxUk1pL21tdll3TDNiK0RZU29laGpyZi93NjFVOVMyOXYyUFk5?=
 =?utf-8?B?OXBHeUZsVG5JdkF4TElZTFdPWHhTdlhaUmxiclFEMUZnV3JMUm9yeHFsZEYv?=
 =?utf-8?B?eDZKdmZkT1dpWWt6aFREUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6637.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUtybEJHeXh6cVZaK1pGSkQyc3FHd3ZsRmhjcHRmMEJhSFQvb3RocElhVjVZ?=
 =?utf-8?B?Q2ZkbWl6OVpBQ285NTVTTVhiQVNJN2xuR1hKT1VDRFZMWWJOZFQrMXRvYUpR?=
 =?utf-8?B?UHRwTHNkQ01QdHhibC9NS0FpME9qZ25hSFFkTWxnN08ySkpmdW1jcFVFaWFH?=
 =?utf-8?B?U0pMOUNFYzBBUDY5L1oyaEtBdURpaXhQUnlvUFdYK3IybUdtbWFFTmJUSUZM?=
 =?utf-8?B?VHhYVTNjU1VPSm9BZ3FFcFVDN2wyUUNOb2w5TGFYNEY5dlJ1VGNUamxOOFVk?=
 =?utf-8?B?MjNIZDVZckg0V2FPSm8rZWVqNHBaOTRwQ3RYeXRML2hYbkN0ZW92aU1OTjc4?=
 =?utf-8?B?TjFCQ3VOVUJmbUE1K1dJNnY4WlFBRW54VXNVVkJOaUlWQzdsb2JmbHV1VXo0?=
 =?utf-8?B?QmVvMjFqNTZ3bENYRnJOUGk1SHVLNUw3a0R6UkpGcHIxRm1OeC9JcUhJQy93?=
 =?utf-8?B?cFN6ZmpUbnRaQXhSUmUxd290MDVsVWdpQnZoTjV3RGFWQmxXditjZjRqL2Iz?=
 =?utf-8?B?dFcyWkF0ZjRnTHl0NHBBRS9OWWozUWZTL005TVh4Y2l4enR4WWVXU2ZPUkJz?=
 =?utf-8?B?alJxUmh0TWdOVVh0VFp2Rmd3dThmS1J5KzNOeFFYc2VLSjJQVURtTUJMeE1X?=
 =?utf-8?B?Y3JobFNNKzNTUW5RMVFtNGp4Rld0RGwrUGJ0d3BmZVpLemlubmNhRzFFMnpH?=
 =?utf-8?B?OURBYXJVTkwyRktJeEg5a0VzcUtuQzRURkF2aG5od0trQlB1TUlDdDZ4cytt?=
 =?utf-8?B?SzJPZS8vZ1Q0ek1WL2pLM2pJdFRkQi9Fb1NvcExHamI2ekt4bDFLYUl4Q3dL?=
 =?utf-8?B?Q2x1V1lOTU9hT0M3L2E4MjhibCsvQzVvQmR1ay9NMng5R1ZiN05FRndNWDlZ?=
 =?utf-8?B?a1M4cHBuTVlnTmREVC9PWUhBUVBUZ2hwUjRkZm1LNmxMQ05xclVnYU1PZ0xK?=
 =?utf-8?B?cmRVbVdEYkd0ekQzc2lpVlVNQ2libkxDMlNIblJWWTN3QlhKUGdBVVA5djF1?=
 =?utf-8?B?Yi9SUU9ib1U4NE8rWHdBVXhqNkFqbVJVSEVQODU3eGp3eE5RV0YzcHkvL05M?=
 =?utf-8?B?VDU3U0xBcUJNT1RSM3NZZithUURBRjFnbmYrMHo1QkkwYXM4SlB3UjRua3Ja?=
 =?utf-8?B?VDQrZXpGb0Jna2plVUN4enViN2M5QnlQTWFnY2NiVHVpWUduVUJaTFMzMnFi?=
 =?utf-8?B?NnU5Zm1QQ0RPRnBlbzBOVVlxRWU0MUMvajZBaFoweVd6Q21uMEhaSU5nT1Iw?=
 =?utf-8?B?WVdqYmdydmRxaDVkUzhndHhSdk9mbnRPL2FzUUg1cUh3MDJkdUMzK2p5Sllz?=
 =?utf-8?B?dmM4eUxWTFFqUjEvWE9TNWFzbmJlTmtFWDduMC9QY1RJa1ZMNkUxcmcyNjBI?=
 =?utf-8?B?ejY3V09FR1lRaFVrcVh5UFd1TlBNZkMzeGphNERIZnhWRUJMa1dhNnJvMmVB?=
 =?utf-8?B?dkoreFJRQ3VuR1hCZm9IdTZqenZuOXlzcW1ranNOSllOQ2ZUeEQ3M2JQK3hq?=
 =?utf-8?B?aktuVll3Tm1sWUFmcFZMY1U3RDYyUVVLMnloQys2bW1kSWhLSjRyNnFLVjEw?=
 =?utf-8?B?UmxPTEUrYlM2RlJ2MTFLQWFIaVNaQ1EyVm94eGZxeTlxNHhSaW8yRXl5WFBr?=
 =?utf-8?B?ck1ETXlVUUxOZUZBb2lJeFVYNzJQZ2E5SkdDUk40WnhHRVlBQVBsUHp0bjA3?=
 =?utf-8?B?T1o2TDF3TzhCdXlBdFZXRmt3WTZmKzhqRkhIVEVlRkllNXJnbmc2aXl2WExT?=
 =?utf-8?B?dXNHTkNwSUIxMURjWmxPeEVyTjBkNExwbmdyaTNHeEM2eTY3NW1oN3FBWFVs?=
 =?utf-8?B?YUpZWndBVVlTRlFWUXdRMXJnMjYrNEhXTVNvZXJyZE1hTVkrb3ZQVFo4dm9M?=
 =?utf-8?B?cEMwOVBKa0x1b3F5YmJ1aWY0M1pNbDBQeFZRY3Bpenh0NEp2MFVDcEIxaWY1?=
 =?utf-8?B?OVBOVnZ0dUtjVHVhOFg2SjNicU90cjJmVmpJVFZHOHMrRnpKQTM5dG1ENmtN?=
 =?utf-8?B?L1N5VG9MOGJkbWNqU3JyT2xiQWNoQVk0cVlDM1hJWnpBNDdadDFFcFdEU1Z4?=
 =?utf-8?B?amJYYk1FdDU5bjlhZ2gvaEszcWxyNzhMZHowMC9tREM0ODBSVytYY3ZMeklv?=
 =?utf-8?Q?ViP68mknRxUPwYu2dlubP9e0F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00269cdc-fc4e-4ff6-289e-08dccfe2da6c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6637.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2024 08:47:21.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQrHNkMCFuNFFOvh6v6C+NE3y/aR+b9r0zv4F9Nm1TKU+SO3sx7EM9uCexRb13E6GXNyYXmTVCb7CN1Bx7G+Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822


On 9/6/2024 6:17 PM, Zhu Yanjun wrote:
> External email: Use caution opening links or attachments
>
>
> 在 2024/9/6 20:17, Edward Srouji 写道:
>>
>> On 9/6/2024 8:02 AM, Zhu Yanjun wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 在 2024/9/5 20:23, Edward Srouji 写道:
>>>>
>>>> On 9/4/2024 2:53 PM, Zhu Yanjun wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> 在 2024/9/4 16:27, Edward Srouji 写道:
>>>>>>
>>>>>> On 9/4/2024 9:02 AM, Zhu Yanjun wrote:
>>>>>>> External email: Use caution opening links or attachments
>>>>>>>
>>>>>>>
>>>>>>> 在 2024/9/3 19:37, Leon Romanovsky 写道:
>>>>>>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> This series from Edward introduces mlx5 data direct placement 
>>>>>>>> (DDP)
>>>>>>>> feature.
>>>>>>>>
>>>>>>>> This feature allows WRs on the receiver side of the QP to be
>>>>>>>> consumed
>>>>>>>> out of order, permitting the sender side to transmit messages
>>>>>>>> without
>>>>>>>> guaranteeing arrival order on the receiver side.
>>>>>>>>
>>>>>>>> When enabled, the completion ordering of WRs remains in-order,
>>>>>>>> regardless of the Receive WRs consumption order.
>>>>>>>>
>>>>>>>> RDMA Read and RDMA Atomic operations on the responder side
>>>>>>>> continue to
>>>>>>>> be executed in-order, while the ordering of data placement for 
>>>>>>>> RDMA
>>>>>>>> Write and Send operations is not guaranteed.
>>>>>>>
>>>>>>> It is an interesting feature. If I got this feature correctly, this
>>>>>>> feature permits the user consumes the data out of order when RDMA
>>>>>>> Write
>>>>>>> and Send operations. But its completiong ordering is still in 
>>>>>>> order.
>>>>>>>
>>>>>> Correct.
>>>>>>> Any scenario that this feature can be applied and what benefits
>>>>>>> will be
>>>>>>> got from this feature?
>>>>>>>
>>>>>>> I am just curious about this. Normally the users will consume the
>>>>>>> data
>>>>>>> in order. In what scenario, the user will consume the data out of
>>>>>>> order?
>>>>>>>
>>>>>> One of the main benefits of this feature is achieving higher
>>>>>> bandwidth
>>>>>> (BW) by allowing
>>>>>> responders to receive packets out of order (OOO).
>>>>>>
>>>>>> For example, this can be utilized in devices that support 
>>>>>> multi-plane
>>>>>> functionality,
>>>>>> as introduced in the "Multi-plane support for mlx5" series [1]. When
>>>>>> mlx5 multi-plane
>>>>>> is supported, a single logical mlx5 port aggregates multiple 
>>>>>> physical
>>>>>> plane ports.
>>>>>> In this scenario, the requester can "spray" packets across the
>>>>>> multiple physical
>>>>>> plane ports without guaranteeing packet order, either on the wire or
>>>>>> on the receiver
>>>>>> (responder) side.
>>>>>>
>>>>>> With this approach, no barriers or fences are required to ensure
>>>>>> in-order packet
>>>>>> reception, which optimizes the data path for performance. This can
>>>>>> result in better
>>>>>> BW, theoretically achieving line-rate performance equivalent to the
>>>>>> sum of
>>>>>> the maximum BW of all physical plane ports, with only one QP.
>>>>>
>>>>> Thanks a lot for your quick reply. Without ensuring in-order packet
>>>>> reception, this does optimize the data path for performance.
>>>>>
>>>>> I agree with you.
>>>>>
>>>>> But how does the receiver get the correct packets from the
>>>>> out-of-order
>>>>> packets efficiently?
>>>>>
>>>>> The method is implemented in Software or Hardware?
>>>>
>>>>
>>>> The packets have new field that is used by the HW to understand the
>>>> correct message order (similar to PSN).
>>>>
>>>> Once the packets arrive OOO to the receiver side, the data is 
>>>> scattered
>>>> directly (hence the DDP - "Direct Data Placement" name) by the HW.
>>>>
>>>> So the efficiency is achieved by the HW, as it also saves the required
>>>> context and metadata so it can deliver the correct completion to the
>>>> user (in-order) once we have some WQEs that can be considered an
>>>> "in-order window" and be delivered to the user.
>>>>
>>>> The SW/Applications may receive OOO WR_IDs though (because the first
>>>> CQE
>>>> may have consumed Recv WQE of any index on the receiver side), and 
>>>> it's
>>>> their responsibility to handle it from this point, if it's required.
>>>
>>> Got it. It seems that all the functionalities are implemented in HW. 
>>> The
>>> SW only receives OOO WR_IDs. Thanks a lot. Perhaps it is helpful to 
>>> RDMA
>>> LAG devices. It should enhance the performance^_^
>>>
>>> BTW, do you have any performance data with this feature?
>>
>> Not yet. We tested it functionality wise for now.
>>
>> But we should be able to measure its performance soon :).
>
> Thanks a lot. It is an interesting feature. If performance reports,
> please share them with us.
Sure, will do.
>
>
> IMO, perhaps this feature can be used in random read/write devices, for
> example, hard disk?
>
> Just my idea. Not sure if you have applied this feature with hard disk
> or not.
You're right, it can be used with storage and we're planning to do this 
integration and usage in the near future.
>
> Best Regards,
>
> Zhu Yanjun
>
>>
>>
>>>
>>> Best Regards,
>>> Zhu Yanjun
>>>
>>>>
>>>>>
>>>>> I am just interested in this feature and want to know more about 
>>>>> this.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Zhu Yanjun
>>>>>
>>>>>>
>>>>>> [1]
>>>>>> https://lore.kernel.org/lkml/cover.1718553901.git.leon@kernel.org/
>>>>>>> Thanks,
>>>>>>> Zhu Yanjun
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>>
>>>>>>>> Edward Srouji (2):
>>>>>>>>    net/mlx5: Introduce data placement ordering bits
>>>>>>>>    RDMA/mlx5: Support OOO RX WQE consumption
>>>>>>>>
>>>>>>>>   drivers/infiniband/hw/mlx5/main.c    |  8 +++++
>>>>>>>>   drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>>>>>>>>   drivers/infiniband/hw/mlx5/qp.c      | 51
>>>>>>>> +++++++++++++++++++++++++---
>>>>>>>>   include/linux/mlx5/mlx5_ifc.h        | 24 +++++++++----
>>>>>>>>   include/uapi/rdma/mlx5-abi.h         |  5 +++
>>>>>>>>   5 files changed, 78 insertions(+), 11 deletions(-)
>>>>>>>>
>>>>>>>
>>>>> -- 
>>>>> Best Regards,
>>>>> Yanjun.Zhu
>>>>>
>>>
> -- 
> Best Regards,
> Yanjun.Zhu
>

