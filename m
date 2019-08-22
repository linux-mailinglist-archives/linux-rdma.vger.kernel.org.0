Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8899D98E05
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 10:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfHVIlq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 04:41:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45936 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfHVIlq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Aug 2019 04:41:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7M8cxOf094160;
        Thu, 22 Aug 2019 08:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=yOQnngcrQBI+G5qgWaIDGqdTs0mg/p+BP5fGCoiltC0=;
 b=WbmoMq6i58ob+JdE8mY0FvhOSWJmd1ZFZwnxsU/gYIcfulsUjdQkK3+2b0ORz431Y6X3
 LuXZoXC7kg86gowZD54aeExB/k14Y/iyTqEesTEgUacQs1Rm9HPkd8AfVRei24O4cZnm
 7tTSzcMSyWtHO1kHAGtCyIqFDfC+QWhKxNQmawrND0fjjZTT5MqtnFtY92KLnyRC3MzQ
 MldMjVEnJXz0WFhrmr1YomtXYoGdg74Kcdr8id6VfuZ4PbadI6XFeRh49ud/2FfkZI8V
 dmmM8k4uuaxPlpsxUsAlwTBIXcQG/hWvr61ErE3sltMz65UcSXmnAxcnphsnh65qmWk6 uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ue90tuyg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 08:41:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7M8cnTE130861;
        Thu, 22 Aug 2019 08:41:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2uh2q5myq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 08:41:18 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7M8fDUZ024092;
        Thu, 22 Aug 2019 08:41:13 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Aug 2019 01:41:12 -0700
Date:   Thu, 22 Aug 2019 11:41:03 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, johannes.berg@intel.com,
        willy@infradead.org, michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, jgg@mellanox.com,
        linux-rdma@vger.kernel.org,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 00/24] Shared PD and MR
Message-ID: <20190822084102.GA2898@lap1>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908220095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908220095
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 04:37:37PM -0700, Ira Weiny wrote:
> On Wed, Aug 21, 2019 at 05:21:01PM +0300, Yuval Shaia wrote:
> > Following patch-set introduce the shared object feature.
> > 
> > A shared object feature allows one process to create HW objects (currently
> > PD and MR) so that a second process can import.

Hi Ira,

> 
> For something this fundamental I think the cover letter should be more
> detailed than this.  Questions I have without digging into the code:
> 
> What is the use case?

I have only one use case but i didn't added it to commit log just not to
limit the usage of this feature but you are right, cover letter is great
for such things, will add it for v2.

Anyway, here is our use case: Consider a case of server with huge amount
of memory and some hundreds or even thousands processes are using it to
serves clients requests. In this case the HCA will have to manage hundreds
or thousands MRs. A better design maybe would be that one process will
create one (or several) MR(s) which will be shared with the other
processes. This will reduce the number of address translation entries and
cache miss dramatically.

> 
> What is the "key" that allows a MR to be shared among 2 processes?  Do you
> introduce some PD identifier?  And then some {PDID, lkey} tuple is used to ID
> the MR?
> 
> I assume you have to share the PD first and then any MR in the shared PD can be
> shared?  If so how does the MR get shared?

Sorry, i'm not following.
I think the term 'share' is somehow mistake, it is actually a process
'imports' objects into it's context. And yes, the workflow is first to
import the PD and then import the MR.

> 
> Again I'm concerned with how this will interact with the RDMA and file system
> interaction we have been trying to fix.

I'm not aware of this file-system thing, can you point me to some
discussion on that so i'll see how this patch-set affect it.

> 
> Why is SCM_RIGHTS on the rdma context FD not sufficient to share the entire
> context, PD, and all MR's?

Well, this SCM_RIGHTS is great, one can share the IB context with another.
But it is not enough, because:
- What API the second process can use to get his hands on one of the PDs or
  MRs from this context?
- What mechanism takes care of the destruction of such objects (SCM_RIGHTS
  takes care for the ref counting of the context but i'm referring to the
  PDs and MRs objects)?

The entire purpose of this patch set is to address these two questions.

Yuval

> 
> Ira
> 
> > 
> > Patch-set is logically splits to 4 parts as the following:
> > - patches 1 to 7 and 18 are preparation steps.
> > - patches 8 to 14 are the implementation of import PD
> > - patches 15 to 17 are the implementation of the verb
> > - patches 19 to 24 are the implementation of import MR
> > 
> > v0 -> v1:
> > 	* Delete the patch "IB/uverbs: ufile must be freed only when not
> > 	  used anymore". The process can die, the ucontext remains until
> > 	  last reference to it is closed.
> > 	* Rebase to latest for-next branch
> > 
> > Shamir Rabinovitch (16):
> >   RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
> >   RDMA/uverbs: Delete the macro uobj_put_obj_read
> >   RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
> >   IB/{core,hw}: ib_pd should not have ib_uobject pointer
> >   IB/core: ib_uobject need HW object reference count
> >   IB/uverbs: Helper function to initialize ufile member of
> >     uverbs_attr_bundle
> >   IB/uverbs: Add context import lock/unlock helper
> >   IB/verbs: Prototype of HW object clone callback
> >   IB/mlx4: Add implementation of clone_pd callback
> >   IB/mlx5: Add implementation of clone_pd callback
> >   RDMA/rxe: Add implementation of clone_pd callback
> >   IB/uverbs: Add clone reference counting to ib_pd
> >   IB/uverbs: Add PD import verb
> >   IB/mlx4: Enable import from FD verb
> >   IB/mlx5: Enable import from FD verb
> >   RDMA/rxe: Enable import from FD verb
> > 
> > Yuval Shaia (8):
> >   IB/core: Install clone ib_pd in device ops
> >   IB/core: ib_mr should not have ib_uobject pointer
> >   IB/core: Install clone ib_mr in device ops
> >   IB/mlx4: Add implementation of clone_pd callback
> >   IB/mlx5: Add implementation of clone_pd callback
> >   RDMA/rxe: Add implementation of clone_pd callback
> >   IB/uverbs: Add clone reference counting to ib_mr
> >   IB/uverbs: Add MR import verb
> > 
> >  drivers/infiniband/core/device.c              |   2 +
> >  drivers/infiniband/core/nldev.c               | 127 ++++-
> >  drivers/infiniband/core/rdma_core.c           |  23 +-
> >  drivers/infiniband/core/uverbs.h              |   2 +
> >  drivers/infiniband/core/uverbs_cmd.c          | 489 +++++++++++++++---
> >  drivers/infiniband/core/uverbs_main.c         |   1 +
> >  drivers/infiniband/core/uverbs_std_types_mr.c |   1 -
> >  drivers/infiniband/core/verbs.c               |   4 -
> >  drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |   1 -
> >  drivers/infiniband/hw/mlx4/main.c             |  18 +-
> >  drivers/infiniband/hw/mlx5/main.c             |  34 +-
> >  drivers/infiniband/hw/mthca/mthca_qp.c        |   3 +-
> >  drivers/infiniband/sw/rxe/rxe_verbs.c         |   5 +
> >  include/rdma/ib_verbs.h                       |  43 +-
> >  include/rdma/uverbs_std_types.h               |  11 +-
> >  include/uapi/rdma/ib_user_verbs.h             |  15 +
> >  include/uapi/rdma/rdma_netlink.h              |   3 +
> >  17 files changed, 669 insertions(+), 113 deletions(-)
> > 
> > -- 
> > 2.20.1
> > 
