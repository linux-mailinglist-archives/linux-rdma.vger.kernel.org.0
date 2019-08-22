Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2FD997AC
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbfHVPFJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 11:05:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387546AbfHVPFJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 11:05:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B271C3082128;
        Thu, 22 Aug 2019 15:05:08 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFF5260925;
        Thu, 22 Aug 2019 15:05:07 +0000 (UTC)
Message-ID: <26ae8c4006cb31ee8c26fb821451d43732c7a35a.camel@redhat.com>
Subject: Re: [PATCH for-rc v2] RDMA/bnxt_re: Fix stack-out-of-bounds in
 bnxt_qplib_rcfw_send_message
From:   Doug Ledford <dledford@redhat.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 22 Aug 2019 11:05:05 -0400
In-Reply-To: <1566468170-489-1-git-send-email-selvin.xavier@broadcom.com>
References: <1566468170-489-1-git-send-email-selvin.xavier@broadcom.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-vslb/vdnHvaWXhcMvDdn"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 22 Aug 2019 15:05:09 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-vslb/vdnHvaWXhcMvDdn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-22 at 03:02 -0700, Selvin Xavier wrote:
> Driver copies FW commands to the HW queue as  units of 16 bytes. Some
> of the command structures are not exact multiple of 16. So while
> copying
> the data from those structures, the stack out of bounds messages are
> reported by KASAN. The following error is reported.

[ snip ]

Much less churn, thanks.  Applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-vslb/vdnHvaWXhcMvDdn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1eryEACgkQuCajMw5X
L93LVA//WkJmpTl4FOhiHummh6/De9kx7ohHaLc8blsXeCQte2VLbf/OQwE+185T
5xsnBSueGgfzDje0y6e9E+SEB5BqLbHgCWqzByonC4Ppk7jlqFy9Ob/OHtrk7LFf
Bs7FmzRzLgWxH7KqZUgkDx6HsHYSA33HZqXjnqdJuuwsIz7sYuHUbeNWOCIBlWDY
jxTFX84kddyesLdsjYOQVDIjXztTKnNajexiawsZ8dDsUil8kfmuwLgYCRsgrWNx
A27ILQW8LObRMZ7liRvDDddBPJEflq8WfS7W1DjiQZHLnTsQRDKlPbCiZT5InfR8
f7Kp6QgIpkRZSYdS0H7vuv4FU1PYzyGvEip+rd+yzcfhyr2sqpH/vXUgoiqsEFdW
l2AXKAyh/k9RMdRhrLsVBdL9NRuyZWrcaymTvJgklLfhnnB6escjrb7Lf467tJ2O
sMVOULAdHjLxJ2MteP7jAc0GNMDfyAL42meqXOntdCwtTnQn3cWoDtPIH3Uv08mj
hm6GLaLMGjXbfi0+gIY2/UMqCXPaG08o3EFFVcttTdzMBsAbOgy72qzPWi5yeiGu
gxkhlIbqbKIQ3C0Ie3LNNHxUPt/CWyLsyFaJ7ioptyJOmX9MUsXtqVte1sb9lkYf
DD07WiFZiCzri+jKTboT8L9DsugCTnUR+bGRcdAoZhq6OpfZaaA=
=xnw2
-----END PGP SIGNATURE-----

--=-vslb/vdnHvaWXhcMvDdn--

