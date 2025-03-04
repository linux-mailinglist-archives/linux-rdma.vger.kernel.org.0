Return-Path: <linux-rdma+bounces-8337-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E68DA4ED97
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 20:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EC13A60DC
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC8F25F7B4;
	Tue,  4 Mar 2025 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DJfVWoMF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD0A203704;
	Tue,  4 Mar 2025 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117201; cv=fail; b=idndVDwQy0+K6H4Vzhvkg5Dt4TO5E6Z90NOQpTYNbdgQvh+yrxKeaw/rI+y12+D6sv0DlUj0LJ7U4oqNP15kqiUfuJOd+ckmWdwkYoTtGLVrPYBrGMX3Y8K/D1ywsobibW3/Gc70noVFOLg4EtzB/YX048fbVd5AJ3Tvue8cvls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117201; c=relaxed/simple;
	bh=XdZCwUxdkGp38VVBPnffzte6EalsEOUATNMg7qaymZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dwpOu0G4JAZaOqL/C1xbIM8aQF2J8/vBmOMqQpc8oHWJ4ZbHc3u8wF3D07drAXH54/uwmqe1Yp8bHeNDfwdemK70L3Dok5WGtTCzqJu7i2bZR5FXe3NdTrziBikhSxyNVR4ed+jQIG8ZyKpgES1+oAqIg0lNqX5zQeIKf+v5oyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DJfVWoMF; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBSqaWDRwCx4AfvDC2oKT1JuE7XNbW+Dc26gY9NuL626BByaUgBQ8mnZhzDndQOCooja0TahRhpvb57h0Qa62IuH7uEhvwrmQRFVAEmtFldLzIreQOK78gUB9MeaBw95Pg4UdYfHa8zAhKuzuQxNUzHl1a8uGtygLvUkU6iOOh1RDClgFjlEgqKptmAa4H5MsXHuVEKXgKNY7WNMbDKqxF8vjc1drWGEP0fo+BrUr4vhXAAGT8jzoyMXuHBq2vP4KaO9bOcBba/c0pi+NOLsh8ZNunH5aeS8bj3WkbS4imxZssM5GSGBItk6+gZXamb9/JyU7Ae0DIlJ+wH1FDzlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79Em+/HRy7HdU7T4umrfn3H/WkUQK9thc3ut0LuZYWM=;
 b=wysd4d4RscDwf6x7+e47nOSQ1n35iqCUlA+4rKrVXhviR9VqG2qW3DF0f/xyIwjDFSeV7N7u9FKH0joi4JDYMyu2OYiVZDVyFAgrNhrpXBak75OIxTvsNjEbx34qn1OKEG6wFHd2EjdfP/5LolU6meYTqsm5cP8fP0RpJ3/ujFx/RMt1AMIfDqwBKTxiukkw/c20lAIKbKu/H3BSdEu2B815x/e4bKoWEr343r4gf9YNjiSfAkrEN2o/Vm3XIWadWGZxXsBEAiYDmkwrcBDZj+oTczG1I+fX35qcZntVuOCDKD4A/VDEW9CRAZdf+pRZxHEwATvdAxfan4oNrsX+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79Em+/HRy7HdU7T4umrfn3H/WkUQK9thc3ut0LuZYWM=;
 b=DJfVWoMFrNHPu1v7q/oKstuJRRHoDNrASgAFHuFkZWOltEsE31YfIPI9zK8Ku7+b7nhHAsQR+Jb9HW5nCogqWxq5YZiXaqJ1PvNb2PZJC757QpYVwVj5M4sLJyDR2IBviMwiPzSH2tlJwOHfPEPmOzwhtEteDxfBRXejjSViMBeu+sjJ+58Sw04oUYrjqLVpY2czHFPfQRVVse6NjkXcdBTxka/8mMwpKlKHKplUL0TSZOw2Km9s0ciEyNQHakclysENEqAPwE29vMMqb1aHBOfaHJ/7R6Tu8AmOcTtCszQFv/p1+VZ6fpxjj6k8xRBzqZMxB6pSkd5FZ/lbvbY8cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 19:39:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 19:39:56 +0000
