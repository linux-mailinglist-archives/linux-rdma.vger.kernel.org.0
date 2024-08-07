Return-Path: <linux-rdma+bounces-4236-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B04594AAC0
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 16:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F211F2638E
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34795811F1;
	Wed,  7 Aug 2024 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CjqtGTZ8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467AF6F30E;
	Wed,  7 Aug 2024 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042475; cv=fail; b=b+UWzDoZRa0PyDC8WjomUx1kJkE8QXZzMTN4KRsdKVXazznTsEP3HA2uk2fW6/OChqZsFXkLQZTDuoKUMiOHrrHg8yCvg3r5s0l0FueiZ6HzOh01jkxLc2leSOD17DZ3bWypnuItZhv88QZnRw3Db4ixo/cdE7ucA/ehGzXV2es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042475; c=relaxed/simple;
	bh=A2KQRnGp2eDJqNBdd7w1ExxtCaKnyPNmMpjmHpHoFjY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AwJ8aKjo2IJFTNVL/B01iXLWXJQdYG8p592Yl/por0kcMYbGtwmQZ+y1yIeFCSCmU6Bxkn+e4VVFpRLd6Nq5GAmV7CGDpxgA54VyBgl+CZtZvfP57RvOuYOshnk7Tzp8Ypsml45eNY8FxiWAxYqVtAZhF5rKMWbyupxKom6iHok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CjqtGTZ8; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnFCHJwyc/G3n+CXT7P1vr/ZfdIijIq9dCj/O2+WBhADeC6slxDtrAovbKPo/Z4WnnhfQn0tJDZsrSs5xDXSRw7J/osHmcOR4jgsq9OyT3N8+o331KHexHlE5bEtfuTVV07UpS9wDyRvgwgdz59VEkglUIRdVHOVFPeGE1i7nEkpe2b8psb+xlWP1SZFoogOpoGAoe7t4YUTvHMoaY//BfSHi5EoV5yPCjcEsKDHI8d01948qQHAqD73KjednhKG1wLzdpQ45+8jcNHhBSVELU/xsC0y0oxQLIi7DUxpfu36U0q9LWwSZIB0BDV1j54ir5vMpB9euKSrwVvtYJ/Tcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRMn1gDqhXXJFnBP5HZYT2yYy6Lt3zXMx/pKQUPSfdY=;
 b=BuT4pK1LMPIF8xriAyjjv8le+k8bw63NIgnmAir/GtlTjwVOQLr/wWlPsODEjYu7bIgX/USpYglgjlAP+HMltM7hpM4DOs0unIZYqkcc2F+Pc6b20nQ54vDfVh8PS3/S/SNQZ/tPmHONs6zNm6Ea23Gb2PU1Gd/2hShvr7dBmQIg8KD3MfXXTeTgClEllIwFBwxi4LDJhPWaaPP5P+1Frmz5w0Gdos9/eIcGFmYmYlO+wuiUqa+Nt7eavugS4W1Clt/RnZFAuP0tLS9P9/RYDaRFobE1edkfUis64yb7UySUgI3DmdVyCbLiRkGQhD96AceJCnw2kYI0kQbF3HaWUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRMn1gDqhXXJFnBP5HZYT2yYy6Lt3zXMx/pKQUPSfdY=;
 b=CjqtGTZ8K6mQA+QO+o9Os9bzU4YLxk1BsdtbHeNo5qHUqEhVJz9GO1htfkw8UmLKX8Os+Se8GE1vH3U13y3f3SOe9KnFQqATtgIpIQak6V8NTpcMJNYCSEAoPR5H8wj/7Z4yVlKa/EKzXYJVIHH2uJZYOr81eDwp2PzWfgIdLzcbkK7z9xBElBkefzqYoak5G3vLc3cDmRDaBw4ATMu4Xd/JJDB8M1SBTfOBog0WDRqiOYNATPUr5c5VIwUMXamVh+lPgciylFPTlHLPYOtOcq/+7QMMq6tq61MseBpZugSIYwqpJp9ZsNDpuQiUHLpJpqIWTItSsrlSm1zHXPKt4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Wed, 7 Aug
 2024 14:54:25 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%7]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 14:54:23 +0000
