Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B4F1F817B
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2020 09:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgFMHPf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 13 Jun 2020 03:15:35 -0400
Received: from mout.web.de ([212.227.15.14]:55901 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgFMHPf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 13 Jun 2020 03:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592032514;
        bh=Vi7sYjFH49Vu7klCRw9AFR9filGVhiZCDgj1TNtaUfA=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=K9shExZM/9pY8udcmOD+ngT4hvtfggdXeteDgPjPK/oeSvnuzZrci4fw9u9XX7Ffp
         M+Xb1I3OxilYMjMSsPf+ZAnEZv3v/cBlMYLbKjDJFJ/EsGXupT3aZabehSZbzuP90t
         n7pOkhdb28bYdd/sVQfXyNfDS/9m7Gzvv0hzJ1eI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.51.155]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVcvn-1jPneX26Qh-00Z0Tn; Sat, 13
 Jun 2020 09:15:14 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Kangjie Lu <kjlu@umn.edu>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH] RDMA/rvt: Improve exception handling in rvt_create_qp()
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Aditya Pakki <pakki001@umn.edu>, linux-rdma@vger.kernel.org
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5d99dfe5-67ed-00d2-c2da-77058fb770c6@web.de>
Date:   Sat, 13 Jun 2020 09:15:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wel+iYWrKu0b/j3mDn+d7PRf9eGuvJVK9O3COQH8wD0kR9EnOGD
 OFqSMTo+TyXpOyAzu1xnt8IuO5IUrl1n56u8dJl0fwHRxu1I0rfwaiOY8DhCBs1p6TTXSbW
 X9GeXVX6q8ByJtVhRa8fR4ZgfU6Gucwxo69R6bDiIl86b3T16oEusfIk4/VhZieyVtMiLM7
 ocZC/RkTKwqwaY3k4u9Xw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GSB0jT2Pv7A=:QfwmDEUJLtvBAP2dFhx1ht
 tevRsY4BmNmY5r6DB/UVSEl2tFHWqajkNOPalmG+hYJYv9EAMsGxGJ3ZLyEmOqy/fxWw0aa+r
 QHIL7vQJC4/ghdRdT9g4a3gUumEYu7qj9TOoZGxuVuclXkp4f2VCtebZeAiDiKAZl5o+AG9kF
 vXn+ElbRke+CqjI42Ebo77Q92QpMHQ5ZYcijm8FiRZh76I/f8cz8HrDj6bsc/TKZHc+3YDE+V
 +Kpoa2VpR7PEOUmWR+bpq6pDJajdazi19uXp7+CwM/963ZTvIP3J1cqUpZ1NoOn4ez4IOgHuC
 JDJ6XcIhDUUoqOgefy0L/SB4leSJ3ef/fzjpb5h8YExpgk0MqaHJsQv6KxH96dZDG6p6cDezV
 zp5p5YhNSFNDQ4yTfJSYHAvlTL8g6QTMd5m9RHvglLwwBEubYVjCb40MMMgngbAv5qUKsty5B
 1uA1y03/NKx+d83wuZOWYLqqi8hZ75Xxzdf3C+9mzxeUiJrcGoxSHQ+ZAocJFhE9Vzb1nb102
 8OiWbfyNy+FcDr82uoeSVWKp0zCMOsc0eaVePCBJARvGzIjXrtcwE6x1PN68KCnSvxsSIdcGu
 0zOJQ6ajSF0vToKOXcoIe+IXU1x8oWidi5UIxJaW9vufBK7BMRQM9eBk8k1oZEUAEGM8T02Vv
 XonDJFiv5Po8pKLi02tYsuZ0DNsS/5aTd2aK0tJNIRdqv7udYtv7gkUZMcQAegPRILRo706F4
 TndMW80efuWZa9RgMjpQuitn/czR//PYt18cG1sxY6ROfjEo7SpoXFlnOmbkpMng17ACnNC/Y
 X1rn7c27vcJzigVdx+4GHlln/2GQT7V7ao8lBUnLkh1Is1+1Pw+uM6vY4VrDrE725eqtZmKnV
 A6iBK3TgZE1KQQ6QGrZCINkQx9Z7e57e47wrvYSDrcNGDIYf9Y4EcPttz3lOPdZQnrD9dSZ8/
 25sKS78Vyf/gPPLu6kijX3q1KfkVbhpAcKk11Ucz9AANCvnex0UVIOTM6oe90JEh1rfj0S0pI
 9JifUrWskib/YC1EYdnkK2VMOQpub2GRzFlFmajH4twksflsAFyHHalDGtzC2TX4SrTOqRBcG
 69LqwfSrrpmvihcm0dnNtxqSM1O+73vWC173VVgSECNf/L9i/9aMHysSrhSRMjy58bjnoQJL4
 2sM0bXj8L+GM1TFLvfeVi5xiH3mETr43RTZ615aWuGlMUjmQtaYjXob5DPWdzrwwbDSSOhx9s
 ED4etOIvcADFPE46p
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> =E2=80=A6 The patch fixes this issue by
> calling rvt_free_rq().

I suggest to choose another imperative wording for your change description=
.
Will the tag =E2=80=9CFixes=E2=80=9D become helpful for the commit message=
?

=E2=80=A6
> +++ b/drivers/infiniband/sw/rdmavt/qp.c
> @@ -1203,6 +1203,7 @@  struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>  			qp->s_flags =3D RVT_S_SIGNAL_REQ_WR;
>  		err =3D alloc_ud_wq_attr(qp, rdi->dparms.node);
>  		if (err) {
> +			rvt_free_rq(&qp->r_rq);
>  			ret =3D (ERR_PTR(err));
>  			goto bail_driver_priv;
>  		}

How do you think about the following code variant with the addition
of a jump target?

 		err =3D alloc_ud_wq_attr(qp, rdi->dparms.node);
 		if (err) {
 			ret =3D (ERR_PTR(err));
-			goto bail_driver_priv;
+			goto bail_free_rq;
 		}

=E2=80=A6

 bail_rq_wq:
-	rvt_free_rq(&qp->r_rq);
 	free_ud_wq_attr(qp);
+
+bail_free_rq:
+	rvt_free_rq(&qp->r_rq);

 bail_driver_priv:


Regards,
Markus
