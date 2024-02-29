Return-Path: <linux-rdma+bounces-1177-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C886D664
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Feb 2024 22:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5D71F23E48
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Feb 2024 21:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D36D51B;
	Thu, 29 Feb 2024 21:51:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FBB6D50D
	for <linux-rdma@vger.kernel.org>; Thu, 29 Feb 2024 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243507; cv=none; b=UoHM+FtwTsxPVX76C6dY+B8KXPg81JZctglDn0Ka36dSXzC/pJG1/JqMT2WTEJVYEBlKxnRXCfZetpz4FdGt7S8nWzyRK06XLMsaFD9NyWp6wCVoNcw5UZ5gSp6b1HgZR06lQn1pRzTRA1ahpbuFQNFzjGc3uU3JL4U7AZdv88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243507; c=relaxed/simple;
	bh=lTSCtbIaRm6WV7aUszukfpoQOedRgGr+iyRaIZSkRn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=oGZqTX085XO5nV9UryQaLZq5LbznVqAyxwoURlJP+K83vhUe6KVa2gdT3Uf6wnFXB3q4Ilmlki1NPqWpSSdqHi2mq9wOnImc6j+V6CVhhnRbo+3AWgp2cLD5XtEqxtiWydekj158zsHd/4nX1KkzKMKvg/rAu/Ke9PYpHa7DcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-238-TFXAcaIDM1y3ttMNu7WjKA-1; Thu, 29 Feb 2024 21:51:36 +0000
X-MC-Unique: TFXAcaIDM1y3ttMNu7WjKA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Feb
 2024 21:51:35 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Feb 2024 21:51:34 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kuniyuki Iwashima' <kuniyu@amazon.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Allison Henderson
	<allison.henderson@oracle.com>
CC: Kuniyuki Iwashima <kuni1840@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>
Subject: RE: [PATCH v2 net 3/5] net: Convert @kern of __sock_create() to enum.
Thread-Topic: [PATCH v2 net 3/5] net: Convert @kern of __sock_create() to
 enum.
Thread-Index: AQHaaRoH7RruzneFAEWJZ40+AXQHpbEh3qiA
Date: Thu, 29 Feb 2024 21:51:34 +0000
Message-ID: <fdd655490688410497d82ff3d38da093@AcuMS.aculab.com>
References: <20240227011041.97375-1-kuniyu@amazon.com>
 <20240227011041.97375-4-kuniyu@amazon.com>
In-Reply-To: <20240227011041.97375-4-kuniyu@amazon.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Kuniyuki Iwashima
> Sent: 27 February 2024 01:11
> Subject: [PATCH v2 net 3/5] net: Convert @kern of __sock_create() to enum=
.

Should probably be (something like):
=09Allow __sock_create() create kernel sockets that hold a reference
=09to the network namespace.

> Historically, syzbot has reported many use-after-free of struct
> net by kernel sockets.
>=20
> In most cases, the root cause was a timer kicked by a kernel socket
> which does not hold netns refcount nor clean it up during netns
> dismantle.
>=20
> This patch converts the @kern argument of __sock_create() to enum
> so that we can pass SOCKET_KERN_NET_REF and later sk_alloc() can
> hold refcount of net for kernel sockets.

I think you should add a 'hold netns' parameter to sock_create_kern().
Indeed, that is likely to be used for a real connection
(which would need the 'hold netns') and code that doesn't need it
(because the socket is some internal housekeeping socket) could
directly call __sock_create().

Fortunately both functions are exported non-gpl.

I've this comment in a driver...

    /* sock_create_kern() creates a socket that doesn't hold a reference
     * to the namespace (they get used for sockets needed by the protocol
     * stack code itself).
     * We need a socket that holds a reference to the namespace, so create
     * a 'user' socket in a specific namespace.
     * This adds an extra security check which we should pass because all t=
he
     * sockets are created by kernel threads.
     */
    rval =3D __sock_create(net, family, type, protocol, sockp, 0);


=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


