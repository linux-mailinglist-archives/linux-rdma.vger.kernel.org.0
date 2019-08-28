Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D1A0A12
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 20:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfH1S51 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 14:57:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46642 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfH1S51 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Aug 2019 14:57:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SIsEAr149716;
        Wed, 28 Aug 2019 18:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=tnAx5aTiWrBSJPE6YoUpnKBoxIq8DKshBaGqp5JxstQ=;
 b=MwKnHX0YXWVSCFmR/AMi5QDSjZ4BJdaxzHE0nBUQ2bg0q8mOv83TYI84EoJqx8wAyXYi
 XR2NE7mptII6uDUBHKBOHQTcrustg1tEo/1GHjwBZbFGy8WuoGJLN0AJRKvzDOBD4YU4
 nkXKH98OjrJ2eC+J2zMM9hper4TDzpHBi1ToMfYA+Uu6D7S6opfWXtv6Nq4ffJepxRaz
 9W6RiAayAHzQYh/EkxnRuSueYsgqeCa1CVVRdEzMGT7bOb/oU24OyVFkkgh3g5pUw1+8
 34DzjPdOXPRnjZp7iAVJ4f9hTvP/ugBumxONQ0zlWTP/FUuVghXIEt+ouOWbNlJaEQyB 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2uny3903x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 18:56:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SIr0fA173991;
        Wed, 28 Aug 2019 18:56:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2unduq9vbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 18:56:54 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7SIur6r030386;
        Wed, 28 Aug 2019 18:56:53 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 11:56:53 -0700
Date:   Wed, 28 Aug 2019 21:56:46 +0300
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
Message-ID: <20190828185645.GA4799@lap1>
References: <20190828091533.3129-1-yuval.shaia@oracle.com>
 <20190828091533.3129-6-yuval.shaia@oracle.com>
 <20190828135307.GH914@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828135307.GH914@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280184
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280184
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 28, 2019 at 01:53:12PM +0000, Jason Gunthorpe wrote:
> On Wed, Aug 28, 2019 at 12:15:33PM +0300, Yuval Shaia wrote:
> >  static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
> >  			     struct rdma_restrack_entry *res, uint32_t port)
> >  {
> >  	struct ib_pd *pd = container_of(res, struct ib_pd, res);
> >  	struct ib_device *dev = pd->device;
> > +	struct nlattr *table_attr = NULL;
> > +	struct nlattr *entry_attr = NULL;
> > +	struct context_id *ctx_id;
> > +	struct context_id *tmp;
> > +	LIST_HEAD(pd_context_ids);
> > +	int ctx_count = 0;
> >  
> >  	if (has_cap_net_admin) {
> >  		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY,
> > @@ -633,10 +709,38 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
> >  	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, res->id))
> >  		goto err;
> >  
> > -	if (!rdma_is_kernel_res(res) &&
> > -	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> > -			pd->uobject->context->res.id))
> > -		goto err;
> 
> How do earlier patches compile?

They did not

> 
> Jason
