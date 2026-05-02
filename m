Return-Path: <linux-rdma+bounces-19864-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HKsC3NZ9mn2UAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19864-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 22:07:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 679D04B35CD
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 22:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA5AA300A7F4
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 20:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9B13876A0;
	Sat,  2 May 2026 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L0Nfwkfe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264D241139;
	Sat,  2 May 2026 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752427; cv=fail; b=XNif8QU7fEe+g6vwo7JY8JgtiTgR9BzPVc8c5FXq0cBnj4XVw0k/HVTWe8gt1hZLOqatG9xVo8axYP5hU1uIYYDt2R/5XS+a3E0nJknBHz5GTB2uQ971Sutr+GBG2CvAlLMMXxbN2oP5+MV6L2VyDLwoFS25yOVLPo+jEFp6f+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752427; c=relaxed/simple;
	bh=Rjvk2rcwX0dHTXB/iZCKeQwoM4dAjDE72tZ3dqRnVpU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ToVX0FeNT+e891NEufXzBi+Tci0FzswZ1tv7gXJ6GqOWL6337CiNYWOnEMs8+c3AfILYYi+qciXSeqN7h0W2eH3TltHG+oBqFcf3rML4EBs/K/n89ni56VCXlPIkrq5xVeHvMxzkvkdrU/UjHN2dZrfeLbRH10q1joqNJO5cUWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L0Nfwkfe; arc=fail smtp.client-ip=52.101.43.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bieo6ped1Do2mjV2PvU8Dv5aL1YsnwCst/oToYTeOIOgPWzHTqweV/3979jcqipHK0fk1+2Kip6H+cVjlZ7uFZH2I9C0GaO+I4h3WUMqlgma+Igi0/XRBBlKQ+r3eerrF+m5rV0yW/88V+fVmvFfWzxbM60LmJGEwRl9sfJMmnON1RYtkswwIXSKTWRaWS9/xePwVFo00o5EzB07iOpAFyms2tTHGUuXmZETspGp1y01mH9GWBW+aIyUycy1bqwORvQLk4EPSQewXOa5ZfgdOhNRgjxf8giWrj9ZSKlcWLdKO5/0SKbQNHBa0FN7ncoF2zB+VlRIMdFMswFNgI+EGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n40Y/oF+8qKY629PSkI7HWm2l5S9BvY7y1xMV6v4o5M=;
 b=foi875F5nXbGrTXXIDvYS9DXzVexi6/YBYFDYw3qIIME7+K+mPhfRF5PyR8d9oZI9Px/cJYaZPyAWzn/EXyf2CT7A2uV2jmLzYAAdqw4Drpgtqo5rWyQ01qwrqsscTzZeTRc+BRJTPdM+xM7ppf0tzMBo4gpP5A7J/BMhsLDJCmKndeEE9Ezyqs0wX1UB743gOzCUdpIMjU5jB6EfRps7pLRkRNNfqbKm/vN+IzPS4JmIPJI7GdVw+Dk+GnS+6wA6Pm3CONbIkmnJ47vvHiwc0g9/t0EiZMPs76N8NCS+pDWchgg2lmTO8q7/fz20Tsm+VYLi5B2XCK+jHnt//cppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n40Y/oF+8qKY629PSkI7HWm2l5S9BvY7y1xMV6v4o5M=;
 b=L0Nfwkfe024B2RsLh0htCtAsefrSz+rW+iBNKRg6u/jw57m0CalfThoowSFnJvkgSYx2rPSBqEydKAjbLbOuSqLpMnBxQb6Vf5Mzg07Ufs9BEKfpqPTrYsfdWGSIAXjNFay0qc6oHoETw3NDwcPCzpkOkThirI5bH9LnlBNULpCSEnNML0jF5JK5oxFqCXUZXLosSpDsN+kU6QkL8FQU/zx7UVkttkcPqh4IAc5owfTFrCF0pQbRCLa0yU+Hb5l1bZKS5mHyBji1v+cdg8Ip2qD6S7QhDYmhRp7PzBurw0xFrE49F6FE0nD4M2dbCIg5hq+DdBZDSp2KiF+y8sF7KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 20:07:03 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Sat, 2 May 2026
 20:07:03 +0000
