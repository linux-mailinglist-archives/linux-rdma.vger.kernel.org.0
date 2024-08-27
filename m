Return-Path: <linux-rdma+bounces-4590-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45724961058
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 17:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BA51F23D1E
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65791C4EE6;
	Tue, 27 Aug 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T8XzOBJ+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F621E520;
	Tue, 27 Aug 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771274; cv=fail; b=su5JqGXa+Ulv34XB9slA7BY3qPgsWHe0OZxybQjqMVET3kXkAOZHaYNL0lJVCKoe+OncZJA7CzXcyllu3si7FJDn2LCVtvZXF1zZFv2rhCAwPF023pE/ydsDB1etoJsSsNzQnRhTNmVyp6vENyiEoLa3paG0nH2PC8wGh8wxJBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771274; c=relaxed/simple;
	bh=Jml1YWpv0xWTZO/p0FLL/fOpraCYIEeiipNW5KPq6sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n/H9azpcyW7OtivV0uHQ2VuLJ+8DHHK653KfwLcGQbTqMpHuSNOM12pkU6ExKjFHY6WROZdaY5yXWFc+2+BrwsS48Yo3QnTJFFhVP94lp/kOgODWKakECaeKWA0fxdroCy4IewBFsWbR+5uRnA6mgdEYSEKFIccK7oAezhLdWZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T8XzOBJ+; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xt/fHDxZ82zVCu1/1gd4x519udrN2ou4Us5GVQDJl/JRwcZQH0ecLu+hALcfPu1Y1sU156cwIjK3NjIk/9tOTzRWzz0+ZcLKpr5utrk2bbLN4p5N1Jkh0no0GpIj2E9N7lqHt5jiot5+1Z9XvdnXGkRZiskQRQ8ZnRuLkOQ1JmTtnN2t60Vp08s9Imr2OaHTaMgsldken1zU2N3SMR7YIUAZV0efsDkpFjDBK0Ljojh5SsM/hlZRAPuHmSqcQcHBbu2ntamMVJ7rrR01lC07J/Gg056pATBQURploKnG+At6nXl0I/3+cjpgQxdGaeChIDVjKrV1aQyvaWboeaeezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRPOFufxLVzFzmZIeqVgE82NgLbnsXOQNfxCiddWm0I=;
 b=XTNaYC/kXsjV5oWNmV4zHnIBtOS2QpBbKgR8Vx3Fgd+8XYeWARrZrjstgfQi468rQZA4be+pXlYm9RgMKnxuCMfbDmFkmx1PtrgwVWXOviX/edd1TtKg296KNrQl0jBzxEiYxeaoTe8nmR1LlUkD+Jbv92AKWte42JgFWmVCEnil44ypimrh1zWUbgO+T3dNvZKZFQ88wCqoRD9LwSqayS4Zoxujgg1o10wmycQMijKh98Da1YdbwGAoh/NPX7tncadMsG17hLJy6Dlj5ukcKXmbUpN/h3Mnnh84rghtMr1zfOk6aw9jkPiKGWHz0Qc2eDC2uTyyz/Eyjq0U6hy3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRPOFufxLVzFzmZIeqVgE82NgLbnsXOQNfxCiddWm0I=;
 b=T8XzOBJ+osimJN84Rou4FNsx8HBCozQhATWXiSM0jl1wNyMv4DegtO2V33vwJ1f3LUULk/iEXN+uUc78yTFT1uqfOQGZ015Fu+GwGU2V+fbS0VELv/ctMdZbhaXalYinTwdcnxU3HyY5zgRWvOGNqx+rb+s6XneQ8Iwg02zstgAnBUye/87HIxlBm0IVj9MsQzi8ZvQdSTPibnkHGHSVCe3dO8gCfG/HeGrkq+Qpcdg7VfWVSdRW7q49iBYDFjkSNb1m+sE4pdlQLXG1SagG4KPbZbr/J46aj60V2rtea3ttwdKwKuGI9ypMUFUO+ZaR/jzobXnWhkTZqh7wL3lA+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 15:07:50 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 15:07:49 +0000
Date: Tue, 27 Aug 2024 12:07:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v3 07/10] fwctl/mlx5: Support for communicating with mlx5
 fw
