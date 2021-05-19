Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B003892F4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 17:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346171AbhESPuJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 11:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbhESPuI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 May 2021 11:50:08 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE5C06175F
        for <linux-rdma@vger.kernel.org>; Wed, 19 May 2021 08:48:48 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a2so13141417qkh.11
        for <linux-rdma@vger.kernel.org>; Wed, 19 May 2021 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x63CDkbpjrpOmS69kD+XBMLK30BCtwwCMgbZs5D9GJU=;
        b=KYJbuaE8MNqDFjrByUBoDljcz28pqSJ9IP4Zw+X4uKNMUhKlxfswUoyprquRcXOJli
         WDpGqYUed+S7+EgZDjz8FXzyWWEs/+1whaSM1uHfI0PghjBQWkSJOLNN8wXWf19klAMP
         6nzX/cq0poJTOjbubMToa/w//IlMTTZxfDIlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x63CDkbpjrpOmS69kD+XBMLK30BCtwwCMgbZs5D9GJU=;
        b=bdmgvn2vZ3hKcTZEw8A0AkR+P3KvoVfZl9gH+6fB2m/nRlr8PJfZbCOA96dBBrnzjn
         /ezS9A/HJuvNkypFxUFr6S9rQ2yfdv3gIQ2df2Wfhsaxl31MpvW/F0eG0/WFQl04tCsr
         bEmGA4j8xueU7FoMa+Rc3aCCfnWpswuB9vOTB8UKlAZzg5yt3gdtX1BeO3QaQbniQ7Zb
         ac3grVKAdog5D9l1/CjTcKF59AgnLXmpOLxPmwspSEBLF2hO0dAziFxjW/i8Mi79NFc8
         GPppf5ket3yu0TkpU1x2LTSLytvJ8vvtO3nH0rTEsfEJNMuT1DBBPP94ttAcOPgx8/Pp
         e4vg==
X-Gm-Message-State: AOAM530tltFFOnVHMrTCfEPWD2to72FFLnAde4fuKnb9gTYdFvqXyWGx
        HwDHRBTaG6oQBWjw4nO2rzhWI/lyZ6XsbtWM5Fr1zH6Lt4EQAw==
X-Google-Smtp-Source: ABdhPJwZwVD+kyRUuOTktBvTZ5Za37jJQ+TyMFMBcT9ECOjFv6LwxBw+Dfp8Mme50c2x4FW04fBEBSvt3LxAf+VPwAA=
X-Received: by 2002:a37:5c7:: with SMTP id 190mr8882553qkf.169.1621439327621;
 Wed, 19 May 2021 08:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210517133532.774998-1-devesh.sharma@broadcom.com>
 <CANjDDBgR_wP5WHWWRue_Pg8XYujcuoqFs2J-zHD0c2g9+bRfjg@mail.gmail.com>
 <CANjDDBjO4dOXCb5rVe1UOd6foeFp8FLTqJbz8w6c36eTZSZtkg@mail.gmail.com> <YKUwKa6fNfBq8b8a@unreal>
In-Reply-To: <YKUwKa6fNfBq8b8a@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Wed, 19 May 2021 21:18:11 +0530
Message-ID: <CANjDDBgM5pgaCJoMM-nFwGFJOu7g2qcTQaM957-RFiUSKK-_vQ@mail.gmail.com>
Subject: Re: [PATCH V2 INTERNAL 0/4] Broadcom's user library update
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000030f20b05c2b0c334"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000030f20b05c2b0c334
Content-Type: text/plain; charset="UTF-8"

On Wed, May 19, 2021 at 9:05 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, May 19, 2021 at 08:45:20PM +0530, Devesh Sharma wrote:
> > On Mon, May 17, 2021 at 7:08 PM Devesh Sharma
> > <devesh.sharma@broadcom.com> wrote:
> > >
> > > On Mon, May 17, 2021 at 7:05 PM Devesh Sharma
> > > <devesh.sharma@broadcom.com> wrote:
> > > >
> > > > The main focus of this patch series is to move SQ and RQ
> > > > wqe posting indices from 128B fixed stride to 16B aligned stride.
> > > > This allows more flexibility in choosing wqe size.
> > > >
> > > >
> > > > Devesh Sharma (4):
> > > >   bnxt_re/lib: Read wqe mode from the driver
> > > >   bnxt_re/lib: add a function to initialize software queue
> > > >   bnxt_re/lib: Use separate indices for shadow queue
> > > >   bnxt_re/lib: Move hardware queue to 16B aligned indices
> > > >
> > > >  kernel-headers/rdma/bnxt_re-abi.h |   5 +-
> > > >  providers/bnxt_re/bnxt_re-abi.h   |   5 +
> > > >  providers/bnxt_re/db.c            |  10 +-
> > > >  providers/bnxt_re/main.c          |   4 +
> > > >  providers/bnxt_re/main.h          |  26 ++
> > > >  providers/bnxt_re/memory.h        |  37 ++-
> > > >  providers/bnxt_re/verbs.c         | 522 ++++++++++++++++++++----------
> > > >  7 files changed, 431 insertions(+), 178 deletions(-)
> > > >
> > > > --
> > > > 2.25.1
> > > >
> > > Please ignore the "Internal" keyword in the subject line.
> > >
> > > --
> > > -Regards
> > > Devesh
> > Hi Leon,
> >
> > Do you have any comments on this series. For the subject line I can
> > resend the series.
>
> Yes, the change in kernel-headers/rdma/bnxt_re-abi.h should be separate
> commit created with kernel-headers/update script.
Okay sure
>
> Thanks
>
> >
> >
> > --
> > -Regards
> > Devesh
>
>


-- 
-Regards
Devesh

--00000000000030f20b05c2b0c334
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
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKIdVnlwXMYxa555zPqrDw2XY/lz
PDcNU1AEdtBzXauUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUxOTE1NDg0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCOudJNh4MmVVa/EVuKi6nyxlZGZ3VFdzT2zHo5BVUEV6gv
J2saPBvXDUfxzxv9aCcAJot7nsBnL2/00AMIxhjSgi/19fpTsleypEqts3EOFE4RkimcUfy4W4Ws
BJCm34qrODA1EflqrCrspoicvayvzy4DqGCzkb5rkJg2rNMMMt/54rFrm1k0R7Y+rv8gwQ55PEg2
FjrUyqOGU1ArysMYMOFcLadL7ZZEUr8Wqnu3NctFU0YgVapu99H2QiBw0a9kmGMgUDQD5p4zbZme
ZKHniGLWuN7ExLwxbOON0eS3VaEFUBiZdqQhR8/8jHWFp62n5ZYNbGiI16WkQGUxMnA7
--00000000000030f20b05c2b0c334--
