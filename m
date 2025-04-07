Return-Path: <linux-rdma+bounces-9204-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8746EA7E973
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9462B1897755
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D65A219302;
	Mon,  7 Apr 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sW8X1xVv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E5B179A7;
	Mon,  7 Apr 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049278; cv=fail; b=OmN8+tJLt0QkPv3LejVjsV0lo4oIq5ixi63ZYai8UgQNEoXVL/6lefcpDg0Pvpa+lIr/plv4DRGrx2c2KhRtmJHIrhEsdVFIFaApoRyCjykH3ClIFZBYQQWFAurJOw0hv9rh6t+zBit3RX9SDROOGXFOQATNgq93SqBpMQ0nPVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049278; c=relaxed/simple;
	bh=Mh4dwUQVa2iFsCff8JA+T3g+TiaztQGnQ1If/ihNZxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XgdQd/SsEy2SNo/nYQV8GZI/cr9rSSniS64oOLqqhkKSYsNoJFLQVQVwRMsXUgclN/OwjbNRHdcs4idgJc7Wx9BsGop4QCr5972DmMbkjpSuXTVNv6hiC10w3zy0Tlp3T4B+/ay/rJKHudgqc9Ha/Pdv19v4Ur4tt0c0TYWPm60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sW8X1xVv; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HM2RXFJNZNnaPiCucx65jbQ5ypToeXh1wf3qjWAN9laDCp4SLbb0XoR2AU7ydu6kzbiiK+xXJcHRRToO+WJ+000UgBYvR4gdqPIybDLw+9plVnPtmmKSPXS9FSsDb78rqMQdzZPH4qZOPMiEJadr7+etKExyqlvzD+Xg9vq7Bk2uJX3JQFYlm0VSLcdq60JZcvrK3XUKkn5ZSHdMYZ+4cI9nOjIi7u1V366PqIK2Ec3SLXYhWcvIIdTiZikuJ23hpumQZNVVNIJDIAvxOGDwHlXg6J9mhbgLRQnLkp0fyEDrO2us49IXDdYifUoEaTKiLeCthQCuZ8o1B/uI4PN9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHA9rELujfcneczkzi68DN+MAZNopkCmjMcvYTiyuTY=;
 b=cQ7AItFws1jkmmjj20cfnsU7yG3AhmEkMOVEhaQz6gD9JyVjQj7J8lfv0/AtrjslhZvquIDAIhlrc1srsbrj6XC0Y0CJA/2XmRHEqbL6tIzmTMtZ1tiK2tyZF/Z0YWMjzRQJBrJsSLcXeNPfVbfNbJF/HEa0canN/izNZAwnWIN7SkYkMP+Jp86I4N+SNY3JZ/zSOF0ROf6t7YCVOpN1UpsRSYnShuW0RxtspVaziiSltkJhQW/fO9/SWfVss01FKx4cs5qZSYy0P1fxpP2dL0iSvJ6wfHIZn3I1fqjHtFG37Qhdeecn21452uQE/Ac6XrTrFdN8ENnMdUfGV0Db7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHA9rELujfcneczkzi68DN+MAZNopkCmjMcvYTiyuTY=;
 b=sW8X1xVvI1h2UtYXcVg77Y7CuVS0WjaXVTnSAAwukfLxw72n7b9JTZtkr9c8juW6FlLvqZq84SUfVNS4wfpBJKGZAB9w2l0zss94gD8f4Mxni4i1PF204/VhW3dcwotG0LkQBpMd+RcjUHn9hXNxhPDkCMnNooHl44dVQCTQNN11ZHglsRoKmYx+x8T986p8477CRrbtwswjC4uWzeHeS1crUyv4xftOi2owYgW18qzs9m+kKEPq6GIdAtynX3xNPhi8kPQpmcKHocaxqePgolvQjUh6DjW3QuREx87jLeSVY8nRCB6DzggsTz21BsigoizZHQbVoJopbAEbA7VmEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 18:07:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 18:07:54 +0000
Date: Mon, 7 Apr 2025 15:07:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Use secs_to_jiffies() instead of
 msecs_to_jiffies()
