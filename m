Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1F684DF27
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 04:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfFUChG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 22:37:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfFUChG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 22:37:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59A80307D90E;
        Fri, 21 Jun 2019 02:37:06 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EAD91001E80;
        Fri, 21 Jun 2019 02:37:05 +0000 (UTC)
Message-ID: <66f616ad351d0f1e0f4f711deae98ce8fd830679.camel@redhat.com>
Subject: Re: [RESEND PATCH v2 0/2] Completion rework
From:   Doug Ledford <dledford@redhat.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 20 Jun 2019 22:37:03 -0400
In-Reply-To: <20190613123013.5297.32797.stgit@awdrv-06.aw.intel.com>
References: <20190613123013.5297.32797.stgit@awdrv-06.aw.intel.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-uvSLk0XX8n0WS5mCbr5y"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 21 Jun 2019 02:37:06 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-uvSLk0XX8n0WS5mCbr5y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-13 at 08:30 -0400, Mike Marciniszyn wrote:
> This two patch patch series is resend of:
> - https://marc.info/?l=3Dlinux-rdma&m=3D155499222312346&w=3D2
> - https://marc.info/?l=3Dlinux-rdma&m=3D155499221212340&w=3D2
>=20
> Jason raised issues in:
> - https://marc.info/?l=3Dlinux-rdma&m=3D155611789008362&w=3D2
>=20
> And Andrea and others surfaced issues with the post send
> side API use in:
> - https://marc.info/?a=3D152205460700001&r=3D1&w=3D2
>=20
> These patches address those issues.

You indeed addressed the comments.  Series applied to for-next, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-uvSLk0XX8n0WS5mCbr5y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0MQs8ACgkQuCajMw5X
L92x7Q//SqnUI43MvleS8mfR/tugnATdWa7nNDadtVxtokUgNNQdahdGAKbEnOFI
U8JUUSQyK9dbobhA3Il+utxn+7e4jd7VyrYgiadUfM4xXbPzyOS/czx0tAsOYyY3
CmFZGm2OxqxZJTQ4yQMur+4qceh6KOTP72HSJBT/PbvlSiqbAAz1rIL74NTh3Ku4
m08cUpAr3T3bPZuJUyyUNL+bck43RDoItoUG9HivVcHdP0VSe1WB5mbv/SEGzLX2
8a/6LN1aDE2iDtuY1aMvK8GF04YrajmHdAmcFpFHHelvSIoQ57QFauq7G2gbK72v
rHJxPoKMQOY0XVzSb/cQmCRV3Ch324abFyzDVD0FMDnuxJMPnFlF1AgXWrpd5Tly
ROAciilqPY/R+28uluTYEJeRMq8afC0AAWPipwGtc7P7M39KKPpIB1WySlyLv8R+
yfz7765ZL8HI4x32iGm+/fYUcJLnQ1bAHYkz+lQjZZr7YGyuvcd6Ns7sc2bpEIdN
1SPvyxtK6MAjjmor2s7yFzDIMHg4+0mAm4k6az+J2K7nZMgrI+60nIZnyoCg06EV
cKlEQOT4fY0Giq+fZHb66yuK2WNBnZ2ahD4rJTIugFe7ZWSgzyZpb1G9iiwAAXOA
MNqL4ghnOWT7C9ZLeNvdgU33X6pEu28fpD9bVZKH8w0DAeu0abo=
=Dbpx
-----END PGP SIGNATURE-----

--=-uvSLk0XX8n0WS5mCbr5y--