Message-ID: <6582792d-8db2-4bc0-bf3a-248fe5c8fc56@nvidia.com>
Date: Wed, 7 Aug 2024 16:54:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vhost 0/7] vdpa/mlx5: Parallelize device suspend/resume
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240802072039.267446-1-dtatulea@nvidia.com>
 <CAJaqyWdGNfJ3n-E2-PvkuvCiOMsLkEzYaUi5wi-C_n84-a_LAw@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAJaqyWdGNfJ3n-E2-PvkuvCiOMsLkEzYaUi5wi-C_n84-a_LAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::9) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfd15f8-8850-43c6-2a86-08dcb6f0d37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2RiR3hCWDl3K1RBNGNXazRJQUR2L2ZZaFFyRU5ZSVRBMnFnNGNIakFMM05L?=
 =?utf-8?B?TjkvL2Q4YUZrUzVaZ1JNbXZXa21Ga1UyVk9sSEYvbDl4WXNYT0VSaEllVm5K?=
 =?utf-8?B?U0Noa2NYdGZNS1ZTVmFtZmtxRFVZTW1SOHRidUxtdUJma2hPeUlJakEzcENN?=
 =?utf-8?B?d0d5VXBtdU42bTJaTURGVUtURzZOSk1LQXVnKzNCaEY3RWRmQnUwblBDbHQ0?=
 =?utf-8?B?U3UzOHl4aFZNQkxpVjl6SngyNTNyY1A5STNOc1pvMkVrOEVTakxzQnQ4eEZj?=
 =?utf-8?B?NTZPVjllQmpveFVYb0dLUFVRNTV4THJkenlGTkNDMnZTTyt6VjhkeUpIZUY1?=
 =?utf-8?B?NHJOQlJJL1l1azFvbUNmWkF2bXk3VUE4eEJLRnZ2bERYMENqdjhHeVM0aGpm?=
 =?utf-8?B?WDMvenJGOE5iN01WaDZVR3g5YUVKWGc1YkJCSkRYbzJkbDAxQzhISXowTk8z?=
 =?utf-8?B?ajRVOU5PUjJDSmdzdWMzYjd4TVdVeWhReXh1Yjk1RHZiZitvOGhtLzYyTGNh?=
 =?utf-8?B?cXRVd2dtUVNwcnRIbU01M3puQ3dqTURscXg0YnFOdnJhMmxNL0srS0FvSWMr?=
 =?utf-8?B?VExPSjFqL1lZaUhPZG4yNXhDSklBeVZEaW10VkZLQVAvd0RVWkxGcmgvZWVP?=
 =?utf-8?B?T1ZGVUc2T2txdm1xYnJwT3IzMkd3emxVUTF2MHJiVWl1NGVpSER5SnBPSm1O?=
 =?utf-8?B?RFd3ejl1bEhIb2puQWNjLzBKSEE3OW9xa1lRUGgwc1MxczF2d1E2VVVORUtC?=
 =?utf-8?B?bDU1LzJOcnpqRllYcy9zYktwM0tmR3dWUGNvUnloYWhrWDNRcTNYUWtiK0ww?=
 =?utf-8?B?SEc3ZGNMWXN2RyswSjZrOWpUTDB0VWI2M1VvZFBBTVFKZWE5VzRoSnpVWDJn?=
 =?utf-8?B?S3ExSGpXbE5XVlpjcmhmczlQcXBrdzBldEZBSlVpdWRiYjNDYnR0YVhMSFR4?=
 =?utf-8?B?aEFqaUhtOTlQN29IN3FVWlA0N0dUZUM4ZGVEcWVwd1VJUlBoYWR0K3J6MlE2?=
 =?utf-8?B?TmxjRnFqTmROZ0tDcFFHZHFiUEphTUUrb1piYUNwQkJLelpxcmdYdXVoeWlG?=
 =?utf-8?B?a0xTY1VHVmhtNFFSb3g1azdER1RGRXU1M0UrRXdNeHZ0WGdCeitmektQN1Iy?=
 =?utf-8?B?ZmIwQUhQRTA1RDVXZnhxSlpnTVU0WUZCcEtpcWlYekNhVmJxV1VBNHJIZ3lV?=
 =?utf-8?B?aGZwRERKemZnR1FBU0JzN1lDYnNmdHd0RklvOTlveVljRHJvdi9aTFlPcDQx?=
 =?utf-8?B?Q0J0QUNXQVJkUnBjNXc5R21pdDNzZ0V3d3NyUkRqUUhVZDNSN2NIZ1FvSHRK?=
 =?utf-8?B?YkY3MUJKdTdubTJjbHVrU1ZySjRmVE8wSUpPTzY2WVkvRnZLRm9PMUZXWm45?=
 =?utf-8?B?M0pya3lHMjlUMUtSVlk2OTlHeFNvREVmWXV0dWgrMUlyVytqQUtTMjFaTXJY?=
 =?utf-8?B?ejhPREpzQkJLWUVXSXQwTk0vci9xR2h2MTJiMDFYUjY3d0YrZUtvZnZMdW04?=
 =?utf-8?B?a050b3U5Z04wclRBaDNkSnZWTXhYZVREM1IwU3VwMGNuOEJpck9HNnozME9W?=
 =?utf-8?B?SUdQcEVMWlg0eEZ0YmUzbzNSc2pMQnRseVJDQktQVk1OUnN4QUc2RDlGKzR6?=
 =?utf-8?B?SW5JYncwMUpTOG9xSkJIY1lWMzk5Sk8rc2FKK1lpajdGOENPTWp6NnVwcnIv?=
 =?utf-8?B?aURBVzdjOThrYkh5SDdOY0FBNWFJNGViSkhuUVRyQU84NGpGU2tCRlgyeFNl?=
 =?utf-8?B?SWROS1p0NW5zbVByT3VWbElDWkxVblRaZEl5STBjcEFNWm9LMXd1OFBualFk?=
 =?utf-8?B?YUY4WFo4T1VBY3k1ZFVOQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjlTK0ZodndjMnV1eVF4NjF1dDVncHJVWittVG9CMWpzN3NGZjdaTFdqT0tI?=
 =?utf-8?B?dzIzVkpTYXBUc1M2OG83S1N2L202ZjFYSlJpZWgxdStsTGxwNXpZTWZ3SWlD?=
 =?utf-8?B?SzNjN0FPZzZVVkRLTE4waXppT2FxS3BLTEMxMlMxTndGNGZRWWEvVDNNK1NU?=
 =?utf-8?B?WDlmZElhSHl0RHJueUUvRWxEaFZ4Rnd6L3RBWm4xTGZHaklQTGwzMkNpcVJ6?=
 =?utf-8?B?SFRndVZkd3l4RFFnOUlNdGtkMTVQUU1pd0pibmhncDU4Q1U2YXRBM1BKa1JN?=
 =?utf-8?B?c3NPSURxMkdId3JoVjMxSThJL00wYVJ0MXhHQ2N2OEFVdFB2QzFrSXNBNTl1?=
 =?utf-8?B?TTBRcHg4b0pXY0t6ekgwblo1TzEyT3I5OUpTRkx3eUNyNGVmb3FHZVg1K21V?=
 =?utf-8?B?bHc2bnMzY2lOczVFNFZhd0g4UGpHK05sVi82ZFFsRkJMUVQyZEJzMld4N2ZS?=
 =?utf-8?B?SGo5eDd1ZjBjRytJOUJhUHFFNlh5UFRsc2NQcjZzTDBVY3ZOZ3YrRnVJM2ZM?=
 =?utf-8?B?dlhHVzFCTnpGNlF0ZnorYXZFRFBsN0szMGwzdzhIOGZXVVJ1TW1hbVFUMUh2?=
 =?utf-8?B?c2FvWTNHeFY3Q2FmVFNCYzYyVU9xR2NDeFBBNGF5dGtYNjFJdm5HWTJoRERG?=
 =?utf-8?B?QktHTGVCZ251amZlYXpKUks3bVJHYVlwODc3VmU5T0xIR0xtUjF3dmpqSkY5?=
 =?utf-8?B?VmJIWDVtMXVSRVVCM1VKM2hNaTdQWmhuL0VPOGIwczhvYkZrN3hqV0FPdmdN?=
 =?utf-8?B?amFOV3ZXN0d4QU9JcktNeHdqRW1WNjdQa1poOFBGcnVpMW9hRkUyYkg4LzlI?=
 =?utf-8?B?d0Y2M3pDT0IwUnJhZ09IaDZkek5ESURQRGNnR2F4MmRaeU93b1hsbWZ3MXpZ?=
 =?utf-8?B?NzZTTk4wejNwNXlXOEFyT2cvOTRrSUNLcnZBSTBvVUR3T2prOHJ4Vkt0Nmtm?=
 =?utf-8?B?NjJiTFBKdERGa2xPZzVXbHZ5SUE5VXhrS3hnSVdTV25zbStJemJYcWhSc3RL?=
 =?utf-8?B?RiswcFhZcUMvbU5tK2ltdy9KUHJMbTdVWHZVNDgyTlo4SWx1YjFYM3Y1RnJP?=
 =?utf-8?B?Q3NpV3dlclcvTWZ2bENCTkRiN2ZBeHpRT0VRbDZsUTZvd1V0cDlZZzBORDhn?=
 =?utf-8?B?Ri9lSC9jNnp4eVNVcC9WWE1Jbi91UmhDcU54TTJFc0R2Z1BabU1wNldCaG5Y?=
 =?utf-8?B?aWg4aXpORzhidE1Pa0dFcUlRR3MzMVVwcnY2N1Y0RU5JMXlzU0kxd05Fc2dr?=
 =?utf-8?B?QnVMdStKbWpndnR3MWRRNmdINGV4M0ZLUjVhaWR5N0prUDNtTEtYMHlISmRk?=
 =?utf-8?B?cHhwN1pwM1pYODBJbzc0Z0JkRTBjdGZpMXJwZGJQMURINzFxeVBubzZSTTM2?=
 =?utf-8?B?b0g5MWxaUldBQ3NoZ0tFa2Q1bFBYcy80N2RncXdHdm9JNjFkZXNpMGpaeWNq?=
 =?utf-8?B?TDNVZkpCTFowVzVDVGNmc25GWDlacFFMT2dvV3dMNEtzZFFsMS8xVDZOc2F2?=
 =?utf-8?B?Q2U1WC8wZ0x0VHpOTy9UT2lPQm51aGdBTElvdWhzOEYxMHgvTFhuRzFmV1pt?=
 =?utf-8?B?OFJVZUwxcmhxQTVFTjEzaEJKaUFFMHdEaGZjcGRpSHJNMS9MN2w5UkpQQXFS?=
 =?utf-8?B?WjhoNXJUaHFLQzJ0UlNOYjZ4dU9iMklhQW9JZGU5bGphTGxWTnNTZFE5NTVZ?=
 =?utf-8?B?QmkzMkJLbDB1RkhMWWRyVENmU3lOaFUvNjJiRFFqY3F3RTJvcCsvci83NXNy?=
 =?utf-8?B?Vk5QKzlHME01ZnoyRkN5TnZzOTFqZEE0YjlXZHhUTUlScHowcVQxVE9SWEd3?=
 =?utf-8?B?WEFWdVEzSENzM1Q4emVuVkV2eG9zS05YcHlOWkJhZUY2NStLMnJIb2lncGRW?=
 =?utf-8?B?bjZqMzNObGRjaEdLTmR4cmFwSGp0SlNCK2JsWi9MZUFQbVQ3c0JjQVJhVk9y?=
 =?utf-8?B?cytHR1loaTZIZjF5OGhuUlZJRVNRVDZ6YVFVbmV0RWtNZitoV3JPUDRZOVFI?=
 =?utf-8?B?S01kakQwdXZXdWphVGhUQ0Fwbk56VUlwaXNyclhFYjJHMWE5RG0zMEdGSEd6?=
 =?utf-8?B?eVFONGdTZXc4eW1NZUszWlhqVGpiRVNaRmZkSUNpZ2lYaU9TeGx4TTBtemtQ?=
 =?utf-8?Q?FFM/iKHoDavJsLjEE506h9IxK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfd15f8-8850-43c6-2a86-08dcb6f0d37c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:54:23.8768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhegpFw88p1JyOwvYKsqLc6huMSJSIkXdzjpUXGfiuiwR0LRhrGfYDsxy1X+rDuamq5Jm29SaYa3HAE18CZvnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707



On 07.08.24 15:25, Eugenio Perez Martin wrote:
> On Fri, Aug 2, 2024 at 9:24 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>
>> This series parallelizes the mlx5_vdpa device suspend and resume
>> operations through the firmware async API. The purpose is to reduce live
>> migration downtime.
>>
>> The series starts with changing the VQ suspend and resume commands
>> to the async API. After that, the switch is made to issue multiple
>> commands of the same type in parallel.
>>
> 
> There is a missed opportunity processing the CVQ MQ command here,
> isn't it? It can be applied on top in another series for sure.
> 
Initially I considered that it would complicate the code too much in
change_num_qps(). But in the current state of the patches it's doable.

Will send a V2 with an extra patch for this.

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
> 
> Looks great :).
> 
> Apart from the nitpick,
>
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> 
> For the vhost part.
Thanks!

> 
> Thanks!
> 
>> Note for the maintainers:
>> The first patch contains changes for mlx5_core. This must be applied
>> into the mlx5-vhost tree [0] first. Once this patch is applied on
>> mlx5-vhost, the change has to be pulled from mlx5-vdpa into the vhost
>> tree and only then the remaining patches can be applied.
>>
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
>>
> 


