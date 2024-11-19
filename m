Return-Path: <linux-rdma+bounces-6042-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5807F9D3116
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2024 00:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8524B23580
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2024 23:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E215E1C2337;
	Tue, 19 Nov 2024 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4uGWTfe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10714AD24;
	Tue, 19 Nov 2024 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732060434; cv=fail; b=ViMjcQdmnZlv6mXIRER2UiC+wQwRe1Kw/QE9sTcga2NeY65zd28p/A+VzVRjCbWsNLCGfetxdlNkA1ZTgPvesV8Z8C1bn4SBM8aAzzbau0Rpq5d17WZLqeMwPOk7lAiCEqxTx/IMBkH8xPcKR63nPsLBjLcSIlrTd8RKqpu0Y9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732060434; c=relaxed/simple;
	bh=G1rNUZtZzYvQ8E0qeH0RlgimXgpFElKOYXvU9YseuzE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PYxDBaqcSoUA3YWsM5vdFtmZlP0ilj0EwO1FYpY5pOLtNIsNA0dF0JnCV88ihIoPKMCXX06vdo6HeWTuulIxS2jeMlMywuBHs6MbdeCDhDoEeBynfSQIh7zllGs3omcBA3tSE5ULzB1naHOIYNEfMQhobStQSY24v3DCQmAhj8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4uGWTfe; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732060432; x=1763596432;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G1rNUZtZzYvQ8E0qeH0RlgimXgpFElKOYXvU9YseuzE=;
  b=W4uGWTfeu4KagwCFW9qvlSyrbOaGHoC7FA0DM/gq5clDV6ECJatDtPEC
   8kfJXKVdSJgGjQDrjkHuzqk338o75NGXwF+qYR+rESpSoCFUEyj/vqxwy
   VtxnRDo3URWqkaLcD4uvBZimvZpsuLfuTCUEmZxtSE2QMQ7B3G7NFZUwQ
   iRinkK5BzCPuX1R2//A9MI/iIakELll1mmCrWlq6lp2QQvEDQnC3WrX6q
   tjfQdlAcGsL3Mk2+xCwqnwJBdfAjjCBoWg0clw84rMdQBJLLiAgZuqmZZ
   2tJULyCu1s12Khx2oPZiGKKEwy3MKQEkfRqPFl8LcA7aVJ0QCfNTIpUBl
   A==;
X-CSE-ConnectionGUID: SmZdOIjEQYqCxtVRnvct3w==
X-CSE-MsgGUID: x9XXHyEPQxadaZwLHBs2+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42606708"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42606708"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 15:53:52 -0800
X-CSE-ConnectionGUID: +eDce0HAQZeBJIc0wZx7KQ==
X-CSE-MsgGUID: pPAC5D3fSTu7q+yyPF0jlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="113015816"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 15:53:51 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 15:53:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 15:53:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 15:53:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnwVPd9vnXtDHm6rTM+hIiiNp0m890LGLP4/N7aC/DgrRKCHeRT0nyrAbZTbbUpqDk85GupJHB8n5Fc0yFpjuV0CEADLItVFIiXs901eBYseZxad3EAWLeucvL724xUhl2vIVynqWUiS+sFul903Z56SiBLX1t39EKLAdVzghtrs9bYdVCVa8LP3AenFsKie3XNJnOPCz3iCXawqyZVhnwntVYmdd+ntMZBfiZckQn4P6Z0K3eNVUGvakz+RfZrajTr/Flp3e83kGJP+9ymbSZ9N2pxsUdOWWTitYeoMCyOAyt9KaFnZNDWHOCF1q5sFiJupRxuvee9/TrWmtbwWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Bm3wb9ba5ZRdJ3iX1Ox//ETuOT+/tijp97IAaBmX4c=;
 b=nT2gn/xFVtrgPyu4Nd+wYJHtucPTIT79/p797JgpHzPwIBKrIn0K5ZTJFycz0KdMr4vgHFMxLRadivDSGHiMJqI4Iu6xp8x4A4XN67ZicHVgrNwVeawMev+J7MirWSDabvCals7Cf+qBRaI1V3/9tm5zFRJ0Lg6urR3CH2Xto0GYYpa0XpqXRYT2h0x62cCfnZzXJIlTtyPVSy599X5m3SLU82qC5kopP1RcaRjPpQi3ZGZoteXM3yCvxi3qJ8PJ9cughorp+xveQtFpronIATPoZxDacfuvnaMbz+ZzB1V612UAIV20yvHJiLXoPiZm1rY7ycxWibJerspOcAGF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 23:53:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 23:53:42 +0000
