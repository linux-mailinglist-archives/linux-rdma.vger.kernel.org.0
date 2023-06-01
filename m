Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB6371F0A6
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 19:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjFARW6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 13:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjFARW5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 13:22:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56254B3;
        Thu,  1 Jun 2023 10:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiQRsuOpb0VaqU2KaCjbq3A+QrBRKLfeJ95Yi4MfB5lVRO7zNytmgnvM5jRabcZFB7b+DtmRujXL90r0RPQ3yFsPSkF1WSc5mS/UAUXuHb54UJCr2INypjlvyLwkDkXaTVYWY7hiU4/QbOcczyay5f3ogsadQA9wku/Q6f5AalQrCdaLFNGcu/S7cMF0gYMAeI6jgS5lzLO1IAxNVY6MIv8kDykDmSd+N4vvO1ps7hiyVA612a6435QhdSE+zr/3/WaodmGVXWCxlLe1o90iAhVN/uHu5zI1DbYUXxTSKPLxCmcD2KEZUW+S1KaxCZSXRwTxnZZFJG9n9lWRLglVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUB2asxiM+O5EI2riv8YhrtM2Q5xMMvSs9u0HmvuWFo=;
 b=QWJwk4R1ZgpSKvfLE/nvRhcYNcwcrWOuBKesn4jnPRmTQIqd/46u3myIWuVjD5ePPomcb9FZnhg6o4NB/muVPAfQhwKhOzm1/yPj29P4WlfLpz7i5Ec6ACl2bPCiR1ZgRfvHb99SsUqpwd6d5HElaWVlETBRl66138IyBE9eCyiBxjH1B4svKbkFkdcAC+UiMAckzifSvG2iTgXYai/G6NIOSHQb7UF8UbzkUM5K2lUo+afYWtycwFeG8AoPIUZI/59qOUwKxHZ5vYFT1M/LY0BD2LbkfQObeNRPFCE4KZtgXBD7KPo9RPLVFmlZa2qbvw5ovaWmwX5axlta+AKgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUB2asxiM+O5EI2riv8YhrtM2Q5xMMvSs9u0HmvuWFo=;
 b=ugQsiKLLHJYJwLG97UtwKHpFgMQRy2k+WgubSj1VfEpP+A//wHJJCE58Y4acy9STZPPRywubNF8+UrwGDmsw/IiNgB8LDRVH+M9la/UH0e0xFP4mZuXYdTrrAHJ/XVzDp/ZlBwVODcud3FCThgifgzHx+Kzm8Gs7+Dw7RpgawRnaUVrZpDCygaNj8+YCG/YN0xHmF4sEf5OnmvJDVpdB2F/17EPbbX+FaypuzkGxfdgg0qzSVPDNEqznzQENsLl92EaEBMfZnWW98T7EkJE9wseUnUNXf/bO3D5ny67bUmsmgsLlOSdl0pZJ5P8uyUbbZ9kNu0+7tsyqvm0O2if5MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 17:22:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 17:22:54 +0000
Date:   Thu, 1 Jun 2023 14:22:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        linux-rdma@vger.kernel.org, leon@kernel.org,
        guoqing.jiang@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next v3 0/3] RDMA/rtrs: bugfix and cleanups
