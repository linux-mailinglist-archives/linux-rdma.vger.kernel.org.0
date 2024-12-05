Return-Path: <linux-rdma+bounces-6264-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08159E504F
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 09:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668D9285C70
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0AF1D461B;
	Thu,  5 Dec 2024 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3p1v9o9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5307A1D0DEC;
	Thu,  5 Dec 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388830; cv=fail; b=DaDAfD6Hue3otO446L0cHsplOXfOmZLdscNw+FtVTTFrRI+galbYHHFcvqyEjQFo22ptbzZmmnRtZLc2lZq5+vFeuZGo+qhUpV5NDutmelLkOWTIi52eYsjIvgFWmFu0iTrZiTCHpw9ZTVrLNO+qgRg4MK210CJIhXtMl8j+GBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388830; c=relaxed/simple;
	bh=+K/LdK4niIHFK//75ONIOFYOZZgE7F8yA/O7+jLMr5U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pVAjEpdZpe1lJl2bDdmGwdbK3IP9GvhFS3eKbtHi2QSNG7gktZxhozACKIvCtVs4cS0I3PkkePrTjICkmacwjXmI3s8S8jcQt5hS//nAz8WHtzKLSlxsD0pF4wTqOv79qWo78wBt0rSjXtmNLahNht0jZu9w5FEzMLZuqm7j5u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3p1v9o9; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733388829; x=1764924829;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+K/LdK4niIHFK//75ONIOFYOZZgE7F8yA/O7+jLMr5U=;
  b=h3p1v9o9VOYISlQMYabZKi51DBpIhwr5HEI4U0CUkR6FFm+VIMsSR06/
   hOMIk0RmAdxwOBuQC6ZuquinK7bB6EfUyHJ0oSQk3P/VRCT+zoDYewdZg
   z8w3zDlbts8sAeOZfdjF5jFuq78a20jv+tMvJrk/Sn3iPX74jREXhm2Hm
   5bnh80D0lh/EOQoAWfBYlK9WyM03GjdvNd1DzRJpcoE6f99VWKnGT3b0J
   zjdTUMdaCcPPlOByFo3nn3qDiPYVsohjMEHN4OF+suyF1RI/Mhuvazpn+
   Lq8gKFo9S3RzgUyfo3a3Id1/xAaVJdqlDa6gQw8PYWcyCqz3CL4RXmp7K
   g==;
X-CSE-ConnectionGUID: H27fNd+TRiqtm8uKSMVQzg==
X-CSE-MsgGUID: NdkmAQ2fRziLUvty2P63OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37624622"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="37624622"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 00:53:49 -0800
X-CSE-ConnectionGUID: LEwcb02CR+K94rMW0zbchQ==
X-CSE-MsgGUID: NM/OwO1gStqClqgHGay5xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="99109776"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 00:53:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 00:53:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 00:53:48 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 00:53:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0ZRxRESjQ9lmkzBnpZqoyEEu/GvAKfQ8q11VhV7UYGxLE4l8TXRUh437+iFcvyKaqXV8qKiPdO4Unhygau7H0wKS/qwbaqkjpAE3nTqlVC7nM6zlEyTKzyjn8kcMX8InCdSwJdqjf9aA0qHRE77Q3Afbf9M0H/20rOY4O1dTIW24EeGAfc6Pqwv251Ssp8mtU2n88qViDwV7gH8VI4S1tG9VCsR3V1DdZLjBZHf3Di6GrYDCTxZdqc987olXtw8+0dWQ/Wh3z6FZq7BB+oVkld4GNm4AqoxFQPXnd6Se7kntDrGW0zldgDX1Ezf/SCIKz+YaMTZABnzh/YeTdlLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qXrR//5WvaXiE5bigVCrsYqFGeA2DapMY8k/OZsy5M=;
 b=rBmz4h0wPzJcbK4WBklIHqc485JqGDW0Z5/6XbN/Gef9DM8eWmqy5rEBJYSCZxnYs+kG5hoj2DhYavp3uBuXKTqYGFmTrICn1SWZ6LQ3OJiyY3Hobky14l8aXnsvKjphlttIsWrZRgOcpW0D+f14NAzAogb7T9d/1L+oJtxpd7EL41slZcNJ69fZvJCTHqNrOEtffIB6lVsG1W0F8Z6cvxHnBrEYje0/Ttj4LyXcMLjnRAxy9tdTKjDp5+lR1twGvBww8cw1O42x6O0Fq6wKZJOZEvZH9MFHrfwHD3qt2TkaCYsj81g/9F/NeX/oK0+RguaXLAs5nEFB8LkS3q7ASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.13; Thu, 5 Dec
 2024 08:53:46 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 08:53:46 +0000
Message-ID: <bdc31171-350f-47f8-abef-876e320b10c3@intel.com>
Date: Thu, 5 Dec 2024 09:53:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: DR, prevent potential error pointer
 dereference
