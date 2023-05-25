Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F48C710710
	for <lists+linux-rdma@lfdr.de>; Thu, 25 May 2023 10:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjEYIOO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 May 2023 04:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239102AbjEYIOM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 May 2023 04:14:12 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EAEE4D
        for <linux-rdma@vger.kernel.org>; Thu, 25 May 2023 01:13:47 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-561da492bcbso3747677b3.3
        for <linux-rdma@vger.kernel.org>; Thu, 25 May 2023 01:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1685002423; x=1687594423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh9Pmm4olHVt59wa1/6cupFV4nHNvw2HPHU9gqPMP2k=;
        b=FV7Oh52vF+YbzJCY9O1E7Oo9LG4x1BM3XbDCZpOBwQohZUeuYEb8vkogIb5JOGjN1H
         zB0QLziwI4XTxA2kSEbbm8eQe6JZOVb8cJEeoo+akrsk6YGNrGEPlve7L7AcM+HvJIuC
         tsZyglR3d6AFiknL45X+IgigQe2rzI/PMcTAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685002423; x=1687594423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dh9Pmm4olHVt59wa1/6cupFV4nHNvw2HPHU9gqPMP2k=;
        b=lx69qWVnTeRZeyCjR+Up7xkGaRT/5xcjbbNb0tqJKtHlF0rscE5UvH11z6/4u6a2c4
         TEfIeq1rR2G+chD80aS2Ew1Uiolbj1yqxJ7Dk9+9inG2NF3EhO2KvWxUCAbppG7LonuY
         m7T5Mo4mZOhSkqaQlAi6JeqkKMjkfwnPvIaN5d9mAxcqZT7lBVCPc7s+5yWjeHbRtomC
         9sKVH7taseBt53w1FeemqoPrwXdeuRya2CxL7NlnXSHxKrQh99TpYL84Q9lZpPDGhLgp
         lfhjUa01vX5tWetwYtNM+bPIVCJzQLhRJO3BmLmHn1dT7m8LWpWnVmnHcFiCObSsSesc
         4T7w==
X-Gm-Message-State: AC+VfDy1WjUle4aY0Bbw6qmbvQXfn4K4lYgik4ltFArWXQJ2cNRftYO3
        buPt95n3Ao33OvPyb1w5X2nw+RnriZn74eOE96qe7g==
X-Google-Smtp-Source: ACHHUZ7HJxCVTfzaz/LK4IdgChko8Ku4huAZ+Zrq+iiJ9s8QPb1dgrX6ekzId0pfLDeH7DjYQDYDC2H2OxSdbEMlwOk=
X-Received: by 2002:a81:d54b:0:b0:561:5168:43f with SMTP id
 l11-20020a81d54b000000b005615168043fmr21414221ywj.46.1685002422823; Thu, 25
 May 2023 01:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <1684141610-17588-1-git-send-email-selvin.xavier@broadcom.com>
In-Reply-To: <1684141610-17588-1-git-send-email-selvin.xavier@broadcom.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Thu, 25 May 2023 13:43:30 +0530
Message-ID: <CA+sbYW1sN2g3c2pj7vTCVq3rvmMfgpdTsekxf-YjDMyuvPwX8g@mail.gmail.com>
Subject: Re: [PATCH v3 for-next 0/6] RDMA/bnxt_re: driver update for
 supporting low latency push
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e31c2005fc8032db"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000e31c2005fc8032db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 2:48=E2=80=AFPM Selvin Xavier
<selvin.xavier@broadcom.com> wrote:
>
> The series aims to add support for Low latency push path in
> some of the bnxt devices. The low latency implementation is
> supported only for the user applications. Also, the code
> is modified to use  common mmap helper functions exported
> by IB core.
>
> User library changes are getting submitted in the pull request
> https://github.com/linux-rdma/rdma-core/pull/1321
>
> Please review.
Hi Jason,Leon,
 Did you get a chance to review this series?
Also, I am facing a sparse error  in the library changes.
https://github.com/linux-rdma/rdma-core/pull/1321 . I guess it's due
to the kernel headers generated. Can you please give some suggestions
to fix the error?

Thanks,
Selvin

>
> v2-> v3:
>   - Rebasing after the merge window
>   - Fix the return value check in bnxt_re_hwrm_qcfg
>
> v1 - v2:
>   - Fixes the review comments from Leon and Jason
>   - As suggested by Jason, implements the new uapi
>     driver definitions for allocating pages in the
>     driver and return the cookie for mmap
>
> Selvin Xavier (6):
>   RDMA/bnxt_re: Use the common mmap helper functions
>   RDMA/bnxt_re: Add disassociate ucontext support
>   RDMA/bnxt_re: Query function capabilities from firmware
>   RDMA/bnxt_re: Move the interface version to chip context structure
>   RDMA/bnxt_re: Reorg the bar mapping
>   RDMA/bnxt_re: Enable low latency push
>
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h    |   3 +
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 265 +++++++++++++++++++++++=
+++---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h   |  19 +++
>  drivers/infiniband/hw/bnxt_re/main.c       | 117 ++++++++++++-
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c   |   4 +-
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |   2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |   1 +
>  drivers/infiniband/hw/bnxt_re/qplib_res.c  | 177 ++++++++++++-------
>  drivers/infiniband/hw/bnxt_re/qplib_res.h  |  33 +++-
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c   |   3 +
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h   |   1 +
>  include/uapi/rdma/bnxt_re-abi.h            |  32 ++++
>  12 files changed, 555 insertions(+), 102 deletions(-)
>
> --
> 2.5.5
>

--000000000000e31c2005fc8032db
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKXE0H68X2JD
Uu3S7jx8Jqr2zLRUe0tqAMZk6220QfR4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDUyNTA4MTM0M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQACbHm3yzD9QZa+Wu8kIrFHhOyhf2wl
A0Ui5VR1TzR2A4+kHpyAv0cPdACYOvP4gIzVDn9a2pNROW5gT49sATNswTJ0tdku+xvC7tFXKMDW
iizZAOaBv2E2K7vdE8rM266OjWli6wzDkl/I2gcZ2PAipxNhqJcR3nEpFO87Fxe/o4poh8ei9QLM
R8Oz9mKLmwh/KnwYIs4C68hKjTVen0sgCvZVaQLziLgP47qxHzoQiyUvFU1bTcQ05OKgmZ3tTmkx
Y2K4UT8tCg4EO8DuM//WOpmxWoosTMsrW4rOFXg5nVww6Jvul7pPbg4OglF+3Nbkz07xImc5p84v
VcDOx27+
--000000000000e31c2005fc8032db--
