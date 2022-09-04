Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D025AC318
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Sep 2022 09:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiIDHW5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Sep 2022 03:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIDHW4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Sep 2022 03:22:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB4345F63
        for <linux-rdma@vger.kernel.org>; Sun,  4 Sep 2022 00:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvjjZ+IuU1CJCTQjhPw4P4aFrIf5XmwuBK3OvXQpCbR+x8+5NvN65z1dayMw2oaQH0Nmuw3RmvA5vJYGihxfiW/01OK/6WBap7rAt7nlv9FSFmTQj8EMtQEIM0BgjsAocMlWAjV9AuugdfZj/V8NP1jeYftuyYkwj6o2m3ZhIjG4u51znmeRr3FnskAC0h8G3Bbz4ySpBeYq+rd5QjDZoE7tCDighGckRGX6pmSV1PhnHW6BSnOxgDTt1Brjup39JT9V7EHQqa/2WagkxZ5NlXAuxxu3lXUM2ks7rhwVo5q9ooVOz1M44XC3rjL99ruVr/Hsmd+DFp1q6Xu9GqHTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enzoqwDTJ3gf1voXu9m70MnUbE7GVzq2eiQYJxQN1eM=;
 b=PsehutulrC3qFdxToBO/T73JDTL/g6V+5Uf12CaYor4XWhVcWG0wTOJHCWPHbKff2nI4hB2P6hXDJsD+QVESGZ6OgqNBMnS0h91Lf8XOsk09G/dB2CC36/0HR1Rm+ZLmEJTpH0xZP9uPAcX1mx2Gnu9KECF0sX+GCQh0HxllngAL8gxjWL5R0q5UHzT5akaX92D/frLSnLi8QdN/yXb3V8fY48mP+2IqE91ssJXhJT7acshXmPUJK3mxsPfrglwgWEB49NDoVOp+BDEsZ6rzwBr/oVRdAIdflk48BBmG43BFufHtTgTawcFLUJBarGHNqKotaHPm0+JsKZkDzcQ+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enzoqwDTJ3gf1voXu9m70MnUbE7GVzq2eiQYJxQN1eM=;
 b=HAk0y+gw1CswtUnozBbFK29Kbbi+mSySdHbtjgYp2EXpX2lLujL5AnZQBpFUGVN29+7feLGU6bOrU5ky3dZOaHKaQXRdpSV7MLlTmPpmB8+ZzZTjw1ukyCaxGN13XpV4FlVida6bmjBuF5l7H31R0sLhXmigJval/UbWe5jDM37797n4m3/geCrLXyigdgU990FPfNNvWWeIbS+7TTiHx4JjS2oRJ1I1xq+n9l3Fzk5ihiCKlxOIJWkoZbptLCi1ePFOWZ1ncB4oQZfIg6M/VeH1Wc34NvJ6Iz64n2nFR+4CP3WDTgUSfGTvRtYa4bfANBrC/eiLKW6CaxRoVeDIHA==
Received: from MW4PR04CA0079.namprd04.prod.outlook.com (2603:10b6:303:6b::24)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Sun, 4 Sep
 2022 07:22:54 +0000
