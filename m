Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2107CDCE11
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 20:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbfJRShC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 14:37:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730794AbfJRShC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 14:37:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C2C3D3175295;
        Fri, 18 Oct 2019 18:37:01 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8C6A5D9CA;
        Fri, 18 Oct 2019 18:37:00 +0000 (UTC)
Message-ID: <2b7aae89011067b39806130206fee26b6df2a947.camel@redhat.com>
Subject: Re: [PATCH v2 for-rc] iw_cxgb4: fix ECN check on the passive accept
From:   Doug Ledford <dledford@redhat.com>
To:     Potnuri Bharat Teja <bharat@chelsio.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, nirranjan@chelsio.com
Date:   Fri, 18 Oct 2019 14:36:58 -0400
In-Reply-To: <20191003104353.11590-1-bharat@chelsio.com>
References: <20191003104353.11590-1-bharat@chelsio.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jSQDf5PFPPeFxAXIeLOB"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 18 Oct 2019 18:37:01 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-jSQDf5PFPPeFxAXIeLOB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-03 at 16:13 +0530, Potnuri Bharat Teja wrote:
> pass_accept_req() is using the same skb for handling accept request
> and
> sending accept reply to HW. Here req and rpl structures are pointing
> to
> same skb->data which is over written by INIT_TP_WR() and leads to
> accessing corrupt req fields in accept_cr() while checking for ECN
> flags.
> Reordered code in accept_cr() to fetch correct req fields.
>=20
> Fixes: 92e7ae7172 ("iw_cxgb4: Choose appropriate hw mtu index and ISS
> for iWARP connections")
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-jSQDf5PFPPeFxAXIeLOB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2qBkoACgkQuCajMw5X
L90CpQ/6AyYZtcYJqCht2JOAH1rx9+xYENAUgj/Ujj2BMEfmxxmPwsMfTq3HjUFp
NxaxOzJkICDmQ0ZZYEywjQzYLeXHI6pY1QzQ0P8aQE+IJ19MBnBkMM1Ea0CItt3B
C7Kci+PPubfPt48Sz06gA5+He6wNniKaAf4PQIvhlfh/1U8f7dG0Sufqf/h2ov/+
i4hAeyeZETfmD1dj/YzMkpnrAtWl0Gte37HJvGBEFet4ugveOt2ALSIGgZk+gdwK
wvv0yasl0+UdQGjovSWNHy50YeVa8hd0gy3X+NUTTdBj3jxCUpGiOUljme6W8Gp7
epBktQwF+TWco9nRxhhWf4QRFvHY4Zxx76B734d1v6Co9m6Tvy6lGIQH2I3YyTGb
NvwwH3Ma1Q0zhQyxu8JpKRzJm/6aOVdXsO65WQ5g3Svmav5WbAiNuiTpRabkIsqO
0F79JOYSl3WxIEMl/8LFADVGQkQaUCnuSSeG5eXMrKo6dqHjvJj7lODR6hdyNLnr
JGmfI3MvduBnRztagD+RNdZhBoEuw844Vw2VBkgJ/OiEcyD9ZA6tzlcOS0TRmXHX
2MUDLLRQI3exD50ST1adAkBnYMHt8aTM0jlTSnkc5HWTMr5twCAtUboULVRvsQAS
YmGOTLmdBsiA4sa/OljA7t+l7sJ6uAw2e+FM+Kz0ux5qBEvxVpg=
=ElKw
-----END PGP SIGNATURE-----

--=-jSQDf5PFPPeFxAXIeLOB--

