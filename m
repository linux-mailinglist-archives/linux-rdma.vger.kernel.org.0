Return-Path: <linux-rdma+bounces-17003-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAiKBB5Qlmn+dgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17003-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 00:49:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAC915B06F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 00:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ADDC3027B5E
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 23:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287530596D;
	Wed, 18 Feb 2026 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DuoYiLFN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92CD27979A;
	Wed, 18 Feb 2026 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771458567; cv=fail; b=YxD58VNm/Wim5lNOyfil1xcFi3IlLcT9bgWRxoqCp0o4mAIYUjMD66X1JfAP43cVYPy+dTy6x40s3sNQqagDZGz4TTotjjVaz1T0BfYuD0ONBKv1bngfhRePjqW6els89+xIWNdiaJfun1urLKoDsTv6OCs3J2TLs2SLJKM/oVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771458567; c=relaxed/simple;
	bh=EHMgKtWJlAbel9awMTROR/GnE1g8D1aSAYZEH1LIivA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XUddaR8tIGyiAiROGBzxVJweJAUJIv1rWAS1a9MSvQz9UdgSvJ6RYUJNVgkFIWRsYP5gyZPe+8pMPsWh0NJ67PBcoCuM3PiwMf5purbh09gqeq1kKBXyuMvVCilaftyAYbSSjn6hWzovcJuR7ewfOe0P9EVFh62jwq/l5WZHqVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DuoYiLFN; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771458564; x=1802994564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EHMgKtWJlAbel9awMTROR/GnE1g8D1aSAYZEH1LIivA=;
  b=DuoYiLFNPk6pc+VltKQEfHjUG3I+KIKwdWHM5ay8OBoypht0AfEcIrYm
   ag38hRr/U6cYhR9qEPS0ROw4hKUqTOETLhJ8xpHeoVJh28sDcQQgZfKi/
   lqBkK2vznCJhZofjwHMFMjQhQKv5uN+Gc3EJxrAfQuAJ022k4GawASa4o
   8zjMBRfOBZpLoKhJUBmQLLsCrJjurXqUT8ZhXmNJyB4qia4keEupUqyCO
   vKAN3q7Jo/5Bvdw5GUXoGoSEX262SKRK6uQmTDDOoTqMl6gByX3+ZwfR8
   bABVaohRlSPKvJ7Tsw1AYPFLx8c0WHXnCQdz7R+6OrGib7/IKdei1CZ/y
   Q==;
