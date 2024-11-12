Return-Path: <linux-rdma+bounces-5935-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 928779C5207
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 10:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B52B2E749
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 09:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B1720DD42;
	Tue, 12 Nov 2024 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XTJwkX5t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30DD20D4E2
	for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403527; cv=none; b=JMkO2+Gb8OP7TAI9ou84hVzxpNS0eIAPuyHLz7NiMPS2IfilTS61a57skHoIZVK5rMOyq4VnUPoj4Wk6BJ4lmiiqcNA3b+BTi5I5h5dPJkf0eQg2UHaBUnJ3AatKsTwPl6jCogmwwlCdOILr5E0bZNKjQvJ6I86auFiERZf3fmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403527; c=relaxed/simple;
	bh=A2pPYyjVf1GSl/zqDlVl2bLHdGohsPJHM6bTfUtcYcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4wYMfty05BN11KXq+F+Fy6mKAwi8oKu+CvoUxPYj/e3tOWrqS5Akz63fviTQw1pyy8pTNufDvc/0JdjH6U3bwSHbGEjfEW3wabTT36z9PirolU9980hTYxFnBUuzfhrXzmz9RKmXwHehZqTZvXPnVbXfdy6vYfFL6mEsp11DB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XTJwkX5t; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e377e4aea3so42829407b3.3
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 01:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731403524; x=1732008324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J/MSHj2lzu8SPF1/p/SFzF0wJ5aPryWbuEkBuEq4w8U=;
        b=XTJwkX5t56aD8E9VtypbuSC0di0C8QQ1E/0VVe8Xym5lIo+XEwyykvjBTbopbfbC+X
         gD7Gge/sEqeHNjKlkFHPIXkproy5Vgf/VCbvgEKAnkmeZxNoOgmikPI7IAKe31khwh7q
         e81N0w8Q0bFpwtojiuSGmTQuq+tBjWI9xFUlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731403524; x=1732008324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/MSHj2lzu8SPF1/p/SFzF0wJ5aPryWbuEkBuEq4w8U=;
        b=ud2V5EYoUnJ5h0qMVdmxnBCjZ64V11PjFtQ5UxK8J0UcsPY4mAy7FfT1P3c4hHj9yf
         qbcrBxiJvhCEQmP7Pd2e0pokgLdM8vMijsPP3yNBWTgDFm8xa4h3dcZ99f3ZnHbC28lX
         J/08mZDOX4jeQFYihRpDh6KsrEYM+aG++wnlMst0VfyUXhad8d+GVklvklTuf/Dlb1fE
         Sa9QV2Q8h7zv+Xz8oKzaIEtckHxyfXtm5fiW4jyddA8eEQ8gDsLjIa7hEu3iu01EmuLK
         NoIoEBT/bxR6xxqloTHq03Qn92HaNyjVNm0gF4XMZt2s9yVSBvaoIKQkM24InnS6n0TC
         7EZg==
X-Forwarded-Encrypted: i=1; AJvYcCUwvfvhY1VvaJKFTFQCoNfcpTI3tqCpV4i2W7/6yvAHvDBwzN0F1i2/BSlxty9OCv6C4L8+OZWINQDx@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQVbQc3s8gNN54bemJHazzinzXGNJmO8FSz2mDAGM6NXmpggo
	eFyr5JrdS+GnnbyV3wyqdA9eiNIAlQycAjLYyPjyu3cbL7fUb5k8WFVucxtFcn2i2wqhEIyDapw
	gAQi5e0+7MK2k6ogG7keHpBProKdCVRX2+N3C
X-Google-Smtp-Source: AGHT+IE0QdUCsu6CRyM0Ed+bFnzf3jmr0KzLBwBmsSc84wzhPHf8j7oNyAE+xLO0PuTZNMdkNKt3mK+FobndxpS/a1U=
X-Received: by 2002:a05:690c:f88:b0:6e3:453f:fbd5 with SMTP id
 00721157ae682-6eaddfb83b2mr142791167b3.36.1731403524680; Tue, 12 Nov 2024
 01:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
 <1731055359-12603-6-git-send-email-selvin.xavier@broadcom.com> <20241112081746.GI71181@unreal>
