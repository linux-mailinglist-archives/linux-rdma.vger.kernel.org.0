Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F580490947
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jan 2022 14:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiAQNQ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 08:16:29 -0500
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:15798
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229591AbiAQNQ2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jan 2022 08:16:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je6LjdISwulOvGdSbZXcdgHepizxbmb9gcBE2oyHcsq3DqEteBGFbQw9IvC2r86R1uURaBzzPROiYLQWlVhnkjQoOQUwUU3tmKEq/v7PIEZWrJphQNom4MBEBsa9cBPYYeOx1eAGHLY0ZtJVFEVVRjB+rK9wPvuH3ZvMypFvve3YScZYh3LAaSlvSSLOwKnq4frVpbMParydcxJtd7tqZcJ4YwDDkN7B41PmMWPKqZsdsSPtjD4M6RS7KhMEp6PD4AbCdNZkxMrtBYksTJVbV4R4ePXDbh9KAxe+Y13oIsVy3YanZoYWFmD9kPOWBZIrupDTkfyyUGm7ivVAn4SIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghzZYCcrNWrkS711aSVpyCXvxj+uFN/SHpdA9Vld2C0=;
 b=khV+Msic90MxWAkCX5SV7JGk+G6sFBcqTY6qYuay8rMWPV1dZsEM25wqRrIMDQgGeTyt7jujRcZL0XMifZb8PyYFZDm6/g4kUeTO3lYvO+58NKzXCryD+s9cNw1Wcrum8pQcwk5pKO2KgEajJvjOAbo+ga8zQiO1+SsJGE8FbEzAvtNeBiaj30p0o8ZG471t2+u0Kqdcy/JnWoUrlhENuGpze+XKdUEpG7qGyc9P/6RCe3kYRTga/WgDl4NSLCgHr3FejxX9ajpPS2GHMjdbLIeIFUP3/LbvJ76jZ3OL1K402MRM+vBjdY8pGUKq0pZsd9wYsY4k/x7XvICgPJ3tGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghzZYCcrNWrkS711aSVpyCXvxj+uFN/SHpdA9Vld2C0=;
 b=j0nCUU7zGu3BK00ts7ibawQKJ7bA1jN2pq8esSJL1mpxvOxdQ4hbwRcABowzoEmJRXb/ls+rdPtr1lesdHlNocRykGuRly4YcUvBBP9Sy9cQq3e0U5MjOgX6LSeHzNbfyKGNCFrFgVBfDmq7eUC5A0fY3dqjtZyCewnKOCfqetrQG9eiBzyX2vgRJ4WcvF2BkTVK1e9WbVEthQZXX19GerMiq4lilMhfczR/fOywgCb23gnD+IvyHgpOMkFvNpbQYxym9H+SyCA90qaXi7aCKN2a/rn2hkryjIb4qmzBE9Yfo3Eo/zD7EA62ayoK1swl6UQoo6Aa7cTY5SgOg0+M+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 13:16:25 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 13:16:25 +0000
