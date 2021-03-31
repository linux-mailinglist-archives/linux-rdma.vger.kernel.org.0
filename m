Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118F73505D9
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 19:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhCaRx2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 13:53:28 -0400
Received: from mail-mw2nam12on2080.outbound.protection.outlook.com ([40.107.244.80]:61409
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234832AbhCaRxS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Mar 2021 13:53:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMPRZG71oKKXxEOc3FuXAXgHPlYuMsdHMykNZNEd0Y6Pm7R+NIjBJ9l6WW3sM4rVPhwgYhZiKi8PS1cc0iFdeUEfKutamUN14o/296LodRfRYjFVhvHr+ubOoV+d5rxYPK45rJv6b/cUrdJ+Y2YL2fE8i4DoyK+wzxjPgGV1MhrChUQs/sCS+M5eUXNrVi1GgJhfTYMDPq/DoRNNstenGCCvPcdF8HIYr1bSncVTFWGg3Ov76FwpzGJBDcdI/TVKP6YPp2AX6OXY9oa+UJD4rqnE33Vg2l/6KkaeCUGKzqU9TnVSKqlp9xScU1ENUPpdctYiRTJzH66AJy0aRMG5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdIw5Al3nV6kK/gtWoOws2likTa74ylnpt1xWqnzYQA=;
 b=m+VRf4NZu2LeXUgdTRoZxh0dAQJlTXaGo3KxvH9OgFINtEY1h7NTJl2UkBIGHlnRSAd/vOEdWLGlGAmSjUZwFIgzxbhm7mc0jcMucUrCLYgfV9eYKb/acQWPxShYVTULImgW/2cCTqjmLgU+34r7klZ2B7E0B10PNYwT2wC6D5la/j68z1tYXBmMdBmZ7TS/UlTY/P2ksbPYQknI4Q0CA5Hbp5nCff+U2BBN9SMMUjqGYY1jj1+qCZI2HVMLTD4AO40C3ogHhMmUJ4Bm7oHSiYdgww6ME/a/N6IPEOwMCIBemoFgbI568zGQuYDn7uvOT9b1689+iL8DdHIqJZILVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdIw5Al3nV6kK/gtWoOws2likTa74ylnpt1xWqnzYQA=;
 b=MSqZ7rmsQmlB7fzxRxfTBEGGgZ4JIWX/A8GdNXfByo+8doB/JkxAgXNWOthqHjxltfrDD87HrM3gXB68ci8QflvHvxtfWDD68joqlfYKK78H7iDqP1dJPyQQnZJ1luJnIjpsFBLNEs0y7d/xP0qL/ebLzAzdnT//cXy2P0e3k/G4efG2vtzR8u1p2aIZtHOkGHtlihCWUoQ6UTcGYi0RFeHWMD3KdcdHwPHFmYaiSWjIVaQ8U9kQs5C1GkpFEWNdJrAhK1/WxOIaC3QTS+mblZeeCnV6VOqJAdGsfcoul1Y9l5n5Dk0YUxC4hZhBpCFsNjtUoCjexNdWAuOknMbtHg==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2901.namprd12.prod.outlook.com (2603:10b6:a03:138::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Wed, 31 Mar
 2021 17:53:14 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 17:53:14 +0000
Date:   Wed, 31 Mar 2021 14:53:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc:     Praveen Kumar Kannoju <praveen.kannoju@oracle.com>,
        leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajesh Sivaramasubramaniom 
        <rajesh.sivaramasubramaniom@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Jeffery Yoder <jeffery.yoder@oracle.com>
Subject: Re: [PATCH v2] IB/mlx5: Reduce max order of memory allocated for xlt
 update
Message-ID: <20210331175312.GA1531363@nvidia.com>
References: <1615900141-14012-1-git-send-email-praveen.kannoju@oracle.com>
 <20210323160756.GE2710221@ziepe.ca>
 <80966C8E-341B-4F5D-9DCA-C7D82AB084D5@oracle.com>
 <20210323231321.GF2710221@ziepe.ca>
 <0DFF7518-8818-445B-94AC-8EB2096446BE@oracle.com>
 <20210325143928.GM2710221@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325143928.GM2710221@ziepe.ca>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:32b::6) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:32b::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Wed, 31 Mar 2021 17:53:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRf1k-006QOG-26; Wed, 31 Mar 2021 14:53:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca3217f6-a9d4-4001-7a7f-08d8f46ddb37
