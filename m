Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F89A4B80F4
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Feb 2022 08:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiBPHHj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 02:07:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiBPHH3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 02:07:29 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545B4256EDE
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 23:06:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMuhQxBM1jttdE40sVj+qipSlJuKM3S5CufIquntX14wvxyiPswKUmlig4E9d4BX4nA4vYemgTUBw3qRK4tjTAP44FvsTkUphsPC1fvrxaNrHEa62+SnFOflPbVJsUB+KBd3XwT2ocQekAbTlWBFvrARRM1z3370XV+xCnRlM9Yg5TYPmVwG+E+UhCR8gGkyTc1DTzDeuAUCzVq/6QyV1hhDVaizh5FdKGJX86XcOFX1WxOc92coIvDKi5a3th/5IlnNMu1Jht9Jjf/H1ciukogi/qz35oKJoKlzUnhqIo8aFexodvK4bIABxdr3M5gQWXoQYw7i0ctOkwRLyXRLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsVy5ZpxCaIIUAVb7Dj5OF2nonZAAOBAQS+3ZuCZdXg=;
 b=XeR8uOx5jhfSwIIWgz/AJGBvCxHWGsFKisGCZlvJpHHiXAdBDAbXiY0lt/wTaxm0hmu67CjHZa7tLj4/d2n7JWikJMjFj2Q+6JNZwrQsEFnrTXd1FOrTuMg/Eutbpuyf13dTJA/+QkjOpVZRMRbYhxr+J475RUqSsvrXujfw8gIbMNx8xL1UT685q6/1jxW8Jg+dsBeEcfHwOu35SNnrdASzWTT79I+bL2qSn3krTzk1pA4LrkiAD+GlCGRL+4D0H0g39kQNK1OhWtFBQrq+fnWzlPnmif+ydVVEWWtxhgbqL4f4Iz2Mz6XTUCX4xeiKSfBHaHnBLosKiL/+TMFyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=i-love.sakura.ne.jp smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsVy5ZpxCaIIUAVb7Dj5OF2nonZAAOBAQS+3ZuCZdXg=;
 b=QOWVxyaMp47+8RF2NobEOhgWKhaLjw18k8CU8KUAR/+5LC90Tf6XwKap93dZchdKzgJkw8klcvkFw8WoYTQ+w5o8oIFwrrsDFjlNfAGbuEF4HB41eNJx1NnuPPwIal4RKYSyF2TsBPRmX0vdogWtt3zai76950kBHcDLLVwipaEFACkqqaJ0Ny0lIZicRoOUyYKv5B34yIxP4LiDZbg5/qEWX787t4/kgykwetCiaUWPSV3oKy2Ds3xmEXOwjN/svdmL0u1WDSh71YEnDNqNvhiD6Og/GyCI21QS4eR2ZO3lz4V6vgyfjlvEyGzFSiGL0ALNDYqTFo6aOBoCZnGhLQ==
Received: from MWHPR13CA0046.namprd13.prod.outlook.com (2603:10b6:300:95::32)
 by BN7PR12MB2788.namprd12.prod.outlook.com (2603:10b6:408:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 07:04:12 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::c4) by MWHPR13CA0046.outlook.office365.com
 (2603:10b6:300:95::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.7 via Frontend
 Transport; Wed, 16 Feb 2022 07:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 07:04:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Feb
 2022 07:04:11 +0000
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 23:04:10 -0800
Date:   Wed, 16 Feb 2022 09:04:05 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2 2/2] ib_srp: Fix a deadlock
Message-ID: <Ygyh5aKVZeCCBnPi@unreal>
References: <20220215210511.28303-1-bvanassche@acm.org>
 <20220215210511.28303-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220215210511.28303-3-bvanassche@acm.org>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d653f77-b1ca-49c8-5017-08d9f11a8945
X-MS-TrafficTypeDiagnostic: BN7PR12MB2788:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB27886E5A838D5CE3BC970764BD359@BN7PR12MB2788.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +R7Z0I4bD7quywrQdNyTUBTehq3yxLcRK5rJ2ATsnehpfla/gg5pEXBTO/HmRpjUCrfwWGY/DlZBMMCEbX6eaagax006pHDSo0W052ipbRrqbgLmwEWUwJSrOx3I+vOw6j0dEDpAs/atwGC6eGj+edDzliI5bF/oAY+NURJcKSZfcRTWDB9qQMRoeI8NkjBVoqqAOMA7iTuKoUdH9y19SEP33LGDY1YyJhTAcMljCBEtfSJR78GpFMo974C+ZSW7IIFYlE8GbKCXcEyCADlrl8KjU11D6XPEng0E1d9LFCMUOuysiSyaQOcHKaKM/OtlrJzNd/nJZs15u2X7OCbQUNNu0TPkIOtPOG5quy4OXsZyZB89aXRb4gBg4pp9sP4JAUwHmOCecm248s6/gI0yvC8YYfAyqNGEJtFuXxxzrK6tXt+3fXTWq4xZh0ExT679fUMtxlSd8WBRk0D2N4IXpwtTio+L1feO32RGVJ7k+26pm3kt49fqEwj1qIerBx/Xf+GYfRe7lx6F7De0zBz5L7A7/GbR7Yb1+QNTtYVkZF6aohRWI/Cp0/C+8/fRDhXnrxgqZ0FBkeiLk578JKkX/RpYsKumCrn+MZCjK5zyfFsnS9B2a4+XQr2eWDvG49v5hVdxPlXeha8kEY5CEymFhAimDlOeGALwIkIlNKFxjA1mPAb1A1iG+Nuy/ea4Qvv5vJfSF/6VXThVq8efUkYvzg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(7916004)(46966006)(36840700001)(40470700004)(86362001)(4326008)(6916009)(8676002)(356005)(40460700003)(70206006)(81166007)(4744005)(70586007)(8936002)(426003)(316002)(54906003)(6666004)(186003)(16526019)(26005)(5660300002)(2906002)(508600001)(33716001)(36860700001)(47076005)(9686003)(83380400001)(336012)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:04:12.3006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d653f77-b1ca-49c8-5017-08d9f11a8945
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2788
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 15, 2022 at 01:05:11PM -0800, Bart Van Assche wrote:
> Remove the flush_workqueue(system_long_wq) call since flushing
> system_long_wq is deadlock-prone and since that call is redundant.
> 
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Fixes: ef6c49d87c34 ("IB/srp: Eliminate state SRP_TARGET_DEAD")
> Reported-by: syzbot+831661966588c802aae9@syzkaller.appspotmail.com
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
