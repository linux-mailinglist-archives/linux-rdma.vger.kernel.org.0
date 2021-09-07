Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165A5402A74
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Sep 2021 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhIGONY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Sep 2021 10:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbhIGONX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Sep 2021 10:13:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5E2C061575
        for <linux-rdma@vger.kernel.org>; Tue,  7 Sep 2021 07:12:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s25so14194606edw.0
        for <linux-rdma@vger.kernel.org>; Tue, 07 Sep 2021 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zmHBk46/gYZI1Bt0Lz6xKWjU/HioQ2nyjhMLj4gtxKg=;
        b=TqVukg8uxIdZcnIhrSi/ap3SVKObidt/LjZo5GokAiqdvyWT/7/s37Klyyqek0fNqw
         g+DS7SfGCDu6RewGBAZo7bEVOPTBNatn2MzGYcfKKkkoSCfXE+9v8gknokfm6qnlsouL
         uLgRUWS66OJwg8JwkVOHYLBscJlMGPghhuTeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmHBk46/gYZI1Bt0Lz6xKWjU/HioQ2nyjhMLj4gtxKg=;
        b=oBGh4t1tVt5QtrZTpbIGg2569/4Lpd4mdGXFdvcqR3rCbZxK5+h9ceB/Mv7ygyqQIG
         yTa2mU8Ck8ECE44rD6NMHSNZI6inRWysE4biBYANYNNkLIctIKuDwL9GdYvQRE1V3eFq
         yjcTh7nNwNRQHO9Mp9geSOs9koyOBhaYxQPqdalArefhZ7YEgLfTGFI9Pp8fp9Uxvo1+
         cynuKWShue4h4WT3vTGEnLGk+KLYXxSKoV6QjYJXURdtI5mSwOiqQNZFTQqhamCFPx3O
         tHTtixCLz9ZNleOe68bMC3NDji2qdY1LHa91VGG7vEM0pcvMqzyViS4o/5tDynj0erbY
         qGOA==
X-Gm-Message-State: AOAM530oVQ1vMfIAred+Tfl2YT2GGpsqlGeHQGqInzIYtYZrnb7ZOVmy
        JgY6ejOqdsVj3C75lBED3lqXARtcQpuo5eMlvvWvZw==
X-Google-Smtp-Source: ABdhPJyEWcW/caxnL4kTvdHDS+45FF3fHWSPqWbeYWXqXDjl+CF8AKyOy1ogt/mxTktA5vVNYYj59gZmlnh31/ODHSE=
X-Received: by 2002:aa7:c311:: with SMTP id l17mr18486326edq.320.1631023935434;
 Tue, 07 Sep 2021 07:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210905081812.17113-1-len.baker@gmx.com> <YTSaIMAlelivBGEv@unreal>
In-Reply-To: <YTSaIMAlelivBGEv@unreal>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Tue, 7 Sep 2021 19:42:03 +0530
Message-ID: <CA+sbYW0YMFc-ohPUWu=a-NNasbM+Yk4dH5v-yYZuAjmZcAJysg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bnxt_re: Prefer kcalloc over open coded arithmetic
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>, linux-rdma@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000508a7b05cb685ad7"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000508a7b05cb685ad7
Content-Type: text/plain; charset="UTF-8"

On Sun, Sep 5, 2021 at 3:51 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Sun, Sep 05, 2021 at 10:18:12AM +0200, Len Baker wrote:
> > As noted in the "Deprecated Interfaces, Language Features, Attributes,
> > and Conventions" documentation [1], size calculations (especially
> > multiplication) should not be performed in memory allocator (or similar)
> > function arguments due to the risk of them overflowing. This could lead
> > to values wrapping around and a smaller allocation being made than the
> > caller was expecting. Using those allocations could lead to linear
> > overflows of heap memory and other misbehaviors.
> >
> > In this case this is not actually dynamic sizes: both sides of the
> > multiplication are constant values. However it is best to refactor this
> > anyway, just to keep the open-coded math idiom out of code.
> >
> > So, use the purpose specific kcalloc() function instead of the argument
> > size * count in the kzalloc() function.
> >
> > Also, remove the unnecessary initialization of the sqp_tbl variable
> > since it is set a few lines later.
> >
> > [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> >
> > Signed-off-by: Len Baker <len.baker@gmx.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>

--000000000000508a7b05cb685ad7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
od7PzGNQ3SgTYKl5XslMq+gpy+K8+egxMxo3D07c8snwyfU7Y7NQ8I1M986gsj9RUcp3oo0N+T1W
rwVchQXTGD/Hwqc11XBU1H3JKSRkn7cTa9bMFnp0Asr3Y4/kB+4t6PhYi50ORwIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU6uPX
5eOTTGwUwIAAoXKF4qVZLfgwDQYJKoZIhvcNAQELBQADggEBAKAn7gHcWCrqvZPX7lw4FJEOMJ2s
cPoLqoiJLhVttehI3r8nFmNe5WanBDnClSbn1WMa5fHtttEjxZkHOFZqWLHYRI/hnXtVBjF9YV/1
Hs3HTO02pYpYyHue4CSXgBtj45ZVZ0FjQNxgoLFvJOq3iSsy/tS2uVH5Pe1AW495cxp8+p5b3VGe
HRzGet524jE0vZx0A/6qrYo6C7z4Djrt/QU2MZDbPb+kwkkomwcn0Nvr91KWSrbhhHtZ/EfXi08L
x3R3oHtWjbmIW1nYkwVk4pQZoaLkRWkfTSGpwDwilhrd2F+d5rhCbAbfACk4Oly51GV4SI7jUm0D
VbZWyuIx85gxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxea+GNYSvtMZZyJzwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDqZ4+LCuPz0
b2+XmpBDoNmFpYvtPPMt9Egd6l2YLv2UMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDkwNzE0MTIxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBpBcFTtHhZjm+mky+xOsHVrZBUI63j
IrYlVlbQimwNGXX4RFTvBmE40YOwfY2vCiHlBCqiiPoSFbET2MY7wVXHehOcPCe+LsglJeRjiQjI
KqHl9FMOL2TQPZbCDNHZKFZQkYUPHIEl7z/DjDDAPyHZemQMH3rLD5AIr4DTHxcUZy3eQL3JG/2u
qw+ogvQJFyGF0mwOBkU+pyGj0MzWKoLTlsv/1F8IULOl6cdjgTm/yDgng2ifACGMlVWuUwEBJJcW
E9xt1+e48/dCnFOMHMDcs3jTqrYHWAYi2LFvHG2BJcpGDKmN/5oBJ8jyA20O0bHXJLyFZ1L/oU5K
ak199ot1
--000000000000508a7b05cb685ad7--
