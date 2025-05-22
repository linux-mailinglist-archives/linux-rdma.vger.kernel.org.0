Return-Path: <linux-rdma+bounces-10530-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D062AC0AA0
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 13:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900DE1B646D2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFEA289E3A;
	Thu, 22 May 2025 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zZ49gaXQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEAE28934B;
	Thu, 22 May 2025 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747913317; cv=fail; b=PtiqFKNBxqQaG9/7GP0s2JCnkyCWUB3thKmaBJP5hUChZTrUTaJBYiS8SM9p0wBMbEwjJLbZvvPiI6zXQ2/c/mL2B4JVKK2yoMzLfRybaqc6+5DH9m4WW1BAgsStYNAnhEMLFMyaCwWv5y9PlaS5vovp7ZN+h8/cY3PTLoISQO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747913317; c=relaxed/simple;
	bh=O1Mo6MVo8ZN7fT+gJDAxwbN+k/gP212RN6fKzqj48JU=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=fiVaDF0WLCWOHsI+MU9r2Z4WMNOstEY3jt6tm0gw6Qs0d9vecHJPMnpsLSCllvjjbwyLkIrBBu0GU50VHfQ6wD7zOU+mj7GoTSEfpilNOT6i71qIC+C/oNRpiKE5b80NvXumms8nsVWiUY7t6Xm94//RGbV3zGtbQWWllCjOoTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zZ49gaXQ; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQ58JVl6VreOONA8Hiok8Vai1LCQx6QM5KGStE06fNOHA/TKzMRs7fFN2m1by2YQTwGrNx4fIcaUSjf/e1ajj4yM8T2ndODrg5p6pD6LKoJuZWYGcsbnPC4ZStDRkeD7ettzi1IeXQm9vRPY8Dygm0xSDyX0oKc/cdjY32GGC5trrH+MX3cVo2Me0sbfC+PS6dE5/+Kb6anoVt8PLtGEKY/tnDCNolj+LJn/1tLZ48pfZ0c3oqCzehIqit+CijdgTdYfAbVQiHBLd542EmESvX1Y7f/9jHhjE6T+MIL4MYExGPPdsUPsS6Ke1Cqw0NPq+vXiEXTy0hR9jjsjbwlCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUHNaxfVGQ1OSqEbvz570MPJBKg4l7vNdrNk0BtVoMs=;
 b=HWYCAg7PHRm7DK5vQT9bYMU40jrO4myjjhU/cMlPNO1NGTpslecqtrRdZPYWnhQpRiWEwryFNiecrOHbIx/JxcZSJ8m+Lx64U664KPf7ovKV9IdoHMkKSSj2o6G8d98JeQPJJAQmm2KHWyiLgIkdKo1k1RaaoS/VuxerCGuOkz60HEo6kjNaSOeFYEdVFVGeBZVbgBZCC0A3C+IhdTFcdPZWoih9q/yHr1L5SuL90i42ArB3TFNouENDmV/AzMmsCFXKVQhkO719s0SbSPx29yCGjyMepk4tgNqjmjBgmLWXtTFqEWMXrUA8oGGWGcKJxH4We9G1G3GCoSW6xCjxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUHNaxfVGQ1OSqEbvz570MPJBKg4l7vNdrNk0BtVoMs=;
 b=zZ49gaXQ72EkzKoJ9Zmasw/VbEdI12usrI2RCz/uYUP6glb/x+daoQ7UHMhruDC898/xabGTgVwwGNdivxenH1DpgILzrE+J2aCsTjJEo0mtE/uUbVdN04VQPdaaacGFIxsovszDwU7EvT2RWFF3gz6/AGJqTBoeDwgf3nUmYio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 11:28:30 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%6]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 11:28:29 +0000