Date:   Mon, 17 Jan 2022 09:16:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, tom@talpey.com, yanjun.zhu@linux.dev,
        rpearsonhpe@gmail.com, y-goto@fujitsu.com, lizhijian@fujitsu.com,
        tomasz.gromadzki@intel.com
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Message-ID: <20220117131624.GB7906@nvidia.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
 <20220113030350.2492841-3-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113030350.2492841-3-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:208:239::13) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f23913e-17e9-4611-3560-08d9d9bb907e
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4571BC7E8340DD73BFCD25B3C2579@MW3PR12MB4571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KYJ9/OXLw96Za/C8RA72VNDeyt1f6O0cmKz9c2iYoC9hjhEGD2FlJfcpgjSC82awgaZwMlhoBRqhqElmsu7m6WaZtQhanSu09x6hEOLu8N1+3JefVArZ9U1mGhtOrz8nMM5q0mjalj9ILEzKhl1wbs8rfXHMVE5G0FYUH6VdVchH+CJvIuD6O02LLeY9GoNuKNtCcoEl8Mv6fkJ9woTJNI4PB+WkX49dVRWkz0FNVDiu7geTp5GqLbui4O4iuzYVPg56rzPgJkGTkrJCWr6YLM+RYbLoN/0H2dQ953K+g2gLGnCejLLZreNtebjA4v4+xyTDpQHbsLTJkpmZRbNWHNL3EovcZDjOsiXCPdUmsVB6Umoj8DSTF0WhCwVKjTJBN1L2ZZozqPH39wg61YWNA0TRTZi/YmX8uJlNRrIUej65hfMj8YWmvW89zNPliACPdcEmp/lQlM6KsPGk3qzHpncTmHxxzUer/LAcS8gwhz2pjGVEQJ6oUkWIozPNND7W6rbSNKor12gxvCwwIg8bO89yHFddsCOcnOW9IB/tLk8Q56QShMyjo/6CLkwovxDJNpNM2yKZCCyb+r2AW1FC5S2OT5eKk5UL3QBH3RHqTo1JPn/R0Y2DHhaiswykhqP/cIy+EIezMoMvBbhFmEziQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(2906002)(33656002)(6486002)(36756003)(186003)(6512007)(38100700002)(508600001)(8936002)(5660300002)(86362001)(8676002)(316002)(6506007)(4326008)(6916009)(1076003)(66556008)(66476007)(4744005)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G3B7/KYJAqmC+M4wONZwoKv1nAncZ85DEd4Z2lChbhS+KTubA/K2jX3Z6Uq/?=
 =?us-ascii?Q?FGNVBBt3GIlnEox8BhDia3+ys+2TepC0thno+vc+qrqh9hx6NE2SA/DSgwgs?=
 =?us-ascii?Q?vXRY6e+yBohV92vV/CWs4NHPbARckyNk5pZ7kVi8RvjP8SuoLtnIQGEvVD5j?=
 =?us-ascii?Q?cndoRQk2CituOvcXQ9+aFOd5kBs60M4x5HgivcsnOnCjWBfzJWqdm4j45LAp?=
 =?us-ascii?Q?Q1cSAsKu5pZ3gfbVBT09mv+/xHK3tBZuuyuYaT939eS9tnY4n1Uh7LlLQrqG?=
 =?us-ascii?Q?WcsUGCJMiOotVmujmdzrG9EaZKuIRVAf/yAo5XcQm0s22mjphSni1539xZrE?=
 =?us-ascii?Q?yLfqmhJVTWiWc9vYWqp8E76upgVHzIZKYe8hnXZUlO7JadBi72Mru+vMxS+u?=
 =?us-ascii?Q?Lj6dxTMf4tEwHyWHfiGP41qgADoBrm57vs6hh/nK5EvwlH+ocMkUYvMoUY2C?=
 =?us-ascii?Q?exWlUUezPLyaa7XjB3r1EMBY14sJ3pXnyFqNa7ESSjIYoi342D+L6Hr61sm9?=
 =?us-ascii?Q?uzHItgduNWy4RjW9U1G2gwpTrkPC53QzNJGqSI7jVn3bk1L99Rd53ypA3JCv?=
 =?us-ascii?Q?0bKE0m8g3eMgU9GFTcybBu4X+3/mLDmudzxDFYacrAP5yR8zSXbgM+ZSwq77?=
 =?us-ascii?Q?O5LIsKzsKTioUW95NiP3YpDjxuM3B6mrbgzozyMNPQ4UvK1up917EdoZjsn1?=
 =?us-ascii?Q?DWtfMeug2hgcfPRzKKbjtcilSzFxV3FW6dG3cSyfGDhUm2Cf3rOaC4KGyGnu?=
 =?us-ascii?Q?Geb5AzL/WzExBDCY1N/pLAN5H0BdFoizRmbrxSig9KMxVTKTqkWWTUJMGcuu?=
 =?us-ascii?Q?GrQ6SUmxVq1bfsbZrlxfW+21Rz0zkZnDLS4SFUdmD2qZN78TehNV4U5wI5QQ?=
 =?us-ascii?Q?AP8YGA0wTBZyNwo4yT02Uh3TQO0zGrxCONXjcKf2osAbiVerXitBf5QT8jF2?=
 =?us-ascii?Q?1PTno8NkfZkJpc5GK+DIwNTQbhz/lF99ohKqGoJCei6MYYqZ7zoFlSD9LbxU?=
 =?us-ascii?Q?Ftw3ga+e/6aH6fP6i6Pa4VUoZisTFY5/L9m2sgDjdoAk2U70CvyBH7+mDvOG?=
 =?us-ascii?Q?L1PMqqdnAevPby836Dun+2Is8wZ+NvBFPmJdkfLu9PMwZZTrIQ99/EbIzyvX?=
 =?us-ascii?Q?vwOdMP+92hBPK5Uh+18QFSg8TRZhb//SUI4i8GUYaQNcZ/3ds1GXdZ2aUH5s?=
 =?us-ascii?Q?ODreDAasHNOqATRngTbHxPsShH2VaJj3iLGYL50eZ+Hhzn+SZivMaH+PnQ/F?=
 =?us-ascii?Q?O6I4sfE8nMtLbbyiZmdxT13DcaqoRpnrNsKN3sVi4hx8KFSCW5FOIZSZxaSQ?=
 =?us-ascii?Q?C/ryTGoC8uTv74Nbz9t8UoLd3j30595zeIyd3NQnVlgWcCMJX+pIPHKwJoUk?=
 =?us-ascii?Q?f9gklJK6a2FIuSedn77mTWER+oOl1ZssA2w7fCphTYdV5hVTLqH0mYrZEXbm?=
 =?us-ascii?Q?yffCHbVyi+xKIRAmPt2osQpH49uWUkRoPmZ21CB0s76dJ8f2OdPFHmCUF3Q9?=
 =?us-ascii?Q?UctE4UeUkHNKrbYRBXTj3WIDqn6dlzAIjWw/vGNVfday1u2A+zZsixtrq7eJ?=
 =?us-ascii?Q?udVma2+a90+m8FTBRDw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f23913e-17e9-4611-3560-08d9d9bb907e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 13:16:25.7500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PABI6BrqrZZyAZ1BAt4/ulhWZD/P/zO129oDu7H/cOtgIh5Gpngj+SuEfpaPeZW0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 13, 2022 at 11:03:50AM +0800, Xiao Yang wrote:
> +static enum resp_states process_atomic_write(struct rxe_qp *qp,
> +					     struct rxe_pkt_info *pkt)
> +{
> +	struct rxe_mr *mr = qp->resp.mr;
> +
> +	u64 *src = payload_addr(pkt);
> +
> +	u64 *dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, sizeof(u64));
> +	if (!dst || (uintptr_t)dst & 7)
> +		return RESPST_ERR_MISALIGNED_ATOMIC;

It looks to me like iova_to_vaddr is completely broken, where is the
kmap on that flow?

Jason
