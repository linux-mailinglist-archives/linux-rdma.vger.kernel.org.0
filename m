Return-Path: <linux-rdma+bounces-16979-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEMSBfn9lGkUJwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16979-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 00:47:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67468152016
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 00:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D0B43008776
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BEA37AA8C;
	Tue, 17 Feb 2026 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z91YQ6CW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3F437AA7D;
	Tue, 17 Feb 2026 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771371995; cv=fail; b=Ee6LoNJ/fmsOfcR3owPqFTZsutYfDQj7fr2hU9VdIlT7mzeU4nfQI0g0q1DOs5d2yuDNSIOCvns02iYXrn1JN4Dsu/hc8U1qPfdu6oP/uIN6QTJLZ3I48ciAsbnTiRBK49o573fCLs7wHTRxqLTRJYoBSG6CvYu6UGqPfjgqe5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771371995; c=relaxed/simple;
	bh=hJTrLMu9jSAFJ37TNyI9XkOXxerP4Uur+OPz6IHkoc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eiekDCnzwItg+N09ZzOOt6y3N6pAlTDxdqQOp+6JRKabZSHoyGBviPQaBUWmiwn0Q7T6Y9oJ8Hvgsky8dIG74I80CiSPF7x0+NpvWIdHe18ZVB2P9HQn1jK3jqMA9aaR13Iex5THHO8bA5Kx9PB9l40iqJoTIHVI74+Td+bQnBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z91YQ6CW; arc=fail smtp.client-ip=40.93.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxY9oMLtCkRW/fhW31BiQIuuXzyB48953EUShVgsnEsVg25ioZT71jwmvhJqyzLw6X1N0KyQ5QWkrEoYFnM06xz4pWhlGJ3+cjBP+vrkaXZj1mnQgMSRfPtRDJAhSIfUw58OwuA8qRpPC9bMUTlcZwweUcJJ+6wS+SU/u/7VKEQJYoOSzv6eJFFRSbOtgpalR1K9h8iP9sEPvGrVu5ed2qUEZN89Aj3NFsXRQm8kkt7RJQfirgh1CTQmIlP448ugL9t64iHsFW1ecQ34JmbYOd4ErSGPJsDVDnKVY4DZJmF3d63MslKdFn5cEgCxW3lw9ZMHpKsPnbenBvk9JzAY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCtnn0mIDJUUKs4f/MRfJn/Q7KPVmSW61p8beICRYcw=;
 b=UeCvpu76Pj84YoErSy70nwcjpTHwyRIFBZbTUDnyXQgS+5szw/f8TXu9PAk3vz6rP4gzOXAPAQ8uQOOtDHKXVldLZfQvDMmKmJO5YLzhrb1ShRex+PQ430LjBIsE37ZqmiQKcd5PHsLbmyDgeWH7Va9n8GiKSaq3Ogfd6XA2D+lQGwOWxriecpzOwEbO5ICOX6B7HA8awOvjphyEIS/O5DRVDxj9mAUn5zzpzA7scyF+G0unhd4kfdtnL7oyANvahyskvfvLRTyd14OiFyvG27kcp/nC0ZE896j/22oGqPIqHGM/CMWBVOO19htIjRJNBR1kljf2gKLcLNlLuzpqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCtnn0mIDJUUKs4f/MRfJn/Q7KPVmSW61p8beICRYcw=;
 b=Z91YQ6CW9/bjncr8ybZrNTGbwHZnncYZb8bTJE0HbDULYUSDFzAsDO5Mbz7V9GHhuF2w0nJg2Q0CaFlGiw7WRoAgh0TrD2nmBhhIavyBEGaXK2JS0WQO0bcUVJSNYvoTfg+oNyrPObcMXtTwCreRvqodMgBTwQqc5oWE+lZ18qxWVVcZIVbhDjcJ8XsJWArh6r34pI2oyfWesGazO9TMvB1+sg6AfRDJmeC4sCChRLLiwnp6dyueza8qykvrHoE9/h+fTIjvmpVTEwvScABDxcs5vAEYfXbz9F9fr4y6JH+j/DV2S0NfZGaBaf+21zY8cTE/GHIK7bjPnCqDGTxUZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Tue, 17 Feb
 2026 23:46:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 23:46:29 +0000
