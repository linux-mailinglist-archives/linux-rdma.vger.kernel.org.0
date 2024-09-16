Return-Path: <linux-rdma+bounces-4962-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D746979D19
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 10:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC751F23639
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 08:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B64213EFF3;
	Mon, 16 Sep 2024 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EXi/W24t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205C95647F;
	Mon, 16 Sep 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476278; cv=fail; b=kEw/mpz4RZFVrVawWCwmZE6NbCyuvCpWfDa9TqKRx7HO4gpsSMGAMUYmcOHO5E4bUneWPPT4vGqRgPEUzLWoL7gaIup2b2qhzpE668qKk67WzFlfW3fBV7IbXsSMCt9xUmmcHXyqmGqaiEzMj+GCTSoTUt+HMvwUmvbyJiEMmyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476278; c=relaxed/simple;
	bh=GkrFtxERJbWmyg2sNkV/kWmKLmHYajgGe4nzTXWWmMM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C93xxP/QLsUmfjA+wzWcZ2Lhba8X2Dyte2J8XirobQOtc6PFHmnHTxtlrzdgxDa1h2r4lulXYwMsydKqMql6Lscqx5no424M+1zJTb1sgVNlHjZRytZYD6YBwTD5xpWUaY+Xiqxp7/zyQs0wQySnfe+k4+RB5NNz6hKd6Q92ZGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EXi/W24t; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuNd8cj1zCJA45N2dGYXeCO2IckhGaKjdSejwZQxIARK4gWXrYVhCtk5Lh3IPrJuaTKMNh7EqCI9iD/OH+7XU49LOs/QbTU4c0r1GfuLw6cKKs8XxjwqdSi187Al381XgL5Ea3ys1eCMzck1yy3m+yxRdR+kxRoA+cgJ2dbcafW+VcWTQgsACsDRYxtJzmcUn872+E/TrvyjGb88uDFdFJLMG41bVKaGZHWJ34dssUqtYKSX9Dzw6yUQKo89JHBsXS0qS8bEPM8SFwMuZYdgM57Wx91H36ZJ7w/SoLb4Qs1iy/w1qDRJ5ZMPSfJD+ldv8ihf5rVwbzvOMx4s7wM35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJnXCA8tJvWJvMEf2BW46wvwD/M2wkxtGzPvE+DOXTo=;
 b=qzfB2VHhw+gkWRMjwtwNuGJNq6VN4C4PnIpdNLQLvmOPI9i/bWX2Zjn/3HAYuBGJCRaHFUGawLewN4OCP+dvWQCbO2AXh7omdHtmBDfotqoUw7l9vi/DhTYhGHmya4Z1dg5cUm946sndZm41h3AUltxlBkg7ojZ03PXkwj0r39TPGKJpcd/YR4h+G8ZAF5zbKWZFTGjdcY5oodksDBHPpsgyZNqjgVIU/VCWCqiu0+zAIWKuvR/g0HNumqJrtlWqPvO4iOx7+c9/zmYIDkhj+oUaheZV8eMNSY8Q+FE0SRX2GYQHRRhTOoo9lnFFAdqgbY136kDIq2yVFNGXV2BFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJnXCA8tJvWJvMEf2BW46wvwD/M2wkxtGzPvE+DOXTo=;
 b=EXi/W24t5hPWQsHYlaS7Z346ZCZWRV48w06EnhY26BdbOUxQMWscTQAHZNauTNfbnlqYb0G4JO06x7BM07+3C/wsYRovaiQb9yclZuGmYKusPa5846f5OzDKXyXoWuZhkmeK8rzkSisJYPgs1PG82sNpt88p+K5KKvpp3Z1f9Q17FpKxVNNG7A8e4p1vxkfOy8sPjxlyX/RhPyuAYho5ryBTb9nXHlpaYuKv0R6Rt8O29Lbu7mrWG9EDBd6SIfp9L9dD3ROJeUeOxjDYAedodg6fHthP+53bAJVqJlu5Glvs6Q/9OGTfRh8W+qONrIYNwipGtobvMgeeQOipiWkgag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 08:44:33 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 08:44:33 +0000