Message-ID: <48dd34af-a9c4-435b-a22f-f1061a3616b2@nvidia.com>
Date: Sat, 2 May 2026 23:06:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 5/7] net/mlx5: E-Switch, unwind only newly
 loaded representor types
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
 <20260501041633.231662-6-tariqt@nvidia.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260501041633.231662-6-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e157396-575f-4a5c-bdb7-08dea8866061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PfRkO4tWE/RUm5MEouGLI+8/2EG30/ZwVoLY/Mv8Su6ZU4mgfn966D03vDv4MY8VjI61XUhvttpiAq+JyzdOt8yVdlcEFPV4DtozsWVsia/iuN48/SMuXiD67hUzJDmc6TWxuh/jYfy7lBW6SKGd3P6iloFAilGvtRbVFi9RiEyOsV3UzX5nBf/gAUNyFw+YoBfqsgvUrXIJpAeepBuXcE9NAzvZlRzVBeycFAuSI5lasBGIPq6rIA8YcFxjJLPIz0rUPIRHeUga9jjOer321KpHKki1kpdcjYBbX+U+bSYuvGeEg5eBKzDt1BalGpYpC0NDmfozxEA03PtmH7/8jLhT0aTLbnbOKuZwZ5Oxhkh41G+RPBc0L8EpAf/+FVerQBrFf5R+jw6na9VzfMIgtH7tJPM3ZMmPPWP34AZzOnb8jQnZu47FH3pptcqieHcurtHBvOZJ144HopQbAtF3E7szb/DuLfnBc6ufyoN7P0HNNyUZbfp054aCU7kNwrOlkmt/Z21U7lIWfxyELgNE3EB7GuSzVNcL5/i5dz4fhmvpziqn0x60Pr2M/SmaWdM200N/xTx9yVk88g52yKgxOIedt/7Y5FxDAyZOZm91Q9JCEV3VfTJfNZ46y7Kswluv7aPHnvFwTipH5vNxrSz9LwJwMcqZ9N6+GPeyA3vR7KDejgaRmDKMBnwsSwXzBJTB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2krc0FYMTBEN2RiUkVFSjk3SW1FUFZKejdQdVlwVTBjUTBtSzNRNmh0YlAw?=
 =?utf-8?B?bkVaWHk4NTVkVmFqaVhXczZmUnFMcWtTY3F6N2FWemdPbW9qM0o1c2l2dFJS?=
 =?utf-8?B?eUM0SHVuSFYzQk9DK09DR05YZG1ydWtINkZCT21JNnJYVHU2MkJTYjJnZ2Y1?=
 =?utf-8?B?ZGZibEtEQUxYWWNxeVd0OVFGTzE1MkdnamZsd014cnF4YTVjSEMvUXVPN09K?=
 =?utf-8?B?UmFPUkpSYmJvVGttRmwwQUdSUFNYaVJ1SXBDM0R5OUllUUdDZ1RuOXd1VUVH?=
 =?utf-8?B?N3JkV1cxTlNuZ1FXakxCaGt5YTV2bEhuWUxXOG9MWE9lU1A4TU9LeDV3M1hH?=
 =?utf-8?B?WVZ1K2lKSEhKS2xWMnpUMUl4L3BOcjlHaWtraVhSZ1U0SGVsbng2VnB5VzRr?=
 =?utf-8?B?RUpFcmU4WXFzUWthaklicFdybTA0SXFDWVNUT2VDSlpkSkFxR3hqanozdll5?=
 =?utf-8?B?MlU1U1ZoUnp6dThpQ0pkTEsyM3ZvR2NoQUhNaWhEQkR5YXpHQnFWRFh6clNF?=
 =?utf-8?B?T0VBSHV4Z09WUlErYmJZZ2laYWo3VSt1dGZReUZ3Zk9QSElEYnlad09JUHNM?=
 =?utf-8?B?SzdXcnBoS1hkQlc4akVveWQwZG9mcms4bnRZVEwvREZsY0liL1FVekpBSkVs?=
 =?utf-8?B?NlhrRSs5U0tmUnVOUGp1ZjdUdWpXVHgvQ0xVQ21FZGZtbmJ3WldrUlIvejY4?=
 =?utf-8?B?K0FtUzRtQjdlbGQycktPTnB5dFBwVWp3L2FJN01FR3pRUHJselVSMTBYVG0y?=
 =?utf-8?B?bC8wU3F6Wjc1L2tJR3FYbXFGMTJaV0tsUEpXZFZOeUl6L2ZRWXBhQy9BeHh5?=
 =?utf-8?B?S2U3NGc2OVFFckFFTnNHZDVCeS9zblBabVBmQXl5alh2RzI4bERaRDFWdjV3?=
 =?utf-8?B?dGY3UzFvNDZZRmNsb2RmS0l5RGxZWlJ1VExUTmFRQjFFdFhVd2JTcjJ0dkNv?=
 =?utf-8?B?NGRONXVWTFRZQmhqb2RYWFU0eVk5Vnh4OUFPS0pEUzVFaTBwVG1QdDdXU0pG?=
 =?utf-8?B?ck4vb2crdlZ6cUtWdWcrRzd1ZVU0WStCTE5wYkRxUGYyYmlZaFFkTTkyYWZB?=
 =?utf-8?B?Y3k0cTA1ZnM4UzFUTjdiZlZ3ZXlPNXZtZm9aVWJkNXpXVHdvRUlDL3ZlUjhm?=
 =?utf-8?B?S1dteFRvNEtlQlFlR0hYU2N0ekF5UnovYnZlekVIN21XRVB1REpseXJkN1JQ?=
 =?utf-8?B?MW90aE5nMGZlYUxWbjRXYS9sQXJmSWNaMXdGSEhOdDNlMy91M1pzUFZMUElB?=
 =?utf-8?B?L3JvVnl5TU5yb2dXdWw3b21aM3hKdTVIZ0R4bWRrd0ZhUFdvc3JXTXV3Z2xh?=
 =?utf-8?B?bkJYUkxoMTdRVDhkMVdUSW43cTM3TjVWeTAxQ3hUdExUQjV4WTdCNVFuMjBH?=
 =?utf-8?B?YzhwamtxVWhtbmkxUEk3TXFyN3dZWWNlVXd5aW9WNUJkdktlYjNmWG5YMmlY?=
 =?utf-8?B?cTlINVNwQjNXSTB4dys3WjhtL1g1UVhlKzJHT1dLWnl2NVJDd3ZzTlhwQUNa?=
 =?utf-8?B?eFN5Rk1kMy8vOGZOL0dXb1NEZGhGN2pDYmExQWJpY29NU0QxcEtoVTc0T3Rx?=
 =?utf-8?B?aWtlaWFOazhWcytzQ1FVd1hkZWdNVzlyNEFqWkZ0U05NSjBadnJXdTFLKzZ1?=
 =?utf-8?B?RE50eGV5VElHeVMwaVR6a2tpc3c0VEd4aG1UaFNaVVFCNjN0VWJxTVcrUDZr?=
 =?utf-8?B?U3FOdys5bDNFcnExSitnYTBDaHdSQUtJSzl6WEFsVjcvbzRYNVBuaUt3YnI5?=
 =?utf-8?B?Q1dDQ3RzbzNNSEFsUHdqNkZuTjl1aG1XT0hhK040Y0FYSmdWUTZSZkUvWWtm?=
 =?utf-8?B?bWpoU3dBaGZGbTF5Nmd1dVZjUmxYNFYreW0zMDZEVmhpcXd1OVFnc2VwUjlE?=
 =?utf-8?B?THZHdzExVlBQVzkxY1ltUEJtQmhzRFpyYk0zUmRTWTZ6UitXTEpPNW5ZdENh?=
 =?utf-8?B?WEcwSTJJMDRjcExtN3FtNktZSkx1elZrRVM0Q2ZEOUdjQTkzZ2FoMk51RnE3?=
 =?utf-8?B?MjliZjhzaCtiUmNqQTZXdVBRbzZ4UEpvc0ZMb2tFb3F5QmY1RFlkVk82R1Zz?=
 =?utf-8?B?K0lsMExiamJoM1VPSTgrYkFoYm9SanU0SXVwTnBFd0dpT21IUnl3T0t0ZHFl?=
 =?utf-8?B?RGJBZ2NwRG8zMnVGVzZsY25rNEUvdFA2TWRFYXBUSlAyM1Y3Tiswb3RSS0lY?=
 =?utf-8?B?SGJTdzZsVXhxbE1ocENyQngvZVgxU2NKbTlEODRCNGJTcGp2dGZKbjRaWWgx?=
 =?utf-8?B?OGhGOEhONG1Na1c0UG50QTZDVlpGbWUwaVBsQTFkZlpVN0JkZ2JOV1U2NnRN?=
 =?utf-8?B?UElpOVhuNTJrUjI4Y01wSVlCVXRFb2dQQUlwTGdsTnVMZ2VOUFNTQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e157396-575f-4a5c-bdb7-08dea8866061
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 20:07:03.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZ0eciKOpr9LzbpdMVcpkT1nznTezK+WmNtN1h4flk21CgkqCbzqsvtI5OQldfZ5zfDf02r2t6IL4Sk5jI6qYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055
X-Rspamd-Queue-Id: 679D04B35CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-19864-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]



