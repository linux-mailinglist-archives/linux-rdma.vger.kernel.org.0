Return-Path: <linux-rdma+bounces-3791-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983A592D239
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 15:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F23528809C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 13:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDB8192470;
	Wed, 10 Jul 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l0kcsxPh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED7A83CD4;
	Wed, 10 Jul 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616722; cv=fail; b=IJrGKn8MVowT38w35La4N4Y9e+Kfu8S3ReX2Ae/NWJFKM0sa91nNEg93TfI+Q55PHN1ICbJ3HCxaZhUZGlZUVWz+9PupcAIkRRhT/7csRC8zkKFE099lSVexYn+yBOsaxSoHSIu3ZZ8LAFW3FwZHWEDVe4cskPTyqCBbu/lJBso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616722; c=relaxed/simple;
	bh=FjjxiHXdok8vIpo7og9cjLnX68OgIqq8heGo6ucSkow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FNTTbwF7ZaySmuLS4j+BTKMS1jwn9XC7IU6jPD70DliOevYMPB8VICK4aEnx4UaQEdDwzcmjZuBVGDm6hFCGf1dSMxraEoVI7qziblsAqixP4xvEjbtwR73nSYum2s/IEj42H6kUt0iNni57Ls4Fg+3QVeF/Wpe1I9TY0R2VTBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l0kcsxPh; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv3uulByK0eCC5DkMT+GOl493jRmzpNMTOM/FKbNmMH8U4+g3q0DhKn7n2u03LWHQlhz3iFrlUPWEg7I0qwyc2dANzu6MOl4m7vubhQ6sutdrRlxGzc68lYONhtoNMYEUtzhL/vZxLmbyru9dgXgh1461Paz1wcFAXSDHcpNSNaItIe4c/zO8lEJI0E6MKjXBJKEwcl5bjOElj6vDFW9XVnNA5Q1kyaj2em/uouLzt/Mj7grSpC8/Xvo4uFpXNLaARzYCr5jEgUWEDi+SDWb0ZCSkwu2/08lssXCqrPqdmgcNLSfuNrRPXotmgvhXtgA0Yi9RIq8jjL7TmBQm7HtIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjjxiHXdok8vIpo7og9cjLnX68OgIqq8heGo6ucSkow=;
 b=JnXynsqY0gf2Yrel/hj7dsgXkDOEredrc7R68HwXEbRWv0enpqZ/neVhdATBA9k2gR9km+LMRZ54wmTwRkh1SZeCOmCHrtZ1ds8fYLq01Ff18vV58nCAlOZ0eB+fK1+nMjHOvN67Qs9hIKvJLWqP17z7cY7Uhk1ZJFNseF77QxM2U3Xirz8bhbKmQkc0T2KRCyzbi7I1Gl0S0A5p0GjtsqxtSroR1u4PQNdY5zTPv6P9iJoF0M0v5v7WWEWwTd1RA3PT5zrYCc7cDVJT5i7atYRUpHJe9nxMFCej4s4q45Dnc+IJZZ7QpCUIXncjB4C2pJJPm4iOQGE8+B2M7GqO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjjxiHXdok8vIpo7og9cjLnX68OgIqq8heGo6ucSkow=;
 b=l0kcsxPhP4FXhUcG5YPffA8CPmOwAQxuy6BhLj4mRh39rv658tCsTRwl59EblCLEIg5npTidZdjlSMEv+XCHcSYse0FpOL+yb3nigXfPthRIT76Ed6uxn6ehlXB2o6U0zHMGgXkSVxh57IKIAomSVhWqfLys5m9KAN+OF3Qm/z5TsKP/ers6cVfXxWAXvY3F2leYJ2IgieHDTgsNh44rMmPsSoAbVhJSWbovqE19M0IoXYKtJ/qJtpONdFoIihuoU+/bOEdVgEe/n2Cv7iqpNK2hMgmfrEcJvOlSsuYDvr93EmdaDY4k20B1XzC+RfA33seBDrukCWeHXmCyBWSKqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33; Wed, 10 Jul
 2024 13:05:16 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 13:05:16 +0000