In-Reply-To: <20241112081746.GI71181@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Tue, 12 Nov 2024 14:55:12 +0530
Message-ID: <CA+sbYW2BAUXLyk0Fa_hmXoQ1e7Ocmj-jw41JNBmjJQupimaD8Q@mail.gmail.com>
Subject: Re: [rdma-next 5/5] RDMA/bnxt_re: Add new function to setup NQs
To: Leon Romanovsky <leon@kernel.org>, Michael Chan <michael.chan@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000011851a0626b3cc17"

--00000000000011851a0626b3cc17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Michael Chan

On Tue, Nov 12, 2024 at 1:47=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Fri, Nov 08, 2024 at 12:42:39AM -0800, Selvin Xavier wrote:
> > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> >
> > Move the logic to setup and enable NQs to a new function.
> > Similarly moved the NQ cleanup logic to a common function.
> > Introdued a flag to keep track of NQ allocation status
> > and added sanity checks inside bnxt_re_stop_irq() and
> > bnxt_re_start_irq() to avoid possible race conditions.
> >
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h |   2 +
> >  drivers/infiniband/hw/bnxt_re/main.c    | 204 +++++++++++++++++++-----=
--------
> >  2 files changed, 123 insertions(+), 83 deletions(-)
>
> <...>
>
> >
> > +     rtnl_lock();
> > +     if (test_and_clear_bit(BNXT_RE_FLAG_SETUP_NQ, &rdev->flags))
> > +             bnxt_re_clean_nqs(rdev);
> > +     rtnl_unlock();
>
> <...>
>
> > +             rtnl_lock();
> >               bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ctx);
> >               bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
> >               type =3D bnxt_qplib_get_ring_type(rdev->chip_ctx);
> >               bnxt_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type=
);
> > +             rtnl_unlock();
>
> Please don't add rtnl_lock() to drivers in RDMA subsystem. BNXT driver
> is managed through netdev and it is there all proper locking should be
> done.
The main reason for bnxt_re to take the rtnl is because of the MSIx
resource configuration.
This is because the NIC driver is dynamically modifying the MSIx table
when the number
of ring change  or ndo->open/close is invoked. So we stop and restart
the interrupts of RoCE also with rtnl held.
>
> Please work to remove existing rtnl_lock() from bnxt_re_update_en_info_rd=
ev() too.
> IMHO that lock is not needed after your driver conversion to auxbus.
This check is also to synchronize between the irq_stop and restart
implementation between
bnxt_en and bnxt_re driver and roce driver unload.

 We will review this locking and see if we can handle it. But it is a
major design change in both L2
and roce drivers.
>
> Thanks

--00000000000011851a0626b3cc17
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIB0KCWCwKtT2
VRiSAudCqhRW2751oHrhY83r48IeMg6jMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MTExMjA5MjUyNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDbS+s3UeVkQCM8nBHWOAWYutQeeCaC
XwVuvztaXcIsYuBIHS0fF1eFownCXnlqaZdlaOc1atFEoTNvpaZDidJkS9IkQH37ohAm3R7PfjXO
X5+72clVPUb90bubc4w+yeKKdW3Asreg82rRMPRBfQWQhxihULCWoq+3iRuRkP+JeOggKgvIt/0N
0KUXTTpGsFaYjJ+rLGUd+TuuH1OQKIgtqdSEbOKM012f/Y8nVDbi0jGyKcSgssHpygq+1Af0HHu+
0omxYoPW5xlFNVJpDsGmalmGP7AyfwLRiU7Ic9yrVUFSfgDonHS4OO93bR8gOgItI9BNBeV4JV8w
ozI0jNU+
--00000000000011851a0626b3cc17--

