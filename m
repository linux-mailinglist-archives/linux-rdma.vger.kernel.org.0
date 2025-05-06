Return-Path: <linux-rdma+bounces-10101-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EF7AACC40
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 19:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C01502E70
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9682C280008;
	Tue,  6 May 2025 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EbJ+MVak"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42825F7B2;
	Tue,  6 May 2025 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552719; cv=fail; b=HWF2i/eJTZTLkraOWHQi9N3Br7KwNjZ2/1mHC+x2LITYNSyxBFtZkNXFQ+oprRI5+3pdA7jZ5CA/s7t6kxQiJVUHIovk6joqO5lTgvmbfzHXCcTJ182aTEv2kGdpVywrEdukHxTtw8cc6I5iEATpKf+2nZ+J5ymipGR4ciFL60s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552719; c=relaxed/simple;
	bh=FFzFZusVjbpKpGSWitE5DucJGYyZks9ApEERDAfsaco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MeHZ25h190feM8KeXszqcUCMpiwcqxzm7JQhZzsVmj35PzRZbjEWSNbYQsOwmxort5zs07WmGWTATYDI3YqGmK2JsT57yO2bRh2z23sVLZs52tuCvuCrckU9KqJ9hbZ/AHRId4fl/hyW8IOA2+4NuE5+n4TnOBDVFHDSAH6aPz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EbJ+MVak; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jV4neKwDBQwSLyfeD2Q+NQoE/cIpw7Z0VLGanXKkRRMKBSvPLmlcCP6xGLWMkMARdNjFUsCRM0ExDoJomVtGwO04DMWvFplYijD1xYmSyBJK552plNpVeAs6btDjqRkSuZqZnrxhUJxpYtyz9gJ+z/1dIDpUUPvP0mLNMAZCN8SpS7RfhqEoOs9ySPQDD4vdxClP5fWf4OadTV5Bvlo6WD9JW6/zQyeOg8oBolEUgErBzcDvGsN5l3RrW/GJHefsoH2Wkj9Tjv1PQqAKTILgs2KAAM/FaLylSoT0VDclaxakK0wLQB6HlrnWlaR+NQA03cvbPNS4T4ceUNd3k51Bwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuSA8lm1U3S7won9O5Fi8gbUl0W6seV2jtguC1gIh5E=;
 b=rJPgcGWvyhEE0DHcVtuSb6IBhhm4LRZ5PsUBVj+BrI25ugCm6Stci5KFRlQTHTpX3J/hToZRtcrE9Mx/Y1ooMBoX9elwxG5upzi8oFM2T4tmxbTsnpVzz8Key9gDDd/O5ASR9pNZ1Dtz6egUn0g2Sd6YmVCU5magWS80ygONYAbYovj/Jk8DrlbSONpV2wzDD203bmROewARmVKj4J0pjjEZO7B5A4EFXITxCMxFkRioVRAu1efHYOe/uvOStaZlWTnN77rOy6g7J8KS9HKblrQrCbvMPDM79JaDFDmweeixWCLqfKLZHOCSkBbS8rCL9ptZlolzf4YqDC+fMODnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuSA8lm1U3S7won9O5Fi8gbUl0W6seV2jtguC1gIh5E=;
 b=EbJ+MVak8IZsqMRANcROJAGf6xB68uXyMqRyIeBfMpsp3OYHUDl/oF2dtEDRzjsJv5sBKynYdYkuf0HMJ5DsL0DNjbwO3otUS7XZ0RAHwbNpb8PQ1nl9WTCRlukVQ8CiJ9wy0NEVfIZVAp8gvCo96MpQApkYCV/h8vXsRa61jPX6Zl0HlwdHhd/5aTAb/NJ7vLkTP85YoISizlwrjFv4W4I1CvMcqt+TI3RXM6laMA0Dxp6btt+N08vM8dG3tzp/mIBmeex8LX1X/igPXdlln2GVIvAZ8G0o8J69UX64f78FHl1cB0gdzeu3Y3PlZbm8zN+g2otpdK+Mh6oNspYX2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 17:31:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 17:31:46 +0000
