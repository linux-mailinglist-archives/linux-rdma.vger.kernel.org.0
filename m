Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A670E10363C
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 09:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfKTIwh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 03:52:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36661 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727976AbfKTIwg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Nov 2019 03:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574239955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J62qG/l4OLNLTAXRiIot0/oxRSgkxGYPpqtpwxT76WA=;
        b=EPkkd3Gor5c1ztdylSv6lVFL3NcgTEJFR35idrTIZ4AAbvwxryeHuMSI58nPTnCh9fQ5mU
        RRbB0qyQ5DCqZCCjz2HvWclbk1Wm3kagNTUDMy0V7fV1vVDZ4XA+xs7/Y8BbOdIoLmTKto
        +5IZ1ATGAPpKf5ftmCk0Xt8nnRME5NU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-3ruPHH4zMUWGOtswcBjDdQ-1; Wed, 20 Nov 2019 03:52:32 -0500
Received: by mail-qv1-f70.google.com with SMTP id k11so16685119qvw.19
        for <linux-rdma@vger.kernel.org>; Wed, 20 Nov 2019 00:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2B/lNGhsR+kI+KNj1BmROSKU5fUdHyUukwLs+JxNkWA=;
        b=gNVQvodJ8CWC8UyFEbWRdKPVc2rdEJpE3Nq4qtP21L2J6aHIpSdaESPiZawudbBKji
         R8ORrbGkMUgwx3ibwIRMhvitwe3MCaAeYDIubFUH4NEsCTGVZI8lQdaHcAsysm0ZvUNq
         NQm+1r7Hz64hFJKv+1Bu6a35wWyCohLL8Z3+YygG6tDLouBQufHTVwChHghhJVVuJnc6
         RpV0jZ6VJRPdclcXQBpeXf0hiKZ5YyJQdptwn5Mc7/u7KBHQ9RloeSD4tBQqJuY/yuBb
         SAiYGJJ/s/oolidxeKTWv/weH+8cfBNDCHSjs3hVWKZSVm3O5wP40Eb5CK22GKwmeW+p
         gpyQ==
X-Gm-Message-State: APjAAAWMpaNCy89FKTYx3LZmCe+UwlJH3LyEw2XC42yKCj6az9f0gfaG
        CfEBl/vuBkdNUs5o8eWonIVYo9Qa1v/rw3BtV7jQ4MUkcCG0fV4n2SxcFqj3dzAVk3iJIVTLjjI
        yenSaefXXoyM5Jaho/+PHOg==
X-Received: by 2002:a05:620a:536:: with SMTP id h22mr1355412qkh.480.1574239951670;
        Wed, 20 Nov 2019 00:52:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCWyR6HUb5BbPq5DUZXyuyXDuw6pH0/t6iz3hUQgrSdlnaDkRyBd3Abw0ar+8jKbMeqfRFaw==
X-Received: by 2002:a05:620a:536:: with SMTP id h22mr1355383qkh.480.1574239951357;
        Wed, 20 Nov 2019 00:52:31 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id m186sm574902qkc.39.2019.11.20.00.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 00:52:30 -0800 (PST)
Date:   Wed, 20 Nov 2019 03:52:23 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Dave Ertman <david.m.ertman@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "sassmann@redhat.com" <sassmann@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, Kiran Patil <kiran.patil@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [net-next v2 1/1] virtual-bus: Implementation of Virtual Bus
Message-ID: <20191120034839-mutt-send-email-mst@kernel.org>
References: <20191115223355.1277139-1-jeffrey.t.kirsher@intel.com>
 <AM0PR05MB4866CF61828A458319899664D1700@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <a40c09ee-0915-f10c-650e-7539726a887b@redhat.com>
 <AM0PR05MB4866C40A177D3D60BFC558F7D14C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <13946106-dab2-6bbe-df79-ca6dfdeb4c51@redhat.com>
 <AM0PR05MB486685F7C839AD8A5F3EEA91D14C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ead356f5-db81-cb01-0d74-b9e34965a20f@redhat.com>
 <AM0PR05MB486605742430D120769F6C45D14C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <743601510.35622214.1574219728585.JavaMail.zimbra@redhat.com>
 <AM0PR05MB48664221FB6B1C14BDF6C74AD14F0@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR05MB48664221FB6B1C14BDF6C74AD14F0@AM0PR05MB4866.eurprd05.prod.outlook.com>
X-MC-Unique: 3ruPHH4zMUWGOtswcBjDdQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 20, 2019 at 03:38:18AM +0000, Parav Pandit wrote:
>=20
>=20
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, November 19, 2019 9:15 PM
> >=20
> > ----- Original Message -----
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Tuesday, November 19, 2019 1:37 AM
> > > >
> > >
> > > Nop. Devlink is NOT net specific. It works at the bus/device level.
> > > Any block/scsi/crypto can register devlink instance and implement the
> > > necessary ops as long as device has bus.
> > >
> >=20
> > Well, uapi/linux/devlink.h told me:
> >=20
> > "
> >  * include/uapi/linux/devlink.h - Network physical device Netlink inter=
face "
> >=20
> > And the userspace tool was packaged into iproute2, the command was name=
d
> > as "TC", "PORT", "ESWITCH". All of those were strong hints that it was =
network
> > specific. Even for networking, only few vendors choose to implement thi=
s.
> >=20
> It is under iproute2 tool but it is not limited to networking.

Want to fix the documentation then?
That's sure to confuse people ...

--=20
MST

