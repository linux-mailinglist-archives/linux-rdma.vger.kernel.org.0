Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83B4D9F8
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfFTTJn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 15:09:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfFTTJm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 15:09:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D67130860BA;
        Thu, 20 Jun 2019 19:09:41 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29B645C1A1;
        Thu, 20 Jun 2019 19:09:40 +0000 (UTC)
Message-ID: <d4ba310e1cb50abd3810032fc468797edd917c08.camel@redhat.com>
Subject: Re: [PATCH V3 for-next] RDMA/hns: reset function when removing
 module
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Thu, 20 Jun 2019 15:09:37 -0400
In-Reply-To: <1560524163-94676-1-git-send-email-oulijun@huawei.com>
References: <1560524163-94676-1-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-lCbtIX+eSa6QSaNBO6lq"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 20 Jun 2019 19:09:42 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-lCbtIX+eSa6QSaNBO6lq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-06-14 at 22:56 +0800, Lijun Ou wrote:
> From: Lang Cheng <chenglang@huawei.com>
>=20
> During removing the driver, we needs to notify the roce engine to
> stop working immediately,and symmetrically recycle the hardware
> resources requested during initialization.
>=20
> The hardware provides a command called function clear that can package
> these operations,so that the driver can only focus on releasing
> resources that applied from the operating system.
> This patch implements the call of this command.
>=20
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> ---
> V2->V3:
> 1. Remove other reset state operations that are not related to
>    function clear



> +	msleep(HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_INTERVAL);
> +	end =3D HNS_ROCE_V2_FUNC_CLEAR_TIMEOUT_MSECS;
> +	while (end) {
> +		msleep(HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT);
> +		end -=3D HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT;



> +#define HNS_ROCE_V2_FUNC_CLEAR_TIMEOUT_MSECS	(249 * 2 * 100)
> +#define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_INTERVAL	40
> +#define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT	20

I absolutely despise code that does a possible *50* second blocking
delay using msleep.  However, because I suspect that this is something
that should *rarely* ever happen, and instead the common case is that
the reset will proceed much faster, and because this is in the
teardown/shutdown path of the device where it is a little more
acceptable to have a blocking delay, I've taken this to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-lCbtIX+eSa6QSaNBO6lq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0L2fEACgkQuCajMw5X
L90sAA//Q8yUJXzZhD1ELyMFk2gUBzHhzEDAN3AfcSPRRgi9q4rhYIX1AR4mq5VW
YYOZ2urWabMjvMLrptIaV9pw0HbSJYEMOfK6oDlwChf2YTmiKezkyb1UdGaVo13j
mZkTtza8XGWXy6pGIBeg2T8ddhhWN83Ybg4LXZAnk4OrrY3RJA2N1ANiKNMpwhjs
rGG4S6Ysi0qTaXBqEuP8D1PQVIh6A9Vwb5ACDMBCn0OZnoQpjY1JBhuYZg3C6paI
3S5J4dSBbRm3jN3BhR6JjtdSOMfxSmIAjUTAd1bboLrpWfFbzArBHaio3xIjms02
QAHM6Z/2II/wELUrOqqRP/6eT6U+djMp3tY7lTKI+6rSIaTQO9mbi7HQ+jMNHtzV
4zbUz5T7+dMlkpS7SuusjUfpylssAngEr/J2U9fASYHJgfj32zgIKsX1dKDP3vq0
ToHMHzXeMrdoPLM6pFRd4gnY9DZ8GWF8l/4l4YB3g4ARy8NTNzxPtHM5Im7o6ZwG
e7aA+T23bIimoPKkmnYZ5Z6bXPEunB8WJ018nFveuYZjZn2bGm2cGmqlDIKGBl8y
nHUr3KlZPVtsu9WkLIoKLNdr+xHPzj6WmCO38YLgvu8PoxrU57hPCKAv2lXo4r0g
ns8GhfEx5ispZGEzJwWlMVBZ+y3LBFA9mihPoh/oSyWxmaRABOk=
=D0Zy
-----END PGP SIGNATURE-----

--=-lCbtIX+eSa6QSaNBO6lq--

