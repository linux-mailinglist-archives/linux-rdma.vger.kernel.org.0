Return-Path: <linux-rdma+bounces-6110-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638389D953A
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 11:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A20B21F57
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847C1BC9FE;
	Tue, 26 Nov 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tvu9guTE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2522192D8C;
	Tue, 26 Nov 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732615823; cv=fail; b=qo9iG16Ynaor3FX/W43asvoESJ8mYDNW7PcluAEJQWehpCSnegGcCmlGKBrlZokP240KUrJUP3WpD/xvE0HUZly44qW5GZLWJQI+fTJzUn8yYbyrQ7fr/hjHK1LuzKY8s1eSPypfVV3A7KVXEr6KHxc8uCSjmjtyEtRIOpPIjzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732615823; c=relaxed/simple;
	bh=R6I6kBVl3Vzui48NRMmXfqQZ0BcGtV6UDnDAAv/w+tU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvMqmwDkJbS4RWrJJ9nq4n2mfF+ECOZwPqUzDB1XwoVhZs5gQWFhIjXr7NNd8xXwy0OwBkINKbYBjOFyDtHycE18nn0sxrWlDcvpTClR/P4bdQAqvk/jgzOEx10TMyH32so20KbumBLydvgUqyHGREczEaySiYR5giw1BbtKAI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tvu9guTE; arc=fail smtp.client-ip=40.107.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHIFQ8O5jY+VoTiXYSf4sKKfSuTWalfCWVDWt54jLmSKvZHI0REhrPbBQV59Hypi1IheVOP+LfGS+MDeX3T8NcbWyS9fxpXvGCb+T/wbVzH0qslt356yfuoHs5WiNgCnPjNek07+/dvjH8rVPo33nynTjolG+vMg0QDOafj7tMLv350ynEJb9Y0vOKZoTLg6KSsw0NHOsK7taAs596pQkPe8T7FN0zQtIGbx1SsfZ9bYni0Z9zJfkX8tWCUKcoXtdKA4lmNXb2+zg19NbQwTOIH7AfbANTbGmHO2nzeAXAKxczqJadofA3CAn+zogXyiz5l3tkRwbtPQ+Ac4jT3wYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY96tJUJ0UFsNc7lPjKmGRS+XFNpXkT/MtDKn3bTy6A=;
 b=cKXeB74Exj+dPLtFQJ9uCDG8L9dG6JYFqhP27a4oePsfPFlKaRHr9ep08fWr8NzYE3pVMrZ0ptZysZXTkTApIj6VntzPTUL1ZutTBGrL4bFiPuB6/3r5Lj1ocVIva+sJy6y1FXiyb4mVXciBZ962HT5RhCPGSlU0TCr62XoSS9tRJhgf0naCtnCL18rF/SlWnfE7+P2nkAFb1wlIMsKwLhiZAgTeuiD/1fropMvzw3GNKj6hJKrWJ4YrGlqZL3UIh+acqg4x/Yvj4jqKX/eBfK2Z3hvcjCvXYCsgehTN+9pbn6aibCuN8VQfQ7AqFXbgaiZyZTQ9eAbGI0p+DOXE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=paranoici.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY96tJUJ0UFsNc7lPjKmGRS+XFNpXkT/MtDKn3bTy6A=;
 b=Tvu9guTEY2X79lEF1fcF56y6A5mOwqw63PAihDc29mlYaxTn6X1Uew09rdOJfaOni77C0BvOBRJQnslWEdJcu0Czrm9kmlzFSwp+JmsfVnRuVoi9hO1m+y9LnE1+/C6qscNy1FsqntHhUZ5ELBxuzRncxJyJzSXjwhC6AZakM45aTVJ1be1yxx3DckY/ZsZ0dZuv8p12zx56PqwIpp/x9MSWlcVNomE43++4JrpqvGsjvnOeIbMboyKa6Aki7aLxs9L5r/uKiEmtSPn81l4sRUBQV3LXSHbBHsKzvJwv2qkxMb2PeU9LZ35ltMXB4caLsGwT35v0W4lJ5VmWjvOyfA==
