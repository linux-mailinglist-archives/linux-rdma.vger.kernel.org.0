Return-Path: <linux-rdma+bounces-10288-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0D8AB2F31
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 07:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949FE3B580D
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 05:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EC8255245;
	Mon, 12 May 2025 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y+am50wB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD05AD5E;
	Mon, 12 May 2025 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747029271; cv=fail; b=W/Bhg+niKUliFx0Ifv71ftHobifFeoN+VV+5QUsCXZ1TIh1WsUqMPSYekcQfnal4uN1/iU602rskEUdkycY7ehjdXnw6rDuiN0+YhyaGUwG4lLpdLq5LrMl+xhVN2Io9DZpQZWyvWX9J8wPwgPnTZYwpTY4YsayaDFtwB4t/pg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747029271; c=relaxed/simple;
	bh=nU4fJf3C/i7KObEX976nKjAA3NuEcfG8FiVdpWtYd9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AAWxjSFHg0PdpiBMitFpjKvBx7rTI4FsQRODesQq5QyqKPfTzhUPpd6s3t4GD3TSfFoZ6gGv1Gin+bmFVD1Iy3bYYbdTVw8VsddQhI9I26wMU9/EVVASVbMRz2ej5GTMo2lbwoD1OdU6Q2mIVbNHmxGXVhwgdstrqIkdIlT4RDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y+am50wB; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/g2kupmI1oTrg2TIxBIMkA17+RaUTmxuFSb8vDUnWM1bvEQQ/wlZGCxBUXxJGVJD9v8lY3ocHPxRJuX7AJ55pNYRWaxussVoAmi0Ld0Zp+7GYM8Dcd91ZDeC/96Ih4HLm0iadKPoa5R6AhAcSfmvPRkQjsimvXTBu/MN3215WMGN1bJgBHjBRVMAqs7dh46VvO4dIIUQs308vt5vksaoaqQLtXOQ6Dzfcn7BGEBzuZo9Cr6HdxEMphTsx0WkYBdY+TnXCmGCzD0GJHfzmQAR5OqjN87dsLpMy/I1RHRc42CFkQtmaHZ+bJKbugzXSwYU/xRaF29txtRcFZ2RtLL6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVTpfO5iiPlh7ARWpeh9H+sde8JHE49J3z0dwbuG17k=;
 b=AeHmpzfzT+qAHb5d2T8ZC75QYyDDlgiOlHphSyqgg/Y+NctJWG1tBLMaFnRiq0E6u0ladJsrRHABV/434LWQnzpn3qSsywOmoFdmIfK69S0IHOaLw0xkO23+xDZYGOQBp4Dpjia1C1xgKPqXQwBA3bTj3VJsrW2XsGv/NLNQm7F+psCIn1k/Et+5Ugot5m8BnTzkUoea/kV82AtjNfACGjbvkmFb7oHm6lt5AHAngaTazmfSiWirXNjY+3cPzYhteBPtfelaFYeOc5I/reFud4mKmFERfHeeNUleugRM8kk8FYoLAKbRJIL59AT5qaQgUS1Oa2hgwMind84OjLs5kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVTpfO5iiPlh7ARWpeh9H+sde8JHE49J3z0dwbuG17k=;
 b=y+am50wBd3onEkcJAyMVd3JR6e5+auFRtLRJDOAglpJBRspmrjjy8QSed4enHU0nC3W+N1O3wnSOqop5WpMY4z/Yyrhm2pYMyw3vxX6mfM4nLPO1p01DSKiUhnVJ+Ouo3iB+50paJmtCNHnVyMmhkdfKhBoTWCsQ/+Dynq6CqRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 05:54:27 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%6]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 05:54:27 +0000
