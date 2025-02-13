Return-Path: <linux-rdma+bounces-7759-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C6EA35235
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 00:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577D616B9C1
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 23:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE11C84A5;
	Thu, 13 Feb 2025 23:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bg3/P8HE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8079F2753F0;
	Thu, 13 Feb 2025 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739489540; cv=fail; b=GE0uf/i6ePoZ2WHm994f5yd/+7ltsohihIRgDv8LuplSKUoGABdRRTllP8Gb1ZtNs1auF0xxlSi/yvmacnNL9wfFLaHN7qskvkwZzdz7JPJu3mo+pd9bWN2ZTxTzVUj+2VvarU+ezXF2tUyGyQvU0VoJzCEjGVULBz/agRSfBg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739489540; c=relaxed/simple;
	bh=3y14DJcrf4Te+XXvPvMfptVS4/PNkTkIfG38Jl+TvC4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y3ebswXbgXmgZjDhYpjE32761PxfBbeFr+8MOvTDV9K6qWGeaUnpIrKIQLeEjqaa5hLx6CsuBn0zDm3QkYESwyIsH4BG3nkVSEduHazRkv9Z/WPX35Y/iDdDVYfPCZMJGYFdeppjceuP+wIV+RHx+zRaOpmn/OoekjnDFqSkklc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bg3/P8HE; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoLhpU0EiEZsE0DbQiNZM4Bcf0yU3ezo0Q3pPGapOJ2oDCNhhIYDJ+Fp9peVJWRTrgkAmaeenHbYQEJ08MUEjORsFa6w2imp/d1GUXie6+u3Rrpy7srOBohcD/egyt4H0g3ZihEpw/zRsVi6/DG3D8wKEBxtgoP8jjkv0wHhoB0bfgrtkt6hXP9Rs6il3L4bBPYY5vl0esYmoYQiUg+kWaeLO2ieqte8jjzrDrxh3bIvS1odJkMwHMtGzf7U5C9LSi5y4F7sHJIA+bRP6l+ok9+aVSNA/fvyzLCSs292CFrF4vjKmg5mEQBGx3xxAIBQNJCTF/ztvti/pA0jFlUJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqEghKyn2Fj0Fk7/EZDQZ9B4ey8QSvIXtbpzal5CF/M=;
 b=ca9rqKzPKD6VVZw1gr7D/UdD395UFe3Vh3snAOLeDIDtVYl4o6RDOyBjri7MfVvXgKOEvdKiPAJgiRpoYuVVXguKOR4da2Cgwd8+p/7W28jQHkyK1tVd4Wt+Dwz4nZs70Th0myMVaMSUbtT0tAUkn/LGT0GuTic0wNTylelLSQhcNd0q677SVcutVswgkMQdm/ASzzDFbD84fthsLGKUomHDmke4zSueZDRg2X4XE51MBH1ez/K3VR7RtD/LPy48F4SgSSPNURRLZU4ymfzTzI6ldS3LOKXIrldqhhUINumR+l4UttO7RzeRi2Tl9LGsCFHEvV4bShryTy6P62NGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqEghKyn2Fj0Fk7/EZDQZ9B4ey8QSvIXtbpzal5CF/M=;
 b=Bg3/P8HElFo7dnZnGUj9Q4OlJ4QYovTqVTx1Nx8S6N9xVRQ44sebytm0XjCE4gD283YmCojk2k4w2y3ezuPMZXCgVDT54VY5qatGeORWT5ZHZDiZFcXs0QNX4FWcV8wzJCCNNFKlC4YCqFZ4H8ds3DsB9+/VHcddUAlz6+a8Udw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Thu, 13 Feb
 2025 23:32:14 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 23:32:14 +0000
