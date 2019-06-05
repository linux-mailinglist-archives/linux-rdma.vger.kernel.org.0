Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4135D79
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 15:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfFENFU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 09:05:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52072 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfFENFU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 09:05:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55CsKjU090157;
        Wed, 5 Jun 2019 13:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Mp4BfOrwv/HrSKFr7H0xPGUzyIAhBNjPqgH944OWr/k=;
 b=buJoKBo8ioQ+XEekssFs7TkHvrMY65VsFwIf+bh800hhutYqt4GaPTE7d5Cg5whcLhu7
 YXNUoaoz0/2QeguyAnZQowGxBzN0k+GGTvf/3LMozluW5NApdEaKwzoYtXWUFUklBPNV
 URKdw4CVeX2kTjVfff4mF9YpbVmIRjBLoV8Ot7zipZbyY2PGQObvoJT1SpEeXOVIjzG9
 aaGHs+oP9WRP04IihIfUP0lQsxL5h8fS6VXeGKmz/Kj79p/zkB+XjTBC1EiT1n9PLN8Q
 ynVFpJhI6Aug7YEsAfcgDTK0xT2+u1ZRE6wRMA4f6I//WSBaza/v5GNE+eIGMdwQ1LYT TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2sugstjfqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 13:04:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55D12QG113359;
        Wed, 5 Jun 2019 13:02:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2swngkvj13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 13:02:54 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x55D2qFr006884;
        Wed, 5 Jun 2019 13:02:52 GMT
Received: from srabinov-laptop (/109.186.248.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Jun 2019 06:02:51 -0700
Date:   Wed, 5 Jun 2019 16:02:45 +0300
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@mellanox.com
Subject: Re: [PATCH for-next v3 0/4] ib_pd should not have ib_uobject
Message-ID: <20190605130244.GA3433@srabinov-laptop>
References: <20190530122422.32283-1-shamir.rabinovitch@oracle.com>
 <20190605072125.GA18424@srabinov-laptop>
 <20190605082549.GM5261@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605082549.GM5261@mtr-leonro.mtl.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050083
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 05, 2019 at 11:25:49AM +0300, Leon Romanovsky wrote:
> On Wed, Jun 05, 2019 at 10:21:26AM +0300, Shamir Rabinovitch wrote:
> > On Thu, May 30, 2019 at 03:24:05PM +0300, Shamir Rabinovitch wrote:
> > > This patch set complete the cleanup done in the driver/verbs/uverbs
> > > where the dependency of the code in the ib_x uobject pointer was
> > > removed.
> > >
> > > The uobject pointer is removed from the ib_pd as last step
> > > before I can start adding the pd sharing code.
> > >
> > > The rdma/netlink code now don't have dependency in the ib_pd
> > > uobject pointer and can report multiple context id that point
> > > to same ib_pd.
> > >
> > > Using iproute2 I can test the modified rdma/netlink:
> > > [root@qemu-fc29 iproute2]# rdma/rdma res show pd dev mlx4_0
> > > dev mlx4_0 pdn 0 local_dma_lkey 0x8000 users 4 comm [ib_core]
> > > dev mlx4_0 pdn 1 local_dma_lkey 0x8000 users 4 comm [ib_core]
> > > dev mlx4_0 pdn 2 local_dma_lkey 0x8000 users 5 comm [ib_ipoib]
> > > dev mlx4_0 pdn 3 local_dma_lkey 0x8000 users 5 comm [ib_ipoib]
> > > dev mlx4_0 pdn 4 local_dma_lkey 0x8000 users 0 comm [ib_srp]
> > > dev mlx4_0 pdn 5 local_dma_lkey 0x8000 users 0 comm [ib_srpt]
> > > dev mlx4_0 pdn 6 local_dma_lkey 0x0 users 2 ctxn 0 pid 7693 comm ib_send_bw
> > > dev mlx4_0 pdn 7 local_dma_lkey 0x0 users 2 ctxn 1 pid 7694 comm ib_send_bw
> > >
> > > Changelog:
> > >
> > > v1->v2
> > > * 1 patch from v1 applied (Jason)
> > > * Fix uobj_get_obj_read macro (Jason)
> > > * Do not allocate memory when fixing uobj_get_obj_read (Jason)
> > > * Fix uobj_get_obj_read macro (Jason)
> > > * rdma/netlink can now work as before (Leon)
> > >
> > > v2->v3:
> > > * rdma/netlink nest multiple context ids of same ib_pd (Leon)
> > >
> > > Shamir Rabinovitch (4):
> > >   RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
> > >   RDMA/uverbs: uobj_put_obj_read macro should be removed
> > >   RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
> > >   IB/{core,hw}: ib_pd should not have ib_uobject pointer
> > >
> > >  drivers/infiniband/core/nldev.c            | 129 +++++++++++-
> > >  drivers/infiniband/core/uverbs_cmd.c       | 218 +++++++++++++--------
> > >  drivers/infiniband/core/verbs.c            |   1 -
> > >  drivers/infiniband/hw/hns/hns_roce_hw_v1.c |   1 -
> > >  drivers/infiniband/hw/mlx5/main.c          |   1 -
> > >  drivers/infiniband/hw/mthca/mthca_qp.c     |   3 +-
> > >  include/rdma/ib_verbs.h                    |   1 -
> > >  include/rdma/uverbs_std_types.h            |  11 +-
> > >  include/uapi/rdma/rdma_netlink.h           |   3 +
> > >  9 files changed, 273 insertions(+), 95 deletions(-)
> > >
> > > --
> > > 2.20.1
> > >
> >
> > Jason, Leon, can you please review this patch set ?
> 
> I'm sorry for the delay.
> 
> >
> > Anything missing from my side here?
> 
> Can you please post rdmatool output for shared PD?
> In such case, all those shared PD need to have same PDN.

Leon I do not have all the pieces in place for this yes.

I only tested that current rdmatool can cope with netlink message that
has nested context ids as it will happen in shared pd case.

I'll do that once we have the export_to_fd & import_pd & import_mr verbs
in place.

> 
> Thanks
