Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD9542A936
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 18:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhJLQT3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 12:19:29 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:43776
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229495AbhJLQT3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Oct 2021 12:19:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxJ8sKDKZnR456eftkaLwOXhwobQvM1CSzDm08xo7+FNXsQp2Qmw9WJdxdZg0er9xpXs7eO4PoVxWxHH04SAZmOXLR0xtPdzhtEDqdJxOhfQ7B4LbJIZlr8FnpQN1jfDyTFSbLeZWGib6egl+VaaTNAvamA8AS0ys3XpVsSPqrtNgsWYNHOcSRcFzI2WKPx6niGenz6BbAEiFUVNsZbWdPIHyOV8E4QkUasMvSLZtM/SHE+7PxSwLHzGeqp5Vdznn1dUdS5UL6IGN0U8JuCfNy23bsqBr10JWcR3ogZUWSmiERNzrtCruHy8JjLAhddp2l1TshRSnfidS8LCje6IMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=za1hyURc5vUIkWc7qI+g0MukP65w0I8HSfEVIm1WjFo=;
 b=UQxsYcHoKMKzo8BuC/Mrt8SWfxVNANV9SKjCfuL/tx/2C81OhtcUjTvNO6AFjy5Box9NrnCIcINsMsw5Sl9Z4cT82uD9T5yA+mg0PeOcsNrZLXS4RwV9vP35onYYTeYtgfYlnHviGtRz3xxTx5uA6S2lMvV9BNDa60gbaRaayJftbmasU1BH3vmk4EqaXPJVtgJnzsjyOebFFtwQ9Nw8nXapfpghUy8KJAl2vBO0Zv1W9I1uRNqjhqBNSW8S849gEA/DWJDEW+wuO+KgnKUkjrtpSUe1+PwLVJBU8oT6S+4/E6HcOjNXiuc9Ewd8fPGvJIltG333tPqBVbSRIctvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=za1hyURc5vUIkWc7qI+g0MukP65w0I8HSfEVIm1WjFo=;
 b=hzWsJgkA5A+g3jbp/iZ29N6PUuo9378/+cKp79FLY/uSz6J/D38Kl74vHPPSpz8Ut/x0+L2LNylzqVaAhkC36txAa3e6ISMpkjSb8dDVHynIBaPF0M9pQFknnzwEOXBPSgnDR226uyphXR/3I5L3//HsyS04Ug1MGhz/1wqnuMpfhXUgDTJiSAwvQNy3iy4w29Q2f8t1YfUsgq+Hk2IF0iddaTZQBoInjJ73ThXluUutHY422VP65WgeJAkjlolt5xlGFGO0FLUOveVHk1hAcp/4k9UpoUcQyNZme62+ApEN+9lelmnxt/Km2H/z/QDv5V1qh0i0koddC0Bfq9etJQ==
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 16:17:25 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.014; Tue, 12 Oct 2021
 16:17:25 +0000
Date:   Tue, 12 Oct 2021 13:17:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/iwpm: Remove redundant initialization of pointer
 err_str
