Return-Path: <linux-rdma+bounces-5277-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580F993428
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 18:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B221C23814
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F901DC190;
	Mon,  7 Oct 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fGWhkxHj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43F01DC196;
	Mon,  7 Oct 2024 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320140; cv=fail; b=NjXkE4vnEwMfphu4ZRKnH7QFbz8q9c9i4Jo/GOv/q72jGpE5xzi/6ysRpsCUZN2+2Lf8TIwa2sS/d48JZVvSqGVZL2EuCkXB0mzrP9IM4gm7bJ517wU3A3GpAg6D/x+K/sxZS+ViSkRSwHT2UVjuwCij1IYD8k0HJTxMsQjGsSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320140; c=relaxed/simple;
	bh=Ray9v0hUMZLSlYmBWYzW7Ib3JcHIBG+BJcH5ORpgiCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C6jVRx754wzKknEhXNHEkjjc5fLDDTpSal5f4bPsS3RWBntEvlroOIkj8Tbofvu1QGHPCb7u7QV/+Zfi/YlmDFmYPrA2eVA/dQLeA0wbfGPZGYeGRP2Bk594vSS4hx302if7U1bgXDFMvcwY8qCOv9udovk5SQy4mWlyGjzr4pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fGWhkxHj; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7/ghtHugFZHGrPJNL/Jn4aEDbP6WxhON75HdBJtcpz8Z7AFBn0dFHC+19doA77nR/r00StSulfV2+//Syx7x550ZMORPFwFV8M4x7b8cj63gfmjt+S+ZL0CAQhpL53jIsjkCZHEm8MhL69JJ0yhDQucvu4SPH4Tbd8tYM6F2Xv5ntt9svAYxlDGCPOblUxykkoLGaNK5lfBvnMVE9tRGngzQnVXxBp/Wut6lGAGxfNcJhVZogEplqrTmpEZ30S0nWs7AFB2M+a6AlyMqPifpXyXP/cdfQ6vCEzc03LMbx8o0DDPcR1b/1LNZWbtzffYCyBAUFIn/Rc+lE1+Zwqj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ray9v0hUMZLSlYmBWYzW7Ib3JcHIBG+BJcH5ORpgiCA=;
 b=j7bQCvD77m50dsnzoPXbrsQS08XB9m/X5gzY63PcIGNXPLORX27t2xjJofbthcrTXbdSPLxTorEdzhDosR9J/BHb3g2VGR683iUHyn3eRr/2uNS0zysaKiABK511NLKMkPpfTcNPoNQlbR/9smIS5+SAXz4TQo/G+OqQqMBPQe18hOcvWTUM+7AV9yZNCF/bAPpm/hEitWW2pKj8OuOAhvur0ylQIavWQa3SUhQi3yXqCO+6ROY59obG6BPqFilCkXwxMX1l5FLCLzY57UYAAUj32R+ZCEAYQxQubcCyvhwDnz94ZRK4fqx2wmQ3XCdHcw1W77aPVzQRfmXoqii17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ray9v0hUMZLSlYmBWYzW7Ib3JcHIBG+BJcH5ORpgiCA=;
 b=fGWhkxHj7lANLInRGRFWDx0OaS6XuS+1N75QT3ZGXEDdwF4FSThzPuVdGO9qByjTU9PmSlATbPvTMLmHzG3tES+JAOPabBS0dyYHtexLafiarujpti+Dhi+vit79OhZgP4xDo2UikiofILne9XWPv9gsgvp3oPBg3VuoDVJldKifUCYK4d3XUJT76IpP3XjWeitRaRWHISH0R1+Om9jJrMOAAUhXT5o3HKx2GMb8Ix0gZ9zxlahMAIuNDI/H5ghlKrUvGztg3sR+UT4jzxw4Vjn/5efeEIbmVRw2DpVfnQ6N52GekFMgmi5EnaCSuBa35jn19DoYSXHP1s5pRe0Agw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB6678.namprd12.prod.outlook.com (2603:10b6:806:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Mon, 7 Oct
 2024 16:55:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 16:55:35 +0000
Date: Mon, 7 Oct 2024 13:55:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Zhu Yanjun <yanjun.zhu@linux.dev>,
	Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
Message-ID: <20241007165534.GW1365916@nvidia.com>
References: <20241004173730.1932859-1-bvanassche@acm.org>
 <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
 <e9778971-9041-4383-8633-c3c8b137e92e@kernel.dk>
 <09ffcd22-8853-4bb3-8471-ef620303174b@acm.org>
 <09aa620c-b44b-41d2-a207-d2cc477fdad2@kernel.dk>
 <04daaf4c-9c62-404e-8c5e-1fffb3f2ecbd@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04daaf4c-9c62-404e-8c5e-1fffb3f2ecbd@acm.org>
X-ClientProxiedBy: BN9PR03CA0742.namprd03.prod.outlook.com
 (2603:10b6:408:110::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 21943fc4-3a5a-4c71-c424-08dce6f0dcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AI5VwbuOb2qFKDN7M4rlLaEnkPfpBNBzJiPBFJBJaH/qlPCCBh+e/GSyIhYl?=
 =?us-ascii?Q?Eho/cGaQkjOz5i+gXclUwywLYA1tFbL1NJ9p/E3AcsBMNL8PsRbaMTir2Xn0?=
 =?us-ascii?Q?77xm79AJZVJVwq0/c7YeDIxYF2MyXcldUcNWxdscn4LeZ4NDTc0FhcJx/TTP?=
 =?us-ascii?Q?DYjqjz0Q2m26djo2RSu3I9FqHx0Wh6U87mErutkPhnObB2nE+h/A+Mgygu8t?=
 =?us-ascii?Q?jEMCzeq35OSkzn4rTCOWsZKBOIVlwIR4P/uM9wULv1w3JcOp6j89urzAhDrP?=
 =?us-ascii?Q?6OgGsPuT9dS4GwKpctpBPXRdd+1gSaz4s+Ib3sFIoCbIU0W7x6mwDpGKRbBD?=
 =?us-ascii?Q?BvTIkFqwyLYG+ejca/vwxsZtBtGu47QwN7n5SvYaFR6g6nEKawwCl0d9WqGB?=
 =?us-ascii?Q?kNWKkQw7BCgNX5LbwXEbZede0YqxdMDPyZaBVPZiX9Xh5XI6Z33pXPUuBcB8?=
 =?us-ascii?Q?QaFBJNLmR8V0bD+1aFs69UTFzDAM1Z83WIBxbbjIfgSfTKZ5eSiqC1vBiZye?=
 =?us-ascii?Q?6VEwg09HjKXze9U9nxa9oPMbPYq8mvEtrcLct5JL/P2msRP3VaZXwl9KZf9+?=
 =?us-ascii?Q?1uXBmjB2xS2PNkGmUq21o0MLdibsY8SvlwLx7zIgsM9e0JfliNX+UZ5FoO8d?=
 =?us-ascii?Q?KhLAD2hp2LThD4jyg636HzxI2w30WJuExE785UP49nORM29fTt3jahKOI5Xm?=
 =?us-ascii?Q?QVrbL0JUb0Cq6v2pGXwabiwCKwyVKKXT9gPplErbOSVX8M0cY6u+JczwLpVU?=
 =?us-ascii?Q?oHYoRCs5uHlBjr/KcWafxD+aLDs0kD+12JV0aQcZgGsQ2PvmotL7BOIgcoP2?=
 =?us-ascii?Q?Mmn2+9b0S1r8Vyp2Z3w62uArmB4NvUYERvVTyfi7Wplgq+4AY11vsvEXdX6i?=
 =?us-ascii?Q?jXKpcNAHXj6SJEzAHX3qLpIi4zpHREZwgQoZ5U2HsVJCkq5O+dkpz+TQCIzt?=
 =?us-ascii?Q?29KXOdwjoreHczHriRMebuF3qhVLMn2h+CH3dNzBZBYEhvuYUh8VyYMp84qu?=
 =?us-ascii?Q?M+nVcZwFS2v6cVSzOrSQ5inn2RuKDaQiraFNFD01o9WmMGpN1mODQzpiWd4y?=
 =?us-ascii?Q?r+UD5COdRXqtbfqbVVTgE22HWgU9nseUP0h3jJoshYqLcMKWyYb8Xqe/eE8F?=
 =?us-ascii?Q?31gH4u2k9dfzTTKdWsNdMnINxmmStAZlqDE74rC9Wc0+xEwRrcnCFjgfc6K2?=
 =?us-ascii?Q?A3el9MgBKVQvhAhAJTIGaHilihWCOgimgXsI09Rn0QA8l9W7EtMqnJWobnSa?=
 =?us-ascii?Q?EG9U3lk0nDqMgzX5unA7y9G31JFzGD3GjWMNWv/8Vg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c8kbbRAgHeEdDpmiQolyRjtF2Qg34kExhGCNysuYk+ocMy2c4hGDq2E5ly5Q?=
 =?us-ascii?Q?eE9QuwjYKfo3xeiOFwIf+F6vKYun7z9rc3yv/vVdBug7PlGUWJ5p7yHkdy5D?=
 =?us-ascii?Q?4xL345xQNPVFeswqNzE7ufiAV/nkaHKfQXVadnlGwu64CHMcL4JV07b4JPHq?=
 =?us-ascii?Q?7lgeBKiRk1QcsnrNnG6UD5DoPM8Zt06ISh3nAf4dI39bckFQAfjd6IWgsKup?=
 =?us-ascii?Q?FbKMlWW8k9zMd30d20xiuCNjiu2RLqkSGMA6fWQDV3o8+C7KLydaOvwkczzh?=
 =?us-ascii?Q?Mox2sUIdS3eoVoGW9c+ZSVyOWQ5iz49FkMg4TkO6U6Fa8J77i4gfO0bl1ADn?=
 =?us-ascii?Q?Y0T+mImcFgQbmxT5w0tOSY7eCrJqDN1kNHiL4OX7qPkS0tRUQWJMvbVJ2qtq?=
 =?us-ascii?Q?yOcM7QJIAw3gDEsV8a0+6OHOa6WbGIbn6PX2jI7bC8ys+cTi3xVIhH2oiIur?=
 =?us-ascii?Q?PfvSk4Q04Bj2kwPUa1+k0K6u/fLReirRYMN3nN8rT8PmAYF5sL36OQ3mm3jk?=
 =?us-ascii?Q?tImY+PqqC4DF9vM39GHaapbeokjLk2CM7E7zO4wvCcXFe4UdxgGKOvJ3o+LI?=
 =?us-ascii?Q?hX6hkfALJQ0bnQEd8UCk3iNSG7EoBrzbuqFl1Qr9BOpoFD/QfyHKEjUsox7n?=
 =?us-ascii?Q?eFLDQmduJyS6aFR8/5X09Z5b208Zi2F3Jjf5MopIg7w2+3jgJcFSgMSlx+vY?=
 =?us-ascii?Q?Nji/NxRhAtMmTJNy3yKZ9kljZJi3I8zPcs7no3bfYdYsI8jb419cy6w+SL47?=
 =?us-ascii?Q?JikQDkyfI4+Rqe1tqHtRNDHjXvjJCEGqm9lZyeG1M6zYC4JXCj5y4e3DLpzr?=
 =?us-ascii?Q?5SD/eEbc9o65n2cEseLAh77z108urs9Hsr05pC8ZBsF8iOYmZTL/UK9RJcsM?=
 =?us-ascii?Q?j7Cm/rzGy5DWAu08q3vZ7whN8c8uwBXoNQxDL/4chS3MVXaOyOZC2SMyX9hf?=
 =?us-ascii?Q?0c9AOlC8jOPCmuOjd2op1nomMbtUXF3NKUJcMycGM9s8TsOMwArYMk+0aDNW?=
 =?us-ascii?Q?J129AQXrNkbiD1Svds30PnxMAYS5i/2EHVgG9iV10VSoDMXunHPz664KKYs2?=
 =?us-ascii?Q?LanoLP1B+rjUKiTV1hsCTqb994B2xxyo0kppYvCi9hBcKkdpDrLHQD3h+4fY?=
 =?us-ascii?Q?HzEPc2pG6wVDL+MIkO1Yajh/UDPcoSzx3AC55GHAUMLCOG1RjSKMWO6FqqF8?=
 =?us-ascii?Q?qRHZ7VFtdMbDFujfJU1Sb9IiqSDWjkGLVC25F3UBr4cdkAytABSqckCIifrP?=
 =?us-ascii?Q?WbzNIwwDi10xr7x/0J2Uhfac8xcaT8/9dFBkbQKgdENUTzJI5UANsx1+h0ln?=
 =?us-ascii?Q?/yH9TgnplTrHMI8fpLZPltIp+gV+5Cru1wngD3lA2uh7rY0aYxUANAEvjAak?=
 =?us-ascii?Q?fna6CrTJqtM54iX7eqDdk1slPssz12CEtdf35zyk2jFmkthzyE8fhd0hWheU?=
 =?us-ascii?Q?l5QptX9We4v2RKo94s1GAWp9LeKgNn440bZ2WFJP/lf2/e+cVEqVBEUQhTEl?=
 =?us-ascii?Q?Dc2niaDUNI4LIunMf2Ej5nIEgsDeY2FbVjsQVkFrJWP8kZ9YyhWwwXRkp4Wk?=
 =?us-ascii?Q?OaFSJbBGvMR3ubnPxkg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21943fc4-3a5a-4c71-c424-08dce6f0dcfc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:55:35.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzI+m+dGGA3yS/QtZAIatbXRTphdJ1L8lrE85kCkGy6qHvEXblLYY1GoLv5mTviG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6678

On Mon, Oct 07, 2024 at 09:52:05AM -0700, Bart Van Assche wrote:

> Do you agree that in this case it is safe not to check whether
> ida_alloc() succeeds?

It seems like a way to attract static checker bug fix patches :\

Jason

