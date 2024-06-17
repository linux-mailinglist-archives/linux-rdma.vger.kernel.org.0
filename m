Return-Path: <linux-rdma+bounces-3190-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1471C90A349
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 07:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1CB1C21015
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 05:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1077180A71;
	Mon, 17 Jun 2024 05:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="etqIVgnz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1F224D5;
	Mon, 17 Jun 2024 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718601444; cv=fail; b=GSmtkHbDwiFQFVI2jwfkn1AyU5ep3kvtoPOtOl7YWmjvzSZpANBzpadzRbwq3ZJmM2KdjfeN/mBtPPTiVrdG8Q7hODbYsUmxIk0DpliBMeRB/Um6qtB2D+L4mRp3H47a9+bpWbJ2xjB2qf1aJ0SJ7p7HVOFXEG6VyjvxywEa1wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718601444; c=relaxed/simple;
	bh=UMMIZx8aAKWh10o3GWeU0q1qFWrJMFZXt7PfgOAy+5I=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tFIzQDWuw8hgtaCPrczMw9AXl/X2S6ET9sjBss+ei+CTzfUCR9zh1ILuEuNYFSNdbb77PCqp8erMay88twRhxeypYhpJjp8mzPakS0e04GwPBxcOUqmR6toRjnmDrm6Qyfn80iE0j/WsVjB+Mv6RYimZ7Z/bfBaIeLb9OZ/kit0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=etqIVgnz; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lufpANp2xmqVe6S7KTixZagYm1qHHqvyWndzqZdItBzDaF6hyI1CtpQj9d954yfSDNlFPKVhb7GLQRAzWet1iP4CpTpjwPTgXBXI9PmFf9W/0yH5KnF1Q6KQKBjM/LvYh0IoKmlZaZPxJGFmtY2dCdFaQ6y/zxTBTUkmtMfjSWxbBz17istIoYifAi99y5X3WCqXZe8EWLn7IhJ1r+59eswpDSjOmafHUu80wFpbweCIRoTvfB/29UCEKWwOdzrG6WOT2UbZ5B7UL3n8dCOFMYN7tz++eLZbb0reZ7CxTbOCu7ZZJJH48OisDf2USBuEMLiLlVFYaOqwauck2hXaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV+ayOKKpSJ+RLpbhBFkCuQTrLBSsACDSv2Kr/XwH0I=;
 b=MDRFU5ry/kkIeYzjs1hQu4/4egcaPCKEQ0tg77bUoY0ZkH//ylP7aIHcZ+JRWyU3axMeVpG/UxFbAVlBoIf6r6AMxoIt986RzSdAMubi42dWBLa7VCoP1h6VNz8WnunhjGKdVKjksXKgFpXD4F4pCKKZ1cEGU4ntk9icuQNkvRaDp8FuIoXtl7X3vSGNpjdrzGDArGi6IKqCAwSY7EnbkOGMH9UX4VHv0/ejVa8Ec3dsaC8ooGLe9Klsd5DqOoxI1eHAr7l6zY9+NaRCAas7QgmN5Hfkh9cc1YcG2vRbhXijFxhOHZcXqF8E/qMvHMKLEr1nMUu2o+ojIdCelrsVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV+ayOKKpSJ+RLpbhBFkCuQTrLBSsACDSv2Kr/XwH0I=;
 b=etqIVgnzkooSiTpDyu+mUbHMz6D7tsTYKOi0vprqNcPvNVE8CgauUPRYyBu5a+MPsTNKyyxkTzR7uiSq4hUidTn7RWNI70kF/hMf8OX0nacouCKEpKLRAznA/FT2gCy6TPzbnEp1iTNvKfUXiXu2ybajcGPMkVwRIzQdhkGs/z59ciQMi/vvAWE/uT8uAD6WUyRCRoyS0Su744SxG5oD9oTeEX5bQNtYv7L9/7cbkI6c9BW0kOOY9sN1XoRyiuJaCaQj/UYFMPe8ygrbh0PPi0Sx0F8Co0R11WX2qoVbA7YUKpFsl/FoNq5Pn+pZH+E/NXmclVUOtqJsgJFcq96+TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 05:17:19 +0000
