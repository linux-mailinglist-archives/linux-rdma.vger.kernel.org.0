Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A016ED0860
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 09:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfJIHfy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 03:35:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51224 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIHfy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 03:35:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x997YIIH071378;
        Wed, 9 Oct 2019 07:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=astRmtcxdwJfd5jGfQNYmdgoAsTRPrOTEf1/eNK/ur4=;
 b=hMeu5JJSBXaU+qAM43MF9tr25AnwolI1wnzCjWACz0q3XiZtOrhnWSOV/8KfsrkERTY0
 UVFyE6oPmzSJfwmMKB4ILAmYU9pMNAeT/9oexmZl8cgu5segf6qe6XuHqgiLqRQngZ1i
 sQPyI6JBfx+jRyZLGbCbiResFVPUvavt5VULvqsjDNfsUYAcJaKNBgJrwoxPqmnqEA9x
 6v7aEUGiRePffRgOAN/yd1ISAJ5532GPUInMbF3hRMnFJE2kAZ9tlum+y9Yplc4vcA+y
 +mEKnCbP3+acotURpQe6/c3C6kaKi8Si9RlTXQNdRSzrIEEgtt7EGjjWdrxvGXGVyLVj Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vek4qj8b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 07:35:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x997YAqX112192;
        Wed, 9 Oct 2019 07:35:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vgev0qynd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 07:35:17 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x997ZFEG027907;
        Wed, 9 Oct 2019 07:35:15 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 00:35:14 -0700
Date:   Wed, 9 Oct 2019 10:35:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] uverbs: prevent potential underflow
Message-ID: <20191009073506.GI25098@kadam>
References: <20191005052337.GA20129@mwanda>
 <20191008194425.GA28067@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008194425.GA28067@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090071
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 08, 2019 at 04:44:25PM -0300, Jason Gunthorpe wrote:
> On Sat, Oct 05, 2019 at 08:23:37AM +0300, Dan Carpenter wrote:
> > The issue is in drivers/infiniband/core/uverbs_std_types_cq.c in the
> > UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE) function.  We check that:
> > 
> > 	if (attr.comp_vector >= attrs->ufile->device->num_comp_vectors) {
> > 
> > But we don't check that "attr.comp_vector" whether negative.  It
> > could potentially lead to an array underflow.  My concern would be where
> > cq->vector is used in the create_cq() function from the cxgb4 driver.
> > 
> > Fixes: 9ee79fce3642 ("IB/core: Add completion queue (cq) object actions")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/infiniband/core/uverbs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
>  
> > diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
> > index 1e5aeb39f774..63f7f7db5902 100644
> > --- a/drivers/infiniband/core/uverbs.h
> > +++ b/drivers/infiniband/core/uverbs.h
> > @@ -98,7 +98,7 @@ ib_uverbs_init_udata_buf_or_null(struct ib_udata *udata,
> >  
> >  struct ib_uverbs_device {
> >  	atomic_t				refcount;
> > -	int					num_comp_vectors;
> > +	u32					num_comp_vectors;
> >  	struct completion			comp;
> >  	struct device				dev;
> >  	/* First group for device attributes, NULL terminated array */
> 
> I would have expected you to change struct ib_cq_init_attr ? Or at
> least both..
> 
> This is actually a bug as the type of
> UVERBS_ATTR_CREATE_CQ_COMP_VECTOR for userspace is u32:
> 
>         UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_COMP_VECTOR,
>                            UVERBS_ATTR_TYPE(u32),
>                            UA_MANDATORY),
> 
> But we are stuffing it into a int:
> 
>         ret = uverbs_copy_from(&attr.comp_vector, attrs,
>                                UVERBS_ATTR_CREATE_CQ_COMP_VECTOR);
> 
> So very large values will become negative and switching
> num_comp_vectors to u32 won't help??

Yeah.  You're right.  I should have changed both.  I'm not sure what I
was thinking.

My patch does fix the bug because of type promotion, but we should
change both to u32.

regards,
dan carpenter

