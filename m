Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255F934F4AA
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 00:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhC3W4N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 18:56:13 -0400
Received: from mail-bn7nam10on2043.outbound.protection.outlook.com ([40.107.92.43]:56192
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233152AbhC3Wz7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Mar 2021 18:55:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yknd9+zrzdky+Rb4G42EEZkv72RfJ1Ty0Cozt26DD/uDCOykivUhEE2zi/6ppZYu84SfsjrsLT57H0k5uxIFMhiQ/JGoK3sYscJneHTHSbPoT5wluulfRlhXkNK7J42d63LSmOQ0bCbiMSWOG4/DF7xJx1j6PV3WGCx+Efja2cE9bn2kAq5bI8WY9cp7TTMliJBpb22k5YPnMOOGXJ+GoiuILWr1KysfG7LaKPws/+XJmlWg3PZdIvIezbsMBhLmDJ1gkm3HaNqJntzJvjgTOG2pbnj2/wVQV1zvJyEkkWTBERvbrrhvwieLCUWuJA7MbLDH8fTh448VUE41c0jasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywm7R9CtZ2qgAtc/bgtwle0AZqprb67c72AGBJeIigw=;
 b=EKpnyH9rylM/+LlpxlbSg4jN36PAyCDJ/fPlIzxUncAmF3DlULfRNhbIoBDMaJwumQPI14/IZFaiXSM60s7+XqDeZ2R/rJM9wUvHZDIAQW0Uby/7e9q9kbRGGTJ3TC9F7izrbpL8knkYP2hI/xbBM5cVwax72dEn1jTh8FOjuyVP0iLxqBKROZzGJa5idjZrhREFHO1OWd5RVQ0gyX54Y4k1Zb7ZajcJucF4Z6dsjNje7wN/V0xMrXQHdNDDdW7KMViZJXpcHu2WhnonqaOZFY+1TmY5ujuLqxZk4vgwwwF6msXW+90GGwSPJ/ZbYRqBWf14qdChTnkAeqs2paElDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywm7R9CtZ2qgAtc/bgtwle0AZqprb67c72AGBJeIigw=;
 b=SV731gLZJCKXnYeEkhV8+UTN6lY2bDuzJg/FYV4ZzPN6pAlb9dYjZ1qtvDy4jjnwb2uyz3WW8/jp+df6Fu5ao9FjqHk5WrnhX093HmYk3MIXZqJvBWxF2P101viS12zrpKVwwMlq9gjqdiiy74mMBQoRJK96uOBlK/hDBX7Eb19OgQ/jv4Qub69hqNNV08KfPLr/e5lNc3ubH57c2WDyJh6n6dEDWZ6hL878N4M5gh1kv5PkR0dfNM/zvZpTi1ho5Pr4LoayzIeW49GcIrpwAe3F7fZ72YJPn+mQUgnBhxlg36EJwDGvlieRuJG4LZpc+HPGd4CKcYGjypCXnWMoTg==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4620.namprd12.prod.outlook.com (2603:10b6:5:76::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 22:55:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 22:55:57 +0000
Date:   Tue, 30 Mar 2021 19:55:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Ruiqi Gong <gongruiqi1@huawei.com>
Cc:     Lijun Ou <oulijun@huawei.com>, Wei Hu <huwei87@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>
Subject: Re: [PATCH -next] RDMA/hns: Fix a spelling mistake in
 hns_roce_hw_v1.c
Message-ID: <20210330225555.GB1463613@nvidia.com>
References: <20210330122912.19989-1-gongruiqi1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330122912.19989-1-gongruiqi1@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR15CA0004.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR15CA0004.namprd15.prod.outlook.com (2603:10b6:208:1b4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Tue, 30 Mar 2021 22:55:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRNH9-0068le-8S; Tue, 30 Mar 2021 19:55:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68e638e0-afb6-4874-c806-08d8f3cefadb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4620:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4620A7494F29FAADB309189DC27D9@DM6PR12MB4620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5p1Ov4MR0hzbEtVbvNZMFCaHD0qWf874dGJ4t18gl/z2/9fXq/5Ej0oXjWtX4O76IuMcDHKKHsVRPcOXlRP8uP98eR4lu1ZiLaXt31O6vxuyzc9+cqw0hGZfJlpyFPpTXRl/Kw5Sf1GiH6689SPa7OT73hWnsYsUSb3w1oIhv94/PIGytecE20gO0UIFwAlPGhuEKcVBVyb8tdJrhxNVEHoXV9+hylpoW8CT7202PN878I9tZv7B5fee4e8/eHPlb9A8ePTLjfWuwSapJgSaXfwZV0FUXeflHeGWhy7JGkvu6+MV8JBmxHjZXb6zlgBjTW4PtTunrgE7nIab2pGccH7mHIeCHQPw+zchzaopSwDHM2UyBqpYvXk5ci2q1mPMavK2jHU4nnQ41zJ5na6y2AXWLUvTYGD/pZy1y5dEJYlEdHz0buWAoVRA11Jyh80vFutxLNUHs2ISu9wIFP1sZ+BybyA02MKcrtJ7gdkQvKCMyH9nQGQc3XR4NnwS9OBHmRm/Nd8QHNEZLCdnAx1+qgs5wZLcmfQQ1j9uB+9kPL1LHP8e4VynofILiUBsVzLfKG4fIpNbonme3yvLM770aq+epByabC2jRvuphcerU8WoL6pi0t4DGKX+bQcTgTu50LcsnI1v85RrQABRtSaTiG/p8gCMyAdN1x4YzjsfGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(4744005)(5660300002)(66556008)(66476007)(2616005)(2906002)(1076003)(66946007)(186003)(33656002)(54906003)(8676002)(86362001)(6916009)(8936002)(9786002)(9746002)(38100700001)(26005)(4326008)(83380400001)(478600001)(426003)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6soDlV+aZH6NOB4Nr+UhdRgNRn2dTjg4TP6CZ8Nc1JUm2oVqXWwCYIUjJNWJ?=
 =?us-ascii?Q?054DAWrzt79G00PrVD6MutkGDQT1bIBQ+1ncK9pu+LoY1vJf88PG7wc1kxCg?=
 =?us-ascii?Q?jX/MBE3SS8p00kjEGv3OMaYSI1CcfwGMQpgpPjsp+9R3wo6jtch49RrJojrk?=
 =?us-ascii?Q?56Te9fWtKaZ9IGNCQgYutaUBkKqs8MRy3dvqlogkMObFPIEwzKDvSDHMIDNV?=
 =?us-ascii?Q?kt4BF7MSsu33tl/gSjNI9/i96DlHzTWCPoLYv18aZnnKvaJnhecXTu/q+EhL?=
 =?us-ascii?Q?/btduBuQS/eFW3yVuBDdIQWuuKssHZj9XXETIc3i6W1oVgos0smeXs3GSy2v?=
 =?us-ascii?Q?O+nSh+sStooqzaUFVEAAo3+6Rt65l7N+W5/sdXdR6Hpx0m9hsxm62FGAU/VZ?=
 =?us-ascii?Q?ikqQ6rSqGzI91NNd/OkNOh7KeGb7gZLL85i8/kWaRZyKWdTAP442FDgAS8It?=
 =?us-ascii?Q?CsrMaInn16eMAAc7s8prO+b4/DhVmuI4C7WJ7m4NiQSmdV5epPeIOBbGOrkV?=
 =?us-ascii?Q?iIvRrijklPeNtKazPvsm+KDbR5Rgyi0Z4O3lhQSSTJWvLVujkr6m7WlC0dKL?=
 =?us-ascii?Q?NtFHgiuIRdOFgU86TVxO6drIvABPyUoIg2OFPnjXbobHMVAeu1IGjSWWjNCx?=
 =?us-ascii?Q?/6Am8Q3F1XR0NPYLk73xQ6VPghwPW0pQsWvp5cntHoJvti/FFgJcKh++B/Yb?=
 =?us-ascii?Q?cKreLhCoPEmjkQZ83IV+Vttvkd8Fe+akOUcRIvmqyHIX9wJZiisqA4jdYhJo?=
 =?us-ascii?Q?PaJ3G03v2cSRcMvv3jmcn2bgkhhx5eZuYSwFOnIM77WUhUx2RFi1ALfyelfH?=
 =?us-ascii?Q?xgGbSPUDHK8gCzBQ/fp1ZREDRloJDXYGluJedikJMkNldWZJ3EhTQXxphYcT?=
 =?us-ascii?Q?oWf1pZgT3/6IqvHYnemU9V7VhU6b7vjBK9O1KRn2vS7qCBFGEMLmNKk8i6Id?=
 =?us-ascii?Q?WiOzenA9PvZbXe+jfcVGd6WlBDpWDYr3FUPhPhIuYkkJTn95TDbx8DryyeO8?=
 =?us-ascii?Q?X96/xtsC0+8jD8Ag6ZLLLIHX4pQxASg13yTKwrGs8+AmcmpXEdMwpZ5yCBRr?=
 =?us-ascii?Q?NDPWMgyBn15qXNR/2cW4Nn61Gp0teyq12Btw5bGpU57vNLdGfY4jRn/4gZHF?=
 =?us-ascii?Q?DPidBkYeb95tRimmH5uLDpr5MaVXslhgiUYCdgK1eiQj9tGpvZGSvok+4tc0?=
 =?us-ascii?Q?R6jN1omLGQ/VWcd6vB8EeaT6Z76cHohdpvhV3zVho6ghVZM/H11CkObIKitZ?=
 =?us-ascii?Q?KX+IwbFYKfSA3hgFI6n+6dgD0yUK9jnYtmkXPcND+lTwwKhB3jZB9PM6bNEf?=
 =?us-ascii?Q?iE5xc0ydZXZbwTDEos7c2fbUuUlxtPuUDWWh2G7SrCvmyg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e638e0-afb6-4874-c806-08d8f3cefadb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 22:55:57.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhje7fuLDCbX6aZz0/v35lnZiqcmz7xhy75fhiBiKNPl/nzruvk36OkyQb49/dFw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4620
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 30, 2021 at 08:29:12AM -0400, Ruiqi Gong wrote:
> s/caculating/calculating
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
