Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC6FF47
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 20:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfD3SFL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 14:05:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56776 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfD3SFK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 14:05:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UI4Ovt053896;
        Tue, 30 Apr 2019 18:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=TxQklnkm9kRNAQfwmkU+bMxLgo6wSlClB1L737Y7nlY=;
 b=t821lhD82Ys2bDdel7+xAY8i6/MgRtnHtUzFFXIbuhugrquoianVVCAZhkxj5FYhN5Nz
 J+AsJN1GTGWGGDkETLpRXaiG9U4tu9iNyV+Tnzm3pdBBufWULsooFDro42e7c8kvuPyg
 SFmiAGn+hSxX0yxvc0CxG/W2VHI0CxB4MGDYv0TD7MqCy/RX06QjeLk9b0M9ltoIA2zJ
 rnVJtD8fGCJd0hKG6n2ukiX20Jn+7K9ZFxHWWqIouBIMyDyWJCE5R7gnzpIDf8h3UPoa
 i6YwQjtaspn39gjqXBKiND/TXwf6hIpqlSpRbTua01XHBwprExcvpuesLhq3oaaInvhE kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2s5j5u2vef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 18:04:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UI3bMC107273;
        Tue, 30 Apr 2019 18:04:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2s4yy9pn7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 18:04:23 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3UI4K5g000592;
        Tue, 30 Apr 2019 18:04:20 GMT
Received: from srabinov-laptop (/10.175.1.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 11:04:20 -0700
Date:   Tue, 30 Apr 2019 21:04:11 +0300
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Erez Alfasi <ereza@mellanox.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH for-next v1 4/4] IB/{core,hw}: ib_pd should not have
 ib_uobject pointer
Message-ID: <20190430180410.GA30695@srabinov-laptop>
References: <20190430142333.31063-1-shamir.rabinovitch@oracle.com>
 <20190430142333.31063-5-shamir.rabinovitch@oracle.com>
 <20190430171302.GK6705@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430171302.GK6705@mtr-leonro.mtl.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300109
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300109
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 08:13:02PM +0300, Leon Romanovsky wrote:
> On Tue, Apr 30, 2019 at 05:23:24PM +0300, Shamir Rabinovitch wrote:
> > future patches will add the ability to share ib_pd across multiple
> > ib_ucontext. given that, ib_pd will be pointed by 1 or more ib_uobject.
> > thus, having ib_uobject pointer in ib_pd is incorrect.
> >
> > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > ---
> >  drivers/infiniband/core/nldev.c            | 5 -----
> >  drivers/infiniband/core/uverbs_cmd.c       | 1 -
> >  drivers/infiniband/core/verbs.c            | 1 -
> >  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 -
> >  drivers/infiniband/hw/mlx5/main.c          | 1 -
> >  drivers/infiniband/hw/mthca/mthca_qp.c     | 3 ++-
> >  include/rdma/ib_verbs.h                    | 1 -
> >  7 files changed, 2 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > index bced945a456d..f8a325d8082c 100644
> > --- a/drivers/infiniband/core/nldev.c
> > +++ b/drivers/infiniband/core/nldev.c
> > @@ -606,11 +606,6 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
> >  	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, res->id))
> >  		goto err;
> >
> > -	if (!rdma_is_kernel_res(res) &&
> > -	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> > -			pd->uobject->context->res.id))
> > -		goto err;
> > -
> 
> Definitely not, in current code, PD is not shared and connected to ucontext,
> users need to continue to see it. There are multiple ways to return
> multiple contextes for shared PD:
> 1. Return multiple fill_res_pd_entry() for every shared PD, but with
> different context ID.
> 2. Create nested context ID and return list here.
> 
> Thanks

Hi Leon,

Why we drag the context into objects that do not need it? We already have
issue with objects that do need the context but at least we can drop this 
dependency from objects that do not need the context. 

What is the impact of removing this piece of the code and avoiding
such assumptions in the netlink for other ib_x objects?

Thanks
