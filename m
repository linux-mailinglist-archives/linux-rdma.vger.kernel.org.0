Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679B83AF916
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 01:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFUXUz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 19:20:55 -0400
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:45281
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229940AbhFUXUy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 19:20:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LT/+jPdgFjSJhTn4uRNmmI08zZnlx0leYh+3SUmUiVNSMF497lHZKEFOJ48hrNLekuiGF9rlHTmBDFBPJLq3sY/Xk9eVjRM6Gsd1O9Gc5KDES+0urwSVomzy/V7ishhahSK/o74+kMr+HemLT2WA9CkjGqfSePo2fidxubO/g0Tyop1gMZobO/Uf2CB0wsWLamCNHkqBik9fj54i+V9O5MxvineGQYcEwqY+ciJl+mrleG6AucOGEETCjXoh/LnuBbZ9+mc3sZS3Snc++C6qcPDgGrAzZO8xwiXISf/0cEZL3coddrsA8AuobpGw7rkDu2Y144pWLTqP17B3SOG7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzQEsXzmAHXYA5QucndpHPSUMmssd5U473kGRctvTzc=;
 b=I/Z5aDPQp8f3el6MwLcEfLQeoCJyA2OFmSim1+rRK39PqHDlTOXogBB/pP7cEcX1mVdQ20a/GfjNwzKw+2VHlGNZa0O1JsJm/I3dPizPAQFkHbf4a7AoyoroKx3GYXXhR048RLqLBBlQNNVIEK1Dyhp3RG5MYURSf7Ot6/MPhCapRndiJV+RW+iIwBYJF3GZRQj9FZxOMDeJdNPYp5Slv3N84bB/uxjOfSOG8UKLwkuSLyPiUNwK5rptM7Uo/YPwHHutKis+Bzg449Wzxao2xxs90xRjBBVGNbsStSgsQ0iqj1z/vqFeIPSZl0kWyOofOeuUBmofoDdBSw0Rr8YQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzQEsXzmAHXYA5QucndpHPSUMmssd5U473kGRctvTzc=;
 b=N1mMD344/y57xd8R7f64DB2bvP+egT/TUwCAMGgQSJj4uoBF3OzzcLvXb72ne2/S7bMb0JwZisi+pZ9sSMQHyKGluS9CdtVTdvBvfC/nVs9986btX8dxW1V5dnTiEHIql3ZYWPxOWvayP9dsaFK8k+MsXzYRPGJ7KzdzD6ZQjFdvYg1KFxn9qWsIWHHVsKqaLIYvf2yxRvbPeQZL3dssTcFUMMHFAcpGtiOl4hdkXOz92sezgmhNFCiuVrB4DGFMSmF+0t7+rsSDWTZUGBravFDC5bjTOayAtG4mSbz8koXwJwRJ4OkzdCl1BgGHiBe4irWzAnQi0zD50PVxkSj2lA==
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Mon, 21 Jun
 2021 23:18:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 23:18:38 +0000
