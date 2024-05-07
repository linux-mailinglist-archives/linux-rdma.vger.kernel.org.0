Return-Path: <linux-rdma+bounces-2331-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B061B8BECB4
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 21:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26886B250F0
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 19:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A2B16D4FA;
	Tue,  7 May 2024 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QjDVnC31"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C4516C690
	for <linux-rdma@vger.kernel.org>; Tue,  7 May 2024 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715110621; cv=none; b=lVwVwpceCyqDZ2o3eT1y99CvECeCvOq18NvX75B9lca6NZZsVHNxIvaY5Jh142VZKXlNEjuBGIvfm9E65qBZVfO2YpTWERWlvQnfxda5/0FDMUzZ4IxP1WgBxo/4qcyWddB7JqpIq0JlPS9sct4+EYMliyWjfzJmED+FLL2zynM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715110621; c=relaxed/simple;
	bh=6li3TgtN8Tq0pPfW0a0zo5qSYqQduV4EvozlGa3kE2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nI2B4hsJ2Y7uJ4vqn91g53ElXoSgLXLCm4DRJWGDfyuhlQFrg8caKP0EjA3Wgwkjb+TFhRMJSVVxLyGxXliJ66CyhzgXNMaL0UavR3z++YoS9gHll1OMUjsRE+K7wcAn0wSkOxlJiBcS9LK+VZUvffwUglagpR474VGQ0PscpYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QjDVnC31; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso105291276.0
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2024 12:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715110619; x=1715715419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CGNkK2c3GgSvVVZ28Myr0QXIYCkrfUYZbCvS+OjA4K8=;
        b=QjDVnC31GKjbsDl1PcPsmGYMQ79y43itMCPqbANoUmtjGW6K2m3H3wAqC6fP++RyOj
         AOtE2xoleXRx+Tv+Xk/Trtn64G6rqdzAo4x/OpDzDam1+qfZW5eoS0rdppX/278shAyH
         BQo0PJj+6vybMx7BJ+MEIOBBXLyVfC7WNLzk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715110619; x=1715715419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGNkK2c3GgSvVVZ28Myr0QXIYCkrfUYZbCvS+OjA4K8=;
        b=S/4bfZuxRM7vMJcSQwpAc5/pdlRkQXClglxk7hDJPaze8CEffk0sDgkSnLHgDdtJQv
         3mluevc09OXUsKiFhog+2U7XzUpp3YvDPc2rLPhGhdd5XH2D969xFH72BoaoQ9ALOljE
         qsv467HlehGUlr/tFVXHpK9VH8o5kW5o3QAQv8dHxB7TLqnESmwzJTvueuw4aoe8OCNw
         U0CTQCTGPd2/XodkysfxOryBg6JgSxZEdk85vktGHt1X1GmFKmJnHNG45LGpsZlUKeTw
         U+JdTQKVjz/yoPvN4l+iyVd7pS+Q8qLnVdS+kxLs66k5NH4aRt5HUPbVZrizDVkfUddG
         G0PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuMfM3nbk1P0I+GEBQBWI2UzACnNCSivKaeZT0hfgScJr657gJBq/lEzZ+D8lSEYPMB7ltm0u3Dnr+W+u/zJjHFXFPbYL/wyLz+g==
X-Gm-Message-State: AOJu0YzK0nuGNCNoy+EyJ+hO9+XkXzq0K8rpWnBi55QGgpwPTm1tW6XF
	zLnDqRGY7HIYSYwKLHmwCHT3eJUL/273CPj0uYPSSohhjnkghsK82j/Izv3yhvCV31IRnGkwHBR
	TL+iWSimjHT+4VNVwqa/SDlgDsf9n9r5MYk5zwEDQb4BMFJNYFw==
X-Google-Smtp-Source: AGHT+IHynnplDUlh7yKe04EMpbVpQwmVxfzBSVB/eajVZGGq51Pf2xUpKygk2fNnoXUSiaTUMhXHk1gn2EDTCxhZIB0=
X-Received: by 2002:a25:d88c:0:b0:dda:c380:689e with SMTP id
 3f1490d57ef6-deba31e005amr2798177276.4.1715110618654; Tue, 07 May 2024
 12:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714795819-12543-1-git-send-email-selvin.xavier@broadcom.com>
 <1714795819-12543-3-git-send-email-selvin.xavier@broadcom.com>
 <20240506174701.GG901876@ziepe.ca> <CA+sbYW0VZ-tnHGkB=nod7M-aOXryORpWrvV2CKN0F_tjEE9+JA@mail.gmail.com>
 <20240507163436.GE4718@ziepe.ca>
In-Reply-To: <20240507163436.GE4718@ziepe.ca>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 8 May 2024 01:06:46 +0530
Message-ID: <CA+sbYW00RS2uaJ5agL9XzZTmzPFHz-K9U3SUDcup==K6iNfP0Q@mail.gmail.com>
Subject: Re: [PATCH for-next 2/2] RDMA/bnxt_re: Expose the MSN table
 capability for user library
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003284370617e24fa8"

