Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B34573C681
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403836AbfFKIuO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 04:50:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60532 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391273AbfFKIuO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 04:50:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B8mVCK170798;
        Tue, 11 Jun 2019 08:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=7V1ikAmNv5WAE25RKNK6sjTXPvJ2x9oGUizrQvKZ8oY=;
 b=HTbfEixs+3bQeZ4hT7Y+8og6AhSfEr+v3Bff+GO9DhOngsNvBEAvGGpvqf7Xch8CO6Be
 U9R97GZNKJOVl3PXxMQeEL0C/YUjlm5Zt8VHy4U/FM58HkZcWDUPAJoFflg4hM2YmV+y
 /QzBTJFdXQ+2hrQXUEH0se6VV29T1xAJq2STbdKJdDHZWqDS3TK0mYfb500YYn8C1LWq
 tmOkOpJKalZmpCjek2imZmid06qc6CWnznf7DIQ639cdaXaBD+ekvXtx+D3xGeuETOGV
 eegja47JTRkhjtp30PvEU/JnlNCLPESh8jcp7FuRDQ0NLRqH+mMWpCJTJDFx3VROK2I/ OA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t05nqkp77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 08:49:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B8mwd5007571;
        Tue, 11 Jun 2019 08:49:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2t1jphb2x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 08:49:48 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5B8nl2w009816;
        Tue, 11 Jun 2019 08:49:47 GMT
Received: from lap1 (/10.175.46.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 01:49:46 -0700
Date:   Tue, 11 Jun 2019 11:49:41 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     yishaih@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, jgg@mellanox.com
Subject: Re: [PATCH v4 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Message-ID: <20190611084941.GA3499@lap1>
References: <20190606100511.4489-1-yuval.shaia@oracle.com>
 <20190608083224.GS5261@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608083224.GS5261@mtr-leonro.mtl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=9 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110061
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 08, 2019 at 11:32:24AM +0300, Leon Romanovsky wrote:
> On Thu, Jun 06, 2019 at 01:05:11PM +0300, Yuval Shaia wrote:
> > The virtual address that is registered is used as a base for any address
> > passed later in post_recv and post_send operations.
> >
> > On some virtualized environment this is not correct.
> >
> > A guest cannot register its memory so hypervisor maps the guest physical
> > address to a host virtual address and register it with the HW. Later on,
> > at datapath phase, the guest fills the SGEs with addresses from its
> > address space.
> > Since HW cannot access guest virtual address space an extra translation
> > is needed to map those addresses to be based on the host virtual address
> > that was registered with the HW.
> > This datapath interference affects performances.
> >
> > To avoid this, a logical separation between the address that is
> > registered and the address that is used as a offset at datapath phase is
> > needed.
> > This separation is already implemented in the lower layer part
> > (ibv_cmd_reg_mr) but blocked at the API level.
> >
> > Fix it by introducing a new API function which accepts an address from
> > guest virtual address space as well, to be used as offset for later
> > datapath operations.
> >
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> > v0 -> v1:
> > 	* Change reg_mr callback signature instead of adding new callback
> > 	* Add the new API to libibverbs/libibverbs.map.in
> > v1 -> v2:
> > 	* Do not modify reg_mr signature for version 1.0
> > 	* Add note to man page
> > v2 -> v3:
> > 	* Rename function to reg_mr_iova (and arg-name to iova)
> > 	* Some checkpatch issues not related to this fix but detected now
> > 		* s/__FUNCTION__/__func
> > 		* WARNING: function definition argument 'void *' should
> > 		 also have an identifier name
> > v3 -> v4:
> > 	* Fix commit message as suggested by Adit Ranadiv
> > 	* Add support for efa
> > ---
> >  libibverbs/driver.h               |  2 +-
> >  libibverbs/dummy_ops.c            |  2 +-
> >  libibverbs/libibverbs.map.in      |  1 +
> >  libibverbs/man/ibv_reg_mr.3       | 15 +++++++++++++--
> >  libibverbs/verbs.c                | 23 ++++++++++++++++++++++-
> >  libibverbs/verbs.h                |  7 +++++++
> >  providers/bnxt_re/verbs.c         |  6 +++---
> >  providers/bnxt_re/verbs.h         |  2 +-
> >  providers/cxgb3/iwch.h            |  4 ++--
> >  providers/cxgb3/verbs.c           |  9 +++++----
> >  providers/cxgb4/libcxgb4.h        |  4 ++--
> >  providers/cxgb4/verbs.c           |  9 +++++----
> >  providers/efa/verbs.c             |  4 ++--
> >  providers/efa/verbs.h             |  2 +-
> >  providers/hfi1verbs/hfiverbs.h    |  4 ++--
> >  providers/hfi1verbs/verbs.c       |  8 ++++----
> >  providers/hns/hns_roce_u.h        |  2 +-
> >  providers/hns/hns_roce_u_verbs.c  |  6 +++---
> >  providers/i40iw/i40iw_umain.h     |  3 ++-
> >  providers/i40iw/i40iw_uverbs.c    |  8 ++++----
> >  providers/ipathverbs/ipathverbs.h |  4 ++--
> >  providers/ipathverbs/verbs.c      |  8 ++++----
> >  providers/mlx4/mlx4.h             |  4 ++--
> >  providers/mlx4/verbs.c            |  7 +++----
> >  providers/mlx5/mlx5.h             |  4 ++--
> >  providers/mlx5/verbs.c            |  7 +++----
> >  providers/mthca/ah.c              |  3 ++-
> >  providers/mthca/mthca.h           |  4 ++--
> >  providers/mthca/verbs.c           |  6 +++---
> >  providers/nes/nes_umain.h         |  3 ++-
> >  providers/nes/nes_uverbs.c        |  9 ++++-----
> >  providers/ocrdma/ocrdma_main.h    |  4 ++--
> >  providers/ocrdma/ocrdma_verbs.c   | 10 ++++------
> >  providers/qedr/qelr_main.h        |  4 ++--
> >  providers/qedr/qelr_verbs.c       | 11 ++++-------
> >  providers/qedr/qelr_verbs.h       |  4 ++--
> >  providers/rxe/rxe.c               |  6 +++---
> >  providers/vmw_pvrdma/pvrdma.h     |  4 ++--
> >  providers/vmw_pvrdma/verbs.c      |  7 +++----
> >  39 files changed, 133 insertions(+), 97 deletions(-)
> 
> You need to bump PABI in main CmakeList.txt file, otherwise "old
> providers" won't work with new libibverbs.

The P stands for "Private" (asking so i'll know to look carefully at
section "Private symbols in libibverbs").

Just bump 22 to 23?
How about PACKAGE_VERSION? nothing there?

> 
> Also I don't see any changes in debian/ folder, which is not right too.

debian/changelog?
debian/control?
debian/libibverbs1.symbols?

Anything needs to be done for other distro? redhat, suse?

Shall i take commit 75c65bbca as an example?

> 
> Thanks
