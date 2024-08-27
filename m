Return-Path: <linux-rdma+bounces-4585-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC90E960E58
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 16:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFB41C232EB
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 14:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03A31C6F55;
	Tue, 27 Aug 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JJGJikcT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01311C68AE;
	Tue, 27 Aug 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770050; cv=fail; b=ecRi9SBmVAojrqesN5+B1rraXrUbYxrZog7vZ44S6QUhZf1gm1+ffh+i65hXmoVulbEO8MC0vHZC/oOKfLPlJElXY28o5jTP67NtOvhWB+2aInJkG/VSnGijgNfiBz+rWohpCMpBhG9bH8JzhRd6LvsN7I//8Vf6ZUSPodyqvLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770050; c=relaxed/simple;
	bh=MnT1JSWF6/E1sxy3V5UcvDpqfPd3wLEXpi4/1mdt1pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BKeF+sfA06jqncKpbKIuyPWoV1Cjxnb8wlhO6idO99Vr5D9lhUk1esavmL1vwv18s5rCxb9ycI7PY7d7U3tys4WmiIqUO4e9m6wwY0HS4Uoc3etMq/3cCls8OLx1YWKLeoKKm7pnVdWkTWNOPndtF5pN+riFplKAmayQcY+myd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JJGJikcT; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWZ9Y1DtMnK20AUQZxcd3/kfPeztwSsU/a0FbDqBY0V/0yjyR6NuKFUtMxWFosd7iwOdi3JVJmBrKWgThqc21RsSC9bCqfyf78xWtrp9jLalWFWOP0D03Kowp3P7ANSP6ZwzsBCVBCAzTW5qpF5ERIS2zPicNWrD4rFrijjlQ6cZg52U1P83UIaiTb4gJtiSdKVWOkFYTGM6fMWMib5IBlZH8FErLJIqhBeSfjIxOQ8CGbNT/WQuL+DL+pXC8Me84X9UwqLdsRiXa1wqe0Cf1uhjMv+lgETunp2eu3BYeljBd91HtsKminQwO5y83czzG8A3bX70q0csYNjD2Okj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkhDqRFwGHsIPQIaA4uZR61YtSjvSeeW4lPgVjeHrI8=;
 b=EHRYDW0jiQ+2WefpFHsyho3erOXx7hjnEqq+5qEuWOZC8uNNH5pp87Uez9DFtBqZt7ZD9WWdpa9oRVpn8nji1Ig7wZjxKL5bwK8yyB2TLr3sHRD2g4ShowDeslzL3b8zWbVOXLIAqplRoVFO7WfS9bhxvJoGsO69UCB8OqRpipe24zk+wmWAxe5VJFQphWdQdT1FjnP7SI6OhLv7xxLT34VSVh//wToLbqpQjMFOg1iBgifmZb40goyMTeRSWLShm+VDSMhZ8jg5Hu6Yok2x3UbF+vPjNEGOglFWSDhUsw8tdbUzVK32kju0uqQmY0gxzZY7FFAVGdHrdDW1FqlozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkhDqRFwGHsIPQIaA4uZR61YtSjvSeeW4lPgVjeHrI8=;
 b=JJGJikcTVhaxephARQZ4DMl7nRSn0eOQhfYcV/J5klslwd0I/m+ToBRovRHZ/0oVFartO8SqUDH3h97UWGLaGyfWXltmOOagEtuHmrw5Jk54hMnBhCZ+hoA0bFzuEL+Jir/e55Na0pYcgrlVujO2S3NnF9sH3TGyKh2bppSkSjlMqrfi0qb987XEeBUJc5tmqidQNekGUwmE7XMonKwb2cOC/VKghzdsF3OOUoGo+eXRAiHY52GRSss4tMVKn6oSXiGZGe46wEXeJt8VC636RMCx6c6Hi+f8ISYMQNRGS6U1ZHdIkglgJi8wSf8hAUvCYfhNogYGixMdXf7x68mq3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 14:47:25 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 14:47:25 +0000
Date: Tue, 27 Aug 2024 11:47:23 -0300
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
Subject: Re: [PATCH v3 03/10] fwctl: FWCTL_INFO to return basic information
 about the device