Date: Tue, 17 Feb 2026 19:46:27 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Gal Pressman <gal.pressman@linux.dev>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	linux-rdma@vger.kernel.org, Michael Margolin <mrgolin@amazon.com>,
	Yossi Leybovich <sleybo@amazon.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Andrew Boyer <andrew.boyer@amd.com>,
	Gal Pressman <galpress@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>, patches@lists.linux.dev,
	Roland Dreier <rolandd@cisco.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>, stable@vger.kernel.org,
	Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH rc 2/4] IB/mthca: Add missed mthca_unmap_user_db() for
 mthca_create_srq()
Message-ID: <20260217234627.GB3804671@nvidia.com>
References: <0-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
 <2-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
 <20260217132356.GM12989@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217132356.GM12989@unreal>
X-ClientProxiedBy: MN0P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: fafc1643-e4e4-4e1e-1b3e-08de6e7ec56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d42+JrScO+qDSX0kdtuC9D1npxrEm6LPb8PGYe8iB9PB+IyznymswB3msN29?=
 =?us-ascii?Q?11E+7fb0148JuEbkcIRbXlt54yKwgCYIpNcR7Jc0lkwJMy5jzaG0DI+1VZbY?=
 =?us-ascii?Q?amWGBoUPiO+uLL/PRlAI1It6YhRQ0+yHwh9/9bR1GWtH8sUXfsPBbhsEzKxQ?=
 =?us-ascii?Q?PrvJL4kcr4dLT8UutAMxe3qKaSeOPY+TH0XIcuf57L1zSIVz3dk8l0v2DlEn?=
 =?us-ascii?Q?fJ8wxDIoW/dEk5ZCnvGCEdnJ0tNMOlKaMOoi2Vg4+PRSZg9KynDhIuw7k8XN?=
 =?us-ascii?Q?XSfJgTumxfCNWnvDIcjRkfi4Me8HD1oAC1gqAEhag1KgSn7gub7A6eC6n1BA?=
 =?us-ascii?Q?0V+TXFNwBfwjJ40xTUeGQHZt+Y2UVglPkIxfJUQNvhfNfGsuJn/Kamq97bZH?=
 =?us-ascii?Q?TDM+dXKaCSMopQ6Ny/Q97i1NHQpLozto4d/5Omey9XXtFT+idwLN/VLHgBU2?=
 =?us-ascii?Q?4TYYIuZcObEBsltaIAmRf7l/Y4pHEv2kuEhg2CVPwLnlgIZ3W8nzhopxpITW?=
 =?us-ascii?Q?MLt36kYorxJJ6nZsYS+swmbaGfk0xCSlE9Rd5Cs81LpYs7d6UVnXmbRLzm3U?=
 =?us-ascii?Q?blS4VlLaslb8R9/155ypwelDfeU0JrHfYTQamHZXgoKGJ4DtOcD6bTwY3lcd?=
 =?us-ascii?Q?P2oTYEXccSDe78DndFpaSctEapTZQmmLV+nOkJKXtSQ8I6IkQ6y2vnn0iyDU?=
 =?us-ascii?Q?OLUEglHk3gneYlRIJW99XIBCEBMX2P3yA5iys7QK8h/pCj/k0PPScNRRPy4N?=
 =?us-ascii?Q?yoiu0RvrJuHP4x+HaB5vMp9+CTM7cNIAEbv2njZ5cpolCRkQgoIiPjz/eZ6t?=
 =?us-ascii?Q?UzVK8AJj41jjAzhgEXxFPzytNmLXkBASOa8PnEEbdT1nV0TajXEuBKvAkFWO?=
 =?us-ascii?Q?Zvsh1/HnoJitVwySDmOtQbfQzCHfHOQzSSGvEBpltg1O/ssTKVCftZO8h00K?=
 =?us-ascii?Q?6gkQtt5fkTEZwM+rSoTKvSIi+a8ZfdvtlGX3bVd6qfUJi5q3kWMZXkAWBVSk?=
 =?us-ascii?Q?TFpt9j46DqppvkNUbPSqoXIziY7wQUp8nqV7PaGmgLRDDSUtDBhkuuc7690a?=
 =?us-ascii?Q?fMjc8DCM+1gP18cpMsg64krCZm6CkNIp7HwPYWVFjkIOo+IDKgXNMu00d1yv?=
 =?us-ascii?Q?uNmfFhN+sZUZlbRGDTK3MaQEMXyc9wNBdmJeTt58U9Wzof9jcSG9OVf237vQ?=
 =?us-ascii?Q?ws4AO31BWzdhveZsBGC46gst6/r0ynlAfD/owExyOpm+gTsgzFZ31uXdKuGA?=
 =?us-ascii?Q?G2KQorDo6Q2HNM3oaNjQXeW/nm9WSlThlUZW+FePq4LL2gwRMpCATfzUQtFn?=
 =?us-ascii?Q?uVV8mUh7jeS/ia07H+fM3ccPrPaAuPXYCty5DoMAF9BA871sTFoiINdvBjxq?=
 =?us-ascii?Q?DRHqm40Z/vdv+R9NLJpWBSOD2PYN5LNSkB9nd717lONm7wzTA7gu2vhhAbys?=
 =?us-ascii?Q?bVx2mU8jUFM/YRzlB7LxNYiJipWT+OEhl4CdBdiB8V9iB9wYKa5jwLzkIr11?=
 =?us-ascii?Q?gqjk1QC8RjleYx2VUkaZwVV6WDz3imRcclTFdnif81Ma6MSGRC8X6Qi9p9lg?=
 =?us-ascii?Q?WfG3l+s2oVhOiCV8IRU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3i78p69sl/vT4Cpc1U+Ubx6mNCK/amyshLGlndouH+oKAw5ZSCH1yO5EdrMk?=
 =?us-ascii?Q?In2eqDt8lw7ncnKy8qHtzAe0lNujZIXn9BlGZddqzDLRycbtZmNwAFnAcd99?=
 =?us-ascii?Q?kt1fpDzhYJerOcZmlVFonDhols8DY1KsJYr05YsBx2htX+Ukly0Bvh+C2M/h?=
 =?us-ascii?Q?0DqDBmMgAean3L/lAIfNVFWyVA5AnIDlla7us92zAPXm6GzkAciMhvmyEl1J?=
 =?us-ascii?Q?0ASfWBNJ4vI9E5K8Rxl2KYeGTa7lorS6T16tPCV+riirY98uBoO/pGyNd3M4?=
 =?us-ascii?Q?vAftrtNV0crRQUY/zgcFdeCc4a7WrORpaPY+oN2uY0SUodStvSiq8pLSUMx9?=
 =?us-ascii?Q?WoJ0byek1u3Xn6KnUpQAD3y27PmDUmFiM7CpZzM2xUyRWRE1yHd2zfZmQQgZ?=
 =?us-ascii?Q?8R+QHL9UjNf2eByiG9ZjoiMDjXwQ7msaqBvXDfkwaPeULqMWqyOXdQFsjqgF?=
 =?us-ascii?Q?Ys8njiO5vK7V+uNvtFkh7GB3T9pXgWuEy42QaB3aEN3uNUzi5Kete+QpAcHD?=
 =?us-ascii?Q?dEPWanO2qsJ2bb+xLiybIY5z2sE/iCXtJVwQgVbnhrcyKoZOims+Y9wQTZDz?=
 =?us-ascii?Q?Q0nqwOOSZO49mUj51fZF/CR6kwm+1MO3ATqvLvTT0SrVQ/Ay6uczy4c8fcEw?=
 =?us-ascii?Q?WV9H4/VMDOLTTa9x3MF6TK7nydrC1OPx5kjm2nN//vS/kOJ4kHzjipgevwAK?=
 =?us-ascii?Q?3pN17cDW4Vgt7DsUpunfRsotMz7JVC1q3N7pYbd/zuWxDrPCEEgk4sUe4IhE?=
 =?us-ascii?Q?PhxYrcnsewmDo5t2p+9V2g/vgbRn7Kc0z5r7lbTyNA8rnxHOk9R8I9SNB9BH?=
 =?us-ascii?Q?+G9h4WPmgXDHY+cS0+ky5GNKMFKEm4DESpoWL1N1t1An8HnjCZsJMdp68AE0?=
 =?us-ascii?Q?rGBqarzC1jlvYSWPMW2o8p5LYxu1ZOE74ys+MUCVWj6hrEpB0B9NRE9kDbzy?=
 =?us-ascii?Q?AHFZVdHsgJWoSn3rbGiZyoUKUcKYEKGko3xOEWqmfckSbO4ihb3KBfVP5JJu?=
 =?us-ascii?Q?+2B4ttlGfKDnSd3wG92NcZw3yrwgB6EM8Z7YuO9McN0DC8mfF7ZmH6nDm2Yb?=
 =?us-ascii?Q?7hk6eza6sZhGqnX10E1IyBkDu0vrW+gmUl4fS7hjzRmsqEBMmH0QEcJ96OzT?=
 =?us-ascii?Q?ROi8gtz9cO8qnuJbyacrqFoj8LlbhQn4C6+Ho5fdXthn8q3kfniwOsYr5X8O?=
 =?us-ascii?Q?8I5QExXEkybZS6mPULFCpNuX6+EN4hSw6glZXKVzhHitCSqVFgbL8ztiiz/E?=
 =?us-ascii?Q?jqk1l3/rCKUWvY7RM8YWWLYfFY8THAvctMXCEUl3ZTwZP0YPeT//The4ezdi?=
 =?us-ascii?Q?zAuQkV5QVskJmx3wiIjcHEJd5ytQdHTN8GzVHYRtHBgiYq4M/2fzFs0MfXSC?=
 =?us-ascii?Q?ahVJD82CDrIuc/dKv2dAqeKCmjVJXLO78q5kXO9t2agxCYJGYR/L/FM62uHv?=
 =?us-ascii?Q?bq/vMkfslQQLx920pjk5B2D17XXbaEZABPuhq3LLQCJbldmxRse0reyzU5FY?=
 =?us-ascii?Q?vlHk/6OFePKLgMaCiUNrfnu8yD4fF5LdOFEeTBI4HDvY2c0M0A918pzrK/Uj?=
 =?us-ascii?Q?D2T3u4fK2YRdk7E7Qh7ilFKnYNXjz/rkbDDlJTCafBpVRWj8cSoHiciCSUhb?=
 =?us-ascii?Q?dzUlsFYs/W7mK3s/LvhZzevnlNAG55JGKrD1OJr6zFA7ZF4mUIRHDllxyc/6?=
 =?us-ascii?Q?iXe60l/4GIgH4lPnaN1IVVX4plLwLvcHgCz0/UbLxGtk8tnQlEirp4ZgN2Vk?=
 =?us-ascii?Q?KVMUkQF+OQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafc1643-e4e4-4e1e-1b3e-08de6e7ec56f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 23:46:29.3992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLh17o5+3UjCa88+U2q+qUqIp23/NkgWnla9NnI14vIMcmzZMtnc6SMGXmg9dW2A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16979-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67468152016
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 03:23:56PM +0200, Leon Romanovsky wrote:
> > @@ -428,6 +428,8 @@ static int mthca_create_srq(struct ib_srq *ibsrq,
> >  
> >  	if (context && ib_copy_to_udata(udata, &srq->srqn, sizeof(__u32))) {
> >  		mthca_free_srq(to_mdev(ibsrq->device), srq);
> > +		mthca_unmap_user_db(to_mdev(ibsrq->device), &context->uar,
> > +				    context->db_tab, ucmd.db_index);
> >  		return -EFAULT;
> >  	}
> 
> The `mthca_destroy_srq()` implementation needs to be corrected as well.
> Its resource release order is currently reversed.

Er, that looks OK, this is probably in the wrong order, let's should swap
it, though I'm not sure it is even order sensitive..

Jason

