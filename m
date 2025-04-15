Return-Path: <linux-rdma+bounces-9449-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58228A89FE0
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 15:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 647577A2675
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E532314D2BB;
	Tue, 15 Apr 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CblIPFpG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF1313AA53;
	Tue, 15 Apr 2025 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724815; cv=fail; b=mYa25frI+0PtfffMpca/uUZ0CYLFibCKmzDYySlvFHF10JZKTiNJPwAgnEDwSDHwcNwAnCKdNfK3OEnnOgO+d3Uh6M3Wm1YlhMXXIz8eQc+oAqVlR1qJGy4rwWJKZinouPmhY3tQHzz7POINY1plbY88j084lYt7tjBDZiaU9Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724815; c=relaxed/simple;
	bh=6E+OhTBKUgMZDmVsTdz7h5SEph9MetdOLZuCclt0mNs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sQF/ZU/9bF5l6O18+vbXE6pv0BCLLQ7Bhq+S9GvxWkBHIldq2bzWCh5acjR2H/jgoqGnFpHFsWPf+ED3I8baygJo7b0Gky1IKQy35H+NXcRlVQ/5MeooXVrangoUZ4gJXf3kBE4h+N7rlWcTHiPVYrTLENWm98TPX1RJ2DPzrhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CblIPFpG; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMXk5CGIeKl9vCd4SynkO7GiRIVUnMuyvTWBYy7s+XoXnO66f4fk3sY89zOsD8y2IqMx4iTqEDcxPbMqO5YzcEqGuOIwZ29GTwMUDY8cp4IQpKyuo4JsmSn1naLzN60WPQNxN/tVIxESgiea+s6SyhHKvk/pXCGOM6XrClj6Mg4OqPE1m9YD36mYKsfs3g6X8YAevMWIzfTLbHoz9rbu+m4340KTTJgcjzh10kJ5Pw1FszvCR/E/oWqvStFjeZSjmfDtYnT0vht6WCvGix7/kEd89ZPV8LOo4gOK0XPEZQRPsCEWau/kEDXrufveo1D2fqIyOFvAQGF4HMdqJRDC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FBENBDQh5J5yKZL+0a+aLbCVe1gbwE4me27edZy4iI=;
 b=KNBsWA3Y7WxMJxVaqQoZsmoSmbZGfygjMcNrS6NasQgYQzlGLg9UWVc5f/+uU0/OaZ24g4KqjPNAjwSD/0KFCaex2I5t6G+o+VmsHmJMb8YKdLQPlN28DtYnACjIqJqrnZa15j9QmH7r7V/LYM7cGb3icFV/UXQYSYoaciO238s5UoWllxR6Xoj5jqcmkFHAiX6BEcTY2s4+s8afVCyRdpH0qAgnViGDw4f7ruaZlvWsxekTfdwzWkFSNhLcneNydX2sX+FIdsDZ1rNEtOILaeU7KWsW0tdG0qJDF9eHWFkG1gL4Db5NX7pd4nd3qhhPQ0RFmKKzU1BzAgBxwc0JAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FBENBDQh5J5yKZL+0a+aLbCVe1gbwE4me27edZy4iI=;
 b=CblIPFpGmNz1MCvfwfN5OBxDZ07dFMCuJiUaO8SlTK8Loz12PjloCl4eQdnnJTh6EcwQJzmJDZvI6D7NG00qGjduLj0N/cMM4ic6irfiQaMucoY1F1QOEw/pMtmdsKgs2o4jro9XYbdSPtmvWJcC+NDw2RzPnJKfItIusqMLyG6/5qjSj/FqbUmajuvBWwpUy0TKFmMO4+lEwbuspVC2sdcchuL/wFV+xxmxwbjCW6Cv+/yeOTCyC62AiYCJrD8TMC3fadeVPDl9Iy11bKUdIRq0GzD9aaCfO0J7EAInckgbKs/6qnHmt1HGUZj6R36bGSHP1v1fMN+h0977BWUawA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.38; Tue, 15 Apr
 2025 13:46:51 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 13:46:51 +0000
Message-ID: <c0125e86-79f7-4217-832e-44249cae16dd@nvidia.com>
Date: Tue, 15 Apr 2025 16:46:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] net/mlx5: Fix memory leak in error path of ttc
 creation
