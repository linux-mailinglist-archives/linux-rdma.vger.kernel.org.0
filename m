Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590793F1C8E
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 17:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbhHSPXv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 11:23:51 -0400
Received: from mail-co1nam11on2045.outbound.protection.outlook.com ([40.107.220.45]:19428
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232821AbhHSPXu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 11:23:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6OKXhg9LfwO8WCUh3vYi+EpTe+8Yk1gTIf0wchC92DQmB5ezNmzWGAsU9yALjep/xpBD18d2u1YiHFUsQkkxOk2wvDkOiK/5MxVeczH9jW+MV3yLr6dHHZPL9OuSfiXzjzigIu4ZadAgG8qBfczhWEy3XvwTArCOaBfF1m5MX4iLnqvhdW0PT8gB/A4MR38TdP4t+krhYHXAj/80sgGT0+DK5xBMTc0YR2sz8zFAo7sfW+C9M+jV8tvOZ8L4FlIIasPD3MVBQuRCQ/b8XgJkcXluz2H0CWFWSo117EMBOvZecroA6x4mLOJGmuh+k5lwz6pbKOcaDe5lPPh7ZO72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M4t8JUS8Vk6eYrb186u4RMoiXAclIQ7HgnajXc/Z0A=;
 b=EFVJXuLlHbKzOtaq/HhiY8claVS/ojpYA5dPFk2fG01H6Dy8fHmvxnx5+MmFv1LAB/AvnstDVXvg1SEhsE8FJS2N+vyf/uSDRnjK5Z1+xX6J5sKllwvd/mqzFhmja9ywSDGIVEZzwmcOOpUSQBrJTSp8lrccKGOGHWT4CWJmDlYu0Lz5WSKvTcGxuq5mY0rWsgHjFRxa1tE7GsJCbLW1WsnhfQmFEyZ0v4t6q/+sF8LO7atTrsrOwcQPwUpj7bEI23CC2Ay/uGtBufCu/8VMsRXOE7X5a/7G+6M6zooCQjSTSL0QFJCa0vzxL7ianDptG1/ex7ybSAqMiUVPJJ59YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M4t8JUS8Vk6eYrb186u4RMoiXAclIQ7HgnajXc/Z0A=;
 b=cJfhuPBzYuNX0Ai9n/rkXoGsLIInOI5gW2ZG9l2Fkh5DlXioT5qdxz7VkPNifMXWc5iBnhqr5D68cW7u0jZwYG/vrwA7JmdMPYMuXbLiMqCIQIsS3PMWHTYN0uYPxPMD2cpYDwjsbwbeBGu3p6ZJ3+SHfTS4VYBzNtQmKPe4EgdLeY57y7jzZ4jafM+M4IKEV3qdfM+sPWU75Z9BIo8+a46Yr1Irg/Np+Qn6rJ5BtSdKsAmjdYVzPflv7He8s/sxnKkSjgotcxrXrkisjjJOK2bUrRLLjpx6M93NbO0jQKYMu2LviH48y9ExuFJ7EWX8ldFcK+z2iD1pI5lWKpDL4Q==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5555.namprd12.prod.outlook.com (2603:10b6:208:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 15:23:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 15:23:13 +0000
Date:   Thu, 19 Aug 2021 12:23:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [RESEND PATCH for-next] RDMA/hns: Restore mr status when rereg
 mr fails
Message-ID: <20210819152311.GB1721383@nvidia.com>
References: <1629339948-32231-1-git-send-email-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629339948-32231-1-git-send-email-liangwenpeng@huawei.com>
X-ClientProxiedBy: YT3PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT3PR01CA0114.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Thu, 19 Aug 2021 15:23:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGjst-001R2W-O7; Thu, 19 Aug 2021 12:23:11 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 366c2a31-9260-48b3-c1bd-08d96325428b
X-MS-TrafficTypeDiagnostic: BL0PR12MB5555:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55558A390DA8D90248CEF49CC2C09@BL0PR12MB5555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:207;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bfd6zseeF2e8gpHSA+tEQa+Tdpyhs2NtNYPtTt7Zb84zUKCc5hsBX9inimxFBB8E11jP9mW1/kfXxdYaSp7c+gFC2qrR4NoDzVFmIg3faRFJuFKAOFftvuFzkVrVoGNb/hkkTR8g6c7+UQfmcf9fPRcIwnDkYQi4fA/D1VFnybwUW16KANbmjXJ3ZpQYwznWDFBi4MjM4Sz4FuwMf6qdlkYf1s/e/3XcO2McKN8Jk7pm+0JKYodSuOzaG7cenx5iV7OcZ29IWTTvDKF0g4rJ/vSpHlRYF6UmZaM982E2TeUyMJuEhPnt+JVU9r3BMmWO+PzF5WpbYTXbP5dWQ8s/pgnaj8wC4g+DHthwDY9xhBFPy1025wWXDtExgPuxhSLBBAlghP25cjSEU8u6rvhiYPhqj/wFqgQN0DIugCeNxhN4I2OIxAI/gIFDk7Qia2j8L1BzLBjK61jzQmXuar69hoK4XruDgtsAaMcknlFX2pKTBJvQjhKdoRhOho2fdL6dyZHF6zOaX9c21+CAlJFhCtjnPCLzS6Owunt29HJeQC0AN72VVFfnK9hEMQJAhCJBlONuXn59OvTZ+G3hN0QcC6M/zsTg0rrDdXQW5TfI4mKVhA95khgdv8MCnoMzp1poWhcGYp9/nVB62GgFGybVrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(38100700002)(478600001)(4326008)(9786002)(66556008)(86362001)(26005)(2616005)(9746002)(8676002)(6916009)(1076003)(66946007)(5660300002)(66476007)(36756003)(426003)(8936002)(33656002)(316002)(186003)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1wl5xOKUB1wh5anP5Z5VAckZ9ok0KKQNR4uxXFHkVx0ZcoMD1EqFeK734Oq2?=
 =?us-ascii?Q?EES2o4MplsWZEzk0LCDObhAP20rXrmr9RF38d/92vvQNk5i0fneAN6Uv1xnM?=
 =?us-ascii?Q?f+lDkb1O4ra92nyn3zyBlHFQcEAgNKX4mJ8m5C7Rr7GV7Q7YH+nPdD8H1zEb?=
 =?us-ascii?Q?Kh/gsEPrx0YYUNctwDl8IxYXW00GIb2vws9OIvCV7HVk0Fb++4SIpSwwCrvc?=
 =?us-ascii?Q?uzZltCzsePGSFhtDf1X0MQabXGheD62up/sBOsMNzrExlYH0JaU+6PITk9eg?=
 =?us-ascii?Q?zjtKpLqtPAi5XD2um1msYnAGgQLNGv9ebpDlvKNxJZkg/X6gHr4rxtVYzp9y?=
 =?us-ascii?Q?wxhX7+b9W32XpOp/iZH5bM6IZGog7yMGWQ/EJbtbugfvjtVpI323/Q5Xum9+?=
 =?us-ascii?Q?oc4XQPPxNOL6FiwIZRLckbcNP0UaYWFdJ5yhKG0bcbKWvTZ5DYlbLe9D/Rgs?=
 =?us-ascii?Q?ehtO7JU0VMMsDbEPj2wqXoPrWMUDf0lKWtvi8zU3R0fH8sQ3UL4fb621+Rcb?=
 =?us-ascii?Q?3hAUjfd4NAcNEPcGhD4YyGgS9QTMSjP2UQI4GzCQwOyWuIQQFRMGs7t81Xd9?=
 =?us-ascii?Q?IfCRN3Ci35+EKApcroK4dmfCqD1NqJ0spn8SyVpi89RyuywPvymp8Jm8hdJ2?=
 =?us-ascii?Q?G/WxcE1MuE0Ezs8ih2NvWzVY5c6dq/FpbK4SxTS6N4bXdevvjXauH0eSM7z1?=
 =?us-ascii?Q?cgpMY8xgIseVYoEzw14y5pSSZCuZg2QZ+DhOB7re3NJDrvXDJK+t9fnxMrxA?=
 =?us-ascii?Q?e1vvTuvArePPx1DddrSnuYlgenPPZPRapd0aRK/cNVIBwEsMW4YQigKPWhEW?=
 =?us-ascii?Q?PCwbQU3qc/5gs05OFNEAWmclWrehcEMVOczp5MuJtYgpZ3V52Gkd6UsaJ9Vh?=
 =?us-ascii?Q?6rVCc6gj9TYriKm91cYahkc5Ip/P5FBnCjngzZhuDQRS8JGA7Hp2HGUpxwTZ?=
 =?us-ascii?Q?bpzQDsZRoA9hwR7dD7n4kJDnwgGQm/iQ+1lCmWYo7N64KGvXcdY+RfZby3oJ?=
 =?us-ascii?Q?9gycLGY7jd1gRg25RYLAcWvVNcrZSd44B5SH78MPQB3AwapV5tEAu1vy+kBS?=
 =?us-ascii?Q?Zp/TItqL7lXHWTd9wJUsawIqNl6TrwxUkPA+qQELxg+fy426RtPWaIIR7IO/?=
 =?us-ascii?Q?QiQpyO5acGXT47jCuOLpTtUQveNTeUhlPyz/gwd4Ef5y+ItGD4kTbNmYdG97?=
 =?us-ascii?Q?dkAuxu44XUDOpZ3l8Zcdp/PwyOh0558iuOk9folQcLeXS9jNsOXMUbAoXl1j?=
 =?us-ascii?Q?u6Wk/0P3HaKEfTIbHxjniLGO2f0TUl8arupvxj5jYk/4Ri4PcXeUJ8x4yDAn?=
 =?us-ascii?Q?Vc1VjCxk1lcmnjmsp4yV0R5R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366c2a31-9260-48b3-c1bd-08d96325428b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 15:23:13.2375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIopg0fxoEus2QVFI7cHeiaoALIIh3NPHVWtNBw6ZW3oXRWi7XSxrlv5DN0KHqGq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5555
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 19, 2021 at 10:25:48AM +0800, Wenpeng Liang wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> If rereg_user_mr fails, mr needs to stay in a safe state. The mr state is
> backed up when entering the rereg_user_mr function, and the mr state is
> restored when the rereg fails.
> 
> Fixes: 4e9fc1dae2a9 ("RDMA/hns: Optimize the MR registration process")
> Reported-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_mr.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index 006c84b..d0870b4 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -285,6 +285,27 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>  	return ERR_PTR(ret);
>  }
>  
> +static void copy_mr(struct hns_roce_mr *dst, struct hns_roce_mr *src)
> +{
> +	dst->enabled = src->enabled;
> +	dst->iova = src->iova;
> +	dst->size = src->size;
> +	dst->pd = src->pd;
> +	dst->access = src->access;
> +}
> +
> +static void store_rereg_mr(struct hns_roce_mr *mr_bak,
> +				  struct hns_roce_mr *mr)
> +{
> +	copy_mr(mr_bak, mr);
> +}
> +
> +static void restore_rereg_mr(struct hns_roce_mr *mr_bak,
> +				    struct hns_roce_mr *mr)
> +{
> +	copy_mr(mr, mr_bak);
> +}
> +
>  struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
>  				     u64 length, u64 virt_addr,
>  				     int mr_access_flags, struct ib_pd *pd,
> @@ -294,9 +315,12 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
>  	struct ib_device *ib_dev = &hr_dev->ib_dev;
>  	struct hns_roce_mr *mr = to_hr_mr(ibmr);
>  	struct hns_roce_cmd_mailbox *mailbox;
> +	struct hns_roce_mr mr_bak;
>  	unsigned long mtpt_idx;
>  	int ret;
>  
> +	store_rereg_mr(&mr_bak, mr);
> +

Is this enough?

What state is the MR in once hns_roce_hw_destroy_mpt() was executed?

Jason