Message-ID: <70d63971-6b74-41ae-bde3-b08b5f244672@amd.com>
Date: Mon, 12 May 2025 11:24:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build
 environment
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 jgg@ziepe.ca, leon@kernel.org, andrew+netdev@lunn.ch, allen.hubbe@amd.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
 <20250508045957.2823318-15-abhijit.gangurde@amd.com>
 <20250509203352.GS3339421@horms.kernel.org>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250509203352.GS3339421@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: beb541d2-1c67-4f0a-aa15-08dd91197488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUZkWHRwcXdLSk42V3hhWjg0ZUNROU9KaW5oU25veG9pVml5TGFlRnRjcGlZ?=
 =?utf-8?B?amw2MHFjQUl0YXVMeHFCdHBzQWpDMjBUVkxRY1duT290WFZON005alJvK3Bx?=
 =?utf-8?B?RVdvM0NNblpVWTBQaWpJS2tXL0NaM2M2bU9JanJ3TzkvczNNOEU2ZlJjbnM1?=
 =?utf-8?B?a0pJNWdNT1N4NUN5SXJzLy9SN2pmSFV4YURjaXNTTEpERDUvK1dVZUFoM09X?=
 =?utf-8?B?bEdrcXZJUW1lcTl6Y0RpY1ZBQ1RrL0VBaUVwMTFlQWVOZHRlcGpqNld2QWYx?=
 =?utf-8?B?ZjJlMmJKTy9MeXJySTNPVkh1U0FuU2lRejRnTjBlWFIxOFV3emxuYmxtRWF1?=
 =?utf-8?B?RkFYZ2pkMURFdFFxaXl0K0RLNHpzV3ZqZzFmeUd3Vkc1b05KbW9TYWhxVWF1?=
 =?utf-8?B?MzdRWVZsOUhtUUFNeEovT2NWdW1GcS9ObEx0QS8vYWVOOGVzT3VYVnJ6RHpO?=
 =?utf-8?B?Q3UxNXFBbGg5QzJDbHhyamVmOE1VWU5aSDJYNnd6QmM4YmJhczZ4YmljNFVT?=
 =?utf-8?B?NWU1UTU5YjFnVmIxaVN1eVJpZDN6ckJzWGQ1TXlyaUZobklvTlpoc1AwVzRx?=
 =?utf-8?B?NVhySkYyNUNxbkxldGhLUlRaZUNtRHYyVy81TDJJd29ic2U4eDR1S09jU3VM?=
 =?utf-8?B?Y05kTkIzRW9pT0J1MzhzMXpaUDlOem0weWVtMk1LQUJFZVdiOXlKbUI3eXZI?=
 =?utf-8?B?TGVrRzUva3dLOHlqT0dqM09YWGlaVkc0RXBtRllPakJic1JwQzFGUWFuWjNN?=
 =?utf-8?B?V2hocldKSmZIeFJlTGgralpJY1lxVVZFWFdiZlIwNzJnQy9rWkEyM0dKOW80?=
 =?utf-8?B?aWhSVjNZU0h6cS9qQk9pVHlRTmFNNzJnblZGWm1TYzBEK2o2ZS9QTDNZemRi?=
 =?utf-8?B?SjNWeTRhb0ZLYWQzWWhZdHcwcW1GSEZkbnNFNkZvWGNhdlhlWnlTZUNOVTk5?=
 =?utf-8?B?bSt3d2Z1T0EvWFZiY0RTL2VZVWtWMjMzeGx1SVRTNGdaODVub0g3NVlUYzNv?=
 =?utf-8?B?bm9tQm1JcjUvYzhIYWZFQVZ6K3VHU2p1bEJoNG5XOVhaV0NXbEhOVEdFQ1RP?=
 =?utf-8?B?M0Q3VGxUNEJwdjlTSlF0SC85bWpZdHNOZEx6aFhOcEpkWjdFRzhjQmpIRjln?=
 =?utf-8?B?MHNrVnNqakJPdHNmYy9COEowdG5VTm96WmRjb0VYakFweU5za3JKdU5PYlRm?=
 =?utf-8?B?d2RNRkRqNnVmT0pMUHVLSU9yYXZmcmtENFBxd054SXQwa2F3QWUrYUpjaC9y?=
 =?utf-8?B?alFLc01kZXhxZjFiZUt5ajdXbEtxc2xwMlFsVjBkczlQazh4OU5peEV6MXZ3?=
 =?utf-8?B?Q0RaYnc2QXQzakYwakxsZ3ZYSzd6ejBlaDdNQWJUVHp3aEpMaXM3L284aStC?=
 =?utf-8?B?SkFDTXI2ZmxoTHlTVU56V2VsSzdTZUhYV3g2UG44WWtlZXhnQUlWMUNjMjJY?=
 =?utf-8?B?eU9sSG4rellZMDcwMXBFVVp4YWErd0FOeUxDcFdhS3JrRW54Y2VTc203WmRm?=
 =?utf-8?B?VmgwazJxd0FER0RrKzBnYnpkNVVxMnVSY3RxRFJwdjNKSTNzblBLQmVQUzRS?=
 =?utf-8?B?bjhJYVoyeXdtbDFkK28xWjZOa1NWSnhaUUdpS2RNOFZLRityZCtSMW5rU3A4?=
 =?utf-8?B?N2cwNnI1b2ZZZWtza0Nma3lxYUxBblpaSDVCTmtFQzJIZ1VkbXdwbXM0ay9r?=
 =?utf-8?B?UzFjRENzSzlZenl2Q0J6a2lpcnhvUFY5a2xOWDNrZWw5MjQwL3VDbkJwRU1r?=
 =?utf-8?B?dzBxR3pVa1BWemh4SWJRaDMzVDJYc2FsVTJaUUtpV2JHVEEvb1lKWC8wYXhk?=
 =?utf-8?B?b3V5dVNWNHZEZTNybzFoVXFsdUo3Mnh3aXJ3RWFmM25tRUZ6VmVyc1A0K2h0?=
 =?utf-8?B?TU10YTJrR2E3K1ZkQW5nWENpbVhqbjZJVUtLSlV4L2pySXlHbnJETjc1Q1pk?=
 =?utf-8?Q?oSMuZN4e9XY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGhxY3RkRzllZVhpZ3dWWXpIQTVtRjNCLzNzZUNZVGIvUWNLTG9DSmxBWC80?=
 =?utf-8?B?MmVRbFBsUHJULzVJVFZlREkrcFdPTEZuME5lYmxDZEtKM1RHZVJYSDgyNTRw?=
 =?utf-8?B?MG5CMDgvSmgxME5vWjBhMGgzQ0t5WXNNc3FIWXNvLzA5Nmxia0xpYjF0NUlY?=
 =?utf-8?B?TnFNVWw3bmpJa1FtNjFqcnpjVWZ3VU1URkgxSWNxdGFLdkZ3MndLMUZsamZv?=
 =?utf-8?B?LzRUaCtKTzFzSjBDMUFLRytoS3phdHkrdVM3SHFYNWNXSk5qeUVja1ViVG8r?=
 =?utf-8?B?ajZFV3dzOUJQUk9YenpBZmovZTRRWnJUR1NrOGdFbFJTc0xZck5LUmF4NytL?=
 =?utf-8?B?SlpETk8rTUVYVW1ZWGg5VkNmUXU1RnlXUnNzYTRScmFMVldyNmJmNmpUbGI4?=
 =?utf-8?B?WVFuZDU3TDJvVmxyREhmWFlHRWZqLy8zdFdmays5VTJVZEdaVXEvV1UrOHc4?=
 =?utf-8?B?Mnc4d216UUR2WDdla3pBMHQ3UlBlNndEMFhsYTM3aXg2N2Y5cTBvN0NFNDFN?=
 =?utf-8?B?SmlvNitWMVhmWTBVd2VBMS9obUxWckVkTzZsK282Y3pQaDN3Y1Z0WlR3MHFD?=
 =?utf-8?B?ZkR4bXcxckRPN2I3UjRDcHhUMlRnRmJBNFcwbGpGdVJpeUFUbUxvV3J0ci9j?=
 =?utf-8?B?SGwzWG9GY0ZMaEpWMldxUW5DUW11Uk9Rdm9uUWc1eUFwdnF4UnBobHAwVlFC?=
 =?utf-8?B?SVlKeHJFUFNBWDliSWRtckduN3NpT2NZWHRQdi91ZW5OU3J5d3kvN2FRU3ZR?=
 =?utf-8?B?Z09Td1FBdVhFeWhQNTBMQ0IxblNTN25UM3VJL2Mzd1pMaXIvQXJkejlxUFFl?=
 =?utf-8?B?VStGanR3N0g2Um5LdUhDQjc5Q20xUTJSNjY0M0VyU3o0Tm1PTmZreFQvMGNs?=
 =?utf-8?B?Nk1uVW5FcHBvZVpRNXdkbk82MFI3UkVOTk1JcUlzelUrcTZJRDdkWTFRRzBB?=
 =?utf-8?B?WDBFaWhHc1B2OFVPRFFIYzVrbmV5RjZJR0wwMDVrQ09oOEhHSE83WVkwaGNm?=
 =?utf-8?B?WVd5S002RnowbGVVeWJ1dTE2TlRXYlFYZkc1NnpPT0dWT2FMNC9LbklZd1J2?=
 =?utf-8?B?Njd5dDh4STNVMm1Oc1NKZmZjdDRta211RWxJK1ZIRmNOR200TWcwb3c0T1hG?=
 =?utf-8?B?Vkc0aXM2a2pkTmF4TW5BMy9sU1BUSEdPN01yc3Bxd3NQRm8rNnp6WisxcTZz?=
 =?utf-8?B?aHhZLzRFN1M3T2J2QUlFNTFWZzB2akQ5M01ydmg3Z1VuL3pkeHVVdXVaSURO?=
 =?utf-8?B?SGRhZGplMGdXR3NEUHdGK1hwSlNVZlliZkJjYkpHdmR6MU9wenJ3Y3V0SHZE?=
 =?utf-8?B?NVpTUDU1VVlSVDNobVhJVjdvc3E0WERucHYwRnQ1a0ZtalNjNS80RmFGUHpo?=
 =?utf-8?B?ZlB5ckl2aWpWR3Uybk4zUjc3T0duV0RBS0dUTFU0RFp4bFh1S1l3R1kzc2xM?=
 =?utf-8?B?Y2hRaTJhQXB4OWRUb2ZDbFdiTTkrRlc5TTdLT3NrVVRZLzh6TzhvQXV2c2Yx?=
 =?utf-8?B?RDJHTXRhNmovMUxOWVpNWDFSSkIxVGdNT1NFay8wVDhFY0dpOExBaUNVdVAy?=
 =?utf-8?B?K256WUhTQzhqSnozeEpzNXorSWFlazkzLzFYR2I0OFdrd29TNVFJR2hKUXdE?=
 =?utf-8?B?bjFmS1pTM3lhZ3JUdElaUEF2T3Rmc09NM3VmakIwZFY2TjA0MWJaSC9BTWJF?=
 =?utf-8?B?UzdkNDBSV0w0QjhLa1pKVWdNTGZ1SUNteW83dS9KTUZvcHU0c3JpemhHekpT?=
 =?utf-8?B?MVU0K0dJYld5NVhQRnJ1S0lLWU5MRzhXUUxVZWJjbEpZaEVKQWd3K1pwSjQ5?=
 =?utf-8?B?VnpOakNQcWo5c2RKZzFzV3FHaDZKcit6ZDNBa0VZaGorU3Q0U0dIRWZ0SFcr?=
 =?utf-8?B?enYwZTRXRmJBaXR2RjVERlppbHQwclhxcjNkVzRWL0daa1BnNWdZVzR1MDlM?=
 =?utf-8?B?eWE3bi9qWk5kbHZpQ1Q4NlprU1NCbWVnVFRLakl4TXpoZUtxRlpMQktJR29q?=
 =?utf-8?B?NDJnNUNWWHN4enovZFo5T09QMkxHbi9sTi8yTmtyeld1N2dFdnVBSXZ1Tkla?=
 =?utf-8?B?VnBNRlJDZ3VTZ3V1a3VOeGlUeU85a3k3dXdLaUNHV0hza2N0R0ZnQ3dFTmsz?=
 =?utf-8?Q?MnbIu1E+P8DX6Pr21kBvkN8xv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb541d2-1c67-4f0a-aa15-08dd91197488
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 05:54:27.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHZ+mlvbFkU9z+F6XJ6RD/n0cGqWi+nrnz2SzUk62BIonKTDgfACWjTycLTdyyTqGK4yQmswFUqOV52XShtlPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715


