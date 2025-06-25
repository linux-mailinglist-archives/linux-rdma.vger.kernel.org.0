Return-Path: <linux-rdma+bounces-11632-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BC4AE86DF
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0238C18905FD
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA964269CE6;
	Wed, 25 Jun 2025 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q2k0CE4v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF826981C;
	Wed, 25 Jun 2025 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862592; cv=fail; b=KrS1Le//mIjQau5+qauTZr8RCfjhIWzBrbcbr6RsWv5rMqn2TEeed8QCDHQK9TAy87/Z14dk5dSCoIMLT3saiGvEAXRBYsm+DxSiTj3DX7F9IgTAaMvd6Ks/8MPpVVhN7QCN974HcpPunWwc8trGbWUiDDkv5ZP/G5GAf7klVV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862592; c=relaxed/simple;
	bh=UBcOAexD8GU2u011BXyevYiRFhUg2baWzAWBJEhQFQ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qcODFfafOl5kIdaGVTGn6gXs8s7Ld0gd4TpeqptHxphiiEVHIR5/QoHN+e3zTE4qyYr591yD6NYi3d5nVH5ugaKUbtVi4bis9wqlm4Lw+mI/YCaQC7rNdgN+jl854HYYjxNYD+eGIWxc1MVE/oLLVN82fdryqLWXeZjc23wPm9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q2k0CE4v; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C72Y/wfbNuObHE3zE3T5NUCF6x2gtdV3pvLID+xps/Cvp8FKhLpmpvYu7gCj01W5/5tPZhtXby5az/2glYQsU1k8NaOrTDfiU1kgYECjRZU4fbIDb17lxM2GevYcTH4CB37yz1ZjYW95hE0ObUVtFiW2geooRfkTN3v7tyJLLehL9fWLixawEC1VJrH5+qDMjCVuPWcoTU/Knu1KXrq96n9sa9YCp2az9q0jHEE4RpU+b+V9zkIeSOHcKxhETpSshVr3JsOn8m+qpwnPNVe2HzK7txlqTaJ0rZAYjZoNB9wVSf+p9u9iI0cVHEwjMiilZbOnxR73Ty8Q03XsLEU5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDGLYaw/hFf8VNRieJ4PjG45QEHKCCONCeQLlY5mcXE=;
 b=FyHSn62JBjDUmtGKpuPzZ6dy+jCveAwLDfAvO0a7zXVvu+3XeQ6EYFBCyNlvifmZCWp8VqYUx0v1wmOhbHkMWFxZf236l2P4BukzV0ssKwFZt4g4rGT3TgESdn3padwqNnzSW8bdQEviBhj2D3F3L8wxPdK+OllappQNGebh0EXqSVmuayY+HmCrtYI208uJ2s6g8/EByRgOVrC3L3saDsxXH+lNsipF4Lam/WCZ2eHLJtwWEj3LI362tNOQqQD9cT2Do1WegZLJCazRYbujxFU7PsWTXSNnYfLfdLUTfShHmnO9UYsHKhlAJEjpEWsP4IS1tfP8panyD5bdR6cxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDGLYaw/hFf8VNRieJ4PjG45QEHKCCONCeQLlY5mcXE=;
 b=q2k0CE4v6vlE0fYrh+IauWfgHIomn5CDOL6W81d7HdbwAzRqzLw1iAVbdTf6ixn4YUKwDR99iRxpUi/XzdCGQ6S/eRqPEszBFRzGqRZNWl3A/XOxr1b+uYqvOxmvWtDpdBDEZ9ncCnRAtxSiBf3FpDAP2xyWsLOdA7Sk63MpPz/seVbeP1Q7QI7jvQoxLyyMTUB5zYlEB+V2cQT1kEydif8Kc0TC3NHlR0PaTwAtLSV6xbmASkji+q8JeY86n+D9kYaYD3MVp9C3lWZPJCOdzIuUeth2XWDRXRnb0632D8CFwDWsXop2b4SHFeRaiXSEWakNzP6n4JBMHyXuO1B/iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 14:43:06 +0000
