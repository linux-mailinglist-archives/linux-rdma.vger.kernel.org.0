Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFF2510309F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 01:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKTAQg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 19:16:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46697 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727324AbfKTAQg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 19:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574208995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Ab41kp1XjjxVLY8i+Hks9bWT2aTG+H1xMaXg6cmt40=;
        b=euoDXZqFrxOKOWAed4IwyLAR9k0TlNF4aKu8irQN0IjRwG54TLeiqFbmiXW9XrmC4tx8zY
        sXO/8QtNacKZxA6e9IgNVon5YVW80u9uwvDz3VZG9t4hTy+3R6QXoHQA7IyZRaHc9DXvq1
        MJRxl3OCeqW+1HChSugzwraEuEHwmwE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-DCk8r_7FMXW88yfUbpsOtg-1; Tue, 19 Nov 2019 19:16:28 -0500
Received: by mail-wr1-f69.google.com with SMTP id q12so20182238wrr.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 16:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t06Tsi72ww7TuIa1C3fnMcRmbN5Hgd2Lx1VIhbta3sI=;
        b=rj8uWHt+QWG1R4X27Uo80qjmF0eXA3nCgieGev+umwWq3JE9uTzcd24bgrueNPfftC
         b6BeDZeNiofHILCeYk9KG9qLSO+xg5U25Vg+SINbOQZMhLpZxqK2d46qnH/Eu654rCL4
         qYC4ePh7KN/9dRO91k5rD1kFimy88uCT+q8jABn5ZIy4oZSdDlvKcL1P48vKk3eMdsnA
         c+3aabP87JAR3dTLIb/0Gu3/GclrKP262vrKwUYmViwxnzYlZC5JuGlJA+c136JBkp3T
         FCxjqNnfNT1y+2aTbq1j/MpYO7YgWEqjVWVIo4Y+Lurwt67TAsngHaT/k7I1xoXNL/P9
         4dag==
X-Gm-Message-State: APjAAAU18Gp7IpPQ+JBfEAyIpUn6PLZU37caSMWxe6Aifh43Okbk6I5V
        ffsn6ECqCbq9NVYO8eA9EpUP7aY/r2hzmjIwzTz2rsQqz4+JM0RHjG/rEwPUTWeiMoiK1eh4j2b
        C4n6AUFERRd9NsnFaAT8fnw==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr176774wru.68.1574208986904;
        Tue, 19 Nov 2019 16:16:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqww9q4ij+sss666iKTsmZRfAAMuCzQa3zKx/jQ28gxGtZf3qmHixfXYtuem1SU5TdSxOdvdCw==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr176751wru.68.1574208986660;
        Tue, 19 Nov 2019 16:16:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id q15sm5097043wmq.0.2019.11.19.16.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:16:25 -0800 (PST)
Date:   Tue, 19 Nov 2019 19:16:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Dave Ertman <david.m.ertman@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "sassmann@redhat.com" <sassmann@redhat.com>,
        Kiran Patil <kiran.patil@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>
Subject: Re: [net-next v2 1/1] virtual-bus: Implementation of Virtual Bus
Message-ID: <20191119191053-mutt-send-email-mst@kernel.org>
References: <a40c09ee-0915-f10c-650e-7539726a887b@redhat.com>
 <AM0PR05MB4866C40A177D3D60BFC558F7D14C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <13946106-dab2-6bbe-df79-ca6dfdeb4c51@redhat.com>
 <AM0PR05MB486685F7C839AD8A5F3EEA91D14C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ead356f5-db81-cb01-0d74-b9e34965a20f@redhat.com>
 <20191119164632.GA4991@ziepe.ca>
 <20191119134822-mutt-send-email-mst@kernel.org>
 <20191119191547.GL4991@ziepe.ca>
 <20191119163147-mutt-send-email-mst@kernel.org>
 <20191119231023.GN4991@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191119231023.GN4991@ziepe.ca>
X-MC-Unique: DCk8r_7FMXW88yfUbpsOtg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 19, 2019 at 07:10:23PM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 19, 2019 at 04:33:40PM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 19, 2019 at 03:15:47PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Nov 19, 2019 at 01:58:42PM -0500, Michael S. Tsirkin wrote:
> > > > On Tue, Nov 19, 2019 at 12:46:32PM -0400, Jason Gunthorpe wrote:
> > > > > As always, this is all very hard to tell without actually seeing =
real
> > > > > accelerated drivers implement this.=20
> > > > >=20
> > > > > Your patch series might be a bit premature in this regard.
> > > >=20
> > > > Actually drivers implementing this have been posted, haven't they?
> > > > See e.g. https://lwn.net/Articles/804379/
> > >=20
> > > Is that a real driver? It looks like another example quality
> > > thing.=20
> > >=20
> > > For instance why do we need any of this if it has '#define
> > > IFCVF_MDEV_LIMIT 1' ?
> > >=20
> > > Surely for this HW just use vfio over the entire PCI function and be
> > > done with it?
> >=20
> > What this does is allow using it with unmodified virtio drivers
> > within guests.  You won't get this with passthrough as it only
> > implements parts of virtio in hardware.
>=20
> I don't mean use vfio to perform passthrough, I mean to use vfio to
> implement the software parts in userspace while vfio to talk to the
> hardware.

You repeated vfio twice here, hard to decode what you meant actually.

>   kernel -> vfio -> user space virtio driver -> qemu -> guest

Exactly what has been implemented for control path.
The interface between vfio and userspace is
based on virtio which is IMHO much better than
a vendor specific one. userspace stays vendor agnostic.

> Generally we don't want to see things in the kernel that can be done
> in userspace, and to me, at least for this driver, this looks
> completely solvable in userspace.

I don't think that extends as far as actively encouraging userspace
drivers poking at hardware in a vendor specific way.  That has lots of
security and portability implications and isn't appropriate for
everyone. It is kernel's job to abstract hardware away and present
a unified interface as far as possible.

--=20
MST

