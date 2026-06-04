Return-Path: <linux-rdma+bounces-21799-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vlrMIUjQIWqUOgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21799-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 21:21:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 816E0642D95
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 21:21:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=iKTIUii1;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21799-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21799-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CA99300D550
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 19:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68433383C86;
	Thu,  4 Jun 2026 19:21:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B28385D77;
	Thu,  4 Jun 2026 19:21:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600897; cv=fail; b=jsJkNSA3sWHLesyBLgm5rGGZiqSJsT7PY/Y/jtwijlaAjIucOuQDmuDzRoy1zgrTSUzCW3OK1hKYRZGTmiIEjxckKck/F9WU5+R4obNIl3YVlNM6VIFNvf0yrsov2VlNanbDjSZj81n82SbzmbzzJsoeaT7DSVj7jLOu0u/Xoeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600897; c=relaxed/simple;
	bh=yMgiY07SRnU/VfcDImLxj4p/ElqZJatB9OZid5X78g0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p3e/ogntcnKp31zsDZwKuv4PLBXxCdse9NLd0hd4y969sEmZfddLP7Zy2TMHxEzbi5PGlZo1Ct5fsNQdZ01NHIv5rdqIpzVDCYgIeuYJ3lAPPk+tHJXbqKIAKOdwYg47VgMOqABkCuZBMftQ8NHO2vg1vUEX4XMgGAMUZwGLqWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKTIUii1; arc=fail smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780600896; x=1812136896;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yMgiY07SRnU/VfcDImLxj4p/ElqZJatB9OZid5X78g0=;
  b=iKTIUii1Ge55rLiZpP+TZkvLApdns0zNtJkDsunVTwJmhOMNDj+bE/xl
   m0aaQQzyhKyUp+cvhN26Ws3THuTpWE2QZIsohss88oaiQyq0KX52ISDPJ
   OjgbFf7eRl+SoE/EOOnavV8CBcI+AAtz86VMqnjFm+++XgQPlUQwfOcPZ
   zrvlL46n6i5QPDk9SFWmZVv+A7OQ90MQJlBWX0pJoDgTCzpgdQlfv+OeG
   N+Q/37siPA30mGciLOGr7UA65fgw4igyN6XS+GrZQAl6JEKEfGLBkBTOn
   tALe/2VcCKjMXXHDPjZu3TSv73c6JJUAaON8IXvNqsHz/s5ibudpJQVtw
   g==;
