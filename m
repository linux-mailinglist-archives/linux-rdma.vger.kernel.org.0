Return-Path: <linux-rdma+bounces-12560-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 384C1B1766C
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Jul 2025 21:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D6A27B28EA
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Jul 2025 19:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B121023E34D;
	Thu, 31 Jul 2025 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="USaYSvgb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2223ABB1;
	Thu, 31 Jul 2025 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988758; cv=fail; b=rCIQi+rk9wI8DmPXfUMRZgisry2Jp+dCakveoFqPWlOb0FmwLEXCa1N1mTs8HZO7ykQxp81H/CMouMU8udiktix+gye5//nCeQpmF3d0Xc7DQdT2ZQZNL0SEu4NFRJYV+Tz1J3vIxWAmeyQggx4GoNrJsiAO+yiMqm9KCWNQ2Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988758; c=relaxed/simple;
	bh=ypEGs71s9vLeje9Wa93pFeOH5QFQewBSEpP/59aZD8Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pfumgbO7L504EaSBVURLJQgyfLsfz4JVTJ5LTeD6PoxkJRnklBl1Nwdfoc5TCCN1VP3e3jHNvioZfT8WnVtBV+zveme4hKFCdZG7eNIKIEbbY4mtcdtsHSvJGJYD0bprxf7EcWJlTrH70IhPDtX+1pLLfSJDze+t1tvD9rJAzDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=USaYSvgb; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyM06z2b198yJAs7lIH5NJkP3oOjphGlSUPWud7nlyBwvJ6TyxtZAEmKHPOpz5iT7Nl9GTE+xQtnZplTxTDN2zYcmEUiyzzh/dHXrJIFw3LbPm7+cFFEy3oRAXDZqwkLmASxrClZdKzVvNiJpWHPOGLGADrqzGamvizd6YBnmxaiu3LN6BQAgF9QbizHjYfkNsuvmNZ/HHgqlWI/l3h6gDPNviYUj/03c5YaFovURQLkyWkD+pbjUFNarmL0D4Gulw3cArfmPU+nBoJFVBtxwb4Ik7dLYNTmk1vi7mkrm/MUv2Bb+b9DlIZU5kgTEhGKvpOXFiVh/EL7CmO0lEIR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+snbNEkA2OywW4icEFu5damKgDwklI71bZyljcbrS4=;
 b=UwR2EN5JLJKit80QQZ1hmeXVUWhuqiT+UxXMeV6Lwmsh5SB1MvNAj/eW6lMiBizD7JWucbMD03/ZtZ0weXVzCuV8kQK4OcJWb7bPjtxZtxxNqvRpizX+SJXl1X6NMwjBOxMR5ER0h1gGQBzsbXMp43kDX6GxCAGZ1xYtvAKo65NNGME2Z6I5ObefFNBGROr+b4h3QIOREw5UUgm0Gk9fiTHtdJ8bopITrs74do8tMwvC7A2MOr870uxp0uNpt8ZGE2OaFJ+wpkgwHyzErY3kSHNpmUqeLBre69/q8LqtPolXoOGjUb770MKrrwbUMJn3poLTXQv1xQcmiwmGBqrNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+snbNEkA2OywW4icEFu5damKgDwklI71bZyljcbrS4=;
 b=USaYSvgb4/dcIu48Bou9O7hwkuHAWp9k62A2Ey5hSyLGrYePXt2La0KDCYfoG2Hbi7zKg2lPum8YxZKfFbmD8ANpUcJ7iqL3+Idmu+93OB0/wHS5LNy08hcq/Cx8W9ng/Tef74F2uekAWcjt38z+9dY+ts0ue5sm7vIqvc7px4NEO5SDvNpgkF0ICXG6OWgfZLBaTAGcFEVn8IDFwENzQh8JXWfErH3UJIWg2aLNsPIH4PNnSNpGUPn7JSr4uty+68NcYW3IBGWaZcQRUGmmEaZLx1D98tpxpv5EA8IJK/EMFU2+HXTkKf+7qDZnzFE3NJxpRCoWhs2buB32Hlg8RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 19:05:52 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 19:05:52 +0000
