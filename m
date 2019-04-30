Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12ABDFEA8
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 19:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfD3RRS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 13:17:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37524 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfD3RRR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 13:17:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UH4FwP003846;
        Tue, 30 Apr 2019 17:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=YCvAXQQY1/RYFeen1yHy0EWWZQl2k3jibJKenif4IWk=;
 b=C6C+KxHRLNuKoYz9vV6GyXwrDJ5HS/peF9RF+fYLCMG0u088X9sb+n9k36o08svxhIPp
 YbDecGp3XSDLLqCPsaP5izOxO15EXRYgZk7tkhaGwRnSyw2u3xdQ1gDcu5bteG1VPIzT
 Nc/nP59okv0atFK+hf0IFuu0XKkOEH0otSt/3H49hoOfeVK9Gkr/T+ky8d2ciOilEhLt
 mRYVHdDc4UViDeb+8TmYQubx1j9luv21SoKZFEVj7NZiEIuzuNYNgqKcabDeSYmhxRVV
 ISnvOdFBw1wdmDYb1h6+dZqVfqz5xJARDezgOGXn2PWFK/rkXzedRGvzgA1zMBH4ZA+e GQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2s5j5u2mvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 17:16:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UHGgbF007102;
        Tue, 30 Apr 2019 17:16:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2s4d4an35x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 17:16:42 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3UHGgRJ015187;
        Tue, 30 Apr 2019 17:16:42 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 10:16:41 -0700
Date:   Tue, 30 Apr 2019 20:16:37 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, Cornelia Huck <cohuck@redhat.com>,
        mst@redhat.com, linux-rdma@vger.kernel.org, qemu-devel@nongnu.org,
        virtualization@lists.linux-foundation.org, jgg@mellanox.com
Subject: Re: [Qemu-devel] [RFC 0/3] VirtIO RDMA
Message-ID: <20190430171635.GA2937@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
 <20190411190215.2163572e.cohuck@redhat.com>
 <20190415103546.GA6854@lap1>
 <e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
 <20190422060034.GA27901@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422060034.GA27901@mtr-leonro.mtl.com>
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

On Mon, Apr 22, 2019 at 09:00:34AM +0300, Leon Romanovsky wrote:
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
> > guest). So while one would need to be prepared to support quite some QPs,
> > the expectation is that the actual number of QPs used will be rather low.
> > In a similar vein, multiplexing QPs would be defeating the purpose, as the
> > overall idea was to have _independent_ QPs to enhance parallelism.
> >
> > > > > Expectations from this posting:
> > > > > In general, any comment is welcome, starting from hey, drop this as it is a
> > > > > very bad idea, to yeah, go ahead, we really want it.
> > > > > Idea here is that since it is not a minor effort i first want to know if
> > > > > there is some sort interest in the community for such device.
> > > >
> > > > My first reaction is: Sounds sensible, but it would be good to have a
> > > > spec for this :)
> > > >
> > > > You'll need a spec if you want this to go forward anyway, so at least a
> > > > sketch would be good to answer questions such as how many virtqueues
> > > > you use for which purpose, what is actually put on the virtqueues,
> > > > whether there are negotiable features, and what the expectations for
> > > > the device and the driver are. It also makes it easier to understand
> > > > how this is supposed to work in practice.
> > > >
> > > > If folks agree that this sounds useful, the next step would be to
> > > > reserve an id for the device type.
> > >
> > > Thanks for the tips, will sure do that, it is that first i wanted to make
> > > sure there is a use case here.
> > >
> > > Waiting for any feedback from the community.
> > >
> > I really do like the ides; in fact, it saved me from coding a similar thing
> > myself :-)
> >
> > However, I'm still curious about the overall intent of this driver. Where
> > would the I/O be routed _to_ ?
> > It's nice that we have a virtualized driver, but this driver is
> > intended to do I/O (even if it doesn't _do_ any I/O ATM :-)
> > And this I/O needs to be send to (and possibly received from)
> > something.
> >
> > So what exactly is this something?
> > An existing piece of HW on the host?
> > If so, wouldn't it be more efficient to use vfio, either by using SR-IOV or
> > by using virtio-mdev?
> >
> > Another guest?
> > If so, how would we route the I/O from one guest to the other?
> > Shared memory? Implementing a full-blown RDMA switch in qemu?
> >
> > Oh, and I would _love_ to have a discussion about this at KVM Forum.
> > Maybe I'll manage to whip up guest-to-guest RDMA connection using ivshmem
> > ... let's see.
> 
> Following success in previous years to transfer ideas into code,
> we started to prepare RDMA miniconference in LPC 2019, which will
> be co-located with Kernel Summit and networking track.
> 
> I'm confident that such broad audience of kernel developers
> will be good fit for such discussion.

Just posted a proposal for a talk at Linux Plumbers.

> 
> Previous years:
> 2016: https://www.spinics.net/lists/linux-rdma/msg43074.html
> 2017: https://lwn.net/Articles/734163/
> 2018: It was so full in audience and intensive that I failed to
> summarize it :(
> 
> Thanks
> 
> >
> > Cheers,
> >
> > Hannes
> > --
> > Dr. Hannes Reinecke            Teamlead Storage & Networking
> > hare@suse.de                              +49 911 74053 688
> > SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N??rnberg
> > GF: Felix Imend??rffer, Mary Higgins, Sri Rasiah
> > HRB 21284 (AG N??rnberg)
