Return-Path: <linux-rdma+bounces-21522-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FZ+D9fWGWqjzQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21522-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 20:11:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9453C607193
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 20:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F95F31B26E5
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C7E390204;
	Fri, 29 May 2026 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PS9Opzkj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B525386C20;
	Fri, 29 May 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076280; cv=fail; b=VFbdEoCYiU7HMV/9u57E6fQx6nncIQltcXURgZe2spdTivSjXwu2GhhIqU2El74ArwC6wiESopalsLIeBtfjJVi4zth27x9T9PNyLoRzOsJ4m3igZoPbYVe/7DT+Dv5owQ94ILHyRLTnmnP2QX5R3YK5hRQQgYyvabOtYuUkFU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076280; c=relaxed/simple;
	bh=3c3zirBMzg12NOk7z31MDx83CSKqzk+0EqlLg8438Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eAZFebcLrY+QK0jU1qvPc6Sn+oPUseeWHHBtz7jma+4EbxNMgpxA82bTT6LfDQVZoH9fGLqCrkZjXJckhSPwceJZ9fQ1adGeXguz1hi/UrDeqrXxtZZicQdKMuj25MXawgWM/79ybfz7fZYelXJBDC2IPJvBhXQTKV0jSTyjLk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PS9Opzkj; arc=fail smtp.client-ip=52.101.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igPk+CeWKxwyiUGEDabctsxexKhlAaujz79vXmTISNUpVVZw7v7YMn+BYsGOmcL4cQRqT1JlvRH4d3N0rn5Bz8wAjPAiQ7FOaukythjcMd95BPuotcf3PEsnVHAFVAuoDpln/JoDWXZGd4DFyVyHR0VYLw6jZwDkC8GPJXqg+uO5O6A/khQuYXutTVAormEQWjH4cCaUXVaQK7rBQgd0sdYA0/NFlcSwKwxZHcVuY8oN30ycMprqNu1JSsvixcsSXuN9DhNt4/yTqPfhZ/CJPb+pU9/EnM4j3ULNqSWKSEbTV9iwfRjHcAkkRfa29pRkIDhpwyPVvkVjnkN73vx8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtwL7nOTN/B4u+/2nYSzNPd4khDp76FempEzA13phVY=;
 b=jazGnI6A1CSv3ZStQJ8RX86kc7RFRlZRLx40mVQHyuWESUE9HwZLBewlZWU+H4nlwWi/cHCuotFAgtHSpzW9+b4RxNkbm3CpML1Arhq2FN5ZcFpHkgECq7s44zQmDEmQfdLCTKbbSNsBqXq/9nQigt4aK0oi8oUgLQMv327SNN2Qwix+qkX4Ps2D+AsgyGp+uDYiMVrAAzGNC3EmzfEHkQXe82KGvNnp1YjPLWHVJq9fv/l0ASLlooynWGXbFQuOYWliwaF3ofr0rBR/T98aWe8vtoICx4IQ8iAUrm4RTN652CN/LAf7tIKTn1IzytblTMdGHZJshTcHStrC8KD0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtwL7nOTN/B4u+/2nYSzNPd4khDp76FempEzA13phVY=;
 b=PS9OpzkjemnTcUKeQQWfHoSh4Jr8MpKU0YZXy8A0bfcM24+zmUAzFqacdvqzNAE5a/30DzAYIfxrsI5rJCCALxS2Qm6SdLCpdqmPYQud/5777/EOoY00o/ZgRgD+fi6IGUeL10jTlxu8xDDyBbryF0RCe/KvTVYIh3K1rIJ6fBzPdP6fMe0uLqPCL66jwFeuT4B4gbGheBl5WCbNQOE0uhnUyns3XbN5F8GWe7ciHEO+z1hb73cGAlb8lxcB0nA0cDfZf/RrUafWJJIuIwzT/YFL1eEe2jZ5dcA0fXUwa3mEzxStc7zJyL7dSj3fnGSEuvbvhU8Hk7C78dEo8I3ezg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 29 May
 2026 17:37:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 17:37:54 +0000
Date: Fri, 29 May 2026 14:37:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 07/11] vfio: selftests: Allow drivers to specify
 required region size
