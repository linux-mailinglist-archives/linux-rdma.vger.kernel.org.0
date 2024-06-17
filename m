Return-Path: <linux-rdma+bounces-3209-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5341590B2F0
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 16:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60ED1F264BF
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96F316B38D;
	Mon, 17 Jun 2024 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YI4KX2Ka"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673F1684B6
	for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2024 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632754; cv=fail; b=U6BYhl31BFAbhO6H1qeIwbxqFzF6mm71miy1KGhlCUK8VoRuBOTOvmkZmxo9TpMFrZNAC/CDoaLQKXU+7WP7HlSv5Lj4WWawmb4MCKf/xlm3T54xsCVXSY7zf9rlsKymph29bDE2zpX1izpluCGBDKrp49E63cnPR2Yzu6UxF10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632754; c=relaxed/simple;
	bh=15hH64NUIfdpd40K348EAw4MYjucxzmJXUgtPKHLqkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r0BNgth4O7yw0zl0F0RdLPHLTtdv8rXCacNyOJEL/HSyuCTuqNzRBc+uanzkIxWou9Hz+hDojxZYP9bzgyPUmofFKeCeDAQRRMI1HmAD0i4IdWt4Rwifnw0Z4iRN+mfLTpNSlbt6RP0bmeRmwemwUu0bIMRxbdFIobnGRe8fYuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YI4KX2Ka; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz5xI5OStyyl+lyrLT1WU/kHMidnPZePd+kZObWO7r58VXQIEpoqIaXB5bKyW7I7xq0JVMs1u6tKfmCiY0dLuooyvbJbs0se8rpZTBtmCzL5anZJCFFdCq2ik3ysitYPyGReMagRAkb/W5r9awrDSKi8hcMAJvZDboUt78ryXNW5e13EvOuUWljCLgc0WcAqLZS9ojdSCxx9iTgwICwaZinH7JPV/jVDYe9ab8Xj7gQue5C3IVpaACydePNcow6dOVuDAtQsFr0hXixPvHpC2rZ+WMwS9bcxMnB6wjP+jua1LqsW1d+J6yei9oYxICg1mgz1LejB0DZIrWv5ysoesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EvuocME3DzI5wikwhLiTH8WyUX++7AWnWqJmWM/sp0=;
 b=g3AOq9rOLBqdjFeTEgm+mZH6C4Rh5YRgvzrr8ZQRDVIP5miz7Fo0nC+XgW3R3oIHeB9Uinsn+H4pMcsrTBf2eCq6/KEy/VE5h/l/kNYpQynZUkUIoswkbLJ5Lkf18tOU727TI+xZrpDf+4JXGH8pWc42imICDKaN/bOVIbdIER8wyCaDn3Xu+zIPREiaPPqOSu9jz37J2dM2fVG+uUhCo1xPMrzt+ifv6YgOaR21w4p5kyKY/ltBwSqHBsXzgXmNbGLEHLRxz1bjWB9bLgvtcD5bD/lbU1O5e5xmDwD+bXOw2VVq51fEeuA+A5EsrSAFPW4raKiGuc4KB52LtWaUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EvuocME3DzI5wikwhLiTH8WyUX++7AWnWqJmWM/sp0=;
 b=YI4KX2KaKZxrYGmyFkNCkt8X+cH9/XbREKPJsp3g+rEPQZTTrh51J1vforpmimmWx882JR2i6MwXwc69pl7WyTQUTtoASqpHcb7+Ng+ddQfTHujm7wbfgkMcd/LzRJcS8vmTuyg+DUpCALE0PUb9BGjJsIm3bL4zG/sKgupUfdVDyDjxxhy24CiGCc/+uT0IvFEIpZGH/ecGEuG9vElqp4zASO9ThzXoCMe0hTbc2vcaacusUQrmPqi5A0a9NWAH+dGrTEGYrqHAeCR33lCjXDrCA4o1Mjw/eNfE7GP9M4U1EhVvGZVHmkWsb347Rf70JLJ8xReMy/pv0pVWwP3VmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 13:59:07 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 13:59:06 +0000