Message-ID: <6bc6fb63-2a31-808d-91f3-eb07a681e631@amd.com>
Date: Thu, 22 May 2025 16:58:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 00/14] Introduce AMD Pensando RDMA driver
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
 <aCuywoNni6M+i07r@nvidia.com>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 leon@kernel.org, andrew+netdev@lunn.ch, allen.hubbe@amd.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aCuywoNni6M+i07r@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::6) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 5491f2bc-a6b8-45a8-3803-08dd9923c6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1k3UVYxTGtJM3lWNjB0ODB3ZTNxbzE1Vlp3UWI2YkU1MjBXMDNKQ3d4a0Z6?=
 =?utf-8?B?bVdIaW5PaGRHbDRhL25IbGNRSDJDQ3RRcDYvNWw1OTljajZtU1dOOWR2ZXAy?=
 =?utf-8?B?d2NyQ1FsQjJrRFFUZFZVNllMUE1YZ2hiL1o5eGNxM0FzWlVVajNwcnE0MXhG?=
 =?utf-8?B?NzM5VVlwcFhUTHZQcEhGN2t4ZjFrWEJYUUxhWDEyY3pUbk5YdlR0S2tpcy9D?=
 =?utf-8?B?VllEWTJFNVM3VVBqK3JBTmU5dXpNTlZOU1g4bjJ1WXZHS25JNlNSSmVERUY0?=
 =?utf-8?B?dEc0TWdWT0NtRG1DOVBjYVlENzRVQjQ2UnB1VzZFWlhrZVV3Y1NRcU9MamVi?=
 =?utf-8?B?ZkVwS2liVWNwbENzMnFtdHVJL1ZnRGVyRElrVnhXa3BweVR0R3hqa2JIZTJC?=
 =?utf-8?B?WStPcTZLU2NicVE0a1dkK0ZpWUJJeWVvM3d4NXNtckczTUxhVkRjUXN4dGxQ?=
 =?utf-8?B?aDZTR3JiVDdueVRHQWJXZitWeXVzUGM5WXd4Q25PVS9wM3ozQzhpbk1nS3Z2?=
 =?utf-8?B?dFZnMjQvejhZYll2dTl5cGJ5eEJLMnFHc2gvNXF3RUxveERySzU0TDhpKzZM?=
 =?utf-8?B?Wjd3aTRpWG5wRVJPNnVQTnhQWkRPdFpuby84a3pqSklIcHNBWmhuUTZuUWpK?=
 =?utf-8?B?K3NEZlduZDUyY1N4TmFYMVozc1Fwc2FaRDhoam9PbnNXeitieitpN2tieDA2?=
 =?utf-8?B?OGpGRHZ3N3RhN2o1MEU0bDlIeGgrbmNCc2JqWUlCS3N2OEVQS2FuZnEwRGpG?=
 =?utf-8?B?elBMcWZZSFg1N2RNOTNuWS83Ym1Fb1M4S01XV0lCeU91STZMZTVzRzRwcU1H?=
 =?utf-8?B?NHFvb0Q5TG0rNWhENkVtUEFvZUFEN1FxQTBBWmd2SEtQQ254WGVYZFJHemRC?=
 =?utf-8?B?eVNJdVNaMjlsbC9VbmJ5bGZ2dzFxcjVjdWliZFR4RWk4cEppNkhKbTlFQlI4?=
 =?utf-8?B?dU1CcW9tMFZqVXpnczgvM21KdU1kcTZWeHlFa05GWFR0RkNQSytaeEdZYVlq?=
 =?utf-8?B?dFFINW9rYXBJeWlhWGhvVWw4d00rU2N2UVpiRUhOdEtabkxEMGRURkM3NDRE?=
 =?utf-8?B?YlliN1JmZEVwSWh6cVdLaTluUERTcURXeXJCQmpSRXJsRnMremhFQXkrazdm?=
 =?utf-8?B?ZS9ZWWpnN0xjM3hCYnFDV0YvOVBEMWFIR29wb1gzYnZTVk9UZHZvaGhEYndF?=
 =?utf-8?B?NDYyT25ZVlV2ODBORHlLSUR4NEZlMmYzTDF1Z3RXWmlXZXl0eWRwS0JXSldl?=
 =?utf-8?B?T1hieTlRRm96OElIeXF6SjB3VE5XMC96ZTBVa1ZWYlZJcGlWV2crU01EaCt0?=
 =?utf-8?B?SEdReEhBVUlSaFlrSWROOU9yZ2hacUdMVDZESzhyWGJjS3g0OUdIZ3dpdDlN?=
 =?utf-8?B?dFk4S2NuMlgwM3hCTzBhVjVUNkU5NmdiWGlIVEVIYTJKR2pVNlI5VkhQNW1x?=
 =?utf-8?B?ZjR3NlUxZWdORlRJZlZZb2RYZ0tXSEN2NVFTd3NQV1BwdTlRaXBhcDU0SnE1?=
 =?utf-8?B?NFV0R1FiVjB4WVlFME9CcE9lemVxUGc5MnZGcVFENmhJOGxHSUhzTlU0VXgv?=
 =?utf-8?B?alJpNzFlazF4eUp4MjhLb2tsQTIrREt2REpzelBqTm80RnNLZmN5LzFGMy9i?=
 =?utf-8?B?RStEUE5oa0h0VXp6clpvemczcWJ1K3QxQ1BaT0ZJQW1hNjg2WUJxbkR4VU9X?=
 =?utf-8?B?QTdRSmEwdDEvMzZzV0RzcTVQQzhzelZrUzhWKzJ2aDMyeWg4L0JIc0JkNFFO?=
 =?utf-8?B?a0hzTUx2Z0owWHg2YWhHRlc2YmRmckoyVG9hV2l0dFdFLzRsU3RINmQ0ZkEr?=
 =?utf-8?B?Q2dncnlCeFlyKzFvelM5c2tmenFQVEFrM0JVZnExdk40a1lIdDRmNXdOY2xu?=
 =?utf-8?B?anJmYlJRMU9vcHlHbmJucHBTNzQ3eElXNFkrQ3N1TmlyeW8wa3J2Q0dTeE9S?=
 =?utf-8?Q?pfruASb0ybk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm5YbFQ3MG5icDhYTGZuRXpVTnVZdHAzQURYSHBRb1dRbnBhM2lWNm00R2U0?=
 =?utf-8?B?QWpuZXY4MDdnMGlqWlFFVzJ3S0ZqZW9NMVV1RmVYVkNiUHBVSmRwdlZLUXJO?=
 =?utf-8?B?WFJIcTh3WU9hU1pnTTRhUWNqbzFKSmdHdUw0bVgzQnBCQUVqTmtKMW02d2xk?=
 =?utf-8?B?UlBQdGpwSEdPQm1WZXRDYi9MSWRGWFZ1MUhVd29RYzRhVmhhekdScjdEelJV?=
 =?utf-8?B?V2RBdnQveHZDd1h5Slo0NWgyN29UbWl2M25BQWlYdVM3dGYzczJKZS9GZ2t4?=
 =?utf-8?B?RUwrOVdEWWliQkpZMWhVa3R0a1VzeEZJMzZnbnAxOXg3aGpkcjJvOXI2QS80?=
 =?utf-8?B?VDY5bTU4WEhIVXhVd0pHc2RJVHFnV2VGNTNNQnJkaGI3STZ1cUViNUliQ1hR?=
 =?utf-8?B?SndEYzRrUVh0bXVRcC9ZdUtPU3V0RWhYR0daaUJXUEFnK2hqdFJRUDc1OFZw?=
 =?utf-8?B?aER5YWtYenZlNEsvQStJMUpnbjdQT3N0ZDdZT2lDVjdYRSs1K0FHc2JDN0Vz?=
 =?utf-8?B?VzIwWXJzVXFNUHlXMVNEa3NJNlRhMkV4TWU3WjhZQVUrRWtnUllEUWViTUo5?=
 =?utf-8?B?TVpIeHo3OGJaZnBON2lxMnNhYWdVKyt6aDJsaERQYmdFbDNVaXNqOTJCZWlQ?=
 =?utf-8?B?UmZKM0dIanpEajcrQ0RmMis3WXAyeDc1T3hIVjJlTUFtQUdMY3pBYXk4eUdZ?=
 =?utf-8?B?UithZTNpWFQ5aW1MZDdrOHpMeVVCdlJ3QUVEaDltUXBWTVBSdTlmN3dDc3JU?=
 =?utf-8?B?ZCtKYzVhZ0NSTEVMQmUxYy9qWkt3dmhnZ0dVWnVtL2RvQzM3d1VIcVAvUW5Y?=
 =?utf-8?B?a3d0dldLTEg1VWVwQStXWDF2UnFCWUxDY0VQVWVZazBlR1V1Mitwb2tpTk5Z?=
 =?utf-8?B?cks0SGM0dTRiYk12b0ZiR20vZWVvVTFNTXd6Y0JkYzZ4Vk85Z3IyNk1QeWs4?=
 =?utf-8?B?dERvSXJEWmtHNnBQZVZPRHVoSUNKSTV4L1BnZVNkeG03NXZmUStQMzNtaDZC?=
 =?utf-8?B?aGw4T3FjVFZINE5oQU5HMVh1WVNXSlBDMjIzaXh3Sld3dnJLVVdPNTVqVm5n?=
 =?utf-8?B?dkRmSG5CSWlkMkd2dm1FenIrY0kzaStmdXdFQ01va2pVV2VYaDFSTSt4azlI?=
 =?utf-8?B?VlRqTks1VHNSTHVjVXE0ZHVVejVHTUd6RWZiQ2VWQnNndkZ1NEk4WWNDN1hD?=
 =?utf-8?B?VWNXTk1iQUlodDg1d3JyL29wdzZMNE9rR29uV3NLRC81SlBtb1ZnZkwwT0xQ?=
 =?utf-8?B?YlkwbUYyem8raUdhc1FmUmo4OE40ajBMdm1qM20zaVo0TkV1REtGUEplNEE2?=
 =?utf-8?B?eTlKb1MxTmFUc2lMSHRhdVRJYy9VajZHQVFMTkZwUEZiZHRqZjJYRU1pdWJY?=
 =?utf-8?B?WWVYZW15b0poT3AyOXNiZzBnM2duZFRJcmVFK0FXOHRVM1lLVisxVVBwcWda?=
 =?utf-8?B?ODNxb0FIZm9zRDdnTm5Id2NjeHBQYm1XZmNOUnd3QVZjWGhnb3JlRVQ0cHV2?=
 =?utf-8?B?NVlFMGRaZnVMKyt4UE0yKzhtZFFuL0JybVB4eHZVaE9MMGQ3eDM1L0g1L1U1?=
 =?utf-8?B?bmVyd2dwR2JERVRvcml2SUlob3B6TnB5MUFXUlQrcDAxcnZzN200S1d1L242?=
 =?utf-8?B?cU9yYnlWeXF6TUVsR3kzTU9WUCs4UjVWVXNJbDNDZWpBeFhjMVdubEVwaExv?=
 =?utf-8?B?bElvL3pXM1owYkpWTW02WFFEQTJhYTRxTU9lNHNnY3h5L0N6bG5TdGxPY05a?=
 =?utf-8?B?TVZYVWZlVjNwYVNyYis2L0ZtSW5wVUt0OTdzeEFqU3hRRTdKYUlockZOZlZG?=
 =?utf-8?B?aS83R0wrNFRFVFNSUXpuK0Y0WXZtR1R0dWdGMVAxUzY1am1zMkZIckVlNDl1?=
 =?utf-8?B?c3I1TnpmbEVLbVBma3ljL1psbVZ3VkNzamlvK0E5bi9NcUptdnVLT25iRUxl?=
 =?utf-8?B?Qk1NZm9EM3Fla3Y5KzRtZDBBb042WUU1enJuSVRoSnhMazdHMUhieFlXbGNF?=
 =?utf-8?B?b2c1Vkt4NEh1MXpLSzZIcUJSamswWlMyaWVhRjlGU0lJSmgxc2pmV1dzeDlQ?=
 =?utf-8?B?eEc5TUp2Vk5RUjE3c2YydEZ5U0ZWRkVtck1uUkZrdXZOSm4wbnBZYU5XeUZu?=
 =?utf-8?Q?zUwFa0tenmHSgLj60PxTQo4zc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5491f2bc-a6b8-45a8-3803-08dd9923c6ad
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 11:28:29.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2XXRo8vLOVdsxHhV2sshnxyOI2Om59hCq8bKBhfhurn+iG5yclHT5NztStiJitBiq4RRApBGvpsa0BKIxiT9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738