Message-ID: <20240827150748.GC335450@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <7-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <20240823154830.00007d8c@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823154830.00007d8c@Huawei.com>
X-ClientProxiedBy: BN9PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:408:f7::33) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a34df7-fce1-49ed-d277-08dcc6aa042f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mbtc1X2CRw/mPPsj60lhqpn/YqVSg0b0T00NCB7aRgp1ia0UX9tzwB3zUfWJ?=
 =?us-ascii?Q?Lzr6M2JuhMqeXm7b/kbLkbfrqU2vzEZiIABFNDJqp0yNeVHZ73wCWKRpnpsP?=
 =?us-ascii?Q?UuyWiFafO1ffbUxBClGq1uelNvETXLVgDnIn98Z1bm6uo6mjOzQh6qPCwXge?=
 =?us-ascii?Q?zKBemGZdGbbx2F+9HFzV/rs1tDWdey+gluCFQxlXMM6p1GvD1w7GsMZcbGX6?=
 =?us-ascii?Q?5T41YkClZGwxX7leAKwTQggps/qqOTBJsCDda1G+lABPvEWd/4VWulfEjYGI?=
 =?us-ascii?Q?83RvOeDH86jnj3p65E4lIJC9/BCAZDd1BW7q7HvO6RSQ5HjFKeiV4WdLRb4m?=
 =?us-ascii?Q?aI1dChfh/OCJXdcuaqwghnfjrka+AS1MqIogd7E4c75fnZmNQutTtlnxXwHK?=
 =?us-ascii?Q?3CW6NlmHuK5NzDObLsmoFn/pwpkOPVIcbXFKX5FID7flFIJOztn5LbXtCeYy?=
 =?us-ascii?Q?zIiya5OJKShApwNoTyQAP5Q5kbsr1AmyPTehV9uVzK9lXZvw1Smn8dc3DhPn?=
 =?us-ascii?Q?bGyigL5HqvZrvexL4am7Crs7Pof+3cjH6ZWEyLbPmHGmxcS6218RizKfdBeW?=
 =?us-ascii?Q?5sx1Ny48Pk+PAN4TR9DvCSO16DsEUZbcedfVcQTO2sbEMmQNg1h9qaiY+Nhb?=
 =?us-ascii?Q?bAVKuezxDdciX9dmKFJlSjyVNpMrZN6vBQOexTQrY8TX3mo+Um1bT5AxRtwR?=
 =?us-ascii?Q?7w7ZwjkRNeiIwvBFVAvDSZaIejpKjlqPP9EN8kE0MbMCjPTyAxSj7I3kfmVE?=
 =?us-ascii?Q?YhMEEMhZpElBpBeVbtO7uKNpku8fLEDtk4G0HRFP8v6pSUD7FheH6hlfUNV1?=
 =?us-ascii?Q?SHUsgT2Wos1u9oXRU9QMo7GzEIDheCgiq36XrFaPW6Zu/an89j5XYsh/C56f?=
 =?us-ascii?Q?fAT7UnYLjfH+T9I0kkffUZSolYqEKUx/iFHyLwDPeCPP9mGjfgzj17ctTwBN?=
 =?us-ascii?Q?hIT54zfuubBmCDgeWJ9EROmvH1A8u8w/pdh9eA3jWI4P4TeA9VzgKiE/dJV4?=
 =?us-ascii?Q?4fkdhFrd1+5GochQeuQ1QF2o3Lu6nfxqiNQVGU76eF0aIPgmQEvHzupEDdcb?=
 =?us-ascii?Q?GGvGm+YKdMb4sNgXCYsFcMWbB2vi9EZnMgQtGSxkFEIfaxAyGHssg9SdNDbk?=
 =?us-ascii?Q?27z5GJFC2UCAacfLC9v49h1I4SWSBgZfJ2B1RIiFoFe8WAqzkupBxAnFe2/O?=
 =?us-ascii?Q?udSpouAdk1VEgN5rFcEQW19VQBNBgELSUUP+tbhIv2cLOx8L87wlF4BLyFV/?=
 =?us-ascii?Q?YpSDWpdqJ+PkXnd0RPTP36Tf3SCR11DpvS2hyPlz72+Cb+s/sn++EpCsRDXu?=
 =?us-ascii?Q?ow7MNRXimYLc/5POH8q9lnSkf0U7WgjWbVvCsa6bMXk9Fw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QdiBpOWjKVGT3X8d/NQMYTqN0KVXWs78tdxy8aubY+l5GZkegm/c+TMrfjbR?=
 =?us-ascii?Q?puEeOQzopxu3NUf60DPl9EQJWImMfi3HF8omz2v6RZKywKmcPdzdUSSfZ870?=
 =?us-ascii?Q?AekupXjigTNvpQh92JHrfj7/KBNWR6arK963aU8M6bWfFw6kcyJyEJW0xTF9?=
 =?us-ascii?Q?fj/VSpSNue6/ICxrUPLcihmueB4Uv3TEngYeY0ZciV4Qv+JpBopN7Yos7e0C?=
 =?us-ascii?Q?j/4UjB6JoN5dcLrLYd7d2QVzcMF1j/hSfwQvbmR9TFsK5AGEFbHECIfwmhy1?=
 =?us-ascii?Q?SPIvD7XUUgm+Kr3rLN5zSGTNaEthXWqEMW+s4TZkDIcUk6t1xkmBdZN7+HOX?=
 =?us-ascii?Q?BYreiZNSjk12RhFHG8yYK1D8heL1ENMyk3uldtDXJG72Iha2qEvL/usmlg5D?=
 =?us-ascii?Q?+X3hbbz8Scg7+DlW32RasLX4A8N6qnKJXp8C6ZRuef77WphAZu51wsiBKOLV?=
 =?us-ascii?Q?uIHtuVW0uFBmGFjTZj38Dyi/XDg46b+PiGU1csrNO1UmExJFQ2JExbK8iJr4?=
 =?us-ascii?Q?81ewVOjSwsFhnpaxLMf74ImkxiGbUGFCD8WFtB8HCVM0wP+4iZdXv9uZJxrl?=
 =?us-ascii?Q?vB4JdhGgqQwikuKRmjtEBImzlzkxqag0m+VnH2YlQN69vVZRdYru785EcKFi?=
 =?us-ascii?Q?fmEJ4ghqrGwqA86j14H4R4JYjRl/yeeCgJjVgnw75x9u0MpR+J0FqxSs7DEK?=
 =?us-ascii?Q?6YMu392ELGo4joCL6K0P4skOrQBS74V+4NYHA59eYfQUxvphijrCU0MCiEfA?=
 =?us-ascii?Q?InzteAihLGUDzh8j5LghBh/6jas1+vQ2ILt/5LA1XtfRZPbUr+COfjX0tNBa?=
 =?us-ascii?Q?cRZl1ylqVVJXvfPI378o1wvqc5wB2Ypd2/dO4uxmCLpb8o7eDj2zfiuHKbMD?=
 =?us-ascii?Q?41RWTmcrOTCjiNHeA/uSjCI46jauJgxDu5T+dFq1mqxXbW1iXkuUratPPdFF?=
 =?us-ascii?Q?I7fWgKtbJ9wFLKXFWs1leogD3G8f+Z6PFCRZv0YOnQyWAdiYM535gXzeaT8/?=
 =?us-ascii?Q?ec2kNKuZJaKzqDK2CCfP+ggX+P5/pxQfUQQof/Ecn61mwflSsL51lGbEPJhu?=
 =?us-ascii?Q?d3oKqSunJTUJ1PgSBBJfAPd+LCP7QUCqcZF7WlSLRy8T/FFUsftzPx9kuAAk?=
 =?us-ascii?Q?oP/iXSrVioVzX5u1rOxOaGb2Ng6Iix6FCQD1PqD5z7/VmaNkH3NTs+FlE+Ip?=
 =?us-ascii?Q?kXeToPxI8F1RdG5ay/oy5xIxQblDuRA3N09wvRBHydWOi8jmcEMFRvq88Gzi?=
 =?us-ascii?Q?f7o9RHcGLg11NjheFHMJ6HlLfIyEIHFRUIynUEsioB+UvhBo+8r2ulRxANkb?=
 =?us-ascii?Q?Jp3IrsywH5ag/PFzMWuQc5F3dRjV1kWhj9giqNQYq0XJCmPZjGKB2GQOYz00?=
 =?us-ascii?Q?q+2zuKP+V4rCCJAq88oT+Gp0uheD4cIT8K1ATnJ0jbubUVHg/KmPjGHw7UUI?=
 =?us-ascii?Q?Cu2ybzaX6u4wI/4Ku6PU6oUwOyk9fEQomogY6KpfqggLxhiYz5FOEHbiTLDS?=
 =?us-ascii?Q?nFpuSbGZ0KFfcNq/9NS8wdcjG/rBtHIewo9O5c9zR3/W5PsQLSVQk5wGZsCy?=
 =?us-ascii?Q?ZE+v6gp1k0fp8seYyyosBEHd9Jr+r21NWON/wDpz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a34df7-fce1-49ed-d277-08dcc6aa042f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:07:49.8264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOl8ejjYVBoqOQZMrAd5GeZYIenCk8RELbtuudVhpUUuBEXXHuy4EWJtnJTCcJuo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600