Date: Tue, 4 Mar 2025 15:39:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
	dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
	dave.jiang@intel.com, dsahern@kernel.org,
	gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
	lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, brett.creeley@amd.com
Subject: Re: [PATCH v2 4/6] pds_fwctl: initial driver framework
Message-ID: <20250304193954.GT133783@nvidia.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-5-shannon.nelson@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301013554.49511-5-shannon.nelson@amd.com>
X-ClientProxiedBy: BN9PR03CA0431.namprd03.prod.outlook.com
 (2603:10b6:408:113::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: 47dd888c-bfb7-4f85-ea9d-08dd5b545754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KkqlX3oad2tp+6g5036diETpXRx9hJdpaAW9/QPlFiV1AVgqwuhyuGgQq4pm?=
 =?us-ascii?Q?sxtHvwBfMKrNqrAzJTD30G+Xw7ax3g1+W6qHFDaC4t2FgE5CiW19ByGtRqOv?=
 =?us-ascii?Q?0w2PmFTy7CNhGgoGcfZx/+Z92qASWJKPpmLUhvv+BoRy5T/DCXgwC4Ak4n1g?=
 =?us-ascii?Q?nn/Qim6D8b2zsNV81KwRDvpQA8EzAf0zq//3QScA2989c0sUIZdgoSDBWVs0?=
 =?us-ascii?Q?NdNbg+LFsODyjuG8HUgZ3JvYpF6eRfYPVX0B+TrMjAsi+9+ChKzxj/ShqTcA?=
 =?us-ascii?Q?xvINw9p6LiU6dubdbZCk3PZ5prku+QCa7UigIOUQ7iicI1bDHIg/zp4AKBJ6?=
 =?us-ascii?Q?8roXWoaw60WAkaPXMVus3qkE60jjLsdwF4M2BgtT78TDtl5ASRwdEKFJgcR2?=
 =?us-ascii?Q?im1BIoSjL/7cQZXqChv6uo22CGu5XFU5MkeXc75+/OTZWu2VmH4EsvCulvIV?=
 =?us-ascii?Q?L8DsSoYoX0sPQtVGgp1QMoIp1oepn1rL09UAWX1SOeRPWF6UcbeHVyqKu2RJ?=
 =?us-ascii?Q?O2zVN2xkDPzDx48qSWveVY7iWsavNMN/AyUa2jAr1O46/ayiFvM8wxsyZWEv?=
 =?us-ascii?Q?BIzG4BYwq2mmFq15F9JTI24POk7XSzx0VE4LZ1EXR7pehQ4CpGKC2nd6m3yp?=
 =?us-ascii?Q?duXUjdGy9fjJYTXzHRoa0ZNk7XkG5C1Os06QapSA9efuZEWeG6GueQRSMdjo?=
 =?us-ascii?Q?bnRZGhF92dvfaKF2CA8XnPa7LGM41NIeWVnhYAYUslNaCA/BXbAOdUHpY2DV?=
 =?us-ascii?Q?RWN9ifPmGcxgrQ1SZoYLPEkElf0bzWuF+dJX2Z759wR5vvUw8aRLq61w+tvv?=
 =?us-ascii?Q?/5dSWGkJJucusiR+g+AolIO++C6XfLemiIUc+Eh9QGb2T/3sIPODg9U7fRku?=
 =?us-ascii?Q?sqhkHAb+uxZq76NR/h/3VAooz4SJHKgbpSpbS8JXuoz2yu09gpq/ZLBDvtM2?=
 =?us-ascii?Q?MW3HbgAXDg856uEfwOO4IgvGzECVzJUITKFvJNpY7yR9nbX3roVptjtHcJPy?=
 =?us-ascii?Q?TidqYXCuLvLA+ms6QxebULvZTZvh/2g6hWz2wbwvMwsBZsIZ6LRQSXtKF/gW?=
 =?us-ascii?Q?qexyCtDIu7lffbJRgPcTPdMGeluk/pQOOVHNU+Zy0K7T1NSRpWVrldqN8PzM?=
 =?us-ascii?Q?ZijXvHnD0e67RD7DIPQNV/BJ16p+JcBdQcq1eL7FGbpoh2DdUUgz5yN20XhI?=
 =?us-ascii?Q?28SLadOz0GRuWS+l2SNHF3Nnusnt4J2UjylhE5eEHflZ4PLn+rWZinpPA7gT?=
 =?us-ascii?Q?+825ES8PJi1youbonxqk8+Vii8wpy5278toRdRN2Qs4lGwfzDdkXX9jWN68b?=
 =?us-ascii?Q?xXnaH9/kKH3hd+PM/LXqsgpPB/J+r2OpI7sBvNWAkgzEfsFYsD/9sxomUn98?=
 =?us-ascii?Q?iy9ifPBD+xUZnHLCSQ4UtsDu5Xg5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sk2hDxAE37IbFrFenR1lUn3N626XT2XsmhXv/O8mZkvg1CRMvBVGXgqiC6jx?=
 =?us-ascii?Q?0MvGamWF16jSAB87kzdBQMsc9GxghQYFlXyVjFi0wwCU3hxXBm4zWM8GLxRD?=
 =?us-ascii?Q?gsY8/+1fJchIvJLvOpclDngRwrpmgRpNaPXt9EZQTh3qad2cy7++E4XSj5WT?=
 =?us-ascii?Q?cUET+yqoO2TmbSiD27oHuLDgQlTrQnGSJq4aSclQp/cXPzEefAwKkIa5SN+k?=
 =?us-ascii?Q?xfYwhc+7iwX/z3E+Ldq9SMqDqRF+bLMYzFLpvbq27FqhexCXBLaEmvr1xM2z?=
 =?us-ascii?Q?sy96EKfiwibJPwHpQWHeULd52MVwcCKJhJANus+yWAZzYzCSpbhjXQnVfAwI?=
 =?us-ascii?Q?xy/8w2hoKMD5d56xD4aBkAptPnadxjRGNUpdvRbpB5Gdyw3MsiXHN35t8yFh?=
 =?us-ascii?Q?UeJV7kWL1Xc1TvZa2RAIX9f5H1ytiH2P5fNARhD7Ry/ZS+jaGxrMWsKQNYEN?=
 =?us-ascii?Q?ArcEDOshz8YbGeKJSgm6/liV4aMMU0k1j2up7WP5KrWCK9Y7+5f+fWlydxJX?=
 =?us-ascii?Q?+XpVDvAmYG/4xpUqTzz1QPAwK2frRdnV2675OdKQP5fd7WjeT0YaMpm+kvQU?=
 =?us-ascii?Q?iIvdxRRS7OE6bIzd5iDtvVJisy3VXGqJosw43Wjpaf/W9OMR1lzW9Gc5rpKZ?=
 =?us-ascii?Q?79FFPVgpFStE7ZbLkWaeVki4pCJjrM0Lj3WNXDouSJ5INGP9yhZtPdxTneSA?=
 =?us-ascii?Q?yvXvLMc7GZnyRt9mQjYNrFPd1m5rV9rPtoajqClYKWGjsZjbpPIuERrSJ9/p?=
 =?us-ascii?Q?xNby7wIK/VsrvTHSHs8Dl9rJtn34ZDbEX7vQ+5I8Lkd7nnFrbnY27fiYsBE6?=
 =?us-ascii?Q?9OPnj9GaX9zrGJp/pwUj0n0mV5yLJB8fiaqmBZV8c3C4ZNMpHznzzLBHk7Dn?=
 =?us-ascii?Q?Z5KMGwAuzSmly19ITO6xPc/TBk4325MO965UFFHPVhejOe5+mux3U8cFkrLc?=
 =?us-ascii?Q?0tQGYNwh0mvmzfwmQcu0EaL/trKzqHroNnD3TdD/UIks1RvoZpow7PPhVPDo?=
 =?us-ascii?Q?R2O9iMJC3p9YGMtuBP9IUd/X8N8tnfkI2NB52VkelguWGQPUa2rr0tIWPb0W?=
 =?us-ascii?Q?KuhMCdbkN2esNh4IC9NSi3dhnQglBx4uR2uA0Jd9p03I9o09OkaPw0gHH/dd?=
 =?us-ascii?Q?BoiekCVw01EYMdQ5oQz0UCpgDEQW+QJ6QhLvhohXE4wZGatvsz9u80BZzynd?=
 =?us-ascii?Q?cXeEdqk4+5ZMJLSK8jY7A3hEJmj0GFtjmOWAU50EswGoz3mLEkDdepVzJJ2a?=
 =?us-ascii?Q?0q7cnFaI1Ah60HFZik+aOSD8MZSTnVba9gPVSCqHtr3y6xOGp6GThx8sy3Sq?=
 =?us-ascii?Q?FON3Juz1+BnPK75foxEJD9zF3/tpgUu0PZ3VvCSXiFZ68RerpC7n/nEHhEgo?=
 =?us-ascii?Q?z64pET+VyACZKhEBQ+RiycjAVYRszlxS3DsTHAVrhOXZPlExUX4UaTgW8EjC?=
 =?us-ascii?Q?TjGFRjYNdsmoTL1705GcgA+ySTyVdyH5jF1nzsY0qmgH23Bu+JBz/ClmnqD7?=
 =?us-ascii?Q?zbO4JJMHFJ3aSaAP/iB6m0gL7oRL6U3vURJ0hOL6N/TGde7D1M6DZkjKIDis?=
 =?us-ascii?Q?CRPrEk8RTAQuaucHiaBrqlVi334jLhBvklkPGR+k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dd888c-bfb7-4f85-ea9d-08dd5b545754
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 19:39:55.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/ZvBU8Plmc104gqA9bF18sJZxevfmGl2YaPH35CBrLznVLNakZGYmM+CLQ0sHzU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038

On Fri, Feb 28, 2025 at 05:35:52PM -0800, Shannon Nelson wrote:
> +static int pdsfc_identify(struct pdsfc_dev *pdsfc)
> +{
> +	struct device *dev = &pdsfc->fwctl.dev;
> +	union pds_core_adminq_comp comp = {0};
> +	union pds_core_adminq_cmd cmd;
> +	struct pds_fwctl_ident *ident;
> +	dma_addr_t ident_pa;
> +	int err = 0;
> +
> +	ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
> +	err = dma_mapping_error(dev->parent, ident_pa);
> +	if (err) {
> +		dev_err(dev, "Failed to map ident buffer\n");
> +		return err;
> +	}
> +
> +	cmd = (union pds_core_adminq_cmd) {
> +		.fwctl_ident = {
> +			.opcode = PDS_FWCTL_CMD_IDENT,
> +			.version = 0,
> +			.len = cpu_to_le32(sizeof(*ident)),
> +			.ident_pa = cpu_to_le64(ident_pa),
> +		}
> +	};
> +
> +	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
> +	if (err)
> +		dev_err(dev, "Failed to send adminq cmd opcode: %u err: %d\n",
> +			cmd.fwctl_ident.opcode, err);
> +	else
> +		pdsfc->ident = *ident;
> +
> +	dma_free_coherent(dev->parent, sizeof(*ident), ident, ident_pa);
> +
> +	return 0;

Is it intential to loose the pds_client_adminq_cmd err? Maybe needs a
comment if so

> +/**
> + * struct pds_fwctl_cmd - Firmware control command structure
> + * @opcode: Opcode
> + * @rsvd:   Word boundary padding
> + * @ep:     Endpoint identifier.
> + * @op:     Operation identifier.
> + */
> +struct pds_fwctl_cmd {
> +	u8     opcode;
> +	u8     rsvd[3];
> +	__le32 ep;
> +	__le32 op;
> +} __packed;

What's your plan for the scope indication? Right now this would be
restricted to the most restricted FWCTL_RPC_CONFIGURATION scope in FW.

> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Copyright(c) Advanced Micro Devices, Inc */
> +
> +/*
> + * fwctl interface info for pds_fwctl
> + */
> +
> +#ifndef _UAPI_FWCTL_PDS_H_
> +#define _UAPI_FWCTL_PDS_H_
> +
> +#include <linux/types.h>
> +
> +/*
> + * struct fwctl_info_pds
> + *
> + * Return basic information about the FW interface available.
> + */
> +struct fwctl_info_pds {
> +	__u32 uid;

I think Jonathon remarked, the uid should go since it isn't used.

Jason

