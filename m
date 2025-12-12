Return-Path: <linux-rdma+bounces-14978-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0495CCB8438
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Dec 2025 09:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADD013060F29
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Dec 2025 08:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BE530FC2A;
	Fri, 12 Dec 2025 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HbIgMX5b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010041.outbound.protection.outlook.com [52.101.193.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887B30F942;
	Fri, 12 Dec 2025 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527898; cv=fail; b=X6wtg9UsaSsVBfPFlrLc0HB8zONHRwCbiJQeniaHyYyKyyCQOjxQbo+HRGHOigQ1xin0hP6dJoWhDjxb/wpBvn81y2P8x53P0UB4hQh55QQGyiHoPzr1EmQvO/mHz1rRBcHZDtnbebDrP3MJXdg03suH6voNDwZJtVxDpdpqTWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527898; c=relaxed/simple;
	bh=7gexjvo6x7grkEAS5q0nj7XkaVGc3WUO2t/VpkK1h48=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dmvq8EaRGZFdjkhbC/SBA0EP12Xxvh+ZE7fOgUoHPFMM/c8Z5GU4/y6gluAw+Tvd8+/nGnC5ppDVgHpdfDsJWQh5CUrtSdJlmzPc2cW9P6GwYIC5a9jeuhbYvpvo94ijfPhD9sk/5/p8P6wEmfI0vm/L4+BsmNrxGr2ZXGrAxDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HbIgMX5b; arc=fail smtp.client-ip=52.101.193.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vjtt08zsRi4Q1dIzkTGzzc9H16vznq4DtePibtp8MI4mvxcSPKXGD0uytxP3HTwC4DT/+f2VR5AwgMtd9BqKLSE/0FVu6XWYwxPhgEVbXZfWj1kqQANGx9ZoZ9BIpHqFoWrm0lXtkcW31uvGEYV9Zslj2NMxxthpc9mzUXmohDzYKEn5jzdecEmkgk8SRBeDSA9LxsJhMc7I6VMRkzVA/MsL+v3ipNtz0o9qMA2a8ZpMaGwS82ZAM+wPSb1xcEU8/VgZct7NyOGczlS0aPlv9gO0wkxyTeEUKTlWGqruVm+U2Nws1ZP4rewFU6Pl8ejqakyavvFrwA2WnW02qC+mZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7++XULC/b8mP2Egx+SWbLynS11sUo7bFuyPXYnGjVF0=;
 b=gCsRSNvkb8gEpFsBunpOV0oNs2V9uZ56TahqP2LQF287VEQ8EZvNwe0q8nT6a0Eu7QcJaTnv8LtjW9vFlcvrLAn7S6HdfPthMKPgZZdTKANdPs/Mz3tn8fO7BjCgtVOf423dM6gkEJ61HNyX5hpw3jwv3CQPOV29lj2aQdA1jnkGGdC+j0JshFFIKFY6vuBgGCHUx5RjsksSFqE3SGmrwqG0CInV/euVbdY8ARxY5Mfdp37fIbQrsGU4ljc843D/FFB7PzOjMUmQ0RLE51NYZjXho5DiZrAm++MoMLNti23UEWAql+qogYwVa4KwNDHQqGQWCh5GyCI6vi4b+06YbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7++XULC/b8mP2Egx+SWbLynS11sUo7bFuyPXYnGjVF0=;
 b=HbIgMX5bv9n7HhdxXFEcbSPUbhfn8Q6fZ/73gzQdT3p8ucKIdVQyu9Gg9lDCUdnRL1N0WHggWvC7JsAX48BiAgxzUTa7I/xt59aqhCzSn+Qh2dsHQtsyS1rw1Y6Zb+BIAtotrmD9LjZhJcI8HQp9Fp7DAdGV0BV4LsRFZ3/Xy50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 08:24:54 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 08:24:54 +0000
Message-ID: <66a98775-76f2-683f-77b1-7f5dc991ca14@amd.com>
Date: Fri, 12 Dec 2025 13:54:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] RDMA/ionic: Replace cpu_to_be64 + le64_to_cpu with swab64
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Allen Hubbe <allen.hubbe@amd.com>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thorsten Blum <thorsten.blum@linux.dev>
References: <20251210131428.569187-2-thorsten.blum@linux.dev>
 <aTu7FFofH/ot1A74@ziepe.ca>
