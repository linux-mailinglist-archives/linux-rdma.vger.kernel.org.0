Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 160B7426C1
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 14:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436623AbfFLMzq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 08:55:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40490 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438421AbfFLMzp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 08:55:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CCsKvY145703;
        Wed, 12 Jun 2019 12:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=v79sqnZ4W7t95evEJOziS0PN1d4ZsR5ftu3hgA3hjiM=;
 b=eu6UL9KoR3mQbzYhVTie91UCPyOv/Jx66T0XWnBsrHomzQEEv/yc4Us8y3xBXSIxZ3Aa
 6EjQInZD57rGO7obeIRTMQfSddx6fO1dXwRE9TYBQFLALONXMjz3ZsY5tE1uuPWvXQJ+
 91Q1IwLVgn+VEE/x7b+b/0HOeNydiJGcjXEx1G56Q8WSbxxSfXzvRyYL681jExhbxdx3
 k71Rl9NcYgDceq3LwIbMHfGNp5V3Gs5QgS08c4S+03Co8sL1xt1kFlI2Dub/EH38M/nA
 o8rRTT62p6FsDrFLQ/9sF7Pvm+c+XQkJbtOL5L5cx7edDVJhiYi7lnBe9e+stmhWkI+y Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t04etu6x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 12:55:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CCsoeZ003150;
        Wed, 12 Jun 2019 12:55:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2t1jpj0hk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 12:55:24 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5CCtNDK023670;
        Wed, 12 Jun 2019 12:55:23 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 05:55:23 -0700
Date:   Wed, 12 Jun 2019 15:55:18 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA: Convert destroy_wq to be void
Message-ID: <20190612125518.GA3358@lap1>
References: <20190612122741.22850-1-leon@kernel.org>
 <20190612124049.GA2448@lap1>
 <20190612125112.GR6369@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612125112.GR6369@mtr-leonro.mtl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120089
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 03:51:12PM +0300, Leon Romanovsky wrote:
> On Wed, Jun 12, 2019 at 03:40:50PM +0300, Yuval Shaia wrote:
> > On Wed, Jun 12, 2019 at 03:27:41PM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > All callers of destroy WQ are always success and there is no need
> > > to check their return value, so convert destroy_wq to be void.
> > >
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > ---
> > >  drivers/infiniband/core/verbs.c      | 12 +++++-------
> > >  drivers/infiniband/hw/mlx4/mlx4_ib.h |  2 +-
> > >  drivers/infiniband/hw/mlx4/qp.c      |  4 +---
> > >  drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
> > >  drivers/infiniband/hw/mlx5/qp.c      |  4 +---
> > >  include/rdma/ib_verbs.h              |  2 +-
> > >  6 files changed, 10 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > > index 2fb834bb146c..d55f491be24f 100644
> > > --- a/drivers/infiniband/core/verbs.c
> > > +++ b/drivers/infiniband/core/verbs.c
> > > @@ -2344,19 +2344,17 @@ EXPORT_SYMBOL(ib_create_wq);
> > >   */
> > >  int ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
> >
> > So why this one left out of this change?
> 
> This function can return -EBUSY.

Missed that.

> 
> >
> > >  {
> > > -	int err;
> > >  	struct ib_cq *cq = wq->cq;
> > >  	struct ib_pd *pd = wq->pd;
> > >
> > >  	if (atomic_read(&wq->usecnt))
> > >  		return -EBUSY;
> 
> Thanks

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

