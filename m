Return-Path: <linux-rdma+bounces-4247-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D6094BD95
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 14:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62290B2342A
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 12:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BFF18C327;
	Thu,  8 Aug 2024 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UKRTIAdq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5B1E511;
	Thu,  8 Aug 2024 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120499; cv=fail; b=F3dYZGwwvKqFr81jvye6oQXalZd611QGhnVni2ip+LrmbpAa/5NNNAsVmVTv9nHuucXZSqy6xFOXyrkDCsRUffqMyikN8q2DKSyKFPUPt1mquBokvHIegi57o6175E4jIi5mXdqD8mMldnJAish9949UQKLvBLJIzRfHS8ipKxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120499; c=relaxed/simple;
	bh=emwGwhzJgOlPfCUbDL5qE0UN+BNiBWFiMDg/ROfUIeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qjghvZMA4AFezow9+SNoo8Pz03m81Dx7D9gYOgagwFsvn7Q2jNLVKs9eqFM6SLPcAglbaZD8OpWB7UB6wEDe+d49iVpedwCPYBJSr8vDV6Obc6Z2COLUMDDfGd5DTl8XrOPqxtdhbXFOyxy6Ox0VgBxYMXtFt3kuIr68uLa4fNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UKRTIAdq; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqdKTjIm5fGp2ouhPzyUssZAAVsIgHgnAhfjNiAfN4StNXestDoLBcOKnRyyBsv1vwaD28nzGOEXuDKJUpdTJdcf4RPADVfGhFPJtCUMKkaZymO+Ql7B3N74z958IcLNmWY1cupnLHPbVDO8tZwfvHmZpBcbn2CRRUCb+4Pnr3IeiwCvb3nojIgLDOzh+xoObW5JI0RMQGq/mFphKyLkRoBeuRy55p2ky8PWNJ8LfC11LA3YFsAfMqQ86ZlhkkfhLA9JdKskTrR/sZ+zLXppgOz0imS3Z3Z5/8NVCRcKCuDO9zCztIed5gwSU5sdGPWOG/YZqwNJzUq/YjjA/lnX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQS8p/cR4KOtFaUml4dccRE1WAxIE3A+yYPXFgzCE7E=;
 b=LLAL7yPZ028oyMimdeD1Pd5Evgna1XvszX62KRW/5n/mzQkvuM9vpMlQRGZC7wqr0ml6JLOAEtkBp/ktM76i44ZLUX8ZDOAfAWEpJW6GySJoSepM+w7nH+ljqhtG1B/XKGuWAqJEMBy+/RV/tSyRkygvlDlXkyeFSm91FvkZGh4dpfSAZETWfwTaXXIeLEDQeH5teC1TOdru39whOZDUffmZdPmah+95+OqXVEWqazcYkA/Ke+QPo9qW2GI8ajcNfCia1akDgLfZxjuyV2Bz4c/eTtnVz8XQm7KZUxuOu6MUqvrGFlvWq7UkJjBIlStkobt4GUINKH5L374mK/OVqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQS8p/cR4KOtFaUml4dccRE1WAxIE3A+yYPXFgzCE7E=;
 b=UKRTIAdqFI/sIpFiyblqzAZdRBe8x1tOycZe+YzBPKqHU0L85u5v3w+YvXOtWo6X3dff3CrR0eKQLip6qA0HBJn+g5LMmVK/XeIgo+GQePPMWl/B2fZXSItBsss0pBdP2GrVaCPnYw16+fkuRlnsZubRLEz9bjWF/jX4tsXTI1knSP3x3MZk49/UiuJ8EA/lM1l6bs3KVev8MOlz6GW6+TcGh/7exlCIP0R+R060trp91VaBcSG0fyqJ6OdFmcyWeLih60WTqd/P/jcCNSsI3p9XAv17hQrvOuJmc1wkSJs1XsFtWBcSnjEtBwNEAnL1Ebu61ul5IiypkU/bISDc0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Thu, 8 Aug
 2024 12:34:52 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 12:34:52 +0000
