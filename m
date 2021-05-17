Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF10383A70
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 18:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhEQQty (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 12:49:54 -0400
Received: from mail-mw2nam10on2062.outbound.protection.outlook.com ([40.107.94.62]:7601
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238410AbhEQQte (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 12:49:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4IZ1BBOzenRlr38tf87rN8F0Ir22zJTRi4L6H24EJo7Wrgy8yl1tg35lwo/6X73lrVjwGDjyd78Bc3ERFNmA4TrV0rz6fLI1WwjoM4/+f1p9YRwEKPTxNAnDePNqTTDBemIBR3yS45NFkoJhBNQqsYBxdLuX1YeFuUzlmJfuJbEDxvWvL0c0iBmJB6Rb6dd+lViGRhwarYVnLr54XscX/9O6e6kqRj8tkF46tRg/YvbjfxvotmQ9JOr9HXbnXfSJvXFuD4MzBV/Xea+53S0j0wcEnzqnKqvWqIkvxj3y/nnbzWaqVcNjwm1kz/hi8iL/7TnA6gyF18c+V0ugNiK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsNdzCl5uR7bG0JyBxhIJog1j7n9fZ7nl4A9RO0hZSo=;
 b=OniwonnscAZlQNSmGOwkkY90xSqYFE4onoYJ5eq3EhrtMCI6kL+ue/fjOrc9LK7rlYAvUSUseCbri47Ph6UzDgogrXC4C2pY2RyeyAc/GZ/lxKf5bRNMmbbhiEl5F2RS5dw7N4eB3Hc4ukORjr7HJXZ/LELdDgWhOnSegghQr7zOSHXWuBztdC8Jh+aan3QaTmy6RVCq5JLOWYEwBtmv1wWIf6IO8PwjhGDg6EmTasum07UhxW/V9o/M5Ry9yEWZ+ueQpMsFijB6y6ARF5bevXgrMGrTCIV/JcyQIj8yjOShGjKKRPDyEAbP3lPF8EV1ZWUeKks2NIvxPWZqr6oCSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsNdzCl5uR7bG0JyBxhIJog1j7n9fZ7nl4A9RO0hZSo=;
 b=eO+PY4PHoCh7r2O1VNn0lTWv64ZUdkaRYocvjbOVB0gnbdbrmT93Uv2+sodgXlRFKmVt36uYee19ShCn2/OyS75Ojjn3KdViuOzlCY3KDAcD/gIMr2s1BwXQWi+ouBPRG5wxWJdR+IB+9aWSuPxO+97bz0UYGVW3HYfGwUFlLuzPsd0/JtY374DtAMn/CmHG9iL0mBPej+TrYA5wPn8XINpINcu+E9eXzFH3BVsaxF1NlmGxaVbfbiJCoSe9Kak0CK4s8lAUcGpkWUFzV9jTy2C0UbTE08aooFJxaSwln66d5UyENHdv7TBu4uq0CXIqj1SzCWUCcQPwFnzk5zpICg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 16:47:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:47:49 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 08/13] RDMA/core: Remove the kobject_uevent() NOP
Date:   Mon, 17 May 2021 13:47:36 -0300
Message-Id: <8-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
In-Reply-To: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:208:2be::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0190.namprd13.prod.outlook.com (2603:10b6:208:2be::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.12 via Frontend Transport; Mon, 17 May 2021 16:47:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ligP8-009LYn-2n; Mon, 17 May 2021 13:47:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3ddcc79-ad9c-4bc3-a8c2-08d91953800d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2858A2349B4E368586FE9BFAC22D9@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6X3t9m22hAD+GaRBBXHRBePsmr972G8WcbzJuWYIT++fI6UbG5KiIWjzA40eRdqnZCdHQAUkMgkOZhQC/IQSJLz33HYlFTE5BjMTjGbqMx/l40uEyt3vjsO82wc/NjVhVhIf7VEUBquHYiuQotXKQXc7F0VkpTxf2e+XdKv1DVV5R1GrUhq2THYT8GJqZ4J9XAmqYWXpQkgDOrBPFFZjRWEfgBpJfrrExD8Gc6Fl/hHK+WvhVeM4Z+lh5UvVqACHOEPwRIsXNcnS+HqEyFT+U4i3XhFX/TCRvbJ5WtmVO431eumczsSRgGoo/T6yHUwoo7HwuajxJ7V24s4Ycra1KKG71DgeJwmZVdWWs7zyicW2O4G0dtNNERkEO1ftdgTPjv8wUv901JnXVPVZjb8xbeV1Znj8qtLjNxr/sWy42594KokLIJPNUVfxwobDIjQGGD/MX/S2xisN/mk4kHriif6hnYRejZO3Q1EiEYqI4j7xcr/bckWwoQX0B7GADYLp9g8oeYWidT4uresZZI9qMIh/OXZsfke0T0TmePVWXyTWRRVMyzzXSVoD+4siYfaNz12SigHde5kdGQFUvKW4hWLsqqgJQxf5anSaXAvlEXNOvqLgcYgguiQW+dItbmw2EeT8aAqvFblgflsUpdZNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(54906003)(6666004)(9746002)(8676002)(66556008)(426003)(83380400001)(36756003)(9786002)(26005)(66946007)(38100700002)(316002)(66476007)(4326008)(478600001)(86362001)(5660300002)(186003)(8936002)(2616005)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jNaDJEidLz20xP6A+5QBD6XiCuBPIRYbuViFYZhk/q9p/BOzXwUYpijXNnko?=
 =?us-ascii?Q?ELXjacnFnFYFG99/4pmnk+a7KiGNuD9EaSZK2+3jYR5Q+FxezGJ/sqNTF+e5?=
 =?us-ascii?Q?Pq8m5svnZg3JqF+QDw01ZIacu+gYVNNRtLZ+2hd3QST8IcDhVSgITn+5D4kI?=
 =?us-ascii?Q?PfQpmrBeDKA+w05auLgeh+Qu3xttCYm4AN0yGrqvYDZ7KpGGqypS+maZKJLg?=
 =?us-ascii?Q?YGioJrsGwmGiNyh/Qq56y5VUGLd9lppn/lNIHF1EhiMoLBwY+V4Oz8BfhiqE?=
 =?us-ascii?Q?ObGNZENgp7Wpe24pFCGxXeLWoxgzzBp8JGcl9/MRA1mb28Sms073AGfLTe4m?=
 =?us-ascii?Q?dE0UQkK7ejXI+/L3RNttpNo0ukkEEvN/6jJ5kLMqOOGNZmgNavKPMaCcl3aA?=
 =?us-ascii?Q?LpiqC810LIr2hGWW5nr4xenC0oSHWqjrfv4/HQl6y0BOuzDVnxirdnH2KJju?=
 =?us-ascii?Q?56FuO43ntjBkrleuSxsbQcnsuPIz/lKm9f20jsqPKKYcuNmXcGs7NHsZIbDw?=
 =?us-ascii?Q?SaGRHrIoU+X+kiLnuojKB/Dzv/+feJBI/0uCypeeh1SW7UHEHVxHZMYozjht?=
 =?us-ascii?Q?EhrCekV+DI1Q3KGWgUNr4JJyQltweAO9ryW3Mvh7SEvIaQYcgw8rXjGLGj+J?=
 =?us-ascii?Q?oKFs6UgAVd05MNH4TZVLj5L45/ZPbAWnNN2WzVde3rW4BjETm0T0sTsQ+qqf?=
 =?us-ascii?Q?3SQxmC72cKHfPZ/NE8MqTHM+QuS/9d6o7b2aNcEGoCUE6q14eoEdhR8Rky1+?=
 =?us-ascii?Q?r/9gWLdD53tOvxphLkT/JxTvDaUfhUNC1bv79Pq18UMova91xHK/BaOelhks?=
 =?us-ascii?Q?CN/vLSgCbj7vYl4mLfK2XA7oQ0YFSTCm2zxyyL2CzjVN/8TYgAosLR+20Cs0?=
 =?us-ascii?Q?usXzt+9oWK+T0wCz9/crX31HTrKZu/uE8uWm7huVLcLrWFxOqyDi716nRuBQ?=
 =?us-ascii?Q?MIdRukmrlpWjDJmmBkjr2kC5iVfR52GARSD8q4DaRdmczNLyvm1i/uGnEOSg?=
 =?us-ascii?Q?AQDY4ezgwdrY6i18vTdCboAQT1nq53EjUa7pqPX28dzRqDqYw0EY2YFseEYF?=
 =?us-ascii?Q?7nN35lml0TKM4XBt0GzPTCdvx/sU4ZmTy7LsxvsV5VKFpOrSqZ7RG5rWqTQg?=
 =?us-ascii?Q?0W26RWAjFm74GySRoSkJqBRZxJU/z2beupzFfJJBsHZwgSPCihmad8iAGdWC?=
 =?us-ascii?Q?WcbChAgcyZXDjnBi5yFMBkM7As3L6HN7Prq6DVrxlSeM44vZMfmcONa/4Tgl?=
 =?us-ascii?Q?GsbKXm25ti9KOuT9uDXudh4V6EAs4Zsm7h8ZqsT4+AHtOn83J3paKPvymHWs?=
 =?us-ascii?Q?bwQKlQA/TfT75vVKnzqSs1jB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ddcc79-ad9c-4bc3-a8c2-08d91953800d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 16:47:47.2273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2N6TT3j2YvpJcjEyjX4QBAhzsFA9cQ3bgmkcuDrs5WV4lZLch8Pkbc6qtvsZskA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This call does nothing because the ib_port kobj is nested under a struct
device kobject and the dev_uevent_filter() function of the struct device
blocks uevents for any children kobj's that are not also struct devices.

A uevent for the struct device will be triggered after
ib_setup_port_attrs() returns which causes udev to pick up all the deep
"attributes" which are implemented as kobjects nested under a struct
device and assign them to the udev object for the struct device:

 $ udevadm info -a /sys/class/infiniband/ibp0s9
     ATTR{ports/1/counters/excessive_buffer_overrun_errors}=="0"

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 168c43a644d76c..ce6aecbb5a7616 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1423,8 +1423,6 @@ int ib_setup_port_attrs(struct ib_core_device *coredev)
 			if (ret)
 				goto err_put;
 		}
-
-		kobject_uevent(&port->kobj, KOBJ_ADD);
 	}
 	return 0;
 
-- 
2.31.1

