Return-Path: <linux-rdma+bounces-13279-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DF8B5353A
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 16:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B555CA0462B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D908F338F30;
	Thu, 11 Sep 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jgfto7iD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB8320CC8;
	Thu, 11 Sep 2025 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600732; cv=fail; b=lbYdPxKyPAhPsvdlcWHg/JUhjnwrw/DIHIIbfIdOyw+z4lWVZpEkgbBHFnEGSqR0tD581sh7Uq7/QlDRNwmF+JSDKrU9QhvrltkA33kribDiyhLWq/+KpaJr3HvXr5v0OFO/pORgMYc3BL3aeExrw0IxiuG8ABU/WH2/yJnoWRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600732; c=relaxed/simple;
	bh=ycJq26EaGi2KDXoRIGV5/OOQgk0OY8c6xxPteBAUVpU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V64Mm1HYjzqGjZ/FJwsofNrP39NKWT+3yym6nb1B+a4VAT58QfKt8OBa+6O0UtzkRU0vGAu0SBsy4C6iJSAPc270XgwFoUOeB7Edrf+MR6huBZfg2AbMIlFuMrrn/SGt1PfnrX8neu56EmiDd+Jrab5b4knmYoLAA0sVBuADkaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jgfto7iD; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syLgjQ+YB8O/e8jbv1wWRdOyygq6VSiPsAqY3m5A7MjJZ6woWILGW9P8aprhv6HBlpk/uUospmFZiP4YKk6ypQA2TafqTiZlvO/Fxs3Rthzudrym7IqZz2nn1XIMd+U0k0/JRsZLQszSi2VnSQDhBCCbyLsNejZYc4FGqqoGW0/GR5ATXmMGBzYFtmMj1pj/YlqF5xSFUcpMCCdsGByeZFQ2sfPQ2C2ksTwAB/r57pHSpk/xqMFP4vljvvavD1ajB5gzO/4LsQunz0YnHKO02qR9fz6SlxrAWyThCd6zF/CmCJ2rKzxknH5pjXItvOZR9a+7XEEPw0iZ8dS1GMR04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ce/+cXPgCt46MGN+RBOCMkxl16KPrdHGKims5Lm7n0U=;
 b=r3qEiXEBKE/VRfFKevvmKkjDUaZ1xRDC2Y96ODjTpeKZfXsGRQVC7wVSyy9S5OHOnexSBy8XC5Hx1HKiEve8wn4oLoeHnIpCyprSpYxLxnbyf7qUr+eBGrZUF3jH/YkM0gbkwFq1LBPvYkpijd2F4Eeclm/V4jqrIloJ1Q97Y97yKTIVm1Akum57pv+gcjBTRDbvnyhHXwD9+DrWQI2aHxUbn73CUU5Ikhr3UedLjfMDBZrD/iR89AGMPYUpCKbh1seaGCDxr9y/LeALsSNVCi69Zfj/+46xrV34/r4errE48LZP2S/tkIweCjSOLET+cmhwbw0EbT425MxKMhNtuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ce/+cXPgCt46MGN+RBOCMkxl16KPrdHGKims5Lm7n0U=;
 b=Jgfto7iDFW7NZZ6+DjQKjawfRCV2Y5tiO3eybpzkfQJPUkBb8No/BL3A7wOwjGNRfzK5OJKgXzfL8SWAltt65FrgU7luUCZBThWc4zkXW6Rg3hXJFfzCc2dyKMpvSOaPG2R8ZzCNI3U5W2X22PhWj866K8dSD8ecdKRhLRgsSQum48WLgGxs6Czr2WYXhype07nZ8aCUjbng1mDUIS0MhZ5aZTj+d2GoQdXUOa4edknQ1RKhiUYBofelmzFy8NHhkbMuW+7CIy+z9TJaFkcBYSt/9nT/XIrmVzcOGl9qTuvUU50YaPlQmn48g5RI82VP/p3rDjQRHBkYBrmOYWzqOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:25:27 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%2]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:25:27 +0000
