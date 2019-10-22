Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1978DE0AF8
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 19:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfJVRuK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 13:50:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52639 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727881AbfJVRuK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 13:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571766609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vV5R9JFSPuxaXsrBZzTkyUrLqrzYx1h6I7SHkYotgvg=;
        b=GfOGKnephNvSXD4x5R8eKc2891HYxqCOekqIbqMCZ2wEee/adIvMmSdfy6OrpdiCDfG7/8
        lHoyZ3JtXs/xQdGpyb4e1aF67hIHyscZOEimQXRqLRh6MzWxpfRzKvIJpa8dxoBUhNmiGj
        tJo42OuqonW8NOIyGfEi4IHlDlvp9GM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-hnVfKaHvOz2UMHYu4vAX0w-1; Tue, 22 Oct 2019 13:50:07 -0400
X-MC-Unique: hnVfKaHvOz2UMHYu4vAX0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DCC21005509;
        Tue, 22 Oct 2019 17:50:05 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E1E41001B3F;
        Tue, 22 Oct 2019 17:50:02 +0000 (UTC)
Message-ID: <edc0090d294d23451cc174835fedf9f0c4cd825a.camel@redhat.com>
Subject: Re: [PATCH] RDMA/hns: Fix build error again
From:   Doug Ledford <dledford@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Shaobo Xu <xushaobo2@huawei.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Xi Wang <wangxi11@huawei.com>, Tao Tian <tiantao6@huawei.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 22 Oct 2019 13:50:00 -0400
In-Reply-To: <CAK8P3a071AHaN0Jb9dX5c3syQZZPgaR9bX3V3nseDTsPvgDWGg@mail.gmail.com>
References: <20191007211826.3361202-1-arnd@arndb.de>
         <113038cde3f1335ba9bf4d66f22f0a536b70ef1f.camel@redhat.com>
         <CAK8P3a071AHaN0Jb9dX5c3syQZZPgaR9bX3V3nseDTsPvgDWGg@mail.gmail.com>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JAbWIVJ500SGnZMy61hI"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-JAbWIVJ500SGnZMy61hI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-21 at 23:51 +0200, Arnd Bergmann wrote:
> On Mon, Oct 21, 2019 at 11:09 PM Doug Ledford <dledford@redhat.com>
> wrote:
> > This fix looks reasonable, but since I can't test this at all, and
> > I'm
> > personally tired of trying and failing to fix this issue, I need to
> > ask
> > if you've tried all the permutations for this just to confirm it
> > works
> > in all valid cases?
>=20
> I'm fairly sure I would have found them all by now: Since I sent this
> patch I built 4680 randconfig kernels, 293 of which had some HNS
> driver enabled.
>=20
> I also like to think that I spent more time to think it through in
> theory.

I reviewed it pretty closely, and I couldn't find any way in which I
thought it would fail, I'm just being picky because I want this to be
the last fix ;-)

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-JAbWIVJ500SGnZMy61hI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2vQUgACgkQuCajMw5X
L93xlw/8CVxWkpoZYKzUO1eqL1qucmpiLHo2PSSUBHKPM8BBbNWcai0T/w1Y7nQC
LFvuE21ydBtwccJcB0juPQKoMTrIzqM4AzZAlCodBM9L9iJiCL72E0uoNTDsa/LK
6dxi4V+GpM/86aIXjNEeaZ7Eqrn/z7m1x4mYY7lYv/UEd/ms/fGiASCcYhMvouGh
sQe0rKiMn4ODzy1xV/tQfKsARfxhT4ntvCAJpgxnqBNxyW+o6rQI3srPtu1BrFgG
KqauoqAj2x4V+xYAs+2UtndWeejPtfkOlwjhSJuHHIaaUzuRRYNgoolaN+Uk5n5X
9qlMAPihrUgApxQIRYtfF53b89SHeSEU+AbQHQcgBcvab6+DyGf0x+oBDGaxqopU
yalV1i3Ob67B/aOxWxiFOL76OHmloH9K09aMMbiKZOZBlg8iRPxPbifPClG+0LUs
TuLt85wXiRIMN/GUdor8yv5WrH8e0d9Tzw7Kl1Mbwcw/Yjl08wZu1fUmoY0MEsR+
M1ovstGW/HYNOa8rLB3i2mARCh+pgpTa7eMY7KSulZcRcFPQzsTAlHMmVWXGvp77
ykf78xjelP50tQmhRTS8athuj/SSl17isfifcNPfXjDMDWYwM3icMQ/qrf6b6bV1
RF7j2+3P9eHOw7Z/RJasCXOMZhlsfpzafuaspt+6ONawylNdaWM=
=C6YR
-----END PGP SIGNATURE-----

--=-JAbWIVJ500SGnZMy61hI--

