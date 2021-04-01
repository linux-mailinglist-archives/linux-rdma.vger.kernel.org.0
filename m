Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E655351858
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 19:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhDARpo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 13:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhDARj3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Apr 2021 13:39:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2705FC05BD2E
        for <linux-rdma@vger.kernel.org>; Thu,  1 Apr 2021 06:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFyJuvXd9YCJDktJaXE1h+kdcpTAeTY3m5belipPuFiNk4XM8nL941RUOXkBQSPzgwD8m1JX7BEqhHZeLK1smKXdxe2ByS4uVWMD25vDGkt2oxnwkVnpXTxfTVYFn10689VuAfceVkds6P1tSIz5+L6T5q/x6/jbpzkCSMroj2p/2fVdracRcTup1TySndBrzSxGBjQI2U3O0uZOEoKMYJZQUz7xlhmBfMqYoOf73DvthRMA92fDiVHodD5iSPbhX19hPZbQkqveYghsblnIc0e/Xju2uT3E07e+XgQA/5vm7zYPEgwdnHzECC4ovDBlk0o9vtXE737nVIRn6/T3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxBWXaSE+NtKqvTRZ8Mqs04iVQ1RinIvW3t4cq7vh30=;
 b=YUgp4mZ7s97LTpWrx5JAqt0Qf99KRxIsl5jNSDt7gYa+UBV9WJFW9YfVNjpq//d0f1SqspOkzoxPOq4XRlqaDePBLlsloA1XnzOGDPT6niFQ4Vik4CgIrH9DYcFjvYMauLqaiFgUNcYIOVxHXU58JJ3RlCaNfizlAzRr0wEZK9srWO/5ypHUGZKX+smNdQhisczSy6Yu8scemzl7WaPpiRaBp4PPIjDI/jDNPHqGV8F5BYvV0BSIwcNuv/adrimm2jyHZ4Gtt/+VfIdUbcUA9Iw+8PBsoT5Ex4hOVbeqAD0H3rMAmlyGyL4H/tEpuSIm17GpRl4K2SnD1rnVGZUR2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxBWXaSE+NtKqvTRZ8Mqs04iVQ1RinIvW3t4cq7vh30=;
 b=Xnp90Zhg35pPRRL8b0D05KHb/R8nZNG5z0o1y1fuvgmrXdXViB6LoEiHaabspxZy5truqAAQ8K4jHCV5oqRo0If27QTf7K0caxaP/z49qhROD8ZqXfFQK8eDXXhQ5Y4Gt7iC7XgvumPG/w9gUEPuflWwNVNWQLMxL3HC9hewMIbkDV4XWypLpl0VCy2fygUhURnnxnTZVYJn5V5h0RQRjyMYgBkPPfLIW0djpONV9pd3IUUuEWkT9EFMvUXUBoLXTeGZxHGiHePCeObYgEHjiRG2+KwN1GBTmaJvWKpNo18EOfPFs34tJM2SgYKznx9bspqlzMSwgmyETn84Mua/Fw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Thu, 1 Apr
 2021 11:31:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 11:31:00 +0000