Message-ID: <20260529173753.GB128816@nvidia.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <7-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <ahiQmnWscsbWPqRo@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahiQmnWscsbWPqRo@google.com>
X-ClientProxiedBy: YT4PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: ea90ea88-0041-4f50-1520-08debda903b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|4143699003|56012099006|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	FGuHpe+EG1lzbOKxmWpdsRaPq3S8NE+DGKhj7lzJF/bZ7bbssoNVv/S3QUwLSraOC9kYMrz6r/DD+gUdpgar6WYcvXthInuYmdpg+UIsuMmMBq0xNsEa76igzMXqF+DfnfFog56vfahjTu0vSwr6v8n2zC0AxyN1uRz4/rbYL2b2M5tre7j6+0h7o1x/qIC48b0ClklSTzXq3FiSekOlJ0D+GpbYvFE+v8UHPWXaq5FwZp0m3hcILn9pDh2YQC6ij8UhecPIawPqSwCBZqoxC8Ng4lqcOgsrPYGsxvnf5dKYTWGUO+HEgUrX1jfn7uB0W703aP0JMGs1MkSjTHNOMf4YGb6WWYHUFXNgImdiztuR8KshuBrUnEqDFMjlq+J3FpYTvvSLcC24xxPbBfX1LcIiA0H0SyWPOUXwTzCal7twCtBUb1VKVb+Ccn47Cka2CrLNoUtffRu2bwsqRk9YVZSIGXxKbJLqY3GjMFQVKZ4wOiszyPAG/tL+IKwznQJOt+7iOwf73Ju7zWFJ59QUr6YhC6C1Ye+6GFuBEvGm+2BEe22dXLQ+l+pnYc7HWbiqHKRnSN9lRGOfkmdk5jZ5duMzP3tfF2dypVBJ9Eztl28LbT1P915eu4s6r1zxgfOEdt7B60fDZynWA79Fc+aFyC7XTp6fzOuU4bPjt0pZ8Watus5i8PMd0dmGjfK2aD+j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(56012099006)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FZUIsVPHfrEwqPIj5fJ53HhD8O5GKN7NpxeQVa3XkxQCBp6wrBJFLVlZqDII?=
 =?us-ascii?Q?pm49YM6f5cf5ybbHiK8dytaVz2x/aFj4F7iBKttpNeAZ98hucmdhDkDQxXKZ?=
 =?us-ascii?Q?2D7IbgyiHs9soCbukJbZP8PvyFaN0plzlIDgaa2SMXaaAO7eU7wpY4/7Kir7?=
 =?us-ascii?Q?UrgB0e8GJUVZSNd7LqSngZl2XMhIP5YZWudV3zB63itA2Ln5H1Njgn7gyKLp?=
 =?us-ascii?Q?ccwD1FtN70AQgmK84T+Y/S6bqnGyQm5xi+gW2icDHXxIzGszDB2j3YICruEn?=
 =?us-ascii?Q?lYFVkbPY9tvSvhYpnoRXhYGvSgA0AiWsj65leICXOmJ8wpm/xpnRiwrFnm3e?=
 =?us-ascii?Q?WWlBGACwV2FiGpk/Rv0/ue6vZkJvDUSyIz+yH8iGbIODJh0OC5Ih1xYPyrF1?=
 =?us-ascii?Q?F9tFFJ0Ym5KFs3sgLJjxTnsrHPC1Rf02jnYd5V72G9d9Ha7sHIQv5Os2dAIJ?=
 =?us-ascii?Q?QQJXPgUkaZqoX20HSaEMUwxlc1pj4UGavnlIt9rbbhbYOJl5hcsQrhnhQ8Ui?=
 =?us-ascii?Q?QqRO4PSl/kHKQ7wZ5tnCiDLehbHiifShZOatDlDYkLrw1JBiJa6IqSmRDX6t?=
 =?us-ascii?Q?lyC5Xs5Fpwh/yA6oIT9O5f2kQde3VzaThUuT0kqE/vpl74pxfOY8XuWT4KJY?=
 =?us-ascii?Q?qEWCgv8+ReJPfOoXNJIwwI9L02jBqkfIqQGu3gedfsSFNceA4ksIu8/fFXMG?=
 =?us-ascii?Q?EYBn8vEG1qol6yFg+iyr87C8H5e20LJ3piSQUaR96moQgcSkGuJtRGMComJl?=
 =?us-ascii?Q?NzMmxvkHklq/KI5qo3q2MTXjAj/2aGLKVuYHZOYRfRlVNgGKeQBGfNFyMtg+?=
 =?us-ascii?Q?7P9gd0OEwn0au6uXCTu+JAy+RGDVM634i0lLBvsWN5JTmWQ9eVRhwrKJhAK3?=
 =?us-ascii?Q?OVmnV2CZudbnYbVA7FvZ5GhTXSXsjoNtcc2wYTZO0gLuEjP4+ApwR3OfiA06?=
 =?us-ascii?Q?bCsnQiQm1aS+nsvWOCzUutEmciRLMb1Y0gNM+LPMcxT7muZeBFUpxb+gZdBi?=
 =?us-ascii?Q?ewgvWaXzplFKKpwyp2aJUlD6EMguihKSPOOdFObKuaj6tPP4XkeDu0CWMdYs?=
 =?us-ascii?Q?/XetIvKSUqVTuH2CQqlZ8bxrB0otdKY6JeU4tBnq7hvkYpaSMv4z7ESSO/II?=
 =?us-ascii?Q?De8HN8h3ps//l7eM2x33VY2fGPL7C91tWVL0HGI9w+GNdl/0OVjL3Y1e+Vtq?=
 =?us-ascii?Q?vODpJb56Q9J7RDEbBAEzx4uSOPIQdsrXzLQnjLZgNYn3HfHE5chKuwlHtP1D?=
 =?us-ascii?Q?tQibyxrYFzxD5/y6wK2slpJ4XSLoAp1fp5OUy7ohodetPw6j9MHxKzlwvzLO?=
 =?us-ascii?Q?fQqVuXZuWZWiSC5m4kSbqVFjrCktUl2j+B81UAbxE1ojXFlMaTjLn08p7BpD?=
 =?us-ascii?Q?f/HapDjKVu5QQzQbzfuzDIUvVg14HmOTH1kC4R6AAyeRw3oY+4/Yw7ZTICRU?=
 =?us-ascii?Q?XtY5JHEwleTEMZ17oBBfYm46D+5vLfZXWIyCJ7iIGToP27SngL7hy7cSWLBX?=
 =?us-ascii?Q?w68oxAa1gGaEntiPLHbFJ1f/Wj+JNQKz5JFk00raAOloFaBPHqnIyar+oGH5?=
 =?us-ascii?Q?qIQY2IZb8I/DFNDD4rlzSTrlQ0k4tdTO+nxoIQmPfJ12E3jFRef0T2ZMJ1Hr?=
 =?us-ascii?Q?T9P9O9ndSHJMgMYXpmxKC0A0HvPHd+WwK6VGGbZST5kNob5Vb11psABIGP3d?=
 =?us-ascii?Q?bmyeiGEhArsXgFm+Tp+ALCYapNm/F/vnLdpGvmTm8JW+6xG4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea90ea88-0041-4f50-1520-08debda903b9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 17:37:54.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzQSph2gOaDSxpK7tCILvnGq3xN5DbDD3thtXN+geK3H9bR2JQSDVDHY9CTYBOeG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21522-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Queue-Id: 9453C607193
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 06:59:38PM +0000, David Matlack wrote:
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> index 6827f4a6febe..c70c22b1a86c 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> @@ -28,6 +28,9 @@ void vfio_pci_driver_probe(struct vfio_pci_device *device)
>                         continue;
> 
>                 device->driver.ops = ops;
> +
> +               VFIO_ASSERT_NE(ops->region_size, 0);
> +               device->driver.region.size = roundup(ops->region_size, getpagesize());

Almost, the iova allocator insists on power of 2 :

/home/jgg/oss/wip/mlx5st/tools/testing/selftests/vfio/lib/iova_allocator.c:54: Assertion Failure

  Expression: size & (size - 1) == 0
  Observed: 0x200c000 == 0
  [errno: 0 - Success]
  Invalid size arg, non-power-of-2

So I left it with the max

		VFIO_ASSERT_NE(ops->region_size, 0);
		device->driver.region.size =
			max_t(u64, roundup_pow_of_two(ops->region_size),
			      getpagesize());

Thanks,
Jason

