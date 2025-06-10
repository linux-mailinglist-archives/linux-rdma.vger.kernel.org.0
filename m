Return-Path: <linux-rdma+bounces-11127-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A24DAD32BB
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 11:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA5A18970E4
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B19B28B7E1;
	Tue, 10 Jun 2025 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YLsLA8/M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA7286D6E;
	Tue, 10 Jun 2025 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749549066; cv=fail; b=uI9QDAxi6rvsk75LAz5CBPko1OF1LE2h2Rm6JDVMU4R9h77jyOkbQdX1DjmdsXS7VXNKzG8VWs9D2r3TJr9uow2QpujrTEhQ0aD3/Xw3pGgNHgd+3e6FXmZY3e8wiAbk8E66lIxZ6tIXvnc3nv4cEVgno2utDOj9zIUV9TOALbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749549066; c=relaxed/simple;
	bh=a0zUq5pcKJeZ2MMQfpmRKoGfYAR6kS0oxzDe5NaXX2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CKmQHyC4Ve+hhxPMS2HCX4GH+1o4fSrmCvrYaINodzZbovyZEzB1OEKWSJcnuWd00oQPvo6Y2rcwkGdWPJhwFWDEXpYzMMu6tVHPn6dbEJpXMA8aLRveYABedz6w2PTmeLOiHlHx4Do+CgF8T5A6+0dz6X+K/vS4EQPZxxIlj2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YLsLA8/M; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9CfdTAh3gjPI2kkRGZOSdv8OClNe6H6eztC+X56eLg/OE+YFpbDsAcJAwh9RONZ1wM33wEgaux83KKh14CXAki5Lh5tjhFdL9u43mJ2kI+xuC0sePz2t3NdEzRDTYySWYyunmRBzdJ/3hDyAqNaa46fomBm98/wu7e0cck9n6HTzYLZU8I6XOK5MkPc509f+qFZySxMCTh7g3yYb06pikoOJ5YpJe5RD65SPDJ3hl93dEHcuClQQC5CQTnZwT3Rl6eVXxfH4DdsXGOFDxOwj/PixzZJ7/gwKnRkln8olblEZOW/br96Oxo17mcxdVPYlRTByLcxG+kb3jClHAvmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4b06AP9xzqxNc7hphROiKMTmk017t+u2vy1xkcuhDU=;
 b=d05zA+kClcYlNfvNulGrf8k1PcuRHlxvWRUo2M0imPcD+54uZ1juKbREWVqyWh+RZiF4/FaHMa7Lpk4WuBIfVCfmweCrm9ghKcb3yfhEBAzOabZ/xdhXxJBGXXouF6Bv5KQrjAAnD+EMZRNYt228QWrNkIu/1og2TcTR4cbhT8GvK/cRb4Nal0RsUufYM3tWL+HighiFZTLUJrGSbBakJH/CTxqJXlMeOqtqX0fR8ybUYtcazLG4vDoUseLQgIGCDPYFiOziUkKEhg3uSNlc/bWsPd0Vq1HlDWaXt/YUgnTm2bFmXHE1q5mSqeacfQ+D/K7DdduXKnMY2l1OFlfP0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4b06AP9xzqxNc7hphROiKMTmk017t+u2vy1xkcuhDU=;
 b=YLsLA8/Mv/WOiKvhs10Kucn18LKI9RL8OyBaglO9XxRAggeR1bjGhZMyZJZ3W9X9kgpxs1w2O9RsqRngVw56tFnNNtK6JVwtKp78y17b6kofzKliuERpCuuuo6FDPZDMFSLJ9TNxoWr8Z7Hb48JYGz9WwogOCvEnV6SYzJF5Ss+t4eYpGnnI36fwLilt2vmB3rQkNEm7O6Yxznri8b5Cfsj1LM2SGJJlife/8fYBs848zxwDVcNJtEt/ragT4GDUp/fcIvFrSQmoUaYUUHwnoVIWdCZE123oqE7GrXrQnpmonl12qbPCCbxpqIKZS4DkSwM59TZQXyK0+pbTnQJYmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 09:51:01 +0000
