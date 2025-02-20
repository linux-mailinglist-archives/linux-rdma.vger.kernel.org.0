Return-Path: <linux-rdma+bounces-7928-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF33A3E878
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 00:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7D17020FB
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 23:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD860267718;
	Thu, 20 Feb 2025 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YSGYN26p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A2E2641C3;
	Thu, 20 Feb 2025 23:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094064; cv=fail; b=fP9BWW8njzW81mB4kW5LybSBS5iEUz1fRYv+ifp7dvZ1Iz8UPjIMG7gla0fC6YcevNrzYkE6HtP6wcO93e4WUvPhiKeNj/9y3dSV+9LjgtVcsWnPD88A0GnFNEtiye/OuyMc+w3FbdtkvCsKn51WksOZThErNTwPHKF7fLpBzgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094064; c=relaxed/simple;
	bh=iVA41RLh3I5h5u1xEQYgFFCU+FGRYaTqaBswv2pCdfc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AnB6IONXc0JRThuUYpDdKud/5UPcvKonuhA+FM63AhH0KAuuzKGPwtUtaL4INBQ/aFxiZ5s5KGdWgr+0c4jH1ZKPkDWgPsmNKKBWLzLulxEe3yUk1Yzzi4M0VTT0yVvL/3kD1NmwKSJDZJ0jKzG6K8c+vJdoH/Fp2dBh1aGg/d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YSGYN26p; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5af+e+XMmpa8iKS/2Bgm4gePICLO73CT68cMu7UBkBDffMQjHXc02iKr2l6fFEu+TEYJvzXOiSdwP60YuN2m7sbbb1gtqJWB4jVKNl2HDsXnAs8HbvY/ORL/BqQDNYhPihlobWXiani2W30yORblVeRFLemaGncXfPOTahrbIfeXbUSIAlPeX6M0hhfty+MecbGoDjkfxCYTGG2Ae15Pm/i+7zQBpCt2fMH61y4fspFZeYIsO2oRvf615IdVMkqyRUhgZyj2+GtTEQ3feEVuYIwtnAYsUFHQFIxGrCXcuxpAeMtPr4F5aYAZVOpMMPdnSntWP6c1kfGMzWAA3SmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRiS8m7+msPuwdBd66nmUnR8FMw9JH8FmarUXGKk+PE=;
 b=efAlh1/2ZE8h2+E1Q8FWBmpQxYb9eALufSTgCEIbfYoOL9fSxeCJHjz1nkVulaWXQv5lHcI78lFb+Thj1X5vkm87PvjlFhsbBYC43LvjzNlUlu/oeRJ/wzehjP4KNJcp7HJlJUY4LSkOxUsLI6saPfX/I7ZgEdP/38tBSlIMwUcIG7+vSzdSZllhGsA7GZ7TAZ3jHRLnC4veWyO5ZH9mNdAwfZnHvCZVbQ0fx6+B2e2K/W+6qxmmw8g74T8txMYUfpWroHjUQxvdK1nuXxfgaZOtYLzSy12iOh4Tbm3U86ZKndNgK5UBIB2nKe1QEQv463z+sYL/eKcqTJ5Bvpt7xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRiS8m7+msPuwdBd66nmUnR8FMw9JH8FmarUXGKk+PE=;
 b=YSGYN26pxkWktv1BfdwMoJ0phGkomSYb0MJ5p+YKor9/2zHQ218MeoBu5uTVCfqmV6IYhoUW2bsHdaPna5gC4Drf3PFtJRTMTh3xjbWIICznrnIKYNtm5VGF7GwQeZOAEmS5NmORyait7BRDrtizd2g/8Hvcl/4hsxiQLuTkrC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Thu, 20 Feb 2025 23:27:40 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 23:27:40 +0000
