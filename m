Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE156C220
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 22:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfGQUbx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 16:31:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33108 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfGQUbw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 16:31:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HKOOTf009465;
        Wed, 17 Jul 2019 20:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=nrjYHPQfo4VSSrdGXiSULUAL24mws17NKKMNMoXB65s=;
 b=pDB/ad3ABHUKxlPel5jXdz2p32NSDfKXyDpH5Hjcb28j5DtZWkb5EP/IqHewTXkGhs0q
 WGjUaLTebBA6IRl6LWU9YN34P6aXASuq3KH6fbXPAFXHMS82zNRemkRKwxDjvB5rAXBe
 FtfIyMgVp1xxZaQeCEhb2xMFt3E3qrTOoCmCV6xT1VfhAndUBXRMvVWpOXfTbB4mqiHn
 a1Vx58Q43ocxQQEqYJvlXmDN6FONVi3i+k89ZEXbOVBMtIL0vJB79FS+ooVvdWIwbCZ9
 hC9ew2ly66bkHkN85vpsAi0cPxBsaNlq6cB6Sxpg/EDXGNNqJ85x3XxGY3HrhJp9q7jm yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tq7xr5396-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 20:31:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HKSSp1175186;
        Wed, 17 Jul 2019 20:31:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tsmccmjy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 20:31:23 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6HKVKw3010262;
        Wed, 17 Jul 2019 20:31:20 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 20:31:20 +0000
Date:   Wed, 17 Jul 2019 23:31:12 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Shamir Rabinovitch <srabinov7@gmail.com>, dledford@redhat.com,
        leon@kernel.org, monis@mellanox.com, parav@mellanox.com,
        danielj@mellanox.com, kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, johannes.berg@intel.com,
        willy@infradead.org, michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 08/25] IB/uverbs: ufile must be freed only when not used
 anymore
Message-ID: <20190717203112.GA7307@lap1>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190716181200.4239-9-srabinov7@gmail.com>
 <20190717115354.GC12119@ziepe.ca>
 <20190717192525.GA2515@shamir-ThinkPad-X240>
 <20190717193313.GN12119@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717193313.GN12119@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=884
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170231
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=936 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170231
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 17, 2019 at 04:33:13PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 17, 2019 at 10:25:25PM +0300, Shamir Rabinovitch wrote:
> > On Wed, Jul 17, 2019 at 08:53:54AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jul 16, 2019 at 09:11:43PM +0300, Shamir Rabinovitch wrote:
> > > > From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > > > 
> > > > ufile (&ucontext) with the process who own them must not be released
> > > > when there are other ufile (&ucontext) that depens at them.
> > > 
> > > We already have a kref, why do we need more? Especially wrongly done
> > > refcounts with atomics?
> > 
> > Yes. Will fix in v2.
> > 
> > > 
> > > Trying to sequence the destroy of the ucontext seems inherently wrong
> > > to me. If the driver has to link the PD/MR to data in the ucontext it
> > > can't support sharing.
> > 
> > The issue we try to solve here is this:
> > 
> > [process 1]                     [process 2]
> > - alloc mr & point mr to        -
> >   context 1                     
> > - share context                 -
> > -                               - import mr
> > - exit                          -
> > -                               - exit
> > -                               -- ufile_destroy_ucontext
> > -                               --- driver dereg_mr is called
> > -                               ---- ib_umem_release on umem from
> >                                      previously destroyed context 1
> 
> Like I said, drivers that require the creating ucontext as part of the
> PD and MR cannot support sharing.

Even if we can make sure the process that creates the MR stays alive until
all reference to this MR completes?

> 
> > > > +	int wait;
> > > > +
> > > > +	if (ufile->parent) {
> > > > +		pr_debug("%s: release parent ufile. ufile %p parent %p\n",
> > > > +			 __func__, ufile, ufile->parent);
> > > > +		if (atomic_dec_and_test(&ufile->parent->refcount))
> > > > +			complete(&ufile->parent->context_released);
> > > > +	}
> > > > +
> > > > +	if (!atomic_dec_and_test(&ufile->refcount)) {
> > > > +wait:
> > > > +		wait = wait_for_completion_interruptible_timeout(
> > > > +			&ufile->context_released, 3*HZ);
> > > > +		if (wait == -ERESTARTSYS) {
> > > > +			WARN_ONCE(1,
> > > > +			"signal while waiting for context release! ufile %p\n",
> > > > +				ufile);
> > > 
> > > ????
> > > 
> > > Jason
> > 
> > I copied the behaviour I saw in the rest of the kernel as for what to do
> > when wait_for_completion_interruptible_timeout exit due to interrupt.
> 
> It doesn't really make sense here, we can't block release() like this
> 
> Jason