On Fri, Aug 23, 2024 at 03:48:30PM +0100, Jonathan Cameron wrote:
> On Wed, 21 Aug 2024 15:10:59 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > From: Saeed Mahameed <saeedm@nvidia.com>
> > 
> > mlx5's fw has long provided a User Context concept. This has a long
> > history in RDMA as part of the devx extended verbs programming
> > interface. A User Context is a security envelope that contains objects and
> > controls access. It contains the Protection Domain object from the
> > InfiniBand Architecture and both togther provide the OS with the necessary
> > tools to bind a security context like a process to the device.
> > 
> > The security context is restricted to not be able to touch the kernel or
> > other processes. In the RDMA verbs case it is also restricted to not touch
> > global device resources.
> > 
> > The fwctl_mlx5 takes this approach and builds a User Context per fwctl
> > file descriptor and uses a FW security capability on the User Context to
> > enable access to global device resources. This makes the context useful
> > for provisioning and debugging the global device state.
> > 
> > mlx5 already has a robust infrastructure for delivering RPC messages to
> > fw. Trivially connect fwctl's RPC mechanism to mlx5_cmd_do(). Enforce the
> > User Context ID in every RPC header so the FW knows the security context
> > of the issuing ID.
> > 
> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Trivial stuff only. Feel free to ignore if you really like the code
> the way it is.  I don't know the MLX5 parts, but based on just what
> is visible here and in this series.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > diff --git a/drivers/fwctl/mlx5/main.c b/drivers/fwctl/mlx5/main.c
> > new file mode 100644
> > index 00000000000000..8839770fbe7ba5
> > --- /dev/null
> > +++ b/drivers/fwctl/mlx5/main.c
> 
> 
> > +
> > +static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> > +			    void *rpc_in, size_t in_len, size_t *out_len)
> > +{
> > +	struct mlx5ctl_dev *mcdev =
> > +		container_of(uctx->fwctl, struct mlx5ctl_dev, fwctl);
> > +	struct mlx5ctl_uctx *mfd =
> > +		container_of(uctx, struct mlx5ctl_uctx, uctx);
> > +	void *rpc_alloc __free(kvfree) = NULL;
> 
> Whilst you can't completely pair this with destructor, I'd still
> move this as locally as possible.

Yeah, this is a troubling area for cleanup.h here.

I can't really move it as locally as possible because the assignment
is in a scope:

	} else {
		rpc_out = rpc_alloc = kvzalloc(*out_len, GFP_KERNEL);
		if (!rpc_alloc)
			return ERR_PTR(-ENOMEM);
	}