Message-ID: <6e023017-27ac-4182-8a87-313d2b34f5e4@amd.com>
Date: Thu, 20 Feb 2025 15:27:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH fwctl 3/5] pds_fwctl: initial driver framework
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gospo@broadcom.com,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com,
 Jonathan.Cameron@huawei.com, kuba@kernel.org, lbloch@nvidia.com,
 saeedm@nvidia.com, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, brett.creeley@amd.com
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-4-shannon.nelson@amd.com>
 <20250218195132.GB53094@unreal>
 <39ec35d0-56a2-4473-a67d-9a6727c61693@amd.com>
 <20250219082554.GD53094@unreal>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250219082554.GD53094@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::32) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 1caefa78-20f4-47cb-9565-08dd52062aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qm9zejNXQmdEVFJTdFJTQkZQMkZPTi91cWU3S24wb0tPbkpRODd3M3pqYWlH?=
 =?utf-8?B?eHhyV1RxMWJaZ2pic2Y0NFQ2cVNTWXVGOERLeVpNazFlNVU3ejdpUUp0MlEz?=
 =?utf-8?B?SjJ0dWlzSjM4OG5hTzBYNnFSVHNsSm9pQnBSc2NzYkRUM1Y2amVKa1NKdXFn?=
 =?utf-8?B?UTJoSFMwUTNSUjMwQ2VUWEZLNHh0YU9oWGd3bVJtdUtPeXlEaStzbi9ZZFdX?=
 =?utf-8?B?YkhuK2dGcDRrSmdXOUg3SjJnV0ZKejRrSVErQUVxM01YY1o3UFBDZmQ2MFZ1?=
 =?utf-8?B?R1BtdUdpemZacW9EeDB0NmdWYjNHa0prcmxCRzZ5aVlLUjRlMC9hZUZ2S3VY?=
 =?utf-8?B?NzlKZUoyR2FJL1NwM1MweFYzTTVWTjFvTFRobGNNaURMVTllWUJEeXlpNzBo?=
 =?utf-8?B?cGg3N3lmVmZIRS9CMXhaeTFlWW5vYWRpWXhXcG5jeEc3bkRZbVRmUWxKdzIx?=
 =?utf-8?B?dm9xeWNzN0dSNjEwR1BEbnpxbmIybWxVa050aHhzMGFzZ1NITm9sY2NvcGpw?=
 =?utf-8?B?aGRsV1hKbjMvczFnWnZLMWhoVmMrYis3TFM2end4UmFZNjZjQ09KS0lqK25Q?=
 =?utf-8?B?TFpEd0pQY3IvRlRLbS8wc0Y4bFlzV1pvS29CZW9DUDJVYktsd2hBYldmaklV?=
 =?utf-8?B?K2FKZ2ZNR2cxMy94Y3VHRDNFdmFpUXZ5aVZYV3lwZnlIYlNxcmVZTzhNMjdi?=
 =?utf-8?B?TWJLcDRmNjE2VTBtTXVGSXRvUDRVUlp6aG9BY0h6cEtEeXUrRm5xMTY2eWxa?=
 =?utf-8?B?ZFBpNUMvdTZMcm04RUpqR3FBMTZacmUrUk5qaDQxVFJsNCtpSjBONWdsVHNR?=
 =?utf-8?B?OTBrTU5yMVZKRU1RSDVaRllwUXQzMUpqd2I0K1F0cjF2UnlORlVib2w3TU45?=
 =?utf-8?B?SmI2RVVlVDlicE1jRlNUTUZzMi9nV3NhQUFVOGZkZDVOR0ZER3RGekFZRmNX?=
 =?utf-8?B?Rnh4cWw4OTEwN1VSLzBKL2Zpb0xPYWtFUzNiaW83dzREOUR3M3AwdUxCSUg5?=
 =?utf-8?B?anpCZVh5SVNUWDk4d2cwbnBKbmdnbkorUWdkZWhSSU9EZEVsSUFScGE4L1BI?=
 =?utf-8?B?VFRsMWJDQ1JlRTNGRXhSNy9HaklDbGVhUitGOWZ3ZGJHV0xjWTkxcERpbzFR?=
 =?utf-8?B?NE45aWExMTFwRXhLMjVpdXVLc3dSeWsrN3JoRWtFa0RXRFRlcXZYQkwrczNO?=
 =?utf-8?B?SnZWTThhbmtBUXVsNmpPZDBRNFhDa3RMcFEwWjRWektESEhYN255NEFoRWl4?=
 =?utf-8?B?cHBmRkx1eHd4S1J2RlBIVmsvOU5LRGgxZko4M3BKL0k3M0RSN1VCZUdCbUNE?=
 =?utf-8?B?MUxXZ0ZUWHNNaDh1ZnZsaTVnS0xJSnRKUlkyMTl1dFJ2a3ZCK3lrbDlZc2tm?=
 =?utf-8?B?SGZTeWdyZFNTbmgvY3YwTUF4cWhVOVFKNVVIMllLViszUzhsUGNBSXhSQzhY?=
 =?utf-8?B?WE1PZktFWE9VaVoxYWs4aGdPTlVUa2dUbDJOdWdaMmEvQUtiYWdjNU80Wklp?=
 =?utf-8?B?Z01tKzJiU2p1ay9kSlMrc3lLOFB0MTFUMEpITjhtR0wxRWV6bklGN0dxSnMx?=
 =?utf-8?B?S2M4RnV5Ulh6bXdVSkpMdTc2L3FNZkpOYVRZM2NpTUJ4RUNiQm1SUUxOWDlF?=
 =?utf-8?B?dmlPTWhPeGpKTzB1aDJ0bHROdWNydlNmYnRLOTg0STdub1dpNnFXczdrZ1JW?=
 =?utf-8?B?dDJwK0VxOU11VDA1NUg3SGNyanYrSk9GTUM2TXNiRFF2cHZ6V2lVUDhuSm1r?=
 =?utf-8?B?OVY2NlUweDVMZ0VQYXZ4Z1JxRklOUFRXdVR6VHRDZURlelRkUWZlaTdXV3Y3?=
 =?utf-8?B?WlVKbXJyOU1FMmJHOG0yN0NkZitwcm5Jd0RPZERrRzAwbENRelpxUGdJTmV6?=
 =?utf-8?Q?0aui3nD/JFEVQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGYweTVlbmxEN3VpV0lod3E2enF2N3A3azM2VWZHY0hBUmlnVEZRMkhtdjhB?=
 =?utf-8?B?UlA0YnlHNk5ZU09rTVRTdDBoNXNuYkx3L09MaXZQZE5Ta0lrUjZtamZ6RXht?=
 =?utf-8?B?OWdyZ25TSEhDUytWWUt2YTVOL2RUM0ZSenRTYUljazdtM290WGNVYkkrYUV1?=
 =?utf-8?B?Q3BaQnRGd3MrUHl1RGlQTmVpbGhTNTVheDZXM0toUVd4Tm9FRlRVY3p3emtQ?=
 =?utf-8?B?NFdUaTNKUEUyZ3R1SS9DOW0xQ21tY3Q5ZERJZlZvMzliT2xhVXFicEdCTXNO?=
 =?utf-8?B?dVlTcGpDQmlzZmdiM20wRmRPa0V3V3dveWNCV3pwNEdCT0QwN0F4aTZydmMx?=
 =?utf-8?B?RTNzMU9ITHVyNWpqRS9tNmpUMVZ3emVDUnUrNTlPOUpwY3h0em9rUE5qQWZF?=
 =?utf-8?B?dHUwM2pGN1dGeW9zMzhEQ3J6NlpSTFVvVmljRzdNa0F1Mjc2dDRTb1JLRjRK?=
 =?utf-8?B?T3VhNzI0S0QzeGg5RTQzdDVHL2MyNzZ6MnJ0UjFBRU8wb3RFRUphTXBiS1pI?=
 =?utf-8?B?WnhlOGtqbFRZd2dLUEFqeXArTEtsMjY1cmtvOTc2dkhLamxCMjJwWnM0b2pO?=
 =?utf-8?B?SUpMWlFSb2F0Zi92bzdtc0htMmMrNkJhUGs4UGIyV2hFMDVYK09wd1NsUXFE?=
 =?utf-8?B?VHZxUlNOaEU4R2E1NkU0UmRiNS93UnJwanZNcFhoejlnZ3pSRDNXcmFCSUJq?=
 =?utf-8?B?YlZxRFh6SzBKUkZXb2ZFTmFoZDYzS2lJNU1jcmZOOFFYSHpCYWtTd012OGVH?=
 =?utf-8?B?c013MHBubjRjR3VOcWFlTDJEZVZqcFZUSzFRTVJ4c1RLWTU2dTFmaFYxRGhF?=
 =?utf-8?B?RWJzZDhRMU5IVXVWRGtubmxjUWp1L0xSaTRzUnRETWVkTURRWEhjeXdJRFZL?=
 =?utf-8?B?ditZTUsramJwNnduU1Jpb1NxQUxoVkd5T3hjdlRucVJJTUhDcllMSWxKcDZN?=
 =?utf-8?B?NlVXcDVXQ0hPYUxGVFVDLzN2YXR6MlBmSitKVkp1SDBkR2ZFcFN5TnRwT3gy?=
 =?utf-8?B?aTR5aVFQZE9jK085SGVRbmhtNUZid0Y4eksrb1BHY0xKWXFuSVJZWHpDZ0RP?=
 =?utf-8?B?RzNlMk53K29Ob1phblIwNW9oR29KQWV4aGFTa251RnNUalFOYndkaTN0Nlg3?=
 =?utf-8?B?YXhjQURvUlFOenVXVWU0UjJWQlJORTNPVlhHK29iMWtxbVY0c1FNZjVEN3ps?=
 =?utf-8?B?OVZKUkE3R2xIdERPdnYvTmtDZURieTJoSCs3NTRXdSt1U0piS1hWS1h4T2Zi?=
 =?utf-8?B?bklDNGs1ZFRyMmQ0bDhiWms4cVp5YnFQWXZVamt0bGdWU2xkbE4zTjFFTHJT?=
 =?utf-8?B?WmhqOXpyeUpLQ3MyQ0NhM2NHTjJNZ3k3YWFZMk5RQWhWcmRXcmZDVmRodjNk?=
 =?utf-8?B?UUI2OHVEcVp4KzVFZWZhNU94OSt3MWVxTk1tTExLZ0I4MVM5S1JlWFdxZStn?=
 =?utf-8?B?WGZET1FKc2NoOW1xSFkvL2NZWEpqU0JMRGd5Z3kwS3NpaWJvNDhDNkdmSnBT?=
 =?utf-8?B?bDlDWEtHaXBGQ3hOeXJiUVZlZjEvTm5XSHJ2QVdYL2lJWGpLNkxLZzRPd20x?=
 =?utf-8?B?Ny9ydG5lMXM2bjdjQmxiaUtOamZQcHFSbTZuanh0cG9xOGllN0M4bWRldWJq?=
 =?utf-8?B?WFp4NmRoR1NJZzF2bThaeGRwUGJwK0RJZGlFbUNuOEI3Nmp6T1NtVEtoc0FO?=
 =?utf-8?B?QWdjZHhVdTZPZC9yNEI3MXdXck5mS0FrYkp0UDhsSUdSMzltcjhXaDNqdXR3?=
 =?utf-8?B?NzVlQmNTYXlrMXlzTFlIdEQ4UlNNOVRmQThuUGNOUTUrdEYrN0Y0WVJCK3NS?=
 =?utf-8?B?V0pUbmdNN0l5Y2lnUHpWRzlReVRtVG12Z1RKWGlDTFNEVmJHcXNJUG53TUMw?=
 =?utf-8?B?ZWZkT1crdTk2c1FSa1JiVit1T2JENVlCbE9PdC9qYW5DV2dIWVBKQTE5dHRt?=
 =?utf-8?B?eHpDL1Y0Wi9uZC9YOC9xcWdIWUFXOEhPYS9Zc09nbjhSRElaNWNyWTRXTHJ1?=
 =?utf-8?B?eUZjU3NuU0RYMGdmRlROQkRsS3I4QjNjZzEyZmNQOUplY2ZtMXRDNEQ0T0N4?=
 =?utf-8?B?cXU3aTgzT3VTMnlESXlkZ0lGejcxR2VMS0U4UHZjZVdUWEREejBGS1JXZ3VM?=
 =?utf-8?Q?3999KMZ+VbAvlBhextemttoGb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caefa78-20f4-47cb-9565-08dd52062aed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 23:27:40.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YbkGk4jL/w6Ptg6bM8tqzOfSqoShar5J8UxbMC69EXuzolBD0xU16M4q9BJexuGK9ckKWdoSCBIG2afqj4t6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