Message-ID: <160b2a85-8f14-471e-83c5-d7ac0fa2b817@amd.com>
Date: Thu, 13 Feb 2025 15:31:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH fwctl 3/5] pds_fwctl: initial driver framework
To: Dave Jiang <dave.jiang@intel.com>, jgg@nvidia.com,
 andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gospo@broadcom.com, hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com,
 Jonathan.Cameron@huawei.com, kuba@kernel.org, lbloch@nvidia.com,
 leonro@nvidia.com, saeedm@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc: brett.creeley@amd.com
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-4-shannon.nelson@amd.com>
 <4a862ed3-0959-42f6-8ae8-cf6176ff1742@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <4a862ed3-0959-42f6-8ae8-cf6176ff1742@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::17) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fb5353-edeb-4bfa-3807-08dd4c86a587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTNNN2Q0Y3hYeXBkVFpONG04aFRkS2lKVFFyckk3QTIrc0c1N3RwZXZ1dDN0?=
 =?utf-8?B?UGxEbmRJZ2hUVExwZ1VMN2tNL0hMTlQwZ2pzemNxNFJUem8zdDcyd1l3b2xM?=
 =?utf-8?B?c3k0bDRIWFdhclJvVHNQVFFKZ1ZNZkZGSDQ0dDZ4bzFwaDZiRU1RSFd4bStI?=
 =?utf-8?B?K05wOEIyV3B0SUIyNS9MMFhJWnRraDlQTGFTNTZEaGUrUXV2REliT2dDanV6?=
 =?utf-8?B?TTNZQ2ZzeTVGMmIyQUFMNFFBV05VREFmZFcySVAvZUtyRXNFSVJ0MTVRQitB?=
 =?utf-8?B?NGN1cmF0bjlGQjZrYW9tNytFSjlLNnRvNDhMNHFOVjd6TzlnOUFVeE1RcitI?=
 =?utf-8?B?TXg2VjZYUlZpZGpQcGl0V1BGN3JLSDBxNnFtVEk3NUVlS1dJVEZkUHZaWXN3?=
 =?utf-8?B?NXc3UGRta3RXWXl3Tld2UmxaNmJ2ZkI4bUdkOXl3YUxkdkRJY1FuUWd1VEFs?=
 =?utf-8?B?QkJvUEhLcTFWVzZXZDVwT1ZoWHErenJ1c2NvNHY0aWFlZlRGWTlNelhuTGNU?=
 =?utf-8?B?MkpNTUN6WVZWSklyTjJDa1N5R3FaNnk5bys2UEI4YWpjVmo4TExFVWFGNjVN?=
 =?utf-8?B?NHF0QnJIVU1JTGtEZ2k5c2lKZ1p3M3poeTVGcEVVaXlZWTdlNzhoWjdaRXFv?=
 =?utf-8?B?SVU2UFZyUktpbXowRTRuQUE1YktybGx6Zkp1cTFFeEYxay9yTTdYcjd5ZlBk?=
 =?utf-8?B?elJ3REtPTzQrL3RvVWlsdjFKYnN1Tnd3anNDcG11a3pCNVdFNFdxazc0WDJS?=
 =?utf-8?B?LzFaVTNBbm1PRWxsSmZBRkZZNHJ6ZVZ0UEtjSHUwcExaV25PbWdEY1QrYzBE?=
 =?utf-8?B?aE5KbGZBSHMzeWlCem1Ec01TTHQzSGRINEEwL2hzVHZYN3VhdkovWWxOR2ti?=
 =?utf-8?B?Uk0rdFE2YnZMRlN0RnFxY25Kd1dQZTB3dkxHdHJVWHNHcXlselh6d2g0eklR?=
 =?utf-8?B?QzAvQ1VMVHRNZktyRWtVSGFxckRQV3BqSmxwb083N0xLeGtidXlkY0ZlbDdp?=
 =?utf-8?B?VFpPWGhWOFN6UzVGbmlONGVLMFFiZWs3SlduOTUvTUZhMXRWQkgzaEVQeXoy?=
 =?utf-8?B?NGM3RFgxZEdKZ0NtRURUSzEwQVRzSm9FV0pnblB4UFVkM0hJM28yMG40QURG?=
 =?utf-8?B?eEZFQUcrNUd4N2VRcEtKcHFHbDAwZlVDcG52U2FlTEdIZE9paDdrcmV1cjNt?=
 =?utf-8?B?SGtrTWVVZHVtQ2I0OFZxckxDc3pEM3BrSjVmSXdhb3NtbHY5NFgwQUk5b0tH?=
 =?utf-8?B?V2tRZkhtVkJCR0JlZEs5ZDlaUXQveWZFNnl3aEZxMzhZMHVZTXBXcUhBak5w?=
 =?utf-8?B?N05lcnNWdzNjZVFXNDBnWlcyVFgzVmFpNTlLNzZRZWliMXRhVEM2dk1oSzZG?=
 =?utf-8?B?dUFuVElIRWg3U3AxMWtGb0huNTRBZGhUMFJvdFFGSFBURlo0UFBpcHBDZmdK?=
 =?utf-8?B?cTQzSkc5K2VvbXMxOTdmTW5QckVrc25HZDEwdVRnOE0zY2cvVUxoNVZPVEtD?=
 =?utf-8?B?QWs0Z1V2RjhmakYySXpCclRlTnRRQXhDYWY1WkNlWkJiT3lnblJRbFg1VGpT?=
 =?utf-8?B?M0JVK0pSSGRrTDFtM242aVVlYnlQTlFnRWdHWjBxblpCdXBZZEZsenR1WVM0?=
 =?utf-8?B?K1NJR1hyM2lhcGEwcXhqTlQ4OHNWQ1hwT2FCWHlJbDliN2puZkhDam1aL3N6?=
 =?utf-8?B?Q2dhUFV2dnhtMjJ3cktHa05BdzJQVjlqUjRWOW8zWnZJdjljTElpaWYybGor?=
 =?utf-8?B?R05wYys1RGR3ZTFYQnlDZVZHRGhQL0VPVlV4RGFmZm9IcktwVjBFUDdodFNC?=
 =?utf-8?B?RWs0bnFTQ2hDVHNubWJqUEpFZkROZjVOTFl5ZnBiMnVSa1g1a29DTFlCYWNn?=
 =?utf-8?B?SDJmN0lTWWZUd3NjUTY4Mm5hVnBOaGoralQ5MDFwZjdSZlZ6NThxUHI2Y200?=
 =?utf-8?Q?DBqZI9QF3T0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2JxRkZwY2FWbmtHL1c2RkJpVE56ZzBJeHlRQmFyRTk1TDIzaEZYMGtVbUxK?=
 =?utf-8?B?aUJlRVpZRTBCb1hmQkQwdnJnTUU1TGxWcU1mdng1alZPUWE4NGV4VkRIMXN3?=
 =?utf-8?B?VDJ3V3V2bmorMGgwVyswZW5KWEFMQUFBZ0J0d2pkVEgwYjNRTXBKRHZCQytq?=
 =?utf-8?B?cVc3aGJIZEJVaFdORSs4OXpJMCtMQW5JOFR6MDhBaEtIRDNBOVM1SDRVRkZH?=
 =?utf-8?B?a0V4YW90Q3RCOGxrOFpSblBZWG5rSXY4U2xGTU1zT1NVcDNRdFB1Q3pJOERi?=
 =?utf-8?B?THhoVUREMU9EQlYzaHlyMTg3WnN1b1dPeWhxS3A1dmdmd2IxNnJRVXFqbVcw?=
 =?utf-8?B?dUZTUEJPMHVEc1pnYkxYQjgrMEZFQUptWkpodkNuaWJUVVVPUGlaVUVHMkdm?=
 =?utf-8?B?VjhLbHBJTEpqVjNFL3UwRUtLS1I2ZkxUeUozM2Vva25MeGljczlMYVRiQnho?=
 =?utf-8?B?SXdmazExdTZiOE5XYm0rbUhHUzF4UkY4cnVPLzNacHYyUitkMlUxdVJISGRK?=
 =?utf-8?B?N1hCQVo5ZFVBZVppOEhMVnZmNkJkUzg0QU9XU2IvaTgyNG52ZXcvNDkyazkv?=
 =?utf-8?B?ZXlMTENPaWV3SDliaU9FL1J4YU1mUzd4ZHdxOHhjL1hnSEY3akRuUE8xbGlB?=
 =?utf-8?B?bmowNXF5eEVwYmJHRmc5MUZkK3NwZ2JBUzZybGIwNmE2U2FLaitKSGMvdUcr?=
 =?utf-8?B?b0VsVEZJbFhlOGo2ZG5mZnhMRUV3eEVlQko2S1NNREkybXBWY3NDTGI0bThU?=
 =?utf-8?B?VnByL3J4LzdzaUFtUzJWeHRUWEI4TVpad0o0L1FlRnd3dmhRVVRlRjBvdzhZ?=
 =?utf-8?B?a3NCckJrRjRMVityN0cxU0p4eTAwMDUyblhMZWpTbm9jaldZWW1YM0o2SUpX?=
 =?utf-8?B?c0ZoYjJRM0R2UWZTNXR0WGV0Q2YzYytUK28wdlFJYWFJSkJ2eUIxb3hFVmd5?=
 =?utf-8?B?Q3BwWXpLOVErRVlsMUFrTU9zNWNNZjFkWWcrbjRUVUJPT0lFemxlMFdCdE5X?=
 =?utf-8?B?NWYxaTNYYjFjSWxONVJsMlZuYld2VkRMTzUwVkIxaXlEZXZMVnRpMktpZEZN?=
 =?utf-8?B?VEZVSjA4N2VLS3ZrcERTTGs4QjVkUFBpbkFjRkpJRVhlVngzaGdYeTA1bUJr?=
 =?utf-8?B?bjBZNjJuT3phN2hrRFlSdWFEVmk5SVE4VXZNR2tNajA2R2M3ZnJ2OWM5UDVh?=
 =?utf-8?B?c0s3amtuSTdwd3ozb3B1TXJMc2wwMFYwVVAvai80K1RzTThmdUJiTjk2T3Y4?=
 =?utf-8?B?TVBhbDM1dm8wL1VZSDVFdWFjZXdvYjgwNjVKVUFmTm1tUktnQUdJb0pFNjAw?=
 =?utf-8?B?RmdqMHlkT0IxS0RQNDM5Rk50NDZ5cDV6ZVZ1Um9QcTkwUktkUjY1NXBZMjZr?=
 =?utf-8?B?RkU1b25nR2ZyaTZ5SUxNb1Y2QXhmNDhhbU9CQVFra0NKOHRrR05FeWgwZ0M2?=
 =?utf-8?B?TjY2MDZtMFBzZkYxdFVSQnZYNTE0SkdKc2drOGd6Z0NvdERHcVVudFI0Z216?=
 =?utf-8?B?VE1ZMDJseGd2eElpd3ZMZ21JN3ErcGQwd0RpeU0zNDM3eUFRQTVlUWw5U1Zj?=
 =?utf-8?B?RkgrQVVSZW10Y2tWUXY4N2pwREk4M2FRUXRLdjdtSGVRbGt1Q08rRjdScU9H?=
 =?utf-8?B?ZUNZSnNUMU1TTVlHOXhmYlU2OXFZcmtSMmRuSTc1OG1XVWRqbW5mUXdPWkhI?=
 =?utf-8?B?RElDVzBjRWQrVThMZXVKZ0NFUllEWEpkNnJHUTRTNk9wS25zM0hzR2tiTitB?=
 =?utf-8?B?TUpiejJMRjBXS0Fmb1Eyc3NTdW5zRFRpTFl5dTBEMUgvTUZONTlrSHI1SWZk?=
 =?utf-8?B?Q3NIa245alFFc0VEcDJ2OFlUdVdIYU1XQmpKV3NJcFo3V0tINzlXcHFWbjR1?=
 =?utf-8?B?aER2Rld1RDU5YU9QOEtrdDIya25nOXdlbXJ6bUxZbHRwb3M1aGMxNjgvVW5m?=
 =?utf-8?B?MXE0UVJVT0hHaXhaMEhyV1RXNjh4SUlHQklxN3BCUUt4cUxnQTJ1MjN3YWow?=
 =?utf-8?B?YVVLMGthRE5HTWN6MVVkY3JKY1lKRlc5N0JQN29JazZUUS8vNFlWc3daOFEx?=
 =?utf-8?B?Zmg4Q2tseW9Kck12OFI0VVFVb3Nqei84dUUyZE0vOWVhaS9MWGMrdzdob2ln?=
 =?utf-8?Q?vBhWyWc3Xy8axil/HfSN1raPB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fb5353-edeb-4bfa-3807-08dd4c86a587
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 23:32:14.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66oUKQlpl/mMi9s2x73dVu3xq3qtqPpQnezU9d1TjaAcyTggw8gTm8mYXnOIJPkma4Xr3vaAV+ZUPKptWanuMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

