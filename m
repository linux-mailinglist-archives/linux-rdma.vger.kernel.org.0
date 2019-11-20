Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0AD0104648
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 23:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKTWFN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 17:05:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20617 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbfKTWFM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Nov 2019 17:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574287511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4YpMbJX5XyxRp8q7h/jm7rfnus2WLxi2XgTkFPCvRSw=;
        b=MXe31K3A6uIY0r6FExhRw40dIBFUMT92ACDxvESsjJfqPLEIve0Hw+KOYE0bo+VjZR06/S
        pe0t74I069xbpCzvjt5p9oZpRSCGyLPGgkMMG7JJ11nXwozEV/d3yyrIUpIUDgvcagki5p
        44Ay9cJNxpvYmCquw3lXtYBtCF1fsdw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-QOXeT9vIOnKEa2Q9Q0PbVA-1; Wed, 20 Nov 2019 17:05:08 -0500
Received: by mail-qv1-f72.google.com with SMTP id m12so821176qvv.8
        for <linux-rdma@vger.kernel.org>; Wed, 20 Nov 2019 14:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ix0u7hdNyTJABkb8oloHDZIWR+Nd0ngaOCu5R4X4iSI=;
        b=AJQTyMH9bMVKO2Nt5l2vVfKn1D+9y3ZTrEEfW32BN4/Go9ruyOIq4tZwv9aaFUrCMy
         BDJymNqoXvn1kuxeEJ3juVROW4XPvSkxewjfKjpm3yC95md1GL7MiLaNyVDovYF3ayHB
         Ax7DgeNxLwUilfN9w8dd3IwHDRw1IS1JR9Y9QL6FGtTz8NwMCkopF1SZicu7kEXp2r7V
         U2QERUwWTO9wArR2eODAP1eAKwpFlvtMtmTqcvxGz94tSGPPBudWsG4gQQJhifBGGasS
         qhAQ1TBIopCzB5J/wBaaxR5pkm9EbRGWX7xHZRcASCszjQNVfX2f0DwXGgd9dUEtUifw
         JnRQ==
X-Gm-Message-State: APjAAAWM21cgGRHKrilB8SfCPIMCQt5hVwo/v9mRpCyiDhmRBuwTT7sA
        f2afgbG/PNjfSm5LO5+VUd5ZbJtYwQmL3wy2Ptrl1Fa6ngFZPqUZS0LqGb8q1xKqFFNVwIj4olR
        xN7xs4JLEIOcMbs5K9lVtjA==
X-Received: by 2002:ac8:51c3:: with SMTP id d3mr5040944qtn.14.1574287508112;
        Wed, 20 Nov 2019 14:05:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqxdsih9DHA5lFir/c/3IJa6bxqZOBG7X8LxPArtXfaUgPz+4d3X0P+nI2I9fnkkPKWKJeAeIg==
X-Received: by 2002:ac8:51c3:: with SMTP id d3mr5040914qtn.14.1574287507889;
        Wed, 20 Nov 2019 14:05:07 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id i75sm353431qke.22.2019.11.20.14.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 14:05:06 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:05:00 -0500
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
Message-ID: <20191120165748-mutt-send-email-mst@kernel.org>
References: <20191119163147-mutt-send-email-mst@kernel.org>
 <20191119231023.GN4991@ziepe.ca>
 <20191119191053-mutt-send-email-mst@kernel.org>
 <20191120014653.GR4991@ziepe.ca>
 <20191120022141-mutt-send-email-mst@kernel.org>
 <20191120130319.GA22515@ziepe.ca>
 <20191120083908-mutt-send-email-mst@kernel.org>
 <20191120143054.GF22515@ziepe.ca>
 <20191120093607-mutt-send-email-mst@kernel.org>
 <20191120164525.GH22515@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191120164525.GH22515@ziepe.ca>
X-MC-Unique: QOXeT9vIOnKEa2Q9Q0PbVA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 20, 2019 at 12:45:25PM -0400, Jason Gunthorpe wrote:
> > > For instance, this VFIO based approach might be very suitable to the
> > > intel VF based ICF driver, but we don't yet have an example of non-VF
> > > HW that might not be well suited to VFIO.
> >
> > I don't think we should keep moving the goalposts like this.
>=20
> It is ABI, it should be done as best we can as we have to live with it
> for a long time. Right now HW is just starting to come to market with
> VDPA and it feels rushed to design a whole subsystem style ABI around
> one, quite simplistic, driver example.

Well one has to enable hardware in some way. It's not really reasonable
to ask for multiple devices to be available just so there's a driver and
people can use them. At this rate no one will want to be the first to
ship new devices ;)

> > If people write drivers and find some infrastruture useful,
> > and it looks more or less generic on the outset, then I don't
> > see why it's a bad idea to merge it.
>=20
> Because it is userspace ABI, caution is always justified when defining
> new ABI.


Reasonable caution, sure. Asking Alex to block Intel's driver until
someone else catches up and ships competing hardware isn't reasonable
though. If that's your proposal I guess we'll have to agree to disagree.

--=20
MST