To: Henry Martin <bsdhenrymartin@gmail.com>, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, amirtz@nvidia.com, ayal@nvidia.com
References: <20250415124128.59198-1-bsdhenrymartin@gmail.com>
 <20250415124128.59198-3-bsdhenrymartin@gmail.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250415124128.59198-3-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::12) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4b0e6c-7050-438f-b578-08dd7c23f999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dk9YVjNlY0Q3dGdFZUFCNFVyelBid0x5RnZrYVMyMjNCcnR5a0hSSGU3S05D?=
 =?utf-8?B?aG1CUE5ZS2NHQjgrWjRQNFhoNXdnZU8yUGhudzVSa2FEbXp0cUk4RzBteDdN?=
 =?utf-8?B?bitIUFJOSFZEVmFVNjRKRzBCVklNQms3YXV6K0ZqbURpSXBITDl2UUJEcS9l?=
 =?utf-8?B?MFlpQ2Vwa0srZXFJTElUZk14SHc0NjBNWnhLd3MyTU10T1JJazNMdHRUTGhN?=
 =?utf-8?B?dXFRQjBhdW55S0IrSnJWUEdleGUxbjVhWWxFN2NkQ2Rkd1JWVTZVeks5YjRX?=
 =?utf-8?B?Ri8vZzVCZncrQWk4MDZ1L1Rva05Sd0pYMGFnTmlPV1BneTBOMDI0WE5NVjNl?=
 =?utf-8?B?RjN6YjhWZE9mRGZ2SHdQZFUrZWYrNVduQStJZTZsQ1BmQUNWQk5QQ092ZFQ4?=
 =?utf-8?B?elUzdGlkbE5hNDRoL0Uvc28rQUpuTXFQdUYyMFh0aCtIRW5VUGhJODJRNGZ1?=
 =?utf-8?B?blFRaXV1eHA5TXFPVWdYclZOYmZYUHpuS01TYmtialdnZ0xrRnU2QUpsbWty?=
 =?utf-8?B?Y0Y3bFR1RS9WRXl0QjFvbS9wYnZSMFo2OEREUkVja216NFZWN0lUNXFOUkRT?=
 =?utf-8?B?MWxCQXZXdGloS2t6ZlMyM2o1WFhpRjNnd01MVWp4d3huaE1CM3ZzT3dVanZZ?=
 =?utf-8?B?QW9Qa1NKL2lleVdaYTc4dkI3UXIrYmFBeGtVV1Z4eitReXNidGdrdlU0dDlk?=
 =?utf-8?B?ODRJZzVVTzE4Q2ZwQnUxb3dsMVoxbjg0b0tqNFo3WkkyVVVzTmorajdxZWFJ?=
 =?utf-8?B?NXJLSVBpVTVOZHMzRW94SWhIN1hjcDNZRTZVdENxQ3NvNkZzb25KUVpSZ3hr?=
 =?utf-8?B?bStWQXlMRmM4WngybEcreEZ6ckxScnU3ZHlTeW9TRjRMaFJPbWVkaW5lQ2dv?=
 =?utf-8?B?dGJkUWM3UEhDV2h1NWtSVE16anpUZllKZWhjN25KMjNPN3h2WUZJZWg4TFV3?=
 =?utf-8?B?SFphUzZUTzNVWGFVMHlWcU9ldmJBNUU5L2hsZnRkSjFIelI5WU80T1JNSk1W?=
 =?utf-8?B?UFlzZjNJbzN2cGI4czYrSUVvZSttdjdtK0F5R0dWeU9mK0N0NWt3QWFZZExH?=
 =?utf-8?B?U1JkenFSTGdHb09RdktqOHlNRG5ac0ZBYlY2d3B0SnEzKzV5cmNraFJySFUv?=
 =?utf-8?B?UW94bExablQzZmJBb1U1T2s4MExVb2ZHMjBtY2cyMG1ldGdVak1wYzh6cjl3?=
 =?utf-8?B?VHl1K3dxUTFhNFo1a1hoUWw5MlFFc2tBcXNIS3MyVHQ0cmFpVDQ0VnkxSnkz?=
 =?utf-8?B?eU5XOGFFUklQcXZoZzdiTUNqU2huTkZVZGtVbXB3U3VaSUYvdXMzb0QwaVNy?=
 =?utf-8?B?NUNORCtrcjlSM29Lbmh3OTF4SVFtRFF1MEh2RjBlRE01c2t5YmRLWTZJM2xo?=
 =?utf-8?B?MXpGVVBkTGdLdWxRY2RrRXBsUjRGTjJSR0NGR3FjVHM4bDFXdG1XNUNGbGto?=
 =?utf-8?B?SWZPeTlXUXJrTXNsQVVFcFJwNVZTYkltRjFvaVhEQUM5QUd1bzR5RGlaSElG?=
 =?utf-8?B?M0ZzRkpuSWZUemllTXNLQXBDT04yeHFHdWxQY3UrcTVySUJKZGF5NzVNc0ZW?=
 =?utf-8?B?YlA5aUt0MWc4YjJ1NVZXTjhRVVQ4Y3RheVZvOFZ4Z1g1TDNMVEpyQW12dHFa?=
 =?utf-8?B?SUFBdUY0K2VTWEVLcUhRQlhFK1ZXTmFxZXhBazVucHgyZEN4V0ZaSXoxYm9G?=
 =?utf-8?B?ZG1PWG03WVVkQlNNU25tamRSRWhrV1hFTjZHbzJ1dUtuOTl0aVo0NEY5Z083?=
 =?utf-8?B?TVk5NVR4c1lPTE5tNjVzWHR1T0hseVlJTldwM1hKbGlMR2xieFg0aVhhOVNk?=
 =?utf-8?B?MmY4VlMrTkdlaHRydThqRVpSMWUvL3Fwc2xtamFRbDZtdml5OHRMZk5EdTBK?=
 =?utf-8?B?aFhoL3JLT0U3ZkZXaWVzcXJTTks5M2Y3TWdWczZJZTQ1LzNHZGY1ODNPTGRh?=
 =?utf-8?Q?vTs3Xts5V5M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXI1SzJxR3VnWE01U2Q0NDVaZkFYZHoxU3JlVExyaUFGRzc2OU5IU0ExMzZI?=
 =?utf-8?B?S0NKVjFxTFJhK1NReW5RankzWDNZeHhSSXVITVRTbGNybGZZcFUwaFFRWUo1?=
 =?utf-8?B?VHdORGc2bHE5aUlEUUpoUGNjT2dRNllNVHpWcnh0RFZuYk03Sy8zOC9XMmo0?=
 =?utf-8?B?Nk1UdzJTUXdhMjJiNEpoYlJsRVJEeGNuUjhiRmp3REhNQkZYZGxnQkZiTXBR?=
 =?utf-8?B?NjdyMm9kMDJYQmJLMFYrQ2NqVE1lNHY5SEEvRFVmM3NoMklmSENGM0ppdjBT?=
 =?utf-8?B?OUhCdDR3Mmdibnh4a09XMmFxeDFsRlAraXdvdVlHQ1I0OTRSSElnUmZBZDl0?=
 =?utf-8?B?cTc0Zk9jaFNoZFYwbi9JM3VaRTVRbDdMTDJDQjdjR2VnVlUrVTQ5REorcTl0?=
 =?utf-8?B?aitkWDdRbXEzcHFQVUcxUFUvc0JFbGZqeVhadzJ4L090WUJCTVl4TXo2d0s5?=
 =?utf-8?B?S0M3dXNTQW9INUgzWmgzdWNVTVVqc3J5dVBydkp0dVppRDlPaDQ4aTJUTnAx?=
 =?utf-8?B?V1lCTkg4cjRvc21iRDE2ZlN4SWFaUHNPVVlwejR1U3lUSXdPQUFyclZEUTRx?=
 =?utf-8?B?M3I4K2docldwOGVpWlhxTkVzblJMclBBSnVNeUNjbG1kRkV2U0hLdkN0bUZE?=
 =?utf-8?B?ckkrdWFLRndRYmN3ZHpsUytLZEFEQjVTemIvT0Z3VUxjNjZvVlFDbklMK0t3?=
 =?utf-8?B?ZXprUVNRU3RyM0FRd1FSWG5CQjBpZmdDWDFiU0xGaVU0aVNqK3BHSXZYTjUr?=
 =?utf-8?B?bStudnliN1NXR2pUOSt4S3FmZHMzTzQ0QjczbkJxQUJqRFUzSkx0WmlUV3ho?=
 =?utf-8?B?NnhReFpEeFhBWkxUMEh2Nk1ydE5weTlDMVRuWEsrR05vNjdWTk45NUU2Z3Fj?=
 =?utf-8?B?TlNsSEw0L3JSNHpycno4c3ovRW12ZGw1aDBiaFdUMjRTQURRQmdWSktsWndG?=
 =?utf-8?B?SkxhK2FCcGR1UWJDZ0p4T3N4amZEb3E4VW5ibkNmMzcrbVdDYkNEZjhxRStM?=
 =?utf-8?B?TEx2M1kvd0phaFhVOGFzZEtKSzBoQlZmeVBaTVk4eTE4WW1idjNPdG1uNkpO?=
 =?utf-8?B?UmRUTWdjWEdCcFRZdzUvRjU0RXlnWXM3MU16U01SYzRaamwxMEtxdm1GejIy?=
 =?utf-8?B?YTRSWVFTV3Rqb0FtNWUxOUxqbzlSQnpwZjBzTlV4dkhaRnZLQmNuQVJoaEd4?=
 =?utf-8?B?S1lnbURsY0NncVVWK0NVd0t5dmdhUkIzakkzOTF4WCtxZW4vMVUyWEJCRjBR?=
 =?utf-8?B?VGlZbXlLNXRta3QwaWlkSUpFc2s4ZFVwdThkeXZENjBmMERjR24rMFFlQ1dm?=
 =?utf-8?B?bTI0VkNUdEZVZ283TDNQZVRDc1JsM2dZSVE2cndTbURjcGlFdkhaSkF1RlBM?=
 =?utf-8?B?M3ZoblRpN0R3MUVPMG5HaUs5MWJMRDJBN3JFdTBxZ1U3OVQwVW0rblRRQUVC?=
 =?utf-8?B?TC96Wmtzd3hSUS9IZTYxRjZMZTMxQlYxV1RPQlM5OW8yY3NiQ1hGMWlGaHA4?=
 =?utf-8?B?c1ZNSnVlaldXYUtnODltRjdpd2FkRGhCcmZFd1k2RnRqM2pVMXZNdGtEem5R?=
 =?utf-8?B?MzZiM3FHa1NXNXJCTU03N1ZSV1V0VVAremtKL0swcVV5ZnpDSU9WUDNGY0E2?=
 =?utf-8?B?d0FHS3lHaU1sbjd6ZDVuQkZqZ2IyWHlpUjcyUHhKVFlJdWd4Z2tzV09UeWtm?=
 =?utf-8?B?R0k3bW12SExXMkpVZDNIalJSaTFpOHpnaWtGajZkbVgvZ2VqeURXR04vS3VG?=
 =?utf-8?B?VDdSR2EybWR5Y3lscHZHNStwalpLZ25xd2UxZ21PLzdDNzZ0V3piazAwTTM0?=
 =?utf-8?B?SkxVd3cwUzRwODlpUXBIZkdBcStnQm40SkoxRHJKb3ZzYVlkMzRtcWN2UWRa?=
 =?utf-8?B?NlprK2FKYVJKN3RwYkhGWEloczlzR1pHZW1sSGlYV1ZoUWlobGVXQlBwWUUy?=
 =?utf-8?B?YjdpeVF1dnQ5cjBmOU0vU01rYUVBWm1rOFFYR3NQK1lJckFETWkzaE15Q3Iw?=
 =?utf-8?B?ZzJrdUdHc2cxWGdCM0hDMHdvajlyT2MwZWtpbnVOSTJUZG5iSktRcWJKMzAw?=
 =?utf-8?B?MlZQTTZieTJCSzdpbmZMc2RSd0xQYmpQdDVxTUNYcjhWYldaK25Kbk40bEov?=
 =?utf-8?Q?g1a3KlRZk0y4Rwye6IpodeRGT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4b0e6c-7050-438f-b578-08dd7c23f999
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 13:46:51.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ae9xsFzY1hy83//zs2SGpXNW/snK7Hcqh/4vQuEz8sWl0rnnxYFf0LACG9UhxBGChcLzxcq9kz29vj0hfsThhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596



On 15/04/2025 15:41, Henry Martin wrote:
> Free ttc table memory when unsupported ttc_type is passed, to avoid
> memory leak on the default error path in mlx5_create_inner_ttc_table()
> and mlx5_create_ttc_table().
> 
> Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_table")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> index e48afd620d7e..077fe908bf86 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> @@ -651,6 +651,7 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
>  			MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(dev, inner_l4_type);
>  		break;
>  	default:
> +		kvfree(ttc);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> @@ -729,6 +730,7 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
>  			MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(dev, outer_l4_type);
>  		break;
>  	default:
> +		kvfree(ttc);
>  		return ERR_PTR(-EINVAL);
>  	}
>  

What about just moving the ttc allocation after the switch case?

Mark


