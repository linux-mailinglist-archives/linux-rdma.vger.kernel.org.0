Return-Path: <linux-rdma+bounces-14012-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6967C008FA
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 12:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C9E3A4775
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 10:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146B9309DDB;
	Thu, 23 Oct 2025 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c7aWEjEq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A00308F3E;
	Thu, 23 Oct 2025 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216302; cv=fail; b=tQkMHHRe3dUwbZipq20Liia9Zc5wlv+BfPpz6/q5TJQJJYIoekRXaidluBb6wJ42zKk7mtjls5VV8y7Pk0uP6Zch5Y7y74WysGPz1O3Q1DqB4baYgQuStSJnYkoAhiLUCRPOVF/RZPLhn0TzBDuLydEIfLpLGe5x69kcAEOr7m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216302; c=relaxed/simple;
	bh=PZjJu9ltcRQU5+3wjpR0ZS00uV1KRx5Fe5/OaukfIUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cf0aNrY0zoc2Aj7cVRwOJxcBGCA2BfkVXm7wvCPfIEMa+KL3jAjkd/VsluTPX/yHnWsW7GCv/s4xNlRtKOLVkFtAsgJy//ZKS0zl3YNx4Mu0iOJiGs9NRtvadbN7Pl0ihVM7wUXEInbA7tueDjfOUghtgaxKGIcDfrr+/f6PzGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c7aWEjEq; arc=fail smtp.client-ip=52.101.85.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUbYAC+CrWIoaER0EdF+C5RShYEe/vNa+dzYEhiQYgz8JsRstOQo4W8DPTRDhWpdXQTBfMCsSKeekcbSeh6Kszc64Xx7iTTcTZVzEFsyJKAnajs+3BoMNUAttuctsswsSYAxxYLUAjN77C+ljpjoCULyZoE7T9pdHf0l7Gr5QbrVPjv+AKbuoDKdxmkUi/oKISs0s7i/7hn1YPxMTzA3EoUNlgHng7kkIlpw9j1vjhfATzcv0uE3XdGgN9b/yyCiDqdYP21jgKITv8WY+/e9TiUf2+J6hr2Yq4Rw1aopT1XXvy8Ka+toZPXPtijyt4YXzaDgarAPBuNNIELNh2h/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyhR4kDRFixarRr5KEY241BgDv5UqGuws2Dl4s2YCaE=;
 b=bCRnN6GsWIPpljDIqH+L2ZVfeY5gkB45RCsE3t11Lgh8SaMRY89RupYFiCcqxyds6XLV/+mfr0Kx9vW9IigvZXJTXqtqN3eBOqIbGQC5IhJk+JKSYQEVPLfrqyBEuAmoORq93mWBxgdtX1zCwZcsf5RPqAP28xW4fZwBuJXoNjOUv60GzcBi8bfWdxJooTax2QbFRHyoAwnLr1bmL6yYxcHLnkg7VeVafogq1aZXd1IBnwFn5tJEioJmgH8t83yEZcUSc6zHy1ESPGLssHa5735IzKn31jykogQ9dt+KrjtsEGAu1aeySfwBi/C8bM0JBtepQss44+wKiRpL/QcwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyhR4kDRFixarRr5KEY241BgDv5UqGuws2Dl4s2YCaE=;
 b=c7aWEjEqDSYHWgMzew9cn4huyHdYVV2kDg5qArjNYjvn/uqNwy2gv+O9nFwbfGlJ9WVO2b5QaUdKiNZUoePuw36SHrVHvd0eyVPrMwTctfDF7LL+O7HzkKLA9rwZShZY3BGDgh7NOD0/7ON9/x3LO52pU6oO3reh2AduQJ8M58u9cyoR7toz+4vsFJhplD3R/q4mLS6RPhn4aV0SqgOTSQWAPjdsdySh/bK/aSeydtWYiqcRhZD5OGLDdWjVVNnFb6bEY3Ob+mqBfJLclc+XlBDSsvuhN0FFOSuTxubIBlG2EkQBRqMdm09siw4eBL+zio9H2e8vArINkmyDqsUV1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Thu, 23 Oct
 2025 10:44:56 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 10:44:56 +0000