On 5/10/25 02:03, Simon Horman wrote:
> On Thu, May 08, 2025 at 10:29:57AM +0530, Abhijit Gangurde wrote:
>> Add ionic to the kernel build environment.
>>
>> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>> ---
>>   .../ethernet/pensando/ionic_rdma.rst          | 43 +++++++++++++++++++
>>   MAINTAINERS                                   |  9 ++++
>>   drivers/infiniband/Kconfig                    |  1 +
>>   drivers/infiniband/hw/Makefile                |  1 +
>>   drivers/infiniband/hw/ionic/Kconfig           | 17 ++++++++
>>   drivers/infiniband/hw/ionic/Makefile          |  9 ++++
>>   6 files changed, 80 insertions(+)
>>   create mode 100644 Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
>>   create mode 100644 drivers/infiniband/hw/ionic/Kconfig
>>   create mode 100644 drivers/infiniband/hw/ionic/Makefile
>>
>> diff --git a/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst b/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
>> new file mode 100644
>> index 000000000000..80c4d9876d3e
>> --- /dev/null
>> +++ b/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
> Please add this new file to
> Documentation/networking/device_drivers/ethernet/index.rst
> (or some other index.rst).
>
> Flagged by make htmldocs
>
> ...
Thanks for pointing this. Will add the new file to
Documentation/networking/device_drivers/index.rst
in next spin.

Abhijit