Date:   Thu, 1 Apr 2021 08:30:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: Split MEM into MR and MW
Message-ID: <20210401113058.GW1463678@nvidia.com>
References: <20210325212425.2792-1-rpearson@hpe.com>
 <20210330201245.GA1447467@nvidia.com>
 <54ec9b7c-5c43-2c36-ea51-684fd63368f9@gmail.com>
 <20210330225437.GD2356281@nvidia.com>
 <d542977c-54fa-b1e6-8717-616d6c5b5218@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d542977c-54fa-b1e6-8717-616d6c5b5218@gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:23a::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:23a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Thu, 1 Apr 2021 11:30:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRvXO-006iqq-U5; Thu, 01 Apr 2021 08:30:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0260c44c-616a-4770-ea7f-08d8f5019fe0
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0105:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01056FC5F9F4BB7829303220C27B9@DM5PR1201MB0105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6fIQF1TCXvMjDlR/YnXbF4MgBrAillD+C+SH/MGsGKmiTQJe0zHl02m9sTNUXXs587JToIl4oCstHqVn+A87bCtpKKKGkof0FGMoRZlt03UmsgEJFy3QgKTxIW709FoXxa4AZgC10kTm92eLd9sppXv+ZfqAhR6JK9ezAYwu3lqU1FS8ZrOmbwfg2DCHAkZrIj1H6GrK+6SleQuaAxfCUmhK9km6GILFtvzke9ql//hIfeiuzHAyi+xQ2LpEZgCS0Ikt9tyUa2PLVmwBBk0R/2HR6FlT4Kl7wmtOrgyTgBQQDTVlbaCotlcN8l+s5a0KiSd/08/7sz631Vp2EJ56LBZPlsWlf+M7iCQ33MDGRD47z53XEPH3WdhyuI6Foz3o9KjzKjRRxoYU9w4n6q0e6YYXVJReddTpoeZMN1+GZAlB9XFc+UibUQifKUNEZlOmrUvskKSqKDzd+YHv1VWrmLl8OWznwSpkULy8PB4En7JS9CwnuJ/jGjVBNTXFi784/EmBWZ7h72aK3vy4Mz8BqN1eF3BtePn56khmMwZ9sLK5nMBksn1sswCD/BZPGPtm2UWUMnPLWgKV8lWkeSr/oW87DHvBKWbTik7Gq17nok9D1kOsU0Otz9lZfX2nMXEJLSH0M2BYksmFixKca6uWiIb0gK/Tu74ROHAFikbrLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(36756003)(86362001)(186003)(4326008)(26005)(8936002)(5660300002)(66476007)(8676002)(478600001)(6916009)(38100700001)(83380400001)(9746002)(1076003)(9786002)(316002)(2906002)(66556008)(33656002)(66946007)(2616005)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?241S8/bMDiF2qV23yFWjmuII0CqUMp9rFSuPr/ECTjFKhTKJD1ipLsVShLIi?=
 =?us-ascii?Q?Z39+XGK5t/maRxMXGQS25i3St3x4yQyR3pKoBx3hxPIdwmbyU8h7MmBu+y9i?=
 =?us-ascii?Q?NAtRNys9rXIof1rVeeQRqEgCROWznRpOqc6flrLhPTVMUCyI3vgnCui3RA5K?=
 =?us-ascii?Q?2WGOhy3St2or8lrgEXG3srdkcxS4gMCzRooCI7aPP/P1pPY8qrPCVHt5fu9K?=
 =?us-ascii?Q?ZBDpYY/War6Kq1JJB/ZwG/GpzOTFK47LB85HwNIzjiKR0RWONH6OTSO3tFVG?=
 =?us-ascii?Q?QfzyrTQX+xf6pB3pSQsL979+P3gk5CPKhnpvEwso0sdqjauKJgfjhK1vr/oh?=
 =?us-ascii?Q?m0lgUO3exT60HudyRUzSJhqb3tdrZSnkFjrB+s9Q03jfYeu1ykZl0cSidcL0?=
 =?us-ascii?Q?MUOw8hTf0FCs+UWC+qfVmlpt325XxK7ruAwqRxcRW17XKd/0l3qL8naPGM9c?=
 =?us-ascii?Q?RWmqB73TcQ8eH7aGAPLReoDgmOclMnyY5PIQ8L3qqdyZDzJacTqo7tAeZw5/?=
 =?us-ascii?Q?E4VTwmRzDuyNAjJq+I2H/GCLBLQJ86gplnQMFQ+ONZiASAkrt1lfRGLepCWP?=
 =?us-ascii?Q?r11dgz+oJ7gr6K1QmAD4wsLxkCKK+wzVCH2Jf7ZpIvG92TkKn4qlZuVygaF6?=
 =?us-ascii?Q?U6iB6v7CQJaJa8RZOlNUOtUxWKFBLqN012TtsmtkVspI9eUMs1X79GLlP0pq?=
 =?us-ascii?Q?Qd7v4ZItDOUMqKRnKySjs/zFqaY55tu5Ui9nE2TaWRV7ys9IhboPMLPTZwge?=
 =?us-ascii?Q?UTbyPvaj6xr2yxGiqcWVpPV9xQJWYG5eZJGAPe3hfOh4U124ZYsMh+075/q0?=
 =?us-ascii?Q?9bXFQGeoQmT0Hq9tkxs9PhUBfbkbXLkLaNk9X5dtHmZ4XlqzBvHfCPjxqoYo?=
 =?us-ascii?Q?XewCy8SB79hlwEAhjQ0dtI29hn/lXell7brqcO2FzKzrzGn4jHNsKFGsq/jQ?=
 =?us-ascii?Q?Uy7cAauiVWCZ/Tqu87ingZXoPqnf8xwJQR2aFkYgtDbGg1Hb05dSnGjCKt0i?=
 =?us-ascii?Q?YGConnrSc/b0hs2ybt4W5Uer7xSE4IvhOEtCS9dsg6kNZkFrq4L1rUOyBEnK?=
 =?us-ascii?Q?QDxeqlZhlGdIzcSHOMGvufyKHKsHaBjNz+b6Q1smKFXnsfxmLmE2N2Hj5e9l?=
 =?us-ascii?Q?aXI+fKJAUL7q/QrX0tt3dtVG/se/guiSIbsmUfrj01K2KMm7p5K0el9fOgsH?=
 =?us-ascii?Q?dFd/HNmydchxl4X52cixzgD5lPU5jgfMtNU8OGWh0cWfaVpgy8/iDbN70aII?=
 =?us-ascii?Q?PrtGevUclJ16CR04WNxUF9BHFE3VkAtjsfwX33kS9LtVe4dz8BclN1xRwq+7?=
 =?us-ascii?Q?dJpZJS48wUe/fdTtpOw5XMyYTNo95/3ZT42fjmfEvEaUMQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0260c44c-616a-4770-ea7f-08d8f5019fe0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 11:31:00.1233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfPLj+JHA6GGzkINm4yg3kyk3UomcmwDsK9llSlPnVXrJGtK4dwCCbctFVOgUDhU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0105
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 31, 2021 at 02:51:35PM -0500, Bob Pearson wrote:

> Is the long term goal to take clang-format as the default whitespace format?

Sort of. clang-format is quite close to the accepted kernel standard
and makes maintaince alot easier, but gets a bunch of stuff wrong.

> If so should I just reformat all the files in rxe now and get it over with?

We try not to do this, just fix egregious errors when you touch the
code.

There seem to be two camps on this topic:

 - Internal consistency is more important that following the normative
   style. This is the idea that if one file is insane it should stay
   consistently isane. This avoids files looking "hard to read"

 - New code should follow the normative style. Old code should be
   changed when it is touched. Files will become internally inconsistent.
   This avoids everyone doing maintenance work from having to
   understand a million different local style convections

I tend to be in the latter group. 

Especially when it comes to the annoying vertical alignment that is so
common in RDMA.

Jason