Message-ID: <55ffb761-170b-4a1c-8565-7e6f531d423c@nvidia.com>
Date: Mon, 16 Sep 2024 11:44:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] mlx4/mlx5: {mlx4,mlx5e}_en_get_module_info
 cleanup
To: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>,
 Ido Schimmel <idosch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-rdma@vger.kernel.org
References: <14a24f93-f8d6-4bc7-8b87-86489bcedb28@ans.pl>
 <12092059-4212-44c5-9b13-dc7698933f76@nvidia.com>
 <8a0c724e-d2fb-4ae6-bf5d-74bbd0a7581b@ans.pl>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <8a0c724e-d2fb-4ae6-bf5d-74bbd0a7581b@ans.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::8) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba11078-bfe4-4e1e-a7ab-08dcd62bc977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkszQytLUjRsWmNXSzVvd3VQcitMdGFrODQyQW91TGNLN216RTZmQVRyWEdI?=
 =?utf-8?B?TG85OUhqaU1rV3g3R1hsNTB4NUJDVlZySkt2UEo4M1pTaFY3TkgzdGNnZVRu?=
 =?utf-8?B?ZlE0d2p2Wk8xdXBzMFBOYWhzdFVmQjBKSE9jVVUvd2o3bllVZjJNeXNxYnZO?=
 =?utf-8?B?bVJrZ3Rsa05rRDl0bkwwcVVMckVYamsvU1QzMDNrTnFOS1VnWFJja0NGSjZQ?=
 =?utf-8?B?dUZTUWNnRitESkI3MG5BakVZWGZadUovUCtGQ2Fyak44czlCeUlqUFRub3Ur?=
 =?utf-8?B?aDk4WWdqeVYzWDdtWXNiMEtGN1BPTlQ2TVdBN2ZIRGZ4ZVRoY01aOW9VazZP?=
 =?utf-8?B?cUhpTVV3ZWpIeGFudnVhdC9pWHUrczNUWmxjWmdhU0JYYnlBcHdtMStkMUtt?=
 =?utf-8?B?M2NkdU1qK1lPQndzRFI1ZllPNEZWODJiTmNobjdPRitQcnhFK2hZcldNNGg2?=
 =?utf-8?B?NTRwRllFcDJDdko5WFpyb2JlUW96a2FyYlZZU0FCYkp1MjJuZkZEZEFXVW1X?=
 =?utf-8?B?TlByWXlTeVpyVklqQ01sYkV5Wm94T281YjFiU2lWay9QeDAyajQvV203Z1pU?=
 =?utf-8?B?cFc1d1Y1T1JBa3o3dFphbkM0NWQyNzRhbmw1U1I3aXB1elBTSkd0dmdBcldQ?=
 =?utf-8?B?LzMzMUwxZTNSMk5xc0xQcDhrWUJFeHNXRHJEc2RuOHl1ckFiQ3ZBSVc0cUR3?=
 =?utf-8?B?dzhhQ0JySkc0aVQ0M21UWkhXMDBvNmxidWNzS1dMLzZ5NlpQemNlUTM1aXMz?=
 =?utf-8?B?ZXA2dENrUWhyY2cxN0ZOclR4cDFydFhidk9BY1AyTnF3WEJzL1FJUGlyWkEw?=
 =?utf-8?B?Wmc3U2ZacHowdnAyWmQ1Z1E3UEtqcXIybHA4RUdUNzZ3dTJlZmJmNERGS3Zx?=
 =?utf-8?B?L2tPblZ2Nmw5cFU3NnZ2MFNuSkNzWDRrMm9mVkszd3BMYTR0cGNla2JtNysz?=
 =?utf-8?B?UDZaNW9qWUR5UjVoaWpvaEZTR2g0ZkYzRm1idDY3SVdUNjNFWHZoVzhjb3dp?=
 =?utf-8?B?cjNnWjhGaXh6UHprWTFPRVBLVDVNTDZlQW5OKysvaVJVY0tpcmZGUlFiTG5s?=
 =?utf-8?B?N3QyM0xmbVE0aTRWdEtnN0V2Wk4zdGdlQXNZam9aRDBBUGFWSTBrQVpwb1RW?=
 =?utf-8?B?ZlZaeHcwZ1kwV1I2NjJmOE5SWG03Rlo1VXJOWmVoU3RGZS8wY1NSQkg4cWFU?=
 =?utf-8?B?dDh3YUFaRm9KWWhoRVR2YXEzYTNoWG9CWFZkYWNkNUsrcFdCU0FMYnRHdzJI?=
 =?utf-8?B?d3hmbU1TZ1IwY1h5Smw2bmt0VTFxaHZNSTgxRUtrZlZJNW9CcGgxT3pNaEZz?=
 =?utf-8?B?RkxHb1NwUEVkdDdRdVhCeHdJWVFkR0pRTkVqOElIYUNkU09TeHlVNU9oWllw?=
 =?utf-8?B?b2FGNWJXT3c0WHJibVlXSWw0cTlDMHBHSnd1NHZBUmZkdk1BdHY5ZVgySWVL?=
 =?utf-8?B?Yyt0a3hNOVpwbnE4TnNwMWo3eXRiSW9oV2ZBRmJVdTYyNzdoUFNSZVhGYWF6?=
 =?utf-8?B?cTF6QnkvRVpLdjM3ajNtRm5iQVdTaitBcEpJYUhJOW1YYVRFQy9la2Vjakdv?=
 =?utf-8?B?RVlDbUh4cmVPTURHOUoxQytzUjFRZnVQZ1h2WTk5UHRNMVJ5a3NTMnN0ZTJw?=
 =?utf-8?B?b0RIT3NUQzc1L2EzRmY5Nnh4NXl3K0ZoeE5IT1puL3Fua0VyT3o4MmFvUzE5?=
 =?utf-8?B?RVl2TmtzNis2VWtCei9CQkhLRTRmQi9xd21IN3YyWWliM29KNlZUd2pCT05X?=
 =?utf-8?B?eHQ0WDd6c0U3OU9HZWk1c1JyenM1bDFUWDRObGpwaUxESVNMM0JaWmltZWtN?=
 =?utf-8?B?TWt2TFV6MUQvWXc3RTlEOVJxM3o5R2NQTVJjVVNweUFpekF2c25wZEIvOWVr?=
 =?utf-8?Q?eDW7W6SuTanrH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0xHRk1IN0tmWWZGK3VuSDd5U3Y0bUFCWVUvYUZUdk80RVhWRnE3V08vd2Uv?=
 =?utf-8?B?cUcwSmYzM1lITjFqN2szL3FSZk1ucGlXMnIyenJzbjN0czJRN1NpWjRiUmlD?=
 =?utf-8?B?YXppSmFYUW14Y1NRM1dkSWcxZktNSzlIMHR5WXhveVFQZnQrQi9CMDVNWGFm?=
 =?utf-8?B?Y3g5Q3VSdXpzNVZsVUJwMngxM1VicG9vbTdUOWM2T0tRc1BRSGl0OHRKSXU2?=
 =?utf-8?B?cEFLaGwrUExnYWZmeUY1SWc3eTA2ZmpEZnUzZHhmaktDREcreVdPWE5xTDZs?=
 =?utf-8?B?T2dnbFQ1NEFSSXlCQjNHK0Y2N0JxM2lHdmZYZm5JbDFLSG9EUFRzdk94RXNQ?=
 =?utf-8?B?cEVYeE1pdmxmK0hWNitqR2tvd29OTXBaMGRsN1ZVOFh0ZVlJamRQK25PZ2lS?=
 =?utf-8?B?d3laMWpPUDhueDV0L1kwYklEbG5CRkFOWmNJTUhaVC9yT0VKZC9kUjQ1dmFz?=
 =?utf-8?B?VVluTDhMTjRJWnZzdEJlSkM4eTF5ZU8yQlA0Tll1M3JqZlJaNDlyRTBLOWJW?=
 =?utf-8?B?NUJGcHZkdGVpVGZhU2VyanNReDNSTEZLckJzdGR5dlpaeDRYL0pXbExuMWRS?=
 =?utf-8?B?dEl4Qm9uMXdWeHU5aVBBbzh1UkxGQm0wVGFEZ0h3TExzOU5iQWp0U0t2aktX?=
 =?utf-8?B?N3hOREQ2T3VOdDRzcUV6ZzNMelc2Z0tZaVh2YWZPenFmckI2bktNWFpkOUdO?=
 =?utf-8?B?OEdja2VZUUFpQ1RWak5QYWo5S1BlRjNSWDZITkNHTWl0UWZ5aVBhMFhKc1U5?=
 =?utf-8?B?dWN5ZHV1ZFZwYk0vV3hUaHU4UmE0U2REZWNkc0h4cCtML3VPSk02Z2RMS2FV?=
 =?utf-8?B?bzdqZnJzTHVNM1EwNW1yZE56WlhwamFXeWFvTHNEZVN6OVZEWVlIR0hDdWxL?=
 =?utf-8?B?OTNjQmtyV0xnSmZoQldJbVNWYUhiY2h2aEZRc1NUQldyWHNPWHpjMXJNNDFz?=
 =?utf-8?B?dVRGeEoyVkEyd2VaTXBYdzRWY3dJRzhLOElkaXNzTWVBWU5SZ0s4MDRnY3NC?=
 =?utf-8?B?SEhTYlMxdVZWa2orZVpXSjBuRXVQOU0vU0xuU05ac0xwUnZUNmtWcnA5dTBt?=
 =?utf-8?B?djZYT01kNTZJMFhNR3pSNDZzTjJRVjY4ZmJkVFRFb3FweEw4UGwyZmZFNGlJ?=
 =?utf-8?B?Y0lHcFUyNTFFZkl4dmZIc1VtcERFMExXd0VKK0Mya2ZjMEhOekV0cm5jT0hY?=
 =?utf-8?B?cHF6SmZUWHBScXE2RzJpZ3VldXRxWThxcFFoZzBxdUdLZXpBQktZUTUzbkNY?=
 =?utf-8?B?OWNtS2ZjVE5KWE10WHlSTWJMVXpySnRmR3BLUDEvV3piZ1ZzOS9CYnk3UTll?=
 =?utf-8?B?K2JIOXcvSUloek1QQWxOSDVLMkZldVI2RXBEdk5ZNktuRWo4cVpxYlp2Y1RW?=
 =?utf-8?B?ZC8zQnBSdFJWbTJIeUxQcis1V1dwL1E3V0xpM3M3eTFsemREV3daby9jOUpD?=
 =?utf-8?B?c2FIZFdMTE80TTNxSUpoVTNQOS9KZHN2bjVVQW1jSjdidC9pU3V3aVlTVHhY?=
 =?utf-8?B?WGlyMXNDaWVKeHdRQ2hudEVyWk9scW45azBua0gxVmhxT0RMQllIRTljQmtL?=
 =?utf-8?B?M1IrMVhKOEhPL1lOU0V6QkNOSWJJVWR6ZnVWZjVhV2o1MS9JSCs2NStsQXV0?=
 =?utf-8?B?TE9yaUVybnBDQUUwd3ZHWkttVytad2w2dUppdG8yYTRrMGk5U3cwTldJRUFG?=
 =?utf-8?B?M2JaQTB1Ry9RUmNyODRmYTRrQ1dpam9aNkRKT1p6SmRXdlppRU5KeXNvYitS?=
 =?utf-8?B?bkZKWXJnWnlweEJhbmM3OTRJUVI4REVOR1BFVG5qazJXMmp0cE52RlByWVBu?=
 =?utf-8?B?NHoycUhHNHArRWUwQTlXL0h0UDB3Sjl5NlBNU2QyVkhEaWxGRGpCSkRlL2tx?=
 =?utf-8?B?S2tjTlptMXNFdTJJZmJVc0lpczBwTTNZeng5VnZlSHlHTkxDNG9MRWtybHVw?=
 =?utf-8?B?KzV4QWcyOFVxbWFOdkJER3ZiNm05dDM0Q0xmTFFJN2psdWh2Z1FVY3NCVW42?=
 =?utf-8?B?M3h1aXZ1a01EazdTWldiRFI5aFRMZDhZV2lSR1RHb3RVdEoxYU9td0YrYWl6?=
 =?utf-8?B?ZjAxWVVpVTFiSnJneU5XRmZvZFRXdmRCdEVXc3l2c2x0N0VPdWkrYWVyT2Va?=
 =?utf-8?Q?12aIO9WUvxEDQlDk7rszLZMV+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba11078-bfe4-4e1e-a7ab-08dcd62bc977
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 08:44:33.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juZjDZguQaSGtC8V3723/aEYOKEQq48SV7SgWZdXThMKVMHIB5TNaAMswMU650q9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