Message-ID: <90e5e7d6-89c5-4f0f-9a9d-34873fc498ad@intel.com>
Date: Tue, 19 Nov 2024 15:53:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mlx5/core: remove mlx5_core_cq.tasklet_ctx.priv field
To: Caleb Sander Mateos <csander@purestorage.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241119042448.2473694-1-csander@purestorage.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241119042448.2473694-1-csander@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0084.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: d95ea6ca-476e-4bbd-8339-08dd08f5655e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZE1Kb1ZCeitGVDhRSll6KzlQWXg5L3NiVjJaUVQyMGZ3TGZZRW0wbkxjdGh0?=
 =?utf-8?B?dmJQekR2YmFyMU13U1E0ckI2UXdIVmJIdFkyQWdXNms0MjlZQlpJLzJPQ3BK?=
 =?utf-8?B?R3VnWGRDSWNVRDh1T01JaTQreDV5UWpKTWQrRW1RSEJ1bXYxV053TFFKRnQ0?=
 =?utf-8?B?bU5mbmk3QnBta0dXUmF6K1JDSWtySWtBRUhHVW4wd2lCeE5vNUtBZkszVmh5?=
 =?utf-8?B?TkFuSDI5SXpwNWxwTHQvRnZ1SXRtR0N6UHdXNWR1SDZFeFJJNm9UV3JCeGoz?=
 =?utf-8?B?aExFRTlaZzNERlVQNlJhanNtbjBsT3c0MFZGVDlRTEFCcjNhTlN3ZGpZUnVC?=
 =?utf-8?B?K3NBZzZnVlNkUDRDMFVsc29SRnJ5RVp0Z1ZLZnBSVmRwRExmcUdLcDlnempy?=
 =?utf-8?B?Z0UxNGg4dVdNNHB3MUFDamhiVHEyMzFaZGlmanBGOFFpb09BK3AxaXYwT2N5?=
 =?utf-8?B?R2V2bWhvUE00SVAzeW5KUTVBNkQ0NExDOElNRkRUZGliUTdvUU81cHhXcWg1?=
 =?utf-8?B?eFJWbGFsT3o3RE52RnRZa2hBd2RpN294OTN0bDNWZXg1cWI3bVdPN1pYQ2R6?=
 =?utf-8?B?ZjM0RHBpM2hJS0MzVVpzMVhUTFAwbGRIbGlRK0JRNFFnMzBqMndLZGVkYU5X?=
 =?utf-8?B?NmJnTStXbTFCV0I1bWRyZk9vb0M0bWk3K1lTMGhXcjA5K1pTRjRMTlJ0bk90?=
 =?utf-8?B?Y1AyenBsSjRnSkI3S00zZ29LYWFheG15bkZPWXFGeFR3bmxkT0k0Mjl3SU1Z?=
 =?utf-8?B?bTB3VWk2bmVGRTdoSTY0Z3p2R2lUWlBBV0JMbnlDN0FWOHRFNGphaHZUS3hu?=
 =?utf-8?B?Zk1kWkg3dzQzZ1NuTlZqUmUwOFpuUllWUmloUFVxMTJUUU5RTmpPQVhTeFNr?=
 =?utf-8?B?bkNhUXNKRGpyOW9jR00vTjJHZk9CZHBlK3dqdnJrMVVQSEFUVVIzejlCdDFM?=
 =?utf-8?B?dHllMnF6ZVF0Wk5GSkltUEN3a0wraVZUZnM3dnpGRUYrQUZ5ZThrbS9hcC91?=
 =?utf-8?B?VnFSRHIvTzQ5SHh5bndyUzg2ZmRxWVJEWTU0WE01MTRiTFc5dXc0TjVKSzZn?=
 =?utf-8?B?MHp4cU51clhnOFRpcEVkd1FUZVVJVVJ0dDlGeldOLzc3ZEZWcHYxeWFKaDhp?=
 =?utf-8?B?S00yN09wN1Zya3JFTFRnVEVFNUtMTUJnNVVHZEtUS2JrOFgzVkhPVVg3eGVS?=
 =?utf-8?B?K0pNUXllbWJRcW9KeWlnRVNZY05tcGxpcjRGVHNDUkFwV0FZaDU1YmlOeElh?=
 =?utf-8?B?cThFVUM0RCtvdHlaT0xnQmQ5TnpMOEptcWJtWkVHWU5VZmZvTHhDeDJMWllN?=
 =?utf-8?B?V2Zrd1JnK1lROTBTdTlIbm1UbmZnY2FwZzRCTU5mN2R2Q0VUREgrdTErMmhh?=
 =?utf-8?B?aEtWcHNvMEY2d1FvQlRvSkVlWS9jY1orTzY0aS8zSUgzQnprWHRVbFFaeG1u?=
 =?utf-8?B?UDNBZlNKVzI1LzQ1TmUwTWIyak5IeXhqUHlWRjBXMk1UZlFjZlNUMDlQdXVK?=
 =?utf-8?B?cWk5TG5Rc3lJTGVpeGlTNnRRc25ZWW9KZUxtWkJHOGV1M3RYWUxRbk1YY0Nr?=
 =?utf-8?B?bnFrclF3cjhwejFXZDlOZURHR0VoS3JnSlE2N25XYSs3aS9iamZDWDZEYlZK?=
 =?utf-8?B?eU1lYW5zZ3dmRk9NK091YlNaUVhwUFd0RGtWZkpGa3lRYVY1OW4xK0thZTJF?=
 =?utf-8?B?dlE1OERFb3V4RlE3ZFRydlIzUEQ1UXFLNWZwd0xRMi9MRlhRaEVEN3M4YS8v?=
 =?utf-8?Q?V7vmgaidE8K2SeiLZt1M/KLEPt2dwlngxfCCMXw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVBLT0N3c2N2WUNlLzJySkJ4dFVDMUFYNnZPcUd3N0puSGJybW9GN2lQaE94?=
 =?utf-8?B?OTd4dWpvcEdSdTFYYjVYdGNFbzU4amY2SURnZGx5VjJ1NWlwQ1NkRkNPUnRK?=
 =?utf-8?B?djdCNk5rRllIOGJHLzVLYmlqeEp5Mkd2WmhkZkFPUnhLdER2bUZDeUIyNW5P?=
 =?utf-8?B?ODRKbEQrbXlsR0xWdllMcWVqY0VJZ09mWFh5dGMzalVxNHJnbTdZbkFnbzJ2?=
 =?utf-8?B?MmZSWnJkUmplQ0hiTXVGRDNJL1RVVSttdzNGUjY1K2xCY3d4bUxNQytrK2F5?=
 =?utf-8?B?a1JyaHJzcHdKWVVzdjIrVFd0Sm85N3lmZjd3amhqN2I2b211QnNIYm1STGsv?=
 =?utf-8?B?ekNiR2l0U3BBNmF3bW5LRVlxenRjS290K1o4cS9Cbjg1OGJ6T2RQWHZHNkVw?=
 =?utf-8?B?Vkx0MzdzR3Y3K1JnSmw2aGp1TzY4ZEt2Z2hQSDBPQVpjM2ZycmZlOFo5cnBq?=
 =?utf-8?B?V2crZm5oK0prYU1wM2lPQkgvd3czSW5BL1RZWGxDOTlJdytRVUt5ZURVWkNG?=
 =?utf-8?B?c0Y2UWFFZ1ZzRzFvWTNjTkdDb2IzSEJUbEY1Zi9ZUXFZWE5TMWRJWG01U0g0?=
 =?utf-8?B?YUk2K3lMZWUvRFY2b0NXRWxlMCtxZS9EcWtwSWZncUhCVG5TeEc4T1BLQVcv?=
 =?utf-8?B?S21lU0JJblphZ0xkeGJWT1U2VUw1SWNhZUMrOGE2ZCswdDZZU1JvRkt6WGxE?=
 =?utf-8?B?Nm1pRDhnaXdLQk03M09yUWY1aCtKSll3Sm15S1ErRWJnWjhjWFViTFNjeC9t?=
 =?utf-8?B?RmszTDdWdXMzS0N2M1JDM1VOazBoSkVZcDJPWkJCZEVKcUQ3SFc0Mk9vRlNx?=
 =?utf-8?B?KzVZL0JVdkpOT0FlU3VPYTJOYzhvcU1VQmFwdzY1eVFwOXJGRitwdDk5RHFB?=
 =?utf-8?B?QVBsUkdvQlN5L1R4ZC9EdGVHV3hpNy8zWlBvTEFrVCtLS09sdnhpSy9nR2Nw?=
 =?utf-8?B?WDd0OGgvZW4zek5NNUZhSVQrWFN1cmQrMGk4enNCMnNZNjNpbmtoaTQvUUh2?=
 =?utf-8?B?VElCRExZYUZxSmdadkEwYXI5VGQvZjczdG5pdGU2MlhMdWFUZjF1V0JNSndE?=
 =?utf-8?B?dWR5WjZxMjlEUjJTUjZpSlJWOEVvRkVOZ0xkcnNuajY4d1ZrVlVHbTdQdTc0?=
 =?utf-8?B?eFBiU282cHhQY254TXNTbTNDWUFtK2xWZEM4TnJCeGlnR2QrMVJvT0liSkhk?=
 =?utf-8?B?YlRMK2IyTUREeWUxdm9sL2JLaTdPVmpkamFsWmp4R3o4ZTBudmlTNlV1L1A1?=
 =?utf-8?B?cUdqNDFhdTNac1lSZUpnVmdValJXTjlIT29oZW03Z0ozbkIxZ1E2anBhbUdP?=
 =?utf-8?B?TDc5VG9RWU9CN0N6MmdzNnZJUklFa2srVGpma0hKUm1EMWJ3d2Q0aGJ1Umxq?=
 =?utf-8?B?UGZQcmRCbDZUbXFIMXpOQWMzWTh3Y0pVZVFoN1h0dzdlaE40Y1ZVdG82TWlF?=
 =?utf-8?B?SHdDUStMSXlrZ0RJMDE5WEJ1b1RxM1lHUTRWT0ErWXNZT1pRM1pSa3FEanZr?=
 =?utf-8?B?QkdFeWVobDY4MWNsa094Z0RKK0kxREZBMUl4L2orRThIb25SRitBSG1rRlBC?=
 =?utf-8?B?WHYxbkgvSk8wYUNERHJWSHR6bDF2VEJ3dE9SMUEyL2pVaFVocnZKbnMzUzAx?=
 =?utf-8?B?NUlycGlSVExlSzRobWhyclFOeFNIWFo4ZnpJQ0xYRjQvZUI3dUViWDJEcXRm?=
 =?utf-8?B?bkdhTE9MWVBoaUlCRWErcmhzMDdtWUVOSUFMeElDM2Z6cU5BaitlMHMrVHZP?=
 =?utf-8?B?Y0krR3Evd1hTaUFBWWZFWE1hQ29JeXNidERSV3FKRDRmLzZWYjNtTTIzVEVr?=
 =?utf-8?B?WlhDWmlJT3VtcFExcWQ3ZkRRRjRDcUJxaHNlS1haRXV5Mm5TOHQ0RTlVMVBX?=
 =?utf-8?B?azZ6Nk5EcEFjNkNIQU1WZFhuamg5SzdQRERSRlQwMUl5MWlTVi9lNjY0QXI4?=
 =?utf-8?B?dTBrK1ZiUlUyQUdIS3lzeFRpeEJ6bHo0ODVCbDRGcUJKSkdtamI2dUNsRTk2?=
 =?utf-8?B?SVVyYnVNQlVOaVlrSGZxTHpYZVJ2MDhuV3V4bHpwMmNMMWxSd0twZVgyeDlB?=
 =?utf-8?B?Q1NaeXJUejAxMG9qRks5Y0NUa0RwU1g5UHBiYjAvNUxCdWp0OEoyUVNRL3Fa?=
 =?utf-8?Q?SP17iDevOOrBS2F1Q/EzBEVse?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d95ea6ca-476e-4bbd-8339-08dd08f5655e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 23:53:41.9735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43Z7b8+fpXCzKWgF6IevhIKl7zkhe2z/drfDwnyLFxgCTJ8/xTcNEWcqFUyFKdUeogXPsV/1KbnABukpLdxYuKc0mLv4pXIDVJtEoTHc4mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8179