Message-ID: <ZHjT64eBLGDW9lvr@nvidia.com>
References: <1682384563-2-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682384563-2-1-git-send-email-lizhijian@fujitsu.com>
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9923df-b6bd-417a-a57a-08db62c4d571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: URSmhrBBrhi0N+RTGRvLtNnOVui/OGIsH7/Z0hi7cjJ0agkWLrAOzvc3nphbB7l/Ce/U15engvN1qtKvf6DZfsPZh1VAEum71ixjcnrJcop79T+tUp+t4DxyYu5bCje5YP5bc/BDJRcvC8ou3I8rH3/EQMqGtIKzKGFgACW5ZusvAw2qesVHoo3kn1t43to9nfs2aYl3x9Pd7Z2R9KkZhWuQDPVqpgWPZAOxCrqf6/igDdqEt858RRgVzr3ZLL6BnD197L8Vm3e6DZST9l9U9enKmrIyZWKSltJ61fxKiFXctfeDHstAJUjPkaBhttxQg/WbJt7peq3k+ezgDkXd/AjC+KSH66c51LdDnDKacEsFGWYX5HbDGnUA7B789M4nNzr7WZYl31iLfp0DCAKd/g4RWglHjdks0JWEsTQwS3me+/U/26RJgFnUh6E/J3WMgHIB1PNoi9AP1+aei/AqK/5Q0HgrCAukJLSVNz9ocHJrp3rbhVxUgUaybSOhwkHaqdk677M7A0mpcSwzHD3tt3ppDBtb/Cqr7bKVPyqUtk54rrgoxi2eU0AGDQ+y/ybXOd3Pr6Oodu4X/XyeBB4iK3sV9n2wTgKVe18/0Hzbw1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(86362001)(38100700002)(83380400001)(2616005)(66476007)(66556008)(478600001)(66946007)(4326008)(6916009)(66899021)(2906002)(6666004)(6506007)(6486002)(26005)(186003)(316002)(6512007)(36756003)(41300700001)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OSc6uWlNVKhBdAmGdozs7e8xNbQgDGJ3iJXqvkfWebgKC46zmnoZDETjRyKM?=
 =?us-ascii?Q?u2NaQeEwAkrlABp5x9N2ytEi4p7cUYP5A/aPjEVlyzVgWFtI9bmex6E1tISa?=
 =?us-ascii?Q?em/CBZxs4mWd6PTJLBC+9903jmyEY8/+2RGeemE46Twq0RTYDqTHWSD5tydz?=
 =?us-ascii?Q?4XTDmJvnIbSr8tPuu60FSCivFm5m2d+sSUJ1spkODw/5beVfwW1yJZd/Nghm?=
 =?us-ascii?Q?kbuy6e0GBIKWYeoDNCG+SYf56MhWcRSiUSDFbpeGwbQGP/+w2ouFam4XzveQ?=
 =?us-ascii?Q?N1hWzQeQRDzARUFTzSbNUme1tYGwETQhaHdtdLge2l07ObHmuwEjQDMWgGa5?=
 =?us-ascii?Q?MNR6R94XiZlCiW/EWBuNhYlhKCyfdidGK6k2/qE4DFO+fLGkFoaqsgZm1tK0?=
 =?us-ascii?Q?Kv1zt1NcEhZQAJ52zI89g5AFrellWfrVNLx1Pb3HkSkmdFqgjlwxNLuDYVAL?=
 =?us-ascii?Q?oIKQQO0x0OXH3dU5ekyaoJmu00jv/RIQ7R+gPmS84TididEmWjKkNc3EDrtq?=
 =?us-ascii?Q?jIprDJF6+CcLL9G/BvGxpFT1PZQ6+xEay0YuvfpqJ1Yx6iFf23s0ATNb/AE7?=
 =?us-ascii?Q?JlCKWoLQMaB5cSt5PB3EpGtmLIELbBAvDVxvefGpGetc6gilpJoDYp2cKNq4?=
 =?us-ascii?Q?o0y+1CQqnJmB6EEzeYMqxuxvHLLPtf7vAfW3o7mGrszGnjn3MtOgvjGQp+My?=
 =?us-ascii?Q?b8DKLsJUSSZ7Ic8SHk7HDVxF0jmiMYeVc/MPFR62DwZsM3e4gg+rI9WtCxXF?=
 =?us-ascii?Q?S+tLr1Icj3mdEB4vWYsSso8OsDN1tqJyzZxqVFE0u02DHO+F3ALJjSp34d93?=
 =?us-ascii?Q?ZwLHIr0/FfXqQFG9cHqDtiIwvaSE/+j4l1isEfAE5ve6FDFNLG97WXRtY97e?=
 =?us-ascii?Q?mMr+5diO2WjMfIw0NApNNYaKuEal3d3u2eqE82Dr+z8ezmzWMrpX0PRL+Ipp?=
 =?us-ascii?Q?dxRBdvUOmocGiZOZsNawOdctSX6I5Nu5ZJcejfuk+Dbd9BOPJcFB75vJGoKq?=
 =?us-ascii?Q?emABMcmR/OLgMg2BrCLwASuLeiitXKuFhsyeRxbVBGdjZhvoEjSV2YRgmye+?=
 =?us-ascii?Q?ME0+/f9yiVYEBeHoKxEsq0hiFXPAVKe7Yeyvb6hMc9bMJ5ck9WffRad7Esx9?=
 =?us-ascii?Q?EEFL4QJ68Eyvb4VjqZrG864SmHdwLpKMmn8SRZeCYHjeRIwxiq0lCVVSFi6y?=
 =?us-ascii?Q?Sgs0zZcjM1QbA2wxzoLjTsjdUvkJHYLDEf/R+P5L4N34JBpmOLzFTE4EaQ4D?=
 =?us-ascii?Q?NSiC7rEMPJQ59QoPVY++IkCMWgSv4gqlFS39MUfuB+lXc5TmiDmpwIRpf/pn?=
 =?us-ascii?Q?FEC+g5x6OqV7yG7UmsZbED3HU5+WZBnGQXz+UNOZ6BtqQ6Nu4+sglsTZQ7+i?=
 =?us-ascii?Q?ugOV8B7ntod4fGcjeqw7bzo/MlEJHSbiculy1ewP79dEVJgcIgQtOC04gtlj?=
 =?us-ascii?Q?Sc8aILKKgOOXeNLcHve8sI+w1uGLfnzzu+2bDPddV0vG+qx44fPuZbVmPQY8?=
 =?us-ascii?Q?tjL4RJd3UPKlEUO+L2o66SOrpMr8zbhtvGzTIMOlJX3PX9y8qET7qXUK3vFv?=
 =?us-ascii?Q?Lu8Lb6HJ6HiYq9XHFoUX6f5op9O2TsF0E7tGAzsM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9923df-b6bd-417a-a57a-08db62c4d571
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:22:54.0623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hm2t02EnoJC68bxOfiCc0pn6s9cir+O0pNnVx9LE2J5xkGFFF7ENjP11B3f4vaz2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 25, 2023 at 01:02:40AM +0000, Li Zhijian wrote:
> V3:
>  - minor comments fixes and add tags
> 
> V2:
> - Add new patch2 to fix a memory leak
> - rewrite original patch2 to patch3 by refactoring the cleanup path instead of
>   introducing a new flag
> - Drop original patch3: RDMA/rtrs: Fix use-after-free in rtrs_clt_rdma_cm_handler
>   The problem it tried to addressing doesn't appear after the new patch3
>   where it adjust the cleanup order
> 
> It's trying to fix 1 issue triggered by the following script which
> connect/disconnect rnbd frequently.
> 
> # cat rnbd-self.sh 
> #!/bin/bash
> 
> /root/rpma/tools/config_softroce.sh eth0
> modprobe rnbd_server
> modprobe rnbd_client
> 
> while true;
> do
>         echo "sessname=xyz path=ip:<server-ip> device_path=/dev/nvme0n1" > /sys/devices/virtual/rnbd-client/ctl/map_device
>         for i in /sys/block/rnbd*/rnbd/unmap_device
>         do
>                 echo "normal" > $i
>         done
> done
> 
> Li Zhijian (3):
>   RDMA/rtrs: remove duplicate cq_num assignment

I took this to for-next

>   RDMA/rtrs: Fix the last iu->buf leak in err path
>   RDMA/rtrs: Fix rxe_dealloc_pd warning

And these to for-rc

Thanks,
Jason
