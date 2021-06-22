Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE353AFA00
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 02:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFVADo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 20:03:44 -0400
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com ([40.107.93.53]:60001
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230182AbhFVADn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 20:03:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBlX9R8V602PEoFMLf2zVLfqGsOp9smC+jWa+A8r54P/oXY1fY3D2f8Wa8RBmQBoSF8VC6NCdbgQnzZCJOmI2tyC7fBxjebARjU0RAr8mUTs4tnowwZJE9TzWL3hhJ54WNK19q5AxnhTK5v+BwhO1LzgLQo7pxaYt+m5756jLgiLhNWOZUn/N1Pq3i0HE8fD3nFzD1bllG3yQMTMUW5BrmFJLchXaJE1wG84tipqYSoBcfGI/HJb6IyKfKWwujthF/R0yWLvDdmP/1IrwjXkOE9MXzDFzwZ8P1oJEaMTDCO9CqFms8f8oBZu667pc/rJbptQEcbnrG9TxdaU1KSb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pi9TewR+1fkibJA/tEmLDKuUnLNKncVp7ayH18PgGM0=;
 b=TeatXAKfevRKxTwdWmxuq/rsM+vEpwlGp6dYkG8u+mEkffsxKdvLLYAxmgr1FrO5/sWhELpCOJDM7gXtlO+KE3GNBO/YeP58SVJCAxyLWjdINfm9oN4exbfcACYVppwI5sbN9BtUxfbKEfxgzv5gs5mx3Li8u66wEr1M/nCNM0++DY6YXlOtmmEp2hxC0EkeEv5khxyyoKy/Up5JAbWM/cWrdzZh8U+ixf2WKN4SVRVP+i0+lq7OB2MCHtcXe7OFwry5B4zNLvuVAgq3WN1XcNm6L0WRYzuiHQ0r1EcM3ei+ANdHjfpciVFGp7sOXKm1VOM86b9e/rdTCNJ+7DzOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pi9TewR+1fkibJA/tEmLDKuUnLNKncVp7ayH18PgGM0=;
 b=oON6sP9mvvuK8bRWt00o3k/mJ03Fs0vRri/kmNfWoEgxW7dRjLa6QUrGv/+Ik97Ifo6YZpBaVUBdD8GItIA/RADHZLIpJt7gom2CZmBbo+in4/AaRyfYNwjwhm5lf6Rl9df3Wg3S3kQeLfcGnXWms0YuRNcxwnH8ud6Grfc6dMTMjrEUoBOqUAP6U1aUih6jBdYpuog1AAmM/nu/nipDUZlpEGtifQRCZsAXP9uTxfAHldq9rPhXGfKz/dBknpmVOtoXJcDbPx9i5lOC24BDQrkzxxX9n3lupPZdVPcCQn9YQd6rI+TtdMkc28bjJVDlvas13S/USP2y6Qb8GOyhlw==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Tue, 22 Jun
 2021 00:01:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 00:01:26 +0000
Date:   Mon, 21 Jun 2021 21:01:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH V8 for-next] RDMA/bnxt_re: update ABI to pass wqe-mode to
 user space