Message-ID: <fdd4a537-8fa3-42ae-bfab-80c0dc32a7c2@nvidia.com>
Date: Thu, 11 Sep 2025 17:25:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 10/11] net/mlx5e: Update and set Xon/Xoff upon port
 speed set
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, linux-rdma@vger.kernel.org,
 Alexei Lazar <alazar@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
 <20250825143435.598584-11-mbloch@nvidia.com>
 <20250910170011.70528106@kernel.org> <20250911064732.2234b9fb@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250911064732.2234b9fb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: c8bb77bd-512d-4294-5d0e-08ddf13f0d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmNNejN5VkRSQlRMKzZjeVhiU3BSV2tSaG1hdUd2Tmg1VGxDd2FBd3poMlhJ?=
 =?utf-8?B?RlV1WS91Tm5VbHpjZ0NoWjhRQlREMFVUTjlNUEQwZGp6L3hQL2RjTjdKUzBT?=
 =?utf-8?B?NWZHWjI4eU1WQ0FtQnRReG9sMXRkTXBaWlE0ek4xa1ZGMWoyVmRqako1THlU?=
 =?utf-8?B?UTZkQ1hGL1U1NmFoRlh0enp2Z01rUGxQMndrTjZwbmtGT2M2UnFEazRZMEtE?=
 =?utf-8?B?dUJIYXNrZHJrYUhLWXpESVd0eXhsZ1Fvc3FObEdRLy8yRkl3TDJEYXgwWEhm?=
 =?utf-8?B?WmhzNkp0ZDNFVW1ORC8zeG0zT3hJMWtDZ0RaVXpVMGRacHU3ZWlySjRBTXNG?=
 =?utf-8?B?Yy9WUDhhNktoTEFXdGVxUlJoTlVZK3oya0JrVC9Kc3RwVnMzWmVOY2w5Wklp?=
 =?utf-8?B?eEIwTVVVenNYZThSUzhKYnRVMWNxb2xMa3VNdll2Smh4TERabmZCSit6RnNh?=
 =?utf-8?B?WlVXYXE3bGR5NzM3a1lna01tRU1ZdTJMYmwrZWVoZ1dvVnJxLy9UenJEN2h1?=
 =?utf-8?B?Zi9IWEhCUCt0WVM4Q0xTeXREOUtjYWdSaEoxZ3JEempNQjFZKzBlWHlQd1hX?=
 =?utf-8?B?MHFlTzF3OHBWTE5abkdmVGNUUHhMcldWaGdLbkh6cmpjaTJnSGJwSjZDc08r?=
 =?utf-8?B?elhoVWN6SWdrTVNaRUJKVUk3RldIWGNNSE9ML2F0OUJFYjZGQzhDWDkzTkpQ?=
 =?utf-8?B?TGZrbm5UYTJZckZ0YkN0TU5ia0N0NXZUNUNVamE3QkZYcU5xM0I2VDNoWFM1?=
 =?utf-8?B?K0dsRTZVUkNucUR5eDQ1anpocmdnOGV5RnBnUHFPMEhIekZnRUZUa2R5ZkZG?=
 =?utf-8?B?d2NPMWQydVlRczdFVUpVOEZEWHpYdUMzQjZFYVRUU245T3NRWkkya3BLVUg1?=
 =?utf-8?B?alA1OHY4S1FITmc0dWhHTllqZVlHNlBSTm5mUVRvTVo5bzJqM2JiSUZPcDR5?=
 =?utf-8?B?M3F3N1NsOW14ZVFYcWJ3ZW42SnRkcGhwa2JRRm15OUxGUDFLbkhwSEpDTVhJ?=
 =?utf-8?B?ejZNNmVkNnAvV3c1RnJvMEp2YWsyei9jQnJOQ0htOUx3TjhEcW9VM0FTb2w3?=
 =?utf-8?B?bkpidDFsMm9id2NyUXB3NEVjMUF4Zllwb0YremdaNVJjZTFVTkl1bmNCTW1v?=
 =?utf-8?B?eXg1bEtCTHJ2cHlBcFRtTVRtbjBQaEg3eS9nR2t3RlZjdjdyQS9QcU91dU01?=
 =?utf-8?B?SmJuS2VIcTN4MHA2V01TMU54Yi9MaWtmUStNaWQ4QkNlSmVxTlp0b2JmOWZE?=
 =?utf-8?B?bXh0QjU2T1VpOUpMLytqb0l4OFpOL2tIa3RDV0lla05LU2d0RkpueTJ1aTI2?=
 =?utf-8?B?UDJSTmlGbE1PeER3WnBEZGhlWnVhYUJUU3h0cjM1OEpIejcrVzdGbFJpNFJC?=
 =?utf-8?B?aW8waEpxc0JWOXBIRzBOS2o2KzJld0pud3J3N2NobkdaSWlQUDFiZ3R0SFBJ?=
 =?utf-8?B?eTBoVFlZRmJSS1dDRHB2ZExQWG1rVVJiWkw4dkNRK3lvM3lWazMxckQ1VlNk?=
 =?utf-8?B?bG5Ydk52ZFYxR25pY0dZUG1PaHVSYWhJOXFhSTNxQ3FpN09BZzRtN3Q3Nnhq?=
 =?utf-8?B?NnhQL0QzclplcjRmdUJKRE5oei9vWE9MeUZieUNtbXRpT25YazhUeVVUeXQ5?=
 =?utf-8?B?VVAvNHhReGtNYVNyVy9ZN2JvVVU2Z2xKcUtJNlNsK2pOdlZnazg0WHlzR0J3?=
 =?utf-8?B?VjQyVEEzbTBFQ1k5OTRFVWhRREhKSE16dWRDM1BlVTFLaG13cDdPckpUQ1VN?=
 =?utf-8?B?cWJ5bFhlYkFZd0RVQWZtaUF0VnBVVzBjdlVqSWNLOXFzdEZXT1hMeE1obFpF?=
 =?utf-8?B?SVdlMWNCdkJqZHNJV3h3Nmxqb1FzQ1dnV0QvWHp3cUw4cXRaVFptMzZmNllq?=
 =?utf-8?B?VXgyTVAwd1pPdzFsZTZxWDU5WnZHQ3F1dzJ5dFVBanU4ZkwrR05tck5xZCs5?=
 =?utf-8?Q?1JPSUrJ+0E8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFVJRXpqYjZaUFI2ektPVGhoWldObkU4L09qdzBKcnJVN3ZZY01NdURoK0R1?=
 =?utf-8?B?eWZ0ejZ4TGhxZklHQnA1U1NTSWlKVXFFYXJlU0gwaXZTQW9GL0RTcTNqRnkr?=
 =?utf-8?B?WFZTQUk4S3FUNENhc3YwdFdhdlF5ZVliR2VhREdwRGhiNjFBOU9ySnA2Tk9h?=
 =?utf-8?B?TDNCOUNwYkFLalM0U25oY3BWdVkyOTBucEV5Zm13RjFUL2QxRXk1bWRTNnBK?=
 =?utf-8?B?ZEVBK2l3MStVaDVRTkN6YXAwQzJibTdpQndRWUUvamdUYmwxVzFEZUNqRlR5?=
 =?utf-8?B?WkRxV1hLeVM1eldBTmVLUi85aXZoSFpGaldqUFFua3QwNDRZa1lTK0dGWVp4?=
 =?utf-8?B?MEYzZTNCUjJVRFozTlV5WU4yUHJLSFVHY3pJSktuZTBKQVhCaVd1WEw2Wkx6?=
 =?utf-8?B?azl3d085Ni9XMDRtNU91RXV2NDZtQmJ0RXk2VTJPeGJvRFg5cmphMGxCMUwr?=
 =?utf-8?B?ZVdXTzFsY1JNOEc2NzFLRVpWeFdpSHVyVkpPbHFzWjM1TmFuODhrYTlqQy84?=
 =?utf-8?B?NUE5OGZEYS91V0ZkVHhZL1RLd1NQWTBHVUM0b2FBY2N1V2JOVEpkZzc5UlV1?=
 =?utf-8?B?MlVuQlY2MkpJeHRxcWhXYVUyTDE5TnhHcGdjS25XMmN1N2tndHo3RXhXN1Jj?=
 =?utf-8?B?d1dvMEY1WkJHTWptNUtGYXpoQmwzd1kxR0RBek5OY1c0N0QwMHdQZFM5dHhy?=
 =?utf-8?B?cGY2RlVlSk9RQ3ovbDAzRVE1MmRCakxxR3hqY2JhQ0lQYWpWUVQ2SkZBNCtJ?=
 =?utf-8?B?b2FORkxzZUVQUzY2M2QzTFI5QllhRG84T1NPVXBITmdNa0dmRm1ISllHTVdP?=
 =?utf-8?B?cy9SNnNmRHYzNlZZRmk5YWRQOU50dUFTdDYwVm1yd0FIOGJMRVZadVdQTktE?=
 =?utf-8?B?bmEyY3FMckxvTU4zTDNZY1B4cXJlVlIwK1lnWFpuSHZwWGxETTVTb3dCbERG?=
 =?utf-8?B?d2RBNi9qTDJodVRQU3RYVUM1N2tZakN6cExRTnlES2FBa05zTkpBYVBQeGVj?=
 =?utf-8?B?dTdKd3pnMUIxc1RDVVovK3ZTNnBLS2ludTFnMitneXZLZVRpZ2FDVzdSaTAr?=
 =?utf-8?B?V3Z1LzZiNjY4WUVPcTh0ekYvMEpjeldacXlaeHhmcFZqNkR4cU5RS0tieTE5?=
 =?utf-8?B?Z3hxQjlhQXh4aVdqUVpEUmJxUVllakk3S2RSMXJ6ZzdwOHorZERRcFBHN3Zy?=
 =?utf-8?B?QXgxYm1ZSVRRNzFnVlRLOGRwZ0JNaFlWVVV3WURTaTJGRWlPUm1TVEx0Qk5L?=
 =?utf-8?B?c092dXFtRlBjSGNFdlVFTkNqRXNOWWpDTXh1K25IYnIxSk9JQUllTnA5Zy90?=
 =?utf-8?B?WHhzK01jc0d5Z3N3VEhlcEMxRTZzNmpweENsKzhYa2NaNVRLSlF0dW8vdWFQ?=
 =?utf-8?B?Z2pKRUxsUm1PTnord3lVcFFMOVNyM0VLeVRpVTdkMXp2Rzh0M0xJMGFpWmlX?=
 =?utf-8?B?aFUzS1d5THlhVEQ4K01YWWsvZTJZNVJNcVBHMkFLdWhLR0dxSlA4dkd0OUhr?=
 =?utf-8?B?WWZKMTlhOEZvVTQxRFBZWFJ3cG1mWUxEQmRqNUozeXp3Rm5lWVFUY2w3TG1F?=
 =?utf-8?B?RWNlckhPRnBJTG9MYWtlaDVpejY5dHJQNlRoNHdJTHZxYWhWb2lzcTNpVWc3?=
 =?utf-8?B?aGxIK2NwVXdmVk9kWkx6TU9DR0owUmJ1cmxHVERoWlRXTTZQSlMvYXA2Y2Js?=
 =?utf-8?B?UXFURG1lYVdNVFpReDhzRWZMTEtoMEkwbGk5RThGVm5nQjg1NHowc1hPU2x1?=
 =?utf-8?B?dVJwemU2NjlGSm5DczBVOWR6aHFzMzR0VXkzTmZQcWVROGRjZXRhM2dGOHY0?=
 =?utf-8?B?ODA5RUlXeFNNNlJFQTNuYWVOK0JxUkJIakxGNlhiWVBjNUk0NXZXcktlclg2?=
 =?utf-8?B?Sm4wWnBuZjVLSm4wMDlNem02QzF6RkphVW1xMGdOaCtOTmEvbmcvQ2ZYcjg0?=
 =?utf-8?B?enQzV1RBcVdhVDB2QkZyTGEraHhQRmdEUC9HMHNZa0hhVlNCVHBHTzJQNE9L?=
 =?utf-8?B?L3dkcy9SdzZBK2U5YVNsNG0vR1UyOWlXdm1uSnUzZ3VRNzk2bE5PY3lDNmNi?=
 =?utf-8?B?Ry8vNDVRL2lmcW5RZUREYzJHSGY2SUVqS0xob3pUM1JYTi9KQzBRZW4rSFk5?=
 =?utf-8?Q?Pgo4WO0uyF/tPtl2Sbp4l0RKq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bb77bd-512d-4294-5d0e-08ddf13f0d64
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:25:27.0156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDOr1wI2dcBzjQISP4fbKRVDT5goPcLTpcQbrlUr9bL+DYRwKoiMIDGY84g6FiNl8jnnCyRmu3tfnC2fbq3m6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821



