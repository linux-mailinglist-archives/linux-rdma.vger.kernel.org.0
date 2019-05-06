Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037CC154F6
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 22:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEFUig (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 16:38:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61291 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfEFUif (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 16:38:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E020930833BF;
        Mon,  6 May 2019 20:38:34 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-3.rdu2.redhat.com [10.10.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9ACE3DA5;
        Mon,  6 May 2019 20:38:33 +0000 (UTC)
Message-ID: <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
Subject: iWARP and soft-iWARP interop testing
From:   Doug Ledford <dledford@redhat.com>
To:     linux-rdma <linux-rdma@vger.kernel.org>
Cc:     "Gunthorpe, Jason" <jgg@ziepe.ca>,
        Bernard Metzler <BMT@zurich.ibm.com>
Date:   Mon, 06 May 2019 16:38:27 -0400
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZuHpwLIaC4enCJbtXy27"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 06 May 2019 20:38:35 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-ZuHpwLIaC4enCJbtXy27
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So, Jason and I were discussing the soft-iWARP driver submission, and he
thought it would be good to know if it even works with the various iWARP
hardware devices.  I happen to have most of them on hand in one form or
another, so I set down to test it.  In the process, I ran across some
issues just with the hardware versions themselves, let alone with soft-
iWARP.  So, here's the results of my matrix of tests.  These aren't
performance tests, just basic "does it work" smoke tests...

Hardware:
i40iw =3D Intel x722
qed1 =3D QLogic FastLinQ QL45000
qed2 =3D QLogic FastLinQ QL41000
cxgb4 =3D Chelsio T520-CR



Test 1:
rping -s -S 40 -C 20 -a $local
rping -c -S 40 -C 20 -I $local -a $remote

                    Server Side
	i40iw		qed1		qed2		cxgb4		siw
i40iw	FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]
qed1	FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]
qed2	FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]
cxgb4	FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]
siw	FAIL[2]		FAIL[1]		FAIL[1]		FAIL[1]		Untested

Failure 1:
Client side shows:
client DISCONNECT EVENT...
Server side shows:
server DISCONNECT EVENT...
wait for RDMA_READ_ADV state 10

Failure 2:
Client side shows:
cma event RDMA_CM_EVENT_REJECTED, error -104
wait for CONNECTED state 4
connect error -1
Server side show:
Nothing, server didn't indicate anything had happened

Obviously, rping appears to be busted on iWARP (which surprises me to be
honest...it's part of the rdmacm-utils and should be using the rdmacm
connection manager, which is what's required to work on iWARP, but maybe
it just has some simple bug that needs fixed).

Test 2:
ib_read_bw -d $device -R
ib_read_bw -d $device -R $remote

                    Server Side
	i40iw		qed1		qed2		cxgb4		siw
i40iw	PASS		PASS		PASS		PASS		PASS
qed1	PASS		PASS		PASS		PASS		PASS[1]
qed2	PASS		PASS		PASS		PASS		PASS[1]
cxgb4	PASS		PASS		PASS		PASS		PASS
siw	FAIL[1]		PASS		PASS		PASS		untested

Pass 1:
These tests passed, but show pretty much worst case performance
behavior.  While I got 600MB/sec on one test, and 175MB/sec on another,
the two that I marked were only at the 1 or 2MB/sec level.  I thought
they has hung initially.

Test 3:
qperf
qperf -cm1 -v $remote rc_bw

                    Server Side
	i40iw		qed1		qed2		cxgb4		siw
i40iw	PASS[1]		PASS		PASS[1]		PASS[1]		PASS
qed1	PASS[1]		PASS		PASS[1]		PASS[1]		PASS
qed2	PASS[1]		PASS		PASS[1]		PASS		PASS
cxgb4	FAIL[2]		FAIL[2]		FAIL[2]		FAIL[2]		FAIL[2]
siw	FAIL[3]		PASS		PASS		PASS		untested

Pass 1:
These passed, but only with some help.  After each client ran, the qperf
server had to be restarted or else the client would show this error:
rc_bw:
failed to receive RDMA CM TCP IPv4 server port: timed out

Fail 2:
Whenever cxgb4 was the client side, the test would appear to run
(including there was a delay appropriate for the test to run), but when
it should have printed out results, it printed this instead:
rc_bw:
rdma_disconnect failed: Invalid argument

Fail 3:
Server side showed no output
Client side showed:
rc_bw:
rdma_connect failed

So, there you go, it looks like siw actually does a reasonable job of
working, at least at the functionality level, and in some cases even has
modestly decent performance.  I'm impressed.  Well done Bernard.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-ZuHpwLIaC4enCJbtXy27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzQm0MACgkQuCajMw5X
L92k5w//QxNVMiccYHxqBrv9wEBHhDXqFNSWJMoxy1V4WDSb7/fB3kUGcEox6Tz0
djYRWDqIucQqiJrJs7aT4H4+iOZh5X+9NUD42R06qlpNXK+al/cBA/se59hIhruC
4YsmLBat5SGDPjaSOOaVaSEkZaoybWvZ0BbaD0cnuWSI7lWjdr+NefCtyatKONB4
VPjLcAGgaN851bS87otTz6rOo+45Kk/CgJ11Fww+fderL11hLt5fBW+UI3ZMrhRf
nIXf3QK18p3BNXBu6FzySVmLwVKeBL8YPZ90p8oXu+1eoY0QyTli+jMUs6zZPHTg
4LkyPuv8EUIuV49qgSwPbAkVrhlGP3Rg7SSnvZ3uZAcR2aG539cSPBdMBkUVyYbB
p+26rlIrtOxkWPjL7JLSDBtEwIjGUls0Bv/X0RgCDbkYUYvXrySRO3jgH1SqJWcs
eAgFno4WbWbHFRi1+WMXW7Ro3yWR7KgiMQHwiOyP/fl/QmXOm5ylbEsdvRq9zmZD
AnvKtYWXlew1I8oeSh/Ec3Oz5CcklBxxZM27FM625VBij0v5GZYUAHVzHhcJJAGI
xfJsfKKDhmU1Qglws0o6yu4pScTD2IyxnFr0W2rZbzNA1Us8Yn/cMpbd2dKXViG4
b0LP7TIma78hmDjO4JMWMp6+btj8yZ5CnVne+YAm5TApxExD67g=
=Ikfb
-----END PGP SIGNATURE-----

--=-ZuHpwLIaC4enCJbtXy27--

