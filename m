Return-Path: <linux-rdma+bounces-21240-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDmmOdxtFGoTNQcAu9opvQ
	(envelope-from <linux-rdma+bounces-21240-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 17:42:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8852A5CC6A7
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 17:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E01C3004D2D
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086FB3EFFDE;
	Mon, 25 May 2026 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QZzrJwaD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D0D1A0BF1;
	Mon, 25 May 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723735; cv=fail; b=imPj+7Xmy5kpMJZsyu88ZxXvIs4YSA0TZKfX/YwHMFPGoDbyflnImOAni2smy4QZyRm0OqtWfPUsyUNQ/0e9UcWUvsobm1iSuF6HLJMarGUadheWSHb4keq0G4H82ZK0Ox9NUtJSY/w5stoNF28GHhHq8m1RfM/KobosUM2th54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723735; c=relaxed/simple;
	bh=GDSRFpO1j6ao/aAAAT4eNBdLUUrhcwaONkyPVN2BG/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GuCms6Ti0af5e8irwit+IXXZ7TeJZuUfAUr57M8m+ukttAvg1ET1GUUIlwAfQySKSkQ/tNu/IE0OdFk51/H2z6XXrVBfHy/1Syi+ZuepWwa3kjXbBM86zwWx5tnl1y1Pl30ByNOzneIkkcCo14eEtXUUwRZTirdAnq8bRFPZb0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QZzrJwaD; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AukCoa6qoHE1ab9NeMEEilHKuIWSOazK9eryHFlojeA0uIMEvD0Wa8RVHZZfTC9eUpAOLDHEGtOxM+3Z6Ymt3f5h1HEYUdjdWeA5sN3M0KFF5vqmZqG9NIAF8YCYZHm4PdP7p7YmVGTy8DOA41ANiuYQUoLFje/HILGmHPe2IiiV8OmR7eNvWih1zO5zBeOsJ09pyoStgu8WT/D+Mql3MwlJ+A8xFidBvwyq0C3Di6e7zQOTtnVaTYZcj9nS9YWJUVOQVmySlKFIxhu+H+u+kKMrMlwNLUcKEUj5MHkEBJOJr62jzKqkT2HZY48XCNxL0q304JLSQSEnzymGJde05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5nK9teiPuXnfz/4vzu02lHBoSPBKTsiLstfIQKjXaA=;
 b=SO0eygfA2+QW+ThJHPFDnYKrN9wjvnKmu/rmeckg2eGmurk2IAqR4HFCsdvioXnvn92VzDvqP+HGu3d1ijogiYGGxw26fNyWGvyuJwMYAUAPMxTfbXGpBxJceqm0xEInfxHNi1joHXt46ytKohihzMhDL2q3JCfWcLd12rLY09QEMrRCCrYPo7lMo0sZltgCG5uPljIThh7OtITI43lDGTbOoxXK+CPiRgaolrh01denpVsnlvDTzCxaG3WdpKgyk/R3Ps/98TF40q7+eNUF+mL93UrUbxBRTn/4fFgUjbyvO7RCOvf+WCan8EuLqdVQZ/5ESWB7JAlH2Ss61Q0RbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5nK9teiPuXnfz/4vzu02lHBoSPBKTsiLstfIQKjXaA=;
 b=QZzrJwaDk3God0f/9CrW+xyc6v/MR+1wWadjnefviDZ6YUvXqWAvDwwNEdkC9CTRGzvchjZ5X3u7bc5PniJIq+QAovehR/7M0HQ66pGWY9e4RQ+aEhFoi/rOODOB/55xpzxB+WtQ1LegY+mjo6SjdYvNmOp+DdA9sUlYbfilKZ6ORQiAuxWwR8L26jXkWhcr3kzAcFZmGm2g3iB/o0ld6OylRbPRB4sEwb8tQaeMTstcVxC63kNv/yhjILKrH+hTDIkqlpBLPxXrx8aIeL8vNXtLo8RQKpvEBzEg83NUHEggmz9XnXBvnbM97prWov/xuSIzLC4ZN9IVC+rV+4ps+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 15:42:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 15:42:11 +0000
Date: Mon, 25 May 2026 12:42:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tao Cui <cuitao@kylinos.cn>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 0/2] RDMA/counter: Two bug fixes in counter
 error paths