X-MS-TrafficTypeDiagnostic: BYAPR12MB2901:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2901B877CE5C40FE754B680FC27C9@BYAPR12MB2901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYyjmjWWQoUcBznBXDlO7Xubd2mSanKfhKkR01SDneal9koqbsiq4Bjk2A++8fXc3lBTacXek/JqWFb32ozLRGlY1kNEQxN7z1xJEXgg09gDrk0Ry1Vah+pWU8S4RuBo4YQqUQggOKQ7Z6FV6xBclDTCRz4fXBgL+/GUBg9AcV5qwe4UtJYpKUwL7IJMEp/ezQY4X3jQMgXwBP8g7ImJ5kHD3L9WGVu2LGNydBkYX1KcK5PGCq+G9NWHA3qjxd51Bfjg320aEalLot5l7nFZOzKEKHbSztodd/DoD4JUjbf0hwpXDwGkCz9Q9AROXskHgg+yloaRaN0XG+A12VtxCOi5rmg/E/mnZdmXvFvDyF1OenJdiVhc4iPNJffmmo32hMfa9QTkQWHFzAsx06uH+jKGkwCzjYi/10HO4CMDe53oRqZ2l5vCuUFcqq68lyv3RUyiCYHfG0sn+Hl+/c5EgWCoiJqg+e+OlUhIRnRYC02VWA/ftDjhTIabo7zRw6K+kbtcM1voyWBc0XfiklWLBw3F9OZGcatpop6wqv426w+na/RlYYIMF5kYBXgEwcQ1fT87hPiQdzS/djTZ8hehDW/45mogDD1VVjyZn0H3hUX52X0A0ENcRG+7IjF/ugclSLEomG6uzjQupnAHr5PyBk9Z+IAVv4ifARvZPpJf3e8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(2616005)(1076003)(6916009)(9746002)(9786002)(83380400001)(66556008)(8936002)(186003)(38100700001)(54906003)(4326008)(33656002)(8676002)(5660300002)(478600001)(2906002)(86362001)(36756003)(316002)(66476007)(426003)(66946007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4dNGap3zDWkh4VDEIUbL50tqSRCa9EME9CZCs/tQi8/WaejIS6GKksBHoE6Y?=
 =?us-ascii?Q?XhBBj42dZQbfxFMM6G1/KvLnLYHeL3q2Nyn+hyHNmWfGvzH/cJ0kThyusD7f?=
 =?us-ascii?Q?8haYiN+MxfxvhJIZWpfnCqYXER97wie5L8qC08Erw/JqzP3q54eixC+fIo65?=
 =?us-ascii?Q?rP2sbqVjtR2Sx9S714y3ho5umAQEiiMQqxQ9osjTvPMLM7m+7+IukYXTehBn?=
 =?us-ascii?Q?csSg4TwG2t7SEdrZlTERLNnKYb/qpmrfOwNbLnlcv/zrKGjkjaMaDFwaI67o?=
 =?us-ascii?Q?JnKW4rLkwl5OffGidk2ooWzLkCpe4hm/os92LYiWOji6/YjQHZJED3a6w2kp?=
 =?us-ascii?Q?Dq01PYU8stG2QKPac5JSX+OJo8Y7vjN8OxojgUwbKlRPmbyZtlmKKOOoqXSJ?=
 =?us-ascii?Q?mcQwshezYBXVNz/CpQi3aw5HM9qDOQwUgan3MJxyNU+mYzL+Up6pzmqffrBZ?=
 =?us-ascii?Q?nkD9HXREn5mvBnkx9hMMdAkRNlI2gPhkLV1n7iWr3qgQoYluUtuaCs39xeb7?=
 =?us-ascii?Q?t2PAddVjLn/2pU7xaO4skB3H5lVFRlu0LsTEDxszRwzX2UOR/3s91vfXUFom?=
 =?us-ascii?Q?ADJv4++M0wbuYlJ40wEEvSpphK7yj+QGyYAlJuZS5f4PFR6Cy7x2XfEatWFZ?=
 =?us-ascii?Q?v8NrfgkiJ5w+Er29FnGCiMG8571b0ZKORkGRMFg36yIMSEgbaQtsksMk8CHm?=
 =?us-ascii?Q?QYaH26BAMKMht/RRhYppHjLYE3e/pcOdpgJYEyutFwlve1ngQQTQFbzBP+TG?=
 =?us-ascii?Q?1T6TIgx+K1lBSyxp01tIbT5NNMYDss/aFZnvnsvLoIfK9vWg4wkSAaf79OkX?=
 =?us-ascii?Q?7/AokJYkH8EKwS0GJNiWyyofXiuZ/6pfwBtEKZc/ejHW4mTZMuqgZybvQatm?=
 =?us-ascii?Q?g/HQ1l4r2iKREa+WFVKIZ9EqYr0HHZcW2N2EO/stQgLwOCgLsTM7mdHndUND?=
 =?us-ascii?Q?hYqW8dZJvzht+l1JN5ZvZXruS4xnIFhxx/uIFqbBVQDFuRZz4kxPOTWNCTmM?=
 =?us-ascii?Q?+w/hfLBrdpU53fI3oOJjKvmf5rH8k9haC9tKshdlj+WjzYiRIyo5p9KOTEt6?=
 =?us-ascii?Q?xjxK7N/IDMVx0I0vOq4u+uksKZrKbm2Q+oHXwDkXcI26Y5AY71ZaIDH6WIwz?=
 =?us-ascii?Q?WEiCL4t94BuDQ524ro21eRv0W3+wkuoTKIxgjNCN6N8se1/joQVgRCfdpwOZ?=
 =?us-ascii?Q?Sj7IeAYaxMAd+f0WiTCUZeACXH0rlCmgQ8u/oMPqdPFYw34kLPmKauHztmDv?=
 =?us-ascii?Q?Pkqci5DdR6PD+euRCvUFi8zdZa+jFzIc+cs2YYLpureuwh9DXefz/2QctBuN?=
 =?us-ascii?Q?8QxCq8J0bWRTQ5Ah+AXUtIci9ztGrUFb5xYspAtTOB7L1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3217f6-a9d4-4001-7a7f-08d8f46ddb37
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 17:53:14.8028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUKxJvmmd4iExTiYajhETcq4HupK75itnF2QtTxXzFmBkMrp+NH6OBvefric1jBc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2901
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 11:39:28AM -0300, Jason Gunthorpe wrote:
> On Tue, Mar 23, 2021 at 09:27:38PM -0700, Aruna Ramakrishna wrote:
> 
> > > Do you have benchmarks that show the performance of the high order
> > > pages is not relavent? I'm a bit surprised to hear that
> > > 
> > 
> > I guess my point was more to the effect that an order-8 alloc will
> > fail more often than not, in this flow. For instance, when we were
> > debugging the latency spikes here, this was the typical buddyinfo
> > output on that system:
> > 
> > Node 0, zone      DMA      0      1      1      2      3      0      1      0      1      1      3 
> > Node 0, zone    DMA32      7      7      7      6     10      2      6      7      6      2    306 
> > Node 0, zone   Normal   3390  51354  17574   6556   1586     26      2      1      0      0      0 
> > Node 1, zone   Normal  11519  23315  23306   9738     73      2      0      1      0      0      0 
> > 
> > I think this level of fragmentation is pretty normal on long running
> > systems. Here, in the reg_mr flow, the first try (order-8) alloc
> > will probably fail 9 times out of 10 (esp. after the addition of
> > GFP_NORETRY flag), and then as fallback, the code tries to allocate
> > a lower order, and if that too fails, it allocates a page. I think
> > it makes sense to just avoid trying an order-8 alloc here.
> 
> But a system like this won't get THPs either, so I'm not sure it is
> relevant. The function was designed as it is to consume a "THP" if it
> is available.

So can we do this with just the addition of __GFP_NORETRY ?

Jason
