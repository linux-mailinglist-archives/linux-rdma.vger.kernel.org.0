Return-Path: <linux-rdma+bounces-9262-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64702A80F21
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 17:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4767B52EB
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E86A222595;
	Tue,  8 Apr 2025 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oYShYR+1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE43757EA;
	Tue,  8 Apr 2025 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124491; cv=fail; b=bHjsfx4yA6Ty+S7I+18i/J03YsUdZT3w6Sa78BdkeIuoM4tCoymC0LHHBC5ylE6b2aYO5BCB5GViWOUKkhZzo0qgcl+1wIO/XyaSeCvstX59wZBzDTcDoWZ8UYf13wSqNe6HZHTywfesSUIHF2P87mjwJqTlit34dNnAJNrtkww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124491; c=relaxed/simple;
	bh=3MaYpp/OPBNWiOISVc4Sy8w+zS1C1IpWijtVG030iEg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nCgoVHAuMWi3ldDVuKLNaWNO9zn4ZXISo3UrRPanwOQVuKrvNIq1zFQoEhadiMR/chbEFceMBusmd1+ojePK3eKpxd3SUFW/7fyB+dLfLueeLmgtMhEZCUJxxXFTBbNR5rRUES3DmPt6RObFtS08A3zopP+Pn2Qk7RTl1OHQ5Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oYShYR+1; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQl+M4C1AkxIBciR2egYBi8JFOicapq6bDAvDGJfyv/3MBx9KhhIxwDvp9YL8MwIoGzXITyTTrKhKqUOmq4AssBu6q/uUbmbULL0c4lFdOfuNBpk5qTBXpTrL42o5nFzwxEGcYjG6g5h3sDFVnTc9Spc418T6wcoHq32XKkRU6YTvSrobR3VN0iOFq/36qJI3RJJeTF6LKzQew0AmEHA8q+vRZJI4swPKniQoQNR5m8Gz/F1Y/LNcQBzBuMxb0xJsRBUaueT2UB/Z5Y8Ze2Xp9YG0sQLtAg+xB/WEFnJmd/99+EN/XoBx75vb5dtKlPmpTmElP9OL+mRkdR34PGjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrFWrmoW0T9CqEEa5yWi0tPCvxxp7gPX07HjKSbdpuY=;
 b=DDZcHs56Ytr73MHr4xpteF2KeVNL0+vGA0xw7H72JIdekRCFv4KXCm7RCrXA3hH6/P0FCUEwnGmnhAmfiig+3qu1qylouwm6HCuC7pKrd5rdS5l0knPLM+cKaU33xVr8383vKReIExF8748rZai3Je4R/kQsO2roOmv8uFkbplKouqwr17AwvHau9LvRurDIId/sdsy3bcd//6BFYYxaAnFZBHMEeLEUvjPhYacsIrxu3tI++rFLrXBb/juoq8lzENyXsMDpFdnU9cHa+XChKWklGxL3aJvYHNUPBzRA5lRvL8tfBwPn1sMmSK95PObioDSts+D1o87qwt5Fvva/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrFWrmoW0T9CqEEa5yWi0tPCvxxp7gPX07HjKSbdpuY=;
 b=oYShYR+1WMoj+ljsKnOFzCzoVMx7GKoAflMqnA+oeUg2l4MPahUpgtiwVAJxOd92XKfgmW8BYNkUXKuTDTF7pcDPWP89yqXrD8NUKVRKL8XTdmaCCLZa8SgfuONCP1hE0QqZzeoiiWj68kjttaupkvZDvZstvrVOgDitKbTuEiDOA+/lQ/Vi1QefUzcalopCMREZ5cBlk571hMDyU6zlGK7bficS1JytaaBTFJhBPlVlDrarc1ooRYfJ7gYMMTHAccUDQDggxzxvDbsu7H1chQdh+QPaGg6SI/ym5BS8+YGG/eyKRcVG+g3bl4/qW374VWXxjQENppd/KX7nDVy4mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 15:01:27 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 15:01:26 +0000
Message-ID: <7aa5ceb8-6cf7-4f60-90bf-5a8ace49ecc6@nvidia.com>
Date: Tue, 8 Apr 2025 18:01:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Fix null-ptr-deref in
 mlx5_create_inner_ttc_table()
To: Markus Elfring <Markus.Elfring@web.de>, Paolo Abeni <pabeni@redhat.com>,
 Henry Martin <bsdhenrymartin@gmail.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Amir Tzin <amirtz@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Aya Levin <ayal@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
