Return-Path: <linux-rdma+bounces-13328-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3CBB55DC8
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 03:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D731C83DF9
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 01:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F81BD9D0;
	Sat, 13 Sep 2025 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SU4U8lIa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344B514658D;
	Sat, 13 Sep 2025 01:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757728347; cv=fail; b=k9gy5C7KjUIk3RalpB4DiSOAbHt097GrAsXuuI5tRMdXWWmkaaTg8/zutnuHJ/JNCv6TvSUj/loxypW7w0Xc9RKpmfnS3SU3ts2biwS/NYA9bE9xbnSlE57MVCfZQZgc/KM4xL4Nmq/QAiM4DKZbtbneKtqo7OrbM9aktnVG+gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757728347; c=relaxed/simple;
	bh=bRZAYDjDvPd9oswb1t+gDdUkXMpZXsMfdro2sz4n3F0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t91iCoglFnd0UBuvOGfDB/MDOZljq/YjO39Z6N5coAANGDJznoAf0Caskq6/17Md/98MsGfU5PpUyAinpyOBIV1TRBmdyaAu3BAdoGsjFQOq/Nl7aP8Z0fcXAIpJBYLpoQLoB8i+MAnmeVhkIs3lximHdfV4D+Y1Wslku3ZVxfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SU4U8lIa; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utr4xs9W23g63Ewk/PXbid9jgXGkGKDLuiMW6Feu5bZrNjDZqatCb2if/cFc4jGhygm8+UtXSBs/AZhEdqLd884THOFyc1Mq9eoXBnWMfBNuNpSYn0pB1wcbtr8YehJRF3GB68ff6u9m/ypoH6xIOjAXf4i7zbvbCRXlqGCxKpWIeEpUCogG856/fiYrVhJjUzZoqbAMZlFkfpE3RuoWfWBJUvh+4LUswJwti5gm4vtFajpmAQGevVO760zJT3qXieP4H4qpx2WEUcvXvUEbblZxODkcwOBM16K6nJBwsv5GChyJAez9G0HvlhA1xDlH+GDk35igBGc+aT4Vc0F+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAD9BBZvDsmYnGuclcPjDffHouxDOObxtK5eu4lGsVU=;
 b=PZgg9ykBccHAOdeYWfOyGHTMgtxIYDYGaoI4ePetHSF/b+xZ5JgFTPfbq1RHYzcTrYijl9i+kQBHPJGKV21q9ZyelM+ecDwaTWbrEGjltVqQo5cojEMa7t6eVcpQ6iDj7JajXQ5DNRVxUMCxJ43NHIegYP3zKdXZNUBXGrJn2Qjngl+5I21xZqmmcVoEGXJuQycOcFimJrvBIxpsxQrobIkI50BvEIwVP6rn6PPbZnQQavky/mRmxlbubhiGl9VcHRAYaZrQOyuRcr9xSeCzM5XbQ3SzaVPGpV5ZT1dqg832SBuF8nHw7awMb/cxQ5FCBXeakVWLTXr8LXRdt5q0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAD9BBZvDsmYnGuclcPjDffHouxDOObxtK5eu4lGsVU=;
 b=SU4U8lIaWnmSlboK8PxMw7cjufwqqP+SPpEUQODKJLvSPAPXTPDI1IVKkVJodbR1eJO6HJx0BP+3SI3XanqdblM2dVSjQHMImGdWuszDBzNl46/3p2tQgviCcBq5WtawV/A1Tvgvpb8aLVGMDv4xado/Yt/xb2b/a6u0gqIUbG2jKFs1+qGkJJcjsM2MTMPyFPAgwhVpZqlnaIBpAXquVdBRFXkn9AgVnVzA9KlGn8Ff3PLLmqESAVbM8UlwQUOI9y914RtoaLJ7G838d4ZpFY37XCNYf7jlLFDz+3wnrz/5MYrAnS3AHxOeZBHUJm2A85herqqdRoekQPgRmDttWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sat, 13 Sep
 2025 01:52:23 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9115.018; Sat, 13 Sep 2025
 01:52:23 +0000