Received: from IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43]) by IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:43:06 +0000
Message-ID: <594a3f22-57c6-4f97-9464-40ed0e3fcec9@nvidia.com>
Date: Wed, 25 Jun 2025 17:42:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/8] net/mlx5: HWS, Shrink empty matchers
To: Jakub Kicinski <kuba@kernel.org>, Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, saeedm@nvidia.com, gal@nvidia.com,
 leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, moshe@nvidia.com,
 Vlad Dogaru <vdogaru@nvidia.com>
References: <20250622172226.4174-1-mbloch@nvidia.com>
 <20250622172226.4174-8-mbloch@nvidia.com>
 <20250624170809.2aac2c69@kernel.org>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <20250624170809.2aac2c69@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To IA0PR12MB7722.namprd12.prod.outlook.com
 (2603:10b6:208:432::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7722:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aba6edf-440d-48c2-e8c2-08ddb3f698d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEJNSTMzMDQ1aW1MZ2lSYzdCS1hRcU9HbGgyelBXWUtHSTVUS0VFKzgxVnBH?=
 =?utf-8?B?QnNCK0hsSkxtaGV4N2JadWJOSDVuWG1Dc29EZHN2eERaaTUzL29ZUGlYNXpp?=
 =?utf-8?B?NGZtU3d3NTIzbG9neUlUS0ppT0k4b3lFSGxKM1VmVVo0NUVhV3ZCc0w2dGFz?=
 =?utf-8?B?UDc4UzhBbWZTekN2TThKdWZqY2p3WGNHY0pTb2tQZEJ2S2NaeDlSYmVmZ3Rn?=
 =?utf-8?B?VUhZMWl0L1FaSkdmUEoxcW90MW1jSXIzb2FJUktTNzdCTERlNGZ4NGNsVlMz?=
 =?utf-8?B?UmdWazRVWU5vSkN5VFlmSmoreFRVLzlNNjBYd0pET0NIdWx2UTErcFpxMmZv?=
 =?utf-8?B?SUpVck5OWDVrS281TExOQzdMS1RuR2t3V0JXU0FuTU9laUM5Q2ZFOTYwSlRr?=
 =?utf-8?B?N2xGekRIUnZsUEJib25vR2hPV3lOTUR1VW1MaFhGM0M3djlBcjlzb2xaV3Fn?=
 =?utf-8?B?QnhDZWxLQ1BPemdPUnpPNm9Ua0xob29KcTJMbWZ4dWlsMVNFcGJtTzI5UjE3?=
 =?utf-8?B?cy9UQnRKVFJ2YzlNc0k3TDk2M016SzB1dUpEc2FOTVlPamNiZDVvVFphc1dj?=
 =?utf-8?B?bm5IUUhEc1praTdTYXA3UnEvNVNUbkRLTkFvVG1RcER5bXdrNFVSdlF0bUMx?=
 =?utf-8?B?dkh6eFIxWGc0ZE40YittendXeHpXTWFScFlEL2hOc2IybHRuRzg0dFpCb1lo?=
 =?utf-8?B?YldIVTRSTXJ1OWJnNE91NlJTN0E1eU4yd045VkZuOWhXaWlpMnRSNlRqTHRU?=
 =?utf-8?B?Sm5jaTlRTWZzM0RVd3FqU1ZFVHdhckFhaXlDT2ViK0FOQ2pCc0ZiUTdsWTZ1?=
 =?utf-8?B?R0YwNThWVDREZWFGRlFQenVCeXR5cGk1czhPaWw3M3Vya010V3BSekJnbDQz?=
 =?utf-8?B?RitRM0FHdjgraUh2MWVmZ3k2U0o4T01vY1ZXVnJyKzVvS3BNeGZRdldCWTZ0?=
 =?utf-8?B?aGFERW1MMElXeVJnaVVhTk1DYlhEUnUwRzB4NGl3bEhBaXZnd3RwRXdFSzQ4?=
 =?utf-8?B?NTZnMW5iNVIwcEpoOHVOeHFudlJFRTVNVTR4Nm9kTDdZZDNEZ1FUMU52SW9q?=
 =?utf-8?B?aitsU2dXcEloTmlLTjNZd0Vsejg0bVhUZGQyZEIvWFNtZW1rbEJnQnZhVVh3?=
 =?utf-8?B?enhWNkpnOU1FYUdqSFNRVUJldzE3SUZ1enRabG51NjZPNVBiQ0tEQkVQdEdX?=
 =?utf-8?B?VkZWTkd6QTAvcmdyWisxd0NXeE9YdXhBYk13QjBlVkNhTU9rdFhJN21tTTdp?=
 =?utf-8?B?ODQxdXZPWXdNb2lMdHhkKzcvb21oeUJaeG5WQWxUaDQyaGV6OEhiQy9QaHE4?=
 =?utf-8?B?cmd0WXdORzBqWFBacTI3SXFXYzZXU3VLSmU1UnBYc0VleHpxZG9RQkl0cis2?=
 =?utf-8?B?Y3h4bGp5NHBkUGxBbHNmd0ZnY0lRTjY4OHkwMFJRbTBFaFhOVWtXSXY5aWI0?=
 =?utf-8?B?M1BaZ1FHVDFEUlFGN0NJd1IrMDlBRmtvYytPSGt2K1QyK1ZyRHZhZmhJeEQ2?=
 =?utf-8?B?T09zVUFlUzFCdFRHS25LSDI2dmFXd2Z2TVdmeXlzS29sL3E2TVRhWU1XUzUx?=
 =?utf-8?B?cDlzLzNVUG5xZndDUGFjeVFHNUtnS002RkorczM2YUZyMWxPWERTMDc2ZUdW?=
 =?utf-8?B?SUxTSkxvOGJmQTdkZG5raGlIMWZ1SXZjMzd3VVdyakRmVWNsSVhWTGlHeHU5?=
 =?utf-8?B?cW55ZVBTc1o1ODNLQzJ0TE1oWEYySnB6QjdhT3B0dG9LVEIzSHoxeS9ISjJ1?=
 =?utf-8?B?WXp1czNJTzZZRGJMNVliSjJMOTB1d2NBZVdMd0Q3S0M2dm1YMmUzZ1ZGOG1C?=
 =?utf-8?B?eXpsTGgzYlhDcVhXV3A4d2pNQW1qMy9iam93bExKWlcwcHord1orWEVwWXp1?=
 =?utf-8?B?VGN4T2tURjNuS0cyUVVWd3dnQ2Z5RnVseWRlMFhNNmdQT0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7722.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTh3enlNT0RNVDdKcWJkRkFrK1JxMm8vY1F3bnR4ak9BRUk5YlBNTnBBMUVN?=
 =?utf-8?B?cyt3L1Y3bFlGNi9VM3lrem5pRDNIWVErN2V2bHM5WDJNM2JYTFc2M1hZZzUz?=
 =?utf-8?B?Ym5HZjU3QzNHRzYwdStaWVc0Vk1XRFZrRitTRFZORldqcTNiZ2tKWDU1QTZQ?=
 =?utf-8?B?NVo5L2FnWC9LTCtLQ1Y0YmJKV1hVR29MNEpvQXJxWjcvRGltZDdYa2RBTkt2?=
 =?utf-8?B?QlNnNTRydyswVWhNcDkxYnFjNkptblMrQmpoNS8yOGtjMm9kSmVESFhhd3JC?=
 =?utf-8?B?d2NWMi9GRkNNMGluM3ZoOUpUYW9oOStRZUowdE5MWXA4aVk2SFlvM2V1NEVQ?=
 =?utf-8?B?ejhNcStHeHhCK0JJc3g3eTYvQlEvdS9nRENQRjh2alZKY2t4QnFKb3k3cWZj?=
 =?utf-8?B?enpkSWRmd00vc0RWTkpVbC9XY2NGRk1jZTJCbjh1Y1BYSDY2RmZXbmpiZzNy?=
 =?utf-8?B?dVcrU2lxek9mZUlnaXBFSU1wNmNGRVJVV080RS9QZk5RamdBY2NlRzRaSENR?=
 =?utf-8?B?UGw4RXpxbHlnSlZmaTVCWU5DcnR1WHoySXBIL3NiRktEVldzVEtLSEUvYkhQ?=
 =?utf-8?B?eXY3VUpvZ3pGY0J6eWJ6YnNsK2xUU3VIWWRtME1pdllOSHhEMUlrZVpTT3By?=
 =?utf-8?B?R0hJdXJuL3FZYzdjZGx6bXQrSW10WDViUDAxUzcwU1RWNVM3cmxvSHlvN0RW?=
 =?utf-8?B?WGcvcXdUNjBiZlFDWjA2eVgxdGtIOHRSMTc5eGVRRVJ6Mk1CV1l2NTJGOC9R?=
 =?utf-8?B?WFFoTVpLK2kwaktvSDZqOUpNTmZjTTdaOVlTK21YaVlFMjI3NVRSZzAzWlk4?=
 =?utf-8?B?MkJBc041cnQ0RTRDTjBPNU9UbXlDVUR6N1BkN01jM1dHT0pnbVZockd1MWdF?=
 =?utf-8?B?L0NxOHpVeElTYXpRaCt0YU1LMWw5K09Lc0VpUU1IVGg3cTNOOGFaZWhYcEt1?=
 =?utf-8?B?V2IzOTdjcVcydEk1NC9tVmpYdllMOHJKcUpPaytiZHJRY1lwQSs5dmtiSk96?=
 =?utf-8?B?bHJNQ2puWVk5bm9qZmFJY3FvckRGYS9PVHZ0U2JRWHVvZi9vV3VIZWxBRSsy?=
 =?utf-8?B?c2FZRFdHZlFsNWFvY0Z1blNNOTM5dTZFemJRT2k4aVQ1dXZrc1h4Ry9SNkhY?=
 =?utf-8?B?cjdOYk8yWHNYZVdlNDlOV3hMdVlTYUJmWEdYM012eWptbmF4Q2lZeE9PMzJR?=
 =?utf-8?B?cUFseDBRaWdxZzRuSitBVGJueHZzcWtiVjRTbFBIc1JrNzVBbFNuTkExTXM4?=
 =?utf-8?B?ZHVSUktPWUEzeGlPcmhlUThzWmFOVThkZ3FyajBYR3BLK0MySm42clZPc2dS?=
 =?utf-8?B?eHRXelZVZmk1d0I0LzBDNC8vVlBUZ2VwZEtJQjBnTDhMcHpkSGZPbnlZSFA5?=
 =?utf-8?B?REEvMUNjWThoUXd4QzdCQWl2SFUwOGt3YXZxMFdlbHZ0bFpBWmU2RWd0ZW93?=
 =?utf-8?B?WHBVbFdOK3ROMjEzRGdpN0g3T1JtTjE2R2ZFYXZ2TXlRZi9yRFRhcEtXYmw5?=
 =?utf-8?B?N202R3VTR2hQUk12eitHR3BIOWN2K2dhc2JicUc3bGhHdEJZUXRiSjVzV0tZ?=
 =?utf-8?B?UzhTTm50OHNjYWtQSmgxNVNZWGRCaFVkbnlLQkdlNVB6YzkvQ2hIRldEcGht?=
 =?utf-8?B?RThXYlV4KzViWk1mNkZOQ00zdkt3Y2taYzVyRGtKQXZyQzVyR2ZDekZjM0RQ?=
 =?utf-8?B?bERRRFlGa25WclFpdEpaTTF3dmZ6aUxQOWR0RWpOcHQxaGpIc1FiQUd1N1Qv?=
 =?utf-8?B?cEFkY1pIWHYrYWJTSEZqdG9ibm9iU3JPRzc1ZGZlRnZVRXd2R0hWbHltbDlP?=
 =?utf-8?B?R2psdGVSNWhOd2hUQi9GYzZMSUNVd3hMTnRVOURybnMrSjN0bk5VVVZqbjYv?=
 =?utf-8?B?T080bitWYmlETUl4cEVSMFpwLzdQZXlScmU2d29hckZqMmFSdWNCdjRmMHFF?=
 =?utf-8?B?NThpbWYrSWpIVlpmeVB1OHZQU28yVXY5TGpkbHZ6UE43Zy9ROWw3QkwxNkZT?=
 =?utf-8?B?N0VGVUl1Tml5TWI1bXJhcXM1ZDZ2L3NrWFZ3NXhxL3ROenQvQXU0bHRyQ2tV?=
 =?utf-8?B?U1d1Qm5DMUpkSDFCa05MS1lLWVZsRW9TSlIyZWMybE84dUgzd0xjL2JrK2NQ?=
 =?utf-8?Q?e8N2UhupESEiRRlr4G7r+JJAo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aba6edf-440d-48c2-e8c2-08ddb3f698d8
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7722.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 14:43:06.6829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYtzRO0HMqKhv1UjKD8450WbnxKJrBgFKjfFsGHk1XqNrTHVYfghHyRqplSBGfFY/8YTHMAWyOZutERsM057gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928


On 25-Jun-25 03:08, Jakub Kicinski wrote:
> On Sun, 22 Jun 2025 20:22:25 +0300 Mark Bloch wrote:
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
>> index 0a7903cf75e8..b7098c7d2112 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
>> @@ -3,6 +3,8 @@
>>   
>>   #include "internal.h"
>>   
>> +static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher);
> 
> Is there a circular dependency? Normally we recommend that people
> reorder code rather that add forward declarations.

