Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96C435D7C9
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 08:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243312AbhDMGMF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 02:12:05 -0400
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com ([40.107.237.55]:16826
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229748AbhDMGMF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 02:12:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0j9K9JZF/GkEZ5+lUzrj1IhksZQDkzt3R3qFsa1ZG5lgcUPcQ4cN5AIg94TbYX2/KmF7uzjYKnQqEbvlUOoAYW/SnfftuGUdU+S/l/WtMp5uq0FPEI8CZH3H5LCQE/kzdX3/FSHNJv04Y5b6XSaSODdekkl3/kswwzFaFyeho8Wm1IVHqCk2dvaLFkjCBiIyhzIut1teYwMsQDo/aUnkZOQHsjoYpSX2eEUpOmtuU007QKUlufAusMHiCw3sRx7SQhL4KIwsKyEiAcO8YGmRtipy1cOYZZrisrbHEW7tIlyACRfCeIkcR8Qx4+Fx2rqrZXcfFZHNOGFU70sVlSDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHNhhkkfoKY0x/jjyGrpkscY6YBhqzSHzp/J+55hh4c=;
 b=X7MNCRHskxSdWfeTgpCKZ1yD0s+H3MCMow1Rvh5ixT3zBWgKEEejmheFxdMQtvzFZbKimyZiz8RE82yUpWcUVKPz0xW/qXeq8bJknFJ2RutXIHPfu5kwbwxNz4C9VGtywjj5P7/7StfRUg2VGXu+XBIav22Rv7IOQkCfBRRSellMVoUFqyHzH/MZBBr82+ZvwQxjag9xWmCpxJXc23cINWdQidnZSEGzSjm5Jf4RRfI4DCmTFrxFlViLc6p2AQig8/i5aIPDQxWlTWBfWNigu/49QED5dVxENNPEvQl20Q9jP6iyz4A6MBxEMSAE3E4qzkGBv6YCrqZfq9NoVrNZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHNhhkkfoKY0x/jjyGrpkscY6YBhqzSHzp/J+55hh4c=;
 b=DozDlmfCOa8NuzdGtPEqkX0EWrs8D/0osv3cz52Oqm09nKBEBmjx7kzXznz5ODMO+6l7fQjF+LWRG1Iv4TfBP/eqg047JAfi7xhTQ0U9R2QnALWg2Z9Eh5ChEL+VBAUKuhQyLPeWv3nvcds2068suAlXoJUOsc8i/fZOEEbMaLv4xwD8xd8gfheOu+gGNNLDlyLurz21GCiKn/fYTTcPNnQsUjUYb2+ppaFFr5wZpb0c1kRvVBXvJmIbf5DBV7E5P9wQcRFjWChIcni9WHgNaJU5uvVGuCSovq/bvnXx32sbxkFtpXBgNhi9Nki/BKUgkjTY+8TMUhw9knODrmK4FA==
Received: from DM6PR04CA0016.namprd04.prod.outlook.com (2603:10b6:5:334::21)
 by BYAPR12MB2887.namprd12.prod.outlook.com (2603:10b6:a03:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 13 Apr
 2021 06:11:38 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::24) by DM6PR04CA0016.outlook.office365.com
 (2603:10b6:5:334::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Tue, 13 Apr 2021 06:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 06:11:38 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Apr
 2021 06:11:37 +0000
Date:   Tue, 13 Apr 2021 09:11:34 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Zhu Yanjun <yanjun.zhu@intel.com>, <zyjzyj2000@gmail.com>,
        <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv4 for-next 1/1] RDMA/rxe: Disable ipv6 features when
 ipv6.disable in cmdline
Message-ID: <YHU2FvDsHBFtov1O@unreal>
References: <20210412015641.5016-1-yanjun.zhu@intel.com>
 <20210412184407.GA1163957@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210412184407.GA1163957@nvidia.com>
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 418d9ce6-e4f4-4d52-f3ed-08d8fe42ffb0
X-MS-TrafficTypeDiagnostic: BYAPR12MB2887:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2887EB5133D120756E39DA94BD4F9@BYAPR12MB2887.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDHEz5wc/FioCMP5o4R4LXT3sr2QX6p6TwIzIhQ90mY8fvHBrlqJ6hWKDCWWdcMEZB9dtV1kbM/UiKBTEXpjL4YPNJSqjVlZ2TJgY13rpTFHB74i7dH7XNOIjip8qGkkSsCLP63+3WkUWYuPoeCaBfZ6O1siBqaredvl8hq/vIaFnpXjrJPtbqnTUvLROp5LJNbIiD3NdPewQdg770zVUoEre03n9/i1qMBD7swB4nlDNuqguQXYOA2llLwJprd5vEHy6gPAgB8bF293WuBcZgO8N6c4cy+17CwrWLigiKw4Xl+/e+0qb/d4erIb/lu04abXTpBenwXy2TvVY5BWXlXmuOryHUDUHecvzm7DQHPGSDx3GXrVS5IbLwUdpyH6tjUddtX+TPTQd7gs1mDlnpDdLvhqOKeTRuNgNxUWz6NiyJB6GzXets4uVvy1sz1idvi6iSd7anPFGxNr+08w69Aijz7sJs0EvEal054RVXSMz2811h79lkYXtpyI5Yi6OY30WqT1++vbGdTmLoy9ZkWT1wRg1uOY+FUv97ySCDqTw3AN1CKilJFTrcQKFQGJbrajbrXpct5mdid78+UBmunlv7fDQP7dG0jA+jtVtgbvBuTjzEznwTsIskCQF2gzraXe3lAOohfO3h/wiSKHGfuEY15lMelSeI8rJuXIZAB/2NzXdXNMdhYocEpf+aadSe8B7InvDMWcfMCh6/8dMx6xLnln0Gg5yHBpxcDPJX4=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(7916004)(4636009)(376002)(346002)(136003)(396003)(39860400002)(36840700001)(46966006)(82740400003)(478600001)(8676002)(82310400003)(186003)(6862004)(6636002)(36906005)(5660300002)(47076005)(336012)(966005)(33716001)(86362001)(6666004)(70206006)(16526019)(356005)(54906003)(316002)(83380400001)(2906002)(70586007)(26005)(4326008)(9686003)(426003)(8936002)(7636003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 06:11:38.2779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 418d9ce6-e4f4-4d52-f3ed-08d8fe42ffb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2887
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 12, 2021 at 03:44:07PM -0300, Jason Gunthorpe wrote:
> On Sun, Apr 11, 2021 at 09:56:41PM -0400, Zhu Yanjun wrote:
> > From: Zhu Yanjun <zyjzyj2000@gmail.com>
> > 
> > When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
> > in the stack. As such, the operations of ipv6 in RXE will fail.
> > So ipv6 features in RXE should also be disabled in RXE.
> > 
> > Link: https://lore.kernel.org/linux-rdma/880d7b59-4b17-a44f-1a91-88257bfc3aaa@redhat.com/T/#t
> > Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > Tested-by: Yi Zhang <yi.zhang@redhat.com>
> 
> Is this signature block accurate? I'm pretty sure Leon didn't look at
> this version of the patch.

Yes, I didn't look.

> 
> Did Yi test this version, or is this leftover from a prior version?
> 
> > ---
> > V3->V4: I do not know how to reproduce Jason's problem. So I just ignore
> >         the -EAFNOSUPPORT error. Hope this can fix Jason's problem.
> 
> Who is Jason?
> 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> > index 01662727dca0..b12137257af7 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_net.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > @@ -620,6 +620,11 @@ static int rxe_net_ipv6_init(void)
> >  	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
> >  						htons(ROCE_V2_UDP_DPORT), true);
> >  	if (IS_ERR(recv_sockets.sk6)) {
> > +		/* Though IPv6 is not supported, IPv4 still needs to continue
> > +		 */
> > +		if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT)
> > +			return 0;
> 
> At least this looks OK to me and the original report certainly said
> the error was EAFNOSUPPORT

The failure can be received only if udp_sock_create() fails in the
rxe_setup_udp_tunnel(). It will print an error despite us not want this.

> 
> Please clarify what is going on with the signature block

And fix error print.

Thanks

> 
> Jason
