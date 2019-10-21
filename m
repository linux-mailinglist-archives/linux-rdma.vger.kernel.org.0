Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10EFDF6C7
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 22:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfJUUbD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 16:31:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35951 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726672AbfJUUbC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 16:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571689860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Bz3GJRaSLsj28Ruxvnrx89SO1QhdOQDAg59fJqf2G8=;
        b=TTbWVqah81+KvCWfQfRpFgw9lhb2moP74LMmqeh3f9rtf1zfyuQeX+wfFd/0DjGtG6F6c7
        p0OooE7tOc3DQL9QCnFmHNvC+oOGIsJpeQK2DHPW+FCtzpDhHDJX1Ri5dxfxWNHptJzT5Z
        pwKdou+IFBGwI5hWkgLoQk3BroC/X+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-sKA6DNxUPriHZfFLQoQWWw-1; Mon, 21 Oct 2019 16:30:54 -0400
X-MC-Unique: sKA6DNxUPriHZfFLQoQWWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53318100550E;
        Mon, 21 Oct 2019 20:30:53 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AEB3860C57;
        Mon, 21 Oct 2019 20:30:52 +0000 (UTC)
Message-ID: <4f01d52616a4a8f767b95bda7fd68e62d8c1f8ae.camel@redhat.com>
Subject: Re: rdma performance verification
From:   Doug Ledford <dledford@redhat.com>
To:     "Liu, Changcheng" <changcheng.liu@intel.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 21 Oct 2019 16:30:50 -0400
In-Reply-To: <20190916094234.GA11772@jerryopenix>
References: <20190916094234.GA11772@jerryopenix>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Wrzia8QZ+lDTn4aw0RoU"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-Wrzia8QZ+lDTn4aw0RoU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-16 at 17:42 +0800, Liu, Changcheng wrote:
> Hi all,
>    I'm working on using rdma to improve message transaction
> performance
>    on distributed storage system(Ceph) development.
>=20
>    Does anyone know what's the right tool to compare RDMA vs TCP
> peformance?
>    Such as bandwidth, latency. Especially the tool that could measure
>    the time to transact the same data size.

qperf is nice because it will do both the tcp and rdma testing, so the
same set of options will make it behave the same way under both tests.

>    Previously, I use iperf & ib_send_bw to do test(send same data
> size).
>    However, it shows that ib_send_bw use more time to send data than
>    iperf.
>       nstcc1@nstcloudcc1:~$ time ib_send_bw -c RC -d rocep4s0 -i 1 -p
> 18515 -q 1 -r 4096 -t 1024 -s 1073741824 --report_gbits -F
> 192.168.199.222
>       real    3m53.858s
>       user    3m48.456s
>       sys     0m5.318s
>       nstcc1@nstcloudcc1:~$ time iperf -c 192.168.199.222 -p 8976 -n
> 1073741824 -P 1
>       real    0m1.688s
>       user    0m0.020s
>       sys     0m1.644s

I think you are mis-reading the instructions on ib_send_bw.  First of
all, IB RC queue pairs are, when used in send/recv mode, message passing
devices, not a stream device.  When you specified the -s parameter of
1GB, you were telling it to use messages of 1GB in size, not to pass a
total of 1GB of messages.  And the default number of messages to pass is
1,000 iterations (the -n or --iters options), so you were actually
testing a 1,000GB transfer.  You would be better off to use a smaller
message size and then set the iters to the proper value.  This is what I
got with 1000 iters and 1GB message size:

 #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgRate[=
Mpps]
 1073741824    1000             6159.64            6159.46=09=09   0.000006
---------------------------------------------------------------------------=
------------

real=093m3.101s
user=093m2.430s
sys=090m0.450s

I tried dropping it to 1 iteration to make a comparison, but that's not
even allowed by ib_send_bw, it wants a minimum of 5 iterations.  So I
did 8 iterations at 1/8th GB in size and this is what I got:

 #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgRate[=
Mpps]
 134217728    8                6157.54            6157.54=09=09   0.000048
---------------------------------------------------------------------------=
------------

