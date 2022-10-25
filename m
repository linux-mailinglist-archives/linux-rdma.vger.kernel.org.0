Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1962A60D132
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 18:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiJYQAK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 12:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJYQAJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 12:00:09 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8400913C3F5
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 09:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np5KiZic4nbXnfYZPS5vGLRnEv9GeHKGoJcrChNJkXW/ooMljA1Gh2FkkUAywLcEnlc+i47nlDdonELPDIcZ4yewGZRmD7+VkZLEqRpRIHQBZLSeduRtRZ7ZZMS/ePP7fSsESqtVkwn7UvYCPOhelw6ZhpunnEgLvttEvV+HlryeXJG3YCnf+e3o1AsGFmqJOnIhTmqRCEbBRunAqU/TsFtRGJ0cCEXtndqPxesH3G7Av5BcsA31hrj0Hy82eGABgNIlqkg+FfjIMLLlp+DKF7goH9g2VPxIUoHd1NfVi3rewyzZYBDW/fX6vr5tOyYKL6NBFuNmVITYnzSxduVy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxc6HX6XM52PELM9RVzreKaxTau8Uuq1GDHyjCGHXL0=;
 b=Mn44N7LjybcZ7RX3wO3zn3gCjZSAdV3XTQRGH7SpT01py0esSydmQEVdD56c9l6MThdo0ndCvyV5GuA5crh1+HjNu0mZOzsls/KbO68YJWMBpM6jKQQWijMhEMlE5cW+XiSLIv612DefO71A8Eutz66LwvgXRrYhSzmUl4M6UC5MoX9iv6GZxkRrakOGgeSvDhdRIaiuaDaqHbVrZGQc7OvAvQkDs+1Wm3UTJTZ2NyNuvtRsQ65fgHm2e+yReT/wN7pCz/i8QGBVbHDJJShw2fSIHvn7K77o9p0A3mcbCvEMZQZ5Hewb8Fapwj+dweWaLAfMZn8nlx/wUxO2OUS8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxc6HX6XM52PELM9RVzreKaxTau8Uuq1GDHyjCGHXL0=;
 b=IN7tKNjTSgd3rK9VnVnUzadMZ8FU8OD/cs5WIoNdrZ+zv113QqkELAOaAKtVr9NRioJH9JIY++xyWa7+qhsdO0hKJK/5VHW1hSo/QNG5oaJ13+Kr683+qqBa6KyYrk0kSqxH+Fdc/3RjZfL4ymL8HDooC6NDLaG3+ps93+fNy5VA8wVtDgJCKYrApZEZyG9QnLAUEjm67an5H320OChQ9a983b4ltmNl2xmEyAxCBdOpG4TdbPPz0zZydJeDWT8KTk4sIEyw6X4mhozP6ZHP/bI07xWcK5WFSlH6SRMJ1v+/1hEARoDPLVlfXpO8wZIiB0K14NfcBjW0oE5hlI7ADw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 16:00:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 16:00:04 +0000
Date:   Tue, 25 Oct 2022 13:00:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] RDMA/core: Remove rcu attr for
 uverbs_api_ioctl_method.handler
