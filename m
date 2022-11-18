Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE79B62FC1A
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 18:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbiKRR5t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 12:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbiKRR5s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 12:57:48 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694E2697F3
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 09:57:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eY36EKTZhrLVhsS3q+ZrHq0DLDhxpgzcRNcuYHKSeF03OUTg040hKjd2MI90SLFJ+b7+1Sfl/5uk0helYoEn1X1mv2nbJ6HieqOhyx3hzcjtKG64XzfxBkEZrJFB9qFnd4xuoxYdH/a1JEjiPlKwNUHhi/u3nFdPlj5kImIhkelvBD/XnjkwmwM5PW96OZIPRDqvdXOmZ7g8E1M9rcVXAB0sVKYlj2L7+9cP72hroBf51n2zxwaB2Gu0a8EJUHF3Hdj3AkCU6HH7d/rsQwQM0J89V4LScSN3qK4FeT9GwBQAI0ATG08ojgUkvZWgVFgFLoavFw9iRxV1y30bwrx9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcCrpFuFGt0JrDaWm3TQdYHPiFPxgg3cwr/UIpsSztc=;
 b=gukpqjHS2Myh3IsBg//xgA6hNG0zD5tOPKkcV4FHqYclfFZWvg0ooHmbnBWI6ed429cYdBlf2MSQfBAIhlmuiQdwGA1ruL/s51Du0IU7Ml7khYCP546aoBu5HCT1BcX5mnOVLnhIsIWWCKcc18bsJZSp93ay/TbSJW7Ord4PGAAIwuKSBZQlGMrjjm5rXO9MzhzYCY/80AjrQzeJW7rnTQ42tv2kAVvlvXLwg4+45WtkfuHtb5FEF6cxDfJhy56iAH4taVBZ9OIsMqCWiemEatAYJLmFQM++ePiV2/T0EPElZaM3zVHICQrLLuq8Cz8hbWOpacJ6NjKBXK3akU2VPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcCrpFuFGt0JrDaWm3TQdYHPiFPxgg3cwr/UIpsSztc=;
 b=iUS0hz7g4YpCPe64wssBbG6YTB9aJfK+od8od2hyKHB919SSPG+21n/FCmvgm/rNNhxM4WlZ3W9AcyUG/D5oaovROC0IO36Nas7YA9Jbshph6jTrNwv8Qq83H0J7xQ+FrfNafefBs7aEbv//hwBHLY9T+Qr7Vcu05KKgFOaC1+ASCzogHO+o0hwJz5Wqg0q0aGdfJTHEIB3x0gpNjFhEK3dgRDzJNlzZb6t2r6DUCMlbluyIoDgMSAKdbesf5m62BTBM3deUfLsgK0dMjcYm6UF6dh3PbzHumHGR91NXV3cQt5rnG7N8oVousuBcKBKbhHAFgfM9CpQfGFVE8EsKbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 17:57:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 17:57:46 +0000
