Return-Path: <linux-rdma+bounces-10939-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4A5ACCE92
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jun 2025 23:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFA53A59B2
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jun 2025 21:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE0D221F11;
	Tue,  3 Jun 2025 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PTSxx49I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58C221F09;
	Tue,  3 Jun 2025 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748984476; cv=fail; b=GCJ5B/MZLasdWG7JeybAluLHr+Aimo/9/2YzPpLH8/WghlZqfbmfQ1FApphkwvAU3onX04iqUfa+yP8ux63HBYvBQiX6/dE3sVFw6XZ0RoWAXOGGA/ol9oj65xxGx/zmNFwXpiCI2zgUuUcWkeLZivxRpTfMAxfLGUS9D3Uizdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748984476; c=relaxed/simple;
	bh=tWp83JejVxBw/vMTNPWIcSe/lgtT/89yo5cyI/ctx+I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pHVGfiWxZT4wHobuveoqnC3LrK3F7SaZFspGj9+M44d2ktIKNeKDwOxtmKfRPQGh6W/951iaDIDLmAX+PxYZvM+lBBLIp/mOFasGq99dRR1TvzS3zTjZUIgJJTm/NphOm+g4S0W43zJAMew4D47aBwV4VA95fI+UDwRfpLf9iS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PTSxx49I; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkHcVHy1XxZEeM6oJKhcKMmt5ZYqAkkwj9Prgr+t6umwU9v4d8fio/2WToYI9SVRS4yJsN7cFqrpPKVYb8YCydKSHxXRGDRXlH4NzWfl+t05cRjLj93Um6qJN1B14NM0pshCGMuKNSj9W2zr3VyXTYKQuyT+Vdr1bI03wf+wKehDQMq+nJZK68VLxB1LN2m8iusRy++rxSuZICkvbQAktSuDCs4AzQPTBMv1+erLTyes2KUGtbeNtow8GP+MljjrdUWqCaw7WSv5hlP7VoTBQqQXJdf0InqIMpuclanuymvBxexCCfx7l6a33GYLzU5Ij1z66+WaQPUb9vb6NizZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue60DgP6iM59+zr+NpP4sT90hkUfRF092WT2pJ6fX6A=;
 b=b5VZytzGmrDluZ91ikr2BEmcWL9vbtwHPMvZCbzRMnnukMfABFS0c2UktnXoXTkkxQFp4JNd3QJp67ftn4ml4ZVSaIoU55oYYroUJHnXb5juOmVG1ISoqlUiWlLVXdNbuJaNVGIUsxZNef0DDDmXVhQ6vTvKexKge8p4JGtl0oyPVrF6UZPFC9lY3c/13bQbUq+GiD46xUwKycF9O+RsS+CcKOzSfUKxk4nRMaDSnHE4Xib2DhtbPeugi/hrkiFdEbJNXLQsViOnaypOIsl+qXF1tgQUJczENcoY4j/9elfIjlBg6RCEK3VFL6jCo0WHmx8xa5rvOnPn9hvoQcm9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue60DgP6iM59+zr+NpP4sT90hkUfRF092WT2pJ6fX6A=;
 b=PTSxx49ILFa6uXFsEajtJPMQANRHstvoT8b09Is51i3WjxXtE5lxfPgaaQsqUMp5+UGr0ynNAfIkV5lVlesXt57emBdFnLSXCl+we+8oNDd6hbn5kZIKrCoTuSgSHhjiDh19y8CpwWd9LwpRZ+diDYY5hKAPiC1Rep6ZLRB3pKf5Tmhbf7RI+hjyaTWBALxS6rjOvc7J+KkfbTTKGuIHkjCLqrIOKzI0H+SSZcOXP3GYYsq+gcTMR7MVANIZvxnDZGcL2zjnVXgZ97qM6fg/VcE3ZW3xUGuxcNVqvTkdqK5f9Z6tb8q5jugSCrC0tXBQBEgQA+rFVQ7+HRdk6+wlbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 3 Jun
 2025 21:01:11 +0000
