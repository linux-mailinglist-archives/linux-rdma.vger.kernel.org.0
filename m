Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6A74F9B93
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 19:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbiDHRZS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 13:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiDHRZR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 13:25:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50E715FC6;
        Fri,  8 Apr 2022 10:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjJ/ZU/JbLKwfH18iYQRwsSwmhCu7NDUOX3K4fbkOqMNwJyPOddIWpxy6+LdTyEHkfAZ0fa/k6dNystt0vJijTJ8AnRXeA6WC1NMS649XIoQ/pNGgcUVs/YbQFJZz/9Sny32x89cNFfrFLG+sAuGcn5Mx2iF2VU6v/h3yMICKwyKi5lt2j3c2pyP9netQ61fI9Y8mVm7nut3rGixtIaMY90UwdTa5mgQpZFxuT6ana32O/E8uWprB3/MfJ3EigCDOKcK/F1QD3L/egW+mHAyhy5yc+LegblxmYBdgu3FV+7KolVQLx3LZfoHVt4BU1lQPmlNJNq3kC8i6x3xVEeVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFFSBP0L6O2YZ4eZ4TBmERFfujY10FxotNxezTuso70=;
 b=I3KanT4hsSMx07gXFccRiM+5LfAtGN4O2g0UHydy64z0GC3g8wdZOAP9RiXc3/v3kPTTL7DfIKkgYgx62Xu2KfzAWZ16V99DVOXWpJ1mGoSqnZrifP1U5hiQ7XjXfaQ5n42CNffb4Q+QjH//2KWS76+UBMqzzCvO4UERLDUmwdBjz5JsnJI1RWc2e3N0XxS/Z7VL2qR5e+ZWEny8ADBCFDdRr+YHOqkjxALxgVJbhT1MGDSmTlw16ZqHzdfvrDyNcS5CvifNtTp+SzQVFnoAjzApYkjXVLaCUha86ZHBPDAC7XjZUjcIDAGJJ8nJbQEcuHgL8SMm+I4wSBuvkv0ajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFFSBP0L6O2YZ4eZ4TBmERFfujY10FxotNxezTuso70=;
 b=cIJOIZac/NlP2DpvwL5/XoCbkT4zARgXcT3wry9y2Tj2QV/hfkgntzSKL99cVePSt6TndEHfReHXo7VAhvx5m5YEZ4YEDLRcB/gL1/siUdOnTFj0864Yy91JAyGaZyJfQqiQiPql4OThR6slIS7z9cSNUQcooO1STrC3aE/YI3YTOkGgYOr6nvNULu84IRizb/8/iEkUaw7yhMaQxbBdafmkfgPD6zDAZGaFsbqls3OcnSQPvBlHMUUfa0jK7swMjXI3ymujzHRBsyoh4CuaT2vLhoOks72xo6I5kUZRRNPqQfKJJtIJeeIM0LYbBzTQ6Xg3JwW/lLbrm/xMnNjnrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3262.namprd12.prod.outlook.com (2603:10b6:208:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 17:23:02 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 17:23:02 +0000
Date:   Fri, 8 Apr 2022 14:23:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     benve@cisco.com, neescoba@cisco.com, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/usnic: Refactor usnic_uiom_alloc_pd()
Message-ID: <20220408172300.GC3637956@nvidia.com>
References: <ef607cb3f5a09920b86971b8c8e60af8c647457e.1649169359.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef607cb3f5a09920b86971b8c8e60af8c647457e.1649169359.git.robin.murphy@arm.com>
X-ClientProxiedBy: BL1PR13CA0420.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9bf9452-0e89-4164-3d5b-08da19846f1b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3262:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB32625949229942120D06811EC2E99@MN2PR12MB3262.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HhpQlrPFDvoWRt+Awy94PO7pjoi0FRe7qZvBNbkLPEEbhhT7g8qgutWQNLWIUAMw9n15ANHpZfGsBgqP3/yG7SLggZuLTKYROrSCMehOzi9wptkn1fybvQJHzThIKL/HjLJNIrwxktqQn1rLZbdneg58mQAkVIpf4kHvpDqvivfdmB5J4DJgjO4oeI6O44ZOalRj/12DbKdXjA3o+TOlAUN5HJOndjrbP9vLOzyt5B5rR/yekmBzqvQH0GhrImXMeCHhGvYS45I2f6J11hLXljwNDrYO5bZIUefyujPwVcfO41RXrZqxHTqrjTMi966Nhsf4iABAkhNuqAmznnxtwRz2ioKa6l73ZKBLuV4HvDFipszppOYc7uZkkI04z+YEcI4k52/grxT9J+i0NHnBWsfpHIikd3npjPIv7hKGepiUB8Bjlrn/Ufv16iyg9FzFQlVvqt+qWudn5MWkFUuoenFPZty764RU5pwftR/w8DVg/FSR+EJbkJOzJz+evEvmtfze4jCn4eRt3t0bCcfNOO8WCr4ZVLEfBDQXUYcve1FKXfPWmAUZthqflgdUXPHXI6zFNiqIRqaQbprasRtzjRr0h3OGVJQ0wNtJoHdXgwR/HAOFaCJmFJ5DkzjAmrU4dSpLiNN8JRqj4o1hX6dCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66476007)(66556008)(66946007)(8676002)(5660300002)(8936002)(4744005)(186003)(2616005)(1076003)(83380400001)(36756003)(6486002)(26005)(33656002)(2906002)(508600001)(38100700002)(6916009)(316002)(6506007)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TgsUOb7uZuiQtK4auy3FCF2w67uV2cMYF5dptHxMNSGm5HldNWzamet/UN0Y?=
 =?us-ascii?Q?wbszWHgf78/CD21a7yPM7x/axzQxKoXax1x9udomgCzTsfxCj1Pan5fp5ltF?=
 =?us-ascii?Q?Bv+AywGYavdUYZxjq0HEa2XOho8sVK36yQas5s/T6kJwnnl/TvACDZmYAhL5?=
 =?us-ascii?Q?VHVfp61i0uAt7fZjyPUt3UfTBk2b6XfKmZDnRI8PGt8HFtkhNCQYCfcugF7/?=
 =?us-ascii?Q?zOtH0eBa1rbjskq7/3rjzu1dp2HhuGU8o+gMjNeL6CpFm9Ycpmj+PdtSIl4/?=
 =?us-ascii?Q?txsoC3lGkKDS8+5gZemuV4NFNATqWjaiwUD+J8Qwb5PJaooqwnCRqgEPR7mo?=
 =?us-ascii?Q?jsO/I4vFxCSHG+AaDe+0WXCwzGCm6vpaTqBZf09E2nTynyLwvPLaO5EhhW5k?=
 =?us-ascii?Q?UfvnUxC3bRYpxLlNIVUyCPQDQsnN1Pw6dwPIS3lz9qG5W9KHi5VaBXx+pgLE?=
 =?us-ascii?Q?j4OATWZHjbkvQq+b96HOZw/G4A10SjQOeqZcpt0nZn8nuvuQ7JBHj8SXkS66?=
 =?us-ascii?Q?d8RjX+nWcwFUvMv7r8GJIDJN1fWX73/a9r1tTI82+ksNt8rZ05o6Zn1IZ+Nf?=
 =?us-ascii?Q?LxRRfSNZvIpEdpPtIedYR2HRiznyCsCs3n5zkoUUQTnkFw00VjzamJ0p3llT?=
 =?us-ascii?Q?SH5JFtTB3QO11rq0XtYnirkK3gmwG944uNys/Kngyo7Mj2r9EdPudEPxMfcn?=
 =?us-ascii?Q?yJLAODYsyOV2zCLCSJkKb33LKguvxTdWICxibTow3/bSq7w5I77BaswZXvdZ?=
 =?us-ascii?Q?eRjjKqr96tik7cGN64VAYRRctrWWQeeInMh16RyMKUGJjOOZ0FzFdnYC+yOm?=
 =?us-ascii?Q?8JRBfUtpg44vQgMDddSxtl91YnJkx4LUuBchz+euJA/O7Lp0QRxH+wC2YVJH?=
 =?us-ascii?Q?lwbL/rddRd0Kt4X8XQWSSoPNz9nspiHQ15Q9H4SKOpYKqNpP0XsMe5DAMQo8?=
 =?us-ascii?Q?GZvqehC0nMw+KwbJbDcwW63p2CQMEVlA7PpTMv7gLhSpfQWXdDrOHQynft+/?=
 =?us-ascii?Q?lJuRGAnopvmKCfeoc4qyQN4VGVyt9eWrGNRpKogNZnS7YZ7HpWTbHZ69qMzh?=
 =?us-ascii?Q?zBsb1KS0Aqk4re89/F407vMKZpVYrAsHeEap11x8i5VY+eggi5yKJOEuA40T?=
 =?us-ascii?Q?aSESDu4aJOBUUdN/xyHEM3yWIYhmesd4aFnDkAFv1eZQFoFEaDx+Cdho2jKl?=
 =?us-ascii?Q?j+ggeE+F69MVL2pbY2yx+DSK6ajQ0/5g2iuqGXhxcEe5xy3qB+ETFnENcPo8?=
 =?us-ascii?Q?ax6fULN0QtzesQq4HRVVpE8SIaAk7hp1anbCewrN8N3fHI5O42idWAqWGBfu?=
 =?us-ascii?Q?6eF4gCpKSOQNshkiZ77Iw/Jyl/YLzbaEBFR47b/1+zH/vnh3nIz54Cp3WXqV?=
 =?us-ascii?Q?S8ArAl98wnR7oITbmFnP7Wgf4rvs657NuI9UxF441Wx/+/Q8FF9Qi1g4smZr?=
 =?us-ascii?Q?Eyr5QGY8GNw36yetljiAE5Bv0c8Ci9k/rY4Plx2QDIjmVw695odykp3y2nfr?=
 =?us-ascii?Q?/zRCq50mxjIdkPL67gJPh9+nZtn6YmeozgQIEH5vAGwbi/uhHdGI21+iOmdZ?=
 =?us-ascii?Q?xICYcPBn2/wm+a89m/EgUzrdXqODFJU3lY2z29THtmFgZZqtTJF8eDlLYgWy?=
 =?us-ascii?Q?s4BgtWBOt81A1aJCLMuIXJ/Dj2hzsgwQarU54ufF5R7SJjJAyOcarVlgvgYL?=
 =?us-ascii?Q?OVZOWFQZjRZIW/mjL6sL7TQCpMoFV5v+ivVRKpeXGlNZDTC8H1I2sEG/Sqqw?=
 =?us-ascii?Q?ry0QIsNExQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bf9452-0e89-4164-3d5b-08da19846f1b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:23:02.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c56qayiLvKDz5ZLKWSGnSMzUOO1yVSHtYxGIGbrcdNvN0swmBixZk4KEYEPjWura
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3262
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 05, 2022 at 03:35:59PM +0100, Robin Murphy wrote:
> Rather than hard-coding pci_bus_type, pass the PF device through to
> usnic_uiom_alloc_pd() and retrieve its bus there. This prepares for
> iommu_domain_alloc() changing to take a device rather than a bus_type.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 3 +--
>  drivers/infiniband/hw/usnic/usnic_uiom.c     | 5 ++---
>  drivers/infiniband/hw/usnic/usnic_uiom.h     | 2 +-
>  3 files changed, 4 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