Received: from IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::c3b8:acf3:53a1:e0ed]) by IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::c3b8:acf3:53a1:e0ed%3]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 05:17:18 +0000
Message-ID: <0a528fe1-59cf-4761-9827-5f12ca886884@nvidia.com>
Date: Mon, 17 Jun 2024 08:17:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v5 2/2] net/mlx5e: Add per queue netdev-genl stats
To: Joe Damato <jdamato@fastly.com>, Tariq Toukan <ttoukan.linux@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nalramli@fastly.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240612200900.246492-1-jdamato@fastly.com>
 <20240612200900.246492-3-jdamato@fastly.com>
 <0a38f58a-2b1e-4d78-90e1-eb8539f65306@gmail.com>
 <Zmttd81M4g_FF7A9@LQ3V64L9R2>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <Zmttd81M4g_FF7A9@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0674.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::6) To IA1PR12MB6018.namprd12.prod.outlook.com
 (2603:10b6:208:3d6::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6018:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 5851ffd9-8480-4da5-1f48-08dc8e8cc266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|7416011|376011|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a21zV0NYWHdHRVZySXJjcGs5dmJDeWEzczQveFByVEpFN09QR0lDY1c0UVZ4?=
 =?utf-8?B?RUl3RE1QQSt1MGV2SnpFM1RrS1poUjhNL3ZoL1hocEw3ZEt1Z0ZseEkvamZs?=
 =?utf-8?B?aGp4OWhsbUkxUHI4THZOaG0xTFgxN1RZZ2l5b0NwTkFKN3gxdFJnZEY0My9I?=
 =?utf-8?B?d0MxcjhrcEU2d0E0TEhWRWlCK2RTMGFleVozR25YUXBGaVUvNXMyckpJMXhU?=
 =?utf-8?B?TUNXYTNHTGhGRDJhMkxTdjVFTUdpak9JcFhXanpqT1hOMWJvb2p0UzZlNU9w?=
 =?utf-8?B?M0F0b0lQZHFNOHM4eHpXUDNRczEySEhRQjRKNkZsVmd3QnVKN2ZHWlZiVk0w?=
 =?utf-8?B?UFVYVzEzQmJhekI1b0RlcWxQK2o3WldvM3dFQTNOeHJZRUhvVzYxd0VRSzBS?=
 =?utf-8?B?dE1Wb1ZuWW5pM2VkemhTUEVQRkROUGVuMzMrZGVXR00xcjBCcElxdDBWcHlU?=
 =?utf-8?B?UzdEL3NHZFl2NnluQUlBckVWeGNLc0FuV0NEWUUrY0dENy9JRzBmMEtJQitj?=
 =?utf-8?B?T0g4UGlCanZoa3RJa3RUdXBxY21sa1B4M1ptdnJnZjNpUnYwMStMaStmQlV0?=
 =?utf-8?B?enJKY3QyTWNjcVI1Qzc3RlVyUW8zZ0w1Q0g1VFFUL3o1L3FrRERTY3JDaFFv?=
 =?utf-8?B?VnhBcHNpc3NONCs0UzNCaUp4eXAwSURaalNaTmZlYzNHbGh5ZUFFRldOaVlD?=
 =?utf-8?B?SHVSQ3BIVCtvYzI1bk1XVStkYmJQSlZEZ0wyRWs3VFA3ZEZDOVR4cjRoNkIw?=
 =?utf-8?B?ZDZzRm1OTi9DeHVNVGE5b0FESktGRXc0RlRVSFRKOHJlVHc3c3kwSW52bFlR?=
 =?utf-8?B?amVvd2hXdDdmeWFWNUNFMFRObWwwT2pIeE5EczBvSjVmR0N6VmZibGo2UzQv?=
 =?utf-8?B?OFVHQTNreWlTNVA4NUtaK0w4UjJlUGw5ZkNPUVpURlJteHo1MFVabjlJL200?=
 =?utf-8?B?azV2ZFdQOW5wUG9hT3FvOHhTYmRaeS9nVUdnMEpybURxYVd4U2pjZXVIeHNH?=
 =?utf-8?B?MXJGNXVEdjRTUUJ5S2Q1WWl4aTRDdCs0WDUwTnJZZnpmVnhQNGIyeWhhU0ky?=
 =?utf-8?B?VHNkeWZPT2NUTUplR1FkWk5KN2gweHF1dEVud1l5R3pEckRDT3FWL2Y0TDZR?=
 =?utf-8?B?SnlMazBPRFVMSWh0em1ONnFWYzZSUlZlYlY4UmtHOGw4M29jdVJhTHE2YWkw?=
 =?utf-8?B?Q1lQU1E3QngxaG1nUGRTRzFpMXlPSlVPc2tXRUdhV2NlWUlUU3FZQVFEOTNt?=
 =?utf-8?B?M3Eyc2N6NEgrZ1M1bWp2UytjWUF4ZTliZzBwRkVuV2xnK0tkMXY5NFByQmtx?=
 =?utf-8?B?NVliTVJIeFRGQ01RQVdTQkZjdVEwN21ac1BianJNcHAvOWxNaEFwTVIxdmFC?=
 =?utf-8?B?MnZHU2d0YWhsUVFjOEhHanRYRWJCZEpST0Q0ZmdaY3h6QUdsU1VkSEdVZG8y?=
 =?utf-8?B?SVlYMEI0UmgrT0J3djN0dXNaVTNjdDhTalU3SVRsOUkySXZJSUExNnpQdmJH?=
 =?utf-8?B?UmphOCtWSThxMXd5MlR5dVllSXhpbWZCNVJ0R2U1ejRiWDdzWnJuTUorc0J2?=
 =?utf-8?B?eFlkVTJERDR2Y3l1aDk0clJqaVprcWxHVnpLd0NJL0Q3Q3U4OVZaOE1kU0pL?=
 =?utf-8?B?bFFlbGJLOG9CTUl0Z3I1Sm0zaHlVZkVHOTMvaDAxR0JTb3BWQWFkekVsNmJB?=
 =?utf-8?B?MWhYRzJvUTB0MzFGTkI1S25laFpQSDAyNU9ORkUvTzhRMHF0WEpLRm1PK1k4?=
 =?utf-8?B?NENLc3dCTmwyZXdEV0FZaUJoVHFsbk9lRkc3UlVndjE0ajRwZ1dIaEJhbHBj?=
 =?utf-8?Q?ywXWa8fayS7OaebuKW0dPBDVef7xey1cCKK7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6018.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFhYWmlnNlJmMlFNK2JlaU45K3EyMkJaWVkxLzRsRDFaSTFpTUM1OVJ4SmdW?=
 =?utf-8?B?bVB0aENjbVFxbGhzV3hFSW5QYWxaNWdKS3ZXVGNEdUFPZEZDYVlqTTZQKytm?=
 =?utf-8?B?WlA1L1Rsb1ltZDYxcGNFUk85WkpmZ2s1WjlLZzBPUGFFS05FUlQ3eThUZ0U4?=
 =?utf-8?B?VUpoVXBkclAzL0R6OHJoRTFYS0RObTBJY0xrVUxyM2Y3b2NPNThyVFhVTnV1?=
 =?utf-8?B?cTZ1R1N0Vzd5anJUSGtEb1VXMFg0OWRyVWpCSWhnRzMra2FvajNRZzE1Z2hT?=
 =?utf-8?B?MjV4bHJsdlBHOXI4TGI4b2NjRU9IaGxrRitJVTU3OHVlQ2c1Ulg4SVc0Vm9Y?=
 =?utf-8?B?VVJuaE5yV2pUemM0R2E1T28vV3dUc3FTQUM0UEtmUlN5Ri9oZ01wb04wbTRZ?=
 =?utf-8?B?YytCb3ZJa00zZDcwVm5DTFZJdzlSVHVBRmZFem9XTW1idVBrblZabWVsTlIv?=
 =?utf-8?B?VExEYndJcldkZWpHb2tkbDNqTkdEenZJWW8xMkNLMW40OTVTSjNkUk52S0VM?=
 =?utf-8?B?bFNDemNMQkkrTUJocnNoUUNHRmNYNVh5Skx3U3U2cjYxTlduakd4MDY5RzJZ?=
 =?utf-8?B?eGtld0ZwQmRzWG0vSlMySEFhMTNSbmwwMDNvblVscUxTT2xKL1VRc1NwY0hq?=
 =?utf-8?B?V3RhUHkzUjF2dURHNWpvMzNFQ2dNZVpmalB5cVBod1NwWnFiMkFWSFVrcW1I?=
 =?utf-8?B?UnFhVld4OWR4RmJJSE4ydGZncnMvbDQxamxaRVJLVWJKMFVHbTBOTituOHJZ?=
 =?utf-8?B?ZGMwVEtEL2RGMUNucUhEb1ljaEk2Q3B2aGRqMjQ1aW41QkxRYzhvemQvVThP?=
 =?utf-8?B?RGtNMnpNNXJpbnA2czNrdnY3aGd1K1BueTJ2YU41U2tYMkR2dHJHOEJsZ3Z6?=
 =?utf-8?B?RDBObkhTNEdLNGtmTE42RGF4ZnorK1pIaGREOEFLc1ZYc0FhVEpPbnhJNWcv?=
 =?utf-8?B?dUZpM21PdEQ4UXJWMDdCVzNpYjRXYVhHTUFHSVJ2Mml6bWNhNWpyTmxnZlAw?=
 =?utf-8?B?SEdZdllJV05UZ3ZabEt0MkV3NitXc0o4K21jMVZ4a09zNzVqTTN4M29xSU1O?=
 =?utf-8?B?T0UxZ1Z5QU1KZDJpOVlUbmF1WkFyMHBHNWRvbnlDa1BlaWhEbU9BbW5yM3V1?=
 =?utf-8?B?eGlkYnYvaW1ycFpkNW5XMEd2dis0bFhlQ29VV1JHQlkwT2x4M3Z6TXB1alN4?=
 =?utf-8?B?dXQxYUJxeGxhMkdmbnJuLzEvOGNCQkJ1TkI4ZkgzbktrbDVBVkxXZE5ST25k?=
 =?utf-8?B?TFAyL2lncTZ1NHFkUzJXSTBwYS9rRFBPTktRZ3pyYjhSdGg3UklVaWcvSFU5?=
 =?utf-8?B?VlhlSDkyMzlkdTQ4bmtRVFpsZkplZXVTQm5aWnJoL0VoK1NFMlBSeFZNWEp6?=
 =?utf-8?B?Nk1Xem9JQTAxdFg1SEs4UmN3Z1hqKytJVUxsaEZsdWdaM2orOEFzVnZCRmJO?=
 =?utf-8?B?Q0h4L2g2dTJxYnhvN09sMzlLZVI4MWtmUlJENWRBN1Azb20wVkozQVRCK05D?=
 =?utf-8?B?OGI1OXBFVXd1ZnBwZVdVVzJSQXBhRnNtU3FObjJZeW04SGU4M0kxckRaYWVs?=
 =?utf-8?B?VFB4OExMblFLcTh3Y3lleTY3Y1FVbzVxRWtpTWhCQUJIWFFaS0ZXbFVtN2U3?=
 =?utf-8?B?aHg2c0c3dzdPZHpiYzhKbkJOSGRIK0xZYzlmdnViNGdxOUx1empqR1lOdTJX?=
 =?utf-8?B?S2VZZE9ka08vdGgxY0lLNHFJb2s1T2F5cVl2N1A0aXRvUmhYSHBSZ1lKcE1p?=
 =?utf-8?B?S05XSmo4VEpuajBIdyszUE50SkFCbWkrVzZFMUtsVWwrYnlud2RIdldLbnl2?=
 =?utf-8?B?dDlxK3VjeHR4R1grNUQySFRBNkFnRHZ5L3FXc2JiU1d4U0c3Y01YMUw1Wk00?=
 =?utf-8?B?a2poTXZHT3F0eFRNd3VHbEE5S0g3bm5GeHlRcHVldVg0YldROE1KOEJJL3Uy?=
 =?utf-8?B?Y2grMTRuV3lxamtOVmV4MjF4a3lYR2ZWQlg2VTlkYXBBWlhva255ZVlpT2kx?=
 =?utf-8?B?Z3hMekVjRDh0WHFVa2N5eWhDVzg2Y0s0ajVkNkVXTTBsRGtUbjhsZXV2amFw?=
 =?utf-8?B?THFJL1ZHUm1JZ0ZseW5hOXlzTHBvU0QxVE9QZWwwMFJDSVYvTDJYY3k5VEp3?=
 =?utf-8?Q?vn2DDR48LEys3+gOcDIbNHkSP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5851ffd9-8480-4da5-1f48-08dc8e8cc266
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 05:17:18.9354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWquUMBEc5Q711qWurysMStLMFaKgfVHzj562kStCgrYdel0tKPCRKdZtFwuUn6MnoQKq+QR0yRFnFgZRJjq+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265



On 14/06/2024 1:06, Joe Damato wrote:
> On Thu, Jun 13, 2024 at 11:25:12PM +0300, Tariq Toukan wrote:
>>
>>
>> On 12/06/2024 23:08, Joe Damato wrote:
>>> ./cli.py --spec netlink/specs/netdev.yaml \
>>>            --dump qstats-get --json '{"scope": "queue"}'
>>>
>>> ...snip
>>>
>>>    {'ifindex': 7,
>>>     'queue-id': 62,
>>>     'queue-type': 'rx',
>>>     'rx-alloc-fail': 0,
>>>     'rx-bytes': 105965251,
>>>     'rx-packets': 179790},
>>>    {'ifindex': 7,
>>>     'queue-id': 0,
>>>     'queue-type': 'tx',
>>>     'tx-bytes': 9402665,
>>>     'tx-packets': 17551},
>>>
>>> ...snip
>>>
>>> Also tested with the script tools/testing/selftests/drivers/net/stats.py
>>> in several scenarios to ensure stats tallying was correct:
>>>
>>> - on boot (default queue counts)
>>> - adjusting queue count up or down (ethtool -L eth0 combined ...)
>>>
>>> The tools/testing/selftests/drivers/net/stats.py brings the device up,
>>> so to test with the device down, I did the following:
>>>
>>> $ ip link show eth4
>>> 7: eth4: <BROADCAST,MULTICAST> mtu 9000 qdisc mq state DOWN [..snip..]
>>>     [..snip..]
>>>
>>> $ cat /proc/net/dev | grep eth4
>>> eth4: 235710489  434811 [..snip rx..] 2878744 21227  [..snip tx..]
>>>
>>> $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
>>>              --dump qstats-get --json '{"ifindex": 7}'
>>> [{'ifindex': 7,
>>>     'rx-alloc-fail': 0,
>>>     'rx-bytes': 235710489,
>>>     'rx-packets': 434811,
>>>     'tx-bytes': 2878744,
>>>     'tx-packets': 21227}]
>>>
>>> Compare the values in /proc/net/dev match the output of cli for the same
>>> device, even while the device is down.
>>>
>>> Note that while the device is down, per queue stats output nothing
>>> (because the device is down there are no queues):
>>
>> Yeah, the query doesn't reach the device driver...
> 
> Yes. Are you suggesting that I update the commit message? I can do
> so, if you think that is needed?
> 

No, that's fine.

>>>
>>> $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
>>>              --dump qstats-get --json '{"scope": "queue", "ifindex": 7}'
>>> []
>>>
>>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>>> ---
>>>    .../net/ethernet/mellanox/mlx5/core/en_main.c | 132 ++++++++++++++++++
>>>    1 file changed, 132 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> index c548e2fdc58f..d3f38b4b18eb 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> @@ -39,6 +39,7 @@
>>>    #include <linux/debugfs.h>
>>>    #include <linux/if_bridge.h>
>>>    #include <linux/filter.h>
>>> +#include <net/netdev_queues.h>
>>>    #include <net/page_pool/types.h>
>>>    #include <net/pkt_sched.h>
>>>    #include <net/xdp_sock_drv.h>
>>> @@ -5299,6 +5300,136 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
>>>    	return (mlx5_vxlan_allowed(mdev->vxlan) || mlx5_geneve_tx_allowed(mdev));
>>>    }
>>> +static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
>>> +				     struct netdev_queue_stats_rx *stats)
>>> +{
>>> +	struct mlx5e_priv *priv = netdev_priv(dev);
>>> +	struct mlx5e_channel_stats *channel_stats;
>>> +	struct mlx5e_rq_stats *xskrq_stats;
>>> +	struct mlx5e_rq_stats *rq_stats;
>>> +
>>> +	ASSERT_RTNL();
>>> +	if (mlx5e_is_uplink_rep(priv))
>>> +		return;
>>> +
>>> +	channel_stats = priv->channel_stats[i];
>>> +	xskrq_stats = &channel_stats->xskrq;
>>> +	rq_stats = &channel_stats->rq;
>>> +
>>> +	stats->packets = rq_stats->packets + xskrq_stats->packets;
>>> +	stats->bytes = rq_stats->bytes + xskrq_stats->bytes;
>>> +	stats->alloc_fail = rq_stats->buff_alloc_err +
>>> +			    xskrq_stats->buff_alloc_err;
>>> +}
>>> +
>>> +static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
>>> +				     struct netdev_queue_stats_tx *stats)
>>> +{
>>> +	struct mlx5e_priv *priv = netdev_priv(dev);
>>> +	struct mlx5e_sq_stats *sq_stats;
>>> +
>>> +	ASSERT_RTNL();
>>> +	/* no special case needed for ptp htb etc since txq2sq_stats is kept up
>>> +	 * to date for active sq_stats, otherwise get_base_stats takes care of
>>> +	 * inactive sqs.
>>> +	 */
>>> +	sq_stats = priv->txq2sq_stats[i];
>>> +	stats->packets = sq_stats->packets;
>>> +	stats->bytes = sq_stats->bytes;
>>> +}
>>> +
>>> +static void mlx5e_get_base_stats(struct net_device *dev,
>>> +				 struct netdev_queue_stats_rx *rx,
>>> +				 struct netdev_queue_stats_tx *tx)
>>> +{
>>> +	struct mlx5e_priv *priv = netdev_priv(dev);
>>> +	struct mlx5e_ptp *ptp_channel;
>>> +	int i, tc;
>>> +
>>> +	ASSERT_RTNL();
>>> +	if (!mlx5e_is_uplink_rep(priv)) {
>>> +		rx->packets = 0;
>>> +		rx->bytes = 0;
>>> +		rx->alloc_fail = 0;
>>> +
>>> +		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
>>
>> IIUC, per the current kernel implementation, the lower parts won't be
>> completed in a loop over [0..real_num_rx_queues-1], as that loop is
>> conditional, happening only if the queues are active.
> 
> Sorry, but I'm probably missing something -- you said:
> 
>> as that loop is conditional, happening only if the queues are active.
> 
> I don't think so? Please continue reading for an example with code.
> 
> Let me clarify one thing, please? When you say "the lower parts"
> here you mean [0...priv->channels.params.num_channels], is that
> right?
> 

Right.

> If yes, I don't understand why the code in this v5 is wrong. It looks correct
> to me, if my understanding of "lower parts" is right.
> 
> Here's an example:
> 
> 1. Machine boots with 32 queues by default.
> 2. User runs ethtool -L eth0 combined 4
> 
>  From mlx5/core/en_ethtool.c, mlx5e_ethtool_set_channels:
> 
>    new_params = *cur_params;
>    new_params.num_channels = count;
> 
> So, priv->channels.params.num_channels = 4, [0...4) are the active
> queues.
> 
> The above loop in mlx5e_get_base_stats sums [4...32), which were previously
> active but have since been deactivated by a call to ethtool:
> 
>     for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++)
> 
> The (snipped) code for netdev-genl, net/core/netdev-genl.c
> netdev_nl_stats_by_netdev (which does NOT check IFF_UP) does this:

It does NOT check IFF_UP.. Now things make sense.

> 
>    /* ... */
>    ops->get_base_stats(netdev, &rx_sum, &tx_sum);
> 
>    /* ... */
>    for (i = 0; i < netdev->real_num_rx_queues; i++) {
>      memset(&rx, 0xff, sizeof(rx));
>      if (ops->get_queue_stats_rx)
>              ops->get_queue_stats_rx(netdev, i, &rx);
>      netdev_nl_stats_add(&rx_sum, &rx, sizeof(rx));
>    }
> 
>   /* ... */
>     ... same for netdev->real_num_tx_queues
> 
> The above code gets the base stats (which in my example is [4..32)) and then
> gets the stats for the active RX (and if you continue reading, TX) based on
> real_num_rx_queues and real_num_tx_queues (which would be [0..4)).
> 
> This is why in the commit message, my example:
> 
> $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
>              --dump qstats-get --json '{"ifindex": 7}'
> 
> The numbers match /proc/net/dev even when the device is down because all queues
> active and deactivated are summed properly.
> 
> Do you agree with me so far?
> 

Yep.

> The other case is the per-queue case, which is expressed like this (note the
> different "scope"):
> 
> ./cli.py --spec netlink/specs/netdev.yaml \
>            --dump qstats-get --json '{"scope": "queue"}'
> 
> In this case the user is querying stats on a per queue basis, not overall
> across the device.
> 
> In this case:
>    1. If the device is marked as !IFF_UP (down), an empty set is returned.

Ok, so here is the main difference in comparison to the previous case.
The kernel does the check and doesn't propagate the query to the device 
driver.

I think the kernel can trust the device driver, but ok, that's a 
different discussion.

Thanks for the detailed walkthrough.

>    2. Otherwise, as seen in netdev_nl_stats_by_queue (from net/core/netdev-genl.c):
> 
>      while (ops->get_queue_stats_rx && i < netdev->real_num_rx_queues) {
>        err = netdev_nl_stats_queue(netdev, rsp, NETDEV_QUEUE_TYPE_RX, i, info);
>        /* ... */
>      
>      /* the same for real_num_tx_queues */	
> 
> And so the individual stats for the active queues are returned (as shown in the
> commit message example).
> 
> If you disagree, can you please provide a detailed example so that I can
> understand where I am going wrong?
> 
>> I would like the kernel to drop that condition, and stop forcing the device
>> driver to conditionally include this part in the base.
> 
> I personally don't think the condition should be dropped, but this is a
> question for the implementor, who I believe is Jakub.
> 
> CC: Jakub on Tariq's request/question above.
> 
>> Otherwise, the lower parts need to be added here.
> 
> My understanding is that get_base is only called for the summary stats for the
> entire device, not the per-queue stats, so I don't think the "lower parts"
> (which I take to mean [0...priv->channels.params.num_channels)) need to be added here.
> 

Right.

> The per-queue stats are only called for a specific queue number that is valid
> and will be returned by the other functions, not base.
> 
> Of course, I could be wrong and would appreciate insight from Jakub
> on this, if possible.
> 
>>> +			struct netdev_queue_stats_rx rx_i = {0};
>>> +
>>> +			mlx5e_get_queue_stats_rx(dev, i, &rx_i);
>>> +
>>> +			rx->packets += rx_i.packets;
>>> +			rx->bytes += rx_i.bytes;
>>> +			rx->alloc_fail += rx_i.alloc_fail;
>>> +		}
>>> +
>>> +		/* always report PTP RX stats from base as there is no
>>> +		 * corresponding channel to report them under in
>>> +		 * mlx5e_get_queue_stats_rx.
>>> +		 */
>>> +		if (priv->rx_ptp_opened) {
>>> +			struct mlx5e_rq_stats *rq_stats = &priv->ptp_stats.rq;
>>> +
>>> +			rx->packets += rq_stats->packets;
>>> +			rx->bytes += rq_stats->bytes;
>>> +		}
>>> +	}
>>> +
>>> +	tx->packets = 0;
>>> +	tx->bytes = 0;
>>> +
>>> +	for (i = 0; i < priv->stats_nch; i++) { > +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
>>> +
>>> +		/* handle two cases:
>>> +		 *
>>> +		 *  1. channels which are active. In this case,
>>> +		 *     report only deactivated TCs on these channels.
>>> +		 *
>>> +		 *  2. channels which were deactivated
>>> +		 *     (i > priv->channels.params.num_channels)
>>> +		 *     must have all of their TCs [0 .. priv->max_opened_tc)
>>> +		 *     examined because deactivated channels will not be in the
>>> +		 *     range of [0..real_num_tx_queues) and will not have their
>>> +		 *     stats reported by mlx5e_get_queue_stats_tx.
>>> +		 */
>>> +		if (i < priv->channels.params.num_channels)
>>> +			tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
>>> +		else
>>> +			tc = 0;
>>> +
>>> +		for (; tc < priv->max_opened_tc; tc++) {
>>> +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[tc];
>>> +
>>> +			tx->packets += sq_stats->packets;
>>> +			tx->bytes += sq_stats->bytes;
>>> +		}
>>
>> Again, what about the lower part in case queues are not active?
> 
> I am not trying to be difficult here; I appreciate your time and energy, but I
> think there is still some misunderstanding here.
> 
> Probably on my side ;)
> 
> But, if the queues are not active then any queue above
> priv->channels.params.num_channels (the non active queues) will have all TCs
> summed.
> 

