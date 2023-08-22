Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4DA784438
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbjHVObC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjHVObC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:31:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658EEF3
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 07:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaFcfSHe+FW3FFrZWyjss4zIuH+p4ourTpquRqk0vIo4Hi8kAdbyNNDmEEITlDqSaYJxNMKWUxBpspzJ3UtxL4jDjnJ+KFYjQaCQDXVfdkyUCmlRgnooHeckzsKOUh2DzaNfeceCwkpl5LMkCEMu3a82gCRCtGzFOI976ro4Au++Ew8UHqjIhWZkF4MSXK2X3l7eQHhmOl97c5dpbcE/KvNswxiUfAVCBYI8BIGjnZTR1Zb6kVm0glqXeFBNpYSVbFxOOGo00SBSiWwLlvbKdGY3pKH4hqmXbdQiR4m91jJ4ItrPUHklJ0GbiTOf6Q2YSR+jW2WeEO7Ucnreb/9ewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elPRqzmyGaCLGRxnjbAHL4jp3SITCB26z1IYGgMBDek=;
 b=NF4s6BTTpM36yxuJkj3D47oqyG7lUfJX0ZxeeDqBiOvRLofQUDCEPoReKPHWmNYaF1Gmv5pnbT8W/D3vbNkGgvcOH+QzN6cPcP3j81+o+u1VhPjirAAslO12RV2VlIfSwJQrkdYgF4OxlUqqb2m+F3VK9jRq2X4gqwvDFnuSzQgzOlZnzCnkDoBBM/OGfKW6vjl1Ihq3Mxc+xZRDrlXh8UHm3kB/5NRJ6b6tKArZy0gtVPvlAGldhgZRJMQqvcdguth61LK9ofFzFAL/7qvS4EOEj5AYUaM7n4ijZGmnDeLsrKVygzMSeQZfLtPD/L0rfdUmy8WYtp7WW0AAnwXNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elPRqzmyGaCLGRxnjbAHL4jp3SITCB26z1IYGgMBDek=;
 b=Mt81vh/yHwiQxbJpRWv6wp/ywsOyfwmu+DUG+4emYPd/uQD2oyuQaBC9FtGoQUd7on9cimDqwn5sZ4ihukzPr89d/9H82z2RbdpMoE8Cls5S3G6m6BDIGh5dNWfe/iPz5yLHPoNKzLbIIg/4W0TFzPkFl/XN2mLnpe8wS1NNAtSl0NtQesKAB1zvp5mBLQch0++wZag9388DPRP/Rp5FHLQ4/xExWZJZlIrSuKIuMV7utBGCE/bnt7OIWncvBcCTrxVoR1q2TOzlEBMVwYYXx+UCN1raKkEfypFvR6DIVufja2uPXf2Fre6Wsi5D+vXEKjs3ZTPJLpTZXuK5ycEEhA==