References: <81d6c67d-4324-41ad-8d8d-dee239e1b24c@redhat.com>
 <5ddf49e1-eea3-4a20-b6f2-fc365b821dea@web.de>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <5ddf49e1-eea3-4a20-b6f2-fc365b821dea@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::20) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|SA1PR12MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a757338-e4fb-4a21-7261-08dd76ae3c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUVjczRWZ2pLSks1LzZVSDRCWGVFWTFFZ25vOWpiK2w4VUFxa2IzUG5Db3Zr?=
 =?utf-8?B?YXdDaGJQRWZ6bVJ1dGZueHpaNEQwU2dQYmdnQktnUlRPODRpRGpDTjFpYXNP?=
 =?utf-8?B?QWFESlZKNnE4YTRNTGZaYUZCTU41M3RBZGsreXNJSTNuMjA4U2VSYU9jRktp?=
 =?utf-8?B?ZjNaa0tnR2s0MWVveFdOSlM0R1lXZWZiTUlKVzlnVy9VUGpVSUQxR0cwdTBr?=
 =?utf-8?B?bUxoNHNUdnV3T21DRlB3a1VTS3pOeTZVV2NpTGxwcXN5QkdPZjA5NlBxTUhw?=
 =?utf-8?B?bjlmcTZXamhsc1I2em1HRHZRQ3lCaDl0OERjenNKSWdiNHhXRFViUXcrRU5k?=
 =?utf-8?B?aVBUWkRwS0Y5VjRHMUtVQjI2SUg5RjlMd1REN29KOEhlUDdlckZDMDdPUzc0?=
 =?utf-8?B?d1hTMFFGdDU0TTdhMXQzVTNtYVcyVU1WUlBnOWhnZWRDZDRMcEVaNzZyeTMy?=
 =?utf-8?B?Wldtd05ZRXBUVE1uY21tak1MeDFVM2UxTHo1Y1FXOVZLTHBuVmhOd2g2Rk14?=
 =?utf-8?B?MTZJME43R0sxS1ozQzk3TXV4MDJRNWFZN3ZXZzdxZE9QYXhCVFZBMHNJTHdY?=
 =?utf-8?B?anVjTHFzSy9HeVlrcTI2cnBSRU1FM0dOcHVZZi9RWVU4dnk3cldmNjJ4YU5W?=
 =?utf-8?B?U0xUcXFYNzljbVFpZy9lTThsTGpQZFc3bFJyVlN4bEw2clYxSVovZytWYUx5?=
 =?utf-8?B?MXRHZ3d5K0NWNk4rZzBhVTk4YUkvWUZXdHgxbGJYSU1UVHg2WHlqL2FLblVT?=
 =?utf-8?B?cWJjay9jamkwZFNmRzFLdmRIem43V2JNMDlldDQ5UWprcEUwTzBSZTVkZFd5?=
 =?utf-8?B?WmkyRDBlM2hzMjFLaHV6OFhMU0d2OHFxMnJYNTZXcW1zeHJORjBUMmp4NUpQ?=
 =?utf-8?B?TFJsUmR3NVNRU0xLN3VXejEwZVBicGw1N2c0amwwTGdGQWYvUHg4UHRVU1Yr?=
 =?utf-8?B?MDlDS29TTk5OUkRXQktzbnZIT0VzSVlxVkxrby9KMW96amFxWmFLSDRCekVB?=
 =?utf-8?B?MUhLZEplcDB0dUJkMnZleFNxdkVML0ZQQ2NMeXlob3oxVTRjME10alJQMmo0?=
 =?utf-8?B?bnFuWVlZdkpjT3BjZWUwMjVLRTBNazIvaUs1U0ZDcVF3TmZwTUpkOVlFZHhj?=
 =?utf-8?B?ZkhrNUM2YnVFcVFnRnd1UVh3NVphVWp6NS9RQ2NFZFlWdzUydGJPSW1FQkls?=
 =?utf-8?B?OXY2Q3hLVW0xR2xIckZRWlBOUnN0OFV0NXpubnRKNWEvcUNuSVd1Q20wQkU4?=
 =?utf-8?B?cXA0b1BINWJScktKWUJ2M0RFaktKcS9FRUdhQlR4UlhHN3k0Y01Cb01Rcllt?=
 =?utf-8?B?VEZNMHZZOWRBRTlVSkZGYm5EZWptUHBvSlA3eXp5Z3BLcDlFYStOa0tCOXFV?=
 =?utf-8?B?SnBkZksyc1dUWCt4cmM2SHVMRWxzRlVmS25LM3VuOGdMUkdSSzRxcHZ0OWRr?=
 =?utf-8?B?dVlCMnRiYlg5VllSK2hEQk5VQjRydEFxWG9JZlhRakttMjdmZnJnbW9xSWNG?=
 =?utf-8?B?K0ZYTnhKSnREMlpTYUM4NktNTDRza2dBdHQwZElpMzhzQmFqRE5Ga0tDcFlo?=
 =?utf-8?B?d205VXpOWUl4WVpHaTdWOHhqK1hxQUNVbHFFVW5jN3VOaGIyeHN6cXMyOTBG?=
 =?utf-8?B?cDYzYmdPVkFzMDgzOURFQlcyeU9jd3kxTURmZzhlWXo2TmVhMVY0WE5yY2NB?=
 =?utf-8?B?NW4ycU0wVEZudkdqNGNCbFRLVjFBYlBWQTNTeFR4RHRHUWdCenV6S3dyOVVm?=
 =?utf-8?B?cjd4bjhTWmM5UVVydzFVVFVpcmRWclY3eGNmMW1aZUFDa2JSWnB0RFZxYmRl?=
 =?utf-8?B?enhSbTBCODBIV2puc0tSeDZwSlF5Qm9sVDNVVUFCYmpCVGpqalhQNjRrZXZG?=
 =?utf-8?B?M2wraTdDWFc1UzJkcWpnQ1hKOFA5RlA0ZmpranVvazltbzVKRnVrSDVRQ0Zq?=
 =?utf-8?Q?J/hMprGAk7w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zk5IM3RhSVN5QnVranNaL2g5L2FjOEtLMnQzcHJUaWxsWkxPMkpvdmNXaWNv?=
 =?utf-8?B?RTZJYUFqcCswdW9waU5UUHM5RStGTHhhQXZBN2xxcXJERUVaakRZSUZqdi9t?=
 =?utf-8?B?aDU3RCtnaFkyT1RjSHFaWW4yVy9MTHRyQlRjQ0hyOGExUzhOZEtiNlkxU2N3?=
 =?utf-8?B?VW1NSE0va0dGMzd1TlBqQjFYbFVYQ0lRM0pnUXd1a1pXQWxKd2VvZEtKdkQ4?=
 =?utf-8?B?RlJEeFRnQStWbFBGeFdTWkZ2d1htelk0TGhEOGlFTW5xaHU2azdkdDBQYkNp?=
 =?utf-8?B?VlZWRkc0ZldQOE4wZ216Q2VTekd1YUhQZTZLTGZXUS84ZzFVeHFKWjU1Kytr?=
 =?utf-8?B?SGl5ZlBDdVdBSUNSVUJpK2F4OFBvbVVWQ0FYamtydkFmZzlZQmdaZ2Rmb0VG?=
 =?utf-8?B?VGxEMGYyMlZXbW9HSVNZWmNtWWZJU0l2YndtWWZpY0dVdjA1T3hxOWt2QS9s?=
 =?utf-8?B?MC95SDVDL3dnTVhDMHJ1NU1nenBJdGZxbzNlTHg2UHJmR0NkVEhtblozWlR5?=
 =?utf-8?B?ekp4amZlQjdBUndXaHMraHF4NWppZUZ3bC81Zmg1dEk3eVpEazFabUZ3Nks0?=
 =?utf-8?B?bUprV1dkOERSS2JUUDA4a0oxTUF6aG9xb0pva2NUaksrb00yWG1RUmZYRm1I?=
 =?utf-8?B?ZkplUDQvNlpPN3ZBVTduNkl2WHlwQmV3OFI3b2t4TWtyenJsQTE0S2FtajNv?=
 =?utf-8?B?dHU1NHI3SU1OODF0QTQ5YktRWm92MTlSc1FiMjd0UEFkckpBK0s3QzBRUUJG?=
 =?utf-8?B?Zmt6Y1gwbVpRcGZrNEdEVUJVaUgzYWo2dmtYUDZaK1NjblVTVmgzWGcvQWsw?=
 =?utf-8?B?cUR3NTVuVG5qbDNvTFF6V0RsblhyNGV6YU12Tk41WGJnMkM5VE1OcUpIanpi?=
 =?utf-8?B?TVFPbXRKUFRrcVZLV2FsRWdCMkdUM2dOQzRBZUQ1R0FJaW00T0tHbkJvWlNt?=
 =?utf-8?B?cmcyaFhrSkt4dWlzRzQ2cExCTUNuTW1UVWp5MEZBcFFkM2lleHFkOVRZdnVx?=
 =?utf-8?B?OWx5endoNUJNNUkrS0hOc1VTY2ZoQ0NiQmdPS080U2VLenJXVmFOWmFRR2Z2?=
 =?utf-8?B?YTFVRHhkUk5YYTR0WkpZdWJwaTRSOE9yTk1rYkdXbnpIRzQ0SFJEZWdtT05o?=
 =?utf-8?B?THMwbVduTWIzczRxTnZjdUs2Yis4dnR5MTJySzZQQ3Z6UXdXdTZ1M2hScWhJ?=
 =?utf-8?B?TGxuZEs5LzhENDR0dlVYTnhualNlOHNhcHR3ZmF0SmVkSGx5R0tRVVNnNFZQ?=
 =?utf-8?B?emNuOU1OaVhyK3J4Qi9GTzR2aHR2Qi9RM3VyYkJTaG1DNEJ2MkJyVlB4M29l?=
 =?utf-8?B?eUtCTlgwSUIrclNSZWRLTE1QSjFUY1VYNkk4bXdWQlhaN0dFUEpUQWt5eXgr?=
 =?utf-8?B?WXQvckZOQ0tUMXl3TVc2RnVKR1IzRUw3eWgrdWVWRUN5VUZubmc1VUdoNm03?=
 =?utf-8?B?dkFBODY2VUF5czF6MFFIVDdYei9MbGtMNCs1RGVBTkNJRGgrV0d4ZnB1Q3V6?=
 =?utf-8?B?OWZJTy9pcndxby9iZ1NSajVKRHBOSGl5aGVtNGR1cmd5Z2diSzhCakluVXY1?=
 =?utf-8?B?QUlwL3BHdm14cENVRTNYRzlyRk1LaVNneHoyR0cwY1ZrZnlnOVZEMjJ6eVB6?=
 =?utf-8?B?anBGSnRkYldOTitWL0RGaGt5UmtubjFieUhFWnM1QXVMREx6c1NUeFJ3MGpu?=
 =?utf-8?B?UkwwaEJia1lON3FTNTRxbnVTOC9sR2V3UklxS0VXRm1ORjRDcUhGVlAvenRR?=
 =?utf-8?B?YXdadTBETnZNOHpGMFpQYzhLYVZCSmNKSlcvRUhJNEZlWDFKL051RHc0RVo1?=
 =?utf-8?B?S2xmZWxhWlhrSzhpTUV5eElPNHlPckIwR2tVRDhGWG03cUFhZnlrUkI2cG5P?=
 =?utf-8?B?eXZBZ0Fodjljd1d6RklnSmkzUHFKV2JBdEdyWUNhUkdhcjNTczNHQ0hvb0Y1?=
 =?utf-8?B?NGJGWXA5ZDc2dCtpK0k5cjJzQm1hN2JhelQ3enBxTFhZbGtoQmR6RUJnZlhx?=
 =?utf-8?B?aFh1RXdscWhvNVJSdG53K0VVSWt1dStuTml3eklBSTZ4VXh3TkQxcHJXb0RH?=
 =?utf-8?B?VEpSeTg4bDlCYzQ5cUdUelhrQzBkaWZyYjRlYlhpTys5bzhWZWxQbzkyR3g2?=
 =?utf-8?Q?H0u+8Yd4DUlZdhDgqFDmBUzO4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a757338-e4fb-4a21-7261-08dd76ae3c2f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:01:26.6044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TGi9QKFSAJqfZoS5no6tKDS4L/cRkJjH6J7N0tqpalzGu4UIyQx/XvfhjluP1taAJYIZsDDbP65vuBLYiBGhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8120



On 08/04/2025 15:25, Markus Elfring wrote:
> …
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
>>> @@ -655,6 +655,8 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
>>>  	}
>>>
>>>  	ns = mlx5_get_flow_namespace(dev, params->ns_type);
>>> +	if (!ns)
>>> +		return ERR_PTR(-EOPNOTSUPP);
>>
>> I suspect the ns_type the caller always sets a valid 'ns_type', so the
>> NULL ptr is not really possible here.
> 
> Is there a need to mark such a check result as “unlikely”?
> 

Please don't. I'm fine with simply adding the check, as
Paolo suggested. When TTC was originally introduced, its
functionality was more limited, and reaching this point in the driver
meant we could be certain the namespace existed. Now that TTC has
become more advanced, adding this check makes sense and I'm okay with
it.

Mark

> Regards,
> Markus
> 


