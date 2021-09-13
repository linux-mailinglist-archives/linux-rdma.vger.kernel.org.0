Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600164089E5
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 13:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbhIMLMV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 07:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239218AbhIMLMU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Sep 2021 07:12:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B8EC061574
        for <linux-rdma@vger.kernel.org>; Mon, 13 Sep 2021 04:11:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id t19so20140484ejr.8
        for <linux-rdma@vger.kernel.org>; Mon, 13 Sep 2021 04:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dodeIrJw/KinDahz4MVZqoTvg3fWXcQ7QggqRsvEe98=;
        b=X7CPP+88R24a6JTuD2C7tiS0lHkM4b0vuuml9eG9ztmXjRSzyFUDG1xaWsFWdWEV/L
         IgTS4Me5UlLF7fx7KQ6w3bj+TzpJbJwXUXHozJBy3S2fxqn4L/ZE1KOxXDhqh2dSkpzw
         FTd5tsB7rTGMdkGeyA2dkRXiXfTpC59xrsP3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dodeIrJw/KinDahz4MVZqoTvg3fWXcQ7QggqRsvEe98=;
        b=QbaNHoX+N9Q0nQMgbl8lVNO6QjajQ9kecjIO85y5nrhnFFxvU6PoaSiaZa/yScG8OB
         SVHBgddMZQhWEH2XwWJaUaz3TbFK2jx+7fRg+kNjoav0+P0TynWTzcXVjwFiz7fmhBph
         J3UaYsoIR/K/HeNC7Ne5heVT1BGFGkj4OKUycZNBuYA98srK2sX7bq8mtSWtS7kIBHuW
         eHX52JnRRiSdc96bIDCnhGwZUnZoa+AYgZiqh2RqaJNLf26yYY+rZk9MFcvfqhNHRXzN
         13zGEmkXEOlhnXP0LFj9+O0K7G6OpVJ/WRSuAOJpccGTjWOe8kpre7vb0j/P2taIymRc
         dbSQ==
X-Gm-Message-State: AOAM530GKaR/ZhRHfW+pEjODr9iPaaNvK/bjMScwskDPAnw/4p5opYy6
        H9dmgI0gylR+jCOU9MHwQkkA+yhYSKXoHFcYEdTR7w==
X-Google-Smtp-Source: ABdhPJyMHwHAmwpexe9WqwNc6UjgIScTkCL8aYrOcuPl41lkJRSuGtlzrZJgw10Ojr0KYxQEZ3H643UC5TJJiApRRYc=
X-Received: by 2002:a17:906:3157:: with SMTP id e23mr12187895eje.29.1631531463432;
 Mon, 13 Sep 2021 04:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
 <1631470526-22228-8-git-send-email-selvin.xavier@broadcom.com> <YT8uNPMzuLsBlOTd@unreal>
In-Reply-To: <YT8uNPMzuLsBlOTd@unreal>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Mon, 13 Sep 2021 16:40:52 +0530
Message-ID: <CA+sbYW37rqodaqgG4_w1fA=p1QT44OMv7nGuRn=3yPx6FtLZNQ@mail.gmail.com>
Subject: Re: [PATCH for-next 07/12] RDMA/bnxt_re: Fix query SRQ failure
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000057ce9905cbde85bb"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000057ce9905cbde85bb
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 13, 2021 at 4:25 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Sun, Sep 12, 2021 at 11:15:21AM -0700, Selvin Xavier wrote:
> > Fill the missing parameters for the FW command while
> > querying SRQ.
> >
> > Fixes: 37cb11acf1f7 ("RDMA/bnxt_re: Add SRQ support for Broadcom adapters")
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> > index 539b1a2..e2926dd 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> > @@ -713,6 +713,8 @@ int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
> >       sbuf = bnxt_qplib_rcfw_alloc_sbuf(rcfw, sizeof(*sb));
> >       if (!sbuf)
> >               return -ENOMEM;
> > +     req.resp_size = sizeof(*sb) / BNXT_QPLIB_CMDQE_UNITS;
> > +     req.srq_cid = cpu_to_le32(srq->id);
>
> You already have this line.

ok.. I will remove one of them. mainly the fix was for the resp_size..

Thanks
>
>    698 int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
>    699                          struct bnxt_qplib_srq *srq)
>    700 {
>    ...
>    708
>    709         RCFW_CMD_PREP(req, QUERY_SRQ, cmd_flags);
>    710         req.srq_cid = cpu_to_le32(srq->id);
>
>
> >       sb = sbuf->sb;
> >       rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
> >                                         (void *)sbuf, 0);
> > --
> > 2.5.5
> >

--00000000000057ce9905cbde85bb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQfAYJKoZIhvcNAQcCoIIQbTCCEGkCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3TMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVswggRDoAMCAQICDF5r4Y1hK+0xlnInPDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIxNDE4MjNaFw0yMjA5MjIxNDUxNDZaMIGc
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xIjAgBgNVBAMTGVNlbHZpbiBUaHlwYXJhbXBpbCBYYXZpZXIx
KTAnBgkqhkiG9w0BCQEWGnNlbHZpbi54YXZpZXJAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAxUvDzFRYD8BTJrAMQdCDuIfwWINjz4kZW2bdRd3xs/PuwwulZFR9
IqmPAgBjM5dcqFtbSHi+/g+LZBMw6k/LfLLK02KsorxgMOZVCIOVCuM4Nj0vrIwtMJ+fNnaa6Dvu
a85G89a0sBrN3Y6hDnOfpbimSOgwA82EFWkGY4VggzfB7w1rhwu515LAm0sN0WOsrGP7QI8ZJr8g
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
Agxea+GNYSvtMZZyJzwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBlOvrrd+9Ky
a50QEe5ix9jyYJQ8Lo1dJD3AIdqujXtLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDkxMzExMTEwM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC2qD+9G3CYh2xUtXqpYTmbNaAAGjj7
D/5NfIizgVGBwwRJ3a2N3igMH8P0MuS/BFvoSyWywa78wJ8Gt9j4kZqp/sBk0MI7pNLfAcmXfodl
2U6LXN712JBoBuBKgw07gtPe5crWRoN/4/QoXpW8d2CMyQcRhEKVOll4XE8mBcrkmMh+d1hxVVOd
64r4IssiUTt5dwYOORvA2Y+hiWQQhZnD7PEdTVHRKlXhRl1GsemQxY21whyKas15e0xVWKrvqMhq
8DLsQ+8YzRneWLDG8Bs1tWcYh1g/G6QUPoPuOSwHp1rRxaWlKht8Ih16qrTxekaanzGILwUmoWu7
fVZpRwXA
--00000000000057ce9905cbde85bb--
