Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D07E11D5
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 07:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbfJWFrm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 01:47:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37664 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbfJWFrl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 01:47:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9N5ihQj179639;
        Wed, 23 Oct 2019 05:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=9kTjEb4WtrXxgdit441jU3EuutMpGLHwQECBRXOJTHQ=;
 b=Fn2ATc6FNJFEHUHzpztk+zroUBBPSs7D3PlEyszn6w+82Og/vrxS1zqxsuCy+z0+UGwb
 QZPc0r33/HNooWUTGEsNnVUbCmyYgwQch70MCuBp5Gi573zL21Vn0HhZwEGHus+bbW0w
 WUZ1fiIC4bu6IBgj/mCrcGxWPP6TUq13XtkevM668UVFQ+c2HP8NxpaQ6MvevHfpHgE0
 EYVezMDt1ZvAFaIRNG3ZeA1eixqZutB6J8F/inhRD/+xD4K/pPrLjg9WqoclWmcMqFhe
 tAS6sh5Ad4EYTiBK9zenpps9F/JSafT4Dpz+Acw6dDPy0lKlVdwz8a9obGqdXTJa1Ba5 Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vqswtjyfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 05:47:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9N5gYvd002612;
        Wed, 23 Oct 2019 05:47:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vsx24ar1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 05:47:25 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9N5lNox009788;
        Wed, 23 Oct 2019 05:47:24 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 22:47:23 -0700
Date:   Wed, 23 Oct 2019 08:47:19 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Doug Ledford <dledford@redhat.com>
Cc:     bharat@chelsio.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] iw_cxgb3: Remove the iw_cxgb3 provider code
Message-ID: <20191023054703.GA5060@lap1>
References: <20191022174710.12758-1-yuval.shaia@oracle.com>
 <ba91bb6c42e18e72cd6eaa705067a9cb30a02853.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba91bb6c42e18e72cd6eaa705067a9cb30a02853.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910230056
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 01:57:18PM -0400, Doug Ledford wrote:
> On Tue, 2019-10-22 at 20:47 +0300, Yuval Shaia wrote:
> > diff --git a/kernel-headers/rdma/rdma_user_ioctl_cmds.h b/kernel-
> > headers/rdma/rdma_user_ioctl_cmds.h
> > index b8bb285f..b2680051 100644
> > --- a/kernel-headers/rdma/rdma_user_ioctl_cmds.h
> > +++ b/kernel-headers/rdma/rdma_user_ioctl_cmds.h
> > @@ -88,7 +88,6 @@ enum rdma_driver_id {
> >         RDMA_DRIVER_UNKNOWN,
> >         RDMA_DRIVER_MLX5,
> >         RDMA_DRIVER_MLX4,
> > -       RDMA_DRIVER_CXGB3,
> >         RDMA_DRIVER_CXGB4,
> >         RDMA_DRIVER_MTHCA,
> >         RDMA_DRIVER_BNXT_RE,
> 
> This is the same bug the kernel patch had.  We can't change that enum.

Yeah, but user-space should be in-sync with this bug :)

> 
> -- 
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