Message-ID: <5af63b6d-8609-4799-83b7-fa3daca390bb@nvidia.com>
Date: Sat, 13 Sep 2025 04:52:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net/mlx5: Lag, add net namespace support
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Shay Drory <shayd@nvidia.com>
References: <1757572267-601785-1-git-send-email-tariqt@nvidia.com>
 <1757572267-601785-5-git-send-email-tariqt@nvidia.com>
 <20250912140902.GC30363@horms.kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250912140902.GC30363@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 78474f2d-8645-470c-2fa6-08ddf2682e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUQwYzRGUTRTdnRXWWJLTHNFMjBXSWJtZkg1V1BvZVVpV2IyMjNpZFFHQXhu?=
 =?utf-8?B?eUZINVE3UWpFODBTOXhBVUFDQkNSVEJvcVVHVXVVREp2OXBrS0k4VTNnaXd0?=
 =?utf-8?B?WUxIR25MNCt5TTdzeExnRVc1RUg1UUlBczNmV2EzTk5uT3J0SVUwSlJCdHRJ?=
 =?utf-8?B?MDRldkRqWmprNTRoMEhOcU14cXJKbXZkY2ZmQ05vc2RZNUJ4dTlUdDl0Zi9B?=
 =?utf-8?B?OWdhbk1HSEYveldoTDA3dk1ZWlJmb3lXbG1TcFpkNktWdkZPSUFrUjFQdzRt?=
 =?utf-8?B?M1FrVVhRZGJwTXNzc1Erc2VLYmNlQTJtTCs5R0s5alR4Vng4VE95cGN1MEpK?=
 =?utf-8?B?cEsydnh1M0V3TmZ3R1Jjak1CdGxpaElqSEY4TStRcHVxQU9MS3d1bUlpMkJY?=
 =?utf-8?B?QzRvQlE1MDg0clRuamNqWDBBWkdsb3kySllLK1hGMldCUHdBckI2ZkM3S2di?=
 =?utf-8?B?cmtoN1FweVBMcGVBM3R5dThqK0U5VVJKVmFYdGVxT05EbUxQYnQvRk8zd2Vs?=
 =?utf-8?B?bkFUVjZQRGFKWEtMRU5kK2Y4clgreXlOMHBSQndCa1Yxb3g2TWlUZm9XVGhP?=
 =?utf-8?B?R3cyZjN2NUtyNUNXWXdGaTBURXAydVB1ZUtjZmVNOGhjSGY4QVRQcVRaV21n?=
 =?utf-8?B?cFdWcG1CcU4zTDFEZ0Q4QWdGZkRkVWpaWEZMem1VekFoK3liQ1ZVb1hxdGdG?=
 =?utf-8?B?QUFqdStQZFVFbXg3R2d0c2tzTFBwTkJ0T0Uxekp3N0tJYXRPTWZkRmxpQ1pm?=
 =?utf-8?B?WW4zeXZxelBSOU1WTXJINjBIdjJhY2MzSk1VUzVnV05VczZudjJhMzJzWkFE?=
 =?utf-8?B?dUVJQlZsRlM3RkVsVXZLVnJ6cG5qR2hMaHdlUXVPVjg3V2hNVzFIbXVUWmkv?=
 =?utf-8?B?QWdBTDdGZDZ6Q0NKSXhpeERmeHRYOThpNnVBWW1XUjQwSGVKSDRQTE1MUUFH?=
 =?utf-8?B?ZDQrOUhqb3hmSGFoQnl0bmd6YmkyNlVWNkowNUdlTTR6T0pSZnZFZTloL2J0?=
 =?utf-8?B?ZnZPcnEvYWZZMlAzbHZmN0xZZXM4QTFXZ3N1aEN1NHJoWlVKN0szZWpvTGdU?=
 =?utf-8?B?MjM3bVVhTndpOXlwSTJLeWVqbUpPSU9oRFNxUUZ4SkxYVi9NaGtXbGdlejdU?=
 =?utf-8?B?U1dLQ3BMcXNFaGh4ZEhtS3Z3TXV4M2xKMWI1TTQzTnl2cDhKMG85VWJaSWJw?=
 =?utf-8?B?bUtCSldnd3JRcFdaTnIvTHZRT1FiWjNTcXVnVUc2OTE5Yzc4VzJHRWxVTWVy?=
 =?utf-8?B?TkZoSFJEd1AvZjlrRzBwbjJKYUh2K2ZsSWpSUWFNUnFBUkQ2UUN5UURrc3V6?=
 =?utf-8?B?SmhDZkJzZ1JKRjJVU0hTN2FlVnFhTmgwRWJBWUpNY1JHSTQyNHJBd0I3TEpN?=
 =?utf-8?B?bFdZNzd4QW1sTnJFN29rczRNSHJrUVdyVHNEMGhaUmdzSmhVb05zdHYyR3Ry?=
 =?utf-8?B?WnRTNGd3NEwyaUNUbXRSWTNtRk01bVhhSkdvS1BQR3l2STh1QmdOZlJZSmFZ?=
 =?utf-8?B?U3YrRlRBUEFmNHlyVTFOTXdKSnNuMXJlMHVqczE5cE5zVzcvM28zbVpUcW5E?=
 =?utf-8?B?VjFJUE4xZ3JrV0tjaXFBTnRTUTYvVjlFeURibVlGOFA5aHNkYndpZ1RHbWxD?=
 =?utf-8?B?ald3UXNsZDVialM2RXBEL1hOZVh4Ukk0STJ1WTQ1b2dzV0llYlJreHN3OSt1?=
 =?utf-8?B?YUFiSzNDU21IZjk2UGtIaWRDelRzbS8vWGxxOGh3R0JINzcyeWlMV2NrY1Zu?=
 =?utf-8?B?ZXVTNmNTUGg4eUVrcy9RdU5GTjhWQ294c1F1WVRLZWpEUjJUeEZqZml5R2gy?=
 =?utf-8?B?ZitYSXp6ekFoaE1oRzVoOUZGbW1zWkhweVNtdG0rZEhuM2J3RnNLaFAwdWFk?=
 =?utf-8?B?N2h2OHVtWlhDQjE4Ry9hN1JNNG5sUWdtYy9JRm1nNS9QM3V6UGlZTDIyOHdh?=
 =?utf-8?Q?WHuzdNgqU68=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajNFYXZ6MUY4MWFiRDNONnBLZnRZUmJZOGhaeTVFcjVDMTJURHB1LzlWZk5E?=
 =?utf-8?B?cUZKL2pFWUlQb0xNTjlWRmdhMUt5T3VuRUFtWmZCREsrMGdYNjhLSmxIalVJ?=
 =?utf-8?B?Ym1UamQzNnRGVUJaeVNrQzMzWmZFZ29aQTc4QzVLWVYxdTczNThvTytTSVk3?=
 =?utf-8?B?Nmgvam9YRG1MTFNpZCtqaGNLQzBRVmZzR1l0S3B2TEM4Z2RRd1NrblljVW45?=
 =?utf-8?B?TUN4Z09RY293Q1ZnQ1p5NFFpdGVSWlpXWi83UjMxS0Z2T1NBNlY5Y3grOTlF?=
 =?utf-8?B?MDZ2Z01HcndyWTRTNFlzaEJibEdRU1pmTkZ6RTl1ZHNWOVI2dWFTeEMxa0VW?=
 =?utf-8?B?OWV2NkpiYms2UndTY2xHbDJJSElRMmEvUWVyWTdrMUwzUGNtRThrak1GU3Fq?=
 =?utf-8?B?NzZ6djUraU5zWnJRRlcyVDZBSmI3eTNKelhXa2VSWjVKY21uOU5IS3cvd0hN?=
 =?utf-8?B?WHdRdWViU042cVo4bmdZYWlXSHZidnNaNW9RT2hHaHREbHB6ZC9lcTFlQU9R?=
 =?utf-8?B?V1NRU1dKMUpQd0pFZm1UQWVjbk1VNG9WRnBxaFNoTGx3cnpEbHd5eU9aUnN3?=
 =?utf-8?B?aXh3elhCclAzcHRiZkhMUDRrcmpReW40bmpmZUJxUUkrSlY3QzlZM0pJVkZs?=
 =?utf-8?B?bXQ4SlFNTG5LUHJkQUVIMzFYU3JIYUkxelJILzQ5WGh6VVp0TnFMeHNPcjdV?=
 =?utf-8?B?RU9FenpYeHVFamw3TTRqZFM1Zy9tRHpFOXNFYWFrL1IveGJDRGJGcjh3Y0pR?=
 =?utf-8?B?YlA2ZVVYM1RGZ3psTUQ5cmhCVzQ5a2tQalk1M2luSVdRWXRTWHVEMTJEcWtZ?=
 =?utf-8?B?T01PbC9QalViekhoWXRpRHVzdGlKeGYrUmN1eGNDbzNsMkt2S2s4TzJYOUcv?=
 =?utf-8?B?UytVaVdCS0I3RS9VTXNhMTZsTXBJSGZKdnJzTVptdE5HOE5Pa09lNTFnMHNN?=
 =?utf-8?B?WFFWTFR1ZFNEVVlsdTN5UHdkUFVYWnp1TU1RT1ErNkhOVGxac3dyMVRIa00v?=
 =?utf-8?B?RFkrRUlvODJ5ejRxZnJGc1pUOWdsa1ViTmw1T1BuTERVbkVRRkd4SXJFbHlB?=
 =?utf-8?B?UXZNbE91SDgrSzNqWGZCd0lOYTh2blc1ZHg4a0twc0FHMllIbGVyMW9YMzZ6?=
 =?utf-8?B?R1ErbjRHcUZEM3hxZDVIendsU3lYWlljSmlEaDNxMXQvSXcvZGlhTjdqdDNr?=
 =?utf-8?B?dEpiVU9qdUlvcVA1S0l4V3JRZk1OaTVsNFpiOHJIQUdSS1FzOG9OQjcvUGNk?=
 =?utf-8?B?cFZwSk8vcFlVc1lPaUlzdURpZWxjUUxQQTBhR3FMYnhHNno3VCtRTUZKTHFK?=
 =?utf-8?B?M2JmT2UxaVZhNnUwS2Erck5uUzl1N2hGSTljbkd1R0RwTjRFZEdESFlPOVRQ?=
 =?utf-8?B?RnAybndqY1hJZDBNMGtmZDRwVEF4STYrSjZlVUhMdDZRNSsxVlo2TEt1Y2dL?=
 =?utf-8?B?aytuVmYxdElvbFV3SHB6dHp3SDZ1WFdRckxNeTl1TGVkOS9lZGg5U0JJanhY?=
 =?utf-8?B?MkFiWUo2c1A4alhCZTlYVkU2RGVFeHg2VFgzdFRPYW1VRTF2QWdWRm9nYStZ?=
 =?utf-8?B?ZGRnUm53VXU1cjJUMlhJTDVydlRTV1poY2c4TnVLc0pLcngwcGZHRjQ1MFRm?=
 =?utf-8?B?cTlicXVlNzFkaEEzZEhmdEswaXEvNWF2RllEOUs0ZjZlZ2VWK0FNeXh6elZ2?=
 =?utf-8?B?UCtsSUNuR2xLeklYRUhnVU9hUTRuZnNZREo2MzBiZFJwdkR4ampwQjNUaEJ4?=
 =?utf-8?B?NUVqc1JQanVxRkJWc0I5RE9SN240SlZPVUx4VnlZUzBlNXRodUI2VjhIWG1N?=
 =?utf-8?B?eWFGMVFEOGt4QzMvMEpjMkFkT3BCRno4MUxUN3BKQURFYWREQUphK2VQQ1pW?=
 =?utf-8?B?UitlRm5ZOTNDN0pmUG5JVC9WNzlNWmd6UTBLUEhES2Iwd1YyTk4wTk1qcnRt?=
 =?utf-8?B?OER1ZFozMXRPNXNpcGRFMFByQU5oSlZPVExtQVhldmFkL21Jd3R2UnB2L1dw?=
 =?utf-8?B?ZFU3Q0ZrNy9FTUdoNXRPRmtIZTFKTWJWeng3ZFBrNHMxaEVWRG1MNW5zWVND?=
 =?utf-8?B?Q2FNK09oL3Bmdkk0bjFDcnRDTHlGVkh5bDRXK3g4T21MZXZXNUZxOXdWalFp?=
 =?utf-8?Q?+UHEQAWsgV+Rie+ZOoZ1Fi9u5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78474f2d-8645-470c-2fa6-08ddf2682e97
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 01:52:23.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+usnFAI3e32GHRLwtzob/MB1ctAX+aDtBj9aNoZrxls7E9mXpNC6w2rt97QGnx1Oc+H3gIZs5iFPgCFPuQ1lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851



