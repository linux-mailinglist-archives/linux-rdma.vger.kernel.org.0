Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC3D263C1
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 14:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfEVM01 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 08:26:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38880 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVM00 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 08:26:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4MCOHZv123090;
        Wed, 22 May 2019 12:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=GvghwfEY5poykxErLpBcT/nLLpWoTXLSTARTFZ5A8BA=;
 b=LyxxTKggrXYRVBMljI/jGqArtpoXJ6TFHX+A6M1OANjyfLw2YsOLTuEeKlsnfM+3flY/
 VhweDevqGga4j5XG1stl/qa1GQn0gsloqeCotzvndv4h9rZpLp6xgTtC0WR74eWBH6Z7
 UT6/CFcoL978+h+eaX+hrVTqAjtorstH09EL+UXgms4A1toZnzD7hzr4aWm1Dq/aIfzp
 YK2/Olm40WU87xg7dlFFtd46vXf0zXOTfS9OwT1NKThSG2G8VgS2qAyb+omflFbRVLPx
 DQoU8q84Gk8R8ZOeUo06fLY4iPNgl7/Km3Ew5amaK1XaQplHqeGyGKK9LS7negj8jBHA tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2smsk53ahr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 12:25:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4MCPg7b025628;
        Wed, 22 May 2019 12:25:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2smsgutmm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 12:25:42 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4MCPbSD021739;
        Wed, 22 May 2019 12:25:37 GMT
Received: from srabinov-laptop (/10.175.62.21)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 May 2019 12:25:37 +0000
Date:   Wed, 22 May 2019 15:25:32 +0300
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH for-next v2 3/4] RDMA/nldev: ib_pd can be pointed by
 multiple ib_ucontext
Message-ID: <20190522122531.GA6173@srabinov-laptop>
References: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
 <20190520075333.6002-4-shamir.rabinovitch@oracle.com>
 <20190520091840.GB4573@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520091840.GB4573@mtr-leonro.mtl.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905220091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905220091
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 12:18:40PM +0300, Leon Romanovsky wrote:
> On Mon, May 20, 2019 at 10:53:20AM +0300, Shamir Rabinovitch wrote:
> > In shared object model ib_pd can belong to 1 or more ib_ucontext.
> > Fix the nldev code so it could report multiple context ids.
> >
> > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > ---

[...]

> > +	if (!rdma_is_kernel_res(res)) {
> > +		pd_context(pd, &pd_context_ids);
> > +		list_for_each_entry(ctx_id, &pd_context_ids, list) {
> > +			if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> > +				ctx_id->id))
> 
> Did it work? You are overwriting RDMA_NLDEV_ATTR_RES_CTXN entry in the
> loop. You need to add RDMA_NLDEV_ATTR_RES_CTX and
> RDMA_NLDEV_ATTR_RES_CTX_ENTRY to include/uapi/rdma_netlink.h and
> open nested table here (inside of PD) with list of contexts.
> 
> > +				goto err;
> > +		}

Hi Leon,

Just to clarify the above nesting...

Do you expect the below NL attribute nesting in case of shared pd dump?

RDMA_NLDEV_ATTR_RES_CTX
	RDMA_NLDEV_ATTR_RES_CTX_ENTRY
		RDMA_NLDEV_ATTR_RES_CTXN #1
		RDMA_NLDEV_ATTR_RES_CTXN #2
		...
		RDMA_NLDEV_ATTR_RES_CTXN #N


I tried this and rdmatool reported:

[root@qemu-fc29 iproute2]# rdma/rdma res show pd dev mlx4_0
dev mlx4_0 pdn 0 local_dma_lkey 0x8000 users 4 comm [ib_core]
dev mlx4_0 pdn 1 local_dma_lkey 0x8000 users 4 comm [ib_core]
error: Operation not supported

Is this the expected behaviour from unmodified latest rdmatool?

Thanks
