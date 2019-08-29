Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C9CA1266
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2019 09:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfH2HNp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Aug 2019 03:13:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42654 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2HNo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Aug 2019 03:13:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7T78vj8111354;
        Thu, 29 Aug 2019 07:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=diKMxoXhC0X0aiYXZ1e+L4ZndxdFHw7IHHrWXgxrw4E=;
 b=LuDOIuuL2DU9i305Lr0zwWscoEo3G3zJwdF+aJPuXjNGRTu5L+MoZL8THdS1HWedJbrw
 7tp7h4DXK3FY3C8MYhdfXLGU9WaVrZfYJrMqlRRZxu9bMFu2/z4W9m1AMbiifHuZ4WPQ
 zqhqz0t4KhnUht/dVzBkscXQvFVRrFTtLQMqol4LO1hwaRuA8K15kdqQPfY2jhgrNuUQ
 Lmfw2kg9/K/pNT+Z3zEKF9Rk9yUym4wWCDgR01w1fA1bJUnwykw5IhssKvKHOdduh2mZ
 ZHx/iLKBF/lQH2ECCprq2lrPLCFhy1Y6ZsFXi1JKeTmhd7NpBy8M93SJ1g/FdSBcYCVi Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2up9x6r3gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 07:13:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7T7D76W184357;
        Thu, 29 Aug 2019 07:13:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2unvtygbqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 07:13:13 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7T7DBWK021505;
        Thu, 29 Aug 2019 07:13:11 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Aug 2019 00:13:10 -0700
Date:   Thu, 29 Aug 2019 10:13:03 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "oulijun@huawei.com" <oulijun@huawei.com>,
        "xavier.huwei@huawei.com" <xavier.huwei@huawei.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Israel Rukshin <israelr@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        Erez Alfasi <ereza@mellanox.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "srabinov7@gmail.com" <srabinov7@gmail.com>,
        "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH v1 5/5] RDMA/nldev: ib_pd can be pointed by multiple
 ib_ucontext
Message-ID: <20190829071303.GA3339@lap1>
References: <20190828091533.3129-1-yuval.shaia@oracle.com>
 <20190828091533.3129-6-yuval.shaia@oracle.com>
 <20190828135307.GH914@mellanox.com>
 <20190828185645.GA4799@lap1>
 <20190828192818.GR914@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828192818.GR914@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908290079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908290078
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 28, 2019 at 07:28:23PM +0000, Jason Gunthorpe wrote:
> On Wed, Aug 28, 2019 at 09:56:46PM +0300, Yuval Shaia wrote:
> > On Wed, Aug 28, 2019 at 01:53:12PM +0000, Jason Gunthorpe wrote:
> > > On Wed, Aug 28, 2019 at 12:15:33PM +0300, Yuval Shaia wrote:
> > > >  static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
> > > >  			     struct rdma_restrack_entry *res, uint32_t port)
> > > >  {
> > > >  	struct ib_pd *pd = container_of(res, struct ib_pd, res);
> > > >  	struct ib_device *dev = pd->device;
> > > > +	struct nlattr *table_attr = NULL;
> > > > +	struct nlattr *entry_attr = NULL;
> > > > +	struct context_id *ctx_id;
> > > > +	struct context_id *tmp;
> > > > +	LIST_HEAD(pd_context_ids);
> > > > +	int ctx_count = 0;
> > > >  
> > > >  	if (has_cap_net_admin) {
> > > >  		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY,
> > > > @@ -633,10 +709,38 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
> > > >  	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, res->id))
> > > >  		goto err;
> > > >  
> > > > -	if (!rdma_is_kernel_res(res) &&
> > > > -	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> > > > -			pd->uobject->context->res.id))
> > > > -		goto err;
> > > 
> > > How do earlier patches compile?
> > 
> > They did not
> 
> That is not OK

Sorry, i probably misunderstood you, what patches are you referring to?

> 
> Jason
