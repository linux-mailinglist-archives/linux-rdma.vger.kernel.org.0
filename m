Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26DC3A2F6B
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhFJPh1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 11:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhFJPhY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 11:37:24 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7612C061574
        for <linux-rdma@vger.kernel.org>; Thu, 10 Jun 2021 08:35:27 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id im10so14055717qvb.3
        for <linux-rdma@vger.kernel.org>; Thu, 10 Jun 2021 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhzw3JuzqXwrj8KABEg6v/oQ4b+IgboU/pezrxozYOc=;
        b=GyFjRMWkoeOlQOZXoBPMAai+1vCjevZ884JdJrxUhCgvDMOeUn9IMmAdh3vHzSy/NL
         ICfSEWY9d/gHjgk7U+ApXfiC329FXA+850791PQjyLUZpobO+yktrfM/CdrvpqxpQQ6X
         tbSnoakvAxtzEAi8StD7i47Cs0qaarF8miHt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhzw3JuzqXwrj8KABEg6v/oQ4b+IgboU/pezrxozYOc=;
        b=BA6DpiP/NXwSuQ5HNQUEWki4IM5Vo2sp1vweglWeSGYW1kEwweTqEu8GNpFaOIbFQB
         Sb+SGlfyJwGAqtPT9KBy0O6dzRn2hGvBDceFGxhpW9VxO0xAfH8v2w7CX+PEIdA4rcrj
         7aXLfljEcaCILa+P48uFXynHt2t7L7NF4iuSpqKzdgeHcNENiBJIXaSbHmroYEnYkTv3
         8QM2IhQm12pb7ji4BZEXtETHWJJo6Yg63ZODQ+aFq9eFPDTWLNn9HpifXAC37k/9Of4g
         9uSqd9w6hoRAaWBN8y7vRO4g/pz0E5wWlOliiWIrjh41yjEHNIyIGCjlbmKFJSUyM+lD
         OM3g==
X-Gm-Message-State: AOAM532bdO6cFy2Mz5zR2+Pcj7PSdfdeZLOhRXjKJB64UBnCG7Pi5IPT
        NW4EvxVA84eGk1Pn+nhNDYS81uvMBYSZLgUcEDfNyQ==
X-Google-Smtp-Source: ABdhPJyrBR0sY0AuN6nj2+8lhnCZJQJDakHGU1l8C05A98wyggJ0kvsEEIIgI7Rz5GQuEIlI6Bnspfc2I8A0LRz/nvw=
X-Received: by 2002:a0c:e148:: with SMTP id c8mr228027qvl.18.1623339326123;
 Thu, 10 Jun 2021 08:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210610104910.1147756-1-devesh.sharma@broadcom.com>
 <20210610104910.1147756-2-devesh.sharma@broadcom.com> <3398B5D8-B9EB-4C94-981C-05CB753E9D9A@oracle.com>
In-Reply-To: <3398B5D8-B9EB-4C94-981C-05CB753E9D9A@oracle.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Thu, 10 Jun 2021 21:04:50 +0530
Message-ID: <CANjDDBi7xruSKNdGo8yumrzLBMYDnetqAAsEsm5z9aagXP=c9A@mail.gmail.com>
Subject: Re: [PATCH V4 rdma-core 1/5] Update kernel headers
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f082d105c46b2353"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000f082d105c46b2353
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 10, 2021 at 6:13 PM Haakon Bugge <haakon.bugge@oracle.com> wrot=
e:
>
>
>
> > On 10 Jun 2021, at 12:49, Devesh Sharma <devesh.sharma@broadcom.com> wr=
ote:
> >
> > To commit ?? ("RDMA/bnxt_re: update ABI to pass wqe-mode to user space"=
).
> >
> > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > ---
> > kernel-headers/rdma/bnxt_re-abi.h | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel-headers/rdma/bnxt_re-abi.h b/kernel-headers/rdma/bn=
xt_re-abi.h
> > index dc52e3cf..52205ed2 100644
> > --- a/kernel-headers/rdma/bnxt_re-abi.h
> > +++ b/kernel-headers/rdma/bnxt_re-abi.h
> > @@ -49,7 +49,8 @@
> > #define BNXT_RE_CHIP_ID0_CHIP_MET_SFT         0x18
> >
> > enum {
> > -     BNXT_RE_UCNTX_CMASK_HAVE_CCTX =3D 0x1ULL
> > +     BNXT_RE_UCNTX_CMASK_HAVE_CCTX =3D 0x1ULL,
> > +     BNXT_RE_UCNTX_CMASK_HAVE_MODE =3D 0x02ULL
>
> Please use a comma for the last enum as well, to avoid this line to be un=
necessary modified when you add another entry.
Good suggestion, since this patch is rather dependent on kernel patch.
I would let this patch be unchanged.
>
>
> Thxs, H=C3=A5kon
>
> > };
> >
> > struct bnxt_re_uctx_resp {
> > @@ -62,6 +63,8 @@ struct bnxt_re_uctx_resp {
> >       __aligned_u64 comp_mask;
> >       __u32 chip_id0;
> >       __u32 chip_id1;
> > +     __u32 mode;
> > +     __u32 rsvd1; /* padding */
> > };
> >
> > /*
> > --
> > 2.25.1
> >
>


--=20
-Regards
Devesh

--000000000000f082d105c46b2353
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
TUsFTOuxP4FZ9JSu9FWkGJGPobx8FmEvg+HybmXuUG0+PU7EDHKNoW8AcgZvIQYbwfevqWBFwwRD
Paihaaj18xGk21lqZcO0BecWKYyV4k9E8poof1dH+GnKqwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpkZXZlc2guc2hhcm1hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEe3qNwswWXCeWt/hTDSC
KajMvUgwDQYJKoZIhvcNAQELBQADggEBAGm+rkHFWdX4Z3YnpNuhM5Sj6w4b4z1pe+LtSquNyt9X
SNuffkoBuPMkEpU3AF9DKJQChG64RAf5UWT/7pOK6lx2kZwhjjXjk9bQVlo6bpojz99/6cqmUyxG
PsH1dIxDlPUxwxCksGuW65DORNZgmD6mIwNhKI4Thtdf5H6zGq2ke0523YysUqecSws1AHeA1B3d
G6Yi9ScSuy1K8yGKKgHn/ZDCLAVEG92Ax5kxUaivh1BLKdo3kZX8Ot/0mmWvFcjEqRyCE5CL9WAo
PU3wdmxYDWOzX5HgFsvArQl4oXob3zKc58TNeGivC9m1KwWJphsMkZNjc2IVVC8gIryWh90xggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwhg1OJo0VLRNay
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDDKOLyJuNMtrLopxv0kR9WcN6ee
PETtjzsxNbiPtw/AMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDYxMDE1MzUyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBA+hTvnEuPivVtEFNYXP0A4RVGgYsxIlRwHiAfWWcWZWHA
D2WFMeqOmdqVb8Kzka0dMQqDQoMaDProu1TzdQgo0Ch5SZnXbFtynBCYAMGZ6WPy26maT7VNuCva
8QEeF5kQUypC+vE1cP/f2gCyCqaJsk9M9K2zAX17TmX+l0dyvb7aoTQsh0qN+B6Guv3mNBH2yLFI
vPgCcS5lac+eGv+qpcg0XBU2E8sfquLRrJj2dsp8QmjDmQK9MgJGZ8fgWpB8a1qSWXQPmapUXaFU
ljRkqbKM9WlWCESXDLsQm3B7E5TLdYE3XHVOJ3JqVbzGxloKQxqrEkLjyhRisFPEqmZx
--000000000000f082d105c46b2353--