On 2/12/2025 3:26 PM, Dave Jiang wrote:
> 
> On 2/11/25 4:48 PM, Shannon Nelson wrote:
>> Initial files for adding a new fwctl driver for the AMD/Pensando PDS
>> devices.  This sets up a simple auxiliary_bus driver that registers
>> with fwctl subsystem.  It expects that a pds_core device has set up
>> the auxiliary_device pds_core.fwctl
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
>>   MAINTAINERS                    |   7 ++
>>   drivers/fwctl/Kconfig          |  10 ++
>>   drivers/fwctl/Makefile         |   1 +
>>   drivers/fwctl/pds/Makefile     |   4 +
>>   drivers/fwctl/pds/main.c       | 195 +++++++++++++++++++++++++++++++++
>>   include/linux/pds/pds_adminq.h |  77 +++++++++++++
>>   include/uapi/fwctl/fwctl.h     |   1 +
>>   include/uapi/fwctl/pds.h       |  27 +++++
>>   8 files changed, 322 insertions(+)
>>   create mode 100644 drivers/fwctl/pds/Makefile
>>   create mode 100644 drivers/fwctl/pds/main.c
>>   create mode 100644 include/uapi/fwctl/pds.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 413ab79bf2f4..123f8a9c0b26 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9602,6 +9602,13 @@ T:     git git://linuxtv.org/media.git
>>   F:   Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
>>   F:   drivers/media/i2c/gc2145.c
>>
>> +FWCTL PDS DRIVER
>> +M:   Brett Creeley <brett.creeley@amd.com>
>> +R:   Shannon Nelson <shannon.nelson@amd.com>
>> +L:   linux-kernel@vger.kernel.org
>> +S:   Maintained
>> +F:   drivers/fwctl/pds/
>> +
>>   GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
>>   M:   Tim Harvey <tharvey@gateworks.com>
>>   S:   Maintained
>> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
>> index 0a542a247303..df87ce5bd8aa 100644
>> --- a/drivers/fwctl/Kconfig
>> +++ b/drivers/fwctl/Kconfig
>> @@ -28,5 +28,15 @@ config FWCTL_MLX5
>>          This will allow configuration and debug tools to work out of the box on
>>          mainstream kernel.
>>
>> +       If you don't know what to do here, say N.
>> +
>> +config FWCTL_PDS
>> +     tristate "AMD/Pensando pds fwctl driver"
>> +     depends on PDS_CORE
>> +     help
>> +       The pds_fwctl driver provides an fwctl interface for a user process
>> +       to access the debug and configuration information of the AMD/Pensando
>> +       DSC hardware family.
>> +
>>          If you don't know what to do here, say N.
>>   endif
>> diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
>> index 5fb289243286..692e4b8d7beb 100644
>> --- a/drivers/fwctl/Makefile
>> +++ b/drivers/fwctl/Makefile
>> @@ -2,5 +2,6 @@
>>   obj-$(CONFIG_FWCTL) += fwctl.o
>>   obj-$(CONFIG_FWCTL_BNXT) += bnxt/
>>   obj-$(CONFIG_FWCTL_MLX5) += mlx5/
>> +obj-$(CONFIG_FWCTL_PDS) += pds/
>>
>>   fwctl-y += main.o
>> diff --git a/drivers/fwctl/pds/Makefile b/drivers/fwctl/pds/Makefile
>> new file mode 100644
>> index 000000000000..c14cba128e3b
>> --- /dev/null
>> +++ b/drivers/fwctl/pds/Makefile
>> @@ -0,0 +1,4 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> +obj-$(CONFIG_FWCTL_PDS) += pds_fwctl.o
>> +
>> +pds_fwctl-y += main.o
>> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
>> new file mode 100644
>> index 000000000000..24979fe0deea
>> --- /dev/null
>> +++ b/drivers/fwctl/pds/main.c
>> @@ -0,0 +1,195 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> +/* Copyright(c) Advanced Micro Devices, Inc */
>> +
>> +#include <linux/module.h>
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/pci.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include <uapi/fwctl/fwctl.h>
>> +#include <uapi/fwctl/pds.h>
>> +#include <linux/fwctl.h>
>> +
>> +#include <linux/pds/pds_common.h>
>> +#include <linux/pds/pds_core_if.h>
>> +#include <linux/pds/pds_adminq.h>
>> +#include <linux/pds/pds_auxbus.h>
>> +
>> +struct pdsfc_uctx {
>> +     struct fwctl_uctx uctx;
>> +     u32 uctx_caps;
>> +     u32 uctx_uid;
>> +};
>> +
>> +struct pdsfc_dev {
>> +     struct fwctl_device fwctl;
>> +     struct pds_auxiliary_dev *padev;
>> +     struct pdsc *pdsc;
>> +     u32 caps;
>> +     dma_addr_t ident_pa;
>> +     struct pds_fwctl_ident *ident;
>> +};
>> +DEFINE_FREE(pdsfc_dev, struct pdsfc_dev *, if (_T) fwctl_put(&_T->fwctl));
>> +
>> +static int pdsfc_open_uctx(struct fwctl_uctx *uctx)
>> +{
>> +     struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
>> +     struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
>> +     struct device *dev = &uctx->fwctl->dev;
>> +
>> +     dev_dbg(dev, "%s: caps = 0x%04x\n", __func__, pdsfc->caps);
>> +     pdsfc_uctx->uctx_caps = pdsfc->caps;
>> +
>> +     return 0;
>> +}
>> +
>> +static void pdsfc_close_uctx(struct fwctl_uctx *uctx)
>> +{
>> +}
>> +
>> +static void *pdsfc_info(struct fwctl_uctx *uctx, size_t *length)
>> +{
>> +     struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
>> +     struct fwctl_info_pds *info;
>> +
>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +     if (!info)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     info->uctx_caps = pdsfc_uctx->uctx_caps;
>> +
>> +     return info;
>> +}
>> +
>> +static void pdsfc_free_ident(struct pdsfc_dev *pdsfc)
>> +{
>> +     struct device *dev = &pdsfc->fwctl.dev;
>> +
>> +     if (pdsfc->ident) {
>> +             dma_free_coherent(dev, sizeof(*pdsfc->ident),
>> +                               pdsfc->ident, pdsfc->ident_pa);
>> +             pdsfc->ident = NULL;
>> +             pdsfc->ident_pa = DMA_MAPPING_ERROR;
>> +     }
>> +}
>> +
>> +static int pdsfc_identify(struct pdsfc_dev *pdsfc)
>> +{
>> +     struct device *dev = &pdsfc->fwctl.dev;
>> +     union pds_core_adminq_comp comp = {0};
>> +     union pds_core_adminq_cmd cmd = {0};
>> +     struct pds_fwctl_ident *ident;
>> +     dma_addr_t ident_pa;
>> +     int err = 0;
>> +
>> +     ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
>> +     err = dma_mapping_error(dev->parent, ident_pa);
>> +     if (err) {
>> +             dev_err(dev, "Failed to map ident\n");
>> +             return err;
>> +     }
>> +
>> +     cmd.fwctl_ident.opcode = PDS_FWCTL_CMD_IDENT;
>> +     cmd.fwctl_ident.version = 0;
>> +     cmd.fwctl_ident.len = cpu_to_le32(sizeof(*ident));
>> +     cmd.fwctl_ident.ident_pa = cpu_to_le64(ident_pa);
>> +
>> +     err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
>> +     if (err) {
>> +             dma_free_coherent(dev->parent, PAGE_SIZE, ident, ident_pa);
>> +             dev_err(dev, "Failed to send adminq cmd opcode: %u entity: %u err: %d\n",
>> +                     cmd.fwctl_query.opcode, cmd.fwctl_query.entity, err);
>> +             return err;
>> +     }
>> +
>> +     pdsfc->ident = ident;
>> +     pdsfc->ident_pa = ident_pa;
>> +
>> +     dev_dbg(dev, "ident: version %u max_req_sz %u max_resp_sz %u max_req_sg_elems %u max_resp_sg_elems %u\n",
>> +             ident->version, ident->max_req_sz, ident->max_resp_sz,
>> +             ident->max_req_sg_elems, ident->max_resp_sg_elems);
>> +
>> +     return 0;
>> +}
>> +
>> +static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>> +                       void *in, size_t in_len, size_t *out_len)
>> +{
>> +     return NULL;
>> +}
>> +
>> +static const struct fwctl_ops pdsfc_ops = {
>> +     .device_type = FWCTL_DEVICE_TYPE_PDS,
>> +     .uctx_size = sizeof(struct pdsfc_uctx),
>> +     .open_uctx = pdsfc_open_uctx,
>> +     .close_uctx = pdsfc_close_uctx,
>> +     .info = pdsfc_info,
>> +     .fw_rpc = pdsfc_fw_rpc,
>> +};
>> +
>> +static int pdsfc_probe(struct auxiliary_device *adev,
>> +                    const struct auxiliary_device_id *id)
>> +{
>> +     struct pdsfc_dev *pdsfc __free(pdsfc_dev);
>> +     struct pds_auxiliary_dev *padev;
>> +     struct device *dev = &adev->dev;
>> +     int err = 0;
>> +
>> +     padev = container_of(adev, struct pds_auxiliary_dev, aux_dev);
>> +     pdsfc = fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
>> +                                struct pdsfc_dev, fwctl);
> 
> The suggested formatting of using scope-based cleanup is to just declare the variable inline as you need it rather than split the cleanup vs the allocation.

