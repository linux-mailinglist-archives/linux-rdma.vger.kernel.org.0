Return-Path: <linux-rdma+bounces-8786-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F3DA67517
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 14:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244223BE0BB
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD620ADD1;
	Tue, 18 Mar 2025 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F95irHpG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D520C479;
	Tue, 18 Mar 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304338; cv=fail; b=D/x9SQBd3zE7/mpsHXMGmQB0rBLsM+Zb40ecO76ICjtnXxmrgzJ57WTobpvAmYCi5Fi8USqheB6IXh2/XvfrPkwShuElIzgXB7lSkFow9Qt4d9vNUyJuxB6d3oYMbUzoVMvHcYm/V+qYnPzg1V7/LaKPXeZqC3y0hW6l1Wy+y0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304338; c=relaxed/simple;
	bh=cWrmuqpau39+cJKSUodYyBjPSN1pcJPhaDl3rQ9rTNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O9Nd40fI2lXNY5XmmNagKJ/dgVZDrOyZ1U4wJ022GqrmlAYArshqiCBj0n+sLVd/XCsU4FjNi9Pon49szM/W4NU074aE8NAwhJzzHKJVzfDfpDy2BHIivjXwjOORUApUJhwjBgp85nOXm0hExfG//ZUlkoW5x5iy/ELY3GYtLrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F95irHpG; arc=fail smtp.client-ip=40.107.96.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsSPHcWLs7/bRo2WqX8BwngkRJo23h0zidmDjIJt0VM8cc3q+Iqss66sp0Vm0ZjeW6AxqN0LdCYE9kqprRUqP2VKR7iUgjXhEzQGh/Q9KHTzc/HDBIIXwGOAbNRwEFb+dfsBC2D4QUECuDE/EW0PdBakjPMZZeWkd4FkUYaOCqRnOozCjm1uQ5JhEQKaaNPfXtldna88sXDZteFK1uNln2lF44QsJTuBJCv1zLxwwo+qJJ+YEwQH+Nj/o8ZBDzYg2Hzymn6Xbi9Se3tj+/X/9W9IJZvgIxUYcq0+E9dy4x/Wbe4m912y1oEIigxmiEdWSEpEWT+1p8lozaXL9N3gJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uKkxegF+RepEfA55D6C6j1bU2S82p76+QiaHeU7mS0=;
 b=cbf70pH8ABqDGZfsrH8eXAa/LjDcc5wjzCvFM4LsOlEruZdTfXoUNLLMpX3849zZ+SYWITdiOCN+/mjzjAgC0guLLMrbA7+6sN6hi5ReQv8X3BxEXZ49Xy33lCTZ9U2uUrBxHAzwYOFVsq4Ls9fUdUTz1dLuMFcgc6MgbBZhUS1qN6shTB1Jiuj/7PHVXq0aIsnbIRhDyob9mSM7Znu9taPvUFz30JcryE77jvjFV/6ErMTk9DSg0mOV/+SEkPkIPQlqYAvC+81+B7WihV77B2xrA4BtW4EPKSGM4Y4IgZ28mOHsB5qB7ar97zABUOc/ZjCgAi8KebU/PgBocfTZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uKkxegF+RepEfA55D6C6j1bU2S82p76+QiaHeU7mS0=;
 b=F95irHpG3NVVqpYwx0UkC/wKjbU8uuWWhN0AXR/x9lJ9t52hx3WuX/iKVnzwzd4G8Z/26Pz6wvZba0IJ06tXQ1pYLB9czejwmfS+ECb6ehD9qsWAfrm5/mprQ2sIwGwmXDzsuHnkb2EP7Odb8foEkVvuC8ACLYlr5AYedh7UA7D3ZmwJitTHFsnDjZtcMsoP2oNi2qo1xZJCZWo2yYl/shdwgAIT+8Q6/Xt7V47mkduIAWWy8KwJQ5mwZWU70qxKW5HONMWQTJyT81/9fQGDAYQemlFTaEd3e0jZRVsg8aKgah6ftuVKr3sjZdRQSyYnkSwCv50KO7ccvrBTMxUnQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:25:30 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 13:25:29 +0000
Date: Tue, 18 Mar 2025 10:25:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>,
	David Ahern <dsahern@kernel.org>,
	"Nelson, Shannon" <shannon.nelson@amd.com>,
	Leon Romanovsky <leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250318132528.GR9311@nvidia.com>
References: <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
 <20250313124847.GM1322339@unreal>
 <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
 <d0e95c47-c812-4aa8-812f-f5d7f6abbbb1@intel.com>
 <20250317123333.GB9311@nvidia.com>
 <1eae139c-f678-4b28-a466-5c47967b5d13@kernel.org>
 <CO1PR11MB5089AB36220DFEACBF7A5D1CD6DF2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <2025031840-phrasing-rink-c7bb@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031840-phrasing-rink-c7bb@gregkh>