Received: from CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4]) by CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4%3]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 09:51:01 +0000
Message-ID: <fa916ae4-1ed3-4f90-8577-3666ff0fe84a@nvidia.com>
Date: Tue, 10 Jun 2025 12:50:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/mlx5: reduce stack usage in mlx5_ib_ufile_hw_cleanup
To: Arnd Bergmann <arnd@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Christian_G=C3=B6ttsche?=
 <cgzones@googlemail.com>, Serge Hallyn <serge@hallyn.com>,
 Chiara Meiohas <cmeiohas@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250610092846.2642535-1-arnd@kernel.org>
Content-Language: en-US
From: Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <20250610092846.2642535-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To CH3PR12MB8583.namprd12.prod.outlook.com
 (2603:10b6:610:15f::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8583:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1443f3-daac-4f7a-bf70-08dda8044ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkVHaTBxZ0gxWjg3TFdBZllzUXlKVk51Wmpoa04wYjAvdy8zR1pCVlk1UVM1?=
 =?utf-8?B?SWZQbzNOdnpOa2ZOUWl2ZHdWZVh5Y1dTdHJ1aFcrb0syVGkrbU5YWkY5SCtJ?=
 =?utf-8?B?Wk9STTJnaTh5bDh1MGszQnlJTHhZTm1mdFBGUDB4am9haWJHRTF2QWdjSWU0?=
 =?utf-8?B?RDRHbmtHUHBia25XK2dkZEx5eDhFTWsrSWdLamcxb3hFTXBZRzVkaHp5RDU0?=
 =?utf-8?B?MnRKa2VMUEdIR0xOdU9RTmw1SXlHY3oyZElLVmVDcHJOYmpPeFlLWEpINTRk?=
 =?utf-8?B?STJ3M0NGVSsycXZkUUoxclo2T04yMEhtWkoybDhLSW5MNW10TjNsbjQwYWtD?=
 =?utf-8?B?bHh5Y0RWQXNFbUVUck5zbmo5dUVrRE8yZUplejdhUmJpaVliNjEyRmpsSVhz?=
 =?utf-8?B?TmlJK0p1dTl4Q3JibndQWmx1REpuMmNhazRsSS92Rk1SZkVtZHNZa2c1ZmR5?=
 =?utf-8?B?bVl6TXJiSWNXZ0RrVXF4ZmhOTEVERFZxMTNXOFZ2dWtIRWpIZTF6VkZsYm1w?=
 =?utf-8?B?Z0FocGRLL2ErZlVFNWpBMUNiS1c5Vkc1Ry9YckQxdm91czBQNTNsREEwL05j?=
 =?utf-8?B?czhMTHNWMkt4UjFwTlFQdmlsT0hmQVA3YjdHcDA5WUFKajBjNktwT0NtdHht?=
 =?utf-8?B?VEZEOEFuL2RxLzJkbWN4MVFENXNYNzY5QnlJcVR4MHRmTm83MjFBVW16azN3?=
 =?utf-8?B?bS9JRkVkQW9yTStsRGw5NTF5b3pybExjckJ5R1BwcTFKek1ERzlYLzVVcUZR?=
 =?utf-8?B?UU43YTlJeEl0cm1xdkdzWkc5YzE1WHUrK3NXM2QvR1p1K1pXcTBRMUNPWkJ1?=
 =?utf-8?B?MFFQRGViNEhoY1A0RmVkbUw0VmM0bXJ4dUN1UmFUMk12UzFoanhOQ0hKQlc0?=
 =?utf-8?B?eVRTNDI2dEZVb3ZPVlJBVitpMmozb3hjUDB5dnY3Um1rZ1hkLzNwaEhsVCsr?=
 =?utf-8?B?MmQ2b1RoYjIvMW1mZkx5M2FGQ3UvZm5CS3A5SmVqRFpIQkR5Q1NjbjJ5aFNM?=
 =?utf-8?B?WUhZS3Z6cTdjcTMrM3VyR0FkdUxzaUJFc0lhelFHQ1MwYjNab0p2Ykd3dExa?=
 =?utf-8?B?N3l5cTk5ZEE4RklNSFlNVER6TGcxVkVXUmt2NTBEUFJqU3ZwRkE2cTMzT3A4?=
 =?utf-8?B?NGoyT011Tjh2NmNsY0thWktiYnc2VTVWSW8zNkxwc0lKblR2R1FlUW1RR2Zu?=
 =?utf-8?B?MW5jNEZ0cnlKRWNIZWdOeHRpeWVwZlJCdkxTeHhDNHRRZERJa2JnS0RQQnNX?=
 =?utf-8?B?RzM3alpXSWoxZnBCZGFHT3NoR0VRY2gzcDZSWVMxOWxHQjRxeWRzSVJqSzZ2?=
 =?utf-8?B?YWJOdVB2eUUrREc4aVpta3Z2cEtEczJ5WFdkajA2N09kT3hMWGxJcTN2NVpN?=
 =?utf-8?B?MG85RXA2UGhBQjlIdkZHcmJ5VTlXZ2ZrVmhuTFFHcVNoRFJSUGQzNGpicW0v?=
 =?utf-8?B?ZVhTU0RLRC8rNGdRUEZZZjBmUnlDK3RNQVhuYk1mbldOYkVCWThhd3NiY09q?=
 =?utf-8?B?cFUrN1hCcTl3cFpZTW1adEd1WTB2VGxDRm1NVVVONG9CcXNVNmdPaUVVSlNO?=
 =?utf-8?B?ZzJaKzlDbjREbit1TVpLUGZCNy9zKzBPVUZZTmR1TlF4WHpsL2FsSDMxUTc4?=
 =?utf-8?B?MWZwZmlCQlpnSzlsQklqWVl5L1ZSbzBEYkNLb25ISlVob3pUWnd4WnBiZk4x?=
 =?utf-8?B?K3oySCs1OWhDNXZPNDE2eFdjZGM0bmxiNlNhcUhBTGZ4RWNsZm9QYjA1eGk2?=
 =?utf-8?B?QlhqU3BWSTMxUFozeURTZG8xQ0Q2NWJXdVdyMGtBR2FFOFJWbVhaNURIcGtE?=
 =?utf-8?B?YVhnZjhXVmE3aUNENGE0TTRNVjlIWTJWR2lVejdPcytMTUVNT1VDazNoR25I?=
 =?utf-8?B?QW81Zk9DVGQ3bVpqd1ZuZVRYM2JoWFNvc1p3ckI3d0tqRXZyWHE2SGptOGlJ?=
 =?utf-8?Q?btiAHcALqqs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a25Xd0pOV1BETGRlTE91YXcybWlWMmZPK2lUY0QyNnZ2cEI2UTNCU1dDR1dQ?=
 =?utf-8?B?WndDYzJvZkpJWW1oWTNLTWVwejZ6U1l6WGFtNlZ2RUdLUE96WWVKSVdvNmg2?=
 =?utf-8?B?ZHNKN3hjNkhtdDAvZE82Z0lvNUhZeWJRdzYwNkRzajhJb20vek1Cd2ovc1lI?=
 =?utf-8?B?UE9MTzlnYnQvblFyTHdGT1VqNUkvRXh4bVhZbkg5cnlwL25GWWRodWFRQWhS?=
 =?utf-8?B?aVdzK2VMKzFjcHJvZmVHS3VXOHJ3NGZnbUFYQ0VRbjA3NExaeHZnY21QRWNP?=
 =?utf-8?B?YklOcWNycFg3aVlnN1pBNnY2ZHlITzFyajN5NVdOK042VFdtT1FyempsaGRk?=
 =?utf-8?B?L2VTMm1sbVNqQVJIeFdNT3Byc0VFTDQxK0Z4Q1VyUFJpT01STmFyOUdBTEl5?=
 =?utf-8?B?T1VwVDZlaitvSGJqM0ovOTlLLytUNHNQYTBncFdiK09nMmw5Y0xPMTJRaHlw?=
 =?utf-8?B?eDVEZFF1cEZHVVpXRG4xY3BsYnRwY3lIZ21Qa0RydXE0VnpTRGR2WFJIdE1t?=
 =?utf-8?B?R2FjQVRzNWtBdElqT3hRZWhwb1lpMjMxTE1yQU8wSHgvMWZROXFhSU1Ndmxj?=
 =?utf-8?B?N0RtK0RRWVpKK2w4SlhaOHl3VUhqZGoyaWYwMjc5NDRnY1QxczBMR0dOWUxX?=
 =?utf-8?B?MVkrMUlNcmNncUJXclFsQ21DWXEra05QZjc1Mmd5Si9KSTdEbnFMS2lkUW1R?=
 =?utf-8?B?Q2pERXJIeFBnaEo1dDRKZ1EvenpOTWllK3NTVGMyeExBTFZKbG1YbkFZQXNZ?=
 =?utf-8?B?d09UTXhpUkNMcllZOVFTOSszZCtRUHVYU0NSZU5DR1pCK0NscVFwNGZQRUVL?=
 =?utf-8?B?NCtUU20zSHJ5NW1maFRVd3h2Q0pHYWRLR21ETWtDVU1qVjJZdHY1Y21MaFZj?=
 =?utf-8?B?WUtwTktHTEJKa1hCdWVJdVFaYXg4eDFyQUF3UnpINlJXTjRlQmtTWUJOZUgz?=
 =?utf-8?B?U1RGL0QrS2ZnN0pld1liOTQwOW9nWStXbkNrcmYyeHlQMm4wRENEWkd3cjlo?=
 =?utf-8?B?YVEzV2RFSkR1U2FrK29Ma2V3cU9qSWh6MXFlbVRYd2R6Q2hGWndMdDYzVFB6?=
 =?utf-8?B?OTg2c3RIOWRqMDN1TDI2UFBnbXdIS3REZDdCZlNmZzdKS1RiaGU0ZFZ0OWk0?=
 =?utf-8?B?TVFYd1I2a3hkSUs2M0ZZMmQranVPVTlFTlkyRDdaVm90cVFvNUFrM05FQUJX?=
 =?utf-8?B?L0VjUmZTb1hTZVNoYkJNeEJhNUNzZGsxbCtZZi9JTnZGb2ExMGV5aWdtbXll?=
 =?utf-8?B?dWJyNVB1Ynh4VjJlUHNEUEQ2RzRSTy84L245WU5saXRZZ25HUHVQdllJV2JU?=
 =?utf-8?B?bGo0MWN6cWx0cHRBOFlPb3d2SXYwMWM5Sk5GNHQvVTBSNUdpMEdUdllxWmRT?=
 =?utf-8?B?UUxsUnA2amZKcjdyREJuODAwNy9zdVJWbzlnOXhjNGFyVUJKSVB4MUJXRDZ2?=
 =?utf-8?B?TzhZcXREbEx2UjlpazBTYjVVeHZEc3F5aTZXcHdBS0d3VEk4dmlXNmZyYmc0?=
 =?utf-8?B?RS9KTDN0Q0dnNWl5dkdNeTlhYi8wWnFEcUNkTVdTZ3NiR0FNOVRBYXE2ZXY1?=
 =?utf-8?B?VCs3TjVwZnNyKzloLzNEeGVrdlFNR2RZaG4zdDE3c2RqMlUrMFlyZ1FMTVl4?=
 =?utf-8?B?cllodGZDa0ZSRWlTVmlHUHA4SUVhb1hoSldHbGJaTk81QWExZjZoZUYrNzFy?=
 =?utf-8?B?Y1ZRdGdTSzhCVzJUQThwd0x6OU1RckQ4YmUrZnIzb0gzV0dwaVVDNXZsQndY?=
 =?utf-8?B?Z05US2MrNU5ZNGYzNmh1Q0V1V2Fmd3lhUEVyQm9jenVvZ0poRnJBZGN4cDNS?=
 =?utf-8?B?ZnJCbmtNcXJIbk1VV2hkNFZQN3M2aW00ek4vSXJsRXVPT0Q3WXl2eFRPRFZZ?=
 =?utf-8?B?clBSSlA1SmlBK204S0NOa0lJNVJLMTFld2lweGVWSFY0ZEJjcnZ5bDh6NGo3?=
 =?utf-8?B?UStUbGRJc2xYSmRBaFRIdUFETHZGVndUYlVQQ1RVSkMzTE4zSGdHaDJUb0tm?=
 =?utf-8?B?NzE5MjJQLzJub3phMTlLeWltTkZTdklFS21XU3BuK1JHUUhLS2ZrMGlPQjI5?=
 =?utf-8?B?SnQxZXRHRVFnRFRIRmNSa3RFMVVFRzlxTzgyMlFveG1FTkk1WkRwMHFEVXA4?=
 =?utf-8?Q?hB2pPX4qNIcpOLk5HAY6kivH5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1443f3-daac-4f7a-bf70-08dda8044ef2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 09:51:01.7315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HONlaPezde9mivTbxqFMZeLAVkBMLHw2DQCkeb6icgKDYXGwqn3aCr6H8JQH/GoPpEpqjrPcoAhNcUOI24ghPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908


On 6/10/2025 12:28 PM, Arnd Bergmann wrote:
> External email: Use caution opening links or attachments
>
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This function has an array of eight mlx5_async_cmd structures, which
> often fits on the stack, but depending on the configuration can
> end up blowing the stack frame warning limit:
>
> drivers/infiniband/hw/mlx5/devx.c:2670:6: error: stack frame size (1392) exceeds limit (1280) in 'mlx5_ib_ufile_hw_cleanup' [-Werror,-Wframe-larger-than]
>
> Change this to a dynamic allocation instead. While a kmalloc()
> can theoretically fail, a GFP_KERNEL allocation under a page will
> block until memory has been freed up, so in the worst case, this
> only adds extra time in an already constrained environment.
>
> Fixes: 7c891a4dbcc1 ("RDMA/mlx5: Add implementation for ufile_hw_cleanup device operation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/infiniband/hw/mlx5/devx.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
> index 2479da8620ca..c3c0ea219ab7 100644
> --- a/drivers/infiniband/hw/mlx5/devx.c
> +++ b/drivers/infiniband/hw/mlx5/devx.c
> @@ -2669,7 +2669,7 @@ static void devx_wait_async_destroy(struct mlx5_async_cmd *cmd)
>
>   void mlx5_ib_ufile_hw_cleanup(struct ib_uverbs_file *ufile)
>   {
> -       struct mlx5_async_cmd async_cmd[MAX_ASYNC_CMDS];
> +       struct mlx5_async_cmd *async_cmd;
Please preserve reverse Christmas tree deceleration.
>          struct ib_ucontext *ucontext = ufile->ucontext;
>          struct ib_device *device = ucontext->device;
>          struct mlx5_ib_dev *dev = to_mdev(device);
> @@ -2678,6 +2678,10 @@ void mlx5_ib_ufile_hw_cleanup(struct ib_uverbs_file *ufile)
>          int head = 0;
>          int tail = 0;
>
> +       async_cmd = kcalloc(MAX_ASYNC_CMDS, sizeof(*async_cmd), GFP_KERNEL);
> +       if (WARN_ON(!async_cmd))
> +               return;

But honestly I'm not sure I like this, the whole point of this patch was 
performance optimization for teardown flow, and this function is called 
in a loop not even one time.

So I'm really not sure about how much kcalloc can slow it down here, and 
it failing is whole other issue.


I'm thinking out-loud here, but theoretically we know stack size and 
this struct size at compile time , so can we should be able to add some 
kind of ifdef check "if (stack_frame_size < struct_size)" skip this 
function and maybe print some warning.
(since it is purely optimization function and logically the code will 
continue correctly without it - but if it needs to be executed then let 
it stay like this and needs a big enough stack - which is most of today 
systems anyway) ?

> +
>          list_for_each_entry(uobject, &ufile->uobjects, list) {
>                  WARN_ON(uverbs_try_lock_object(uobject, UVERBS_LOOKUP_WRITE));
>
> @@ -2713,6 +2717,8 @@ void mlx5_ib_ufile_hw_cleanup(struct ib_uverbs_file *ufile)
>                  devx_wait_async_destroy(&async_cmd[head % MAX_ASYNC_CMDS]);
>                  head++;
>          }
> +
> +       kfree(async_cmd);
>   }
>
>   static ssize_t devx_async_cmd_event_read(struct file *filp, char __user *buf,
> --
> 2.39.5
>