X-CSE-ConnectionGUID: W5K8PjX7RLy2Ip4ueLsGjQ==
X-CSE-MsgGUID: N+lgTr4ASp+6GjCcQ72DOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="91750350"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="91750350"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:21:35 -0700
X-CSE-ConnectionGUID: YsMzV3DrTtCzY68qhcBBgg==
X-CSE-MsgGUID: vp+xowV+Ts+d1iHxj5DISg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="244487545"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:21:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 12:21:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 12:21:34 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 12:21:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lD/l9g33NZHiuCakBJuAFay31DjVc5qYbtjwmyTOY57Wrj8tlq09l8aZurNT/qCOHujKQsCg5++bfxJg8D4aUYJ/xU6DthlWtBbMkfMCj+yTDpDEhsJCk6zJQ+xtSRb+/dr8CBnuH7Q/AH79v2UfmUBxxiUSbZ7Do9rCLnWYzHKzmwFnduT0mtPaschqzMV9XtGrA6nU1t6/9Be0Zy2BxypFEIsPg5GNTyTxYCIfPr/EsFar6DPrAIjdTrNv5wl+2XGJADoP7CtBHooRW7XF7wGi/ylzLhOByPYxAKc29LwveoOicw1AJnAvAGcVCV1kij5qJITtPSqQo1T+yEz9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3+L+GnTKl5CtlZVa2yXYA9N6yqfbklRp/Okdygqr70=;
 b=q651ZhVxmwxJu5YHk+b9rUKlivYBdBebjd5iAm3mxczG/UwNDVylRoNkEVPwYBGGvSfxvrnLi23IF7E7J/ViVi6WRS06KW+73lEdtnYiflDGa11WRYaMRrJpkbIKDLTq/hEd+3ufE/2q1ukNG8Jv5g+36Pd8LPmFz4d5R63rpcAly7Srf8i4xGPmPcPbu8qXVO6eXUGzgq2c5rPG1vkiHiUpY7jEPeNyk0irptGY3/Q9I/UJcTsbxspxhCIismVgeD3QTdKknI0ukCfHHBXQ1xpOiWMIGQyshzGjOjwI+fckWEakBbUZeZVoxvJnL/eGuDQnYYVH2Uwh8BQFWQP4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ0PR11MB4815.namprd11.prod.outlook.com (2603:10b6:a03:2dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 19:21:30 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 19:21:30 +0000
Message-ID: <cbd6c85c-ba5f-4e3d-bf65-0ac434a805c1@intel.com>
Date: Thu, 4 Jun 2026 12:21:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx4: avoid GCC 10 __bad_copy_from() false
 positive
To: Yao Sang <sangyao@kylinos.cn>, Tariq Toukan <tariqt@nvidia.com>, "David S
 . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
References: <20260603061044.2055155-1-sangyao@kylinos.cn>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260603061044.2055155-1-sangyao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0128.namprd04.prod.outlook.com
 (2603:10b6:303:84::13) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ0PR11MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c004c7-0659-46b2-b38a-08dec26e7b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jtUp+9Xo125ZXMMkti/c/pOUcj3XaAaOUgk/hCMxVTyF9QJwJKcrP0A9DBjVHCaSlkgIKOtvlaJ8UOycGup6ZCq2GkZ91rl+fBfizs6Pp7oDtCWkbqLnvsU3aBDChoeWhqv5Jqzdk4uIOd0UxpQNRgWAUd8+DYmtYmcOvraqlV1GYYqHlpAm9F1LISTUhEyWimoFZDBGTmxkAWE34g2Mu60kQNNXYmUwqbvTmxfInFb+bm5y1IfmzzWZ8r7mfGc779aoPWr8GmkONl5ijlXWP4NwZi3AxZB/qV2QNIBsTXGIQYFRPIk1gIkAXopmIqyv3H7nSgwPd7MS9pAXr8koWc3p0x8l3Qv84YDVPT6ZXKepGsGMb7HFQmwmL8AkMisU3RgoFJAcV54qwV8cn0KQiJ8Qyxa9vGy95SpjHt90DeqLwd+WGzeUl7Od499mDcY1DJmGYqovWI774kv9hwpoB7zeiOQPZZiMBBPXfpT7wUv1sS0OrQEmDrf2/lgtojjMoLNFFPWGoD4ZsNuDw7BdikwBsdItPVNqUvtaYg/jhOsbqP/NwvN5HMfuUnUStYpIo/7CLMksmoez3fHC4Blxe1OO7Nb9fniC7E2AAOjwMGb4QkWH3F8lhufTdZpJB8R1NTPZ471KKAPa5kFwdY5FfSoXMPprwOV07oh60wyjqEj/CDIH0f5NltNYwZTpiHLn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGxDUnUyazJJZHpoa2pWOERLVm5mbk1ralpwc2xCK3MwTUM1T2xVL1pmc2hP?=
 =?utf-8?B?cEdmN21tQ0hBeWI1UThHbWw1RGxMU2NON3lrSFhVUzRXVEtFUFZZcXhjMW5i?=
 =?utf-8?B?b2luUC9LbTBWU05YVUNzYit1T0NJa0xabE9pdXRXOEwvNE80QXNXNC9Eekh3?=
 =?utf-8?B?THpOYnkzcE9rTmdUQUwzdVkvS0lrMGVoeDE0QmxuM1VwWXJ3M005YjdkWm1x?=
 =?utf-8?B?NnJLdHFzMFhUQWVkNDROOHdSdFRpNTJ1dFZtRlMrNnBrRFFITmxPbGRCbXYw?=
 =?utf-8?B?Zjd6K3o4UTU5SnVuNHFTR00yUDlxdDNnYmh4ekRHQVFzcDFaWmhqWVVqczV6?=
 =?utf-8?B?TWFPYkEwNzErOWk5UzdwS1ZWNmEwZDNrOUF0YVRTVDljb01wVzJEMjFkZzNY?=
 =?utf-8?B?N09qTlJsNDhoZjUrbEp0dEtSZlczUFV5cjAzZTVwMlV4TFVOTVhqa3NRS2g1?=
 =?utf-8?B?ODNhdk52bzZXSWdYWHdzVG45NnFyNFUwMnNVZ1RBaGd2amlzVFpBZVRNWCs4?=
 =?utf-8?B?N1BHOXdFY2h3SEZsL0plT1dFVnBKemxrMlFCaUdhOWhKTmtXZjlaNDNmSGZz?=
 =?utf-8?B?czhObStyVkxEemx2UTJkVEtUV21sVy9oVDNkREpmY0NFZkVNS0h3VWd1ekNQ?=
 =?utf-8?B?VW5BVnZqbDB2ak9GeTJqZ3JYSng1S1pXNVVNeCsvbXBLcmdJaHE5T2xnVHRu?=
 =?utf-8?B?eTIyNnBsMmdwL05jWFpxRDRoNlBzZ0tOZlhpTUZqbHE5amI3K0RKY082ZXBk?=
 =?utf-8?B?OU1NQnkwbC91amlpcjh5UE1XdkMwMVAyRi9vdVY2NnJMUmJjSy9vV21ld1Fp?=
 =?utf-8?B?dFdEMWJmQUVmTkRKVW50R04rRWdReDNoYjJCQmE3UkZUaG9pb1h2V25oWjlS?=
 =?utf-8?B?dUFsWDZxUE5tYlh6YjdzenY5YUV2ZGlxMFdQckFDYU5BRXFLTU5mTis2UmJ6?=
 =?utf-8?B?ajhBc09vYWxuWWlFSTVidzU2OHNnbnFlQU5UYllTUjMxRTZuWTBXODFzdXNp?=
 =?utf-8?B?SDdXNzBkejg5TmkrYjF0MzNoRmRyQlUrQkRuN1ZPY2RBNm01ZTRRaFIvWmVO?=
 =?utf-8?B?RTlrWlhrSGY5VmlhaXlMSTIwYlNwK2NHMjRPQm5lM1pqdlYyWkVOci9hV1Zv?=
 =?utf-8?B?SmpqeElzTWZyRzNPbUhjbGZqdmFLQk1zdyt3VDY0Y25vejNyeEdSL0c5bm01?=
 =?utf-8?B?SlVncE5vQjNUWkpzdGJrVy8rOE55Z0s1eXd1OUVzbGwvc2grdzV0a05wdW9a?=
 =?utf-8?B?dzB5RUxqTGh4eXZ1R3lldXlFcVZQcVFCM1hXL0ZOOVRkb2Vsa3NXVi9sWXdy?=
 =?utf-8?B?OHArRkdEejNrNVNtYW8xcW5IeEdkb0c0VGJLaDlxMGdXNkwxRGhuQy93QjhL?=
 =?utf-8?B?SnRzRUxUc1VlWnRWUEw0QTJhV2E3Zk1ZTDJCT2Y1MlNZSGVqOEF3Sk45UFls?=
 =?utf-8?B?WmkvbnRZWlpNMGdnVVo2OTBwTlpSVTdldmpRQXdTOVVjNXM2SVFJWlhBUUdM?=
 =?utf-8?B?QnJxUDJRTCthMjYvMVNLQW9YN1l6cXBGc2lHekFzTVpvbjl3T0Jia2ovZGtn?=
 =?utf-8?B?bkI4Q2NxTUNIUzJJY0ZObVh4eG5UMWR2OUxyTVlLSkwxWUNpWDlKVHp5aDhx?=
 =?utf-8?B?YmgzUldmQTN3aG5uSTViTDc4SnhVYkVwU0FNbXNDTWdFbHpYU2JrMlhySC9t?=
 =?utf-8?B?OVBsYVVabWNKc1hncGFrclRMVTB6Nk5GUUkxMkEyQ2kxVWptN3YwcFBvY0Vm?=
 =?utf-8?B?RnlzOXJBd3Nzc3d4eVB1cDJsMDgzazVJZFkzdXpHRTNJNXZPbGkxaGZUNHhy?=
 =?utf-8?B?QXJhMnZNc25xLzRpYW4xMFhKMjhrNDh6bkhQODVmWTQ3ZksyZWRzNkRycU5n?=
 =?utf-8?B?eEFsV2lwdzNEYjJRZU5Uc2p3bVozUzdDajc3UzczMWFmRkV0c2h1aktDU25j?=
 =?utf-8?B?NGpnVjcveXZFcUM4c2NaQ0lqRmZsRTBkTHBwUWNIc3JJY1REQmxNVmY1Nk05?=
 =?utf-8?B?UjMrNXJFb2hZRVQ2OEVhWGNhYnVBWDBWOFpsdUxYNzVvbTh6eU8xMlZMOEFV?=
 =?utf-8?B?TGJlQ0RwS0I4ek1kVTNzL0JKdjFlMkNIQ0RsaG8xL2dORjdQU1JiS0JrUS9Z?=
 =?utf-8?B?WDN5cm9OajdRWmpFQnVXaDcvMURZLzRkL2YvSUJCenMyTXNyeXRCNW5MZjNQ?=
 =?utf-8?B?QjVwQ3V2Ukg1SG43V2xLYzhrcWN4RlFpbW9RMWM5UTB5dkcyWGFodXNoR1Vr?=
 =?utf-8?B?aHpwMFc5bFQzdFd6NmR6dXhlK0Q4Nk4vZVpXUVJBcVhXQnI2d2dRSWNINkFw?=
 =?utf-8?B?L1dDK1pyaGcva1lzUlZXTlpLZDBQOFV5SEtITGt3cWxKUEZMRU5lY0NPTVVt?=
 =?utf-8?Q?WHoLWgivk+5qHPf4=3D?=
X-Exchange-RoutingPolicyChecked: F9Sjsiaj3X8gnXp86kCZrZmIxgaR7C3tx63VMy8K1pTwGcvP9lGO/tu1gBCBQuqttSCmqSPKlFEDqjPQ4WW/xYsR8kBX8DNjEYRRIJqKDD5Z7HcZCEQ/W3CczhvYBz3DtYaaLRDuClv0czOGEm3kYS/vkPapr5Z+8RA6ZnHMESlmRui5F0GBPwgHGZhiftq/ONAOSb8tO/DiTqiWJNL152osTsH+FdTrT+XNJKnIgRZuLPVWc8DuD9l+pKGTCDDgR/K7NgXsiYp106qzGok85eL3VCnl+IRS+UALnq2zB5gCe8w23jY+iNrM75s65FWRcNhcd5HEGYM+Zp7MWXrfNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c004c7-0659-46b2-b38a-08dec26e7b44
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 19:21:30.4899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ump500EmIroQiZLF0qY95zKBuD2WXWb1/u4hlJvjfe2rUWqX45nEVUTDmjy96ikSEtYlYVmRZSc/e4SgSqd4+6IUSabFMbdF0LyWUbRo7ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4815
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21799-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sangyao@kylinos.cn,m:tariqt@nvidia.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:gustavoars@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 816E0642D95

On 6/2/2026 11:10 PM, Yao Sang wrote:
> mlx4_init_user_cqes() fills a scratch buffer with the CQE
> initialization pattern and then copies from that buffer to userspace.
> 
> In the single-copy path, the copy length is array_size(entries,
> cqe_size), but the scratch buffer is allocated with PAGE_SIZE. GCC 10
> does not carry the branch invariant strongly enough through the object
> size checks and falsely triggers __bad_copy_from().
> 
> Size the scratch buffer to the actual copy length for the active path,
> keep array_size() for the single-copy case, and retain a WARN_ON_ONCE()
> guard for the PAGE_SIZE invariant before allocating the buffer.
> 
> Fixes: f69bf5dee7ef ("net/mlx4: Use array_size() helper in copy_to_user()")
> Signed-off-by: Yao Sang <sangyao@kylinos.cn>
> ---
> Changes in v2:
> - Replace silent clamping with WARN_ON_ONCE guard for array_size()
>   over PAGE_SIZE, return -EINVAL.
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/mellanox/mlx4/cq.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/cq.c b/drivers/net/ethernet/mellanox/mlx4/cq.c
> index e130e7259275..5c55971abbf0 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/cq.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/cq.c
> @@ -290,6 +290,7 @@ static void mlx4_cq_free_icm(struct mlx4_dev *dev, int cqn)
>  static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
>  {
>  	int entries_per_copy = PAGE_SIZE / cqe_size;
> +	size_t copy_bytes;
>  	void *init_ents;
>  	int err = 0;
>  	int i;
> @@ -314,8 +315,14 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
>  			buf += PAGE_SIZE;
>  		}
>  	} else {
> +		copy_bytes = array_size(entries, cqe_size);
> +		if (WARN_ON_ONCE(copy_bytes > PAGE_SIZE)) {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
>  		err = copy_to_user((void __user *)buf, init_ents,
> -				   array_size(entries, cqe_size)) ?
> +				   copy_bytes) ?
>  			-EFAULT : 0;
>  	}
>  