On 11/09/2025 16:47, Jakub Kicinski wrote:
> On Wed, 10 Sep 2025 17:00:11 -0700 Jakub Kicinski wrote:
>> On Mon, 25 Aug 2025 17:34:33 +0300 Mark Bloch wrote:
>>> Xon/Xoff sizes are derived from calculations that include
>>> the port speed.
>>> These settings need to be updated and applied whenever the
>>> port speed is changed.
>>> The port speed is typically set after the physical link goes down
>>> and is negotiated as part of the link-up process between the two
>>> connected interfaces.
>>> Xon/Xoff parameters being updated at the point where the new
>>> negotiated speed is established.  
>>
>> Hi, this is breaking dual host CX7 w/ 28.45.1300 (but I think most
>> older FW versions, too). Looks like the host is not receiving any
>> mcast (ping within a subnet doesn't work because the host receives
>> no ndisc), and most traffic slows down to a trickle.
>> Lost of rx_prio0_buf_discard increments.
>>
>> Please TAL ASAP, this change went to LTS last week.
> 
> Any news on this? I heard that it also breaks DCB/QoS configuration
> on 6.12.45 LTS.

Hi Jakub,

We are looking into this, once we have anything I'll update.
Just to make sure, reverting this is one commit solves the
issue you are seeing?

Mark

