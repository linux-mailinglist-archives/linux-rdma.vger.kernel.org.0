Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635EA117272
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2019 18:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfLIRIP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Dec 2019 12:08:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53261 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726538AbfLIRIP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Dec 2019 12:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575911294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=waScVUeDSycUf+PrN96I4z+R7/A+aBcxkketQWg+fiM=;
        b=MUTVDb8Mq7su+VKR8Opr9YvbQQfX4hY7c9mi+VRdMTcxvpbddqPCkEx/DHijNummt/6xUV
        YgvRkU2uG6EVeUs6XOhf2FVQPnIweqqW+Ble/s2NYThGRnzpVOcFf0EaDZO3F7VcMB39Hu
        JwjBdCddo9y5Fs5pBW/qkbzRyMoyHUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-EQSvobaJO0S_WUDWy8kurA-1; Mon, 09 Dec 2019 12:08:10 -0500
X-MC-Unique: EQSvobaJO0S_WUDWy8kurA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 847F91090B62;
        Mon,  9 Dec 2019 17:08:09 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-42.rdu2.redhat.com [10.10.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2DB279AC;
        Mon,  9 Dec 2019 17:08:08 +0000 (UTC)
Message-ID: <fcbf09317ccf0c3662616f38f1c0c3e874ec0c15.camel@redhat.com>
Subject: Re: [PATCH v2] RDMA/cma: add missed unregister_pernet_subsys in
 init failure
From:   Doug Ledford <dledford@redhat.com>
To:     Parav Pandit <parav@mellanox.com>,
        Chuhong Yuan <hslester96@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 09 Dec 2019 12:08:05 -0500
In-Reply-To: <005ae1f8-3241-4a7e-aa1e-eb26275d15a9@mellanox.com>
References: <20191206012426.12744-1-hslester96@gmail.com>
         <005ae1f8-3241-4a7e-aa1e-eb26275d15a9@mellanox.com>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-PkZpq8e+oUxr9ZBOflcr"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-PkZpq8e+oUxr9ZBOflcr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-06 at 04:32 +0000, Parav Pandit wrote:
> On 12/5/2019 7:24 PM, Chuhong Yuan wrote:
> > The driver forgets to call unregister_pernet_subsys() in the error
> > path
> > of cma_init().
> > Add the missed call to fix it.
> >=20
> > Fixes: 4be74b42a6d0 ("IB/cma: Separate port allocation to network
> > namespaces")
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> > Changes in v2:
> >   - Add fixes tag.
> >=20
> >  drivers/infiniband/core/cma.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/infiniband/core/cma.c
> > b/drivers/infiniband/core/cma.c
> > index 25f2b70fd8ef..43a6f07e0afe 100644
> > --- a/drivers/infiniband/core/cma.c
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -4763,6 +4763,7 @@ static int __init cma_init(void)
> >  err:
> >  =09unregister_netdevice_notifier(&cma_nb);
> >  =09ib_sa_unregister_client(&sa_client);
> > +=09unregister_pernet_subsys(&cma_pernet_operations);
> >  err_wq:
> >  =09destroy_workqueue(cma_wq);
> >  =09return ret;
> >=20
> Reviewed-by: Parav Pandit <parav@mellanox.com>

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-PkZpq8e+oUxr9ZBOflcr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl3uf3UACgkQuCajMw5X
L9389A//XLWJPE7g6hqtjC/3TatYIkTJLtyosceKCgRgYpear/j1W49VM+EnC3aS
7nWsEyffVueWMDdorNzXnwAlSUWzxwQNJZ92u17uABb6bUOvWjO2ccaSIprgEHQg
RnCDKsderPFMkfH9EsA8uZk5wXtci8Vu1wzl7oHZfQzyjhznwCVIjtV4SGYGhgMO
XtsZCrvWxPdpHn50d3WSrf6jKCOtCUDLBxW/1mM48h3svwk2u30wmmzwftKCH6db
bODbTchBbiJ8SKbGuuezHQPeU2rSQiXJC8w+ENrgmVmFeTjgjTVfithviLU+snp8
lh9r/TvpCuq+qcseL2hDr8tsayTteyi7+ORIeZM+yk+jIRATxeYN/8O00Og2qwLn
e0M46dtpSOAD9NiGmPaW62KSNsenhLqRh4QDY9CztbUe/2bgfu9URrrEpC6yZPSz
5AqIVER07cEtjncBopvueHuMWNZzrynfevdykjZGXsMvqhbVpfpYlrh886VosbZ+
ytD97uMajUnmxIjmnGBMd6yLpquG2c6O4zyW9HITfrj4EDzB0ntZW7hRnLUVhpse
7EpLfT1KKm6c5buD+1n6okvuDg0l13b7qr1AhP8Cu2sMvAHLZ6t1NpKGOfr6tbQd
uzYh5pDZJzyvmRTXdteHBEUBwVICqxJG0ORFgEz+pwhnt/2xAaE=
=iVCy
-----END PGP SIGNATURE-----

--=-PkZpq8e+oUxr9ZBOflcr--

