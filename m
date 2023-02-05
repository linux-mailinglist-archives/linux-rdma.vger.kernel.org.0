Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778E168AFDA
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Feb 2023 14:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjBENGL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Feb 2023 08:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBENGL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Feb 2023 08:06:11 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E808DC640
        for <linux-rdma@vger.kernel.org>; Sun,  5 Feb 2023 05:06:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2GSLrb9L6/SUl7k+nqkp1T7oen8tNjVPdqIywtRtp028KuafJfTzmM1UqU6L6Wjkvx01929IHrbDgTlKF4h70j6Cz+WlWxWKaKfVdwR0DeLBXzedFA/ewQ8E9gGv3AzvHgZeJUH2lXoe4diWvMrsiz4RTtXND6lCkAzQ6kl/5CVk/W1BjXgUl5IUbqeT0B7Y5XBeF3TnZRl+HN9E8AYbgOKxMF5ZDGVfJjpk8Eo1MAig1qAutLZzCnd5TbJgED9WV1oboljP8nkLS3M7PjQaiyibpU7r16rilPTqejkADzWq9DvfhMlvwJ6ZGnCC7POH5d3nJgSOWAkqsNmnsbh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO6K4226dz7MkZq4/TVd2HQCCS8rVjhjnU/qutGA3o0=;
 b=HkCNgatPZHEYyf9AXin6ItSaXVbpDVbqL+pWf5vGWW3m7qVaLmqhQ9Zl0pG4q6ow9/S5irYgHVpBeTwePHtK/kHmOYVcoNxe9Alg8Nr8SEpK/G7SPGFu9wCgFZAHRhSCGVsyCcPNX2AvHOrd7wRQEPJxX2uRnbQ5MCTAxgYNkKHe0L8NVkySjX4GU1lP/KOPCFJ3t2dbDbomGj0/vqzLMDBklr1aDPSBn9yFgD0QkSPNvjAMnxOtKBskiA1JPxuD5iff7R6IG66Xl0K8ovaAmirbl9LAoRAyU+hGpQolmgVwCFlrRIcF68Ue0ZhV5XLT++zqidgO/to2sKujUerlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=zurich.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO6K4226dz7MkZq4/TVd2HQCCS8rVjhjnU/qutGA3o0=;
 b=mmKbosAGhHJis9EsSnQdS4lLdTdyAFi6zPqxi7No3ZBKrZqeaUJZRjss03Gq88zjLMsbWwmlU5BkBmjQGtiXUR+NxYoLFu4Ck+1uTkDk4KQjZr76qIVcsi/sE8IY/rgHuZFe2jCijEjYAnV+9IJlXEYqA5sfAzCz/rBD4bOak0G+vftqNcnG2/CoEKQEChBZCWEsQB9R1uWxdCNKKVSjnMURxbKL+dMC+hfAkgi1Ay8YFTUpq9sBi6mCYhNPiTu/458Gw1sl3Ok2FtJGURqmPefpRyCbKCutKv1yUw5jba73swmeRv6KHd63ie5vsuoD7xkWRbV9lVPaAnfz4m6mkA==
Received: from DM5PR08CA0048.namprd08.prod.outlook.com (2603:10b6:4:60::37) by
 SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Sun, 5 Feb
 2023 13:06:08 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::20) by DM5PR08CA0048.outlook.office365.com
 (2603:10b6:4:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Sun, 5 Feb 2023 13:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.32 via Frontend Transport; Sun, 5 Feb 2023 13:06:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 5 Feb 2023
 05:05:57 -0800
Received: from localhost (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 5 Feb 2023
 05:05:56 -0800
Date:   Sun, 5 Feb 2023 15:05:52 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
CC:     Alistair Popple <apopple@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>
Subject: Re: Re: [PATCH] RDMA/siw: Fix user page pinning accounting
Message-ID: <Y9+psKn6GrceGeG3@unreal>
References: <20230201115540.360353-1-bmt@zurich.ibm.com>
 <875yckmrx0.fsf@nvidia.com>
 <SA0PR15MB3919BA817A04C53AEC8B66FA99D69@SA0PR15MB3919.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA0PR15MB3919BA817A04C53AEC8B66FA99D69@SA0PR15MB3919.namprd15.prod.outlook.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ab2462-5d22-4de5-b938-08db0779bee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9E4qngNZoyaCxdpoFF3AJhtTE3w6bgGAUkISRMzDp6Z8k5r4Gk79pfkenhP+J2WzU29cjVChvmxciqpRQaMR0+RzbbsCS+qnLClWIyCLcDAcWDvlimaCWyxbwIi0bk5VoC26UnleLm+NA921YLsNmf2ocV6r3I9XkX8QcI8H5fcPeEEZR7f2/K8D0ehovD9fIgKtMNybDcdGIbSS7WCzNBaef+WOX9yzpNs0W5Nguat91BRnGSOv0m630Ef2QdhWBfZWGEkNE4/XuowX1tZcth/KwPmb0C4I+jAbT3m2HDGkwthdKN8fcPAFkP02LR/IKzcxC/LKrIUcRSglsJFFEBpLMjZUVGCDWwz9talYOs9/59eBkQKrKD4CdBg6EJyGe3U1TvCnNeaeNYX3Fjgs9YpUpxpmdMdmrMJs+rwOXckSsaG9pcXygOuMptaHZ6PYjSNEHihcLIm4lOe5TWchiV+v3RJ+mFDLIjQyh4C7b9senAt9tMtz4TTbiy0QTTESbFMmPNI3gUBtMgQm1jtU53K4qI1gQxWekXlICZxXxyKopjSAdkyCtQWGVC/68sMuCVi1ZYoZeQ669cwcB8/iW7+xQgibc3VWRN5bQZQepmL7ldjTUn/MUhRsYL3dq3zXDgpyWbxyVswRcSTIVT52T7rkrM2qDvvGyYeYhDPZehptc8qrLf1bAc3GmrJf4M2VUqlZopuDGFYHwFMLsb93r6AJeJ2HEGykPW9BUy6+MRo=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199018)(40470700004)(36840700001)(46966006)(478600001)(316002)(54906003)(4744005)(53546011)(5660300002)(16526019)(6666004)(107886003)(82310400005)(26005)(186003)(9686003)(33716001)(86362001)(40460700003)(82740400003)(426003)(7636003)(40480700001)(83380400001)(47076005)(336012)(70206006)(70586007)(4326008)(8676002)(6916009)(2906002)(15650500001)(356005)(36860700001)(8936002)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2023 13:06:07.6527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ab2462-5d22-4de5-b938-08db0779bee3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 02, 2023 at 09:04:06AM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Alistair Popple <apopple@nvidia.com>
> > Sent: Thursday, 2 February 2023 08:44
> > To: Bernard Metzler <BMT@zurich.ibm.com>
> > Cc: linux-rdma@vger.kernel.org; jgg@nvidia.com; leonro@nvidia.com
> > Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix user page pinning
> > accounting
> > 
> > 
> > Thanks for cleaning this up, will make any potential follow on I do
> > much easier. Feel free to add:
> > 
> > Reviewed-by: Alistair Popple <apopple@nvidia.com>
> > 
> 
> Thanks a lot! I'll resend for the last time (I hope), having you
> as a reviewer.

You don't need to resend for this. Patchworks catches all *-by tags and
allows us to add them automatically.

However, it will be great if you write target rdma-next/rdma-rc in
subject of the patch.

Thanks

> 
> Many thanks,
> Bernard.
> 
