Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D527781B83
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Aug 2023 02:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjHTAKb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Aug 2023 20:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjHTAKH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Aug 2023 20:10:07 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6089917DDEA
        for <linux-rdma@vger.kernel.org>; Sat, 19 Aug 2023 13:04:32 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d299ed34bacso4366925276.1
        for <linux-rdma@vger.kernel.org>; Sat, 19 Aug 2023 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692475471; x=1693080271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TWeGdcVvP7ehBN5Nmp5lFEImea2uLutgVJ4S5aL3qW4=;
        b=G3AeXUU3GLPnD4y3ffTgOAPHHq1MH8sGLmnHOAtRcRbdW5nzc3Pgax64X1pWAhHwM6
         cfelcaDuCVFESueFl4wQGnly/GTrw8C1xFVWqLWCcLBwDdckwcqxIRjtnIUYf4d1xsMG
         C02EEIRt1GLp8h4emSdmtkartEcZdSeLUDiMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692475471; x=1693080271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWeGdcVvP7ehBN5Nmp5lFEImea2uLutgVJ4S5aL3qW4=;
        b=HqsKScB8fh8NSlN8A1cGq19d8kPiy4Z78RQfaZYT+1culJ32lRoCQ9H2DkbSpAo0XB
         31eoygQkqOrBSjU2o/FGR+n7CW73d8l6l9C69trP2CImHtaZC2SJcv9VEPFAKpkC0mKb
         ZYCBZfnqhSnJq5gv7puTONdVm5BaBAxNk6mJ2W6tpdXXC8tBREu63cjeNTpHpMFI9dHN
         /tRNmh84Qpk0RzxZO2fgIPDAwJXoktidHFJCREZdg8nZie7dpUtSBxTnD0gTJr5V1nZ8
         Zy6EVlbWqMFJku35BXmG1Nq8r+CLs/mtFV+gEXg4e1rVlIyVSEVJP6t+M1rPyybpl/Ud
         WLFQ==
X-Gm-Message-State: AOJu0YwHXZ0Dh2fiScbFKIt3goo/VieZwUpoXHGArap9SbtpHj6lHzgj
        Iyb4nG982SyugeZeNt4mYVpMlx1uktDOaE3Bu0viyg==
X-Google-Smtp-Source: AGHT+IEY7BLBtt5cX3zoXTulKyAKI+4tUrth2nmY04O2Nb3EAC9IzWOZ/QRvThx3cTFyXfNZLAWsOibmunvJ9mi95TM=
X-Received: by 2002:a25:bed0:0:b0:cb2:7e6:191c with SMTP id
 k16-20020a25bed0000000b00cb207e6191cmr1935153ybm.20.1692475471517; Sat, 19
 Aug 2023 13:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <1692032419-21680-1-git-send-email-selvin.xavier@broadcom.com>
 <1692032419-21680-2-git-send-email-selvin.xavier@broadcom.com> <ZN+aZiK+BJY98vmb@nvidia.com>
In-Reply-To: <ZN+aZiK+BJY98vmb@nvidia.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Sun, 20 Aug 2023 01:34:17 +0530
Message-ID: <CA+sbYW29xcfBWxkXDS7BhMUCXOFo2KznVnRRPwd0=+E3KFpoYA@mail.gmail.com>
Subject: Re: [PATCH for-next 2/2] RDMA/bnxt_re: Protect the PD table bitmap
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004a496b06034c2757"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000004a496b06034c2757
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 9:50=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 10:00:19AM -0700, Selvin Xavier wrote:
> > Syncrhonization is required to avoid simultaneous allocation
> > of the PD. Add a new mutex lock to handle allocation from
> > the PD table.
> >
> > Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  2 +-
> >  drivers/infiniband/hw/bnxt_re/qplib_res.c | 26 ++++++++++++++++++++---=
---
> >  drivers/infiniband/hw/bnxt_re/qplib_res.h |  4 +++-
> >  3 files changed, 24 insertions(+), 8 deletions(-)
>
> This needs a fixes line, it seems like a serious bug??
Yes. It is a critical fix. Will add fixes line and post a v2.
>
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infini=
band/hw/bnxt_re/qplib_res.c
> > index 6f1e8b7..79c43c2 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > @@ -642,31 +642,44 @@ static void bnxt_qplib_init_sgid_tbl(struct bnxt_=
qplib_sgid_tbl *sgid_tbl,
> >  }
> >
> >  /* PDs */
> > -int bnxt_qplib_alloc_pd(struct bnxt_qplib_pd_tbl *pdt, struct bnxt_qpl=
ib_pd *pd)
> > +int bnxt_qplib_alloc_pd(struct bnxt_qplib_res  *res, struct bnxt_qplib=
_pd *pd)
> >  {
> > +     struct bnxt_qplib_pd_tbl *pdt =3D &res->pd_tbl;
> >       u32 bit_num;
> > +     int rc =3D 0;
> >
> > +     mutex_lock(&res->pd_tbl_lock);
> >       bit_num =3D find_first_bit(pdt->tbl, pdt->max);
>
> Please make a followup patch to change this into an IDA unless the pd
> max is really small. Don't opencode IDAs in drivers..
pd max is 64k. We will create a followup patch . Thanks.
>
> Jason

--0000000000004a496b06034c2757
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
XzCCBVswggRDoAMCAQICDHL4K7jH/uUzTPFjtzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE4NDdaFw0yNTA5MTAwODE4NDdaMIGc
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xIjAgBgNVBAMTGVNlbHZpbiBUaHlwYXJhbXBpbCBYYXZpZXIx
KTAnBgkqhkiG9w0BCQEWGnNlbHZpbi54YXZpZXJAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEA4/0O+hycwcsNi4j4tTBav8CvSVzv5i1Zk0tYtK7mzA3r8Ij35v5j
L2NsFikHjmHCDfvkP6XrWLSnobeEI4CV0PyrqRVpjZ3XhMPi2M2abxd8BWSGDhd0d8/j8VcjRTuT
fqtDSVGh1z3bqKegUA5r3mbucVWPoIMnjjCLCCim0sJQFblBP+3wkgAWdBcRr/apKCrKhnk0FjpC
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJG0TY7jBQy5
wBpMgXieA0qd+HGNQb0GgUV+v1N50HRAMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDgxOTIwMDQzMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBfH2FHz8fvurA5p2FMaRZ8KXrs5ZlE
twCPpTHtnMkg2dRzhg6tc0RAJ6Z6csEfRjYBoqRR3lEJMBEh0tDVAKsrs07LQa+l6OEb1QNFTNWj
nljh5yuEW0ZOCibfx+BpDsCa555FRscHC/j2UWj1sFzLQriqX2/VwUq/byq+q1E/KZXi8EUfyy7U
ad91IxY0X7wJExfFQPGR2gaW4FZ7MQYYrhddBLwLSwK+itXfS7PNdRFf94YQO50lcqkgXOgOMiy6
cK8zEiDsHU92gBPOmRvkVUgJpmyLGVJgzwsbnroJwnFtDqE5R/EikPqvfdvv5gPbdmA1XE8TUWbZ
2YrX7Fjk
--0000000000004a496b06034c2757--
