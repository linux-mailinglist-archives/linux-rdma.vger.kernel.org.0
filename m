Return-Path: <linux-rdma+bounces-16981-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL+mJV4ElWlRKAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16981-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 01:14:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF801522A5
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 01:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01599301E3FB
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 00:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0F21F8AC5;
	Wed, 18 Feb 2026 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jSzA9BSE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E169820E025
	for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 00:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771373657; cv=fail; b=Ugp6Iqwq0oBtFuiIF+ch15oYmFlMtn6d8ZdOquyBTLAtLICAZIC1hSofuEGPJGXZVxqdpBaIL1Bfe1EfA2lRt9eP/hzuZZRIS+QsWZHgbIKjwJDebFg6HF0bZtVc6ltyKLnHwsgmbFU2SG72btcgjiRf4obEDH4n+9f8wkKm/NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771373657; c=relaxed/simple;
	bh=HpKwjRg4s2xlSSiXWw4P3gx8mCfj0D7KCFK+WApedZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BUh5oM1fiHs2WTd5LkHZDQwUeeTYRMGsTDVwMlF3LCYr+bXMSK9gLoJv1XI6TwL337EjNxs/1LbOcW3bdnj9HNkL/7A7v8uExxVqDWa3hxEUNe0eGgLWbVIBso2pj2sjGMJv0/cqkfeepRRE7xgae0y3Dz2qn++c87ocIcqoMGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jSzA9BSE; arc=fail smtp.client-ip=52.101.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/x0di5nO3khhDlsLs7NX1xVjTIPCtL+wfsgi11ldQtMc9n48uH1mjfaXqo344dwHD2dBW+fx1azA2DjoQnsII0YRTPnA9c3jvbwSoECGIjA/uCpETzaNaOvWaSaK9V4CEVJA8nBGG/b1WSf8RKuHmGNEv0WYiBBO+IHaj24jFC8xQ5atXmXnHVskUzG4kGKikdyQOywR2avxtlRQy/2WFDT0RXLq9yfWYPBdpvMuXnTCjYW/U+Xol8ufujI363t/hZARdbjUytODCholMv5njJ0oxI5pHgyDlfTRXeBOgEEdkdtbHZ5iPl76X+izgP+ZGXcX7zvmKpqHq8slyM91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrKGa5j8TpN5ldTho4VVFTdjDxImXS5DxTrk37MOOsI=;
 b=QyWfKTks1myrh+TE9FPtzoXArZD4wZJ4E8aBOwqjbjACbDPPAc7Lf2bvknnWItpvCk4d+D5oGiy2AeFSx3sXrEUMguGs0TNRVQ8qRNPix57S4QMU/ebJhsqPf46DJ4m6IstfJ03xgXJZG3hFbHy3FRj66WGh8C4YOwUnq3yWNIa5qnizXuAvacoHMX4sUG9uY5I8zVUx4Z0HZyP+vi1Aotz4+UnuCfBt/bt2NUgiMx7IhNZM8MEYUDIUBjvfidyBdPkidvJAj7mULaMqdgdmYYf6wb32HomrMzOkr1pApizvpinixoFIMa1i3U6m46Xk+yFVwXXKQqmoprS8cHlxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrKGa5j8TpN5ldTho4VVFTdjDxImXS5DxTrk37MOOsI=;
 b=jSzA9BSEEIFOlBxbx4lURUUpPlx+5KcZyxghggYwdjCwxbCERQYeGpidSK/m+pWsagL0sSzzt7wkalVRZLPMSBc19FfTDHcpKUm+rPW2cRQAKJceLvTlJAAxq3viy6lTU/mhJG/X1JIewdKLhNGSgqZYGLg4ttkD6JSu2IARS9ZEk3ACmljIgsOyO7Gd9gmucdomOt9h+imS+dGmiuHVhQ7gBJzNn7NeeUA1zOz7i03zRXSl5sI6h/8jhnVzyq23aiGWJmM3bIDMuzqyfrn+dA9pgMrHK0CgI/0yN8Zw60j82gnqeblDtmvkOspkK2zTFvmqZXcFDaMoFI16k1I9jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 00:14:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Wed, 18 Feb 2026
 00:14:09 +0000
