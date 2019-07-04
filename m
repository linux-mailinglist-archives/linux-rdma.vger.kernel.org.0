Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 140E95F944
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 15:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfGDNlz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 09:41:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42512 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfGDNlz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jul 2019 09:41:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64DYCEB088053;
        Thu, 4 Jul 2019 13:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Dlw2BZECljrRb5zUVHmug4KRAXeIKZcZd3eoMR7F2jw=;
 b=dxvRBSmOwJYJOj+1kzzrB/UlFSsn9ovy2cSNxoryrPzJo/JG/b/OfeTpulg4AuiPgoHo
 DTEl6gQ4ZC+j7xvNvb5OL1rtqV2dNNI8kXEktbRSPdGn97L4Elhl68bR/VeVSKfwG8C1
 5os9k8eOQjWSO7/ImIOZppLt2IO2K/msBWfuJ23rz9m4spwImnXU8cCnACag7YFq+wDO
 mGO3nJleY9NBaaBL4xiTaCzTqcHCIhJ40pR9pRA7t4pzGhj/XDbU00k8Mq7ouU464h7w
 eHW/6nSKAr3G1jKYJJ36A7JpeEZY/1MXSkx/LhDEtPB1TeEXshunlm4bBFb4udljviei 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2te5tby0jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 13:41:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64DWSrF011487;
        Thu, 4 Jul 2019 13:41:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2th9ec003b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 13:41:51 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x64DfnED014896;
        Thu, 4 Jul 2019 13:41:50 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jul 2019 06:41:48 -0700
Date:   Thu, 4 Jul 2019 16:41:38 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        linux-rdma@vger.kernel.org, leon@kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [RFC rdma-core] verbs: add ibv_export_to_fd man page
Message-ID: <20190704134136.GA5711@lap1>
References: <20190626083614.23688-1-shamir.rabinovitch@oracle.com>
 <20190626124637.GA3091@lap1>
 <20190702224807.GE11860@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702224807.GE11860@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040170
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040171
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 02, 2019 at 07:48:07PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 26, 2019 at 03:46:39PM +0300, Yuval Shaia wrote:
> > On Wed, Jun 26, 2019 at 11:36:14AM +0300, Shamir Rabinovitch wrote:
> > > Add the ibv_export_to_fd man page.
> > 
> > This is RFC but still suggesting to give some words here.
> > 
> > Also, subject is incorrect since man page is for all functions involved in
> > the shared-obj mechanism, not only the export_to_fd.
> > 
> > > 
> > > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > >  libibverbs/man/ibv_export_to_fd.3.md | 109 +++++++++++++++++++++++++++
> > >  1 file changed, 109 insertions(+)
> > >  create mode 100644 libibverbs/man/ibv_export_to_fd.3.md
> > > 
> > > diff --git a/libibverbs/man/ibv_export_to_fd.3.md b/libibverbs/man/ibv_export_to_fd.3.md
> > > new file mode 100644
> > > index 00000000..8e3f0fb2
> > > +++ b/libibverbs/man/ibv_export_to_fd.3.md
> > > @@ -0,0 +1,109 @@
> > > +---
> > > +date: 2018-06-26
> > > +footer: libibverbs
> > > +header: "Libibverbs Programmer's Manual"
> > > +layout: page
> > > +license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
> > > +section: 3
> > > +title: ibv_export_to_fd
> > > +tagline: Verbs
> > > +---
> > > +
> > > +# NAME
> > > +
> > > +**ibv_export_to_fd**, **ibv_import_pd**, **ibv_import_mr** - export & import ib hw objects.
> > > +
> > > +# SYNOPSIS
> > > +
> > > +```c
> > > +#include <infiniband/verbs.h>
> > > +
> > > +int ibv_export_to_fd(uint32_t fd,
> > > +                     uint32_t *new_handle,
> > > +                     struct ibv_context *context,
> > > +                     enum uverbs_default_objects type,
> > > +                     uint32_t handle);
> 
> This should probably be some internal function and the exports should
> be type safe just like the imports.

So you suggesting something like this (instead of passing handle as arg):

int ibv_export_pd(uint32_t fd,
		  uint32_t *new_handle,
		  struct ibv_context *context,
		  struct ib_pd* pd);

int ibv_export_mr(uint32_t fd,
		  uint32_t *new_handle,
		  struct ibv_context *context,
		  struct ib_mr* mr);

So the handle is taken internally from the pd or mr  arg.

Are you still ok with new_handle? asking as this is what is used in the
ibv_import_xxx functions.

> 
> > > +struct ibv_pd *ibv_import_pd(struct ibv_context *context,
> > > +                             uint32_t fd,
> > > +                             uint32_t handle);
> > > +
> > > +struct ibv_mr *ibv_import_mr(struct ibv_context *context,
> > > +                             uint32_t fd,
> > > +                             uint32_t handle);
> > > +
> > > +uint32_t ibv_context_to_fd(struct ibv_context *context);
> > > +
> > > +uint32_t ibv_pd_to_handle(struct ibv_pd *pd);
> > > +
> > > +uint32_t ibv_mr_to_handle(struct ibv_mr *mr);
> > 
> > Do you know if extra stuff besides this new file needs to be done so i can
> > do ex man ibv_context_to_fd and get this man page?
> 
> Yes, they need to be setup in cmake with aliases.

Will take care of it, thanks.

> 
> I think this man page is kind of terse for such a complicated
> thing. 
> 
> Ie it doesn't talk about what happens when close() or ibv_destroy_X()
> is called.

We've mentioned that the returned object is like a regular object returned
from (ex) ibv_create_pd and should be destroyed with the corresponding
destroy function.
We can add a note saying that the HW object will be destroyed only when all
reference to it will be destroyed.
Is that enough?

> 
> Jason
