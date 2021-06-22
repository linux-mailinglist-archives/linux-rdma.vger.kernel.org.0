Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB73AFA11
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 02:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFVAII (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 20:08:08 -0400
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com ([40.107.244.87]:33184
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229640AbhFVAIH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 20:08:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKWGPvagRn3y3tvFJKYwnJ1vOCL2Gg52l8NDKls3jdDcmAQkSjt6xS9Nn6M3d5yBuAMTUQkNozlX758HaJZiPTGHMmZhifSyZ0P8clLzhmKb88T6nnfKg6T0sBQ4jiav+n97jR3ARPp7zOgvJFDvayWEIHmD4I1efLOA47YhMYszL3T+euu1hVic+kK6XrV51J/pS8xYyL++r0xVTAzEPMXmdqQSrjzsnvtqZyhfwxdfDl5OULCmEXU6o9TTjmvUd5SZzjV0RsbvrmHjB8HTVpqu5lVJoPbqYeRXEIfY+z6vlfwgVzD2ND57EWenbkmLi9rq/6T2u115F37EbIIDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekkyWx9uQB7OmbovIxEOPXniEIJYK31tBFJaBySj+Dc=;
 b=Dmb8zbzACHEPsC1CrfyxdT20asHSC/XQn0y/ltjgNznVMH3D5PcNjx/kxz7x7MitoMd3Dt2M4JGL4lufA0LIbkFl75Ez8FQ5Cb7zWMN9t0h0tBXIYiHrad7XDPPYRS8beAboT86AIMw+AcQD/dqSpyqU2KnQD5+FS9CzmIOOsMlLG61pS4M68CXNikt1X4YCVRxgZWZPg1vrqlx/5vOyv4sMQwsX4ocznqnNtCmei6NEms0zFERwih/5CwQlTYzo1WRRtNKmxlkmxPtBs3II44BymKu10EBLnbSEzWpuT6WQ6lRNHaHhvo/LFNzRp/QzVHYcDnfXohXEOptVyHenTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekkyWx9uQB7OmbovIxEOPXniEIJYK31tBFJaBySj+Dc=;
 b=O3vSgyiuP00/9fsZz0RodTUgTBvD4jcA7pgYdUrZW818JRzIhOTeZynYcL0xWCHVsV1jEIaM6q/GVAbzYJGljrmdN2rd+B8V2vlAQN7MLSGrzcUzjJSCC/Kcj86GAe2kew7T+Xi/VjM1AhPGNyiY2Yj4w+wmIFfRTCpA7eLIxZeNBhn+gR0w2Uac7c/HtjlnLqlDhxSphNi/0SBIpdewr8DpMTPXEnYe8OWrNgdtAJNU1JmMKD0wiHoM3p+Ee45Q74bKMNz+7PbkTY10TmMOwc1i2HOJ1HHcCXKHqL0UUn2tW9BycM2+sD6DGmKbegdr1MRFK8CtROKT8gpnQGFNmQ==
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5095.namprd12.prod.outlook.com (2603:10b6:208:31b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Tue, 22 Jun
 2021 00:05:51 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 00:05:51 +0000
Date:   Mon, 21 Jun 2021 21:05:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Yishai Hadas <yishaih@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] IB/mlx4: Avoid field-overflowing memcpy()
Message-ID: <20210622000549.GA2384990@nvidia.com>
References: <20210616203744.1248551-1-keescook@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616203744.1248551-1-keescook@chromium.org>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:208:120::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR10CA0006.namprd10.prod.outlook.com (2603:10b6:208:120::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Tue, 22 Jun 2021 00:05:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvTvJ-00A0S5-Kj; Mon, 21 Jun 2021 21:05:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d6c89f4-11b9-4659-d8b1-08d935117ef4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5095315CB3BF1C2E31BBE2AEC2099@BL1PR12MB5095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZcUgBWVkADvDUIYLuBwqA+JVsHVD5G3uVU3i3RUOiA0gGXkTaEWW5f8/WixtI35tmSO30eQ2/l57zZn7EZDAYbiOMhKaSGSQL+S8liM9cb3RYKkAh8ieFtwWADmWjFteEvncr4tAzhWnDmgOCK4026dp492/GFYFYvu741Bg0Pn0Kdrl7bujxbAbQpuXSu7wd3o4gAynQqgP0/bzCcP1XfmDYHUR38ZvFqdN8WmwYZ889YTurS+yOwHNrLvHTtK0H9AlQACgJssia8yR41C9Grb1KRWL5StHdFAKHuYum9Nbf1xdBVL0gR+wPjQ+8pR7v3Zz1mYt7THqqyYaOGMWoiPk7sN7/u7Gs4vMr79LdDRp6pVXrAlY2pzqSeOcS11ppz0V2+9nbzKwkTa4k2yr/l0c5GpNEbk1/2Dp3Y5mZG3IO6Aol28YAdl83aBjc3WeSx61T/u4m5sxsbJ+VKp1XJcdjauUVEoWL0ivft+Zz0lCeRMA3SuQ+y+YR8cFEmcwaB704w2ZmnaSNT5115sZdZshxnLfp3Hbv3yFvnri8CFja99o7cWmT97zSu9//flKy2RAXFkU4z6KIBcPRP1XtBIQ7iT9ckPMjURb+w/tbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(1076003)(8676002)(26005)(4744005)(6916009)(2906002)(66556008)(2616005)(4326008)(316002)(478600001)(9786002)(36756003)(33656002)(66476007)(66946007)(8936002)(38100700002)(186003)(426003)(54906003)(9746002)(83380400001)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oIM4ITu5M5CKbV9mWSsfVO3E0V3181DMgyfLdWVeVYfjbdMTB5QKQAao+BNj?=
 =?us-ascii?Q?gQ/eb0dd12+yWM58MErBEef+L1uR9TBi0Q4zkHto3awLwefi5/ZbiobmoBK7?=
 =?us-ascii?Q?kZDERBFux44o3I+1C12jDMYyhsIXCGNkl4Y1WoVvN1ef3myTkbjj/isEsx0n?=
 =?us-ascii?Q?c2VqnWdoGUMaxpQmFiJAP9wSzBumd3seXsKhutmPW20C3zVQfASQvFoeHsjk?=
 =?us-ascii?Q?Fu3JDyFWTwZuy6rSA97h5D6L3alb83tyhZDzzOT2UrFTXXVWvwfbZaIbQFaR?=
 =?us-ascii?Q?gvy3QRW4SP+KwGH6TFrG1XH8zQ6WPPr2BWLtmsSE9zBosia9NuXjSya41T+G?=
 =?us-ascii?Q?Bb9dBbkbykxpCkXc6gYMzUHaQej8DX8Ft1z8/KoIOrPq9GqepCPBx+shxZ0S?=
 =?us-ascii?Q?HiItcLQ5wcaAs9dtnZxiTuzzJplQbCJLfDEwBI6b3YuCdmbUdR5bK6CBpsD1?=
 =?us-ascii?Q?McRmxIcE8d68gi0DbnVaJAgYeW7uj3syt+sEuApDSu4qcia6d+56QN+Vtrqn?=
 =?us-ascii?Q?62f9eD9819Xf0qb0Tp06+ycb0LI0EyRH7BQeIU+iskvQxMxev/KV1oMvpbYG?=
 =?us-ascii?Q?C7Mt6eyabnC3yc+1dYSyITBGyg8kEmDviqIL64DsAgaJmTvzUyZHerMDOVqA?=
 =?us-ascii?Q?C06fsUVqjQOsBLeXFar3QeedqvLqzfd+ZnJfGR+h5ACBLZsNjXuvQQofqzV/?=
 =?us-ascii?Q?2jfen2i8q+6HVKaSqYObi/PWBEnZSHV4PYSg5A28hUTribAwTf/pCSBNyxsR?=
 =?us-ascii?Q?3plXGonRu7tbWl/Lu0w/vH2UvX8o9VAMzHllJJ03C37awc+9V9QO5s/rc69z?=
 =?us-ascii?Q?GgzskYqHkGpPrnH5601Z72xVYMxdcs9K8iSxH9TIz0t++rj78lVubbmja1Vy?=
 =?us-ascii?Q?2Lm8bpP7qPFn7yVyhRlHHqQokBBr5YCt6r3v96xq65B05ML844nHkk1k1pUu?=
 =?us-ascii?Q?yCG4l5m/mmiYj/23/iOcO3kZFqnxqyShDKjx6M84+AyntGLbAY3jfJtxNPOM?=
 =?us-ascii?Q?qpzQt8/eOK2BY1XkNKCpc9+sVj4I5hkZmLd7XyHo5F1dHx/cIJ5YbUPyxL7X?=
 =?us-ascii?Q?9cH+PcxZ46DFfpZim63aFCL7gva3WNTeHAEyeMCmhkjrvKEDF7XsbcDRm29M?=
 =?us-ascii?Q?BUjXgYbrJZlbIJ0daNEHE/lI2q2ISBptsqZAv9ZAN0n8x2sCdQO0iAFEFGbs?=
 =?us-ascii?Q?jvUTpGS+SOx2kw7y5hQ1hhrjav9y+LgCcyY4sbdMKAuG9keKN+I5ZzYMxnb5?=
 =?us-ascii?Q?+NYjYc7pOBvqu5xNmYVObiO2c1AwFJRjjDceAMPbDUrc4x8a0YDC+hLpbGPN?=
 =?us-ascii?Q?gB0+X587bz/bv9SSWpWSbURM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6c89f4-11b9-4659-d8b1-08d935117ef4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 00:05:51.1522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKah0a6kNKj5lJtlJgjQRr23PMh+oh0jdY6q0YBpbR8bdOzUk6adRjULJWaO3vDr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5095
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 16, 2021 at 01:37:44PM -0700, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring array fields.
> 
> Use the ether_addr_copy() helper instead, as already done for smac.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx4/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
