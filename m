Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBD74D9090
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Mar 2022 00:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbiCNXq0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Mar 2022 19:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343737AbiCNXqZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Mar 2022 19:46:25 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B6E3190C;
        Mon, 14 Mar 2022 16:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUihr6Qd8IXJR5V2LZjl8zOxYs0yp7p0XiUomwPNWFn0omkYUw1LpMbsYDrRwD28fErf8zOb3rzvseDJrIjVhVfiIl87FyvyuBdZGodU1l4qcGhF3yVlgWQPvgXRnkJubSDFFKawUGUeqdOp9F8mNTavVPy7vuWdOJzrgE/dYzgYYnGD7M4QC7aIIht8Le9RVLyaPy2leQNvbFeIhhk5wPZLJ5soOKiZQf25vW53AToP6lFVTCdREIkMGvLN+i6GO7TulQ6ElsPqQXK6CRZ1guMKLajOgrN7mN8ahffrGKvk3WdXmghiUtCiV+dem0q+LLey9BOkhFGDRMC7D4Ut3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDiy9pCrONdGForYbmTcE1Wgwtgkrqr3u5NuCOklz0M=;
 b=JT+53J6HmyXlsGpq7IKRz8zYqwz632MbBh08reN9ood/RiSF5H+TwB2PDCamdYoNq3jXmZodzxFHRJHHfD1mEEk9adtoeD2qAWajhHIWYLs6RX+x7mpB4gyhH1V33vxrf1gHt0rzcFq2vrbXyIeJAYFlYSZp/JHekFK4SYl+Ui/dDFg/XMogfMMEGN4YYwFnoDpf4SjGPNnq1spa2fvq9b9NFlbTkcHmCI/oEE6mPG0rsSwIsV+du/8gcfJmjLGishhvZhy1/W60Lz6l5Dqkyu1/J4cb/rz6uHhK2aVJmOMbYxrWxhmdCrHTn2/wjoEfPj6rKQ1MSPqmBMt2XGni2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDiy9pCrONdGForYbmTcE1Wgwtgkrqr3u5NuCOklz0M=;
 b=D/8m5acfjnyyhnJlIYSXiyAnVhDrUzGQpIdSuIWZIyJoJj83TlWYpIbsoMSgKwQQpA0KrXj9MgiuUCcOIZWgYQ2dZ3pdaN4o8QpTDVNFgUlAgBentHOYx8PLLB2sxGQDOXYWPVvEL8hxMSjj4y/C/++LOeg9lnGuvtwWrkljwpLSoiR4rDTwjHTwJECah5ZGWfXOOtFEgvY0Uz06FI3txzXbGt57/rY7aonC52J6gJcT1b+ieSnqYSnwU/2CUWGszAmlV/xIrXZjCt5RMxo+FrRVVpj+K9a1RaocfMb5cxNVizw53B99wKuGS87W+3xh2kRgvLrsQIADz0mU7D6DmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Mon, 14 Mar
 2022 23:45:12 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 23:45:12 +0000