Received: from CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::ca) by MW4PR04CA0079.outlook.office365.com
 (2603:10b6:303:6b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16 via Frontend
 Transport; Sun, 4 Sep 2022 07:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT076.mail.protection.outlook.com (10.13.174.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Sun, 4 Sep 2022 07:22:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Sun, 4 Sep
 2022 07:22:53 +0000
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 4 Sep 2022
 00:22:51 -0700
Date:   Sun, 4 Sep 2022 10:22:44 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3] RDMA/siw: Pass a pointer to virt_to_page()
Message-ID: <YxRSRIOs3gEEAyGN@unreal>
References: <20220902215918.603761-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220902215918.603761-1-linus.walleij@linaro.org>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b6c4ec7-a19a-4774-5a05-08da8e464854
X-MS-TrafficTypeDiagnostic: MW3PR12MB4394:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AEmQ9uZfiKiqqw3+Q22eZ2e/25HuB8dcFadN80w340tg44T2dlJs/Fu5khIprArN+WGsxrilVZhpVU94+fwiFrcEGJkrWVxG/uxFjDRH5Qs1DBysp8+b0ozMAhqrn5HT4H1gL8jBYpWpKKUDwDIdvZMklS+fPlBnft4aKBLqLr+OcDIJZU0lyoRLzJamPu7psfDFs0wkwhZbcRtuzfROAzN2XVcKU+iYSY3iSVhl8qrxFycxM0fvhT28UQByH0h5k0R+OYuKdPzS7bv+AJdoOizOWM8zlaxYlYUHIR59tZbGrthunXPVQkGv8gO+/kRP2thXt1QHB0Xmzlslo67JW+1Zf2TKrgyiuTW+U0BZAoRBdlKxMtb5ki+HOyeaUlh72wo2sARu+zcwAv6Jq0gaNWmOMOjIXF7UWFVZy/u3zrjiVL09B78uWxjMqjeXT1TdjCSDJ0ClZN9aGQtHtdOKFLjZc8c3JUl6Cr7I+7B0xqq3t/vgF1i1PTh6qElvCZ6Gb42vMhmFwgRldUo0v2HosiwyJgzf2R32LZpcBMEIzbxb0tOY/VfC+p+792IgfrAEsL+0H8uGRe6bUYxbC1B772YAdgfzfQLUIaxvbYARu3p99aoBWVUE252oVph8sRv6SpjogZ7IFOfsDoUiaN1NuBCuzLjg0LehnDhu6P1etcmnCqB7SZYs5YI+Zmm1HU8MJHCu2P/h5vbSIgIVVJa9MsKzUqDXSzLvzsioZv/FhMxQlgxJKYMqy+xZEr6JCLrL+Ez2Csxh+mqyu68vUD5JWT2YHGDKXS2M6miUxLBjP/ZkHj8NAudbBBi5IUc5E7e8xw3/TA9+j7jnn9N98FjZg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(376002)(396003)(136003)(346002)(46966006)(40470700004)(36840700001)(33716001)(36860700001)(316002)(6916009)(54906003)(5660300002)(2906002)(8936002)(70206006)(70586007)(8676002)(4326008)(40480700001)(41300700001)(478600001)(82310400005)(426003)(47076005)(83380400001)(186003)(336012)(16526019)(356005)(81166007)(40460700003)(82740400003)(9686003)(6666004)(86362001)(26005)(36900700001)(266184004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2022 07:22:53.7595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6c4ec7-a19a-4774-5a05-08da8e464854
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 02, 2022 at 11:59:18PM +0200, Linus Walleij wrote:
> Functions that work on a pointer to virtual memory such as
> virt_to_pfn() and users of that function such as
> virt_to_page() are supposed to pass a pointer to virtual
> memory, ideally a (void *) or other pointer. However since
> many architectures implement virt_to_pfn() as a macro,
> this function becomes polymorphic and accepts both a
> (unsigned long) and a (void *).
> 
> If we instead implement a proper virt_to_pfn(void *addr)
> function the following happens (occurred on arch/arm):
> 
> drivers/infiniband/sw/siw/siw_qp_tx.c:32:23: warning: incompatible
>   integer to pointer conversion passing 'dma_addr_t' (aka 'unsigned int')
>   to parameter of type 'const void *' [-Wint-conversion]
> drivers/infiniband/sw/siw/siw_qp_tx.c:32:37: warning: passing argument
>   1 of 'virt_to_pfn' makes pointer from integer without a cast
>   [-Wint-conversion]
> drivers/infiniband/sw/siw/siw_qp_tx.c:538:36: warning: incompatible
>   integer to pointer conversion passing 'unsigned long long'
>   to parameter of type 'const void *' [-Wint-conversion]
> 
> Fix this with an explicit cast. In one case where the SIW
> SGE uses an unaligned u64 we need a double cast modifying the
> virtual address (va) to a platform-specific uintptr_t before
> casting to a (void *).
> 
> Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Add Fixes: tag.
> ChangeLog v1->v2:
> - Change the local va variable to be uintptr_t, avoiding
>   double casts in two spots.
> ---
>  drivers/infiniband/sw/siw/siw_qp_tx.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 

Thanks, applied.
