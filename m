Return-Path: <linux-rdma+bounces-11501-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9636BAE1C4A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 15:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A092188AC94
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D957528B3E2;
	Fri, 20 Jun 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P5PbL1cx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DCB225777;
	Fri, 20 Jun 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426428; cv=fail; b=LYD7jG1wh+7NE0canEo/HLxNqkfG4ypj141OPM7QrQDAUU+sWf/06EaO/UfIX5/LDtu6CqlgWv7zws/6rBqNPTG1PZ2T6M8/HRjsUB6zWS2v2VrgG6ldce4R6/ABI6DNiAaLRngoONOFz7dxbsCPIf0fYRYfJ+zpZ0rMWPr0e3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426428; c=relaxed/simple;
	bh=3CbnkJpQorWkKvAdlEU73vDE5M7IrTfUTM6dC4Ibml0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B2LsieyF/AzAP2RXesnAIuZbrlufr88CHi+pac01VIOn7A2HOeZYxEnDNOyNjc+7GRQtPCpgUajy/8IilP8pTtdnct/Sn4IJw7faYLlVdvk8D7Wi+o7J/SHrieIhdb6SGh63YF7CmtFn9xVGDdFM8d5m/X3dvLf9DXQnt9l7xWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P5PbL1cx; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6JjrX+gb4SDSFA1VaENBZtMI8DlHBgQl4xG/5qAvt7snkPvMSMD15nTsEAmngxz9uR1JaIQNwAM91V7WFBpUIvVbAOI9P0X9QQ4qDDeGyd4gtkSj8HvifmKLzwrQUISOX1As/D/2yyO3hiKcEj+G7FnJyS9Bw1ZV22ZK2WQHzxsYG/mVJV+GwfX8S1p9G5hnNvpBRlMwVncbGE6AhNLcemVUuOE38kr26hJ0y0zVsBhcJM7/482HPW3B4pDC5TKWRwjmsbCXeiRmbN9r0frVvhJeGKw1r10zBTh0no6LKg+zra3CtG+nxZpSvg+6aYRlB4Q2vfDyBxeE4dsxIh2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xygbyzZHae6tydkYniJwhIIk/scOFSSy783gdS074qc=;
 b=OdHd+sQJDpqOcc5QfKaKwUqPhju2Yf9Bc9pEyrmivUozBB8DB0nAtNAVDBEuRaCk0tMhH2nUjzGuYi9Ywn+nf5RC55BHgQfedj455yGtkvtAuo4sdqlVb/81+jcsKZ0eidoVtARJ/Q0ZcgyNcQ/pRF8pIJvh9C09xxd5wYlZMlXNIghQUHyzhUvnz8/tzkCiYTIXDlXuAdWInQuMAbFiXl9KHT0/pDu9g6P62m4GsXXIUNEKKeuYmWIjsS0DBlmihYiVDs+WXbkWEjzIs2yUkjBa74en2bpBeFkvgRNv8m5/mOsw1VPGtw56HN3FRH0rxA/Px42h77ykbUlTdTU6/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xygbyzZHae6tydkYniJwhIIk/scOFSSy783gdS074qc=;
 b=P5PbL1cxc1TdLe+tdqfDPGlPxh3TKxgJ6JSO+m9sY3uBrzx3fWeTRISvZczgCBgVEQOEu4ADT6s3sNBMnoCeL8icaI+SlY2LiAIYkxRhNRf8P1IDihXIdjI2nmzT1xtgoM3l3Uy3HnDg6q6XnHWEpTSRKO8pb/rXPM13hKLjHq7oJaiLWRTLAqXpsC8FvgFVgzYjDZPntd6gKtzkFtffymQX/+PN2k+qNvSxjLSDTah0EORQGA4xyVmMMDaGWwVL9LmtZJX93yJvzvKCYSlrB/UzuEmN55PveFgPXpcSHFX65fsUiz5R5PrW2mi0d9WDWdzSEPUebH9XmmCyo0CQbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 13:33:43 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 13:33:43 +0000