X-CSE-ConnectionGUID: 7CVnlizIRb+TMmmIGhUgXw==
X-CSE-MsgGUID: N2YWLD8CSIGCISqO4ey12g==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="98005792"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="98005792"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 15:49:24 -0800
X-CSE-ConnectionGUID: adrhzNWlQMWHp17JQAEZYg==
X-CSE-MsgGUID: 0nKD7SINRQSdqE5UzWMK5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="214206438"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 15:49:24 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 15:49:23 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 15:49:23 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 15:49:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1vLZ1ZtY60GARi2mz/SGC2GLPf2hHH3dw3LOaCKi3hgUe2QWDZtA0PDBm6EvNoGTlKU8UxEREsJv9eneHKaHDhXq6I7ocp2A+ElNLkjkiLi577Iddr0jcGMCPh7EhbJmUXRtn3O9JFRMyNcugnXogURf2YduafLVyjHvHPYm4Q7FQ5zwILRXZLpyTZpxMD1oKE2BkgjqPi7RkTHAnosubMC0C7vtUCK5lWgKaiNwbiHmpZpIdW1foEtZHS1aYqu6XyxmMrtRD+O53N8Um6Uf7ruAm5FU5tXCbwdZx2m9eqBqao1tkhFEEP6rwNO00f+sMRXEm8yQRmDNXnpIV/XMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHMgKtWJlAbel9awMTROR/GnE1g8D1aSAYZEH1LIivA=;
 b=GUoXYv0N+EREr6O51NQaybDNOp9/X4gXPGkJAvAtdElxeZ1N2Kn9T+KoiPSYDKOtsGzNLORdgvhQZWBybwqWS0VoGlTqqeZXhYWvcZA00s5YhBgJuNrEFkaShcDM2uK77x7ogJBuGcgDOg7Rb8K7SexFw+7qCJsvNYA6as2IK/tRSpIxJdyDUPz61uEX+8OHGjwutlhx1Uht+iPTGmpZ1AdevhJbL0VgStaVepkNcs4sNs4WeRiGGd/LeBKG3aT2oBCi+MFKauw6oYlHHuns9pOpp0nlTCxCDQHg/Zbpc4SrdJEWMadpiRXwkNCtXkhxi81/8eI57bp7Nyiq7hmx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 IA1PR11MB7271.namprd11.prod.outlook.com (2603:10b6:208:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 18 Feb
 2026 23:49:20 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 23:49:20 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: RE: [PATCH net V2 0/6] mlx5 misc fixes 2026-02-18
Thread-Topic: [PATCH net V2 0/6] mlx5 misc fixes 2026-02-18
Thread-Index: AQHcoKhcLCfzsmIHhE+Xm4yGaxBykLWJIPJg
Date: Wed, 18 Feb 2026 23:49:20 +0000
Message-ID: <DS0PR11MB7579D2A0B025F75FD4CE626DD66AA@DS0PR11MB7579.namprd11.prod.outlook.com>
References: <20260218072904.1764634-1-tariqt@nvidia.com>
In-Reply-To: <20260218072904.1764634-1-tariqt@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7579:EE_|IA1PR11MB7271:EE_
x-ms-office365-filtering-correlation-id: 29c4bafc-13b5-485b-62cb-08de6f4855f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Vm0zdkFkTlF3UnRGT1VsbE5CWWp4b3YwMGt3WjYyQkN4Q1A4MmtQKzVTTnFj?=
 =?utf-8?B?NURLN0lRL2QvL0lCdHN4NVZEcFVmd0l3SGlwcThBUXVkc21NcnlWaWFYWmlR?=
 =?utf-8?B?VVNnNTVVUGRkSnZpeDBqT0pFSTVCS2tRU21ndlZQOHlhVXJsSUc2cmZBZVg2?=
 =?utf-8?B?ZGxpc1IvN1BLeFVCOWQwYzhNYyt5TVpUQVpNdmY0Z0VSVlRrN1ZhdFltbVY1?=
 =?utf-8?B?SW56NUpuWjZtSUNZTm5qTTlQbDNZdzd1dTd6clI3aC9aMUdKcEhHT2EwZk5s?=
 =?utf-8?B?K2VaNk92SW8yTEVuRUdJUk0wZHR2OWdBbTFJT3JhdVFZNlhqOVBDZG5XRjZI?=
 =?utf-8?B?T0djYnFKSk1kMWF4Mk52Um1wOTBBYW4yVHVSc01hNHZHTGNQMU9xNWp5bWJl?=
 =?utf-8?B?YThxd05jMjV2RnVMR1V4MlI5M0s4cHcvL3JXaFUzS2NHSzhJRkFWejI1Mmlo?=
 =?utf-8?B?YjJHM1dZbW1PSDdKcjhtMkJmVUxsZUt6TXpZb3BRN1NGU2MrN1ZMS3NudXc4?=
 =?utf-8?B?UmFESmZPZHl4d0wrZWk0UFZpL2hsczE4cC9RK0hSdXV4TW5ZZlZyaUZVU3Vt?=
 =?utf-8?B?S1U5NmVHdlBNbkJRTmtWV3M4MWUzcWFvY1ZVSUk4SHY3MkFUMEsxRnpYVWJR?=
 =?utf-8?B?VmFBeEUxNUxZTWV1SzJ4WkdKZXNET2htbTdiVXFYYTRCZSttZVUrbWtGS2Jl?=
 =?utf-8?B?WnJFN1NXZmdrcFlJSTF6QmZzcXR3V2xnTy9PSmRVelNyK2lFbUZtbjRUV1gw?=
 =?utf-8?B?VDh0MFczM0xGY0FPQ0EvYlJhZXhld0J1OEJhVmVsSnVCU0wzd1hRaEVXcXVv?=
 =?utf-8?B?RWR2NWZobU9MUDNiK0xQWjFic3AwTGMrWmN0Q3I3cXY5bURVMExZbm1QU2F1?=
 =?utf-8?B?NllBckRRd1NTc0xoaEJlZmpXcXpURWNGQmhnNThGRDVNRG1OemNiMmVKOTUv?=
 =?utf-8?B?dWNlRXM4ZjZyWUZPYk45bDZzWG9mM0ZtcHpsb0lhbUFXdXEzNXFIdUtDck9a?=
 =?utf-8?B?Nk5kYS8yTXhSZXFGTVA2Uy9YNlRna29FSm9RaFU3d0Q5eGxKYmJ0bmFaWWJV?=
 =?utf-8?B?WW10NlpxUWlpaUhFMEE0QllPT2J1Vm12d2ZSb1dNR2V3R3VteHBBWjFoUDAz?=
 =?utf-8?B?N3doenNyNitnS01oaTRnUVh1MmNxZUNIb0hPTHI2Y0ZCaDZaQ0xsdTBmNnNh?=
 =?utf-8?B?MVhxQnU2M24yKy9iR1pOU2dVKzBnYnE0TXRYdGtvUjA2aGJGWnlpb2xOZVdR?=
 =?utf-8?B?bjNid1FMUGJaWjhzaENraDdoR21HK3NndG5sKzhtRWJhdjkvanFMbmNJaS9Z?=
 =?utf-8?B?TzFkZDRQeWdqZWt2c3Q5VjJyQnpVNTZyamFtcHpGcTdNazdYVk9UazU3UFZp?=
 =?utf-8?B?R3V2OVFab3Nlb2NGQTdpRUtXS0dkRUlHUkU1YkhKNTVMMzNDU29ZSnB0blNQ?=
 =?utf-8?B?UTN6ZlJlQUNPN1VLODIxdTYwWmhuMmpMSDV2MmdudGxmUkVaZUJPaXVIVjE5?=
 =?utf-8?B?Y0VvNllVbXhLalJlVVp1bnVERXFtVzF2L1grQjQ3MjdyOG9hVW9EZm5pNWhG?=
 =?utf-8?B?MW1lOWpHZzRFcVhzdWFUUGpJeEFEc1BzWUpGS3ZRbnlockY3MWVuQk9uVlFi?=
 =?utf-8?B?L2d2Y2VWSGp6Z0xoNldLTEdzR0NVU3RxTmIrVzNSTGdXSjRyNFR6eEZCUVQ4?=
 =?utf-8?B?alpKd0xJOHl3eTVQVDA5cHhCL29kdlJFMFdPUzQwZ0xjNjlNdmpsRmdSRUlK?=
 =?utf-8?B?d2FFeUk4TTkwVEdielI1WVU4MXVVbTVxMTZDWFlCb3NpQnBpMWNUWUU0OGpV?=
 =?utf-8?B?Q2VpZlZCekd5Q0xnWkVWdlFVRXh1RlRGVEpwMHdlNDJJL01YbWk4VklvL1Zw?=
 =?utf-8?B?ZVNLdlBNZC9tSVNSWXFXMjA0SDQwdFdXbmE0eWkycjFibEpIbGZtNWFGTVNp?=
 =?utf-8?B?ZmtYWTR2L1BlM1I5d1J3SUJsQUJjbG01cVliOVJZaUVZWTVDOWZDbVJuNHlM?=
 =?utf-8?B?aGUzNkVTYjJIcEdrRWFpZjlUOVB0NFdFbmNacnJaaS83L1NsYmx5cHp4SEY3?=
 =?utf-8?B?Y1h6Tis0NHo1QVFCb0JFU1JFZUdBcUhobHhmUnlNblpJcmRRS3JzOGlaR2ZM?=
 =?utf-8?B?YThQOEZwVkJWK2RPTWtvbkp5TEdIU0h2aUtQUTMycWNQTlpwdXlLNy93NEoy?=
 =?utf-8?Q?dP121S2pkRf6NlghJS0TK+A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVhYL2FHcnVmalNNWFYxcGJUTGJIZ2hldVMwVHQ2Yk9pNmdZeHU4SjN0TUhU?=
 =?utf-8?B?T3UzNldsdW9wdVp5ZHZrejk0SkJXZzBILy9nWkhjYVpNRU9UMGFwYTVYMDJr?=
 =?utf-8?B?MGtOWE1nM1hJUVA0Tmh6NUs1b0pvdFhUeE5JVjVWc3pZZGd0bXF6T0liM0FE?=
 =?utf-8?B?bEthamIxZ3NRWmF6U2pMUDJrLzIyekZQNms1SjhwZy9aNnc5V0U3ekVVM0Uv?=
 =?utf-8?B?Qi9vYjhrUkhKbnZsdS9ncEcrMTRWNjkwK2VyUlN2K3M3THZIUVY1QWNsakV2?=
 =?utf-8?B?bCtyNGg1d0xpRUFBM2s3UjdBS003d015eUR2VkFzbHY3K05tZ0wxd29BMUN3?=
 =?utf-8?B?ZmZ6cnpmamdKOHhmYXNFVWp4U3U5eTRzdVJxMnYySjlIZTJIRkJNYXpHZVJJ?=
 =?utf-8?B?L1lEL3JPV2IvVUZZbWxiVnJucUJFcGlQVnZESzFxZDY0VmNFbjdUZW0wYmRW?=
 =?utf-8?B?bTBhNUs1bHVPRGNjKzV1N0hnN3JlV0lUK1Z1YjJ0S2hJNlNOMHV5SnpZVlRa?=
 =?utf-8?B?R0lZVERKWkNlS284d0kvRUFmVzkzY2lvS3FSWWpTaGNhMktTVmlpTVp2MWV2?=
 =?utf-8?B?U042Y01Hb0pTVlRRNWZSKzJtdGNiSTkrRC80WE9wOGdIdnVyV1VvZ3VycFFY?=
 =?utf-8?B?aTJKV2xvSldBbnJtdTNqVHU5ZXJGdGI1S3BYTlF4aEFiNTFWQ0o5cUpuV3VO?=
 =?utf-8?B?VUsrUUpnbXBMemluTVdkbWN0Q21vVG9qbW5ETG41aCsveGFTZ29kUnlkeHN1?=
 =?utf-8?B?eDdzYVhTVHY5d3pScHI3RUxnNHdINk51Zitjd0trdU9FNXJVSEwxdyt4VkJJ?=
 =?utf-8?B?UENkaktYZ3dveUgrczVZYk5DSjRjNnhhRW5YcGpqOStQaWtsc1VVaWNhKzE3?=
 =?utf-8?B?NExuL3RUREUvQTlnck1xNUJ2ZUtOOWxLMzBWT200dlZKMzlOS0poWjg2U3B6?=
 =?utf-8?B?ZHRXQmptR09Kc0dpeHdwYWw5aWZTelJDRGVnUWhndm14UERLZ3NyaExQczY4?=
 =?utf-8?B?cnErNGRWMTFRN3NjcHptY3FiaHc5VGFQQUNVOUhBUDN3Y05OeWV2NFVwYnJt?=
 =?utf-8?B?T3RSU21xMUpNVnhXSWEzS28zcnVKVDdhRlk1amIycmdQYnF5TFdNYXY0SDJ4?=
 =?utf-8?B?WE16d1R0M2l0WVBocDU3eXlDcHRndGMwdm4zTkVJMDZZUi9zR1puQjVKUDZk?=
 =?utf-8?B?OEdPWGxZeTltMUVGUXJvbG40b3kybVF1MlRyRGc2SGtML2F2M255ejd1eDFI?=
 =?utf-8?B?QUlXK0VYZThscElybnRaTTJEcDZrd0ZVTVBoZllRQ242endXT3FySlExd2ZF?=
 =?utf-8?B?eC93blU4eU1nMzhnUFpPSjJLeUk2K3BCWFh6OVRQTVVZdDVRQWdSVkZUYzBl?=
 =?utf-8?B?aEs0a1JoMU50dEJVaDNNT29CdDJBS2xoWmxaMkV3TW9MNUVIbGovYTFjR2I5?=
 =?utf-8?B?ampvcGtDcDFjZnpQa0RCTmtNZXNjTGt0aERGNDlOUE5Mb3EzVjUzS2tqaXlt?=
 =?utf-8?B?ZHNDZ2hvMFEzZVlyRVRDS1ZaU2RWVW5PMDVoZnlYMW5SMkczbHo3Z1M4VkVr?=
 =?utf-8?B?c0VuQWlXZHBsaElnWEduRExibkdXeFpRZHFMSjlrS3hpbHhJRC8vSzJkcll4?=
 =?utf-8?B?MFpZUnV4M1lsQjQ5YlpRK2hKc3dCRkIydEp5Wm4ybDhpdTdkR3liYlZXU0ZD?=
 =?utf-8?B?R3MzMVBtZUtodFJaMHVsU3Vid2tnV2VwQ0ZzdlNiY3ZDT0NGU2VRTEtxR0lU?=
 =?utf-8?B?YXoweGdaT3VMMnE1UE15YTAzMFVvVkl5N2RSakNXdVNJUis2aUx0Q1gybml5?=
 =?utf-8?B?RXZEaGJGRko2UVdqRFROTjk5Ymk1SnNxeHRMcnBudUhHVzZKNXlLZFJPY3Vh?=
 =?utf-8?B?OFJVTkxobU05ZUliZitJekRMTStMOThIZ3FQUWZoZmhZWEdYaXNTZ2lHY2hU?=
 =?utf-8?B?NG05UnRaaXdkN3c3cm5MU0pReVJrNFp5YVBuOE9kQm5oYjZCa080SXVjQ3pP?=
 =?utf-8?B?MGxITUNoSG1KMDJxREdORlB0WHBYbWF2alhZRU5YOHBBbzRFUjFLdmhBb3Fw?=
 =?utf-8?B?NFVIM0NoVlJUNkU4MDRnODRNakhsUDQ2QXZvTkRtVFdUWWJ0OFd2WlZ5YXVZ?=
 =?utf-8?B?WkkwODdHTFZIQnhua3N3MlBVbElxSGpsZ2lxYlJnTWZJVlQ3SkNITEpVUWRv?=
 =?utf-8?B?YkQrV2FINS8vNHVaaWg1UGRGWDFaUmxpakNjTFhRMWJtcmdyeTdZTkMwcVNM?=
 =?utf-8?B?dHYweXB4Tk4wdVg2dzhlV3g3YWk4NGNhOSsxT1lWVFlrRXJ6M0VxWFhDaWZR?=
 =?utf-8?B?eGdMUmhxWTcxTGdySS9UMVUvTFZGVDlJMFUxS1VqVzlUOXpLdUtKUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c4bafc-13b5-485b-62cb-08de6f4855f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 23:49:20.3255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RpuAQi1yFUJR4soErnYnIqmMalTSbH2YLp7o9L8sRly+Hg1gKLKFh/njXki82oRvn5xpAT5RxombARrhKIXlQRJR1ZP1FBSeTCWDpzkOCmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7271
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17003-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9FAC915B06F
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGFyaXEgVG91a2FuIDx0
YXJpcXRAbnZpZGlhLmNvbT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTcsIDIwMjYgMTE6
MjkgUE0NCj4gVG86IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtp
Y2luc2tpDQo+IDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5j
b20+OyBBbmRyZXcgTHVubg0KPiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQgUy4gTWls
bGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KPiBDYzogU2FlZWQgTWFoYW1lZWQgPHNhZWVkbUBu
dmlkaWEuY29tPjsgTGVvbiBSb21hbm92c2t5DQo+IDxsZW9uQGtlcm5lbC5vcmc+OyBUYXJpcSBU
b3VrYW4gPHRhcmlxdEBudmlkaWEuY29tPjsgTWFyayBCbG9jaA0KPiA8bWJsb2NoQG52aWRpYS5j
b20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgR2FsIFByZXNzbWFuIDxnYWxAbnZpZGlh
LmNvbT47IE1vc2hlDQo+IFNoZW1lc2ggPG1vc2hlQG52aWRpYS5jb20+OyBLZWxsZXIsIEphY29i
IEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIG5ldCBWMiAw
LzZdIG1seDUgbWlzYyBmaXhlcyAyMDI2LTAyLTE4DQo+IA0KPiBIaSwNCj4gDQo+IFRoaXMgcGF0
Y2hzZXQgcHJvdmlkZXMgbWlzYyBidWcgZml4ZXMgZnJvbSB0aGUgdGVhbSB0byB0aGUgbWx4NQ0K
PiBjb3JlIGFuZCBFdGggZHJpdmVycy4NCj4gDQo+IFRoYW5rcywNCj4gVGFyaXEuDQo+IA0KPiBW
MjoNCj4gLSBBZGQgcmV2aWV3IHRhZ3MgKEphY29iKS4NCj4gLSBVc2UgcG9sbF90aW1lb3V0X3Vz
IGFuZCB2YXJpYW50cyAoSmFjb2IpLg0KPiAtIExpbmsgdG8gVjE6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8yMDI2MDIxMjEwMzIxNy4xNzUyOTQzLTEtDQo+IHRhcmlxdEBudmlkaWEuY29t
Lw0KPiANCg0KRXZlcnl0aGluZyBsb29rcyBnb29kIGluIHYyLCB0aGFua3MgZm9yIHN3aXRjaGlu
ZyB0byBpb3BvbGwuDQoNClJldmlld2VkLWJ5OiBKYWNvYiBLZWxsZXIgPEphY29iLmUua2VsbGVy
QGludGVsLmNvbT4NCg==

