Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C13A32F22
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2019 14:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfFCMBE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jun 2019 08:01:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47478 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFCMBE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jun 2019 08:01:04 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x53BnL8D027013;
        Mon, 3 Jun 2019 12:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Pjl5egAD8lcOJCA5X//w3d4b5oNsnOO0ptH3+DJjiUY=;
 b=PTjNJgcC8LvRwDt1p8g+QOvRbKUOd1T56nwPvGeOB+hTbuo9u31hqxWBeSDAPsioFcR2
 jegJ+6zR0EXsCgMnSlZ5oaMH71PxvcQzUpnKhcAEyI98dEHOl7ndicN/15MGHm/GqCQz
 ROHmJ5UgApnsdf7HmXYDuzBaGa+DQYc1FUfPtT6Rt4BQZIP/ob/t7OmHLybuX41vy8je
 FwSUoY6Te+l3CyXkR+OrEIRYsqMWgBIJ8zMTop/83BnCeW+ovrNXNJo0S+JNPQDr3uyR
 UvTsUrgC0mdWSFI7raFVHBegh3naLiimjoIKE7I/WxEtAbRksyxUOsKfsHwkfNoH/bCp NQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2suevd6nnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jun 2019 12:00:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x53Bwavk030593;
        Mon, 3 Jun 2019 12:00:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2sv36s65mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jun 2019 12:00:14 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x53C0AJP018619;
        Mon, 3 Jun 2019 12:00:10 GMT
Received: from srabinov-laptop (/109.186.248.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Jun 2019 05:00:09 -0700
Date:   Mon, 3 Jun 2019 15:00:01 +0300
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Gal Pressman <galpress@amazon.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Erez Alfasi <ereza@mellanox.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH for-next v2 4/4] IB/{core,hw}: ib_pd should not have
 ib_uobject pointer
Message-ID: <20190603120000.GA31289@srabinov-laptop>
References: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
 <20190520075333.6002-5-shamir.rabinovitch@oracle.com>
 <20190522002237.GB30833@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522002237.GB30833@mellanox.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9276 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906030087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9276 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906030087
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 12:22:42AM +0000, Jason Gunthorpe wrote:
> On Mon, May 20, 2019 at 10:53:21AM +0300, Shamir Rabinovitch wrote:
> > future patches will add the ability to share ib_pd across multiple
> > ib_ucontext. given that, ib_pd will be pointed by 1 or more ib_uobject.
> > thus, having ib_uobject pointer in ib_pd is incorrect.
> > 
> > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > ---
> >  drivers/infiniband/core/uverbs_cmd.c       | 1 -
> >  drivers/infiniband/core/verbs.c            | 1 -
> >  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 -
> >  drivers/infiniband/hw/mlx5/main.c          | 1 -
> >  drivers/infiniband/hw/mthca/mthca_qp.c     | 3 ++-
> >  include/rdma/ib_verbs.h                    | 1 -
> >  6 files changed, 2 insertions(+), 6 deletions(-)
> 
> Please remove the uobject from the mr as well, those are the two
> objects I want to see be sharable to start.
> 
> Jason

Jason would it be OK to progress with PD first and later come back to
MR? 

Can we finish to review/merge the PD clean up ? 

Thanks
