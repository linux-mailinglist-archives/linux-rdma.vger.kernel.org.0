Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6FD23309
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 13:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbfETLut (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 07:50:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58378 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731777AbfETLus (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 May 2019 07:50:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KBnaAh149371;
        Mon, 20 May 2019 11:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=rhFnK/NoJoiOPNuu2oqPUqAvlJKvAkFXxRv2Zxs2eks=;
 b=u6HN7gKP3pChGrUn73qYZw5IA2PN1ommA2L2IuRT3e3Mpm3lpT6b6oudUWLrcCe+staQ
 3PM8wc3joe14dejprCDNGaGTZGw4Y9EjcXJqTME31DUTTaU56FFKM1W4vWdRpeH7thZt
 WD/c4ZEtbExw1/srA+DEV8AXen9Jxs0pU4Aw75OC1bDtYG6S9VDk+4OrOOLBrDA5Ay8H
 K7bG1AGxda3ICsFcrYo5V5+BKMbFEmRX3/4Frdsg+n2sNLOqnPZP6JHNdcyyHN/bhL9S
 UeQeJU6oWi8lTVKG2oqNe7lkdfRwwa6JXTNmKDMqMq1vOXwVa8YRDE3kDoc6i+bpFirF BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2sj9ft6cys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 11:50:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KBnpEY070293;
        Mon, 20 May 2019 11:50:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2sks18j7hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 11:50:20 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4KBoIRn021023;
        Mon, 20 May 2019 11:50:18 GMT
Received: from srabinov-laptop (/10.175.35.172)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 May 2019 11:50:17 +0000
Date:   Mon, 20 May 2019 14:50:10 +0300
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH for-next v2 3/4] RDMA/nldev: ib_pd can be pointed by
 multiple ib_ucontext
Message-ID: <20190520115009.GA7740@srabinov-laptop>
References: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
 <20190520075333.6002-4-shamir.rabinovitch@oracle.com>
 <20190520091840.GB4573@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520091840.GB4573@mtr-leonro.mtl.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905200082
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200083
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 12:18:40PM +0300, Leon Romanovsky wrote:
> On Mon, May 20, 2019 at 10:53:20AM +0300, Shamir Rabinovitch wrote:
> > In shared object model ib_pd can belong to 1 or more ib_ucontext.
> > Fix the nldev code so it could report multiple context ids.
> >
> > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > ---
> >  drivers/infiniband/core/nldev.c | 93 +++++++++++++++++++++++++++++++--
> >  1 file changed, 88 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > index cbd712f5f8b2..f4cc92b897ff 100644
> > --- a/drivers/infiniband/core/nldev.c
> > +++ b/drivers/infiniband/core/nldev.c
> > @@ -41,6 +41,9 @@
> >  #include "core_priv.h"
> >  #include "cma_priv.h"
> >  #include "restrack.h"
> > +#include "uverbs.h"
> > +
> > +static bool is_visible_in_pid_ns(struct rdma_restrack_entry *res);
> 
> Mark needed it too.
> https://patchwork.kernel.org/patch/10921419/
> 

I see. So follow Mark patch the above hunk is not needed.
Should I apply Mark patch before this series?

> > +	if (!rdma_is_kernel_res(res)) {
> > +		pd_context(pd, &pd_context_ids);
> > +		list_for_each_entry(ctx_id, &pd_context_ids, list) {
> > +			if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> > +				ctx_id->id))
> 
> Did it work? You are overwriting RDMA_NLDEV_ATTR_RES_CTXN entry in the
> loop. You need to add RDMA_NLDEV_ATTR_RES_CTX and
> RDMA_NLDEV_ATTR_RES_CTX_ENTRY to include/uapi/rdma_netlink.h and
> open nested table here (inside of PD) with list of contexts.

I tested with only 1 context per pd (what we have today). Thanks for
comment. I'll try to follow what you wrote here.

