Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B6B9CCA2
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 11:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfHZJgD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 05:36:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55422 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfHZJgC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 05:36:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7Q9TJFp112063;
        Mon, 26 Aug 2019 09:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=3k0Mn1DqqK1XYnA0ErjSwh9Z63QixSOIsiukFyYVe+M=;
 b=ll48b6obFEnBhrABc8dzNAomXqNcfjCxYJKgVQZ9KbCpX4uQ9pFGH8S1MPFSeM0P6DF0
 vEeqYYFoBcob90IB/dEDmys7qSPVtL+IyyWrTddlTMu3VRYSyqKnK69UWGiZmnpjOeSe
 3ZiSx+07h8SIvgYtSzZRTNVVtZZuhrub8+YxpTpIrhapwdSuMits2MjIIh8XTT4HQhLp
 A0X8Dbal+UElev39k5HoHUy2G92IRPuYqGblO/tIA+h1v4sbHpIocHQziZZiZuA0+pnI
 EGxbaejWp31GMkEIF7LrQFSNIHYdrHkoIr4hXRW9jN7cpkYdBJw0J+e9q5/4JPkXw5BX Qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2ujwvq7nf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 09:35:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7Q9X9M6038811;
        Mon, 26 Aug 2019 09:35:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2ujw6un6ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 09:35:21 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7Q9ZDd9031037;
        Mon, 26 Aug 2019 09:35:13 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Aug 2019 02:35:12 -0700
Date:   Mon, 26 Aug 2019 12:35:04 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com, johannes.berg@intel.com,
        willy@infradead.org, michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, jgg@mellanox.com,
        linux-rdma@vger.kernel.org,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 00/24] Shared PD and MR
Message-ID: <20190826093504.GB3698@lap1>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
 <20190822084102.GA2898@lap1>
 <fbc950ac651d49e7f88dc483570b1ea3e56b980f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbc950ac651d49e7f88dc483570b1ea3e56b980f.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908260105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908260105
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 22, 2019 at 10:15:11AM -0400, Doug Ledford wrote:
> On Thu, 2019-08-22 at 11:41 +0300, Yuval Shaia wrote:
> > On Wed, Aug 21, 2019 at 04:37:37PM -0700, Ira Weiny wrote:
> > > On Wed, Aug 21, 2019 at 05:21:01PM +0300, Yuval Shaia wrote:
> > > > Following patch-set introduce the shared object feature.
> > > > 
> > > > A shared object feature allows one process to create HW objects
> > > > (currently
> > > > PD and MR) so that a second process can import.
> > 
> > Hi Ira,
> > 
> > > For something this fundamental I think the cover letter should be
> > > more
> > > detailed than this.  Questions I have without digging into the code:
> > > 
> > > What is the use case?
> > 
> > I have only one use case but i didn't added it to commit log just not
> > to
> > limit the usage of this feature but you are right, cover letter is
> > great
> > for such things, will add it for v2.
> > 
> > Anyway, here is our use case: Consider a case of server with huge
> > amount
> > of memory and some hundreds or even thousands processes are using it
> > to
> > serves clients requests. In this case the HCA will have to manage
> > hundreds
> > or thousands MRs. A better design maybe would be that one process will
> > create one (or several) MR(s) which will be shared with the other
> > processes. This will reduce the number of address translation entries
> > and
> > cache miss dramatically.
> 
> Unless I'm misreading you here, it will be at the expense of pretty much
> all inter-process memory security.  You're talking about one process

Isn't it already there with the use of Linux shared memory?

> creating some large MRs just to cover the overall memory in the machine,
> then sharing that among processes, and all using it to reduce the MR
> workload of the card.  This sounds like going back to the days of MSDos.

Well, too many MRs can lead to serious bottleneck, we are currently dealing
with such issue when many VMs are trying to re-register their MRs at once,
but since it is out of the scope of $subject i will not expand, just
mentioning it because *it is* an issue and educing the number of MRs could
help.

> It also sounds like a programming error in one process could expose
> potentially all processes data buffers across all processes sharing this
> PD and MR.

Again, this is already possible with shared memory and some designs trusts
on that.

> 
> I get the idea, and the problem you are trying to solve, but I'm not
> sure that going down this path is wise.
> 
> Maybe....maybe if you limit a queue pair to send/recv only and no
> rdma_{read,write}, then this wouldn't be quite as bad.  But even then
> I'm still very leary of this "feature".

How about if all the processes are considered as one unit of trust? anyway
this could be done in a multi threaded application or when one process
forks child processes.

