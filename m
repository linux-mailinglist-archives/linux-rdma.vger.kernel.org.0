Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED51D979C
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 15:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgESNZd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 09:25:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54020 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgESNZd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 09:25:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JDNtiH110262;
        Tue, 19 May 2020 13:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=RoDhm/qf5JKz8sWHVAzXBZgQ0Mrj2SKDTSPETSyu448=;
 b=JpbJLkuMJ3TsXPJabr9mkP2/NTE2XtayDksbOaqiBAH/pUxHHeK3rFoGaEeAhdY1EeKN
 mvSJ3XE1ELCU4G8XdFXED2XXlMTISlGgyjvc4J0sVsX0kbp/oA1hQL7THNsq4BoOCdR0
 umEN7WNEi6gf626BXB3EQ4HQRhhdy/vcsJmmWR9V7f8Ynxm98M5Yi5R9uoCXbfb7wk8b
 YNkj3qEFuAczyjtCtoOKwejSENcEQeZDfKMAorw+5w7QuSzVFkA8Ul72/s++lRPcjpsS
 F8sGT6/i54JEMrkYGlUXM/2h7Q90U6/FD3eiu5blyvNPgAWTQdO0zeFKgS3fyOmQwFlS Wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3128tnd80j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 13:25:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JDIPGc135474;
        Tue, 19 May 2020 13:25:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 312t3y05nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 13:25:28 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04JDPQxi023515;
        Tue, 19 May 2020 13:25:26 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 May 2020 06:25:25 -0700
Date:   Tue, 19 May 2020 16:25:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs: Fix some signedness bugs in error handling
Message-ID: <20200519132519.GM2078@kadam>
References: <20200519120256.GC42765@mwanda>
 <CAMGffEkkUVV9b=iMhP4C=ndBRcePcTQMiF4h-Et1DFEKYPA6mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEkkUVV9b=iMhP4C=ndBRcePcTQMiF4h-Et1DFEKYPA6mg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 cotscore=-2147483648 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190120
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 02:40:41PM +0200, Jinpu Wang wrote:
> On Tue, May 19, 2020 at 2:05 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > The problem is that "req->sg_cnt" is an unsigned int so if "nr" is
> > negative, it gets type promoted to a high positive value and the
> > condition is false.  This patch fixes it by handling negatives separately.
> >
> > Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Thanks Dan, fix looks correct, just one comment inline.
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 +++----
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
> >  2 files changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 468fdd0d8713..17f99f0962d0 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -1047,11 +1047,10 @@ static int rtrs_map_sg_fr(struct rtrs_clt_io_req *req, size_t count)
> >
> >         /* Align the MR to a 4K page size to match the block virt boundary */
> >         nr = ib_map_mr_sg(req->mr, req->sglist, count, NULL, SZ_4K);
> > -       if (unlikely(nr < req->sg_cnt)) {
> > -               if (nr < 0)
> > -                       return nr;
> > +       if (nr < 0)
> > +               return -EINVAL;
> Why not just return nr here?

Sorry.  I thought I did but I made a typo.  Let me resend.

regards,
dan carpenter