Message-ID: <Y1gIAnr5jFRn74c8@nvidia.com>
References: <20221025152420.198036-1-yhs@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025152420.198036-1-yhs@fb.com>
X-ClientProxiedBy: BL1P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f619e4f-ce8e-42bc-ea1b-08dab6a1fac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KE6DWUs6B4ZYNHUCpbPQjsaFiVeDOCiJ1MPAR3dgcRUwGbfvDq83xFNgYVfev8/uDk9PMUcQAMxkt+Oqe50Rtapy5Setf/UUp7ZtzIDxjF3z4F74lPnw1dWgS51KyTe1bHE3Qw7eIQDhuVYJGI+CsV1ayQzZIJu0un6R5wRho7/ODUJJpkLaG7BlO5/VlPk029WhgPIsvP7ocBmCKTDN+5Zom6NWtNaks2+fhru0Jh/XWdWNy5JgOHkNfEg4SOtnME/eQZxxsDpK1bqVYiQdXqECdJmUctMIF9zlB9Am+2bc9/MJtqO4teRPeTQ4lKdX1gnUVrY0K7QaPEUco4jg9Gd0L4iPIs7kCRSf4oJmGGHp8t3VMNhlwBh06GxqnEcK2tzRhSYo82bd6jp78josXkCRlkWPCFApWmsTnVIzJ8d2Qs7tTf564C3dPR18bs7uHNHd0uBlrUmK6o86zgMjWJiM0cRhgeYX7HUesyyPMfAQEoab87/ffDUcDTVH6Orx4limPec1v5lOatgDrsP1DhLr8U4G6yk1JCYDgFlD3z9VvZtzqa9K4wym7ZoUtQTqxAXoPJ1BC4IvNmZZDoE+i+jznUPNGFLXtdihTDWeTxYY3I/BPabACSSwyIYsW9Xt7NRcco/bbZ5r59Lxf5ti8X7BMV60kMsySsg0AGSzbnRGctHRl6au0KDv6BFr0DT5jXSgut2gzGXzS7WdkzoCWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199015)(86362001)(36756003)(38100700002)(186003)(2906002)(4744005)(2616005)(26005)(6506007)(6512007)(316002)(6486002)(66556008)(478600001)(54906003)(6916009)(66946007)(8936002)(41300700001)(8676002)(4326008)(66476007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aLnyyehogKX6JqO7zHqjp5E0gAzOmzMBwdZaVSrG2kD7rU7oqaz5Xw95gVPG?=
 =?us-ascii?Q?KU45u1Q6LiOtWsEq6/pCgUcXv8HymDJvOszR58wZAIqWDtqpvv/EQeELgZ8L?=
 =?us-ascii?Q?aYIjzW7gZ8JPtrZfibndoA0lrLTM7rHP0Te8tfVd/I1fIctHXQ1TqUBZbzuN?=
 =?us-ascii?Q?VN3cBWnX+RRdt5LOv48PdNLFG4Mg+Yo1yISoj+aaElYOpMic/056m//F4mcY?=
 =?us-ascii?Q?1a8iWcx3H51f6uwmu0K2auVtHkOl2WnJTizpKBrAIPavay7yWJmpy0q1/zXi?=
 =?us-ascii?Q?javXEQTVAcdb7IaeCE6sc/GYC5PNjRjJ1bAHUMIQLl8UgyA6dcGdfgYEntfx?=
 =?us-ascii?Q?yrw7+dTFeJ8GI4FSpchx2UgKPJKe+OkEmmv0MM3o9YRv5t34kaizoAekQCVl?=
 =?us-ascii?Q?VjiJ1FYFdtC8ARuTPeYxzB046eIH8W19wQu79GHqZaiF++mZN7y1XpvDTrVp?=
 =?us-ascii?Q?CDDmS6QNhgLjWdOp2XSEvU+MuMENz5KzyB54BTjczCRwB0CZr7Ig6tglWD58?=
 =?us-ascii?Q?bflSy932sBa3X0rKLf8JNUOH16GB44pEdIAfIVT03Zlebt919/98yOavJTQT?=
 =?us-ascii?Q?2yjFNTCAkRtp8CTAGDIv9wecTfCL1t5AfI9f+bp4o5ZcdnvAE/zpJQzorWK0?=
 =?us-ascii?Q?PAJA4slkT/s5YcNM63f2Mhn4KJ42aVArLTViZu+WB1esZtR23Ps3eReS5rY/?=
 =?us-ascii?Q?53zU559HAkAekw55kPwA9vpMQHH/An9cHVUR/KAM7QiXVh3nkPMzm6MX0QJk?=
 =?us-ascii?Q?XQCeJUywGuWxHkzO928GA9ybnkFyY4PW/vAWdrbHVTdGQrzHGorpW3eiKJsF?=
 =?us-ascii?Q?bgnRBZBbFW5uCv3Jdk05cb6958WvPR5nhAiABp+kxmDYbHLIq0sipYq/5m11?=
 =?us-ascii?Q?/07JwBleauWZlwcuhqi2bxlqGE2FoU8t1bLZpekZf2CDHOU5mGUFmpLN1LSy?=
 =?us-ascii?Q?1C5DQN3WnWIJEUrFTzMZuAa1JP5yvOo07xc6lQ32uZDdw7ciNj9TMiD3UTgm?=
 =?us-ascii?Q?SIIJtfUIYzzgo3MEnXUSsZ4QlMVI2LqjzryY5DZk2yS63shul+br0bg/L/Ng?=
 =?us-ascii?Q?c/tFh0jOj1mBlwcP2c3PG1gHt58F2Ct52Z+D1CVN2RVgVjBWlHkyoMgjTz0K?=
 =?us-ascii?Q?qDzbp9qwGPuOP7zfxlLs5zuOjRz/BB+xh9x51tYxwi1YYBJL/HSMQMbSElaM?=
 =?us-ascii?Q?0yo2Ul0kdEtbhh5Q8c7DqH9OjSXuL9Dc5UVCNDj3M7rA7pUT9GfZhp8tF0ZI?=
 =?us-ascii?Q?VMpOInmy/f+Fvj5v1y6KGJjC4RUoZmGRR3aXCFYrJoHP3G628Z/qO3r6wBpv?=
 =?us-ascii?Q?Z+zHs6f3BtRouj7UEFBLwMFfo7BHY5t5A7tG/GVYnlxOOVCYwP/4HWNXyBRV?=
 =?us-ascii?Q?PuB8zd5Jph6njOz6HrwoPS7ZhTu2/MLxQ7j2TbdaiWA3FC+UjqFM/L8ZIAg4?=
 =?us-ascii?Q?wsrQ1S9gj9IcaBpQewnWROYgKthbqGmhJtooGpvPND/PWpoooEpbqKuPKC55?=
 =?us-ascii?Q?rUv0QQAPdKOI0lnImsv6o2Z1imttwt9spHMDysctFx3fc/wQQzPTZpVj5yVA?=
 =?us-ascii?Q?XuUFWb4FmCRfEn+yj3w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f619e4f-ce8e-42bc-ea1b-08dab6a1fac5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 16:00:04.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qpk0GsTQcuE2d85w74xYYQ+yHA8DW2TK2VjpDODE2matnkA13VKTogpa70RkJIw+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 25, 2022 at 08:24:20AM -0700, Yonghong Song wrote:
> The current uverbs_api_ioctl_method definition:
>   struct uverbs_api_ioctl_method {
>         int(__rcu *handler)(struct uverbs_attr_bundle *attrs);
>         DECLARE_BITMAP(attr_mandatory, UVERBS_API_ATTR_BKEY_LEN);
>         ...
>   };
> The struct member 'handler' is marked with __rcu. But unless
> the function body pointed by 'handler' is changing (e.g., jited)
> during runtime, there is no need with __rcu.

Huh? This is a sparse marker, it says that the pointer must always be
loaded with rcu_dereference

It has nothing to do with JIT, this patch is not correct

Jason
