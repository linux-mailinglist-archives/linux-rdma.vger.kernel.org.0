Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90FA9A4987
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2019 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfIANLU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Sep 2019 09:11:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33400 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbfIANLU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Sep 2019 09:11:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x81D8jXC046237;
        Sun, 1 Sep 2019 13:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=l/ZQp9vj0JVMEroeDZ+glysxI+ThLE4C6MaMwhGGIoY=;
 b=KoRb68fFJMudBPrqhBs68dsDoXWDjcBqS5zh4ofmDb7bxVPFovsJSlwXlb3BGj7gpVqp
 lFnlGDrWp0MzJG6O/LNHwV3T45tts2XQaD1tX8Z+3V+e8AT9OoBSchbRIP7yCsZFPzoU
 ZydEKr1hkz5fwk04YGRJzo0DseiImbSwkSAPnqnzLHCtWcdQ4ERrW88fxGiJNOoZxAj6
 fLZ1mn3w1mAugkf07Ti3RDfx6IBI4XEDDVocvplxTnQjH0hcvv6E/2l/QCgaBKAAriy1
 0JnUs2sqHz7hOwUA7O7ZQd4Efmdw269Ntjjh52Kn3jiPOVPjkNejG/s61H1fM7Eo4nnO hQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ureg1g16r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Sep 2019 13:11:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x81D3WqM027467;
        Sun, 1 Sep 2019 13:11:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2uqgqjneg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Sep 2019 13:11:01 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x81DB0II005685;
        Sun, 1 Sep 2019 13:11:00 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Sep 2019 06:10:59 -0700
Date:   Sun, 1 Sep 2019 16:10:52 +0300
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
Message-ID: <20190901131052.GA19343@lap1>
References: <20190828091533.3129-1-yuval.shaia@oracle.com>
 <20190828091533.3129-6-yuval.shaia@oracle.com>
 <20190828135307.GH914@mellanox.com>
 <20190828185645.GA4799@lap1>
 <20190828192818.GR914@mellanox.com>
 <20190829071303.GA3339@lap1>
 <20190829142708.GD17101@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829142708.GD17101@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9366 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909010153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9366 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909010154
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 29, 2019 at 02:27:13PM +0000, Jason Gunthorpe wrote:
> On Thu, Aug 29, 2019 at 10:13:03AM +0300, Yuval Shaia wrote:
> > On Wed, Aug 28, 2019 at 07:28:23PM +0000, Jason Gunthorpe wrote:
> > > On Wed, Aug 28, 2019 at 09:56:46PM +0300, Yuval Shaia wrote:
> > > > On Wed, Aug 28, 2019 at 01:53:12PM +0000, Jason Gunthorpe wrote:
> > > > > On Wed, Aug 28, 2019 at 12:15:33PM +0300, Yuval Shaia wrote:
> > > > > >  static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
> > > > > >  			     struct rdma_restrack_entry *res, uint32_t port)
> > > > > >  {
> > > > > >  	struct ib_pd *pd = container_of(res, struct ib_pd, res);
> > > > > >  	struct ib_device *dev = pd->device;
> > > > > > +	struct nlattr *table_attr = NULL;
> > > > > > +	struct nlattr *entry_attr = NULL;
> > > > > > +	struct context_id *ctx_id;
> > > > > > +	struct context_id *tmp;
> > > > > > +	LIST_HEAD(pd_context_ids);
> > > > > > +	int ctx_count = 0;
> > > > > >  
> > > > > >  	if (has_cap_net_admin) {
> > > > > >  		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY,
> > > > > > @@ -633,10 +709,38 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
> > > > > >  	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, res->id))
> > > > > >  		goto err;
> > > > > >  
> > > > > > -	if (!rdma_is_kernel_res(res) &&
> > > > > > -	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> > > > > > -			pd->uobject->context->res.id))
> > > > > > -		goto err;
> > > > > 
> > > > > How do earlier patches compile?
> > > > 
> > > > They did not
> > > 
> > > That is not OK
> > 
> > Sorry, i probably misunderstood you, what patches are you referring to?
> 
> Just make sure every patch in the series compiles.

Ok got it.
Will change the order of the patches in the set and send v2.

> 
> Jason
