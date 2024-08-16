Return-Path: <linux-rdma+bounces-4387-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46298954541
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 11:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911CFB23738
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 09:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5AB13C8F0;
	Fri, 16 Aug 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pKrKA9F3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127578297;
	Fri, 16 Aug 2024 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799615; cv=fail; b=DeOI8j5A/uTycoY/FbSIZ+C3rbXVRYEAc7WLfLzWkG5qzfkjxLzq6YCI/HcUQkaadTHGg8GlQrx6T04jNDostjE3Ejh/+7fYOpKqjL5wxVwtK2W49eV/x68WnjPXECcn2dLADIRFlTnbGVNXYMX48Wkgft/ieBAGLHLwk4+oaSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799615; c=relaxed/simple;
	bh=BjkPF3c6Lt3fnA9D+8XtQZ4PzaMpqbuVprI15f0jtGY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KD75HD9vy0xXKHJxKY8QymH3g8VkFgF1gataw46rm/67bzfYNvYoSv1EueJae5lJCmCAjTkq+yHc0WBkJTBOiZcgIFHplxrX1cKtDTUCjb+MK7uDWCci9YmnC3RutsQS7AAaYdPbmTH6/odGvVICs9XSLmnk88G4XBRbXv1oTEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pKrKA9F3; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sj28oF9YpPdeDZah3h7OrkbndRo7F1sxSgRLp18nrkQ9iIz3mgyLEqJsQzZV+evejVeEgeZK6vS0Htft0+/Qd/udNX+tf/fDNRFMHbBAXlFsbs8ilYojBFOhW2Jkt2avSFPAompfNnojcMCw9hEJL8YBK1WyS1okOtFlM6HeoGLljRR3tLNaVriGEX+6aJbfpCc5j7CzAcnAGWilLfrPwKObPtYibTJAH/y6y3bn5ytd+p0VeaJS96V1TZ2acabwIh4zh0pVUQKJpPBthrNrKbY3L9toJ0mkxI5vZ5CYzuCX+NhhhezjOE0zff1iAfq8JK8LqGoEYgf85bcQQtCIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3ZDMoeTDgHzHp9DG5I3ctC+7144eMR0dcikBcVA/18=;
 b=O4LCNZzduT4s3atG91qamyuJTBtdQ09ItYHNdRvJh2RHXnM2meHBvzguxtzrDi0M1N9mfrG3Pls9nGddfbxi27hCuD8saboGQc/wGirPs5IGxxO10FdExouFo0fTWQf5nCKI9s3yqw3/DhZ4bwSYX6cLlL+VCawSkMXUBIDXIn3/QHaGmUpXojb/R+DXXauOs6Fs3ZvqEzZS2Lr+lQv0qlh6eE39mF8eztQ1CcC+0pqx0VNevG7i93V7MNcYlYcM05Wcx30Y+w1KXtAMZktau/fdS4lY1YpWL03XyN6A9ZkcJ4QuJkvcRe65fjHxDrEXsq420ZmtDMcREtJgxCRq0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3ZDMoeTDgHzHp9DG5I3ctC+7144eMR0dcikBcVA/18=;
 b=pKrKA9F3ARlX5oSRKXedE+4BbhPMtq+PAnqpIfW4NJX4VZefiNvxPKmbBqF3V6dUN8dsBVzGehJW+pllQbdTOMAMpKw2CymehfHzgkYBAiEdXRU4b6wQFuiym9MovyqrhD1Mqfa6l/G4VvGIOd64UzrCVXVLG9OY822rWHYUTAGJAqO+vBE7kbxsJTHN74LmmOsM9xMEGU0oC+OIseYw4gBHHrzTGYjisQ1Xx0XZuryXgB28uxBM+kfTHFAE8z6xkjguiOZkCplG8gTgbDxdkIgceSavv/H8vwgpf4F46o3wNTUWqwvPAfQzSOZLuwdfY4cSTKCJwTFO1PBaFpY+lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 16 Aug
 2024 09:13:30 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%4]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 09:13:29 +0000