Message-ID: <20240827144723.GO3773488@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <3-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <20240823151411.00004b30@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823151411.00004b30@Huawei.com>
X-ClientProxiedBy: BN9PR03CA0641.namprd03.prod.outlook.com
 (2603:10b6:408:13b::16) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ec8bea-bab2-4897-30d4-08dcc6a72a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n470u5piDOIK7emfGJrPj6EQPDT7VIMbfYt6GHhEGtn1sV733LFapfrO5Gdv?=
 =?us-ascii?Q?ezgHXbxOFi8+2I5wq3ytd3sgqfeAECeeyfTSl1AcdOF7Rp+SWXtOOIi8RajS?=
 =?us-ascii?Q?2+kutVO2FYXJSIvH9faLff4oO/Nvpql5jcB1X6fQnHLdTobwdFuvx+S9MbNr?=
 =?us-ascii?Q?eK/8H78TuAStVI2l12Nr3/csvrb/23YVzbfhlU0j/RmhOEZ2o5YiR7/9tVVI?=
 =?us-ascii?Q?53q4QG9/9vdmjggRdGP6CZ2Kr+bKzttRznNuj2XNzZc36Sk5OebTnYPSZMPB?=
 =?us-ascii?Q?EmSzqA1e0BSI904kjmwBHH00mrTbkS0G1tmkwuVrBMUPg6hnQr22L5ETaCZQ?=
 =?us-ascii?Q?5rFSF0hGtlidz1vg4omkDryscNZq66yVCdszyDL7A9OwKts4X8nQpqUpkN+d?=
 =?us-ascii?Q?zHew0Al11VmfbQirs6b2FSAwfKRVYEn8nz3/CK/OnwFxaeTZAkzDtHvYOF6Q?=
 =?us-ascii?Q?cdZjf8cZmhrYhm0+R9wLF6swkoSEQo3x6SOMpO43i2I3uQ0Jg1Ic2yJ2kfdc?=
 =?us-ascii?Q?NSydBv/hkZP5KXYhO6cZY3YkALHq/N6viDzd/UDBo2c2OnHOeQFY7JcBV5wG?=
 =?us-ascii?Q?HxpYXjc/cgC6hOhd24jlcVQZAsiPqMeWNQ7RVfNozXrcr1ufNG5plVNnxMga?=
 =?us-ascii?Q?cPZTkEhAGD2grsaG8A/9zB/uaRJup7juVdtTj06aZ6REPEuLLoOB9+nGL31c?=
 =?us-ascii?Q?Y0LSMWB7fNiXW+4k3of8eapbi7sxRU3N+vtqryaESoBwBwX2iOyNO6u7QHxA?=
 =?us-ascii?Q?v8XZpRyksbJf+gS8lG4j30aBefX6VbFFhz2R97t5zmsCAVqgPjDLi4oTU1YM?=
 =?us-ascii?Q?27MJWVXQ/RVYwVbQRnj/YERuubhtEPk7d0058DD/d4VXdyhiJ/6WFYcSudha?=
 =?us-ascii?Q?vys/M87hl165zEk71veyXbcc1+ya0bNJpJYT4NwrawXqRFqtnak9XMAXgvYt?=
 =?us-ascii?Q?6BhB0kFXmLg7EO3C+Rplc291gYAyEiqrUGrROEHBYhnelI+Jstb5PcJ2r3ag?=
 =?us-ascii?Q?0uQNBEb8IKMTK0go9SzuP87PUi8uEChFZUq44ybr1kKYXwV1v/nse/aVvsnT?=
 =?us-ascii?Q?+op+szZiwQaGtI4Bglvb8xHF1SMKjxZdQT+MHrnLtCUFkDTf6eXj0McJd5+i?=
 =?us-ascii?Q?mfDvwxOS7Tn07SAUDYce9rlh8mF7OufiPzduVeSyhaKZhJ1kw4gtbDm+zqRG?=
 =?us-ascii?Q?cfopN1fXG21m3IhQHKkDjeNzh8naVs9l2zKTlNeBUs0OxzFHMu6lYXuJrLei?=
 =?us-ascii?Q?3F2j4/K1SmSMaa+zrXfhC1bHHUHO26MvJ2GGbwkkt4v4ZeTK1z8Ao+2zXpPC?=
 =?us-ascii?Q?2/VGOH4A7ccugaZidzRO+s4bEIHnUun5q8xNRAenu5ihJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v/1BewSwDTXlXqaRw2ShL/SZnV4gVQUeTR4IPlrcJfJS9YCSyiAmiVZnPCIh?=
 =?us-ascii?Q?OscgCOBWM8gyBfkmdAZq+w3dw/36dpCGvX9Tk+jhhf8HiK4K8tFkb4VoOmcs?=
 =?us-ascii?Q?o4Ald65QSKDJG5o71x30b/RksRc44QWuqB+jKTb0p1kaP3MkbSf7DsjXlsyD?=
 =?us-ascii?Q?oeMio1Fqic6cfNtDhtEzWxykZdg+iZTcKPSq1X7aeB2N7c4cJQHmMy/cEnQs?=
 =?us-ascii?Q?odQAW1wpKSdEvBZcl9xRHqszk19LMGo+9RsZ8rmGqAradOHIiOgplHXKcANf?=
 =?us-ascii?Q?fc3YwEgKNuc4HHEQGRRQx7ezRolLlSCk8ezmNYy36Ex0i25KUs6ZoXzetrv/?=
 =?us-ascii?Q?yZTbpH7AXQ6fJFBcdRfWhtjnmkxWocTMyuz2wKcTcnDXqGpnUKFme1mkWyZw?=
 =?us-ascii?Q?zQ+WE0ISOestaJ03vgiPT27jDa/aEyHgyUsuAkmAMeteYxMhpFpSFMo8eFWM?=
 =?us-ascii?Q?TAQTWBmJio7p7QfbBLE++TSGC1CXhymQtn2jXQeDUuLP9naWTQ9V8LZt+G8u?=
 =?us-ascii?Q?aR9y09OFyXIaqcAvxZZmquXNQc5mz26uEXFYx+3f8z3o1m0+uY9vfg3MUvm9?=
 =?us-ascii?Q?M1syfTTexf69U7vA+DwdZ6EJXpA3AzWW5n3D/2+pJW1pacpNQz5E7+dBkcoB?=
 =?us-ascii?Q?UB8b2IpdwF4kDgwp5aKGJwUCg6pGKvP95TVT7aqJeEgbSrMnszXPhwLn8HkQ?=
 =?us-ascii?Q?mt/0owMQ3bvBoW6iaa1SfquRM6KNDApUylz3oY6k3vvWaJVahjV3JPTcmjPt?=
 =?us-ascii?Q?nx81obncIl14fbgFe8rH9I8beX03z9WZj2v414V0/h/x3Yqi7KyHSL0/d4wN?=
 =?us-ascii?Q?4uknrtsuuzV4ygdE8ptL/6fE6fb/vFtLW5CRaj7MfqicV3hvSgThdxgXJAIm?=
 =?us-ascii?Q?B/y6mJXPkhrEtbJROJyiU/DZFV2FXsiFiKbMW31ILDxco0lxxyAkk6fGyO5s?=
 =?us-ascii?Q?fcRczyeixRjHTBADkE5v+2IKJOk4uhQ8AwaciRZI/aOTodk56C4jKWTkMKe6?=
 =?us-ascii?Q?yGh0wWRyCSTQ72khdh+CmBpcw108/2IXrrBrd3a9UPXdWG8gsav+DlaTaHYN?=
 =?us-ascii?Q?xrXcgjd2FG6W2n1fkeG5zcbGuGasEhWdauGeCcFyv5SXavi2cST9Dsf8DaAn?=
 =?us-ascii?Q?4kx9iQQOBLHVVjPuNCwgw+Gv+jbuKkLsGadttbHr54gtJ5BtmtqNE+6TJVrg?=
 =?us-ascii?Q?Wr9EMx2N+0MnlECMGVz73FkJs6R+Lj0/TBV1maBB755LX+B6HIHkEh12UZKX?=
 =?us-ascii?Q?HyiXtbNm+nxslACG+h6vJuwc46k0imBB4RKLhxMjfP2ox2edm1V1eTuSnT6D?=
 =?us-ascii?Q?QdJW22ty9opzK85Rhsg94B2spkrtMKuQHO1bCPITaIdxJDnDQZXStT/JO5NC?=
 =?us-ascii?Q?24i2UaYsJeWV2bLFTQnEUA0hvYyqr5s1bGHcstMbBGFAG50gUV6lV6w8Rooz?=
 =?us-ascii?Q?jqm4stdYckBAXSTf9Q1Nz8BB+8fgRV0/aYTOgQwJvf3vYhUEFvSTw8THqou+?=
 =?us-ascii?Q?NMTYZHmJqZ5sQyR7Rd5dYiJj2F+4EwYNAY/02KXlLJADo6bEFOlC9QG63Vob?=
 =?us-ascii?Q?nkO5c1QLeKO5cDO20J/E64OQcx5gd/9Xhq+KpvJd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ec8bea-bab2-4897-30d4-08dcc6a72a14
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 14:47:24.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sf+UEd7CR9y4a02QeUqsc8N/q18D1OdPbk2zX5l9I2crahl3JE+TMReDCJv3Mww3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241

On Fri, Aug 23, 2024 at 03:14:11PM +0100, Jonathan Cameron wrote:
> On Wed, 21 Aug 2024 15:10:55 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > Userspace will need to know some details about the fwctl interface being
> > used to locate the correct userspace code to communicate with the
> > kernel. Provide a simple device_type enum indicating what the kernel
> > driver is.
> > 
> > Allow the device to provide a device specific info struct that contains
> > any additional information that the driver may need to provide to
> > userspace.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Just one minor question: How likely is the data being passed back
> from the driver to be const?  

I'm guessing not very? I expect alot of drivers will want to include
dynamic information about their FW

> Feels like it might be and should
> be easy enough to support either const or not.

It would by easy, lets wait and see, adding another op is trivial.
Allocating memory is not the end of the world on this path anyhow.

Thanks,
Jason

