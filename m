Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CA51E523A
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 02:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbgE1Aai (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 20:30:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47959 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725267AbgE1Aai (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 20:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590625837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJI7bSeRmdZCxn+5Qeb3iCtQcSP6aUjTfq9vdrY4srs=;
        b=FJgMGxmDu5NhT8tJKvDZ/5V7V3IU4nf57Fb7dPWFQMM2Mm/DQ3HxjGV7hGYjLxs1d296LC
        XVpMJLJzGv37zbEZv5ZItVDNhuCKBSKR45wvAengGPDoTo/X24GzBOO0ZWNXDa1nPUFbM2
        +QKHIazvRj7E4i9M3riD7PVNBuSOJ8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-vVWDQ3VZNTuQxxERdefMyA-1; Wed, 27 May 2020 20:30:33 -0400
X-MC-Unique: vVWDQ3VZNTuQxxERdefMyA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FEE91801804;
        Thu, 28 May 2020 00:30:31 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (unknown [10.10.110.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C02862932;
        Thu, 28 May 2020 00:30:30 +0000 (UTC)
Message-ID: <d60491181553cc89708e40901122399c702ebe63.camel@redhat.com>
Subject: Re: [PATCH rdma-next v1] IB/ipoib: Fix double free of skb in case
 of multicast traffic in CM mode
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Alaa Hleihel <alaa@mellanox.com>,
        Alex Vesker <valex@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>, linux-rdma@vger.kernel.org
Date:   Wed, 27 May 2020 20:30:28 -0400
In-Reply-To: <20200528001623.GC24561@mellanox.com>
References: <20200527134705.480068-1-leon@kernel.org>
         <9cd656241bf31f454a72731de7509a7244353193.camel@redhat.com>
         <20200528001623.GC24561@mellanox.com>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-2nkdSFL1MFoCVVq67n9W"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-2nkdSFL1MFoCVVq67n9W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-05-27 at 21:16 -0300, Jason Gunthorpe wrote:
> > This seems like a pretty important fix that should go to for-rc, not
> > for-next.
> >=20
> > Regardless, looks good to me.
> > Acked-by: Doug Ledford <dledford@redhat.com>
>=20
> Sure, it looks reasonable for -rc, but the crash is not so common

Yeah, it's not that easy to trigger, but it's an oops when you do ;-)

> Applied to for-rc, thanks

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-2nkdSFL1MFoCVVq67n9W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl7PBiQACgkQuCajMw5X
L90tEBAAuKKS75GHVfICti1BLMZZasRJGxjGLSCZq9kBTRsCAbRnQd2kJ5wGEmvM
Vj54IELGMJjX9cJUCa7p+DyVgl7L5P4OdP3eeOiQVoYNzlGTwbvQ3mshkIbiHvbO
PoVvKcq/PXlVwXxfqsBCqDQzeYQ7MjcHLhOoiKt4Av4C+vdJdhbgOiz8OtLMummh
BNaz7/38BbfEXXhCzo5WrGiKaCR96JjtlSsQMeqC1gQdG3SlCxZG/+duvnDK5D7n
Ce9FJoyEyrPAdJto3+jHsthVOMp0G67g7hVyC7DwnDT2OKAYNYhTQQrFrhSvXsc/
egyLlgQLEmZ6uj3YVDS0QGcjfJOikoRmr6EkFbAfc5SrYI3XsnIOpDxidLGBSjW3
s1PMcLy/r1RS/hjfDMaU0DQYnsNHrVizBnos09MEYria/phkfib7KHGvGFJyUEWX
/3r/cBnumSLCxf99k1mLaJVSIJnyOHcATrvcgqVKL+i+Ma3A59StYWKTKAzSDqW/
IAw33u21snXf/nkSkiWpB0FstojhuQnmAd6dZhIcuGjOBmaBJNX1iVYx3BlGbSL7
opRFbwPqBTK5pOAYGDcCXTK9aioOAmc352J6PQDjLROh6LVj401DHdaRTFPmBWOJ
sxQdr/ozE4bkxQAMWuNaJNYle2yaexgZn5I4MH2XCZfCvE38/fM=
=V3mF
-----END PGP SIGNATURE-----

--=-2nkdSFL1MFoCVVq67n9W--

