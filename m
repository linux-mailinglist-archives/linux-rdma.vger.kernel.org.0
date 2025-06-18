Return-Path: <linux-rdma+bounces-11435-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB5FADF6EB
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 21:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F47A7A527A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 19:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FEB212FA2;
	Wed, 18 Jun 2025 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aAM3bikB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B71207A0B;
	Wed, 18 Jun 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275332; cv=fail; b=u0AimsLsR/gCb7PpTMV00zA3feDSqozKZQNEQuM7XJSiJBUWT/Pz91cnw8X/UaSXxDo+26RbE4CIOPMeGfpIFvRvaDNjpDgYS9NE9Jamdsb3tcbGSCobd8I8ABn50LfLGPvxndTgL+Glh+NpgYNfdEc1LFjQAVkhFEP/5K3IgcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275332; c=relaxed/simple;
	bh=BbrmQLXXCQos8CQWqEhA/xpgtBeoiCUdcp3ZYMmRrkw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c/8qPf5IXp6j8Nt0GbHkh6zAtJTVVA1EqkSsBohckzYmSCdPgLOwjAkO5i27vnKa+mZxvCH72roipZJDA196/f5IcHMt19b1fwrnnvB3iMcoaCbCZj179uoVsSH9pRDnQ/fnQIXBlHUj8mQCDIyXnQWAEtd46jZfiH+k+s9HzdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aAM3bikB; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcyVjJ2ZGwdjFrR4Z27RCCuyHgnMA8RGrtCdkc5L5aJ6BVEBcYtOkM1TbjcdZzUP0slJwGSf3DIlXk9/fuNHHmDA8xq5fCvEwp4F4Sdq9Hg6lA1z1G85uZeGLQrLP9B7IB4nOUaoVLY+xesTqtfR6Ka9T5jVXGHn9oWlLdxMcW8DtppZwiHhSreWv96CmRKEGQDO2z9ODoPhSKD25gJsi1UNZsiFyE0FUO87iwwRnzTmYzYWLrXQ3bdXtfESJIesPxIHSLIIG1LxPQ1lJRojqiP0ID/dxJouZOtt1X6pymzaV8dNRFuqm8RoBJ2gpx5UccpSLv4WrZ71t5oj0KJDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnZKur2gArgrZgO2ExSiV5sk+L6eDlYNfJZGgiU+yko=;
 b=a05AuDm81MkXqZ6F3FEv51akrHl0QXWUVJwqVNzLdGBMSMNj+gBB+eH7y6QrxvZS3Kb6W7CSqGlyWEujKQkabGnUiemVT5wj5CtSJ8zyMbMSe2hB7rLeeQY82/E4mhuOz+KaVtedCzbxBf2E/M3vv8Y4X1zXq3WeEOkKhb9kAmr78oP14XI7EEFWJzieLsvlwDhOljlj3CwmXq8dunFmB7IznTXQJS/FeYtQ20nqhZb/52Nfv1UhVZc//MYUcoIE/ZdsDJmZ/RCQIHqFf21Q6c9mU3Cfnun4x/w53Uo9w1RB67SAyYyG8HpwgURMUIeh9IBpN5VfN6nSqy0u9JEuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnZKur2gArgrZgO2ExSiV5sk+L6eDlYNfJZGgiU+yko=;
 b=aAM3bikBTFQHuDXPbjNqYugcp4s/n2B/ZdNQBwKrFax23Mfmw07kpw1xVlo028XHpsQjmZ2CUeOCOoUNkVcWyNYMTAoEgcf/rkDkpqVKiLyWhD0l5npfe0V6YTjReRSUPoWVk2Rnmog7G8B2WE/IAyDyu91x4NeTyu5CgJqih3U6y5Q23VbFDf2lVx7aXUnS/7xsLXw3HlAbHCXif9dnj5mx/EKYVca3Mb2ndLd+K83MS1jLakf31DOpKg2hY7vMcwV9LVu5+zVQ9kMUDQVm26ASmzaL0V7q47bL4P7cOJi2f7q7G/BbW58M/X8VFqtjuXSWrHzYuK4GnGneG0j5TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 19:35:28 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8835.032; Wed, 18 Jun 2025
 19:35:27 +0000
