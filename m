Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688F75BE405
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 12:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiITK6u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 06:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiITK6s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 06:58:48 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4F26CD14
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 03:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0u5odyUejhHvsI1hRn2MpeCK5A0cUjcHcqS4Oq3Di20lmcT4xqgMc3us9L/y+aZpcYTQNWup5TgeMybq8EXWGWoEoDdz/AmsJbUaEVxUTGKbKuXscHgYjccR+R1QCJFNroNqTECti7JPbGYf39fZxgw/dZQX9r7yfZdIlh22OgejHPFc8fpBlfnUEFCvEPVlpQ2RIC7bPWheu4JPXi/s6E4CkYd5g03NNrIFeiIY0Yjc+ZblT+Pe+LVR0lcgr0zMFa4N2o9zHS+/B/4Ap8loi5MUsDfq7xxiv/UfXrhooedXhGKKpuoLwH4cgZBjuk2KkYn3dg+h2K8hAgngXG7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAbxvjmaYqGW2y93QjNsL/TKWyQJJtOAgCAkdXn+ku0=;
 b=CyA3pt9Qy9z/TTTSbQibIljftB0201yZa9WMZ8ci7ONT0OhyYvPeJZX7tVgWjCBUWaZg9xJ4o8RLKPRLn4CAhAeEQexmli5VLea7KDx2Q0TScV1M9+zF0tGoX2oPGRYZDkTCW2oEW8kGpqfv9M2fj3RlbV4vPPGQVo6dBGKvvpP8dNOiy6lJWkFK4IXV4CFzc0btA6V2f1KFNLIhVi61ogiF+6FOHe0tFwStf4YZdHZzDX4jy77HTj6nGeMYRnGY0NS8PQ53KCvA48C/0qcj5TbN44Xm7NHofNdUxxQ3m0uPgrQFziFEnFgKpQ+hoHKQX6UFHe8Okk8YdP+hjy+oAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=fujitsu.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAbxvjmaYqGW2y93QjNsL/TKWyQJJtOAgCAkdXn+ku0=;
 b=RGGKeKli8NeHFmIeMXyu/BFBKimFlq9cXWXmGrJaR0Zf8nvI22fp31fYO8Yv2sDCh9+yiIH8dvOoaX21l5JauqlzUhLacwNVjdHWFtbKBMAvrtmISC8oPxDR8D+DI4m3wFYFywzfVaRa2H+iGzo7PABSlmqO5Z8ByRber1A8OjgXBx0MlkPQHthAZ3a7qlxVhbuos/5lfPzE1N+Hi7uAyXOF6Q7/lzHbLf+N3+PO8kqhq0QjdLRUA5kd0fLplQ29dkRktgF325Vs6o+s0NYFOvr2PQCOG168lD45RdFrtx2UdvZNjtBjwPtOmoCEzttpKwYPn1KaGzkgaleOI9Fh6g==
Received: from BYAPR01CA0058.prod.exchangelabs.com (2603:10b6:a03:94::35) by
 PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 10:58:37 +0000
Received: from CO1PEPF00001A61.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::40) by BYAPR01CA0058.outlook.office365.com
 (2603:10b6:a03:94::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 10:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00001A61.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Tue, 20 Sep 2022 10:58:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 20 Sep
 2022 03:58:19 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 03:58:18 -0700
Date:   Tue, 20 Sep 2022 13:58:14 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
CC:     <jgg@nvidia.com>, <zyjzyj2000@gmail.com>,
        <linux-rdma@vger.kernel.org>, <liangwenpeng@huawei.com>,
        <liweihang@huawei.com>, <yishaih@nvidia.com>
Subject: Re: [PATCH 1/2] IB/uverbs: Set LENGTH on IB MR in uverbs layer
Message-ID: <Yymcxtp/5eJh9JtT@unreal>
References: <20220908090708.3997456-1-matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220908090708.3997456-1-matsuda-daisuke@fujitsu.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A61:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: d6289a5c-189d-460a-d3c0-08da9af7116d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJH50hjZZWG0vry2y51RkHUD01UjD1qY11gel9ZxcKozP7l50k4zm9gbdCB6B9atftRZ1N6F0l6fCcCj2KU+EPAyeAv94UEbpzpjA4//AIcHilPCqHOgwRpsqxlgzt/DN4NVm3j91oICl9dNm3xI9UMsEV8trpsstCJ0/SoYHZZrmhjCpImOx11mYmc6mYWOiJPkbW0KUtF8eeYBz4/Iy3nt+F2pQpj7XT1TC6USytWsoOlQRQ5tmojGPwbdau6s8CyOlMH/wgVXDFVBUl/9YC/c08kUzv7BELaIHy09iVsfO9eyStA8ADx4KqoW+1S4zhC9x+YjInf6yZBuFZsB27XyHLdV1V0Yz8+bLbxuaq2+nglCyZxO02WJLfMYwvtd4vJFPcYC2OsvC5XCVYyM1NjTFC8PE55gNq6DlHzdCklDw8rMvoamrKQhzzK5CU1FhKjLSISiGm95SWluw5Y2+Gzx0TDXQZgT4L3PTpbd4EeI3UDqt0WTEralj9Nkg5cXWW/02qtI/AKjah6OHOqFvi4FuwuA5IgXurSVKSF5H3s46ptsnf0uDhoV/DsL5ixyvksM+v43OAF350pcNpZlMl8QxDukc6ckHI5OWxPM92QfFS037FR377+Hzm+bPq5v4vhd6egE3Co45nQQ4Z9zI1e53/VXO6kgU245sZqYh1DuMEaVZ22Sywte8KWboXOc2vKCShKSchs9Cu8ZBkFrIVchZppq+44xlq3mHFweINPW9XWcnahwRGUO2FHu6Z4rBoA5UVQoqFizNKeZSS9KWQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(9686003)(26005)(40460700003)(356005)(478600001)(2906002)(4744005)(5660300002)(82310400005)(36860700001)(82740400003)(7636003)(86362001)(426003)(186003)(16526019)(6666004)(107886003)(47076005)(83380400001)(40480700001)(33716001)(41300700001)(336012)(54906003)(6916009)(8676002)(70586007)(70206006)(316002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 10:58:36.4637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6289a5c-189d-460a-d3c0-08da9af7116d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 08, 2022 at 06:07:07PM +0900, Daisuke Matsuda wrote:
> Set 'length' on ib_mr in uverbs layer to let all drivers have it, this
> includes both reg/rereg MR flows. Also, this commit removes redundancy in
> each driver.
> 
> Previously, commit 04c0a5fcfcf65 ("IB/uverbs: Set IOVA on IB MR in uverbs
> layer") changed to set 'iova', but seems to have missed 'length' at that
> time.
> 
> Fixes: 04c0a5fcfcf65 ("IB/uverbs: Set IOVA on IB MR in uverbs layer")
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c    | 5 ++++-
>  drivers/infiniband/hw/hns/hns_roce_mr.c | 1 -
>  drivers/infiniband/hw/mlx4/mr.c         | 1 -
>  3 files changed, 4 insertions(+), 3 deletions(-)

You missed same change in ib_reg_user_mr().

Thanks
