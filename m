Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB47E11B5
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 07:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfJWFex (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 01:34:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50362 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfJWFex (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 01:34:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9N5Y6H7153211;
        Wed, 23 Oct 2019 05:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=5aEjsqX9BuK/GWVvLlTvAfi3v1Eaf3p4JOqZPpO23nw=;
 b=P+lUw9liUVlQs0DSoiTg3bgdDTi8eioDO0EnDUFDW++0HrDreuwMILpkdI1V1FI4ptHi
 Yd9Zt1Fg0CILIGi1fHOpmhyqA7RfhoNYjO1e1+aoSwSgxznKwIaWGH7vhZPEM1bQGF8g
 2MEOsYsk0gDzDfxEkPeH8cdeWxkxVxpL1DxsCw7HyJ8FzGA3QBR3pDbxULoaA+IX8a55
 98X/GMVhuuSt0P8Yk+RgWGz+n949LEAeUigh9e3sllDoT/7KJN3EjtRwJBwbl3cmdjqZ
 T9WiViQNoTyLQC+T/D0THuY9mQzpX1vDIb6lrQEWAzCub4Hwq+RG0rqrKztOHSVmNB8s tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vqu4qtnhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 05:34:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9N5YYE0118200;
        Wed, 23 Oct 2019 05:34:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vt2hej6md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 05:34:42 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9N5XVud003371;
        Wed, 23 Oct 2019 05:33:32 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 22:33:31 -0700
Date:   Wed, 23 Oct 2019 08:33:26 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, bharat@chelsio.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] iw_cxgb3: Remove the iw_cxgb3 provider code
Message-ID: <20191023053307.GA4907@lap1>
References: <20191022174710.12758-1-yuval.shaia@oracle.com>
 <ba91bb6c42e18e72cd6eaa705067a9cb30a02853.camel@redhat.com>
 <20191022175821.GB23952@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022175821.GB23952@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910230054
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 02:58:21PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 22, 2019 at 01:57:18PM -0400, Doug Ledford wrote:
> > On Tue, 2019-10-22 at 20:47 +0300, Yuval Shaia wrote:
> > > diff --git a/kernel-headers/rdma/rdma_user_ioctl_cmds.h b/kernel-
> > > headers/rdma/rdma_user_ioctl_cmds.h
> > > index b8bb285f..b2680051 100644
> > > +++ b/kernel-headers/rdma/rdma_user_ioctl_cmds.h
> > > @@ -88,7 +88,6 @@ enum rdma_driver_id {
> > >         RDMA_DRIVER_UNKNOWN,
> > >         RDMA_DRIVER_MLX5,
> > >         RDMA_DRIVER_MLX4,
> > > -       RDMA_DRIVER_CXGB3,
> > >         RDMA_DRIVER_CXGB4,
> > >         RDMA_DRIVER_MTHCA,
> > >         RDMA_DRIVER_BNXT_RE,
> > 
> > This is the same bug the kernel patch had.  We can't change that enum.
> 
> This patch shouldn't touch the kernel headers, delete the driver, then
> we will get the kernel header changes on the next resync.

Will the resync also delete the file rdma/cxgb3-abi.h?

> 
> Jason
> 
