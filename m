Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD80FFE9C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 19:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfD3ROX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 13:14:23 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42672 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3ROX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 13:14:23 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UH4rsl014697;
        Tue, 30 Apr 2019 17:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=DQTNZZhsQKt4voEepoJ9Y47rLJgWfSsZm28VVRxKQ1E=;
 b=ri6QmJVwL/vr3a9gKu6Qasq3OYCj9svwQNWW60yA+aUylSbPzGjGFIn3b7xDc2TJrq0C
 AddJDwzWN2Cegw0rJrINuTMIod7gXnL8AjezRBCjXLo2NvohkgSGJ05R8+WdewEOpxpz
 CvVNuJAtEU2Hq6U2sY6BbGoDr2AXkj8w5sIwaeeUq5rePxxGvqseDV/vR3Vc+IZoPBzL
 56SAlAPdzBaxV9yUmM4IRarVSbdQx3t3ORh5zL8D+Sc8WwPMikRicnSLF1/unzPW1rM2
 j7lq0czU1fRutnUPFJGdYRER3E90k1Pi390tpr/VPU77BXdEKkRIWhfhqC7FPiUTdCTl OA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2s4ckde5n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 17:14:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UHDalr186532;
        Tue, 30 Apr 2019 17:14:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2s4yy9nxh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 17:14:00 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3UHDxkl013605;
        Tue, 30 Apr 2019 17:13:59 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 10:13:58 -0700
Date:   Tue, 30 Apr 2019 20:13:54 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hannes Reinecke <hare@suse.de>, Cornelia Huck <cohuck@redhat.com>,
        mst@redhat.com, linux-rdma@vger.kernel.org, qemu-devel@nongnu.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [Qemu-devel] [RFC 0/3] VirtIO RDMA
Message-ID: <20190430171350.GA2763@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
 <20190411190215.2163572e.cohuck@redhat.com>
 <20190415103546.GA6854@lap1>
 <e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
 <20190422164527.GF21588@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422164527.GF21588@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300104
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300104
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 22, 2019 at 01:45:27PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 19, 2019 at 01:16:06PM +0200, Hannes Reinecke wrote:
> > On 4/15/19 12:35 PM, Yuval Shaia wrote:
> > > On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
> > > > On Thu, 11 Apr 2019 14:01:54 +0300
> > > > Yuval Shaia <yuval.shaia@oracle.com> wrote:
> > > > 
> > > > > Data center backends use more and more RDMA or RoCE devices and more and
> > > > > more software runs in virtualized environment.
> > > > > There is a need for a standard to enable RDMA/RoCE on Virtual Machines.
> > > > > 
> > > > > Virtio is the optimal solution since is the de-facto para-virtualizaton
> > > > > technology and also because the Virtio specification
> > > > > allows Hardware Vendors to support Virtio protocol natively in order to
> > > > > achieve bare metal performance.
> > > > > 
> > > > > This RFC is an effort to addresses challenges in defining the RDMA/RoCE
> > > > > Virtio Specification and a look forward on possible implementation
> > > > > techniques.
> > > > > 
> > > > > Open issues/Todo list:
> > > > > List is huge, this is only start point of the project.
> > > > > Anyway, here is one example of item in the list:
> > > > > - Multi VirtQ: Every QP has two rings and every CQ has one. This means that
> > > > >    in order to support for example 32K QPs we will need 64K VirtQ. Not sure
> > > > >    that this is reasonable so one option is to have one for all and
> > > > >    multiplex the traffic on it. This is not good approach as by design it
> > > > >    introducing an optional starvation. Another approach would be multi
> > > > >    queues and round-robin (for example) between them.
> > > > > 
> > Typically there will be a one-to-one mapping between QPs and CPUs (on the
> > guest). 
> 
> Er we are really overloading words here.. The typical expectation is
> that a 'RDMA QP' will have thousands and thousands of instances on a
> system.
> 
> Most likely I think mapping 1:1 a virtio queue to a 'RDMA QP, CQ, SRQ,
> etc' is a bad idea...

We have three options, no virtqueue for QP, 1 to 1 or multiplexing. What
would be your vote on that?
I think you are for option #1, right? but in this case there is actually no
use of having a virtio-driver, isn't it?

> 
> > However, I'm still curious about the overall intent of this driver. Where
> > would the I/O be routed _to_ ?
> > It's nice that we have a virtualized driver, but this driver is
> > intended to do I/O (even if it doesn't _do_ any I/O ATM :-)
> > And this I/O needs to be send to (and possibly received from)
> > something.
> 
> As yet I have never heard of public RDMA HW that could be coupled to a
> virtio scheme. All HW defines their own queue ring buffer formats
> without standardization.

With virtio it is the time to have a standard, do you agree?

> 
> > If so, wouldn't it be more efficient to use vfio, either by using SR-IOV or
> > by using virtio-mdev?
> 
> Using PCI pass through means the guest has to have drivers for the
> device. A generic, perhaps slower, virtio path has some appeal in some
> cases.

From experience we have with other emulated device the gap is getting lower
as the message size getting higher. So for example with message of size 2M
the emulated device gives close to line rate performances.

> 
> > If so, how would we route the I/O from one guest to the other?
> > Shared memory? Implementing a full-blown RDMA switch in qemu?
> 
> RoCE rides over the existing ethernet switching layer quemu plugs
> into
> 
> So if you built a shared memory, local host only, virtio-rdma then
> you'd probably run through the ethernet switch upon connection
> establishment to match the participating VMs.

Or you may use an enhanced rxe device, which bypass the Ethernet and
perform fast copy, as backend device for the virtio-rdma emulated device.

> 
> Jason
