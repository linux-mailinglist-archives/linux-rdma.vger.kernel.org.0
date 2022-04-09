Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664874FAB10
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Apr 2022 00:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiDIWgS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Apr 2022 18:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiDIWgR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 9 Apr 2022 18:36:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B300C24
        for <linux-rdma@vger.kernel.org>; Sat,  9 Apr 2022 15:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey1lCwNchTAJSQWQCdWHpUwOKlj28GHqWrltxG+rh7O2mJueBswEhKb4B5ZFkCt9qfyZYnR6bORwN4605N5oltI9TR0j1EwvgLYPqIB8CT6PHQlivaQZTk/TXtOTzd7C+zjkzAep/H5nKhzxTtmobAyb+ZJ7sl5lPVgPEgXBOYid5ySd6DVT+ccibS6V5FYsPfoEVzjRxHNQyh6S0MSwx0YkV6vQQ6YCB1sLQOcq40usCyOOOHcVakXKIdR0mpXCT04YuvoUjQsL9Z+jUkID3Mv/+R974084NrqmhErnKA862Y15GZeuYeDHo4bypfDFoiy8Qg00sxTJOJNaX0j9Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzevz+1Q9+j2NAGlMWBLwkFyVzDVyxMdUaEft1IQmZA=;
 b=Qrcoo7ocJ4HIYfEtQDnHcqP6zQepLhU5TJRHzuPhRJp1qrJ+PN5zCUK+v1gEZm8S/VT0hxn+/WAMxLh1zqCRbPhWOaL3xYf1sxFfHG6uQW9GPrKpXtcuHQjWtHFugDA01V8LWMfiGU4yqB9XDS5zKXLdXcdOGxOMiSKDcUM2cJbZsAgP/jpBX/Uajre997hstcpA5TT2Mt4zxwe7vrSFZ+1ywBX9ksqJkj3T5nQic1BISt4LrguVFb3nuMGcF52Y7uu0D5TI531rgXzTE887zKXyirXt5DKWch+J+JCa4aL7QETKhy5+2P6mcYYEvmkN6g8F+MWnxIXo7gHBxAgmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzevz+1Q9+j2NAGlMWBLwkFyVzDVyxMdUaEft1IQmZA=;
 b=lAoMeNQbmF8aZV+GKNOa7YM9jnLA9XL/yZv8JVyM9YEddPYD0udqBOkpmZRh2CJGIDz8BEbwK/CeV+X7WogS+X/w4Q82niWvSt4wqbiLoOas8XX3PIeHD99IBX+aDAqZGC5K9xfTkQt9ofazp4sH7HfnjJrT2YJaocQW6RRXP/ixSHm5cVNbO6jFO3rNdC2LPsM+rQ+dUJtH13DT6DEwhK9GT3DUNHy0oSTs5SjeaqF5I7CGKq11YyKUp/cAfDR0VLFfvLYdcgMHCAB5qc2yhSqAWYivn6nfu5HpepqzqgSdv9VUwWskg0rO4YoH1kVwmaNp0UB3N7KVeqildCqDfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Sat, 9 Apr
 2022 22:34:07 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.028; Sat, 9 Apr 2022
 22:34:07 +0000
Date:   Sat, 9 Apr 2022 19:34:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Fix the missing device capability
 flag on the virtual function