I'm old - I have old patterns of distain for mid-function 
declarations... I'll try to do better :-)

> 
>          struct pdsfc_dev *pdsfc __free(pdsfc_dev) =
>                          fwctl_alloc_device(...);
> 
>> +     if (!pdsfc) {
>> +             dev_err(dev, "Failed to allocate fwctl device struct\n");
>> +             return -ENOMEM;
>> +     }
>> +     pdsfc->padev = padev;
>> +
>> +     err = pdsfc_identify(pdsfc);
>> +     if (err) {
>> +             dev_err(dev, "Failed to identify device, err %d\n", err);> +            return err;
>> +     }
>> +
>> +     err = fwctl_register(&pdsfc->fwctl);
>> +     if (err) {
>> +             dev_err(dev, "Failed to register device, err %d\n", err);
> 
> Missing freeing of the 'ident' from dma_alloc_coherent. Although mixing gotos and __free() would get really messy in a hurry. I suggest you setup pdsfc_identify() like an allocation function with returning 'struct pds_fwctl_ident *' so you can utilize a custom __free() to free up the dma memory. and then you can do:
> pdsfc->ident = no_free_ptr(ident);
> pdsfc->ident_pa = ident_pa; /* ident_pa passed in as a ptr to pdsfc_identify() for write back */

As discussed with Jonathan, this will get reworked to not need to keep 
the DMA mapping around.

> 
>> +             return err;
>> +     }
>> +
>> +     auxiliary_set_drvdata(adev, no_free_ptr(pdsfc));
>> +
>> +     return 0;
>> +
>> +free_ident:
> 
> nothing goes here.

