Return-Path: <linux-rdma+bounces-16796-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEQfCWNWjmnHBgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16796-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 23:38:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE1E1318A8
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 23:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60EA83046F2E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 22:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9728D331A5E;
	Thu, 12 Feb 2026 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0r8O1GR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F37E12CDBE;
	Thu, 12 Feb 2026 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770935903; cv=fail; b=tNs6QQuAaucawQesZ0sTzqyx2g5CyuM2CXdGiI8GIyGN5rn/JBVrnkgYtaTgEaLsFHgB3vD4NNRi6aWPVc75HdZrZ0ZdCN3a+aTxh0pcwScbkE/2zF+mSXJbq24a0EdFcMC184NunLpwTF+FoZpUrPxoKuQVC7qRpTYoN/N9l/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770935903; c=relaxed/simple;
	bh=2MfpoBdgQ+6DVLZAyql+Dsb5nOE1e+Xs7ohahqtwWzw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qZdiFfDPX9wIT+ZijwqHUWeKtMRkLHG1J1zuwRp2vIYWIv2j58wOOf3eXlLOrpi87Kv6uWCbulK/AwALD+Z+tZa+9XmX53nWAv+gkyJ08KiY9gwF14GnBX/A78+e6lCnVB58t6weQP8EhK1MQe/l9h7tYZQkyUmSa41QzuGj16Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0r8O1GR; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770935902; x=1802471902;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2MfpoBdgQ+6DVLZAyql+Dsb5nOE1e+Xs7ohahqtwWzw=;
  b=m0r8O1GRvfz8idpFbaNDHoOzFpXS+5jA8n24+8PQT1LpOIdTXOYFJL0o
   rlGjSAs7DSTUfXDs7LLHhaeFvjsxXqFiijNpt7d5IarKZKn81T9XAsox1
   RC3zsHcs8G+NDcg8z16LZwh2NUvRUxa7t7ii1Y/GJGTEGrWtSLY0Y/fI1
   SIBJinYjeWMW16mq2noMNH9JinY1nkNCJPPi5Cy+C/lSIMi4TI1tCZsO5
   ACLxah0GHRqJ4Ptizt124kd5mvbRX14K+QFjK3628n5To7jYolyWvXeEG
   dSqgJm8VFE9pIjt9zZ0BK7LSDzjAYy8+EUA/R4QpAG+zZ3y/I85DpQPLd
   Q==;
X-CSE-ConnectionGUID: f4puHXZfQhO1Shtfb7VqVg==
X-CSE-MsgGUID: wNMsWW05ROqnTDLvkdOcsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83217660"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="83217660"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:38:22 -0800
X-CSE-ConnectionGUID: WA9U+Uq+QRquQQU01s0/wg==
X-CSE-MsgGUID: IfmfnyTwSe2Rwa5CxFl39A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="216927061"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:38:21 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 14:38:21 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 14:38:21 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 14:38:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olkLlmshlyWSb2FTIfwqne5ff8WYogd1hvTbLdKaIZyJhfS73Sz6ID9vE54v9Ox3F9DIkz/Z23ndYlgVL9CZgXxGwqYJTyeiiIUUoVSQpMhYRi8b+C/XPCaAZo7xClbUT+rMQH5m8i1A1lYwu10ZBsD1aZul/AD1k75LrqkbvOMwIJ8EnhoVoPbjry0GsSkTxje/zzAJ9IJmmf3IqkFiCm9WHvNnckQv4Z+37mUMNuVHe5eBYc3LR5pFx1lC/Tg7wOe2+Gm/az5FWIJByfKAeeE8myRCc3iTLyzglkYZ0EL+NHFsixQlGfOipNGnOmjJcc7nagCA7alVozgrN+uAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69rlO8to4Q/t65uChBFZJXyVL8jMCzmLDrNQvzGfy6k=;
 b=EfvJnFBmQwoeNMarMUsYIo4J7hDGSUbx84NK3cvGNrSHo8+EuWKXSsW4stwZh30h3Q4YyfOkNntJBKjqttCQ/TzZLtdikxemI9WwAcEck2UPL13OXig9HXJwvBErs4JCqv4hqcqlVPPf/LqTtYcnIelEPxW5EzFtqVWwyO5QAwexwa0t0pWLcv9Z2nl3Xsg2RgQ0jcBSSE3aLo3uY/1g2KTPDWmlaohtb0kNbUKQgn1R5GYGjHarkMaNJ8R7VKfTaQNtsS9oHeHNBQBM6eIE2IkntIfYU1DsCxi+ui2OlHN8sjapohyndRcqlSEU0TJlLl0VJQ+1KPLT7xjj6ycjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by DS0PR11MB9504.namprd11.prod.outlook.com (2603:10b6:8:28f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 22:38:19 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%5]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 22:38:19 +0000
