Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2578155D804
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiF0Mvs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jun 2022 08:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiF0Mvr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jun 2022 08:51:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A274B09
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jun 2022 05:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEz78CTpEJykpPEVYPd0ELRINYjA6ZqaJD2BV+zeiTdOZv1VkCbBlzVm7tjibNBSKQjyahLG49H2RAxGJ8h/jva8b5AGX12lEZbXCtZAPHTtmEVKt6ArshVVtpVLqypO2PYKsXpSc/i6T1xy8YNaH9wcEDCmwvHQBkPS8vzOddZHSUuqqDfO0kUhTOM1KxwVoWxenNnnr5zHwZoLY4dEhGnYTSNpotGkHiYXL0wKWTc7EzH+YjB8C1JLAFLXOkJFzzF2NpaRkK4x/tzKAw6ViP7O6kRXKzTZ38hzSq9EizS4dJIm/YEtjRzKIgm43DJN8MrcV0gks6TKrsMElMk81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hv5V7yYjSe6ETBtXaOZL5VlRgs1ReJ8XfX3Yg5+k3fc=;
 b=DZGuMCwR2mc9DN2XqZCTkh4cS44Q+yPXb1c51G+uBLkpHYLUhj/LhI9wRGPB9nIAYz3MMIR0oVljNw5y/TG5mUKPo8lpNuOUhj0MWxKCXrhCEPNa32xxAW0vrtNhbFN0+VogzABvApY3LyH6bE8CBZO5QORL70ZMlmUesN5LIAfnvvJ2a8R1F5/bHlBhMJZ/ZnsvV9ajNAwdPpK5LV39CaDaReEajqHMx6swIr0k09xpSKQHt7pHb1ZWTVALelwvBx9XXdcDUqPDIh9MY5g1Z20rsQzwPb4/CHe91iPElQ5Tvai0LVIyQo4TA3xYpaVZ/ngyJAVbYCuR14ovXUirzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hv5V7yYjSe6ETBtXaOZL5VlRgs1ReJ8XfX3Yg5+k3fc=;
 b=Pc1ylKMEZO1W4BSnMmNnLz7zyVgtGH1q9pIzWirgwaM9B/u2kojUcs9dHC5musl7EEcPAI6Bq/koWi5Q+wpaFFCJ48KxU7/zna6vsDBLifeevn2Mv9FGpm/TccZIZKNhWFLEJYxc/uDCZ0ulPGDNmvgCwqFcAr7T1psmcl9WFFa2M0RI1syahTLfa1170kXSYYihyAhPeGqBOI+tJ4FOJ+Ih6QcUa1Yyao+Z45Wv32uJBcAILgCFbQzN9kSVsGpo+8Fw/cQwuvHmLVfeRmE6rOuphtCNuG7J3c0S7c7viE2cRkzLgkJSbTCGVg1ncTi1sLNvXzf2aXRcooyITNicSg==
Received: from MWHPR1401CA0001.namprd14.prod.outlook.com
 (2603:10b6:301:4b::11) by BL0PR12MB4930.namprd12.prod.outlook.com
 (2603:10b6:208:1c8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 12:51:45 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::a3) by MWHPR1401CA0001.outlook.office365.com
 (2603:10b6:301:4b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Mon, 27 Jun 2022 12:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 12:51:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 27 Jun
 2022 12:51:44 +0000
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 27 Jun
 2022 05:51:43 -0700
Date:   Mon, 27 Jun 2022 15:51:39 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Tao Liu <thomas.liu@ucloud.cn>
CC:     <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>,
        <talgi@nvidia.com>, <mgurtovoy@nvidia.com>, <jgg@nvidia.com>,
        <yaminf@nvidia.com>
Subject: Re: [PATCH v2] linux/dim: Fix divide 0 in RDMA DIM.
Message-ID: <Yrmn2x0Q8gon6msb@unreal>
References: <20220627113036.1324-1-thomas.liu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220627113036.1324-1-thomas.liu@ucloud.cn>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13dcd109-a8df-4886-8a80-08da583bca5f
X-MS-TrafficTypeDiagnostic: BL0PR12MB4930:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w34CoZKyLZN+KK+8y73hINKs2EDUVyY4whDbxLpOTNSgqqwQJbjNfkD2EQvty+iXlBwN8RUIZR/m3PG6694NY3cQLJpFcOOP3X4Iau8WtbHMljwe8iOQqqRf8qk5S6dJaM92U9UHXksuCCg6FJTlmvdeyANkVru0Wv4Az4qqiy6buA+Dp+LC/ND1ZibEJk0qsnBFLkjFwDVYmAlJKJwEMPWIqzPbV6kyF9Ep3YrcxvBMbpE8AvC9unJtoN56+z/zAdYjZTKOeLsAdFC9t1nCT791mUm+InDV9nTVmteYNPXDmHTPjpiklw6/54JvkyTXxhVs29ysoB7Cl8Mq14ucitFMC3RcmV8D8eG6CC1wR/5QB7ksajvUpqmG9KRaBiud59Owoduv5YD/x5Gm4Z9wim7lpFSj4VY7XvYfI3z5LUc3OdLenoT6PUwQ2n5phBrSIgjLJE44knR4jpsOUIkthD5V6yiAAFupEsiEEVDUvzYNwVvF7OQ8TlLYoKv/W3VKOKGPM2E0UoUBZpyg+a2NIPwRzBPzMmhx21uZsaS0fSHo/uTgxEpCbi8jqsdDNdy6lJFXnfBskNSJKtV++nSR6ge/RR5OjPtWwQ52Ex74tDSr74oE7ZlYMSELx9xsskASXGYWeJEQLSN0H2j96SVFqcDcwPIeg0xWzpoR7agEke1NlzIF25O+s+v95CYah/9smamH6q8jBIXPbmBIQQnq5SvEssGgM2/l2S74n74O1gh265Q38QNIol+Mi1eoxTQBeqNcS3Vep5cJiKldmoJSwx5H92MWxGOTso0fCtu3fUQQD6GhjzZGdW1DkTr8dVqn1B8kl+zxBRugL4PpGBkP33fLmk10bONyJ4EOecoIGWsPnHNPC/dUR1KDdobJz7uBrczb4dbOtkkC+m+ApUrAqLHXO4u0tPYcFhnCDLnKkNg=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(40470700004)(36840700001)(5660300002)(86362001)(4744005)(8936002)(40480700001)(33716001)(186003)(16526019)(41300700001)(6666004)(2906002)(70586007)(316002)(36860700001)(70206006)(4326008)(82310400005)(40460700003)(107886003)(6916009)(54906003)(82740400003)(81166007)(426003)(336012)(9686003)(47076005)(26005)(966005)(478600001)(356005)(83380400001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 12:51:44.6826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dcd109-a8df-4886-8a80-08da583bca5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4930
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 27, 2022 at 07:30:36PM +0800, Tao Liu wrote:
> We hit a divide 0 error in ofed 5.1.2.3.7.1. It is caused in
> rdma_dim_stats_compare() when prev->cpe_ratio == 0.
> 
> dim.c and rdma_dim.c in ofed share same code with upstream.
> We check the 0 case in IS_SIGNIFICANT_DIFF(), and do not change
> decision order.
> 
> Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
> ---
>  include/linux/dim.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I liked the commit message from v1 more.
It had proper kernel panic dump together with Fixes line.
https://lore.kernel.org/all/20220623085858.42945-1-thomas.liu@ucloud.cn

The change itself is ok.

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>
