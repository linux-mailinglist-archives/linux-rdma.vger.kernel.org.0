Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91E523C58
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 17:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbfETPkN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 11:40:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42694 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387541AbfETPkN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 May 2019 11:40:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KFYJ68172776;
        Mon, 20 May 2019 15:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=X6QeCy8Tk1hEVcCaANKPZgfmPxruk13ugU5oj4qOeTI=;
 b=09LjapoHVNR6CnOvRi1tCojfqm7QCbaBhHlCTJRhWRHEv+Cw3jg3vAftGNIWW1/t80IC
 vZjJe9fX+BIBFhCJg58eIn1JVmN6Mn6nnAwAcIs4/vS2DeU3FIXNxzxxN3oCh0PjiHGE
 j/4eKq/MUDxR9SU+HRD+OTYL7Lu4vLuTX7BqzKr2IRJhrDbNWQEurLG7FPSrjoPSsHp8
 FORe4bfZKrPitoWv1TxS9GkPT7TxrRXJZP9VU9RrX73Dj2kN/XMVjdSxxp4fcrhXhG6Z
 uzQNS2d4MmUXxaaJjcGq+MjsH/HTU6w+i3cT/6WaIkM6GFJ2PKN0aQe5qv+RPs5AHv3e gA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2sj7jdg16t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 15:39:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KFbSXa033063;
        Mon, 20 May 2019 15:37:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2sks1xnucq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 15:37:46 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4KFbhU2015430;
        Mon, 20 May 2019 15:37:44 GMT
Received: from srabinov-laptop (/10.175.35.172)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 May 2019 15:37:43 +0000
Date:   Mon, 20 May 2019 18:37:39 +0300
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH for-next v2 3/4] RDMA/nldev: ib_pd can be pointed by
 multiple ib_ucontext
Message-ID: <20190520153738.GA25279@srabinov-laptop>
References: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
 <20190520075333.6002-4-shamir.rabinovitch@oracle.com>
 <20190520091840.GB4573@mtr-leonro.mtl.com>
 <20190520115009.GA7740@srabinov-laptop>
 <20190520120529.GH4573@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520120529.GH4573@mtr-leonro.mtl.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905200100
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200101
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 03:05:29PM +0300, Leon Romanovsky wrote:
> On Mon, May 20, 2019 at 02:50:10PM +0300, Shamir Rabinovitch wrote:
> > On Mon, May 20, 2019 at 12:18:40PM +0300, Leon Romanovsky wrote:
> > > On Mon, May 20, 2019 at 10:53:20AM +0300, Shamir Rabinovitch wrote:
> 
> >
> > > > +	if (!rdma_is_kernel_res(res)) {
> > > > +		pd_context(pd, &pd_context_ids);
> > > > +		list_for_each_entry(ctx_id, &pd_context_ids, list) {
> > > > +			if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> > > > +				ctx_id->id))
> > >
> > > Did it work? You are overwriting RDMA_NLDEV_ATTR_RES_CTXN entry in the
> > > loop. You need to add RDMA_NLDEV_ATTR_RES_CTX and
> > > RDMA_NLDEV_ATTR_RES_CTX_ENTRY to include/uapi/rdma_netlink.h and
> > > open nested table here (inside of PD) with list of contexts.
> >
> > I tested with only 1 context per pd (what we have today). Thanks for
> > comment. I'll try to follow what you wrote here.
> >

Leon, what is your expectation here? I see 2 options:

1. Code will build same NL message in case of single context id and
nested table in case of multiple context ids

2. Code always build nested table with context id(s)

If taking option (1) we can postpone the iproute2 matching commits to
some extent but if we take option (2) I guess I have to add iproute2
commits as well - right? 

Also, what's the best way to add the changes in both given what you
choose above?

Thanks
