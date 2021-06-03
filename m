Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD53139AB2C
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCT75 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 15:59:57 -0400
Received: from mail-bn8nam12on2064.outbound.protection.outlook.com ([40.107.237.64]:33440
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229656AbhFCT74 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 15:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/sCllSue0BVQAOyOd65xJcBogZDzWE0SGR1eUh+sxEQm3EW14fZerJibcp4BKLrOkQ42MvQK7/XUlxBR40qzA6CRDA9TwP/mXk72JmiW8IOprPmaOoxvBd6Y0aeFY+LnGJ5vWt+Z2xO8Fok4mScg+VzXA43g+jYjNXBnvJOQSxhUCL595ky2IzIS/F4M8va0HSnzmdJD5WRD9Gm6HS0HJiu2EngvBG1U88aULqQmr1DtrT5Y7jp20+wgvU65J140/5uJ4/m2jyq1WViV4JhegR80jGMdN+gx2rYSRQsr3ntxnAXg8MgNyG0Kii/M6E+VXYQYlA+S0PmOypi7dlsXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf3Nqr1Dzxgxhwvn5lNZXA2zBfJHRFyfQa7JqKMZdV8=;
 b=UhKTFjip798RGeA6KtdQ5knxIWhiefRwFTzbRk1wgLoaZfnt+4A9Ys/cmiTxJOPfdFh+/nPHwh9XeNG6XnUcVzVrvYbITMqgzHAhLO+smHFjC4++vGUT0p6whzfb1a3ovimSSkVUrWCLBMqOyA+8e784UI4oGHTl5puyPzfnjdLONd3GZfs3PYBMqN4VvPccBa2QJfR4TyMQMgCjOWPeSpez1L+QvE4QZ4drCcYZPa4IB1spTc+gkdL/QzDY51G6VViNEK6IscdP1HCIoZg125K6Y5KmmLoQvDNcbpMrnsuOfdt6eN1LCwStAOEpoh48yCpuVzXrpmbecoQyT3t/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf3Nqr1Dzxgxhwvn5lNZXA2zBfJHRFyfQa7JqKMZdV8=;
 b=jmtMzx71UuJiA0BQXYH0WN8OEAjbRxFIjWK9P+ALqIQ8mNGitD4oo1QJlYLU1AlUMR2DCWMcAayYKnwATn6ZQW6svwo05JJUu0UFyBxhydzZGS+N1AB/3yqIYXJmfPjDj9gT63ohkIcMjxlrlk0gEuWggiU+/OaAyWYawLJald09o3GPIGSiVYSmOrUDataPXkX2ooaYEl8mxEIdc+MuAIWN8sQE1N9wGEey4NWr+eZy69mUeV2yqy4XxYPP5eaYqGIruc29XuQSxttnyeIEU9+NSPEb0avv735Pba1c1enSyjtGZn6a8xxyTObRyQxQ2meaC/HxwHO0A3UXlLRCVQ==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 19:58:10 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 19:58:10 +0000
Date:   Thu, 3 Jun 2021 16:58:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH V7 for-next 3/3] RDMA/bnxt_re: update ABI to pass
 wqe-mode to user space