Message-ID: <20210622000125.GA2378220@nvidia.com>
References: <20210616202817.1185276-1-devesh.sharma@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616202817.1185276-1-devesh.sharma@broadcom.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Tue, 22 Jun 2021 00:01:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvTr3-009yh0-3J; Mon, 21 Jun 2021 21:01:25 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b337a76-7438-4a9a-e387-08d93510e133
X-MS-TrafficTypeDiagnostic: BL1PR12MB5361:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5361D64B9AD67C275E144F43C2099@BL1PR12MB5361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lLK8MSOELBb0ZGYPH+94s8UDu4TIhfEITUGHx9HJzEYKNbZRkex2wT0iwqyS7EZ2NWtfTOujY2IgnGd4HHZgZacObw7h58BqgONUqTUfMPxBoY1IW1qBHSPRknyO/eBzRl1X6MyJL37oQ/Yo9LP8HTnqvkFbd3UoZ+LxIFq+9L9KJXYeZOp/cEgUmixYRuKdykDU4CrFvGL56sNNntwvTeHi+nScSCUS0rz13nKOCOgnTPuTDTI/95xIBwaIGPUd0sPurUCM/uIjfiHrtyXIe+azLudzPorIbhiSJCuVLjr6y7QE4Oem+NPKjetMXTrpEU904hMu//TdcA7LSYptXtBMZCiubc1PAEl5jxfnX8seGR5Xyl+Hd26evi4QmBa6rqvVxqVhWOwT1fm6r68j/r3afV3eZB+uI3XuOal5PrLLcJsg9uNnYm/Bsg05Vq4axQmlIYtAaDg5DRT5IyaNk2NffmewMzir6o4pzG5Le4MIqAx7yC8orbmvsW0mjnf797kCyVRqE++fSzrLHX/EW1vpYG99Jw7qIp3VQ3/AUdAd7Wx89vJe8F2FbIAt/P6f+k0d9TV2TS3DJGhA4/3P/E1QQTWaXcqraBUto88iUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(6916009)(8936002)(26005)(8676002)(4326008)(33656002)(2616005)(36756003)(4744005)(186003)(38100700002)(86362001)(66946007)(426003)(66556008)(478600001)(83380400001)(5660300002)(316002)(66476007)(9786002)(9746002)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xVvb7l1AyiUyYHJa2DIIQygecJbV86A+j/WR9hh+uAOJL17cdz2D9BQpKtBL?=
 =?us-ascii?Q?m+NlzlYRZFLzuJwpjts+9Nxb5EnnP7PMjfAXcYCD1zyksFXdhKgUOlUVjAav?=
 =?us-ascii?Q?QTrAIqAtYY0DM3HfyuWGh0GPXgxwLfQZEZHv0U4u4ccnA2BuUM+vCncBnKW2?=
 =?us-ascii?Q?2XYpQ1ek/Y7iX1SMMaB6ZnF6z3Ctd7W+OMbcN1DmRmSiWy7Xd8X7lYALfKG+?=
 =?us-ascii?Q?4JvEtfk3qXKX2uT/2c2a40qPOrUOPFlmmx1OXw+/X8yai0aRLJ8mZcw+LhIX?=
 =?us-ascii?Q?fSKkPP1Jl+tlYMWdBJ4BEe36d9WvcynyC2Ek8Ii3QJOISZocNthDarzA9kMh?=
 =?us-ascii?Q?CPHKX6RwcuPsKPTVvG65ADjpFKYpBFUIPLaOkMjze0zK5junwZmxiDOUQjg8?=
 =?us-ascii?Q?3IPUiVLov6iTTUdkhwDSHhPfG9vRT1qmySJ5te6mrUjqAECyQaTQjpgqeHne?=
 =?us-ascii?Q?dFH/X+GQFY8Lou7KUgKnSMMpkEh2phYhP43SaupohPL4zb01EjuD2PXaIJpc?=
 =?us-ascii?Q?FOMiOZgH+TbOBLmjSwL/uEEyy0+Uf0BPxBZIup5iqiAhv+pAUHNZoCUrSMak?=
 =?us-ascii?Q?YuOfA/nf0xUifpputsPINWJTvdGGc1yuK4xr0dPJ5NS9kVBJFBnciQGeFLL+?=
 =?us-ascii?Q?1N8eVHrlwA5c0UgdBYkbZnQy7Umja6SGrbKaPkPEBSShEWl+YZGnfl4MdC0V?=
 =?us-ascii?Q?nN4BUR88XxESS+YcDNV8nKXAhD1N3hGGoCBXT26fcfB3CSzqkvKgo0s5f1vk?=
 =?us-ascii?Q?jn5NjXApktYXxbgH7xofkVnqc/bH+b/7FersQZnwsPsUkIm0lBacn42UStEl?=
 =?us-ascii?Q?Pk3PrIFNwIwwtD58B67i40Zvsb1VTmTy/oXL+QdZ2VOdBwdvb8qs9Z5mamyh?=
 =?us-ascii?Q?XcglCIP8AxmeJVYEFQdTH8qu9vGRz6JSFxNNIeq4uIs2zqkllbtQIr10kDbZ?=
 =?us-ascii?Q?nZlOer83mi5HVB0Gqxh2GhrkGFkVQ52b3qXOjzNgswkeOFjUGzU94DdvWpo7?=
 =?us-ascii?Q?4LwvJlfjw5p8lTqQNoeVhLfyKomDHYtJ1SVNkQ3wngDTmNZIB6ykNHgoYoXo?=
 =?us-ascii?Q?MgyGTBQFxaDsri2OocbDAL2rVTsZJyseb49IjoWQSe+SQAans8po4cZ7OuCD?=
 =?us-ascii?Q?N6wmv32kxIDPBGNprIvco1TqfkveU3/86oMvkxuzP0ZNaRfdcmbGkDE6kS6J?=
 =?us-ascii?Q?rxHBDLe0N+dTrke6QNfslbu2p/RhG7jtw3dhtinGiMAEdmB1zksi8Fa7HMvi?=
 =?us-ascii?Q?oAWkZWBrSp8zux9e8IO8h6K8/YgK+HGcMEMvKRBbMBlnfumMRbfmI2P3qkb1?=
 =?us-ascii?Q?UChV8uVDB+KdNP750jlwwk68?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b337a76-7438-4a9a-e387-08d93510e133
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 00:01:26.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VoOUKtLGcskON1su+nb5HvRduu/GcpcPXP5dcyTCKCUfLnvzDxsGeDeQrxqZ0Sd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 17, 2021 at 01:58:17AM +0530, Devesh Sharma wrote:
> Changing ucontext ABI response structure to pass wqe_mode
> to user library.
> A flag in comp_mask has been set to indicate presence of
> wqe_mode.
> 
> Moved wqe-mode ABI to uapi/rdma/bnxt_re-abi.h
> 
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  3 +++
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  2 ++
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ------
>  include/uapi/rdma/bnxt_re-abi.h           | 11 ++++++++++-
>  4 files changed, 15 insertions(+), 7 deletions(-)

Applied to for-next, thanks

Jason
