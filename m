Return-Path: <linux-rdma+bounces-16797-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DJKORNXjmnHBgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16797-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 23:41:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7801318E6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 23:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AF043051EB9
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 22:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6043733343C;
	Thu, 12 Feb 2026 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCVoKDUT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662228A3EF;
	Thu, 12 Feb 2026 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770936076; cv=fail; b=XqXdk7WXDpn15mv22ABmanNFPH12dgSNzrrQvbvSUdmGOX6+SeYXW7FHF8z+J90hH6i2QF1pnGtgw4Urmb5HGGEitGjLaAQNxTfJ9digzwGjSp/ul9sN659HEVUlgbAz/ey/MXSFuBNN95VqI2wyQWReGa+9on8gb/JcQ28GThs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770936076; c=relaxed/simple;
	bh=l6rW4f4se8jqMrWdg1dSocMwCFh5DbX2hNGqzkQjfdg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k1skWEZSSojiZfxDwv28xrqSNtW6oG/YJibsHC58SBPR8bghe18dzOdsVnSWhwy4dpaQlSD8zSYUjRvREpN6jnK89OWRgl9sMGSmjtxiNNP1dbRUmlKkVWjNjHTbXKjuqc1+zDPFqwPd7IpBO7ITqiC+rDXabn5+OtTx7rDpjts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCVoKDUT; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770936075; x=1802472075;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l6rW4f4se8jqMrWdg1dSocMwCFh5DbX2hNGqzkQjfdg=;
  b=dCVoKDUTFrlm11QXpZDJAVwDz/Ps9e8jWtlXro7e1Xd1KNzXAKjGZVdX
   oquA85Zib9WBv/xQnV8msWh8xWMJtHYL50cp1QtVTw1vuvyNL4IxOyhzW
   ejPd2bn8xh/eg0ZgmQ0TJ5fv8EjLJIDcusGbF0kVXLeTPTHauAjngsyDq
   DAXFqy3zGrV0qIY8AOYhU2uIpC+8V1vPLMdwcuAWJsVbIe45zRbxO9ZKn
   KQrufwHH6qWE3NjWAOWsehFLM/4dB6hC7ephl4zLj0+jIut/bwvnIa/ip
   IxknWq/+hy/dXjD4CqaI5BSeAjCvMmxBCstH7ln9gngNrKUw9bpM7hJey
   w==;
X-CSE-ConnectionGUID: UkTFhQ8TTNuvu0auku9CuQ==
X-CSE-MsgGUID: KJKGNcAnRKauC2Xhgg1/sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72193560"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72193560"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:41:14 -0800
X-CSE-ConnectionGUID: aYx5A6iXS+K53YZT2Xd6uw==
X-CSE-MsgGUID: ZJH4OuXISa+LPyM35aw1Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211954137"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:41:14 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 14:41:13 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 14:41:13 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 14:41:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQwjm/WfkY4atXN8UOSzOa0WqxVV/Ci6OM7kuAUsvBkFG1l++QNukZgSw3ahDQnWlNHR4hS20nYBDeaKI7A3ULEyN3We2SBJRdFBLrefXRU/Z84u2RyzxlYXCwz4Hn3hjBXWPc6ooTd78lc0XyBWsq1yeIr2YHa7vENzv9lHLY754vdeLND6b510YNf0hkHcUN/eIY9ykSX8af+nUANZWmlexu76lt9kXEM5jZE5/BZxXfZMoE58RpuK2+NiGyGpFfbrHqFP8gVLGPb4ERpDJw0G+zGiLyH5LweXRIesz6Jdh6Ymqqt8COC8kzpWmt2mCG//Q5je1iKfRsWywcnKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfsLWThxk7tmuuqGscgET+GJfMRRfjqP1JBg74Axypg=;
 b=KnN98u8fz7UZxmfiJy+Em6eSNMXY52exBMb9UD/38+hn/1F/WW6F1ZCT/WnmvJt5KVsWmIC6Ng+mgIGsKHRC+QHi2DpbxkEkrPLghIZQAX05Jj+WqEi/1Q3ivLu3knPZr8+SOrvXVo6Qu4ImB6LlUNypKpFLx9ks31dY0jUrSgjhgCNarhzVvBBU33FEyk+4fWVLDhi9tZl1BgSJU9JHUjmmGkCO1XcCHlC7mOUIXC+nCKHI5jpqT2IPSNYwHn5UFJMMbKPsxhM173T8VOtgdc5ZyVUTzSJkoce7SFCGhnJLIomJ3FER1qwFYJKZUYCud2aA/vNkBsKWB44Pz5Xu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by MN0PR11MB6086.namprd11.prod.outlook.com (2603:10b6:208:3ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 22:41:05 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%5]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 22:41:05 +0000
