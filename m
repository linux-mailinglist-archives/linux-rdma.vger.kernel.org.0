Return-Path: <linux-rdma+bounces-20024-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PWkClMT+mlRJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20024-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:57:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF7F4D0BBD
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A6A8301727B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE41C48AE10;
	Tue,  5 May 2026 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lziqa25C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E9E48A2CD;
	Tue,  5 May 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996420; cv=fail; b=sBWuuXzayl509whV9Lr7oAlOBCt0Y5p9SksVci0q//ZDpSO1vzXmx6xHlsuU+kr+EhvSCFeTwuVe3ZcQJiSl2+k72Qx7NnWbJl4k1cyAl+Yeeq62mhx3icWpqWnm/1NJy5jGjxU2fk+w4twFF4Oy7aMHy8LxnwPyM+qx2fQcJZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996420; c=relaxed/simple;
	bh=bCSUGQ4kht6h9WyGM+IOw44jWI65miEVoLA9Fw9oL3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hMUudFlhfY85+TAGiGSgYwKVRaqIfAJiq3q0tCvJ5j+bDAEJ52HRl/Tx5RDQMycxODi+8OjK00Frd5trnGl/6+BHdaXziS/bPY0WKRJkFkCSVdQqOL8lV1BD3W7cSof3mDD72N38y1Zu645AwvHUraFfF5wNJVWLYecj3bko62s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lziqa25C; arc=fail smtp.client-ip=40.93.195.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+RFvGcRrVJuMLGfGX6WOXWBoeaIlNVV+pMN7BA4zk+QYnkq89YFvX06NBGIg7lUbrGppnQd6CgdkQupeABPSekTvNkwHx/9B6Yh9rOWFYpYm8xP0A9qv9AJ2GTHMW4k3gJNkG8GbokX2HT5+fB52RMK5FMgF0XVoe37ZpHrfwnHOhhVi2ClxlUZ7vHZjFRQHokgDTtdFTczMSuj/P2vdj0j3bq8WyMjJtbgLmabV04L7S0pHfJfFYywGwhuK0WRzhY8PQsu4UZzNu7bDRBOtWx/LKf2iGl3nglCMEER7Uae/oPs1xb4uEJcHrtqfqfisT2bGd3H81CTB1hu7X79mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tjTRlnBXCISp5MSzdfPsSD8kTaGRaGdfz4QgLQNEdM=;
 b=uGnhJg6724WqYBwABNWA/Fl9oR9qIYiVGuO9OhhO37pdD4Xtn9Yj6r/f+eDyhXqi/4LZAUscRflgWBpWQf2F2fYtU+ggDseECfT8rfUvgKV1G6K0o1VE3LHV6Hxt0wv8WlmM0CYS5des8Xu5PekhANlSqdK6U8TViuWluzbWtb1YRMNHUZ+9IrAgz74Zq84K83tq4wvhGHP3u7yR9cZ5Ke3h5t83rc5Yh+9QN4cb+IKH+p9O+009ZlbMzwkoa2VOdEEC4azaEnTuEoAChVHOsDhSzjTgPcqDlQNVmpceyDnw/slm+/8H3Z+89bUHomRAVhYRNfYByCGlVq84tFNo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tjTRlnBXCISp5MSzdfPsSD8kTaGRaGdfz4QgLQNEdM=;
 b=lziqa25CyNhvKsoshYflIVMK5kHY8+aXiV9kC90OtEz2A9DJoGQSiolnii10ztV+56LSpTgZJoRoA3qPx8t5bTTVGrvnS4s3AAieGDCTpFhR4a/XO9qJtMYaqDSRuMxvXl2AYcDA1WX6Zl5IYjcSJYCprlSPLh6TeHruOByLXLc0e7Gi5tEQ6S+SrjYAwZvzbQ3WPp70LvmcxetpsqiOMmxaImgYoGO7PdEQmFTXeOrcnxM+DMZpEyxjddW6tsLnT092WEuERbkH+98RWWa15mdTEax6uIpT+PyNGSVF3GuFomspYN4WD7wiGcjJsXNEMJYxK/h96nBDwrlmtBy7dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:53:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:53:35 +0000
