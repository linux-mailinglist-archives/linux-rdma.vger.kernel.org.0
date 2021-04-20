Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA899365917
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 14:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhDTMkZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 08:40:25 -0400
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:63457
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231393AbhDTMkY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Apr 2021 08:40:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tg9P3lAfVQgy65sWNo1IvGcrx9kplujj2qo5DNkEqPVJ3TPk9VuYdx6GH0sDHS0LxFXvnPVZ6YMJMPr9hkcPjgHPbUKTBjyMfLN+qH9EA0i+XB8o/fY8dTPVax9ZXGbDkP7tSIgUWms3AgKFQFX880mRAAuDFJbZMl+p/dGB+5PtAQjDp4AHHw3GvVql1c5Cd2xbbX+MaVNEd/za5K1Abi/fUf2MaT5749X5CC5l65m4hOvR/9RvwSmCipQ+0Y+TBnn0yfod9WxDUuLNb288ndQxr/9u1QGqN6ZbpaQ6V0YFdcDY4DTk2Pqrar1J8T19CIK17P8hwHuhvzYOD07U8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2kgZfOJkHhc4uR/6y6m2kQ9Js8n0/HN2dgD5uuKaXw=;
 b=b78F7AiN1aSdQGYRepDJoknOEtEbh4T8XtWeYWw+yJLYqHAE43DCnmKEpNlIx39MF2KXDaoZRpCXQbGvfWRRbrQRn6ko7DsoJhTGg0i0KZiaRQUdihbVCTNEiM2YdDr5nBW+tlpUw5PFgfXJQzmUpHFvEJvfZVzUx2+f9slxhDkary/BZxIvanFGM+4MLebwL3UOTeIKF8tRbOhZiefk/3Ld95QCykQy/mfj682VUZOlE/TaE6ueZhR0KjGKcBCxg/VjQAtcllRFvtTiOvxqQdgg/GDgK8+s5lg/86rybsmF0zhSalaKhzUenx87qhxh/ykOKfqxGFGu/b24YwkQ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2kgZfOJkHhc4uR/6y6m2kQ9Js8n0/HN2dgD5uuKaXw=;
 b=U42oe4yxEgIboZoOXOnJmN6awGI1rclYyhFtYit8EjGZdN1sYOMlxtC7QnKwEqyQUA+LlBS+oCgiRApwvIPmAtAccUC8rgqOnDnnCCyypRAexDg8zuDgHsBEVUQn00kf1TMnmDPTl1QXRt4a9MAV/HXgyXzq9c7Xvr0NxxBg+lS4zGMzsiUKIAyOFtfPxcJNm5H7yvKYZ0MhivLA5BbM6VASHoLQ6odYM2nYUYhlmOSzdz9jreFoSGjKuhJE3FvWZMM2K74jy3Xxl6jQqmM9pmu2PbqGFC7MnCMFe4vq7pEpf+236qYKse6Vjx1y8JRNVeP4B5IhJ6IxevsGqfvi2Q==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1244.namprd12.prod.outlook.com (2603:10b6:3:73::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Tue, 20 Apr
 2021 12:39:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 12:39:52 +0000
Date:   Tue, 20 Apr 2021 09:39:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all
 users are gone
Message-ID: <20210420123950.GA2138447@nvidia.com>
References: <9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:208:1a0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.17 via Frontend Transport; Tue, 20 Apr 2021 12:39:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lYpfS-008yKS-Ov; Tue, 20 Apr 2021 09:39:50 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f11c54c0-3942-471f-ce64-08d903f964b1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1244:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB124452E8DA0AF78B0C4D7AA0C2489@DM5PR12MB1244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJEfAGim89m3SpWVpuJp3VbPApCxQAIu2/jn997VFAemJ9ztQGGCkbqbOzGUTUL2Cm+QkuFksUexn7Zb6AMvRNlmBEORx+RFrBu0s6oXYvgfrrLrOqKelye4WS/xjPSCJMDQ3ZFOPeyVfmuci4h3P81h+68UXk47Er5bgbqnz35KBCwh9fyX9ne1t/isL37no1UfseOSXRNPgh84Rar5TNzqUrKyzs48dG1G297m0ZAkdhZlWW4KBjPieJfbs9flhozMytgAkjceqbhSbuVmSW467e62yzCxuLPthy/D+yAl0YUF7gz7Epaw9DF1ZAEkYn2RyjoGQhTbH5Ugc2bGQ0amV9bWhjOhGgDTBLoTxCqX92aRj/p/87ilnjO+Ly4qg49V0Em6tr83+UEDJGgqIythb2EVV84Lvw69rbPyP3cN4gNvrir+78CLLRSXrc3c3/sUWkeTH87Bjd29hBUQNFLdEblfa4/l1UHEe8i6Z+mzlSAho3Q7dny8QrgJ7+5Dnx/f1CkpF6mWo3K+CKFa3xTIYyFbaQpjLMtpVYbmlyZrctFjEO0DWItuofJ3npeF9LPMJ4o1LKJNfi+OlIB42v7fE7itury2Fi2EpqgySDQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(8676002)(66476007)(9786002)(9746002)(83380400001)(66556008)(8936002)(36756003)(4326008)(86362001)(1076003)(5660300002)(54906003)(186003)(316002)(6916009)(66946007)(426003)(26005)(38100700002)(33656002)(2906002)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1QVOlNMUhuKPHull2Dbld9NRSkRCbCkybj+zxNPVcYHcijygiiGFMJ7DUbGj?=
 =?us-ascii?Q?l7GjbHr4bEixWaYX0S7e+5RSP9k3Ui3s0U2vyGS6SFhE6TMNMjEjuW+/ZfSb?=
 =?us-ascii?Q?JA6BztWYsDJxKu3bx2z6D470qTL8CoQ5FS/5CLpu9UciE++jij+Zrp16mPHk?=
 =?us-ascii?Q?A/nL5U1cByn9+TPcjYL7V/nhqILPYgYmzIpCliT7q7E8yOuDYWN8La3f/MQe?=
 =?us-ascii?Q?58XrC84oUezCr2LV/8963LpU9IzeHpl4HVCy7iKvjjP6A4JfGRytaUKndI+A?=
 =?us-ascii?Q?F5alTsJOjA/A2wwiPUVdsvdkghcSsxz96FuW3a5Zj1wm/pKYLmzfemyJmsNz?=
 =?us-ascii?Q?lBwg3uzdg9WJv22DSKoqNRVO2ogZktbIRflenhct0tl7phIDPrA/j1CoPT3W?=
 =?us-ascii?Q?GkoTeNY4/zd4oAhbzshWKfi387YZCQrX2NdyLwnyeQ64hx3NtMftIHcK8SVX?=
 =?us-ascii?Q?2wsCYZa+nzwO9h7EcfM0JglA8qqozb4+0fiCUqAkFNE4Yg5FdlYAVEqe4Prx?=
 =?us-ascii?Q?qvxUzqgAgGFlRfzMv/nmNLS/5WfbfIe2R0+PqyEELTmG9gOOjkcPzRI09tFu?=
 =?us-ascii?Q?RFc2mZF5nbNl0AvA52dyOHrHa4LUbMbzxLlAIsBkX9ZdkobgeZzc833cZvLg?=
 =?us-ascii?Q?tNfQKOhB4KHMvm2SR1NnPpSz0JMVCeMctgtUJtAQrQeMq8KFehVvvo/tjELe?=
 =?us-ascii?Q?fiCRHEMkiXhd/k8w96JugNFQj3cF7bcFXsJuUkl8E3cGKd8VQULBOalsEZRY?=
 =?us-ascii?Q?IBC7gijGCo2y99lnMyzZDXs0a+IyOgZp1hRH4+9jZG8/PbPCCTnT0hUjmwJy?=
 =?us-ascii?Q?jHgoWoQMGaEutnFtaoMOuBzkP5LT9gUFrbTkawNDnVJIq0a6WH+fbusIbejr?=
 =?us-ascii?Q?2FnOf1L9/C4ebiv9wSZ3xFD86RERKQ1E4o/o0RltiEO1iL7+0wnzb3021Ar7?=
 =?us-ascii?Q?JzjdKnsjYAoyrsQzCRPXhHY2rrRLvlM/gOT9htnRjS7vU0oZkG5Sp6aoTyUZ?=
 =?us-ascii?Q?GHHakJE+tnDW3ATX8rm9cDX1Aphh2yLNTYnTaYHQPC0iRloNJXYKG+X8EYz5?=
 =?us-ascii?Q?RHVfTQ3ZWBxy4KXiIdV+xqXghrT5IVb50KZPUTCmNcbf9U7lx9eC+SUSSwqm?=
 =?us-ascii?Q?BaLF0nHajLdQfUOGB+9cpXm3x0wQzlp+pkTwtC0Axb+hNorxt62nc6GpecgD?=
 =?us-ascii?Q?GJZN9KdTAWkLd2tBnDy+nI+TP4ZB45It/1y0pwe4eysQzrKTufG5Qss+nX4u?=
 =?us-ascii?Q?o8Xl7C14nSl1T05oeQ4YnxCajz5wg0B8Y/GbOU9BZ6QvVifwVwS7HkKplmRw?=
 =?us-ascii?Q?HJaLG+DAx9zO5ef0SHCaSWSNspMS7Ce9t85J+GGBTucMSA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11c54c0-3942-471f-ce64-08d903f964b1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 12:39:52.1889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIOIcX7kee3xoZJzgldCGry85d344igDYFiDHzX6KDv8qxgqiR2QbKSs5AkrkcUz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1244
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 18, 2021 at 04:37:35PM +0300, Leon Romanovsky wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Currently, in case of QP, the following use-after-free is possible:
> 
> 	cpu0				cpu1
> 	----				----
>  res_get_common_dumpit()
>  rdma_restrack_get()
>  fill_res_qp_entry()
> 				ib_destroy_qp_user()
> 				 rdma_restrack_del()
> 				 qp->device->ops.destroy_qp()
>   ib_query_qp()
>   qp->device->ops.query_qp()
>     --> use-after-free-qp
> 
> This is because rdma_restrack_del(), in case of QP, isn't waiting until
> all users are gone.
> 
> Fix it by making rdma_restrack_del() wait until all users are gone for
> QPs as well.
> 
> Fixes: 13ef5539def7 ("RDMA/restrack: Count references to the verbs objects")
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/restrack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index ffabaf327242..def0c5b0efe9 100644
> --- a/drivers/infiniband/core/restrack.c
> +++ b/drivers/infiniband/core/restrack.c
> @@ -340,7 +340,7 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
>  	rt = &dev->res[res->type];
>  
>  	old = xa_erase(&rt->xa, res->id);
> -	if (res->type == RDMA_RESTRACK_MR || res->type == RDMA_RESTRACK_QP)
> +	if (res->type == RDMA_RESTRACK_MR)
>  		return;

Why is MR skipping this?


It also calls into the driver under its dumpit, at the very least this
needs a comment.

Jason