To: Leon Romanovsky <leon@kernel.org>
CC: Yevgeny Kliteynik <kliteyn@nvidia.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Muhammad Sammar
	<muhammads@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
 <ad93dd90-671b-4c0e-8a96-9dab239a5d07@intel.com>
 <bf47a26a-ec69-433b-9cf9-667f9bccbec1@stanley.mountain>
 <4183c48a-3c78-47e2-a7b2-11d387b6f833@nvidia.com>
 <93a06b66-ab5e-4722-9270-cf892470d004@intel.com>
 <20241205083240.GS1245331@unreal>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241205083240.GS1245331@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0043.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::28) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|BL3PR11MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: decde6bf-10cc-4846-2722-08dd150a540e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3lvcC93enY2cmhYcXozMjdWOUV6Z2dvTWVkbmtzQUhIazVaay9Ha2l5YnhC?=
 =?utf-8?B?b2pOZVlIbHlLM0pad2YwYThYL0ovZGVlSGdIdG1kUmhFVzlURTJmTHh3TEI5?=
 =?utf-8?B?aXhXeUVZSmhiL29lb3Z3V1pqSGt1bHJRSWZjVkZDVkxNMG5mOC9STStzS090?=
 =?utf-8?B?bDdzc3pYRndUcjBkQS9sQUFGb25NaEJZODJEcnZwYTMzWTdNZGNXR2FkUWZ5?=
 =?utf-8?B?UEIzekNBOGlhbjluWFpONUxlVVBBNG0rNWlFSjc3RWxSd0wrR0s4elVDa215?=
 =?utf-8?B?SXpwNlZIMmxZU2dFTmszN3Z4b0swa0l1b2pnWXZnQU1hMWo2blFmUHdPWURu?=
 =?utf-8?B?WUxKMVhVUUMxajN4RGVZNU1FMHgwdXdjYzE0aVdVaTlmT3RBVkJkV2poQXU4?=
 =?utf-8?B?dThqby82c29nWk9ETHorQWd5d0ozN25nSlp5bHhXQjJzalkrNitvTlZEYTA0?=
 =?utf-8?B?bFNBbnZsRmtPcE9EaUJHTHhoZlU4UjU0ZjdBa3YxU3ZqYVN4V2hjSXlGNTh4?=
 =?utf-8?B?bEVKR3hqUXFWVmVBNFllcGlWeXBibDkvUVpxVHc3b1Fub1kzUzRjbllPUEZ5?=
 =?utf-8?B?RTFOTkJLTXYrSFJPVGVkMGt1Nk8ybW1GNElmdGJvVDdHZFNWOEg5N0J3Kzhk?=
 =?utf-8?B?VnN2RUZsSmd4U1Ird25CQnlsNnRFdkVFTVlFeXBkaVBRdFFaWEs5b1lBb21P?=
 =?utf-8?B?MlNkTHJ3cTZxSzZ5M01qQkk3aUZ4dlN4cmo5LzFvQ1JMeDFFcStBQ1UxTlBQ?=
 =?utf-8?B?Mjlmb0REZkNjdkNkMHZDbi9hYm0rYVJDR2lmNlRSSnM0aE5WaTA0bzB2ajEx?=
 =?utf-8?B?Yy93bUM0cjFqa2FQVVFhVmpkMzd3L0I0em9Td0pLRENEQkRaa0ttc2FVM1hS?=
 =?utf-8?B?eU5kTTNKc0h3WFRRV3N4RC84YUlQZWpTdVRNVlJHUkd5ekJTRlBUR2VleHBl?=
 =?utf-8?B?OGZkZWVVSXR6NzRwTzd1T0pRVTdZenlNQnI4VUpNUFU1UlFBTHJlc0c5OWpq?=
 =?utf-8?B?eHhQSDZHcldNczR0M1pEV3ZSWnhvMTk2YnVocTJZODRpSUtpL0txamdyQzVT?=
 =?utf-8?B?dEdyMDVsOWhJRDE2dnA2a0JCLzdpdVFWMm5uN0xRM3BVditMbVVIYUdaN0VD?=
 =?utf-8?B?ODZNUGovR3puUzQ5bE9GdFNEVW40QTByV3JwcHRxUWZqZFNzdHNlU0xUWDNJ?=
 =?utf-8?B?d0RFNnZ5ZExyd0ZMbVk0REI2NmVmbzN1eWtPUWxLTGlEbE1WcHNORlNtMGF6?=
 =?utf-8?B?ZWhWU1owYzVhMXlnQ2VpL1QzNTJsU01KWVFtSTY2NkhNZWZpOWtxQmUyajM0?=
 =?utf-8?B?NE1GTzlLQ3lOMzJHUS8zRVlHWHNIbDUwZS91NXhVbEV6d2ZMc1NLSnRWcVFH?=
 =?utf-8?B?SXJFMll1TU9xSDZ6UG5qVGxUN3dSdUIwakFyZk9FS1Y1VllBamNsMzBld0Mz?=
 =?utf-8?B?ak13MkczUHN2bXBxUHAzM2NaandBakFDemJXTWt6L25tWWsvYTl5enMxdWs3?=
 =?utf-8?B?dU8ycGhndGZRMHVuc1pCTStnaVU4NDlzZjh2eEdtdFB2b0ZSLy9rZkhOSnll?=
 =?utf-8?B?czNWNGdZYmtkWFRCTURxUk5WSmdnaFZuc2I0RDNaci8wN21DV3JJV1VkemRY?=
 =?utf-8?B?eEhNZUZIMkF1QmFmdlRxMCtJUVpXVThIZ2NSSmtsOStIMTJKYXNwcVdHQkNt?=
 =?utf-8?B?L29wNHJ6c1l4NjhjYkpQNmVETmRmOStTSkdQRkxiS0MzMTYxM2xyMVQ2Wjdh?=
 =?utf-8?B?M0lRbDU4aTRianQyRmRzRUJ3MUY2MFNKRk1IYjkvQkxwSXdDQ3NpTEQwWUZq?=
 =?utf-8?B?S0ZjWHhDVDFSeUxuU29FUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk1LaFI1cGpYc2xidEFYbTQ1amRTRVZ0TjBtSGRBeldkNk9oV2djWXVVUTRY?=
 =?utf-8?B?TENXOTdKOXcreXQ0c0pXMGhmbHhlbmcwc2FaaVRZbEFXWW9UTUVUeFhiM0Rk?=
 =?utf-8?B?aDUwaUw2T1RvMlNERUpENU42cEk0K1NQUnRINmI2RVF6RnJSWmp4U1VseHQw?=
 =?utf-8?B?L0JGZkNrelVTNkFhbnN0VFhlY0tPVFhiWmgrT2RnMTNsVk5mMFJiYWtjbWor?=
 =?utf-8?B?NkpEa3dHTUg4anl6dkRoNkRTWjJ2NWVRTU1WVm5NTFhhL0daSjcvOTg4Sncr?=
 =?utf-8?B?ZlBFcDN1T1ZydlRhRzdPNEJPaUZacnllUDlCbEdhbkpmbUR2Q1RMZTZWdHJn?=
 =?utf-8?B?V0dvUDJkdW5pNWVaZjhWWHdhQnV1RHBIVWlNTkVrWlRQWjNXNllSeU03dmZo?=
 =?utf-8?B?WmRkMHViSWZaMDdtSEM1WWg3QUhoZEFJUFdxREM2OEVBeVdyZzFFRnJZWTh2?=
 =?utf-8?B?cmZERHlxcGg5T3hPOWtxZ3VPQ005VFlyTzgzcTdOQWtpNHBZeUhkendCQi9O?=
 =?utf-8?B?T0VNWDRLcDlqVFZ6R0MwQ1Q2OFloOGxKNGJFSHJjSUx2cXNaQXlsSkNseVF4?=
 =?utf-8?B?Y0tSay9mZk1WcXBEVDI2cFpIMGdEY3R6cGNYUFV1UEVRYmdEdVRMU0YxWTBM?=
 =?utf-8?B?NFpYWk4zZmNJLy9EZCsvUU1mbml0YlhVUm1jdWdBT25rQ1pIK0FJTHBCcXRt?=
 =?utf-8?B?bmxOTUNQWFFpck90T0h2akZUTU1FRWxmMUZkN0kzcUIvcmhqUXBaNVN2NWo4?=
 =?utf-8?B?Ui96dlJ3S0FnSVdCZTEyZ25WYk9HYVR5b1RtNHBOVjdOMTJDSFlHSGdmTFlE?=
 =?utf-8?B?K1lyRmNDYTBJR1ZpaW5zL2NHT0NSdHNMK3ExTm9ROHFqYjJ6c051aU90R2Na?=
 =?utf-8?B?YVhaRGIyQW5COFV4T0VwRmtHeTJYKzN0V1A2MUR5cGVaRktuRnFqVFlkeFBi?=
 =?utf-8?B?eGhkYXlaMEtHZWZIaWVLMlFpUHlNeFUwaDUvL3B5a0dhRlRicmZtQk1DQ01C?=
 =?utf-8?B?WHlVY1laWFRKV01HUU1YM3pLQ0VhWGkzRVRCM04vRmgwNFpFWWYxMVc3MTN5?=
 =?utf-8?B?QjV6c3hrTm14TWdGd2xFbm52THRWSUFoNWd1ZGZ1MGRCcmhPckxjdlowVE1i?=
 =?utf-8?B?ZjF4clc5MlBzRHBEQXlMZHJxVVFxaDBKcTgrWGNHZUUvYUQvaGRSY0dCY1Iw?=
 =?utf-8?B?NEtUYlN5SDVLdEJkVjVpRVd5TktjdlExU3BYd05ZM0swQ1M1RmZwTVZVcnRO?=
 =?utf-8?B?QTBIVmJUYWdyUTdXM0ZYTG84cmlYOVl1ZXZZanhPcWlsWTAxbVVpQzV0U042?=
 =?utf-8?B?OEVpd29obHAvU1JadTZ2amthSzcvUWt3U3dpVUxQRVF2QjZ2YkVWYmtJWGd0?=
 =?utf-8?B?ZmNTaUdoN0Q3TTBGN1NGSGh4N2xoSmtaVWV1blVDZWU0K1htV2ZTai9WUDNu?=
 =?utf-8?B?NDVMZlpJUFZ3dWZEVFA5WTRVa0lWa3pFK1drZTE2M0phODlKRTNaOFhtekNC?=
 =?utf-8?B?ekY5bEZRR2krcFgwMjVlSUc3RzBVTEc2RTVCRjJjL1JlMzZpVGxTTEdKL0hw?=
 =?utf-8?B?T2pJWE1pMWV5dmFlWVZjUDVjRGJQTnhVcTJzZlIxclp6bzhtRkNpK2xBbFBD?=
 =?utf-8?B?aThnNU44SGpRNWRpak8vdXY3NXhHYlhBVXBDZzg2S1ZITDUvc1pPNGtNUlY0?=
 =?utf-8?B?dlkxQzdmb3VCY3NSenFycXFuVG1vY0VVdlBzN0V5WHZFSy8wYXltWDdvUHV4?=
 =?utf-8?B?ZXE3bHVFemtxSGtMR1duN2M0L0NpOXlKd204K2xtNWh2bk9nclJYQWRPS0Nn?=
 =?utf-8?B?WGlNWGxOWHNza0hRajRkVHVpQ3lNeTJYK2JiZjd4R2RySC85RnhnOTZYRXpE?=
 =?utf-8?B?SFhHREpqNjkwVWxmTmgwL1BIUTVOeE13Q0xHUVUwTDBTNU9qU3ZNbVVFMXZT?=
 =?utf-8?B?U1dWenJTcUlqSFpVNm5tb0VPZkF1eStiM1lEQWNCZ09neFFPSU9YNWhTSGtu?=
 =?utf-8?B?cVhUcHFtcTJwU3UzcXBneitFWmU4L2tLcmo5SzZFalk0a2RUbjh2dnQrUEd3?=
 =?utf-8?B?SStpSTZSbGRRYVB3RjF0cklwaSt5eVlIV3NtVVE0UkNrSTlYekdKUEZmOVlO?=
 =?utf-8?B?b2FwbDZWR0xMbWtuNm50c0VHM0pmVy8rbFlWbnVwaUQ1SklwSnhqTFdYWlNP?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: decde6bf-10cc-4846-2722-08dd150a540e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 08:53:46.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZwwVgZn8UdwDNb/Hhb4daFcmMHI2fqrNkfcrZBhjcrFSk7ItXiPhicHnL/zrBda9nzvEMElTVXMGqkYOrZG02mMaaVmpEtD+iFClcMKDc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6433
