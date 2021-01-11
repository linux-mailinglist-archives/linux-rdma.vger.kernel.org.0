Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A89C2F1D9F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jan 2021 19:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389307AbhAKSK2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jan 2021 13:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389280AbhAKSK2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jan 2021 13:10:28 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02131C061794
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jan 2021 10:09:48 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id m10so237247lji.1
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jan 2021 10:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1m+vqAswpT+Y5qW/QwObwYJF8xQXCE+6GwKXHiUvLE=;
        b=Olznl+04e16zvsYukk6/J9oyZZResLsoVh0jpu+YeCdAGi5WHZi4OriRPZ6l1YPI6H
         DRTBsKOxAPhi9fJKYoGkLMkjm7MUr2Cnl9gEAquoXOKQ9CCLl1NueBXUJMD4jFHPiBwg
         VOZzIe8K5/V+kGpjAhYGpA2zgvBFQuPAkTbqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1m+vqAswpT+Y5qW/QwObwYJF8xQXCE+6GwKXHiUvLE=;
        b=WR4IhyXmaYEoJrm+HWTbtcHKXhnrauLMN3QFBv1LP+2lwY9bn/uxusZn0Zku/Eeu2z
         24H1x+JT7ANbEikb4xpjctvJd7kj9NU5Xp0M+sJjzWepRvQ0IrOYLWFKB6Jsl9qNgFfJ
         InDfdah6XjRDaRBu4LM6shasHIjr8bMpu2+7xmUI0Yo3AFP6wu7/1LJ9Qv4tuRwRmiAj
         IuzSHbuwXZuqBSOfyhB9pm86qDt87CAwWqQGlGRX1KacdIeo/JFepneizlezTsUbsvVx
         8nKiamT3BMtuEz5naQrrPBiq2IxgG4o2m5PTsfYqcAIm9ktXsIRj/vHO6Ck92CqVN8m3
         R0pg==
X-Gm-Message-State: AOAM532TGMqqTEsmFlWHr5aAcZfgCTq5jJxVILk/JA19+0QOfNnOqDv5
        OD2prSmloErGpmCwv94+pRZq5rcHlsH//wFDXNU8/NmYW51PoA==
X-Google-Smtp-Source: ABdhPJzeVlQYCsuwV9Pqis6BBOoUIQtb+MgbCu4rLp2cDpKdkINp25aWl5+FKdNC7rg5k56Fjgg9gm/ONDelvAr0/II=
X-Received: by 2002:aa7:c886:: with SMTP id p6mr464760eds.352.1610388586018;
 Mon, 11 Jan 2021 10:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20201230024653.1516495-1-trix@redhat.com> <20210107204102.GA933840@nvidia.com>
 <00c76f8e-4e46-2ab5-772b-ad5db59f8490@redhat.com>
In-Reply-To: <00c76f8e-4e46-2ab5-772b-ad5db59f8490@redhat.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Mon, 11 Jan 2021 23:39:34 +0530
Message-ID: <CA+sbYW1_zYv47YV8Btd8+JW=3QcSo4N1yFFDycnTS853UHGGag@mail.gmail.com>
Subject: Re: [PATCH] RDMA/ocrdma: fix use after free in ocrdma_dealloc_ucontext_pd()
To:     Tom Rix <trix@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, maxg@mellanox.com,
        Gal Pressman <galpress@amazon.com>, michaelgur@nvidia.com,
        Moni Shoua <monis@mellanox.com>, gustavoars@kernel.org,
        linux-rdma@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a8ca9205b8a3cf47"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000a8ca9205b8a3cf47
Content-Type: text/plain; charset="UTF-8"

On Fri, Jan 8, 2021 at 3:13 AM Tom Rix <trix@redhat.com> wrote:
>
>
> On 1/7/21 12:41 PM, Jason Gunthorpe wrote:
> > On Tue, Dec 29, 2020 at 06:46:53PM -0800, trix@redhat.com wrote:
> >> From: Tom Rix <trix@redhat.com>
> >>
> >> In ocrdma_dealloc_ucontext_pd() uctx->cntxt_pd is assigned to
> >> the variable pd and then after uctx->cntxt_pd is freed, the
> >> variable pd is passed to function _ocrdma_dealloc_pd() which
> >> dereferences pd directly or through its call to
> >> ocrdma_mbx_dealloc_pd().
> >>
> >> Reorder the free using the variable pd.
> >>
> >> Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
> >> Signed-off-by: Tom Rix <trix@redhat.com>
> >>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > Applied to for-rc
> >
> > Is anyone testing ocrdma? Just doing the pyverbs rdma tests with kasn
> > turned on would have instantly caught this, and the change is nearly a
> > year old.
> >
> > Is ocrdma obsolete enough we can delete the driver?