Received: from BL1PR13CA0381.namprd13.prod.outlook.com (2603:10b6:208:2c0::26)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 10:10:14 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::1e) by BL1PR13CA0381.outlook.office365.com
 (2603:10b6:208:2c0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.10 via Frontend Transport; Tue,
 26 Nov 2024 10:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.0 via Frontend Transport; Tue, 26 Nov 2024 10:10:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 02:10:01 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 02:10:00 -0800
Date: Tue, 26 Nov 2024 12:09:56 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Francesco Poli <invernomuto@paranoici.org>
CC: Mark Zhang <markzhang@nvidia.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<ukleinek@debian.org>, <1086520@bugs.debian.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: Bug#1086520: linux-image-6.11.2-amd64: makes opensm fail to start
Message-ID: <20241126100956.GN160612@unreal>
References: <20241113231503.54d12ed5b5d0c8fa9b7d9806@paranoici.org>
 <3wfi2j7jn2f7rajabfcengubgtyt3wkuin6hqepdoe5dlvfhvn@2clhco3z6fuw>
 <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241118200616.865cb4c869e693b19529df36@paranoici.org>
 <nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl>
 <20241125195443.0ddf0d0176d7c34bd29942c7@paranoici.org>
 <20241125193837.GH160612@unreal>
 <cd4ea02f-bcb8-4494-a26e-81cdf6c684bf@nvidia.com>
 <20241126081824.afd7197d3a54c5242c4bb4b5@paranoici.org>
 <20241126083859.GM160612@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241126083859.GM160612@unreal>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: d9492c73-0236-40ce-4bc7-08dd0e028482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GTKuATamck3VYLHv1k6zwN4QGG+9S0bvn63l9Rm6UGzPt13lGaLMTFqew99L?=
 =?us-ascii?Q?LyaepU+xARx+95s/8VFcGNE/+8a9SDhqu+VJkSG0Cxjias0pSRoMdYAsDCKI?=
 =?us-ascii?Q?6YocsvJMn14guatBMGDGzMLU3JR6AMMbuH7axqGr8iYwuwe9BLSWBG+ZSYIj?=
 =?us-ascii?Q?xxn+G9bCuQ8TJIsgD5mxrhJY2ozYYWA9p9CUFezBmbvHzQFkhIgB2rZITCNh?=
 =?us-ascii?Q?ijugHeBzam77NQQvH9JuWk+SfJUomEDxFDduQGKYtQoTS8U93nV3chYo+Js5?=
 =?us-ascii?Q?bGLV14CzFWguzDVUOcnW8/0Y6BIuY5aEhutAuV7+GpWVsyk/xuBtwGYe0A2E?=
 =?us-ascii?Q?TeHG2VdXEmqWNgGXZgn6wfPXyCV4UWoF08mDyiXEstcUm+GnU6kJmwzn08c8?=
 =?us-ascii?Q?yeoEObkt1HyUI+wiMaSuROJ1Nf7WpOWu9HcDHqbhLTPHHqeHCTpN8iEVTocK?=
 =?us-ascii?Q?iWzhCoJ0ABtspaDG8kps1HcZow9Ow+PnY79iIq1fxQyk+GmuCuCuBX+9AdSg?=
 =?us-ascii?Q?3n0RDFXYgjEHDIgXyZjpD0arzObtFdC49AyeQZVaMTR4mMIAr8Z/joNnXUaL?=
 =?us-ascii?Q?vbk/im39YZTD9oL5LtuhAPpRj/5yVLAbS8lUM/ZmHFLDBwVAHn6QDTWEA8vV?=
 =?us-ascii?Q?2twZyo6GF3CaPoUtetyBZOm96KZQa6itXBF2QNmmUlSbIlfIwT9Apl+LB0aP?=
 =?us-ascii?Q?sLWssVIDVCmmgENfdfSyv51iYQBonUjggnHiwIJRZiCOKWWd694qY9aClnSa?=
 =?us-ascii?Q?hEefhDYsIV7zcBWbD8NK2/zYkhf7etZL/r+4HCN4NkjZGbrfhbkfA620jAEx?=
 =?us-ascii?Q?75krzbETg/z15L4uO1OBeqtzkN5ho1KyjX095umzAkSE20CRBqPLA8BkQ/a4?=
 =?us-ascii?Q?ILnOWt+RuJoZnaRQ2VVB7zpa0qbA1naQXwLzB4ELqSoAqcS5aAvXSM3Sn0ph?=
 =?us-ascii?Q?16gNLCHg77TZP8/lwWCK2w3YPw8ZRGh8LWLEGH3GGFSohW+d0rqUn/vLyWzf?=
 =?us-ascii?Q?OuNe29a6bh6RTvg2QZWdzXISoTZ4AVJbvr9/6iRlqCKeCROfY7FqCjLMgSkg?=
 =?us-ascii?Q?p+a06T3rO3lYdFvZsRN+Bosm7JQZZh5/xFpvJJu6dgbC8CntX3zAaAfwHZxz?=
 =?us-ascii?Q?619KiC8/43lFc7hcJtHdu5n6Aa/siw3lwEUxE7EhcszCGWV5msBs0YC9DThL?=
 =?us-ascii?Q?uiYMzirMkdAjUIO+O7o+bRLAo4JblhiblxAjXIuinqiaLRNFyUdO5eFehZQB?=
 =?us-ascii?Q?JsaGoffdrvUzexRdpVriSvsv17CtS8Rop7WXw1zov4f6ZBy/i0qSzPYruaso?=
 =?us-ascii?Q?jDCWHR9HttICyTrAFlTIg1ZPIdp26XjmJbiCPVLdT12huEn7sehqQUzoCGFe?=
 =?us-ascii?Q?0QviHYqchcJPmjDhv26jKGmK7utYQeHnWowGnnzysNceBfJdbu3ZnWvOJUCl?=
 =?us-ascii?Q?wsOKCpSR2WdKPsPq25eJXZAL+Szxb5RZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 10:10:13.0206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9492c73-0236-40ce-4bc7-08dd0e028482
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760

On Tue, Nov 26, 2024 at 10:38:59AM +0200, Leon Romanovsky wrote:
> On Tue, Nov 26, 2024 at 08:18:24AM +0100, Francesco Poli wrote:
> > On Tue, 26 Nov 2024 09:21:37 +0800 Mark Zhang wrote:
> > 
> > [...]
> > > Yes looks like FW reports vport.num_plane > 0. What is your hw type and 
> > > FW version ("ethtool -i <netdev_of_the_ibdev>")? I don't think it 
> > > supports multiplane.
> > 
> >   $ /sbin/ethtool -i ibp129s0f0
> >   driver: mlx5_core[ib_ipoib]
> >   version: 6.10.11-amd64
> >   firmware-version: 20.40.1000 (MT_0000000224)
> >   expansion-rom-version: 
> >   bus-info: 0000:81:00.0
> >   supports-statistics: yes
> >   supports-test: yes
> >   supports-eeprom-access: no
> >   supports-register-dump: no
> >   supports-priv-flags: yes
> > 
> > Please note that I determined <netdev_of_the_ibdev> by looking at
> > the output of 'ibv_devices': I hope this is a correct way to answer
> > your question.
> 
> We forwarded this information to FW team and will update you on the
> findings.

Francesco, 

Please update NICs FW to the latest version. In your FW version there
is a bug which causes to return vport.num_plane == 1 even if NIC doesn't
support multiplane mode.

We will continue to work internally to find a solution, which won't require
FW upgrade.

Thanks

> 
> Thanks
> 
> > 
> > 
> > 
> > 
> > -- 
> >  http://www.inventati.org/frx/
> >  There's not a second to spare! To the laboratory!
> > ..................................................... Francesco Poli .
> >  GnuPG key fpr == CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE
> 
> 
> 

