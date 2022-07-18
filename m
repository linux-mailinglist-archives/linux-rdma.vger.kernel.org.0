Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36387577FF4
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 12:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiGRKlq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 06:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiGRKlp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 06:41:45 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9601E3F1
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 03:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fL4ZUNjzozrkEBcOSEyxLroAmhqTxq4bF1ScfJnimPT9/P9QO7Vq5P7ddHC3JKgEH+5sk1vd/weuvOVxbQKHYr7AW3mS/w9eL5zK6H1Aqh+lAceEaW7kLDj4zr3MrL7Yiw40o8LK7vf5QKp4oaMe04Kyz7GKXoZncIrdpp6wsyvV0ZsDmA/Jj/OpHMaEL+X8nVlRnU+SjuyZZBCtGmMPDPDuU4Vz6bhwulYoWmk5LSVYWYimjhxTXwypWBImUu+gDAOxAETxQlpEkQhLUEtFlBKjR2eZIzraqNJZYrQ2/+o3dPW+jVuwG5oFlEvpsWjavMueo8DzzAtqtvA4A+UMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6SwRA5WJoO+Vu9hIXz0AvSSAvNSGyhS8cF1Ble2bxc=;
 b=V8DVm/a3GRqaDGvK1zKjFT89YTD4vncZIY07bGgB3dj29E3Ak3YlNoqyQMOOZO45hQHEofitBgTcDevA6qhkjVOH7RyU3Li4itzlihLT5Ibn6lRQnM7EaCBFIzdRyKzMYWKVTGy7qqrtx/uPpgI/AhWfavv5YThMxoONGK9HNyHDFOByRWBxqra6sqKgnA8c3EPMHlPyrbMZ+spZv18/CWnhiqk7G22E3olw+XqNTdvfPMGVsCmFynpKqhvoY2V+hDCIJAZccq1IJryNKjYhd8JAjN/7Bjj8j057/BIMYfUelDfFwqForLiyBiYGTdOAOSEhqmmUaChVnrPbH1HnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6SwRA5WJoO+Vu9hIXz0AvSSAvNSGyhS8cF1Ble2bxc=;
 b=fi0nMxaxt5n1xALWPD3LqasekCfOjPz1765Tj4Sv0olT13V7MvcQHlbu+gKOTu8B4qsE6ASowq23upiyegKOh4zBjo47sg3Opve0OaPmfiVU1RUIGyUaNWqjr65yEypokEsbmSY+wATfo61UMIc0ypKZrccwDoKc4hrq3VO+ewl1bIuk9Zs5Y5x+JWIMpXM4b3/PyaEhdkiFzpK9l5YZpVBsCAF2DlelZYFBw4ciYoB8G+R7T19EOGI8w4DFfRKa5uTCanA7C02svzfIrlW/GoA6Q4/YRVpncMLbvc28dhStpM7ujZsJ+60c1I63kUAC+5xBIjQjdsLi0kih7SaihA==
Received: from BN9P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::29)
 by DM6PR12MB3561.namprd12.prod.outlook.com (2603:10b6:5:3e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Mon, 18 Jul
 2022 10:41:42 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::b3) by BN9P223CA0024.outlook.office365.com
 (2603:10b6:408:10b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
 Transport; Mon, 18 Jul 2022 10:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Mon, 18 Jul 2022 10:41:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 18 Jul
 2022 10:41:41 +0000
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 18 Jul
 2022 03:41:40 -0700
Date:   Mon, 18 Jul 2022 13:41:37 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     <jgg@nvidia.com>, Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/hfi1: Depend on !UML
Message-ID: <YtU44eReCCsxfgBG@unreal>
References: <165755127879.2996325.5668395672492732376.stgit@awfm-02.cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165755127879.2996325.5668395672492732376.stgit@awfm-02.cornelisnetworks.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69bb2075-c186-4a3b-589e-08da68aa1a7f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3561:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXTr6qPYYc/GnbLkGuwzcy73ksxo1cHMIPYd/LpEe4PHj3cvJbACm+9/ylVmVRbMT+mx+sQmzrLMMPngPtQbBDjjCWc8Tgv3dh7ne1Fvjmqfp/Ctko4VEfeNyq0gZZNixeSeyjBi67h8qIIcA6h+g8GhyWdUd/ejO9gbol85TFE5ScZNAobNAEy79M1pLQh1op1RBiRR1SURjDQknn2UT0s5fx55S63gGg2+ejAgDbOEAEZByh73sKRfCpZhvKuu7x89pGmwh7ed8lb/Mi+kXvcPL1CIh3O2vP9nb8JwI9SpLnQ0a+CBhyjgaSOsR9bF6DsQetdd1R/ubF6glc3oDDjhlR+cQ6641Xg4wxqUH1top0bCT3S6zeI7I18Gpf3Z+HedDrQC7XxIIqtqNtV80pe1qdL2Crsb4xv4XOvNBuyNlPizyg6HI2qorR6tBtyMJ51L4DYnmDPpPk46ZAKz8DPtHaiIQWAPmd4HxkdBbkkh7v6lCYG80u7ySmYiKnS/ybxzCQ6bfDgGoJ05T9UaVkjmiquzllt8bBd0v8hE8MLGNzmHynIozxhbFtVUuJQFN/40dcCRJDYNWJf2vdVuFJrhyRtQiau4LT7kkmCUASVOfmPKbZ8UprJCSLz4Hg651NcW5KeRAPhOde/Vc2qPWi6JTcJu0EL8OWTMwvaHlrSLRR8F/d70csd7ElU7dxRSBBG5qaSJTf3I+TFDpSDy/+o3d/djVqmu4AHMHbK7en0SG6c5yzaPBa1A7YbYcV7N/eWsDhDwYAoFpkBNlPAMsMPUMufZSlEHh6Hhl3ORg3Bg10k56pbh6FnLXGyRq4VXTPOkrb9gqnMgAR7ebWs+Bw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(39860400002)(396003)(136003)(376002)(40470700004)(46966006)(36840700001)(9686003)(6666004)(186003)(26005)(41300700001)(33716001)(4744005)(83380400001)(478600001)(86362001)(5660300002)(82310400005)(40480700001)(16526019)(36860700001)(2906002)(47076005)(336012)(426003)(70206006)(70586007)(4326008)(8676002)(8936002)(82740400003)(54906003)(6916009)(356005)(316002)(40460700003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 10:41:42.3066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bb2075-c186-4a3b-589e-08da68aa1a7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3561
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 11, 2022 at 10:54:38AM -0400, Dennis Dalessandro wrote:
> From: Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>
> 
> Both hfi1 and UML depend on x86_64, this can trigger build errors.
> This driver must depends on !UML because it accesses x86_64
> features that are not supported by UML.
> 
> Signed-off-by: Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi1/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, applied.