Date: Tue, 6 May 2025 14:31:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: linux@treblig.org
Cc: bmt@zurich.ibm.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Remove unused siw_mem_add
Message-ID: <20250506173143.GB83499@nvidia.com>
References: <20250505210226.88994-1-linux@treblig.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505210226.88994-1-linux@treblig.org>
X-ClientProxiedBy: BN9PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:408:112::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 88884014-1288-49bb-9b98-08dd8cc3df3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HCUiBnTKmrs+YbJbo1R55bpFS5Im5q9E2dOhuxVTJDw1V6xFePIRjX8BFKxg?=
 =?us-ascii?Q?eLuVKVEIHJ08kqDCIIl1iePwOveqOocV914cAE1kbF7swct82U2ZjCRrySHb?=
 =?us-ascii?Q?DLrcI4F2P8Cqp+6xt0KiTAS0TYVgXLUUaSzrKeE7VLB2P2K7GNO9LR5KOt0u?=
 =?us-ascii?Q?+qr5zTbUgqyQgXJaQvjpFM4/pjWAxGJLmoXChykTMQuv6JoYxeJQRx/v4P7G?=
 =?us-ascii?Q?/HgqXIEzUs6lMPDhfZcgrbxCLDY1h37pi3O090sneJxDmWZhxUk29ucOx2X3?=
 =?us-ascii?Q?u3Ra+Q7gOBk/mua8xwfZKlzID0W0jqLStLqSG/QAbbtKOoXqtLwKFKm8q4F1?=
 =?us-ascii?Q?1C9Z09NQS9e9jPB7OhRR1ZaNP1EFxrbPi1XwrzJRxob5Qu8vqseSAT44BAdB?=
 =?us-ascii?Q?2z6Fsn4toq9KOxb9/OMCxejlodB0bWemrjYTMowxJ53XBZTE10BaJuFscIRK?=
 =?us-ascii?Q?bvBuyvpatrwB3kVK9gzh1EYl42MA6sPVuAcGjxh+6Snm2/gXYoJgL1PkQRhq?=
 =?us-ascii?Q?A4FJS491yUhSEXP7S2GikwyEyoNCOjHdNv+E8+oNAn+xXGvv4xTaQqA2bBZT?=
 =?us-ascii?Q?KYfG2LgMJBRllW1fRsfZ1zsnTfpZKTi0e9GRXoH3XDnCFDcegfqMDcj9C7g8?=
 =?us-ascii?Q?/cx5X06bQ84qpvMuA16x9ovWOvT/zNowCpzbEH2ReorqwLB7YEd23hSRQUBy?=
 =?us-ascii?Q?GF26UnJYk4TU/cEjP8kgQ+T8yxdfLUB6V5BHNCdDGRUDrVEwvxvECTfxv8n2?=
 =?us-ascii?Q?/W0oXULPoY/34IWb3rbpl19LLU7YUDWleBOOW0WzzC4XaaWxg2PEwewQGVGR?=
 =?us-ascii?Q?KHQ2A5QYFUjIga0i4pK8Sz4lEu5ktDSo5G+0qz167BmZ0SyWzs+jxe43O8nd?=
 =?us-ascii?Q?Wyr3iwVp6KZVXWzTQu/rxAA+WFu9rtVELPLbQqrYeFszd2YbHZBmAo0P3Zux?=
 =?us-ascii?Q?kHTBBy8EjfMkCW54qXcgl8GtRBN6JBNlafdV1Px8znR2cySDHh1xfQRIow9r?=
 =?us-ascii?Q?7ZPOC2No3kpDoqCfecOPQydlU/xFLN7yZTlE6UURvK8njKJx+Nj4zR6xnF6L?=
 =?us-ascii?Q?09Z2hM3S8D6iOwxXj8C5+MbT71i8a7sdNSEerk7mdgo/+dzp59NBYuhlSJuD?=
 =?us-ascii?Q?0Az+kru7fsgACQfLm81XzgbLpOtfUrCUEoGioHR2nICPNJCQJ4i/IWNBk8WD?=
 =?us-ascii?Q?9Mt6dwrjJ/r31hhRNVjR2OedjsD1sBqLgb7f39kbfCUIbEQNL0bQ8kRriLM6?=
 =?us-ascii?Q?PRwsn3crlVutB3McFZstJQ5ne+T0oli2Bo8ujxJHU+v3kA3vC6CQ0+xP5QsH?=
 =?us-ascii?Q?nuOOwwMW54b3T5ROnfW1xhZKo6VRkcBvq23elDrL3v9dcNQvffOEFG/drqSb?=
 =?us-ascii?Q?zhvowPpjMYMjQRRWocxzEIXPfFpsfPy0KUREinoIprqyrzGZA0b59d2AVisV?=
 =?us-ascii?Q?cd741U5tRBI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5vuq37yHIJE1GLtxex1qHokQ34jzZCFJZ4qPRwdMiz+oeCYIVbdQYaZZRnND?=
 =?us-ascii?Q?pULXTsWtQcVGczSmwOlV5ZoE3ugCIrtuhldVBRPnMLysqhkqPHB9Ej2pqntv?=
 =?us-ascii?Q?idPpasjAgvn5kjWFz4WzFqMFabcQhgakPXO165nMxos9NsIb24b6vN91jPUq?=
 =?us-ascii?Q?ZJozoXs+REzJOIdk+Epf37FmBISsBB8qDPvmK1UlkkHZYwkHmh+xVLgrUZJQ?=
 =?us-ascii?Q?ovvXrAlHSDU0GJivYIktquRz9dxLmNkR85vWNicU54wczVPKlF+nXBZ7hvLc?=
 =?us-ascii?Q?sbILU8zwG0uJYjXraLbQIJUSg4O5q4Fe6mqxjYwqWeJlWgToguRoMvrd0cVf?=
 =?us-ascii?Q?+T3SPePRir2HxdrHKVcRUhWaomZrRTS0vvgDuGRc3MT36A6B/9VO6nQTeNH+?=
 =?us-ascii?Q?URhlR4w761oX2NeEHTJSVhYNKs21v7f3cw0ld4vIihH9t68C6s7oSHiAyqRH?=
 =?us-ascii?Q?M5Cag5fmjEAtf22g8Gny6SBQvjD0iV0gKwNGRrNLUHxuSpDFSh7wxijsbEZv?=
 =?us-ascii?Q?PWlnKyBLXspOY7rJcIXF7UO2Pthyu/Cm1XBMkQ2yAYZVR2V/WNRXsa8JPa7A?=
 =?us-ascii?Q?K+5OBpayfcNKGeQV61kfO4fxiLPo3Y3/rdtN0kBmOs+nvoyFao+O1jRHSaCh?=
 =?us-ascii?Q?Yw1mIJsPOZshPuDxqZ1x786E4SF9HjClS5a2SvMNb60yK/7kNrxBq9qWg+cO?=
 =?us-ascii?Q?sWc2SN86tzIFIPpQL2b7D60glKvHMvxKI0YhHqnhs9txkVWIj0j2TqsN7jJn?=
 =?us-ascii?Q?wSscLE8Y13CeNnB7dI3eYYUM55bS1YHJh59p3bc+o9651O1T0W9DBTZ8MEi1?=
 =?us-ascii?Q?Hsws7p23AFy1yScYA+hkPHk9kRmonYMOaRDyVGYPI8FlhWgfKlVeB5H16V5S?=
 =?us-ascii?Q?w3+Jivq1gGJtDaYLkyIgtl3kxvX8wdIBfdUE8CgymFl6iFdQaVmY3CdazrSO?=
 =?us-ascii?Q?e5dK8tfp4c6V3fQEhMPht6J6LKMB3qJJ+6h1+vXZ+L3+zQsgzVrqHGguFRW+?=
 =?us-ascii?Q?soFADv1iDQVhQmNtfAPWo7K7OL5RPI8QNe2US1I82Hb/Cwokv/ojwjnrbJAL?=
 =?us-ascii?Q?3Ce65uANEwzr1X4IWDbUJ1z7Grxjh4i1fSxLqmF2TCGA6GgQ6y9s+Vf6u33j?=
 =?us-ascii?Q?RLHZCTQSN4OwW8I7U2d7MihhmH9FNWhvRafU9A9PP9vPpPeGEMhFvKcdhw8F?=
 =?us-ascii?Q?PPCPyf6pVDfiCUn8eiwMIcBWuL9ozkyJ+sWtkvvJcKsUhodTC0xDqrJUzryb?=
 =?us-ascii?Q?msy/ej7aINXsPjqcODjx0Yc7cLNzoLrNFWXH7IArdJpe0dTNTzvvK3cvkra6?=
 =?us-ascii?Q?HXCkVU/700XGNBlr3VsHaXsXWzK9/mZn6afctIJwSB4z8Mu0Y13EW286HRSD?=
 =?us-ascii?Q?z0uv9HVgaFveyGfdloyKc/3LelLCRs8HwFQfZq6VNhGEPR/y31wB1Ecb1pe/?=
 =?us-ascii?Q?4WzGkSPJZvD/ieliLCjVfr7f+fDHgLXp5DhhWcNYUKW11XJZPe3pnrYG1dTH?=
 =?us-ascii?Q?hzKiClkws3FK67bemqtE4kbKE03CLTgnSWN2GLfzRqpJ33dIzS8POYqBWR+f?=
 =?us-ascii?Q?PyMdLvzyoHsd+vleDsjgFZE0dcne5BM4FffuC9m8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88884014-1288-49bb-9b98-08dd8cc3df3f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 17:31:45.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yeXoeF0M64cZF6k6SeO1XuXBzXwmsbZgUi0/iUh2982wU/6yUpY0wElmIEyXrig
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321

On Mon, May 05, 2025 at 10:02:26PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> siw_mem_add() was added in 2019 by
> commit 2251334dcac9 ("rdma/siw: application buffer management")
> but has remained unused.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_mem.c | 24 ------------------------
>  drivers/infiniband/sw/siw/siw_mem.h |  1 -
>  2 files changed, 25 deletions(-)

Applied to for-next, thanks

Jason