Message-ID: <41428323-618b-4d54-899a-b2a5eafb6a03@nvidia.com>
Date: Thu, 23 Oct 2025 13:44:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 2/3] net: tls: Cancel RX async resync request on
 rdc_delta overflow
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>
References: <1760943954-909301-1-git-send-email-tariqt@nvidia.com>
 <1760943954-909301-3-git-send-email-tariqt@nvidia.com>
 <aPemno8TB-McfE24@krikkit> <ae854fd5-dda1-416a-9327-ac8f9f7d25ba@nvidia.com>
 <aPjSbFE-nQwDHUu1@krikkit>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <aPjSbFE-nQwDHUu1@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: cecab9b4-96b8-4514-2a6e-08de122134da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVI3Szh5NEdFQ1U5V3ZNbzQwaFA5OEZ4LzMzVnFpdlluMHBSSmxMTlVDSEp0?=
 =?utf-8?B?QjdzWTcraWR3QmlRbmdxOW8yUEtlSU1DMkpSMUJIbUlaTDZiOFhvRDBLYlhH?=
 =?utf-8?B?WUtNbUFSdWpmRkg3SjR1VG1TaEQvMml0RytycjkvU21XVVBESkRBdjA5K0hM?=
 =?utf-8?B?UG1EakZXUGFMN2EyQ1ZDa2JRUkJveTdMRjJCMmhnampWQzRjbUNXOGFmSHpi?=
 =?utf-8?B?WGpZK1JwVSsyekRVSENMWjFWTU85NUNPRDB0eDl5MU5HS1Y5VklDcnNmc01F?=
 =?utf-8?B?WkMxYUFiR0xjVDNwaldheGFhcWNHNmlwOG5PUjhBRnltazVySldQaGRteDZv?=
 =?utf-8?B?NGF2TVZkbjU2VkExRWNwTSt4RDBZYjRJb2lrWHdqQlZZU1NVTVRiVHRuSm41?=
 =?utf-8?B?MVhIV29Pc2hBd2RLaFk4QXFhTzFGbUMzOU51YThaRExFVyt5SjlwOGVvcWNB?=
 =?utf-8?B?TVNrOXFRc2ZtdU1nNzJSMDREakROV2srZ3lxWEZkY1laWHNXKzdFZWFMU2Fx?=
 =?utf-8?B?K1B0VENHWmVhRndBdFc3Nk1lTnVwRkpta3l6QWVlbXBaZ3VlVEdjR0J5NnlY?=
 =?utf-8?B?OFBQd2ptb0NZRm1lb01wcGNiTjZRQ2ZaL0duMTNPWDllRXFrc2NMTStUZkYr?=
 =?utf-8?B?WHBmN1FwTmp1aVFMRkRFaUhhWE1FK1JZd0JCVmxBSHNkUU9RUHdsT2tFSm5p?=
 =?utf-8?B?cTkyOGllR3MyVWtHdUp1azFza3pZZDRqbUozTW1iaU1HbHhzQU44ZzZtQVEz?=
 =?utf-8?B?aXBIb2cxY1JSUTFqMXNzNDVJbWFQZVZqYnhtNGE0Z055Mk9MMWliTWRDMU16?=
 =?utf-8?B?cVFER1NJdWVtRWZTRHEwUkVYdUt5Qk9oRHJ5TTZucElRQXpLM0hVcjVWSHY0?=
 =?utf-8?B?U05OVVUxd0d6Qy9acmgwK1hYZEYyUzlRQ2ljRU9EdGxZOEhHa0JiekQ0eTI5?=
 =?utf-8?B?SGZBeTVPOVhNUU9xMndTYUFNMHJBbXIyaDR2c1BFdFBMdFBXMlg2TVorNzBB?=
 =?utf-8?B?ZHV1MnNReDlGa1Z4MkdSMFJzb2RPMlFlYjZhUnBma1I5aHNMdk9TMS9pNzZs?=
 =?utf-8?B?NVI1bU5SS04vWk0xQUl0Um1ZNGJwS0tiZGhHV2c1RkJINUJkU041ZDBYSXFp?=
 =?utf-8?B?MVlyQTI1bkhBajcxNUFEM2tGQmxsWlhnNmZxaks4emEzVmNZeHRPZS9vWFJ2?=
 =?utf-8?B?YUdENUk4Y0VlejBJRG1tSlFuMnR6cDBLMkE4VmtUMjMvY2ZTTi82S2l6ZXlE?=
 =?utf-8?B?d1A3eFF0eHRQZ3JaUndjcmRkdys4NWo0Z20rS3FDdWNMR1FZWVMvYVh5WFE1?=
 =?utf-8?B?TUd2RGFYd3lLWDhaRVlDN2g2dHlFRE5EbGlRUnNCNDNFTHg4QjA3ZWdiMjA4?=
 =?utf-8?B?QlBXNjVZYWwrL2hoU0svT2VEUzc3WFdGTE12VVdRY3oySlJ4ZkZwL2RZRUhv?=
 =?utf-8?B?b1Z4U09FUDQ1TytNWnpnOVRRVkM1YWJQdk9zOEtxMUkrVFk4SGlUWVRBTy95?=
 =?utf-8?B?SnFKVFd1ZmVhNjJhNTFXWWRqN3dqcnJlSUZRREtSNStOem1KbTh0ZlJiVjhx?=
 =?utf-8?B?VnBoQk5iK0o0SXZtUDJJb3Fyc1ZjQ0xYc1JLVk5mTDBjZ3RrTlg1S2ZBSElk?=
 =?utf-8?B?T2JQL1V3anRRRTdTNkFzWld1emhtR2pYQ2NTUDRBMFU4MEJ6NjhrT0NmcUFX?=
 =?utf-8?B?dDNrRXJVbkZwNDh5L0tnVERRKy9FcjFUcTludXh3Q2lpREZHUlhZVnVkc2J6?=
 =?utf-8?B?cVordHRFTW5mOFZETSt5TE9uOUpqQ0NaL3ROVUd3clYyR216RkR5anBVYmNU?=
 =?utf-8?B?bGlGd2phazl1c0RCU3NzOVdtNnY3K2JkTlhtOVlTYjZyS3F6cU8zWkc4UXFx?=
 =?utf-8?B?cWttZUw1dElGL25IaXd5L3FwbHNaeUNQaTk0S1lEellJWkRXY1B3eS82WVZn?=
 =?utf-8?Q?Pc12hufmky3rdvJ+oxb16QAImMBEwOT6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUJLL0MxdCs4U2pTdE9sVnpjaDB5K3AxbVZldDVRNytqeDV5TlAvakxTNVl1?=
 =?utf-8?B?VDYwb2cxMzRDblcwenl6bStSVEdvc2VHYmxlSGtacFdKRXNpdzgxaUZFMkdI?=
 =?utf-8?B?NFNNVUxsSWpCNHUzcUlXZllQNHZuQzhrVnJEcU9pVEljMnhoVXNXRkxXQkRO?=
 =?utf-8?B?czc5Y0FoeklsOFF0dXNNNzVKaGlSQnhldVRXRE1lTkhUWVRVUkRaVkY0N3BU?=
 =?utf-8?B?UDVVaktxbFZacXd1d3p2QzUxWms2TmFCUlpCKzZtK1R1SFVqS0ZhU1h5cUNT?=
 =?utf-8?B?eFcwSzBkNi83TVhwNFlqL0djZVFDelRBYW9vSko4RjY2MzRFRTRLNWZQVzYx?=
 =?utf-8?B?cG13OE0yZnVLTmxPL3VEMUFCc0h3SGEvaWo4eEh3dkg1bDNabzEyK2Y2ZzlC?=
 =?utf-8?B?NHFnVm1JcHZjZEY4MFozZVczOFZxMW1Jd0MyS2xzaEl5L3gwa1p2NDVVVXR0?=
 =?utf-8?B?QW5jTk1WV3E5NzkvNU91V2Njb2ZMaG9vOE5mdm02eFU3RVZPS1F5VjI0YmZD?=
 =?utf-8?B?dzRTcTJCMkdPSWxBWm1oZG43NUtqVHRZUVNreDJRU3ZjWlpTUVBjVEd6WVZm?=
 =?utf-8?B?ZXpwa0dZdnNpZG9iZkRKMVZpVE40TWFhVE9ZMUZMaktSZk5SeU1WN0tab2Zz?=
 =?utf-8?B?L3BSQkNuaDZ4c2VNNXNPQnlaWnFsMFNhWEE1VkJKRjV4QWp1Vktadnk5eFFI?=
 =?utf-8?B?Z2VGeGkxd2NyTy83UlRtRXoyN2x1aURrKyswV3NTaHVCQTlYUTE5NTJyWjln?=
 =?utf-8?B?NitPemhJaUFhV2ZDUks3WElNVW52Z2tMZURTUWMvMjJnLzFVSFgwcVhYbm1C?=
 =?utf-8?B?bUVqWUtkbmQ2SWVIemVtQkhiUnNkYnh4M2Mvam9YUW1jV0F4VVdCU0pseG4r?=
 =?utf-8?B?QkZHMGFNSWlGS05icFdJM203TTQyUUFPVjZrd2d6MGJ5YWVQdG9wVTVMcDJa?=
 =?utf-8?B?R2hCMlRlQzU1cVBDeGE5YUtOdlhEWWg3dGhDRVdGbnFQeFE2OWwrT0pId1lL?=
 =?utf-8?B?b3lTb2hSVjNEYlpEdXR4dHRGTS9rZHlSSnh1Smp5ZDROMVU1aDNDeVlkRm1p?=
 =?utf-8?B?aUdPNWhUWWxlMktjZnRPamRvcmRJcC96azZselkzcTQ2YmlvNTF6aW94Ym1G?=
 =?utf-8?B?OUh4dUl2alBwckczc0xNVEhCbVptRTlraEswY2Q1WGc2WFhjbTMwdlJvejYx?=
 =?utf-8?B?TmN6US81RTBJK2grUlRnVVNkb01QSUduK2pFTkNkZDJYY3dUeTE5Z3dvdTls?=
 =?utf-8?B?MXQ5RzE1RUc1Z2oxdDErWi9FR1hzZWtOU3gzUUVLUnNrZVlkUEJ6MGkvcStV?=
 =?utf-8?B?cHZ5Y1VCZjFYVzhTQU9XTVl1K0ZIQ0w2SFRIWWYycnNvVmxRVS9xdVpTUHRZ?=
 =?utf-8?B?d2Fxbm9ZWHVEcnR2ZDBnbWJibFNrMEZBdzdyWGRBVE0xYWxwQ3J1Z0xtYzEx?=
 =?utf-8?B?VzM0YzY2UnV4emw0RENPdFBaODVDd0djaW1sc055YXpoMWRWSUFnSmxaYXNt?=
 =?utf-8?B?Vk9HeWk4SjN1cjhNZ1FaMXFZMW9tNG50U1JxdzgzaWthQ21CaWtFeUNOTU80?=
 =?utf-8?B?cHUySUwyUk1uMjBGaFErZmE5SXVkMXo3WmUxd0Z5Q2JkRk9ZRjJKNC80U0c2?=
 =?utf-8?B?MWcwTHkzY3h5Ti9Ta0p6K3JMWS9xWmxyekpKTjBhTHl0K1prT3VzS0VPOXEy?=
 =?utf-8?B?VlVDdWtuY0Jic2dlUUhEZ0FJWGovaldLbmZYRFZCSUNSaGJ0OE5MVUlVclJT?=
 =?utf-8?B?UE5lVGxGdEhzY0xmMnVTVklOZDFMS05PMDdraGJodjdqYk9pTVVwc01RWXZu?=
 =?utf-8?B?cEl0SC95bTRHWHo4YzhQcDFuWHhFVWNvV1FpS29Vc1RLQU02NFJhOG0xN0pC?=
 =?utf-8?B?YlFTTHAwamRYeGI1eWkzd3ZiS2YxU3g5YWhWbkIzbWQ3ektSQkUzSTl6NnBw?=
 =?utf-8?B?RjdZcmNrRGU4MURQSndJZE5TTm5DY1o1dVViTDVDclhsYWhNOC95dWc1SzJH?=
 =?utf-8?B?cTBtQkZ3NEN5QWZZUVdnZXhHcUhvSVJkYmFlVTMzQjBzd2NyYVljYjhQcHlj?=
 =?utf-8?B?TkxYUk1BNWhnSWc5YWFYdE5DRHlpOUtRb1FobUpyWWtXWlJvWW5kZ2U1TTlz?=
 =?utf-8?Q?3OLxjw45sJR0fRo0FmUMz+yJg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecab9b4-96b8-4514-2a6e-08de122134da
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 10:44:56.5604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6scmq2iqTxcJ/KlAa93bAO6sL5sLF8cw9urxDkl42dKciIW33kYG/GLUMUxvuEcR5RRdKLo+q3JEp/OZgK/9Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884



