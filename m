Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3874F162F
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 15:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356199AbiDDNlg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 09:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356127AbiDDNle (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 09:41:34 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D634DFD0
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 06:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbSseilw8zU/ehrq0QZrTkZh8JicYJ1Wl57Bz+PTzX5kV1XCqBqPTBPftCfEUOvTkZVtkVXrxIz71XS4ft7LyH/RtMIvZBYkXqMuV2Cw2D18S09XMf187jm2nO4zRUDVLsVt7oaS3AsQgWmhrsumMnZT7KBoduqnGHYejmzLAoO2/Q08liPEsfiRWnPVyr/6hDKiJpyw3ec8mlqF1rinlDeJhRt9FkxfWsN3YAdAeDHVUErmwNt9Ko4udzVcV4sbc+Ed3UCE3f/mZLVhZDdZNNV51b0pUL8G1tR2NHTFh7+NMXCnn6b09JEQnDOJD43/eHPWSe8Wy1c85mDa/jqCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIGzEoqvLdXYT9kex0QzDxu+pVjqMkg61fcE1WoL9P8=;
 b=BzwgMCRmkFSlytRLi+wNvRKRW4rgpe75TXas3Z8wSmym6OjCFoiWAqZm2Meqo0lIJyHPOvfl4Cj50GVo1Lh5s2uyVFfDjaWQeJnzttYZLIEH4IkAPiqA07JMPXqwUMW8b/KoN6lXzKQE1tUvIc7vmdqy6ENatI4q7xKjJCu0Jwh4haacwCOOSJc1WTCV185loZQz1504+w1iAAfry3L34wuhkyTpz6q5kuVIT8eRg59yYk4x+55x4DTIlX3DkWdngKZYZhNhXyXsGEBWNi9MU5d1wk3xsaNs1oe21HcsOCwiAyiYGhx2xmVMSKSGtU9fiIZ1U6wE9gfLtOJDry4idQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIGzEoqvLdXYT9kex0QzDxu+pVjqMkg61fcE1WoL9P8=;
 b=c9BhH4EV6NUI3gu+2Ri4pDZL0Qn/aK+Z2wgrixxQLgQ1Bh3dGNANIdTzSMmeqZn19JhJQL8Hj48+HbASyKVKtWclTkwrKjrFlbT1xvFIZmPJ6l71rjMfFzpxUxhoSV+iGXyeZ12da4s24wDtdLNw+tBbo4oFUcf92Gx2zf3ZqIVVwlZevVp8tPaUTgH2eEpOLTSwLt5P5Nhg1cR2GSGUe6n4WkgqhEI/XR24Cr/LCt2MEWPuFliQyeG3dctyJwfyIgyTFtSgf4ufRCMov5rlWXdaJBH1vtoWFBSaQlyR2CY9Ud1zIMovLFu9TO+ltUyd/4/x09wRuZudgqS/xEsD7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1504.namprd12.prod.outlook.com (2603:10b6:301:c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 13:39:30 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 13:39:30 +0000
Date:   Mon, 4 Apr 2022 10:39:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-rc v1 0/3] Fixes for v5.17
Message-ID: <20220404133928.GC2905023@nvidia.com>
References: <cover.1649062436.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649062436.git.leonro@nvidia.com>
X-ClientProxiedBy: YT1PR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 813df13e-40b3-493a-fd05-08da16408b67
X-MS-TrafficTypeDiagnostic: MWHPR12MB1504:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1504F0FEC7FA769FAC23D6FDC2E59@MWHPR12MB1504.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGx6tVUsYqbEIY6DmFcJCLM3nDIIAopVQFpavVoMcpySzDT9HPrUZArN+GrLduzhRAlZ0O9K3fd7unUJcA9bkHLndQhOJSN0Ppe0CdXFpijRbzm72EFEApHVAmiwW4dAD/zQYIuGAuDduWBQlRK9wQpGsTHpANH1EMymDjsgIpWBcIj6nnbFjktXzr1UVr6W7KfwkV33IrNXOnKYUDtv6Ue1OwTmcECL5bAIepsbVJ31QxfBqd0ONERt0kX3z6oGuZq8P2LuU2KxnU2WMztuKpAwK2p6REXni6rW+NtzYYdqzvWENKZG3RMdesOCLTdoE8RIaxWSxXbnFykrmjwMKMfRtm6ItFovYCWb+XVgKnDfD8OWCat07y7AIN+V+LiB4MQ7rhPd9hI1SZqVuea2LzrQHlIAk3MvqErvxPyENtZ3AXUFvlAbCcNpR1UzC+l1Km6Zz0AokNLnrUfnF0j1wkqEnuOYSABjN5LO6YvG5rxv8H2VQg+/r7dP8yatVzf8TC+2T9B3+zA+fMjKcQ9EKT13MyefYmCTAMoA2302u88bnNrWrhPZPWBIUjCBk/HvqRep4yZDuJhuSyj7WFGmfB2nan6yEgPqxVs2ZPjzm7jLUmtXGQoc9DcIxkA5tmyxLRAxhJ78/3vXZaJs9gWDfzMPl0xIH5qjVyfy2spgDH0Nmot8NFoYfzlFxYSw9IT/oLV32T9YbufvVIqx9KHhBLpwz2haSbzKrI8+1MK8Z14=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(966005)(6486002)(36756003)(6506007)(107886003)(2616005)(6916009)(54906003)(86362001)(6512007)(1076003)(2906002)(186003)(316002)(26005)(8936002)(66556008)(83380400001)(66946007)(5660300002)(4744005)(8676002)(4326008)(33656002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kxYf7OUKUrzUzFpYBXk/5Hj6YB1iDvo/PJgWgsCqaX3RSdCC1S207UM7l6X3?=
 =?us-ascii?Q?HgftxHBUhgmdldsApULMCg7Y43F+fLbAJPrT68rmfxHWk9w2hzMUDrMt6hEB?=
 =?us-ascii?Q?waB9KnKlHTl5R+SALDtUDEuBefNSTYbaKryiYZaKYx+8is2m5KKE8f4BahWf?=
 =?us-ascii?Q?MA3lkztxumafRwOLQSQb1sDhy6Ec8SIED8/hj9Tswy7fFEoEB7Dg2Tv2Z9ba?=
 =?us-ascii?Q?yZGP0xNkXlAPezWoZect1uuueSAMWLMqyRqiKHZ5wqxBwIZx2pRXMOSFwmGM?=
 =?us-ascii?Q?QE8pc2aN12KwN3mj79ZdjLW19FbUQgZBa0eISn58yQlM1JTWkQicQs19YOkC?=
 =?us-ascii?Q?ul2pNu0PZzKVNExgJ1QT+AW79PLiDyOd10DKFIMg0n8r6dpWE1B8utOOgsFV?=
 =?us-ascii?Q?v3HT7AqPboTyVrTipGm1enCuRfzS8Dm4t4VQUBL7M5GG5CI4RaUsje0qzZCQ?=
 =?us-ascii?Q?PjWTSAe4ftqbURv63Fkh1ro68d9eBUGCvVarXQjlMZwdClFEUThsd8tHaP1T?=
 =?us-ascii?Q?+ovB71ofnFgJZXN9xz2RoEoAoQ6VN8tmExHsN0YLY5DgG/fJhLOXVOL+rZd/?=
 =?us-ascii?Q?l4VxnPJ0tSY2N6JvDeDfR2IS2hjvukr9kNPBHxxwfXucVmqfX4CrEA0UK0XH?=
 =?us-ascii?Q?lhsn3cAzst3d9PlcIpRSEHx4+YV1cY+wEVw/B1zXhOJMXoX9mwQF+UzI0fVQ?=
 =?us-ascii?Q?cTD4CowoClT3kIA636YRQKxaqcjHfktfsFjbG/obQcSrk2uV2gYsTareJ2bs?=
 =?us-ascii?Q?JmQ9TYMQ08MYDuG8f+T6gca9z7dzCTgFKgeICmBp/3jsMVboJwvPmbGa6+ZQ?=
 =?us-ascii?Q?7bdx/rbM1J+ToKz9vYHwtPafFtwtPFsXk9zC2xcian7YPvBENu7aggIBwQ4C?=
 =?us-ascii?Q?ufOuoNbqO5exNg9jZFZopYvBhi08fx4bJYKXvlJZDsr0L/hrPFCzIegKBSxd?=
 =?us-ascii?Q?24MT9qFN5Niwo4j8We1asWN3nvCm7bE07ZVOIj0U5854qxZ1FA+Q+nZ3KaeS?=
 =?us-ascii?Q?Xv5GZWgYJaSL6lFAhnZ7qt73aNlihoVvqXJcf73KZG+oaCkpPoKxhlgDP//X?=
 =?us-ascii?Q?WNnU+tx/mQhGuXQUoxRTTpuDpGhpS1Key+zQEXqLdrCqLOkz1Ht4BXLRJFUV?=
 =?us-ascii?Q?1WuPxLQtf8+vxL3rd9rC5YV6/Ylq8wFS6WLDsfOTa+92uFqW0D7vs8pI/yae?=
 =?us-ascii?Q?9YUf4uAEVF/0yg2eZEvKMqTRJ87iYLMnF6/c7k42SAyalsu4+Llh4TZJFdm5?=
 =?us-ascii?Q?YgcdrXJ9lWUFr+HfV9OJuS7la3CAfYgD01KW8mF0Q12uqloeQjq/Q4/BT4uV?=
 =?us-ascii?Q?5RM6IGUeNUbHt+lEv6edeEoe2g2Yqj84orRINOQ6B9CGPOYfgckNB4G8ctBu?=
 =?us-ascii?Q?AFz3zhTO5Y5azyfL90q07PgDzx32W9G+Xr4bfWbiM3lZh2UVXHKyC/vjM+mJ?=
 =?us-ascii?Q?kAU7hcBfVyr1kxiASFBDvdoM1YHBYx4qOyceEzXhATOhXXlXYPZePUbL/EUy?=
 =?us-ascii?Q?Q7VEHPyzPy3H2XHGLKnM03/dzq/XnZUNPJfJuk3bRn/LGmaJMpxc1wnUyBNC?=
 =?us-ascii?Q?L2aquFlTFSn7FjfCJGoslmH9PHrvvVQpWpNp27iljsToDuwOV3WtZnuiIb8E?=
 =?us-ascii?Q?hyNFB7Wijj203TObSldR52GpXdaqqvcgQpfWMiZpGV/nkiclgSDfxpnmR3iD?=
 =?us-ascii?Q?LZTC/EfM1UhyK+N0IThNAORpUeYsw6WpmdZvhDRjyG9MCYyNer+YRR4axcid?=
 =?us-ascii?Q?h6Hi6C7l5Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813df13e-40b3-493a-fd05-08da16408b67
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 13:39:30.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLRgEHLpvquL2e+C5gUZHLen1PljTHb1KntovaLWGVbp7ya0fHnKtDmAk7pPoU/f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1504
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 04, 2022 at 11:58:02AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v1:
>  * Fixed rebase error in patch #1
> v0: https://lore.kernel.org/all/cover.1648366974.git.leonro@nvidia.com
> 
> Aharon Landau (2):
>   RDMA/mlx5: Don't remove cache MRs when a delay is needed
>   RDMA/mlx5: Add a missing update of cache->last_add
> 
> Mark Zhang (1):
>   IB/cm: Cancel mad on the DREQ event when the state is MRA_REP_RCVD

Applied to for-rc, thanks

Jason