Thanks for your contribution.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

>>> +	}
>>> +
>>> +	/* if PTP TX was opened at some point and has since either:
>>> +	 *    -  been shutdown and set to NULL, or
>>> +	 *    -  simply disabled (bit unset)
>>> +	 *
>>> +	 * report stats directly from the ptp_stats structures as these queues
>>> +	 * are now unavailable and there is no txq index to retrieve these
>>> +	 * stats via calls to mlx5e_get_queue_stats_tx.
>>> +	 */
>>> +	ptp_channel = priv->channels.ptp;
>>> +	if (priv->tx_ptp_opened && (!ptp_channel || !test_bit(MLX5E_PTP_STATE_TX, ptp_channel->state))) {
>>> +		for (tc = 0; tc < priv->max_opened_tc; tc++) {
>>> +			struct mlx5e_sq_stats *sq_stats = &priv->ptp_stats.sq[tc];
>>> +
>>> +			tx->packets += sq_stats->packets;
>>> +			tx->bytes   += sq_stats->bytes;
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +static const struct netdev_stat_ops mlx5e_stat_ops = {
>>> +	.get_queue_stats_rx  = mlx5e_get_queue_stats_rx,
>>> +	.get_queue_stats_tx  = mlx5e_get_queue_stats_tx,
>>> +	.get_base_stats      = mlx5e_get_base_stats,
>>> +};
>>> +
>>>    static void mlx5e_build_nic_netdev(struct net_device *netdev)
>>>    {
>>>    	struct mlx5e_priv *priv = netdev_priv(netdev);
>>> @@ -5316,6 +5447,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
>>>    	netdev->watchdog_timeo    = 15 * HZ;
>>> +	netdev->stat_ops	  = &mlx5e_stat_ops;
>>>    	netdev->ethtool_ops	  = &mlx5e_ethtool_ops;
>>>    	netdev->vlan_features    |= NETIF_F_SG;

