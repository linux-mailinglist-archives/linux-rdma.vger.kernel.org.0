Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1379755D4D1
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 15:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiF0HmO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jun 2022 03:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiF0HmK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jun 2022 03:42:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C8760ED
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jun 2022 00:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMQWpn1yXjka9PPAknlBaJ+2bq89HmSrfVGXHq+SWpqrWVTYRlhckgV44PgQjzifstGzgPOvuj0uU85ZwxvQYxQTxoGZlmFTbKwYou3hil6f0HLApXG3kfOAt4xVRqXUi7xJ923pgJjg0wS4+5f2GFA7CEvp2+YREAQlTOPuxb15jui5OiVcA8l+r4jthe9fIixj/VqctfHRnKCJjwXHRJAtjR+PuoBSRsgnnItUCYDRLq0OOgewUj+mfQeX100Zm0cp+Icyu8zBU7g0c0IVgTKGC5t2rD5WIlmJB+qS7oAFJYAF0EBpVFQICDcUFb0WPFhocZATE0EhyFuJfFFFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZXVOQR2Az8YHbnE0V6JQtykIpL7rwN5lyO7+uLBILk=;
 b=dmLoagogVrCUpheHPPvJJSa/syFLiTTAN4MeqzR/aGhI/+7SFuyzTlOvVGSb8xruux63ZQ/2owBxrUVcgR2rpwPGp2Da0Uy00Uprln3GAsQRpa/Zn6wPTnGsGGg2VeEYUrxFREvdkA60XDtQK4gxVusrm/TIouYcm6G872PiWo3pZuWYWJ33NgqsF7SQwLuJ8e1eGa/yiQsaK50f024MSiIszou3NGiGyTed0ffkE1RjmeR/FqClnkL7sTfS8Q7b6wM4v48nXFCeIGuFdWrWhXa/wxH1DeTzJHjS6jOIXOtbKOoKuF+SPv2dB+RuQaeHfyyffeM9TIcTEACS5DANlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZXVOQR2Az8YHbnE0V6JQtykIpL7rwN5lyO7+uLBILk=;
 b=egwKOqvr/SE+xkQDryc0eeaL58qyOjrOroGBU0aMQfIYeUYFh4JSjr5yo9bUyDJouX2CDh6/ooCI2aItRjCle/7FGjWZWDyD0ZemuKqJOkAEb8XqCMGj3NCD57JLn/33CjNOb2FVa1h3SZ8EwJAOb2GyImRn2dLbCaZWHv4VhIFlwHyrM9V+CzgCK9dx3XTPtmpcVfKwDnynBRkuf/oUb1oybI0MTw0zV4ZXDHYWVqMUHaK8ZpdWjPM3YTxI33sBDgAGN6X+4uwUKJjhpkMiIViAMoWw/iYv2fJiGLlboLa3RVyqbJ2yWr0f0uFrqMZ46URvlmd1pLJueu6J25yjXA==
