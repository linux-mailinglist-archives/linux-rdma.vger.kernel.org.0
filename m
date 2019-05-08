Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66A6017094
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 07:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfEHFwU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 01:52:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:40636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728109AbfEHFwU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 01:52:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E931AE27
        for <linux-rdma@vger.kernel.org>; Wed,  8 May 2019 05:52:18 +0000 (UTC)
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [ANNOUNCE] rdma-core: new stable releases
To:     linux-rdma@vger.kernel.org
Message-ID: <013fc422-ec3f-aaca-8bc4-cd3661fd6b7f@suse.com>
Date:   Wed, 8 May 2019 07:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These version were tagged/released:
 * v15.8
 * v16.8
 * v17.5
 * v18.4
 * v19.3
 * v20.3
 * v21.2
 * v22.2
 * v23.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v15.8
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri May 3 08:06:22 2019 +0200

rdma-core-15.8:

Updates from version 15.7
 * Backport fixes:
   * mlx5: Fix masking service level in mlx5_create_ah
   * cmake: Explicitly convert build type to be STRING
   * buildlib: Ensure stanza is properly sorted
   * mlx4: Allow loopback when using raw Ethernet QP
   * travis: Change SuSE package target due to Travis CI failures
   * cbuild: fix tumbleweed docker image
   * libhns: Bugfix for using buffer length
   * mlx5: Fix incorrect error handling when SQ wqe count is 0
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAlzL2mIcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZCP6B/90JqJ4MRaTOtHMK9xE
p6tSN8ww9viZDtTk1PHzAMMpeopVwjYVzq1UuJLdyPQI1Xcg4QTOEv4mJX0BnBmF
9FG3cYCSmh7WKBUiNQPXHhpRGFWWzGagsHJ/6LzOK6ItDgI9u4/L13jn1yxWQ6IH
ucQUCe4Yf9pLWG81llRKOpFNkn8z3Qxjm2tdDxJ3fDpjGb1UQi2VO3Bn77Hd0NQP
OvdVDegzAP/aDS5bboVcfV32nz7sqORXjOf18QmYO8qoZ42usNh2TSXPKEzosTN9
SKNSIq+DAPNxuUvoYnR4dV2SiLAOCx0CZ36cBqil5KA5oKF1tmBskqzmMdo0xrNb
dHCn
=XYEr
-----END PGP SIGNATURE-----

tag v16.8
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri May 3 08:06:36 2019 +0200

rdma-core-16.8:

Updates from version 16.7
 * Backport fixes:
   * mlx5: Fix masking service level in mlx5_create_ah
   * cmake: Explicitly convert build type to be STRING
   * libhns: Bugfix for filtering zero length sge
   * buildlib: Ensure stanza is properly sorted
   * mlx4: Allow loopback when using raw Ethernet QP
   * travis: Change SuSE package target due to Travis CI failures
   * cbuild: fix tumbleweed docker image
   * libhns: Bugfix for using buffer length
   * mlx5: Fix incorrect error handling when SQ wqe count is 0
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAlzL2m4cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZL1xB/9xEJtqXS6lbl+D8jkA
9nJCrTNAZPy+4EZ7i/u9uHlRWTifsHNu0PT0b+8ED6b3bYjREk3660/Y3LVhhr49
AY2ZEdqUvBb0SyLNwJKzjmV+gIepQ1QMz2ku+M2px82YhC/5vEpy1n2jFGU8uVi1
oL2w1VisGsUorQuROlxph3/3FsCCEaxJqahpvfTCdq1RX7gR/co4u8vknNtD1mpo
f+uXOImFViqMwmP/dRKqD6pmJmFBQc62lGpmLvqZB2UXpFf8i/iEpCkk1gcz7wR7
M5hWPdx5+Gfwz8eiM0sKEGQhXDH/Yovw2glMRQz6SbVABhmBP//c1kCO27NwX28c
3ciw
=faJY
-----END PGP SIGNATURE-----

tag v17.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri May 3 08:06:46 2019 +0200

rdma-core-17.5:

Updates from version 17.4
 * Backport fixes:
   * verbs: The ibv_xsrq_pingpong "-c" option is broken
   * mlx5: Fix masking service level in mlx5_create_ah
   * cmake: Explicitly convert build type to be STRING
   * libhns: Bugfix for filtering zero length sge
   * buildlib: Ensure stanza is properly sorted
   * mlx4: Allow loopback when using raw Ethernet QP
   * travis: Change SuSE package target due to Travis CI failures
   * cbuild: fix tumbleweed docker image
   * libhns: Bugfix for using buffer length
   * mlx5: Fix incorrect error handling when SQ wqe count is 0
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAlzL2ngcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZHtlB/9UPdrk2id5ni3YygTr
N6A7oYES76GGE8WEB5x38b6JrqVAh4gkgb5GQUGtcB7ToA+RnVi62qaht6Fdq/d8
DA7juig16xLJI77yMaUMTjN9GPdhY5fYcL800e/KaCXEdSQabZyJfDbdwOFfd20n
8r0SWCPXO+9hgk9ytzrs1sG7NuJ5cJo1HADv51a2TeS8KiRAeJAsa78npSC/Uwms
C0PblXBODOvLwW2kma727+I4oNm+uhWrtleVmc+swC7RUU8kC3i/o7IYXlqwr+L5
lgMfcobMNoJrr7AzaehkWDJ5fqK+N4Wm4acVKr6o/32zwfegTYOAsYyMh88qs7o+
Ea/L
=P8g3
-----END PGP SIGNATURE-----

tag v18.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri May 3 08:06:52 2019 +0200

rdma-core-18.4:

Updates from version 18.3
 * Backport fixes:
   * ibacm: fix double hint.ai_family assignment in ib_acm_connect_open()
   * ibacm: acme does not work if server_mode != unix
   * ibacm: ib_acm_connect() is doing too much
   * verbs: The ibv_xsrq_pingpong "-c" option is broken
   * mlx5: Fix masking service level in mlx5_create_ah
   * cmake: Explicitly convert build type to be STRING
   * libhns: Bugfix for filtering zero length sge
   * buildlib: Ensure stanza is properly sorted
   * mlx4: Allow loopback when using raw Ethernet QP
   * travis: Change SuSE package target due to Travis CI failures
   * cbuild: fix tumbleweed docker image
   * verbs: Avoid inline send when using device memory in rc_pingpong
   * mlx5: Use copy loop to read from device memory
   * libhns: Bugfix for using buffer length
   * mlx5: Fix incorrect error handling when SQ wqe count is 0
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAlzL2n4cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZHwTB/9RO7VgcnTbbdMmYVWV
UMAYK8Vlp9Lq2CvLaYIu/1m4yvg2i9OiFXlPut5hkL58ztefwAV0E+X6tN5fLEfX
CSHaRfGd/OvgsOoK2PJTFFsBTGcZuPjfWuKO+XkbZf8kM7z0pLV2veI6DGMSKV+v
vczJKXqA952I9r3M6EjXkUAU8kLqUZw86Je0J/Nh6JflvR55r9bWHCF3X3+5D1b/
YqzoiaYm6qyVVWk/1f/FX0h2J8MeGt5we7GTlAU9087sC9TxxddYkWfsP6juJGrc
yVP0H8fPzDBAJ7uFM9H8A6Su4ZLwnBmPbbigPv0D9I8pnL1FFP8vqnqV4urbdo4o
L1lJ
=o5I6
-----END PGP SIGNATURE-----

tag v19.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri May 3 08:06:57 2019 +0200

rdma-core-19.3:

Updates from version 19.2
 * Backport fixes:
   * ibacm: fix double hint.ai_family assignment in ib_acm_connect_open()
   * ibacm: acme does not work if server_mode != unix
   * ibacm: ib_acm_connect() is doing too much
   * verbs: The ibv_xsrq_pingpong "-c" option is broken
   * mlx5: Fix masking service level in mlx5_create_ah
   * cmake: Explicitly convert build type to be STRING
   * libhns: Bugfix for filtering zero length sge
   * buildlib: Ensure stanza is properly sorted
   * mlx4: Allow loopback when using raw Ethernet QP
   * travis: Change SuSE package target due to Travis CI failures
   * cbuild: fix tumbleweed docker image
   * verbs: Avoid inline send when using device memory in rc_pingpong
   * mlx5: Use copy loop to read from device memory
   * libhns: Bugfix for using buffer length
   * mlx5: Fix incorrect error handling when SQ wqe count is 0
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAlzL2oQcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZNnRB/0T4H+ZlarzMMq+S2BL
SB9KqEeapL55fGFworU1olE0gkf/reyV+7NY0GAoJoUUQYbVoTcqMej+JvLhr0zq
dNGpqBYUvXqiRbLFEpGJgyxixfkSmY8q4Pk0bQN1FQudrCEAXGobyztgwg+81EZp
Q/4/n86WBBSLkBO0hHo74Uj5L14LPO85MKaGICVY6teUr1HlXBBRo3z/iIWaERiX
aPtbSaUaeJ/EehAtXr5sdkyx+rTpe9S6AeAzW/AFtNdPa87dCUb634l3E66xiFjT
6CdfLv/TFz+v3eu6ifEwCwi40m4HvIFuvZX93WL7yfKEiE+DUsobQZDszJ2ZoQcO
Rk/O
=SNtL
-----END PGP SIGNATURE-----