Date: Thu, 8 Aug 2024 09:34:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 2/8] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <20240808123450.GC8378@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <2-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <ZrHSgfzb0lz-Qa9s@phenom.ffwll.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrHSgfzb0lz-Qa9s@phenom.ffwll.local>
X-ClientProxiedBy: BL1PR13CA0358.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::33) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: 610478fe-dcf6-4976-7c62-08dcb7a6806b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b8/7vbTsfLd6Fss2gD2rod20OgXlJBK3qgtbKuwskXDuLWXmEP1eyvd6/igG?=
 =?us-ascii?Q?nKkGpxispSaq+XHrr7fGLlLlD/z2NcJrz0wzVaFVxPubFGdqLHCAqToQ+oTC?=
 =?us-ascii?Q?DKeCUHlAT1emJ4igJO9w0VRllZoRejK5Ull7OTTYvKY3Pj6DjJSJPG24xznY?=
 =?us-ascii?Q?sRR+EoEqZQRUbfg0xiQmFRFZ5etS34wgHlo8sxYTQ3/cCiz/R9q0GkdHd7KB?=
 =?us-ascii?Q?bLhJv95eevnxMwXNrUm7LMjZE14q9l3gsCUW+8+sGJioWZ53J5LUxwlHxeJE?=
 =?us-ascii?Q?LCoug+lXtdGA9E72MRA3oBA1HW/OEordBhiZiOo2/5QA08akT+ffCA59KhxR?=
 =?us-ascii?Q?Gg1cF8MDS+GgX6a+s3AxwCI6RkjsiutVrzJm7T87p9knoZ/QalQejOB09kWQ?=
 =?us-ascii?Q?s/Gppa0QNDZPnjdrBBZR3p7Vq3+nQswP8U1aDjeToXudTG1wTlnmuJXEYgrE?=
 =?us-ascii?Q?pfjVWyzrbYcMHdt+l0UQ2AoxXkyEZ/GYmM3R/X4A6sNjGeJyE1FuY8SYulFc?=
 =?us-ascii?Q?xzKnrv1FFSFnup+dCUihQIv171QkWt+2B/I4P+9yHwdtI9aP1t+kDfAqt+Ml?=
 =?us-ascii?Q?kEMW5KWGSRnmNodtw2zlCEzmRycanD4YHJWo4qSkc/u0ttYs8hi5gptRJMNX?=
 =?us-ascii?Q?2HkxWi7Y6aopT8SJAVoO7zXOfYPyDeM7C38Ney4aqdURcx1AgtK364BXCJUA?=
 =?us-ascii?Q?T+W7nIHqsxuPUbgHOH9v9uyFRu7CTqjgrONRYG4WUZh7yAqLx95v1lmkoVT5?=
 =?us-ascii?Q?CxdjsUg3tEkUyUdOS7RIgZp+BWPhG5Bw6N3pUg1qnOwIwnYWsRZMAxA9I1+2?=
 =?us-ascii?Q?eztpV4xhNQuK5rlkCk3rSxVtT6RdprukvaL9wpWOWx/Z2ob7PkkFXYZxbkY2?=
 =?us-ascii?Q?SOn8Vz+BfFtVmkbhCn/gMoNNcUhg+CRuCtraf5w21+TNboc+Nug3iW1/e2sx?=
 =?us-ascii?Q?H77xhvKKWwYE9qkL6EAe39MsnBEStl/d89y0G0COcBi+ljfX90ODZv/JIy7/?=
 =?us-ascii?Q?ffiwlbuTtN7AhUu5j3jurgUP9k47G1K0SqI+HDg5Mw2MA9KH1faZvY0Llf8M?=
 =?us-ascii?Q?BxxXNSxmzbzeRGYNv8XSwSCje9HIDb1gWQeqldUcQgg0LSCUxggKjV/SDay6?=
 =?us-ascii?Q?GBpCbeibDgXJvTmzkmNG6MQln7RypfxtV/hCRx1+u5ujbTypjUgNLhF+fzxy?=
 =?us-ascii?Q?PAlQ9VftGuoWjRlGBS3YcjBbSjH7cBX7fEQcbTpfJ/RgZLCqYy2tyA4MqisS?=
 =?us-ascii?Q?4pDbMUx/duKKWPoGLzvROL2vTLB/Wg5USavgbgPCwU5UgPpm3rjZDul5/ocq?=
 =?us-ascii?Q?vjWMEKo/BfKUszwICuxEAdX091Q5tqyvo5RiBgIB01uUGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yPpH9+QQxkY4TeaVVZL9OVNoYzS7ttUcTv+xUu560VmMSjiee+xDMM+sYRim?=
 =?us-ascii?Q?N20wwC0w8z6K3SIPs2Jjht5V8wV1jqJzyqHq+UfMVxVGrYW1pchg65PsUCDU?=
 =?us-ascii?Q?3uDB01FMcTY39LWQ7bM2j/HjWLtOxwMam090i3+qrk9DjmROL4cjEupUQSc0?=
 =?us-ascii?Q?tHmCcQC1+IA9o0n7e9diZso2V5WIwdAcsB0rduD54CHkzg69HqLp24JpgyhV?=
 =?us-ascii?Q?R0Ek8LVp4/iM+TqkXE45PuvGviTNdiPcj3tqtNhooJNzkPV1kw+nW3SLzfF2?=
 =?us-ascii?Q?H80omf+GfFEfORMxQ3wU9QgKtfptjeM2QVSgaKxlU89rwHPxHbG/MeYczudk?=
 =?us-ascii?Q?Ht+TwHvyDnMkc5Ixsllm0KyqMLnWqRoIZ9mUu0rl+P3ZCwFJJtr74dDbMO2Q?=
 =?us-ascii?Q?zeH9pYFi4DD+Sn5B7+JlHrFRyJ0ciLlLFP+hsYiefnzYjinv3Q654wv6pL0t?=
 =?us-ascii?Q?CFEWbO2shm2PQGQ/kd09JRy9lQQCL/Tz00EvBJb4Pe57FYiLO6fsw6DXyF3B?=
 =?us-ascii?Q?mRD6MUf3xBiIaEcxXyq4KNJ/0iTaw17UrsOZlPUEed5pZYwErFoXODYnQ9kY?=
 =?us-ascii?Q?EWUiX1O8NeL5u4akNFDjdlfLTfGKN2n80cENOqGR7TLFXHxFDIQD4ma3hEZR?=
 =?us-ascii?Q?PDD4mgwKt52t/xQgzLzi0IdrkZ8+jbr39VIMxjTA3RPT4dd/0WQddO2RI6Ei?=
 =?us-ascii?Q?8XDpoC2BMLabkwGouaYtRJE9I51ijk1tVBY5JSXrk4ZZ1o/XHNmeJL084iY+?=
 =?us-ascii?Q?gxn3wNL25DW3S57Rx+UpByTFvVV4oEuZ3kpSAwkBwPkSxB3ftnpWhuImsq5U?=
 =?us-ascii?Q?Zf6FyLOvhT2V/CnL7JAV9vyYSoSRgZmgHSj9OCnVYmVn+TNH8ugaG63WwEQK?=
 =?us-ascii?Q?cVHFmFdhDrP1ZEjb8gVoi03MfJ+b+sw1826xHadUB38t6yH9hj/K0QxvVND1?=
 =?us-ascii?Q?k0jLAggpbn/vptuDPCW8LA+DqfeL7EJZ0GHFf9RUcw+hxhbt8Ivdu5B/R4fJ?=
 =?us-ascii?Q?9M30fCr7FLAZ27CBUFRUey5cDHMTM6RMcKYoOKqpVc+GBXIjSpPIpeZq61sO?=
 =?us-ascii?Q?zsw8eS+r6HYDhJoKbaOLWg5LbKFFzNztF9YNfluiaBFpyjZswbpYChuWkUKD?=
 =?us-ascii?Q?Y55Ir0b7USZV7txpc9Sd0ZdNTkE7S0LJNL38DFvmziqRaW1+DuU8VyjTc7b7?=
 =?us-ascii?Q?vmkOxqZWsNZKGZF2JVjopmCeYYYdOgB/LLW7R575//hEwCcnYnLa5Ax+Lw5m?=
 =?us-ascii?Q?1GfqDqFobsS0jKMkQYnlooQICJZwsCOBlQeuils15+W3vu/k3aMbajqjtueu?=
 =?us-ascii?Q?h8dgfHE8Kbbneq1vwihXK2HeiEkn8iUdMpJnNRLihL921OeG+hB1hv4uaFN0?=
 =?us-ascii?Q?eOcnobX3iyejP3hinUxXmhPrX8UDZyQyqXm5SWTfR2h2ZXeiDQhdqTWBtGfd?=
 =?us-ascii?Q?QBP023RLtv38hsQ6cLixFUbqOP+TEMEE+MriDmH9DLlRN52okG9+Sp8k2Pv2?=
 =?us-ascii?Q?E+LvcPuztmh+XfqpgcL0PVugorWw16O/jH9gKUWz7uaSVM4cTcd1xyBAOT6H?=
 =?us-ascii?Q?w11SNmfxS6ICfibSwjc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610478fe-dcf6-4976-7c62-08dcb7a6806b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 12:34:52.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ph/J9GlgHpZCweiQDwGOvoSu2YrFaq0wITPDr/lxJn7EUF/C0YYerjDmREflkHrv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065

