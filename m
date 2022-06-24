Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F26255A209
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jun 2022 21:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiFXToj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 15:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFXToh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 15:44:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F78C81D9C;
        Fri, 24 Jun 2022 12:44:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5uRRaHrwMXtaLjy+BPiNIG5NQ1O84n6tM9EdRybkIax4HtfjvQXUCdte2UL1v0lwcaJNscL1SPoQCLVPsd4ULqcTUi4IRfMoGHok3SIazftq8urFwCC+JNllFu1oQUXBuzaZ2wVzSKQjGbjtrlqBEdixTsMoVRzjddOfCcvlTB1N9ma1b+cTGCKgEY847v6OD7e8Qb+0tb6Na6mJlEyndKohPOKQ8MeT7bjSchNbjBtIibyZVBGfv3qA6++U9Ej8sb+180YamAgjyryin/mqx6Kqkd4ztphcpNim8dFVicWeZ8Ybxmem9DW6eF00z4FyxJDxJygAivy1fESrGedGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zV3ur51Vc+kLTHYE1aYT6rm2AgXdxJNEmxnlbOzV6DM=;
 b=aLjP4JCFOIXpsxkBZomZZ1whL3Jh6gH0SFA0Ii12l4kKvRi+9MDT0dab9cHJ3lwH7Kvtxod7nF32W/h7eUtKmlKVK9UjC7SGSFiOqAHuBseT6RcrvBtJZgwWyxrmWaMo+h4shCLZNrFAW7+Gny+8HHYDmK47WdZ7W8v6C7p66+UAPkcEGi8ExAk5vvm/6QzI6Xi3d14Wt9fa9Az2DnHeWONMfiwS/S8zyow8FWLOpWG7J/7emBBWxO3zwIOAKHP1mdhGWGMSoJoDWtiCfXVy0jhiTfUgYDwshNvs/8egKarejfgSgDl4j58UEadrSmbHd8ej4AoeMsf/q1x5Tpx+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zV3ur51Vc+kLTHYE1aYT6rm2AgXdxJNEmxnlbOzV6DM=;
 b=OWfI9ypj1c92VNoXNrKgHfnV3MfGUav6aI3PTMvwxzokRabAhipWJAy6TXUMBVxSLVKjRyhVMAGZaNTYydcnub78KYoqWM5KSuc1BwHvxzdx2cqzWQ9wcu4PIHAqF5DIMnRjpMoih2f/AuihjyqvNMAsC/Qi0l7nqErWuN0yTpeAkmxNn+t0VnmK/a4SOTFSGu/PhQudCjL5DDrRqNGoJ/2y8ImmTM6GgTduaRplLe1WT0+7CulBZJQi/9ktOyyOJFPHIt8Jmbpf7pFg0+cMEOYzcVh+Kjv32bLvj51vLw50TAJ+HDQ00OxThV1QWN2X0xWTKUkQ7cu6etrOKRYQXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3397.namprd12.prod.outlook.com (2603:10b6:a03:db::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Fri, 24 Jun
 2022 19:44:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 19:44:34 +0000
Date:   Fri, 24 Jun 2022 16:44:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/cm: Fix memory leak in ib_cm_insert_listen
Message-ID: <20220624194432.GA281681@nvidia.com>
References: <20220621052546.4821-1-linmq006@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621052546.4821-1-linmq006@gmail.com>
X-ClientProxiedBy: BL1PR13CA0388.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a453cc15-ba7e-49c3-51e5-08da5619f6a3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3397:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LpZysfw1mIGqiNa5sFVcbXUYOcBVCvjjL4/1aSSR5iOCjAkgpLX+sbghEAu1haLPXlQKQ06xeO+v25y+BdeqA8Jkpz0VIXEKvUvW0EB/Pp+jMveU8LT48DX3HtAbBjLWkepRSttMEiKQ/binov+WDuCigesPhESSSCIOzoM+0Ep1+KOMwXytxaj8MbDnG9A7a5lCF72R+lSoJMQOrzmvs+Tcgw9q/3DLNwsUX17LQrw+sqlQYQAhWd5/bQf6WoYdBUFecc2OntEmVZFBqbedWTAm44EditF6QqDSPUX/UgjALxIdNOlIeS+vpvC3IOE3lWNx9uvOQeoeZOWAyjIVXF6rBU/lxDY7aizXIwIORklbCzEEZRF8bmcwpr3IUAYgGHX4iM9goVEePqxYLr7Sc4kw7n6A34X1pJnd/p5u0TeOb4ZO5wvdwhHpNvGwqI5upCoQ+MHCQJu0FQqPOZE6TatY7Hg8TFIGkh5Y65LSsLpH/kp4xTRete3dIiiF/JUtk58Ni98AKWVs2tmn2Ij0fnwEi+d7LYkZnjS+VWRj2hNq/dHcPOQufj7/aQ5bvJeNhrDvdYCvXrLPxZPZs8ZkTd7lQpaV6Q9JYUbyZp+6Lb86XXOCsvKvW8U8jMIJ0qiCYP4ixqO5c9BHDdIYlwN0DPnavgTz4C4DRiElVVxMCQ0NdvQrsixnYot8vbs0H9qVQSIH1uuld5wbTHI8mu1b/yGnx70YxuvVpGCjhav2MasfB7Uj9HEgyFHeQBEMfgACi+OBAmIqUE9Qts5lhR9rf7FxrtxvMd1MzRtVXr2Tad8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(2906002)(54906003)(83380400001)(478600001)(38100700002)(86362001)(5660300002)(8676002)(4744005)(1076003)(8936002)(6512007)(66946007)(2616005)(6486002)(186003)(36756003)(26005)(33656002)(6506007)(66476007)(4326008)(41300700001)(66556008)(6916009)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4+eV5IyC4b6k31bbiIgujoib3qdEZEisP6NbVz/HZdJaLI8GTsxA0DEiFAl5?=
 =?us-ascii?Q?LE9a1+1eqvWN77jqiTnbOI6Ac3ZKCDu9vAVnht6yQiaZIgStsxlFtD9N2TbK?=
 =?us-ascii?Q?D4cKXhuatJgaa512igmddFzgcIewqv+3Tfw1u1FZ+DwnRDq+a6CfuQ3yR1pe?=
 =?us-ascii?Q?WllQjnMyfQEYE/LocfWAcurTbJJvG1rvfVmQBsRaDQ0ULqi8vyelBd7joFRo?=
 =?us-ascii?Q?xFi4MyLMZa2kt5UFa5AWJg7wLgbQ1N/NXyxbEBAgH4hQQniTT+Dqnv4lun4G?=
 =?us-ascii?Q?vGe0XB//lbbh+7Q4g7Bj//JoLvUkh8G8d5L2qtFJCGisgiyyKEgqJVMPILqU?=
 =?us-ascii?Q?8HMrpffBbBGKedOxCdgkfgSTrMbn4ikEqEY3N0r2bD/7WcgExatA83set3kG?=
 =?us-ascii?Q?d/pK750OB1yPeoUKhYITw1WR2fe2YrUiNAAT3T19xU7ypZMVNwwPyeUry+I4?=
 =?us-ascii?Q?tp2lICDHEjErxqd1vBC65vDqRAlEnXz3JdHG5J67a+fXKa1Q1I9QK4KgM0BE?=
 =?us-ascii?Q?NUC7ndeGntWzY2AJDBYilA61qZO3hORcZos8+EpuDGTzHoMp/fsgIkuj4Nrb?=
 =?us-ascii?Q?2V44/0WsKpz1dGWkSNa4Gcf15JcctseLAnDha3uRRof2RlBzUxbWaZIBWIMV?=
 =?us-ascii?Q?CaWzKFjRfhUiBCJ6JKFSqazGms5PLToES7TIcNCs7BWgF+4ii7T6mE26del4?=
 =?us-ascii?Q?BgVOUNyQH/cl8s/Mq/+44Yf1CWN8Gyyr6IMmr/hFm9z0QzZpWpBAXKR+za0I?=
 =?us-ascii?Q?9qkcsnzpZ/2M089Nd+wlYjqKiOdh8ARo1dmAS7QADH6r5J6Wcz/yJJByHJUe?=
 =?us-ascii?Q?kc9DOPSFykrsgTSFGxXEN+vX+cqFl67yYQ5MTs/XZYh+/IqWOHZURKIOvIql?=
 =?us-ascii?Q?d1um3y+Pop4dnQfqpGbIjtj5O6UAuRYf5AX9wg99EtS/VmVulKFpNY1M1PHI?=
 =?us-ascii?Q?uIIqjPsp1R7sSa7hfwJtpFxIWSI2eGWvU4i9wHQlAYYljkc6+gRpLe0aNJ9n?=
 =?us-ascii?Q?RXkxg16NmzKmKJc3yP8ahGL0NEL3FzUbCYu0rIJAYbsTR5TqhiJfjrrCHn/k?=
 =?us-ascii?Q?+PARPz20lsoF71mQz/JzUXT2JbxeAu6aRI5unDVaU6m5U70tKKP5v0JwsqIP?=
 =?us-ascii?Q?VRpxRbxRUztcVoYI4il43oUYFRDAxK6hKS9DTg4Q3Jhrvmn2K+W6cjPj5EvE?=
 =?us-ascii?Q?8UJ4FOqzagh71R9zf3SdSCYKHiZm0LW0fQE9+xCru8xrppj/jcznrAEvdS5S?=
 =?us-ascii?Q?p/HbbBDX1OK2F2moVFBbooD05wB8wbcg9lU4Ik+y69vbJPZV089byibKSXeI?=
 =?us-ascii?Q?ATu9PWWc1Z8IGILZp060dltzvg63PogEilgz1Eug3gNTFOfkYr4Bmk3DaVnb?=
 =?us-ascii?Q?ex/0LqQjF7BiBMjTK+9CPTAf8nb6RwkGxVebuot7Wi7Wh2XyTa3SaaUZ1yWF?=
 =?us-ascii?Q?NVk3e1LHj5a8lWIdKCMwCl+hethOOGeQrh4PiB34p6xTGYDf6izEuYF/U03Y?=
 =?us-ascii?Q?seY3dAMjNa+bCmnrF8MxYG8cXWIgu0qoxzF4DvqXrVhu8xZ23XZjUzvhbu+s?=
 =?us-ascii?Q?pVKSa1eMfoGnk3BVzwIacULNvhhh9P5GEX8HZNOD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a453cc15-ba7e-49c3-51e5-08da5619f6a3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 19:44:33.9822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewdhw+h3q6S1gQ21h7x7Elpd9waKFNNrPdbBw0BQFgCXBlfee/Fmcd4x5TohqwGj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3397
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 21, 2022 at 09:25:44AM +0400, Miaoqian Lin wrote:
> cm_alloc_id_priv() allocates resource for cm_id_priv.
> when cm_init_listen() fails, it doesn't free it,
> leading to memory leak. call ib_destroy_cm_id() to fix this.
> 
> Fixes: 98f67156a80f ("RDMA/cm: Simplify establishing a listen cm_id")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/infiniband/core/cm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