Date:   Fri, 18 Nov 2022 13:57:45 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 00/13] Implement the xrc transport
Message-ID: <Y3fHma3qRCbQ6rF1@nvidia.com>
References: <20220929170836.17838-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929170836.17838-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0232.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 6423ac8c-8d47-4e9f-d88a-08dac98e65f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vbb/yPmQ02UrrrjuFGmPhAEPM/SdB337S3XOGK+4Jetfpu2VzsM96TrejlvyDQ7z2oHRiZJxm6e6ERgApK7D0i5d4uX2cmwodqgOPvpHaK6z6lCxE2ixfSjeU9EE0LLI3vvv3NAyo05ZFB8IQ8k+he8jN33EbHCpUS+BBF4YpndAconDueVPPYc0oshQFDexK9PszGuILXKH1lScJAXrkngYTbbZ06L8hsvaZ5/jpHwJenvg6OTwRI+nWGmhlxFiqVRPkANikt0nsKD4ByjXarktLNd+HZw+tsfLpkbqkbRwmTNWCJ7iFxPFb5j6lvKuKkn7HaY/9LGzx8WuQ/6mM8QuvS8d9ri1ekkpCk6K16mUx0PD4cE837Iysecjl7SPNzDFGkx28vMM2/R8GzSM7p/sn1fa+04JW3bYpcM5xirGcQsC17C5HwY7HTaFRWtz4XPDEyTZgfXZtrQytzb/E5hlkWh4gLlDnCMgVMTS/39MDzHrlmaUBvL+Vji+9Rp9yGhyVf4SGq43ZAXzFeaeCQpHt7ygNcymWd3MzMxOyMdYJuVW0zly3gGOPvJOfoDv2PM/3+ncc90AslXJZ5917OuU8LInlrjnZPlhqlwdPM4+s0xl6HdsrBs2WpZ4OWRE7ZJVbtox/+2TrYeHwORw6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199015)(6512007)(6486002)(2616005)(478600001)(2906002)(6506007)(36756003)(186003)(38100700002)(86362001)(83380400001)(26005)(8936002)(41300700001)(6916009)(316002)(4326008)(5660300002)(8676002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HHA69O0IaY9pH/2ex0hu/2eaUsJGYqVh7jF9t96ZLfXfdTCsvY6aOTNZUs82?=
 =?us-ascii?Q?sgXEz6AJuqloWLnjr6H7ARAbZGhe74yqv1tvVF6vySkU28WLK0GzvNW2k7RH?=
 =?us-ascii?Q?yc600KYR6HFPiEYrEEcFdJFiPQIa7PTC3xJBuE2zcCu0NbvaxRkxsuCAYkch?=
 =?us-ascii?Q?4y9yHaNZxgvWti6hFTVCsECQDzlNgB5rOKjnfKW0/VMslx0scTvZLsFXwANt?=
 =?us-ascii?Q?/KTuu+U3IIkmiWtOYgM5Q4umkB0AmHdYohi3HVUDuSL/ad6FhwYKQOCVXcpc?=
 =?us-ascii?Q?we3wAh7cmRxg39M+WMn4+qFVMvQCOUIrnQ84Fu0kWnalKu1esxnbm+gRa3lj?=
 =?us-ascii?Q?0YuBcvRV9at6GiyvKguUAHRtc+g4JsSCZ2YFe+FgiIKV75znxMPe09XRKiIi?=
 =?us-ascii?Q?T20Sy+b6vDW97NdGJLvEhW0RYGk/6unPjPVoFcl/2w12IudiCxbaCAHLNJEx?=
 =?us-ascii?Q?EQ9zNj/6+PYwxXdBFi1OptEH0bWWqDbkYBg1l+3j+su15n2t6n9j31hL/9od?=
 =?us-ascii?Q?u6JJjVpMoM5JkHiO5bHt/6a2hf8dzq8TwilrA56rZ3dS/kft5HFHbS0q6v32?=
 =?us-ascii?Q?VuM5IwPlNv8ZOEZ/kCAHdkNn73piiVZbuPvoeuyWBx/jxjlgos/w/C1IhuaR?=
 =?us-ascii?Q?s8982siod49Cl2yFbzBCIx5ecE1Krb1Q2o6Dr0dkXbC8SHSh6rrZQeBpCL+q?=
 =?us-ascii?Q?fwkE/LAhrK8fDBo4RuLjOUsEaoMFqbzOy3kuX3K/XhRjKDYTUcZvVludARDV?=
 =?us-ascii?Q?MSf/HVoXUWex6t5UOvneDAT0mMcMXlKfsMfJCt4mZ8b0XpnFZMpPDcE3Ng74?=
 =?us-ascii?Q?fgNHIGhOcM/5zmPrx1YxPZ6pymZnwzF9RnM+grUO4pWJW+nRNG2V7BAyMSPp?=
 =?us-ascii?Q?jhgkR8MDJ7i/UxP5plMQ3VRtyd+8U9QkkuuL4+YWG7mVhMlhKTSHVRiUWpVi?=
 =?us-ascii?Q?eewjwnhD6qcKcQblodTHMGHpuYg48RfRcrxU+D/ilHO+X+D3d4ne8FG82jXS?=
 =?us-ascii?Q?J0N/gazZjaRkdZevSn83qhvcesWB8iyJhCIihoY16/+wCsVbs3TCyjM9/p50?=
 =?us-ascii?Q?6HusZYKU6B8Nld364+35ozcvF0eE9ZwvVyDI3Ei14fH+7vYofMkFwT1NvxMd?=
 =?us-ascii?Q?nd+i9LwjiBOIssrVhfOjFbBhUsp+eRm1QeYpDZJVwz4G5ACAW0EexZj522GT?=
 =?us-ascii?Q?gbAWC4RsrTKHXQBbqrFGarxs1i9ju5E8ejro4/8Q/+cHkgMMsWorjBr28SJP?=
 =?us-ascii?Q?ojw+ZHdn/pdz0pbohF9OhfnFdqqw1+c2W97FoFJI7ksPsm9Xe6TzJ5Ugy9pk?=
 =?us-ascii?Q?Jh/XIMctACyo3ryXaxpUXY/BwkxoG0eYozS009+rXTfmkRlt8hOLOg4G7PtE?=
 =?us-ascii?Q?iPJc9NmPPPX0LfB5hQQBVwsNDMn81wg1fAjuf4boP0c6kEmE3QdQPgQOxFZU?=
 =?us-ascii?Q?qwPMn9bENJsEfKY0mWzIEpHpY+07EBPvkJtbh9oE50jsnor7rlINxh1VaEPR?=
 =?us-ascii?Q?esPDurx9qMKzBs5qvtBBu4hRXVAW/IWinqF3AL4INihBbJYoFImGJKU3Z1en?=
 =?us-ascii?Q?Afwv/xYX4/KfP5fF8IU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6423ac8c-8d47-4e9f-d88a-08dac98e65f1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:57:46.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1bUAA8Cx4lQPGPvyXQIJ79UsGajhCdAqEdX0iHmiX+pfH84sHHwS6aNpcvObEoQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 29, 2022 at 12:08:24PM -0500, Bob Pearson wrote:
> This patch series implements the xrc transport for the rdma_rxe driver.
> It is based on the current for-next branch of rdma-linux.
> The first two patches in the series do some cleanup which is helpful
> for this effort. The remaining patches implement the xrc functionality.
> There is a matching patch set for the user space rxe provider driver.
> The communications between these is accomplished without making an
> ABI change by taking advantage of the space freed up by a recent
> patch called "Remove redundant num_sge fields" which is a reprequisite
> for this patch series.
> 
> The two patch sets have been tested with the pyverbs regression test
> suite with and without each set installed. This series enables 5 of
> the 6 xrc test cases in pyverbs. The ODP case does is currently skipped
> but should work once the ODP patch series is accepted.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2
>   Rebased to current for-next
> 
> Bob Pearson (13):
>   RDMA/rxe: Replace START->FIRST, END->LAST
>   RDMA/rxe: Move next_opcode() to rxe_opcode.c
>   RDMA: Add xrc opcodes to ib_pack.h
>   RDMA/rxe: Extend opcodes and headers to support xrc
>   RDMA/rxe: Add xrc opcodes to next_opcode()
>   RDMA/rxe: Implement open_xrcd and close_xrcd
>   RDMA/rxe: Extend srq verbs to support xrcd
>   RDMA/rxe: Extend rxe_qp.c to support xrc qps
>   RDMA/rxe: Extend rxe_recv.c to support xrc
>   RDMA/rxe: Extend rxe_comp.c to support xrc qps
>   RDMA/rxe: Extend rxe_req.c to support xrc qps
>   RDMA/rxe: Extend rxe_net.c to support xrc qps
>   RDMA/rxe: Extend rxe_resp.c to support xrc qps

This doesn't apply anymore, so it needs a rebase. But nothing caught
my eye in it.

If nobody has anything to say I will apply the rebased v3 next week.

Thanks,
Jason