Received: from MWHPR11CA0018.namprd11.prod.outlook.com (2603:10b6:301:1::28)
 by MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 07:42:07 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::49) by MWHPR11CA0018.outlook.office365.com
 (2603:10b6:301:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Mon, 27 Jun 2022 07:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 07:42:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 27 Jun
 2022 07:42:06 +0000
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 27 Jun
 2022 00:42:05 -0700
Date:   Mon, 27 Jun 2022 10:42:02 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Tao Liu <thomas.liu@ucloud.cn>
CC:     <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>,
        <talgi@nvidia.com>, <mgurtovoy@nvidia.com>, <jgg@nvidia.com>,
        <yaminf@nvidia.com>
Subject: Re: [PATCH RFC net] linux/dim: Fix divide 0 in RDMA DIM.
Message-ID: <YrlfSnNNdjkaajAg@unreal>
References: <20220623085858.42945-1-thomas.liu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220623085858.42945-1-thomas.liu@ucloud.cn>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e99f8c6b-9864-49fe-278e-08da58108980
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60SnFFeWKnFPSQ9PAuao3tpIqKZ610qj24Sg2HqtD7ek1icwglMzIuyzxW+hajBxFI1H63Zlmf134a6ujKqCwVAJoEomvEOI4bZR3njCq+zozufRQpcjN98mFv8tuT9Sww6p9NVTHmvKaj95iWTpZKIoXLE8WYCNhiZd11HfxdrnAm40zPUsRfFRl2ROYk8zzS9J74ObtiLMbmrgf5gsB7ifXolGQI4THM69GCLjvz7SklQsopkmbczVVfPGUpmcBbd+rpPZew6z0NSTostjk5KXPACYWJwuGeQ3mG22iaMdZ1eWsLTnUc/zwsQeSXtzqUmz3aLIDw/KWG+pXc8YTwPAKceAI11xB/M1WWGj+eEI4CgW7ogiAJp5GPasBzYXjDjKb6LYanofoYdfc0GPbnFSyQA36Iamj5MDudnc6PQ1THBc+7e+57j58z9ZkfU1i5Z65L68eo8TzcvKDvsduA2d7Scx2YKJrk6M6oH6YcKsZb9yXr3WJtqKs9NclTCHv/b/6v6YujtSGxnHewWOXqP/HYh9nRTW+dY1dRPVTYMpafLPA9YIQ6Va4/fEATDSGmusmcwKU8ixZsfyJFIEz/jIog080uyrwMLVv5XgGsXqTWhfnnHOnAPguTsUWb2ZCyO/ZxILaFUGN62uOu5UarHK5hbhlE2ClENuzQn0Q83ZNxMNmn5Iq16NlQqJw291kNS/QBKZkDg8dDcY4xuF+Qhy+HNGYbtJaQMFE3mnZblw5dYFmxiJj9cD9A5Q9WhQnaC/UlL4vrfLn0PCHKspem9owANUXKQLfOzvVG8l597xzFNk+cfDy20y7xVcDW/bWkkmAt3ITn0VPVFg5A8UiQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(396003)(39860400002)(376002)(136003)(36840700001)(40470700004)(46966006)(2906002)(40460700003)(36860700001)(6666004)(6916009)(356005)(5660300002)(40480700001)(9686003)(4326008)(186003)(16526019)(107886003)(70206006)(26005)(47076005)(8936002)(8676002)(426003)(336012)(70586007)(33716001)(41300700001)(316002)(82310400005)(83380400001)(54906003)(86362001)(82740400003)(478600001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 07:42:07.4694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e99f8c6b-9864-49fe-278e-08da58108980
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2380
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 23, 2022 at 04:58:58PM +0800, Tao Liu wrote:
> We hit a divide 0 error in ofed 5.1.2.3.7.1. But dim.c and
> rdma_dim.c seem same as upstream.
> 
> CallTrace:
>   Hardware name: H3C R4900 G3/RS33M2C9S, BIOS 2.00.37P21 03/12/2020
>   task: ffff880194b78000 task.stack: ffffc90006714000
>   RIP: 0010:backport_rdma_dim+0x10e/0x240 [mlx_compat]
>   RSP: 0018:ffff880c10e83ec0 EFLAGS: 00010202
>   RAX: 0000000000002710 RBX: ffff88096cd7f780 RCX: 0000000000000064
>   RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
>   RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000000 R12: 000000001d7c6c09
>   R13: ffff88096cd7f780 R14: ffff880b174fe800 R15: 0000000000000000
>   FS:  0000000000000000(0000) GS:ffff880c10e80000(0000)
>   knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00000000a0965b00 CR3: 000000000200a003 CR4: 00000000007606e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   PKRU: 55555554
>   Call Trace:
>    <IRQ>
>    ib_poll_handler+0x43/0x80 [ib_core]
>    irq_poll_softirq+0xae/0x110
>    __do_softirq+0xd1/0x28c
>    irq_exit+0xde/0xf0
>    do_IRQ+0x54/0xe0
>    common_interrupt+0x8f/0x8f
>    </IRQ>
>    ? cpuidle_enter_state+0xd9/0x2a0
>    ? cpuidle_enter_state+0xc7/0x2a0
>    ? do_idle+0x170/0x1d0
>    ? cpu_startup_entry+0x6f/0x80
>    ? start_secondary+0x1b9/0x210
>    ? secondary_startup_64+0xa5/0xb0
>   Code: 0f 87 e1 00 00 00 8b 4c 24 14 44 8b 43 14 89 c8 4d 63 c8 44 29 c0 99 31 d0 29 d0 31 d2 48 98 48 8d 04 80 48 8d 04 80 48 c1 e0 02 <49> f7 f1 48 83 f8 0a 0f 86 c1 00 00 00 44 39 c1 7f 10 48 89 df
>   RIP: backport_rdma_dim+0x10e/0x240 [mlx_compat] RSP: ffff880c10e83ec0
> 
> crash> struct dim ffff88096cd7f780
> struct dim {
>   state = 1 '\001',
>   prev_stats = {
>       ppms = 2142150514,
>       bpms = 391112768,
>       epms = -30709,
>       cpms = 1,
>       cpe_ratio = 0
>     },
>   start_sample = {
>       time = 51174507127193614,
>       pkt_ctr = 0,
>       byte_ctr = 0,
>       event_ctr = 1,
>       comp_ctr = 494693321
>     },
>   measuring_sample = {
>       time = 51174507266581985,
>       pkt_ctr = 0,
>       byte_ctr = 0,
>       event_ctr = 65,
>       comp_ctr = 494693385
>     },
>   work = {
>       data = {
>             counter = 128
>           },
>       entry = {
>             next = 0xffff88096cd7f7d0,
>             prev = 0xffff88096cd7f7d0
>           },
>       func = 0xffffffffa02b9f80
>     },
>   priv = 0xffff880b174fe800,
>   profile_ix = 1 '\001',
>   mode = 0 '\000',
>   tune_state = 2 '\002',
>   steps_right = 1 '\001',
>   steps_left = 1 '\001',
>   tired = 0 '\000'
> }
> 
> Fixes: f4915455dcf0 ("linux/dim: Implement RDMA adaptive moderation (DIM)")
> Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
> ---
>  lib/dim/rdma_dim.c | 3 +++
>  1 file changed, 3 insertions(+)

I think that this change will be better as it won't change
decision order in rdma_dim_stats_compare()

diff --git a/include/linux/dim.h b/include/linux/dim.h
index b698266d0035..69ae238ec2dc 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -21,7 +21,7 @@
  * We consider 10% difference as significant.
  */
 #define IS_SIGNIFICANT_DIFF(val, ref) \
-       (((100UL * abs((val) - (ref))) / (ref)) > 10)
+       (ref && (((100UL * abs((val) - (ref))) / (ref)) > 10))
 
 /*
  * Calculate the gap between two values.


> 
> diff --git a/lib/dim/rdma_dim.c b/lib/dim/rdma_dim.c
> index 15462d54758d..a657b106343c 100644
> --- a/lib/dim/rdma_dim.c
> +++ b/lib/dim/rdma_dim.c
> @@ -34,6 +34,9 @@ static int rdma_dim_stats_compare(struct dim_stats *curr,
>  		return (curr->cpms > prev->cpms) ? DIM_STATS_BETTER :
>  						DIM_STATS_WORSE;
>  
> +	if (!prev->cpe_ratio)
> +		return DIM_STATS_SAME;
> +
>  	if (IS_SIGNIFICANT_DIFF(curr->cpe_ratio, prev->cpe_ratio))
>  		return (curr->cpe_ratio > prev->cpe_ratio) ? DIM_STATS_BETTER :
>  						DIM_STATS_WORSE;
> -- 
> 2.30.1 (Apple Git-130)
> 