Date:   Mon, 21 Jun 2021 20:18:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Message-ID: <20210621231837.GT1002214@nvidia.com>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
 <20210621180205.GA2332110@nvidia.com>
 <20210621202033.GB13822@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621202033.GB13822@lst.de>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR0102CA0065.prod.exchangelabs.com
 (2603:10b6:208:25::42) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR0102CA0065.prod.exchangelabs.com (2603:10b6:208:25::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Mon, 21 Jun 2021 23:18:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvTBd-009svn-AJ; Mon, 21 Jun 2021 20:18:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47b56494-eb22-4eb4-12de-08d9350ae678
X-MS-TrafficTypeDiagnostic: BL1PR12MB5380:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53802CC60D5FAF3E613939F9C20A9@BL1PR12MB5380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+B5F/2U0kcOWoTaOApbuAMDi2m+ZkfTuN4XIfO5W8JjmgeHDXDDnf1Htf68YRm79Iq7LMOdT3P5a+Q1PZn+ojtrawBKh3voK1YH8IrKXiyqgnN3bzAlqEjR+7zEhhVxVWjlS6xo3UAATd8yq6Jno9t7LrHGUJRJp0P158wQ5XtKKLMqmVPhn9G7O8hU1hdvNxe++5ZBjyEVCwsLdKdrh5+LpJWMdHPt41xS6t4kIVe5yhVu6sH/mTrr7h+F11Kz7mbeUVeAxVhJr1ec/ihJFcZLOvMYzg8VRUvjg4a09L5wdIkEwwvyiId4c9qQdVx+R1B7Z9yA59R3njL3hSrLeoVzUgbr4btLC9zPKUaYL2kO6JRQpiH4E5ImAa/6ge5rNKcdRUczaWw3NvSEf4OI+hQIPjGXQOsOe2Rxhrzr3qcRBr3rAZL4jZVOQRpDUnLt1TyegA19q+L9wvWWYI8kEABiNWFq8yuBvxQwm8c9e2pnfSwpqiC/1GPw5E4hocYwA1t/cIl3SisDCEzM3PVOo0pXRGlu/ar4r2rKsk1P6P70ccYTqIBD4F3Teon0ps5gXk+88LuggULouJBHKhuQtS5SLcZZPgNsP6yyHR1kvII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(316002)(38100700002)(1076003)(66946007)(2616005)(66556008)(8676002)(54906003)(66476007)(7416002)(107886003)(186003)(8936002)(33656002)(6916009)(4326008)(36756003)(4744005)(426003)(5660300002)(478600001)(26005)(9786002)(9746002)(2906002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LEtzyShVT3kyH5xC9Vwb3QNwzaXa1Ky9mAhMTg7jRiuRLAt1cQ+w0wZnV5kDSu65icqb7WhV/lRsWeUZa37enzFjRm70MmP9lX9V0+0+cy7EW5DnwUvfCCHuY6Ogk2MVHYAo/fWlYrFEP39WPpPaWBJ94YWctHJymdVb979U+KfnNd5ZTLxPozGqVbZOljL+60fYpoUTox+Q2j21JJ33EKypF9vMcPkIYBXca9uSWmu6aNsOd46hSQ6h1Irq6Y9O0b/UJSELvFwZLoAq1VWPog3t0AKJyKnjw0FqZ1FPyI0FZGyg8dk/kmW6so1rb1RFdqKY0U6ZeeZedZ4L37Biy0W55WKI6q1rgqKHwHxd0FVTEXtaZ3rG+Y/Jj9LS/ERiUoxUv5OUldsQNjQZWeOGJ8EwYdjAauSl/sa4nJolMsLq89zaTrSYDDtT2qcRYAF0E1rr02JzDd8i/aUty0UdmIhHbbY7o99R7/Bz+BZvyz+9YKU4InS+ZAMMkLb4GL/DYU9agaOXbgMVK+XzrkYSTBZsc7++C4WnVImeM2yL4K3PuJo98CAp0RUJArOk9dMsoEV1QjeyQt8ch8ojVPWYmXhpTA3i3j468+cm1Wl1AWC/8skPgeDib5ajAJTUIMt4VwK3+axCMeWDxW8Q3dpvUplyBgFJahKgTl4+Fx/JmcZ11xtrdtNYbmf7zDhdBuu3k2fxynKGfplZb5Zlly5A7gbEo75U60t+YCElreFLFXfNGadkz6/BbY7r4PBgU5Xz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b56494-eb22-4eb4-12de-08d9350ae678
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 23:18:38.3514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5822IFEOEDFgALuCxaQzMRWAU49o3uyJ4ZiIS7vgTDC0jrxX3k30kPyNlCI4rGsw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 10:20:33PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 21, 2021 at 03:02:05PM -0300, Jason Gunthorpe wrote:
> > Someone is working on dis-entangling the access flags? It took a long
> > time to sort out that this mess in wr.c actually does have a
> > distinct user/kernel call chain too..
> 
> I'd love to see it done, but I won't find time for it anytime soon.

Heh, me too..

I did actually once try to get a start on doing something to wr.c but
it rapidly started to get into mire..

I thought I recalled Leon saying he or Avihai would work on the ACCESS
thing anyhow?

Thanks,
Jason
