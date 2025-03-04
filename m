Return-Path: <linux-rdma+bounces-8306-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DE6A4E011
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 15:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3770B189D100
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192B204F7D;
	Tue,  4 Mar 2025 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AzpX2B97"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A10E1487DD;
	Tue,  4 Mar 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096842; cv=fail; b=OhHJt2daXcXKMVK9Fz2P3MYoCZTH87t38q6AML824xkY4rUo2XcSXb2fhp+S8Xs+fIZ9yJxfBAhXHdN4B4Jdk/AL6DO6beULQw2QAXZemBqpf+9ZC941uwr6NYDkkGCpcyFp8i3YyQLV2DrRLbu11H7Rx55UdB0mHzHHrpcqV34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096842; c=relaxed/simple;
	bh=RYhAAw354EjdYy6e5BDcJL0yJax4QbR9gZWrGmYapC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pBemaRwNPRfNnYrK5mEdY+iHpbPGn0mv165A/2+V+b6DvMy/R+qWegebr3H02UWHnJosk5MJq9cZFop0Y/VIoV7+DMHP0vyrkSgp36sXXHHltWzqPtLyqbHigmT1kd59SE9QxWc5M1e3x03lEkFizz0ozg81/uvjPWtXnTW1quI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AzpX2B97; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnmMk8jFyRsZRNC7uAa+QY4HlyQA4naQBAv6okBQIMx09c27SrZhQDJ6NOzd+YIbJlxdlQmhN1PVy6odAdXf6WuDzL9TVQPT4PLbZmMF3jQNCBkPP/mYaK7oX7bhuVYAntEGE5jxuruYGlBOxKa/jA0zainrj6+T8AJDBZshS4nZNiBiqq0nB/fR7VYx/P2oTeEcN0z3/ivGIW29InjSd5fCCtvtSHEOWg+JY7lD91PofFa1Qhtq+lg2XfFNlLfjHVkzzLjXEoB4w4gv763gj00gfo0UW1/rWtieHgrPsCcButH+/ZBeebtWHu99kf1TctHmnz31Pd1/9NZRj6+Tlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d19dFQ9ObLVkmtDd9/LdlcMq4aHurzAyOH0o40TeU6E=;
 b=uUIJlb0Oxg57SLECuzQppPFvj9uAFqMFXYPPv4k9KryzEgXBTOwynIyu5E3dfy8U3T9ExEoqLHGacjC4kQa5Rd+IAgR/1n25dyIjxdsVF3R9NNoys522ynGFSoe4GLc0X3FlhIlFn/gtNalx1nmF1X35yJ+mqxMGKn/9KP2nK30hMiWpQV7syYJ8dQBQi0hgWz3XPJGbFM0ZR+8ToxsBnqoJS7oxzBY7zLSvCSE1+A+tr/bvDsqm5/wgTyKUb4J3S6ggInDaxA5V0a5hIuF8SqqgE2krjp0pMWVOv96EVllsQcc75FotnENidZ6LnyBBpKB2AAJiJVmnXiEITFzL0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d19dFQ9ObLVkmtDd9/LdlcMq4aHurzAyOH0o40TeU6E=;
 b=AzpX2B97svh5Wuy/GJoBF6bEb/gAbVdXk/8CGQ5UykmjMqk5utODASz/Uc6VtzcVpSIfAh5sPrivLaiJEwvhnV3N2bkoPb6OZhzFxxeFGq8KRbrZ74An0rZypG9ZaQv3AcGRnqUzpw3/3ckQ+zYRrf8eJJ7RcrL/Nu0V2Fz6P1eQQJFX0NO0MuUA/M43JFkvQ4u7p+ecjKW17t/xJLdPEnvX9hz/pny4o3yeNGHPezU93kI2jT8Eyv2XSiOh7M8QukfuBeiweZFUADylSVySgwdi5Nh2a/Qgb3C7InX44ZYP93AcSRpR/cJUUzyEzxWHrHKcD0iWyCWTH5k0+E7ENQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 14:00:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 14:00:37 +0000