--0000000000003284370617e24fa8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 10:04=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, May 07, 2024 at 09:57:17AM +0530, Selvin Xavier wrote:
> > On Mon, May 6, 2024 at 11:17=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Fri, May 03, 2024 at 09:10:19PM -0700, Selvin Xavier wrote:
> > > > Expose the MSN table capability to the user space. Rename
> > > > the current macro as the driver/library is allocating the
> > > > table based on the MSN capability reported by FW.
> > > >
> > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > ---
> > > >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 3 +++
> > > >  include/uapi/rdma/bnxt_re-abi.h          | 2 +-
> > > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/inf=
iniband/hw/bnxt_re/ib_verbs.c
> > > > index ce9c5ba..d261b09 100644
> > > > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > > > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > > > @@ -4201,6 +4201,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext=
 *ctx, struct ib_udata *udata)
> > > >       if (rdev->pacing.dbr_pacing)
> > > >               resp.comp_mask |=3D BNXT_RE_UCNTX_CMASK_DBR_PACING_EN=
ABLED;
> > > >
> > > > +     if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2)=
)
> > > > +             resp.comp_mask |=3D BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENA=
BLED;
> > > > +
> > > >       if (udata->inlen >=3D sizeof(ureq)) {
> > > >               rc =3D ib_copy_from_udata(&ureq, udata, min(udata->in=
len, sizeof(ureq)));
> > > >               if (rc)
> > > > diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bn=
xt_re-abi.h
> > > > index c0c34ac..e61104f 100644
> > > > --- a/include/uapi/rdma/bnxt_re-abi.h
> > > > +++ b/include/uapi/rdma/bnxt_re-abi.h
> > > > @@ -55,7 +55,7 @@ enum {
> > > >       BNXT_RE_UCNTX_CMASK_WC_DPI_ENABLED =3D 0x04ULL,
> > > >       BNXT_RE_UCNTX_CMASK_DBR_PACING_ENABLED =3D 0x08ULL,
> > > >       BNXT_RE_UCNTX_CMASK_POW2_DISABLED =3D 0x10ULL,
> > > > -     BNXT_RE_COMP_MASK_UCNTX_HW_RETX_ENABLED =3D 0x40,
> > > > +     BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED =3D 0x40,
> > >
> > > Wah? How can you rename this bit in the uapi?
> > >
> > > Looks really strange, userspace is even using this constant.
> > >
> > > Please explain in detail what is going on here in the commit message.=
 :\
> >
> > BNXT_RE_COMP_MASK_UCNTX_HW_RETX_ENABLED was introduced to share the HW
> > retransmit capability between driver and lib. The main difference in
> > implementation for HW Retransmit support is the usage of MSN table or
> > PSN table . When HW retrans is enabled, HW expects MSN table to be
> > allocated by driver/lib, else PSN table (for older adapters). So when
> > FW started exposing the MSN capability as a new field, we can actually
> > depend on the new field instead of HW Retrasns capability. For
> > adapters which support HW_RETX feature, MSN table capability will be
> > set. For older adapters, this value will be 0  (to maintain backward
> > compatibility with older FW).  I renamed the UAPI just to capture the
> > correct name of the HW capability that driver/library is interested
> > in.
> >
> > I pushed an rdma-core PR [1] also with the associated change. Even if
> > an older version of library is using
> > BNXT_RE_COMP_MASK_UCNTX_HW_RETX_ENABLED, it doesn't affect the
> > functionality and this is reason for renaming and not defining a new
> > UAPI.  If you feel that I should totally avoid this UAPI change, will
> > add a new comp mask and leave the current value unused.
>
> It is fine if it works, I asked you to decribe in detail the reasoning
> and outline why it is correct in the commit message.
sure. will include it in v2
>
> Jason

--0000000000003284370617e24fa8
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGX1bCWfPY06
sW7hmxJMRmx+avFkibW5l9Qu4HpXRi+UMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDUwNzE5MzY1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBRiEfYAh0XoyLuE9DUbQR13ZQlK7x5
/rJQULen2GPqaTvr1PczIz0TFWKCTc+mG4iwwDfTAc5vl4+HTcP+aJ3ulUsZacx4zs1ObfIGP6bL
wZtOvb6h65+0sbCJSS13CU3ZKWUPiIBhZBJO87FDF91SvASwU41Z9ulaL8s9ofBs0zynG+e8hq14
uiV1HFzTfy2zi4kch9Qx69qxbJ3eS39h+OhVAXtd3FIIiUVUYTsuCdV4p1RFOEqMGTZmMqY9eb21
kj8RVIzUtqRPYJn4fhdRnNQHy8v72LBY/bXZKbd4lBQVibI1aJQtuB16IaoJrbis2msDY0xPe9tj
zdi17Vj6
--0000000000003284370617e24fa8--

