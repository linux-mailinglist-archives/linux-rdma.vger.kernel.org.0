Return-Path: <linux-rdma+bounces-7555-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB27BA2CE1C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 21:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E93E188E721
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 20:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5061AAE08;
	Fri,  7 Feb 2025 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dc+MdESy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B51A5B98;
	Fri,  7 Feb 2025 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959935; cv=fail; b=IjPucfX9bwUfI8g78uJn6ikAKxzjeAdWzXajYn5ph+RgSogqZKAOS0NwHdsEVbJE9npXCrH30F5cgvBIgCl9pIC77cFxdysCtCEAUjF2MnqhwqPibQZW0mb7Qd6/0NrqRZQrduqFkTpru87wT7UG7aMINWg84pQWG9mpq6G7Jqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959935; c=relaxed/simple;
	bh=NcebqMVSpYyftO2F5ujox1OnQQbOK7SopjCfGnnODjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HDNzlgD6uie2AuxHxPQ7+FHTuEo/XJtAvFAlSbOuhzur94vySO44wArWXuQpJD8UR+j66If3+LRrZnSC+FBdZKHPqEVmhpg9xZ4XlYi2qMYlBSz9Heq3M74dYL7Qhvzgs2Tu5ZPqPfvfp6AYVF+GdsxVpH2xeRF7EuTOZAwez94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dc+MdESy; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlFv7BnnRTh2qeYS8FYJAX/R2Uxmb/FB9ENvMz2NnLTeCIetopRByqWGc4qxGmLNtQhYrRTdCSkXtT39PvKSM+tg4uFdwQ2zpjohakhxwgNTrxk/2uxf30vaAz42WTGTbZ5+lbQipJAqizaveuqeQFHCi06+1QtKqXAQ1l3bKFSpnqpjh6Oxl18BeRvpzpUg/imngwqAsKYJzL9FIW4Orv4wEb1830sAds8QwXMGkJQjHSQqa4DbLZO0vmFkYwn96swWwkAnluYh6kIVeOEDI9uIxyMGg3Vrhmk5+FfklTyk2wfOUMnLvIC4n6W8L4KjVzqG08/ufVD4kfLUbqUloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6g1K1Bkcfq2rbVlEEJnPYPi1PKK4SX8mNBJoS9TBmo=;
 b=y9/iCxJmHhFFPzahKcIxq3Y9LeVw/tWX5Lzcfdf3zcnsZjl004t2HCUK0KF+BO7iCbYL+Mr0F4GTlw4ZRkcpEAd8eORgKUo30UfVxe4bp1WTuDy7vA3BNz4Ahld9N3zAqASWZU3L6SwIC20P9TKt5jg8rPG2lu9PofTkaQ3pLcexuTv6+vBbN7hP+dLHgxqIPtZfcev6p9zO2qTcw86neHIOkAQSydkTl0GywwlWU4s5Gk5lRsC5dvnC4z3Xf0u1dczC/AOTNSXBoJLNAoTqeWyZ+4VAgQNTbzbfySTdZGvXKVXlBJU7fsPyxuRXJrMxfOsbrFWfzx3QYCzJv1OJWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6g1K1Bkcfq2rbVlEEJnPYPi1PKK4SX8mNBJoS9TBmo=;
 b=dc+MdESyVLOb0f0Kiy0q1eEYfsm8izQX8dCpz8JlmC3tbbr1ykukbhdr3+2N+8lrc09lKq2T9sBJ6iahgly6jyop3B0K5BpF0t/5IT6kE3t2ZKTnBdUeDVfo1h86/ebcT6BoCJrEkFaPei6Qs4gbSLj6SeGefV873H5ZbpyPF+UhjPBGjM7X0/w33BsKEK2Vzs8lEw3Nb3M78lhTHPrYQk+FEv/+eZtfwV/M6ZJ67SoMYlmlDtKAxbQ723pWhHA+VZCJChbvTfp9CWOTPD8h+4ClSGoZtgnvDqy3V1TW7r37pzXU0TD1vie1hNJ3R2BRii7Im1ePSkH2PKhzssz8SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Fri, 7 Feb
 2025 20:25:31 +0000
