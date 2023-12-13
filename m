Return-Path: <linux-rdma+bounces-404-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E997B810C39
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 09:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAD01F2114E
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 08:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6541D55E;
	Wed, 13 Dec 2023 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YhjCUSC2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16A89F
	for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 00:18:08 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-dbccfd048d4so311431276.3
        for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 00:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1702455488; x=1703060288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oKUjPf+23RqjwXK6NuMGpckwuSs+0RbewdG7B73lXpQ=;
        b=YhjCUSC2Al9tqEd/TbxoIay4vJ0vJsbgBW8SC7yyVNXGw6qmDcUZcHbxqEta1z28Tj
         Lcy87C9HlIRPaFGSDv8l5KauVB5D0Cl0EoaXRHdlMWTcUO4O55Wgp9dXXc57PgW3F6Bm
         lNWLWOwnZYPhpuG7v+mCT2zAjWtrIryHuMlVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702455488; x=1703060288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKUjPf+23RqjwXK6NuMGpckwuSs+0RbewdG7B73lXpQ=;
        b=WlhYzVxA64Gkf28viwA8akd4YS0fdsiuHs5dDKyuEuyvol2qkGl16UssLXZXG7agwv
         zOL9CVH1NltiwF83B2KHtmUILy6QndKdkHGoUHtxjcAXpZEdQYqLNyIjqjBkvceaFk8c
         nY52I06pej+hdXhVz++nIlcPq0eRA8+GFkvS79rao+FN1yiCDNXxvz/7o5HfQceObY3y
         65xGqgL4Ywtj+eiNvqkOaYnhO4qbVgAS5OaiISj5JQUuOJ/fxTgJTX3FGFnU81SQjy6y
         qepqpWAWq3HQL6uQt2RrtFPokqMqAEabmpAPGYeRM/7Uq+J00EhUw+W0PLdNcGF9sEr2
         H2hw==
X-Gm-Message-State: AOJu0Yzk+0tWIrhIFVQqHQvFwg/BUCKeNKn9FO8vd4r8z5r/gKHG4hjW
	5TBMjKTAj5Aovf7z1v7cYqjrC+S4MELuFjI4tnbNqg==
X-Google-Smtp-Source: AGHT+IFcSTBI34gBfEb+LkLZui+syV2ZGz1u0SJTaiiAnVCeVkV2unjqV1FKOR5BGessuFL7sSp05eeY92sAsrzBoNo=
X-Received: by 2002:a05:6902:4f3:b0:dbc:d107:876f with SMTP id
 w19-20020a05690204f300b00dbcd107876fmr189196ybs.97.1702455488103; Wed, 13 Dec
 2023 00:18:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702438411-23530-1-git-send-email-selvin.xavier@broadcom.com>
 <1702438411-23530-2-git-send-email-selvin.xavier@broadcom.com> <20231213080958.GM4870@unreal>
In-Reply-To: <20231213080958.GM4870@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 13 Dec 2023 13:47:55 +0530
Message-ID: <CA+sbYW0EBu0PceNv7xvtJi3e=qFiQqn0Fgq25Zj0_qGNCcDebQ@mail.gmail.com>
Subject: Re: [PATCH for-next 1/2] RDMA/bnxt_re: Add UAPI to share a page with
 user space
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a20eb8060c5fce07"

