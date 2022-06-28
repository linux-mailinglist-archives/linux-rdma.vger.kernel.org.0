Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2955D54A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 15:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiF1HLZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jun 2022 03:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiF1HLY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jun 2022 03:11:24 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A40927166
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jun 2022 00:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtKgkN/I1p6K6lK+dNMbOnvAMPCS9UTHb2Mtz5MJwiOcJAXVCKQWBuzb4AOw58xjqNESY/HOS2aorj+Bw1T6AK15qIok/htlwrib3z1CI6x+VcfD8qb+SOnicKUKPj8TimG39yuzyIoagnLra5IA5bTznAt36PQakNCVwxFXs4aYXne3YHpO5kQtpNBq819aGu7A4PMQDiDPjgfjqELbXAap6z6XMs+HHYnoV9BUVti62t6mGgteuYRWQyPN5cbBzZ5oXHHJdPayPrDCCdd7U/WX5hb6SctPQPTLWIdVoSQp96olyyEDlidwvE+LLpaX6egP60AJba+aw0WCbqHc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=df7gtc2e5VlvpLeGUtCDf8OxxzTAj4LKwAi9IStj2AQ=;
 b=KqAnEb7+FZpFtQ8QgvlQkoyqrOluIXf5WCn46pEISkQCrvVd/eu12owBC4ZUt3UyMjRcm1+d9EkOQsUutGZUq2NKzPrhBwTtkgkWVmSBR+7Wyp4d/oCNt9BUFSogvymw8ZwwQirminDVAZmo5gHnL3/ZkeNfxfxuhn8VIMpleQXsnwEiGwNnUk/U5oN+8R4ME9EIBNjtMGsDeqrdppFLXDN6oeQfnVQmAbCXpLNu2KTf+fGQdPZXdqx07L0vfPfMhoQyyZJAFgD6KRuEkLNMbvSXmvFz0nnQtN8f7mGUVaqXncw1gtMdR6gaE88z5x1cKubiSrC5t95wJIc9u76TxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df7gtc2e5VlvpLeGUtCDf8OxxzTAj4LKwAi9IStj2AQ=;
 b=mNdJk4IZPOIaa0a1DGoiW1GAMPbfel4NcOHv9BdG9+QcYI1v9P189pdwu9vm5cJvxlAFjNvkJxdFKZZ3zDcZteTznWwbovEi7MSL5OVWM3eZel3ZoM2oLnR8ZZ936zoAy/LHP5mLrvnvZ7x8pnTnW+NdzexPeVWltVgc209exRKg20V211euymtCe2mxsPM8ThTwesjb9mRFocfdHqPs7M7xAeQHUH32lyk8GHuySSdVnCs6902I3esOtv9fr23uZNp+A2NCfdQ7BYvPC+wViydnu/czA/Mszsk2brwHxE4B2R7yw+qDjO5adg/ENFyGEWzXr1hoXkl7z/PR1gghlQ==
Received: from CO2PR07CA0051.namprd07.prod.outlook.com (2603:10b6:100::19) by
 DM6PR12MB3034.namprd12.prod.outlook.com (2603:10b6:5:3e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Tue, 28 Jun 2022 07:11:21 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::69) by CO2PR07CA0051.outlook.office365.com
 (2603:10b6:100::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 28 Jun 2022 07:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 07:11:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 28 Jun
 2022 07:10:54 +0000
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 28 Jun
 2022 00:10:53 -0700
Date:   Tue, 28 Jun 2022 10:10:49 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     <jgg@nvidia.com>
CC:     Tao Liu <thomas.liu@ucloud.cn>, <linux-rdma@vger.kernel.org>,
        <saeedm@nvidia.com>, <talgi@nvidia.com>, <mgurtovoy@nvidia.com>,
        <yaminf@nvidia.com>
Subject: Re: [PATCH v3] linux/dim: Fix divide 0 in RDMA DIM.
Message-ID: <Yrqped6TSUbmiWg9@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220627140004.3099-1-thomas.liu@ucloud.cn>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96c89bff-5b01-45fc-5e80-08da58d5672d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3034:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsJX4ovt7H7vLlqZftIHCPecKKf6K7K2/ncVSkwUDj5WJD47hMp3/gsmDdPgq3ci43T/92i42dYUq99d7YCf96jNwP3PA+rNNuzKTrtqjPZcaCKHcP1PRX5LxDfV08B6jTWtl3n27y2PJ+/xT5jvFgLj/iDOXkxE70SkM6M9Qy+QVOgG4tyJ4H6KjjeYP7+tYN3gP6aOa13LgflTPdnUk8azMGJupeDPVngG9bIO0iBpwVjFN1Sy7bl6YvyYGJ35hs1bdOPti9kYKXs9nxxw54PsorVysV4pLPMWTCFKvZgGUmUx7D6XbOMJbe7eZHo9H4Gb6d/mgzSF8DH2/t+vuNY90Ou06wBjFA44DDvTqIw1fJ0lGtUwb6P+gUzYCmZT6wmaGfRgRMdIm3tTmnPyOmMMkPdg0mPT2+nIeO1Oi/GYEzVbdy2elK6RpeR7dnHbzoyTwSxfTXPwNtpX9CAoGDHGPus4i8XDH0kGJ7LlRQVo5guQL39I0kN6PepFWE0O8emaF2eJkne2mF1n8tK9+r2XKms8+2Bvagqt4jYahZLPAdGPewwlIxYWgdk/o7590KlCV70JQnmSdKWj/ziV7akyKnScOsGEANPAtJtOwuix2ZWWk6Z0dm/cSqDAfs1LnIWL8OVjqPBPyxWhD+c8wWsrXCKVJsBHQuHxExZ3mKSEe9ke3ppQ7v4rl7DJ1b1Rnk+oc6QtftFZSeCvYRw3Z9j+9yrJjlJCwhkEevOzYq8Wrl3/gRdwzaj6j4+jOe5mP3dGP0Ls+VThNCyhy5dq+qwFR0V/q/SZIdMcbayWhNGQ/aha4bLSQzQkZWePFTaLlTBYdjaKQ3jlFotCztPWkg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(40470700004)(47076005)(83380400001)(16526019)(426003)(107886003)(478600001)(186003)(70206006)(41300700001)(54906003)(26005)(336012)(81166007)(36860700001)(6666004)(8676002)(356005)(70586007)(82740400003)(9686003)(8936002)(6636002)(4326008)(40480700001)(6862004)(5660300002)(2906002)(86362001)(316002)(82310400005)(40460700003)(33716001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 07:11:20.7557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c89bff-5b01-45fc-5e80-08da58d5672d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3034
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 27, 2022 at 10:00:04PM +0800, Tao Liu wrote:
> Fix a divide 0 error in rdma_dim_stats_compare() when prev->cpe_ratio == 0.
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
> Fixes: f4915455dcf0 ("linux/dim: Implement RDMA adaptive moderation (DIM)")
> Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Acked-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/linux/dim.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Jason,

Can you please pick this patch to rdma-rc as this divide-by-zero
error is caused by RDMA app?

Thanks