On 5/20/25 04:07, Jason Gunthorpe wrote:
> On Thu, May 08, 2025 at 10:29:43AM +0530, Abhijit Gangurde wrote:
>> Abhijit Gangurde (14):
>>    net: ionic: Create an auxiliary device for rdma driver
>>    net: ionic: Update LIF identity with additional RDMA capabilities
>>    net: ionic: Export the APIs from net driver to support device commands
>>    net: ionic: Provide RDMA reset support for the RDMA driver
>>    net: ionic: Provide interrupt allocation support for the RDMA driver
>>    net: ionic: Provide doorbell and CMB region information
>>    RDMA: Add IONIC to rdma_driver_id definition
>>    RDMA/ionic: Register auxiliary module for ionic ethernet adapter
>>    RDMA/ionic: Create device queues to support admin operations
>>    RDMA/ionic: Register device ops for control path
>>    RDMA/ionic: Register device ops for datapath
>>    RDMA/ionic: Register device ops for miscellaneous functionality
>>    RDMA/ionic: Implement device stats ops
>>    RDMA/ionic: Add Makefile/Kconfig to kernel build environment
> I went over this and I didn't think there was anything too unusual for
> a rdma driver. There are a number of things that need fixing up but
> overall it should be fine.
>
> Please be careful with types. I see alot of just using 'int' even
> though that is not the correct type. Try not to implicitly cast things
> that are not int to int, try not use to signed types to hold unsigned
> values.
>
> All the use of xarray looks ineffeicient to me. I noticed some things
> that show this probably hasn't been tested in debug kernels with
> lockdep. Please do that thoroughly before sending it again.
>
> Since it is so big I reviewed the entire thing applied and made notes
> inline in a editor. Usually I will go back and turn these into proper
> contextual comments, but there are alot and I think you will be able
> to understand the remarks. At least it will be faster this way than
> waiting for me to break it up. Perhaps if a discussion is needed reply
> to the right line in the right message.