Message-ID: <6910b7f3-8e69-4639-bf09-c5cddf1d31ee@nvidia.com>
Date: Thu, 31 Jul 2025 22:05:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] Support exposing raw cycle counters in PTP
 and mlx5
To: Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski
 <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
 <20250718162945.0c170473@kernel.org>
 <86471b96-fb30-450f-9934-ec76851791ea@intel.com>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <86471b96-fb30-450f-9934-ec76851791ea@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: a3909a2a-d237-4a95-3ffd-08ddd06544e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1pQaVZSaVdvT3dNYkkwR1BQcndtZThoYlpSMVVPcUg4bzJhZ0swU0Y3OHQw?=
 =?utf-8?B?Ujdpbjc0TTBpR1E5bTR5dFV4OURoK3FnMEtFSVNPTkpJaWsrTE1FS21TbS9W?=
 =?utf-8?B?VlM4c21CL2JVdkYzdHY0UjFoTDgwKyswUy9FOEUzSS9EKzNPZ2pPLzdVd0gv?=
 =?utf-8?B?cUpVVDhiT01uSVdiTUFqN1QyQnRXai9VT2xPWGJjeHlRVWNaMkZFM3hOcTZN?=
 =?utf-8?B?dWJQVUpRYmJYV3EwdGw4aEVienB2Q2FSTUZrK1NRMUdsUDJLVzFaaWdDeVlZ?=
 =?utf-8?B?VUtTZUVQSUZUTFMxa2ZZakN6N1FNdUdmVytBcnR6a0tlQlZ6ampiNjlNVHQ1?=
 =?utf-8?B?R0Q1NzJaTmdNQVU5ZmVjS3FpMm5xVW45MGk4a1d3a0VtSVVGQzlza0hZT3Fj?=
 =?utf-8?B?M1BER1NNMGRaaTA4WVkvV0crcTdTZ3AybTdmVjdRYU5FWlV4eGh6cUZ4QXRi?=
 =?utf-8?B?UVJ6Z1paRDhpaDdmNjJUa0RURE5MWHg3RkZvM1FpM3RvZVoxY0tNSTRXdWVM?=
 =?utf-8?B?Ui8yUWZwSTN4YzRMViswdklUSkNicTllaHJibzFNcVY3YTRFSVZoUFhxdFRF?=
 =?utf-8?B?TEE5YUJmbjVlZHVWcnRKVVlwVmpVdzJIT1hUdzZ0VUZqMTk1Q1FFTmVMeGVw?=
 =?utf-8?B?cG0zRGpmaXhRd09Xa2FmNVNsM2lIZThvd0tCK2o4OTZlWG15R25SWEZPV1hh?=
 =?utf-8?B?RjhaVFRWS3puMU5TSFF6MkZUS1pkZzBqWmFkck1wRGFhNCsrcStwRE14ZkxZ?=
 =?utf-8?B?cm5VWHZSSloyT0ZBMVM1L0J1TGNNbUIwSXREZXpHR3c0SXcvaklpU0hibE9I?=
 =?utf-8?B?YkJCcDZQcXlFOExZOVR0TVpRUXVsemJPcFlZbUxmYVZKcHQzR3VGcXU5L3ky?=
 =?utf-8?B?eFY5WTlqMEZ5WjJ6OXBWWUFPU0E4NlFra1VGUVI0Z1VzNjlFbWIzM3FGTHFC?=
 =?utf-8?B?OEFlU1ZLU0JlTCtrSjFjS2NtdWFTQ2V5b2pTV2loZndpM05qeTdUeE96bmZ5?=
 =?utf-8?B?cmh6d2xMZ3ZjQURRZlFLeVhTQkowbUdDK1BZemFTZXVibENtVmE0ZTdaenRL?=
 =?utf-8?B?elZVSnI2Q0VhcnV2dmNyL3ZRdlRJaXQzVnViNFA5QUllVXBMQWRkY2lhZ3VS?=
 =?utf-8?B?S25EdmVHYkdqTnlEM1YwQWxJSkFINFJIcDM4Y0dpMjJEcStmOHZlcDd6dTdE?=
 =?utf-8?B?ZlRkWElPUjdoZzRja29JcDJnaFZuOW12SFR1c0dGT2grdVZRemdrNDVyN0xa?=
 =?utf-8?B?d0MxN2hrMUZveWVQMk1waHIra1FrQWJSQmRHS2xLUEwwaUx4anlUbDd0dHhn?=
 =?utf-8?B?dFQxNDB3a1FUYjI3SklYZ1Z5WEk2b3h6QlY0WFBjcGRGWnNybnRQa0FSVXpr?=
 =?utf-8?B?UEJraVI2cnRKd09FZU1QOHZaUnVzS0FrNlJKWndYdDh5dUdsdmZQM3JiaUxn?=
 =?utf-8?B?MElhOEJadzNETTZDNEcxK2w0djBUVnFLckgrZEdSUExMeVJqREU4ZlNOcXFD?=
 =?utf-8?B?bCtTTDNuUWgyckpDVExxR2FaMHpYSnRBL2x1dkNsOEZCTWFLWHJObURtWlB0?=
 =?utf-8?B?NVNsZ3Nta0k3eml0QjlLQXhNa05vUmlMcG9FbjlNR0daVlBhME5Jbk4zVFpQ?=
 =?utf-8?B?dEdxYi9kQkphRTJCVlRqUEpuQUNEZGViMGdZMXVXM2hxOE1nS1ZLa0lxc0JQ?=
 =?utf-8?B?cERUbjZBUzVzelo1SDlhdkxNeXNrQjlTNWdWUzVMRklFQjJpQ1JNYWduaEI5?=
 =?utf-8?B?NDQzalZORUc4bFBZZWl6S0pRVTN4Tm9IeDMrRythUWJvQVN6REh0anZVVWg0?=
 =?utf-8?B?OHRYb21NcHpKVldTdE1JckdjbnROOUduUm1kRndNNXQ4ektTbTRQMjFhTlZB?=
 =?utf-8?B?VzFYLzBJVGFQWTVTWWF5R3FUM0VDVmJpRkpNdU13VVdyTy9tRVdpVTR2WXd6?=
 =?utf-8?Q?kTaAC/iGX9s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2hUL1k2Z2tqWHBEL3dCcm5FU2lMTWgwMU1hTk0vZ1UzTWJsUjFhL2R1eWUx?=
 =?utf-8?B?Y2J6TmVPbjVRUUd5Wm9QYWtHTG1OMlB4anBZd3hZR09kS0Q3dGhyQW0xY1hP?=
 =?utf-8?B?cC9uaFlOeFhPRVhSTlp4bHk0ZHBuajd2T2VhUEJ3cHpFcHRLOExiRXJHcnZX?=
 =?utf-8?B?S2dKMElaWVcxUkY3bndIaFltbUFLUTUvK1dNYmEwWncxZGpHMnJVaW1PNlky?=
 =?utf-8?B?cTNCQUxoSmp3TU42dWlwZXRGaUROQ0RUcElwemtKSDkrc3pwZlRjUEZTQi9F?=
 =?utf-8?B?WDh3bFRBcWg4SkhEN09KVHZHL0NSOU5GYWdUNmNqREs2Y1h4aTNBRkdqYXJN?=
 =?utf-8?B?bzBSNzdYVVVBZWFacDlscWc4MDh0c1FLSVdrajlEanpaR3ZZUUdFN0hTRVJm?=
 =?utf-8?B?VmY0NHF5SEJPeHlPSmNEdlAydWhRL2NRNDlHWFdOSzg5cjhBc2JPcWwzQXgv?=
 =?utf-8?B?RWZrMUV2eUx0ZUxwVy9WaWlLMDJWSDdqM09HNUVQTHJ0UFdwRVJVNnZNK012?=
 =?utf-8?B?emJTWWRwcnRFZ1hNQnZoQWFDY0xrQjdlYytTbzRadGNDUjhHYzUwNWZiejNl?=
 =?utf-8?B?UlgxTnVVRHZGcThRbUNtZTBHc0xOYWdFR3R4NmpqSmxBU0ljMHVRdlVDcSts?=
 =?utf-8?B?VDlaWUx6Z3JKSUlsTU8rK2ZVQXh4OUFPRFVYUkYxeERZZ1h0MEMrTzZzYVJz?=
 =?utf-8?B?aTg2YzdCYmc1RXdoNFptd3pmS3VQZmZob3cvMVhGL1dHVy9ldysrYXJqL0cx?=
 =?utf-8?B?QkZNMEwyS2s0SDRtOGwybzJhdlZnK3JOSDNXWkZ5WnVHbWxJVmdmalNqYUE2?=
 =?utf-8?B?WmVwTlYwWEFQTTRTY3c4UjBNTUc3VUFrRyszVjU5eS84dXpBeUMrUXNaRTVN?=
 =?utf-8?B?KzZpV3BZZ3MrdHQyYm9uVHNuZjdwdnBCZ3NTR2dRUVBXRDBDNE52akE5S256?=
 =?utf-8?B?Zzc2TEVUWVExbEVHWVI1Q2xjaTBSZHpNYkw0V0tFUFdYMEhRdUx1NzlyeXhD?=
 =?utf-8?B?U29DOVNqV0RLRUxSUjdrNG9BQWlCcVJyKzJnaUoxdllUUU4za0dOYUpXMUpL?=
 =?utf-8?B?d0JuNEt0RUc4SXg4VzcwZW95WUZpT3ZHZCtUbVBMYmttbVlNTjhOOTNnODJu?=
 =?utf-8?B?dE9iZGszQXVZUXhZRjBPcnl2ejJPanY0RDlHazRkVTJTNkFqRG5hd29nSENQ?=
 =?utf-8?B?TmNuZEZJUkY1T1VBNllobVR6aHI0anRXU2lBTXltUEw3b295WFJFajJYUy9E?=
 =?utf-8?B?WGV6b2pCdVdMS2Q5blhxOVptSlZIaGVMaUx2QnhWMUFLMmlmK0FZbml3NDNk?=
 =?utf-8?B?ZGFKZmN5dlRZcmdBUE9Ram1DSUVmMEZmT1JhNTFmNHF1d2pTQ2o1WlJjTXFi?=
 =?utf-8?B?UUpqenJHNXovaXE3SkpMQUNlZFpPSW9BRWpPcmx6bGRseXhVMTArSFR0ZG9T?=
 =?utf-8?B?Ri9LZ25lMmpac2xRTjZqbFVITnUraFp5WXlncTBrOHlETmUxTGl1aDJuek9h?=
 =?utf-8?B?ZFpnS0xMWTVPMGNJVGIvTEZKSWRVa0t4NmxrVCtIR0UxU0F2dElJbTdVU2h0?=
 =?utf-8?B?RUJXYkN6ckw0VmZLQTcyUzhpZ1Q3Y0czMXM1TlZ1cG11cnhLSDZPQ2hhaENx?=
 =?utf-8?B?RVFkVUVFRUVwRUNTT2t3YURXOVBQSEJBT250WjI4QURsdXF0UzNoTzViSmt6?=
 =?utf-8?B?OFZwVGpwcnMzNFM5NEhzVU91TkxFMUlkT1BNU01CWC9nSExheGNuUTlqS2Jy?=
 =?utf-8?B?UkdIK0RVUVB6eUlRakFZTkxVczc0SmJ2WXlRNnFBR3Z0dEdvbzZKc3V6ZDE0?=
 =?utf-8?B?anlwQnhBOEdScWFWL3JaRVYrK1l4OVEwVEhDM0ZIWGxHcEY2TEQrdVQxVExo?=
 =?utf-8?B?ZlJIV2hQdnNhTTB0cm1BdXErV2pvNzB1MlpqVFlJejkwODhtUW5xR0VxbTI1?=
 =?utf-8?B?d2lVeFZTcDYxSjI4UkgycCtWSEFra0JocVgwSElRRW1FclBQaUg2cWxsUjRR?=
 =?utf-8?B?RHY2VDRXM3A4c0ZDcWovMFhFNVJpVjU5T0R6eVdnMVdXRUNlVC9mcHV0WEF3?=
 =?utf-8?B?NXRDYTl3eFp1U28rTHE0VXFELzh2eGUzQ3hzQkJlcVU1Um5jdmZDRnVxeVJZ?=
 =?utf-8?Q?X5eKvecr+WtbNmQOY47VysnLQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3909a2a-d237-4a95-3ffd-08ddd06544e5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 19:05:52.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xi5R0lyDW+FEbVDi31g4XmASVxpM0ss03paV1XjzhU9BZALGdMAz+zVw2fhoO3LzyJ+Deu9SKSR1WxECadghYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955



