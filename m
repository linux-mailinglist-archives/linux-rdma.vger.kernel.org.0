Return-Path: <linux-rdma+bounces-19866-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJE/Kt5Z9mn2UAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19866-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 22:09:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A804B3660
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 22:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38E5300D6B7
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 20:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EE138B12E;
	Sat,  2 May 2026 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c739SUgb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62219327C1D;
	Sat,  2 May 2026 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752536; cv=fail; b=Sf+NfnG79ZqAdAtBJPV8Yh6uuZFlFivW9x7s23KuRG+BxpPhwBJWeqd3ZzxLm/f5lZcCwJxsSfe0vVmRVDxiL78GIsRFwgbColzpi2sulxVXr53utQfBlSoyNAbKKEe5spbsMji868933CBahAoAsdv2Qfx3nRzZwmbYGIcKUcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752536; c=relaxed/simple;
	bh=NhA1jd+jCetkxrCgu0Ac9bmjmHQpA65TMn1J8icIQVg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OZlnZJkR3IyxtDfr+faOcNRzGdBFenRG8Q5qOaXkUlkGtFIPHwSkKN9HQW/pYHVXURfGls9f2EzkC3QbAbQEW3hfwLl5HzTXs+cZDy9ZZ+hHXSlok/gWD/7hnUwOCNBDDvs/tTwV94F212woztYQyvcUdlKZa3EU0WKzyoCmuRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c739SUgb; arc=fail smtp.client-ip=40.93.196.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LA5GQ3sic3K4jTR9aFeYPOIAPmFXPzf5cIQ8axZELZ28CI5XUyj6y/nZ+Nah4JVyQZlpMitvx8pL/dldmPyIUqvCupeF6C4HY2GO/KIky9Fmzbki6cvmQZ0kOnBDSBiAYp4H8U66E7alRiXvVQPuj2ycN8ESzAAKaBm4Pc/Mcplx3JtxJNVZt956qN2lxbHwtRlhac1ZT5OYP9rldqtIf8D6X7SX4D1Znpx1EA7easP1PSARY0bUa72e8vPvqGEXaGR6MnCPDU+Pr2YW9PNr9ZG5lQRiGwa4acbt16Q4zn+U2x3GDdoqZinLCh4b3Tu6+kFrYhgwBepSOcK4+MHzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARwFGS3tp/flqjxR23xJJBU8Ssdl2qZ/VkZDWKCvOvQ=;
 b=xWfakVBqpQXnRvkzw3dmL9HOVu645iK0WtKQR5rseZ+RKE5r24h534FBh9B7HWK5yMuxuBIuHKuHanXoG5VA6hP6MMMm+mynE/lGbTPbGn3PJNPlneInxc/yrLHnbZI0jz1KUsF4ThmtLtwp/CVjodmvVS03l5mnO5+ZvGCpaOgpTqvC4vCkJBF8q9SbSK4dcZDJb0fJESdgaX0K9M0N9eA0NOuSoJk6o/hsFOFf3CrYHn9lBfD4O0LuYBqayebmfB3RtnV5m8W8NbiC0R8S6v9FP2A7yTN7stbddmRWhfDZM/+9NIZnti3IIDV53lT3yqgK11eLPYT+E17sXkxLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARwFGS3tp/flqjxR23xJJBU8Ssdl2qZ/VkZDWKCvOvQ=;
 b=c739SUgbVh9TPvGRe6N44QZbjDdwXXzdxvpCexUkZd9t6Irfrh42ozkymp6oY0RZfui1wbLHLdLKaRojgV4MYPB69h/oRf7ODeclm/4BEqFUMiD6t6ofunxcvbQqjYpnBXvOywBObakstPVNzE/wi3zazm2tA5Fx5lClZQXrddoq/cEwefGxUq69a0ZTrQphMAFnCUen05xWltAMHG/IWJl4t8CF3Zi0qnN6kquwpe4/9AmgR5apMiLIfzZolMy9VE/V1bP7MEgHt0d1uA3ZRbMTh91XhB2641AkW2DdFnMXiXeNBZXys7+vDfMxkyNcLTuI0yc2KWsZwp42Ro6iRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.24; Sat, 2 May
 2026 20:08:47 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Sat, 2 May 2026
 20:08:47 +0000