Thanks for the constructive feedback. Many of your comments are misses 
from our end and will fix
those in v3. Some comments/queries inline.

>
> diff --git a/drivers/infiniband/hw/ionic/Kconfig b/drivers/infiniband/hw/ionic/Kconfig
> index 023a7fcdacb88e..60e8f42e4f20de 100644
> --- a/drivers/infiniband/hw/ionic/Kconfig
> +++ b/drivers/infiniband/hw/ionic/Kconfig
> @@ -4,6 +4,7 @@
>   config INFINIBAND_IONIC
>   	tristate "AMD Pensando DSC RDMA/RoCE Support"
>   	depends on NETDEVICES && ETHERNET && PCI && INET && 64BIT
> +	# select should not be used on kconfigs with a help text
>   	select NET_VENDOR_PENSANDO
>   	select IONIC
>   	help
> diff --git a/drivers/infiniband/hw/ionic/ionic_admin.c b/drivers/infiniband/hw/ionic/ionic_admin.c
> index 72daf03dc418eb..bdaefc0a98c4ec 100644
> --- a/drivers/infiniband/hw/ionic/ionic_admin.c
> +++ b/drivers/infiniband/hw/ionic/ionic_admin.c
> @@ -110,6 +110,7 @@ static bool ionic_admin_next_cqe(struct ionic_ibdev *dev, struct ionic_cq *cq,
>   		return false;
>   
>   	/* Prevent out-of-order reads of the CQE */
> +	// similar comment dma_rmb() ?
>   	rmb();
>   
>   	ibdev_dbg(&dev->ibdev, "poll admin cq %u prod %u\n",
> @@ -132,6 +133,8 @@ static void ionic_admin_poll_locked(struct ionic_aq *aq)
>   	u16 old_prod;
>   	u8 type;
>   
> +	// locked by what? Add a lockdep assertion
> +
>   	if (dev->admin_state >= IONIC_ADMIN_KILLED) {
>   		list_for_each_entry_safe(wr, wr_next, &aq->wr_prod, aq_ent) {
>   			INIT_LIST_HEAD(&wr->aq_ent);
> @@ -374,6 +377,7 @@ void ionic_admin_post(struct ionic_ibdev *dev, struct ionic_admin_wr *wr)
>   {
>   	int aq_idx;
>   
> +	// Probably deserves a comment why it is OK to do this. The ID can change before anything uses it.
>   	aq_idx = raw_smp_processor_id() % dev->lif_cfg.aq_count;
>   	ionic_admin_post_aq(dev->aq_vec[aq_idx], wr);
>   }
> @@ -406,6 +410,7 @@ static int ionic_admin_busy_wait(struct ionic_admin_wr *wr)
>   
>   		mdelay(IONIC_ADMIN_BUSY_RETRY_MS);
>   
> +		// cnod_resched?
>   		spin_lock_irqsave(&aq->lock, irqflags);
>   		ionic_admin_poll_locked(aq);
>   		spin_unlock_irqrestore(&aq->lock, irqflags);
> @@ -589,6 +594,7 @@ static struct ionic_aq *__ionic_create_rdma_adminq(struct ionic_ibdev *dev,
>   	struct ionic_aq *aq;
>   	int rc;
>   
> +	// Not kzalloc? Why not?
>   	aq = kmalloc(sizeof(*aq), GFP_KERNEL);
>   	if (!aq) {
>   		rc = -ENOMEM;
> @@ -669,6 +675,9 @@ static void ionic_kill_ibdev(struct ionic_ibdev *dev, bool fatal_path)
>   
>   	local_irq_save(irqflags);
>   
> +	/* Second time seeing this pattern, given it will need some commenting
> +	and fixing to work with lockdep, suggest you make
> +	lock_all_aq/unlock_all_aq functions */
>   	/* Mark the admin queue, flushing at most once */
>   	for (i = 0; i < dev->lif_cfg.aq_count; i++)
>   		spin_lock(&dev->aq_vec[i]->lock);
> @@ -703,6 +712,7 @@ static void ionic_kill_ibdev(struct ionic_ibdev *dev, bool fatal_path)
>   		read_unlock(&dev->cq_tbl_rw);
>   	}
>   
> +	// Weird to see the irq restore outlive any of the spinlocks, why? Add a comment.
>   	local_irq_restore(irqflags);
>   
>   	/* Post a fatal event if requested */
> @@ -720,6 +730,9 @@ void ionic_kill_rdma_admin(struct ionic_ibdev *dev, bool fatal_path)
>   		return;
>   
>   	local_irq_save(irqflags);
> +	/* I don't expect this works with lockdep turned on, does it? Please
> +	make sure your driver passes tests with all sanitizers and lockdep. Be
> +	sure to test unload too  */
>   	for (i = 0; i < dev->lif_cfg.aq_count; i++)
>   		spin_lock(&dev->aq_vec[i]->lock);
>   
> @@ -781,6 +794,7 @@ static bool ionic_next_eqe(struct ionic_eq *eq, struct ionic_v1_eqe *eqe)
>   	if (eq->q.cons != color)
>   		return false;
>   
> +	// Since HW is usually the thing writing to a EQE this should be dma_rmb()
>   	/* Prevent out-of-order reads of the EQE */
>   	rmb();
>   
> @@ -798,6 +812,9 @@ static void ionic_cq_event(struct ionic_ibdev *dev, u32 cqid, u8 code)
>   	struct ib_event ibev;
>   	struct ionic_cq *cq;
>   
> +	/* Weird to have a rcu protected xarray holding refcounted structs use
> +	an external rwlock. Usually you'd use rcu. Didn't see a reason why this
> +	needs a rwsem. */
>   	read_lock_irqsave(&dev->cq_tbl_rw, irqflags);
>   	cq = xa_load(&dev->cq_tbl, cqid);
>   	if (cq)
> @@ -843,6 +860,7 @@ static void ionic_qp_event(struct ionic_ibdev *dev, u32 qpid, u8 code)
>   	struct ib_event ibev;
>   	struct ionic_qp *qp;
>   
> +	// Same remark about RCU
>   	read_lock_irqsave(&dev->qp_tbl_rw, irqflags);
>   	qp = xa_load(&dev->qp_tbl, qpid);
>   	if (qp)
> @@ -1055,6 +1073,9 @@ static struct ionic_eq *ionic_create_eq(struct ionic_ibdev *dev, int eqid)
>   
>   err_cmd:
>   	eq->enable = false;
> +	/* This is backwards, the irq has to be stopped to make it stop queuing
> +	work otherwise the work will still be running after flush. Furth since
> +	the work itself requeus I'm not sure this works at all. */
>   	flush_work(&eq->work);
>   	free_irq(eq->irq, eq);
>   err_irq:
> @@ -1072,6 +1093,7 @@ static void ionic_destroy_eq(struct ionic_eq *eq)
>   	struct ionic_ibdev *dev = eq->dev;
>   
>   	eq->enable = false;
> +	// same remark about order, except here enable doesn't really do much since it isn't locked.
>   	flush_work(&eq->work);
>   	free_irq(eq->irq, eq);
>   
> @@ -1210,6 +1232,9 @@ void ionic_destroy_rdma_admin(struct ionic_ibdev *dev)
>   	struct ionic_aq *aq;
>   	struct ionic_eq *eq;
>   
> +	/* Something needs to prevent work from being queued before cancelling
> +	it is meaningful, couldn't tell if that was happening. Add a comment and
> +	probably a WARN_ON on the thing that prevents requeuing */
>   	cancel_delayed_work_sync(&dev->admin_dwork);
>   	cancel_work_sync(&dev->reset_work);
>   
> @@ -1218,6 +1243,7 @@ void ionic_destroy_rdma_admin(struct ionic_ibdev *dev)
>   			aq = dev->aq_vec[--dev->lif_cfg.aq_count];
>   			vcq = aq->vcq;
>   
> +			// Similar comment here.
>   			cancel_work_sync(&aq->work);
>   
>   			__ionic_destroy_rdma_adminq(dev, aq);
> @@ -1231,6 +1257,7 @@ void ionic_destroy_rdma_admin(struct ionic_ibdev *dev)
>   	}
>   
>   	if (dev->eq_vec) {
> +		// Locking? Add a lockdep assertion if caller is holding the lock
>   		while (dev->lif_cfg.eq_count > 0) {
>   			eq = dev->eq_vec[--dev->lif_cfg.eq_count];
>   			ionic_destroy_eq(eq);
I don't think there is a need for the lock here because the device is 
unregistered and the queues are all stopped.
> diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
> index cd2929e8033545..2ca41c64d963ed 100644
> --- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
> +++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
> @@ -151,6 +151,7 @@ int ionic_create_cq_common(struct ionic_vcq *vcq,
>   	init_completion(&cq->cq_rel_comp);
>   	kref_init(&cq->cq_kref);
>   
> +	// More xarray weirdness
>   	write_lock_irqsave(&dev->cq_tbl_rw, irqflags);
>   	rc = xa_err(xa_store(&dev->cq_tbl, cq->cqid, cq, GFP_KERNEL));
>   	write_unlock_irqrestore(&dev->cq_tbl_rw, irqflags);
> @@ -432,6 +433,7 @@ static int ionic_alloc_ucontext(struct ib_ucontext *ibctx,
>   
>   err_resp:
>   	ionic_put_dbid(dev, ctx->dbid);
> +	// just return directly above
>   err_dbid:
>   err_ctx:
>   	return rc;
> @@ -465,6 +467,8 @@ static int ionic_mmap(struct ib_ucontext *ibctx, struct vm_area_struct *vma)
>   		if (info->offset == offset)
>   			goto found;
>   
> +	// No goto like this. Not kernel style
> +
>   	mutex_unlock(&ctx->mmap_mut);
>   
>   	/* not found */
> @@ -473,6 +477,7 @@ static int ionic_mmap(struct ib_ucontext *ibctx, struct vm_area_struct *vma)
>   	goto out;
>   
>   found:
> +	// Don't do this info thing. Use the rdma_user_mmap_* API for all mmap stuff
>   	list_del_init(&info->ctx_ent);
>   	mutex_unlock(&ctx->mmap_mut);
>   
> @@ -491,6 +496,7 @@ static int ionic_mmap(struct ib_ucontext *ibctx, struct vm_area_struct *vma)
>   
>   	ibdev_dbg(&dev->ibdev, "remap st %#lx pf %#lx sz %#lx\n",
>   		  vma->vm_start, info->pfn, size);
> +	// Don't pass NULL, use the API properly
>   	rc = rdma_user_mmap_io(&ctx->ibctx, vma, info->pfn, size,
>   			       vma->vm_page_prot, NULL);
>   	if (rc)
> @@ -887,6 +893,8 @@ static struct ib_mr *ionic_get_dma_mr(struct ib_pd *ibpd, int access)
>   	if (!mr)
>   		return ERR_PTR(-ENOMEM);
>   
> +	// This seems strange, shouldn't this do something? If you don't support an all address MR then don't define this op.
> +
>   	return &mr->ibmr;
>   }
 From hardware lkey zero is reserved as a local dma lkey for all address 
MR.  I would make it more explicit as mr.ibmr.lkey = IONIC_DMA_LKEY 
(same for RKEY) with that defined to be zero.
>   
> @@ -927,6 +935,7 @@ static struct ib_mr *ionic_reg_user_mr(struct ib_pd *ibpd, u64 start,
>   				       dev->lif_cfg.page_size_supported,
>   				       addr);
>   	if (!pg_sz) {
> +		/* don't print on user errors */
>   		ibdev_err(&dev->ibdev, "%s umem page size unsupported!",
>   			  __func__);
>   		rc = -EINVAL;
> @@ -1002,6 +1011,7 @@ static struct ib_mr *ionic_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 offset,
>   				       dev->lif_cfg.page_size_supported,
>   				       addr);
>   	if (!pg_sz) {
> +		// don't print
>   		ibdev_err(&dev->ibdev, "%s umem page size unsupported!",
>   			  __func__);
>   		rc = -EINVAL;
> @@ -1080,6 +1090,7 @@ static struct ib_mr *ionic_rereg_user_mr(struct ib_mr *ibmr, int flags,
>   	if (flags & IB_MR_REREG_TRANS) {
>   		ionic_pgtbl_unbuf(dev, &mr->buf);
>   
> +		// What about dmabuf? Check the mlx5 implementation
>   		if (mr->umem)
>   			ib_umem_release(mr->umem);
>   
> @@ -1096,6 +1107,7 @@ static struct ib_mr *ionic_rereg_user_mr(struct ib_mr *ibmr, int flags,
>   					       dev->lif_cfg.page_size_supported,
>   					       addr);
>   		if (!pg_sz) {
> +			// no prints
>   			ibdev_err(&dev->ibdev, "%s umem page size unsupported!",
>   				  __func__);
>   			rc = -EINVAL;
> @@ -1454,11 +1466,15 @@ static int ionic_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>   
>   static bool pd_local_privileged(struct ib_pd *pd)
>   {
> +	/* That isn't how it works, only the lkey get_dma_mr() returns is
> +	special and must be used on any WRs that require it. WRs refering to any
> +	other lkeys must behave normally. */
>   	return !pd->uobject;
>   }
>   
>   static bool pd_remote_privileged(struct ib_pd *pd)
>   {
> +	/* Same comment, except about rkeys now. */
>   	return pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
>   }
This is how we allow the qp to use the dma lkey.  If the qp is a kernel 
space qp (its pd has no uobject) then we allow use of the dma lkey by 
that qp.  We do not allow use of dma lkey by user qps.  If the pd flags 
has the unsafe rkey flag, then we also allow the qp use it for remote 
access.
>   
> @@ -2440,6 +2456,7 @@ static int ionic_create_qp(struct ib_qp *ibqp,
>   			qp->sq_cmb_mmap.pfn = PHYS_PFN(qp->sq_cmb_addr);
>   			if ((qp->sq_cmb & (IONIC_CMB_WC | IONIC_CMB_UC)) ==
>   				(IONIC_CMB_WC | IONIC_CMB_UC)) {
> +					// No warnings on user errors?
>   				ibdev_warn(&dev->ibdev,
>   					   "Both sq_cmb flags IONIC_CMB_WC and IONIC_CMB_UC are set, using default driver mapping\n");
>   				qp->sq_cmb &= ~(IONIC_CMB_WC | IONIC_CMB_UC);
> @@ -2457,6 +2474,7 @@ static int ionic_create_qp(struct ib_qp *ibqp,
>   
>   			mutex_lock(&ctx->mmap_mut);
>   			qp->sq_cmb_mmap.offset = ctx->mmap_off;
> +			// NO, use the rdma_user_mmap api for this stuff.
>   			ctx->mmap_off += qp->sq.size;
>   			list_add(&qp->sq_cmb_mmap.ctx_ent, &ctx->mmap_list);
>   			mutex_unlock(&ctx->mmap_mut);
> @@ -2514,13 +2532,23 @@ static int ionic_create_qp(struct ib_qp *ibqp,
>   	kref_init(&qp->qp_kref);
>   
>   	write_lock_irqsave(&dev->qp_tbl_rw, irqflags);
> +	// GFP_KERNEL is wrong, this is an atomic context becuse of the above. Should't a debug kernel catch this?
>   	rc = xa_err(xa_store(&dev->qp_tbl, qp->qpid, qp, GFP_KERNEL));
> +	// Poor use of xa_err, more like: (same for other xarrays)
> +	ent = xa_store(&dev->qp_tbl, qp->qpid, qp, GFP_KERNEL);
> +
>   	write_unlock_irqrestore(&dev->qp_tbl_rw, irqflags);
> -	if (rc)
> +	if (ent) {
> +		if (WARN_ON(!xa_is_err(ent)))
> +			rc = -EINVAL;
> +		else
> +			rc = xa_err(ent);
>   		goto err_xa;
> +	}
>   
>   	if (qp->has_sq) {
>   		cq = to_ionic_vcq_cq(attr->send_cq, qp->udma_idx);
> +		// WTF is is? Needs a comment, but probably this is wrong.
>   		spin_lock_irqsave(&cq->lock, irqflags);
>   		spin_unlock_irqrestore(&cq->lock, irqflags);
>   
> @@ -2826,6 +2854,7 @@ static int ionic_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>   	if (rc)
>   		return rc;
>   
> +	// You can also check that xa_erase returns qp and warn otherwise as something is corrupted.
>   	write_lock_irqsave(&dev->qp_tbl_rw, irqflags);
>   	xa_erase(&dev->qp_tbl, qp->qpid);
>   	write_unlock_irqrestore(&dev->qp_tbl_rw, irqflags);
> @@ -2903,8 +2932,14 @@ static const struct ib_device_ops ionic_controlpath_ops = {
>   
>   void ionic_controlpath_setops(struct ionic_ibdev *dev)
>   {
> +	/* This is not how set_device_ops is ment to be used. It should only be
> +	used for things that are optional based on some runtime detection.
> +	Always present ops should be hardwired into the main op. */
>   	ib_set_device_ops(&dev->ibdev, &ionic_controlpath_ops);
>   
> +	/* This is old, drivers should not set these. Only a few special ones
> +	need the driver to do anything. The core code computes this based on
> +	what ops pointers are not null. Same for all places doing this */
>   	dev->ibdev.uverbs_cmd_mask |=
>   		BIT_ULL(IB_USER_VERBS_CMD_ALLOC_PD)		|
>   		BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_PD)		|
> diff --git a/drivers/infiniband/hw/ionic/ionic_datapath.c b/drivers/infiniband/hw/ionic/ionic_datapath.c
> index 1262ba30172d77..ff6cff06c8575b 100644
> --- a/drivers/infiniband/hw/ionic/ionic_datapath.c
> +++ b/drivers/infiniband/hw/ionic/ionic_datapath.c
> @@ -21,6 +21,7 @@ static bool ionic_next_cqe(struct ionic_ibdev *dev, struct ionic_cq *cq,
>   		return false;
>   
>   	/* Prevent out-of-order reads of the CQE */
> +	// dma_rmb
>   	rmb();
>   
>   	*cqe = qcqe;
> @@ -639,6 +640,7 @@ static int ionic_poll_cq(struct ib_cq *ibcq, int nwc, struct ib_wc *wc)
>   	int cq_i, cq_x, cq_ix;
>   
>   	/* poll_idx is not protected by a lock, but a race is benign */
> +	// Use READ_ONCE and WRITE_ONCE then
>   	cq_x = vcq->poll_idx;
>   
>   	vcq->poll_idx ^= dev->lif_cfg.udma_count - 1;
> @@ -1411,6 +1413,7 @@ static const struct ib_device_ops ionic_datapath_ops = {
>   
>   void ionic_datapath_setops(struct ionic_ibdev *dev)
>   {
> +	// Same remark about ops and uverbs_cmd_mask
>   	ib_set_device_ops(&dev->ibdev, &ionic_datapath_ops);
>   
>   	dev->ibdev.uverbs_cmd_mask |=
> diff --git a/drivers/infiniband/hw/ionic/ionic_fw.h b/drivers/infiniband/hw/ionic/ionic_fw.h
> index 2d9a2e9a0b60cf..0b58cc66d04573 100644
> --- a/drivers/infiniband/hw/ionic/ionic_fw.h
> +++ b/drivers/infiniband/hw/ionic/ionic_fw.h
> @@ -974,6 +974,7 @@ enum ionic_tfp_csum_profiles {
>   
>   static inline bool ionic_v1_eqe_color(struct ionic_v1_eqe *eqe)
>   {
> +	// Don't need !! when casting to bool
>   	return !!(eqe->evt & cpu_to_be32(IONIC_V1_EQE_COLOR));
>   }
>   
> diff --git a/drivers/infiniband/hw/ionic/ionic_hw_stats.c b/drivers/infiniband/hw/ionic/ionic_hw_stats.c
> index 29f2571463ac3a..facc015b970295 100644
> --- a/drivers/infiniband/hw/ionic/ionic_hw_stats.c
> +++ b/drivers/infiniband/hw/ionic/ionic_hw_stats.c
> @@ -464,6 +464,7 @@ void ionic_stats_init(struct ionic_ibdev *dev)
>   
>   		xa_init_flags(&dev->counter_stats->xa_counters, XA_FLAGS_ALLOC);
>   
> +		// This is the right usage since it is conditional
>   		ib_set_device_ops(&dev->ibdev, &ionic_counter_stats_ops);
>   	}
>   }
> diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
> index e292278fcbba4a..a8a8fc015c0e1e 100644
> --- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
> +++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
> @@ -26,6 +26,7 @@ static const struct auxiliary_device_id ionic_aux_id_table[] = {
>   
>   MODULE_DEVICE_TABLE(auxiliary, ionic_aux_id_table);
>   
> +/* Why have this wrapper, just call the dispatch event from the only call site */
>   void ionic_port_event(struct ionic_ibdev *dev, enum ib_event_type event)
>   {
>   	struct ib_event ev;
> @@ -332,6 +333,7 @@ static void ionic_destroy_ibdev(struct ionic_ibdev *dev)
>   	ionic_stats_cleanup(dev);
>   	ionic_destroy_rdma_admin(dev);
>   	ionic_destroy_resids(dev);
> +	// Should WARN_ON(xa_is_empty()) to catch any bugs.
>   	xa_destroy(&dev->qp_tbl);
>   	xa_destroy(&dev->cq_tbl);
>   	ib_dealloc_device(&dev->ibdev);
> @@ -387,7 +389,7 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
>   
>   	addrconf_ifid_eui48((u8 *)&ibdev->node_guid,
>   			    ionic_lif_netdev(ionic_adev->lif));
> -
> +mmap_off
Assuming this was unintentional edit.
>   	rc = ib_device_set_netdev(ibdev, ionic_lif_netdev(ionic_adev->lif), 1);
>   	if (rc)
>   		goto err_admin;
> diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
> index 803127c625cc2f..4d966c27c2791b 100644
> --- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
> +++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
> @@ -137,6 +137,7 @@ struct ionic_eq {
>   
>   	struct ionic_queue	q;
>   
> +	// bool due to how xchg is used
>   	int			armed;
>   	bool			enable;
>   
> @@ -226,7 +227,9 @@ struct ionic_cq {
>   	struct list_head	cq_list_ent;
>   
>   	struct ionic_queue	q;
> +	// Linus has been known to complain about multiple bools in the same struct
>   	bool			color;
> +	// Why? This is not ABI?

It is not meant as reserved. We will pick better name for it.

Thanks,
Abhijit

>   	int			reserve;
>   	u16			arm_any_prod;
>   	u16			arm_sol_prod;
> diff --git a/drivers/infiniband/hw/ionic/ionic_res.c b/drivers/infiniband/hw/ionic/ionic_res.c
> index a3b4f10aa4c84b..2d1559b42de537 100644
> --- a/drivers/infiniband/hw/ionic/ionic_res.c
> +++ b/drivers/infiniband/hw/ionic/ionic_res.c
> @@ -7,13 +7,17 @@
>   
>   #include "ionic_res.h"
>   
> +// None of these types should be int. Use unsigned long/int or size_t as appropriate. For everywhere.
>   int ionic_resid_init(struct ionic_resid_bits *resid, int size)
>   {
> +	// sizeof(unsigned long)
> +	// size_t not int
>   	int size_bytes = sizeof(long) * BITS_TO_LONGS(size);
>   
>   	resid->next_id = 0;
>   	resid->inuse_size = size;
>   
> +	// Use kcalloc
>   	resid->inuse = kzalloc(size_bytes, GFP_KERNEL);
>   	if (!resid->inuse)
>   		return -ENOMEM;
> @@ -21,11 +25,13 @@ int ionic_resid_init(struct ionic_resid_bits *resid, int size)
>   	return 0;
>   }
>   
> +// All ints are unsigned
>   int ionic_resid_get_shared(struct ionic_resid_bits *resid, int wrap_id,
>   			   int next_id, int size)
>   {
>   	int id;
>   
> +	/* Are you sure you don't want to use an IDR? */
>   	id = find_next_zero_bit(resid->inuse, size, next_id);
>   	if (id != size) {
>   		set_bit(id, resid->inuse);
> diff --git a/drivers/infiniband/hw/ionic/ionic_res.h b/drivers/infiniband/hw/ionic/ionic_res.h
> index e833ced1466e89..1aa9118db25fbf 100644
> --- a/drivers/infiniband/hw/ionic/ionic_res.h
> +++ b/drivers/infiniband/hw/ionic/ionic_res.h
> @@ -4,6 +4,8 @@
>   #ifndef _IONIC_RES_H_
>   #define _IONIC_RES_H_
>   
> +/* Missing include files for header self compilation */
> +
>   /**
>    * struct ionic_resid_bits - Number allocator based on find_first_zero_bit
>    *
> @@ -24,7 +26,9 @@
>    * remains bounded by O(N^2) in the worst case.
>    */
>   struct ionic_resid_bits {
> +	// unsigned int
>   	int next_id;
> +	// size_t
>   	int inuse_size;
>   	unsigned long *inuse;
>   };
>

