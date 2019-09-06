Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17597AC28C
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Sep 2019 00:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405020AbfIFWbi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Sep 2019 18:31:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38570 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbfIFWbh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Sep 2019 18:31:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id h17so3401397otn.5
        for <linux-rdma@vger.kernel.org>; Fri, 06 Sep 2019 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0wARihSzzFkdcNYvNy9XKL20l+diJt1ol3oHcpWFQE4=;
        b=icX7ImHrAKnbz18huNMGwZpZy8jve4u5ghsGoLav9wx7w3snP9LSIrLAm+fg09PWPD
         3jsmFcPduQNy1UfEALIx8kN45nCNy6j5MBYbsrdR4hkQp+wl7JyRS66MJSZbaR7X5OWT
         034xobV/J9lR3f1pZ6D/ZmEu4zI8t45yF9VGxkNg65FqkVuLn/DKtQoqXRJvJn21HdUb
         f7DlDe9RqhjYLvLfYvaBUghbORyMLwRsqfRMiFVP1j60OH5DTo4imnc0T8ifMv/12PAs
         MVmpAl4Sn/wZkvjxOcXWmGG0XOmJK7zHga+MEY0NBrRp7d05q/IiMFwn0KB7HkHEUUPZ
         O6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0wARihSzzFkdcNYvNy9XKL20l+diJt1ol3oHcpWFQE4=;
        b=d/Oge7I1gT1fxkIXZJvH67La30PIARG5Q5V6rbeWD6+XY+XlM31Gd3tan5r2KFQGCO
         BKSkSAvt7HkMovALZ3k2MDrabVK5zue3RjTlxzP/3XocKn2BDbajOocNfIhYWU0dzeMR
         fwh4iimm/GdWuk0VC54Eqpr4CKq6RIu8sqfdEWVffQopQl9e7L6yvqWSvE/KDIwgavJK
         neTWiTSYW4Obtht/iXO3VDOMayNJGGaPaTcY+i2EJB03BxnwpWdyVWIM+EQTy0fgfa5H
         k9TP4ad5iXYLo+F6n1nd9kmBjNKxugqLfa18GqtAKQrzZhxJ77F7zzz82+1FOFATRcUx
         jwXw==
X-Gm-Message-State: APjAAAVdGK8jeyyw+05q/dRzxaJOd3RYvJ8J0ZC8R5EdRFBI4w8HyMeX
        tBTsndsoaVjQ/R9yybyTyOg=
X-Google-Smtp-Source: APXvYqzzBz7BJMotatYNC94bYqzJejYRM2xvSGyxDK4ME32iXaRGRiyEeOMdBYx7yaFPYgarNhEHCA==
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr9729663oti.135.1567809096775;
        Fri, 06 Sep 2019 15:31:36 -0700 (PDT)
Received: from [192.168.1.86] (47-221-137-213.gtwncmta03.res.dyn.suddenlink.net. [47.221.137.213])
        by smtp.gmail.com with ESMTPSA id f31sm2732830otb.81.2019.09.06.15.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 15:31:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] RDMA/siw: Relax from kmap_atomic() use in TX path
From:   Steve Wise <larrystevenwise@gmail.com>
X-Mailer: iPad Mail (16G77)
In-Reply-To: <20190906111807.14978-1-bmt@zurich.ibm.com>
Date:   Fri, 6 Sep 2019 17:31:35 -0500
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <08C73A86-3362-4F73-8A40-836DA575236F@gmail.com>
References: <20190906111807.14978-1-bmt@zurich.ibm.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey Bernard,  is the code below called directly from the driver=E2=80=99s po=
st_send function?  If so it must use atomic...I think.

Stevo

> On Sep 6, 2019, at 6:18 AM, Bernard Metzler <bmt@zurich.ibm.com> wrote:
>=20
> Since the transmit path is never executed in an atomic
> context, we do not need kmap_atomic() and can always
> use less demanding kmap().
>=20
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
> drivers/infiniband/sw/siw/siw_qp_tx.c | 12 +++++-------
> 1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw=
/siw/siw_qp_tx.c
> index 8e72f955921d..5d97bba0ce6d 100644
> --- a/drivers/infiniband/sw/siw/siw_qp_tx.c
> +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
> @@ -76,16 +76,15 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, voi=
d *paddr)
>            if (unlikely(!p))
>                return -EFAULT;
>=20
> -            buffer =3D kmap_atomic(p);
> +            buffer =3D kmap(p);
>=20
>            if (likely(PAGE_SIZE - off >=3D bytes)) {
>                memcpy(paddr, buffer + off, bytes);
> -                kunmap_atomic(buffer);
>            } else {
>                unsigned long part =3D bytes - (PAGE_SIZE - off);
>=20
>                memcpy(paddr, buffer + off, part);
> -                kunmap_atomic(buffer);
> +                kunmap(p);
>=20
>                if (!mem->is_pbl)
>                    p =3D siw_get_upage(mem->umem,
> @@ -97,11 +96,10 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, voi=
d *paddr)
>                if (unlikely(!p))
>                    return -EFAULT;
>=20
> -                buffer =3D kmap_atomic(p);
> -                memcpy(paddr + part, buffer,
> -                       bytes - part);
> -                kunmap_atomic(buffer);
> +                buffer =3D kmap(p);
> +                memcpy(paddr + part, buffer, bytes - part);
>            }
> +            kunmap(p);
>        }
>    }
>    return (int)bytes;
> --=20
> 2.17.2
>=20
