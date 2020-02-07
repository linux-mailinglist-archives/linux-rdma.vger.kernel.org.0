Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B607155DE6
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2020 19:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBGSZH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Feb 2020 13:25:07 -0500
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:17126
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726974AbgBGSZH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Feb 2020 13:25:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBIMnmRtfo9dvvPwmDC/L4/RSsl1DqgOZliu2Tvf/b63ATZ7LYpzPfFYi878hJEkm78ewsqpn9sYypUWKG0rgQmW9mHhwb8p1dKl8ukNdqBl7Jo6wqOmEMVnCVtowvgKjw5Jjgw936DURNBS8Xq46vTf1M5BcLY/f0Qws9bhR4OVsAqrdEOWzaN8uWEA++ADvEa6XAIe2ULgNJHUdHybX+iKNUzrhQAyRjAd3IQ16QAWqzSlhbxDU71Ecca6FBaNVi9bHr6u1VZaKbaZEk/AoC6sFEyDsOm3houq2Kulohxrjvc9q1Z+DrvthyXs4Ak+8Ge9n7AoQV+uiT1K0I8GFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXJHiPXntZeGvxypT/6it9obKqo+X9LQvkMZEj/wafg=;
 b=NKA8f2qmLBmWu3vv7Ov7h2z3s7KC3oZWoLOsvfLkrq3Smr5+QYzuQq8ibU2WAI3OiXuP1Xe+uSldYGAiTp6CCx1+V22H1OjEXXFwMhcAojscGSObwXb8T4wgn1xa50kbiQN2xNajm8fc5NDf8n1GvVRl5sRBo06/czUIDOxf9WUvKeJiGQkQxTIwBvdDdMwivZXxR9APl+JE7/pyxs/si8BgrUV/tSe6uh1oQvdXrIzUyc+V6iaWhXhALQNz7b6tsRafVWUPBY7ePzJIeGM3X+NXkuQwWYdKsuF1nYMQSw/U1e5HgQLmcJlGa8jQ/4x8ZQ8kNrR2QRuqmu0wpemPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXJHiPXntZeGvxypT/6it9obKqo+X9LQvkMZEj/wafg=;
 b=sUfMe2GYv/mXqdsDIwQlaGDUv5XcoBBSRnC3jMJzbiJHZEHDIFvZUT64Zx0Iw3Ui/J8EmgRglMMIrucAy+Gtu9LUCAu+eTrhmSu4wwDfx1AodMYWuPzEWwNReXKWfc3zMxzuMey9gfDiD9H+yshTRu7ZKdDsp9b9tqCV7+cf6Lc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5136.eurprd05.prod.outlook.com (20.178.11.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.33; Fri, 7 Feb 2020 18:25:01 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 18:25:01 +0000
Date:   Fri, 7 Feb 2020 14:24:57 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ira Weiny <iweiny@intel.com>, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Don Dutile <ddutile@redhat.com>
Subject: [LSF/MM TOPIC] get_user_pages() for PCI BAR Memory
Message-ID: <20200207182457.GM23346@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR0102CA0030.prod.exchangelabs.com
 (2603:10b6:207:18::43) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR0102CA0030.prod.exchangelabs.com (2603:10b6:207:18::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.24 via Frontend Transport; Fri, 7 Feb 2020 18:25:01 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j08JF-0007rb-Vh; Fri, 07 Feb 2020 14:24:57 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14297010-1081-456e-992f-08d7abfb0b66
X-MS-TrafficTypeDiagnostic: VI1PR05MB5136:
X-Microsoft-Antispam-PRVS: <VI1PR05MB51365235D84D456966371F19CF1C0@VI1PR05MB5136.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(189003)(199004)(52116002)(1076003)(8936002)(8676002)(86362001)(2906002)(81156014)(5660300002)(36756003)(7416002)(81166006)(186003)(4326008)(26005)(2616005)(66556008)(6916009)(66476007)(9746002)(316002)(966005)(33656002)(478600001)(54906003)(9786002)(66946007)(66574012)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5136;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLTkj76RyKDZhRZg2vpc0xKdsQycv2bMGK8nq5Q61ssd/BamsGHkIPFYY0YiShGIYNrWZswpjB0jF3TTtpg6cNpU3EdCM2X+X+RD9criEJqqCEqUSpGYP/fJawvntMu+2Yn607GqOTKfxxsCkFa+zF/bNQvFe04QvzfcK4dVl8flC6535d/TB9qZgY2LibqvrOTlXTk8q0v0I8LxBuPu4GQQ8CTMg9E8LxBiiojc8vaw4vEB1dm4bOjZJYHhIlr3Kf7rZRBvy39Mu1hmLgiegwbdz7KGJYrvpHnXkc09N5zVvNZWUcPvUP5hV/PCpLZoj9wOFWzGfEEOiJ77R0V1scOeSzQv9MHkx2N0yeTfPnvXTNC0uvazKc0E990wRWL2sil5oKsCh/jFqWSjA5t4cAYgNs5XlJJX3K7hOgla4nMsiE9wjNyj98Ux6cOaQdHiVcd2n7Grc7PsnOvwFp6RRI3WgUDV16oYeSe0FZPbvQ4etrtAX3ZEwSe0u3Cle3UfQ9LCq94BeafL3NocYKR/5Q0/FLUDhJaM2fbFID7f1N9T9ztAcIvJaFN+eEKV3V7ujv6jwsVuvPQd3lZ7IM4+OYnLUj/uwY9QtEMGakPtcGARU1wE/oRIqrj46tpOi9ZdSg5oIHaSm6/zpDmwYgI5kg==
X-MS-Exchange-AntiSpam-MessageData: xYXbzTBBgoQT+FmSTxNflbXwLRm+WQ/DC02ouDtJd8DIfzkC3UfJo+cSCGQDjEiX17OwSeoeoSN6zSip6Q/SDX/PJVnsGBu+wizCB+tZhCYoln1a3O908n5OVUptvsoaO98F5QjWT/4UOWCDvgwaOA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14297010-1081-456e-992f-08d7abfb0b66
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 18:25:01.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6lI31VDTP9bargXjmvkiS1mfDQlwG+IAqv9PMS2E+9rzAL/EDo8mqEDOa3aj1hMhYkUVE+Lk+Pz/zjcDLRUPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5136
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Many systems can now support direct DMA between two PCI devices, for
instance between a RDMA NIC and a NVMe CMB, or a RDMA NIC and GPU
graphics memory. In many system architectures this peer-to-peer PCI-E
DMA transfer is critical to achieving performance as there is simply
not enough system memory/PCI-E bandwidth for data traffic to go
through the CPU socket.

For many years various out of tree solutions have existed to serve
this need. Recently some components have been accpeted into mainline,
such as the p2pdma system, which allows co-operating drivers to setup
P2P DMA transfers at the PCI level. This has allowed some kernel P2P
DMA transfers related to NVMe CMB and RDMA to become supported.

A major next step is to enable P2P transfers under userspace
control. This is a very broad topic, but for this session I propose to
focus on initial cases of supporting drivers can setup a P2P transfer
from a PCI BAR page mmap'd to userspace. This is the basic starting
point for future discussions on how to adapt get_user_pages() IO paths
(ie O_DIRECT, net zero copy TX, RDMA, etc) to support PCI BAR memory.

As all current drivers doing DMA from user space must go through
get_user_pages() (or its new sibling hmm_range_fault()), some
extension of the get_user_pages() API is needed to allow drivers
supporting P2P to see the pages.

get_user_pages() will require some 'struct page' and 'struct
vm_area_struct' representation of the BAR memory beyond what today's
io_remap_pfn_range()/etc produces.

This topic has been discussed in small groups in various conferences
over the last year, (plumbers, ALPSS, LSF/MM 2019, etc). Having a
larger group together would be productive, especially as the direction
has a notable impact on the general mm.

For patch sets, we've seen a number of attempts so far, but little has
been merged yet. Common elements of past discussions have been:
 - Building struct page for BAR memory
 - Stuffing BAR memory into scatter/gather lists, bios and skbs
 - DMA mapping BAR memory
 - Referencing BAR memory without a struct page
 - Managing lifetime of BAR memory across multiple drivers

Based on past work, the people in the CC list would be recommended
participants:

 Christian König <christian.koenig@amd.com>
 Daniel Vetter <daniel.vetter@ffwll.ch>
 Logan Gunthorpe <logang@deltatee.com>
 Stephen Bates <sbates@raithlin.com>
 Jérôme Glisse <jglisse@redhat.com>
 Ira Weiny <iweiny@intel.com>
 Christoph Hellwig <hch@lst.de>
 John Hubbard <jhubbard@nvidia.com>
 Ralph Campbell <rcampbell@nvidia.com>
 Dan Williams <dan.j.williams@intel.com>
 Don Dutile <ddutile@redhat.com>

Regards,
Jason

Description of the p2pdma work:
 https://lwn.net/Articles/767281/

Discussion slot at Plumbers:
 https://linuxplumbersconf.org/event/4/contributions/369/

DRM work on DMABUF as a user facing object for P2P:
 https://www.spinics.net/lists/amd-gfx/msg32469.html
