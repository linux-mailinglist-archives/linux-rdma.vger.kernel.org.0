Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F7876CA96
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Aug 2023 12:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjHBKP0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Aug 2023 06:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjHBKPV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Aug 2023 06:15:21 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F131FF0
        for <linux-rdma@vger.kernel.org>; Wed,  2 Aug 2023 03:15:16 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5768a7e3adbso11117987b3.0
        for <linux-rdma@vger.kernel.org>; Wed, 02 Aug 2023 03:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690971316; x=1691576116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NcxcLs7P3Nejy3kHm+RoNXReVtyU4ypWMo5MhwysPhU=;
        b=JuEZLtMDIqCDd1uH3Elrg29DZigS4NdbF4SQxoCF+bBSmM3kNs3z/WThbL/neWioHX
         qZs926Xoyt0BXht9Et2Z/v0l6idzOtx4j52BDXtuQYOWqJCBgx1TyNx9Mi518xDzeMFZ
         9kf7t5xpXiE3eJZESiH5J789PUQEI+ZzjHGIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690971316; x=1691576116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcxcLs7P3Nejy3kHm+RoNXReVtyU4ypWMo5MhwysPhU=;
        b=lO8NI5VKDLDvyiqMaA9pnArZ3lhff0X1JyiH+yqc6mv73KSyMKXlQ1Hrt6+Ozn+Vaz
         j3ooowU62BZwhJm41QJ3WinYW0H7ijetVpuQAEUBCZT2WZqBQFcZx9AGm0hXp4ANljzI
         WVTz1wHdNorMU8ISBTNxbwPBaJV8IHTjrnDroETgM9nG7RI6LRozThvtIyOD1rTpwkRj
         aBiurjUDK4QU76DTYlkvDInoU86JQpruMiO06wXtEfaY4/kfxZhhSNppFm7GDOAhNIPk
         AfdviTlVdFg2vhnZFhSGlHCsiP7p77GCW1Y2JrMmTkgM6I/81L+XcJGuxSeGf1A+mhX5
         FJog==
X-Gm-Message-State: ABy/qLYIN0Tl3kKhv9H/o2ohZx9NBW/9Y/ZK8MNqWZkePGJ9hC745R1K
        1SZmJGMhlVWTnntELz5bTT5je5rfDb3LbWt+3OpGDw==
X-Google-Smtp-Source: APBJJlGkLXg7HWxqfFXegj/xlZaphtGQidj73ilsB3mGPwkkzc2ETT+5V0LUOZRNVXEbstFegcaitNEzh9YPps1oSAk=
X-Received: by 2002:a25:2d05:0:b0:d0a:910b:44e7 with SMTP id
 t5-20020a252d05000000b00d0a910b44e7mr18690593ybt.8.1690971315722; Wed, 02 Aug
 2023 03:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <1690968759-9142-1-git-send-email-selvin.xavier@broadcom.com>
In-Reply-To: <1690968759-9142-1-git-send-email-selvin.xavier@broadcom.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Wed, 2 Aug 2023 06:15:03 -0400
Message-ID: <CA+sbYW0C9=V4L+TvNGpxP5+3W9BnH-Ei0dnWzRrqD-bP=qx=Fg@mail.gmail.com>
Subject: Re: [PATCH for-next 0/6] RDMA/bnxt_re: Driver minor update
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     andrew.gospodarek@broadcom.com, linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009e7bf00601edf03f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000009e7bf00601edf03f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 2, 2023 at 5:44=E2=80=AFAM Selvin Xavier <selvin.xavier@broadco=
m.com> wrote:
>
> Includes some of the minor cleanup and update on the driver.
>
> Please review and apply.

Please ignore this series. Some changes in patch 3 got into patch 2.
Seems like i made some mistake while amending a commit.
Will post a v2
>
> Thanks,
> Selvin
>
> Kalesh AP (5):
>   RDMA/bnxt_re: Fix max_qp count for virtual functions
>   RDMA/bnxt_re: Remove a redundant flag
>   RDMA/bnxt_re: Cleanup bnxt_re_process_raw_qp_pkt_rx() function
>   RDMA/bnxt_re: Avoid unnecessary memset
>   RDMA/bnxt_re: Remove unnecessary variable initializations
>
> Selvin Xavier (1):
>   RDMA/bnxt_re: Fix the sideband buffer size handling for FW commands
>
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  1 -
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 36 ++++++--------
>  drivers/infiniband/hw/bnxt_re/main.c       | 35 ++++++--------
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 44 +++++++++--------
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 36 ++------------
>  drivers/infiniband/hw/bnxt_re/qplib_res.c  |  8 +--
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c   | 78 +++++++++++++++---------=
------
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h   |  2 +-
>  8 files changed, 100 insertions(+), 140 deletions(-)
>
> --
> 2.5.5
>

--0000000000009e7bf00601edf03f
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHRm7Gz/RHJY
0bfFQW5Pi90qg2mEzF+x8nYMpIgWs7SFMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDgwMjEwMTUxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAcW78vjhAHR1tZMOvfGjdSlfFJJ5V7
fAHNGihk2TMesiFsjw/AZjwx4KYQXRh/dgoNafB1t+gWfPgPV6OuoMZ9/IxZtACdUPuTPl9asBeP
OIcpoO/1YBusyVZhi3S7DJikhDt2blyBZWnqrNx5rbDlh44dRtW/cJTIgBZAC5dyGO0yJiqAI0PI
hI7Qw1c8w0tgrsoBmqyNuzCWWz0tXDBGPeY+Q+W7jQVmhh86xs6woCrEzys6qeExFZAlLwfa0ubS
DmT90GC+Xo53SSV7Vl+2N6UjjB939vnXFG7nHnSw0v0sIp5oEYWVOA7oYDGv6mQeQTLZE2SP+5v+
/F+Na5Bg
--0000000000009e7bf00601edf03f--