Message-ID: <4f115511-5739-416d-a687-6b25a21fdd56@nvidia.com>
Date: Wed, 18 Jun 2025 22:35:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net] net/mlx5: Avoid NULL dereference in dest_is_valid
To: Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mark Bloch <markb@mellanox.com>, Paul Blakey <paulb@mellanox.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250618-mlx5-dest-v1-1-db983334259a@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250618-mlx5-dest-v1-1-db983334259a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: a339ba93-a7ee-4d3e-66e1-08ddae9f472c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWJNMThTTkY0OVd4dUJJZEtzSUY5N0ZlcWorakEyWTI1VkphWVVCK21OWUdu?=
 =?utf-8?B?ejlZTUJMSWJ2NmlTN2RGUW51bmo4QnBadzJ1MTRZdy8xaVZneVBUY1gwYnh2?=
 =?utf-8?B?WFFxNTBUSWlIOWFzZ2VqeUxjVlZtRzZseEYrZnk1ZTRCNG1oQXhlY1hwdGFt?=
 =?utf-8?B?U3c5T0FuT2NOQlN5M0pyK1huRmVzZjl0b3JhdkVLTVV6Mi83U0hoWVpFdWEr?=
 =?utf-8?B?ZlZQZ2FzdFc0aVhpRk0zcGplR0JhSmhmUDNPeFVWd016a0hITjU1NjVuUWg4?=
 =?utf-8?B?YVBsd3Z4V1Z4ZTRJbmJjenVsOE1RUHF4bGlaYm5yYlVnY1ljRGhhbDBiVW4z?=
 =?utf-8?B?SUtBWVNYV1prYjBoajlERml3T2NCU2ZpYnRKalBOdS91V0Z4UlNucGg3cVpk?=
 =?utf-8?B?UWdINlJLYnhvOUdEN1NsSEJnU1RwazRkRG1sRWRDcXZsU2FBTVVNRGdyVldM?=
 =?utf-8?B?NGtPZk1UMU9Mc29lM1BlemxxbFFCdm8wZGRhWnRYSktaTlA2cG9mbjNzKzNP?=
 =?utf-8?B?b0Y2SFJidFhmaUhWdnFmeFRvQzVGMXR3d0pwOEEvMDJPaDQxMSsyUWlpVEFY?=
 =?utf-8?B?SE1PSkhMM21iVVNYa1UrNmtCcGorSXExMndYODlmMUlsM0FlNkxFWVpZdVNG?=
 =?utf-8?B?ZjFmSU5EOElsU293VllJcXFMYnNOWThGNU43bzZXNGZkVnB1MWxkNjQyblFM?=
 =?utf-8?B?b1Bxdm5XZ2tNejVQdlg0SnVqT1VDRGdNYXdaODRCc0pZOUNPTUpHeEZUNmZo?=
 =?utf-8?B?Y1pxU1E1WGJWSkNkbG5YK3ZBOXdQQzNRUVV6aUFsZEc4U200RXVKWVpmSzE1?=
 =?utf-8?B?U09NQjdpbEF0MzRWamFuVjY1T0JWQklhbmpvaXR3NkIvbGsxYVNiYkVLbUpC?=
 =?utf-8?B?TWdyRzRIdHppK1A2UVNSSTYyODZmeGRyeVJlOU9kTnFsb0tid21GbmRLVU1k?=
 =?utf-8?B?dktLQWcreWxaU0tNaVFGQnhWM3hTbkJuaWtYSHVRUmRRWXp0MTkyNldXRzZI?=
 =?utf-8?B?THNpQStMSkxRbGNvcmtjUW5NS3lsVGV2ZmswOTFjREc0aFhEbzRRNFlFZllv?=
 =?utf-8?B?QWVvQk5rU0Mva2hNM2J4OHc4eTJyOWlwUm9IdjltOG92d3FwenEwQnZna3lT?=
 =?utf-8?B?ZC9BSGtBMTFsVXgvV1BsK2NIelVxWkgwNlBGdy8vNmY4QnNrcnQxZ0x3UW5J?=
 =?utf-8?B?UFJ2eWJXMmVHNlRldDdjQlA2am9nbDNLcHJUeGlJbDFldDFSWnJUanBibDIy?=
 =?utf-8?B?TGlCZ2xWOGV3Nmp3ejNMU2tGUFVpTUsxbnFnbnJlZHd0VXF5YXl0cG5raGg5?=
 =?utf-8?B?WkdhbGpYOG44ekQzOXFwa0xTWldwSXhsb0tKd3NudS9LSitLWTg4UnlzdGhX?=
 =?utf-8?B?VDZmeUV0ajlpaVNhVnlWWXpjZjJtK0d4STRXYWVzL3ZKbE1QZEZ2ak11dmNJ?=
 =?utf-8?B?SGI2QlA4TDhKV2hibmR3eTRHUmsyUlpYai9FN0Z2d3dGdkcxVFB3bXV6VDBN?=
 =?utf-8?B?M3p5K0p4eWlXTVdrUEttbTJzYWVjN1VSNThEbkNISS9pazhYTEZ4dlhJa1Av?=
 =?utf-8?B?MldZT1NzbWNFT3k0Y3NpY0xUTEtsamNITlB6Tmt2QWxaSW0zN1RpMjg0QzBY?=
 =?utf-8?B?NEo0Tm9JUTZsZTBwOWVwSGU2d2pEQU1YTDB0Y3pLSmsyYWdZTHRPc0dqbkpk?=
 =?utf-8?B?eXVVd1FMMmFXZUQwUVc3N3hRbEJ5MVF5Mm9yOVlUaVlDclBhaE9KazNlSENV?=
 =?utf-8?B?T0p5SVFYcDd5TlFuUWxiZjFXR2dXOUxBUU1kVGJ2SnJMelNocWMvMDIxd1Ra?=
 =?utf-8?B?b0hPSmE2Y1NYMGFDK1ZXYXVBNFV0eE8rclhISG5UUXlJeFVlQmFMZkxBYStn?=
 =?utf-8?B?Zk55aDQvVzF0Vm45Rk05SGo3dzREeUpxRkpLSDJXVWpCUGpPdDBLOWFtVG0v?=
 =?utf-8?Q?K8VkfYplU6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU15dmczVmgwM0U2SndVME1EcWdodUIwMmdJelBzaWdETGc3SDd1QTB3Mko1?=
 =?utf-8?B?U2lZR3UrV0g1dWR3Qm5yT2gvaXZMZlFyaEtycC8xdHBoTVdSamhpVUUxSFFX?=
 =?utf-8?B?RUJOT2ZoQlNua0R4QW1HSUVCeUtCanBjalVnOTBOd0t3cTNkbCtzbWwrYVFG?=
 =?utf-8?B?WWk5Q0UvVVI2UVBTS1E4VHB6K2VUL0FCVVo4ZFlMd24xSEliaG45c0p6NUhv?=
 =?utf-8?B?NXgzTVJsRHFzMUV3UGsvVFQxdFd5cEVKYjRrK1MxN1NleW1hNThyVlpiTUhN?=
 =?utf-8?B?S1ZLWWVDOHRwdFhlU0lRNzBQUmFnNlR3OHJGSlVuYmRacjZZSk1vSTlHRmNs?=
 =?utf-8?B?am5MemJHUEtzSkdpMzRmdURoTWVnZk9rdFlmbWhwR3R0aURjdjV6eHV1ODdT?=
 =?utf-8?B?MUszYjFvT29EbGl2VE1saW1LRU85d2NHQmpBSVRlVlZDbVI0d0RqZWpZbmVV?=
 =?utf-8?B?aXZjWGhNVDNETndKanJ6cmFTRWhaZXZ3T2UyeGYzU1VYT3Zxcy9GNDk5cGZQ?=
 =?utf-8?B?RDRWbnlGa0l0ajB0RklEUmNEUWIzN3FQSnJPVlNUd3ZDbHErcXh0dklRY09a?=
 =?utf-8?B?V2c3S1NEaTNRb0FTcFl4dm9JaFVtRmR2bC9UeEJmamhhZVpsaVYxVnBRNmMv?=
 =?utf-8?B?QUFIeTBoQk1OVlQvcldlazE0L3hMdHFwK1RSVHRvMnkrOHQ3b0tQY2puY3lj?=
 =?utf-8?B?SXhxN0paSGRzVzFxNUJNOVBsRHFlMHRqYTd2OTJGMWFSWHZaREcya0R5WWhG?=
 =?utf-8?B?VFIzRUlVeEJjTDRJZnpuS1pnb2VJbzFOMHhjNGliRlpKUmp0QjZGaXlnTkF2?=
 =?utf-8?B?UXB0ZEVwYXdHQlUvZnRmaG9DUTV6eVJzb25LRnRTUnhDTFlpWC82elQySVZO?=
 =?utf-8?B?czJ3M2NBaVVSb0JWRVB0RERUY3U2MzlvZzk3ZnJkdmM5ZHY5Ukdibjc0UGhQ?=
 =?utf-8?B?dU9ITWl0alpyTFVjOWc2OTkwYWx6c0plVm5mb0pWdHFFc1E5aUFtcmZoY0lh?=
 =?utf-8?B?cmdWb21jUzlWcllQK1VkMEtQSms5bytwVnRZaElNNXVLbi9qRnRiRHZ5ZFRl?=
 =?utf-8?B?VXdOQUdnbk9BbmVPWDljRk5wekl1OXJTYktzNlp5V2s3S1RKTUhSaW1xOWNU?=
 =?utf-8?B?dEIrSG5TZ2ViaXNMMzJ3bVN5YnBHamtJc3dSREt0WTU0WUlyUE9WOHZaM3pP?=
 =?utf-8?B?Q0VFT2JYeEJYMnkvLzkrcE5HdlNaUG1lTVI2Mzd0ZGRZSGVRdE5xQUlNcXRv?=
 =?utf-8?B?RTRkSXUvVitqMU9kN0VxcVFURDJMTVY5SWMvcFI0T2xSTXhGdEpYVGZoOWI4?=
 =?utf-8?B?N3ZWRXF5WUx0NnpKS1RDWGltcG5qUzFGL3hXa1RYRHY5NnkrbkFiU3libWN3?=
 =?utf-8?B?bXVYeGFPUm16b3F6NVhSeDFjMzJmSitnY1RwcklhMzkxOFplK1NOcGIyMHdS?=
 =?utf-8?B?TjM5V01XaTdjM0JTc3k5SlR0OTlneGJ4a0lnK2txMnQvQ3hYc2RoQjBRM0xK?=
 =?utf-8?B?d2dMTTlvTkNjSmJGYXplR3gvZ3g0VlQ1V3IrMW1hNy81a1RwTVlpWVEwd3NX?=
 =?utf-8?B?TE5kcFN2bU4yUGp2T0RMQUlKRDRkeW4rdmJMcU9jbnZGNjBlWXlDVnNUN1NJ?=
 =?utf-8?B?QTdiUTVIQWlsNnROa2NYRjY5ZDREdi9sWXlLbXBBZFBTUnNzNXZBRXAzWnVU?=
 =?utf-8?B?YTZwdHRpd2tWaGM1V05yZVpBZ3VRUGZxck5WOGpvbmt3a1EraUhHclZ2b1JQ?=
 =?utf-8?B?TDZLTytBaEdOb0RRVjVMdS85SC8rVjYrNHNCaEpvaUFRdnQwWnpzSmcvbHVX?=
 =?utf-8?B?TDFjMmJiNXlpWjA3N0pSNTY3aGtLOTNTOVRBdFczU1pNNWtXTlNKWGV6cDU5?=
 =?utf-8?B?N2RnN2ZXQThqRmxPSkE3YjBIeGFYaWVXMVJFRFB6VzJmdXEvQ0F6eDRGMUF5?=
 =?utf-8?B?OW1uZTk2cmRzSktxWDdFUWhINC9ZUWloSkRuaTltdE1NdzJuN1V3cXJMQXgz?=
 =?utf-8?B?ejZ4S1h3SThKVWtRZG11cEVHbzg5RDYwcXg2SHpwQkhxa0hTMVMyQzRiZE5w?=
 =?utf-8?B?Qi8xVEZLTW5lVnFoRFNtL2pVK0VXRGdkMmZZZnBsWGM5UjZmbXZmYjJtR3lu?=
 =?utf-8?Q?8rP3LGGx/uPqa+8mfVAy+/4gp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a339ba93-a7ee-4d3e-66e1-08ddae9f472c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 19:35:27.6858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2PhSKaoajYfAuSUDRmuAtkO3gANnzpAOKv6VzbJU5ITzGxkz45QWELyMXYAD0ab3/gV6gIV+z5bWQYpXqEYtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144



