Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CCA366083
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 21:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhDTT75 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 15:59:57 -0400
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:28448
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233541AbhDTT7u (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Apr 2021 15:59:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdL1ja8l86QjuDRxEQsN8Wra0tXpwOTdyCogCxk1WLie47xiioAOORCmxMGumvLq2i4TXIvQdeDwIjD8dj/SRKZfHBSeBBkOJlu7ZiPkRthwOux7BpfLhGFsJLzOHJ8igIPl1VmM0Vkx5QnXWyZg3Py3d5qCLbIEWa15TsrXn+65WsLYpR1t1igFG+RgVBtIMQGOag3vfjnJcRjNPwp72ul96OR01lDb0RWEvRYivyr3SN0jCeMDeiph9G0Kevv/ThqmvEpBXMk750ZMHTR0pb+pLutQihkOqk5hTUf7IkaApQ2ErAbsDCM3PWJ5j5IERHVJGrocsFmJdK79WRXX6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mCFnvihvy4PqCslWTicUqgoNbYWEWlzQaDuLvx0tPQ=;
 b=Y9hKhYlHCPdAlFQBbekzitY4cpWMzKYo+dKMEBmvB8d9s443j1vz2QwWyLyGn3noNOrOdyafHc7T7jcwCASi43NtWblKIQImlFuLYVUU2ylQ7VsZPBpCcuSKMTS+qjtHCbgmxhmnHyGXRkG0l8yzRODwGSElvwtVIL3JT/Klwqcap6ABFosH4k8hv8q6os/6WJoh2GfKaJU7hi8De/n4NOnwLXztiiq8pprb+pid0aiqu+fxLKc2Obt/GmnAB8o8tjFfp88Y2y+0IZfeyMP2R4AAz3+MzSo/AcoVC9ngECgOUhyIgR7nKYTHYwluAS3ZyaFA0OCbD7fkDWoJXnKLcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mCFnvihvy4PqCslWTicUqgoNbYWEWlzQaDuLvx0tPQ=;
 b=gbeVLVjMyhhmxTs4+AWBwsfM7irqsxk7vAFn5rDI2I3AIN25/KnYfeuKvVz0qwTGk9RYTClid+gVTDXKYl474WJhOTkPs36Fgbnz2moieZdMUSrcMbgb0nBJ2Dnhpf0lh5BtJNAqPxbA7VAqwypGcIOn6O8sWY5mbs77fjgXaPsswtNZ/wO1yxCJc5zOq4Gc9Y5QFwLtghwIddv3lS7wvJ3ujs/nHVtMsPKRmfggAaaME6+XCT8X7or1p5RB+ayWi6sYoq2ShkJDeZUcVgOheGhrGLJg/fbMSHLhauxER7xgjriHPrToEvWvmxf9OWZ7px3BmSQLbDjS1T7mfdSmkw==
Authentication-Results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Tue, 20 Apr
 2021 19:59:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 19:59:16 +0000
Date:   Tue, 20 Apr 2021 16:59:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     yishaih@nvidia.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx4: remove an unused variable
Message-ID: <20210420195914.GA2193837@nvidia.com>
References: <413dc6e2ea9d85bda1131bbd6a730b7620839eab.1618932283.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413dc6e2ea9d85bda1131bbd6a730b7620839eab.1618932283.git.christophe.jaillet@wanadoo.fr>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR0102CA0061.prod.exchangelabs.com
 (2603:10b6:208:25::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR0102CA0061.prod.exchangelabs.com (2603:10b6:208:25::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 19:59:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lYwWh-009Cjh-0B; Tue, 20 Apr 2021 16:59:15 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b931d4c0-7fab-42b4-fc29-08d90436c71f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212E3A6CD92F1741573E83EC2489@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFAwhXEZZDUiQevdV0+VEnm9gYOv8CZoPugvPuBL07AdTs0OPkZzKDGMtpx+0GzjilGRw2Z/qV/QA4+YqADakhpaLu7Te2kpUZsAlECe68Ld/tfPY+reaDEhd8ZXc1ADwq4/y88ZNvMw842r78bvrbDdG02l4j4XqdvRLvEba+NopHWWey+RWlNRGShedbE1gZTQ/nujsqgG2A3Otpa/vxXW1LEsF6Nf8CIfzksZ67GVndM5JaX/zAkLleNzA45lKP+IffqBINq34q+qKyxILqSWei8+Umbg4rFT4Wb4P2H3fgPVMkIwVL0fOs0xgtazVJZbokEB0gMkv0aOBNEviY7OzKkwJ+V9+zmY4s2BgvSaHGjclrxi78UHv1v9iKvVXXMOgiKgeBCm7zMbVIs9Lh2CSVuv6muugs0+5zvQV+tRuulwjZo3eWPEEhZ9C2Y7G9YsRSdXHPchsEkaJM3WSVxL3jF97zJbn3aIYh6XZrd09Wv1lyGnKl6MXgTMHzKcN9nbEzez/KMP5ATJthny9UDlnN5Rlo3mqvxzuTUMUMtfwOlv2iQawrWucHIBxDhHau7namzFgRpLXe3ZckPswcOtLLIjHyl77bnQ/op4Oik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(83380400001)(26005)(426003)(38100700002)(8676002)(5660300002)(66556008)(9786002)(9746002)(36756003)(8936002)(2906002)(2616005)(86362001)(4744005)(66946007)(1076003)(66476007)(316002)(33656002)(6916009)(4326008)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nn1hv2rKqQ6LZchWrQl63+hefyZYKuJE4A5Qi3rWx8tMU2tH1g29ZaZaUlS4?=
 =?us-ascii?Q?d0JiBRUMQfx/rq4s+oqz7awjq1Jxzyg/5Mt4UQxFERQQ4r7NXVLhK9rTwe8c?=
 =?us-ascii?Q?D94PBA8gZe8DTx0GkGOv7vH9C/95BQ12EpFQoA8IiDjuUt8bqHPjBBR7Mg9T?=
 =?us-ascii?Q?lhs/RZpNgGXGABossUr/e1xfdTzFf3A2J4T7RMNxPAdHmqFYdohCoxlugFeE?=
 =?us-ascii?Q?ffp5fMsRy4p0jGz09jfYxuQpOgqWsdfiwb9rUDE9VYGkk8OiVhvBcWrNonRt?=
 =?us-ascii?Q?XAbS0Vsw3269qtolkJf/RwXVuPe/tVJkDSuvlKcr4+298W6GvDFtLVEaynaS?=
 =?us-ascii?Q?xR4u3fXH1xpmo6nkQdDEfs8s3cJmV9YhUEBto1ttFK1yMVEziAvhe7gV2rSv?=
 =?us-ascii?Q?EJLB2IYp50vnsExoMtk7axdjbFWF9VgmJV7X4zxDjJLLIPjaSLa97cEazRPg?=
 =?us-ascii?Q?L1u3KtwSKrXvKssdz/c3yYNPntJNc3hrL0XTl0zoMY3D13C2bjhoXrAq+0Mx?=
 =?us-ascii?Q?JUpx4rHP3YwEGOvddX2zpOvgNkPf8yirrKOIalWuR4bsiOq0+cHaDqn5QCHu?=
 =?us-ascii?Q?NwFaKwh498/1pcGWWqXMQWSaeTzFJzCSNB5qwWpMLszfs/waZFf9KCL+P5wG?=
 =?us-ascii?Q?l5YQoyjA920ZoN5WkRcWwf84kvHEWnm7pyWwTU6CagI9gi/kRAJH+ZXuhnvJ?=
 =?us-ascii?Q?i859RBzZawTh0pGqpmNeGA+JDDowb0GmqbcPLkc9j6Qu/7yZbxS7hi2hjWRr?=
 =?us-ascii?Q?+k1s0JKX0lEX3FVAohcK9IztXq0n1ERE7deAlJ1/4y1xd72q4+LUbEU1xx4x?=
 =?us-ascii?Q?rTpWpYtugf5xnPsOKlrI5wuVneyeIkA7d4S4YrnFuLM4WctDFyUVKt6MmQcl?=
 =?us-ascii?Q?yb1fazGvBLJhnURqX8GgWNm1b08ynLvVcZR8o41CVjZMPmwu76a4wlFNOGBH?=
 =?us-ascii?Q?zTpqZN3Cr3SqK44EGrnILzZMiQDOZTkwh7pp9ra1a2RXIoU7KInixlmBwUjN?=
 =?us-ascii?Q?Q4cvRsoWuSPI3zoP28aWsvrJfK61lfVkstQMyILmYJXuwKw+TIsKsQpAxJfM?=
 =?us-ascii?Q?x/Ww9RYAIzH/yruqV3HgahDshcuvCgcppyzF57Gq7t7BNN0i992mlKHquQAJ?=
 =?us-ascii?Q?ke8TkGjdkHlNA521aW1nxH6XCxv6DOwuAMzfyCSAcPNvnlEen8xH/zK0Nos9?=
 =?us-ascii?Q?WtVOaStUopx3h2/UGkxgAsb2VuPFADdXyt2OK42K4bSXiAY+3kT2RjDXyqPm?=
 =?us-ascii?Q?q9YCd1YnzxWod4TyMvnUR/ZJELOAowPb3vaiH+hS62PPj0uKnrjZjYVh+V25?=
 =?us-ascii?Q?vnkkj3rfODaVsDsufkUG88iAXyY+nZecQ9mTbhuDcZ6CcA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b931d4c0-7fab-42b4-fc29-08d90436c71f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 19:59:16.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSbbT1HsfJ/8lHPDY51DuNEUUp3VZIDuBz0ph7qkcXNge5RfbGxXPVj1jS40U/DW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 20, 2021 at 05:28:33PM +0200, Christophe JAILLET wrote:
> 'in6' is unused. It is just declared and filled-in.
> It can be removed.
> 
> This is a left over from commit 5ea8bbfc4929
> ("mlx4: Implement IP based gids support for RoCE/SRIOV")
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/mlx4/qp.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied to for-next, thanks

Jason