X-OriginatorOrg: intel.com



On 12/5/2024 9:32 AM, Leon Romanovsky wrote:
> On Tue, Dec 03, 2024 at 11:02:15AM +0100, Mateusz Polchlopek wrote:
>>
>>
>> On 12/3/2024 10:44 AM, Yevgeny Kliteynik wrote:
>>> On 03-Dec-24 11:39, Dan Carpenter wrote:
>>>> On Tue, Dec 03, 2024 at 10:32:13AM +0100, Mateusz Polchlopek wrote:
>>>>>
>>>>>
>>>>> On 11/30/2024 11:01 AM, Dan Carpenter wrote:
>>>>>> The dr_domain_add_vport_cap() function genereally returns NULL on error
>>>>>
>>>>> Typo. Should be "generally"
>>>>>
>>>>
>>>> Sure.
>>>>
>>>>>> but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
>>>>>> retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
>>>>>
>>>>> Please remove unnecessary space.
>>>>>
>>>>
>>>> What are you talking about?
>>>
>>> Oh, I see it :)
>>> Double space between "retry." and "The"
>>>
>>> -- YK
>>>
>>
>> Yup, exactly. Sorry, I could point it.
> 
> Double space after period is perfectly valid typographic style. It is
> with us for last 250 years.
> 
> Thanks
> 

Cool, thanks for explanation and please forget about this unnecessary
nitpick :)

Thanks

>>
>>
>>>> regards,
>>>> dan carpenter
>>>>
>>>>
>>>
>>


