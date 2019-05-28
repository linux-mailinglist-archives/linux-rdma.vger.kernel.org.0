Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6012C698
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfE1MeH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 08:34:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37036 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfE1MeH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 08:34:07 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SCSmWt137405;
        Tue, 28 May 2019 12:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=fD5AjPOxgyAztRBQTSWFQMWWFEoVgYQmbKm+TYWNDhE=;
 b=MWzWlP4cy/8JymW3aFkPldtAo+Htr3WIY6ZsioqjG3xYB6JgzK5BZJ4ihiTYse0HtmGU
 ivuBIz4gs/joAooA3558xev9vtPcH529pEot4FHwX6RQABDUQXNPyZNoEQLXN29j9Ugn
 0+znjeHA5olopF8q6KAUMQjemXWPDQ3m41+kkMKSVNDK0dp+y7QHoyBWN4lhQcNTA1D3
 ZLJUNPQOc+kg07FrxKA+cPkWdE2ttDZsYolGUHgXzVN26v/YoXoElXL2ck+9Dnxm3ylE
 uWI/onrhn1k7qCbOsXAvDP8P/DQQH4EMxJTzusN9dR/1SAciADYESoX8cQzK/GWEkKDm Cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2spu7dawb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 12:33:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SCWKOV085575;
        Tue, 28 May 2019 12:33:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2sqh732xmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 12:33:41 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4SCXdo1006283;
        Tue, 28 May 2019 12:33:39 GMT
Received: from srabinov-laptop (/109.186.250.120)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 05:33:39 -0700
Date:   Tue, 28 May 2019 15:33:26 +0300
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH for-next v2 3/4] RDMA/nldev: ib_pd can be pointed by
 multiple ib_ucontext
Message-ID: <20190528123322.GA11474@srabinov-laptop>
References: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
 <20190520075333.6002-4-shamir.rabinovitch@oracle.com>
 <20190520091840.GB4573@mtr-leonro.mtl.com>
 <20190522122531.GA6173@srabinov-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522122531.GA6173@srabinov-laptop>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280082
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 03:25:32PM +0300, Shamir Rabinovitch wrote:
> On Mon, May 20, 2019 at 12:18:40PM +0300, Leon Romanovsky wrote:
> > On Mon, May 20, 2019 at 10:53:20AM +0300, Shamir Rabinovitch wrote:
> > > In shared object model ib_pd can belong to 1 or more ib_ucontext.
> > > Fix the nldev code so it could report multiple context ids.
> > >
> > > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > > ---
> 
> [...]
> 
> > > +	if (!rdma_is_kernel_res(res)) {
> > > +		pd_context(pd, &pd_context_ids);
> > > +		list_for_each_entry(ctx_id, &pd_context_ids, list) {
> > > +			if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> > > +				ctx_id->id))
> > 
> > Did it work? You are overwriting RDMA_NLDEV_ATTR_RES_CTXN entry in the
> > loop. You need to add RDMA_NLDEV_ATTR_RES_CTX and
> > RDMA_NLDEV_ATTR_RES_CTX_ENTRY to include/uapi/rdma_netlink.h and
> > open nested table here (inside of PD) with list of contexts.
> > 
> > > +				goto err;
> > > +		}
> 
> Hi Leon,
> 
> Just to clarify the above nesting...
> 
> Do you expect the below NL attribute nesting in case of shared pd dump?
> 
> RDMA_NLDEV_ATTR_RES_CTX
> 	RDMA_NLDEV_ATTR_RES_CTX_ENTRY
> 		RDMA_NLDEV_ATTR_RES_CTXN #1
> 		RDMA_NLDEV_ATTR_RES_CTXN #2
> 		...
> 		RDMA_NLDEV_ATTR_RES_CTXN #N
> 
> 
> I tried this and rdmatool reported:
> 
> [root@qemu-fc29 iproute2]# rdma/rdma res show pd dev mlx4_0
> dev mlx4_0 pdn 0 local_dma_lkey 0x8000 users 4 comm [ib_core]
> dev mlx4_0 pdn 1 local_dma_lkey 0x8000 users 4 comm [ib_core]
> error: Operation not supported
> 
> Is this the expected behaviour from unmodified latest rdmatool?
> 
> Thanks

Leon, 

I tried this nesting (which make more sense to me) and results are the
same as above.

RDMA_NLDEV_ATTR_RES_CTX
	RDMA_NLDEV_ATTR_RES_CTX_ENTRY
		RDMA_NLDEV_ATTR_RES_CTXN
	RDMA_NLDEV_ATTR_RES_CTX_ENTRY
		RDMA_NLDEV_ATTR_RES_CTXN
...

Which is the nesting you expect ?

Is it OK that we get the rdma tool "error: Operation not supported" ?

Thanks
