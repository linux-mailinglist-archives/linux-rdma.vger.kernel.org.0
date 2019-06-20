Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A297A4DA8D
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 21:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFTTs3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 15:48:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfFTTs2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 15:48:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C8CA3091DC1;
        Thu, 20 Jun 2019 19:48:28 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40C241001E61;
        Thu, 20 Jun 2019 19:48:26 +0000 (UTC)
Message-ID: <9862d4db3e930bc12c059f8b04e1eb24c493519b.camel@redhat.com>
Subject: Re: [PATCH V3 for-next] RDMA/hns: reset function when removing
 module
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Lijun Ou <oulijun@huawei.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Thu, 20 Jun 2019 15:48:23 -0400
In-Reply-To: <20190620193457.GG19891@ziepe.ca>
References: <1560524163-94676-1-git-send-email-oulijun@huawei.com>
         <d4ba310e1cb50abd3810032fc468797edd917c08.camel@redhat.com>
         <20190620193457.GG19891@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-viFqyOFb4RXIcdR1io/d"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 20 Jun 2019 19:48:28 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-viFqyOFb4RXIcdR1io/d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-20 at 16:34 -0300, Jason Gunthorpe wrote:
> On Thu, Jun 20, 2019 at 03:09:37PM -0400, Doug Ledford wrote:
> > On Fri, 2019-06-14 at 22:56 +0800, Lijun Ou wrote:
> > > From: Lang Cheng <chenglang@huawei.com>
> > >=20
> > > During removing the driver, we needs to notify the roce engine to
> > > stop working immediately,and symmetrically recycle the hardware
> > > resources requested during initialization.
> > >=20
> > > The hardware provides a command called function clear that can
> > > package
> > > these operations,so that the driver can only focus on releasing
> > > resources that applied from the operating system.
> > > This patch implements the call of this command.
> > >=20
> > > Signed-off-by: Lang Cheng <chenglang@huawei.com>
> > > Signed-off-by: Lijun Ou <oulijun@huawei.com>
> > > V2->V3:
> > > 1. Remove other reset state operations that are not related to
> > >    function clear
> >=20
> >=20
> > > +	msleep(HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_INTERVAL);
> > > +	end =3D HNS_ROCE_V2_FUNC_CLEAR_TIMEOUT_MSECS;
> > > +	while (end) {
> > > +		msleep(HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT);
> > > +		end -=3D HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT;
> >=20
> >=20
> > > +#define HNS_ROCE_V2_FUNC_CLEAR_TIMEOUT_MSECS	(249 * 2 * 100)
> > > +#define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_INTERVAL	40
> > > +#define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT	20
> >=20
> > I absolutely despise code that does a possible *50* second blocking
> > delay using msleep.  However, because I suspect that this is
> > something
> > that should *rarely* ever happen, and instead the common case is
> > that
> > the reset will proceed much faster, and because this is in the
> > teardown/shutdown path of the device where it is a little more
> > acceptable to have a blocking delay, I've taken this to for-next.
>=20
> I've been telling hns they have to do proper locking and wouldn't
> accept these stupid msleep loops. No kernel code should ever do that,
> it just shows the locking and concurrency model is wrong.

It's an msleep() waiting for a hardware command to complete.  Waiting
synchronously for a command that has the purpose of stopping the card's
operation does not sound like an incorrect locking or concurrency model
to me.  It sounds sane, albeit annoying.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-viFqyOFb4RXIcdR1io/d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0L4wcACgkQuCajMw5X
L92PoxAArFxrY0iOwajrbOuhIBgl7QTNLZ8g+vuwpJl9zO+WqPkrhpqI0A/AJWoe
JyRWuhU4UmfgQOxBQYqJdce9wLLKVeZ3SE3oWzAF7xk+cdy/MSMQ3qXjIo+682Fa
PAaGF4pbkEdx4LxfzV4XjlEUCF4gKQdi1pgxEm8K9ajncusMqjMoI12dq//yJip9
N+dSzPszEKqEQuROkjyQu54EupKf4tm2IpJkpBrg0WAZLBqGWKsWWcelrV30R1ZE
wgnsWIXvw66sgfzp57cl3Ob5ePGUDtBhlZUBQC3WXLseRkW8iABuPsmXIkY7QeF0
um2N6y+5dmbtlfS53tW4D7KsiVFEzD3X5szV8xAW/ByYlbbc8pS82V5ntIvL5m33
ZE1nUG/e4j6c/lO31MpTzAsETRM+P9rE0a2RSf73hJkhjIuYbbHJ3u5lBYNXMfeP
t5IYfMQYcHrZ+3/nOjtG61m8Bu9ingOO5PEKAhsD8r6PPGLP9yhMhPJi+ugNNpfZ
YD+ElXqtwnL+Sqhw37+++wJFtVepSM4avD7Wt0yKobR+AvE452lVsGDN69fAcMgY
m+E8wUzG7g6p7BexVSWF2YYnDfCV0AXgJnOw1pdG0Q3WhpdNN9riB+ycGe30+F6d
tWWthvNIar22LReQELC8S64RbQi86+oKky3mcCb0z3jB8VsExZU=
=UlmD
-----END PGP SIGNATURE-----

--=-viFqyOFb4RXIcdR1io/d--