Date: Mon, 17 Jun 2024 10:59:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Jianxin Xiong <jianxin.xiong@intel.com>, linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Set mkeys for dmabuf at PAGE_SIZE
Message-ID: <20240617135905.GL19897@nvidia.com>
References: <1e2289b9133e89f273a4e68d459057d032cbc2ce.1718301631.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e2289b9133e89f273a4e68d459057d032cbc2ce.1718301631.git.leon@kernel.org>
X-ClientProxiedBy: MN2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:208:236::30) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f087d6b-8817-4ff3-4c2a-08dc8ed5a764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ufSK85zcxfuKndYS6wgVS9SWSvLvUrvJpFxgYj4BHWSBLvk0ZxSDV1U0n04?=
 =?us-ascii?Q?4/xgcOuEW314xz5v9t1SrxdnXavIE7maAwdLeij8yS9HdxeToU4+R/0UdLb8?=
 =?us-ascii?Q?2Vo5N536Gd1CS7mCKsrlwR4mUfDbse2HjqTkQ7+j0Ojy8+hbqehaq1h1I7NL?=
 =?us-ascii?Q?k9OeYCGkUgfhMvF8WR8Ft9uQ5gZ0t/qTyv1KtejObLRVH2hY2agCGBOew1A/?=
 =?us-ascii?Q?rTxsi0u4lGYF/6QP+dWsPNXNOYm+k4/9T52M19pbXlkcrHa6fpWoh0Ts8vi+?=
 =?us-ascii?Q?EyXdoz24Bj/dSCivZ9AgRqomhzwts68Uwoc1hUMt7jr3nxmssQBtRqaXB+9y?=
 =?us-ascii?Q?a4cKyESf3XqNUujQLEAGfdCy9o2Y3HLhMSPnKThYQolMJai6glckiUr4HvRk?=
 =?us-ascii?Q?4vzOU6xrMlnrnaAPRjwPOYQMwUGbI4ktxcBH/eut2mHaCw91NBLHJdnUUYWV?=
 =?us-ascii?Q?t8B4+h2zAn3+Kvag88OdjXfxHCZmeMqy4wpIGKYZb7R/76AvDsKshyxiSCJj?=
 =?us-ascii?Q?YJrxloq39HkJvedTjSEla1LC1goPH/UbYm95ezHe1bueUrqBmwE/eanY+j0g?=
 =?us-ascii?Q?wPETwyb2wl7U6tTGgXswhYpcHQ33p1AGsTEv295JqpyU0tLZp3f7f42jlDMm?=
 =?us-ascii?Q?2EABMdf4W9VtSgYH3wIM3DSg5AalilOImkcj6C6viPldjnEMjAMt5yZcLibk?=
 =?us-ascii?Q?DXN2CV6l1i3EHNUIYsMRVd37t1XMegMYnIBvjVDk58vvkiajdippqEQZz2xU?=
 =?us-ascii?Q?5ug+SU4pUOJU/JD9v83Ee8K8/4uzQA+L3ipFmdB7PMYsPZvPJmpFolOiaiUQ?=
 =?us-ascii?Q?UkRQqKiZxzTR2A3DI8n+5WUWu51xGezDksImJnYPpFP8U0jCJKX9o1V/M4FP?=
 =?us-ascii?Q?FnwFOzBt+nkeiFbjL8CYBcpwrcOQuQUBX4Cq10DjsuX9jTMCSmXZKPqYkOae?=
 =?us-ascii?Q?3sH9md648VvcLuffPub3qLhYk6Z1uXk11J6OJVHXw0RDP+dEZTTQUAQBiI3n?=
 =?us-ascii?Q?nUfox1GSKHp9jKQAbDPckrRRBZx6apDPgQ+CwXlFxy3ug3I0hqNuGcHMAHGa?=
 =?us-ascii?Q?Ce8IzeRVdd8KbonLmsc7UfbcqP6OhcF8qP68xdVrVYwoc9UYppmNm6Q5DwxY?=
 =?us-ascii?Q?/KHknWrFIuRBBocKYwFBlrI+wDTMUHx62SmOWpi8LbwCJXX80Lyn+4O8v2nm?=
 =?us-ascii?Q?uQvIUUN4IA8+W7liSX6HEYxmIXIb9Ueollq/5QDEicaGsi/gCDv3qcjCXCWR?=
 =?us-ascii?Q?WirEzE8LaTp9Yr+suiGUoR/sC/2nEiyinvVTBZnhjYwtsKbmQrCuoiHIeB0F?=
 =?us-ascii?Q?7P1pSYhVrDRbU/8Q/0gYMxss?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cMbxON9iph95CuoxltXGfCfyGsyjXMzPDuuYS/abG1+5m1oQqlCVkNPoggd+?=
 =?us-ascii?Q?jLo+dqo9GpJqC2t1i3JZi1/StBmbHrYZuklohzwKrw3T8Jn6vYqff3oYDNoV?=
 =?us-ascii?Q?CChLyjwP4av5y0k0nwgYYAFcaOA3uHThaUfldzsBcHhRf6zg3TxeNtj4CaWx?=
 =?us-ascii?Q?UN17PbdM3D7SA+t5lHmH8Skh5zVE8br/OGaGDrgr7Lh4LvHNkZYvp0QijmZF?=
 =?us-ascii?Q?Lo2WxWs7pD7UhX+i1iUECaBOWPyRCRgB61C7g7/8I/ysx3U4fw3+JzXlm8w8?=
 =?us-ascii?Q?B9SoSE9/y0obWbO2UQYz7DYh//LmG4ExXSHQAndwv90gL2IjfsjPDen509he?=
 =?us-ascii?Q?CHjMgoLl1C2WiGZsDWRfe/cFmV/5B/RBE5CtU9EUrgl/pSJx9We7ipPIZVLb?=
 =?us-ascii?Q?WhEWTGN2E9zIXBuOFugHF6k2QqDEJO4+6++RlBOw52AsC1XrpTb/yY4rg6qy?=
 =?us-ascii?Q?cURAW3AtYeDjSemiqI/tgIo8YfPACtu2YeYwBloefNrUZ9Yw47zxViXbeC3w?=
 =?us-ascii?Q?5ehghZg34CdKLSVezPrhzfdatN+tYvnKSyg5//7mnz6F1L3mX1+JV8qhlDu4?=
 =?us-ascii?Q?Oo2ChZdgRqj0wVIZ81kLvNaAcYpYwAl4idFsdlXiUSKZpx1FUO7lyFviQByk?=
 =?us-ascii?Q?wdTBQWb73t5yO+B++dOEERu/qKVJcuIqXpNUPYKLpbrWwrjff3C5s5eGBh1N?=
 =?us-ascii?Q?8v++RO+lMTzK3V5CTxzTh0JR+rmlQ3EALPEZtpPYle8mWit84NOp3b9cAQfh?=
 =?us-ascii?Q?FIiypRcq9rQAFOvRiYcgJke9IdbCZT94whucKa6/5O1u/YdcA9S9ZhxJNISR?=
 =?us-ascii?Q?zeQV8QRxBS0B7EBlegUJ4J7QP32oUqR70MovEYX6sWRzOiaye64ii5PH41OS?=
 =?us-ascii?Q?mAQDnxgK7p2D3a9hRGUhyeG4trEfvONRcyJvp46SSM8LYNFp0W4t6cP256oH?=
 =?us-ascii?Q?t1HPRsn1O4whQJxp7LThpUvYpe1i+DMmMfkEn7rTCx5QPF6K5LZc55Tl2I/c?=
 =?us-ascii?Q?G62yF776B/VMGgaEK7Nf8FW1YdolVGv9iGgjMV6zQtLHdfdX6kckgf+SpheO?=
 =?us-ascii?Q?/rctxdh2MvDodO8HalaJujGttRR7nHjNWL9XVqvn7052bLToKRqBQVoJzBL7?=
 =?us-ascii?Q?aa/AoYz0IWHsbTK7RYS/32s+hc/uS+fzZ2GPhZeby2KFNy4dgtpF3HWTPdlz?=
 =?us-ascii?Q?KwHwFj9QxyFY7+YqUiXClgVt8DX2hwsNeAHYZLOb6RCFoFbS1g8V+YuWdmqa?=
 =?us-ascii?Q?8oAWDO1Yy0LKNd+vO50O/4YPLbNhKJaSC4Lnr4sKEtkY+umG3i+NKBWxk5He?=
 =?us-ascii?Q?voCPN9bgcLY3Vow0m5vXUUH/1gX9cZJ9PhlI1Scz7dL/bEivVtbCeAFq1Wul?=
 =?us-ascii?Q?kJB931ZfpPJ3JpmcxZMwASHhCFU0dyAsbZ6Hfiu/G/t8s0YLyIdTcj/KBEl3?=
 =?us-ascii?Q?yLAxK5GNt5cti8L6Y+mKLyPCLuoWXUQgMzfbpo9m6X9t1gk+YLBqXD0ZQPTO?=
 =?us-ascii?Q?7iFhW0orvHbKwc4VZhDFP3FZMzsVG60iqPYLDYCouyiFf2CkwgoCBTR2tbvE?=
 =?us-ascii?Q?NQyZOCFsepl0I2ce1TYDLbCVI45r68erJOYVF/kr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f087d6b-8817-4ff3-4c2a-08dc8ed5a764
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 13:59:06.8617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/xndAv2A3fV2O+c9EVsU4v/+66Nclir+WEoJlaJNmoTB+7V2eWhKOZO2tPx/PUD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864

On Thu, Jun 13, 2024 at 09:01:42PM +0300, Leon Romanovsky wrote:
> From: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> Set the mkey for dmabuf at PAGE_SIZE to support any SGL
> after a move operation.
> 
> ib_umem_find_best_pgsz returns 0 on error, so it is
> incorrect to check the returned page_size against PAGE_SIZE

This commit message is not clear enough for something that need to be
backported:

RDMA/mlx5: Support non-page size aligned DMABUF mkeys

The mkey page size for DMABUF is fixed at PAGE_SIZE because we have to
support a move operation that could change a large-sized page list
into a small page-list and the mkey must be able to represent it.

The test for this is not quite correct, instead of checking the output
of mlx5_umem_find_best_pgsz() the call to ib_umem_find_best_pgsz
should specify the exact HW/SW restriction - only PAGE_SIZE is
accepted.

Then the normal logic for dealing with leading/trailing sub page
alignment works correctly and sub page size DMBUF mappings can be
supported.

This is particularly painful on 64K kernels.

Jason

