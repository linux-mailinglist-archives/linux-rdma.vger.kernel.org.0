Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45CD35E945
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 00:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347622AbhDMWwp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 18:52:45 -0400
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com ([40.107.94.86]:49408
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347621AbhDMWwo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 18:52:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+UfSxXEi9DWN1fWwjJ8DcdcIwUtur+mydjbjuD0FgpngozLPdxxYYQPOE5IWj9o1B6qWxynUzQMWE+wCAE9o53bAEzPobWBUCvypH+HCs/TUbpoMi+mWOcl/EYlr6yS5B73nq9XeGRKZfSVHWWlTQol5MD/17D1kjPGULzwVvpQcQbQaADJwCl0HhA17wZ0lB8O//vIk0iEq/BvK9EUTWutq4Mod+GzMJESJ98RmMzmo+B2uUSZRD89wdY9wHwZ+iacFTRgoupVQst+tS1Z3rgYpDuXOLyrIr2vxs6xgYknSPrFXTz5gi9mj0fVeFGyybsQtUndeUZMwxDb097+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fnu10ye2faX4pTBIgqZ75bzQhqNcQGO+tj65IR0Tb3w=;
 b=S21WUPjHu6sFmA/k6UlBF9/bsVw8VqBfbI51upP3qPIxgA+JOXSu+Yw0CRGGeBFt/oxQSBDpI7VVtCkFz1hPhLNS9MpllyMTvUoV5qP39aY3obhwR84q6fDFidXrt1h49xFWTKJFi/5Y7jrcDIxGKqVSRTmi4Z61yI36PN1eFbtmSh0Xy9WDddOI4fl2h9ffXU4POKa6ljga3uxKc81o8teq6LRrxWNCW7T8JQWR5+XZ60dJ+zenbmmmiqqDylJ2HK45fbzaCjf31PwjWE16ZLo+M1iv+2wRnmaR86YQRjbPqKyHF3D3Ls6HGNRRD4fAjGqaFtS59+toM+zphreeMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fnu10ye2faX4pTBIgqZ75bzQhqNcQGO+tj65IR0Tb3w=;
 b=Ggm2nzwS7Xb4/aWw60kPocqhGKovpXV5BqcgKbMc2HjxDipasqKPVRV8sFqFrMOyNgI1Pxlboy9Jn/3FAWd4Nc0FvLWcKJfxCqOO8hWiUg0XxknZYuSAmHwDY1t6geNiPeDdBXepAZkUEOhudOPJYM/Cqwm46oTwJAwwWCLccgWLJJ+2JDo6po9YTTbi23/t8uxB/fts0djS+dVAQ5jHI2iBkyvq39EEnQmobjSBlEQhhzEqR4eNvJd6sti4nXeGbv/vWegupQd2zuajHYts1PI3F5aB6/5KemL48oA1K2C9Mxbq9AfmA4ydIUTafuMHP1dlYRlq5AUWodWaUrDyvQ==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 22:52:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 22:52:23 +0000
Date:   Tue, 13 Apr 2021 19:52:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: Re: [PATCHv2 for-next 0/3] Improve debugging messages
Message-ID: <20210413225221.GB1376164@nvidia.com>
References: <20210406123639.202899-1-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406123639.202899-1-gi-oh.kim@ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0104.namprd02.prod.outlook.com
 (2603:10b6:208:51::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0104.namprd02.prod.outlook.com (2603:10b6:208:51::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 22:52:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lWRtN-005m1d-Vz; Tue, 13 Apr 2021 19:52:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 162fcb1f-d38e-443a-e0d8-08d8fececd29
X-MS-TrafficTypeDiagnostic: DM6PR12MB2859:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28590338AF4121FE830E0E2CC24F9@DM6PR12MB2859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3YjjRrepFaL933uksNIOUsUqfCiMEtgnTn82Fp9hkqpK2c2v3Zm7Ay/zxyg68+rkdEg6xUw5cggOlYv6qq2pDTtu0BSuJupb29HGpK27VWsgOO+au4eCexHh+6Kbo/RriB0xWU9pggnIeWbuRl5dtQM+I7RvdxkQb1dUdd9/CvP0yJDLeS3olGiChyRGby+5Rfwmy8Pn2r2PPSixJgS35Zu5hGnnrX9GnUIZRH09x3dxA9metjk4Cnon44AoyNulebs1xRt7b0NHWm1MYv1D8AHDxOHZu69sYdIJ1GL8JNWsoGjYUAGC7aBQdoCcL1WiTJuy3dBGkotsGWGH8p37rX1i6QigX3a30+m5p0AAFyQ6khHnh9qv9NlX71fL9kFuyLLji/xLCyBTs1xMBrKhacxWbhTbCItP8DOczft0Tlqkf4EZpxkRaFjKcN4SPCyrCUf7dgwtl9XCEX9fjwu/Ga6O+klfWHG1PLsuuPZRX7u8jRqypCI6qmnGAH/0mD8BDVFDoqU8HvY3EmY7qLh9ej9bTT1rszoxjmpH2MvAPNSIiQdaNad1lGZINbHRmNigROHJJ2DZLdRAvbWXaaKJ9ys9JZIYEHRWu1flFhzyvu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(2906002)(1076003)(4326008)(426003)(86362001)(9786002)(26005)(2616005)(15650500001)(9746002)(186003)(8936002)(66476007)(66556008)(66946007)(5660300002)(4744005)(478600001)(6916009)(316002)(36756003)(8676002)(83380400001)(33656002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yi19qPqRj5KyrjnJuR+mRYpySi70q5KhayQSed0uKOmo3GLG5JqFbV1Jx/OV?=
 =?us-ascii?Q?k7McvQxXu7x+pJQVkiWN12tU1gjB5uR1PX45VE2AcXY/1zqV8gq39t7r36Ow?=
 =?us-ascii?Q?k3uNWoP8PfzZbQbi2JE1mLn2djL4NT6luRbjrbeAtsQ/8dd57/y5pfjlE1ua?=
 =?us-ascii?Q?4/ZCWXxhsF4eqdDkAtNB15NQdS11SVm2+BrK1yHDaXhadvuGBSeHVnh09QR+?=
 =?us-ascii?Q?IQn1AqYyhJBy8A1hY8EF9FedZS3MJ5Ax4qHyRfCXzvQe6p+8ILi9TGBbydp2?=
 =?us-ascii?Q?Cm+AwX8u9LHJXWgflKXm58r9NoFFUIfQvv5sWH0AXN5ZyHrjiY51l121nAyw?=
 =?us-ascii?Q?9jCNsG4mHzyePfV+AsO7meQ+k6+2IUrmmMm2LuOF0nlRHcSnCElZq37ydmyZ?=
 =?us-ascii?Q?lpYxBKArjmok6oV/aJDSUy5P3h3k+0Hb6nOn908HgEgkzE6UGNiOF6uAMlUd?=
 =?us-ascii?Q?Xqzj3mKKZOaElxeEkjLYsezzW4xh8wcs8WKqBZhBkfERuv8dJ1/hsvsFIrhh?=
 =?us-ascii?Q?feTsO7+4o87IE3lGYrgZeMQNnJxOD05xq9q16DFKGXlCAOmQBAC25oOp6RSk?=
 =?us-ascii?Q?+MWRvB+yPyqMTJ7wHAN0HPUU9dSM+u5GfSzG2xwf9RLQaCALjAzJ/ZBnDeY/?=
 =?us-ascii?Q?CJuPCmjQAhIdhJGOBKD2Ct+7Qn9tIY/MHfobSWE4s3i2OyJ5OGobqF+Ac5mK?=
 =?us-ascii?Q?uVzprF/MI063PRieyoFhvARtVw5coq21frACN8TzVcxXuOShfAerVxI3cKyJ?=
 =?us-ascii?Q?l3RSiVcdYncWycYL8SALMm+mWzPohbIj+9jlalvDDH+f/+04x15GFZE1aT10?=
 =?us-ascii?Q?l9Ty67oOM12M3y3vBwJQ8Ko5oyRDsuqueQQNSqLC91W22IUCKke/vtKZ84Tv?=
 =?us-ascii?Q?h5wfE2TeaeoO8wZtXGqyO1tV1TOEJeN6ulqL0mgfYphqmRUHn3sJm71Yrkhb?=
 =?us-ascii?Q?c4zbmYHsaPoQZywu114bziMtmzVQQJJRDK3qodPfIHUM2MXoHsT7ig+jXwkM?=
 =?us-ascii?Q?4k8c3MAdqRLw8tDQrhDnAVrWYcBvRPPixlob8VHHOX5TAoi/N4k9URb9Ihsk?=
 =?us-ascii?Q?iSm5HIiWKO3WLRdSEgHU3GK/3HiEwQ7aULF5GTnTQHz89ttkumR3Iovd/8Ed?=
 =?us-ascii?Q?kLrg6/Y5Rhvpx8i0E5EvWOyK6138xPL0NfD+ZACqEggfzLJ1SczuaPf/XheY?=
 =?us-ascii?Q?tgvJL14ZanIUsuWwnwDPZW3ZMQ5zQivgiSzrOLxk+ieyKH/aGYwOgUxgeWc5?=
 =?us-ascii?Q?jkunGHb7vDlvvcHzHTlCTEqXN60Bu7Hy2qtHtMug7jExnnYozTEtl7h0BHgT?=
 =?us-ascii?Q?89RPJBfNUWAasFH3wuafFi6GaxlF4yOQvD1l2P04yKC16g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162fcb1f-d38e-443a-e0d8-08d8fececd29
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 22:52:23.6064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7cD91jwjtpIU0etOJYDy11vzK1Tm+DlOZ24PwCUQg6sXlBuT/nh8C46czuF0OEw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2859
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 02:36:36PM +0200, Gioh Kim wrote:
> Add more information into the error message for better debugging.
> The old messages was just like "Error happend" without detail
> information. This patch adds more information which session,
> port, HCA name and etc.
> 
> V2->V1: add new line after variable block as requested by Jason
> 
> Gioh Kim (3):
>   RDMA/rtrs-clt: Print more info when an error happens
>   RDMA/rtrs-srv: More debugging info when fail to send reply
>   RDMA/rtrs-clt: Simplify error message

Applied to for-next, thanks

Jason