On 01/05/2026 7:16, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> __esw_offloads_load_rep() may return success without invoking the
> representor load callback when the representor type is already loaded.
> 
> On a later load failure, mlx5_esw_offloads_rep_load() unconditionally
> unloaded all previously iterated representor types. This could unload
> representor types that were already loaded before this load attempt.
> 
> Track which representor types were actually loaded by the current call and
> unwind only those on error. Also restore the representor state back to
> REP_REGISTERED when the load callback itself fails.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

sashiko.dev says:
"
Note: Due to recitation restrictions, the standard inline patch quoting format
has been altered to a free-form summary.
commit ca89c8e618c910a6810fe7127853404ce151ae6b
Author: Mark Bloch <mbloch@nvidia.com>
net/mlx5: E-Switch, unwind only newly loaded representor types
This commit updates the representor load error handling to track which
representor types were actually loaded by the current call and unwind only
those on error. It also restores the state to REP_REGISTERED if the load
callback fails.
In the modified __esw_offloads_load_rep() function, the representor state
is set to REP_LOADED via atomic_cmpxchg() before the actual load() callback
is invoked. Does this sequence expose a race condition with lockless readers?
If lockless readers, such as mlx5_eswitch_get_proto_dev() or
mlx5_esw_ipsec_restore_dest_uplink(), check the state and observe REP_LOADED
while the load callback is still executing, can they access uninitialized
private data resulting in a NULL pointer dereference?
Additionally, if the load() callback subsequently fails and frees the
allocated private data, could a lockless reader that already observed the
"