Received: from SJ0PR13CA0076.namprd13.prod.outlook.com (2603:10b6:a03:2c4::21)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 14:30:58 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::6e) by SJ0PR13CA0076.outlook.office365.com
 (2603:10b6:a03:2c4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 22 Aug 2023 14:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Tue, 22 Aug 2023 14:30:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 22 Aug 2023
 07:30:41 -0700
Received: from localhost (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 22 Aug
 2023 07:30:40 -0700
Date:   Tue, 22 Aug 2023 17:30:37 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     <jgg@nvidia.com>, Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        Douglas Miller <doug.miller@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next 0/2] Series short description
Message-ID: <20230822143037.GK6029@unreal>
References: <169271289743.1855761.7584504317823143869.stgit@awfm-02.cornelisnetworks.com>
 <d2797632-439b-8d2c-e220-e8cf2bff8051@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d2797632-439b-8d2c-e220-e8cf2bff8051@cornelisnetworks.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|BN9PR12MB5099:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c86ea8-8dea-4307-f908-08dba31c66b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z85zgV3Sp+/8DjIHs0r8S73KZSjMsSeUIA7nO/BunrOBspKnPbV9IXD6yBnDG371quc4zjx1VHFwJsTQPlWU9oOyGcrNJorE2D2C0JBywvZrOKLKTKLC72HpTrQSXyaWRZIxtU+2+2xrpLa2Wz10ODtjLSAjUZQut48Zhr47d0JpcI7uQLlDShOzqqPJBdHJ0hPcFscjBQv2vDhA7ETuC8cZuJapahWOHnN9t1nY6mQPdf4Fra4axDUQ+F3QU6b+nWmElVwSineIZe9v5lVRMEx31F6qj1L3WHIJ2OEOrwm7uEp6wGUH8OvuR91TdvouoWvHcS2tb4rMMjSMdVyrYIxZHnAdHgy6TI72lGzrgZlpYlVJikSOPFq/3+Lq7yV5fJmIZ8DufGbYAKERXOPYxwFdW+rJQasvnAOM/A3TxtKW3/kxOSdHnctO8UpndzEAlwvD4mrToIoD8e6gCKpueTsfT67NqQGvxuCI4LO9XMBH3/lhbrykLttz3+cZXLR3PUfSvU5KTeHpVkXywgSzK1yguhFtBJGQRKTGViCpSR42D4tOcYAvSVtl3Gr3hS7oKXVecXRinsCCoVbQN4hdKITUzxlWbPh4wUAAp+p+b0wPnljOVKQ6GMiJ6RXxARwdAwW+zHbdmTlJ8OB9pypj5Wv3WDhQtXKK7DKo1kbEWD4KRUeAH5HhyAHkCaqTO7V10IFXe/KTYD7bCF6bsJS2tfQ+NRqNACy52UyX+KZqWwsxoBfB0QfTgl09Tof0JLwV
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(7916004)(396003)(136003)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(54906003)(6916009)(70586007)(316002)(9686003)(70206006)(66899024)(8676002)(8936002)(4326008)(33716001)(7636003)(40460700003)(41300700001)(1076003)(82740400003)(356005)(478600001)(6666004)(53546011)(40480700001)(83380400001)(2906002)(47076005)(36860700001)(86362001)(336012)(426003)(5660300002)(26005)(16526019)(33656002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:30:57.9420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c86ea8-8dea-4307-f908-08dba31c66b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 22, 2023 at 10:15:37AM -0400, Dennis Dalessandro wrote:
> On 8/22/23 10:07 AM, Dennis Dalessandro wrote:
> > Much scaled down version of Brendan's previous patches. This doesn't touch uAPI
> > just refactors some code.
> > 
> > Small fixup from Doug.
> > 
> > Would have sent a couple weeks ago but had been dealing with the isert
> > regression. Reverting that give us a clean bill of health. If too late
> > for 6.6 can wait another cycle even. 
> > 
> > ---
> > 
> > Brendan Cunningham (1):
> >       RDMA/hfi1: Move user SDMA system memory pinning code to its own file
> > 
> > Douglas Miller (1):
> >       IB/hfi1: Reduce printing of errors during driver shut down
> > 
> > 
> >  drivers/infiniband/hw/hfi1/Makefile     |   1 +
> >  drivers/infiniband/hw/hfi1/chip.c       |   8 +-
> >  drivers/infiniband/hw/hfi1/hfi.h        |   4 +-
> >  drivers/infiniband/hw/hfi1/pin_system.c | 474 ++++++++++++++++++++++++
> >  drivers/infiniband/hw/hfi1/pinning.h    |  20 +
> >  drivers/infiniband/hw/hfi1/user_sdma.c  | 441 +---------------------
> >  drivers/infiniband/hw/hfi1/user_sdma.h  |  17 +-
> >  7 files changed, 510 insertions(+), 455 deletions(-)
> >  create mode 100644 drivers/infiniband/hw/hfi1/pin_system.c
> >  create mode 100644 drivers/infiniband/hw/hfi1/pinning.h
> > 
> > --
> > -Denny
> > 
> 
> My bad on the subject line here. Should be obvious what it's for though, small
> fix and a refactor patch for hfi1.

No worries, I rely on submitter name more than on subject line :).

Thanks

> 
> -Denny
