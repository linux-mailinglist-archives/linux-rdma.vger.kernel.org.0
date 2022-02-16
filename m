Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2744B80F5
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Feb 2022 08:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiBPHHz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 02:07:55 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiBPHHf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 02:07:35 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253E52C833C
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 23:06:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STGh44YLoFjXYCutedcnB9eC28XVWBAy7Gk5L/P+gLfHfpiqJknjHN06o/2LxDb833XA58gAW+Dk9ZF1sr/vJZ/APd9bN2sgC9wO+VeH3JiyFeJArSgQno6nRdZ8rGNsclDeHCEezSzt/hl2GxciC7P1gTTrkuoeniyFcPhGCTqbIBIzLGN5AW6dE7HuibrCA9SKG2lwwEApgiD2j0TyXTlFjvUhoRklOr28HeL5s1Mngz1RN42xKMvO3GrnSjP9siLcEWNxGuSrk5mVAKFnVNSPv+mUAKLwDW8z4ThpY1RpOmQtgSDX9JTrWZ3KPwJphabXmQRNsdwM3gu56qKrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvWt9e1n7HZX/1kGOjWtMosd3NWo7NUmwShqW5Q8tOk=;
 b=kHlDPJGJGjuPcspUoAjw4NCdaHJH4QEUGy9nSHB8NJUITgdaY5ZaqJ9kxcHqGvN3i4bEJ8qV1fE7niINZsQHCkaq5guxS3TEyoS9JNny1aNDxTFk8ZVD+VPckUIhR2HEJYcp+PwZ/qqzXYgxgujVZCvrxmqG03hJy/O5qJziCgxiQqe5U5Lt7Q3nYoPj9GJJym/QxCTwxT3Ut0/uDo21ChbEOlQA4oB/xrdb0+vHdPOdltAgNsUu/14zJ3P35lBozcY2zEEgFcRUJGRifI2n5kJ5bd41RrFNq2J9i7Ph1j4M9acIC13Co6DDd4XSZXZKd+ixgg7MVDW9DOvXPtdMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvWt9e1n7HZX/1kGOjWtMosd3NWo7NUmwShqW5Q8tOk=;
 b=GG45ouXp+y9tZ/oF4aIbKBFc9uHWFbR9j+/0kGL+11+EOc/ycJ1i9538FHH0YgLDeVDDNzczenQrsnNT/BtWBc4H/3uEWut6I+LeMB1frA/GEYb7+65uZFrq6FyyGnt3kTDpTuGiWY/CL8SU9/hLQWWNrn7PyNqJhIRk5nOP4/HpZW85gSfXjr5NBWryC0wTJNexYDD2T+c7IW+vaffHUyNmYCQtwiVuMh3BPVax0GL82LW/Tw/bH5qOaOyUG75EyD9g352A+DxxeR3ARp7ELvkKm8RMOQcsGsfEc68rgfa1kh3XggIH8JhIJYnlOe4eUdUEU6dEz17Y3MiEsfzm0g==
Received: from MWHPR17CA0072.namprd17.prod.outlook.com (2603:10b6:300:93::34)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 07:02:32 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::68) by MWHPR17CA0072.outlook.office365.com
 (2603:10b6:300:93::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Wed, 16 Feb 2022 07:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 07:02:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Feb
 2022 07:02:30 +0000
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 23:02:29 -0800
Date:   Wed, 16 Feb 2022 09:02:23 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH 1/3] ib_srp: Add more documentation
Message-ID: <Ygyhf1YU6mJoVubK@unreal>
References: <20220215182650.19839-1-bvanassche@acm.org>
 <20220215182650.19839-2-bvanassche@acm.org>
 <Ygv0IhNMJxFHSi8Q@unreal>
 <d76031cc-29bb-5dad-6f30-b69fee5966cb@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d76031cc-29bb-5dad-6f30-b69fee5966cb@acm.org>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce020946-19a7-4b5b-d84a-08d9f11a4d88
X-MS-TrafficTypeDiagnostic: DM6PR12MB4862:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB48621E06D2A898760EE9937FBD359@DM6PR12MB4862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqQv5mVbTh5vyFq76tiWM0ClJyZWGsam7CQyjZiLuVKAtkxc/035cJr2cgkD4somb6aTO4G4dpwkkhj0EsC2rE2Q6gI/e/5H+1rAm4tBFZ5jgUMEnprIc20xK22o/3wzMKTXqKoKStZHtTOHBynK5Ox85yIzgAsaJ5TZ2J1Gsyf9siP9WqbsxpP0NHUGRL5IxyweZHVC8RPgOXWyFi0FcwRhEvHxeiVk4rmw9SjNvY7/vR8VCSqMQ1QxaGUuGka7TVNcKwHH5C9iT70hMoPFVBVC5rZbHAJ8gaF9OhSfsW/Rk12PX9GG6r5nntMEvJ7KEV1oyJ/05c6ai98ENHYWL2GAXWzRLQzbOvoDNsy6qUu5SSZhIPS4FvSn0fnAsRo5aHJKKW4/Xo9dkQ4+C7dyIQKS3FqY8GWdvZtFFLL4H9Ejr7v2rFna/8Ywmno1zPBZ3R8hh4pJ/5cgK1EuDon2p87UStrhRbzeMU331ILy0gOgNmHA8+em1Aezv7lOsyFmwCHbSLCJNuk2g8zym/ikC5hfwNHXYzl3QAXncncKOKiGdDQUBOM/vlFFqb5hFUz9C2YnyP47oc50QndHWenekX6CpAyBadqtrnXt85SJtFjQDvmsy6nG50xGnA6nv+FkPByAzT26T8ixuQE22H3pJrisMy5VuIrYr4yrGCE67hYcsTADUln6a1LAC7Pd/Lg3//UBn+wHbQPkXb9nHMCbNg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(7916004)(4636009)(36840700001)(46966006)(40470700004)(47076005)(26005)(186003)(16526019)(316002)(36860700001)(336012)(6666004)(6916009)(426003)(54906003)(9686003)(53546011)(82310400004)(8936002)(70206006)(40460700003)(33716001)(81166007)(356005)(86362001)(4326008)(508600001)(2906002)(5660300002)(8676002)(70586007)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:02:32.0956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce020946-19a7-4b5b-d84a-08d9f11a4d88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 15, 2022 at 12:34:27PM -0800, Bart Van Assche wrote:
> On 2/15/22 10:42, Leon Romanovsky wrote:
> > On Tue, Feb 15, 2022 at 10:26:48AM -0800, Bart Van Assche wrote:
> > >   /*
> > > + * RDMA adapter in the initiator system.
> > > + *
> > > + * @dev_list: List of RDMA ports associated with this RDMA adapter (srp_host).
> > 
> > Isn't this list of RDMA devices and not ports?
> 
> Please take a look at srp_add_port(). I think that function establishes a
> 1:1 relationship between an RDMA port and struct srp_host.

Right, but this list contains devices and not ports.

Anyway, it is not important.

Thanks

> 
> Thanks,
> 
> Bart.
> 