The REP_LOADED before load() ordering is pre-existing and orthogonal
to this unwind fix. I’ll look into it and if needed address it in
a separate patch.

Mark


>  .../mellanox/mlx5/core/eswitch_offloads.c     | 38 ++++++++++++++-----
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index d4ac07c995b9..8f656253981b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -2786,13 +2786,28 @@ void esw_offloads_cleanup(struct mlx5_eswitch *esw)
>  }
>  
>  static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
> -				   struct mlx5_eswitch_rep *rep, u8 rep_type)
> +				   struct mlx5_eswitch_rep *rep,
> +				   u8 rep_type, bool *newly_loaded)
>  {
> +	int err;
> +
>  	mlx5_esw_assert_reps_locked(esw);
>  
> +	if (newly_loaded)
> +		*newly_loaded = false;
> +
>  	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
> -			   REP_REGISTERED, REP_LOADED) == REP_REGISTERED)
> -		return esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
> +			   REP_REGISTERED, REP_LOADED) != REP_REGISTERED)
> +		return 0;
> +
> +	err = esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
> +	if (err) {
> +		atomic_set(&rep->rep_data[rep_type].state, REP_REGISTERED);
> +		return err;
> +	}
> +
> +	if (newly_loaded)
> +		*newly_loaded = true;
>  
>  	return 0;
>  }
> @@ -2822,22 +2837,27 @@ static void __unload_reps_all_vport(struct mlx5_eswitch *esw, u8 rep_type)
>  static int mlx5_esw_offloads_rep_load(struct mlx5_eswitch *esw, u16 vport_num)
>  {
>  	struct mlx5_eswitch_rep *rep;
> +	unsigned long loaded = 0;
> +	bool newly_loaded;
>  	int rep_type;
>  	int err;
>  
>  	rep = mlx5_eswitch_get_rep(esw, vport_num);
>  	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++) {
> -		err = __esw_offloads_load_rep(esw, rep, rep_type);
> +		err = __esw_offloads_load_rep(esw, rep, rep_type,
> +					      &newly_loaded);
>  		if (err)
>  			goto err_reps;
> +		if (newly_loaded)
> +			loaded |= BIT(rep_type);
>  	}
>  
>  	return 0;
>  
>  err_reps:
> -	atomic_set(&rep->rep_data[rep_type].state, REP_REGISTERED);
> -	for (--rep_type; rep_type >= 0; rep_type--)
> -		__esw_offloads_unload_rep(esw, rep, rep_type);
> +	while (--rep_type >= 0)
> +		if (test_bit(rep_type, &loaded))
> +			__esw_offloads_unload_rep(esw, rep, rep_type);
>  	return err;
>  }
>  
> @@ -3591,13 +3611,13 @@ int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
>  	if (atomic_read(&rep->rep_data[REP_ETH].state) != REP_LOADED)
>  		return 0;
>  
> -	ret = __esw_offloads_load_rep(esw, rep, REP_IB);
> +	ret = __esw_offloads_load_rep(esw, rep, REP_IB, NULL);
>  	if (ret)
>  		return ret;
>  
>  	mlx5_esw_for_each_rep(esw, i, rep) {
>  		if (atomic_read(&rep->rep_data[REP_ETH].state) == REP_LOADED)
> -			__esw_offloads_load_rep(esw, rep, REP_IB);
> +			__esw_offloads_load_rep(esw, rep, REP_IB, NULL);
>  	}
>  
>  	return 0;