Message-ID: <20210603195809.GA322627@nvidia.com>
References: <20210603131534.982257-1-devesh.sharma@broadcom.com>
 <20210603131534.982257-4-devesh.sharma@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603131534.982257-4-devesh.sharma@broadcom.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:208:a8::37) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR12CA0024.namprd12.prod.outlook.com (2603:10b6:208:a8::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Thu, 3 Jun 2021 19:58:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lotTl-001Lyg-0l; Thu, 03 Jun 2021 16:58:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a31ab1b3-1a02-4008-f6b7-08d926c9e998
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51924782FCFA0F676D1CDDEBC23C9@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eg4ljIhGbIyaXkMsay40AxJbhaauiZrjZItApiQsBHhbedhf41oITPn7PrcwKKkKypjLQInl9ZEKJ1081tmAY2MXEg2KsNfADp4Acp+aLMdyXy0kFIQh2tvW5G1YwCL2cWH9J1l2EsrXIKiWotHK2CU/Sqocohc+S9ZJw3YvaEXVheV4YcH6kh+wfjmRbg6xYy4UP3/h62bPB14ifN7CFmNQIzbdz+2fZuARXcCOlIO7XumygM5QrBju3hlYPCk9VaJZhIP208XhUHiUeU595aDrTrr86fnjKzvRZDY2q0T8ILkGJM9KZQtmBOA8EG2ZkgDZ/FOclxk7NcTlXimVFlQFfQG4HriLceuhgzKT8eYeYhGCX28P8JU2Yup8kmXjhvJEBvLyTrV8ZTXz0qW/02OF0gyAn12S1CSD81uFrLpGa0cqq7ZB1IeI67h9lfEtMIm0Q1K+Gkth8MOmMp0dA87RzkqqnttyXfmx9XaPy0S/mS0WvJpLH2ubCtSABBsU0s2H5CH2oipdE4oTnrMS579SGreDBmUdPeFC3xuUv3kVtnfyfBoSduJfr8uoKkbmoAYjmOzIh22whiPosfsKZtXPr+6I5JDlF5W/anrztC2xupZXbjeEaScG/8jbtIHZx3xy8YaF5JlmUqnwBJrkn6vOkRAJMfJAlE/mmgqetBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(26005)(8676002)(186003)(478600001)(83380400001)(316002)(426003)(36756003)(6916009)(2616005)(2906002)(86362001)(4326008)(66476007)(1076003)(9786002)(5660300002)(9746002)(66556008)(66946007)(33656002)(8936002)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DfXF1uFvkVqkJm580FB0XVwE9wZamFB7iztr62MqHAx02LBb6WBXfRkD4HPe?=
 =?us-ascii?Q?LeY2/wXSmbMOA1UzHsragBdZAOkBnUzADbdfmKzq91CcP1vsVRSTYZ6LtGZa?=
 =?us-ascii?Q?o01vk0RMPgAhCsVayieff/2lRQADfVhbiYgtVw2GiVshuJKpWJw+zJHXHoA4?=
 =?us-ascii?Q?ojsmkexSec8/NNA7jBS+SEUME9seLyIttYO4LMiuthHm8f+wDsf+zkJaeyPW?=
 =?us-ascii?Q?lG2c5tXw/BsRkdF7jOJWTs1fh+0eswdNsVAFTQF24tx6s4uPRhmcPmpJ+mXZ?=
 =?us-ascii?Q?nwBOVwy9B/epv3Kp6PIvWl8mHMYceBP1b8d0eXB+WfHsbCy31fiPyb0ku2wm?=
 =?us-ascii?Q?gsbYr9VYcFwDB+hA1B5VuSqvMXF8AvTE8ErKmuAnGs4H9IFBAgXFnQh4lcaK?=
 =?us-ascii?Q?UJqdCuVyEEMX6Dvhhpfc7fZLRyZhFNWpYBJsf1zjf94MWl7BqbFthwn0VwTi?=
 =?us-ascii?Q?DDfsyooXmsJUwJA3P1Viz0yVVol/uFbB1GgNtGLuY5WWZgh035KpeImiTmwr?=
 =?us-ascii?Q?Cm6RpStlJig88y2OvhXDolhlT+lvOGIPtvekq3FvQXYwcQPp6nvLcGfVGUCu?=
 =?us-ascii?Q?s//Qzw4vyvcg6n6UMialTPlw6MikA3qTdo+qOm2aBVONYPz9yd2imCicsLF1?=
 =?us-ascii?Q?LLV7CSogcPOeu43DGBDLozi6CSw2imgUJ13xysQmsXX+av7oTHdm0w/pHGhx?=
 =?us-ascii?Q?vOMRtcB2pXjpJdrGf61TK7U2wI6neE26ssgMcnUBc4Esyethw6Ge5rus7b9l?=
 =?us-ascii?Q?d6OeHD/Wz7ey7MxoL7zhoLfKF5C0qhQIbjyeUI+iLleaciUWQ8HiIJb9uJo5?=
 =?us-ascii?Q?TDdH+TxbUX+/+g7gZg4d9O6cTVy1Tkn16GcBJ3GHDVyQIj0J2PKhNhxJAyvr?=
 =?us-ascii?Q?QEq8cA8VSxeYu8ISG8oPKN/fj8rNybz5PKEOkSANpudnWTxkxTurRS4fJll8?=
 =?us-ascii?Q?Dxnce6WqjI9zZEutuDWWxsuvOkmaErrWhAETZQf138HcjFhZtOUMV8zklPnM?=
 =?us-ascii?Q?WwyAezk7TgCeg3tmkl35uTLPm9VEFsG0bbHpth3JoyeXtWk/yH6TOwqEd+oG?=
 =?us-ascii?Q?XQZM8jOGd/7GRAr/g/FnlwIR+7R0eX5eojO6MKfS5SuAnx2JQruWLUhk/9T1?=
 =?us-ascii?Q?9+soeehx4zvaP7pgd7rtdc7OXT48unGxXGQSjsBYh51Jsjs8659tYoVZfCnh?=
 =?us-ascii?Q?m9UbUdYyXALmXkccZr2tDloYROWRjHnJjKBrnQE/SY/iUIE54dnhWK2m1xVU?=
 =?us-ascii?Q?OrGvTSZRomIG1Wp3dUYwsCuyZKisgilRnd21O63DJS4ZPmgvMq2MIshO3XMB?=
 =?us-ascii?Q?izW+iWKVNCYKYbKWtM47WIaE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31ab1b3-1a02-4008-f6b7-08d926c9e998
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 19:58:10.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTlHKjJ8KPNHhqAqm+yiyYJauhi4UE4x/CzLSNu+zbXbGTDIw2lz3xtqJRCzXH73
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 03, 2021 at 06:45:34PM +0530, Devesh Sharma wrote:
> Changing ucontext ABI response structure to pass wqe_mode
> to user library.
> A flag in comp_mask has been set to indicate presence of
> wqe_mode.
> 
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 3 +++
>  include/uapi/rdma/bnxt_re-abi.h          | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index a113d8d9e9ed..5955713234cb 100644
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -3882,6 +3882,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
>  	resp.max_cqd = dev_attr->max_cq_wqes;
>  	resp.rsvd    = 0;
>  
> +	resp.comp_mask |= BNXT_RE_UCNTX_CMASK_HAVE_MODE;
> +	resp.mode = rdev->chip_ctx->modes.wqe_mode;

The enum for this value is not in bnxt_re-abi.h and needs to be moved
there if you are going to start using it as uABI

In fact it looks like several of the things in
providers/bnxt_re/bnxt_re-abi.h needs to be moved to the kernel ABI
header and harmonized with the kernel driver.

Jason

