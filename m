Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F827D44B
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 06:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbfHAEHy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 00:07:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59718 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfHAEHy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Aug 2019 00:07:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7143V9n178171;
        Thu, 1 Aug 2019 04:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=pgie4vrxJgux7gM71BP1C8JaguwbPZ9rlpYc3xBJff0=;
 b=CZvCXxZo5JBcU7TK2/G2fkqTF+cXj95/MhyM0gYsBoDzElf1JMntThYBpQ7h0vAo8BLt
 ljCLN26vsRZkPRvonFjD6nUuqqmaWrAVpXjOI+41iZA8EN1CesthnHa8tV4I/iZbG6by
 mHKbdExh1l9tNst1O1rW4OUJtJdx9P5StrHIOj0I0HLjSNUObAhU7mPS6Ky3D+HwCe7r
 ffd95qyCC81fpKpLKsrzicjM6nTnQ3v5id/XBDk2UB8VgSOlIjff3DlzPn2orJNWbajM
 uh1yTmeCdQeMOzn8hbKJnwn6XPsD3d/b5yEpDmXcLe+C1cOGMgPwTyc04qcVDkcxebpM VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u0f8r8vk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Aug 2019 04:07:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7142scI004959;
        Thu, 1 Aug 2019 04:05:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2u349dhg1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Aug 2019 04:05:19 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7145HNw004627;
        Thu, 1 Aug 2019 04:05:17 GMT
Received: from lap1 (/49.145.126.232)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 21:05:16 -0700
Date:   Thu, 1 Aug 2019 07:05:05 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Shamir Rabinovitch <srabinov7@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>, dledford@redhat.com,
        leon@kernel.org, monis@mellanox.com, parav@mellanox.com,
        danielj@mellanox.com, kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, shamir.rabinovitch@oracle.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 00/25] Shared PD and MR
Message-ID: <20190801040504.GD2929@lap1>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190717050931.GA18936@infradead.org>
 <CA+KVoo7oSdpX2j1hRT1gPFFrxkHLBfcxXh4HaxkjjNKD550sYg@mail.gmail.com>
 <20190717115507.GD12119@ziepe.ca>
 <CA+KVoo5wVzUovQvAXyZzsA8rK9=FuMEkNJDDwJteXe9-eLFu3A@mail.gmail.com>
 <20190717235526.GB4936@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717235526.GB4936@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908010036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908010036
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 17, 2019 at 04:55:26PM -0700, Ira Weiny wrote:
> On Wed, Jul 17, 2019 at 04:35:30PM +0300, Shamir Rabinovitch wrote:
> > On Wed, Jul 17, 2019 at 2:55 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Wed, Jul 17, 2019 at 02:09:50PM +0300, Shamir Rabinovitch wrote:
> > > > On Wed, Jul 17, 2019 at 8:09 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > >
> > > > > On Tue, Jul 16, 2019 at 09:11:35PM +0300, Shamir Rabinovitch wrote:
> > > > > > Following patch-set introduce the shared object feature.
> > > > > >
> > > > > > A shared object feature allows one process to create HW objects (currently
> > > > > > PD and MR) so that a second process can import.
> > > > >
> > > > > That sounds like a major complication, so you'd better also explain
> > > > > the use case very well.
> > > >
> > > > The main use case was that there is a server that has giant shared
> > > > memory that is shared across many processes (lots of mtts).
> > > > Each process needs the same memory registration (lots of mrs that
> > > > register same memory).
> > > > In such scenario, the HCA runs out of mtts.
> > > > To solve this problem, an single memory registration is shared across
> > > > all the process in that server saving hca mtts.
> > >
> > > Well, why not just share the entire uverbs FD then? Once the PD is
> > > shared all security is lost anyhow..
> > >
> > > This is not the model that was explained to me last year
> > >
> > > Jason
> > 
> > We do share the whole uvrbs FD (context) with the second process and
> > let that process to instantiate the PD & MR from the shared FD.
> 
> Then the first (both) process(es) should have access to the MR right?

Yes.
(Please note that since we maintain refcount then the ib_mr object will be
destroyed only when the two will destroy it).

> 
> > The instantiation include creating new uobject in the second process
> > context that points to the same ib_x HW objects.
> > The second process does not own the shared context.
> > It just use it to get access to the shared ib_x objects and then it
> > mark those & shared FD as shared.
> 
> I'm not following this?

Shamir, correct me if i'm wrong here:
So there is one ib_mr object and two uobjects that "points" to it.

> 
> > 
> > What was the expectation from "import_from_xxx" ?
> 
> ... and I don't understand this question.

Shamir?

> 
> Ira
> 