real=090m2.506s
user=090m2.411s
sys=090m0.059s

When I adjust that down to 1MB and 1024 iters, I get:

 #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgRate[=
Mpps]
 1048576    1024             6157.74            6157.74=09=09   0.006158
---------------------------------------------------------------------------=
------------

real=090m0.427s
user=090m0.408s
sys=090m0.002s

The large difference in time between these last two tests, given that
the measured bandwidth is so close to identical, explains the problem
you are seeing below.

The ib_send_bw test is a simple test.  It sets up a buffer by
registering its memory, then just slams that buffer over the wire.  With
a 128MB buffer, you pay a heavily memory registration penalty.  That's
factored into the 2s time difference between the two runs.  When you use
a 1GB buffer, the delay is noticeable to the human eye.  There is a very
visible pause as the server and client start their memory registrations.

>    In Ceph, the result shows that rdma performance (RC transaction
> type,
>    SEDN operation) is worse or not much better than TCP implemented
> performance.
>    Test A:
>       1 client thread send 20GB data to 1 server thread (marked as
> 1C:1S)
>    Result:
>       1) implementation based on RDMA
>          Take 171.921294s to finish send 20GB data.
>       2) implementation based on TCP
>          Take 62.444163s to finish send 20GB data.
>=20
>    Test B:
>       16 client threads send 16x20GB data to 1 server thread (marked
> as 16C:1S)
>    Result:
>       1) implementation base on RDMA
>          Take 261.285612s to finish send 16x20GB data.
>       2) implementation based on TCP
>          Take 318.949126 to finish send 16x20GB data.

I suspect your performance problems here are memory registrations.  As
noted by Chuck Lever in some of his recent postings, memory
registrations can end up killing performance for small messages, and the
tests I've shown here indicate, they're also a killer for huge memory
blocks if they are repeatedly registered/deregistered.  TCP has no
memory registration overhead, so in the single client case, it is
outperforming the RDMA case.  But in the parallel case with lots of
clients, the memory registration overhead is spread out among many
clients, so we are able to perform better overall.

In a nutshell, it sounds like the Ceph transfer engine over RDMA is not
optimized at all, and is hitting problems with memory registration
overhead.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Wrzia8QZ+lDTn4aw0RoU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2uFXoACgkQuCajMw5X
L92Q4hAAgRM8haKvMsr4AelUaOM95An9esIUZRuteYmTIM81vrvKHj/vtO737usZ
zMRZWwMA3zmK6CHG4m9PGbz9+2yj8w/UobWla4hrHgTyQEtRFPY4WNjjMcEp5Gx+
8XIvkD4YDWsu8eoptWNkl1QzgZmYNXmGwppaeT07U8uz7Xho7XfHfAcTGg8xnX8y
WCuVS8BHWx/YxZ/yDfijISiKG9kLDQXWXnc4jSelF+tK7n9L3goavcY+8KGUyCEQ
+jeVrSZTs/Zoqrqje9WL2pBQtc5Ev8YQx26Zc6qSs4PFrL6cgVwBL2qYzmm10UBR
cI85wKj223iDCrShLqrxWgplQW7W8SLOHAg4kDyBITcDVWdcMwrHMCBV9QBilk4Y
ExzMW2RxOQcUtyN6/e5f8D46c+P2NYwjs7R5FmiyFQxsaKOz2ylj6RNct5VGyoQ7
Di4n3KZFow7bzkbzxYRRZLJ5OjAmEfdx1y0J9h8BuzMDrJIDWWoFrSwpyY7bwkFs
ZLiVuHecfTWq1bl8TcZGsgMvoNqMLOrDaPqnTM42gVxWajFWk3Y8gb5VXiFAFXQU
jzqe/23ngxwj3tI6V4DmaUBBQLWq2cqBedvuF9AIJdguEUUq7sEE5qUCW5fSF6iR
yPXMsVdEZqKa/muWjEYYI7x8ImBYplPgoOpTH/F8KBY0W2fDKVs=
=t33S
-----END PGP SIGNATURE-----

--=-Wrzia8QZ+lDTn4aw0RoU--

