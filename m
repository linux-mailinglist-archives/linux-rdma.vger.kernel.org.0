Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89354396CA2
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 07:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhFAFH4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 01:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFAFH4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Jun 2021 01:07:56 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3A4C061574
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 22:06:15 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id p66so3797110qke.7
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 22:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=49D7npFC9zluETOYD2Df9MLKF3U17Y1wuAPVrxhDPC4=;
        b=e0dNxwBz/p0LbENJZgW2AGi0BYd48SDE03yTQ3X7k+v62d8AObavfZU4ts4UqtN2v0
         tpcvXLCslp1mCo7k70dOzB/uS5aVq++ctJ1TEFrPW7dT1DtGL0rIHcUXKsXG0dUGzQ43
         Jxp0/4XMROOrESI70lpK/4wyCK8U1Yf22bFoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49D7npFC9zluETOYD2Df9MLKF3U17Y1wuAPVrxhDPC4=;
        b=LHN7nQmYNVK+aXev4eCGt0+VnMrXBrlxgtoSBryBGkfCTFeyRobYQIHPzU3u6qUa+7
         qrxTzDpzRCawXIi/OPLeXtheWtaLIfKj2624o/EtZLD4nZZAy8qbyW6XPq6ykdUnqhTF
         +BV5szRx27mMYAKZM4a+diVYy6lL0G9JmHeU6r8gZdAi/qDKGkTnRapc9yGYks5sqqSv
         3CN6Mx1NN786274TUlvZgV7eX9W3iSCJMD24zM0p1RtX+dZ+Gi8cs8HnilehdBP0A8aa
         4PploAj4RknvRmi3IikawuQUKmG1xKEOQW4CObDsr8fMZK4ho7CipHGyY69t8kLCfRIa
         rN9w==
X-Gm-Message-State: AOAM5337tmHfOmSwNzETAVXK0Z1FSVtC0+fNXfxIXWO+Evxo9ZXECnkl
        F+Bda68EC7sKem/u4B/8M6UUwScfu7sqzxkrCwLqIFHAYyxYM4dB
X-Google-Smtp-Source: ABdhPJw6L0gSl5sCY4QdNfyid58Z6H6758OipwEKuycLFDw5Dh216PdpTWXcCX7Ri7tPovhOEP46vFfBQur38L0RLyY=
X-Received: by 2002:a05:620a:481:: with SMTP id 1mr19875727qkr.46.1622523973827;
 Mon, 31 May 2021 22:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210528093946.900940-1-devesh.sharma@broadcom.com>
 <CANjDDBi6VS+yyR7BjWY6_=YUEoxYojL6Yy=82i2sfbRzybGczw@mail.gmail.com> <20210531185303.GM1096940@ziepe.ca>
In-Reply-To: <20210531185303.GM1096940@ziepe.ca>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Tue, 1 Jun 2021 10:35:38 +0530
Message-ID: <CANjDDBiw3bXkQpA1=zT1K03QpzWT2Xniif02T6YaTVF55XZLTg@mail.gmail.com>
Subject: Re: [PATCH V3 rdma-core 0/5] Broadcom's user library update
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000020f1d205c3ad4dfb"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000020f1d205c3ad4dfb
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 1, 2021 at 12:23 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, May 31, 2021 at 10:09:06PM +0530, Devesh Sharma wrote:
> > On Fri, May 28, 2021 at 3:09 PM Devesh Sharma
> > <devesh.sharma@broadcom.com> wrote:
> > >
> > > The focus of this patch series is to move SQ and RQ
> > > wqe posting indices from 128B fixed stride to 16B
> > > aligned stride. This allows more flexibility in choosing
> > > wqe size.
> > >
> > > v2 -> V3
> > >  - Split the ABI change into separate patch
> > >  - committed ABI patch using standard rdma-core script.
> > >
> > > Devesh Sharma (5):
> > >   Update kernel headers
> > >   bnxt_re/lib: Read wqe mode from the driver
> > >   bnxt_re/lib: add a function to initialize software queue
> > >   bnxt_re/lib: Use separate indices for shadow queue
> > >   bnxt_re/lib: Move hardware queue to 16B aligned indices
> > >
> > >  kernel-headers/rdma/bnxt_re-abi.h |   5 +-
> > >  providers/bnxt_re/bnxt_re-abi.h   |   5 +
> > >  providers/bnxt_re/db.c            |  10 +-
> > >  providers/bnxt_re/main.c          |   4 +
> > >  providers/bnxt_re/main.h          |  26 ++
> > >  providers/bnxt_re/memory.h        |  37 ++-
> > >  providers/bnxt_re/verbs.c         | 522 ++++++++++++++++++++----------
> > >  7 files changed, 431 insertions(+), 178 deletions(-)
> > >
> > >
> > Jason/Leon,
> >
> > Both user and kernel components related to these changes have been
> > posted quite a while ago. Could you please take these in if there are
> > further comments.
>
> Where is the kernel part here:
>
> https://patchwork.kernel.org/project/linux-rdma/list/
Yes it is there:

"[for-next,V3,3/3] RDMA/bnxt_re: update ABI to pass wqe-mode to user space"
https://patchwork.kernel.org/project/linux-rdma/patch/20210526153629.872796-4-devesh.sharma@broadcom.com

>
> ?
>
> Jason



-- 
-Regards
Devesh

--00000000000020f1d205c3ad4dfb
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
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFr7F4tdAvk2M7aC3ACzhNRSBJLf
cayUHcx3hdH5zqWwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDYwMTA1MDYxNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQB+alszxOcLLP6dJwnUQ6VlmwqEfXpz91Ca8z0tIrICnTxn
PXk8y5ClHkRcrLPiwFiHC9rM8Ylr75EK/qacmK3BYCkWbaWN3BlV5kd154yDZkUwAAlFjacZ67fB
pJKK+ifvSjDsPqYQ6V8K0ChIbGrVRwuf3GpfhqnQ8iAiwnMPZVWOEOJ2tRcEZSR2CtIxaf14c3Wu
wS3LcrDJOt/wVtDN/Thu5F0QOqnz1kLQ0ZODZhuAU3h/qqNcf3T21VI4JLHK/bl6HVxcI9we/yit
Gc+Tp9W4sn5K7+gOrqUMcb3HOaZHym55tkl1SFz4Q/w+L01VjyG3+VxoyYcZohQ8iEK6
--00000000000020f1d205c3ad4dfb--
