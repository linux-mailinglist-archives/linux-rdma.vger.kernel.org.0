Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B722768585
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jul 2023 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjG3NVU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jul 2023 09:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjG3NVT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 30 Jul 2023 09:21:19 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BC6124;
        Sun, 30 Jul 2023 06:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAigCLnMISR5R4eM7x9F+yHXMmJDOduP6p2QqxedyzOlgTJKvtu3iEFNrBLZx/zE6mSVEdGKiHHrsiXCXCcoypA3wsTyENDhHabHuUtozhfcq1kUoCdGIWBaTslqnyDOAn0tbsY7fE3UmEINNuJCgV3qVDuSwQqlU7TOchhKMG40USXAgz/lF9t7DgqPGx7U4XLHAJpCqgTo0RJwbcKAucRRL/RyVf1dGJvaQS7umfb5GEFTydTZMAzzrcuZf0tfpSivNgSKTsaq0dJdL7SwQKglJRecWlWf3mujVqFJrl6aOVvkBesrIzyrdQD4WAzl61tiPRnI8bouTuTZyTTnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maQHuq4zGSk4Yny7KOoJy2jVoNnvvSeXv/gg2pAeGO0=;
 b=ccRskDGi074+StS/tqlKNUfShoz72zBMamKE18MMdDQP3Z24gh3NJNpfnqNyOETrauEKxSjUarb5Y7MiaaLzc5QE8Rj2RjhNEAXf/30hz6dNkSYY37x8oz3JoEEnEHUCmZjbxy53YjV7e2j4nPQQmdXuVzLS+rm/cLqTgT/7lcDL4YPjnUljZ3wIHUZO9JZOSfVBJb0+JG1OrfXvdWyX6HL6qHC1AHi00Sq8K1RynHrYqnxhiQV6jUN1NdGFQ56zTFi6bi3GgvoK/Ckzx6ZYhSwp1N58DuZZCjud6kfK87S9GYNQyFqCahhVG5bnx61Bnwx28G/NAewmL2YQV92qyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maQHuq4zGSk4Yny7KOoJy2jVoNnvvSeXv/gg2pAeGO0=;
 b=qCKh89EbLxUv/O87Nq7MkNRJ4+Sf40J1OsRfSUZNrKkYYMltxhfUll7QQ4INKfDhceRESK2YoeOHbDyO9p9n5GFeZzHEZ3eQSJfDzuzL6em9N9Iy2bViy3y1td0VAC8ry/ZTmHN1fNEKlyHjJ6u2jxBp68ghyaFi9xc8v4InwYZXAy6EANOeyyVuQ88AlKHj6b6LS5eJAEvyQRBwKaGxIiWu9uRD7hQcca+/sHQXao04JBgtV7ffk7cf8ftrajskqpciVZMvr+ycIn3JevAdu/DzCOaeQ0EDPdmWZ1DVX5twYDHhreTrJiMWNgjfJSI2/SFEEMqnyReiRzm8PLnV1Q==
Received: from MW4PR03CA0024.namprd03.prod.outlook.com (2603:10b6:303:8f::29)
 by PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Sun, 30 Jul
 2023 13:21:15 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::c9) by MW4PR03CA0024.outlook.office365.com
 (2603:10b6:303:8f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42 via Frontend
 Transport; Sun, 30 Jul 2023 13:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.5 via Frontend Transport; Sun, 30 Jul 2023 13:21:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 30 Jul 2023
 06:21:09 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 30 Jul
 2023 06:21:08 -0700
Date:   Sun, 30 Jul 2023 16:21:05 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Tony Nguyen <anthony.l.nguyen@intel.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <netdev@vger.kernel.org>,
        Rafal Rogalski <rafalx.rogalski@intel.com>,
        <david.m.ertman@intel.com>, <shiraz.saleem@intel.com>,
        <mustafa.ismail@intel.com>, <jgg@nvidia.com>,
        <linux-rdma@vger.kernel.org>,
        Mateusz Palczewski <mateusz.palczewski@intel.com>,
        Kamil Maziarz <kamil.maziarz@intel.com>,
        Bharathi Sreenivas <bharathi.sreenivas@intel.com>
Subject: Re: [PATCH net] ice: Fix RDMA VSI removal during queue rebuild
Message-ID: <20230730132105.GE94048@unreal>
References: <20230728171243.2446101-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230728171243.2446101-1-anthony.l.nguyen@intel.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|PH7PR12MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 92628cf2-64a4-4df1-a9e3-08db90ffd9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6PLVCMymg/SxA9p3AzRLuRAC+m9reQ5s6PmC4RMGzOO7AE3JXz3b1K4mzAleYcCjbf//wuuBkfC8eyOTLXNtxdFVMZl5rPdZroxdBlj49yCv2k4G8bajt6C6ALje6rdSo2801vzBrkTmM9VAhz/59UyZkMQEprXiCztxwybbhjwwMcCufyd4ECbMoGgtkZ/Od7CYEqF45gxpZNGZmmKHjnu8GPlTHy07MLOOdswciXok7+qyUW6rjn7tqFOht36qttB7bvsvClB4EYNudJ9XScGkdo79HrKxvaqy5/h8kA9WBo1oFis3K9bP/VyQZ9u9I9a5acIizuenl7hxPxpN2v3/E5NU+nSqgcflDDXXIGal4NfHk8hUf0E9MZzhA9p6ohCKpiL3+nSGM6t+G4MoUaqQuE5+kgLMrURIb52zX+fR63EnX6uKuNTwN/uJ/v+/8gSaNnJXI1W3XKJcqqveopJVquH6EDa+/5BjVO8sC+1lQDI3nPExc7l1jgCYtgWtiDSgSufoV6f/FNwYgqJ96l5JFK7X5ghNPeK2nswl+osvlaMwNtmxGQjFu8HsCF8w5JBDbQ4L6LNsDLrtzmbeDF1GSxgMPcxVgThOwMRn+22RvN2Gmy4icDJL0PkSbBuatOlEBZiloMAdW5uJ0O5bk6eeJPLPF1vQWGexbM9XXjlXT2zsIPMIAPWv35W4dO9UxhdcLdwG1CRUPycpAWCo43dfRz1fufcgNRWl+Dau0dK7ONvRrG9xTNYUvsZjYMhB
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(5660300002)(426003)(1076003)(8936002)(8676002)(186003)(336012)(16526019)(36860700001)(47076005)(83380400001)(7416002)(26005)(478600001)(316002)(70586007)(70206006)(6916009)(54906003)(4326008)(33716001)(6666004)(9686003)(41300700001)(86362001)(33656002)(40480700001)(40460700003)(2906002)(4744005)(356005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 13:21:14.5993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92628cf2-64a4-4df1-a9e3-08db90ffd9c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 28, 2023 at 10:12:43AM -0700, Tony Nguyen wrote:
> From: Rafal Rogalski <rafalx.rogalski@intel.com>
> 
> During qdisc create/delete, it is necessary to rebuild the queue
> of VSIs. An error occurred because the VSIs created by RDMA were
> still active.
> 
> Added check if RDMA is active. If yes, it disallows qdisc changes
> and writes a message in the system logs.
> 
> Fixes: 348048e724a0 ("ice: Implement iidc operations")
> Signed-off-by: Rafal Rogalski <rafalx.rogalski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
> Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