Broadcom is not doing any active development/testing  with ocrdma now.
I am checking with other teams to see if this can be deleted
completely. Will get back asap.

Thanks,
Selvin

>
> I am not an authority on ocrdma, i am fixing treewide, the problems clang static analysis flags.
>
> Tom
>
> >
> > Thanks,
> > Jason
> >
>

--000000000000a8ca9205b8a3cf47
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQUQYJKoZIhvcNAQcCoIIQQjCCED4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg2mMIIE6DCCA9CgAwIBAgIOSBtqCRO9gCTKXSLwFPMwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UE
CxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMT
Ckdsb2JhbFNpZ24wHhcNMTYwNjE1MDAwMDAwWhcNMjQwNjE1MDAwMDAwWjBdMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25h
bFNpZ24gMiBDQSAtIFNIQTI1NiAtIEczMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
tpZok2X9LAHsYqMNVL+Ly6RDkaKar7GD8rVtb9nw6tzPFnvXGeOEA4X5xh9wjx9sScVpGR5wkTg1
fgJIXTlrGESmaqXIdPRd9YQ+Yx9xRIIIPu3Jp/bpbiZBKYDJSbr/2Xago7sb9nnfSyjTSnucUcIP
ZVChn6hKneVGBI2DT9yyyD3PmCEJmEzA8Y96qT83JmVH2GaPSSbCw0C+Zj1s/zqtKUbwE5zh8uuZ
p4vC019QbaIOb8cGlzgvTqGORwK0gwDYpOO6QQdg5d03WvIHwTunnJdoLrfvqUg2vOlpqJmqR+nH
9lHS+bEstsVJtZieU1Pa+3LzfA/4cT7XA/pnwwIDAQABo4IBtTCCAbEwDgYDVR0PAQH/BAQDAgEG
MGoGA1UdJQRjMGEGCCsGAQUFBwMCBggrBgEFBQcDBAYIKwYBBQUHAwkGCisGAQQBgjcUAgIGCisG
AQQBgjcKAwQGCSsGAQQBgjcVBgYKKwYBBAGCNwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMRMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFGlygmIxZ5VEhXeRgMQENkmdewthMB8GA1UdIwQYMBaA
FI/wS3+oLkUkrk1Q+mOai97i3Ru8MD4GCCsGAQUFBwEBBDIwMDAuBggrBgEFBQcwAYYiaHR0cDov
L29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3RyMzA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL3Jvb3QtcjMuY3JsMGcGA1UdIARgMF4wCwYJKwYBBAGgMgEoMAwGCisG
AQQBoDIBKAowQQYJKwYBBAGgMgFfMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNp
Z24uY29tL3JlcG9zaXRvcnkvMA0GCSqGSIb3DQEBCwUAA4IBAQConc0yzHxn4gtQ16VccKNm4iXv
6rS2UzBuhxI3XDPiwihW45O9RZXzWNgVcUzz5IKJFL7+pcxHvesGVII+5r++9eqI9XnEKCILjHr2
DgvjKq5Jmg6bwifybLYbVUoBthnhaFB0WLwSRRhPrt5eGxMw51UmNICi/hSKBKsHhGFSEaJQALZy
4HL0EWduE6ILYAjX6BSXRDtHFeUPddb46f5Hf5rzITGLsn9BIpoOVrgS878O4JnfUWQi29yBfn75
HajifFvPC+uqn+rcVnvrpLgsLOYG/64kWX/FRH8+mhVe+mcSX3xsUpcxK9q9vLTVtroU/yJUmEC4
OcH5dQsbHBqjMIIDXzCCAkegAwIBAgILBAAAAAABIVhTCKIwDQYJKoZIhvcNAQELBQAwTDEgMB4G
A1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNV
BAMTCkdsb2JhbFNpZ24wHhcNMDkwMzE4MTAwMDAwWhcNMjkwMzE4MTAwMDAwWjBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aE
yiie/QV2EcWtiHL8RgJDx7KKnQRfJMsuS+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5
uzsTgHeMCOFJ0mpiLx9e+pZo34knlTifBtc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bL
yCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg
6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkW
qQPabumDk3F2xmmFghcCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQBLQNvAUKr+
yAzv95ZURUm7lgAJQayzE4aGKAczymvmdLm6AC2upArT9fHxD4q/c2dKg8dEe3jgr25sbwMpjjM5
RcOO5LlXbKr8EpbsU8Yt5CRsuZRj+9xTaGdWPoO4zzUhw8lo/s7awlOqzJCK6fBdRoyV3XpYKBov
Hd7NADdBj+1EbddTKJd+82cEHhXXipa0095MJ6RMG3NzdvQXmcIfeg7jLQitChws/zyrVQ4PkX42
68NXSb7hLi18YIvDQVETI53O9zJrlAGomecsMx86OyXShkDOOyyGeMlhLxS67ttVb9+E7gUJTb0o
2HLO02JQZR7rkpeDMdmztcpHWD9fMIIFUzCCBDugAwIBAgIMKiSIRRfesYqFvLBOMA0GCSqGSIb3
DQEBCwUAMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQD
EypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMwHhcNMjAwOTIxMTQ1
MTQ2WhcNMjIwOTIyMTQ1MTQ2WjCBnDELMAkGA1UEBhMCSU4xEjAQBgNVBAgTCUthcm5hdGFrYTES
MBAGA1UEBxMJQmFuZ2Fsb3JlMRYwFAYDVQQKEw1Ccm9hZGNvbSBJbmMuMSIwIAYDVQQDExlTZWx2
aW4gVGh5cGFyYW1waWwgWGF2aWVyMSkwJwYJKoZIhvcNAQkBFhpzZWx2aW4ueGF2aWVyQGJyb2Fk
Y29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANqzadW0/yOQaEN6JQ913E1A
qwuLkRxyCYYCajkqDMrYVY1SjcJX/e53ER/L+FZKafnRX9YNemzaRHR4vevD3fO1lW94Lp6Af1Yc
ntj6Fh39AuKwqxFRjgmPxGRgZJ7QanBeDb2/FPA0wT4d2BLt1H5XD8GVdFflnPcq4SwA5Vne7j07
8FiCffeHJWoQjKQNLCaYXQAHXRlpa7/Oz1cOfJU6MrfUYCl8bKGzFPzTrsWCkLTSePmEOKjkQswO
E57pwqmNNXKez5LsgWg0MCcM26jqs8SBTJIA/6zJgjW8nK8WLLIPfCZO1NGVxIkHTjVy2Du2fAKX
qPfnml4GF/qROS0CAwEAAaOCAdEwggHNMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEw
gY4wTQYIKwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVy
c29uYWxzaWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFs
c2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0
MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNV
HRMEAjAAMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJz
b25hbHNpZ24yc2hhMmczLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAd
BgNVHQ4EFgQUKr67/GLyV/C27HDAeg3i3tW9facwDQYJKoZIhvcNAQELBQADggEBABQEPPwx33W2
mW8bSM5/AERxpztkHy4343YTHPsNXO/WrC+SuEQTYhV1eMrJbh1tZduP2rKgvZskl65mPF3qkRWi
J4J0DABOqmcJmyNoeIeXxcZx9bJqjiQWTT2iV+cCTYuiDrA+JUVKoMnmGwh2aSz6BH9Jsv2PFCNS
A6WyTEkC5z+3rM1f91ynuoPZCsYw/V1Hm5Nb+8lCB+0vqbUNUU3vlsiCuyym/XpDULrdf+qAGK+z
fntrEGyEOXbwpxyp5YGNdslhesuWawlpJUy3JSzRI9vx1SS2UaXG1+tsbKMkc1OyML6gl7W2AGPy
KN/Okg/+FqXwVaCbzR83sc69+FYxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENB
IC0gU0hBMjU2IC0gRzMCDCokiEUX3rGKhbywTjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0B
CQQxIgQg79KOpUiGMAfmaRdI3C8P+fgFuRovGKKZoR3UDIxRHjIwGAYJKoZIhvcNAQkDMQsGCSqG
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEwMTExMTgwOTQ2WjBpBgkqhkiG9w0BCQ8xXDBaMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3
DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFLaEymfLa8/
E5sGqE26kmoV4CxjUn6sjfqKiFIw1k0GCoutP+ID2QwwDGptvWpSXBeEGWFd5wTQQ60c7dXFJyM6
+6I83El+pW4JzZqhS26Lj5rIk07CvmRh3m2DqOixywHFN2nHKsQaM3FsKWt5VoDkIPuCXcVj42e8
AwtMXPEEe+MdNpDNlsCl3m/kS29ZWVsZifkUSYd+WUQwYL/pwz+DAHBrXfQq3SP00yhjcx1PcE3U
ppH5BBnHtA6DJFki7RMaCH0kLt+AFhcLLMVxA+xm7tHFdNdxln5tjdiZqYzEdcP51f4DCWG1l11e
ClNNCoBivIhzkZR5eMPm+Hnf34I=
--000000000000a8ca9205b8a3cf47--
