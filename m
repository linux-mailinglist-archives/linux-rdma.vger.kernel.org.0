Return-Path: <linux-rdma+bounces-7758-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9105FA35213
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 00:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 277F77A20B9
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 23:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C6722D79E;
	Thu, 13 Feb 2025 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1XletkFJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C32753F5;
	Thu, 13 Feb 2025 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739488741; cv=fail; b=sw7uWCx17K10ch2kjWotxtX4rrQPIB1uaNn3A/UFLHn/uVLPBE2/OICxaQxn19aEs5I240M29J+p+UiEy7+eZXZQ9SGYSGAgo5cu/7sFxZDrZFcdTxgOaF2ZQZI0mX7ieRTUbNafzScACevpTvXZz7Ju/m+MBHHat9pIEzUoqBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739488741; c=relaxed/simple;
	bh=L7A/HYYfJk3Yf9EsWZWB0kRpVWPaZ/JdRke7Gl5iM80=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bCjA4QFJAevdRmJ8eL8WRIjozo/+ni9YF99f3DhOVbOwnfYfo7JcwCR6gyXfQebGVfbcS2I7nWHLRs3IXM9v0l9W7jVCPBoU6SINTlgd5RjuFvJtwuJgYDZEIF0661i9WgFQOAbry8x4tY04MAmvpKbZ+ot9pEcgGG4ZprbgJjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1XletkFJ; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wseArtg847/S8oiFzEi6L6a/2iNd32z3SmAFRV6n9eN6dTP+d6lMxPfuKbqQxGpA4o8IujIFlyldJzKNuFvaTUTUlg8kA9JH7hSo65lyruU3fmy9aH0sG4M0VG6dJn1KlXOrAcleY+x0ruPs7WDUElnXqvEBw8es0+eWTVmUA5ym5qVwcQAcXMhiuRocvVo55qSaV/q6XibtKL1KfnVRR9sUUkrARcbMFShTNxIxw53L6+WXU+goyzQruwrqxS6rVw2YCwpqpHW5zEzH9DXlX22b2eItlJwbMYj9GklOz8PL4tQ2ULaTIQGFQHPHXGen2+OsC3I8kOe1Xmrfv/tmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=252T3R5dhPxTyOgMU5EwoVdjaFKoO2v24RLKiTUaUG4=;
 b=TMv/ywxUfowT+Ab2zU/eHpE8boJe1D7ZmdX+i/LW+CACkGxOVy1m/uGnolymVXW28Q+alRr9ldL7iVwno0d1PAAlyWjqTsEvG3a3SerbJdtys5hI+2yIYPygPEDP05x2lZ2bO3CK/5pB43dlv5jDt12YVt2PCXJVbpA5GhGszuPPl2LhD4BHnuJeNeMsYMyFIBlCAw/5AfQlqJtQ8ksEiO4/tClat7iXasJrk3FSeo/u3dTmFlAj1ppER6raqLxBudj7pMcGvX4R8sSRi8s3AMqeMUg/VZByX0bIfapXYxi8WLNV3dkOy+ZfWTZWBjtqmQt56VjO4gjjOnPJ7eQdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=252T3R5dhPxTyOgMU5EwoVdjaFKoO2v24RLKiTUaUG4=;
 b=1XletkFJjfP4LPUOjqLNlWcyJ1z6cMsq0InG2QMZ2gvK25gilB7qmw8NRy+3wgS6Bhbhz9yUlQ8xQFZJt8QzuKISCG/OVr8dIVPhMEagZHh8kOIQ1Mea1KDLLgaErMLKtSIzqU/xLWbAZJq6XI5tyH84DIq4vqzYnMbImjS7HGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.19; Thu, 13 Feb 2025 23:18:56 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 23:18:56 +0000
