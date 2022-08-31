Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72075A76F7
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 08:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiHaG6B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 02:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHaG57 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 02:57:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F56B99F1
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 23:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO4saGViuYx+UxMvYM7eQpcIIXxzMvIRBCqexdbWp8/+ejSL27epCUJ6pcUK1Fr+AaSMkKC2iUJQagv4YCdJD2BsTOio8J5tUp+DmL3X1X3eX2p8Eyjua0ljbHg+i1GyXNhlXrKNAM3ddPY7k94XlqwsqyjkYApHItoCv+99SWOgmsS2rXwLwsV0T7+RWZL85IzT3TLy4/xoHMgL8eCs7ePIwrGLvrCnnUojRwKW5zPgX5c1QHwS0r0u2rJGTjnHw3elOcSQ9MzXtxem7rP+0qd9BqQNy+XJKQHMb3TAkry2+gfyyXYcJIl05hTrcW5xhD7Z4Cxf+91hpWVTuWySVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35cMuQJ9Kyc+1tnJ6DSzTRS3QM7L0rBrnMhdFbkKofg=;
 b=V5k5vZGMZ5Bf8Qt9CmKBIvZX8hXUQa1Z6AfVXQdiB2Jzm4lahkmRETh/ewoOjba6zkJR3sWAWXq12VrPMUkSW9PuQh8b2pd02aIDvoHoLTWqM+A9RuA2LBShpphASyFPxKwXKhpCT+dt3mGRfqy5BgGu+iUQC5+zxOSGSPqZ/qTv9EjTvWwJSYYCu00F3WNoYj4yJMyUXteP9Uvk4NZCU47rSzlg7ph5ZGXZnJsJU/ZAGKuiT23pOWHS1tUAotCwr4J+FinfOzOfP6CF1GgwfC9r/n+5VH6yBzQ3OwnKy7ysjhsxjwY/1Rjvg4en/NI+J0jpCDCjzxd2s7rHBKJRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35cMuQJ9Kyc+1tnJ6DSzTRS3QM7L0rBrnMhdFbkKofg=;
 b=aJh7kgPGo+wK5XbRZ1n91Mf1pLiHD8Hokuo+OhzQEevBMVlyKhBqJoFo04EcRluER7HPNL56hLDgux9+KL//42wQtIBgdYYRKTrCFgeu7oE9WfEDXpiuT68AXsyt18XjRR4qKhrL+bJF96S6UG5AmlHbYsmumUpAyBNI4SzrIw1Zc6Chg2uO3LRJnuHHgT5xIUR1uPihtcSBvltI+hafzx3P9EM4GLSMv16I931WM4PvB9mt3XFJb5gUaIx+cUpcfPCvDGSId1PmTBvQb7VfjSJIimz6SdEUlbDYb6fDLnxggg85gp1I/Oyj1ThxJUMiwTTu2woJd0garmUZg8a4Zw==
Received: from BN7PR06CA0051.namprd06.prod.outlook.com (2603:10b6:408:34::28)
 by SJ0PR12MB5421.namprd12.prod.outlook.com (2603:10b6:a03:3bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 06:57:57 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::7d) by BN7PR06CA0051.outlook.office365.com
 (2603:10b6:408:34::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 06:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 06:57:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 31 Aug
 2022 06:57:55 +0000
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 30 Aug
 2022 23:57:54 -0700
Date:   Wed, 31 Aug 2022 09:57:51 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
CC:     <jgg@nvidia.com>, <zyjzyj2000@gmail.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/rxe: Delete error messages triggered by incoming
 Read requests
Message-ID: <Yw8Gb9urH63oHETq@unreal>
References: <20220829071218.1639065-1-matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220829071218.1639065-1-matsuda-daisuke@fujitsu.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb2e79ee-3843-4175-e857-08da8b1e2219
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5421:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D10aaTqVTQseezRIUQMUpq1M6YSejDN/cWi+b8cieb6XQt+5LPvFxLwc7FsFRfpQsh10EYb5E5DoQZCBCj9ItUGKcO/MR0dVQRC8Ahn6wl7ndIF4TX1dE2RwH/6Eu5Rf5amU3A7r9oh0ILIGwYlwFVDOPPIfdOY5vsutijwLge4N3K4luPDwTTFISAN2UiQjYhREJYsgDTLhwfhhB8uKhSRz0DGBtcNA8nPOQ8/pffohNVnZLLuddhvczLiQZgjawKNq9ySLDd2jmG3jN/oQEAcH/ZM3uu6LiAaNIZUiPwva+kSWUzD9BHO2uSfWNhWM4HbHtOLmU1annIpBu78etb82OkeowoPkSJOU4HMID1mSWzLozQSdU1nNu5p6w+p3P9uKf2zbJc3hXlVInJsyc5SuipF8jK2RVbZuUMGyxN0XccniqhaibFIArTa2Ht88BprcCOoSfW9VTpQhm2WKii3+7wc/SV/bKptqK2aZlDd6tOQ+FPnkiWP2t2eVBCXQy73OMrXVRGj7Q8boxlPx63fE1hyHROgWkigBCBssvHZQ6RQXoHz/HRrI557kqbEifocgJCyCQ8qunkQ5+dKT+ugCerjeLa37OXOsqr8P436npshZXNL2fB/YKujwsF89fLdxAcpWCrZlqw4jFsvs4Ivb9VAjEZOXe/H0zSLbe8i9/11s4+y8yxA0qz4xnc90UzVcwNVy/u8bB8Pb0SVyC5WCjg8uTSfvDC5ky9vzbzSTb//e8feWZKhK6K943/LxabCIDQsiytI2OTnDvPRl+7ttVLpl36T/6ncne2boD60vcS8uZ8uQYXEnS5gw1cCE
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(7916004)(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(40470700004)(16526019)(336012)(426003)(2906002)(186003)(47076005)(316002)(6916009)(4744005)(6666004)(15650500001)(9686003)(83380400001)(26005)(82740400003)(356005)(86362001)(40460700003)(82310400005)(40480700001)(36860700001)(33716001)(478600001)(5660300002)(8936002)(54906003)(41300700001)(70206006)(70586007)(8676002)(4326008)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 06:57:56.2030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2e79ee-3843-4175-e857-08da8b1e2219
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5421
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 29, 2022 at 04:12:18PM +0900, Daisuke Matsuda wrote:
> An incoming Read request causes multiple Read responses. If a user MR to
> copy data from is unavailable or responder cannot send a reply, then the
> error messages can be printed for each response attempt, resulting in
> message overflow.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
> v2
>   Stop passing unused value to 'err', as commented by Cheng Xu
> 
>  drivers/infiniband/sw/rxe/rxe_resp.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 

Thanks, applied.
