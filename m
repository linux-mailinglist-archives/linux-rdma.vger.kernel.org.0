Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545A659B459
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Aug 2022 16:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiHUOO6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Aug 2022 10:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHUOO5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Aug 2022 10:14:57 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7600C12AF4
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 07:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JujG355hOukwqqMi25xk/fcG0mpYp/Vl9gPc+e0svvgXfGncGXisKvo/WsNXH2TLU+GOLGZu1gC34U70OjzAH25CHPBaJTevAKEHXKEg5YPg1jVgqJYu9HgPdodvDPsJgoSxtWKY1hjiFtHaae18ZTZJLNTMlVnJZzMJKn+xjcJ/FAw+/DFz0m0b/t2zAh73eUjTeMC6U+MzK1k7Kk+N8rJz6oZcV2BsBWOBiXo2o9TT9V2ImKFd+N2T/DwckH8saad4ymIxkfyWFDnr+axWNLwOjAu3KeNWPimaezf7x8Prz5nNJdbgRGvigDxl9owkMGbjMf/vvd17qMb/RpkSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xyvKVPUmTdcPyQVVvgQN/O9ha8ObHA2Xz/RrKtOr6o=;
 b=FY7tgVP9+XDdrckRveQLsZQhWPG0T6AQIvlnp2wMkpNcHe5ocSMHg0ilNFaZMtOoaPvTJRbkYod1vCXl4w6NkLmcMLDu2QMWGpXWzHwlgoRBZf4CVyHXpYMm1NFQinvi3+/4WNrl2RX4hV8TcWtR41h562dbzTBJc5k/P5ygu8SJ/o4r1CNE8PPTrTTx6VYAq84r40q4vaXDUAVuImuaZ/f6QpRqP3cZJ5gZIYakE04NGU5Tjcrm3R/oIPpbeps880vHg9IyqpfyYVIczrVAkQp6EdUsq0/INCKvEkfMqd9qz37JlKP6f7PiBqF/oCCL2U4hSOvJqbNrRqvnHU0Yfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xyvKVPUmTdcPyQVVvgQN/O9ha8ObHA2Xz/RrKtOr6o=;
 b=qPCNS/oO9NnGHny13ZhYe6yVkxphEq3+LiwA5bKQOnve21G0KJQq7sUDnkAxcZxKfPjPrax1zgX2+udw63XBf2TMDYpR1rJJoxLJHskLiAW4i31+zx9dCIyWslPhJxBhCIFPoc3VfAHJjX5OX8mGe2bO5+0Al/8yYJ8QHg1dngGtI2kmlw6OIRpaZdOmxMQ9BCOwjvnZQLtzsCJa1+4y6iMzwLSvJbN0QjXM+EA4u+7PKEma59lrirRlLWy7Mp5uaB2WrR9p7ABUksVEDGcTmNfd2Kba0vCmQW+yNh7bO6qVClF9kf642fMnU86J3KQQy/W9KUtHz9bihcuqH7jAwA==
Received: from MW2PR2101CA0016.namprd21.prod.outlook.com (2603:10b6:302:1::29)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Sun, 21 Aug
 2022 14:14:53 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::24) by MW2PR2101CA0016.outlook.office365.com
 (2603:10b6:302:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.2 via Frontend
 Transport; Sun, 21 Aug 2022 14:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.15 via Frontend Transport; Sun, 21 Aug 2022 14:14:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Sun, 21 Aug
 2022 14:14:52 +0000
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 21 Aug
 2022 07:14:50 -0700
Date:   Sun, 21 Aug 2022 17:14:47 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
CC:     <jgg@nvidia.com>, <dledford@redhat.com>,
        <jiapeng.chong@linux.alibaba.com>, <cgel.zte@gmail.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 2/3] IB/cm: remove cm_id_priv->id.service_mask
 and service_mask parameter of cm_init_listen()
Message-ID: <YwI913+HsmU8YVf2@unreal>
References: <20220819090859.957943-1-markzhang@nvidia.com>
 <20220819090859.957943-3-markzhang@nvidia.com>
 <YwIYXI9xTSpw4Vtj@unreal>
 <8863ab45-8b9f-3f1b-32c7-2c8f7e06b8ea@nvidia.com>
 <YwI3gG23YhD2zg0k@unreal>
 <472c4a14-e6fd-fe1d-51c0-31b8db8debc6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <472c4a14-e6fd-fe1d-51c0-31b8db8debc6@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec2e2218-d6f7-43ad-9452-08da837f8428
