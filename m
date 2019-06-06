Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 094053772B
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 16:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfFFOwh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 10:52:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59742 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfFFOwg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 10:52:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56EYDkN110285;
        Thu, 6 Jun 2019 14:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=rI+UUdUA03Q/nZ9d+CumA3Zpk3oRpZWMIXwg3x38YdU=;
 b=Wn0dU2jLCdcZr6VnzV7oPW5T76ISl5L5im99lv7CXNwVcaVz07/7JqEyU2Sp65vnMnaI
 uKc8CohqVZyK5HpEHAQ6kHwqWZoo0/y+aGBzzjIoZmu4f38qsl9PwGd3h/oAuKC3SkI7
 /cs31kGs21QwWvRbN1xTTj3Q3xl2nWjIfJmQllR6S1peVo7MlI/p7Y6zYYqZZPD5m3uk
 f1EKIkQHPT26/aMCp5igfTubC4sDKPX5I5q4eeIpnyeqwOSV9NHGPp4rNKsCojBUSLUR
 AUkCBcD9MHFJWXgbjRvIqm4nDHcA4/xVWhys6HasYddqFGvj/iVQVuU9eqIKCZapXAJk YQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2suj0qrvws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 14:52:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56Epuf2031725;
        Thu, 6 Jun 2019 14:52:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2swngjg047-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 14:52:06 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x56Eq5hV018911;
        Thu, 6 Jun 2019 14:52:05 GMT