On 18/06/2025 21:27, Simon Horman wrote:
> Elsewhere in dest_is_valid it is assumed that dest may be NULL.
> But the line updated by this patch dereferences dest unconditionally.
> This seems to be inconsistent.
> 
> Flagged by Smatch.
> Compile tested only.
> 
> Fixes: ff189b435682 ("net/mlx5: Add ignore level support fwd to table rules")
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
> I am posting this as an RFC as I am not completely sure this change is
> necessary. F.e. an invariant that I'm unaware of may preclude dest
> from being NULL in this case.

_mlx5_add_flow_rules() does:
        for (i = 0; i < dest_num; i++) {
                if (!dest_is_valid(&dest[i], flow_act, ft))
                        return ERR_PTR(-EINVAL);
        }

so indeed dest must be valid inside dest_is_valid().\
No defensive programming for this as all the callers are part of mlx5
driver and they shouldn't pass dest_num that doesn't match how many
dests are passed.

If anything I would drop the other checks for dest inside that function.
I'll add that to my TODO list.

Thanks!


> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> index a8046200d376..7eeab93a1aa9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> @@ -2041,7 +2041,8 @@ static bool dest_is_valid(struct mlx5_flow_destination *dest,
>  		    ft->type != FS_FT_NIC_TX)
>  			return false;
>  
> -		if (dest->type == MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE &&
> +		if (dest &&
> +		    dest->type == MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE &&
>  		    ft->type != dest->ft->type)
>  			return false;
>  	}
> 