Sure, I can rearrange the code. It would, however, mean moving a lot
of code... I think I'll do it in a separate refactoring patch before
this functional one.

>> +static int hws_bwc_rule_cnt_dec_with_shrink(struct mlx5hws_bwc_rule *bwc_rule,
>> +					    u16 bwc_queue_idx)
>> +{
>> +	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
>> +	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
>> +	struct mutex *queue_lock; /* Protect the queue */
>> +	int ret;
>> +
>> +	hws_bwc_rule_cnt_dec(bwc_rule);
>> +
>> +	if (atomic_read(&bwc_matcher->rx_size.num_of_rules) ||
>> +	    atomic_read(&bwc_matcher->tx_size.num_of_rules))
>> +		return 0;
>> +
>> +	/* Matcher has no more rules - shrink it to save ICM. */
>> +
>> +	queue_lock = hws_bwc_get_queue_lock(ctx, bwc_queue_idx);
>> +	mutex_unlock(queue_lock);
>> +
>> +	hws_bwc_lock_all_queues(ctx);
>> +	ret = hws_bwc_matcher_rehash_shrink(bwc_matcher);
>> +	hws_bwc_unlock_all_queues(ctx);
>> +
>> +	mutex_lock(queue_lock);
> 
> Dropping and re-taking caller-held locks is a bad code smell.
> Please refactor - presumably you want some portion of the condition
> to be under the lock with the dec? return true / false based on that.
> let the caller drop the lock and do the shrink if true was returned
> (directly or with another helper)

There are multiple queues that can function in parallel. Each rule
selects a random queue and immediately locks it. All the further
processing of this rule is done when this lock is held.
Sometimes there is need to do operation that requires full ownership
of the matcher. That is, this rule has to be the only rule that is
being processed. In such case, all the locks should be acquired,
which means that we're facing the 'dining philosophers' scenario.
All the locks should be acquired in the same order: the lock is
freed, and then all the locks are acquired in an orderly manner.
To have all this logic in the same function that acquires the first
lock would mean really complicating the code and breaking the simple
logical flow of the functions.

Thanks for the review!