On 22/10/2025 15:47, Sabrina Dubroca wrote:
> 2025-10-22, 14:38:17 +0300, Shahar Shitrit wrote:
>>
>>
>> On 21/10/2025 18:28, Sabrina Dubroca wrote:
>>> nit if you end up respinning, there's a typo in the subject:
>>> s/rdc_delta/rcd_delta/
>>>
>>>
>>> 2025-10-20, 10:05:53 +0300, Tariq Toukan wrote:
>>>> From: Shahar Shitrit <shshitrit@nvidia.com>
>>>>
>>>> When a netdev issues a RX async resync request for a TLS connection,
>>>> the TLS module handles it by logging record headers and attempting to
>>>> match them to the tcp_sn provided by the device. If a match is found,
>>>> the TLS module approves the tcp_sn for resynchronization.
>>>>
>>>> While waiting for a device response, the TLS module also increments
>>>> rcd_delta each time a new TLS record is received, tracking the distance
>>>> from the original resync request.
>>>>
>>>> However, if the device response is delayed or fails (e.g due to
>>>> unstable connection and device getting out of tracking, hardware
>>>> errors, resource exhaustion etc.), the TLS module keeps logging and
>>>> incrementing, which can lead to a WARN() when rcd_delta exceeds the
>>>> threshold.
>>>>
>>>> To address this, introduce tls_offload_rx_resync_async_request_cancel()
>>>> to explicitly cancel resync requests when a device response failure is
>>>> detected. Call this helper also as a final safeguard when rcd_delta
>>>> crosses its threshold, as reaching this point implies that earlier
>>>> cancellation did not occur.
>>>>
>>>> Fixes: 138559b9f99d ("net/tls: Fix wrong record sn in async mode of device resync")
>>>
>>> The patch itself looks good, but what issue is fixed within this
>>> patch? The helper will be useful in the next patch, but right now
>>> we're only resetting the resync_async status. The only change I see
>>> (without patch 3) is that we won't call tls_device_rx_resync_async()
>>> next time we decrypt a record in SW, but it wouldn't have done
>>> anything.
>>>
>>> Actually, also in patch 1/3, there is no "fix" is in that patch.
>>>
>>
>> I agree about patch 1/3 so I'll remove the fixes tag.
>>
>> For this patch, indeed at this point the WARN() was already fired,
>> however, the bug being addressed is the unnecessary work the TLS module
>> continues to do. For my liking, the wasted CPU cycles and resources
>> alone justify the fix, even if we've already issued a warning.
>> What do you think?
> 
> Is there any work being done/avoided other than calling
> tls_device_rx_resync_async and returning immediately?
> 
> With or without the patch, tls_device_rx_resync_new_rec will be called
> during stream parsing.
> 
> Currently, resync_async->req doesn't get reset so we'll call
> tls_device_rx_resync_async. We're still in async phase, rcd_delta is
> still USHRT_MAX, and we're done, tls_device_rx_resync_new_rec returns.
> 
> With the patch, we'll see that resync_async->req is 0 and avoid
> calling tls_device_rx_resync_async.
> 
> Did I miss something else?
> 
My bad, you are right. The unnecessary work the invocation of
tls_device_rx_resync_async.
OK so there are some options; I can either simply remove the fixes tag
and leave the patch as is, or I can also remove the call to
tls_offload_rx_resync_async_request_cancel() at that point so the patch
only introduces the helper (and then submit a patch to net-next that
adds the call to tls_offload_rx_resync_async_request_cancel when
rcd_delta == USHRT_MAX to improve the behavior).

what do you think it's the best to do?


