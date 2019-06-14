Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5682B467F5
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 21:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfFNTAg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 15:00:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfFNTAg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 15:00:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DF00307C941;
        Fri, 14 Jun 2019 19:00:36 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8093060487;
        Fri, 14 Jun 2019 19:00:35 +0000 (UTC)
Message-ID: <4b271896e1f3e643ccc5824ff6ac419787c52910.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Date:   Fri, 14 Jun 2019 15:00:32 -0400
In-Reply-To: <20190614003819.19974-3-jgg@ziepe.ca>
References: <20190614003819.19974-1-jgg@ziepe.ca>
         <20190614003819.19974-3-jgg@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4IxW+qinJfkXoJqRplrq"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 14 Jun 2019 19:00:36 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-4IxW+qinJfkXoJqRplrq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-13 at 21:38 -0300, Jason Gunthorpe wrote:
> +       if (ibdev)
> +               ret =3D __ib_get_client_nl_info(ibdev, client_name,
> res);
> +       else
> +               ret =3D __ib_get_global_client_nl_info(client_name,
> res);
> +#ifdef CONFIG_MODULES
> +       if (ret =3D=3D -ENOENT) {
> +               request_module("rdma-client-%s", client_name);
> +               if (ibdev)
> +                       ret =3D __ib_get_client_nl_info(ibdev,
> client_name, res);
> +               else
> +                       ret =3D
> __ib_get_global_client_nl_info(client_name, res);
> +       }
> +#endif

I was trying to put my finger on something yesterday while reading the
code, and this change makes it more clear for me.  Do we really want to
limit the info type based on ibdev?  It seems to me that all global
info retrieval should work whether you open a specific ibdev or not.=20
It's only the things that need the ibdev to return the correct response
that should require it.  Right now we only have one global info
provider, but would it be better to do:

	if (!strcmp("rdma_cm", client_name))
		ret =3D __ib_get_global_client_nl_info(client_name, res);
	else
		ret =3D __ib_get_client_nl_info(ibdev, client_name, res);

The other thing I was wondering about was the module loading.  Every
attempt to load a module is a fork/exec cycle and a context switch over
to modprobe and back, and we make no attempt here to keep each
invocation of the netlink query from requesting a module.  I'm
concerned this is actually a potential DoS attack vector.  I was
thinking we should track each client name that's valid, and only try
each name once.  I saw four module names: rdma_cm, umad, issm, and
uverbs.  I'm wondering if we should have a static table in the netlink
file with an entry for each of the client names and a variable to
indicate we've attempted to load that module, and on -ENOENT, we check
the table for a match to our passed in client_name, and only if we have
a match, and it's load count is 0, do we call request_module() and
increment the load count.  Thoughts?

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-4IxW+qinJfkXoJqRplrq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0D7tAACgkQuCajMw5X
L91U5BAAsykH9LjHKVQCqlpyZMEsIv8KvN3uTOyK2RuOO5zLeh1PP1/+tPIhyAk6
kv0/6/6X/tvo+MspIukMoAwkSnmOEEYKLwYuZ4DgF1houAJv/CapUNooXwbn/hn0
pmvYrwP77cxnAsD1FAUpGqIWfGM5McOcP1xqQAqLUYZ0PIeJF31VYcokbI++AJHj
oDXqg4LNNrSJG24XTNM12ed/6hM4ExSFON0DziSFZW6CC+wASMSIYshvExEjnUn4
5ggFzuvB4ubP5s9u7N413w2RpcjhVELeF9BD918iqeZBnw72qEI7IkyAMfrv67/l
B05ooLJQEtvYt3Eg8w1R06bICBD7W1aSqPCgEQbt1JJnUuTKhZcdpPI6qD8MI8ku
6Y459TrWq8Lis3cS7osoRFbbVWlfDutnDnXtpPRpHHFF8gmk074ocF9oSEgK5E3S
rK1kqPQj/hicOsd43GEzmbMOWnfcQ/VdW8zWpiD1NJEQlxdPWXBq9TMn9LdgLvI1
KW4jkKTNnZnu1zFBffTU4rSR+odSJsCVvu8KCBalmgfL2BZFFfrd7xfZGC+xbvFl
2Urr6YA3b0VAu+lXvwoNnp9HFuBazgZ0zWextyRLxJJjztr962Ee5Jz1Tqt06aYF
ssOTAxgQFXpntL986AAkDCzgXEb4UKHt3MV8gZNdh+xMSnUmvUI=
=2IJf
-----END PGP SIGNATURE-----

--=-4IxW+qinJfkXoJqRplrq--

