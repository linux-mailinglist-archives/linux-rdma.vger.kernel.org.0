Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814723AEDB
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 08:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbfFJGDb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 02:03:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43512 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387614AbfFJGDb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jun 2019 02:03:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5A5xSLN091050;
        Mon, 10 Jun 2019 06:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ua5Kn57u23KRM8CS8jpzqRgxZMUt9wSOXGS523cO7LY=;
 b=jYLfrVJAwc3188Z2XwI05uNHLz5VwCBqxNrSWTt046zzTXQ2nL9LJWgQL9hiW5883iXJ
 iMFshz4N9gKcX6j8NGJElqI5hbLL4sj0DPpvo5Zen4oeMr51UhxiDw7AlhDIE32miSWJ
 XtKDWee9T4nRPxqq+xhmefeU2THXNsgP9f5yEnvjvzjiadOKieYkOxl95QVZsIqmph/C
 abR/twIfBe4mHzPPMj8lZ4PzU+6HxoByvRC8HeOOYhFjlrRiFoPWUMh/0mdKG+lxbE+Y
 uDWz2iDC3/OTX2f/atJIjOnMXBMLRw5B2StYyhOOjZl2CRpvy/p+G8mUuWNwZFYr8Wpz Yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2t02hed187-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 06:03:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5A626Ug166469;
        Mon, 10 Jun 2019 06:03:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t0p9qja3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 06:03:16 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5A63F1E026858;
        Mon, 10 Jun 2019 06:03:15 GMT
Received: from srabinov-laptop (/109.186.248.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Jun 2019 23:03:14 -0700
Date:   Mon, 10 Jun 2019 09:03:10 +0300
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com
Subject: Re: [PATCH for-next v3 0/4] ib_pd should not have ib_uobject
Message-ID: <20190610060309.GA16136@srabinov-laptop>
References: <20190530122422.32283-1-shamir.rabinovitch@oracle.com>
 <20190607175111.GA22828@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607175111.GA22828@ziepe.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9283 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906100042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9283 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906100042
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 02:51:11PM -0300, Jason Gunthorpe wrote:
> On Thu, May 30, 2019 at 03:24:05PM +0300, Shamir Rabinovitch wrote:
> > This patch set complete the cleanup done in the driver/verbs/uverbs
> > where the dependency of the code in the ib_x uobject pointer was
> > removed.
> > 
> > The uobject pointer is removed from the ib_pd as last step 
> > before I can start adding the pd sharing code.
> > 
> > The rdma/netlink code now don't have dependency in the ib_pd
> > uobject pointer and can report multiple context id that point
> > to same ib_pd. 
> > 
> > Using iproute2 I can test the modified rdma/netlink:
> > [root@qemu-fc29 iproute2]# rdma/rdma res show pd dev mlx4_0
> > dev mlx4_0 pdn 0 local_dma_lkey 0x8000 users 4 comm [ib_core] 
> > dev mlx4_0 pdn 1 local_dma_lkey 0x8000 users 4 comm [ib_core] 
> > dev mlx4_0 pdn 2 local_dma_lkey 0x8000 users 5 comm [ib_ipoib] 
> > dev mlx4_0 pdn 3 local_dma_lkey 0x8000 users 5 comm [ib_ipoib] 
> > dev mlx4_0 pdn 4 local_dma_lkey 0x8000 users 0 comm [ib_srp] 
> > dev mlx4_0 pdn 5 local_dma_lkey 0x8000 users 0 comm [ib_srpt] 
> > dev mlx4_0 pdn 6 local_dma_lkey 0x0 users 2 ctxn 0 pid 7693 comm ib_send_bw 
> > dev mlx4_0 pdn 7 local_dma_lkey 0x0 users 2 ctxn 1 pid 7694 comm ib_send_bw
> > 
> > Changelog:
> > 
> > v1->v2
> > * 1 patch from v1 applied (Jason)
> > * Fix uobj_get_obj_read macro (Jason)
> > * Do not allocate memory when fixing uobj_get_obj_read (Jason)
> > * Fix uobj_get_obj_read macro (Jason)
> > * rdma/netlink can now work as before (Leon)
> > 
> > v2->v3:
> > * rdma/netlink nest multiple context ids of same ib_pd (Leon)
> > 
> > Shamir Rabinovitch (4):
> >   RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
> >   RDMA/uverbs: uobj_put_obj_read macro should be removed
> >   RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
> >   IB/{core,hw}: ib_pd should not have ib_uobject pointer
> 
> I have to think it is rather a clunky approach..
> 
> I keep moving the _cmd flow closer to the attrs flow - so to do that
> we should be recording the uobj 'get' in the uverbs_attr_bundle and
> then putting them when the handler exits automatically. Just like the
> attr flow does.
> 
> This requires a bit of moving code around so that the write path has
> the bundle_priv which records all of this.
> 
> What do you think?
> 
> Jason

Hi Jason, sorry for the delay,

The above make perfect sense to me and can help to solve figure where
uobjects are left as uobj_get_read. It do have to solve the cases where
some code is doing a multiple uobj_get_read in same uberbs write call
(as we had in ib_uverbs_post_send). It can be done after the shared pd
patch set is adopted if it is acceptable by you.

For the shared pd I'd rather to suggest the follow path to make things 
faster and get Yuval's help:

Next patch-set:

kernel:
- ib_mr->uobject cleanup from (Yuval)
- Add generic sharing support for ib_x object destroy in IB/core
- Add export_to_fd verb
- Add generic 'clone' for ib_x objects
- Enable export of ib_pd
- Add clone to ib_pd
- Add clone of ib_pd to mlx4, mlx5, rxe
- Add import_pd verb

rdma-core:
- Add export_to_fd verb
- Add import_pd verb

Follow patch-set:

Kernel:
- Enable export of ib_mr (Yuval)
- Add clone to ib_mr (Yuval)
- Add clone of ib_mr to mlx4, mlx5, rxe (Yuval)
- Add import_mr verb (Yuval)

rdma-core:
- Add import_mr verb (Yuval)

Next patch-set:

rdma-core:
- Add shpd pingpong sample app based on the new verbs (Yuval/me)

I have some time constraint and I appreciate the time you take to review
and progress this feature.

Thanks
