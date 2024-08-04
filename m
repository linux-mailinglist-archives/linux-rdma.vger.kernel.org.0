Return-Path: <linux-rdma+bounces-4196-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA0946CC3
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Aug 2024 08:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F8C2817B3
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Aug 2024 06:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2099FD531;
	Sun,  4 Aug 2024 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SpV8CPhO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C177179AE;
	Sun,  4 Aug 2024 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722753416; cv=fail; b=PTxs7Raol6QVC98idozF8UTskS21vCQMS4BHmm8DeXAIyG5CcralaoHSOMqB+sv7lbaMZZAgIn/YOY9wHyVXw+6jINyyuH2noUuiknNfTYr8/UeWFFB7yRDpeo2VXfsUsMYgNRQ+wothn4uy3knLO8lYLp4gMiGfaFuAXqr1/qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722753416; c=relaxed/simple;
	bh=PnqCoAUH82Wwz1ciJSdj+tx8UW9mBZ6JlLc46/Fxb+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UvcxvJcN/RGwKhjjsBRtfF57hpR7JF9fi7oqQqTGP9x1VkM3d6nC7tAAFtgVysB1WEmMbqmCK4zQSj3NsNvsWaT7jcwrsSgTp12styKi4vKo51r1sG36e1Asv46fqJryEJiRQemeKI5mKJEn5X177x5Obx4IBEFFsvcfWwPBSVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SpV8CPhO; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoiEMZ9b1w6vdZBnCpU9iyxGYsNLNIEkhqngHePrDegYTB7HA/JbeS9kiJhNYAgUm8ue9xsRUUQ4uIyBFhwzIYvRnhXFMztL65xFmF0NegldqUJQnR/aGAxcvmi/5CyInDSgl0TABn30Xe6i565bJeovSPMEeDuX7ABD/tAJ5WfFf7ksQeB4tY5EMAsKxKJmt+N/OGd9qg3/835SHN4P1iVpa6KYiKujZ50N+Dk4Law+abwlCwEY7rbkCKpcRaSy9O6zqwFom8vJAO8FtEb05p7hhpBCJXFll7YGUGSpxvxUoksCdYs9pKtVxj5Er7agmR8zNPZmP0QsbpOp/zESag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnqCoAUH82Wwz1ciJSdj+tx8UW9mBZ6JlLc46/Fxb+0=;
 b=c7T5R/49Jrr0s7+WBy4rN77x+Ty/BKQ0Boa6q4MQErWcvGa6rmmO8uxuCs6dLaLrgwVNEAPttVA4KNB3PbV6+JTNBf/lNLZzfDnu4x0FG6fKnSuDZgIyNIAxBuCZ77zdj9Qd8aKa5ZwXHGAhdr6lWWoN51QMl1E/34HExLfYz9UjezkvWxPjDAAkb0T9BZrt9Zj3QsJ6Til5CHXMiZROUZvIUrMS/MyoP6SfGLUaHSkO+vl4csnM4WQPXvJXo79RiyQc1tTmQXRksm+ea07z94+v00taLwcWPJcozEsBW64Yyfg96y+rRNp3dH0HSNfKy4xJF9gFyMo3qXS2XPKYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnqCoAUH82Wwz1ciJSdj+tx8UW9mBZ6JlLc46/Fxb+0=;
 b=SpV8CPhOiDUyoZChI4gVrrvMmWcM4TCo1LBpfbHpEWlSZC0l3KtoyI9bkoUF4CHphxatfZsmVLULKWQB8PP2O7P++RSgyoduOdOoreUX1FohNJI+QdGh4YCfn32IbSHR72Zg6I9Op0Wa62Rs3EuEsrJlSh3+KM2XmmSWFEzX202UpXd9JfWg/o1HDo+/kDY1GBsbnnux1hbU7p/NvQ/zy4IYMfde86EBDV4niMD8fSBC35JNlNyKhf5hlVKvH6fA1QKKGXzDQhBDzyRF3W3opwqhGkeCglfQ22feeddfCSeE069M/pbolm4GOTl/XxEHxWItVDtpWHliswqZGPI67Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Sun, 4 Aug
 2024 06:36:52 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%7]) with mapi id 15.20.7828.023; Sun, 4 Aug 2024
 06:36:52 +0000
