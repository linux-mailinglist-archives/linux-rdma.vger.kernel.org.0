Return-Path: <linux-rdma+bounces-8303-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8862A4DF0A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 14:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAB3177436
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698C9204090;
	Tue,  4 Mar 2025 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WWC5aS1s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C28B202977
	for <linux-rdma@vger.kernel.org>; Tue,  4 Mar 2025 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094338; cv=fail; b=sn02J3X+zY5iUMGl+wSAffri5HgJ10PPqhWRXT3+sbV5je7RWuq2fXVkjgk3wMcuElSNGF71bb/v5ldD9m5NJPxhZGXvHGAPkQahbQaRCI3Sivj1V6yZyuKs9xvCmSuyxkcaxJnDT0ihItYyguwXEZMcmrVUUeu5kuh+RDpwcOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094338; c=relaxed/simple;
	bh=Z6W102UrDY5bEwuX/wL/TbCuGCWm1fCbiYPM1B5RpmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JF1/Fwqb4pq3unFPC5rDO/pRyzk1Fu/n450XjjrLPKakkr9Npymzz8F9BE4VibSSTRIjxoUqi5a9C9ruNs1qZirGJHOrehEt10Wj0gUBuahGwvcv7NR8AddAzVygwTAfjlDVoYg3D0tW8shQ/t4Nb77tQ2PGeFVI+2ahjtw6bwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WWC5aS1s; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esMouV6ORN4DGtPscRfVUXyB+gEpLWb14yYDPQ5VZWhK3Nq3ROSYLFvYAYnxUUJCnvExZST8yeCzNbpej9SBTmL0jxHoNCsiAjiRAeFPhKW+IIJyvvoRjG9+CNtbbGMiErIxWmuWJBR4c/MjDNMlf5ipYFyKwtvXqYnVR6A1neSvH7ZH2inYX51CO9fKk4XwpjloVyh5v6dXAS0+G3JsVEsLqFfdw8PHxwh5R5BZw3CLZaBASR7h8fqMZSGJeYsUMMRIdu+v6c6u5wd+V6qzw4y0MvP2Kou0V123B/KY+OKIHaWZCOqfTgcFNuJDbeBk/wlWxwkP8Y6of7EmD8tghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY6QHfw3jRLUf9gjPOBddmgZlYR6Deq2dHZCib9lW2Q=;
 b=gqo5pEEMLIWgM9lUS+btBo8hsZOlQZKLSNqM7AD/vKCDHuje24tYxGqPx3j9+3baKHOqaHV0EBTK2HQyzNYfO2cKMRW7NZ9Gr9CqSwrzXpOxlHVKoVR1f82x/v/vLXt4m4RMqXH7SFAutZIxdfMPoYfWsaSgp70x/KlGyR6cVDIXQ26V8x9n+Ioh/rsGl1F+eQzvuU8XgXU6E9Xc431VHj0p/GLVHC+4roasRvfIiSrwdar+di31UHnNrIQw3YcF9Ii80KGwQp7UZoI/Rv0rbMrAXmHY7+gfCQlEqWoqsRB0pVckVGg8AKQj2g5pJYAgFBa2FtOGDUVWRBcS6+12vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY6QHfw3jRLUf9gjPOBddmgZlYR6Deq2dHZCib9lW2Q=;
 b=WWC5aS1sw2UtANY4bR2LkQHRH8p7cgdZm6U4d73G+pap2WrC49HHiQltuW2J2K2qlM7MkeS0T2+Pwwl2qGhdeR5f8tMtaJUdIAHvQg8MfBxXHvAK3QndbjLWB2Uy6NNFiGUaDTHnOYSqLlIY7NWZOoaoLYRpK9EbAyoe9C/t7LsR+BAgC8af2J3q1DMCAvXgoynLk6YDavu5z/l7N3Mwe6ikccmJ5CX0SAaA9lWXh3nzKJ/ejLfohwv7iVO9zUOP1Ev3IUrVDst0xjReWJnXoyIBhxgD7RNSsoSWs/en1pKyZoF09r2NDMd2W8+4iwCyqvrwAYab/JJ23Ed/l5bXaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 13:18:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 13:18:53 +0000
Date: Tue, 4 Mar 2025 09:18:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 1/6] RDMA/uverbs: Introduce UCAP (User
 CAPabilities) API
Message-ID: <20250304131852.GH133783@nvidia.com>
References: <cover.1740574943.git.leon@kernel.org>
 <558b28bc07d2067478ec638da87e01a551caa367.1740574943.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <558b28bc07d2067478ec638da87e01a551caa367.1740574943.git.leon@kernel.org>
