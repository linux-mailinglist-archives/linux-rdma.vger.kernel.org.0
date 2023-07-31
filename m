Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7AB76A059
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGaS0R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGaS0Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:26:16 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC2210CE
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnU0o2hztUammPTEGCD4lhLdxF/RlHqYGZkghYf/fgLrmKew5PK2/sMAtunhapktndTzWVvMb8+gVqN95iRJwWz4cpUPUZRj2Uv7sAM3YadvJlc9ik7SOMTXp07q8pvhm7uHRjIpy0j7rd4CIfuqLZqO5knxWsCXHjiMZiTxt3jeKiKPO1A6BITzazfdZy6TA/gHTCw3VPEZeX/cLv8xuWe7O8S2COJ/OsP7e1+13SrTP64CAlaCroWFuxWOvCKF0D4kcF5hfXJYqGGouuAwKHgg88PXwVrnHsuNJ+6zMIg+e4O0btHgXXaoyxRcFEBMtGJSSsj+tO8cnRYFQnQZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3RVMDO34m4pDo6J82XlJGJdn2EXKvOs5LSAqMh/K80=;
 b=DPYD9EKYz7CgcHNblTugxB+ZczY3Znm+6Vb0jScAVqKHLFNYNc1iOrFPUTwoEjjpyK0i23wj3CVVRdIpAjO7iRhfiLcvFXIpX2Kbu8h8rqLjkrgmCs+pQbxKNWLTr68ykYHWkDKuW63Ay83qtA7WV+Ix8XJzEsBPsHTMV07e6wc9eEF4EUnPsK8ZHPVXjhd5mTqpxcb+SOwp764U6CK8ufPl3XZ5r1RbAv9awCnLNz4FYwFjTY3FSMvWFCcndnj09yx6G9OSzM9qUge+WxSNiVBnF/rmQNEaklQ24Uqr9onRmLPoZNTA4A5RVIfVK8qSViBLMnGCPfVueiIkH8YrtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3RVMDO34m4pDo6J82XlJGJdn2EXKvOs5LSAqMh/K80=;
 b=CdxdHGw71uJLdQqPULHrBaAPp46SuzPpWyrJN9SsiBemGQIKb7srYM8qZl+adrYHglAOSvmksK42BCBIZYIThIiRZJWcrotkVkUwIHIUkj1e/+82EauzPeyxDUUmGI5h1JCPAVNfWAw3RYL24FxR/QbJFCF4AK8Jpd+4cEc2svQzEI0B/kRkUbey3qzj/ZGKBKPPvwPwL9WP/JhmDU/o4r0iYUasQeonD0sij1ejfC/dhjaSVPnqEXJMDLCYGI4kOMUqCJhNKhGZ2zK1/OsvNnGk+CdSa+4iN0c7mHKaj/SNJe/gIToP+i4clIWZp57pvWVnD0WbPZ2GjRbDKSOmEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 18:26:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:26:11 +0000
Date:   Mon, 31 Jul 2023 15:26:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix incomplete state save in
 rxe_requester