Date: Fri, 20 Jun 2025 13:33:36 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Arnd Bergmann <arnd@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eli Cohen <elic@nvidia.com>, Shay Drory <shayd@nvidia.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, moshe@nvidia.com
Cc: Arnd Bergmann <arnd@arndb.de>, Erez Shitrit <erezsh@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, mbloch@nvidia.com
Subject: Re: [PATCH] [RFC] net/mlx5: don't build with CONFIG_CPUMASK_OFFSTACK
Message-ID: <lumrrt47kax45kmx37jw4w652f6biunsfnlkkthxsebbcfpso6@tuyiykihlisc>
References: <20250620111010.3364606-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620111010.3364606-1-arnd@kernel.org>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: ffff300e-7659-4a84-bda7-08ddafff130a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|27256017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2IxUk9ZSGRleFRPSC9UOUhQbGEwNm8zUmFzTVc2QmZpNUkzYjJOVXNwcU15?=
 =?utf-8?B?eHZBc0FySS9xYUIvWXBXTnRMRkdoN1RaYzJIdjIvSzdTM3padTNZMUFoZ29L?=
 =?utf-8?B?cHBKU0YzTWlueFFkQ3huVDEzWHJLVEpjQ0xFWHVGdUN3RDhtR2Rocjg4Mk1S?=
 =?utf-8?B?aUpCb1ZpWGhQNVp5OGxoQnB5RGE2OTAwVkdtM09neDBJTkVoeEhwSHEzNFQ1?=
 =?utf-8?B?UEhsQ0JPdW1BRmlKbjBkNU9wZENzNXNIZjNkTDZwRjBydjdjS2N5U0dISFRC?=
 =?utf-8?B?MjRhK1lWbWdGWGVMSUpaVnQrNzRHcHdhL2xKYXJMRUhQNGVDNTNVZ3R1UjZJ?=
 =?utf-8?B?UmdiVDhyQjBLY3RHdmttZDVNRGJVMHBpUUh0ZndIR0YzMHl4RCtycHdvemIw?=
 =?utf-8?B?QzZ1eFVwdGlnTlZrN0RWWVBBcWVnOGE0VUI2RytESktoVVB5aU5Nd2NDREcr?=
 =?utf-8?B?NzdzejFRc1ZUY2R3VnJsQWR1S2lUNi9wSm43MC9CeUxWUzR6bndTZG4xVXJm?=
 =?utf-8?B?aElrUlh1R0E5MkMrU2pldHNrYmdmRnMzV3VKcWhpOXdKd0JsQlJsbDFJYlZG?=
 =?utf-8?B?bUpITU9UTVU5TkhhdVNsNmJ0OVR0UzFyM0NlQzY2M0EvSDBUSDI0QnQ0Yyty?=
 =?utf-8?B?R3VSazZ2b29VemFTMThmUm9pTzdVa1dneVV0YStjbFdybzk5ZDBkSE5LU0d2?=
 =?utf-8?B?czFEbklETTJmRlF6NC9nNHJMOWdKVEFobTM3Z2hpYUJ2VWhGNHM0VW9za0hl?=
 =?utf-8?B?RUJBRyt1YWpxTWpSNmpyVXhRVUtSOVVPZEVqMHlOT09oQ0VYK1ZURFQ3MzRD?=
 =?utf-8?B?aU9BRWt6NEpvYjJ0bEIvZFlIUGpyaEhYTk85WTl4cFFOYnFkeVFCT1gwdjlr?=
 =?utf-8?B?K3NDcHdRNEZTWTNCQUZxMjY0QUFLUVNvejVqbUxSM0t4YTVlUkpYc0dTaDY4?=
 =?utf-8?B?d1p4M1YrRjlLSlR6OWxuMk52eFdiRzdxWXNkYWZmQ0UwUkR2d1hIaEJ1dzBX?=
 =?utf-8?B?cHBMeXFkdHBkWU9IUFh6ay9YWGNHSGZaVVJ2M1RvT1BYT1JoeUpjRFE4dlFy?=
 =?utf-8?B?V1IxMjdFdVliMk5WNWNQVy9BV0Z4c1JzUWgrZ0h6Z1F6MzdTSWRYNFFzM1da?=
 =?utf-8?B?Zi9VN0tKTFJMbVJ2Y2k3cmJFYWF0b0t0SXJTTTRMb2s2ZDZrbjFrbU9ySTRG?=
 =?utf-8?B?cjk3dGtrVmEvOC9mMUpYRE1Bdm0wZGhOeGNyK1Bka2dmWkdYKzdLNGtvV0xh?=
 =?utf-8?B?aERaYXNNZitLcy9DRnE2bmN2NEFnK29HZUU5MTFPQnk2TW1Ccks5QklucXVB?=
 =?utf-8?B?UThnYzQ2T2YrOUtVNDY4SUlEaUttS2Q3MXRvVU96VytIVkJ3bjZrTXV4QWpJ?=
 =?utf-8?B?ZFNybVg3TXJSQjU3WnJUaW10OGwzanVQQlQxYTFSN3Fvc2lNRW0zVXpwd3JY?=
 =?utf-8?B?NFJ5Tkd3QXA2cXFiSGIxQWlEWmJzdnp6TFVid3V0M1h5KzRYOGQ3dEp4T0l1?=
 =?utf-8?B?K0JXbXlLTzJBTE82RUpTRjgyNlIzNXgzdk1qNm84QUNlRVIrUVpsYkpuaUJF?=
 =?utf-8?B?dmord0UyVlphWXJKQlVROHQzQndyRk9zNDVwVC9jTXZ2bEUrNUYxMGp1cWVw?=
 =?utf-8?B?M2NiUGRKaXRuSTFBNVFmMTlNMmd0S0hEWkZzSlVjREl0ZTFVeHgyVkwvTXJU?=
 =?utf-8?B?RGM2Nk1aNzBIZEZNdHh3WXpEc2lMMGRPSHBaREcxZFBOdU95OW5pZkJvbEIy?=
 =?utf-8?B?UGU0bFNmWU5vekxKQmRQOGtSNTlPbXRWNDlZSGNhY01wMFB2cEtZRHVRK055?=
 =?utf-8?B?VWJNbERNS2FMUU1DSHBZejVTOEVIdzJjWGlFZ1E0cDg4QUNjUndkTDdUMS9x?=
 =?utf-8?B?aFVCS3BHckNRTFVqcFR3MXRLbEwyYWFBNG8yMU9CWHlrV21wZnYzTFNhMWJk?=
 =?utf-8?B?UVY2YXJGTTVETy9NZW5zWHlZb3k5TEh3Wm8rbnIzV2ZQSXhhRUdBTEZFdndE?=
 =?utf-8?Q?Q3o3lbu9BZmZVAdwiUX/ZgfumWx2OI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ylk2eGN4ZjczZzJZdnBXTktmOFJNVHpaRllMWUV6UmI0VUVXZWpyNTVXNXl1?=
 =?utf-8?B?bjM1SjhFaGRla25qZ1RUS0cvZ3NoU2VzL05MMVpub0E5K05PR3c0UjNuRkdi?=
 =?utf-8?B?TlV2S2tRQnRhVG5LYmZXTnhLaDk3bGtXRXN2QUc4aVRZMFI3RmQwK0RXY2Nu?=
 =?utf-8?B?cTE0YmdqTFR5Y1ZGK0xMRDZkSzNxWE1ydVZqcW83ZVVWVVU4dE5paFdyelRI?=
 =?utf-8?B?bmZYQlZUcGs3WUFjOVVEYmJDdWUwNCtXczhuRFdiNkV3Z0lHOFlGVzRRZkhO?=
 =?utf-8?B?UGRnTTFOSm5IeCtwV3ZyUmUxSHJFbGlSRHNwTlMvSEEvVTBkYnpMdDhtSGIw?=
 =?utf-8?B?ZEFNb24vdHpuOWdoY2Z4SkMzRGJyY2ZWN05KOXFkV3Z6TEI1MXRhcDJQZzlC?=
 =?utf-8?B?VG9sdnJIb2NJM0o4ZVZlTUdEMHhPSFZXNW0yZzBMOGFrTG5KbFhuNVhPcERq?=
 =?utf-8?B?RGhxSjlITVJNbk5jWGsrZm1oVFVmTkUybXRTa3doUU03d1BYNzZCL2drcnV2?=
 =?utf-8?B?UW9HTysxYmxFSTEwUjg3OXNlN2owL0w2eklSSGR3RFBEK3NOVjdENWh2bU9z?=
 =?utf-8?B?WE1ZeFJMVmFoMHNsdVZESk9aNVJNOGwrc2htUjhybnVONE51TGJLYlI1UEkv?=
 =?utf-8?B?TTYxRDdvM2VaYk83eVJGUVpMam1PeHRzdnlaT1ZDc21sSGNmalk2NEdYWGla?=
 =?utf-8?B?TmZKL2tnY0pObFdNdU81YVNKMS9zTGpVVFhxc1RqUC9WM3hqaFp3VkhLN1h3?=
 =?utf-8?B?dmJtNUZkRFFyWVIwNUpYNGdyM0FvOEFOa0x5TTlyRVVZOThDcTE3WlpXZmRH?=
 =?utf-8?B?L2dJaG9nYUFUNS96YVRneWtMOXVYMVNLUGU1L2FlN3luYTdKdmszamxMQjJl?=
 =?utf-8?B?ajk4ODFYUVhpLytqOVlpNXVkZXlPVm5ieWVmRExzTnR0dnlxcTBwRUpwcWFF?=
 =?utf-8?B?eG5pV0NOMEZuaTIrMTBiUlFkYldRWEdMZFJYZCtod1NqbVgrRlcrVGVBWnlY?=
 =?utf-8?B?ZXZSS2JGZW55VlJXYWJpbFN1NDY5dXlJdEo0RUQ1WGUvd01FVHh0cjFrU2JC?=
 =?utf-8?B?cW5XQm9mREpFYy9OK3JncldXeGhRNG5rOE9aYWlvRkdqT3UwYVBkcTErY3hL?=
 =?utf-8?B?amVDbEVvNnJDSzFKTlZWSzcrVXA2RVhTRkxGLzJiQUlocWtieENxdncrWUdZ?=
 =?utf-8?B?WGpkdjRNTHZydWxzT1N5RVFmT2tlSjhLOVVmbFlsTU9obE0yck1tWmV0ZlZD?=
 =?utf-8?B?aENLN3kwZVZwVjF3QkdwYWtJK0ZXWkxSMDhmVzlxa0lsV0hJeUlYYzRrcXVs?=
 =?utf-8?B?NFVqL0VSWkt1VlI1V3BkcGg3U3c2VWR3QXprTmJQODlHUzhFS0o5TnhveTJD?=
 =?utf-8?B?N0ZEa0NZcjFlNFlCaXJseTZKZXFjUU9oSXpxc3BRMjc0K0l2aXNZSlJ3MS9y?=
 =?utf-8?B?RU8zUkVLQ01JTWo1OWMvSGxCNzFRSitpT0U1UHR2VGZDVlhIYVpVSGpQdWVK?=
 =?utf-8?B?U3VsT3pOd0ozSzd5S0JMTDQxRWZUL2dQL1ZDd1F0a3VreHcxVERPTCtJVGNT?=
 =?utf-8?B?eEhqYm9WSzVDaDhCMEZ4Q3RWdmlkODZxc1djdzNWWTRGY3E5NnJHd0kwZ2ts?=
 =?utf-8?B?TWdVT2ltMFFuaDQ4QXFqQzlka3M4eW5VZXpFa2dZenpacitUOFFaTUdjek5F?=
 =?utf-8?B?dGZyWGhreEtISndvNlpDWk1Va0NIZ2xIcVpMNmpiOG5kNlJiL09Yb2JHc3lo?=
 =?utf-8?B?cURRM1VESEk5OEZVR0prMUlwOHdaR2xUOWtCTHlWa1diZHJkMlFVTDBNLzZX?=
 =?utf-8?B?MmQxbkduM0xCQ2tkL3FGQmRtS01zNWZPOEV2ejhrbjVZTU90MXMrdExIeCs3?=
 =?utf-8?B?TnNhREdvT0h5Tzlyb2IvbWdHcG5mNzRxWXU0cHJ6akF4OEZZRW0xVUFjMGV1?=
 =?utf-8?B?RHVnMXVXSm1KZksrcVdUV0ZYamJDejJGa21xK2IzZ0xzcVFhbmNidkNwYkhz?=
 =?utf-8?B?S2ZHemVZdTdHdCtZNDhkdUdpMjNXcHltV3BQNWhrSEg3OGMwODUwakQ2czNj?=
 =?utf-8?B?N3VTRmlzVWcwRTgxM2JQL1g5T2hGNmRpSDZ5bnlDL1BUUU10amZSdDcyeGlD?=
 =?utf-8?Q?yJFJHYANbCW5HKJt57sqvBwIU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffff300e-7659-4a84-bda7-08ddafff130a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 13:33:42.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHK3DLL+Dr9ZkQ6qsdQWZsHwnpQH9oHz4/Z6LCjMZDqDGdEW7fyvHKKm3SKx0zXWu08DzInD8rP9PBXnNXmkZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450

