Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE763C81C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 12:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405153AbfFKKIJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 06:08:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34262 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405169AbfFKKIJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 06:08:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BA4BEX051438;
        Tue, 11 Jun 2019 10:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=LjjDKR+0h5jy8XWEJc5KDfAlumpMbZO6+MQdfmzWlVc=;
 b=Z4UJWCmSC5Fx0veR+504Jx5Wf5hA4lgVp8zYHsu4stBJBEd0Fvr6ewO7UVjpqh2pOMP3
 IdQ1V63N0qaOhh17Sby4XazWeuQhE6SsGH/FfpUd9qFN+aeylQYXzCBwJCeRYmfNxFt4
 pf8i9mQhmqqPK7HbMgP7uiblqZLJbqyQaPS7eCbDJElTx8/CMwDMMhihxvkl/P1Jz1Q0
 KTGqepsHNsdkWSAK49hxWZb3bCVItdBBgVF4wlXrgL79URvo0+QXx7MmVoftgmESXN5P
 NQ+v8RMsLynTBNxftHT0TjDjqTIAWPOz2pp3GGZPq8bhiPUMqHh2OjHYGMU4zqxdm4vA 9Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2t02hemabq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 10:07:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BA7GG8103976;
        Tue, 11 Jun 2019 10:07:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2t024uars6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 10:07:35 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5BA7XDJ020039;
        Tue, 11 Jun 2019 10:07:33 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 03:07:33 -0700
Date:   Tue, 11 Jun 2019 13:07:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] IB/mlx4: prevent undefined shift in set_user_sq_size()
Message-ID: <20190611100724.GB1915@kadam>
References: <20190608092231.GA28890@mwanda>
 <20190610132849.GD18468@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610132849.GD18468@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110070
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 10, 2019 at 10:28:49AM -0300, Jason Gunthorpe wrote:
> On Sat, Jun 08, 2019 at 12:22:31PM +0300, Dan Carpenter wrote:
> > The ucmd->log_sq_bb_count is a u8 that comes from the user.  If it's
> > larger than the number of bits in an int then that's undefined behavior.
> > It turns out this doesn't really cause an issue at runtime but it's
> > still nice to clean it up.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/infiniband/hw/mlx4/qp.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
> > index 5221c0794d1d..9f6eb23e8044 100644
> > --- a/drivers/infiniband/hw/mlx4/qp.c
> > +++ b/drivers/infiniband/hw/mlx4/qp.c
> > @@ -439,7 +439,8 @@ static int set_user_sq_size(struct mlx4_ib_dev *dev,
> >  			    struct mlx4_ib_create_qp *ucmd)
> >  {
> >  	/* Sanity check SQ size before proceeding */
> > -	if ((1 << ucmd->log_sq_bb_count) > dev->dev->caps.max_wqes	 ||
> > +	if (ucmd->log_sq_bb_count > 31					 ||
> > +	    (1 << ucmd->log_sq_bb_count) > dev->dev->caps.max_wqes	 ||
> 
> Surely this should use check_shl_overflow() ?
> 

Same for the other one I sent.  I'll resend in a couple days.  No rush.

regards,
dan carpenter