Date: Tue, 4 Mar 2025 10:00:36 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250304140036.GK133783@nvidia.com>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303175358.4e9e0f78@kernel.org>
X-ClientProxiedBy: BN9PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:408:f7::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c2eb32-efba-4b82-0db4-08dd5b24f0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zo4YEoTMOeGowT7STkF0uzdRCSdHYO3fsaYUNHYoDv8Ft1cFyLY40EiQoUg6?=
 =?us-ascii?Q?QNcwYUY3oskjejYhoTDoo+3TgX9hS9qnOm8kj1WtgmkinDqfs/aw4Kq65tpJ?=
 =?us-ascii?Q?FbauH822G9oPvV2qSqoM2pk+MEguvP6WTR2v923658W3Xwld9QA7vTC7nFK1?=
 =?us-ascii?Q?Jq3CKy6AkTRUWHgRQc3RtfMuEnvCI8pHXQKsHLm5eMquBScJr93RF4opFiwc?=
 =?us-ascii?Q?Lr1M1jlpRr6Meq56edWnJYaZnDguxdAhG4nNtFuRUpWKFABqGBIzU8/j+xXk?=
 =?us-ascii?Q?XvTCDak99sFV1QlYyGT9/vycmquAIP18uGHc+p1/FprZmXeV7gAGMACSUhlv?=
 =?us-ascii?Q?RAeX2Q3HnXsWaGQiZasfenG0xDam4jRzUWgq9HAiiHIH9pV+IlF2SOmY6FN+?=
 =?us-ascii?Q?e6sZn5XWwfyVDWSabw7mlXvwqK3HlO119FgMr6uoV/56Y8pAtDi6F3hBWzh8?=
 =?us-ascii?Q?hkhzA2xYNeSP/skeGWAAttFn6yn38PmbwoehMtElfTp+ZmA2Bf2o2l6Saayz?=
 =?us-ascii?Q?fe+tYdlZTs5kD4pFtsuxZ0fc888WrmyaChp+c/uyp0MMao4ZKS7AjMlsLTx3?=
 =?us-ascii?Q?VfAF5d5lVaFDQcZPgQDTkuIajfo1xD1aP0MmaBtYJwlxQy+LbEF/iFNT8M8H?=
 =?us-ascii?Q?oOMUvG3JAETMIqrPPO9ecEGAyIb+3kdZoDoELQ4D3OGvuM173mkCL5xBCajy?=
 =?us-ascii?Q?cdgZJ1mrVYIk+H/CFDkdsZyVzBJ3jQJUyB3zu4cjEIRbcOgzlYhmz/qNB/Fv?=
 =?us-ascii?Q?OjqCVU4EChspzTU6/SUDi8t8i/6VW3NOsrOPZ8BylcuxIoWz0UD1K+Xow7iS?=
 =?us-ascii?Q?oXbhp4QKqtKCXpgIJqA8A9UKj8i2aaBNkVq/7YNbHNMQPX7a3NuqBJsCGRfT?=
 =?us-ascii?Q?e9v4VJHi0vIcP3Yq+dypOH5VR3s56j4GxKDPQ9t+QcMnQEwtRxDqewCnB2mx?=
 =?us-ascii?Q?5oBYv/NjdN338Lqnfk/IUH+RNRzvKsZhLq6bYzQc2O4S2tLGAiFE1LGRjqxx?=
 =?us-ascii?Q?I/eOeNctgmzpPO+5V/NtBuXJrvmIdcE1LdBTY6RM1VrdErNP4fEhD8C3L3ti?=
 =?us-ascii?Q?As28KMDj0pFQzm1d9l1fRVoectczbn1Z3eMO9LDnIL1E/JT73Hujvz9LQOt7?=
 =?us-ascii?Q?KpLDDYwc5wg29G1uIofhlyl7wKdfar1gCF8CoSkxk3KimYIHnh/xeEKIELCB?=
 =?us-ascii?Q?hcvv+NYFLEUYqInVHQwNm3icThrwzEQDyW+3NL+LqgE8e1G5IqtYgYcpIGbj?=
 =?us-ascii?Q?0VH5qpZ7/lG4F3F1wu+NApoFdi1dWu9cRPqxXuHMPn7qSYXBENqcLIZysCpd?=
 =?us-ascii?Q?V+hJJ4dDmRFpmpafCKz5823KShuyF9qEtvPIKxZJ/lQwbGwnN2TLnR9S+OOL?=
 =?us-ascii?Q?YT+9orCwAL8I99AywIRnYS+aztmM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vZT3kWhCpsyOGcEU9RAUeRZZciu5/VEsheoR5Ikoh3QN6JYpM09joUNoM+mv?=
 =?us-ascii?Q?Ycsz/tlDMCNJM5Y4QD14LYMaZcsrKWpQTd2XIOxgsgn5vqRyNxovaD6kZjAW?=
 =?us-ascii?Q?yNfCjqSADzOZ4PsCNl9BtDpw6F4dAELnQak3X7akwycb15+dQA5aEOGq0Wzy?=
 =?us-ascii?Q?mHshGBeD3x3lI7LTSaQSnGPggcoiqjJ+Go0CHACcqqi1BA+JEzuIzeaygsPO?=
 =?us-ascii?Q?FaPLcnFj69zJqvd1p3zu7Jg35UrnMLqMHJB6vN/BG56Idyg3Z6FQnaUAWrIs?=
 =?us-ascii?Q?ls+GF728P84opmn2GfXA+/JdTZKm4ujWWvezdTFzp2VrBVvPVa/gWD4Ig8b3?=
 =?us-ascii?Q?E9pp8A6Ol5avWryxCCEfhvdtnzCLXIbzX6YUXCuMts55b45RkF0arWkkrng4?=
 =?us-ascii?Q?VTocfKKl1dwqmHXfRM8H4hdDH589ete7ZhLi6/JGha+JrMXLiV7aNBbqLXfm?=
 =?us-ascii?Q?K9N3VV7fQ+8dN6hM3INrcJV2iWT7ecZfmgNcnJjw8HWYxc1F4bWdZxTNXKXt?=
 =?us-ascii?Q?x2z9dXMFax5X0rfN1AzOBW+ntDXnB+ORdjcAoOkAxmwDZh/ZND87Fq5WjaXJ?=
 =?us-ascii?Q?nI/omHQap+9rytT+G16ArhQptiPp2sB/v1t9Di8wUmKQ3joulKLjqBPvOJGX?=
 =?us-ascii?Q?NVRZnnsFrEYWdjLF6+dpwzJzDZvmr9l7m9fOLuXzdYXIe4ITc6wuX9PjzlqF?=
 =?us-ascii?Q?kobzT4/LbC2dNk7SkdPhnvcT3Gi3xSk5sXtsIIm+A50pknO+QgO4/w/6YuZE?=
 =?us-ascii?Q?jw6Mb1IbI7MHSxzWVXIouB12nbmLv6gVw4CNGTcZG1KlzeuXX1JSOLnEyxdQ?=
 =?us-ascii?Q?JwA6xuVFXSoHNWI6ELY+e9fTOGLPyVcUu52keGFdlbX5eEe+QSgWFcswDBuI?=
 =?us-ascii?Q?2X5VDYS++0eb6xwxWyuhTDD4r2OzjzE0BmlA9Ftp8r7/vzRIQi2zcXWYAv+A?=
 =?us-ascii?Q?r/Mu6E8GkyLrrkM61mUawCNkIPn68b9owrvJ80Ay0HbWe3kV+DO4PVUyTr2Q?=
 =?us-ascii?Q?BjPnWlgML4gy+bPvPFHhbCrjXQSB2dc3ccdLY/oba828mepKY+RFliyVgLl4?=
 =?us-ascii?Q?6A155SeF3etncwjB40Zek4W1ypXHbKKxkeMzkgpwC9TMgwr25AuXUInRurMs?=
 =?us-ascii?Q?GxIln3HjIuKc8KG5TItNfws/P/qkv1boOKmhTPvUrQIGD20LaV92xckcgZZK?=
 =?us-ascii?Q?+FwtKeO9sm3GxyQs83X6nayLTf/2Nb+42g7zIL0BZfD/GQhBPOxr9h7g49FX?=
 =?us-ascii?Q?dPez9DMGf3OOe5GWMGG4BAcdpcmN+KUv8xpPutUWAfwroF/UpSYBuqhZ2lM5?=
 =?us-ascii?Q?M+imAZxRwfgmZ8cGk5CSuRLOBun95SWxiv2CRYyLAM6wt7VhdrcRK7lKnkam?=
 =?us-ascii?Q?x95LI73/3qrNAZTktqc8qztfPiE2djBrTIca0Cvj7XTaFtRqE/KKRlSzApJb?=
 =?us-ascii?Q?azU2Yq22gMWnNsznWvj+Ik6E9cNICkNLzHg6L6t8DijQtx+nUcC/SEJ9YgxJ?=
 =?us-ascii?Q?80Ghzz5wMCI2IflRKMRIR+2LiOOfqIMzwZ3UAnak2k0sE8R66zu6TnXaThN6?=
 =?us-ascii?Q?I6vJAMadIoGamTJEROr4fH/CzJb2CCytjkI22Y5B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c2eb32-efba-4b82-0db4-08dd5b24f0ca
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:00:37.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40c0sWdsQgCH/rEw0MkT6gUZIU5lUEcFYNDPZ0Sdqn8p612GEVttlBdKuhe/3U7W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804