On 12/09/2025 17:09, Simon Horman wrote:
> On Thu, Sep 11, 2025 at 09:31:07AM +0300, Tariq Toukan wrote:
>> From: Shay Drory <shayd@nvidia.com>
>>
>> Update the LAG implementation to support net namespace isolation.
>>
>> With recent changes to the devcom framework allowing namespace-aware
>> matching, the LAG layer is updated to register devcom clients with the
>> associated net namespace. This ensures that LAG formation only occurs
>> between mlx5 interfaces that reside in the same namespace.
>>
>> This change ensures that devices in different namespaces do not interfere
>> with each other's LAG setup and behavior. For example, if two PCI PFs are
>> in the same namespace, they are eligible to form a hardware LAG.
>>
>> In addition, reload behavior for LAG is adjusted to handle namespace
>> contexts appropriately.
>>
>> Signed-off-by: Shay Drory <shayd@nvidia.com>
>> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  5 -----
>>  drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 14 +++++++++++---
>>  drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h |  1 +
>>  3 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> index a0b68321355a..bfa44414be82 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> @@ -204,11 +204,6 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
>>  		return 0;
>>  	}
>>  
>> -	if (mlx5_lag_is_active(dev)) {
>> -		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported in Lag mode");
>> -		return -EOPNOTSUPP;
>> -	}
>> -
> 
> Maybe I'm missing something obvious. But I think this could do with
> some further commentary in the commit message. Or perhaps being a separate
> patch.

While one could split this into two patches, first enabling LAG creation
within a namespace, then separately removing the devlink reload restriction
that separation feels artificial.

Both changes are required to deliver complete support for LAG in namespaces
Since removing the reload restriction is a trivial change, it is better
to deliver the entire feature in this single patch.

Will clarify and add this justification to the commit message.

> 
>>  	if (mlx5_core_is_mp_slave(dev)) {
>>  		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported for multi port slave");
>>  		return -EOPNOTSUPP;
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
>> index c2f256bb2bc2..4918eee2b3da 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
>> @@ -67,6 +67,7 @@ struct mlx5_lag {
>>  	struct workqueue_struct   *wq;
>>  	struct delayed_work       bond_work;
>>  	struct notifier_block     nb;
>> +	possible_net_t net;
> 
> nit: inconsistent indentation.

I prefer to avoid vertical alignment. I find that style
is often brittle and makes the code harder to maintain
over time.

Thanks for the review!
Mark

> 
>>  	struct lag_mp             lag_mp;
>>  	struct mlx5_lag_port_sel  port_sel;
>>  	/* Protect lag fields/state changes */
>> -- 
>> 2.31.1
>>
>>