On 16/09/2024 10:30, Krzysztof Olędzki wrote:
> On 16.09.2024 at 00:16, Gal Pressman wrote:
>> Hi Krzysztof,
> 
> Hi Gal,
> 
> Thank you so much for your prompt review!
> 
>> On 12/09/2024 9:38, Krzysztof Olędzki wrote:
>>> Use SFF8024 constants defined in linux/sfp.h instead of private ones.
>>>
>>> Make mlx4_en_get_module_info() and mlx5e_get_module_info() to look
>>> as close as possible to each other.

mlx4 and mlx5 don't necessarily have to be similar to each other.

>>> Simplify the logic for selecting SFF_8436 vs SFF_8636.

This commit message reflects my main issue with this patch, patches
should be concise, this patch tries to achieve (at least) three
different things in one.

>>>
>>> Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
>>> @@ -2029,33 +2030,35 @@ static int mlx4_en_get_module_info(struct net_device *dev,
>>>  
>>>  	/* Read first 2 bytes to get Module & REV ID */
>>>  	ret = mlx4_get_module_info(mdev->dev, priv->port,
>>> -				   0/*offset*/, 2/*size*/, data);
>>> +				   0 /*offset*/, 2 /*size*/, data);
>>
>> Why?
> 
> I tried to be consistent with the other places, some examples:
> fw.c:   err = mlx4_cmd(dev, mailbox->dma, 0x01 /* subn mgmt class */,
> en_tx.c:                                                0, 0 /* Non-NAPI caller */);
> 
> Would you like me to drop this part of the change?