Date:   Mon, 14 Mar 2022 20:45:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     leon@kernel.org, yishaih@mellanox.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, fuyq@stu.pku.edu.cn
Subject: Re: [PATCH] RDMA/mlx5: Fix memory leak
Message-ID: <20220314234511.GD172564@nvidia.com>
References: <1647018361-18266-1-git-send-email-lyz_cs@pku.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647018361-18266-1-git-send-email-lyz_cs@pku.edu.cn>
X-ClientProxiedBy: MN2PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:208:160::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19f35aac-3595-4fd2-99cf-08da0614ae7a
X-MS-TrafficTypeDiagnostic: LV2PR12MB5989:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5989F57A7C7825C5ED41F5E7C20F9@LV2PR12MB5989.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pFv3dWAE6E4Mka4Fsjcnyq63U8gXVqaLYAq/LhappJyH/v25RlDRQUIaBu4yXLu6HkN8hRTWsymY43yscLT813Pe/8Qu7cwy7cLlsiAZDyXMCQxeP3vW1LoQRwjOUw9QqURcYszXDUDuZ6e5h6mReKwLJqWCXXl5RkWWUPz9a77C2zk+o/lEcZtefjDXZXHzbfxkj8P3kNwOdQYyvNfnOrTWMHeRUhHUXKXe31Oxy63HlRH2tgR5JyoxbXvV4+dhul4xwIuU5wbhTwpq45ZhSPWrXagqwKinefbh7uTFsqs0dCt0o/5ZTDPHWBvCS2EB+XQUhjQr9bxl9LFy69I/Fah3/0tdgB3pdKw+v6vUlkxddgyoCs5uk1sQ7okONtry0ZnfJj/0E4YrVnZ6t9qyXiTqTnEMttu/lWEe3ofj39fsofxHMDSW7pezqPFW1BqCfOtV2vibvRhDcTVHFgV2S3ymz0bQK+TRGqoEN8j/d4XicutRuqq78qnODIRTA+/tSbnGkHNvxfztonmNKwswvrbV/BRy9sWb6aiTCe2mfH3DawnsgTsQAGyJYXJ76YWA5qnH8AC0pDLoO/I2kZdV4gWTKyT2fOOAXMjRFbw7+kQ3ozvOU7WnNE3E5I9m1oFdb86skQAtJjrRlqIg/s5Xd5C3VQk5KLBFcOOPfAIVOr83oSQgQAPO6YvEVhu7eBSYBHuR4u1yTYn7pvrj5RMMHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(66556008)(66476007)(508600001)(38100700002)(2906002)(6916009)(33656002)(2616005)(6486002)(4744005)(316002)(83380400001)(5660300002)(6512007)(86362001)(1076003)(8936002)(4326008)(26005)(186003)(66946007)(8676002)(6506007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pBtIj/JzZLS32A8qUdhIiShHollNdGP9I73OYfbspvG3zPxsFJTNmat5AS5N?=
 =?us-ascii?Q?h1HQS5FfjcINAOm/b8AK/JFccOhwiXdKQIju6UEQdUg7mJG8HmhkisZBNdZh?=
 =?us-ascii?Q?WkxaNIxQs0r1UudwrGd2nmsg99N0Hi8HG5oi9PuC8wm/2xdri9GkN8um/IIT?=
 =?us-ascii?Q?8W6YCTAwoK9lFk5DnQnCDpOXRFfdrqAwAnHKos2kgiOGoEJxD1M7vVqcsmxI?=
 =?us-ascii?Q?DQ9t0TXm74ZYGSWwrOZaAYSgj/+yxu+bFpa8Ya4M5PluaKL72arRHDjHTx1f?=
 =?us-ascii?Q?r5tmMfcphLloiUI+ddMpSXNGvvEzsQPM1PGaqgmSqqkDmOxvBETd/ljX9TDr?=
 =?us-ascii?Q?W4cie9BKTXONy2qKIuyLKlxJAC8Ou6/yZnbRkxJoCbdocXpEL7lQQE6fY1u/?=
 =?us-ascii?Q?+cTTxD/FE+fZJ21t30/c+Yf1032gnl6oNOuURYLenzkt2k2h0tU8rforeUx3?=
 =?us-ascii?Q?AkO+VC3UKO+Uu+Rwr/35ZndMy7/kkkxoyvt1vNN4NzLpf5TDTj0Hu1oPW72Q?=
 =?us-ascii?Q?y7dxbqnONCqtFY2bkZxAgQ3p61WwbmIgYolbSXj6LHM/a8RkqdD884+BvdQ7?=
 =?us-ascii?Q?/T5+DAbDaV6vkuIC1dNSu2rHYVebbC98+OqEvWAGeSYOAkQFPpRtvpWxDtZC?=
 =?us-ascii?Q?4Cm8mX22c7dadSfU93iOZ5n88leL5s1ehC+2Q2KRtFqpzdIx40G7ls1tNRE9?=
 =?us-ascii?Q?7OlGXTgTfeyBTuzSJzWd6+J88Ai1o/n6gai4frGj8vZjy6IaX7UfKBk+najs?=
 =?us-ascii?Q?KRrtVUTaAUMohqdUo374T8zGeyAaKHZg2/4+g0lVzCa4Xqt53lj7pdzJMwao?=
 =?us-ascii?Q?wDy12CvqbiZIrv4ofDtZytLKG2G4yNkvSfPyJ7RtZx7Ii6K5UjekZzLbYOHD?=
 =?us-ascii?Q?CZuE9PnyL+6rdanC0ktt7G9zZ1uQOVph7bSjOxvfrhr9ATSA8C1BJKytuSss?=
 =?us-ascii?Q?FyrYYqM7tYqup6yb4V9zA4l+XhZEKXRISzNJYVAIVLZ0ZRALpLrrGT6grfE7?=
 =?us-ascii?Q?we7V2A2hJKRPzux2NRzlcUHLKTrEF73WM+Z9nK6/bp2uP7Twrz6Nbb8rREmn?=
 =?us-ascii?Q?u1YHqVpVO1L+/zilY9sSb4cRThekJTqRCz6tZbNyaPrLATLrDX5WqtB1c9uq?=
 =?us-ascii?Q?m7H4GaOrIVk7vaU3EC8eAz8JEZkdnnE2GuuEqUICuc/wFGCGTIAvf6FlqZio?=
 =?us-ascii?Q?74AVNSpCw/dPH9ln/RjyNobUGAEDsgMHRGwNTPBsinEHfGohgUzefvNMNJo7?=
 =?us-ascii?Q?CIfTNCZwGIEyfMFVpeKOaIEhpWyBG+pyt1ippGygpNJlHWXzvhDYHhNIQ2Ju?=
 =?us-ascii?Q?MMpfPmFbFUpbXQegQ1iRMtF6zG0yKgX8Gm1ZaaUeOzIQhZMrGJuwZ9Z475e2?=
 =?us-ascii?Q?m1rNlOdFP1sCbzHwDzDgx30esXBd/I1YyFwlQcPwAAg8/puVlNUCMaBTs+Ui?=
 =?us-ascii?Q?GZkmISJ+gHduHmExfrUL3OS9VDBCbJGB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f35aac-3595-4fd2-99cf-08da0614ae7a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 23:45:12.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVaNyDtiwQlOp/ppZHqHRtgNIWz1bbf6NDRpWZLxLfpefnVV4sm34IFyTlxV2c52
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 11, 2022 at 09:06:01AM -0800, Yongzhi Liu wrote:
> [why]
> xa_insert is failed, so caller of subscribe_event_xa_alloc
> cannot call other function to free obj_event. Therefore,
> Resource release is needed on the error handling path to
> prevent memory leak.
> 
> [how]
> Fix this by adding kfree on the error handling path.
> 
> Fixes: 7597385 ("IB/mlx5: Enable subscription for device events over DEVX")
> 
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-next with Leon's commit message

Thanks,
Jason
