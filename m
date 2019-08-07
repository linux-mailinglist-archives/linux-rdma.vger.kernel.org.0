Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C7B853D5
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 21:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbfHGTnE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 15:43:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388270AbfHGTnE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 15:43:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3B893C92D;
        Wed,  7 Aug 2019 19:43:03 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-53.rdu2.redhat.com [10.10.112.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD3F11001284;
        Wed,  7 Aug 2019 19:43:02 +0000 (UTC)
Message-ID: <ed1a93475719e1d735806de6eb0e5703ca55d34e.camel@redhat.com>
Subject: Re: [PATCH V3 for-next 05/13] RDMA/hns: Clean up unnecessary
 initial assignment
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Wed, 07 Aug 2019 15:42:59 -0400
In-Reply-To: <1564821919-100676-6-git-send-email-oulijun@huawei.com>
References: <1564821919-100676-1-git-send-email-oulijun@huawei.com>
         <1564821919-100676-6-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ay87SwJGUZszmKTdl+/a"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 07 Aug 2019 19:43:03 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-ay87SwJGUZszmKTdl+/a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-08-03 at 16:45 +0800, Lijun Ou wrote:
> -       unsigned int sge_ind =3D 0;
> +       unsigned int sge_ind ;

Whitespace damage after fix.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-ay87SwJGUZszmKTdl+/a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1LKcMACgkQuCajMw5X
L92hWxAAnaGXIcOF0/uOaA+dEvr7LSK0kLDgltxIzy13DacaqyO9FkAU55yNVqcY
SYjhAcraIVkXxFtMcwsFCca66+JJq20cEBed7KTLqIaQjUM+QuaeYBMVB5D3OGG/
0g6PCpWRKaeleZnzegnEeSnmckx7ngshvNS35Di+QPU6THVOgpxNgCN6RALJZqdZ
yMzDPQBOAAuOC+rkB7ZI6F8HoSMOAgE1WQzR0Tx9AKg0VsdEy4JM3MKOdMFogsBd
jwmcy41HIYx6ko3iP5CWXQNcU96UZY8Iu6AfNNu2EDINekTuQEmAJKo3dgKiKebA
1J7SBB002mJGPN8SmdYmNmc9hh3vYOx8eR0t67Bk4iBewpP6N1tal8H4I4m+Now/
U6QqmwjDoUpMIIZzDzIczylI1yUaY9ph29dD8JNTMT+gSs2XXEPEk9MQqIWr850C
w0FfgxROJVMzHy6QXshYB1+4OUfydkuMffMVn+uJQggI0yKeGXxLSulPAYjX4jp3
9xrPrDTsuFA0Dz3CH4a9x/DC/7s2jrOTwF/ed7ek4nvrQkMDX9h4S94nJKHqP2WB
BbDhLimeY/W44e64q62Wncut54WOT3RZL8xhWW9+bIcMKXhuT9xmKYpMOwbiJaMN
yHDzzUewqhxlQ3AWRIJK0NIGwHiK5OVGNsiWPnbNFvoi9VeAG3Y=
=uE1Q
-----END PGP SIGNATURE-----

--=-ay87SwJGUZszmKTdl+/a--

