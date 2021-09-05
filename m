Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473B4400EAD
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Sep 2021 10:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhIEITz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Sep 2021 04:19:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:49905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhIEITz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 Sep 2021 04:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630829927;
        bh=fTBXvKxZl6B/IHLAHmbTOQkcjt7hvW0fG3GfH17J/Fo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MKhhkRe79drF0yldxNMv8bw7RvqDGYCpPKLRJ8T6cHob+tjK0KBTyC0kmiWKPjnuF
         GRj2bhslB2MACSgwtLe4wImcRzoZzw97MQgf/E2//kLkdOmhNJat1kQa0MmwUZBwoZ
         gtaZnHGqEyR3QLCV5nlhzMBlmAQdimYzE99mwqG4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MoO6M-1ml4UZ1JpQ-00oq2c; Sun, 05 Sep 2021 10:18:47 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        linux-rdma@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/bnxt_re: Prefer kcalloc over open coded arithmetic
Date:   Sun,  5 Sep 2021 10:18:12 +0200
Message-Id: <20210905081812.17113-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vzAhzYJz4CiUc9w8Raus6XPXj/K19h+cFftCVKPdHnD4ICkrkCu
 7XoRcMK28P6FVNJAkB5J+Uh68r9xW4RJ96AUzolLL5sB/gd6R5NhZi9Bd1mTNBXpId7tnuH
 GItLhPLWaDlDzjdLvGTKA5/qMkvNIrXqe3NYeKn7X2+20/wggFuycRphjbgkSvdmLWSD+Rr
 TW6J58OCRhYABkn+jzNXw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f7gIwwtcx9A=:XxVo3HNf616woWeFi8zZq+
 5D7nCIn5pEcUHG5vSvZ200ZzIMNo/YWu4j4GIp0VULBni31LlbnoyYKDyxL3KT22WDMzxuLPM
 aE7fFznWCXIvVRyZ3kPOnXO9OOYPdh3GHAZv/VCoqSBb9hgU4qcDuJ+VCAFC4cBvPrbY4xGqr
 rrChP7/WxGZU3zUtB3trQtM+VmW0otfvEWSd4AK2RTvH7I44DWVcQHIs09FDjgCN/qDCmkczb
 e2ROm5Rpbv4CT4jr6Fr52QwSMFAJA7BK5LHDm2mqrNuQphmUb948Ui6ABe3oa5FszqlbTpFWe
 2LIUVU5j5/H49bzG3WLalfTYOTKQRVaq10QRaX5evKqI+r2njf9eoLsn30qcnN5li8Wh0hRWW
 MFQP6GoKQoxRGvF+7v6BtKjF+v3IY241Bf11vw4MS06bugtWaL6stPM6LQFh32VSPhto0L+RE
 ePiCVB3JlLeWjgCMiH81B9VZasS2D0TKS6ds95w4C6Oo5hgTef4T/yTxJK6wir3PT9EdiY2Bz
 J4lQ6INNolzp0Cx6OtpAqYg0i5MM1SUYf6pTJq04yxIY9M3PXmGlgVzwxvaE2XM1Ge0+bWzi1
 A9DZmpXu03Y6Ju7FJT3V7/tclCV8dDkufM+s3fPFZs9YPTQJ2zorWegFNRa9GoOa0EDGbj2rw
 pPl0sMpL7DYla6vMit264JgMqIiiZSHwLH7MH/2H1hIv5n7wR3eKp8tvB5+JAbsKXTyrstkAB
 QesQ+VBuvkFc9IkQVlfkH0jAjA+ojMUsSnMTe0P3KEJSN2gVX23lmPS04XYWBjnIz8aQGYw1Y
 hekMx3d6YQJkpTSnMPdd15W+aoDtkaEb0ZP+bZ0V1auoZGkg/yUcBXfZNJfHP7GGU0B0xgO/0
 m7lNF6eUxOxWtQMfNF09W6Z8Eae041rhRO5UcC2YvbgJk3/Q3zb0tmbGpb4uO3Jbr3eqE9qLw
 A9Bes/uM3wvh/cGpg0kXuKjJlqIxK2l+ozrF24oMmDF+TnyIna0IMbXS5nSiub1YcCc2DegTp
 3xLw2w2ErNdpZeLoMLQUjYEP9zr6H6xNxmpLvg01sQyaz6hXm7rJMVgpJvTwlb9DQ9LD1wDm9
 2yayfwbWyoz13I/5qINqRqtHxwLcKR/mGMEw6qyAejHRlwiXZ0rVQ5Y9A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

In this case this is not actually dynamic sizes: both sides of the
multiplication are constant values. However it is best to refactor this
anyway, just to keep the open-coded math idiom out of code.

So, use the purpose specific kcalloc() function instead of the argument
size * count in the kzalloc() function.

Also, remove the unnecessary initialization of the sqp_tbl variable
since it is set a few lines later.

[1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-cod=
ed-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband=
/hw/bnxt_re/ib_verbs.c
index ea0054c60fbc..6fd4b87832b4 100644
=2D-- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1312,7 +1312,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *q=
p, struct bnxt_re_pd *pd,
 static int bnxt_re_create_shadow_gsi(struct bnxt_re_qp *qp,
 				     struct bnxt_re_pd *pd)
 {
-	struct bnxt_re_sqp_entries *sqp_tbl =3D NULL;
+	struct bnxt_re_sqp_entries *sqp_tbl;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_qp *sqp;
 	struct bnxt_re_ah *sah;
@@ -1320,7 +1320,7 @@ static int bnxt_re_create_shadow_gsi(struct bnxt_re_=
qp *qp,

 	rdev =3D qp->rdev;
 	/* Create a shadow QP to handle the QP1 traffic */
-	sqp_tbl =3D kzalloc(sizeof(*sqp_tbl) * BNXT_RE_MAX_GSI_SQP_ENTRIES,
+	sqp_tbl =3D kcalloc(BNXT_RE_MAX_GSI_SQP_ENTRIES, sizeof(*sqp_tbl),
 			  GFP_KERNEL);
 	if (!sqp_tbl)
 		return -ENOMEM;
=2D-
2.25.1

