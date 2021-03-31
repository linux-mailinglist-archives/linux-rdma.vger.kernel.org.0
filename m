Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A12350697
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 20:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhCaSn5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 14:43:57 -0400
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:47612
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235071AbhCaSnw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Mar 2021 14:43:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnRuhdFR7f/VpfL/vEA5nXgK+F0FLpDklgVmJ4hmYnjA2m84+brCzQ95ouTH3HGzbofTI8AXivhVc09eLlCQO3djtgGHro8RJyW4yKBvyE/yyjZzyL4OD1CikE3eeXQi72gwXXPHGCad9deF3vVG1iT5MB/VxwYkIwRc+ZXLRQq82l6x6xhb+HlZZABc9BhDVK6W17hvvc+Kw9YvuME2zhU5d7AqLuExf0DhMMLHJJJFl3PdLhKmo9U3tCN5l3vhOri3sGewtj9zx2O1Ra3XgxQ1x4tcpR3zFlSrxV+vapU924OLAImyZHpBi1oeX7I3O4hnnX9Gy4nl9ALuREQJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbSZzQ0lc+mP2W08JwF/QSe3qJGNw613OP0drMGdSPo=;
 b=JsHIkY5+R3zwQeIGAFPBiwXyfCo/9rkwnzKKyeK1Kgl3fLlh5H0zAK3z2Lh0kZPpWepB2Z2Ajb9hnRpB38SYOfomUJvwcQch0RggAaYyyLmJLJLo0bIyG8nJLyRxl1cvHHs/GHFfH9mOya6S36ZllJoF1L5+BoloTV4TYpfLJ85cpqEXRpmZy4WUK9yOJSwgdYVEU4B/IJeapJ7xuUs0OPVoCmJPeJhKY4Kgahxp/nCKa5FWyfE7tn9ZFjA8HZSf8ndxa1ltSSKqv/isM24NL0WgrlisJ/e6ui94b2OTN1x8kf/S9sAg0guQt0U0plokCu//BlwiJZNoprfXFA74Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbSZzQ0lc+mP2W08JwF/QSe3qJGNw613OP0drMGdSPo=;
 b=q3r7fZ3SDlnmrtdKL1Fv/wq6s2d/yVC6Liewx9wTtyAavr8Ps2St0YB8PescG0z8eo5lOAGikNlLe1S0Di+u82ifNrvmRo4GBD2NatKEnhc7QgWcwyN9xgxchkPvKB0gOy3UYwlNphcltaqwFB99oitNsHoMItAII2D/8TY0s8wPaqIAQOVS2K6wQ7fqrD2aIjp12qlrlIU4oLMEYwg7IJtsbDrj0gFD1Czf9JVbqqORagA/bliRj3fgKVD/ednel5ErqyOO+MXobsU6XenLSjnPKyQ2/vClWog9nP1YNQMaAk0rsLkbg2i4sa/4Mmei823Wzb2bZH5PB55XimIRAA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2629.namprd12.prod.outlook.com (2603:10b6:a03:69::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Wed, 31 Mar
 2021 18:43:46 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 18:43:46 +0000
Date:   Wed, 31 Mar 2021 15:43:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tang Yizhou <tangyizhou@huawei.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] RDMA/iw_cxgb4: Use DEFINE_SPINLOCK() for spinlock
Message-ID: <20210331184344.GA1534472@nvidia.com>
References: <20210331020105.4858-1-tangyizhou@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331020105.4858-1-tangyizhou@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:32b::9) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:32b::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29 via Frontend Transport; Wed, 31 Mar 2021 18:43:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRfoe-006RMA-LJ; Wed, 31 Mar 2021 15:43:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f66e272-7d61-4c69-02e7-08d8f474eac7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2629:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2629FB6C2246CD20F25B4BCFC27C9@BYAPR12MB2629.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvkQhFGoeifSVU1fPu8HES9NNLKqyfkicvfFbJxtD1VcRYECuCRfr7HUYlMtc4i3wpqVXkaUTxTklDS1EtH4WpHVxR754w/TbNUmc8Ceku43TKcSUwqaZcfe8hnVHzO3EFMBmfwHdUx3dMibxyLIzMZ3Ec7u8NRqt58r/InNyUXrN4vS0cFuxxc8ECGI9Nd7JkIL/crV2HWteM3NFAGjx6UbfnsVTKrnob8TjIihupSK7tX7YnoV22pU6OjrLfll5Y/JMaAvKB2hiwBMJWgYIeIXlaC0Ipgoa6X/uN/I4YsZWt6ome1pH1/gg+JvJlIDUh8b0qRhRc5B+YnCru1I3m/wXzCm3+8auxj+8rliser5O5wz4TiU6LjM+GSMUDcH2Ft1IxjqH1CJ3cun77fCa6ri2Kteh/tSy2AhZXxAVSSjmBs3bgmjtJTo86mtG4oNUKIIoiOdPDDiF1k7Xe/aUgCYKIgt9xkeMMD4FVcMXgltPZEy3/G9LaiJuHqIWzmos9fQS+FpFx0Ko0YxltFLvAUjxmKq957Uwc4l17aUrS8A0xvSW8ZvyKyVAb6L/OuCjPAXPG/TaFWAWCkIeZo73Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(54906003)(2906002)(83380400001)(26005)(38100700001)(5660300002)(1076003)(478600001)(86362001)(9746002)(9786002)(66946007)(316002)(33656002)(66556008)(4744005)(2616005)(66476007)(36756003)(426003)(8936002)(4326008)(6916009)(186003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hLVao48vAYg2HdHgGhIJqkUJYDNRzARHYjxOWPZxCQijL5f+U0avkmFnLQhV?=
 =?us-ascii?Q?U0HB3+ZAn25p+c0AGx+AANeCrOOyJ56hTrq2oOt+lQPk9oLqBkSNpvi6kINH?=
 =?us-ascii?Q?y0kBLaziGX/QD/puCsjrLI5KOROGcAI7gxU6fUyAlQGUw3Ln+YcPoJ3C/x//?=
 =?us-ascii?Q?IvjwkVpGqp76aeXaRa3ppwAjEy/+0+7CVGjtMLA6dyMFOFpjX8VlKpIdE3Y2?=
 =?us-ascii?Q?+sq2I0Yje011W6o6cA3h8S+EsCqIU0Ha+1OVGhIl/V/rwlehSnwoSfuAtFtC?=
 =?us-ascii?Q?5HHz9GNhoj1qjGFQdZ8p4bwDOCexA+TAV3blJ9r3T/K7yhlw95p9OO7ifqUg?=
 =?us-ascii?Q?H0nEZT32ruY/7vU/dV5lhicSdeIV+afNQco6O0MgdhgDuAnTVBQ7H9T5VUUr?=
 =?us-ascii?Q?Vj3TX7bPdku4Li0sse61xymaNHOe2YTrmZ4Yx361zUMgTSnXYhvrjOlGD/Xs?=
 =?us-ascii?Q?j4OuGqMtrBiQyy/1LA/G6zHJINaCWFLi8DrwzQ0QLBxqj4gdII/J9dNj7+nq?=
 =?us-ascii?Q?zcmEOy5ZcpRu7B8xRwXDZlfPiIPRYLhZUIPWaa3+6xYiBCxej3byZixZvKln?=
 =?us-ascii?Q?mfsUxHivVcBV5gsfsV6AaRcl8+CaOvmiX060l4w7hu7h+/JK71slWk2+L5pE?=
 =?us-ascii?Q?URTb55o6y0/hczFSxZMtkqTUiJamt0eC8KX+q0gLmSlJTouvcsZmZu/XU0Sd?=
 =?us-ascii?Q?fsS+kYCo1GHtV5vjk8WtPjXukClFzwrfzuxwznXl0a2aEg7Up8NXJBjrIWmx?=
 =?us-ascii?Q?5BdJjohidyM+Odajgv5aC8BsJF8YeVp+aVa8INAR2tVNuyyaTr7wr/vIpZBM?=
 =?us-ascii?Q?aaDEITU5GFvfxicjx+58doLHmlPRoU7tZNFfVkpvgLDkOeL7gKvFq2o3whe+?=
 =?us-ascii?Q?eEZYtDPqAu/w7Z5WzhyQLNqay7mMREYzMu2yB2LDmWiWz11JaVsO4KqWs6sG?=
 =?us-ascii?Q?V+0usjvq0I9gVdOQlKO0A4R0udR2uxrOHf8CAMM603brOUbW8JnnELxkJwIv?=
 =?us-ascii?Q?3NAncZq5sppVZHQfrZMCp18jsVUR0u14VYolqDn3Fcb8OQYb76UNkZ/Ryeui?=
 =?us-ascii?Q?4wktCErgz/ecFtXA2V9zMFwYQGF9OIPoOOd9CbxY4JoHSMXlnbKlJYocd7/0?=
 =?us-ascii?Q?kkZvTeZRRR98yRSgXJtys0ZvYaq36/gAZTJ2S9U6zf/0CtHiBGZKRvR3uyWm?=
 =?us-ascii?Q?vKyHTPvNa0klYGhTh0JM/hsym7My6R0hKgFdzPigNKZfVEiNZDoPJtBPgdkx?=
 =?us-ascii?Q?ZQxK951crSsRMNe1RjiykqJwox3FVFCqJHpoUtdsTnYaWVUiToE6frIXjU0z?=
 =?us-ascii?Q?n9mHhY05pipx1196hU8QCaueNLq5G5/9B2sr4D+mBuTmwA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f66e272-7d61-4c69-02e7-08d8f474eac7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 18:43:46.8347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cG5CDdI2AsBth8RihMLFKMe7CpohlD/lUASv9UraRaH9V8S1B2F9PUoU2fOfszFI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2629
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 31, 2021 at 10:01:05AM +0800, Tang Yizhou wrote:
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