So given the choice of putting it at the top or put a NULL initialized
variable above the if, I'm feeling the top is more kernely?

Or this is just the wrong place to use a cleanup.h technique??

--- a/drivers/fwctl/mlx5/main.c
+++ b/drivers/fwctl/mlx5/main.c
@@ -226,7 +226,6 @@ static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
                container_of(uctx->fwctl, struct mlx5ctl_dev, fwctl);
        struct mlx5ctl_uctx *mfd =
                container_of(uctx, struct mlx5ctl_uctx, uctx);
-       void *rpc_alloc __free(kvfree) = NULL;
        void *rpc_out;
        int ret;
 
@@ -253,8 +252,8 @@ static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
        if (*out_len <= in_len) {
                rpc_out = rpc_in;
        } else {
-               rpc_out = rpc_alloc = kvzalloc(*out_len, GFP_KERNEL);
-               if (!rpc_alloc)
+               rpc_out = kvzalloc(*out_len, GFP_KERNEL);
+               if (!rpc_out)
                        return ERR_PTR(-ENOMEM);
        }
 
@@ -272,11 +271,12 @@ static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
         * but an error code was returned inside out. Everything else
         * means the RPC did not make it to the device.
         */
-       if (ret && ret != -EREMOTEIO)
+       if (ret && ret != -EREMOTEIO) {
+               if (rpc_out != rpc_in)
+                       kfree(rpc_out);
                return ERR_PTR(ret);
-       if (rpc_out == rpc_in)
-               return rpc_in;
-       return_ptr(rpc_alloc);
+       }
+       return rpc_out;
 }

Arguably it is clearer like above.. Let's go with the above, I think
this was too clever a use of cleanup.h, it seems to work alot better
with simpler cases.

> > +static void mlx5ctl_remove(struct auxiliary_device *adev)
> > +{
> > +	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = auxiliary_get_drvdata(adev);
> 
> I'm not keen on the non constructor being paired with destructor
> but it's your code so you get keep the confusion if you really
> like it.
> 
> I'd just have an explicit put.

Yes, I thought I did that already.. Hum must have just thought about it

Jason

