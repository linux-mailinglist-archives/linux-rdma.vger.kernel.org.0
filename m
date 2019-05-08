Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4478917DE7
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfEHQNX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 12:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfEHQNW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 12:13:22 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431F6216B7;
        Wed,  8 May 2019 16:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557332001;
        bh=v5nOaJYneLXDBZYIgukQV4ksiHpUuJyv1FNq7NbA2t8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TgqMj4migc19VNP0RZ8F4n3TijSYleRubaQWCoXl38OLTwEheak1Pr4gDyR1Dw8/h
         VCS5pfW9uQ0xmRW8orzQK3Zd+dsCgs8ju9MxPgMByHMJNJr3RiwctzQg5S/7aBW+lh
         ID6oXHUJHsH2SZ1OPZEJE/hytslTVlzjbfQwnVTw=
Date:   Wed, 8 May 2019 19:13:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 02/12] SIW main include file
Message-ID: <20190508161306.GG6938@mtr-leonro.mtl.com>
References: <20190505170956.GH6938@mtr-leonro.mtl.com>
 <20190428110721.GI6705@mtr-leonro.mtl.com>
 <20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-3-bmt@zurich.ibm.com>
 <OF713CDB64.D1B09740-ON002583F1.0050F874-002583F1.005CE977@notes.na.collabserv.com>
 <OF11D27C39.8647DC53-ON002583F3.005609DE-002583F3.0057694C@notes.na.collabserv.com>
 <OFE6341395.7491F9CF-ON002583F4.002BAA7E-002583F4.002CAD7E@notes.na.collabserv.com>
 <OF21EE5DBF.E508AFF5-ON002583F4.004B49A6-002583F4.004D764A@notes.na.collabserv.com>
 <20190508142229.GD6938@mtr-leonro.mtl.com>
 <222d71d2fce5be8461d7fc35c221e832c9c1a162.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Content-Disposition: inline
In-Reply-To: <222d71d2fce5be8461d7fc35c221e832c9c1a162.camel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 11:41:37AM -0400, Doug Ledford wrote:
> On Wed, 2019-05-08 at 17:22 +0300, Leon Romanovsky wrote:
> > > It is a recommendation to choose a hard to predict memory
> > > key (to make it hard for an attacker to guess it). From
> > > RFC 5040, sec 8.1.1:
> > >
> > >    An RNIC MUST choose the value of STags in a way difficult to
> > >    predict.  It is RECOMMENDED to sparsely populate them over the
> > >    full available range.
> >
> > Nice, security by obscurity, this recommendation is nonsense in real life,
> > protection should be done by separating PDs and not by hiding stags.
>
> That rather misses the point.  The point isn't whether your PDs are
> separate, but whether a malicious third party can easily guess your next
> generated ID so it can be used in an attack.  This is security by
> obscurity, it's security by non-guessability, and it's been shown to be
> necessary multiple times over in network stacks.

ok

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD



--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQT1m3YD37UfMCUQBNwp8NhrnBAZsQUCXNMADQAKCRAp8NhrnBAZ
sQVpAQDCyJTxIMwnJmeevA23gLF25nm4P9hUm/UI2PkA03LULwD/RJ/4C7ccFoHM
NG6rPM5uCevXajfK5vIsHV5VSQdfmQk=
=8rZ0
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--