On Tue, Aug 06, 2024 at 09:36:33AM +0200, Daniel Vetter wrote:
> On Mon, Jun 24, 2024 at 07:47:26PM -0300, Jason Gunthorpe wrote:
> > diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
> > index ef4eaa87c945e4..1d9651de92fc19 100644
> > --- a/include/linux/fwctl.h
> > +++ b/include/linux/fwctl.h
> > @@ -11,7 +11,20 @@
> >  struct fwctl_device;
> >  struct fwctl_uctx;
> >  
> > +/**
> > + * struct fwctl_ops - Driver provided operations
> > + * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
> > + *	bytes of this memory will be a fwctl_uctx. The driver can use the
> > + *	remaining bytes as its private memory.
> > + * @open_uctx: Called when a file descriptor is opened before the uctx is ever
> > + *	used.
> > + * @close_uctx: Called when the uctx is destroyed, usually when the FD is
> > + *	closed.
> > + */
> >  struct fwctl_ops {
> > +	size_t uctx_size;
> > +	int (*open_uctx)(struct fwctl_uctx *uctx);
> > +	void (*close_uctx)(struct fwctl_uctx *uctx);
> 
> Just a small bikeshed, I much prefer the inline kerneldoc style for ops
> structs. It allows you to be appropriately verbose and document details
> like error handling (more important for later additions) or that e.g. they
> all must finish timely for otherwise fwctl_unregister hangs, without the
> comment becoming an eyesore.

Done

Jason