Message-ID: <8b96b3d1-4bf8-487f-9782-c9353a7cf4c0@intel.com>
Date: Thu, 12 Feb 2026 14:38:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/6] net/mlx5e: Fix misidentification of ASO CQE
 during poll loop
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>
References: <20260212103217.1752943-1-tariqt@nvidia.com>
 <20260212103217.1752943-4-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260212103217.1752943-4-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:303:2b::8) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|DS0PR11MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 03084081-afb1-4e8c-2e1a-08de6a876bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHpicWZUQlloMVI3RXltcGlkak1QdXJ5WWZMcCtYSEVJbzRNQVRIaWxhNTMw?=
 =?utf-8?B?QnFyc0JneGVkMTdtUFAyZitGWDk5cWM2bFZJaGFuVzRvVExqQmc5Q3hHMjcw?=
 =?utf-8?B?UVc2K3VHMWFjb2xRWUxRMlY5RDNOTkwxZElLQ3JSejZJZzJIYWp1b2NsYmRP?=
 =?utf-8?B?b0U4R0pqNndTOWJhSHdSbzRkdDNiZnBsc3d6TFUwU2xhU0JHOWZmVHh1Q3pT?=
 =?utf-8?B?bjFWemxidW1PMHEvUk5uYVVENFNCdzRlTDVyeGlvT1A0UjhrcTVja29ZYkVW?=
 =?utf-8?B?enJ5NlBnWGNtbWh6UmI4WHpOSGphYWQ1RG5ybnhXZFE2VjEvS2NIY25FZnd0?=
 =?utf-8?B?TUNBcjdBV1RFWG9paDh2TUhjMitxbmZtSG9ua2R6d3BJUTlxOWxiQlViUTcx?=
 =?utf-8?B?aTJSbEwyTFR3QkxQblBCaEdTTndBU2dSbWttanY3endsc2x0M0Y3cSswemdW?=
 =?utf-8?B?OUJDc0xGWDd5RW93UDJDd3ovcm1BcnNxaFNiSlB3S084ay9hNVIxRDVIL3k5?=
 =?utf-8?B?cFJBWDBqSTJsZkdpdSs3aFJJdG54MVdlRVdoWTRxMjRqRk1FZXphVmZPR3VY?=
 =?utf-8?B?RWpqdnFtZEdFZExvSU5rNEhqdklUdVorTllSaUpVbnp4RWhObVROTyszZEI0?=
 =?utf-8?B?TU9GcFBFcDhYTXFnOEJ6N2M3SzdJSDJoaDVraVVqdmp4K3p6TlhIaVZwZk5F?=
 =?utf-8?B?SmtaNzk4dVpuSUtMRWxwSGc5Q2kzNUpncHdxK0ZjSi9sTlNvQVFNWFp3eWFl?=
 =?utf-8?B?NmxWZHFlRjBUV011djVxMS82eW51Rm5BeXpSd1VkK0hST09sYzlEaDhFZnJl?=
 =?utf-8?B?Q2svYU8zMU1DNzN6amFRK09xNVcvVjhiUWZZSFM1M2JOMzRRU2hUZEEvcUUw?=
 =?utf-8?B?Y0JraDRWT2Y5bkpmS09DaWRYRUYyUzZmUE0vVTA1V3NGMndIdWQ2RWM5R3RK?=
 =?utf-8?B?WENaOTFnV093NzBjcGc1VmIxbGJwdDYwcDNKTk5yWG5xdmMrK0ZYUG5aa1l5?=
 =?utf-8?B?eEMvZjhyMDFoWWlmdktld0tVNm5BT0p0S0VpVmxNME4zZ2dQSDdjRjNlWElo?=
 =?utf-8?B?RkFKTFBNaW5kMW9iTnBiUWl4S0FqSFp3TnY4LzhlNFJiVFdGN0VJc1Y1ZG9o?=
 =?utf-8?B?VzBqRVREVXovZ05mS0Fxdlg2bHQxTHplRG5JTnBZSUljQ0YwaUZoVGxuSFlJ?=
 =?utf-8?B?azRGendveTZaNEhQczdrS3pOVGtENnJQTEMwWWJQVjlCbGx0OURZWXNZd24y?=
 =?utf-8?B?c3FsZlRPc3p3Z3ZUcWRFVkZNYzkydnNvYzkwYTZpNEpRaHgzWTYrdFhLbE40?=
 =?utf-8?B?cmtJK3JNZ2ZoRHlRNTZhZDRySTF1VVp5ZGpmdmJoQjlvcHJCNUFjR1lJaTBj?=
 =?utf-8?B?ODErWmtvYTJKNXpjeFQ5Qlp2K3NzWlVackVnV3JmZGd6Q1FnSCtvdTJlQ2I4?=
 =?utf-8?B?Z0ZISzAycnRlZHBMTFpmS3d4NWhUeUpENnRpRlB0OTMrZU9GOHptRlpDMUg0?=
 =?utf-8?B?SVpoY3d0eEVra3R0WkluUVA1b2tESHk0eXJPdnlrRnVoT0E2S283R2FFNExF?=
 =?utf-8?B?VHlzVmV6OW9raC9FTU5aWjdEWFMvK2ExdEdMZHdSc1lQT3JkbTRUZE8zczN0?=
 =?utf-8?B?MmptbVFqODhjYXpqb3FtQkxoRFE0OXFDS05VNnllTE9ReVN3LzJjbWRVTFc0?=
 =?utf-8?B?dFo0ZjlVRHJhMWdiT2VhdFA1YkhMTThDWEFsbmR3T0NCdzE4MWIxMThmOEov?=
 =?utf-8?B?bUgzTktMU1NIZWcrM1VDR09HWGxGR3NBL3N5NG9lTG5vNUdMTEtWN0VuR2VJ?=
 =?utf-8?B?Ulpoc3Z2UU94YUZIVjF3ZEt1bzFKam9obGVZQ2xKTXBoS3VMamlrSStPL3R6?=
 =?utf-8?B?L0VneWZXUEI4UTFvTTFUc2tkeC9ocGNpNnNWdU9udWt3S3hTblEyd3RWdFBW?=
 =?utf-8?B?WkJ4UlBCcDluZ2diWGRyUFRwcE56eXQrejY1OEVIRVBNbjNKdjhQWU55YzZw?=
 =?utf-8?B?a2syUGI2ZHFrWXlBQytjYjI2Ny9wVktIbnk4Y1BUTHYzWDFDZ1Z2UlF5eUJm?=
 =?utf-8?B?NEZWY05WdmpYSFhUMHczdFBqNm8wMUw5RTB4NW95VDFjNmVTZ3J2dE9GNHJR?=
 =?utf-8?Q?U7yM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7588.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnBZaDE0UGUwTSsyWmhEekxIY3hLNFRPdXdKU2UyWFcydGliWEcxdmNtakxh?=
 =?utf-8?B?YjEwZ0dQVEJsZGtETmhYS2x1NXEvS2RJa253dDVUSmt4bE4xYXBlamF6WWJC?=
 =?utf-8?B?YnhhcUxVM3hUVUZxcDBxKzlmQmxPeHgyVkZvUjl5Y0ZJZHQ3enJrMkRZYWY2?=
 =?utf-8?B?M3BkTjZ2UUxGQWVlUDdSMXlFZG44WWJhbWFoaXBJU2hIL0lCWFQ3RE9BdDdk?=
 =?utf-8?B?SDFBQnBsTVRsWEtBNzlrZi9IR2FsNG1oYUF4TysrUmZWMGtXK3ZRMjY4VUIx?=
 =?utf-8?B?Nm5wNXhHY0FVRTQxb1JCTjMwaG5DaTNFYjVnQ0lJTkhrOW05dU1WaU9PNGY5?=
 =?utf-8?B?dmtSQlRjM0dZd3RJUWw2akJxUXFzZVRWejh2QVN4S1ZuSXhZdlhlbUtMUVpq?=
 =?utf-8?B?dHQ3Y1pQTjJQd1lKT1YyQ2RDT1FoT3NXcmpCSDdPSFhCRzBPZDRXQ1drRUxv?=
 =?utf-8?B?MHRWR2Z6bTlackN0S05mekExbTkwUnZQZW9GdHZIVWQ4YjZTb2hLSnFHU2dp?=
 =?utf-8?B?MDgyTjcvMHViZ2FLM3h0MmdLNXNuempRc0I4N3RuY0hzeFhRRE51b0N1UU1m?=
 =?utf-8?B?V2xvVTJ5M2dPeTdwMmJ0dVFQbWxRSnVBVTJJeUdyYVAxSnhqU21oMmVpN2Iw?=
 =?utf-8?B?Nm1ieVJCRXFSeXl3TTZRbGcwUEpLeDZGUUxUTGVnMGxleXRGT3cwUzlaSE9r?=
 =?utf-8?B?TE5uT0ZvY0crOC9xaVlmY0FGVno3aDRheFFocFJCcnNuMno1RWhlZ25YUFBx?=
 =?utf-8?B?dTRqS2g0ckhmQW5OakplOUZXVU9ScWlwOW1UNXdwcUIydkpxSWpOWFVZaE1J?=
 =?utf-8?B?K3p4L1hNcXcwb0xaYWE0MlI4RWlyTzlHWStQcmEva0JRZDU2YkoxOE0zTjhD?=
 =?utf-8?B?N0tIbHYvd0g3a2h6dFBJeS9NQ21BM2V1Sk90dmNURzlPRlNkNjdkbXkyYVUv?=
 =?utf-8?B?aTlBdWlmRm1BYThaVW02Szh0U3dQTFZWdjBGWmgvcnc5NGRuaEVra3N4TXNa?=
 =?utf-8?B?S3NoSFNkeVdrWVBwS2FpSHpmU2dXS3RvaW12eHdhUGk2NjJPaUd5Y0l4LzVC?=
 =?utf-8?B?Wklub0VTZHdmZU1uWXgyeE5WeDlkNUV2eEQ1VFNkL0ovcnVUN2JPL1kvYWx6?=
 =?utf-8?B?bFd6Z1dDeitJbDFOMlZBMkdpQ2JkckNtS1NNVmJLT29Xa1hva3BLTFErYXBG?=
 =?utf-8?B?QVV0S2U1VTdzeWNDZFlaK3RsOHVoNXJDRXI0aVc2dDlWNGJnRmdIS2VlcUJJ?=
 =?utf-8?B?ZTVibTYwYzVMUHdGNG44cHEwN2h5MzJvWmJLU0xORWlrZVA2L0l4RlVnZTlP?=
 =?utf-8?B?SGFpdHNVQWE4am0rZjduRnVuNE05L3ZiTWYwcnhBS2Fjb3RHT2I4QmdPUDZm?=
 =?utf-8?B?cFViNFNMZVdjN0k4Rm80ZCt1WlhHM0dSZVpBWVF1UDY0ciswNWFaakVDSmI3?=
 =?utf-8?B?NG5xcjFObW5Ma3JzQ0VOSkN3YlVrZGluLzVvT3pKcUVLN3E0RWVlYzJRbW5X?=
 =?utf-8?B?RGR6R1RPRzkrVHZrc3dTSVBvV1pBZHRJb25JZkkzRjFjL25kaHFRU2o1UVpv?=
 =?utf-8?B?T0FUNTIzbHF0cEJ4Q3JBZ3ZwclU4TXA2dVBBSEZzaXBKTE9nam1yTkpzdGJk?=
 =?utf-8?B?SE02dXNkZGdaQnRyQ1JuSXYxdEJNUG93U081TVFheUpaL0o0S3ZMZWZTdU15?=
 =?utf-8?B?Y094aEJVUFlORE5ZeGpwVWtNR2pUb2FHTDZ4SXZPUHdTWmlQaTJrSWtUa1ow?=
 =?utf-8?B?eGg5K2pIb0tMbkFzanpvWHFYeXdscUpxbEJXVzhVOFZ5MjZlNGZaMTR6cEQ5?=
 =?utf-8?B?SVdIeTJIVnhtMXRPZEVpeGdqL0duTXRCT2FrVzdzRjFOcG05MGlPejZIcjIr?=
 =?utf-8?B?dVlranRrbWdMeitPRTA3ZFBEN1h4TWJ2NE5vWGNQSTZJWmV5cjFPMnBzcUVX?=
 =?utf-8?B?Yjd4ZllGRm1FNUkxeFJkRUI5OVFDeVRiVkNnQTBMWmM0dzdMbHMwQ0E3L0Ji?=
 =?utf-8?B?cVhJN3NVNjNnVEZoK0VFd1ZLem1IQzI0aTFSSEhiOW1US25uSmdwR1RjNFJZ?=
 =?utf-8?B?ck1PNWZaZmxPQ3NCdDdTRFV4Mm1WZjhyNTN0ald0Q09sSGEzS0hFNlJsYTUz?=
 =?utf-8?B?UnFQQi9ybkx5NE9MZ1JMS0x3Qk9JNk5OZ2dNdi8zSHVBNHBJWXB0QkRZUXB3?=
 =?utf-8?B?QUxQU0RhVG5hbTBpU2lzdUt0OUpLdFFCcllwSGFtenFHRmc2UHNYbDBWS21K?=
 =?utf-8?B?ZEZhQ01vQ2xVbUNGN1VCQVh4dzJIUCtWVVAzZUJqcEZzdGcyNXMrT2ozUUlU?=
 =?utf-8?B?SmdRRUtMaTFhbytSc0ErcW5WZ2cxUjNwRHFyTHg4aEFjczh5MnNhVTl6RUJz?=
 =?utf-8?Q?2kjhuWZKZORtiGU8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03084081-afb1-4e8c-2e1a-08de6a876bcf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 22:38:19.6618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnjrGD5r/yPqhAFFb91Zndf5JH0dTyHK9gvDd3FwgF/bg8X4vWWvzY4QJ8txpShnQnOICPkbJVoalG3/y9wL/b6QNTChflPh6h2ijS0DPuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9504
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16796-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8DE1E1318A8
X-Rspamd-Action: no action



On 2/12/2026 2:32 AM, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> The ASO completion poll loop uses usleep_range() which can sleep much
> longer than requested due to scheduler latency. Under load, we witnessed
> a 20ms+ delay until the process was rescheduled, causing the jiffies
> based timeout to expire while the thread is sleeping.
> 
> The original do-while loop structure (poll, sleep, check timeout) would
> exit without a final poll when waking after timeout, missing a CQE that
> arrived during sleep.
> 
> Restructure the loop by moving the poll into the while condition,
> ensuring we always poll after sleeping, catching CQEs that arrived
> during that time.
> 

I would have re-written these to be based on poll_timeout_us() or 
read_poll_timeout().

Again as with previous patch, I don't know if that warrants a re-roll.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

