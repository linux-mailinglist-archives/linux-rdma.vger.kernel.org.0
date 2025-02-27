Return-Path: <linux-rdma+bounces-8190-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFEBA48A32
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 21:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93E61658B9
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9CA2702D7;
	Thu, 27 Feb 2025 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UPHKct0A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839241C5F0A
	for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2025 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689870; cv=fail; b=Jnz08BDIQlJ/nkZUCfw/oe3x/672Xou6aR63vu0NiNVYR9qiphXbuvPkVR9dYEHgKaZqyns9gy6K0OHyuAUbGKZllVtW6cwaEGuB6MTbUnZfg8ID9jCbF8b3eXkc0OxfMceqfdbm6HAewhUe0VTK8y5zd7ghGDACBN7M6/DY1i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689870; c=relaxed/simple;
	bh=c06RTx2w9u4Z8b96xtosz3SqfuvI30CWLmlZUPgKj5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rcjc2x5I3Gt2eBhJ4ANVCfWonrkp+61KlB6+km8o51C9qez4hGM8YRaG68LyoImh9oYBpYw+qNwt128E73XJnNJxnQwKnZEHBnvvmw5vMM/pw6N/Tqr+DsN3cC7ZB9HYdXt7ctbISQwacqxMsjXGzwdMrTenob6yldnsUcfsZUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UPHKct0A; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I87HFOegUk218WQzrLov4wLbaeB30etbhzbq9Q52ZLBbko35U3ov5CY0ZTjajW6qme2WBcJX7yQeoy93Ulfh92EtL0gM/a54MKe6p7y3x15hNflcWNlsnu2txe43voxK74X16C4MDhG8HqOS2cUunFXDo1zpFnD3B4WvqZKuoF5ORA7i8fidrkjJGbCKJ7DRE5GR7ST858VespRaQhqoaQEyfD8hEm5qTFfjnIAouVqqoBZhGvI3z9WJaGMYeAbJfq0Io31wLLAJZkS0APrvtMxXzcTDYqLfUNoiR7pjA5zJIKUNU5JYmskVRTv8vEmMXd/RO+CmZ3yVQMFGiRLmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1qSVo97XYccdT/RT79T5r1aAK9XFOdagzxgbeUnCIY=;
 b=SCpkb+2dG5vVuUOU0i3JjP+QKaJANIInQ9pEPxoX/kaFkh4hCTcATg5nDOktO5t9VrmnT+ApQ/3ztjx/UEDRfX7I97P36T2GEwoiN842jW2Y4lYeBbognULvGs59lhdWQCEl2QOp+3Gw3twGWLRNLqcKrbjWgdltOwJGvEBmiSrmtO3aVqUy8BwTDwQKZlNc4VGrEjYLmiLeYtSSO+sHgNGwHCMXlQaaLauUNY5ebXaD3z7NwGrefzIx9/lES1eOligJOBEMBXPKLNkfeZ0Myx/ekcCWHhfEqLJ1MpWsgc1c1nSESZ+eSsIwGILOTHgbrq3qdWRvGS/YMGKdJxBIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1qSVo97XYccdT/RT79T5r1aAK9XFOdagzxgbeUnCIY=;
 b=UPHKct0A9QuLJ0i5G/+5NRoltpk3Dop2A4Xyr0vuDF/4katKKmcKp6GEo10z2PHooqtv53SJVFXIMgqzx17gHvY8qhsQK1080xbxk4W42KCuqUDIZfIEamrTi41qURxsqza5l9b91iuUfTJsEAtAuqom3tuR9NhEILeCL/NswU42f9CCbHgMFq9WpOmsslZhnHN190JC3fn1NCNZ60g1Dyn761V7meWGMWSPjkziBNIVgZNiCCafhoRcRSds8XXCW+8IXTRMlou4VNi1CGvW1em9qsVsJ7KVxw4x4tpllNlgCqH1oikXetaob4W05GB21bmQq8SvJ15JXWEut+faDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 20:57:45 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 20:57:44 +0000
Date: Thu, 27 Feb 2025 16:57:43 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Maher Sanalla <msanalla@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1] RDMA/uverbs: Propagate errors from
 rdma_lookup_get_uobject()