Message-ID: <cdf30ddd-6d88-4fd7-877e-1a15a7cc5ec6@amd.com>
Date: Thu, 13 Feb 2025 15:18:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH fwctl 5/5] pds_fwctl: add Documentation entries
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gospo@broadcom.com,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, saeedm@nvidia.com,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, brett.creeley@amd.com
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-6-shannon.nelson@amd.com>
 <20250212125149.00004980@huawei.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250212125149.00004980@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::14) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: f70c0f3d-2a76-491b-e334-08dd4c84c9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjJxa3dONkgzKzZIQ1dxQ2hHbXJpV0FXdUd4MG9qQlE2NSt6eUg3TWNJVzNj?=
 =?utf-8?B?c1lxVzRyRklMQ2pNWUxoMnhlS0VobHIxcE54WUNxVDdFTnIrOGUxbGhzZTAv?=
 =?utf-8?B?NENQaTRuQlBWRWdyMU1ocUQzOWFYaWUrNVVtUzVweWg1Zk13eEVieHBkS1ox?=
 =?utf-8?B?MHZYb2d3RnBaamN6ZjcwWEFVVzl1MTNKN01sN25jd0g2NlRPUTk1emtvbDZE?=
 =?utf-8?B?eEVUdW9IbDZSVzE5R05ud3J3MzJxMC90bmJQUERLMlp6anpGUTlsNWczMmsw?=
 =?utf-8?B?bFhFR29ZdFRaQTJGM2N5R2tQVXNIVTRHK0djVUplYTBuei9FWDRBbzhBWEhE?=
 =?utf-8?B?TUs1K2tBdUZrRmtER0ttWWlIemJKQ1BqUm1OTG9rQzBUVndjUnJDWDJyV2VJ?=
 =?utf-8?B?SHZWRStIUlJ5eXVwUFN6SzlvdHlod3FFV2EyTXg0UExaSFBpVFJSTWpJc1ll?=
 =?utf-8?B?SkV5S29NS3NkVG1FeWxFbS9YdEN6QnB2eXFBL1RDaGp2dndPbStJalBBN3Rh?=
 =?utf-8?B?cHZhTDB3cFk4U3RLTDZhZXV3QUdoc2pGUVFzeXNlTFNWOWttNEx1MEZjWjgr?=
 =?utf-8?B?VTV4Z1dkd2pqbzVnUi8zMWhBdkpqTUFyOWZWK1RQejJjYldqRkJMN0dZbk9Q?=
 =?utf-8?B?R1VCWEF0ckhhNjJLOFc2UFRlRzYvUnc5RnVpNm9oaUFJeERLZjVKUW1CWlpy?=
 =?utf-8?B?SHBod2MvMzZuNG1IU3ZuOVZGdGZxOVJncnBUdFhjSHQrSy9PcDU4TzBiQ0Nu?=
 =?utf-8?B?TlVyKzVodHREN0IzYXpXSXp2ZitrYTZpUFNWS0lnUEVoSlVYRDQ3UFd1Yno5?=
 =?utf-8?B?VVJaU0hLU1VmeTQvTkRUeVZkZWhMbFlHWlV4ams5MXpiK2RwS1JpTXhvbHdl?=
 =?utf-8?B?ZnI5NUZqVExYcU52K3ZlOVVrek1kdTgxZEFBWWNJRFdQc2d5TGVmditqWGt6?=
 =?utf-8?B?KzRnbzFId0RSdStHdlVpQVUrb1V3ejZNWHVWKytzdCtEZUg3dUlsbVlmUHha?=
 =?utf-8?B?d1FjT0ZEelVpNFhFSWcvV2ZmMUlIYnRTTysvRVloRCtKSUxraGpielBQSXZv?=
 =?utf-8?B?dXFCdnIvWGw5clNkTDdnVFFBNHFQNW9ZSzFJaDNOcVR1cUZBSHRZUHBJd0VT?=
 =?utf-8?B?ZE9Kd2hBVFNDdGc0WDVCeElQNWkvS1c4UHRCSUEzSWU0aVJycXMyczVGZUJD?=
 =?utf-8?B?a2VHbDcrZ1hDTnhtbUlBS2ZYclgvcFA5UzlPSFhnNERrcE1xZVY0VXlybGE1?=
 =?utf-8?B?ZWxLdSs5WFVpVHc1MGZJZyt0MTM5QVhEREc0NEFUREdRYnA4UExKTFhpb1BI?=
 =?utf-8?B?UXkrMDg5UTJzQ2N6WjA4YTdKeHZVaVRWQ1hLa3lYSnRqdUhwek14dVpqZFV0?=
 =?utf-8?B?VUFTQk9FbmU5NFp1OVZVbHVpZDMxS2VzYjg0eXFWeVBBT1I3NU1uRlY1cVRr?=
 =?utf-8?B?S2lkaGpGU3NUZTVaNXhtQnFETVkybWxFZXpYMWd5YmRMdkJIMEF1VlhqMExH?=
 =?utf-8?B?c25HamNEUVJoakNzY2kzSEZCb2JXMHlBOTI0ZkhKL2ttL2tNNWV1UkduUito?=
 =?utf-8?B?MkN1dVQwTkw4L0hObUx5QmNwbmZhbDRSbTd0aTRPZk9YN1o3YXBHK1c2U3N6?=
 =?utf-8?B?VFBYbEIzc2QzWm5MclBzZFJFUlFTcjZVMHpzZElKNy9lZ1JWeDY0TmVaU0Q2?=
 =?utf-8?B?b1kzTkh0dWRwL1pyMjNIbnZzbzNuU1ZYWC92ZjZ3WEwyMHJHUWpFelRGT3Fv?=
 =?utf-8?B?U1ZNc2drVzBsNG5aZG1rTDFFekhQUkgvMkFKMldkQWo5dEVzVDRRbTE3SEpq?=
 =?utf-8?B?Y3ZFdzd4WXF6cFZSQ0NRd3pQVS95REVmK0ZnVHNjR01ydU5TWmlSSG1oZk5s?=
 =?utf-8?Q?Z65GqH74+Evz0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzhLOHpLSHhqbnM4QVVjd3VVU0NNdFY3QjU4QVRNQjNzVC9HNEpHZ3d3OHhw?=
 =?utf-8?B?M2lKU0hSMzRrZDQ2UDNGZWNueVU0RW9RM3RselUvcmJRckdYUFpoSDlldzhl?=
 =?utf-8?B?Z2M5OTJTZEozblptYW1EaEFNSGVCUmRWMGRQU21MU1MzQXZDNHNYZk9kM2Zo?=
 =?utf-8?B?TkV0STZLcFlDSzRySTVVenovZnlIV3NvbWE5NU9DanN3WUFFWGxFbFZSaUFp?=
 =?utf-8?B?aUxKMzMvdVB0dU1IeW5nUG84SkxoS2tZejc0Zjd5bWNIUjRzdlhyakpQMGdU?=
 =?utf-8?B?dUhwVUxaUEtrcm5DODVzTCtEcHZqMEhaOHZOcnhlcjAwUjR4Tyt1VXJEMDkx?=
 =?utf-8?B?YWw1YlpjQTdpMFBjckMyalRvWHBxM0diRE1HTk9YaHkwcFZwYzcxaHlLNm5G?=
 =?utf-8?B?ZURGQzdYWGI4allqS08vdGhwOGtnQi94UFl3U2VJL1ltWHA5ZXJyWFZzTFJM?=
 =?utf-8?B?TDFEV0tCMVVPZlVReWV5MUZxV1NuK25SZEdsemg5VlpXVk5DSUxFWmVoSzF2?=
 =?utf-8?B?MlE0RldGU3hES0wxR2pCbFpZYzY0Q2pTQ0JoTTFyVU43RmV6cENiM3NRZzdu?=
 =?utf-8?B?R0RsbHBGeUhnR0Z2WnlsTDYzRVgyVmNaLzFnam4wb3RoKzZjYU9GdEd3eFZI?=
 =?utf-8?B?L1MrQWI4bzJjTlJ1NmVtVmpQSExsSVJyRlZaTUcyVlZPbk8yM3FBUHJkUHRH?=
 =?utf-8?B?WXVjZHc2WWpGQ2VpYzFOYjB4YVFEVWl4ckFvTXNXelRadjhLQ1Z6SjFqS1ZO?=
 =?utf-8?B?MFVsVW1lenltL0p2UC9nT1E0VjJGUHkxTUh1MzRNUDNDSTVTSlRJdElZeitF?=
 =?utf-8?B?bVdoQkNqVDZHbDloVGJkdUZUQkR5ZFNUMzltMDRZazR4MFpUaEEvNTNwTlND?=
 =?utf-8?B?bDhCOHc4NGNlTWVnK0Z1amVqT1ZxQkpmNHJEbHZDbThkYmNpWDRybkdabFc2?=
 =?utf-8?B?UTJtZTJmczFyS1BnR1ZrUnlUQUVNNm9tNjR3ckJ6VFZXb1R2cTVHR0JoS3ds?=
 =?utf-8?B?QjNlUUVIeVBkL1E0Y3BDSlRQT0Q1TU42Unh1TUg3Q1l6d0FaT1hSQ3NkNzhH?=
 =?utf-8?B?WWdITGV3QWxwYmdVYWQrUEY2UitWaTJBbTVCZUN4TnhkM1I0QUpkL1UrSXpu?=
 =?utf-8?B?S21nL0Z0cEZqUm9rVlRqeHFqSHlpemhvSXpUT08xc2dab1k0Zk1MQ0hJRUh3?=
 =?utf-8?B?MndFWEgzS0NMWExKN2hTTDZBQ3JFb3FDYVFJWW9pL1ljdlAzVTJlejBsM0do?=
 =?utf-8?B?SXJYSUVnQk1hekVtZG1UTysvMFJtZEZBQ292VmlJNFlxd1V5Q1hEZUEwRTlS?=
 =?utf-8?B?bDhGRGJ3eUsrblcyZWJUYTNobkMvdHRhTW8zNzZ1WXBGNENYTzB1L3BTVzR1?=
 =?utf-8?B?QXVySVRiM1hEWVNQTnA1emtYS210TDdQZm5XVThpd1NRNEo5dmEwdDNYSm9s?=
 =?utf-8?B?dFBoUnJydXlVNnBhWnoraCt3c1czZ3A4RnZPeVNWV0JaZnpOeURKWEYzQ1Zs?=
 =?utf-8?B?dEFTM0Flc3ZJVXJKakpPcGhlZDkzb0dqQ09RaWx4NGMvbXNJQmRmWkN1b2do?=
 =?utf-8?B?aHZKam9idUpKZ3pzaG5lMExUZDlBZGllODc3UDlRZWpRVDgrc3htWU1TcWNx?=
 =?utf-8?B?OEVURlovMzRucjR0a3pZLzE2NmRHU3hFcSt2R2dGMzJaQmhSSDRmZnp1YTlh?=
 =?utf-8?B?MlFTUnprK2NyempSbkNPRVlDemFPY3Buc2tDeDByVWo1QnRiNmZxb1FEL1k1?=
 =?utf-8?B?TnF6N2xNL01KRzJFL05UYUlJOFFuQlBPeHV1dE41a3NlWmlERjQvMVc5OXhr?=
 =?utf-8?B?WXNxaXl2dHpBd05oLzQ3c3pWeHZXWEwwOUJYWjBadjV4V01Ma2cvTlgzaDRE?=
 =?utf-8?B?bUdCUVk3TDZkcGc1QTgrd0cxeUlNYlo5SEU0aWRndWtISFpZcWN2cXdEODdO?=
 =?utf-8?B?R2ZCQ2xKcFNJNlIwZnBSRnZUUS9mY2psNkthMm1LTGErSDNtUEhjS0VzZlZD?=
 =?utf-8?B?YmJnUnJiTTFMYWRZVEIwT0NLUitMaWlRUUxERE9oYVlIbnBSaTh5YjdVWk5a?=
 =?utf-8?B?Vmlva0ptU0cvSlkxNGJMdEc5OGdXVGZsdUdPL1lkcyt0VFJVcFdZNEorZEE0?=
 =?utf-8?Q?2mXAu9ZjGKDKZfk3nFlqJQI2X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70c0f3d-2a76-491b-e334-08dd4c84c9e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 23:18:56.6428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5s0rOZuuHLnOLslI5Xv10yQf4efehNES3iJbB7FJflIN16bTz9c+oZf9s+vl5qATmTj+gooW9rGdzN3Oqmui9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826