Received: from SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b]) by SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b%2]) with mapi id 15.20.8769.019; Tue, 3 Jun 2025
 21:01:11 +0000
Message-ID: <2c0f4a69-dd90-4822-9981-faa90f7a58a6@nvidia.com>
Date: Wed, 4 Jun 2025 00:01:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net/mlx5e: Log error messages when extack is
 not present
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>
References: <1748173652-1377161-1-git-send-email-tariqt@nvidia.com>
 <1748173652-1377161-3-git-send-email-tariqt@nvidia.com>
 <20250527174955.594f3617@kernel.org>
Content-Language: en-US
From: Yael Chemla <ychemla@nvidia.com>
In-Reply-To: <20250527174955.594f3617@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To SN6PR12MB2847.namprd12.prod.outlook.com
 (2603:10b6:805:76::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2847:EE_|SA3PR12MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: d4322cd4-c247-4c62-cb6c-08dda2e1c4d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHZNMTlFQU0zT2gyMm9ibGM5UkFkcGJ1VncybnJZUXMzOERMbkxaR1RhZFA5?=
 =?utf-8?B?N1lieWdXTXhNU3NQdXNPdWErS3pEdEFPbUw4eFZJZ1cvbEg4ZkNHOGJYd1JP?=
 =?utf-8?B?OEFHc1JwaDQ5TDRDYXpvUG5pSkVnbzltemZROC9iZTZXdktQVXd5VDgxMlY3?=
 =?utf-8?B?MnI4UE1KdlpmeTIxaHJXcjh6REcxVlVSZHpHOFFNRms4R24xd0ZUcUJuRnYx?=
 =?utf-8?B?T2tSSkxLaWRpYjlxR0ZuQk1yUzV1eW5LNmNkOUJudXd6elc2dUttdjFhc2dV?=
 =?utf-8?B?WS9PMWZNallPRjdDY2o2WENrSFpwMFcvZVpVc3MyR0o2cVAvc1c3VDZDSTZj?=
 =?utf-8?B?em16dDlOTUxzZitRV1ZJOUJKTEhrSTNDcXQ1dnp2MlNWOXVTd1IxRHZPUVJC?=
 =?utf-8?B?ZlVEd0Z1Y2RmeUhCeVdRZWJvV1F3SHF3MTZNdUxCZUZ2emYvUmE3aG1yblA4?=
 =?utf-8?B?dXFZKzBzUVQvdnM5b1ViNkNrdk8xSGMrcVMvUnlNS3F2OE9ISzh3ZThPR3FC?=
 =?utf-8?B?TW52ZUFialB4NmdITVVqTy9Gc1NtRzh4M2tqSzVEaW9kM1J3RGgvTWhySjFP?=
 =?utf-8?B?QjFHbStGNXhTSnB0dnpUZmZrdWloRjcwWmJhd1VIbjRzTzNlWTJOVFpKemIx?=
 =?utf-8?B?SFYzTlFvUEpRdXhrZFpyZXM3OUNBZEZ0VjE0MThWbUxTenU2TFI4Y1pFWFNB?=
 =?utf-8?B?ZjlXQ2VWMDYyVXFlRVgra010RThJTG1odCs1RWlhbzlDKzQrZ25RRFQ5a1c5?=
 =?utf-8?B?NVhaQThqUW5sUWFQS1loQzN4c1hJTFh5eU54ODk5QU5FMlh3ZnBqZ2JtNGxm?=
 =?utf-8?B?MVRLTVV6Zk9zYUZTak1EOFNkaFJhL2pTOTJwM1V0b1BCUS9zL29mT0RxeS9h?=
 =?utf-8?B?TWwvRjdjQkxKc1lIRSthVmlRZ3lBL2I4MVBybzFqSUVxTEttVmExZTFuaE5u?=
 =?utf-8?B?SnZCODBOMTVuekhYUFJlRkdIbmlrTnJXNkhJZzZxWXpxTFF3NEQrK0M5UFFW?=
 =?utf-8?B?clZrdlloMzR1dk1uSFE0MnJJdGlWU2QxWDhzcnNCNGN0dHdZZjd0UnVPYldw?=
 =?utf-8?B?bStmejQ3YnVVZVpQa291SUh1QjdUZkZHVVVocWNxY2ZNQ0xLM0RiSUpZRkhh?=
 =?utf-8?B?azJCV2ZKTGhqNXNtK3lwMndjbUJvWUtPYTBpdTRQOTZ4NTdiL3o5VFhzQWZl?=
 =?utf-8?B?OWFaUFBnY0FQNFJ0N2NKYklJMmxZMVBBM1IyUDNacm5ZNkhCd0haWEszNWJS?=
 =?utf-8?B?blNWNmRkYnhTM2xUbUU4WlFCRHE3aE9ZZ0ZaU2ZoRURLWCsvOWVrdkxyQklD?=
 =?utf-8?B?V1F2NDZRcEh4Zk9JeVhpRWlXeWh1Z1ZKTTEvUjUrd2ZMTitPQ2dyam96ZklD?=
 =?utf-8?B?bGxydW91c1VQdHlockFmTExRK0ZzcnFXVWE1VHNOaExVbytiL3BReThSS0N5?=
 =?utf-8?B?MTBKMm51TG5yN3NUYm5FZ1k4Z05KZWVEZStScmNQN001cWF1aUVERE9ZOFN5?=
 =?utf-8?B?dTU4YlQzWlFPRXZwbmtkeGtqcE1NREQrd09GUGJzZm04QVV4d0ladG1XWGhS?=
 =?utf-8?B?NkZvUFlOYlRsYk5KZ1QxUi9iQzBkampqWWtvS2k3V3phc05uK2hWU2VLdU5G?=
 =?utf-8?B?N1RZRWd5YitaLy9JMnMyTEJrZjBRNFI0VkxhbW5SUUhxTDlNM0VtWWZESzVj?=
 =?utf-8?B?bW9Uc2diY3VueGRvbUVRRHY3M1NmeDRrT1Y4ZkJnTTlYZ0daU25QTi9zeFRI?=
 =?utf-8?B?czdxVVQvRXBtci81TXdnUDFMMWN6OGV2L0wyUFM1aVhGNzRQaFU2L2QvclZk?=
 =?utf-8?B?RUJUQ3ZGYVhmK0RxYXRLaWNuTnYvVUswUldFRitGTlo2SGYrMTB2bGFxOWtV?=
 =?utf-8?B?N0kzeDByMFhWM3daYkt3WU16MW9rcDdHSXN2K1VKVGczVFhWdGVGWEFPMEhq?=
 =?utf-8?Q?jN93/7wUONQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2847.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MldSZ0s2bVJNZGJ3NTB1MGdvUm1SdGZDK3gzNUM4QjcxWWQ0UW13TVBGNUdL?=
 =?utf-8?B?UWVIVmE4YkhZbXIrSWRiY3pPSVh2M2hUR0prL3A4UmpUZE1sSGxpWVRrNFpG?=
 =?utf-8?B?NCtOZDFtaHFrUzJ5US9Mb3dEck1QV0c1WmNsYk53c3c0dis1SVpUYmtlTmtk?=
 =?utf-8?B?SDJ5Lzc1Vy9nTVI1UERaQVpadnp1aC9jQzdhNmw0OGlLc3Frc0dUVlhwclpa?=
 =?utf-8?B?aC9mSDEwS2R5RTFaSzZoM21ldlZhQ0VJMGQzRmVER00xRzF0dlJldGFtY21M?=
 =?utf-8?B?OWFEWEpKLzNvYU5vWW9DTW45M3JTazkweEtYbDE0cll3dW1VQk4zL3BKZ290?=
 =?utf-8?B?Z1hXUnFJcTVoRG1rcGE0LzlDa3doQWw3c1VrZ0RJTi9mY2dvWHRWSytNS2ZQ?=
 =?utf-8?B?dXdTZUFXSkdWZWIzVnAwVUsyQ29VZGpYWWxTUnRobkxpa3BPbm5YL1NsSjIv?=
 =?utf-8?B?WnB1OTJjTDJGWkF2alVNQmdxTnhUYjk1elJaSm1OR0E0aUxmVDNiN2tLeitM?=
 =?utf-8?B?UUk0Rk1NL09YUnpSSENyQU5LdGljR3NhSnBnYVp2RldrZWdBcjF1amRSOW0w?=
 =?utf-8?B?alpEVDVzVW8vZHhyRTJndzRoRGRQeXNycEI3cXdVbWt6clFta0J3MW9EWnpa?=
 =?utf-8?B?Zjh1WkdqNFcxK1ZaanhpVm5zNTNZUWVUUXdGVFlrTGF4WVVYVEhEWUVabE9m?=
 =?utf-8?B?cWl2ak9lZm91cFpOQ3FWSHVIcUd6ZkxmcWVEZmtUOVUzZC9LcnIyUG0zbmZr?=
 =?utf-8?B?MjFtdWhrY1ZGRGpxbk1ZVnVjNTNLYVlXcFVLQVVteG52VTFMY3p1Vm1rejZs?=
 =?utf-8?B?UXZmcHhJZ3JaN2VlUEhGTVhOVkxpVUw2ejZ3dHV4VmQ0MG9KUUNnRVhIbXA3?=
 =?utf-8?B?citnZXlNS1JrZTRxMXFkenV0V1ZhY0lyR3pYdC8vcFB2Ty85bGxSMm9PcHB4?=
 =?utf-8?B?ZlVRZ0x5dUNVWFl0TmlYSzFTQ3VvcVZOMDhZakRKTmsyOUlvZVZET2puNExW?=
 =?utf-8?B?a2NMdjhYTWdrVmg3RThmYitqcU1SL0JaMjc4cUlTK3J1K3JzR1RTcTJWMXQr?=
 =?utf-8?B?OU1zR0pVMjVQWTBOa3ZaeEJCRGRTREtxeFFnVXFYc2lQVG9HS2QvZFhCcHdj?=
 =?utf-8?B?TTdTaFJDVDJ0enp1VU9aM3hjeVNXa1RoMHZ5Vk4rblZjOFBaOTdRUjRWVCtM?=
 =?utf-8?B?VmZWdGRINW9sYjF4K0w1d1IraWt3bXJZYTZKb0poYTNFN2VySEpVbVNwSEsw?=
 =?utf-8?B?bWozQkRxajliZGtITzBnT1BKLzJiSWNmVTN0TVI3Vk9vV0docGdEa1J1QStv?=
 =?utf-8?B?SWlLWXlObGhrUy9VOE9IbXk0VjBjOG1ZNzRHNEJlZmlJSVJpVE1OOTdZRW96?=
 =?utf-8?B?a0xwd1N6Q1pSQ29wQWNGOEVvSC9vZzU3ekxIZWUxZHY5a2FFd2dub2hvNm4z?=
 =?utf-8?B?Qm8yZStleTFRWUl6L0dQbGR0OVBLZlR2TTlrMVhxTzA2K1hzZjhJNkh0Q3o1?=
 =?utf-8?B?SEVETzcwWVpaSWNRZUdwbW9WcCs0eTI3WnoyTWp0QVc3NVdyb2JkalYxek5R?=
 =?utf-8?B?aVdpYXJHL2RwQ1R6S3RSc3lzMzgvVXJ1TnZQMWh4UjJJYXlLbVYraVhTVjdk?=
 =?utf-8?B?bUgzcGxHWktoUXlQRmY3UzhGeHZYZG0rR2RBQ3gyZWxxeTYzc0tnMmpYa2tI?=
 =?utf-8?B?bW1JbGJIM21CNjc0WGxnc0xYb1Q2VDFqb1Qzd3NZMGg1NjVodHZmbmh3S0E3?=
 =?utf-8?B?cVQrU2lxMWxlWEppV2ZTR3VGVGxsc2NBa0xTZUZBOGRnZmVWVjZqYkZmcEFC?=
 =?utf-8?B?NFlxQUZHMGNDZ0s3ZktXZlFBUnNtVmQ2QVYxTzBTUmNaOUdlWjUxajZ1MTNM?=
 =?utf-8?B?MUJ6eW9WNnJsZnhJdzhYeUpDeHAyUEpLSkdJaGNEdm9rS1FTVEFjUWowMzl1?=
 =?utf-8?B?WXdWazB0L3ZjamdxcmE4c05XYlUrYzRQVm9oOTNMYVNKekJodUp3TGhiYlpv?=
 =?utf-8?B?d2xsOTBQWUl2U1FmU3RraVR4dnd5MjQ2aFNvNVNCUUFvY1Jpdk81WWZUOFo1?=
 =?utf-8?B?elBYSDFFUWlScmFOckhhdldBdzN2MDE5allwbkl5aUR0dXJLWnMweDBhNlVO?=
 =?utf-8?Q?TLrOBO9Ub3GbCj3vRKiaKVmkh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4322cd4-c247-4c62-cb6c-08dda2e1c4d7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2847.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 21:01:11.4432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdP10E1XoeZivnyxDBIgUJYX19cySU0uCnNbCLd0ifOnPtjMmBFT8eye51V9XRVmAl+fOqOtTu2ZC02AMMWlKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000

On 28/05/2025 3:49, Jakub Kicinski wrote:
> On Sun, 25 May 2025 14:47:32 +0300 Tariq Toukan wrote:
>> Encapsulate netlink error message macros to ensure error message remain
>> visible in dmesg when the userspace does not support netlink.
>>
>> This allows drivers to continue providing meaningful error messages even
>> when netlink is available in kernel but not in userspace.
>>
>> Replace direct extack macro calls with new wrapper macros to support
>> this fallback behavior.
> 
> Please break this down API by API and explain for each why user space
> can't use netlink. If we thought this was a good idea we would have
> added the pr_err() to the NL_SET_ERR_MSG_MOD() from the start.


Hi Jakub,

Thanks for the feedback.

To clarify: extack can be NULL when userspace tools (like ethtool, tc,
or devlink) send Netlink messages without the NLM_F_ACK flag. In such
cases, the kernel usually won’t send an NLMSG_ERROR unless the failure
is immediate. For more complex or asynchronous operations (like hardware
offloads), NLM_F_ACK enables meaningful error reporting; otherwise,
userspace might see only a generic errno or nothing at all.

The NL_SET_ERR_MSG_MOD() and NL_SET_ERR_MSG_FMT_MOD() macros are safe in
this context—they internally check for extack and no-op if it’s NULL.

Regarding the APIs modified in this patch:

Ethtool APIs: While Netlink support was introduced around versions
5.6–5.8, many LTS distributions (e.g., Ubuntu 20.04, CentOS 7) still
ship with older userspace ethtool utilities that rely on ioctl for
certain operations. In these ioctl-based paths, the extack pointer
passed down to the driver may legitimately be NULL.

TC APIs: Even though TC is predominantly Netlink-based, extack can still
be NULL in certain internal driver code, legacy handling, or specific
test/debug scenarios.

If a narrower scope is preferred, I can revise the patch to include only
the ethtool-related changes, which were the primary motivation behind
this work.


Thanks again,
Yael Chemla