X-OriginatorOrg: intel.com



On 11/18/2024 8:24 PM, Caleb Sander Mateos wrote:
> The priv field in mlx5_core_cq's tasklet_ctx struct points to the
> mlx5_eq_tasklet tasklet_ctx field of the CQ's mlx5_eq_comp. mlx5_core_cq
> already stores a pointer to the EQ. Use this eq pointer to get a pointer
> to the tasklet_ctx with no additional pointer dereferences and no void *
> casts. Remove the now unused priv field.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---

This needs to tag net-next, as it doesn't fix any user-visible bug.
Additionally, net-next just closed for preparation of 6.13, and this
will need to wait until it re-opens on Dec 2nd.

The code change itself seems reasonable to me, saving an otherwise
unnecessary pointer.

When you resend it when the window is open, feel free to add:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake

>  drivers/net/ethernet/mellanox/mlx5/core/cq.c | 5 ++---
>  include/linux/mlx5/cq.h                      | 1 -
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> index 1fd403713baf..dc5a291f0993 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> @@ -68,11 +68,11 @@ void mlx5_cq_tasklet_cb(struct tasklet_struct *t)
>  
>  static void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq,
>  				   struct mlx5_eqe *eqe)
>  {
>  	unsigned long flags;
> -	struct mlx5_eq_tasklet *tasklet_ctx = cq->tasklet_ctx.priv;
> +	struct mlx5_eq_tasklet *tasklet_ctx = &cq->eq->tasklet_ctx;
>  	bool schedule_tasklet = false;
>  
>  	spin_lock_irqsave(&tasklet_ctx->lock, flags);
>  	/* When migrating CQs between EQs will be implemented, please note
>  	 * that you need to sync this point. It is possible that
> @@ -117,18 +117,17 @@ int mlx5_create_cq(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
>  		return err;
>  
>  	cq->cqn = MLX5_GET(create_cq_out, out, cqn);
>  	cq->cons_index = 0;
>  	cq->arm_sn     = 0;
> +	/* assuming CQ will be deleted before the EQ */
>  	cq->eq         = eq;
>  	cq->uid = MLX5_GET(create_cq_in, in, uid);
>  	refcount_set(&cq->refcount, 1);
>  	init_completion(&cq->free);
>  	if (!cq->comp)
>  		cq->comp = mlx5_add_cq_to_tasklet;
> -	/* assuming CQ will be deleted before the EQ */
> -	cq->tasklet_ctx.priv = &eq->tasklet_ctx;
>  	INIT_LIST_HEAD(&cq->tasklet_ctx.list);
>  
>  	/* Add to comp EQ CQ tree to recv comp events */
>  	err = mlx5_eq_add_cq(&eq->core, cq);
>  	if (err)
> diff --git a/include/linux/mlx5/cq.h b/include/linux/mlx5/cq.h
> index 991526039ccb..cd034ea0ee34 100644
> --- a/include/linux/mlx5/cq.h
> +++ b/include/linux/mlx5/cq.h
> @@ -53,11 +53,10 @@ struct mlx5_core_cq {
>  	struct mlx5_rsc_debug	*dbg;
>  	int			pid;
>  	struct {
>  		struct list_head list;
>  		void (*comp)(struct mlx5_core_cq *cq, struct mlx5_eqe *eqe);
> -		void		*priv;
>  	} tasklet_ctx;
>  	int			reset_notify_added;
>  	struct list_head	reset_notify;
>  	struct mlx5_eq_comp	*eq;
>  	u16 uid;