On 2/12/2025 4:51 AM, Jonathan Cameron wrote:
> 
> On Tue, 11 Feb 2025 15:48:54 -0800
> Shannon Nelson <shannon.nelson@amd.com> wrote:
> 
>> Add pds_fwctl to the driver and fwctl documentation pages.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
>>   Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
>>   Documentation/userspace-api/fwctl/index.rst   |  1 +
>>   .../userspace-api/fwctl/pds_fwctl.rst         | 41 +++++++++++++++++++
>>   3 files changed, 43 insertions(+)
>>   create mode 100644 Documentation/userspace-api/fwctl/pds_fwctl.rst
>>
>> diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
>> index 428f6f5bb9b4..72853b0d3dc8 100644
>> --- a/Documentation/userspace-api/fwctl/fwctl.rst
>> +++ b/Documentation/userspace-api/fwctl/fwctl.rst
>> @@ -150,6 +150,7 @@ fwctl User API
>>
>>   .. kernel-doc:: include/uapi/fwctl/fwctl.h
>>   .. kernel-doc:: include/uapi/fwctl/mlx5.h
>> +.. kernel-doc:: include/uapi/fwctl/pds.h
>>
>>   sysfs Class
>>   -----------
>> diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
>> index 06959fbf1547..12a559fcf1b2 100644
>> --- a/Documentation/userspace-api/fwctl/index.rst
>> +++ b/Documentation/userspace-api/fwctl/index.rst
>> @@ -10,3 +10,4 @@ to securely construct and execute RPCs inside device firmware.
>>      :maxdepth: 1
>>
>>      fwctl
>> +   pds_fwctl
>> diff --git a/Documentation/userspace-api/fwctl/pds_fwctl.rst b/Documentation/userspace-api/fwctl/pds_fwctl.rst
>> new file mode 100644
>> index 000000000000..9fb1b4ac0a5e
>> --- /dev/null
>> +++ b/Documentation/userspace-api/fwctl/pds_fwctl.rst
>> @@ -0,0 +1,41 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +================
>> +fwctl pds driver
>> +================
>> +
>> +:Author: Shannon Nelson
>> +
>> +Overview
>> +========
>> +
>> +The PDS Core device makes an fwctl service available through an
>> +auxiliary_device named pds_core.fwctl.N.  The pds_fwctl driver binds
>> +to this device and registers itself with the fwctl bus.  The resulting
>> +userspace interface is used by an application that is a part of the
>> +AMD/Pensando software package for the Distributed Service Card (DSC).
> 
> Jason, where did we get to on the question of a central open repo etc?
> 
>> +
>> +The pds_fwctl driver has little knowledge of the firmware's internals,
>> +only knows how to send adminq commands for fwctl requests.  The set of
>> +operations available through this interface depends on the firmware in
>> +the DSC, and the userspace application version must match the firmware
>> +so that they can talk to each other.
>> +
>> +This set of available operations is not known to the pds_fwctl driver.
>> +When a connection is created the pds_fwctl driver requests from the
>> +firmware list of endpoints and a list of operations for each endpoint.
>> +This list of operations includes a minumum scope level that the pds_fwctl
>> +driver can use for filtering privilege levels.
> 
> Ah. Ok. So the scope is provided in the replies to these queries.
> Do we have anything to verify that today?
> Also, I wasn't sure when reading driver on whether the operations list
> is dynamic or something we can read once and cache?

We request the operations list once on the first query of each endpoint 
and cache them for the next time.

> 
>> +
>> +pds_fwctl User API
>> +==================
>> +
>> +.. kernel-doc:: include/uapi/fwctl/pds.h
>> +
>> +Each RPC request includes the target endpoint and the operation id, and in
>> +and out buffer lengths and pointers.  The driver verifies the existence
>> +of the requested endpoint and operations, then checks the current scope
>> +against the required scope of the operation.  The adminq request is then
> 
> Spell out admin q (or is that a typo?)

The "adminq" is the particular object name, so I'll keep that, but I can 
certainly add a little more text around it.

Thanks for your review comments, we appreciate it!

Cheers,
sln


> 
>> +put together with the request data and sent to the firmware, and the
>> +results are returned to the caller.
>> +
> 