Message-ID: <ZMf8wfyuNVz4oaVM@nvidia.com>
References: <20230721200748.4604-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721200748.4604-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BY3PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:217::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c1a7d3-4166-4f83-1546-08db91f39df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9amyGQAdD35RVO7pNmo5NAPJO4JoJMlht+qiQLYW+VB4TijeKhqBhAmtp90WO32oIMUx1o6QZu0oF4pXC+EvcVNRogyH+eZs7idGLbb3i+2UkYBbLRc6zFnqmdN2QDm2SPb4Gn8fcy86VPc+EHRBrpWb8D/ECMcvHjAxIdZ+X6q9w/EYryDlIvWiClDzOUkrA8ItF8cGTtnVnASSfZsSL3pi5FjNVJ+vWB86dSif84bLIaZ9paOMt11QC2kH/ucW1ZTSIEn9z9n6qQAH7f1rjm4BMulwyvaPicpuBrC3TTTT4ay7Y4M/b9+GJe2au/sqMNqrRRVo4XHhp3vFB8XJch7TP8pja/FWlj1YnCnD128cVvWsNBru5vy0dW+YFL7ZiUW7ZXBF2/8Y1wj6xM+ODmxSIrJHkA95gOabhQw2xAEmn1k/QZTqRLgFbrQb7ktnbpqBP1ICSyaYFNLqTsqBiIhTORjRQE8WfIOHKaROGw0BGS6jloNFyB+cyuVqWEoP4qrFzILky0dSm62jvGBUzw+YselZNAWlTXM+xzD3e1EE61IQ5RAPqNASD9DDy3zj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(8936002)(8676002)(26005)(41300700001)(316002)(6916009)(4326008)(6512007)(5660300002)(186003)(6506007)(66476007)(478600001)(66556008)(66946007)(6486002)(86362001)(2616005)(36756003)(83380400001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DScgAEOm9HaUqHsNZGlPVqfxrYWuGom4WsjXmr6UZYuBNheLnFiT1xptKkLs?=
 =?us-ascii?Q?YZzcTYF4GXMDnVzdKYd9HSwwJStAf5z+jowGFi7nWH4008/qVja/aRpO7Qpd?=
 =?us-ascii?Q?KWPQRZmOJnaGmR7YRvBrFRfjvc4fTB4nj720DXYF/5Gg6hyLCj2qdIct65Lr?=
 =?us-ascii?Q?P9l0SsH+FnS2OqJJ1xkCEc53BN/mUfw8pZhIW5Yd/v5CcedkGR7uCX6If7Y5?=
 =?us-ascii?Q?sl30zcxk2RKgzSmoHlU7phyE586rtV9DhNSNfM/ZKbNpr480klKbhxUJFozi?=
 =?us-ascii?Q?1qeo+f/4G0/JAXw34kMJdhuO/pglmbSZPCp2Eh6k6NcZqvnDPzOhpHTwozv7?=
 =?us-ascii?Q?7/85cLdP7D0fKSruekjcI3EjvAFF0iyrB5S4I6nfTYiynqluMFTilGImuBrh?=
 =?us-ascii?Q?3wn5tuz+xek0jwmws62Y8TkKlr23yy+X8YrnZKFTBlturDjZcPac1ieCwlxN?=
 =?us-ascii?Q?BplLZh9hfQfzzUuENm+oraI08jmMuH85QOGjMKQDdSfLHt/leYvdAxEja2zG?=
 =?us-ascii?Q?0p0hp9R1Sqb3da08KLbXcLDlVXKg0TvhBb6eKmBTCsqDAdoDUGhLrNWJlyde?=
 =?us-ascii?Q?6lWhGxrXNRu3t5V8GFFmnX1H5sFoxsW0yeRwbXl4PY9UECoPJXmdP8S90Ula?=
 =?us-ascii?Q?g5GV/eRPeEOOR07dO27GIQGr+9SfUL7Qz7WLKVAmrSS1rltcClx31u2FZVdR?=
 =?us-ascii?Q?OboDnA8b/xTbS+aL5G4zMe3ISf2ce0353Fyt5ZRv+xAoH66/dF+94WXRbyHo?=
 =?us-ascii?Q?mKTJkDV5loovJyN08GP7Ttpg68rMujcupPIHoh/K34ASYwAtAvWyXc8prLW4?=
 =?us-ascii?Q?CeIiX8NdS5OGA9qQSDL2c4ifWiunRNuV0Du1db1TopzprIG+c2mwoAy2naT6?=
 =?us-ascii?Q?HTDFgeO9wRQE+KTPI/EFXTn8/vQkhKiIvZW4BxD9KVPR5Wzg9MdLzQmijcCo?=
 =?us-ascii?Q?l4cDHtRtzJTnHQE999i5h8DsN7xB78Ke+ICQ81zgeZIkHgK9YHMUHE8pnnmB?=
 =?us-ascii?Q?EwdpdEbu7dubwWBKcZDUpTSeO+upV34boGOwOGY2RlNxmrjmf4hYy6rQypib?=
 =?us-ascii?Q?zjdQ6JZjwHT3Ib6NbaYnr8xKRGiLbLqf1gGp+PMOU8s2ZKlb4YBSH64qtB9U?=
 =?us-ascii?Q?AQuf/jZiP3YCUaY9aDGJHd1NGShcnkbRba8E3JTp0oVwF+c/e9Y8kWue34PJ?=
 =?us-ascii?Q?BqCoH8jE6+gV638Wj6HfxTMXd8dpbYlKXpzglfqD+xFZ9i3q50ESkDKVZZeh?=
 =?us-ascii?Q?b08Qvpeq6UjQWFWC2aMTVFj5lbWSqPguAFxAVzweDHPMpysq5g+9Uso1fhDE?=
 =?us-ascii?Q?3Ngms2vkU8NR+PNXUaVIYLpdRDsUUmhMlNjDPrdiqGYkcxPBsLBXs/9ZEilw?=
 =?us-ascii?Q?YuTaxyQ2FHE6AGkrUS7jQfNDdXQxT3PZSaDlO4EFUJJp4Hvdu/nBF79w5PDx?=
 =?us-ascii?Q?SLblYlwqVRYLxc5/3+k3oSCq13Kk1ONYiLnvRO1p87HTWONfaJy4nPwU18CQ?=
 =?us-ascii?Q?oC3YFk4dbJ5mFhclP3p9TojdQW22yFXamhw7feyDfjcVJIILTDEvjcSPkR1w?=
 =?us-ascii?Q?QecZH9c/ce9IMXn+m7Z/kbTOmvY3GuC+0vHDLEfE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c1a7d3-4166-4f83-1546-08db91f39df1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:26:11.7888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mmdleg0jSy4B21QqWyf5rTMcdYXEKKkiJAkseDAxqOnKQGe4rV7n6+CS+2qQ/yPj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 21, 2023 at 03:07:49PM -0500, Bob Pearson wrote:
> If a send packet is dropped by the IP layer in rxe_requester()
> the call to rxe_xmit_packet() can fail with err == -EAGAIN.
> To recover, the state of the wqe is restored to the state before
> the packet was sent so it can be resent. However, the routines
> that save and restore the state miss a significnt part of the
> variable state in the wqe, the dma struct which is used to process
> through the sge table. And, the state is not saved before the packet
> is built which modifies the dma struct.
> 
> Under heavy stress testing with many QPs on a fast node sending
> large messages to a slow node dropped packets are observed and
> the resent packets are corrupted because the dma struct was not
> restored. This patch fixes this behavior and allows the test cases
> to succeed.
> 
> Fixes: 3050b9985024 ("IB/rxe: Fix race condition between requester and completer")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2:
>   Rebased to for-next
> 
>  drivers/infiniband/sw/rxe/rxe_req.c | 45 ++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 20 deletions(-)

Applied to for-next, thanks

Jason
