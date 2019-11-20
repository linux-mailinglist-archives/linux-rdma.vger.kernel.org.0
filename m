Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99F5103547
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 08:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfKTHiU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 02:38:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32087 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726647AbfKTHiT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Nov 2019 02:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574235497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QueRFGbWIKe1DBP4WKEtexKljzpJDiK9rJt150Hg3cw=;
        b=PQcaNwPPbwv4G55pSrG4nK1HOLVtN1HSQ/bNNhu1l1zW9nJi18et+8iXISBE7LcoHcKuvl
        V5Sl/ryYG/pc8VH+2air3MIZlFZsbabtBwen6agUKk8LQOdNHhqO84DzyAuEWaZb988mqZ
        3r52HA/Y5t57K/+G1hcn2ZniID4t4hE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-qzRdi0FUPzSMofisCxxLtg-1; Wed, 20 Nov 2019 02:38:16 -0500
Received: by mail-qv1-f70.google.com with SMTP id w5so16593883qvp.13
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 23:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+3bQX5jw48ECPr0GHAWNTrSn2IoSLspex7l9wIA1zSg=;
        b=aENnw36igwAL99DPGOrmE3Y2A/Nl4RiZG6KGaNNQRWUdc03uVE2ocLM8CdhIpGf4Gd
         Sv32g93iBuM+6VWcPEDkBPFr0GcEck8NFSWkGaWkHUm6/0ukogEUftIXdjhnBHuIXwIO
         Nb5CknYPv0CaLWxyFm5/PfTpx+BizGqAeN8Xl61j1RNVVnFbFqk73/bSF389q/dxEEj/
         2tqMvjFNGd/j/HBuX0GOC+HCnaHfXJPgyxen1puF6LFt8jyJ8+i2SJqUwmZAcqCcgVDe
         6TVCJ3PyXlEH3oqD94lgGPT9a/07lxq0J/wbuInfGzdAE0EYy3adre76uSnCO4Gfhw+K
         vU6Q==
X-Gm-Message-State: APjAAAXrf0Pj1q4QSOzt/mFrex28ZierxG3ydYSJ8yaTr1U39H/RRuMg
        l+vfVTbKcvApC26fcctMDjm7eIAOC4cmZsJY95dYaQ6dC+ihdU70q8NnQKJTQNiKAt4Guv/2j67
        CUX4POs+btAF/YkyQdZw9nA==
X-Received: by 2002:a05:6214:cb:: with SMTP id f11mr1339675qvs.156.1574235495475;
        Tue, 19 Nov 2019 23:38:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8rIRiWKoEf1Px6K5kHJEFC1V/zLw7nhDs4C5H00Ajz2FrGHb9PN+WDmoIqUtmBFeYpZU4Ug==
X-Received: by 2002:a05:6214:cb:: with SMTP id f11mr1339641qvs.156.1574235495110;
        Tue, 19 Nov 2019 23:38:15 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id n56sm13624072qtb.73.2019.11.19.23.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 23:38:14 -0800 (PST)
Date:   Wed, 20 Nov 2019 02:38:08 -0500
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
Message-ID: <20191120022141-mutt-send-email-mst@kernel.org>
References: <13946106-dab2-6bbe-df79-ca6dfdeb4c51@redhat.com>
 <AM0PR05MB486685F7C839AD8A5F3EEA91D14C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ead356f5-db81-cb01-0d74-b9e34965a20f@redhat.com>
 <20191119164632.GA4991@ziepe.ca>
 <20191119134822-mutt-send-email-mst@kernel.org>
 <20191119191547.GL4991@ziepe.ca>
 <20191119163147-mutt-send-email-mst@kernel.org>
 <20191119231023.GN4991@ziepe.ca>
 <20191119191053-mutt-send-email-mst@kernel.org>
 <20191120014653.GR4991@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191120014653.GR4991@ziepe.ca>
