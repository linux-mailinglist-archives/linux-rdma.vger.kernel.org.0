Return-Path: <linux-rdma+bounces-19065-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCSLATYP1GkbqgcAu9opvQ
	(envelope-from <linux-rdma+bounces-19065-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 21:53:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060D3A6CC8
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 21:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76639303F060
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 19:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9802C1595;
	Mon,  6 Apr 2026 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nwt4GYdq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2A35294E;
	Mon,  6 Apr 2026 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775505166; cv=fail; b=u9nfj1z/JdKyQwkvFdbZzV0M4bUJ70o9uIReNCRU+/leGY0ZqVfenI9bn728FT+u7UkGpyncjzGG6Ncg0GIwv28/5hQhAgx9PAM1XHcIv2+4APLgCkVXQEmGVyCnD0eaGB3IjFL8CfYjnUEgtciX/6py2vNxkW/9YEFTjzl+JvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775505166; c=relaxed/simple;
	bh=gQOkteMPNthBJWvm0sUDJOmzyK5dUmBfA4TisBBZleM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rZAsQSuE43fZrZ+J+ofv5T+k13SGyDkN36uD6oIa9oVMW3/otVAUJJWrAzr28NQkg5rkDZ8VP8Hi30dCWM6thW1rSrWoqgCEOkcg+cd+6IwrkhzFTVdcz53+XgQfpyoivvmJ6EWnSem2Pn0lnhBk697laUGiNgUFTZi+TAYToxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nwt4GYdq; arc=fail smtp.client-ip=40.107.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxS7JTZKCXTO/Y4GMjsD1+hXDT1tELwo0B7CWP9tqekh5siDehxIAppPaaOWfFDUTqgucA2CCIPBdGZQ2IJ294A16JlCDyC4HZeTV3CRHcl9Ny7HBq1TZmd7+deeBhMWZDVPhhrfIJoHw3xonDgtxcNzkar1mU9hRXCcSmwoFva3Tzj0VjcAHnzzDMyJA3Atri1sZhBxT2Rjv/TswpuRKWyPsrteV0EtrHd7yUJLLRIKfCR5lhCTSJTiDws2mMaJ4eqhYae6ZEMqLu/ZGftoL2G4lnlLJTCnFPLnNd+q3sNeDR5Du6+72XEYy+XuYrUUhq/TcyReHKlZE78dDXB82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hr9s6tTXfAv806B6WNz1EnGJScKVk36fcg15nsTg54I=;
 b=MhZ8gcvsz/rP6C/34wPBA2gkeL1fqK8xSD8KkFjVkYqf/2WAQUpxBRXrk//EQgyJhsV1jixiqYbfFVZeDW6VHnmh0jNRFybY/V4TCCL0z+khGQ5T42/hrRxPyhSE4P27Dvd+89oYFPnkx0cLAeyXmtZn6kTxQPE5oQ4kdnFcavvfS3iNblmjfg0qhPf9j8qOabIcgbDxW6oni5ABF3vBf/bx8u1s6/S0oa4/JcL7+XYVxbhwAoThImzZkS0zQAM+61gjW90+YJLb7zgyADKwq4onp0Il0pA4EUY9kYgjWc1g8c3BRc/3jNNvAPoFz0NqFoVERM/wt159fgdXn2Y05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hr9s6tTXfAv806B6WNz1EnGJScKVk36fcg15nsTg54I=;
 b=nwt4GYdq//e3VxDFudPHsVjTu3Ez6R8BtuWow1opf88M8a/q9pbK+mehahHjT59NTIRy8dGUCDPnlcFG6lThwFS3lY2e+vfKZxCTgH/ShGZruEhU7pj+vuS/9Y5idgFEkQMcTTR94cuCvAAmq7tSFZ7HKoE5uPPXEHNrft02tStixSx1hXQEItZetcW3qTJAykZ9XthRYRSQ5Q4fPOXYuBblRbnOwPTQdQdZAeP4NnBsk7Xko8iDWf91uorxjzXLyr//Cg8uRKnlpN6G+6d2vvZu7SMio39ho/KaH4NdCJTza0oN0yLMlGmZkMVlG/DKWVpjJeV4uIpjeS3pyKg5Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 6 Apr
 2026 19:52:37 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 19:52:36 +0000
Message-ID: <7b56b919-f119-4d52-97ab-dbc8872c2ec9@nvidia.com>
Date: Mon, 6 Apr 2026 22:52:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 4/5] net/mlx5e: XDP, Use a single linear page
 per rq
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Cosmin Ratiu <cratiu@nvidia.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Lama Kayal <lkayal@nvidia.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Carolina Jubran <cjubran@nvidia.com>, Nathan Chancellor <nathan@kernel.org>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>
References: <20260403090927.139042-1-tariqt@nvidia.com>
 <20260403090927.139042-5-tariqt@nvidia.com> <adH5yAsPJ8rNgT0k@x13>
 <20260406084344.5d315f01@kernel.org>
 <e0ac9755-fd49-4620-92ce-0f5e4203a95e@nvidia.com>
 <d7c247276e39d88e1cd9d86e21c74779@tipi-net.de>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <d7c247276e39d88e1cd9d86e21c74779@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f36124d-68cc-49d4-dec4-08de94160d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BvJntVw+ABtyX8zEZGOfjwO2a4gyYa0D0bBNjkjZfksYoPVe4J/4YXfrT/A69dn3KGSN49zJ7S538q1dSr2DQd/ch4W6fboNso0ws5WfjEwuxZmJUZAJp79m6wlxPjjM7UVOjWk1ZZQ6XQxAnAczHHoe/YD+Xuzv7Dqy1W8reQ5jK1enciw8wytoGiSygWGsuV6oEpvRE5fegeCtvDCVfL1WwM06YOMbcaZYl4nmd0YdzuQ09/fPuQecFVvm6bv2MaUD/UmppuEO1DSKMa79JgwRbvRcjDsh6gAg5EI+0m0S48N0Zw476oqd4LB2cKpCjghMg5UAEj1Zse07tu99goV1cozeRcNAa/KStqs/20sTVnpJ5r8eH09K1fHZFUm5myCpfMtlACOPSP8POKneHDoD/rRiAPG99RWocNYEvg43usU1qGBskSglCPgHcL7WY8i8GsYve/oV7Yw+gI8zbM0Tz96AR3P0OHdkfnA1+1aOLBLqfeTrO31fL7wlBe8A/7qXLbrJWbXDAf+IixFKRgIfI9DG8Ssu8TzMZb92TRbfGrd5scn11xgiBsFeg4QUnerbQKKqDe8gEI5KKlF9F7+exnpZi4tVk4YuQ3Gq8UzG1RGnbrVVOjstxXUJantJr+O2xMKJIp4OhJZaeufaibBoVi8WD4obBeQXNqfbQTfhKa/jVMwWOGlwjbQoDnyTt+8w3jvJvplOp/3KjodonJMGUHDaFkXTQMWsWEJpAVQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1pQZUluUFJFblcwSkdBR0Y5R3NnK1FHaFI1aEUyeE82cVBKNGhkUkVWdFhy?=
 =?utf-8?B?eFpHRktlWDJReldobC9mdDF5MTNpNUl3N3hFaFlFL1hXR1N0S01nc0lBQmxP?=
 =?utf-8?B?eW1IS1J0VzRQRWtkQjF6VXJnZ0haT1YyU0I2TGl4M3hSeUw4MDhoc1ZWZWtB?=
 =?utf-8?B?T0p3bnMzYTR0RTFKNi9Ka2NMWHUvQml5VEJMVk5GeTZmenphVXZ6amZxSnR5?=
 =?utf-8?B?WlBXc3ZJcFByQ1JzVzNQVm1QU3RNYWJjUk1BU3o0T0lMQUZncCsveXFKVmRl?=
 =?utf-8?B?UUd4ZUpEUUZvQ04vZkFpcldNVWQ1YmJHNjZwb2dJaUxyUDl3K3JMVkcvRzlT?=
 =?utf-8?B?MDJ4ZmdEcUpzYndncFJHZjhiSi9SWXpzbEZkTCt5SDVnS2Fsd3RhYzJIdG5V?=
 =?utf-8?B?R2JtaklBZWNtZVVrY0pKMTlGeHlSL2ZkRGRjUWJGV3k3TDVJc0J0OHlNWGZE?=
 =?utf-8?B?a3NycVlNajcyV1ZiMG5oR3MxUTdxeVkrMzNCSjhhaUpXSGJoaHpqWkJVQ2Rv?=
 =?utf-8?B?RVhuRkdqWm04NlJSMlZhMTR4SytQQURPYnNvcEFwS3N3a3Z3cUNCaW9qYUhR?=
 =?utf-8?B?eWRWaFgwcG1BUlVpQ2dDMlIzMUJKWGlaL3FCcVRhQk51c2JncjUvTFZ1ekxs?=
 =?utf-8?B?aUJ4LzBGeWRMZFBTOHA1N05GdGpFYjFZTWJWcWh4Y2loaEU2U3VISXVxcFc3?=
 =?utf-8?B?UG4wU1dMTVBScXBORC84bktJQUFHdktYaTAyUkNqUDR0dWYwQkNoYkI2RHQ0?=
 =?utf-8?B?M0RkNEJEWnBDUlhmNURWTHlyQmkwUFBQRHM2cTZIRTR3c3llTWg1TmljT3F4?=
 =?utf-8?B?NDIwWGpZWHpPNUZKM1B0MzN4RTl2cjU4RGZ2eEsxVDdWVGRHQ0dIY3FjUGR6?=
 =?utf-8?B?NWZHMXZMVDJvMjdqT3lVVmtndjg2SVJlaW44eGxLS0w4TzlUYmE2YmQ2T0tL?=
 =?utf-8?B?QlFiTWFlOThBYktOZ0pSUmFkOWllUVB6RkZGRmJ4cmMzR2JQTTY5d2I0ZTc4?=
 =?utf-8?B?dzBwd3FaVk51NTVBRzZiRm04ai9OaFUxdTNNejhvcTc0cW5ST1Q3cm43UTh5?=
 =?utf-8?B?OHJ5MHRmQ0hETCtEUHcyOHZyR0ZSZWVnNkhoaXdEL0kzZFhjeGJObUsrcXZ2?=
 =?utf-8?B?Yyt4MEgvbnJPSStVVEljSExuMTZOa3BaYlBYYWlnZUo2Y09uaXhoS211S3Ey?=
 =?utf-8?B?MGpxOSsrRnpGYjRnN3pMUjduWWVpSHpqOW9hS1kxTC8yamRtd1pwZVlTczJV?=
 =?utf-8?B?M0xRRE96RVlFZkRvVWRWS0E0RjJ6SmdGcjhnRTAvdmt5MmRzMnlsbjgvZTlF?=
 =?utf-8?B?VTA1RXJQL2Rqd0p0elVxV3dVNzVtOURKQkN2NjlGeTdkMXFTdXRmTTBwWG5z?=
 =?utf-8?B?ZzdSU01iTHlhVEJla3hmRUdNc0kra29aUlI0WGNpb0JxOHBLRkthK01ZSkVo?=
 =?utf-8?B?M0V2UzJiYWlHVExLaGtYL2cvQzFaTWRXVlU3K3l4MnlxNWtpNE1HSU1VeGxM?=
 =?utf-8?B?T25ZS1AzM1VlV0VHc0dWNGtZczEzc3lITXEwUmdjRnZodTZsV05PWlF2cDdh?=
 =?utf-8?B?RmxlZEhGSjgxMld1ODJjZjRadW5OcEpycEVnazUyMkVNRzZpU1JsMnU4ZVUz?=
 =?utf-8?B?QkxKaHBhclNKVHFabVUrcmk2d05uTHBTREFGazI2RDBMNXYvOHVBMk1jNjRs?=
 =?utf-8?B?UUVPc3VSajBLZ3B5MmkrTU0wQmVaUVQyZjRNQzU4UDVzUDdiN1FMYUoyOXQw?=
 =?utf-8?B?Z2sybk5malVVRE9acnVlbWtFQ0trMW92VWZhMTdoWU5lU0w0bTB0ZFBuWGRt?=
 =?utf-8?B?NWc2YjhTc3FTaGl6T0NTMlFPS3FBT09saytKQ0JoZ2s3bjF3UzZ2ZThFMStK?=
 =?utf-8?B?S1NQU01VSWx1RzR3dnFWZjVQOHl6WENMT2RjMDhBdE5id040aUNnU1FSSTcr?=
 =?utf-8?B?LzlwbkxrckF2bHpSaldPVUFsVUlqYlNBK3Y0cDd4MlRrNk5FZXRFM3oyaThU?=
 =?utf-8?B?VVIwZThMQVMzemNqWEJWNkJDY3ArUzZxdVBQNUxFWW1KNnZMRGlRTTdnYmJE?=
 =?utf-8?B?RkExdnJNVjg1bUlrMjhBclR6Nlp2bnF0Uld2UDJaWm5TL3E3SHY5VUVoaVNU?=
 =?utf-8?B?cFVuV3hGbjFxNkxmeXZ3WWZkT2E2SjJKemkwTUpQbDZaQWR1ZVlLaXRyT0FQ?=
 =?utf-8?B?aWJPUFNhQmVRbmNpVDM5ZkxHWTl6bCtNMHpwazdSRTBVbzZWZFBvNmozRGJ4?=
 =?utf-8?B?aG1VdnozYWcweExJemhobFY0MnhIa0dYTUR6M0IvSlBETCt1UHg4b2VxWUQw?=
 =?utf-8?B?UVlDRlVYdVI2Tm40S3lEWnJkdCtJQ25mQUJiMXRsR0RnVDlPOXl1Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f36124d-68cc-49d4-dec4-08de94160d3e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 19:52:36.7052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8B1rBxBnyjrRhe/GSkULBV+PvJUyuoDDXOZaY2XG+s0atMNTHQcbVmHJ7Pqhn1fDDN0KOkFQyrFXWhphtvHMtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19065-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,iogearbox.net,gmail.com,fomichev.me,intel.com,linux.intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 9060D3A6CC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 06/04/2026 22:13, Nicolai Buchwitz wrote:
> On 6.4.2026 18:31, Mark Bloch wrote:
>> On 06/04/2026 18:43, Jakub Kicinski wrote:
>>> On Sun, 5 Apr 2026 08:08:06 +0200 Dragos Tatulea wrote:
>>>> sashiko says:
>>>
>>> Thanks a lot for reviewing the review! It takes a lot of maintainer time
> 
>> [...]
> 
>>
>> For example:
>>
>> “Before posting, authors could run a recommended baseline of review tools,
>> where available, to catch obvious issues early. During review, tools such
>> as review-prompts and Sashiko may be used to assist the reviewer.”
>>
> 
> There is already https://netdev-ai.bots.linux.dev/ai-local.html which I found really helpful.
Yes, I’m aware of that page, and it’s definitely useful.

The reason I brought this up is that recently, with the rise of sashiko usage, Jakub has
also started pointing out comments coming from it during review, while sashiko itself is
not mentioned anywhere in the official netdev documentation.

Mark

> If this is still the preferred approach, I could draft a patch to add it to Documentation/process/maintainer-netdev.rst
> 
>> Mark
> 
> Thanks
> Nicolai