Message-ID: <20211012161724.GA3377370@nvidia.com>
References: <20211007173942.21933-1-colin.king@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007173942.21933-1-colin.king@canonical.com>
X-ClientProxiedBy: MN2PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:208:23b::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:208:23b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20 via Frontend Transport; Tue, 12 Oct 2021 16:17:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1maKSy-00EAch-5q; Tue, 12 Oct 2021 13:17:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad1b3889-938b-4563-1fa3-08d98d9bc77d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5304:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5304EFBE7B72835D546E2A91C2B69@BL1PR12MB5304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7bjYDYtjAUQZNu4tWwlJ7hNiMci/WdYARU5QSDdiEcBRXdC4N1Lj65wmm5hmo5VAFTmsGt8jYP6058L/4+yOb7nneQtnTI1XVHgATOHOfE9LhkkNKnLmBnc3Yar1xI0PgTlsGKSKdY7XtZXXPtuiHdrxX/iGCqYWBq6PCCB13V0Yc2OdPWTOjTgsWzLOnrIqtqMKsNcDQTvPhcHX14mQ6g9Uhw4qA8hIvUp+2bQwKWp2qSaubx6L2iEuevGrpjthDM7n/ytGKPSIjgVB2COgsg9Zqh1xvBbgOC3XoszXdnDodrlEoGOSq1v+NX/a1A9RhjEGNle9Cy9y19To/Ewm45tI7hrjRPqqnfyqQzDwxa9v4k9uAF01C6Rc+aWPCdWQA0rUID6Y0gnKSuEw4E5EY4l2C6ZkNGNuudSGFSOo0HxMSQYOGrhucdvaUYBvGULYWFLopFUGRVgUsi9HAhXqc+8pDO5Iv0qTEuHynoIeIR8laaYK70Vl7AQ0rH2ccKTwsAmllMdjy5r3+H0Ux7UvZZz4Ct/wtFVBB+7e3bV+FRGraInwPyCCNIJUzrRMTLV2jdq70ZUwWlBGwqyoHma8/qRtDEABqwMkFIJJtb+4jRrAPFyt3muq6Lpu9OusIK6rPaWOKvFFsL4jorG9IKz6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(66946007)(2906002)(316002)(38100700002)(9786002)(9746002)(508600001)(33656002)(66556008)(4744005)(2616005)(1076003)(66476007)(26005)(8936002)(4326008)(5660300002)(86362001)(186003)(426003)(36756003)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RjqwiauPXbC0REtcZ5Ks4SbCD+6hvvwsrA6+TFVnw06/JCy6d+uzhwOqeeFc?=
 =?us-ascii?Q?InShOfEPY0PSOnpfCmBwqetlU1DQ8LrSdqlelt22GRT/A7D769Z02remzNGt?=
 =?us-ascii?Q?L6M65VU7rmdsUBrRcrhZtfEl0Sj4yZ28bFxsPEHXooKnZwOYoKkjds3PdIm1?=
 =?us-ascii?Q?b5AM1jE0FxeW5uJzln9/+/5rDu7FuUGfIP/QLVUlJG1EwaFn74TqNvNmXHdM?=
 =?us-ascii?Q?TrL94zFzEGqVwPrDUVxDMij3ihVMlvmTUAmW1Ywh0oiYnZPaBmecvPfEvL/B?=
 =?us-ascii?Q?uYgDyDBiEQMoPcgi0+0TVPj1iFNVssvfqLAVTV57ur1+6qC8iC0ppNlCzKP9?=
 =?us-ascii?Q?JTP1h4cahRRbb8lNhCcQxApO9VmljvnPx41eb+3DwzEp6QsH/c6WlMsB8B6A?=
 =?us-ascii?Q?VNbxmGjRNQy2e8PP3XQuzUnzKVpdz+pEHkW8ZOYpff+HQhMyIeDCgTrTtt1O?=
 =?us-ascii?Q?tQQRyQIm0MjzIzFfFEdUznrOJ1t+gQ8XdA3fzUDvYFR1a4JDGGal+XsLUs31?=
 =?us-ascii?Q?YTeCxR7U6DTMVDUPTGBb2L8HPqrY6ZDbJm2oLfxZR6AjxyWtH5aFnRAF2cA9?=
 =?us-ascii?Q?FUM3xXTrxtj3FhijMNQqUmxVwWQLa8Xu6b3eMYoPTZu3buFUREqsKJxo+Z6U?=
 =?us-ascii?Q?l7Pq/IhKIg2x9IuUTSc8ev4ZJdIPt38QUCBIuMMoR8UfurWGaC0tzTpzzo5D?=
 =?us-ascii?Q?WamKHWksYvfQqt+CnH4ryrvTtEgZyIqULxK3kmqhGWhDsZoXSBu50mUyjhH0?=
 =?us-ascii?Q?s0ENMlPTGOoQkB7n4SZJu2GibPE0B7wr2YaCWxSFKaGFvTydy8HzVYl13b22?=
 =?us-ascii?Q?N6xPf0o6st0Up7j+X4SyUeYGmdKKU1A95KvVFx9mRniWmnpbhTvpTLaYGyV3?=
 =?us-ascii?Q?MaNmQwCKENraRvAl5V3ZbdVeRajRjaBIiE8vEzh3ee/d62k2ycTlQwsRNeq3?=
 =?us-ascii?Q?znNTvrUb7mq9BntjW+TNaBT7xhti87nc2mIVuQMq8jVRMxw4QTDhFDAM5LtZ?=
 =?us-ascii?Q?C0FPNI3d1s9gjrKTo45kjUcpDIeKRDDl8Y4V47EbOHVzzULTddaYTDmn78si?=
 =?us-ascii?Q?BExLaSaksM7Je35kNxF+TLt+OfbEFk+LPobHlMVDvFjqLFwTaW69HqXQSAS/?=
 =?us-ascii?Q?2r9xrUqMMmg57ZnXdJ0MQzyEvn5cX7uU/z7PK0J41v10UqlKuKBMsa47yAxM?=
 =?us-ascii?Q?JAFfitKLdcfonLYviYOsj5oVOe07CKY41DixB+AwZbTL2D8ios0XCco8UOO9?=
 =?us-ascii?Q?aeH6t3bTW9BO4BaJWpA2MAtpIYq18EtpW+hO/CKjg4GUf147obqkcC5oM8AD?=
 =?us-ascii?Q?J7ptkGhNoPLuItGGGdoGU7Zc9DTW+I58q4/My8ZkQ6HenA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1b3889-938b-4563-1fa3-08d98d9bc77d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 16:17:25.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saDi86WHLcjlYT8Gi2QKYW2G9+EgKi4qRLAvQBU3HVmCP1HZBX5QwnLBjtOpEprY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 07, 2021 at 06:39:42PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer err_str is being initialized with a value that is
> never read, it is being updated later on. The assignment is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/core/iwpm_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