Date: Tue, 17 Feb 2026 20:14:08 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Gal Pressman <gal.pressman@linux.dev>,
	Tom Sela <tomsela@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs
 exposure
Message-ID: <20260218001408.GB723117@nvidia.com>
References: <20260211131338.GA1218606@nvidia.com>
 <ef07b718-0198-4f8c-86c1-56149c7fd239@linux.dev>
 <20260212163628.GG12887@unreal>
 <20260215134122.GA18825@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260215171543.GB12989@unreal>
 <42c8552c-eb41-43f5-bea5-fdd46edba65a@linux.dev>
 <20260215175707.GC12989@unreal>
 <20260216110853.GA6455@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260216112207.GF12989@unreal>
 <20260217145426.GA9217@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217145426.GA9217@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
X-ClientProxiedBy: MN2PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:208:23d::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: e545b566-2f10-4349-970b-08de6e82a32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pk78o0hvdIkfD6APyqPC8aDibWiy5zK01DBqSV219rOwkI6+rfj2M4mZfPG/?=
 =?us-ascii?Q?a6uVP1dUAxLuRgxZCXTLg6vGDwWAluwxGNr4m1mQTGTXREXu5u063oN0Rnkr?=
 =?us-ascii?Q?3NFVxKUbarFs9RUBx1O2POwR4FXQ9farQLmkFOC/6xm6bsDEkig0qYzea+9k?=
 =?us-ascii?Q?vEeSSYTYHMK4M7bEvpcJUE1Mg3IgKmE/b049O00/ab2+0ieYKb6OnRPhbkE3?=
 =?us-ascii?Q?o7X0Advw+0DgmNhdHjWnv3H+9UpS4Qm6RjtBegDBKNm02pF90BeBsrevCqd+?=
 =?us-ascii?Q?LXjQ1WCKFw2y1QzypslG+HfK8tOkEhBlZdgYvjCshLluJINr+xMmYaE9Cgd2?=
 =?us-ascii?Q?JKgQ/LRi/hs8kXMHe9VftnOqFjnqXssabNsi3GlvU58wD95uvp1wOgJPiQMN?=
 =?us-ascii?Q?KyWLmukyL+MXSNOAoEe4b0gLpIX1X4iTj4axF7kbeXAsBwNC6masd+FFICG2?=
 =?us-ascii?Q?y/ThqkM9C2VCc7xqaQu3CyFNPSUByrNnhI/EA+buLdnvqBqF5XmI7uBwlC/j?=
 =?us-ascii?Q?Pszi32+B4IzAsdkDkpiq1gpDYEq3mwphz4iK9mK8wHD6KQIzyKTl7k5QVZEz?=
 =?us-ascii?Q?fw/YiBZ7gKzXhFcbg8ohqo5zUuSl/37lozqW9iFX3fX+JUnaMXvaha8BP5wO?=
 =?us-ascii?Q?GX/PqUasAbbJIIiaK0BYU1m7EMJbk/2J444cWQTeV0G3RenlbmPjn9AUaj+D?=
 =?us-ascii?Q?1VfowaX99gGpT86jDjh1dfvWcKuCLwFT+uwhktYZhO7yadHSsrmIGLzwC0+a?=
 =?us-ascii?Q?HZ2cdPFj2Pei6lerIrGBeAfIkuxLmEEnXs9aW/nLp0Z6hStw19CHt16qPQjo?=
 =?us-ascii?Q?ZLGYvysd+ADHwgAj6YYmi0FJ8S6cbeMF35XhTRIeZDQNqRsSrt2pJ+Sp5EDm?=
 =?us-ascii?Q?G3GejKYQ7wiGWrb+Y0mj9JaMoAoQj3p/MxwooPS39RUDY+cBq5pDxLHBQemU?=
 =?us-ascii?Q?SJiPtvwTvO97Q4DXiFY7SIZWSGrco07YmIzRqP2pUcBJ+F2ycZ9Xenucofrv?=
 =?us-ascii?Q?gGWff7LjtHqkY186t0v4jbtKJ7Jn7SXfy1gkHeDmsJBmdicGPEZqempTrAzb?=
 =?us-ascii?Q?mAAv97jMAMJpYsMvkuwnOL1w87J+OzpvvKtmVuFFsIL3WshCzM1eBN0Q2yKE?=
 =?us-ascii?Q?L8QGqWeP7e6DocaUKBVSfE/K8+kIwzrahRimzXN48rTQPHmAUxIyTb1gjPAM?=
 =?us-ascii?Q?+xR6ITZSP8iIKDb62/DkwyLmljGvxmprTIVO2J1iEi4b7PGbR7QJgo1u74DE?=
 =?us-ascii?Q?LY3b+hdI8U6KfmIWgDCtbvwuYEVv7y+AML9Vd7BXu9g52qjkeV0ozFSs5eQH?=
 =?us-ascii?Q?0/YiGIqqQ+F0ZhYdNP+Yrju8FTDu45RarfXLwfrCWHI6dsV5eI0QPBLofnzT?=
 =?us-ascii?Q?GzaiYaMw1yOnlNzKBIK3uk3OFSx1+pshGRkzSgXtvaqR6V1U+pRnCcfqi9gp?=
 =?us-ascii?Q?XDz9vPeuqCMwaKh4xFe4e7hxAGnWrw+1mSasp73uOIaznru/w0JzD15g2rux?=
 =?us-ascii?Q?u89pweLDL9V8cePEZVPNbqd0sTDcHUqQL1ZUnJQcN0zavJV3WAbwROGaRQud?=
 =?us-ascii?Q?JwU9xK3JFUlOamwFJeA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?euL62+FgrF5TPE1i0Qu3+DAH5eRZjZNoTkxO7I3jWlQyAqTG2YUNRXoh4eUu?=
 =?us-ascii?Q?tQYayJYoiN7WvUoBBk9he1liSl3mAQl8KLj3jx5mpFciK5VAAk1g3p04YO9/?=
 =?us-ascii?Q?KpmtAvTOAZQBbiYwK0M3bVhFrg3KlC4wIDTZRheszYdgl05EWZwPxZNOxW9k?=
 =?us-ascii?Q?8Rt3iFPPcqGrYEFL1J1up8bX2UcEYWnJONctzZQXIywVQ4h75VASq4u6H0tq?=
 =?us-ascii?Q?IA0yeph940QqMjK28JNO6MlmXmGXHZK3lE61jdZoSb3TC18cEAvIM/vZ0cIX?=
 =?us-ascii?Q?vgiBaHRhuP7s9KLvCrDZxSPgTIfCT0VT21IFahMAeBlGnhG+1dMW+qBwVDNn?=
 =?us-ascii?Q?6LX3oTcHqwgz8ssPrxiAsfqPctWAQIAaX98IuUpFQ99RodGs1Q+TY2sBcpa/?=
 =?us-ascii?Q?hbZLTL9jcqVPbHLvOsQa60/zX/2XTLWPel6f2Wz6FtRn3hqo/60YXjJi9J1R?=
 =?us-ascii?Q?v44uLVlzFDo8f/8l60Nn2Z2MseMdaDtRHs367VOhz/sTCtsOtFD16Z78c+1J?=
 =?us-ascii?Q?Q+YH2yd/3/rKqkFESOkuuof5tErWhcdiEB9wut3YcGIflQhKdQdVB3RfB6mr?=
 =?us-ascii?Q?V5FTbe5qYjwEyKbRXMgpSPJgd3smufoJrt7V+7r1yIfpOvQfZUXhJQcb76fw?=
 =?us-ascii?Q?w65v1nNJn0HAsw5fizemACcx4ifbyRidPVuxAdLNi6dC3z6aUGBIjKjOpm5R?=
 =?us-ascii?Q?z21Y8p+ODx9YyKlwBku7//fOjAeq/LHKsu11XqswJ9EEuq+HaCR/8HdmeMyE?=
 =?us-ascii?Q?05i7cfqYLvgTqWH1EX3Dl0/zQj5OOxS5P+XslCNpEsaAkpc3RE8UoIxhhSpF?=
 =?us-ascii?Q?GChlrH2MURSQBzJFBBVvaV0Z0e0HgrPL7WidVk6C8LmU9WM5+cemkwAS3yKm?=
 =?us-ascii?Q?rGFAbWfKry9YukeszuwWr8mayLz49WJoQ9yfL94eoYmX0V5HKz6MrrlmQjtO?=
 =?us-ascii?Q?ryy1jAIVci6Qy+C2igIR/hpanQEeXvnvmzyfEiyZ1NbWG6oJSAtilGVNFFUZ?=
 =?us-ascii?Q?YAaxaXn0tLHCz+/OKG5kj03yc388xTq40vr912js3HD8+orVLM4XTGkRMVOB?=
 =?us-ascii?Q?oiFPJNaFBFI9pmR/3h2CXYYEChqminOqFXHXkQEkZXF0m9h6WB4vcrAyLHUF?=
 =?us-ascii?Q?0u4cqorGCLxV0p4Fx7Fe6s/pQfkIbiH3LO+IiOTOV2x+s8E6pyhfymBtgK/g?=
 =?us-ascii?Q?rA0evqNDfvLtRAjpdXtd9Tod/rXb/4mkG4Enm72ox2N+LLNUU15ogJrM+CCc?=
 =?us-ascii?Q?NH18Nc9ZqaAfK8wtvwqVPg90lP5DiPIitTp7g0IRO6B/xbH+vBexxTbozpr9?=
 =?us-ascii?Q?j1y0DQ+xt2aOl15c2D0soirRicNAwMWu4jBholJYcNFMsBz+naBTSSwXX2yy?=
 =?us-ascii?Q?tzOMdWCdP7wJM2VvbQ52eCKB2Zwl0NaFItYq0gvxrE34AJdCxWyGOZhK4dpi?=
 =?us-ascii?Q?x2yiwLuhIm8ok6z77m8CHFwibM+x8UvnfJvH89qATDliE/IiIAinsje765em?=
 =?us-ascii?Q?eBGTPB4B6ESkyQj0QKSx1aXDk02YuoQN6B69Z/WnYX2jKVYXV0fMSdvznSX6?=
 =?us-ascii?Q?qGqgtUxt/Ia8LF9q7xk8ZsC+++f94X6jYVDPxdJYXqe+4C6Seu7HPwJjElxN?=
 =?us-ascii?Q?oqxUYRxEk7sAcdcx/B7apE5VkNYm//rXTaB4qxfyxvoXY7Zu1DgAfbLWyrN/?=
 =?us-ascii?Q?75yXQZUTxcFJLB34kdD+cSKMDVQuTn4Q1KZov5J2WTM1KF6FJIN7pRjFen8H?=
 =?us-ascii?Q?ciFNTVyBOA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e545b566-2f10-4349-970b-08de6e82a32a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 00:14:09.7830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iobr2vToPcgJUEndGO9RkpDDjc6cJsqFOOkY/p/fJdC1rEqxvI2NT2wzflkUtkj5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16981-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: EDF801522A5
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 02:54:26PM +0000, Michael Margolin wrote:
> to monitor AH usage in production. Resource usage and traffic counters
> are usually collected periodically (every 1-5 seconds) by dedicated
> collectors (e.g., Prometheus node exporter). 

Can you just have two simple stats
  '# HW AHs created' 
  '# HW AHs destroyed'

and the value you want is the simple difference?

Jason