Received: from IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12]) by IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12%4]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 20:25:31 +0000
Date: Fri, 7 Feb 2025 12:25:28 -0800
From: Saeed Mahameed <saeedm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"Nelson, Shannon" <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
Message-ID: <Z6ZsOMLq7tt3ijX_@x130>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org>
 <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207073648.1f0bad47@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::9) To IA1PR12MB7663.namprd12.prod.outlook.com
 (2603:10b6:208:424::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7663:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: e06d2957-c085-4d22-6bf6-08dd47b5913f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzNvaWdMcHErSElzTmhLbFo1VGtMWENnN2k3OHB5anNEbWoxU3hUb3lYNzBp?=
 =?utf-8?B?RHpsQXplbFdiY1VXWjdnd3dER29sSWptUGVheDZldW9Sc1o3RnlKZDZtMDh2?=
 =?utf-8?B?blM5aW9RMGNXc1owZy9MandyWHk5M1NsZk81cm5pWVFJUC8vNWNBWWt6WjM1?=
 =?utf-8?B?MElBWDFyWWlkWEc4aWgySHh4OEFBVWJaeEU0cHFYMUtqU0g5NkIyWWFhdkxy?=
 =?utf-8?B?cUk5VzRyRk1lM0x2R3lMWnRURmRBSnI2NDZjcUNIQ2czczlNYVhsc3hickZG?=
 =?utf-8?B?emFraXdWOUN6YTVqYVlTZk1XUzNIVFZGcTluS2UxSzlYNHUzeldqZndPR2ZV?=
 =?utf-8?B?VUMzZUFYUldMTEVqM3kzZmx1Y2NTNnVSd1F5MjhOQWpjNVdub2lRVnIxaVE4?=
 =?utf-8?B?bjVsRWtTZHErSmNZYzlZblNjNUYrSjRZOURsMklZYTQrY1pSdkp3V3RxQy9P?=
 =?utf-8?B?OStKVGkwSFE2WG5aQ0xwdlNPS3g2TG9PVm9UNEllTzVvcnhkZDdpVkl2YVZL?=
 =?utf-8?B?SlJ0bDVHQkVPWUF3YmE5bTdkWHBKaE1Tc2hpUlc0MkxJWnBmUlBTV3J6REdw?=
 =?utf-8?B?dXRmMklLMUQ2ZzZGcXEveEo3YVkyTTRDZWhCSjRlZEMyS3dRRnlrWjJuWk1L?=
 =?utf-8?B?WTFIYkgrSHl6NUtaYkFJb0xuTXdTRjZVelhuQVYvSkNzT2hHM2dGZUdOR3BQ?=
 =?utf-8?B?UjZsRlhVeFBUSnluZzJDV1JCUGxNaUpVSVNBdWtmTXdDbC9CQjFrS2tsVVkx?=
 =?utf-8?B?S1M5aDM5dW1kUytzWVQvVVV2RnpvWHZXUUxwZDdabnVwbk1VMGx5Q2ovOEJo?=
 =?utf-8?B?K1kzNEE3SlZlajZ1T2VEUTF2bVc2V0NsckF6VURjUnhHbmJZcVo2UStCRHFE?=
 =?utf-8?B?WEhnclBHSlZobGZqZU4rbGpoNURXMEh5Wi9MQlk3cVlpTnNpczk3N0pqU0dZ?=
 =?utf-8?B?eDlpRlRua1RjSmZydXZCVFhOdG5HUVFnSDViejZRa3F2eDRUYUNUeDVYMjEw?=
 =?utf-8?B?WXdxSlJqbjhpSkJpSkZBRThMbGZvaUExK1I5R2U5MnNhNGxrTmdnT1VkOGxU?=
 =?utf-8?B?ZmRSdUxmTU12dEEyT3d0WTNSZ25jb2t3NndPZXZ0bnBMVGxrSy9qVndob3Ns?=
 =?utf-8?B?OVNuQmhiTHFla01GZnM0aThicENLNG93VUEyYTJNVk04MkhwRUxCcVE4cU5S?=
 =?utf-8?B?R2M4OWpFcWlPMU1rL1FML0ppakxhT01XMTJwUXR1aWNGdEhuN2VnOG9UMEdW?=
 =?utf-8?B?cEFYVzNlYlZWb25NcHpMU1ZmNFlxTE9aY1NJWEN3d3FXV1pFdW9zNVFaQnJN?=
 =?utf-8?B?eTNuNC9GVVpYdWprV0dPSGRTZTNNVDN6eFBsNnhUdlFPNTJrTXVkUytnUDVV?=
 =?utf-8?B?Z0FZSWR5VWhFMmlCWlpsbXM1QkFtM2krRXFIcDRkVHlubFRaNXd1Q0xWSmFD?=
 =?utf-8?B?VGdYTmVWcjZNS2tITGtVcy9DZ2NaTkZIekllbnR5a09PTml3TkRUU2ZuNFNv?=
 =?utf-8?B?Z09UMWxpejIvMDQ4VDByRlFrTmRUN3pHMmIzVThEc2dyTE9GV3cxL0p1NTFk?=
 =?utf-8?B?ZldYc2h5QkxXN1d0K29veERNaU5rcC9ZMVRNSnMxRDFzYjJUWmZuSDFTNEYr?=
 =?utf-8?B?Z01xUGVsaTV6a0VNTDhBU3hHenRTZTNLUXI5WTFhdWxXQ0N6UDJkWEl4bHNC?=
 =?utf-8?B?akJVa0NLMFpyWGh6RjNieUFyMmwwOWJZZmt5SkhyV2V2UUFIL3E4aEIyOGdB?=
 =?utf-8?B?VFUzYXNwZU4rbkJHeUx5WWFlQkJvT3hwT29KVjE2SkJQdUpZQm5JVmxYTWVQ?=
 =?utf-8?B?QjZ2aHU1YkVRdFhTMENmQkt4ZG02cXBtVzNXYmg4RTJGLy8yS3BEakczTzAv?=
 =?utf-8?Q?MaWbXlXHVSFR1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2dwRG56dU9ETVV0VFo4NU02SjhSZEFyaEFHSHROSUc5ZmFjK3lRbktLRkY0?=
 =?utf-8?B?ZmRSRHoxZlROYjVqUGFTUnpUaDdpLzRwYU1QWXNTdUNuNzRaREcvUTBPUzhZ?=
 =?utf-8?B?QU5NQ2lsRzlXRE5MV3lUbVdtdUIwbDFEdEZ5ME5MdlF2emZZSUJ0cmVqaVZa?=
 =?utf-8?B?RkJPa2gxSDJNOGsxb3pWUExRdElQTU81UHBHZ2NaMHA4N0ZiTllFRXpQR0hP?=
 =?utf-8?B?RTJDd1NWWUN5UFpUUENhK3BKRmpYazAwTER3RGt1Q2NTQWplcjdvUWVpd2tz?=
 =?utf-8?B?MHlkUVdzUzdBSXJVc0cyWVVUbUlMZkJVeDNCazRHdk9jeDJXQ0VvVUx0eXdL?=
 =?utf-8?B?VGduSDhpSHBzT3NzUk56cGl3cHJUQlFnMmFKMHNFRHNydlUxSE1ldFVaOERV?=
 =?utf-8?B?VFpBNitYTjF1ZitvM0RUWkwvRkFkOXduSHZBRm1QY08vNEg2UnFPeWlPNzRt?=
 =?utf-8?B?am1kY1lWd2x6TTl4ejZva0RTcUhObTNQam56aU55WTh6R3R0UVdEc3JxNkor?=
 =?utf-8?B?NVNZQWk4MjhEU2ZIcE1qVmEvbnVKbE9aUnV6ZnZtNWNTaGtrQ3M0Z0N4SE1r?=
 =?utf-8?B?YzZXeDU3aitLeFczOVIwY2lpZWg2bDZ2aVAza1BDSDc2YkNabU0wWThyUWdV?=
 =?utf-8?B?cnkzeENWWWtlMzF4Qlk2bzh3T0JhRWUwMEZDZGdua0t4WkZPMm1lZzBLL2ti?=
 =?utf-8?B?LzJ5N0lKbTlaQS9vbUhDMHFRcXIrRVV2c1hFaUdMNGoyOFNmcDRJdHp5dm51?=
 =?utf-8?B?T0VXYXBkMFJNWGs5VHRMWWE0SWIrRnFxazFNL2JLNFVEWVZQb1FsMVB3bjdj?=
 =?utf-8?B?ZTJ3NTB3WkQ0bXNOa3Q2UkpseFR1MC80eUVHY056Nmt6clgzVGRoZVJvUWRG?=
 =?utf-8?B?YmNKVXZxNU5xWGdjZFF5TStZTTJyRGg0SlV6WmlVcjNPSzZ2UTdTZVRJRU1B?=
 =?utf-8?B?Y2tKL256WnNFd3Y1SzRTRzdDQnIxOVloVEdQSXNlQjlHQ2JWZ0F6ekRlZWxk?=
 =?utf-8?B?ZkZzMW45NkVDYjRkZ2xFNFJKaXVYWEtJcFNxRDd1TnVzV3lRb3IvYUVDQkpC?=
 =?utf-8?B?Mjd3clRsd0M3MjF0aWlhRkJ3WjhqWGxGY0c4c3lBdHpuUkZITE1vWnlTVG5k?=
 =?utf-8?B?V0g1WThJcFNCakM4cm5Ra3NudWdDK3BKQTM2bjZUVWJBbXEzSlhGMWRSYSto?=
 =?utf-8?B?b0FvTTVma2dyeDQwZTBGcWRtclpTOHRZUkg4bnY5YnVGUHhJblA0dDZ3bytL?=
 =?utf-8?B?RzZveW9SRXdpZ1BuaVJlVTJTMlR4YWhNUHA0cEdjbE9KdHNMblNOQUFnaDhy?=
 =?utf-8?B?bTlZbUZ4YTkyRTBGWThKc1FISUFMMExteFFGSzkzTUJsR3BNR3QxaXpGWFE1?=
 =?utf-8?B?Q0xuMlZ2cndVbklKV2F0NHdabEZ3REk3ZEZGQ1lFRktJNXdjUjF2dmxWSDJ3?=
 =?utf-8?B?M3gzbW9qOHRHRlB0SGo3bCtJNkIzRzE3L1pZaHQ3dkpXYTBXM3JwVm1KYmRW?=
 =?utf-8?B?YzdmUEJqWUVSMElrNjlHY3VzQnVQYUkzRTZmSjVhcFpIYjZvYzZJSHNsOEFi?=
 =?utf-8?B?SU8ySm5Tb2hKdGNnWVYwU1Jhb2lkK1A2N2p1clhzNEYzYkt2NXkvY0IvUjJ1?=
 =?utf-8?B?MERPU2tGODhTbUpiKzd5cWRpMnprSmYxYmF4dE9hb1IvSGZpdXArcUhSZHBN?=
 =?utf-8?B?MUtGa3VjUzBlcGtSdCtVSUNVRVdpUk5tN1FTWWgyQ0FXMFZzU3V5cDhoNyts?=
 =?utf-8?B?Um9WRkhZb0QwblZ4T1lLWmJrUGdUUXI3MDJhOUtqYTFlSitGdHdXVWJEY05I?=
 =?utf-8?B?RG1BblJadmFPS2g0NVVZbGpRUHBxNVA2ajFnMzlOcnhvQUt4RlR3SEZpTGN2?=
 =?utf-8?B?NHpWM3VndVBFaGNRbU5hSGovcGxQV3RVOEpGQmtWRGw3SlZsakZEK2k1Q2N6?=
 =?utf-8?B?ZGc3M1llS2kvdHA5dFlwTlFFN2xsWjdWQ0xJcW90dDRuR1h0SkxDNmVKVXpT?=
 =?utf-8?B?L2t5ZjhoL2RHWEd6MEJZQXZkUkUwY1lBRHVneFRmWG1TSUJZeUJzb2dCMDQ0?=
 =?utf-8?B?c2ozR1JwQXVubXZMVUxCMjJSM3dvdWxpR2FJYmx4eUwvdGowSDlrYTJ5cjNN?=
 =?utf-8?Q?LLURfP9F3PjsVNHQVSpCDrggh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06d2957-c085-4d22-6bf6-08dd47b5913f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 20:25:31.2687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywvwBThCNzHS52Wykszzhh5QuWnuSSdwavxEYkPkOqSI0wun/ZtofSqI+TXy/Ldn5AF0UQjatArr7bn7kTolqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359

On 07 Feb 07:36, Jakub Kicinski wrote:
>On Thu, 6 Feb 2025 22:17:58 -0500 Andy Gospodarek wrote:
>> On Thu, Feb 6, 2025 at 7:44 PM Jakub Kicinski <kuba@kernel.org> wrote:
>> > On Thu,  6 Feb 2025 20:13:32 -0400 Jason Gunthorpe wrote:
>> > > From: Andy Gospodarek <gospo@broadcom.com>
>> > >
>> > > Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
>> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> >
>> > This is only needed for RDMA, why can't you make this part of bnxt_re ?
>>
>> This is not just needed for RDMA, so having the aux device for fwctl
>> as part of the base driver is preferred.
>
>Please elaborate. As you well know I have experience using Broadcom
>devices in large TCP/IP networks, without the need for proprietary
>tooling.
>

I think Andy was referring to the fact that the aux bus management is
implemented in the base driver which is currently under netdev stack.
fwctl as well as netdev/RDMA are aux drivers sharing the same base "pci"
device. So it's not part of netdev TCP/IP, due to fact that the pci base
driver is part of netdev due to historical reasons, driver developers
have to go through netdev mailing list to review pci/bus/aux device driver
patches, which has nothing to do with TCP/IP. If netdev doesn't welcome
non-TCP/IP patches, then I think we have a bigger problem here..

>Now, I understand that it may be expedient for Broadcom and nVidia
>to skip the upstream process and ship "features" to customers using
>DOCA and whatever you call your tooling. But let's be honest that
>this is the motivation here. Unified support for proprietary tooling

DOCA doesn't need FWCTL.
DOCA and DPDK has all the support they need to configure the pipeline 
and their own transport without FWCTL. This patchset has nothing
to do with DOCA, this is pretty clear from mutli vendor and
corss-kernel support for FWCTL.

>across subsystems and product lines for a given vendor. This way
>migrating from in-tree networking to proprietary IPU/DPU networking
>is easier, while migrating to another vendor would require full tooling
>replacement.

This is old netdev mentality, we must not apply it to all subsystems.
And I don't understand why tooling has to be standardized in-kernel-tree?
We have plans to standardize tooling in user-space, this was already very
successfully done in the nvme-cli..

>
>I have nothing against RDMA and CXL subsystems adding whatever APIs
>they want. But I don't understand why you think it's okay to force
>this on normal networking, which does not need it.
>

As explained above, netdev doesn't need it, but netdev subsystem also hosts
the pci base drivers, so you are going to see fwctl patches the same as you
see rdma and other non netdev patches flowing through netdev ML.

>nVidia is already refusing to add basic minoring features to their
>upstream driver, and keeps asking its customers to migrate to libdoca.
nVidia is one of the top contributers to netdev, we submit patches on
weekly bases and due to netdev mailing list review backlog and policy
we barely make quota, so please elaborate on what features we are refusing
to do ??

>So the concern that merging this will negatively impact standard
>tooling is no longer theoretical.
>
>Anyway, rant over. Give us some technical details.
Technical details: Driver specific aux subsystem implementation is base 
driver responsibility which is hosted under netdev.