X-MS-TrafficTypeDiagnostic: BL1PR12MB5078:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCtm9kQOrSq8jDYfRspmXJefKAv9fdH4rvaWZYFeaS+SzufzXHNH9OxKvNCo2+3Dh5A378sRzxeJ2vLBYq87PZh2Z/BKlW7kusJTfqf3lJRqI6yitd4XX80upKd1WyKOR6UXU1sOxeoB9M6qxvR/vZZI4WYRcLGmLBYyLMqEGE+zrQddmsnlcAOtqtJxu/15qMVPoTvIWNCVAuDvNfwOKWFUKclE2gVULD/1pKTUnb++ZFPRQO+h0Uc9ayVOdfi+5IAWdghfAHgRBS+bvCy8UuG0T5YOaXOJa0cAvxvupv53slTh2pDgMCsBwBQsxkeyxaV5A8T5b55vZA0uBnLxT1xYyWl5AuFPKTpwHvcB6D4R1dZM+5kcoUtrJixz9JbfU9zsE8mHbF/1q2VYfwVPDEJxkPoBTEfVsw9o/ayucSN5PXBAuSWWogohYnikCU1tpSf/xo9WgvQnXXTXEIeXs4BiM1n5btv0wyqx1UQeEcFMi65jA6YUAY4cfplJE2gySuZvxshtdzPbzexHRI/Y227iJb5izruWWM7F/DpmINQCDDr/hCETT8yuu6+QOy5mMw50iI0FsLJ7q6GPkJnpTEKhuw3gVjvVPSVyd7Py0qAg4chpMtOsbSenHEggET+Fsf8EEXXRZQvwpTAzkjtQ7+rw/HD/jROvIDFseFRqmjbYBFecE0YOE3JH4HbuQUw3VlCOC2GSa92b3rkHkHtYUYtBBEBwuxn8x7qZnq/llOts2Jdx6uSLB9JABTAdH0hsK223GSp/9uxgBuqAIm8Mnyf+e3mdtUHj194Cc1kv8CaidtuRDHUuZecujGwiJVZf
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(40470700004)(36840700001)(54906003)(8676002)(4326008)(70206006)(70586007)(40460700003)(6636002)(316002)(40480700001)(33716001)(82310400005)(5660300002)(8936002)(6862004)(2906002)(356005)(81166007)(82740400003)(86362001)(26005)(6666004)(9686003)(53546011)(41300700001)(478600001)(36860700001)(426003)(186003)(336012)(16526019)(47076005)(83380400001)(67856001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2022 14:14:52.6589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2e2218-d6f7-43ad-9452-08da837f8428
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 21, 2022 at 10:08:54PM +0800, Mark Zhang wrote:
> On 8/21/2022 9:47 PM, Leon Romanovsky wrote:
> > On Sun, Aug 21, 2022 at 08:50:08PM +0800, Mark Zhang wrote:
> > > On 8/21/2022 7:34 PM, Leon Romanovsky wrote:
> > > > On Fri, Aug 19, 2022 at 12:08:58PM +0300, Mark Zhang wrote:
> > > > > The service_mask is always ~cpu_to_be64(0), so the result is always
> > > > > a NOP when it is &'d with a service_id. Remove it for simplicity.
> > > > > 
> > > > > Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> > > > > ---
> > > > >    drivers/infiniband/core/cm.c | 28 ++++++++--------------------
> > > > >    include/rdma/ib_cm.h         |  1 -
> > > > >    2 files changed, 8 insertions(+), 21 deletions(-)
> > 
> > <...>
> > 
> > > > > -	if (service_id == IB_CM_ASSIGN_SERVICE_ID) {
> > > > > +	if (service_id == IB_CM_ASSIGN_SERVICE_ID)
> > > > >    		cm_id_priv->id.service_id = cpu_to_be64(cm.listen_service_id++);
> > > > > -		cm_id_priv->id.service_mask = ~cpu_to_be64(0);
> > > > > -	} else {
> > > > > +	else
> > > > >    		cm_id_priv->id.service_id = service_id;
> > > > > -		cm_id_priv->id.service_mask = service_mask;
> > > > > -	}
> > > > 
> > > > If service_id != IB_CM_ASSIGN_SERVICE_ID, we had zero as service_mask
> > > > and not FFF... like you wrote. It puts in question all
> > > > cm_id_priv->id.service_mask & service_id => service_id conversions in
> > > > this patch.
> > > 
> > > The id.service_mask field is removed in this patch, check the change in
> > > include/rdma/ib_cm.h
> > 
> > Right, you removed service_mask and described it "is always ~cpu_to_be64(0)".
> > As far as I can tell, this is not true and in this "if (service_id == IB_CM_ASSIGN_SERVICE_ID)"
> > sometimes we set cm_id_priv->id.service_mask to be 0 and sometimes 0xFF....
> > 
> > Why is it correct to remove cm_id_priv->id.service_mask in this hunk?
> 
> 1. service_id == IB_CM_ASSIGN_SERVICE_ID:
>   cm_id_priv->id.service_mask = ~cpu_to_be64(0);
> 
> 2. service_id != IB_CM_ASSIGN_SERVICE_ID:
>      cm_id_priv->id.service_mask = service_mask;
>    It's also ~cpu_to_be64(0), because cm_init_listen() is always called
>    with service_mask = 0:
>      ib_cm_listen(..., 0) -> cm_init_listen(..., 0)
>      ib_cm_insert_listen() -> cm_init_listen(..., 0)
> 
> So it's always ~cpu_to_be64(0)..

I see it now, thanks.

> 
> Thanks
> 
> 
> 
> 
> 
