Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC126D5F7
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2019 22:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfGRUqh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jul 2019 16:46:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34830 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfGRUqh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Jul 2019 16:46:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6IKitA6171783;
        Thu, 18 Jul 2019 20:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=NWtIc3TG5r3EK+ajemBYsabYuRFJH2J4dvGtr1XztaA=;
 b=MBxrbOJzq9wtKHEqftFny/hyM/bns3mhZRt08uzUKtuZ53m8SalgSpABdfQLlnPpgYq5
 AjARUnKgBAlUqpC7UAU9lf056/9pRRtIm/Cg87QiKJkE6/d0LZueQ1LZUXxQf439w2o1
 qBvOEl2V22QQGU++AqxHprKESj51/O549qJ2wy+mlcT/CwxYnW+E2r4ri5slgdpasGQf
 cK88whxN1p0DOtO6yHZny3qEcp80tVRnnhF97eeq3K1+4BjVDlUNKwsEs5VIH5FIgDP1
 QE7W0YG2y1ypSK4WndA0kU27KRgF+mje3Dtwa9tgTsbeNJUlc+SEaOb97LvamSUYyP3F Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2tq7xrb4fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 20:46:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6IKgn5W174033;
        Thu, 18 Jul 2019 20:46:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ttc8ft3sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 20:46:04 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6IKk0SG006851;
        Thu, 18 Jul 2019 20:46:00 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Jul 2019 20:46:00 +0000
Date:   Thu, 18 Jul 2019 23:45:52 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>, dledford@redhat.com,
        leon@kernel.org, monis@mellanox.com, parav@mellanox.com,
        danielj@mellanox.com, kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, johannes.berg@intel.com,
        michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, linux-rdma@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 08/25] IB/uverbs: ufile must be freed only when not used
 anymore
Message-ID: <20190718204551.GA5043@lap1>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190716181200.4239-9-srabinov7@gmail.com>
 <20190717115354.GC12119@ziepe.ca>
 <20190717192525.GA2515@shamir-ThinkPad-X240>
 <20190717193313.GN12119@ziepe.ca>
 <20190717203112.GA7307@lap1>
 <20190717204505.GD32320@bombadil.infradead.org>
 <20190717213636.GA2797@lap1>
 <20190718121747.GB1667@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718121747.GB1667@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=744
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907180214
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=785 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907180214
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 18, 2019 at 09:17:47AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 18, 2019 at 12:36:37AM +0300, Yuval Shaia wrote:
> > On Wed, Jul 17, 2019 at 01:45:05PM -0700, Matthew Wilcox wrote:
> > > On Wed, Jul 17, 2019 at 11:31:12PM +0300, Yuval Shaia wrote:
> > > > On Wed, Jul 17, 2019 at 04:33:13PM -0300, Jason Gunthorpe wrote:
> > > > > Like I said, drivers that require the creating ucontext as part of the
> > > > > PD and MR cannot support sharing.
> > > > 
> > > > Even if we can make sure the process that creates the MR stays alive until
> > > > all reference to this MR completes?
> > > 
> > > The kernel can't rely on userspace to do that.
> > 
> > ok, how about this: we know that for MR to be shared the memory behinds it
> > should also be shared.
> > 
> > In this case, i know it sounds horrifying but do we care that the process
> > that originally created this MR exits? i.e. how about just before the
> > process leaves this world we will find some other ucontext to hold these
> > memory mappings that driver holds?
> > Or how about moving this mapping from ucontext pointed by ib_mr directly to
> > ib_mr?
> 
> What are you worrying about? My point is we don't need to *anything*
> if the driver objects for PD and MR don't rely on the ucontext. This
> appears to be the normal case.

but we saw that mlx4 (and i think also 5) do use the ucontext, i think to
undo umem_get stuff.

> 
> MRs already work fine if they outlive the creating process.

You mean if we leave the creating process alive?

> 
> Jason
