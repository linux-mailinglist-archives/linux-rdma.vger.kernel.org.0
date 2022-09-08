Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989C75B17C9
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 10:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiIHIyh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 04:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiIHIyR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 04:54:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D9FE6B8A
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 01:54:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8smYp0hcsVYhUqdl2JgHbTO919j/g2mxxwnoQoMxzJiIRnY2/GZGX5orQWdkhn3O4Ktz8UuF8dNRQJx1OTG8sXj03C7ISRZoqhKJvi+YQRwsX7f/cxDbrGx4HoHXKbwpUnCPuqWnlb9tb7m9Lv7Db4EYdddPX5e6swsac/8rH5Te9R7BhKsxRf8m18j/NsRoDI2/hBarFv7ukklPG2hAkghJQXYdytdUP5bYPEk8+qoRbhZGaDC7OYK6YKuApA82WeqUoM5ePIlqe7ywc/3WLgF1chEGyhKvaJ9WRSDi+1QeSoOigasoa248xoCj5x9Ox2bdlduzCzvBYm1zdlCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLfjczTdu3bmBXvq1rgCzuNQLlbiicWhUzzQah10HHc=;
 b=VEtbazyzqnaLVQHi0A6W0Q9nMrMsoZT5PJgXVK6jJkK3l/kdtmmNgNbwS4Zr/QKMqZlQtlKqLyKMa1u6lGIKTSf6ROdxpWM2R7yidPT9I+pLPFsiv2zE37QqXxqVPyxbQUZQUJHQDH6c3Zm4gboYZyAMc8MtQD1hUItGi3d7te05L9IbOtoQN8ByUIO7vXXdxZb2lIh3xC3mpQKrJ4QHhAixEFhHQBta7SynVgUNOVh/zFPoT8zi6fJdz4owRiXeou+4B9akXEqYT5dbbFtT2OmSfGBAm3eexVLe8YIRIx4hhHrF2a3MtgwLtp/GEN8V+g1Cze11MMpiUA7F/F58Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLfjczTdu3bmBXvq1rgCzuNQLlbiicWhUzzQah10HHc=;
 b=Ot8Et1ybEWMy7Q8c0fYrvq/MlMLPEtG5hGVGrEIIIxTxfm/9R5ZGWlqjHfaJ5AKUUGicYAts4RMS9MADUpWMRmb6bk4ISPbsdEaoFDF3wgD9/fjXCP7DSpUZ9F1xAtYWEuYqj4FIBFpxJ6aQPjxKGu2mlAHR+jofh7VeaeN4nQh/kZyhgFojNXUQfosG5OWLAePJWJe8qZonSFtmz9/qjgqv8CzXfdAL1105XUROJDAgInNrYt7pB60r+1vJa8XNpBginVhS+/sbHfO5ev+ZO2NIVhD9+bXQ8qwC7dVcNhQs/AtSW3KgZsp2rAkfBb7prDUZ5m9iWbaFyoXZpss1Cw==
Received: from DM5PR06CA0086.namprd06.prod.outlook.com (2603:10b6:3:4::24) by
 BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 08:54:14 +0000
Received: from DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::ca) by DM5PR06CA0086.outlook.office365.com
 (2603:10b6:3:4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Thu, 8 Sep 2022 08:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT083.mail.protection.outlook.com (10.13.173.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 08:54:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 8 Sep
 2022 08:54:13 +0000
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 01:54:12 -0700
Date:   Thu, 8 Sep 2022 11:54:09 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/mlx5: Remove duplicate assignment in umr_rereg_pas()
Message-ID: <Yxmtsb7NtazRIoqB@unreal>
References: <20220908083058.3993700-1-matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220908083058.3993700-1-matsuda-daisuke@fujitsu.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT083:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: bca452f4-a377-49a1-174e-08da9177b480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLaUxu2Qkf8x1A9A7d060k2lHBclcINNAmRnwcTPW9kZ51K7cZWqQweTWYzPP1t/UgyLiO1vk9wSrLwIW0vvz2ksymoR9Nw4WSXtF/8pdWUQGH8X5/+vzGSdV4V1iHBLWUh4sXgps1VDSLamc7PGaWbLBBUPCHS3yqVAociDjIWV2O4Cuo3l2Y7Jc5hMwiU2QvwWiJzK3FspIvZkXHCyjH/rAhCHoXth9GrzOmjSYfK+IV7pBT/XsO1trLhmEU0CqTUuwqhNwYX2MX+1yd9ETU5GDtXqH12oyJ/Rkbb0EvjBIwq7EJrOh/e/5EIAtvsQq0FDHXjbKWpAwluOkQ00KRA2BA2wzZG6GsIk5M6uC+HbL+F5Dv5RlhOO2oxSWyWib0L5ecJf8qPrSbTbQMfhb20JkILZxGIWCQzaplRgnSdux0J0227OJNQuuSCA05S67o6rGNXHXOa7yH9MrqryNUjAPwlcHgo0M7H1UW4A8QsQOxJ1cPj/M8rFM/kBSlK98WQup0yfITQn/rXA1T3bXN08+lpkHMuGNpjlR2aOgYuEC50jh9Sq09TXXxuvlAeZj+XzI1nyTR1JXvTQMXdw+4me1fOjsyP6bt7CtcOnAePrz/pKOoDGgBsCbZcRSvIkC2LNINTKAATrCsZCY5Y9hKBtJuIjdOgwGqZ1DjzUY24OgceNw96gd6o2Fs8AeV4gAmHSI82I182Cooc349bxdsEYgM7hxOT1XhgJtswdShVJBgpez8ORUFg9gmaA3iDWrhwC7iqbpHNSwocKqcBpXqQALK50FCYLmTT4xGfu9QNYwKtNRxUX/cQcleIXfnLW
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(7916004)(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966006)(36840700001)(40470700004)(426003)(47076005)(336012)(81166007)(186003)(356005)(82310400005)(36860700001)(16526019)(4326008)(478600001)(70586007)(70206006)(54906003)(316002)(6916009)(83380400001)(86362001)(8676002)(2906002)(9686003)(26005)(6666004)(40460700003)(8936002)(41300700001)(558084003)(5660300002)(33716001)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 08:54:14.0525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca452f4-a377-49a1-174e-08da9177b480
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 08, 2022 at 05:30:58PM +0900, Daisuke Matsuda wrote:
> The same value is assigned to 'mr->ibmr.length'. Remove redundant one.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Thanks, applied.