tag v20.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri May 3 08:07:03 2019 +0200

rdma-core-20.3:

Updates from version 20.2
 * Backport fixes:
   * ibacm: fix double hint.ai_family assignment in ib_acm_connect_open()
   * ibacm: acme does not work if server_mode != unix
   * ibacm: ib_acm_connect() is doing too much
   * verbs: The ibv_xsrq_pingpong "-c" option is broken
   * mlx5: Fix masking service level in mlx5_create_ah
   * cmake: Explicitly convert build type to be STRING
   * libhns: Bugfix for filtering zero length sge
   * buildlib: Ensure stanza is properly sorted
   * mlx4: Allow loopback when using raw Ethernet QP
   * travis: Change SuSE package target due to Travis CI failures
   * cbuild: fix tumbleweed docker image
   * verbs: Avoid inline send when using device memory in rc_pingpong
   * mlx5: Use copy loop to read from device memory
   * libhns: Bugfix for using buffer length
   * mlx5: Fix incorrect error handling when SQ wqe count is 0
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAlzL2okcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZNoiCACU0gDJ+kpNYdKdjXwk
oolNGOygMtXV0K31SebB0d4lL7UN6DGA62Oi9k9w4iLYrI4eLqwPwqmhj/iJ/ouu
CG/g5DFHGXaUEW22BesKY/jsBddJnqv7NTiC8/9BBeLErPzLe1BKHeEZGm+XZ6eV
E2Lof3DV3M6kMslAeSZt8GcaYJ43C2eCf4NalrHUX5mWclJQqwS9SXzqBlqLxQSh
+CZGRCQdlIe0ClYqpfuM3rt9uye+UpGtcA1Jzyq2d3yWGXWPjAjivB5zCwQAjcTb
k1TAxS28NYChEN62yYOFVcgW0zL4PBKN8ak5TaqfhhTQaEXSpISGlRZcHkQer5CP
aQCh
=mhWp
-----END PGP SIGNATURE-----

tag v21.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri May 3 08:07:17 2019 +0200

rdma-core-21.2:

Updates from version 21.1
 * Backport fixes:
   * ibacm: fix double hint.ai_family assignment in ib_acm_connect_open()
   * ibacm: acme does not work if server_mode != unix
   * ibacm: ib_acm_connect() is doing too much
   * verbs: The ibv_xsrq_pingpong "-c" option is broken
   * mlx5: Fix masking service level in mlx5_create_ah
   * cmake: Explicitly convert build type to be STRING
   * libhns: Bugfix for filtering zero length sge
   * buildlib: Ensure stanza is properly sorted
   * mlx4: Allow loopback when using raw Ethernet QP
   * cbuild: Fix packaging of SuSE leap
   * cbuild: fix python path for leap
   * travis: Change SuSE package target due to Travis CI failures
   * verbs: Avoid inline send when using device memory in rc_pingpong
   * mlx5: Use copy loop to read from device memory
   * libhns: Bugfix for using buffer length
   * mlx5: Fix incorrect error handling when SQ wqe count is 0
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAlzL2pccHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZEayCACTIn1Qf6zML6RczWYJ
gc43nqanLiOIar0wxgp9kTI11DOUSWzW3Qi8VQ/lUfZvBLByfobChH2PDhnd5p4+
UDjhttTFc6VgCCzNsAcDDFl4a1aq9w7gAzBZolKyKIN2u0GdSfPPgVt1Lrqa8EGq
whoQc3+q+vyqGCkpthu+aS7iC7aeGlMzYbV4P3/00L8UsyoGCGXDW8g8hbnFEyU6
JbwBmWVQRXvaGXJ2NS8O3TQ4zsuNuURfVJK1+9YQ+ZtZCwV9RmS1FTLxYys5edk+
CRtWmjz2dgCcBXSkaf2mUD+uf4LPHV2W6b7qW4djvDq5r8hP/qnDpt7A5DUbhvEA
QrIC
=ZVFd
-----END PGP SIGNATURE-----