--000000000000a20eb8060c5fce07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 1:40=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Dec 12, 2023 at 07:33:30PM -0800, Selvin Xavier wrote:
> > Gen P7 adapters require to share a toggle value for CQ
> > and SRQ. This is received by the driver as part of
> > interrupt notifications and needs to be shared with the
> > user space. Add a new UAPI infrastructure to get the
> > shared page for CQ and SRQ.
> >
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 106 +++++++++++++++++++++++=
++++++++
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   1 +
> >  include/uapi/rdma/bnxt_re-abi.h          |  26 ++++++++
> >  3 files changed, 133 insertions(+)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infinib=
and/hw/bnxt_re/ib_verbs.c
> > index e7ef099..76cea30 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -567,6 +567,7 @@ bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *=
uctx, u64 mem_offset,
> >       case BNXT_RE_MMAP_WC_DB:
> >       case BNXT_RE_MMAP_DBR_BAR:
> >       case BNXT_RE_MMAP_DBR_PAGE:
> > +     case BNXT_RE_MMAP_TOGGLE_PAGE:
> >               ret =3D rdma_user_mmap_entry_insert(&uctx->ib_uctx,
> >                                                 &entry->rdma_entry, PAG=
E_SIZE);
> >               break;
> > @@ -4254,6 +4255,7 @@ int bnxt_re_mmap(struct ib_ucontext *ib_uctx, str=
uct vm_area_struct *vma)
> >                                       rdma_entry);
> >               break;
> >       case BNXT_RE_MMAP_DBR_PAGE:
> > +     case BNXT_RE_MMAP_TOGGLE_PAGE:
> >               /* Driver doesn't expect write access for user space */
> >               if (vma->vm_flags & VM_WRITE)
> >                       return -EFAULT;
> > @@ -4430,8 +4432,112 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_NOTI=
FY_DRV);
> >  DECLARE_UVERBS_GLOBAL_METHODS(BNXT_RE_OBJECT_NOTIFY_DRV,
> >                             &UVERBS_METHOD(BNXT_RE_METHOD_NOTIFY_DRV));
> >
> > +/* Toggle MEM */
> > +static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs=
_attr_bundle *attrs)
> > +{
> > +     struct ib_uobject *uobj =3D uverbs_attr_get_uobject(attrs, BNXT_R=
E_TOGGLE_MEM_HANDLE);
> > +     enum bnxt_re_get_toggle_mem_type res_type;
> > +     struct bnxt_re_user_mmap_entry *entry;
> > +     enum bnxt_re_mmap_flag mmap_flag;
> > +     struct bnxt_qplib_chip_ctx *cctx;
> > +     struct bnxt_re_ucontext *uctx;
> > +     struct bnxt_re_dev *rdev;
> > +     u64 mem_offset;
> > +     u32 length;
> > +     u32 offset;
> > +     u64 addr;
> > +     int err;
> > +
> > +     uctx =3D container_of(ib_uverbs_get_ucontext(attrs), struct bnxt_=
re_ucontext, ib_uctx);
> > +     if (IS_ERR(uctx))
>
> How is it possible? You should check return value from ib_uverbs_get_ucon=
text() and not container_of.
ok. will include in the next revision.
>
> > +             return PTR_ERR(uctx);
> > +
> > +     err =3D uverbs_get_const(&res_type, attrs, BNXT_RE_TOGGLE_MEM_TYP=
E);
> > +     if (err)
> > +             return err;
> > +
> > +     rdev =3D uctx->rdev;
> > +     cctx =3D rdev->chip_ctx;
> > +
> > +     switch (res_type) {
> > +     case BNXT_RE_CQ_TOGGLE_MEM:
> > +             break;
>
> No need in this break here.
ok. thanks
>
> > +     case BNXT_RE_SRQ_TOGGLE_MEM:
> > +             break;
> > +
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
>
> Thanks

--000000000000a20eb8060c5fce07
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGs3GlIcsr8D
2PQD0s+ZFnU3EAysANd1mizQHX/jp0ZQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMTIxMzA4MTgwOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDGOplXhi/J/EuMrG16jPpxoSTYoo6m
/zVPyINrAkJN11ZemZhO/IEBDfCrTYemS+P1s6M6WU6wkwiVK/sKpFdJoCEj1f4FWWvVtnBlYyID
lFWQOhVQYZVfxsO1UON/L694wMhnOC6sWEncCgZ60MQWeprdlzzdS3pT2j1VgGVjX5eXEXfXWwrU
wPoFceC+RAzvkmBJrLVykmoFF0e/hzKfFzeIjoURcI48OswnL/l6mhMa55Z3uhJBgDXo4dzLz6Dx
3V24CDHa2sRlhYFMDXZQ/4Dz3jCp9UV6WUPE86RHQDKbPwKlEIWwvRom0pLM5fzKuf3coz2LTJt9
042GJIud
--000000000000a20eb8060c5fce07--