Message-ID: <20250227205743.GO39591@nvidia.com>
References: <64f9d3711b183984e939962c2f83383904f97dfb.1740577869.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f9d3711b183984e939962c2f83383904f97dfb.1740577869.git.leon@kernel.org>
X-ClientProxiedBy: MW4PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:303:8f::21) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 4318828a-ceaf-4a83-32a7-08dd57716225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZA+jhC2fd4s7VQKVhI9Tq7PdFNJD4AWclT39+4qux3kXISdVnicCq2vrB/Fe?=
 =?us-ascii?Q?1RUFffb4q4GdWfJhALloEyQ7jIfCBTySWSpofWjpxsRI94pQRHZeo7mh3xdk?=
 =?us-ascii?Q?Ro6S7ROw9JvRDsr3L0S1CErISL4Zul+1vyY0S9iYWgZXP+1GspqBcWgWhWUa?=
 =?us-ascii?Q?RB+vo5EQMAQRsAAz/6reWWR1k70SzBdfv/6+c21geOaTqbfLT0S088Gj/nQs?=
 =?us-ascii?Q?vtnu+VhgVkThKstL+Slgd2HEa23BG6fYo0EQHw19Icr3JRge+UesazQukrEY?=
 =?us-ascii?Q?KJhXIudLKpH/Qhhl54lrNoTGkZfnlA5QSfjpfasH7aSpv6AGyZXa8RL4jye+?=
 =?us-ascii?Q?NdmrJHYxTVHRwL1Ha41UT07lnxeVzxBqaT96g7m6q0uedYdnIPwJLHUsUSeO?=
 =?us-ascii?Q?QFvak1o3U1dWIDM+ddZvBnXTgz86GfWKGg2y2McCibOWC4weP3K8Gws0+rU7?=
 =?us-ascii?Q?u5Qj+jHBgtOhBSSG3bo1PZsQzKlSMOIUllEr9dNQIRzvHYihWd7Vx8YFuZgz?=
 =?us-ascii?Q?xUvGUeciXt8QpwunUDIe0i7404PLphAckmgdL50aNf9Qj19ApP8rUdKOi928?=
 =?us-ascii?Q?6a0uOUwhMrey8ev6GTG76fNwg8ZeNwSeJbvf9eZtwNYKRediWWg38V2G4gnw?=
 =?us-ascii?Q?vg3tdtkoQFSCZNOnCX9N5EkJLEtKF8N9up5TFFH1GrH6/3MOMiH1ij65e5mI?=
 =?us-ascii?Q?jMQ+rF2tJp2b16iEiEKWcy0McxbuuEgpUjN2yzFMOgx6+UyH90PQ2/pJ4G9a?=
 =?us-ascii?Q?my4B5ytHGvEgGESdsVnSI6QgPtFZB/YgzymKLmKII5vYWoQwsreagL+R/40A?=
 =?us-ascii?Q?b6O71CIr3/MHAfeBl7/YLKr3KdCxK7NVsP5f2/bccpbMCHnN+dN+nejCJKcY?=
 =?us-ascii?Q?b+/R6j+siE1ZUY4AUh04BcPU0z/GXvyrB1fzWmOnMJOG+DiknuffPe1RIzYT?=
 =?us-ascii?Q?4hpZErRgtAgyQWYOplGIvbSnItc4W/aPy5ny2Nyf/+Wp4FuUM/vhqAuxgnsF?=
 =?us-ascii?Q?8O8H1uUexAFwdHuv9l3tJdoxn5u6G2okuvFflZLui/1lroccuiL3bC0P6u2O?=
 =?us-ascii?Q?0J0NiS7csqECTcpkgLRr/6SIkU4totMqOHYSg0LQM4dzM1/b/+MmPQE+vwVB?=
 =?us-ascii?Q?V6dVN1YfKpovQ9HiXEoieiJRyeh/CDx1xmS57A1W5YzX1thTfS/OYvmbWLnG?=
 =?us-ascii?Q?qT8s9j8/r+7xAZfJMSzq0Q3oxkel2KBtoJuZyJUlWqvgzAtm3Zvmy55Pun6j?=
 =?us-ascii?Q?+ocCL8GffZe64n6j7XDF6uH8Vq/vohQ5DGUgPwWT9oR2Xo2v/dG7xQzRTq0A?=
 =?us-ascii?Q?2WUFxJ3SRaaC0d7vNc8MBdsb0ZHXl7Cz2V+Kl+JFjb3BWyOpp9klTqMCaXJH?=
 =?us-ascii?Q?daM31UHSR0btcWynJ67FxSZFz9aC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TlR71DxhkLpdfo4Z9Ecs5emnSaWZjJp7mpFuZxZHK6vZoyTKiH2W0FOXWT9E?=
 =?us-ascii?Q?S5XHo10WkS5AmScXPUE/zEaKi9tath6QohlI6oSDwo2goq8qlNZ2TKYmaR+9?=
 =?us-ascii?Q?nwocLa/3GZn1JpQzwfSRtCkq6uC4OuNTH11mTQjwo5w/L1zNRbpE6Iw5Gn75?=
 =?us-ascii?Q?xEPWoS4Zy9BnJMQ88SUuSbFgX/BP0OqQjsuY73Lowl8/5tAv5S7PQn7k6MGo?=
 =?us-ascii?Q?J5JDZL/T9XSTnwmSZ5y05vv7Ad0nl9iA5ivw+q+RSMWl+zrpRiikjxlPklDM?=
 =?us-ascii?Q?U/eh07RkYkfqzmSmL+wm8h64J3QAwweieeIuV0hVVx+lCGWuM6hYJNcIgxWm?=
 =?us-ascii?Q?JvJFnccvIC73cghpEc2mVLjrlaJsqqa70LVtXd4irRc9Re+rW0T3pmOxetZq?=
 =?us-ascii?Q?o5OW9arIIKYKZb40BxhBo9cQjhbBU+bRgUEh/lM+eYRTINRU+ExIbMNC6J5h?=
 =?us-ascii?Q?BLIwy1bZIvYFHYV1vSFyjZTjQfpth1kP55j4bLclXE262rt11bll2wP+MinG?=
 =?us-ascii?Q?oQ2hdqoEKOTWFgBplvZpePZkhzwtbefVgBfIeMaAXLci2nbr6U5auhaqq3Gf?=
 =?us-ascii?Q?LGo+6dA/PBzwfVlmCD8Rf3qyWV4eIEmPqeti3nRd6B15dwgv1GHLLyCaGfyb?=
 =?us-ascii?Q?WBEk3LABRBCFjgIG5JZEZG70lRRFebaORprcV9HjB1f31EM657u1HeXjOKja?=
 =?us-ascii?Q?BclfSUkhuNPVHqn/97mbnNxbJ7P+gt74mPIjnNmcGjBNLGUCx7E8QvM08dqw?=
 =?us-ascii?Q?NnP+xrtf38UrmotW4jK1feuhMY4nFsK0zn0Lxf+4uLNhtPICWftPztcJv9QE?=
 =?us-ascii?Q?AuqmuDRVuXBEtG9MdML6eQl9HYH8zLpgw/pV5Ut6XvClznQsUTcHgNzb/fQv?=
 =?us-ascii?Q?ciWerNBi3Vv78I4LO1n1wwTFL7yWCCqh/G+sEGpjSte4g2JffAwDnLHKynC9?=
 =?us-ascii?Q?kquT8DxkoMOUn5Qc2NQDhgltnR48SAbzQh8DwzfmHjTJlrGCHYCLzK1cX1uv?=
 =?us-ascii?Q?Q7EjaC3U6vBG3zUzE3nF1pV5GyoWuv4hgfHO/hcuFGkCw7v/JUixu5J4hKOC?=
 =?us-ascii?Q?EsRQnX6Tf6kla/Zl1m30uCcCsyy+8sMNHrqR/tJB23mp2B+ojQYShuuJ+L3H?=
 =?us-ascii?Q?ALJp0nJ6TQrnOnpEL6pwxPnPA+yz7Ztz9Ny4HTb8Pn2UOTBsVwWel+Vvb9ZU?=
 =?us-ascii?Q?CKfLtIEQ2DZf3rKeizJ759illanR9Ch5hpMzYLhdteFNb8PeHtPxowLvuERA?=
 =?us-ascii?Q?iCtcw3T0p75cgxiHNol+lxjbA2d2u/4T2vtcYUEfVQPLf/VBwGaHcons0ZcE?=
 =?us-ascii?Q?N/1d+NBFQxGwhY+SDDVIOVY/Pz4lKXugLtMXDEO825jbXtNE3QSW6cRQpxdq?=
 =?us-ascii?Q?/TLu/mCfCdkU3VBXxJEp8aI7mYIPTvD5lBp+QKwBPjKeJpY39sDgMCcmFPs9?=
 =?us-ascii?Q?qcYi2aLo0cKdIi9yVWGY+KhgGX3ma5UDtekWJ0Ik4PVMeE7yo8JG2NX7Mn9b?=
 =?us-ascii?Q?FxZvR4DOlrKt1zzssJcW0nkOx8upkkBlEsHsCSzP5CwRkSChb+5PaPgmC9fT?=
 =?us-ascii?Q?kEoRfmoNquU0mMvHqGcry/MXJ0y9lt1sfkgEX5iQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4318828a-ceaf-4a83-32a7-08dd57716225
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 20:57:44.7936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4PEfeRvzGRAzwD/z02jFcqx8n0DFJ6uXpDmhUASVxxxTFxyawn5RtyOxrGlyr31
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749

On Wed, Feb 26, 2025 at 03:54:13PM +0200, Leon Romanovsky wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> Currently, the IB uverbs API calls uobj_get_uobj_read(), which in turn
> uses the rdma_lookup_get_uobject() helper to retrieve user objects.
> In case of failure, uobj_get_uobj_read() returns NULL, overriding the
> error code from rdma_lookup_get_uobject(). The IB uverbs API then
> translates this NULL to -EINVAL, masking the actual error and
> complicating debugging. For example, applications calling ibv_modify_qp
> that fails with EBUSY when retrieving the QP uobject will see the
> overridden error code EINVAL instead, masking the actual error.

I still didn't see an answer to the question of why userspace would
hit an EBUSY down that path in a way we need to care about? That is
doing dumb racing thread stuff that nothing should be doing..

> Furthermore, based on rdma-core commit:
> "2a22f1ced5f3 ("Merge pull request #1568 from jakemoroni/master")"
> Kernel's IB uverbs return values are either ignored and passed on as is
> to application or overridden with other errnos in a few cases.

I don't understand this sentence

Is this the defence of why it is safe to do this? But if the rdma-core
overrides them what is the point of forwarding?

Jason

