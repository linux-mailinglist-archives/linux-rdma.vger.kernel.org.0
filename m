Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7FE24FEE1
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 15:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgHXNan (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 09:30:43 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6773 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgHXNaZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 09:30:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f43c0b20000>; Mon, 24 Aug 2020 06:29:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 06:30:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 06:30:23 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 13:30:22 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 24 Aug 2020 13:30:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILawwtRWp0kQ5qxgCdi6+MFpoYRl2Gh/HdLdaKnLrb++QuJJWxMv/Im/afbbWbjMUDPakcMhlEa6c2ZoExmb6bmaHO1ILs0sEKepe8arFwq6qgLjDTUrxkm49ahavk8uNDuRnLt2y9hrDCku5oJsaf6XfD/zCVrIO3lh0SsfWltg7nFxYO4SJKQYWGfU5oGq9wvGVx3P7zGYppw2NFFAlnaLXIZXv7r3egmL5MuoFJvvILpvFXlRmUMJ+jSv+g/RFO85lkcaHDMU+Fx5uvQheuSO+PP0pkw2MJT4TQKfFF5GKg0YqMrImnwaZd35VNNdG4v886Yyq1GtnZm9AbU6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TN1JopIn2kmjNT0Ht8JKdMMorsvZinkdV4so4E9b9DQ=;
 b=Xb0kBORug4D49aYkB7A8iJ0CK1mvNUE6pQ6fBzLLLbJ5q4SUVhUL23ewNVjc/19DjDMQItxxkfDdmkKfnzBfyQd43vsZo0UYPRQC5p9KtwOQJoWzqqZGgsBPlvtXVUbnOy3Z0mh9BgSUyPYy6LWSKd9N7P4n0cOVBLtZl+FA6Uzqp4DG2FEOsdmTh454F3Sw69p8xzuTbceYjlfVNe4dR/oAgsMylWVQ/KvE/SR/OUz3Gkir9/m5DddCGmwPD1cHnI/rv4aAOQuX9CR+jkgm22Ujb/WZ8GTnaRMKuAiuv8+Pv1HBPl/guEBsqHXV3Oy/6b2DPgJrJNBtT3cCcgbY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 13:30:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 13:30:20 +0000
Date:   Mon, 24 Aug 2020 10:30:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <lkp@lists.01.org>
Subject: Re: [IB/srpt] c804af2c1d: last_state.test.blktests.exit_code.143
Message-ID: <20200824133019.GH1152540@nvidia.com>
References: <20200802060925.GW23458@shao2-debian>
 <f8ef3284-4646-94d9-7eea-14ac0873b03b@acm.org>
 <ed6002b6-cd0c-55c5-c5a5-9c974a476a95@mellanox.com>
 <0c42aeb4-23a5-b9d5-bc17-ef58a04db8e8@grimberg.me>
 <128192ad-05ff-fa8e-14fc-479a115311e0@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <128192ad-05ff-fa8e-14fc-479a115311e0@acm.org>
X-ClientProxiedBy: MN2PR17CA0032.namprd17.prod.outlook.com
 (2603:10b6:208:15e::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR17CA0032.namprd17.prod.outlook.com (2603:10b6:208:15e::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 13:30:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kACYF-00DFO8-Ft; Mon, 24 Aug 2020 10:30:19 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40c104bc-27c3-4d0f-f18b-08d84831d911
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3210A8AD3ADB3E0E61ABB7A5C2560@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Ve+6Gm6R7jMmhRAx5yTaTd1eZksPZz28SoYQXM9MylD1B3fJMjlSdoyW7E5ZmfZRdf5A/QqCBBRUJk0f68xr7uIKT22VEa0iHyHZruGgFsRZ5cWNX9iLHD2DyEOVGr1CFDkQ3LyBiL4lBdyqqDful8GXfYNIRbOO9TWDsq+jYr+TjtyJ++j7arvDy90BJM79pejf/aZWR8jdtiqZJ16cnzil7KduZVLFgknPci6MMvm2CgmKai20WvYkmp25IJWe/ro2w8igHNmf3+dB+kHVmwPf8frOH09KbpP9lCoVTlGelasrAzz3LyfhtZVGlX6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(8676002)(478600001)(4744005)(83380400001)(6916009)(426003)(86362001)(36756003)(316002)(2616005)(54906003)(186003)(9786002)(9746002)(8936002)(2906002)(5660300002)(66946007)(66556008)(66476007)(33656002)(26005)(4326008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +awtYCY8mhD5Z04TooenEDhy3rEelR4q1fTzCICCDwL1n9rulSg9D1fzSORi8t525knanZAncaZ3zkxE7YWuOuvRoGgG2exAnHlTTk5hhsNFBHBtCcRnoYt2EYfJ0VPL2b79+/Icbr3jLFmZPdDELxsTKjCSZFzFVoPBrBSmhQIqpBMxNActE+YB6/qfTflGgD0afb2V3wjX5dDnqKlBBLDwgbCGetMI6n9WWvJTfxhbmMXQ9TN356t4iaZDu3G79wbA/JMhqH9T3fPsxy18WRGqqC/VP81PZSk5yiXraOOnPiKQlivkRLgXXCouMZzzcnU/i/jbxJ1sliBAMeOnCp+B11QCJx6526+Tt8jv/Y3Hz/MSd94v1hDw7e+FE/UZ1Ty/SJ2Vy2bdenHAjxc34y+ZkFy2VxbUdyg4rKPq5jb4EjbBCuBosF/jgAytURzZcWQoPYJQtGjxqjnzxWXw3p3sQsoK9wvQienoQApMIxE6CWdP6vp0xSoPV8RLaqmVVMff5cBJt2OdGP+j7o9DAIn+AiGZOR0OPtBj/0hWvbmSSS5Esc5Zkv2oQSnkKtoUW+lePWodtR38HA6DnHOE3+fiVaf1nExBAfcyyLtXe2KjaF4JJMgYGU0IgEHuc25RDbgo3cJLdTggADrmlNZurA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c104bc-27c3-4d0f-f18b-08d84831d911
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 13:30:20.6493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twpCiJqHcWk8pbzG0Cz0G4BKB2SaxA8PVdKZYveRAZjlHaZ/xbNZPxRq1AOP3Dms
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598275762; bh=TN1JopIn2kmjNT0Ht8JKdMMorsvZinkdV4so4E9b9DQ=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=VFPwmpIdPWyZO0W3o4W4Jh1GQspi8aHKm011l8eoY+la0qAUF3/UK3bbCDInfe6Ku
         1UdNFJAgRY53Ovr6aUzWIcf2UYZH5rZzdGSJ9uz2LGOWjFn598cZoeaEqSCAdH6C8t
         G0CvBeOUTJAuLjzG8kJMe9PaEPGCWtWXW2itNOER+uIiC/XXl5FcunyEReqgt8LQ4Y
         +fF9SMzTh+n09ll/NeBhgMiI3XTEKiWTdNiyBEw8+5fNQfemhTLYr1r4eJOMhx+cHT
         r+ZIXPeFxbGOfgX9grtUuo45DxI2OtujSE6L7mPNZx7Vm398ZOntf4Xz4u6k+PVQ+B
         957posS6bcoew==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 23, 2020 at 02:18:41PM -0700, Bart Van Assche wrote:
 
> The patch below is sufficient to unbreak blktests. I think that the
> deadlock while unloading rdma_rxe happens because the RDMA core waits for
> all ib_dev references to be dropped before dealloc_driver is called.

Which is required, yes

> The rdma_rxe dealloc_driver implementation drops an ib_dev
> reference. 

Where does it do that? I didn't notice it?

Jason