On Mon, Mar 03, 2025 at 05:53:58PM -0800, Jakub Kicinski wrote:
> On Thu, 27 Feb 2025 20:26:28 -0400 Jason Gunthorpe wrote:
> > v5:
> >  - Move hunks between patches to make more sense
> >  - Rename ucmd_buffer to fwctl_ucmd_buffer
> >  - Update comments and commit messages
> >  - Copyright to 2025
> >  - Drop bxnt WIP patches
> >  - Allow a NULL ops->info
> >  - Decode more op codes for mlx5 and the sub-operation for
> >    MLX5_CMD_OP_ACCESS_REG/_USER
> 
> Did you address my feedback? I asked for the mlx5 support to only be
> enabled in RDMA is in use. Saeed who wrote the mlx5 parts of this
> patchset clearly admitted on v4:

I never agreed to that formulation. I suggested that perhaps runtime
configurations where netdev is the only driver using the HW could be
disabled (ie a netdev exclusion, not a rdma inclusion).

However, there is not agreement on this from Saeed who is responsible
for mlx5:

 https://lore.kernel.org/all/Z7z0ADkimCkhr7Xz@x130/

I also surveyed other stakeholders on a netdev-exclusion proposal and
did not hear support. You need to convince people this is a good idea.

However, I would agree fwctl should not accept any fwctl drivers for
simple networking devices. However, "smart nics" and RDMA capable
devices are in-scope.

I could also probably agree to using kconfig to disable fwctl drivers
on kernels that statically compile out rdma, vdpa, nvme and related,
though I agree with Saeed that it seems to lack technical merit.

> Greg, I've been asking for this interface to be scoped to when RDMA
> (/CXL/storage) is in enabled on these NICs since pretty much the first
> RFC. 

You only started asking for this more limited approach in v4. All your
previous arguments were that fwctl should be entirely killed for any
networking HW.

Jason