Message-ID: <421e8885-5849-4390-8956-9bc344fa0bf0@nvidia.com>
Date: Sat, 2 May 2026 23:08:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 7/7] net/mlx5: Add profile to auto-enable
 switchdev mode at device init
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Saeed Mahameed <saeedm@nvidia.com>, Shay Drory <shayd@nvidia.com>,
 Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 Maher Sanalla <msanalla@nvidia.com>, Simon Horman <horms@kernel.org>,
 Gerd Bayer <gbayer@linux.ibm.com>, Moshe Shemesh <moshe@nvidia.com>,
 Kees Cook <kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260501041633.231662-1-tariqt@nvidia.com>
 <20260501041633.231662-8-tariqt@nvidia.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260501041633.231662-8-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f4a65d-6342-48bf-3aed-08dea8869e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	60QpwlP1AZl/X62vn210A8gzGflRdgTxQ330WPuUAs3QPRSQveQuHyFUNrAWcz5VtMDD67pZG8/T1SaFPjXTsd84je0EfiimDsEDSUUCT9Cc8p1vGQbqrRhcVEZwxXxKcvSoJK7uEssTr1BWwLSDmn3k2Q6ifuYzftbgFHSiGu3L/ORDytW/2lclFMBZ83XiNr9QVDfnh6CdWHScpbvJy7tyFcNqZMRTIqtSeI7y/unn9bzeqWInpQ9QQ5S6IFZLBCqZUcNXON+9p6iSfyu/Z/maDDmSj4Q7tLOFPXy1JujGkSQvbSb1je0by3QFskzHnym1t+dEJTyaG196psuJKObmLx/s3cMTDc8S4ILCbEF7ok1keurG6LceYxmQNy52IJp7qKec8ww3av4hcglUFbqAXKiKR1jB+XgEG8r9zR4uzLhU8CRm8m9UJtJQMuPp9JkXIGGLrD4kra0bwMhhZtUChOUd4g3YUFOt6VyNRO1ppx2SNZV2eHAMfw81RVibWmmWdIEIfJPhtl5xYUr6LhgvRf30M7EkQicbBZNNq5rEmG9/FhJ5I9AreBfrjtsHfKOskYtUWz2hhoQjmS0FDCgRDM7J57hergAKbOtXkr+gSED9H009eHlGY22Cwwz3cT6rKQ1Y4IMr0HD+Zu3DJbUhrQPC0Fw0WNDcsjgp5dNBPYyhjsPrq0l89PVIeA1/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEU3bnVtRVJBV0s1bUtzYklCYkNteWQxY2ViREtQQUQwU2ZOUmUyL1NzODdB?=
 =?utf-8?B?Q3lVM3ZzN2s4Smx5WmRvSFZJZkxFK0x1QXRURWNGaXg1RWRQN29CWmE4WGJG?=
 =?utf-8?B?Z3RTeEo0Q2JtZ09MS2VkYkJQaGdiWEZHSEYxNm9QaHMzWFpxN0FyenB6ZHpV?=
 =?utf-8?B?RnFLSnZGS3BEM2FGdEdXVHhCOStaVTIwditWaFlEMVFEdXB3Q1FqaU9jZHpF?=
 =?utf-8?B?Y1ZzMWIwOG5sdFJWSGM4TXBjWXExYVVFcnZPZXJqc3ZqemNPKzg5WmdLb00z?=
 =?utf-8?B?b2lkNUs0L0xLdnFrcFdDZzdoMGYrZEtGenlMdUg2clpQbjhjZ1dLYmFnVCtr?=
 =?utf-8?B?TXY2S0k0TFdVR3FoVG9talkxNVhyN2JzWTFEZWtpd2JWbnJORnAzOXd2YUxC?=
 =?utf-8?B?bVprRWFqSE13aGRqWkxnWmRwL25ZMEdUWUp6OTdTcUlLQ2N2eTRud0tjTU5a?=
 =?utf-8?B?UlBrVUtHZW8vQTJjN3RjWTVjLzViUXN1RzZNeDhvSVlsNVluOGtTNzVtY3lp?=
 =?utf-8?B?V1pyTVFGakpKT3RMS1RZbkNENGV3b1Eyd21qL3NCbjNwL0ptN3M0OWlIZHlT?=
 =?utf-8?B?L2l2c2JFN0lyOEpXUldoS05hVmxGMEx2L01xdEE5QUxVV0JyYk5iTDB1cCtw?=
 =?utf-8?B?R3hHZjBMYmJ5ZHRuRFVVMFptMjRGZmJrU2YzeHZUcG1HT1N5aXdMenE0T0pE?=
 =?utf-8?B?NmdHZGNWdWVLM09rSWcxa1NGKzh1b1Bzb2l0MkRGRmdPbUxHeDcrbkRVZlV4?=
 =?utf-8?B?TkRBblhYckFOWVBwYjZ6TjRCdzcwTXNINmJRbGFYaWxVZ3Y0ME9mZUthekpn?=
 =?utf-8?B?NkU0aXh5a01yN2RFYnVxa0pZUFRwaDdxMVAwNEMyaEx0S2lmdHh5bHpaRHJT?=
 =?utf-8?B?clFYVS80RzFnUHZuM0t4TEx6clpuMnZQQllOUURPR1FtK1lUU3lhODVaclNJ?=
 =?utf-8?B?bEdpZlpKRkpRWjUySTNjVTJVVlZxcHVrK2g1Ry9rOVcxakVqL2p0M0JSK2xM?=
 =?utf-8?B?S3RtWlhBRG1VelFtT3UrZzRBZm1MT0VBYXk4TUFheSs4aFN5MUY1NjBYWXQv?=
 =?utf-8?B?V212WCtxc08vSVlNc1Q1ekU2QXBNN1dtQlp5WDMwMkFjcHRzWmV1RFRRZms1?=
 =?utf-8?B?cHZMcGpnMElyTXh2THAvY1dBRXVQcFFWYmk1cHlISGNzK2pvQlBKb004Mmwz?=
 =?utf-8?B?U1Z2dFgzMzRwUE9KdFRxT3F0UGI2NjdWZklneHI3VUdHQ3liUEdaN2VkUEdQ?=
 =?utf-8?B?WFgyLzErOG5NcXBKSVhvZXNzQjFPQ3JqUDBabkR1b3YxMUN1YVB5U1JhSVFJ?=
 =?utf-8?B?akxzVHdnZ3hEUjRwR1ZYS3l0b3M3S1pQN3hYazVCYTBPNjkxejBLaG15MVpw?=
 =?utf-8?B?ZlVWQzBDbFg2NGJRakJVbHJTOU4zYzAwMkNFQ2Zia2VRR3BaRW1CMHZnL2hq?=
 =?utf-8?B?SVFjYkJlVzNmK1NsbjZxRGV1Y3F6REtXL3o4WkREQ0tNYnJOU3ZsaVF0by9L?=
 =?utf-8?B?Vkt2amlsUnE4SGRxNzF6WnJaa0luZjBvNGFxaEFDUnFNWDFCaVpCRkl6clZN?=
 =?utf-8?B?bUZrMTBIbXo0S2RGNUZIMDYwUHF3WWhoSEFVckoweWp1ZTdyWnhBemhoOU9G?=
 =?utf-8?B?bTBHS0pEOXpUakxuT1hkZWtBT2o3OE1PbC9Zc3dWdFlBZUJQdHZQMDdkVWhs?=
 =?utf-8?B?M1pDNEEwMUpLWW9yNkpEQW8wS1NpcFAzczA3dXRlM1JISzlFalZBbTlLOFpH?=
 =?utf-8?B?dnZ5Yk9BK252SFlnOStlTUozNk5PeWV5enFCWmlkSkQvSE5kZTl0NWxUOU05?=
 =?utf-8?B?TVB5T1dxdE16ZHE1eHpiWVRod004aVZYSlVxdi9XTDRhWklMMjBlT2NUZ2ZL?=
 =?utf-8?B?Z3JONm9OZUdxb0Yzb2lEK3hPendZYldmNzJvYXlwQlhYYTk5WmI2QU5aTmR5?=
 =?utf-8?B?TjN2amZtSHJ6UU83bUNMbkFLOURIT0k2bHg2MEpUeUhrZi9NRVBsT2xBekpP?=
 =?utf-8?B?MHUxY1lVQnB5QU04TGFoUGMzMytHVWlLOHd6M1lzaWpacnc0c0l1Tk9jbDN6?=
 =?utf-8?B?YTVmcld2NTZIMkQ5eGNJTnhxZVhmcldPWU9od0ZQQ2dmaVBUYTR3SjYzVG95?=
 =?utf-8?B?cGN0bnJ3OURTNXNpb2hZWDVDUG5nN1FNb2hZaUx5bDVnQjd3WDZuTTMwVmVO?=
 =?utf-8?B?THRDejBhckJWSjZLeFc5Vk0xc0p0RFh5QjZQWmNxeG5EaTllTmVHcGZMQUNB?=
 =?utf-8?B?U2FHMnZaZEE0anZ3UE9tSFIwTHNueUp6TEwrZDR5WlFXRXBJcHRzaW9RbVdk?=
 =?utf-8?B?M2hCemJkU2xhQnlUL2ZlU1BZVUE5S0N4M0ZqdlBpL0RWRjZ3dGFZZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f4a65d-6342-48bf-3aed-08dea8869e54
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 20:08:47.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfDDkHiwbKTU1V7PJOU/djohQ1AuGTdkK9QcriIQWvbZ8FFVimYcgXCg/9asNNArJHBfoJj63RLELMZ14MEYUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
X-Rspamd-Queue-Id: 53A804B3660
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-19866-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On 01/05/2026 7:16, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> Deployments that always operate in switchdev mode currently require
> manual devlink configuration after driver probe, which complicates
> automated provisioning.
> 
> Introduce MLX5_PROF_MASK_DEF_SWITCHDEV, a new profile mask bit, and
> profile index 8. When a device is initialized or reloaded with this
> profile, the driver automatically switches the e-switch to switchdev
> mode by calling mlx5_devlink_eswitch_mode_set() immediately after
> bringing the device online.
> 
> A no-op stub of mlx5_devlink_eswitch_mode_set() is added for builds
> without CONFIG_MLX5_ESWITCH.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/eswitch.h |  6 +++
>  .../net/ethernet/mellanox/mlx5/core/main.c    | 43 ++++++++++++++++++-
>  include/linux/mlx5/driver.h                   |  2 +
>  3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index 3858690e09b4..cfb9595f9de8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -1049,6 +1049,12 @@ mlx5_esw_lag_demux_rule_create(struct mlx5_eswitch *esw, u16 vport_num,
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
>  
> +static inline int
> +mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
> +			      struct netlink_ext_ack *extack)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif /* CONFIG_MLX5_ESWITCH */
>  
>  #endif /* __MLX5_ESWITCH_H__ */
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index 74827e8ca125..4cdda15ed7f5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -86,7 +86,7 @@ MODULE_PARM_DESC(debug_mask, "debug mask: 1 = dump cmd data, 2 = dump cmd exec t
>  
>  static unsigned int prof_sel = MLX5_DEFAULT_PROF;
>  module_param_named(prof_sel, prof_sel, uint, 0444);
> -MODULE_PARM_DESC(prof_sel, "profile selector. Valid range 0 - 2");
> +MODULE_PARM_DESC(prof_sel, "profile selector. Valid range 0 - 3 and 8");

sashiko.dev says:
"
Does using a module parameter to configure e-switch mode bypass the standard
devlink uAPI? 
The networking subsystem typically standardizes this configuration via
netlink/devlink interfaces, and relying on a module parameter for this might
fragment automated provisioning workflows.
"

The target here is DPU side deployments where switchdev is the only valid
operating mode, and the goal is to boot directly into that mode instead
of relying on userspace scripts after probe. I agree devlink remains the
runtime uapi. This profile is only an opt-in transition step so we can
avoid forcing switchdev in code before users have a way to reject that behavior.
This does not replace devlink provisioning, it provides a DPU side default for
environments that explicitly choose this profile.


>  
>  static u32 sw_owner_id[4];
>  #define MAX_SW_VHCA_ID (BIT(__mlx5_bit_sz(cmd_hca_cap_2, sw_vhca_id)) - 1)
> @@ -99,6 +99,8 @@ enum {
>  
>  #define LOG_MAX_SUPPORTED_QPS 0xff
>  
> +#define MLX5_PROF_SEL_LAST_NIC 3
> +#define MLX5_PROF_SEL_FIRST_ESW 8
>  static struct mlx5_profile profile[] = {
>  	[0] = {
>  		.mask           = 0,
> @@ -120,6 +122,11 @@ static struct mlx5_profile profile[] = {
>  		.log_max_qp	= LOG_MAX_SUPPORTED_QPS,
>  		.num_cmd_caches = 0,
>  	},
> +	[8] = {
> +		.mask = MLX5_PROF_MASK_DEF_SWITCHDEV | MLX5_PROF_MASK_QP_SIZE,
> +		.log_max_qp = LOG_MAX_SUPPORTED_QPS,
> +		.num_cmd_caches = MLX5_NUM_COMMAND_CACHES,
> +	},
>  };
>  
>  static int wait_fw_init(struct mlx5_core_dev *dev, u32 max_wait_mili,
> @@ -1385,6 +1392,22 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>  	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>  }
>  
> +static void mlx5_set_default_switchdev(struct mlx5_core_dev *dev)
> +{
> +	int err;
> +
> +	/* Default switchdev is best-effort; keep the device usable on
> +	 * failure.
> +	 */
> +	err = mlx5_devlink_eswitch_mode_set(priv_to_devlink(dev),
> +					    DEVLINK_ESWITCH_MODE_SWITCHDEV,
> +					    NULL);
> +	if (err && err != -EOPNOTSUPP)
> +		mlx5_core_warn(dev,
> +			       "Failed to set switchdev as default, continuing in current mode, err(%d)\n",
> +			       err);
> +}
> +
>  int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>  {
>  	bool light_probe = mlx5_dev_is_lightweight(dev);
> @@ -1431,6 +1454,10 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>  		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
>  
>  	mutex_unlock(&dev->intf_state_mutex);
> +
> +	if (dev->profile.mask & MLX5_PROF_MASK_DEF_SWITCHDEV)
> +		mlx5_set_default_switchdev(dev);
> +
>  	return 0;

sashiko.dev says:
"
If a user explicitly sets the e-switch mode to legacy via devlink after
initialization, will this override their setting during driver reload or
firmware error recovery?
Since mlx5_set_default_switchdev() is called unconditionally here based on
the profile mask, it seems like it could silently revert the device back to
switchdev mode, discarding the active user configuration.
"

Yes, with this profile selected, switchdev is intentionally reapplied after
reload or recovery. A devlink change to legacy affects the current lifetime,
but the selected profile defines the default mode after the device is
reinitialized, users that want legacy to persist should not use this profile.

>  
>  err_register:
> @@ -1532,6 +1559,10 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
>  		goto err_attach;
>  
>  	mutex_unlock(&dev->intf_state_mutex);
> +
> +	if (dev->profile.mask & MLX5_PROF_MASK_DEF_SWITCHDEV)
> +		mlx5_set_default_switchdev(dev);
> +
>  	return 0;
>  
>  err_attach:
> @@ -2314,6 +2345,16 @@ static void mlx5_core_verify_params(void)
>  			MLX5_DEFAULT_PROF);
>  		prof_sel = MLX5_DEFAULT_PROF;
>  	}
> +
> +	if (prof_sel > MLX5_PROF_SEL_LAST_NIC &&
> +	    prof_sel < MLX5_PROF_SEL_FIRST_ESW) {
> +		pr_warn("mlx5_core: WARNING: Invalid module parameter prof_sel %d invalid range %d - %d, changing back to default (%d)\n",
> +			prof_sel,
> +			MLX5_PROF_SEL_LAST_NIC + 1,
> +			MLX5_PROF_SEL_FIRST_ESW - 1,
> +			MLX5_DEFAULT_PROF);
> +		prof_sel = MLX5_DEFAULT_PROF;
> +	}
>  }
>  
>  static int __init mlx5_init(void)
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index 04b96c5abb57..65298c07df4d 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -705,6 +705,8 @@ struct mlx5_st;
>  
>  enum {
>  	MLX5_PROF_MASK_QP_SIZE		= (u64)1 << 0,
> +	MLX5_PROF_MASK_MR_CACHE		= (u64)1 << 1,
> +	MLX5_PROF_MASK_DEF_SWITCHDEV    = (u64)1 << 2,
>  };

sashiko.dev says:
"
This isn't a bug, but it looks like MLX5_PROF_MASK_MR_CACHE is introduced
here but never used in the driver code. Is this mask intended for a future
patch?
"

Before I respin for the unrelated MR_CACHE cleanup, I’d like to confirm
whether the opt-in profile approach is acceptable at all. Regardless
of this last patch, the first 6 patches fix real representor/LAG locking
issues and are needed independently, so I’d like to keep those moving toward
acceptance as soon as possible.

Mark


>  
>  struct mlx5_profile {


