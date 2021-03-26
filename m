Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D64234ACF9
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Mar 2021 17:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhCZQ6m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 12:58:42 -0400
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:20705
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230323AbhCZQ61 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Mar 2021 12:58:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZbbWOz2ipgr0z1t31HjvH3VpjUlmhBo8aFC+YZbJ31I5AO5ujDdKPA8Fe7oiLyGpzumW8ovFOVRR5A9oqL0YKY6Xc6tX5ZhRqA4MqP6RuCNnWqNFFvV415QGmFSDKVTMRqIwGjPMHBJS4KuHGfcJ232Y/MhooiHzfRfbb4SdQTL2VzBI0I5pq2QJ3ShZWt6Kj4l2qXxWsAQ7VaJDHDAMN3uqX4n4ajA1jOTAhR/Arg0LpledNF6bGiPAwhetkDiaAjsbm3vFRmtYcdl/82y0mgdcK6sM9Vst5tIM52Zxg8Gn27HDVqa1HeSGsPWh/CV6Z9muXlsuv1ckSNOAJad/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rl5WK9cFUlXwUgH2AMeEVOMjJ0rcxYNfIZxjQ22Ph64=;
 b=U61ZE/NDjvAUMDZJPyJ5cq35X7k4H6PpoB5/kC3Rzj6sjVliWgxfzXCy2niVRgCYexM+UEWkgZxTdYjkYPIwomkl0qnZhe2Q/AndpfySgeV9ERlAofbI9Zrus5daTFr94D8IR2h6VfgTRbugeQaA0/4nIo1SlKPWh5VtIioLHaM7W3kxOwIumqP5In+olUsDcMyWKs7NM9MC4vHDWnwcHfMB9Mkwcc5dmLZ1eB3QqOQbfimZhxBDQRJdnKNDsQZfSJiW7eGQs9Z4ump9mMtO7m4o2QHt1o4TS/obEMhA7+MqfcQ6ig+cnFpDOU9Uv3bmIckvzhbe8YT2iM2a75DTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rl5WK9cFUlXwUgH2AMeEVOMjJ0rcxYNfIZxjQ22Ph64=;
 b=fmDn3wnAbUWpACGy/uyQ/MY9c2PZFpmiL1Wi3wBIQXngbrv6jl5TSt0i/sIVlXwXdo3vHJmSuEK3ztOnRd5YmYdCDBL+xnf2aZH8YSZIsRYZnDuc2xgCxlCiYlKm+1sYvKsrfy3Y7RrTwLGu5iP0ClWUBuUBIvgS2Bsr7txI+SrnbwrUUdBit/OeZjDZZvb9GGrRSdXj1PuUTvVUb0h+GS8Us6GLJbVXBTMtZuaDyIRDfzXTt0lxqF3pTxTksbjjI78WMRkHMk7Qtg4b/tVzbQOczPVfNAZvKjIKRgwHTZQmGvtF1ICr38ZAZyOiFzziEcHghJRHn/7Q70Ymp6Gs8g==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 26 Mar
 2021 16:58:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 16:58:26 +0000
Date:   Fri, 26 Mar 2021 13:58:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Daria Velikovsky <daria@mellanox.com>,
        linux-rdma@vger.kernel.org, Mark Bloch <markb@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix drop packet rule in egress table