X-MC-Unique: qzRdi0FUPzSMofisCxxLtg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 19, 2019 at 09:46:53PM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 19, 2019 at 07:16:21PM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 19, 2019 at 07:10:23PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Nov 19, 2019 at 04:33:40PM -0500, Michael S. Tsirkin wrote:
> > > > On Tue, Nov 19, 2019 at 03:15:47PM -0400, Jason Gunthorpe wrote:
> > > > > On Tue, Nov 19, 2019 at 01:58:42PM -0500, Michael S. Tsirkin wrot=
e:
> > > > > > On Tue, Nov 19, 2019 at 12:46:32PM -0400, Jason Gunthorpe wrote=
:
> > > > > > > As always, this is all very hard to tell without actually see=
ing real
> > > > > > > accelerated drivers implement this.=20
> > > > > > >=20
> > > > > > > Your patch series might be a bit premature in this regard.
> > > > > >=20
> > > > > > Actually drivers implementing this have been posted, haven't th=
ey?
> > > > > > See e.g. https://lwn.net/Articles/804379/
> > > > >=20
> > > > > Is that a real driver? It looks like another example quality
> > > > > thing.=20
> > > > >=20
> > > > > For instance why do we need any of this if it has '#define
> > > > > IFCVF_MDEV_LIMIT 1' ?
> > > > >=20
> > > > > Surely for this HW just use vfio over the entire PCI function and=
 be
> > > > > done with it?
> > > >=20
> > > > What this does is allow using it with unmodified virtio drivers
> > > > within guests.  You won't get this with passthrough as it only
> > > > implements parts of virtio in hardware.
> > >=20
> > > I don't mean use vfio to perform passthrough, I mean to use vfio to
> > > implement the software parts in userspace while vfio to talk to the
> > > hardware.
> >=20
> > You repeated vfio twice here, hard to decode what you meant actually.
>=20
> 'while using vifo to talk to the hardware'

Sorry still have trouble reading that.

> > >   kernel -> vfio -> user space virtio driver -> qemu -> guest
> >
> > Exactly what has been implemented for control path.
>=20
> I do not mean the modified mediated vfio this series proposes, I mean
> vfio-pci, on a full PCI VF, exactly like we have today.
>=20
> > The interface between vfio and userspace is
> > based on virtio which is IMHO much better than
> > a vendor specific one. userspace stays vendor agnostic.
>=20
> Why is that even a good thing? It is much easier to provide drivers
> via qemu/etc in user space then it is to make kernel upgrades. We've
> learned this lesson many times.
>=20
> This is why we have had the philosophy that if it doesn't need to be
> in the kernel it should be in userspace.
>=20
> > > Generally we don't want to see things in the kernel that can be done
> > > in userspace, and to me, at least for this driver, this looks
> > > completely solvable in userspace.
> >=20
> > I don't think that extends as far as actively encouraging userspace
> > drivers poking at hardware in a vendor specific way. =20
>=20
> Yes, it does, if you can implement your user space requirements using
> vfio then why do you need a kernel driver?

People's requirements differ. You are happy with just pass through a VF
you can already use it. Case closed. There are enough people who have
a fixed userspace that people have built virtio accelerators,
now there's value in supporting that, and a vendor specific
userspace blob is not supporting that requirement.

> The kernel needs to be involved when there are things only the kernel
> can do. If IFC has such things they should be spelled out to justify
> using a mediated device.
>=20
> > That has lots of security and portability implications and isn't
> > appropriate for everyone.=20
>=20
> This is already using vfio.

It's using the IOMMU parts since these are portable.
But the userspace interface is vendor-independent here.

> It doesn't make sense to claim that using
> vfio properly is somehow less secure or less portable.
>=20
> What I find particularly ugly is that this 'IFC VF NIC' driver
> pretends to be a mediated vfio device, but actually bypasses all the
> mediated device ops for managing dma security and just directly plugs
> the system IOMMU for the underlying PCI device into vfio.
>=20
> I suppose this little hack is what is motivating this abuse of vfio in
> the first place?
>=20
> Frankly I think a kernel driver touching a PCI function for which vfio
> is now controlling the system iommu for is a violation of the security
> model, and I'm very surprised AlexW didn't NAK this idea.
>
> Perhaps it is because none of the patches actually describe how the
> DMA security model for this so-called mediated device works? :(

That can be improved, good point.

> Or perhaps it is because this submission is split up so much it is
> hard to see what is being proposed? (I note this IFC driver is the
> first user of the mdev_set_iommu_device() function)

I agree it's hard, but then 3 people seem to work on that
at the same time.

> > It is kernel's job to abstract hardware away and present a unified
> > interface as far as possible.
>=20
> Sure, you could create a virtio accelerator driver framework in our
> new drivers/accel I hear was started. That could make some sense, if
> we had HW that actually required/benefited from kernel involvement.
>=20
> Jason

