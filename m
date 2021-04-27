Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F49336CB20
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Apr 2021 20:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbhD0Scf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Apr 2021 14:32:35 -0400
Received: from mail-mw2nam12on2055.outbound.protection.outlook.com ([40.107.244.55]:64608
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238463AbhD0Scd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Apr 2021 14:32:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVEitOt9SXEqAPaXQlv7cpUD73CH2/IY5MX0rINhAVlomRc02y4QLouQb5dIXga0dmurPF9VOMwWJdo77TbcjHLOS247TH6AjNTt243my8i/eYfMAEXAKtzLUlJWLD6JGlUwKKbdqj4IjIt+T8OIVJnzCGstNM1BC1z1tevVz8o43kOyxDlhkPb+eEJGG1bDyO3NeJY31ZRIcGQcfNaHxd/7WWzhUf50cbdXDcxdjJ+2l/lM9RL0GTIDCiV3fkGGgid9qQC7oGXIypbvBVZemqe7i+6oFeJq0qhJjTfGS+kUWVKXvNdMYdy85aXD3XiMMjDnqNB7q0V4mf5vLumBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUuygQfmKUAT2ixGrNKdSZ6R+elOSLF1cfti0XiS58c=;
 b=DNgnW2IXUu2441TUSG4dp2WE9le5cXKOeeHqVQt7XcdjxSxNN34r7aXM5jGHKtJdIqEbSqLw3XXLeCGb/F8rrbNrs3hN4omQO7wDtbEy4adimJpsFxqKrGoE1dmYnsxXV2cQR9yQYqk342ddZABGxDsxY8F51Cx2EZyffcdfTbToxaJlUL+LFeUKXcBMs0pFBZtQTZWssRrsWzBlud3LN0GX5Qdq0BAeMh/suiEifGp5kPvmBgnjTdZWhow4ETQSvgdAlcfauB9qkDIQtvZBex4srGN2EYTrSJiVL8+8gLdGbTCcwpW0bbqGy+M0QuglxnrL/hZvuOIFnmmw/UerqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUuygQfmKUAT2ixGrNKdSZ6R+elOSLF1cfti0XiS58c=;
 b=iPuWzv/SQZPK17meHtZbSvdEvMV3/x/Uqnnic2WS153U4OpZiKwLZTu8Lae7jTmi7ym/1nf/8Z5+jq8oRT9FKdYunHlv2uKdISAubCoBQ2K66/CSC1lzaeReFImsuqbglxGcsEAnWnUbqQhc0y0FwSGGzqeGecPTeW+ZN+N75NmqLkIBXmmlnMFwbI60q3SyHPEqWPO+Lc5PH7fNkeVfctc1vJ4TzuVmhHzTJix4ShcqiSMKo3bFOW0KEvZLwcWclDSkL/Ao6j9fFplFvfnGhqCXiPheR9/TexS5T78zO/rfpkTl+II4k/l2PVlJbSMYzi91Ak0mdrM3CgIpAWCsAw==
Authentication-Results: mail.ustc.edu.cn; dkim=none (message not signed)
 header.d=none;mail.ustc.edu.cn; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Tue, 27 Apr
 2021 18:31:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 18:31:48 +0000
Date:   Tue, 27 Apr 2021 15:31:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rdma/siw: Fix a use after free in siw_alloc_mr
Message-ID: <20210427183146.GA3246473@nvidia.com>
References: <20210426011647.3561-1-lyl2019@mail.ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426011647.3561-1-lyl2019@mail.ustc.edu.cn>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTOPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24 via Frontend Transport; Tue, 27 Apr 2021 18:31:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lbSUs-00DcYy-Tm; Tue, 27 Apr 2021 15:31:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3b3a5a2-cc4d-45af-9321-08d909aab7d3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4943:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4943F2C75BC24219541C8836C2419@DM6PR12MB4943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tEwQ2dl68Jvvjw6dpU1qe3T65eCIjOJTTVX76MHgCbvnxXbgMSzLw6PzBwHHC3psz/qhcTrfE8ZXYALZ+BPSpLlyWNpuaIgCds5QCRRM71YVBVDp+WXT8qFrOI5cCEHRqGK4Bla0hJXbQkIvpjb9idRyA4Fmbm9ZYKQ8AcG2ClL0GxTFCm+b7bN/I8jgwrxVSsv2e/05SvBFRWLY8czle7QAs/mY492gVykVdNQha1zm8MSwr1WglgXcByglL89RPuPDjYxYqPnVfg2g71H4R32QE2V2WLLHAKHfjpSWfwEehxhkU7vey8msuZPIxm/lZKkdWvhIRwTJWz6q5X+G/Bjx2UA9x4xCPIPf5RbN15QtMuXIHQDHhWaedQYyn9QinAM5s7v3O1QcYj4+Da6AUIeSdez4X/zDNE6HetDFV9F4BwN/ogntNbGBA0HwJbaGdp2DZ37e9BwJJUPnla8Npd2+NARJmgBjr92OyxjgAfDChD4cDqwRxzKBdcD8qzaRHS7f0TRvfA6OPhs3KROWd2WuCXoazB9Vv8lU269SWb9sU2kgOwpxktHH2XnuRnZWrsoD/zaVM852WrMmSv1atbWprSF8jYn7eZ4427P2byQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(38100700002)(36756003)(1076003)(86362001)(478600001)(5660300002)(4744005)(4326008)(316002)(8936002)(26005)(2906002)(2616005)(186003)(9746002)(9786002)(6916009)(83380400001)(426003)(66476007)(33656002)(66556008)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BxIbTvjxyLf15PW1pnGy/Kb6P9MQfVB22dmmF2wx5k5u3xcaOzAZ6QJ8yIts?=
 =?us-ascii?Q?m6dTL+wkHR9YQJwffJq/MGSexxtX4tFyxO29oPpcZFlHuFPHLfyIWqfzMdy5?=
 =?us-ascii?Q?OAAeoIkajGdTQWv70iS3MDM5uFav8c4JC7tCURJ9U/VEYa8Js0BnojfCFUtR?=
 =?us-ascii?Q?h1styJAL/SMh8CDS3Woxp/mJsx6uTm79xLDArS/ykg1sy9bo57D3fTzdl8rL?=
 =?us-ascii?Q?heM1fpi73txl0azOyxnHOZZq0WvDLCLTrqrSerLGWoft45803F++UB1eUad4?=
 =?us-ascii?Q?59sR+OEA/L2wP3SUaHDMRhV9OhlXOFfsMqklG9AQFN4Cv7nRa+T9QRbB44Tr?=
 =?us-ascii?Q?DmYkrPRAuiMpNe7HTJqDFlUyXaG/+lVsCnpAd1LRw9Uh5dc3nBj325y6Z+VV?=
 =?us-ascii?Q?uHqfKQ3XSuJoeHhfg3+jGDTfFdek83ymuHhsWgYSIHOGPnmMnaJbMp8Sdyml?=
 =?us-ascii?Q?UWXgvmAZBF/Wj5l36/TYWsGWlgVpdInD5pIDP68uLCq4E9/Rzem4pzCe91Si?=
 =?us-ascii?Q?sP5AFJaTm83FJdc5EruxrXRTt3gLcOTq0/JTBhLcbTxDVxcXwsuXsrxZ5hLM?=
 =?us-ascii?Q?ChZliEHyt/Bvt0HBc1v+0kVGhjAs8AXlAguVRzP2FFCE6IUlAoq3D6TO0sSb?=
 =?us-ascii?Q?oMOJ4+fN5lQ0seAiK95Y92h8Vm9jOiRfSs6/YhlomIdgPR0V159CukHJqV/N?=
 =?us-ascii?Q?fSWkVrJHmWIN8QgNULpN7L7Sth3hlpP1Qc/laL1k/0rd+KMVEfolOxLTLwkz?=
 =?us-ascii?Q?+NOXdDcbQzV1nSzU88MtShs/2RnA2UQ8El6BAsGSew/3AXEJHcYoHPZOOROC?=
 =?us-ascii?Q?eHz3q9s0vuqrA2ku9p1OnzaSXtV5d1OhDngPhbD4x6EexOYlTDkGWhs22OJu?=
 =?us-ascii?Q?AfgspKLM4WnlOp10KHCRDroq3ZRlOhWGC/MM2CglCUJ7f+rN/80W5RoA8krU?=
 =?us-ascii?Q?cnPobASRdorkNg90zj7fZ2POBCShQ6bvb/fjM7G5dA6j66skTL/Rz4cP8wTN?=
 =?us-ascii?Q?72cBbRMPabBkKxJJwswfVINDYt5PrsbC/W+oB8IXKHs7sNYQGqBKZ7blIYGC?=
 =?us-ascii?Q?mQUAg0QCGUFF5l+6EgcqvmlpyFyo7p3SRXTOU+i30FXcVXxB3kbYM8HHVUAU?=
 =?us-ascii?Q?j5d3TtO0F5ejVyzh1Tw2bTdKe4aZIF220EMaoYaX2NVOwEhFOsJNDbGh6p5M?=
 =?us-ascii?Q?blSb/NA2u84Brn+R+GMglpoRZgGIIW7ZDpVABJaJR4iuHSmiSQMWWJf6etM8?=
 =?us-ascii?Q?/OZF1VnopkK/3GzRZ9b17T7gh0HuQUQ165u81PERgBipUvfhxktKrliQi4gM?=
 =?us-ascii?Q?qydsSHtv33/ofTJO1u2Yse6S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b3a5a2-cc4d-45af-9321-08d909aab7d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 18:31:48.5440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gs//xHuFwU0DPhiT1bP75C+ecu65/Vtg4uI7Yle2Q6sUwb4aPc6rxGzTeUp5uAuZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 25, 2021 at 06:16:47PM -0700, Lv Yunlong wrote:
> Our code analyzer reported a uaf.
> 
> In siw_alloc_mr, it calls siw_mr_add_mem(mr,..). In the implementation
> of siw_mr_add_mem(), mem is assigned to mr->mem and then mem is freed
> via kfree(mem) if xa_alloc_cyclic() failed. Here, mr->mem still point
> to a freed object. After, the execution continue up to the err_out branch
> of siw_alloc_mr, and the freed mr->mem is used in siw_mr_drop_mem(mr).
> 
> My patch moves "mr->mem = mem" behind the if (xa_alloc_cyclic(..)<0) {}
> section, to avoid the uaf.
> 
> Fixes: 2251334dcac9e ("rdma/siw: application buffer management")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> Reviewed-by: Bernard Metzler <bmt@zurich.ihm.com>
> ---
>  drivers/infiniband/sw/siw/siw_mem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