On Fri, Jun 20, 2025 at 01:10:04PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Local cpumask_t variables must be wrapped with alloc_cpumask_var() or
> similar helpers, to allow building with ridiculous values of CONFIG_NR_CPUS:
> 
> drivers/net/ethernet/mellanox/mlx5/core/eq.c: In function ‘comp_irq_request_sf’:
> drivers/net/ethernet/mellanox/mlx5/core/eq.c:897:1: error: the frame size of 8560 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
> drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c: In function ‘mlx5_ctrl_irq_request’:
> drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:494:1: error: the frame size of 8544 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
> drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c: In function ‘mlx5_irq_request_vector’:
> drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:561:1: error: the frame size of 8560 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
> drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c: In function ‘irq_pool_request_irq’:
> drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c:74:1: error: the frame size of 8544 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
> 
> The mlx5 driver used to do this correctly in the past, but was changed
> to use local 'irq_affinity_desc' structures in at least four places,
> which ends up having the mask on the stack again.
> 
> It is not easily possible to use alloc_cpumask_var() again without
> reverting that patch, so work around this by disallowing this drivers
> on kernels that rely on CONFIG_CPUMASK_OFFSTACK.
> 
> Fixes: bbac70c74183 ("net/mlx5: Use newer affinity descriptor")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is probably not a great idea since most enterprise distros do
> enable both CPUMASK_OFFSTACK and MLX5, and any ideas for how to sort
> this out better would be helpful.
> 
> I mainly tried setting CONFIG_NR_CPUS to an unrealistic value for my
> own compile testing, to see which files run into this problem. I have
> managed to come up with better fixes for the other three I found, but
> not this one.
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
Thanks for the catch! We will look into this and provide a proper patch.

Thanks,
Dragos