Message-ID: <8f8a1b31-d695-4955-9250-215c2097ca04@nvidia.com>
Date: Fri, 16 Aug 2024 11:13:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vhost 0/7] vdpa/mlx5: Parallelize device suspend/resume
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20240802072039.267446-1-dtatulea@nvidia.com>
 <20240802091307-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20240802091307-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: f423b0b3-c852-4dbe-2d95-08dcbdd3b191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnB4MUFxcDV2WE8xTSsrTDYrbnUrZklrcjFuekpaN2h4SUZMM2tISUN1V1Jh?=
 =?utf-8?B?RmM2UmM1TGRRUWFXRTB6OEVDUWIvN0l1V1BLb0tsd3ZpRk9DdnZwZXd5T0hR?=
 =?utf-8?B?RjZLd3VKWHZwS2U1TXp4NzRMQzlkT2RQMzdJd0xPUW1UTzhNOFdvTlNETjVC?=
 =?utf-8?B?M25mSWwwZHRVZFo3UmEvVDJkTWN5OGZKRHNDZEdCRkZLazdDVkQ3OWh2N0Zl?=
 =?utf-8?B?SEN1U0NQMWk3NDNBVnlyNGJ5Mko2cHdsZnFUT3U3RXVCYVJKczdnVmg0czRv?=
 =?utf-8?B?bGZJNGFqajE2d0JRUENDUVc2TVBlQ2QwcGJ5NG1OSEd6bUM0ajM5YnpiVlFu?=
 =?utf-8?B?M1hVc01zK2hGTjE0T29GWHl2Z1diY2VMcGVITWJyQkYrOS90WnRXZVg0M2VK?=
 =?utf-8?B?SXpqa0k1TXpxQWlxeXBuZW4yeVNNTnNBY0FMbUR4ekNpallQSUJPUFNDWXBF?=
 =?utf-8?B?VUp0ZkNML3ZzejRYY3JpM2NnRi8zMmM2K2tjTWxWMGcyQU0vMEtqcFpmRFE0?=
 =?utf-8?B?dEpKemp6SVZZZXgxYnVhRmx1dEJuenh6UDk1bG5MNzhTTXg2eFkxR1JKcDdG?=
 =?utf-8?B?T1YzNk05azR5SERIbVBsRXJadUsxSUl1SExnNXhIVlFCZlJBNW5wb3piNVIz?=
 =?utf-8?B?bDIwTE8zdGsyYzFwOTVTWEI5RnQxYVlsM2FHYi9udW5nZU1abXkvZmpvbURW?=
 =?utf-8?B?T0Y5SlQvdlR0NDlqUytDajdFcFNuNXFTNTlNRTRVNDR2NDJyenBoZTl1eWRL?=
 =?utf-8?B?M3BXcWFXNmlUYzJGZFlETEVCZjM0Y0pJc25mVml2aml5Zmt6TU40dEJvbG1L?=
 =?utf-8?B?dDhOWEtZR2M5NWJaMXZxZWFZR293b3QrL1hxK2NrT3Z4K0dHbERHMmludWJF?=
 =?utf-8?B?ZmJpK0t1LytrZGlUZ0piVjJlUlUxUi9UdmRiNkhGR3pXSjZWcFovcUxnRnhv?=
 =?utf-8?B?dGVKdWNkK3c2WDJQdlcycnVTNStlMDFiU0FvNUNGbkp3cE9ZUHA2KzFna09y?=
 =?utf-8?B?cmF5Zyt2b2QxZkZZQlMrb2lXWURJSXpqMDlkQnljeXhQeG9FdzNRQVYycXpH?=
 =?utf-8?B?REphNWdmSEVqWmJzN1VMeFJ3MnpObml2KzFScDRFaFRDTlhlWmFZREFhajI5?=
 =?utf-8?B?dWN0d1JUeHd0c2E2bU9yOXl1TGpXeFFnTW9ld1loVms1aEVmUnZZT2JBc0M3?=
 =?utf-8?B?Mzl6MnFDWXIwRmJlc2dTSzJqWW5pWExOTi93MzNVL1NXSVVDOFlLeFJIdVV0?=
 =?utf-8?B?T0ZBR2xvc0RzeURvV1FDSHNqN0lNc2E4L1d3SjlScmxHSmZNZWU1VDg3VXRG?=
 =?utf-8?B?Zk9FVlk0Ty82MkcyRVo1T1hCK0JxUThwdVpEYUovRkdZWDA4RnVNaFpGNmNJ?=
 =?utf-8?B?VnNvL0M5YzFvSlNTZkkwaWp1a2I5TllFRzBzNlV4RlJNTWt4N3UrZUpOdlNL?=
 =?utf-8?B?ZWIyWHVvWitjbHd3emRneTZQczlrM2pGLzd4elNhdjVwdFVCUHNESFRhMnRr?=
 =?utf-8?B?MnBxQVFza0V3bGxsN0JTWXRNdzNkc2tNZEdlYzk4aDREdFJxR0ttTmtNcHJC?=
 =?utf-8?B?SCtFMFluYVNCSlFkUnJPbkFvbHRiZjVVVE1CVEEzQjIxdmExNFZJdWc4OVVz?=
 =?utf-8?B?djhIQVF5QU8wc2h0bzBNZ0h6dEx6UEYwbUx1eEM4eHRwTzhyeFpERDdwMzJI?=
 =?utf-8?B?TWR2YzdpWGF1cHNIcnltQVo5cjhFamtSaldxOGxaQk5RRjNwb3VqMkxJaE1U?=
 =?utf-8?B?M05SVnJpQnI3WkRMWXRLa2Rrem5sRzVSaEs5aXozK0dPT3lJZlZ3MkU3V0Vt?=
 =?utf-8?B?Si80aUxmcHhBU2VyVHN4UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWk5WTdWSXFqZDJuZWtMVWpyVTlDODIwZmoxNlh3RmY3NWIvbm90bEdrSkZh?=
 =?utf-8?B?MzNHTFBKSXdNWEFJRG45b3I3WlptVnVrMVdxRDhiWVNLV2xDMytyNmwra2Ji?=
 =?utf-8?B?dnZyZkJKdWRiZmYxTHBHU09aUU9FZC84QWpmTmJGbGxZdTdOK0FNZkRNRjlk?=
 =?utf-8?B?a0sxM3I3V0FXY2EzVkl6NGJKVTNETEt4WlVQejVjbXdhWnNCTmNqdVRiYWp5?=
 =?utf-8?B?azJxS2pMNEN1SDZ0YWR1Ui93Q3hZb1JxUFhFZkRzV09TWXArVExNUGlRYVpj?=
 =?utf-8?B?clZvQU13VjVZQlF4R2NrSjhPSG1hQmRlMWRRQm14dDB1a0NTNmUxMTdjZFkw?=
 =?utf-8?B?N2FiSEhzOVhaR3BqYnQ3L2QyK3R1QmNpQUdtelFMdFhxWVN3aDZrVVBWeWcr?=
 =?utf-8?B?LzJ5U0JuTFNNbEU2alBGWXk4alVVbnFYTWFTMUlQay8wNmxDOU83bFJCcVhr?=
 =?utf-8?B?UVBKVHFKUXVmMmhuYStHa3F3UU92dnNkY2s5cDhoWmFvbHpCUU9sWHRjQmxF?=
 =?utf-8?B?T3Z4UGpDMTR5QjU1U29Tam5ZRTlpamwrNGkwVlFtTTYyYlRiaU81SjhGVTY5?=
 =?utf-8?B?WkhraU5UVlg1enJ0d1VQdENMT2lyc2hFUkNlYnNnSFNUNXRnYWlJMkxkRjZz?=
 =?utf-8?B?SGRCdkV3Q1hIcnMrcmw5V21NaHJ0aEZJY1FGSGR6QlJxYlpjRndhZmVxVW9q?=
 =?utf-8?B?ZkFrSDl6MzNkdjJNK1RyVFFSeFN4NG1FV29JU1FnVElHMllRdW5RTk5UMTlt?=
 =?utf-8?B?WEFqcEZqVURsWWx4VGFqa3VkbTN0cEJrOFBobUVreTkrSDQ2SlF5djg5OFg0?=
 =?utf-8?B?bVBjelgyMkF1emF1M3N1WUh1TW1jSzQ5dFU5UEF0em1oSG04cHFuOFd2YXpm?=
 =?utf-8?B?bStBcEd5TlVNcUlUeWZ1QjJONmxjZVJpb1ZGem95UERmK2R2SGl5Tnhwa1Fa?=
 =?utf-8?B?cXhsYXlYSjZlSm50VWtDdEU5NzI3TGd6bk5zSGo2SWg2d0U3OXFXUEh6cUV5?=
 =?utf-8?B?NU5wNExxUVpLM0w3NmZUczFjY2g3Z1VabzVvK2x2RmtRRi9uZDB1MkRIdVdF?=
 =?utf-8?B?RjlFeHBwZkoyRTlDbEFpY3lwSUdQbytBbk1JUkIyaWtNTi9tckJtSkNlWkJJ?=
 =?utf-8?B?Y0k2OUZjNUF1czNwam1uTXJJRkVxMUVBN2U5Q2VFeGJUWXRiQmthcVJEc3kv?=
 =?utf-8?B?Y1k4b2tPbmhVRmVPRDBCbEhIemVVTnhWQ3k1MTJReW96L1FoZWJ5SHZBWWxh?=
 =?utf-8?B?T1JzS2JjQWl6di9yL0FZRHFYSDhQbkVDa0lUbGg4bW9WWmk5WUEwQitoSFlG?=
 =?utf-8?B?Y0xHS3ZycWdVbWdyNXpZc1hZbG0vUTJHWENtM1ZlajlFTUdnVVRFSE5xODVo?=
 =?utf-8?B?dTB6OE1LUjdhanpTSFliaHplZFdlakpxVjVSNmxmMDMyaUI2M2RUdTF5dElO?=
 =?utf-8?B?NFZLamxSZ1RPWjFSaXRPeEpjdlNEbktqbEJGclZXR2czc3NIZzIwUzAyQnRT?=
 =?utf-8?B?a0FpNmlSZmZkTVdBVjdVWEtEM0RyTUJUMkk4N2NjT2JJci9NeldPZDAyS1E0?=
 =?utf-8?B?RFBmekxWUjIxMHBGdzg0bXNGOEErSnozdWsydjdvY1kxMzBHem1yYld3OElD?=
 =?utf-8?B?MU5BMzdZQUFrOVhrOG9BR1NyeUNjTWxaV1F4NUJ1QmVqWTJwb2Q0NVZSdFdV?=
 =?utf-8?B?d0Q4VFA2bVp2NHg3UFNUZ2kwRkYzZ0l6SG1BM1lVVnpacXEzVWhxOHdTTUJV?=
 =?utf-8?B?VW9HMzlqUnNmUS9jbnVpbHRqU3AxZ1d2UkFPQ0VrUllkblc2TnVQZzVHUHl2?=
 =?utf-8?B?TzRWR2xiSUVRdjNzb01rZjFZdERJTVJvU1hZeHU3VW5FWlhEK0IyKzIzTjg2?=
 =?utf-8?B?NTkwVVpVZ3o1MGt6YkNiOGtVcDE0SURNRFlyTmpSdldJSlF1cmZKQ2VTOXlw?=
 =?utf-8?B?MzNuc2hTRWZFNXA4R04wNTNmNnlrelI3RHg5OUoybk9mRUxqOGZkVVFnYyth?=
 =?utf-8?B?d2RuN3lEUUxvaWcwMy9PZ3o3cFg4SDl2ekRYTEFHUGJVOTJsUlcxSktmYklH?=
 =?utf-8?B?dDV5UWo1YkVNc2FpN1FySys4VDVmWUIvWTk0Q3dhU1p2MytueFVtYWRYbkVQ?=
 =?utf-8?Q?icyPAMeS8DpZtYnjhRj9NjAqL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f423b0b3-c852-4dbe-2d95-08dcbdd3b191
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:13:29.7050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvB3sIbIZ+zYwjqcKUgmP+cvnt/BR8T7AXMkNV7qv/bAjt5GvFiUyrRVHClt1X+/ALnB7OG0OJup0ueED6L4Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112