Date: Wed, 10 Jul 2024 10:05:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240710130514.GQ107163@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <ZozUJepl9_gnKnlv@infradead.org>
 <668d92f68916f_102cc2947b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668d92f68916f_102cc2947b@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MN2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:208:236::26) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 8201e70e-a625-4a27-c2c1-08dca0e0f153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wb0w9F1dmrsB/Ro65yVk7+vamsoaiybpVeYpkqlaZYcF6N3m6gOSX6pVWL2E?=
 =?us-ascii?Q?e6tKStQpk/xkbj2be+HWB7+ajzYgyxenOOC3p7eIFuVsTMOOaLob7Cv7FfaE?=
 =?us-ascii?Q?9z3R2OYDjxyW73l45Cmfv2ivHi03C+m+YDwOkDOVfX0IiyPTAJgKy84skTni?=
 =?us-ascii?Q?rAqZic0LVQanajSDu4yVeBOj9rkZBXX/yyt7lG1rKjN7fXi48rawnr4uE4Te?=
 =?us-ascii?Q?RbTH0xmd9Wz5Mes41ynZCJlYxesvc3TfSAa4CUFm/S2vTo+RgRcOKZHXJ+KE?=
 =?us-ascii?Q?eCV3E9ympKnbpVYNYcvZfZK7SQckhCIfQLWyTL2koOOWE7b8b9ZLveUgIu8A?=
 =?us-ascii?Q?/Sjb17JX0CMjLlp23VMY2VbpqB2Y70fuq/DBCi5+JKS6EY/0lz6jCECFa9yK?=
 =?us-ascii?Q?BJDxLN0Mv+YAJJk346S+pBDGY/7+h1B9xU9iRuZzOYS7ChNOdXNa2puKsI6T?=
 =?us-ascii?Q?Xyw4LzhSeDVPtl1txMLnwn3UEnL/fHexHbDntVREWK0BiUIxFfj+D4NiiSUd?=
 =?us-ascii?Q?GlHG07Xa2OiA6SdndwZwtRofYrwpWdaKPDZsGIeSPCA//hSrsXYo2E8ljWnN?=
 =?us-ascii?Q?xfZfrnDvjYXgBA6imOyuzKHA8+45Izo4oiRuiw0mpAMrwhkO6g24WsL0wX2R?=
 =?us-ascii?Q?3ocS3Ztg6MmrIXy6VcjgtBh3o377UQ7gYtKOMJH7JwvNonDyL6/aYDvJ5jBm?=
 =?us-ascii?Q?JFpTSzvDFxLfsF04HQA8qyMu9id5t81FLnmn1gln5xh1FTV4LmflCSa/QN2x?=
 =?us-ascii?Q?kyyHGh8du8qUJavhALSN7k3VXNoktXQm3V9AMVSx0UsVYBVfF0mUf1wpDwV7?=
 =?us-ascii?Q?GQLty0eE0ms3n3EkMc6ckXgbZ1SPxQnYY+sw3vcMqgtaPyDnEHjMPETqgg3M?=
 =?us-ascii?Q?kZwXM8PwvPGmKU+Qu0IhEDJA3g8WTevw69K9sE3oByLVC7VZJGSrmYPt76PE?=
 =?us-ascii?Q?/26HJwfGFkMdElDIw1og9guZA13G9s8JucIbSUxb3sGlCLGbniWaFy4zFlr1?=
 =?us-ascii?Q?UEfpLbXm5QfZ9+x/VTRs2BTGVQAbRdG8+7NIpf6IBAnSLWMQ2AXONakQy8gL?=
 =?us-ascii?Q?KwRbX065PgDl63//hHbXZFStoaDDoCHj7UlnzlUdbf2buMi/SQTp4yXwBunl?=
 =?us-ascii?Q?jwk7YrlEENqxrEr9riLqAHcV+LLk7ma3Yf5GWvXmr1IaR+qIKqdXBBNEcriF?=
 =?us-ascii?Q?pFCXxrOoa+9Z2knH25VfS/IaIgR1Att9mWacTbYf13M6aayG4+yIBjt3fPH3?=
 =?us-ascii?Q?Nh7Gb0K7uX1tkKqW8VwJOa4s8I19ks1rtD+ZkLs+sAReOz8qIHuQSJoEvOE9?=
 =?us-ascii?Q?nzqfDBp+hpiDxKw4PiE2bxNwBbhtgZsG389poJC+mCsaSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MjHA8xeq8Cf2nf9UiyRr6UUDPlzkDYTz7H9ZVIJJUceYlZ1+i7zHy9Xl9CMP?=
 =?us-ascii?Q?ve2rRHpLKFy1ArSNCgrGE7Id9dfy4R+Pgn+GDmhop2vXdn9uG8+iSZ4Z8hpC?=
 =?us-ascii?Q?eBKtG0xBv4ok3zzEHg2P3TalV5Hlagw+eGyWtQqg9fUX6IlQzQhJx/FDKIvE?=
 =?us-ascii?Q?95mNGjYqOzx+maXJ8jiipWWcJsfGCiry8mL0qA20IDOXxWrAwV5pSAXu/nKY?=
 =?us-ascii?Q?FY1ujd/Fo2KkbRYd/Zjx+SXG/uwebjkragGGHEgJnmSLRX/UzxSYYwpa0zpX?=
 =?us-ascii?Q?+ruwSz8NYTXSWuqnhOlZIkUTr41pOTDd7Zr4zJsXBoYt15ihTkiGsxZLnwHc?=
 =?us-ascii?Q?0QUHmZwiV6Xxcgb8TeaMQ+gn675+G2pme2FM3jfpsLAAXjt2a1bry7tVohIr?=
 =?us-ascii?Q?RkgMYXBVbyvD707QVHt1CGu2Eweq5WoVKxRk18V9GbJClC65zxFfy5uhBqYn?=
 =?us-ascii?Q?k+u4qSL3VYzifMc6COkx5+EUZSOCyD5XWPwYGKNi0M5PmlAp9xt4W9RjyfcS?=
 =?us-ascii?Q?6d58LZWUyACr4WboZTCGftviqPqS05uY47jJQmivYEZ7ExvK0n68c7fc5Up9?=
 =?us-ascii?Q?SZJP7ZQTpmNzheYT7DgcRiWpghIZZPf2wFUt/oQ+hAmmTQH3p6pgavLl2H1x?=
 =?us-ascii?Q?DSpCiBLmeGzO71MR34mYsQS/PiqHsxZd89yOrsEsapbXzhFwELi57F2MuQ2s?=
 =?us-ascii?Q?zw/1k96gSEAFQSy7KO596m1eFXAXMxqOvwmTQ++QPcEEf8+QWEcgr8XAxqRE?=
 =?us-ascii?Q?TkTGKFFjV6FpGzB1QOYr7cZu4HajJR8Sh6sD/27oMRpsqFzkOmVQkKeXRTiE?=
 =?us-ascii?Q?80a1YbdUF0WrznLxuegc8tBAGAve8oWSe5EcW0v8qtcO4knZmHwzslrM4njQ?=
 =?us-ascii?Q?HkMmeMTbtd0cLZ2mwe+RD837bPI/Kj3QxZxq/2J9dkpzV2Kgup4/cpEgyLlY?=
 =?us-ascii?Q?c+nNL12oDtZE/qMpauZ7gnJcNPHeNKaUVICodkFJ+qkU8YZxfVYEuNFuHzX5?=
 =?us-ascii?Q?Eke/gC+6+RQel9m8XfI3gyKpc9Ez7dOG+g4h4URKxD5CfS5ZnpEiMJcbN8eE?=
 =?us-ascii?Q?KOyJsFUWAf2cKo64eKGD4yBXLhgnhwEcb/TX7s4K24RZOUft04e6LckwkXs4?=
 =?us-ascii?Q?NCvzXG59J8q96yU9fSkGSBlkAPnVNrKuFVP5AAxWitJ70NxFb/XLb4Gj3G5r?=
 =?us-ascii?Q?Bnv4PSjBO3c40NZCHU/XdS3UVcGKtd80Qb0b1kRZJwz2KyoCNpFAeFP3uBes?=
 =?us-ascii?Q?kZnUnCu5oWeJokkIInp/Hn1uTRJjmwYLmR9EqB4+Vcb0bFA1L2HOTeDVsUgL?=
 =?us-ascii?Q?tYrIWBVanNwkz2t0Db9JK+wM0fYOB+E6XeHP+Q5ZJw33L4xGM5pUhHne/dU3?=
 =?us-ascii?Q?bDxAwxGxVn6Fm/piZo7d48o+N4kP0W+mfCZlywBpT7MG2FwYA0PRwcvJ5k4F?=
 =?us-ascii?Q?xxGg6/Kuc6Uej1YcRAtGV67MHdgAm+7hB0ys/ToJYd+uc8/FG/R0SrdhW6mR?=
 =?us-ascii?Q?5GLmdJAHqmqX4xiRvwrBPlOuvslXlb8GfitK3niA413trvpLYlRP2z//5BAh?=
 =?us-ascii?Q?R2jYLuic9FNgH9VW1IYyeJfhvy3SgiUgxzt8LBLy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8201e70e-a625-4a27-c2c1-08dca0e0f153
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 13:05:16.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ab6Kw6R8zPJadA2qCaYXd2NobDxkI/TDhrzfXOgKyP7r++CJDuuowJgJ6xX0sW36
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043

On Tue, Jul 09, 2024 at 12:43:50PM -0700, Dan Williams wrote:

> A "Command Effects Log" seems like that starting point, with trust that
> cynical abuses of that contract have a higher cost than benefit, and
> trust that the protocol limits the potential damage of such abuse.

I've taken the view that companies are now very vigilant about
security and often have their own internal incentives and procedures
to do secure things.

If someone does a cynical security breaking thing and deploys it to a
wide user base they are likely to be caught by a security researcher
and embarassed with a CVE and a web site with a snappy name.

Not 100% of course, but it is certainly not a wild west of people just
doing whatever they want.

The other half of this bargin is we have to be much clearer about what
the security model is and what is security breaking. Like Christoph I
often have conversations with people who don't understand the basics
of how the Linux security models should work and are doing device-side
work that has to fit into it.

Jason