Message-ID: <20220409223405.GC2120790@nvidia.com>
References: <20220409083523.12097-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409083523.12097-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: MN2PR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:208:e8::39) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5ff2f76-06f4-47f7-3fd2-08da1a790f1f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4137:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB413702D9A73EE3A720AA8EA5C2E89@DM6PR12MB4137.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsIAw2RmYM+lHt/zBmPnlt9iMaF8kPHeSnUITtCOdemHoip075M62/qRhZQl86JGSJ9gd/hcLMGGX1Z4iC326Pg17xx2S/nm7WIJ9ZsGi1DAbFgpKPJPvP/v71yl7lQISQyggjNmPEUODJrSpiYp7/8ZyO0/RyJT/M1F6+OTQ8Ki6WSM1TRlgNVa7Bxn63Q0vIe0CCD8jAq7aGZNrypYJLBYtyo1/mJDKKkwQMxGhyqJpiyxjDuloD8rTlwf26elKbb9/75Ng2MVQsvQnD3pBPen8jtQGGvE19Bv4WtNracYM+c7B4bvTw6miynzMNK8Ci5aE6cHiWJVQ6xKsECVQM5Xw7iVKDSuwk39gRMjWcJYuq/Z0NByyBZZNDsqq7HgpMFBTnk0JaP1n+yy14kwevGXWHUu4wg5rQw/+6c7Y6OXAPIBrC+qbcngqU+tkNOPMV98bHq6xsu7lVZnkpm1QbgDe0kp2a/Vw7jGCXQXknhd34RQA5ajRbhsIcKnQrTsKzSqEPAnXW7ilFtzEWccIzfh69+lYtPjqq9DTRRuBx1IO7JQvm4i6BHROeMAjlUfcMPPSWt42znYeiRDt+jn8kKwb0QycnJ6LEA0fOzxxk0nP0VdX4pfESlTawlDrt07FuAl5491KYl9ZB94KKyjow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(4744005)(5660300002)(6486002)(86362001)(8936002)(38100700002)(2906002)(6916009)(1076003)(2616005)(4326008)(186003)(26005)(8676002)(66476007)(508600001)(66556008)(66946007)(6506007)(6512007)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lt5fGmz/VDu6lPjN6VW+PwkCMxTiv8afYlZO1nnXjnwlYVh/r6oCFPKyBkK9?=
 =?us-ascii?Q?IhG2DIHhQCFc3qcUnhRKSZ7uklb/0qYfNROXA69ydTzAgZ8tlftA0it1VZgJ?=
 =?us-ascii?Q?Bj1Z2VCqVpU4z6XE5aaChi0TjoXnXt6TdDMmQLO7bvgJcAXDqAPsLrf3ENr6?=
 =?us-ascii?Q?dbTuguJtRkb0Rus5lsCaSyM7p5HQ65lquTzb9RY7IvjRJzpjkPLUM70ZJoTg?=
 =?us-ascii?Q?EgQwYCHp0jlg+WJat4V7qofKGCbV1Z4Bm7wTTO/agbeJeZ5Naz0+TTgH2CmB?=
 =?us-ascii?Q?sHzoMOW7wca8Qa9jdFP365lWtatI8ZqN/W7p6CtqSySKkCrRiMzdwg8x34D2?=
 =?us-ascii?Q?ZRNWLVrmSGBQ+IdxhTpO3yPLrtog+f9dvE1ZF+HxgQkwXF419QE8wIXp/OD2?=
 =?us-ascii?Q?Zt1mSxGEneQQGdMA1GdShkkF8/nKKuyLYwwbhfciFFlZEaeiv/azceAb95Ck?=
 =?us-ascii?Q?t7Uvc/n2CYOH0qo4pU8igCXJppq0jSWTYC+DhBZ3pylgRfluj12FOGppPs8T?=
 =?us-ascii?Q?Fcw7P6oGx4UqjMsOLr5Ypl2nySKZIYe5/8vPlpc+l1eIjz/mnCxhV8e4AU5a?=
 =?us-ascii?Q?lynztFkaP36Aaw9v3kYROZGzeSRv7sakpVceBSDOQ/zUsdgZiKcpf1nJWEXh?=
 =?us-ascii?Q?elD1srobwjwb9idV4/MdED8NMLctDnvcYZxvZKtltXbW6sZS8YX8AUbBOxHP?=
 =?us-ascii?Q?hcz/FNzuppabStpjhzNXPX+Z8ZY2ej4Xdc09v5/BpxAvMv93eMuQyyYo8rhi?=
 =?us-ascii?Q?sRw2thaQ9S59ZLoYzjFBXfjscXDkUEQslkN8sJlvBx7eo5XGzF3NvOY43z9t?=
 =?us-ascii?Q?mUsxN/+LmZB801YUFWMvWsAhZltz/HIpkp6UVnM4HzdqN1jwc6qpaWvjLFB3?=
 =?us-ascii?Q?cmbCglvjTnJEyrZKNnUHIDbyOugxBMMTStuF+tSNksmgR1hfdo8DGEncjAwc?=
 =?us-ascii?Q?QbQzmhwWZ1f3tIS1TQAO4D9AVJJf0VrHs5O5hcLb86Pbgryq3TMbJItqOn9m?=
 =?us-ascii?Q?N+mAjTICsQaAWfZ6jMKCS8F3yz/81DU/FJjtNJRWU0u7S3PS4CBImMRbE5xn?=
 =?us-ascii?Q?Ri0UXMmWYiwxcNLDyKxvqn50FrizpoFgH2P7jd9cGrSNSl9Fzo9KQJM6Rnrv?=
 =?us-ascii?Q?IohfW/xW4feTxgSywz3Z/n5lII85P+GVSAIirDruMF/B9WC/f+ZTv6uVOmTm?=
 =?us-ascii?Q?3OPARMzW+AEqXLyn1GQYfkadzifU2p+5eLuWYIA+ZkFzOpPAqk2deFVCfqvb?=
 =?us-ascii?Q?HH5SjOUV8FnjN1wqZAdGOfy6c1SuWvoTyA2bOvhIMDK+/ytQeFMnlH6JSF2t?=
 =?us-ascii?Q?qCGZbNqXSzYwQwwlspChpj5nxHdtz9yuq21ssgmj84uP1sjqDS/abnLPnOe8?=
 =?us-ascii?Q?tYW/vHT/5hedBJNM8STLQGMradRjG2xu2wePwASAt/5JUXfMeDhmBuLZCXPN?=
 =?us-ascii?Q?sJ59Rhr9vKLUjTPFD2ATN77I8ZAxTNQEa+ho5GhvXal0POAi/yZLI/S0brig?=
 =?us-ascii?Q?ySi0jwzzmantg1CdFJ4J6r4Cq+YCISb1CGdqpYPacjdkO0Yl5E8AshOQJDJw?=
 =?us-ascii?Q?BwgB3lFEAYzMoMbk0S/1eU0gPwWXlhftm5WRileRamb8Y1zgYfytTqr289Bz?=
 =?us-ascii?Q?VASGow8rAA1UzHKP7Be9bJKGNsUiigxoJ5HOj9NvPWcQ0kFTZJ7eNL2GQeLH?=
 =?us-ascii?Q?FlWc5NHmpgTWdC81Zuyv/wc7vTmYkgGC5S9eGAIhwmDqP3W8Aspuo1lwrlfl?=
 =?us-ascii?Q?sGm1KXI71A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ff2f76-06f4-47f7-3fd2-08da1a790f1f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2022 22:34:07.4355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h612RRzlO6pstkvKCJRahkTtVSdlfy0doRhygHakklfR6L+7hAIHYLGI+V/N6/1C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Apr 09, 2022 at 04:35:23PM +0800, Wenpeng Liang wrote:
> If the device is a virtual function, the corresponding device capability
> flag should be set when querying the device.
> 
> Fixes: 0b567cde9d7a ("RDMA/hns: Enable RoCE on virtual functions")
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_main.c | 3 +++
>  1 file changed, 3 insertions(+)

No, this is only set if the device implements the _vf_ ops and uses
ipoib

roce devices never run ipoib

Jason
