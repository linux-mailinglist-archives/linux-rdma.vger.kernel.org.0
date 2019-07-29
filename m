Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 174EE7929D
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 19:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfG2Rvc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 13:51:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfG2Rvb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 13:51:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93258308404F;
        Mon, 29 Jul 2019 17:51:31 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE94D19C67;
        Mon, 29 Jul 2019 17:51:30 +0000 (UTC)
Message-ID: <d747a90fafce1d191072dd5f67c2dd1c251d6ab4.camel@redhat.com>
Subject: Re: [PATCH rdma-next] IB/bnxt_re: Do not notifify GID change event
From:   Doug Ledford <dledford@redhat.com>
To:     Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, selvin.xavier@broadcom.com
Date:   Mon, 29 Jul 2019 13:51:28 -0400
In-Reply-To: <20190726182652.50037-1-parav@mellanox.com>
References: <20190726182652.50037-1-parav@mellanox.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gspRUl0pmvWh6M2GqhHd"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 29 Jul 2019 17:51:31 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-gspRUl0pmvWh6M2GqhHd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-07-26 at 13:26 -0500, Parav Pandit wrote:
> GID table entry operations such as add/remove/modify are triggered
> by the IB core for RoCE ports.
> Hence, remove GID change notification from hw driver.
>=20
> Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
> Tested-by: Selvin Xavier <selvin.xavier@broadcom.com>
> Signed-off-by: Parav Pandit <parav@mellanox.com>

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-gspRUl0pmvWh6M2GqhHd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0/MiAACgkQuCajMw5X
L90zHRAAs8LRoZuvz+29EyPj1JZLMsHnEwQxBIgb+WHBIEqOjuuVtlrb919jiY2B
ly59kwfwdXL1XQKk4R3yzWjQo2WaJ8XEwbOpTsxzgu1hzlJq2ysQnxe/RP0I8Ece
EXJqxik8PUWJ74uCamWxZ2fKP/QrbO0LKr3dIvItCLTXDTSfi6TmkPdHVolSa+rC
jmrlgo/DZLHsJbVnuBm3EPNDFYz7x+1UulWfBRu/CvVdM3b9DN4bHW/yLua01mmu
sbzHKafjpzKkF1tcTt9TBO1Qk+fgRoHYgp08U40nkdtbDYW8/kG3gePNFlZSXnXZ
s/n4spOVFMDEa4d751SoMmNLty0y/IdmPYuT451uEhXyto88CFKX5jkYGXF7ObM4
1RCMi7yLt8Y4KbUpQI8s4FQaF3py56CjFN1wMgXKtv/1+RwkiRPVqvNK9uRR/8p7
1lapORF2mAYfuKId3XmBW6EH1Wq7r9bf1LJRcofcYXGDcetnSMbrNjh8PJWzXzyK
AT2ByR4JNCGGCPSh2eeP4FHS7/FTZ54MA53Y7DUnSOb2nNfe45NPGKeLy3A4bEKF
BTctZ+llh6NOKPHNCGRXhDJJNsZDP7shm1k5p2jB3UKmdiXSEg71uirI3Ot1vw9K
Wd3gfDHzkZCx71EMg5Py/MF5mZlrUSDcEbua8xK1ilAejo+A9uQ=
=7uqs
-----END PGP SIGNATURE-----

--=-gspRUl0pmvWh6M2GqhHd--