Message-ID: <44f99074-0348-4edd-9faa-f095e14afc03@nvidia.com>
Date: Sun, 4 Aug 2024 09:36:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/12] eth: mlx5: allow disabling queues when
 RSS contexts exist
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
 donald.hunter@gmail.com, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com,
 jdamato@fastly.com, saeedm@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-4-kuba@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240803042624.970352-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0051.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::35) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a436c5-c553-49a9-103f-08dcb44fd331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3VkZ0I3THRXSEQweE9Zck5rbXhSZ3VlSG9iVURvWE5VbnFpNFJQaGY3R3A1?=
 =?utf-8?B?M2JuZUJoaCtFN21uMmxkVXNVOTdLZnJYZzdBVWt2N1NIUkg0RHQrY2ZSRGgy?=
 =?utf-8?B?dDRPNktKQzZvbVZlK0VmNDJaWktzdkR2RmNvVUJaNTlEUUd0eldWR1lyc2pV?=
 =?utf-8?B?dXlTMkN6bG1IUHJiUG1sTUlnQXIrWXNsZml2RDNaL2RPaEwzZWF2aTRtQ293?=
 =?utf-8?B?bDgxWG1qMnpMaWN4UUJBQVlWNjFJR2F1TW95Y2QxSnBBLzAxVVVIUzlGR2JE?=
 =?utf-8?B?QTdzZWZhbytwMkUyQUI3RmloQ2doK0s1WnhmRHNkdEFqRkFJeXJoYkdDdVdO?=
 =?utf-8?B?K3NMTUdOY0t4NG9UajNDODAybkJkSFZuZXF0MVRJcnNwL29ETEVkNStOVWJo?=
 =?utf-8?B?UEtBZUQ3L2g3eGJFeUtaT25TV2VwSG9Ud1pyUE83L3o3bzlJYWtKNmJaZHNv?=
 =?utf-8?B?NlVCUHJxM2J0dW1wdUpIS2drbnIrY2NKemp1MmdGVGRpdU1rdEJvZ0dJZEx3?=
 =?utf-8?B?Uk1ZYkg3VUFONU5nSzFQZ2pzaFlwNVJFZlRvdithQXdzajdFWmx1emxyeVFO?=
 =?utf-8?B?WWM5cWNCZ2djc3Zpb29YUERYQzVPV2JXUFdDdzF4UFJCK2RLclhERitBNFNi?=
 =?utf-8?B?Sll5UDNESnNNSVlqellVYUprZ0l2L0FOQTZjay9nVGZPbFdYRGdZZklwR0pY?=
 =?utf-8?B?Y1lDNDYrZUxrSDRuMnJ3RFNxKy9hUWFaNGlRZ2xhWTlHSzlKeHowcFdFQXRP?=
 =?utf-8?B?NUpnM0FZbFNySjI5MG4rN29ObWEwN3hUMGptaFlmcDJhVHVBVEprUGJZV2t3?=
 =?utf-8?B?aC9FVEVaVmlieVJJQTRMdzRBRXowSHVkMGlDVHd5MktIdGErUGhlRGRmMmht?=
 =?utf-8?B?VDM2Q3FpczFxM0V4QW44WE5EWHJ0Y1poOEF1VGVDbEFicVBUVG9tTFBQVzN6?=
 =?utf-8?B?clkvU0gwSHJxMElRV1JLc1ROTm5sTjdhY3pkTDFYeEF5dDBsd1BUSkQxV0dV?=
 =?utf-8?B?L0kzbXBXZWJtN3dFbTgzcm45Tm9rYTZDbDNaVG9XdVViRkV5aGpJeWlyZTFE?=
 =?utf-8?B?WjM0d0hQZTBFY1FjZjZPZzdwT0tSajJOSGpwcXdoT3J6djJoUCt2SFB0bHN2?=
 =?utf-8?B?UjdjZEJZR1MxTkZiWEplYXBTRkp0VTc0NDBGYTJlY1JVT1loL2hwWDFqYWxs?=
 =?utf-8?B?dnpWWEFiMlhiaWpPakZuTDhQV0x5YXh0ek5KU3NINTFZU1JBTDZHNERNdWpB?=
 =?utf-8?B?TzJMcmMrUUF1OXVzMHJmTlJEaHh1Uzd5RkYxSVhpV3NadGNEOU1ZdUlwcGNH?=
 =?utf-8?B?U0FkWEVpTnhZU2tSOU16TTBxR1ZPbXR3cnFnN1ZhRXgzQ1hsMzNBc1pBTk04?=
 =?utf-8?B?Q24ycU5CdCtvNThTM0RZNk1HYi93VG9RdFN3Y0ZGUHJmdEEweXU0NjVEeWJ5?=
 =?utf-8?B?cm0rWXM2MEZGTU9PUFo2T0dZMGdObGhPNEwyQXltNkJtckRpWDdYSWpNRnZJ?=
 =?utf-8?B?L2djU1R3Tm1pZlVGK3pxUlhXY0I5T214WWhkSjB0RzBiNWtrSjhMc1NkeEov?=
 =?utf-8?B?MVoxYWdZTmNibFRRSkVzYXFCWFd5QVU5UjVnM2xySTZabUszdVA0Q1FpR2ZH?=
 =?utf-8?B?elJjbllQN05kdE9BQUdlbm0rdGFrbDkzaTZoVUFGWGlENExXNXFnTXZMSWxp?=
 =?utf-8?B?NnVXeEVIQ0RLQlk4TEdCYjBOcVRlcW5ZdzFNVWhMOTVsTGtDeENSNmRreWgy?=
 =?utf-8?B?dlR5RmN4dHFiYm1ITXBuSWpEclJKKzJuWFhXWTJnei9kUnBKWnRVNVN0VDAz?=
 =?utf-8?B?Z255VjBEQmZMRXBBUjlOUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajV4YldEV2FYUytNbUpTeXlPdTd4U1pGWTlRT1dFMEFRS3BaZENVSGJ0aFVQ?=
 =?utf-8?B?NE1XUHRMZkg5NUhWNXI1K0dsYlBVUmRQekVjdllqeVNwNnlnZjRDZit3VWJD?=
 =?utf-8?B?KzlGWVdkREN5TS9GWkovRTlHcG8zZ3hSYmhFYnRWWUg1bXhIcEg2UUhHcHFH?=
 =?utf-8?B?bEZtVk90bmF5T0wrMHBNVHo1NW5FaVF4SHA5d0VveGNIaVBtMldzcVBtRlhm?=
 =?utf-8?B?djNGT3FVdGFiKzI2N091LzZjWUpFTDl4L0xRclhRTjBKUDQ2N1BzWHJ5T3NU?=
 =?utf-8?B?Z0Z0WWJpVndGSlpreWg3SnQyTDR6aDF5cmI3K2VJV3ZCM08wZkZCbFN0WVlF?=
 =?utf-8?B?RjFya2dNZWFNUkhmWGtvS1JOcUlsKzBWdW52VXI4dEhVKzk0eE9kdzdNS1da?=
 =?utf-8?B?ZUg0NG1GNGNCWG91bmtpRk8zbGxnQUxzWUxHeEkwaU5rS2hleWwwcTdlVHNw?=
 =?utf-8?B?NGd0aHp2MUo4NDdBajJZaGlhZjRGak1neSszVlZMMzRXUE1BQU1UT0pNcWw4?=
 =?utf-8?B?bERwM2o0OStnTEVNaE92OHU4dGcvMFllTENaSzh1VUlWVTZpdi9McDFhdnV0?=
 =?utf-8?B?bU5rMm1lamZIbXFIWWYyQmlMMjZPMDhzZUI0b3FLcGxGR3ZpN1ZpSGFNQy83?=
 =?utf-8?B?Q3ZSL2NpRE1WdTEvbVcxRXBoZDhFYVFNNDNNNFo5bUVlQzdsL3JJeVpQeFlN?=
 =?utf-8?B?NHJwSnJacWxMc2RyZzZjMDR5aHJua21PZVcwVG1Gby9nMWI4UVVYQ3VwUVVu?=
 =?utf-8?B?MjI4VElkNXJ5eWpvTGJsVGlYNU9GNEFEQlRHN0pYdHBBNmpFNHVOdTlob0c3?=
 =?utf-8?B?WnZobHBUamhPRmNFWFR6a1AvQlI5UHM3WGhUdFZoN3hLSytnQUZCVk9QK1Z1?=
 =?utf-8?B?bk5kUFJjem5sbnMzSEhiOVRXQ2YyT0NzUkRWZ002RXJlZVRmOUNoalZVejhS?=
 =?utf-8?B?Mm9SVUpSMDhqRytFQzZEWm5va3RkMml6RlNoL0JFTnJETG9lWHBZNEh5MWdV?=
 =?utf-8?B?TEV3L3UzbitjNVBvQ2t0NkRpU0hyV1ZGSi9JQWJ6ODZOMFEwOVc2U09FV1h4?=
 =?utf-8?B?VGhVV3NSTkluYVQ1dzlhY3NsS2tFUEJDK0pPVTQwTVI0VFFobWdBN3dCZjRo?=
 =?utf-8?B?NEhjQXFsVDBkVXNUZUcrcFNSMFJBeERaNWV2MDBUK0JPd1FDQ0d6cU9DZ202?=
 =?utf-8?B?L1lTeG01dWdkK243eDY0ZEZ6VmMvMTlINGVReTRBbk5XazY5NjFta0J0Q2hr?=
 =?utf-8?B?SFVuUDNBbkxWRmpqWWNEUllnaVh5SFdWd1ZmYWR1VkU5T1BFOEtPcjRIK1Zs?=
 =?utf-8?B?bkRTZGhSQk5mMU9wc0QzUFlxUmtmQWYxdktnRHFsRURESnhUZ2F6Q3ZVSHNz?=
 =?utf-8?B?RUc3d2NLMDBpdmxMV1hJS2xqdUFrcXhTSHdzRHpxTUFkWG1UNDM5blBoTlBm?=
 =?utf-8?B?YmY5ekZ4NlJQS2QreERyanJIYWhRS21nK0krTjlRQllkTGZSSDhXSTBNTUta?=
 =?utf-8?B?bUxMRVVCSFEzd2JWZDlEZnFZOFB3VERqSXdWcmd6eHEwbEJCN3ZVTTB2dWND?=
 =?utf-8?B?dmRJb2ZCeW84SVl3MGVGQzQ3ci9DLzY2SnFnTTJ3ZU5PWFVxSVI2YTRzRHF1?=
 =?utf-8?B?amhVc21paTV1ZUhKdFhnV1ZIZzBMcmNUelYzeHBKbTVYTHlIcWt1QzNGUFlS?=
 =?utf-8?B?bTl5UVFnY2J0SVI5bkFSOEhBb1JZSWo2MmxOZW5GWC9pZ1MyRW11ZHV5ZHZz?=
 =?utf-8?B?QzFHdnNaNi9Ld0lsNnFEM3oxNmdHWmNkWW9McW1kNVVXNWtHZnkyVVpodEtu?=
 =?utf-8?B?a2RPOWlZWFN0OGYweXFmLzFSc1gwWDJ3SFBDcjJySDRpODhjRTRuTmxsVUxT?=
 =?utf-8?B?WXE0Rjh0aThFZGxoQm5HY0RteFB4bTJLaHB1Z1QwOVprSUxXbWJCS2RvaGZu?=
 =?utf-8?B?dDVrVTE3YW9jTFliZnJGTkRXdFl5b21aY0Z5NWxiYlFHaFoxTG9LUkZncUZo?=
 =?utf-8?B?aEx2bWFQK0VPWkdIUEVneDNrUU9WVUx2RmZDNG95SWhmN0JKMHdLeVlYTzY0?=
 =?utf-8?B?K3F2dDI0UEFsSHFNejUrYlRnWktxQ0t5b0YxNlcwcy9zbFgzZnljVVV6QmtY?=
 =?utf-8?Q?TWwQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a436c5-c553-49a9-103f-08dcb44fd331
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2024 06:36:52.1511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qz+w27X8gkcy7nDSDBk6le/3AIyzj5XGpaXZsoHeFj437/dCXjKbf47yf5bnPiiK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428

On 03/08/2024 7:26, Jakub Kicinski wrote:
> Since commit 24ac7e544081 ("ethtool: use the rss context XArray
> in ring deactivation safety-check") core will prevent queues from
> being disabled while being used by additional RSS contexts.
> The safety check is no longer necessary, and core will do a more
> accurate job of only rejecting changes which can actually break
> things.

Very cool, thanks!
Reviewed-by: Gal Pressman <gal@nvidia.com>