X-ClientProxiedBy: BLAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:32b::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 788b4ca4-372f-40f1-d50f-08dd66205a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b8J8Vd+aJsqt2PbSX7F0O+m2jdFSUwHf+ypm7dqR6Z3vgGLCoy4NACOnPYv1?=
 =?us-ascii?Q?1XQi233w1oZDns/Nm2q2HnrHl3mTuyDzxkumU+AWFb7FX9qdLCcmA+/mbCom?=
 =?us-ascii?Q?ppgatcT6T5bwY10tbOg/ttmZM+Py/2kV6mC+0lHOFG0MMomNjkaF//r/MncN?=
 =?us-ascii?Q?wNlu9sQnEMIJh/vhMEkdcHV6OUxTFONlUGJon4Yu7d6kEiGnsbIJ7SR5KdB6?=
 =?us-ascii?Q?kkgj9qbhBoWn1Q63Xoqlp4h8c4dP05EXvNz1rRKiTdQXjmLCQWWRnbObTRMj?=
 =?us-ascii?Q?K56JufvGSqi0a00+Yv1NVIAw4mIPVDg2jnDBuMEKyDBQHX0gLlNrkZN9qgQQ?=
 =?us-ascii?Q?bMCMd9NNrkHIDAo27ZB/vkgBiqA7cYvzp0NmfTmCHE42iwnXPC+rqsXHY1AL?=
 =?us-ascii?Q?UuSWin+Z9syXru+SzQghNozymuRm2lxuY7cZKrJPHut3wxD22ibVdqwa6fJs?=
 =?us-ascii?Q?cg0TIwoICqSukQhGH1f1K3VbqwSrdK431s5E5qnt04Z8MBvDfHBE/EyZr8Cl?=
 =?us-ascii?Q?hEKsInW6D6DWyvRmqbPZr5+u9dsqNViVwZRKiy6UG0diS8CQDqO1reW9sVu3?=
 =?us-ascii?Q?xMw/ISkWhPHVEho61g6PN6eQPr2nWvFvyfYjMvgKS7KWdZoZH+WeREkl/4ic?=
 =?us-ascii?Q?78jRcUgnc5GRgWwsFBmlHdguMSjoAwq6vITGQlB4eVRsGfIqfAhi3l4z9j6y?=
 =?us-ascii?Q?oyOkCGEYxc4ePBxWrVXTe36FWnWgDtrNvZoX1kQW7XNXQuvzc1U/Sm7hrvH5?=
 =?us-ascii?Q?P2aAzPl8yAHhIMxP/i2nnW6U7c02Oc1yYxIoIPofDXJx99k8FesjFSDiJlOM?=
 =?us-ascii?Q?/mUwN3pUXoaxtiJOi/Y9zP8lWH1h2ataq/4EwyS/TbytevkZ0J13cN//mbZn?=
 =?us-ascii?Q?WXkjaSyXBWN4yO4tWZZzP1r3Vd55I0WuJ3MpUXAr20agtFwAnBpuphDBHcFJ?=
 =?us-ascii?Q?oWQnvpt6dOGf14k1XD0zIrLQj8xRsMLtjipmCvCgpYnPjBGat+dhdmgQ6SDL?=
 =?us-ascii?Q?4lhr2sxS6CgLJ3usGg1dwAoMvBov0AWW2FsjqmczRSXhVLtOuq2EouKM0C6h?=
 =?us-ascii?Q?Ujer0lhguJWTGlqjnsPmHC4/GF2xoJGgjizTC98TcALgBZS2J6HmINMQ899f?=
 =?us-ascii?Q?pL6Ju5RfP/7u7jqU7F/BTIO17yfGetC9hA0pyQsFDwZC7ubz5dFuyZ8IVzWh?=
 =?us-ascii?Q?21PvvIvZsncICCLCfHrUBxN7zFvIhmYGGdITrJwoSjDJSBLXHgv/4EVIeE2V?=
 =?us-ascii?Q?z5l0GUBhWZRW5vDoTBJlqict5r8VSR95u+kr/FI+vBj9oNMa+hmJ8fhwGOJR?=
 =?us-ascii?Q?gdCxG61Z5FjSaLkFzd12Skw6zl19y7r0mIWTaRN/cRM0VnK+nqftIonPu7Bm?=
 =?us-ascii?Q?aYE8nBjpn3Sj3BxQXcHi6tPqiYWT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VVBEUo1UWdHCm9tlgeMHzy8d3w+jUX6pYwqJKtYlhTPVlkxjlDS3NTXCaAS7?=
 =?us-ascii?Q?0wtuJ+tKbCNYiIaE5kJRoFKudv8HXXwzNf3etCCihF1/jMkinMJTxLm8vK84?=
 =?us-ascii?Q?IbhmLfpa7jDDidh9UjizQ8Q8+6GrtcvpmWgChDljWU7clpTrxv9vhP2ZDJ3t?=
 =?us-ascii?Q?Ci8+dX2pKVph3Bjfi1nyZ4mcA7DY9UbB8vsnTXKaAD0Zsn7AFE8EbEGyQl5d?=
 =?us-ascii?Q?L7stMmJNIEdqaXQdOk3ui0Fuh/rLqBJFx4zQjFq9cyga9748H5fNLrtOhFFr?=
 =?us-ascii?Q?LYUC+j0w9wQ4tlglP8+BowPNnrm6WFGknOOI9mQFhktLJPHisKZ3IbM6k5Ht?=
 =?us-ascii?Q?yer+nLiYHCavpe1MGZ1Z7OFqpFBUbzR3IGvBcTwVCafHWrJUfWrMzRsS/lhZ?=
 =?us-ascii?Q?kavIsVNkdVqJAXj1oekIEEewjuUnrQDbFNwPK/KkYbD8WAh2WAW7o8Anw2dC?=
 =?us-ascii?Q?3SxXCDxRXRs++Gmquuc91TeH03ErKrzt5wBGI9Jjmiw7WqvZJYAM0lxBqn3q?=
 =?us-ascii?Q?rv2UKWnczSR1LqS+HuLeIla0GMfB2RmK1V3Lq6cxEUutQ+5JppGlaJMPthc7?=
 =?us-ascii?Q?3U9pVom5W1h5Xr/QmyOwj8ROmeYVB7f3O4mEpC1npHiG69W3NJLetekORXOn?=
 =?us-ascii?Q?k7uSE8fDy6qVpf5eelRZRJ8ijUDvK4LM+jRw6DPhZehI+PPLRBYImOqB88C5?=
 =?us-ascii?Q?z7K0wlEozVjWa6mfldsphEBo16w8HShJ/tnrGed3zjxNa9Z0A7/xsPnymZ23?=
 =?us-ascii?Q?hx3XIm+vI7d4+tP1Yk9odqwfS4wlOmdovmjhxbplxIkZa1dTDwwU3CS+OC/E?=
 =?us-ascii?Q?8cdzHmBx7jGTa4VZ0KINPiQbdG6+1wGoH2L0c49tGPxeliK2NZ0XM4JEIJpV?=
 =?us-ascii?Q?cQcPc8jaQ8wdGgh/FZkpM6No8WTDcLMKmecMVY2DeSSmCt+Nhn6CajWYyvwP?=
 =?us-ascii?Q?ol8+QWupIZ6BQy0I+P0Eh4u96l4L0bPn1on0LsqXKN0NNLnJi/M9tWO1fycO?=
 =?us-ascii?Q?MVGQBH9CPPFuaGmADwypxEdIGE+LL3JAmGDIZcfvUFpFrLIO+6r2J3OMjZdl?=
 =?us-ascii?Q?3O8wR2OpH9ssc2Oyc8iAobRP6g3DyBB0wWfeX+cen3wONsTv32+xzA/2riJi?=
 =?us-ascii?Q?Rcs3oxGlAq8n7hYTHL32qO8vVk3ow1uv5t7JQn6OIw2zmaxsHrjpVGfP61Ul?=
 =?us-ascii?Q?i86/XlXws4uGUfm2AFSbbf0mqn6R4nmW0SYiTRnzsYQ4jZnC5qnXBcyHT6O2?=
 =?us-ascii?Q?PBCqmXCeK9EwEl9wYbJlFJESbtPq+VIRjMeWb3pdZJYLP/V6W8iftPBKEa0h?=
 =?us-ascii?Q?544xu1WAlR/dnhmCvPoMTspUPt7r+/eo5Vw2WBbBzr8/2novukWtLStHasSJ?=
 =?us-ascii?Q?MAJeaoX5q997HV/RKf3x7g8lobduXMvksYWiUeGKh80oG0bguxx4jBWp6Y6c?=
 =?us-ascii?Q?pYuCsPrZ65lE0Y47bE8LPxYerzyB2nYhx0mNWt5MldNbm4VQly8DEmig1Rxr?=
 =?us-ascii?Q?xebPsWSMN6wOVrWw6zLtcGDdngt/lDSX3sHX6gau2O5X056dIg7no8KebetZ?=
 =?us-ascii?Q?8WXw3oZMOWBNghG8X2Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788b4ca4-372f-40f1-d50f-08dd66205a56
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:25:29.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +p7G/YdlGYJkTlRB6FAjYKb0ASTa/67grei//Y0pNEFbG611cefthIX5XUeFjiUr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906

On Tue, Mar 18, 2025 at 02:20:45PM +0100, Greg Kroah-Hartman wrote:

> Yes, note, the issue came up in the 2.5.x kernel days, _WAY_ before we
> had git, so this wasn't a git issue.  I'm all for "drivers/core/" but
> note, that really looks like "the driver core" area of the kernel, so
> maybe pick a different name?

Yeah, +1. We have lots of places calling what is in drivers/base 'core'.

Jason