On 2/19/2025 12:25 AM, Leon Romanovsky wrote:
> 
> On Tue, Feb 18, 2025 at 02:19:03PM -0800, Nelson, Shannon wrote:
>> On 2/18/2025 11:51 AM, Leon Romanovsky wrote:
>>>
>>> On Tue, Feb 11, 2025 at 03:48:52PM -0800, Shannon Nelson wrote:
>>>> Initial files for adding a new fwctl driver for the AMD/Pensando PDS
>>>> devices.  This sets up a simple auxiliary_bus driver that registers
>>>> with fwctl subsystem.  It expects that a pds_core device has set up
>>>> the auxiliary_device pds_core.fwctl
>>>>
>>>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>>>> ---
>>>>    MAINTAINERS                    |   7 ++
>>>>    drivers/fwctl/Kconfig          |  10 ++
>>>>    drivers/fwctl/Makefile         |   1 +
>>>>    drivers/fwctl/pds/Makefile     |   4 +
>>>>    drivers/fwctl/pds/main.c       | 195 +++++++++++++++++++++++++++++++++
>>>>    include/linux/pds/pds_adminq.h |  77 +++++++++++++
>>>>    include/uapi/fwctl/fwctl.h     |   1 +
>>>>    include/uapi/fwctl/pds.h       |  27 +++++
>>>>    8 files changed, 322 insertions(+)
>>>>    create mode 100644 drivers/fwctl/pds/Makefile
>>>>    create mode 100644 drivers/fwctl/pds/main.c
>>>>    create mode 100644 include/uapi/fwctl/pds.h
>>>
>>> <...>
> 
> <...>
> 
>>>> +             return err;
>>>> +     }
>>>> +
>>>> +     cmd.fwctl_ident.opcode = PDS_FWCTL_CMD_IDENT;
>>>> +     cmd.fwctl_ident.version = 0;
>>>
>>> How will you manage this version field?
>>
>> Since there is only version 0 at this point, there is not much to manage.  I
>> wanted to explicitly show the setting to version 0, but maybe that can be
>> assumed by the basic struct init.
> 
> But the question is slightly different "How will you manage this version field?"

If we find we have to change the interface in a non-backward-compatable 
way, we'll increment the version number that we support, and watch for 
the version number supported by the firmware as reported in the ident 
struct data and interpret the data appropriately.  Similarly, if the 
firmware sees that the host driver is at a lower version number, it will 
handle data in the older format.

sln