> 
> > 
> > > What is the "key" that allows a MR to be shared among 2
> > > processes?  Do you
> > > introduce some PD identifier?  And then some {PDID, lkey} tuple is
> > > used to ID
> > > the MR?
> > > 
> > > I assume you have to share the PD first and then any MR in the
> > > shared PD can be
> > > shared?  If so how does the MR get shared?
> > 
> > Sorry, i'm not following.
> > I think the term 'share' is somehow mistake, it is actually a process
> > 'imports' objects into it's context. And yes, the workflow is first to
> > import the PD and then import the MR.
> > 
> > > Again I'm concerned with how this will interact with the RDMA and
> > > file system
> > > interaction we have been trying to fix.
> > 
> > I'm not aware of this file-system thing, can you point me to some
> > discussion on that so i'll see how this patch-set affect it.
> > 
> > > Why is SCM_RIGHTS on the rdma context FD not sufficient to share the
> > > entire
> > > context, PD, and all MR's?
> > 
> > Well, this SCM_RIGHTS is great, one can share the IB context with
> > another.
> > But it is not enough, because:
> > - What API the second process can use to get his hands on one of the
> > PDs or
> >   MRs from this context?
> > - What mechanism takes care of the destruction of such objects
> > (SCM_RIGHTS
> >   takes care for the ref counting of the context but i'm referring to
> > the
> >   PDs and MRs objects)?
> > 
> > The entire purpose of this patch set is to address these two
> > questions.
> > 
> > Yuval
> > 
> > > Ira
> > > 
> > > > Patch-set is logically splits to 4 parts as the following:
> > > > - patches 1 to 7 and 18 are preparation steps.
> > > > - patches 8 to 14 are the implementation of import PD
> > > > - patches 15 to 17 are the implementation of the verb
> > > > - patches 19 to 24 are the implementation of import MR
> > > > 
> > > > v0 -> v1:
> > > > 	* Delete the patch "IB/uverbs: ufile must be freed only when not
> > > > 	  used anymore". The process can die, the ucontext remains until
> > > > 	  last reference to it is closed.
> > > > 	* Rebase to latest for-next branch
> > > > 
> > > > Shamir Rabinovitch (16):
> > > >   RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
> > > >   RDMA/uverbs: Delete the macro uobj_put_obj_read
> > > >   RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
> > > >   IB/{core,hw}: ib_pd should not have ib_uobject pointer
> > > >   IB/core: ib_uobject need HW object reference count
> > > >   IB/uverbs: Helper function to initialize ufile member of
> > > >     uverbs_attr_bundle
> > > >   IB/uverbs: Add context import lock/unlock helper
> > > >   IB/verbs: Prototype of HW object clone callback
> > > >   IB/mlx4: Add implementation of clone_pd callback
> > > >   IB/mlx5: Add implementation of clone_pd callback
> > > >   RDMA/rxe: Add implementation of clone_pd callback
> > > >   IB/uverbs: Add clone reference counting to ib_pd
> > > >   IB/uverbs: Add PD import verb
> > > >   IB/mlx4: Enable import from FD verb
> > > >   IB/mlx5: Enable import from FD verb
> > > >   RDMA/rxe: Enable import from FD verb
> > > > 
> > > > Yuval Shaia (8):
> > > >   IB/core: Install clone ib_pd in device ops
> > > >   IB/core: ib_mr should not have ib_uobject pointer
> > > >   IB/core: Install clone ib_mr in device ops
> > > >   IB/mlx4: Add implementation of clone_pd callback
> > > >   IB/mlx5: Add implementation of clone_pd callback
> > > >   RDMA/rxe: Add implementation of clone_pd callback
> > > >   IB/uverbs: Add clone reference counting to ib_mr
> > > >   IB/uverbs: Add MR import verb
> > > > 
> > > >  drivers/infiniband/core/device.c              |   2 +
> > > >  drivers/infiniband/core/nldev.c               | 127 ++++-
> > > >  drivers/infiniband/core/rdma_core.c           |  23 +-
> > > >  drivers/infiniband/core/uverbs.h              |   2 +
> > > >  drivers/infiniband/core/uverbs_cmd.c          | 489
> > > > +++++++++++++++---
> > > >  drivers/infiniband/core/uverbs_main.c         |   1 +
> > > >  drivers/infiniband/core/uverbs_std_types_mr.c |   1 -
> > > >  drivers/infiniband/core/verbs.c               |   4 -
> > > >  drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |   1 -
> > > >  drivers/infiniband/hw/mlx4/main.c             |  18 +-
> > > >  drivers/infiniband/hw/mlx5/main.c             |  34 +-
> > > >  drivers/infiniband/hw/mthca/mthca_qp.c        |   3 +-
> > > >  drivers/infiniband/sw/rxe/rxe_verbs.c         |   5 +
> > > >  include/rdma/ib_verbs.h                       |  43 +-
> > > >  include/rdma/uverbs_std_types.h               |  11 +-
> > > >  include/uapi/rdma/ib_user_verbs.h             |  15 +
> > > >  include/uapi/rdma/rdma_netlink.h              |   3 +
> > > >  17 files changed, 669 insertions(+), 113 deletions(-)
> > > > 
> > > > -- 
> > > > 2.20.1
> > > > 
> 
> -- 
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