Received: from srabinov-laptop (/10.175.12.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 07:52:05 -0700
Date:   Thu, 6 Jun 2019 17:51:51 +0300
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@mellanox.com
Subject: Re: [PATCH for-next v3 0/4] ib_pd should not have ib_uobject
Message-ID: <20190606145147.GA5485@srabinov-laptop>
References: <20190530122422.32283-1-shamir.rabinovitch@oracle.com>
 <20190605072125.GA18424@srabinov-laptop>
 <20190605082549.GM5261@mtr-leonro.mtl.com>
 <20190605130244.GA3433@srabinov-laptop>
 <20190605144651.GO5261@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605144651.GO5261@mtr-leonro.mtl.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060102
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 05, 2019 at 05:46:51PM +0300, Leon Romanovsky wrote:
> On Wed, Jun 05, 2019 at 04:02:45PM +0300, Shamir Rabinovitch wrote:
> > On Wed, Jun 05, 2019 at 11:25:49AM +0300, Leon Romanovsky wrote:
> > > On Wed, Jun 05, 2019 at 10:21:26AM +0300, Shamir Rabinovitch wrote:
> > > > On Thu, May 30, 2019 at 03:24:05PM +0300, Shamir Rabinovitch wrote:
> > > > > This patch set complete the cleanup done in the driver/verbs/uverbs
> > > > > where the dependency of the code in the ib_x uobject pointer was
> > > > > removed.
> > > > >
> > > > > The uobject pointer is removed from the ib_pd as last step
> > > > > before I can start adding the pd sharing code.
> > > > >
> > > > > The rdma/netlink code now don't have dependency in the ib_pd
> > > > > uobject pointer and can report multiple context id that point
> > > > > to same ib_pd.
> > > > >
> > > > > Using iproute2 I can test the modified rdma/netlink:
> > > > > [root@qemu-fc29 iproute2]# rdma/rdma res show pd dev mlx4_0
> > > > > dev mlx4_0 pdn 0 local_dma_lkey 0x8000 users 4 comm [ib_core]
> > > > > dev mlx4_0 pdn 1 local_dma_lkey 0x8000 users 4 comm [ib_core]
> > > > > dev mlx4_0 pdn 2 local_dma_lkey 0x8000 users 5 comm [ib_ipoib]
> > > > > dev mlx4_0 pdn 3 local_dma_lkey 0x8000 users 5 comm [ib_ipoib]
> > > > > dev mlx4_0 pdn 4 local_dma_lkey 0x8000 users 0 comm [ib_srp]
> > > > > dev mlx4_0 pdn 5 local_dma_lkey 0x8000 users 0 comm [ib_srpt]
> > > > > dev mlx4_0 pdn 6 local_dma_lkey 0x0 users 2 ctxn 0 pid 7693 comm ib_send_bw
> > > > > dev mlx4_0 pdn 7 local_dma_lkey 0x0 users 2 ctxn 1 pid 7694 comm ib_send_bw
> > > > >
> > > > > Changelog:
> > > > >
> > > > > v1->v2
> > > > > * 1 patch from v1 applied (Jason)
> > > > > * Fix uobj_get_obj_read macro (Jason)
> > > > > * Do not allocate memory when fixing uobj_get_obj_read (Jason)
> > > > > * Fix uobj_get_obj_read macro (Jason)
> > > > > * rdma/netlink can now work as before (Leon)
> > > > >
> > > > > v2->v3:
> > > > > * rdma/netlink nest multiple context ids of same ib_pd (Leon)
> > > > >
> > > > > Shamir Rabinovitch (4):
> > > > >   RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
> > > > >   RDMA/uverbs: uobj_put_obj_read macro should be removed
> > > > >   RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
> > > > >   IB/{core,hw}: ib_pd should not have ib_uobject pointer
> > > > >
> > > > >  drivers/infiniband/core/nldev.c            | 129 +++++++++++-
> > > > >  drivers/infiniband/core/uverbs_cmd.c       | 218 +++++++++++++--------
> > > > >  drivers/infiniband/core/verbs.c            |   1 -
> > > > >  drivers/infiniband/hw/hns/hns_roce_hw_v1.c |   1 -
> > > > >  drivers/infiniband/hw/mlx5/main.c          |   1 -
> > > > >  drivers/infiniband/hw/mthca/mthca_qp.c     |   3 +-
> > > > >  include/rdma/ib_verbs.h                    |   1 -
> > > > >  include/rdma/uverbs_std_types.h            |  11 +-
> > > > >  include/uapi/rdma/rdma_netlink.h           |   3 +
> > > > >  9 files changed, 273 insertions(+), 95 deletions(-)
> > > > >
> > > > > --
> > > > > 2.20.1
> > > > >
> > > >
> > > > Jason, Leon, can you please review this patch set ?
> > >
> > > I'm sorry for the delay.
> > >
> > > >
> > > > Anything missing from my side here?
> > >
> > > Can you please post rdmatool output for shared PD?
> > > In such case, all those shared PD need to have same PDN.
> >
> > Leon I do not have all the pieces in place for this yes.
> >
> > I only tested that current rdmatool can cope with netlink message that
> > has nested context ids as it will happen in shared pd case.
> 
> Thanks, multiple PDNs worried me and I was afraid that they come from
> shared PDs. You will still need to mock something to see that you
> print them correctly.

I tried to check this by iterating twice on the code in
'fill_res_pd_entry' for user pd. 

kernel confirm that we have duplicate lines for each pd:
[ 4707.051279] fill_res_pd_entry: iter 0
[ 4707.052371] fill_res_pd_entry: iter 1
[ 4707.053426] fill_res_pd_entry: iter 0
[ 4707.054529] fill_res_pd_entry: iter 1

But the rdmatool prints remain as-is:
[root@qemu-fc29 iproute2]# rdma/rdma res show pd dev mlx4_0
dev mlx4_0 pdn 0 local_dma_lkey 0x8000 users 4 comm [ib_core]
dev mlx4_0 pdn 1 local_dma_lkey 0x8000 users 4 comm [ib_core]
dev mlx4_0 pdn 2 local_dma_lkey 0x0 users 2 ctxn 0 pid 12918 comm ib_send_bw
dev mlx4_0 pdn 3 local_dma_lkey 0x0 users 2 ctxn 1 pid 12919 comm ib_send_bw

Does this make sense to you ?

Since we do not have any crash in the rdmatool in this case, can we
postpone this test till we have proper shared pd ?

Can you please review the series ?

Thanks
> 
> >
> > I'll do that once we have the export_to_fd & import_pd & import_mr verbs
> > in place.
> >
> > >
> > > Thanks
