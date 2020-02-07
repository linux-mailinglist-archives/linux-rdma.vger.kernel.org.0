Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A255F155F11
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2020 21:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGUOA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Feb 2020 15:14:00 -0500
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:35917
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727005AbgBGUOA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Feb 2020 15:14:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXvvFOtm19CjMBblWTUjDWN7GJiOBEVapMGfYZ7W6RIXLB0Mh74a2c9eD/QF9NabZX4Z5JZsU+xaPYTfJkiKz9zdAuZ7EGuFNwMfhBjYVI1EeK0Yk6yfiU8v5d6h0zouqV0ZZvoyxYHVsV4+CjBxDXZ1WpoaQoNupPzJ/95upOz1rJVa+cwAnE8GeTXWMH3WXgRgoss8lTE54Y2OxJ5G1WqpO4WSyLz3PkCWRNAESFoJ994oLGXtlLSBnWz7M2XXb/yeB5H8Zwj2xhxt65warbRF+Hf8xNNnLQZfwsFDeKy/QiyjrJ9sJl0c3y3JZ1/X4S/QJaB1xTLO7/vBDG5VVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nVSxILu2NSluh2V2bOpM56jAgefbc1WS80B+w2eVJU=;
 b=Bndh+iEA8D8Fv+hAqI0LbgU+9H+o9D/E3/zGhXbbMu/cCknrCMhfp591FBky8DVfE8nojsPBUDDQOidCzS3cglN1Q6Mc7jdgvgLjI2FFG/DutV6LO0YGGoyKwINk9GAPCciu66wfCGXXyI/biN1N492DZ+Ky+YCryY0XFv0I5W/1o79SkANZPteOx6cbucp1byMLHl0hIt4JPdAY2JzvxdxP6m7YfeXrDqfzpCcelmhU7zS1jyDhEfrP5KqXhBZssloRkj60hOW/v2+OrgTy5JljbKAmjPAZpK0zWpDkVfwXTLwAAHr1xkHBhggkbv7HO8/4XDa3ZL6HJZpLa+Wk9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nVSxILu2NSluh2V2bOpM56jAgefbc1WS80B+w2eVJU=;
 b=TZOltWcMX8n5ADZt6wWLz5v678aYyyEXhmaLwMXUU0/QAmk3qgaKp7O1yjjjrzI1NgKVNQiDDGANwgzCJ/k0yhhBLHmVXqG2naEQHCMAtdhG0PsbY1NwI7LAHFzQ0pRiS4RFBBCQSuX5kNR+tZ8aRWFaAlhbZhU0ow6VERv98A0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4749.eurprd05.prod.outlook.com (20.176.8.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Fri, 7 Feb 2020 20:13:56 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 20:13:56 +0000
Date:   Fri, 7 Feb 2020 16:13:51 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Don Dutile <ddutile@redhat.com>,
        Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [LSF/MM TOPIC] get_user_pages() for PCI BAR Memory
Message-ID: <20200207201351.GN23346@mellanox.com>
References: <20200207182457.GM23346@mellanox.com>
 <20200207194620.GG8731@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200207194620.GG8731@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0103.namprd02.prod.outlook.com
 (2603:10b6:208:51::44) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0103.namprd02.prod.outlook.com (2603:10b6:208:51::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Fri, 7 Feb 2020 20:13:55 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j0A0d-0000sW-Vp; Fri, 07 Feb 2020 16:13:51 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b92a5428-b0c1-453d-5d58-08d7ac0a4229
X-MS-TrafficTypeDiagnostic: VI1PR05MB4749:
X-Microsoft-Antispam-PRVS: <VI1PR05MB4749F6CB89714AAFB645CDEFCF1C0@VI1PR05MB4749.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(346002)(136003)(396003)(376002)(366004)(189003)(199004)(66556008)(66476007)(9746002)(9786002)(2906002)(5660300002)(2616005)(54906003)(66946007)(4326008)(1076003)(478600001)(316002)(36756003)(33656002)(52116002)(6916009)(8936002)(86362001)(8676002)(26005)(186003)(81166006)(81156014)(7416002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4749;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCVcdDDXUv6Pdeh4O8KwQO//WabT6Mn7XZi57msj6z1XhvaJ3HJhTQNbEZf+/Ln0doG8+uAoam6b29gG7r/W73Y3WxFxDGgpjGts0Msm5ErCNS89rPBTxFhcfl487EDs8IdvgoEbhryppYLvGKa9eP+fZfGB7Vnbn8c7rGTU6FtMxUZLElVY9hG7vQVC1RVaz6+X/jx8IEjYZQ0/BS/nnsMQACtGRZR4Wd8x/i1/LyKLBCOXIKltbVWijGulO5TSSiHJY8wIPKRgooPtKzoUbEAOKl6CqV1lJIf9lZg3V6haxscioG0J2HzTYuiMzmIC0fLEQcLChxBqrNrHRXzRqx4/McT60C1hOLaLNaVPN9j6NCfaPl5P8KtQeH+WCr2DjyJz2wj8LqvLylzVm6VvYwhwYKf0siVZ40C57VkUlAYoPdbGsREzpWn4QSmDwj+lbtmQ2YC3mNBP1VBCDUJ8fKiogyqVxolX5ZKYzfZ4ABGSshiEXHYdVMtqtaKkY3Xj
X-MS-Exchange-AntiSpam-MessageData: BKG4w4grMJkUyVNeDWSVlLmKzkc5icD1qrr5jHU2FHjUKUSk1+ybgqUbPN3318h94WQ8XQsf4UGXsEyefz9IiI2gtF7cEh6YlgzSTORdnYZC7uXHw3yqrl15zORSGA50mdfgA9/zLVjZ2CsnyiHdeA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92a5428-b0c1-453d-5d58-08d7ac0a4229
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 20:13:56.1578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmaY5ua65wuZQjzAMJy/oz9pfYdB47GoN5F35inFHuB5gFvnbxcRSWqQiSN/10UimE9FNqW3QdAgmsZny+L1Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4749
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 07, 2020 at 11:46:20AM -0800, Matthew Wilcox wrote:
> > 
> >  Christian König <christian.koenig@amd.com>
> >  Daniel Vetter <daniel.vetter@ffwll.ch>
> >  Logan Gunthorpe <logang@deltatee.com>
> >  Stephen Bates <sbates@raithlin.com>
> >  Jérôme Glisse <jglisse@redhat.com>
> >  Ira Weiny <iweiny@intel.com>
> >  Christoph Hellwig <hch@lst.de>
> >  John Hubbard <jhubbard@nvidia.com>
> >  Ralph Campbell <rcampbell@nvidia.com>
> >  Dan Williams <dan.j.williams@intel.com>
> >  Don Dutile <ddutile@redhat.com>
> 
> That's a long list, and you're missing 
> 
> "Thomas Hellström (VMware)" <thomas_os@shipmail.org>
> Joao Martins <joao.m.martins@oracle.com>

Great, thanks, I'm not really aware of what the related work is
though?

> both of whom have been working on related projects (for PFNs without pages).
> Hey, you missed me too!  ;-)

Ah I was not daring to propose a discussion on 'PFNs without pages'
again :)

The early exploratory work here has been creating ZONE_DEVICE pages as
is already done for P2P and now moving to also mmap them to userspace.

Jason
