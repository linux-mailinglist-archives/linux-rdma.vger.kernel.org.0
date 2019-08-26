Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 460D49CDAD
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 12:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfHZK7d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 06:59:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52932 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbfHZK7d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 06:59:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7QAwjvY015332;
        Mon, 26 Aug 2019 10:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=V0G53ym99LxckMoNCUMTP1RUHqskHsw1azgSKA/b2GY=;
 b=SX6s4nk3gAN/Up24Lt8UkDCr4NCQABvCn1Htf9qOaDQyRTfYnrx5QHvNyIrlSI0wv17j
 wuRL/pG7uuVQQ0v2nOWaGIueaUvV1pLRKu6rcxRyh4PqFS5mrXO5e76bb9nCqzpryAmB
 btmAGy3RBXU7BehQxRhA4Y2SCzX3WRyN+wBvdr0+RyuquQK5ZcnYB/yAPZymvLGCa+jJ
 xGgobXwCerC3Xmohq8B8Pxnj0zuke3o0c/pKVeA9hblh1MBuAr/+ykIDSx6UbEuWQuFI
 uSiFug88+wAmPUWy8OjGDyXNBv7O0Sehrn0XVzxtegQ9J9MAeK9ro+GqSsDS11dOgiGB ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ujw700aky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 10:59:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7QAvoni188087;
        Mon, 26 Aug 2019 10:59:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2ujw6hnqcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 10:59:00 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7QAwqE6029195;
        Mon, 26 Aug 2019 10:58:52 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Aug 2019 03:58:51 -0700
Date:   Mon, 26 Aug 2019 13:58:44 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 00/24] Shared PD and MR
Message-ID: <20190826105843.GG3698@lap1>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
 <20190822084102.GA2898@lap1>
 <20190822165841.GA17588@iweiny-DESK2.sc.intel.com>
 <20190822170309.GC8325@mellanox.com>
 <2807E5FD2F6FDA4886F6618EAC48510E898ADD18@CRSMSX102.amr.corp.intel.com>
 <20190823115731.GA12847@mellanox.com>
 <2807E5FD2F6FDA4886F6618EAC48510E898B2F17@CRSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E898B2F17@CRSMSX102.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908260122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908260123
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 23, 2019 at 09:33:06PM +0000, Weiny, Ira wrote:
> > Subject: Re: [PATCH v1 00/24] Shared PD and MR
> > 
> > On Thu, Aug 22, 2019 at 08:10:09PM +0000, Weiny, Ira wrote:
> > > > On Thu, Aug 22, 2019 at 09:58:42AM -0700, Ira Weiny wrote:
> > > >
> > > > > Add to your list "how does destruction of a MR in 1 process get
> > > > > communicated to the other?"  Does the 2nd process just get failed
> > WR's?
> > > >
> > > > IHMO a object that has been shared can no longer be asynchronously
> > destroyed.
> > > > That is the whole point. A lkey/rkey # alone is inherently unsafe
> > > > without also holding a refcount on the MR.
> > > >
> > > > > I have some of the same concerns as Doug WRT memory sharing.
> > FWIW
> > > > > I'm not sure that what SCM_RIGHTS is doing is safe or correct.
> > > > >
> > > > > For that work I'm really starting to think SCM_RIGHTS transfers
> > > > > should be blocked.
> > > >
> > > > That isn't possible, SCM_RIGHTS is just some special case, fork(),
> > > > exec(), etc all cause the same situation. Any solution that blocks those is a
> > total non-starter.
> > >
> > > Right, except in the case of fork(), exec() all of the file system
> > > references which may be pinned also get copied.
> > 
> > And what happens one one child of the fork closes the reference, or exec with
> > CLOEXEC causes it to no inherent?
> 
> Dave Chinner is suggesting the close will hang.  Exec with CLOEXEC would probably not because the RDMA close would release the pin allowing the close of the data file to finish...  At least as far as my testing has shown.
> 
> > 
> > It completely breaks the unix model to tie something to a process not to a
> > FD.
> 
> But that is just it.  Dave is advocating that the FD's must get transferred.  It has nothing to do with a process.
> 
> I'm somewhat confused at this point because in this thread I was advocating that the RDMA context FD is what needs to get "shared" between the processes.  Is that what you are advocating as well?  Does this patch set do that?

The IB context sharing mechanism is already exist. This patch-set purpose a
way of importing and maintaining the IBV objects of such shared IB context.

> 
> > 
> > > > Except for ODP, a MR doesn't reference the mm_struct. It references the
> > pages.
> > > > It is not unlike a memfd.
> > >
> > > I'm thinking of the owner_mm...  It is not like it is holding the
> > > entire process address space I know that.  But it is holding onto
> > > memory which Process A allocated.
> > 
> > It only hold the mm for some statistics accounting, it is really just holding
> > pages outside the mm.
> 
> But those pages aren't necessarily mapped in Process B.  and if they are mapped in Process A then you are sending data to Process A not "B"...  That is one twisted way to look at it anyway...
> 
> Ira
> 