Message-ID: <20210326165824.GB863945@nvidia.com>
References: <20210318135123.680759-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318135123.680759-1-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0349.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0349.namprd13.prod.outlook.com (2603:10b6:208:2c6::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.14 via Frontend Transport; Fri, 26 Mar 2021 16:58:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPpmy-003clh-RJ; Fri, 26 Mar 2021 13:58:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72175b4f-7394-4c8e-e19e-08d8f0785f6e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2811:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB281149014B8B9ECC2643FDD6C2619@DM6PR12MB2811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/qB/QDqLB3XtjYMJ8qkVbTcbUQVSk+8Gn7JG/crviVeNQs3tDXTDDP0Abp07M/Dmnj3GEY7mDqSfsXm0HrsuxK58//iSdlS2WIaQghA1UQpBOhkw1tE2+z9lmGDPPv1AGQ3k8YjjKcGMu/Rlc4FEjssDr3ewu6JEH9AxkhkY60XEEjpg+nWEocKKOQHKfuoRJ/UMKEME9HzLpf1LAsEEGn8Ni/0tyyLZ3FvzW7w4qJzl4T+1WdLkxdawcp6rDBR5va8oVgfgK2PSeuIEBUDX8trKVVPYSAgr9W4DM2TLPBPLWtEErEfZLeLmv1b7ZubziB5tf68mfYPu0GWPVrFFyromWR/ZQH66X25inol5/yktw8h0WwknHOJUgyUKn5culKVdWAtutDLWph8U/Z4FDsDkF/IpXIjbEoNIjKzptCs23myHDcQaDUTcCMrDz+W0aJ3zearViok2u+SoApkJywqMja83AI06qx9Y5dF66MPLXxk+7Hz5FC6FrBiixiuMOSmGY30OXeXfWz+y4OuNIFHwVUMfJ7hpeRtsq7Oj85qcl47vIa46B2Qq8xIZdYOKYf0UixPgkZfxcYypmr+ydDw5A9PIQVLxgWvdRbjwRRgT3pZMenVMwGDos2PosFMug/pWjW2UJgeDadEOE1aqn8bWv6OmMj6W6Erw1JDRx0rtWjYjaUlN4JPe5sWmMJz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(426003)(316002)(107886003)(38100700001)(6916009)(36756003)(2906002)(2616005)(8676002)(66946007)(9786002)(5660300002)(66476007)(66556008)(4326008)(33656002)(86362001)(8936002)(1076003)(26005)(186003)(54906003)(4744005)(83380400001)(9746002)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hu3vQCIMxh1afdoGBSju5om6ikAC422CcvBa+IdiFXRseBgGcPoO/i0HBGaB?=
 =?us-ascii?Q?LH/Soov3pEJdPXcDkCk6QLtcRyI4jmoO+En6OtijXcb6YPhaDQb0t+eQKHIr?=
 =?us-ascii?Q?Oa6NW7Rm8EW34ZzLMTy7/reGIyOiBeRmcA7CzBdepuADf4cWQhgXZ0syIoX+?=
 =?us-ascii?Q?wnmrtpCND7a4JOJvcaRidS8TzyQQyKRnNRtyr8qOZDjogNPl+yCmaQjK1XJe?=
 =?us-ascii?Q?WqWEP3Gxi3h/oc1gn60sgNdb2pVKOHnHKXhk0EYUBJcIbbZF2DIU6UzDk7Yk?=
 =?us-ascii?Q?DtLiNd+l5CJeXADkwmwy6gYbsxLG/lHWzMGveRA1MuAcBOhj1MInxS7/E06+?=
 =?us-ascii?Q?N4K8HhNPN+TOEPXRb/fg2AbiVuQqcCS3lfvfPxCuA4HzG96QPrf9W1Umjf9T?=
 =?us-ascii?Q?bax+t1d3SlKOpKhSgssi4MQrk7givOrgU1rCAMDeLjrkK+2IabNPiItP8G4n?=
 =?us-ascii?Q?UADhc1sd6Eg/8099HvsAEqikWdSgsdxRhJGpRxvY9U0+vxt0lFw6rEvhGZU7?=
 =?us-ascii?Q?mK379V9AFa9SbrTU5/u1xV1fHUqQC7+Yw7fHABME1HbpKME4dpRQnOEMGE85?=
 =?us-ascii?Q?Iio0Kykva7lI6S74JA2rqoj+ApxIRqEmmfqAEIO9Ihi4VUJmt1TqghLqPEyP?=
 =?us-ascii?Q?LAicIRA/+hzpQqI2isDJ+7GhyyEm+rxqJfBB4ZfiiI8xkPHEQ+OfEWzUdaEZ?=
 =?us-ascii?Q?UFFfro/JXiUl0x7NT8AUhvWWr3U8cVygg0dPvbm4tVvTzSpJVlEonclZBWr/?=
 =?us-ascii?Q?O+Zo4xeIzWWG78Fs1yD+2YJ0XODSq7Q7VGbP4OV/HNImuJ/hGiOmVnoF4ckD?=
 =?us-ascii?Q?WozHltCFVXGErO8NUkurxIPN4WdrSJL4Qpqqy/HmSmEh6eSD35l+E/YvHo1j?=
 =?us-ascii?Q?cqWOfp9Crh8/wusn2XJqmbMGqzqXL6SFOw8hYYGeQog345IqsgsD5czG5UTr?=
 =?us-ascii?Q?no+04TpuWXB457LPw0SoyMqtO2LjXGozld/R2w/vEV+uPHwlCRmml+Nidbpv?=
 =?us-ascii?Q?FUDd3Po4kupl9t7imx/Bs2D+w1QLJQmZIgYVX9Hc9h6xAc5yBa4YsS8oP1Iu?=
 =?us-ascii?Q?+JkLS6Jo+mzZxyDBt/ocGo9Ie4Yfi2iOUyBEXIJEHI5gy7tGsWJfs/H5x8lK?=
 =?us-ascii?Q?JZl8Nnv+1q+Vqk5Mxmuhub0sRvpLEMZK1+rsDe82vnaMze4b5GZHGDs/QbIY?=
 =?us-ascii?Q?EWZe5g94T9GUkKnXoT3b1bWxQuGtHnTLMWuODYN6Lkjvq+pkZINcoczNAjeO?=
 =?us-ascii?Q?JIjyNkqEibF0GPahxnhjdCUQnW36JRoC0wWLL0fdpXBBsEdUewOkwIwLgtKx?=
 =?us-ascii?Q?GwxDmlqC74bldbta4/ccoxeBnPtPyyFytz9frQzIgnwpGQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72175b4f-7394-4c8e-e19e-08d8f0785f6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 16:58:26.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fg191GPCUZkaClTj7Yx2bbKTOz4z9cIPOlSVn4mL4yCNa7pTvI9+hV2fJpe62Lor
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 18, 2021 at 03:51:23PM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> Initial drop action support missed that drop action can be added to
> egress flow tables as well. Add the missing support.
> 
> This requires making sure that dest_type isn't set to PORT which in
> turn exposes a possibility of passing dst while indicating number of
> dsts as zero. Explicitly check for number of dsts and pass the appropriate
> pointer.
> 
> Fixes: f29de9eee782 ("RDMA/mlx5: Add support for drop action in DV steering")
> Reviewed-by: Mark Bloch <markb@nvidia.com>
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/fs.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
