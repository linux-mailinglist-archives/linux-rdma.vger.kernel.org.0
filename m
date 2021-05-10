Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758F0377C3D
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 08:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhEJG1F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 02:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhEJG1F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 02:27:05 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A46EC061573
        for <linux-rdma@vger.kernel.org>; Sun,  9 May 2021 23:26:01 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h21so7434606qtu.5
        for <linux-rdma@vger.kernel.org>; Sun, 09 May 2021 23:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9cWQiVDccDrMcGJEFK8VId2DtgO4riwRWO3Rf8Y71gA=;
        b=e7qGvX6ELbJ/YmykHSQtbpv+wqyX0/PPIxsCMjt8uq2AVU4F4fl+0PyH9K58SJRtaI
         M2wV0n2fnhqpiLb4Qwagq6u1Z4lJYNf5Rl0ElC26RmgtXdnQFoJyqq+6dJop58WRDSBJ
         Vta0uNYfDGSKyzb5m7QQge1rnQeomh/FX3Nb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9cWQiVDccDrMcGJEFK8VId2DtgO4riwRWO3Rf8Y71gA=;
        b=LO7bXYUVdI4KZpUem+mPAx5wQTtBwsEIItBVJRnP32wgDPzNwREROYFTDBcjX5VwYZ
         Ei9VaGPGvqdymMwVTUfp03v8a1Ktm87dJEacT04sxHeaLCNbIuwOUYrvoorMSuNzazvL
         /KmFhDMjtedLZemmUBKdf+gjYxA6wQH+QwQZ+9QXd5b6TFo8samkm2abx0gLqV2XTS45
         bAeh+5NY46op2OWvguJFCzQy+u99WMyMJKMw4zAe/M8gD3uDfBVCJe4U0l//LQCDPPMh
         7jEps9bhWBflPBsjrrqwYPi89fmX9t8pH7LdMlVALBHRCruC6d3eU4cJTW10xuWSqRt0
         NWrg==
X-Gm-Message-State: AOAM532BoF34H6Wm0/PIyuJULhd6OiW189xxxjGDQ3xLVS0gEWu7eC2e
        Lkx8Mi9wAAt5seeNpD3xzcZaneJ5BTflEN1TLddrlRALPptzYQ==
X-Google-Smtp-Source: ABdhPJw26xK6NL2M5I/iqTlPmyX3wzDw/wGGfTmDluVUJ2XE0hjqxRZ9OAcj2dheO4QcSqZI5rhhcpPBuiD4sGfycck=
X-Received: by 2002:ac8:6044:: with SMTP id k4mr21352223qtm.374.1620627960271;
 Sun, 09 May 2021 23:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210505171056.514204-1-devesh.sharma@broadcom.com>
 <CANjDDBhyp_YzPE2s6S2HZx20vyrMOEdxhjx4kprtEQWxw+Aoyg@mail.gmail.com> <YJjHcUYLhMQGwoD1@unreal>
In-Reply-To: <YJjHcUYLhMQGwoD1@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 10 May 2021 11:55:24 +0530
Message-ID: <CANjDDBigmYJYocHpN8akxy1QxFgBT1FtVnOObkLz8Ji5-cYVUg@mail.gmail.com>
Subject: Re: [V2 rdma-core 0/4] Broadcom's rdma provider lib update
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e9dffd05c1f3d990"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000e9dffd05c1f3d990
Content-Type: text/plain; charset="UTF-8"

On Mon, May 10, 2021 at 11:11 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, May 10, 2021 at 10:33:48AM +0530, Devesh Sharma wrote:
> > On Wed, May 5, 2021 at 10:41 PM Devesh Sharma
> > <devesh.sharma@broadcom.com> wrote:
> > >
> > > This patch series is a part of bigger feature submission which
> > > changes the wqe posting logic. The current series adds the
> > > ground work in the direction to change the wqe posting algorithm.
> > >
> > > v1->v2
> > > - added Fixes tag
> > > - updated patch description
> > > - dropped if() check before free.
> > >
> > > Devesh Sharma (4):
> > >   bnxt_re/lib: Check AH handler validity before use
> > >   bnxt_re/lib: align base sq entry structure to 16B boundary
> > >   bnxt_re/lib: consolidate hwque and swque in common structure
> > >   bnxt_re/lib: query device attributes only once and store
> > >
> > >  providers/bnxt_re/bnxt_re-abi.h |  24 ++---
> > >  providers/bnxt_re/db.c          |   6 +-
> > >  providers/bnxt_re/main.c        |  31 +++---
> > >  providers/bnxt_re/main.h        |  15 ++-
> > >  providers/bnxt_re/verbs.c       | 182 +++++++++++++++++---------------
> > >  5 files changed, 138 insertions(+), 120 deletions(-)
> > >
> > > --
> > > 2.25.1
> > >
> > Hello Maintainers, Could you bless the V2 if there are no more
> > comments/suggestions...
>
> I planned to take it after rdma-core release (today/tomorrow).
>
> Thanks
Sure, Thanks.
>
> >
> > --
> > -Regards
> > Devesh
>
>

--000000000000e9dffd05c1f3d990
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
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAomreDZvvTg0SCK5pRe/72tVRi1
t50WQcv/Oxv1djqWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUxMDA2MjYwMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQB6ZkWzUFcKp81DqVDTj5xqWXRs58U5SZyIkMNfWCw4Y0fo
DBc2N2BtpvzK8zMI3qxsj7VLMhVGQX+argGeHUlcjPZLOdY6U/RrrJP50BUdFe1/8nQWEYDr17Pf
6XpVyETURADqxK9RjRlInul8Akcs1zwZOQq4EzogDTwe4DJ1D+dxkI6IKm20cXES339izGf3VJVF
DSPbCUIgwfEZJVTzUNWz5o+11Ah2rpzcQXwbZ67GGUvUjONiH/WETd1IXX0VnO/kL7MeCRlx5ITT
Gz1svqR4x4ICXfIxsRFYRknMyvxlFmWgkQRhXN+UnPJx3pB8pxue68bK2d52GLkcghPv
--000000000000e9dffd05c1f3d990--