Content-Language: en-US
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <aTu7FFofH/ot1A74@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::7) To DM6PR12MB4516.namprd12.prod.outlook.com
 (2603:10b6:5:2ac::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4516:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d73e6e7-2965-4815-9710-08de3957ecb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bSsyNENQZWNmaFdreWlWckdRMnVzTk9Ic2N4aW1qWVBDbmNSdVFYUHFXTytK?=
 =?utf-8?B?WDJSQUg3WjRFUElCaWRZUm5nQWt2bDJVeVU5SlFsd2duRTRWVzQwMUpTWDFF?=
 =?utf-8?B?SjAwODFxQW1hS0hJekVmR3FpRmorNUNsYlFRdUttb1NCTndoQ2xWdVdvZEhS?=
 =?utf-8?B?M1hLUTFDb0NLWmZZTTJYS00zakovKzR4MGVPQ2Vjd1dnMnY3MUxSN0tXWWp2?=
 =?utf-8?B?RU4zaDRraTRwcjRUOUdmcFVEd2QxZHdpdE1mWmZvZER4STl5WjlEayt1MklW?=
 =?utf-8?B?N281RW5wdTJZcVV6ZmluUEMwTUE0OGFWbjV5bE9BTzFrSXE3N1Nzd0E4ZmJD?=
 =?utf-8?B?d09NUVZkay9YekVOSGZHdzJmUzhqSVJIdXZXRGdWVU13eXp3VnJtWlNub3la?=
 =?utf-8?B?TTFYUTlLcmYzWFRuWnlpU2lCQ25JNUtMQkRjZGVPSExoaytGYkszbTExeXYx?=
 =?utf-8?B?dVk1T2pTRG5RQVUvUzk5UWdmeVV6dklJNmNucko0eTk4dmh2TURxUW40ZGMx?=
 =?utf-8?B?SkZXeHJibUxobkhsMzh3SzBhYytyUUpHQ0tUb1hQOU1vdlo5UWZrSk5RN2Ny?=
 =?utf-8?B?RDVqNXVQR0FYcno4Qm1VTlY2NU9ONnBlaTZxNDZEQzFRdnFtWGlETHNoNjZl?=
 =?utf-8?B?TFB0eEFVajZVUS9BV1FDOE5VUGNEUXJqTk1NTHZSR3QwamlFbG9JSlpKc2sw?=
 =?utf-8?B?ZDRrUjZyYzdMbVdBWXhjY3BZWHdsMTdwRStNdFhoaURLSlo1WjVPOVZIR3RK?=
 =?utf-8?B?TU5ldXRlTzlTdUxxeDJ4Q2p6aHlhenRNTFRmeE1wbGl3QjJ6d2YwU0JzUEt4?=
 =?utf-8?B?cDUvQ2h6TGVkTmoxdmR5aU00dXBhK0dZZDhCSzd5UWdJanRMYjR1Q09RR0Va?=
 =?utf-8?B?STlDUHU4TVhIOE9BWmVFbzVSRmlBbGZ1azc2b3k4cXVYWGw3U29LeWxnelI4?=
 =?utf-8?B?V2s0QjNhZGQ2ekhWMTZRMnZucys3a04rZ0E0RFVrVG50SXovNHI4WE9KbWVW?=
 =?utf-8?B?bWVaK3ZBQWJPbDNwTkZQYUlreUdROExKM09DTVhGM3VaUFFsSmdZWWFqNU9n?=
 =?utf-8?B?K29vTUNjVWNhSzNGSWdmZ0s0Qk5rb045Zkl1MlIrQ05WbTFOTjJYM0tiV1ZN?=
 =?utf-8?B?WjNRNUdsb1hXQTVMMkN2ZTdST2hNVnM2NGlOemhGS1lrUis1azh4b2RKNmcz?=
 =?utf-8?B?KzVWSGgzcGRzN3BGRUZCWFlzNDQwNjZJOTRNQjNUVURGdy8yN0RtcEd1UFZh?=
 =?utf-8?B?MHBQK2trUzNEWUNvMW0xekdGa0VaYXhIaitIRklzNDJnbzFXSFBwRGgwYTZG?=
 =?utf-8?B?d05ocnJmemViY2VUVXVGdGxUYi9pTk9jTmVoaDU5RTdNRHpqdjhoZkV5SVI1?=
 =?utf-8?B?WE1yamlIR2ZQN3EwZVI3aU55dWg4cThST2gvaGNQTHQzSXFMaDNuMkZwN2ow?=
 =?utf-8?B?U1kwaUdiRjFtSTZOTnhhUldBRnYwNFpscWxEeUhVV0QvVXk0dG5CUDVZcEZK?=
 =?utf-8?B?b0lsd0tJNDJUcEZ3c0RXTktNMG1SQWxQTWdMMHV1bjBSUEFoT25odzZiOVdm?=
 =?utf-8?B?U1VmZ0xKTjZ2czZwUnVSV01vUnRTeU5oV2tkU2wrODdPWlMxekF1clRkZVgz?=
 =?utf-8?B?NnBUZUFVU3JSdmxqNEVFd1lMdzdyNEZGeWZlQmUzakN6c3RQOXZaUG9YN3dL?=
 =?utf-8?B?R3FRLzhueVk2VUsvUHhmcENxY0dYY0ZHT296dkJsZ2hWV2FQRFk0UVRleXFa?=
 =?utf-8?B?MTJLL0xjVVo1VE9ZSkJsN2VBa0xWdGJMaFdTb1VtTHg4VGVRZmZNTGFPVFUw?=
 =?utf-8?B?K1ppcDBydCtEWVVKbmZYeHFMZXFaV1VOV21UY01jRTI0VytzK1pNa0M5ckdG?=
 =?utf-8?B?VGNyQ0E3R0dnM2IzeHpVdWlJanEyYklCTWE4b0J3c28vbHd5SWdrc0VPNEZJ?=
 =?utf-8?Q?czkeI44lHoSUxTo+JX2elBM7aaPPlURC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFJzNm5Ec1BiTVZmMmhDYUZWS0Q0c1h6S0czNHhwN09CR1hUTmJSRXJrYnh5?=
 =?utf-8?B?aU1McjRoNldSbjhZRVZJV0xsMmhGRzdSa2N4OHA1c0ZVaHZBVU4yeWs4R2Fx?=
 =?utf-8?B?QkxwQ0Q2ZzFlYjB4UDJuTy9mandtaXQ0MHRBWVZBQnkrSmNIaWxkMGhlOXli?=
 =?utf-8?B?MlhEYkI5VkN4cW9OMzllNWNudU1EWHRVZjdXZ1QxekNqaDJMRnJrZXVsSjQ0?=
 =?utf-8?B?Nnl3aE82U2dDMmF2TTZaQkdaZGtEL1lQMlpTUUdGanBXSDJUUTBrR3dwWVBu?=
 =?utf-8?B?UExHRE9wQi85VGV4Ni90d0lnK1ZvN2ExMGphNEN0SHJvVVkvU09BK3lKeXFs?=
 =?utf-8?B?dktZSWVqT0x1NEJRMnc3SDBKaS9rallRUHord3F0VkNVaDNyaVBEcENkMG5a?=
 =?utf-8?B?dE9OSmxwakU1SldGOXJLSjVQNGUrK3ZmSHBiblhrNHJrcFMySDNxM1FJRmxN?=
 =?utf-8?B?VUtZQzFKMDhpT2ZLS01PbFJBdjZkSzdQSmVNTnMrcDhEb2laVnZ4MUNKNWRy?=
 =?utf-8?B?L3hvNVlKeVlOamQ3eDFvTXcxUU9QZUdyVlZTUUhhY24wTDQyaStENkwrWE1o?=
 =?utf-8?B?dG1pVnFEUTBwS1JqR05ERENUdVpJVG85eE9LZmhBVlRnTU00QU5xSTdSOVUv?=
 =?utf-8?B?TEhnRGRrZ01sVWVBcGJ3K0FENkgyNTFMUWpEOUVBN0p1bnEzbjFvNGhqNTUz?=
 =?utf-8?B?Q3NIUlhnTFROSnJnZ1VvN2Z2cHJCWXBZZDBaOTYzUFhwUXRHV3BpSUdsUG1t?=
 =?utf-8?B?bVpTcHVOWjVRWkVjbzgvd084aEVNK1ZibEtzL3RTMUNtdy9RSldqRHd3eUtv?=
 =?utf-8?B?Z1dyRG12TzlFSll4UlVnQjEzNHpUcElyY0pwSGxiTXZnT0ttcGhOUm4vaDFV?=
 =?utf-8?B?T2hkTEpJOVBBWnBWVERBZmxJcDFVNVI1aURlMHdXKzBKNTNmUzU4cjQwSnRv?=
 =?utf-8?B?WXVUSnlwbU0rOGlGMkI1UmRVNTBTcDZ6bno2R0M3RE5GNmo2UUZENmtYYm56?=
 =?utf-8?B?TTBiV3psRUVUbjM1b3VkYkxaRGQ1WnkvcU45YVlBV3hYQ3BBR3FVS1d0MW5a?=
 =?utf-8?B?RENFUURsUlVhOUZDYktZZXdrZE5PNWIzY0d6di8yTm1qUWV4amRCY0VWZ3M0?=
 =?utf-8?B?aGduaXdqMXlYb3RIaDZQSFozbkFDMTk1Q2tTeThnWSt5cGQ1OFpkbDJPN05v?=
 =?utf-8?B?UDk2TDgzU09xazRVR1VvcmY3WXpjOFl4Z3F3RVhBdXdQeFozT1ppazRPajRP?=
 =?utf-8?B?MGxva3dUQ2V5R2RzclFTaU04NDhsVjFlZzV1dWpHSGxCSzF2emFFSzZCME5n?=
 =?utf-8?B?SGJUbVNtNWQ1S1BJSTYwN3JhNnY3TlRkN2psL1NycHlSOVBLTFh3aytBaDBX?=
 =?utf-8?B?QnJuTFAxaXArNHliWTVWeDdDZkloclgvK3hjbTZyaFY3bTNueDBrS3Y3TlVh?=
 =?utf-8?B?SWp6Nm96NklZQ3hIL3FScTl1Z2VuRzJ3eEpCT2FlcG80VGFWM1llbnVkMFla?=
 =?utf-8?B?VU8wYzMrUGorMjFld3dBRDBuRjFZUHdLRUIwU1cyK2o1SG5hbWdINjdFQkJS?=
 =?utf-8?B?am4zYm5scnRWbTRkYTJyRU9GUS9nU3dBWWJCcWpQL3dQVFp2NVVUbURaTjVP?=
 =?utf-8?B?YVZqRjhlYlJObmkxbUNUUXVwVDRGMFdOUjNFekFwYmVLelk3alQvOCtScnZ1?=
 =?utf-8?B?Rm5JUzBpWWs3YkUyeU03UXMzU3J1eFYrR2w5YTZYK0lIYzlxNVBOcjI5UTh5?=
 =?utf-8?B?Z3FlRUtDN0ZTUk1CdjR4Skx3anFndm1MUmhWKzZJN0hrNUNDSW9LS3k3V0NN?=
 =?utf-8?B?a3I3WGdJU09DNVl0V1RLRE9teGR3Y3IvU0pURnNzcDF0S3VDYjJOMmlYU3F5?=
 =?utf-8?B?bjFuWng5cjhyVzhYRGNkVlk0MXkxTmxZRHlnVFdEWm1GdUFuSVBlSUFSUTMv?=
 =?utf-8?B?LzJNWW5kcnVyUVE0ZnZoa1ZlSU9OU1NBeVlsVkQrdW1IZnB1MXVmbWtSbFlv?=
 =?utf-8?B?QWJ3eS9sTG1URDZiUGZ6T1hqa2wwSk9WQ3BzTUNwNnJYandSZFhxay9CY2p1?=
 =?utf-8?B?UlM5MFFyOERmMGFmUjZ4VGdCVE9aWmtxTnplTXJTSnYrUG5wRXFlUnRuUitT?=
 =?utf-8?Q?s9xhK5zWRu59HYaI7kMrK6QeW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d73e6e7-2965-4815-9710-08de3957ecb3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 08:24:53.6170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcIaZ05S/stedl2rg+v1nU2q22/fAJlfjcVmdNC0vuq+EK65w1Yg35dTOjp4bc/qgfIBvilt857Ip5wtckc/3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214


On 12/12/25 12:19, Jason Gunthorpe wrote:
> On Wed, Dec 10, 2025 at 02:14:29PM +0100, Thorsten Blum wrote:
>> Replace cpu_to_be64(le64_to_cpu()) with swab64() to simplify
>> ionic_prep_reg().  No functional changes.
>>
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>>   drivers/infiniband/hw/ionic/ionic_datapath.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/ionic/ionic_datapath.c b/drivers/infiniband/hw/ionic/ionic_datapath.c
>> index aa2944887f23..1a1cf82d1745 100644
>> --- a/drivers/infiniband/hw/ionic/ionic_datapath.c
>> +++ b/drivers/infiniband/hw/ionic/ionic_datapath.c
>> @@ -1105,7 +1105,7 @@ static int ionic_prep_reg(struct ionic_qp *qp,
>>   	wqe->reg_mr.length = cpu_to_be64(mr->ibmr.length);
>>   	wqe->reg_mr.offset = ionic_pgtbl_off(&mr->buf, mr->ibmr.iova);
>>   	dma_addr = ionic_pgtbl_dma(&mr->buf, mr->ibmr.iova);
>> -	wqe->reg_mr.dma_addr = cpu_to_be64(le64_to_cpu(dma_addr));
>> +	wqe->reg_mr.dma_addr = swab64(dma_addr);
> This doesn't make any sense to me. The original code looks wrong and
> would fail sparse, switching to swab just highlights how nonsense it
> is, there is no way that is right on BE and LE.
>
> Pensando guys what is the right thing to do here??
>
> Jason

The original code does not have sparse failure. ionic_pgtbl_dma() is 
returning __le64, which is what swapped to __be64 for 
wqe->reg_me.dma_addr. However the proposed fix is definitely going to 
throw sparse warning.

Thanks,
Abhijit