On 30/07/2025 2:33, Jacob Keller wrote:
> 
> 
> On 7/18/2025 4:29 PM, Jakub Kicinski wrote:
>> On Tue, 15 Jul 2025 08:15:30 +0300 Tariq Toukan wrote:
>>> This patch series introduces support for exposing the raw free-running
>>> cycle counter of PTP hardware clocks. Some telemetry and low-level
>>> logging use cycle counter timestamps rather than nanoseconds.
>>> Currently, there is no generic interface to correlate these raw values
>>> with system time.
>>>
>>> To address this, the series introduces two new ioctl commands that
>>> allow userspace to query the device's raw cycle counter together with
>>> host time:
>>>
>>>   - PTP_SYS_OFFSET_PRECISE_CYCLES
>>>
>>>   - PTP_SYS_OFFSET_EXTENDED_CYCLES
>>>
>>> These commands work like their existing counterparts but return the
>>> device timestamp in cycle units instead of real-time nanoseconds.
>>>
>>> This can also be useful in the XDP fast path: if a driver inserts the
>>> raw cycle value into metadata instead of a real-time timestamp, it can
>>> avoid the overhead of converting cycles to time in the kernel. Then
>>> userspace can resolve the cycle-to-time mapping using this ioctl when
>>> needed.
>>>
>>> Adds the new PTP ioctls and integrates support in ptp_ioctl():
>>> - ptp: Add ioctl commands to expose raw cycle counter values
>>>
>>> Support for exposing raw cycles in mlx5:
>>> - net/mlx5: Extract MTCTR register read logic into helper function
>>> - net/mlx5: Support getcyclesx and getcrosscycles
>>
>> It'd be great to an Ack from Thomas or Richard on this (or failing that
>> at least other vendors?) Seems like we have a number of parallel
>> efforts to extend the PTP uAPI, I'm not sure how they all square
>> against each other, TBH.
>>
>> Full thread for folks I CCed in:
>> https://lore.kernel.org/all/1752556533-39218-1-git-send-email-tariqt@nvidia.com/
>>
> 
> I agree with Jakub about the need to properly explain the use cases and
> goals in the commit and cover letter. AFAIK there are no current public
> APIs for reporting cycles to userspace, so this really only makes sense
> with something like DPDK. Even the XDP related helpers expect nanosecond
> units now. Its unclear if we will need other parts of the APIs to also
> handle cycles, or if simple ability to get the current cycles is sufficient.
> 
> The API also doesn't directly provide a way to query the expected or
> nominal relationship between cycles and clock time.
> 
> If you try to just use PTP_SYS_OFFSET_EXTENDED_CYCLES to compare a
> cycles value to a clock value to adjust a timestamp, that requires that
> some other process is keeping CLOCK_REALTIME and the PHC clock
> synchronized. When handled within the driver, the software typically has
> an assumption about the relationship based on expected frequencies.
> Thus, a conversion from cycles to time uses this relationship.
> 
> You don't appear to expose that relationship through the API, which
> means you can only infer it either by knowing the device, or by assuming
> CLOCK_REALTIME is already synchronized with the PHC?
> 
> I guess userspace could also simply build its own equivalent of the
> struct timecounter using this API.. hmm.

Hi Jacob,

You’re right I’m not trying to reason about the nominal frequency.
The goal is to collect (cycle, system time) pairs and use them to 
correlate raw device timestamps with host time. This doesn’t require the 
PHC to be synchronized to CLOCK_REALTIME, but it does assume the user 
can estimate the drift or nominal frequency from the ioctl data.

I’ll clarify this in v2.

Thanks,
Carolina