On 02.08.24 15:14, Michael S. Tsirkin wrote:
> On Fri, Aug 02, 2024 at 10:20:17AM +0300, Dragos Tatulea wrote:
>> This series parallelizes the mlx5_vdpa device suspend and resume
>> operations through the firmware async API. The purpose is to reduce live
>> migration downtime.
>>
>> The series starts with changing the VQ suspend and resume commands
>> to the async API. After that, the switch is made to issue multiple
>> commands of the same type in parallel.
>>
>> Finally, a bonus improvement is thrown in: keep the notifierd enabled
>> during suspend but make it a NOP. Upon resume make sure that the link
>> state is forwarded. This shaves around 30ms per device constant time.
>>
>> For 1 vDPA device x 32 VQs (16 VQPs), on a large VM (256 GB RAM, 32 CPUs
>> x 2 threads per core), the improvements are:
>>
>> +-------------------+--------+--------+-----------+
>> | operation         | Before | After  | Reduction |
>> |-------------------+--------+--------+-----------|
>> | mlx5_vdpa_suspend | 37 ms  | 2.5 ms |     14x   |
>> | mlx5_vdpa_resume  | 16 ms  | 5 ms   |      3x   |
>> +-------------------+--------+--------+-----------+
>>
>> Note for the maintainers:
>> The first patch contains changes for mlx5_core. This must be applied
>> into the mlx5-vhost tree [0] first. Once this patch is applied on
>> mlx5-vhost, the change has to be pulled from mlx5-vdpa into the vhost
>> tree and only then the remaining patches can be applied.
> 
> Or maintainer just acks it and I apply directly.
> 
Tariq reviewed the patch, he is a mlx5_core maintainer. So consider it acked.
Just sent the v2 with the same note in the cover letter.

Thanks,
Dragos

> Let me know when all this can happen.
> 
>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost
>>
>> Dragos Tatulea (7):
>>   net/mlx5: Support throttled commands from async API
>>   vdpa/mlx5: Introduce error logging function
>>   vdpa/mlx5: Use async API for vq query command
>>   vdpa/mlx5: Use async API for vq modify commands
>>   vdpa/mlx5: Parallelize device suspend
>>   vdpa/mlx5: Parallelize device resume
>>   vdpa/mlx5: Keep notifiers during suspend but ignore
>>
>>  drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
>>  drivers/vdpa/mlx5/core/mlx5_vdpa.h            |   7 +
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c             | 435 +++++++++++++-----
>>  3 files changed, 333 insertions(+), 130 deletions(-)
>>
>> -- 
>> 2.45.2
> 