Message-ID: <20260525154210.GA2481160@nvidia.com>
References: <20260520104546.1776253-1-cuitao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520104546.1776253-1-cuitao@kylinos.cn>
X-ClientProxiedBy: MN2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:23a::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8a31ac-8d1a-464f-4513-08deba742f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	te8uIA/9fJbRIlbMSVCqRi6JZVyb+doE6DmabVUcR21xVDdgYjcancX2SIQelROXigQrvJLaH6mhEJozMNy+YAoRPnQnlQCtbdo3EOv5C0puFral9jQOItOPpwYm7Pr8PF/g0g4GJzO/ZG6dRH+VV1qegrEV8yYJw/qG/je9vW9V8+ESqwQ3o6NJIKPGRicRBGFx4/WEi6mNlCFSGBjVHx279wDlYLVmD7nuvASwJE/LnAy1XFqVSVXLQOdJ2CANzERBMOS66onQy9dZToYi0sPZa9MqDD8tNczv+hEAUcgoDSKIt4TjzqVGMXl4M/yyokgCteNFI7fcAxW4LKL6lhe8FIsi2QXnCuKidPRl1tQ/7Od9susvC7/znDR2g46aPwV38oCe8h/32Y/gBb7VNoIUoDkzs+bDwS/PovAJRzYjOwMIX+gKJ77S8JaVeJDa+ANigQgY/43HgNP8hOCqrfvSVKC75b0siKnW6lV29l1LjGFhsPOt4WGow1KNXMDayFttTyLEjhGGvzn81sBa2oyegSu5ATaWxwx29u9zDGyNuUwUzALYYpssitwjcRSDk6YZyE3sa57TimnHG3jWH/cfsa98FhOIYgEPYDl0aqd0qqJtReSqZwwhlFHLSN/F65wHKTgrwYGJjvvQUG53MdgyTG1wpq9pJ8SxqA0sAdHyTuMngesG6Xl8S9JwZ/yU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FNf4S1XdXz9tADCPJyl+ZLj2PTmu/L5GRYSAcNDoPWiEEDSq2L8JKxG7UbSO?=
 =?us-ascii?Q?gwX7f82Gr22ghAa3ohQDvgOYzFWckErAG1N3XxPfGV6pHMmjT2Bgni56a2X5?=
 =?us-ascii?Q?Xzgv+cukdVxAa2Mq8V1yn1PpSuvk/s12WL/wwcbf3ktwHKPeJ9Gn/J9QFSbg?=
 =?us-ascii?Q?zqs+dTWSlVU6vlKDXLZk1n5x0WzrC+49pR1UX8l/qSF2Am4DFWnQThen3+OV?=
 =?us-ascii?Q?URo9e6C4epKJUFp40HtZDR3g6aOnQAcoIv3qoteM9XlEs+Pxu9FBRHYJgvOi?=
 =?us-ascii?Q?qvo7aUJU4pwOJN+30QltQovMz02UTJykoi6BBPMU/yEMznyqsIh0QgCi/H5u?=
 =?us-ascii?Q?zbX98ylCFaxPP8fHTuwSrlibP8cP8K5FGvDQLlgHiaEK7J77tOHaRCqJtuh9?=
 =?us-ascii?Q?jgXAVgtgFYddmQ6kOYf+39/32gIDR7CxEd4g821dr7polN1aqPm369ZF6R4a?=
 =?us-ascii?Q?+N9eDQ9apBodwpKJSDREvc/XnwQTX64pyrZqcwU/T7L+UE0fZ5DdkZ9NBqJR?=
 =?us-ascii?Q?W+DaBEFLdIhepQwUqgn1NLPCulBDpvbDQLr7OQmkNNohrQOB4aVkyvJbvYEi?=
 =?us-ascii?Q?skerwtdr1qTuQjIvzdVRQaDOfbBybVw3D7ehMZlfLWFhNb4EW5IAxeIhaOXF?=
 =?us-ascii?Q?xOY/lkPSXrXwSxPXYUhAsOS3pmbd/t6SoSwkciZ6jQa2TwlTdHOtPh5hpN7V?=
 =?us-ascii?Q?vR0TpsT9nQ52H6DuWolhZBBmj+Qefjjv3b/01ho6hOhrd3rAGFdIQ1/5U2FE?=
 =?us-ascii?Q?b7UPhZFw0p24HIoaMPEdTJuhTqGcdYCLYNpof2Fz39SmgvzfUy6/RlISM+jR?=
 =?us-ascii?Q?5N4gG2LBzrg+LZZL+djf4VFSAE6zklCfCsy61XqHjYGvZ4aSoK7nZFWSEuPk?=
 =?us-ascii?Q?SzW1INora8mfa7RC+fHkfpQqCwZsuAkxerXrdr8xuUmxtSK3yh1Y07X0+Bso?=
 =?us-ascii?Q?tjxzJ+8cMqHQovivLn3+VOp2xh+DzomtSNUEZn0ZynxWJF0WtwwjgW3nkmrC?=
 =?us-ascii?Q?PUT5v0PiHsH6x+NxOmjpKI6mS0zQDJPfniL6AzipeUX5LCnV8Pj1MDKkUv5/?=
 =?us-ascii?Q?GW8hB7zeDHob3o6J/y7CTLEX40H0cCzwOyL/4p0pyH7QOx4sRMAFxatluD30?=
 =?us-ascii?Q?zer/CrRAMY7qquIBu7ZhE12G6SgkCoGTr17SHf/6XBbGITieKYLjBmngJsRA?=
 =?us-ascii?Q?gcPwrsEjhelZSoiMYctRV/aOXnTg/cunphF5qMsN3d1VfMWCQG9VSEAAEYoB?=
 =?us-ascii?Q?shskyurwGd6Kl/+7UzHRHuNBno2VcNqqpKu+1zoeIyexoQWasoIAxV5BLDlb?=
 =?us-ascii?Q?5GrbP2Pjns7bFh9BcCcUBfqTWX33RtQomQpmTNbJVBVoq5ofoU8b+gDgh0PO?=
 =?us-ascii?Q?yTnkGbJArcAqGktOrsFG0cEpwuu7cc5W5A72r0eGFNfNQacO7FxPyArgex3l?=
 =?us-ascii?Q?PwyZYEghyLtU35mrivtbKXNUQEtbO+85bI+rvBO4slG4lIqt8hvlrSwY1C+u?=
 =?us-ascii?Q?rFTTGbuq3g1qv/9xpzIwb5dfaNtAyyBs+PC99pKGuwO1qLskhRG/wun24m7C?=
 =?us-ascii?Q?lRltYDLVfMUvXQicAsFGDh9xHDX405z8cZg5Jagi2Dm6Pa87WAfaNe4iAOcJ?=
 =?us-ascii?Q?J9+smj1mjmshWuAm6cUAiDcEReasFkvGjVpMslkjTsaBZFtll0STD1f3RUuD?=
 =?us-ascii?Q?OadZ37yDOR1Qf0ZTByVV1uIz+c1NJb1gaqVJ7ZRpVI2le2rB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8a31ac-8d1a-464f-4513-08deba742f98
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 15:42:11.2282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6kxzvRspQGJHddSZgKWu9uDmKvGa7erzFrF537PdwZMPpzoBb3TcDwt2J8qLeuk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21240-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 8852A5CC6A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 06:45:44PM +0800, Tao Cui wrote:
> This small series fixes two bugs in the RDMA counter subsystem,
> both related to error cleanup paths in drivers/infiniband/core/counters.c.
> 
> Patch 1 fixes a variable mismatch in rdma_counter_init()'s cleanup loop:
> the loop iterates with 'i' but indexes into port_data[] with 'port',
> causing double-frees on the failed port and leaking hstats of
> previously initialized ports.
> 
> Patch 2 fixes a num_counters leak in alloc_and_bind(): when
> __rdma_counter_bind_qp() fails, the counter is freed without
> decrementing port_counter->num_counters.  This leak accumulates
> across repeated failures, permanently preventing the port from
> switching back to AUTO mode (-EBUSY) and leaving the mode stuck
> in MANUAL when it was originally NONE.
> 
> Tao Cui (2):
>   RDMA/counter: Fix num_counters leak on bind_qp failure in
>     alloc_and_bind()
>   RDMA/counter: Fix incorrect port index in rdma_counter_init() error
>     cleanup

Applied to for-next

Thanks,
Jason