X-ClientProxiedBy: BL0PR01CA0033.prod.exchangelabs.com (2603:10b6:208:71::46)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 7000380c-b316-45c4-de73-08dd5b1f1c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uZxFUMpHuJzbkjrMgtTWyxeP1eCIb0Q3FR31vgFzw4SlTxDoN5xVjDGISfva?=
 =?us-ascii?Q?HTD23wH7chzdXw3EAYhtUwcj5epPfKNCGvQ6l9bsHaQoUdjR7h3XqbKNDAbl?=
 =?us-ascii?Q?L0AthiCdDGeoug7n6/BFYw7icDP0Cw3OBeCxhwsqcI9zLq0lWDkcJFLTMm2d?=
 =?us-ascii?Q?mrcFmjBt6IWr6D5k8hqv0Oc6Aezip3gBNIT0W77SMHT+Q+H/dGuoxNE2SSyx?=
 =?us-ascii?Q?eelNTp90KcTHclM4d9ihraAMPvNCN3BaTsAA111aONR2HimVmSqGVFkjwCN0?=
 =?us-ascii?Q?axqp1IiPxfZyHwsaZdQq2R3C7zOrwqKjbY/8bGYn4wvgdK87YHsoZV9TgiSI?=
 =?us-ascii?Q?d/VGnNQtRNcs51ltWQLLIpuVlsN5mQYk0CV6b53a18wO6uWITTKQ1JOYl/jW?=
 =?us-ascii?Q?EADXQ03mQOfI9E0K/DrOb8ylDPbPHVKqUUphZdafu9wGRQQT2Oo/U5PQGi91?=
 =?us-ascii?Q?1ebBY1idtzNaH4e+ipQVLgcJvwRo35qW7/NV4Q4j0iO4N8BfPnGlvPGdEH5E?=
 =?us-ascii?Q?R5ddWnadTazrlQyL8EmeHLx4kADRJrNgT4TgXMH3/Tq5brZfBQtcXNTMXv/b?=
 =?us-ascii?Q?6ZzOSjgC8iPp3jgaH7w634NT4Sh7hA7MRvWARqvdtEomUCkttzPu0baRI/ME?=
 =?us-ascii?Q?cLMJmeqGOj+Hsc48bd+4U9z3BjCyb1sX0aK3l5uBpM8tPr5OoSoDZetxFz/k?=
 =?us-ascii?Q?BHmXueWUsgaX+RW5DtvVlhiFRcI/iGHniuR3+eHNgXMQ3ZoCLEPdKZIRMJIw?=
 =?us-ascii?Q?0GdzaI27i0WdoBGEnA4EvfNnAyt81Purk1JBAKhkuiAeLJ/eRGjJM5mIlrvx?=
 =?us-ascii?Q?L2Nt+B+df6bUWf5o2WS3ZWCybSGC4zwnNcGe2+3FBCvodAUfPaxBJ92Gme6n?=
 =?us-ascii?Q?kbbqP874IWjFRkzB4OoQncUmwABaK7COqWbI5cSQy7AILO0jweGfTbkzItgY?=
 =?us-ascii?Q?u1BVHRdXMLiXE/uvh/14tY4/vfWdCsfGVckIO9yyv1x8FG9bMrAv0/IrKfJH?=
 =?us-ascii?Q?423keR5YZ0+6eyJuAMKt0AKxX3mEy1sf/zNuBkkMxl9/8BYcL7tL5K0kvOWx?=
 =?us-ascii?Q?nq8CGELgRv/N63w9LiNI2AYHoq5MfQe7Xcl/kIwmMsZtcs7043hwop82tUeN?=
 =?us-ascii?Q?Z3vN2MCzZQxYSty8m+sMydTbtwbQCXziOngByRviRQ5qOrq5cb2/dvEp0nlq?=
 =?us-ascii?Q?TYH+LNqOOdJQqrS5Kc1vzwZSbkBGJeifPWmgumk3nWVDs8P9BRW+jQARZk1e?=
 =?us-ascii?Q?SNTCVCQs3F3khn1apDQ9/pEjGYuO42C12sUrY9udqzYcDUTJ9xqG7Cx5MKtL?=
 =?us-ascii?Q?rXk5+F05vNzee0YnaYEF7UufRQjxex+sq985Zaud90WY6A3t9ZaASMVN7477?=
 =?us-ascii?Q?0cv0v3A8GU3AUXvQDki7ENv1Qm/U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sC3NuHXVmOGz3M9C5oIrAC2DC1f1518T2vkL+0qSz/ENC/OsnJ7sC17rxJHJ?=
 =?us-ascii?Q?fe9eypOtRUteDiXConTYsaoSMbBhAhs6N8j2f3CYYeENL0nyzGEEA7cH9MhH?=
 =?us-ascii?Q?TvhDHVvwOcSguoJL8z4EG7HCyUN9KeBSDNdelMiSx+/qstoDb0j88SVNIImm?=
 =?us-ascii?Q?4Xa+UmEkmpjCNi16U5RA3v+l/XnNtp+qrOmjlozoom6B6WMOuH8jG94ebK9k?=
 =?us-ascii?Q?pO9bAOsJAo/KJtNWSA89TA3jBrbLSPFJzlVDtlhrNSsaq7DGK/XIaUeEZ13q?=
 =?us-ascii?Q?dCabciBMCBqC0j37OVXwdOnLLIov0erwUSGMJaU5pQ4A6ZCD/3Rr26L3a1ny?=
 =?us-ascii?Q?j9n3kjUY7iybcGb00UFLYNEaW2M/mDG6jMPHnXDPclRDqmdceZKkfX98LJvJ?=
 =?us-ascii?Q?t0puNeSrQLkNY2FULp23nv+ZAxQgWmhtv+dKmjDanLqv+5shoXYvx/ZN+rN4?=
 =?us-ascii?Q?/3c8bY3PFEQCUxZdiGR3ztLHTWyb5q1vUktFX/3/pd0O7Mp6TckhspW00Tyr?=
 =?us-ascii?Q?BcZBQIZ5UkxYp/BRgfUtutf98T/b4rTArsi9FaYh6jSQ5BFGJwnUZkwUl23h?=
 =?us-ascii?Q?YtAoEqN/WMFkvwr+4CKROHDiVt38dM4yMAPs+aoS90Y0LVLgiplXtD+MCB0v?=
 =?us-ascii?Q?itYRGi5UtiKQmRiXygD9OA8enKwynNG+4GQxPiNEB5biHFW9A0eeRLgHoMVx?=
 =?us-ascii?Q?FNxxeoWit2qiqN128UtjJAyaetKIz2jFybEk/xEXRqzS/4+2SADIGWWAOVu0?=
 =?us-ascii?Q?J95g/zvMnRlrWL9Yt/IK/BPMKVB86RWodvtdXdYzC0UKnaw39pmHPlg58dwO?=
 =?us-ascii?Q?Cs0M1NsxHKZmjDlkxjpvBuyCO27Zg97nibkF0J3i32Ny7/otsUEm9z2zHpvN?=
 =?us-ascii?Q?KHuHMqgRWVAiEZZHvjFQG8tf9Fwo4w8LhVc/UCbwOuw5nCR1ZIBPDhKWipMr?=
 =?us-ascii?Q?fH20RIE4pBV5VdKmiBZxpV4sXs8MfHsOLNUQX1hz6JlEHWtutfIBxXgU+THv?=
 =?us-ascii?Q?9xyt7zjTnjSFN5b8uum4eewjP0P2haptuZkpTHAvocZMMRGLHNMbfmNXmnQw?=
 =?us-ascii?Q?M9UE3HkC/rqDUluGR8wCnFXpAmuMV8LHrOlu1WkuHhIOIqq/zsCm1GchDKy6?=
 =?us-ascii?Q?zZpU8XtxUpNo9l7irTaN8xV+AjFiv4VdNQTAbEkKkQimcAlBjnu/6/0Mk/32?=
 =?us-ascii?Q?l1aocKiYH6CwN7/Z0hsmk2wgbfe7m/ieKwgH/e6+7TlqFNF7wTXVzpg/3nnn?=
 =?us-ascii?Q?zmptyDI0Mhn/QunBQn9h8S5TsOMPJzyZWl9YF5yHkRCgFFFjbXlo3CO/ygex?=
 =?us-ascii?Q?C7lQ+Zfhlzb7Nv+bZxNWA++mOIk54ncxmGerm6inAntPMQvhMyHt/s4MDXRo?=
 =?us-ascii?Q?g92wU3LoAzq7v+dHUPPHL35PgvB4gFzXfvimKL+wgyxrHun/4ewkOZdggXuF?=
 =?us-ascii?Q?BP1Ntu6OvJwCXrFb0t1O3aRJKPa7ABOJJY0OtBL+TgdsQ3LGLYAmvhEUOWns?=
 =?us-ascii?Q?HTaDuA8vbBqTy3NOGJjnyIYNfWwn8y3q7Wths5BH2YLgec+WyViVJIwAacGq?=
 =?us-ascii?Q?QnLaoAAQcINJl3RzSO1AJLpZvrsgKw398DsDNfOG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7000380c-b316-45c4-de73-08dd5b1f1c1f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 13:18:53.2278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWwO4Vpo+41dpsi7lE+COaZyr1zceAM5bJmPo9bpdrPxxwXvSwkRLcxQotW3u4iV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894

On Wed, Feb 26, 2025 at 04:17:27PM +0200, Leon Romanovsky wrote:
> +int ib_create_ucap(enum rdma_user_cap type)
> +{
> +	struct ib_ucap *ucap;
> +	int ret;
> +
> +	if (type >= RDMA_UCAP_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&ucaps_mutex);
> +	ret = ib_ucaps_init();
> +	if (ret)
> +		goto unlock;
> +
> +	ucap = ucaps_list[type];
> +	if (ucap) {
> +		ucap->refcount++;
> +		mutex_unlock(&ucaps_mutex);
> +		return 0;
> +	}
> +
> +	ucap = kzalloc(sizeof(*ucap), GFP_KERNEL);
> +	if (!ucap) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	device_initialize(&ucap->dev);
> +	ucap->dev.class = &ucaps_class;
> +	ucap->dev.devt = MKDEV(MAJOR(ucaps_base_dev), type);
> +	ucap->dev.release = ucap_dev_release;
> +	dev_set_name(&ucap->dev, ucap_names[type]);

Missing error handling on dev_set_name()

> +#define UCAP_ENABLED(ucaps, type) (!!((ucaps) & (1U << type)))

Missing () around type

Why not use a static inline?

Jason