Message-ID: <20250407180753.GA1760009@nvidia.com>
References: <20250219205235.28361-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219205235.28361-2-thorsten.blum@linux.dev>
X-ClientProxiedBy: BN7PR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:408:34::47) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 816a392d-d744-4f8f-7e1a-08dd75ff1e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zOVUMrXqcJIi4UklOhVbHzc4Q8RGCGqJ3RcK4Y7pWTizpZZcAjNBWCsJcbIx?=
 =?us-ascii?Q?Tef7un2bgnGj+OHDkqjJttt3fdkKwsG4/OdI7XaCNUDvklS92lXvxyd4LWTI?=
 =?us-ascii?Q?BhEE2+3GkqHQfy/7VhSHNNA4rHgah8z7jA9ErGnjMi0f+kdFi+0UmWVzmmSy?=
 =?us-ascii?Q?FlpTfVytAY1pBzVteRXcWXSBuNrVEUKuDPwqll0MePjyw3cG45hh76cBlmh5?=
 =?us-ascii?Q?DAnVR+WPEK03ZTtvJi1b+5Q1a8QoPQ1wmT1qsA4HCjoEmBd5X1NhdcLgq2Cc?=
 =?us-ascii?Q?zEzSR4LMO++2ltf4L56QXkjpjnnAaGZCWah7RVwRQfkbzaDyuPWRUhncItWv?=
 =?us-ascii?Q?R6EamQNqMo5xh0ewFy938Shpd0D1DbGqwWA3LbBQA1mylOrGeQyuZduJBYzN?=
 =?us-ascii?Q?qtmDLSNAHZ1MItzYbK74xH3RLTTaPevUujGceXKTOAU4Ezm6/4pY5odQxQP2?=
 =?us-ascii?Q?pmfh0/ubLrJfyN9PQSZm6searQs4sFwcQqywGgP+LyUIlhKTsZS5oQrB2tVG?=
 =?us-ascii?Q?RxFEiN8DjFzAo0Zc81XnMSCwyYvrqU9gXGdY00cq/5ugTzpVfJzSQ7gVXRbw?=
 =?us-ascii?Q?Uiwa6Twxc+XQqCVm5v24kLETmCRT1OZ3lo3oQXH1AagoP5eHFuM+fpHRcOYe?=
 =?us-ascii?Q?ev4KDfaZk2CRqt8q9HybFJFrv56/DuivJ+Hr+GBud89Sby3Ou6ZzezszB5lR?=
 =?us-ascii?Q?x9EklfCB15HtrKfNmyWCvl6RC5Pm+cgkHP4PUkTXfjKJgJ7cjkDtOZ1XeaGK?=
 =?us-ascii?Q?rYI5r/S0u2gWpKe5314GlB3M9IVyFo9iz08PIIDEUoIfRJAfNABxI0rVttkP?=
 =?us-ascii?Q?rxr5cSKLbw9rFh3+iOOaBUqaguSxs3FGF3fDsDvhAB/bD9PyG/Ks4GOtpXEn?=
 =?us-ascii?Q?JaoCg/Qur8iDAi7o/p2zJyRDSuKJ6XcMW0x8dXAQyUGbvhc5jpFTQe/w1uYp?=
 =?us-ascii?Q?z0vwQ1F4TUnCVTvoQCWrbq0vuz6spLsXFA0gDgnIWPXt9KXKj+l21s3RrdKP?=
 =?us-ascii?Q?OK9HFIZkXAIbWREGT/9MZOHts+YZzwmhPxVi5oPy+TjXhZ35Qu4IoxJDzPfm?=
 =?us-ascii?Q?EsP5YtcSzJJ74jPW2GTpzf/vx2xFAqxacoQ4qUEhERP6YI0z7eXVFYSg3IMl?=
 =?us-ascii?Q?RhDMWIyFLD+WF5Ee6vNRYqeEhl3RoSjqK1J6+aMYhXWANVZ8Wn1lxlO9Sm0q?=
 =?us-ascii?Q?0F1KFyRcL/Zp4JjGqpLmWFXWwbCSafsFwawPQR/61jRPBAGWHyw3IC87j5iK?=
 =?us-ascii?Q?BTaUloGPXda73WEnHh7tDRSXi7g/bL5Bt/RrdRsrhpdfpSPJOG3urNd3VcyQ?=
 =?us-ascii?Q?Pj+YgOAoeZeBOhjgx1HXYaEFuGeCbFjhzHGNrqu4gyc9jfr7PaEaVlfjUFCm?=
 =?us-ascii?Q?8YVNlPDjaOVZ69pznEycKDWgKZxK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nrys4jEtUhbc3xsOF5n8TCwIEAUXGqpfJ3XIFq5WCWE7wvBJAcUVsttriPpC?=
 =?us-ascii?Q?HHHkgDrXWhxRh/x+EMnstNNvJqrwM7EMVcFpHU/d43/z2tnK/WzcE27sUmqE?=
 =?us-ascii?Q?q2CCKgI//M/LCm+4XzRkRklzxZLhC1TiFGPt6P0HJ271aOh62Ea8QsRlrFtZ?=
 =?us-ascii?Q?akzillIGRxYt9rHUJ00xtfdnydwV3LSHgkcNyOnMKwlFCem2a/0kLpxgfDy/?=
 =?us-ascii?Q?SwxIiGOjDwotX/NMVuHdoJdrtg7CPRvnXq8hO5mZhMdvXH21MJ6/iT8DBDo6?=
 =?us-ascii?Q?zVEYgNogXL9GUfBd0oS06ch8uyHXzMGu2pNE+oPRh2EwQepQ79CdAt7kiX8j?=
 =?us-ascii?Q?3SB9k/wJLU6qwULTUyNqOH3+DdBWEOlRWx3QhgV9+cfwwt2AlpjLlAI972Pn?=
 =?us-ascii?Q?Jf6y+SIuuTrTnx+3l3JK1tw5UaC/c0+6mjA6Z/iDA/EZntij0w0ksoBRviiM?=
 =?us-ascii?Q?WaNLpnTYN1eCxwaKAL69TYGkkUjeD27G23EdKop8b5435lZv9G1PUDcA6qE/?=
 =?us-ascii?Q?eW3bDWmukCMZiaKuJmsaTFbw29N/8w3atfsTQAKQg6VAc440Vwq7ysSygjuz?=
 =?us-ascii?Q?lg3j0hTFmlNv5O3YHrqxihObllWxbcKkYs8svvaomszpeJObJ6ZUV6JECdl6?=
 =?us-ascii?Q?84fHIQtTXz2VMURNbe1tzqvS3G4RdR0YUQ6d5hsYfAMRfGyusnjKxv7tvvt9?=
 =?us-ascii?Q?nOB0PLidXWfxfFQ2ma7buNKfWIw4kBN3pbqUpF5kgMQ/P/5tmKgglNMCxLSl?=
 =?us-ascii?Q?6Vc4p+SrGJRPLEzpb/0ZIGJ+huhGfjbV9mE7iUt6YZ/nq2xETEHZQW+qccym?=
 =?us-ascii?Q?LavjtrvNpFZxWyCDakoIuwOXT3ar5U6dGhaqYLX3tBkktl8KreMWmIyB/8aK?=
 =?us-ascii?Q?Zkr4vLQCypMadX2MKBFMxfNSiiVGcyVBXa5MjX6rQA9710iKJLvQcmpUIEi4?=
 =?us-ascii?Q?AVsyzCGazWP+Hg3fdE/VTmT2DZraysqn9ZvTdW1oyEwhkmPSGgtkpNwtS0Wi?=
 =?us-ascii?Q?w7jJs1GMdvO/YWtT2P/Mc5K3RlOaaE4kXJFBiObi2A7N9UzC7xeLWDtDpu3c?=
 =?us-ascii?Q?Bk44sJwRNvTBKzkdQv6j4n+fYAo6FlKuU2AuiFiarXy+hcYtUyGnNN97ThM4?=
 =?us-ascii?Q?0oyXVGxtGmucJDf2B/Ghg0Ha+QtcciOa9ma1BdqiL4WDSc5AcKqfoEKYc6Fn?=
 =?us-ascii?Q?zF+C8N71jvA7qoVvLY0xcEy9E9UztLw5wpZ61DEz0fcLsA1xq0t/d6xXY/Y8?=
 =?us-ascii?Q?JeN4to6b/eGNi64vud4cBS9jDWtFITdBRnfvC360hjzAq2Vd1S6eaRlGCnlE?=
 =?us-ascii?Q?CicOdp2uUCdw23jWdBVgffp1mNxYY66Kl8fKqiT4hETnNBrXA8sFaY3NqOKH?=
 =?us-ascii?Q?j+PskVB18Yjh1y07Y3tIbvVB+qIUB3nsOt0D0UdIO5MuoWB8wGsu5ZHhHrxJ?=
 =?us-ascii?Q?MA19H03POaviPi8UGIALp52ymU+EmPzM5jhvkw6jkX8AntVBnBo9K4iy87eN?=
 =?us-ascii?Q?Jdy1gqqZkMAx8jIB1Qs1nQDe4NjPWQDaSioNgkoRUePkHAdiq5afA8yJM55F?=
 =?us-ascii?Q?Sd24/OHXmdaDCfxxWuWn71GtaiXd/GyIIP1K5RVY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816a392d-d744-4f8f-7e1a-08dd75ff1e91
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 18:07:54.9306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eMASoKEJ9dRwN0jGs96lura02x3d1hcs+YabI0n0zG4ozGvbFx7M6VeG4ggXyOp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

On Wed, Feb 19, 2025 at 09:52:35PM +0100, Thorsten Blum wrote:
> Use secs_to_jiffies() and simplify the code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I took another version of this because it got more of the
msecs_to_jiffies calls than this one.

Jason

