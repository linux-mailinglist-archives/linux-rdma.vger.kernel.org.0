Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA939EA58
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 01:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhFGXsS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 19:48:18 -0400
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com ([40.107.243.54]:61888
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230462AbhFGXsO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 19:48:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDDic+atE2BIsmKt0UIxWY+TZSD0689Gsv5OOvXji12EaLK8wpfZsxMZNHt2tFqxTLVLOF8oNyxhyes172On4Y3o+n0RT/S7Rbkr/VM24/zx6jAIk9L6TEL9SkLATy9ljvepjZxNhAFi31j9wwDcC0vTXDq//W0gcZ8bfYPlWjaaIKbfKtsukfB7554aNrGLqVweJjBBDEm1CgOTc2+ed6hZ0mCEGv5HkkOo5Jigu+Qs9HQB8RyMohWEeKUbOSN4OtYPYpU9xm7quO+PR8J1HnqpzEuoE0GgsN2vMAB2wbFCxgo9eP4L0T8s/ZERxKax/ONxOgJ0/bw9wp6WOLRHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4kI2LghPmCF4umH1AqQXZFhdP5u4gyXmlU2+n7He3M=;
 b=AjTCFFR16Pwz8P1WAF5q6PVPQoh69dSME3aWjhb50l8pwhv5I+Vre0i00JItrbno+VtiMGnTKyc6tMkd21vArhPnG/CV2HwtrCVQ5g+VbBMr3x8vwaF0cwtSxgw36CdOqmZURq9qUlv3iCCA5m862LvDb3IdYVLvflX9Q9imsEiWdl72OPRTs1z49/tfIu6EV93/1+Pu3Hn8jOHXOVXBFKeC9vyHCDfZ5gpxAtKBWkTwEaxLm12NGsKT1rWgFqwXgwe9pEnSY+I3GTYiuvh4+T7Ai3vpWLIGbj52NBRcOjt3CX1SGu4/jPatK+ns+GtHTne+UmvJes3608LsEzLQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4kI2LghPmCF4umH1AqQXZFhdP5u4gyXmlU2+n7He3M=;
 b=rF3yruMP17BTnM8GDw8eAAhLpYwLSXo/KSZ+3XzJGgDeEx2ZBTxRcLxRlhyNSCKkK9GFpCPOLvaPATuSg19QHQ/o8c/B53c8l99nMMxv6qR5foW/9fchNZpvQInXRepLSPBAOAz/z7yOQ/9IlDt6gt2C1BjWJ/MeCVLaL6d8/tFW7/7TeJxbyjP7vGHXhuEsFXbYLqcozCNAUFeICfzBqUOevBK003RYDciHerNJfulVijYsyUzPAnwF8rzQ4I7RJDVWNncBeiUV/io/Jx6OLpOLUe482uXx2h2Soi6z8IUd5xFtpxiwfnIQ6TBvg0Lbngtr6o/3s+rJE7AypRGmOQ==
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 23:46:21 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 23:46:21 +0000
Date:   Mon, 7 Jun 2021 20:46:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/irdma: Fix spelling mistake "Allocal" ->
 "Allocate"
Message-ID: <20210607234620.GD840331@nvidia.com>
References: <20210607113345.82206-1-colin.king@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607113345.82206-1-colin.king@canonical.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::37) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR07CA0027.namprd07.prod.outlook.com (2603:10b6:208:1a0::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 23:46:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqOwm-003Wdq-Oj; Mon, 07 Jun 2021 20:46:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87b033a3-058f-444b-ad29-08d92a0e741e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51928104B0DB95A2827E6095C2389@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/OITtGfc8mtlcgi6qE42cUSGV52wAPY9YtplJmKt3ZFMIticPt7nZLfIiRz+uA2OXexks21HP9xFFP/pWITqOwpobib7z6EQddifjiT+TJiss++nYMB5DytMJ4kdvO3pzxLA6owm+/mOebBKRp96sXeI9JtmiOM6DrdaSuYl+G6uqDajknf/85K8wAwL/vx7dNWvIRQc1RpBwczzBt03sJb+aNPflkLAyvUAokLKg5ye8gGGJ+kBTvbWOHHH21orGx5tg1wcaOOjWxI1Vg7nYQEV0KcvWE6e7wEAKqFfTBMrDCO4xtpgQxLH6MVWTH/5l4wJ+8oUo0Pg/sPzB14d6pYImJJL1N10A3bWg6g374lgZvHT8OE+L8tqEidl5fUXb/mGgsXaF8nkybzOD9b8/+ozx8nMvDuZTwfTX5aPImtTAh3AU6jUcLzcOQSHDzVV6LiV3iQOMU1ahxHcB6Y/NIgKu8jdTYGrY3rxnLj3BFM04pog81SvCkBNXch8s+RQngrmWn8wPnTfoxXjgy23+XuRRnYtV7ANXMdEpfiHh5tfJ4jwpVTbQwxr09MMm4j397/6/c552sgUfkIx7Svy0+EWkoCO+bss80i4x378frA3FpawzgwrOm9c5uNHwckGJfyawjZPBqBJl9u8o6x96LVvo+ZjKIogrEFXb3zCmQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(6916009)(8676002)(8936002)(478600001)(66476007)(86362001)(66556008)(2906002)(26005)(9746002)(38100700002)(186003)(9786002)(4326008)(1076003)(316002)(83380400001)(2616005)(36756003)(426003)(33656002)(54906003)(5660300002)(4744005)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eFDfUMEE22YB6ceULT6sDM8Kv7pjeGK3Oe0igUTMURQutF73t+CjJJtBUzKQ?=
 =?us-ascii?Q?PZq4QnaRXk7Z7udT1qGMI7hPnD4OLCOMx4qVXaJ75x/MBdEWoma2TtSAKTIC?=
 =?us-ascii?Q?3A9gg+vXc6daKZdXXLWkNvhX++5eMeUsNcjdZjXWE7Tc5kzYAxh9ni7Nzx5f?=
 =?us-ascii?Q?t6L8SmFe6rjo1SakLfBBcRe657wWmvpwKc/BMgT2EysiKXszxYSH37QfVdqd?=
 =?us-ascii?Q?WflnqAOBK3YAfPqBRv7UX5PPGtC/FB94H9TIgTKRtRQbVOcEV4CUlMVaCQB9?=
 =?us-ascii?Q?sOO5Nj0avfBXdA6fyUxn2OytVwMrevs901B4jqi9Yw/dg/f/phm4KoEyCiaY?=
 =?us-ascii?Q?qje75uxDm1v2PRiABk3OWWvoSwZhRifmeIiKm9e1AU+3QXZ3YDsFW+xA2Mix?=
 =?us-ascii?Q?DiDQRBjF9glcN0OGkERFGdtYTqasb/4MCzbTass5pkL8g7bmNp9+6X4TjCMu?=
 =?us-ascii?Q?hYD7x7XpT16A0++mgk5yX53C+LIlHZQ8gVTt4MAInvx5PgJng714yR+chytV?=
 =?us-ascii?Q?EFIWC8DaTanNlGVSW+hMf889Epek4gFkPcLBNFJN7zKDRva7aGibcvVqPxgW?=
 =?us-ascii?Q?Fo1gHBCGl8Ad+XwTgjkhwf6wIEhjbhImImdSL72JxmOmqVte2pP+3fyIdkPO?=
 =?us-ascii?Q?+q3UBWcFHS3ccBuRqdV9ldy3ZQCVMgaE9XDBJJm49ohrlbqMQhDm2nIoYP9r?=
 =?us-ascii?Q?ydei/PTeIBFvNve5BELkArGeYEjnp01Hy9ifSfFUyLbyppC3smIy1i3L4Ge5?=
 =?us-ascii?Q?H8ZSxsajCLszhrDadeuHKSflsMPZA9t3j42KU4y0FjAj3u5nSul0jvHgEGKj?=
 =?us-ascii?Q?f4moFA6R4PpTigYOOztj6/iVdu1wPt/LiQQZyj1MHONJOhME/CyAS3IxD/lE?=
 =?us-ascii?Q?o+DOU0ZJeFsR7G2YTvmRk9R7EGI+QWvfulkZIvfN1jLOLcLobwRXZVlzY2v8?=
 =?us-ascii?Q?tg9ShBLTONt9wp94ESz72oAPcvMzHNzbZDlDWSFQPyigQkUzFVDQnQqbUXiK?=
 =?us-ascii?Q?xTVEPIx8sF3pGWbiUNTrkIH0RIL+BRirGcCncJrR0L3Ul4Ra82/PLQ/W6ZHj?=
 =?us-ascii?Q?qX/EGwvZxl0H2PG22WuKxgrVporL4xSIwtqni2sEN0VKCx5Jice8tVEWBGbJ?=
 =?us-ascii?Q?9LuuxIq6+s2G/etjr3WrycN1AnH4vzHU1EPdc5/Eg+P/27TpNsJ69w1wWUO7?=
 =?us-ascii?Q?UVQaq7vVr1WUxpqtjh/2BbUSHKIm5uVfzGKnmVrILx2vruz+6YhV0XtB9JuB?=
 =?us-ascii?Q?R9dMbboXvxJFPs5CEjrZVgXFxxRDbsfZmu9n8ekh9uZNST+mas69fV/lf70X?=
 =?us-ascii?Q?I/fRvDMoTqcZFBG1RY2zgQ1O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b033a3-058f-444b-ad29-08d92a0e741e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 23:46:21.7125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPhSJjE5xC1OLx4EMUpjTdPRz5hBFPhoTECnh1yB5NM0KKsef7USc20o6YK6Y1OX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 07, 2021 at 12:33:45PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a literal string. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/irdma/utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