Message-ID: <446794bd-29f6-4310-99d2-5c67bb2416a3@intel.com>
Date: Thu, 12 Feb 2026 14:41:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/6] net/mlx5e: Fix deadlocks between devlink and
 netdev instance locks
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260212103217.1752943-1-tariqt@nvidia.com>
 <20260212103217.1752943-6-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260212103217.1752943-6-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0369.namprd04.prod.outlook.com
 (2603:10b6:303:81::14) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|MN0PR11MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f3a0ac-db97-4ce6-049c-08de6a87ce5c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aC94c01EVzJuZndDaXVPdkZsWWtYK0xScU03bWhBMHRQZWJpaldpOE9MUzNX?=
 =?utf-8?B?VnVjcG1DOXJ5MGNkUW85QUY1QjBmNE4yV1BqUi9TcHJlZUtDSFdGelhkd2xq?=
 =?utf-8?B?aG82UHI5QmluWDFxcXRJelczWWd4NWhJbGNMOFpLa1duZXhFcC82aHBLNkRP?=
 =?utf-8?B?dnU2ZkZoWVZCNGN3ZEVxdG0xQWNodkdMeis4S1VqVmdQblh6YzljZmhIaXc0?=
 =?utf-8?B?d3dBYVEwTjVTMGp5clFIeXJsVG45aU5aNVlHZmJZYXRadUxTbzdOQlhRYlpX?=
 =?utf-8?B?eExYSGVsNkpaUHVQT2hIVWtCWTcrQ3dZYlphUzlENTRWWkNPSTREa2dGNk9E?=
 =?utf-8?B?QnVPNHBnYlFsRkRWSXFkSnRoRG5jZ1JsaWJjUmNzd3lNMW5wREc4bG9jTDRH?=
 =?utf-8?B?MFJSNjVVclJwcVBscFV4MzJJSVpSM2VTMGU2VThwSkNtSTFlMGtJV2NnU3pO?=
 =?utf-8?B?RjN0TTY0N01aalhTbnVMRURBMTFxSUFTTldtOHUwV0JsbTBpb3hlMlJWRWZK?=
 =?utf-8?B?N05ab0JBMWNjMGliZnVRNjQxUzJVQjFjczAwU3ZWTGZYSERKZWFWMEdwbEJl?=
 =?utf-8?B?L2J5ZDFHZTR6eDR2bkRrYXNDakltVVRxbUJQQ01KU3BSaWw4WnhrR2NSZzNW?=
 =?utf-8?B?ZWIxdUEwczZxWVZxbnBQdTBDQVpFUUtwVlpxS0djaHZnbWI4c0s3Nk1Nc3VU?=
 =?utf-8?B?dWMzcVUzN3RZVnRacERYejUwOWxCemk3dEwvVW5SU3hNU2k4T0F3cU9hdVN0?=
 =?utf-8?B?R1laUFVtaXR6R2x2akVjUU5lc2oweng1SnpNTUcxOCttM1RJTWh5ZUx4Nk14?=
 =?utf-8?B?a1lDb2ZTenlBWFJwWUZsL3c1MVdUVG0wTmhoVnJxUE1FcXpZUURGbm1wa3Yw?=
 =?utf-8?B?RFFEMHkxVkE4Q2dWU2t2S3R1VkZTanBWdHBjOWs1TXVWNXNTYjRQSjZGVEg0?=
 =?utf-8?B?Y0h3Nk9lMFQzditXRmpOQjRYY2lVcnJJTU91RFE0bG1PMHhGNHdrRGs1QWZz?=
 =?utf-8?B?NHhXUWhabDdzV2ZtbkVFcFFZZXZvNXV0QU5VdCs4MUw2eEp0K1lJQ0luM2tX?=
 =?utf-8?B?K2tyNkZoc2dRMWVsalZseEM3TDNyUHR1T0RSWjNoSFJjL3RORXk1bmRETndV?=
 =?utf-8?B?VTcyNS9OcGd6b09ENzEvb0d3akp4dG1JTmQzbEFSNjVDUkRaazF1MkV6RWNa?=
 =?utf-8?B?R3FRUHFmNHFpam5WSVljNmhuS1BEcmZIdGJ3NnJxdlZMY2lodWdFSnEzcG9U?=
 =?utf-8?B?OExQS1FLeVJlVVQ3RjR2UU9BMm1xZzdXc0ZrUjUvdUFlZ05GdE1ZWHBNd1Qz?=
 =?utf-8?B?VDlTdFJ3MjJrRkUzMHBxcEltRUIrZmdYMS9DQWhPdTBLWFZxSjJtVE1KaXhU?=
 =?utf-8?B?ZlBOcFAvQitzaGpXTHVjMDlQMnJKWDVSZG5laVAzdGRnTWNYUGtyMGJ6L1dO?=
 =?utf-8?B?NmloOFRPRTQxZW9uMHYxaHVyeFJqaDl4TVBrZk1ESm1UM0ppSXd5S3RtUHYx?=
 =?utf-8?B?bS93WVRqbWhBMFA5M1V0RzluTTJZYUMzMzlwVGFsamdwNURoNEF2bUQ0cm5V?=
 =?utf-8?B?SkFIeFhmV1JkZ1VzckEwQUdCWDVFellpczd0WDQxYVduQ2g5V2JqRkdHNkho?=
 =?utf-8?B?TG1jWll2TVlkUmdySUNFTHFUL2Fqd3lSdGVMbm9iUitXdWlwZGpkSm1xM0hG?=
 =?utf-8?B?T29zQ0tIbmlOdG1yWlpiem55MTZEcFVlUDVjSG9OT2FoSVhTK2tlTk94SzRF?=
 =?utf-8?B?OVRxQklhU00vU0N3V2VIekEyNmZHM2g1cDBxd2lLY0d1VU1TeFJKTVoyT2Vl?=
 =?utf-8?B?bVJYbWxua1Q4U1JJdWtQZmpOdmFaN3ZVcUFFNmJUcjI0SlBmS1lJaEcrWHRr?=
 =?utf-8?B?K0hyQ2FMZzBpaEhCS1d3SVd3dVU5MkZjcytmemphMm1xbWZlSExmMmRHcFlQ?=
 =?utf-8?B?eWFFV2hpenFBS1NvUm5lUjlxZjBXY1BSYzEyMGN6U25UMmwvZUFsTlBtNUEz?=
 =?utf-8?B?WXJpOXVSRHhIYk1wNUt3MThyOU5XYlFOdjhSaFk0WTczcllaeFA4WUFSVkVX?=
 =?utf-8?B?SFMyQ2haUm9qbkhEQ1R3bFA2N215cm1hSzdFWTUzOFVwQTJQQ0pWRnU3T2sr?=
 =?utf-8?Q?pOYk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7588.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2pSK3pZYTl5TkczWXF3UjFGMTdKL0VQa1BzUnZrY0NmSmFaNk9oK3l3NUw0?=
 =?utf-8?B?SVBTWlY4Mmk4cG9DNW00YnBRbHlKWERZVlU1aytBNHlud1FsaU1vZ3RiS1ll?=
 =?utf-8?B?Ulk5QzB5b0pkcVQ5Mno3Y2FOTTNrSlJ5eDMrcjl3SVdBK1l6aWlxR2RTTXRX?=
 =?utf-8?B?RTBWdUhqOW9aYndOSDdlaFFaZXFJb096bmNsVjVnNEJwdVlXc3dpYjFjdkpP?=
 =?utf-8?B?NXRnMS9QbVlvOHVPWXZFSFFTVld3NVpYVkNJLytHL1BybWVYYmdaMWE4c3Ax?=
 =?utf-8?B?R3VvS0t4ZHNIM3pBMnMyeUlTdnNvVEdHRFJRMzgrRzRqUjRDZmZ0RHhmbk1w?=
 =?utf-8?B?WEVremt4cm1yTDZhWmRPbURxM2c4TExqeCtIVEJOQ1ZyVVM1dEw2N1hYbVpF?=
 =?utf-8?B?N2JBM2IvNzNnVmc4TUphbTRvWG1XeWVCekZhcmZsK1N4ZmErckVER1ovME45?=
 =?utf-8?B?V3ZkelNzWDFVWG5pd25jNWhqZk1aSGdMWXVRclR1ZzRjMU9xdTgxbDNLTXVH?=
 =?utf-8?B?Y1AyRzBlNmJza29jM0tHRU0rU0ZpcWlUekg0eHZ1VWZFS2ltSjMyWkV4Z1c4?=
 =?utf-8?B?R1BvTzhlUlVNVE83Ri9qMWxMTFk4QUw2UlhFWHNjK3NXemYvc3FqL28zMEVI?=
 =?utf-8?B?OW9lQlQ4d0JVaTNhTzBiZldST2luc3dVbzF4TnZwUS9vbnVkbG9rL1VMRGp2?=
 =?utf-8?B?aUxodEhIODk5aWdnZnQyU0xxT21RWk05T0RXdXg5Z094S2cvcHJHZUE5VmNG?=
 =?utf-8?B?cDhHcWoxUUZkNXNFNUVZdGExR3JuL0ptZ2NFOEo1ejNad3l2a3hCNldzeUFF?=
 =?utf-8?B?SXNKa3RFU2JVZjNYcFdtVEhpYlc1eEpaaGpMYnVJRVZTTzJ1YVlCWWQ1R2hw?=
 =?utf-8?B?YU5iejB2WG1FK0lWTWZHWHg2bEdoL01hNmdXb2IwaTM4RWMwb0J6VzJKdW5q?=
 =?utf-8?B?ZkdDTnBXM1dETWp3TUdPZThjT2tpenNUbHllVFovNW0xYmNKem1nVG56bEta?=
 =?utf-8?B?WEg2OFJWVWdzZlB4NWJidEhuNjJZVGE2QTRxZVYzVkF5WkxrQTc0ekxOMW5r?=
 =?utf-8?B?ZXArWnNOZjJlWHNKZCtTd0F5M1pDVUJ3SlBWYWdVaUk2ODJLb0pYelMwZDQw?=
 =?utf-8?B?b3VnQ1JZd3JGamRXZlFXSnQ2TG8vYXhlSFZWMU1DeVdRUHJ1Yk5oZ3Y4MFBG?=
 =?utf-8?B?Yy9FYjd6YUZ0SzdreTBaWStNdkdDTkY2MlprejB5Q2FmTkZNc3l5WmdKN2Z0?=
 =?utf-8?B?ZExPVFdKQlpPOFZVaXZFM1MwNHl2SjdobmVVSUxybU54MlpVbG4zd2QzU05P?=
 =?utf-8?B?Y0NSNytkN0NqOWdoUkFIdXNteWYzUmlEcDdSYTIyZWhHV1VYUTV5QmhuVXpU?=
 =?utf-8?B?c29jTUY3UjJ2a2JJeGNvWG44dUJFNm81WkJEWHJWU004TWhKM2NVL1M3SFBx?=
 =?utf-8?B?NU9qdE9ubVhERHdXcEdvbElKVzRRUDFlVUFBdzlPV1FrZG5IUXcyQmJsZnJO?=
 =?utf-8?B?bmdwRUVqSloxdml2U1dXWDlhNHBVSFpXckNRV3FVME02K1RVOE9LRjUwZXBa?=
 =?utf-8?B?K2pXcllhaUtYZUZBeC9JVW9lZ3BOSlJ2c3p2QnZhTnM3OHpyUUJHVExBUnlC?=
 =?utf-8?B?enJSWFFidFd1dDlHRGFOMGU5ektha3luYll1K3UwaDZxU2I0TFRQcEtGVDJz?=
 =?utf-8?B?Y1E0TmJwTjhkT0tvZGpNN0daUVkrSVpmSDRVckJUSFhDSVNTZ0hWd0FYb29X?=
 =?utf-8?B?YXN4ZUMyMTBtSFFBZUo0TFY0eDhTSCtWSTU5TlM0NlFnN0NUTjd4Sm96d00r?=
 =?utf-8?B?ckI3amswa3VtL21SQ2FQbjFJWnNWZkFvbUdQYmdKYkZGMnZRSzJXWjl2MUl6?=
 =?utf-8?B?d2xtY1Jzc1VnN2htTTZEbXpwQm03R0VWdmFhbUttVlRrQ1hiOUVISHRYRHM3?=
 =?utf-8?B?KzdIWHNMSXR6b2l5SnRDSERaRm90cDFlWi80WFdTQmNvWkhsN1B0K1YxSUh1?=
 =?utf-8?B?b3MrK1JuTkNuUHZRZ3lxaWpZKzZ6UjFpNC9nWDEzdXkwZUl3LzRGdTBoa0RD?=
 =?utf-8?B?a0Q1eVNrbjN2Y3lsYkdzUWpROU41YnFEb3pzR0tWUG5wYmFiOVNlUnplNUtk?=
 =?utf-8?B?WHB4b2FpaCs4Q0UyL3VhUndNNE1EZnJhVlpGdnd6QmhBcGJGUm9tUXRQRzVz?=
 =?utf-8?B?bzZiTDhZU0U4a3BtSitEVHc1R0R0aEN0cmViTmpRQ2paR2hiNUFrdWdkazgr?=
 =?utf-8?B?Ty9lSEJGdFY1Y1hteUtJQVpnMEl2VTNGYkw3OVJwSDJOUTdLWk5nRTgyYVV6?=
 =?utf-8?B?QVpjWWRUaURLSU9XbjlKQXNIQzdwRS9tRDlHOEFXNXVqcll0R2Y5ZVFhWnlB?=
 =?utf-8?Q?W+LgF1mtVcY5Ts1E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f3a0ac-db97-4ce6-049c-08de6a87ce5c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 22:41:04.9724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xW9KStG1+nkT2y6vPVgcaGMoUT4hO123KqMKHFeDg1qrSWYIPLsDz8cqyq6ulz5n4+FTdHzL8uwxo4VyR/KfcOh0J9nnb+BjHiJjSsv1J2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6086
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
	TAGGED_FROM(0.00)[bounces-16797-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
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
X-Rspamd-Queue-Id: 9C7801318E6
X-Rspamd-Action: no action



On 2/12/2026 2:32 AM, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> In the mentioned "Fixes" commit, various work tasks triggering devlink
> health reporter recovery were switched to use netdev_trylock to protect
> against concurrent tear down of the channels being recovered. But this
> had the side effect of introducing potential deadlocks because of
> incorrect lock ordering.
> 
> The correct lock order is described by the init flow:
> probe_one -> mlx5_init_one (acquires devlink lock)
> -> mlx5_init_one_devl_locked -> mlx5_register_device
> -> mlx5_rescan_drivers_locked -...-> mlx5e_probe -> _mlx5e_probe
> -> register_netdev (acquires rtnl lock)
> -> register_netdevice (acquires netdev lock)
> => devlink lock -> rtnl lock -> netdev lock.
> 
> But in the current recovery flow, the order is wrong:
> mlx5e_tx_err_cqe_work (acquires netdev lock)
> -> mlx5e_reporter_tx_err_cqe -> mlx5e_health_report
> -> devlink_health_report (acquires devlink lock => boom!)
> -> devlink_health_reporter_recover
> -> mlx5e_tx_reporter_recover -> mlx5e_tx_reporter_recover_from_ctx
> -> mlx5e_tx_reporter_err_cqe_recover
> 
> The same pattern exists in:
> mlx5e_reporter_rx_timeout
> mlx5e_reporter_tx_ptpsq_unhealthy
> mlx5e_reporter_tx_timeout
> 
> Fix these by moving the netdev_trylock calls from the work handlers
> lower in the call stack, in the respective recovery functions, where
> they are actually necessary.
> 
> Fixes: 8f7b00307bf1 ("net/mlx5e: Convert mlx5 netdevs to instance locking")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