I didn't see the commit message mention anything about changing coding
style.

> 
>>
>>>  	if (ret < 2)
>>>  		return -EIO;
>>>  
>>> -	switch (data[0] /* identifier */) {
>>> -	case MLX4_MODULE_ID_QSFP:
>>> -		modinfo->type = ETH_MODULE_SFF_8436;
>>> +	/* data[0] = identifier byte */
>>> +	switch (data[0]) {
>>> +	case SFF8024_ID_QSFP_8438:
>>> +		modinfo->type       = ETH_MODULE_SFF_8436;
>>>  		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
>>>  		break;
>>> -	case MLX4_MODULE_ID_QSFP_PLUS:
>>> -		if (data[1] >= 0x3) { /* revision id */
>>> -			modinfo->type = ETH_MODULE_SFF_8636;
>>> -			modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
>>> -		} else {
>>> -			modinfo->type = ETH_MODULE_SFF_8436;
>>> +	case SFF8024_ID_QSFP_8436_8636:
>>> +		/* data[1] = revision id */
>>> +		if (data[1] < 0x3) {
>>> +			modinfo->type       = ETH_MODULE_SFF_8436;
>>>  			modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
>>> +			break;
>>>  		}
>>> -		break;
>>> -	case MLX4_MODULE_ID_QSFP28:
>>> -		modinfo->type = ETH_MODULE_SFF_8636;
>>> +		fallthrough;
>>> +	case SFF8024_ID_QSFP28_8636:
>>> +		modinfo->type       = ETH_MODULE_SFF_8636;
>>>  		modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
>>>  		break;
>>> -	case MLX4_MODULE_ID_SFP:
>>> -		modinfo->type = ETH_MODULE_SFF_8472;
>>> +	case SFF8024_ID_SFP:
>>> +		modinfo->type       = ETH_MODULE_SFF_8472;
>>>  		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
>>>  		break;
>>>  	default:
>>> +		netdev_err(dev, "%s: cable type not recognized: 0x%x\n",
>>> +			   __func__, data[0]);
>>
>> 0x%x -> %#x.
> 
> Ah, sure.

Continuing my previous comment, I didn't see the commit message mention
anything about adding new prints.

