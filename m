Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 151B3102E40
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 22:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfKSVdw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 16:33:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38808 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727324AbfKSVdw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Nov 2019 16:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574199231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uzn/F6dkuZ9Ul0rBb+0x2RB8yfihEGhX4QU9TcC33WI=;
        b=VzETE7U1+JYJiZRBxjq1BHRtWFWlZ3YzK9zCaoMqXQsut1A++0ywMGBjrQw/ht7Azyr/hP
        I3t/5+T9dbTA3LCAAcu4l1+QBiuLtgJMa5R09xm/i6MKqBIncvvgBIaGMZ9RmtDylcYAS1
        EO15nDB0TcLGchw0MwXX8lJjdk9A65w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-0PpwRpBwMPChr84p6JoM3Q-1; Tue, 19 Nov 2019 16:33:49 -0500
Received: by mail-qk1-f197.google.com with SMTP id 6so14515191qkc.4
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 13:33:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=70cTiFQFsoR4WQjbXUzAh94mN99XWcHyHcMWXWuCRks=;
        b=MgbAxdtQDCSkeOg5GjZtaMSbhKNyHj5fnyrmvddfL6+MHK4Rid/yZoLbDMKmWaZZUG
         aopSAyp0BYpkqWey9L0Abo7z/LzsuKaDFGzJnSqqhSed4uXat3NISTYAjGCZ8z6LLt9h
         ovs3ro9EJdSkTRrnc66hpIUaBjpLFeOYghicoDEUOZX2SBrug++16AAVJlPLlwQuZIYt
         D8v+mFwMVx4p1FNfjZ4UJdwY3ReuER45khFY065GSjXmJucpzfIbSnogvSNJE/mSpHAy
         u/ViLgSPz9S5QkxSfBcr5WPu2lda1Vc7wUs/hIsBjq3zRUEEh5ozElEGntv5zn0mIlsU
         dDfA==
X-Gm-Message-State: APjAAAVBjiBpyya2R/zceO3H8YrZgk0Kj+aVzEESt46XBnX08ya3X2EL
        bc9p44WuLRtNuv0MvUJkx+FNcgIdqTJbrDcb+7vBmmwzkkpmGagzsh43Hsby9csGz0Dz1s8Auta
        QXQWyJxwGc/29DG0CjzXibw==
X-Received: by 2002:a0c:dd01:: with SMTP id u1mr33153407qvk.69.1574199229080;
        Tue, 19 Nov 2019 13:33:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYGDeT1VCbLJVCTcgAiVh5jz+hDXmOSWm/2udH9NytTu9JOmh7DLTDTu1hmZf5Pk67w5vB4g==
X-Received: by 2002:a0c:dd01:: with SMTP id u1mr33153388qvk.69.1574199228792;
        Tue, 19 Nov 2019 13:33:48 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id b3sm10201658qkl.88.2019.11.19.13.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 13:33:47 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:33:40 -0500
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
Message-ID: <20191119163147-mutt-send-email-mst@kernel.org>
References: <20191115223355.1277139-1-jeffrey.t.kirsher@intel.com>
 <AM0PR05MB4866CF61828A458319899664D1700@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <a40c09ee-0915-f10c-650e-7539726a887b@redhat.com>
 <AM0PR05MB4866C40A177D3D60BFC558F7D14C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <13946106-dab2-6bbe-df79-ca6dfdeb4c51@redhat.com>
 <AM0PR05MB486685F7C839AD8A5F3EEA91D14C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ead356f5-db81-cb01-0d74-b9e34965a20f@redhat.com>
 <20191119164632.GA4991@ziepe.ca>
 <20191119134822-mutt-send-email-mst@kernel.org>
 <20191119191547.GL4991@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191119191547.GL4991@ziepe.ca>
X-MC-Unique: 0PpwRpBwMPChr84p6JoM3Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 19, 2019 at 03:15:47PM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 19, 2019 at 01:58:42PM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 19, 2019 at 12:46:32PM -0400, Jason Gunthorpe wrote:
> > > As always, this is all very hard to tell without actually seeing real
> > > accelerated drivers implement this.=20
> > >=20
> > > Your patch series might be a bit premature in this regard.
> >=20
> > Actually drivers implementing this have been posted, haven't they?
> > See e.g. https://lwn.net/Articles/804379/
>=20
> Is that a real driver? It looks like another example quality
> thing.=20
>=20
> For instance why do we need any of this if it has '#define
> IFCVF_MDEV_LIMIT 1' ?
>=20
> Surely for this HW just use vfio over the entire PCI function and be
> done with it?
>=20
> Jason

What this does is allow using it with unmodified virtio drivers within gues=
ts.
You won't get this with passthrough as it only implements parts of
virtio in hardware.

--=20
MST