Thanks!
sln

> 
> DJ
> 
>> +     pdsfc_free_ident(pdsfc);
>> +     return err;
>> +}
>> +
>> +static void pdsfc_remove(struct auxiliary_device *adev)
>> +{
>> +     struct pdsfc_dev *pdsfc  __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
>> +
>> +     fwctl_unregister(&pdsfc->fwctl);
>> +     pdsfc_free_ident(pdsfc);
>> +}
>> +
>> +static const struct auxiliary_device_id pdsfc_id_table[] = {
>> +     {.name = PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_FWCTL_STR },
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(auxiliary, pdsfc_id_table);
>> +
>> +static struct auxiliary_driver pdsfc_driver = {
>> +     .name = "pds_fwctl",
>> +     .probe = pdsfc_probe,
>> +     .remove = pdsfc_remove,
>> +     .id_table = pdsfc_id_table,
>> +};
>> +
>> +module_auxiliary_driver(pdsfc_driver);
>> +
>> +MODULE_IMPORT_NS(FWCTL);
>> +MODULE_DESCRIPTION("pds fwctl driver");
>> +MODULE_AUTHOR("Shannon Nelson <shannon.nelson@amd.com>");
>> +MODULE_AUTHOR("Brett Creeley <brett.creeley@amd.com>");
>> +MODULE_LICENSE("Dual BSD/GPL");
>> diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
>> index 4b4e9a98b37b..7fc353b63353 100644
>> --- a/include/linux/pds/pds_adminq.h
>> +++ b/include/linux/pds/pds_adminq.h
>> @@ -1179,6 +1179,78 @@ struct pds_lm_host_vf_status_cmd {
>>        u8     status;
>>   };
>>
>> +enum pds_fwctl_cmd_opcode {
>> +     PDS_FWCTL_CMD_IDENT             = 70,
>> +};
>> +
>> +/**
>> + * struct pds_fwctl_cmd - Firmware control command structure
>> + * @opcode: Opcode
>> + * @rsvd:   Word boundary padding
>> + * @ep:     Endpoint identifier.
>> + * @op:     Operation identifier.
>> + */
>> +struct pds_fwctl_cmd {
>> +     u8     opcode;
>> +     u8     rsvd[3];
>> +     __le32 ep;
>> +     __le32 op;
>> +} __packed;
>> +
>> +/**
>> + * struct pds_fwctl_comp - Firmware control completion structure
>> + * @status:     Status of the firmware control operation
>> + * @rsvd:       Word boundary padding
>> + * @comp_index: Completion index in little-endian format
>> + * @rsvd2:      Word boundary padding
>> + * @color:      Color bit indicating the state of the completion
>> + */
>> +struct pds_fwctl_comp {
>> +     u8     status;
>> +     u8     rsvd;
>> +     __le16 comp_index;
>> +     u8     rsvd2[11];
>> +     u8     color;
>> +} __packed;
>> +
>> +/**
>> + * struct pds_fwctl_ident_cmd - Firmware control identification command structure
>> + * @opcode:   Operation code for the command
>> + * @rsvd:     Word boundary padding
>> + * @version:  Interface version
>> + * @rsvd2:    Word boundary padding
>> + * @len:      Length of the identification data
>> + * @ident_pa: Physical address of the identification data
>> + */
>> +struct pds_fwctl_ident_cmd {
>> +     u8     opcode;
>> +     u8     rsvd;
>> +     u8     version;
>> +     u8     rsvd2;
>> +     __le32 len;
>> +     __le64 ident_pa;
>> +} __packed;
>> +
>> +/**
>> + * struct pds_fwctl_ident - Firmware control identification structure
>> + * @features:    Supported features
>> + * @version:     Interface version
>> + * @rsvd:        Word boundary padding
>> + * @max_req_sz:  Maximum request size
>> + * @max_resp_sz: Maximum response size
>> + * @max_req_sg_elems:  Maximum number of request SGs
>> + * @max_resp_sg_elems: Maximum number of response SGs
>> + */
>> +struct pds_fwctl_ident {
>> +     __le64 features;
>> +     u8     version;
>> +     u8     rsvd[3];
>> +     __le32 max_req_sz;
>> +     __le32 max_resp_sz;
>> +     u8     max_req_sg_elems;
>> +     u8     max_resp_sg_elems;
>> +} __packed;
>> +
>>   union pds_core_adminq_cmd {
>>        u8     opcode;
>>        u8     bytes[64];
>> @@ -1216,6 +1288,9 @@ union pds_core_adminq_cmd {
>>        struct pds_lm_dirty_enable_cmd    lm_dirty_enable;
>>        struct pds_lm_dirty_disable_cmd   lm_dirty_disable;
>>        struct pds_lm_dirty_seq_ack_cmd   lm_dirty_seq_ack;
>> +
>> +     struct pds_fwctl_cmd              fwctl;
>> +     struct pds_fwctl_ident_cmd        fwctl_ident;
>>   };
>>
>>   union pds_core_adminq_comp {
>> @@ -1243,6 +1318,8 @@ union pds_core_adminq_comp {
>>
>>        struct pds_lm_state_size_comp     lm_state_size;
>>        struct pds_lm_dirty_status_comp   lm_dirty_status;
>> +
>> +     struct pds_fwctl_comp             fwctl;
>>   };
>>
>>   #ifndef __CHECKER__
>> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
>> index 518f054f02d2..a884e9f6dc2c 100644
>> --- a/include/uapi/fwctl/fwctl.h
>> +++ b/include/uapi/fwctl/fwctl.h
>> @@ -44,6 +44,7 @@ enum fwctl_device_type {
>>        FWCTL_DEVICE_TYPE_ERROR = 0,
>>        FWCTL_DEVICE_TYPE_MLX5 = 1,
>>        FWCTL_DEVICE_TYPE_BNXT = 3,
>> +     FWCTL_DEVICE_TYPE_PDS = 4,
>>   };
>>
>>   /**
>> diff --git a/include/uapi/fwctl/pds.h b/include/uapi/fwctl/pds.h
>> new file mode 100644
>> index 000000000000..a01b032cbdb1
>> --- /dev/null
>> +++ b/include/uapi/fwctl/pds.h
>> @@ -0,0 +1,27 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/* Copyright(c) Advanced Micro Devices, Inc */
>> +
>> +/*
>> + * fwctl interface info for pds_fwctl
>> + */
>> +
>> +#ifndef _UAPI_FWCTL_PDS_H_
>> +#define _UAPI_FWCTL_PDS_H_
>> +
>> +#include <linux/types.h>
>> +
>> +/*
>> + * struct fwctl_info_pds
>> + *
>> + * Return basic information about the FW interface available.
>> + */
>> +struct fwctl_info_pds {
>> +     __u32 uid;
>> +     __u32 uctx_caps;
>> +};
>> +
>> +enum pds_fwctl_capabilities {
>> +     PDS_FWCTL_QUERY_CAP = 0,
>> +     PDS_FWCTL_SEND_CAP,
>> +};
>> +#endif /* _UAPI_FWCTL_PDS_H_ */
> 


