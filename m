Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130327401DC
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jun 2023 19:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjF0REE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jun 2023 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjF0RED (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Jun 2023 13:04:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8683710F5;
        Tue, 27 Jun 2023 10:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j92KA3Rbf8a7bc83CiPLr8YB/zv7hP2AfVM7HD0enLRtEMEG5yEEQg4fptYTpEy6U9i72NDceglnrWq/ieKtlU3cRROYognNJy9UtWQwMHF9Xd9mLRMFLA5z/Kd8UsW5C4IQrmDYGlqPRkHOlQDhLbsVVq8YNQoBiTbb68sOAx271kpMzJoV2Gcaa54Tdv/Z3lCjjVWymmYQLOA6nv99fuHUvQYeCkNBogKatAti5PObZFOJASCR3MeTZjCfnL579u3eJ97MrxowbWa468EEzhz0hq9aWnf2PfiWb9nTKr3BesA3+TIWHWkr95OAcotNER7VQxV1DF1op1GXaRWySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3AYg56Z6X9By3Xpb60dd2lOwkT7wq1tTYAItH/YPqM=;
 b=YuSgKq9fdjvi9RrXU5PNF2CxZD3b+ghEIO+2WCXuf9elcYdB/2uaTTwtoXNEpkhSOI/DJeNvibu31PbWIra1EjHLmLL72Tm4s8Kp3eN+QtvBXlS9a7127WKlB+67o1DHOl9LTKK263MGqPb9fNqRtY+P03rriBps8+C6mG2S3kP1lDLoHLN79ELy9k7FJUgzy+Qe1l114EIALpf6WkRQrOe561GAd3Glxs3c/2b7Le8rr2J8CTtAIdG+HEyNGRj2FP5vBjzwZEO9ujPH/vn8X9bZ+pYxZ4njNGWCxgd794JckgsHVy63gDnySGUbI8CyaKmW38aMh6CJmNAFe3GUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3AYg56Z6X9By3Xpb60dd2lOwkT7wq1tTYAItH/YPqM=;
 b=ntCkjkRkpS0Zb+Lss5WUO5abplf36AP/KZiEzEFZzHbw087Lm9vuLEYM+dyZQ7SB/JdJEQQYOJ+HHYFBEAbAMACgiOvQ9K+AYLkwaV0V0A8g0ub1muT/uamCIgATfdT8hFbE9UuQRtkmQEm8mfq9QZYrpr7FIrxvWB5M8RBGz9aVDL/ewoJFo4D1GO0/0PMiAc9nPCvSWlI+VNuNBAwPshwbIhYiY9fqP86wv4t+SRMBkTonNZ5VoIP7QpFT7KRrMiMcjvwKiKYbsW0GKQve6Osn05f+4P8CiZYHoMGm/Sm0nFRiUbqTaZBHfp4IHzu8KIG9T5Co3zrH5gHUuMLRhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4586.namprd12.prod.outlook.com (2603:10b6:303:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 17:04:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 17:04:00 +0000
Date:   Tue, 27 Jun 2023 14:03:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re: Fix an IS_ERR() vs NULL check
Message-ID: <ZJsWfrz5ka29eNVI@nvidia.com>
References: <8d92e85f-626b-4eca-8501-ca7024cfc0ee@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d92e85f-626b-4eca-8501-ca7024cfc0ee@moroto.mountain>
X-ClientProxiedBy: MN2PR22CA0021.namprd22.prod.outlook.com
 (2603:10b6:208:238::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: cdbe9648-f694-4004-375e-08db77308033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obMdhBc9dx6yjK4+XuVS0Urpc8VKB/hYwfB2mxPavO6eT6j1gEcwR4pQd+ehJW69hoFWEYgiuqFJxfT3YW3gbe2R6AOnJ0g5Ws9j8hbW+bTbKiptacu2C23AcpAJATwMJNy1MdNl8rjvRdt9N1hjBudDNAhs0a5xqwEmwbWjAXx4GTYGn0PeRRg01F1ep0SMO1U/TSoJKYouE4+eVZT7Es7rE9dkZw3SXED/fRobNXA95EtS7CbhnvvjxBtHL1YYQ034Mxh+HQfpwIL2MyNEXsAHiManhjTHtxg9ScAcTN0DFlu0K/No3bJNv7Aa1uPraSIZQHnERixt+6dkjK1oa7UIJj+Nga4bmgaCvL8atippvbawOqZy3DxRYKmznrhYVZiBmL5cxpfedb9DnZJGjrnndd9zHbxN6sycGoWnFzx63GJ1NQ+8vAKycqon1altzynOCf9OPCclW5vDIE9mj97l/rGB0aJ0F6m/hJDhoT9MHkz9OlpipQE7MnvjZBwr1lzYyMV8mtZ5Em4FRICx1iqKdVy7Ol4WwSV+FmmMIj1paCn11otY60w0zgLZIoQj04GS5EM+2pgUvYTFwRr0vXiaJVFRAf1YeA/YuQiDhfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(36756003)(5660300002)(66476007)(41300700001)(8936002)(8676002)(66556008)(86362001)(6916009)(38100700002)(316002)(66946007)(4326008)(2906002)(26005)(6506007)(478600001)(186003)(4744005)(2616005)(6512007)(6486002)(83380400001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pZUvGw69uHf+MENOj/nL7BQNufOXlojDsLgJJ+poWlii15tfuDXM14UAY8Pf?=
 =?us-ascii?Q?aL+TsGBlEm0pAYdi2gqvXFzq3WhikxdAL1aiegIhnHD9vywNoZfowhte2QYp?=
 =?us-ascii?Q?6De/fK3x03jXZKaWjIdfSIwRPvMVSbrbQ3a5CmeINTXpr5NDAUCNbvVSbXvH?=
 =?us-ascii?Q?Utnf7OsH3Mv3iBKCG47D3Ox5U2hKMASjs8zxFTrGNDmhaLzTVhwHZCHlj5pG?=
 =?us-ascii?Q?8U+XCQgsSqz4SZjKI8WZyKeyLrOskRgVgBsdmbabLIyZE7/caVbM+u0iz6/u?=
 =?us-ascii?Q?iqQkmwYlOKC55W9dso7EJqON9ILRaRUmqvzuItGyo4DTUQbpoIm9joPsnaoc?=
 =?us-ascii?Q?RZ67RDHiLODodeA1AxsaA7fsdemkx2LmoSVVInHDSjMdqOrFTmzy6HE8osL3?=
 =?us-ascii?Q?Rxxzvt6+4KZois+Fa1A7pHoVGjqcqcwtp/4CdcPvAUC4YDKzBB+O8X4lJBQT?=
 =?us-ascii?Q?ktcWpm7mtW5LGCwvHdbbnVR/yXNxu2mHZhc21U4KE14e5qBK8pTvKsL6M9N7?=
 =?us-ascii?Q?eWoPU4d0KOIhfnbikqLNmBtjHpmyZ6BVUdaK9fPVZDeT/269y0CInZqGqiLo?=
 =?us-ascii?Q?z1219KH/QO4PX6JNGyKT5k6UQmHPFn2mTBx1OkaBGWn4mI/ngbLQW3a/DEp8?=
 =?us-ascii?Q?uM7IjPfuCPELX6bQsmXxM6CA3e5lzaTCTIlhi/2YswmFk2Ap86LVt1zkUsRR?=
 =?us-ascii?Q?R2FBjfn+wGhGr0zCZ1jdRqsXwM2iM8c3tUlz/A8bduI8zDQJOKeBMUg60CSp?=
 =?us-ascii?Q?3tQf4QplxcoIbDh27q7Gdt/+FjbiPiwctjf00yQYiAH8ClyaIFWn46RoaMT7?=
 =?us-ascii?Q?YZLIXcErbfpIAC9xkcuIHQ6c+Sx0ZmwUvAuVC1kxS68bVZ0cpbArmglUQ4qz?=
 =?us-ascii?Q?h9UHF8Lt66FVMJ4hTq8B9ARXMirYsuCLuznPWjBa9yxLdd2pjT+O+8fYx1VQ?=
 =?us-ascii?Q?25gjvhVmT11si7V+cHRQlyNSh38alZx01jfyDoWHPK4RgGJNKboYlEqfSU42?=
 =?us-ascii?Q?L/MTTU5KjAtpX0avJGBARn7aevLyM/68DoNhEJ6KQZg8lQA9rpSljUf5bltP?=
 =?us-ascii?Q?kzlv9p4updTRcS1221gGEZbHy7Lvx85rKg8Y055dDpUEZaDIhWKnmIpD5Af/?=
 =?us-ascii?Q?6+jg6PFDuzPcZJ8HDNZ2bFHH93b4XMZY/6QiIjdqGaP2+G2LIWl2cT3adHqi?=
 =?us-ascii?Q?Wv40hH+T5hV9OWCoMdkKVq6KuYP15ATtBjEx6vK1MPWhf63zeeJU4nqsDP7k?=
 =?us-ascii?Q?YVskyCyW52qqCygQehriDhcOveyQtgDVjEOvabTKFgD7qSSclkxSV/r8FBwR?=
 =?us-ascii?Q?IpvuA3Zx9oY44fWKIpqqV15iKMMZZALYWuTQCLp3zBwtBJVRd2JNT/qTMJlX?=
 =?us-ascii?Q?P5fkBy1SteifnZMICA6/CZ48hWYUfPHRWx4zUlBtemoSVBkNtrTx5d41xV+J?=
 =?us-ascii?Q?Jvr2+oswjPpxiGLlWcSSLHyQY1fATDlTcFo8UmlQhnrO3Tkm+CUFvHJuvHoB?=
 =?us-ascii?Q?SURvtn6SUEMEzXMgRwnIZEYe5ZnuvJeNZrdzxDUAL+JXz8Vo/6FeNMWk81LA?=
 =?us-ascii?Q?d9agqzgAHFjrHNExZfvoRqajRGyEeLPWMD8hXVUm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbe9648-f694-4004-375e-08db77308033
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 17:04:00.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfXi4Bdkxcyg4fh9EhMVGzwVp2oz7Op2AJIhVB4gufeWWhpfzB9X5iAoVp1R7A4Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4586
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 27, 2023 at 10:20:13AM +0300, Dan Carpenter wrote:
> The bnxt_re_mmap_entry_insert() function returns NULL, not error pointers.
> Update the check for errors accordingly.
> 
> Fixes: 360da60d6c6e ("RDMA/bnxt_re: Enable low latency push")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
