Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 111669A0DB
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 22:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733250AbfHVUKN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 22 Aug 2019 16:10:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:13134 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733269AbfHVUKN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 16:10:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 13:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; 
   d="scan'208";a="378637720"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga005.fm.intel.com with ESMTP; 22 Aug 2019 13:10:12 -0700
Received: from crsmsx104.amr.corp.intel.com (172.18.63.32) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 13:10:12 -0700
Received: from crsmsx102.amr.corp.intel.com ([169.254.2.72]) by
 CRSMSX104.amr.corp.intel.com ([169.254.6.74]) with mapi id 14.03.0439.000;
 Thu, 22 Aug 2019 14:10:10 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Yuval Shaia <yuval.shaia@oracle.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        "Mark Zhang" <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "Denis Drozdov" <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: RE: [PATCH v1 00/24] Shared PD and MR
Thread-Topic: [PATCH v1 00/24] Shared PD and MR
Thread-Index: AQHVWCvZmDSd66uZEUuzBhvtgWBiJKcGMbcAgAENL4CAABWyAIAAdp+A///NYNA=
Date:   Thu, 22 Aug 2019 20:10:09 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E898ADD18@CRSMSX102.amr.corp.intel.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
 <20190822084102.GA2898@lap1>
 <20190822165841.GA17588@iweiny-DESK2.sc.intel.com>
 <20190822170309.GC8325@mellanox.com>
In-Reply-To: <20190822170309.GC8325@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTZmNmU5YTItYjg1OC00ZGE3LTkwZmEtNzU1NjhiMTFmMDJmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZnJzMVZ4QzlTeEsyeXlFMXY3dW5EK0xYM0wyYURId0hqNWU2YmE4SmhvcWg4Wk9cL2tET2pod2ZcL0Z0QWhxdGtxIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> On Thu, Aug 22, 2019 at 09:58:42AM -0700, Ira Weiny wrote:
> 
> > Add to your list "how does destruction of a MR in 1 process get
> > communicated to the other?"  Does the 2nd process just get failed WR's?
> 
> IHMO a object that has been shared can no longer be asynchronously destroyed.
> That is the whole point. A lkey/rkey # alone is inherently unsafe without also
> holding a refcount on the MR.
> 
> > I have some of the same concerns as Doug WRT memory sharing.  FWIW I'm
> > not sure that what SCM_RIGHTS is doing is safe or correct.
> >
> > For that work I'm really starting to think SCM_RIGHTS transfers should
> > be blocked.
> 
> That isn't possible, SCM_RIGHTS is just some special case, fork(), exec(), etc all
> cause the same situation. Any solution that blocks those is a total non-starter.

Right, except in the case of fork(), exec() all of the file system references which may be pinned also get copied.  With SCM_RIGHTS they may not...  And my concern here is, if I understand this mechanism, it would introduce another avenue where the file pin is shared _without_ the file lease (or with a potentially zombie'ed lease).[1]

[1] https://lkml.org/lkml/2019/8/16/994

> 
> > It just seems wrong that Process B gets references to Process A's
> > mm_struct and holds the memory Process A allocated.
> 
> Except for ODP, a MR doesn't reference the mm_struct. It references the pages.
> It is not unlike a memfd.

I'm thinking of the owner_mm...  It is not like it is holding the entire process address space I know that.  But it is holding onto memory which Process A allocated.

Ira

> 
> Jason
