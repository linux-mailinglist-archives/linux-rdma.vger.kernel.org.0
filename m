Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE3D66B0CE
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 12:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjAOLq7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 06:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjAOLq7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 06:46:59 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B768183E6
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 03:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3IUMrVLo2NJms817f9FHYH/lt/jBu7wFLjXFTB4HEdjpgg17vK1iuz3blzGC20M+C2cT2Xh+/W7sHf7U4WKe1y50ob6tlTXWQNkjLVMIUntGFbttlocaNKTnfi4VM2lTOEIImbTSpy53J63B71GD5Kctf65P+HKwQldCx4QsdBxvhSNe9Xvz+tpUG9352dBLgzJ0YegqtXrNUGyCJOY4AcXXoiJqYX8qbPyFx6BKIi7jCQ/48j7c2xpriIsUcszkvsaZByvSCLHdP9qHcSNDg45bSYaxAyO/oz1GZ0QBoo+vsVr/WDJ5scTQtboy5vHwOA/S66/eeW1G5W95YG7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vwGm+1cM7MJ2fheyNfXmcgWBSmN5iCTlRKKhNa30K8=;
 b=KM+zFipN2ZV34M5BxnBdjt7aD8HvtP11vBe49AjPF9Nr0FK6uJyXNSi+6G7Gl6hGWNjoPmlUYMb72D8pem/K6NZ7YrAdmJsQpltFtLhE26NwNRT5K/EY1TKD06W/GjqZ11ZOxoYFEKquIp2GAc93/nhUdXqWFfQBBVKgSMZ89ggJwrvbYWqJ8WJysJk/IW4CwRGtmwtaGPjWxKS/rwzNK9+/xwl/S46yqLQ5+Gx8CoL9J9tf8yO0typK0hErrWIGukSo+fM75w500L11Z2LFjJE1VSEOIF+UPNoaZEqM8C9nROMV+j6ifFSUz0/w7kBnZol/Wap7tZQWlhDSZdmHOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vwGm+1cM7MJ2fheyNfXmcgWBSmN5iCTlRKKhNa30K8=;
 b=TzsSKJEyRvWTAvDRjTm4BUWRVFmn2OTZVZQ70xiOpggLqjsS3L8Cv+CpgEi9Tp/obvGjzMwFN/yOA5igdqjn/+I0B2RyjJtGx0jfBG9yJcfuYig4CZFcJgZU+S1Sz+5Gu8UFSXyrXzsY1yNgH3+h56NgIRdMnk/QJjpt9H5rqBrdQi8obPUwIAh4VkaKl7ucVdAN68mD/ooyP9fxkLUIrW6oUWkpqDPiF0Y7/d0hnvBQfgWVhICNg+MZTHOhyWeLitSGbYDZl6MGxr+tZdrMPU5FlG5iJ7glKcWwb73HkulBWBZGWER8GGvGNfSOpGVzD+EEJqxxOMEpO6O1ibnnbA==
Received: from MW4PR04CA0270.namprd04.prod.outlook.com (2603:10b6:303:88::35)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Sun, 15 Jan
 2023 11:46:56 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::58) by MW4PR04CA0270.outlook.office365.com
 (2603:10b6:303:88::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 11:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Sun, 15 Jan 2023 11:46:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 03:46:44 -0800
Received: from localhost (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 03:46:43 -0800
Date:   Sun, 15 Jan 2023 13:46:39 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Message-ID: <Y8Pnn8NokWNsKQO/@unreal>
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
 <Y718/h2uSTYq5PTa@nvidia.com>
 <3cf880fa-3374-541f-1996-d30d635db594@cornelisnetworks.com>
 <bce1ab36-66e4-465c-e051-94e397d108ba@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bce1ab36-66e4-465c-e051-94e397d108ba@cornelisnetworks.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: deea180a-806a-4662-697f-08daf6ee33b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Sn12VR5MjhN98IM9KMerbg3nHF4n2qxsx+78upNturY6lDjugnHPy3XsbnikWPSJQQgXJ5FbfrI6rvlJcLW4W0xRdvBckTFyF95ox7Kd+rA9xdfkH846dMB9Tmy1zGn8HZ38e41IOxP+gIEvCkFmljJhI7Uzp5nbjCKJpYLmNxGtDgJdYlXDaYU7ZMBn061EKmGKH3crbxAgtF1TnCrZlhUAMQoNO5lBsKCF52LGb3f1wmoEVP/svvDj9mcky3u8+3fgCie7r1kezRx1veARb102HkLRJHBo3WlBFIsFuaH4LcarNeUpLaGj68JAMtn+UUZyTZuNmHX1wz2lwG2MzgWlQV9yZ3R2wyjERzaN08rVNlijWzMPkROxk9Zy73rqf3xFm38+oI66lbd2Xs274hfgwHnQz6gAcGuBC7CrSPNCo+dL3CBI844EJenJ7u0i/O/FSN7Phd3LsM/BCwUmG/uL1Qo94edZbUAzoiUfNiT24Dw8zSOdwzMXbx3qjp8aoaMKL9dzvzcBtGW0/C0owWX4wMfcI30yTPr1Aw6eJXm4B7XBXBQ1F9OIsiFomOJoB4MpHde3CKn2KoELWFROxBBBitmLD7mFkcbvYcxfpa5LzO4jyErwBBDUsspe1sGu6uV63C4uKMrDCjkHwpiE/hWPy2xkHB3HjLSXql/P2QxeoLR3rS2A1/m4bgy2VLIVxlmIxdmbDnLQmYkwR0M6hU30jvX6LVZTouO6Wp10VQiZUxWhmU31jtiXwQ2WnzbaN6klv0rmuYZIIIY9ceHZOWcFubX2I51p1LcZL/rdVA=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(53546011)(2906002)(966005)(6666004)(16526019)(26005)(478600001)(186003)(9686003)(54906003)(336012)(70586007)(70206006)(316002)(8676002)(6916009)(426003)(40460700003)(41300700001)(36860700001)(5660300002)(4326008)(82740400003)(8936002)(33716001)(4744005)(40480700001)(47076005)(86362001)(82310400005)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 11:46:55.4763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deea180a-806a-4662-697f-08daf6ee33b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 13, 2023 at 12:21:50PM -0500, Dennis Dalessandro wrote:
> On 1/10/23 4:03 PM, Dennis Dalessandro wrote:
> > On 1/10/23 9:58 AM, Jason Gunthorpe wrote:
> >> On Mon, Jan 09, 2023 at 02:03:58PM -0500, Dennis Dalessandro wrote:
> >>> Dean fixes the FIXME that was left by Jason in the code to use the interval
> >>> notifier.
> >>
> >> ? Which patch did that?
> > 
> > My fault. The last patch in the previous series [1] was meant to go first here.
> > I got off by 1 when I was splitting the patches out for submit.
> > 
> > [1]
> > https://lore.kernel.org/linux-rdma/167328549178.1472310.9867497376936699488.stgit@awfm-02.cornelisnetworks.com/T/#u
> 
> As a side effect of this, can we pull patch 2/7 from this series into the RC?

No, everything is in for-rc/for-next now.

Thanks