tag v22.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri May 3 08:07:23 2019 +0200

rdma-core-22.2:

Updates from version 22.1
 * Backport fixes:
   * ibacm: fix double hint.ai_family assignment in ib_acm_connect_open()
   * ibacm: acme does not work if server_mode != unix
   * ibacm: ib_acm_connect() is doing too much
   * verbs: The ibv_xsrq_pingpong "-c" option is broken
   * mlx5: Fix masking service level in mlx5_create_ah
   * cmake: Explicitly convert build type to be STRING
   * libhns: Bugfix for filtering zero length sge
   * buildlib: Ensure stanza is properly sorted
   * debian: Create empty pyverbs package for builds without pyverbs
   * verbs: Fix attribute returning
   * build: Fix pyverbs build issues on Debian
   * travis: Change SuSE package target due to Travis CI failures
   * verbs: Avoid inline send when using device memory in rc_pingpong
   * mlx5: Use copy loop to read from device memory
   * verbs: clear cmd buffer when creating indirection table
   * libhns: Bugfix for using buffer length
   * mlx5: Fix incorrect error handling when SQ wqe count is 0
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAlzL2p0cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZDiJCACGc67QPNt7e1X9MkXH
1H/jZq6jRKLOyDoezHD21FpPX/bQzWaMBwOMx31LolERL9Sql+bc4T7F6JCyKEiy
1BkvMD7lnEvJx2E4B3aRGZnyEt6RPsfptszp+5skrv6a0u5/KY47o++qa5XUXu0p
Cb6N+kp1TG180Tr2IFXQ1f7oB5MqASq/uAV+L8zzQzdgpvcgQpVWO8oewvC2js4n
m7pw2WNtn4W3XMpZHePWqCJqI1joAcTxYTlutjJObSo6ap9ip1IJQcloXqPYOx1P
JW1z8iEeyhPOT95oSwp/r+8llQmAxKBgN8JUObTqh/jMhais9lRAxWPEAMIV9mra
Anxd
=9enQ
-----END PGP SIGNATURE-----

tag v23.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri May 3 08:07:39 2019 +0200

rdma-core-23.1:

Updates from version 23.0
 * Backport fixes:
   * ibacm: fix double hint.ai_family assignment in ib_acm_connect_open()
   * ibacm: acme does not work if server_mode != unix
   * ibacm: ib_acm_connect() is doing too much
   * verbs: The ibv_xsrq_pingpong "-c" option is broken
   * suse: Update rdma-core.spec with the latest OBS parser
   * mlx5: Fix masking service level in mlx5_create_ah
   * suse: remove %if..%endif guards that do not affect the build result
   * suse: make sure LTO is disabled
   * suse: mode udev.md into the right package
   * suse: use _udevrulesdir macro
   * cmake: Explicitly convert build type to be STRING
   * verbs: Don't check IBV_ODP_SUPPORT_RECV in ibv_{xsrq,srq}_pingpong
   * mlx5: Fix a compiler warning when -Wcast-qual is used
   * libhns: Bugfix for filtering zero length sge
   * buildlib: Ensure stanza is properly sorted
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAlzL2q0cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZL1ZB/wMeuxEKt8JDuxPrpDh
linWJiiKdq8pqiX1otDTasIgEHhTtNhEwM3vYsH2urHoY6QkC+jxtAgsiaT2Y0eY
D2GKb19vkVd8sPOXMueX26OZjcyYi3xkJUS0ds56+vymugi9dAWddECsY8cOzRSy
oLnT26gUClgB7S5tP1h1gnMjICPz5ciy9ngcSM1pwZyxoTXR9c7Nltgkk0OMd0lI
31npbazuTnACYpFAxHIVhEEsObh/8TpzYRp3TYFF+Tt7/UIFFGYyYLp1lOUGKNc8
wQfcKK4cuXhu8OloCnxgrVNOJRc9EECszd5X2nN/OaPqr4LABENnVCwqZuk9Z2L3
KbKU
=ymt4
-----END PGP SIGNATURE-----

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases
