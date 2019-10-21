Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7AD0DF419
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 19:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfJURXZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 13:23:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60156 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726672AbfJURXZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 13:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571678604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UQ5rFa60eigEj3sK1Gv2Ur3FCBlK9CmtSDxO40wN/gA=;
        b=WHjrHAKI+dkvjwaXDmOLruHLODjiwq46Bihe58KzftopRKRiklHfab0Vuo+sKaQQUDqfiP
        SQvXFEHMtyovGa0rufY81pNRAHXGn+Nu/E7yygs0VK8N8g49m+zqW7Mal7BLA65iPo56c6
        8Vpgpe/wEt4qbnx58nFweFrwnjvvsVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-AJL82eHOMYKGpgeck7BqKg-1; Mon, 21 Oct 2019 13:23:16 -0400
X-MC-Unique: AJL82eHOMYKGpgeck7BqKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2E5C47B;
        Mon, 21 Oct 2019 17:23:14 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4B7B10018FF;
        Mon, 21 Oct 2019 17:23:13 +0000 (UTC)
Message-ID: <3056732a61a9f4d356f761f0e436cc01e67aac31.camel@redhat.com>
Subject: Re: [PATCH for-next 9/9] RDMA/hns: Copy some information of AV to
 user
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Mon, 21 Oct 2019 13:23:11 -0400
In-Reply-To: <1565343666-73193-10-git-send-email-oulijun@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
         <1565343666-73193-10-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Wu2FXy0jkLjackHqC2uJ"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-Wu2FXy0jkLjackHqC2uJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-09 at 17:41 +0800, Lijun Ou wrote:
> When the driver support UD transport in user mode, it needs to
> create the Address Handle(AH) and transfer Address Vector to
> The hardware. The Address Vector includes the destination mac
> and vlan inforation and it will be generated from the kernel
> driver. As a result, we can copy this information to user
> through ib_copy_to_udata function.
>=20
> Signed-off-by: Lijun Ou <oulijun@huawei.com>

This patch is broken.  There are multiple instance of whitespace
breakage (spaces that should be tabs, etc.), and at least one instance
of a hanging character that makes no sense:

>=20
>  =09ah->av.sl_tclass_flowlabel =3D cpu_to_le32(rdma_ah_get_sl(ah_attr)
> <<
> -=09=09=09=09=09=09 HNS_ROCE_SL_SHIFT);
> +=09=09=09=09i=09=09 HNS_ROCE_SL_SHIFT);
                                ^ ?
>=20

This needs to be resubmitted.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Wu2FXy0jkLjackHqC2uJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2t6X8ACgkQuCajMw5X
L9108g//aaS4HWc16B3tUYeTE8XUUP4u/pMuOhTv3tCpB1hjxwbCaZW4ydvqxw0W
oQDGllkb4gCAEW9NDF2X/5YXZ5C0t9rsLG9kZn8OgwNo2OukzqJgp1JFHBQ1jSkV
ddhVVUflT47s49TApdtAzVEy/1oQjv99XW1ovNIDJl5rSEdXJqwAV22iBfZ0K45I
QXAGBAKA5CqUBPmejRgSFOZGuOpt/rwy/xTOoZT89gxmsNtz6fvkTIaVNN3o+/OT
Ntd6SeyEhpvhVPZi5uWkZh9hze7Zi5KxyzIWuNB1NpcfZ4FmuwnPAdaYGHlqCjtS
7SqxmdbHOphk54N0baFDpmEp/9wc+rpTH61N15dr6T0c6SLFkNJr7I3JKonXG4SD
yFnXoikHfuNVSgSMZ9R55NMpZrm7r8viNfbcQdGWYIAaN55q9IQPHZtJj/vc16jq
MEuNyTwDwmjM/P9qgdJse3loNcALnMA3ds0iOKS5Lew5kZnwJgU+5ktiZ+RltKvT
nFVKtCM3YCX0fTmsHuA+CXh59nSBpwHN7JF5kF6g0Fpkn77oxr/ZXVuV2KS8MuJs
UnunTsy6MbKK1YYdA2NBBmS6X9Oatz9sUJVGyya8SdKtRc9rbttgNFRlKELn81lL
XzFTojzbhqUxcyRn50U5sBPaq22L3exrgPK9iYM3NZxwVvYqtMw=
=J6xX
-----END PGP SIGNATURE-----

--=-Wu2FXy0jkLjackHqC2uJ--