Date: Tue, 5 May 2026 12:53:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 08/11] vfio: selftests: Add dev_dbg
Message-ID: <afoSfAj13MhbP30p@nvidia.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <8-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <afkMenQ_gfmLUJIy@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afkMenQ_gfmLUJIy@google.com>
X-ClientProxiedBy: VI1PR06CA0133.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd25c72-3e39-4874-cae3-08deaabe7703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DMSU5TrQRItHiwx/nD8yUlaIx8JVI7EIOR4vceQZsm/PJXFTLevb/IkI+1eyqR+1AodKOTfvaPiR3u5BK74+w4aBCSUAPHqOOWu+CMPwsjdrvNX/IDVFYAuOJWyaOIikLJhFRvzPPT6//Ze3BFGkk6cEUwbMMWrufDsTGm2/0iXjej14PHfM04QG0iqyjkyIIagHCidROujsn71Weerhcrgvfxq8nvB2h6zRXSLBQqGO6T1n78BGGp1gbKrTs5EPWaed5+VKT2Entypj7IURpmw1efeVN2/wfYlObvwFkrOkkfga14LQLCu8lLmup6mKd60Oj+7QxQ5zrK6sx4d92HmOHwDHf9EP2x1m1QW2xCSsc9kCRRBjoesVnO4kLbnvDO6iLtuX4yGZOKdKPLQtQhbMItLat9n3vPdKdZTzRHXCBA43sFUGLRhb6RH/XivvfnGiXi5UsxNrnfnkA2Sik+KagqesDfVVsngBAPOLyMSBi0zeFH6vY8G37YGiUgB74loUIgKCmgNoONU2wB+HmDKpMkeBL3kMLJyLxEGcUWyEiqTD20QhI2f+G5NoTqxvGuox2Z/4n4+qsV00gUVGHDMohQZ/YZWCYGmaBiQPWrTdMjMfLvJJy5LuqmbMF5Fygu5iorcqYVEzyY8PLWc5FEAjNzaPZrldXM6CQ1FbQR5gWDQCy/f/dYQTd8TfrM0k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Du3jSWpnxPxGAWx0/lO5onr4FHotQh30AbLQWSAFrLubcw0DViiP+nGluB2?=
 =?us-ascii?Q?eX9h+fooKrIRNnKi5Q4+xqq+fvop43ykwQJ1UxyY9SBBEc41OWvhu51A4YUX?=
 =?us-ascii?Q?lg+xWCe1IjRUhDIHB5d2n+bfa5VFBLucWzGEC6eGIoWUuoVE6XCTVWzyYpUj?=
 =?us-ascii?Q?o1qOcIf4qnLPT88kBa0vRXN0N9eA4M1kYLK+nXg5hDvN4llX7TBd5UjpMMsF?=
 =?us-ascii?Q?tBmqLoS8JiWpH4OVchImbLRzEcirGc9ITLv/GWxdE2PkEDn7+AIuei4BBoPO?=
 =?us-ascii?Q?PXMkOkK6nr+45aFSgfoahlvUNZxYQ/rYnBFNvbXDupm1VVNXfY0wnJj1XLDI?=
 =?us-ascii?Q?V9r7IzO9yx9ljTLLwU5wGxC71IttlrnHRthjlSNZGYVMl2LpB4fbNWAFa5ma?=
 =?us-ascii?Q?v5mI1wLF/P1CUixAKujAUamUryPI30DTLvjDrwh3jaEkmisjFpc6t8QkPdei?=
 =?us-ascii?Q?ffQ86EyT7jkEBqgQMyl0OgmChwPrW2H4OJyFuKzgLdnhIhMMU4NCooN9lW/5?=
 =?us-ascii?Q?L4i6QwMLfDZfQ6f8MdjcnebtEqysvr58c58E6rlEQ39Y590wZvUh/o7XI5FS?=
 =?us-ascii?Q?SLHWBFTkUbBHIQe0e4+QPSE44HqAvUW9R8Q33EFQG5h/WsjVl+x70aR/gon7?=
 =?us-ascii?Q?EtmAAw3pweAdIU8GqUSE6vrCogx48AB0LpZe6TEoj6pKZEBcA6IY4KhUHMDQ?=
 =?us-ascii?Q?J4xidNkoDA0e5aECt2Xan01YSn2io6SL2fB/DHC6cxql8ibTevrM2ooTmsJT?=
 =?us-ascii?Q?YSqM+VhV4VePppYJHPJrqfdWHXRe1eGvE17fdfoUl/7WRaB+Oui2rWPvKGjy?=
 =?us-ascii?Q?kOlJgVi4ifJ/EcZmbhUsTuGH3EQWWpTyiH6qIbFPHOgOyQSf3WQfkkcqfeXm?=
 =?us-ascii?Q?ib6o1t+tsgyLxm52nSQnEHRwK+OmuDHh0M/QfLjoTPHviul+HHw0aKpR40VZ?=
 =?us-ascii?Q?YYBDS1c6AgmknyqLfFVts1at6PGXFoCLue+CVmmWbfQASnYGWcHAOkWuJ6xY?=
 =?us-ascii?Q?gAY4oPdZYcTMZ0z62oPe4Gf+1jEzKtgUc2OkGJJI7NcL9A7NZcVDQLSigQ/0?=
 =?us-ascii?Q?u6F4lGV0W3TC/NwOTqhkmKQyJQv4hGeRsFNJgm3JnSGwQhyZoFJCbszGYa0D?=
 =?us-ascii?Q?PAXrOEIxk1xbKyMhpM+Ma5td2uf3xymMNSzEYsolsP09RJJcTuSiOx/AcKYq?=
 =?us-ascii?Q?55Z/rbIObdpxswbBh6f01vlWLUBVMGsU3oIs5iyxXK01KOsvIWA/JQiHp0wg?=
 =?us-ascii?Q?lhIeBlcihTuGugF/go2doTVzX9pfF6Iry78T77wN9ThPelINOXQa7nZeOCXg?=
 =?us-ascii?Q?1deGhaPOK8IEgMIL634q/JvlxbGrgXNwPVW4O3938Miyb2s6ZDzjmEh+bVt2?=
 =?us-ascii?Q?5U0I1+Y3uHC6jhlAh9VCpzRuz9U3uD2OMTsn0UamgZeDKs5wWL2eDcqhLR/q?=
 =?us-ascii?Q?AYDMYR4lCApVYmG3g1RFgfbMUk2hfPB6q6G74d8lu9WJWr5E9EXEASEmtdjs?=
 =?us-ascii?Q?36FxV4JhIDpLw2iae0N8cC7XNPHEWxxEMuVPlmUYQ++1jDMB2rhtbDFLiruA?=
 =?us-ascii?Q?ZVvv+pkYOJftFkwL/66Z9FElaK0KfQlbYP5YxpRY1Xsf2O4f0W7bmK0orL7v?=
 =?us-ascii?Q?bwwbN71XN6uYatd/HOifN0ruPz3F6+XiQPCUDrYIv5amsF+tQ+YQz3KY2bb7?=
 =?us-ascii?Q?d2aKoA8yXikD4eoH7/wObrXvDiQnEdoFL6oGME1hAgxNIaEd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd25c72-3e39-4874-cae3-08deaabe7703
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:53:35.2100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTwW3R+8cMXC1bpAIDkUBBxht+VxuklNeFpJgzbeK3UCRpSrMGt1SXTgu3W2ctEg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
X-Rspamd-Queue-Id: 6EF7F4D0BBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20024-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]

On Mon, May 04, 2026 at 09:15:38PM +0000, David Matlack wrote:
> On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> > Enable it with a #define DEBUG at the top of the file. Allows leaving
> > behind debugging prints that are useful in case future changes are
> > required.
> > 
> > Assisted-by: Claude:claude-opus-4.6
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  .../selftests/vfio/lib/include/libvfio/vfio_pci_device.h    | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> > index bb4525abd01a22..2d587b988c09fa 100644
> > --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> > +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> > @@ -38,6 +38,12 @@ struct vfio_pci_device {
> >  #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
> >  #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
> >  
> > +#ifdef DEBUG
> > +#define dev_dbg dev_info
> > +#else
> > +#define dev_dbg(_dev, _fmt, ...) do { } while (0)
> 
> Can you add something to make sure the format strings are still
> validated by the compiler even if DEBUG is not defined? (since it
> will almost never be defined). e.g.

Yeah, I did this with the usual "if (false) printk()" technique

Jason

