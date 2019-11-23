Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D80BF107F79
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Nov 2019 17:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKWQse (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Nov 2019 11:48:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54925 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726774AbfKWQsd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 23 Nov 2019 11:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574527711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eLPWyOtTVNP/KrO80vitNjy/SELWH691R8pfffz4ILg=;
        b=iVBJu/irLbtC25AkYoH4TQjm/1KGoZel2kSiH8BC9m8vfICBOrG/QFhaz9LCvZ8GNBiTLc
        0vw3/Lp0PDhRdOz3S+wREnLZriBdhJ/OMmIyPp6Bixi+wDhndErV+Xw0Ay3/TE0pZ9Ujdx
        33bQJ8utL26ic41BUqwoC9/36+Ct0II=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-k5UJ_IYUONqELCjAGOk8wg-1; Sat, 23 Nov 2019 11:48:28 -0500
Received: by mail-qk1-f199.google.com with SMTP id e23so2341554qka.23
        for <linux-rdma@vger.kernel.org>; Sat, 23 Nov 2019 08:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2bRgOjQ30nYth28kTRI3pLAoIa9qMQwI8LNk0CINp7I=;
        b=SmBBeTrbQp21BpvUYvwasHxQM/REGWvhOyV3Tj5jT5JwyWBq2n9x5b644wkvYqArbj
         B+5+ZMRG+YiNDjZv6fQgaRcAOS26nd5zkTTfEf0K9+YJhKXBtJIOTUQ7D1Xo+SNbG2Ik
         Psepj4RFXMlffeK8rtNUwxU7Kcu56ITsbcsWJsdYXthR6BM2012Y/UDHrkASMOdWITuJ
         xFlvFolGw/1x7TtCUMA5m9oPlj3Kb/KKH6FHZ0P2+bAv/hCKJtn+4E0XKDN5+MhOdd9u
         v8y7EyN9hn8kxPsujfzJMdophkeg9jGG15wMZwGmHTnMmmK9Nmn0PbHV4LYpRw05pAsA
         glhQ==
X-Gm-Message-State: APjAAAU3r+Po0XxGtOG0f1ZCSPI/wXRdxJ/RJQ/OQaQhAzAGh5lyf7N7
        M1k3ppwGRnjcV8vJEubaeRibwt+nfZHSo9noOtIDoV4tMSK3jCJgDWf0jYvnm0Yaa0CSwPDdSPq
        WinKgBArx72b4IK0+LlM7Nw==
X-Received: by 2002:ac8:2a42:: with SMTP id l2mr4836339qtl.64.1574527708356;
        Sat, 23 Nov 2019 08:48:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbpbqBZPtkdWfbagDcVH6cXBbuSfbc4EQYHtIK5WMKGHUWmD+/o0fMbaCBE/gsfJVaTHmdOQ==
X-Received: by 2002:ac8:2a42:: with SMTP id l2mr4836317qtl.64.1574527708140;
        Sat, 23 Nov 2019 08:48:28 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id a4sm616026qko.57.2019.11.23.08.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 08:48:26 -0800 (PST)
Date:   Sat, 23 Nov 2019 11:48:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Dave Ertman <david.m.ertman@intel.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, nhorman@redhat.com,
        sassmann@redhat.com, Kiran Patil <kiran.patil@intel.com>,
        Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [net-next v2 1/1] virtual-bus: Implementation of Virtual Bus
Message-ID: <20191123112015-mutt-send-email-mst@kernel.org>
References: <20191119191053-mutt-send-email-mst@kernel.org>
 <20191120014653.GR4991@ziepe.ca>
 <134058913.35624136.1574222360435.JavaMail.zimbra@redhat.com>
 <20191120133835.GC22515@ziepe.ca>
 <20191120102856.7e01e2e2@x1.home>
 <20191120181108.GJ22515@ziepe.ca>
 <20191120150732.2fffa141@x1.home>
 <20191121030357.GB16914@ziepe.ca>
 <5dcef4ab-feb5-d116-b2a9-50608784a054@redhat.com>
 <20191121141732.GB7448@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191121141732.GB7448@ziepe.ca>
X-MC-Unique: k5UJ_IYUONqELCjAGOk8wg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 21, 2019 at 10:17:32AM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 21, 2019 at 03:21:29PM +0800, Jason Wang wrote:
> > > The role of vfio has traditionally been around secure device
> > > assignment of a HW resource to a VM. I'm not totally clear on what th=
e
> > > role if mdev is seen to be, but all the mdev drivers in the tree seem
> > > to make 'and pass it to KVM' a big part of their description.
> > >=20
> > > So, looking at the virtio patches, I see some intended use is to map
> > > some BAR pages into the VM.
> >=20
> > Nope, at least not for the current stage. It still depends on the
> > virtio-net-pci emulatio in qemu to work. In the future, we will allow s=
uch
> > mapping only for dorbell.
>=20
> There has been a lot of emails today, but I think this is the main
> point I want to respond to.
>=20
> Using vfio when you don't even assign any part of the device BAR to
> the VM is, frankly, a gigantic misuse, IMHO.

That's something that should be fixed BTW.  Hardware supports this, so
it's possible, and VFIO should make it easy to add.
Does this put this comment to rest?


> Just needing userspace DMA is not, in any way, a justification to use
> vfio.
>=20
> We have extensive library interfaces in the kernel to do userspace DMA
> and subsystems like GPU and RDMA are full of example uses of this kind
> of stuff. Everything from on-device IOMMU to system IOMMU to PASID. If
> you find things missing then we need to improve those library
> interfaces, not further abuse VFIO.
>=20
> Further, I do not think it is wise to design the userspace ABI around
> a simplistict implementation that can't do BAR assignment,

This just should be added, IFC cna do BAR assignment.

> and can't
> support multiple virtio rings on single PCI function.

It can't support multiple virtio *devices* per function.  Sub functions
devices imho are not a must.  E.g. lots of people use SRIOV and are
quite happy.  So I don't see what is wrong with a device per function,
for starters.

> This stuff is
> clearly too premature.
>
> My advice is to proceed as a proper subsystem with your own chardev,
> own bus type, etc and maybe live in staging for a bit until 2-3
> drivers are implementing the ABI (or at the very least agreeing with),
> as is the typical process for Linux.
>=20
> Building a new kernel ABI is hard (this is why I advised to use a
> userspace driver). It has to go through the community process at the
> usual pace.
>=20
> Jason

--=20
MST

