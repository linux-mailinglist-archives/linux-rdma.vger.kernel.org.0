Return-Path: <linux-rdma+bounces-5577-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2C89B370E
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 17:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8F2B22A33
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837CF1DED57;
	Mon, 28 Oct 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CQCNnsa4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B871DE896
	for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134217; cv=none; b=EJsu/tUtnNjLvmexOMF1wkFbmM5oxmSIYDWE/12ipqVE2mAp3N+3o9gRzOdDak0FvEHK6qkz/tBJSPrV80GSi2yXYUM60alQBm6LC3xNTApJKqxoJIogv3/YxFisi2E31YbbbFu/SZGHKUvCxdDH3dBN2IhddpG9a8TM9kJcreM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134217; c=relaxed/simple;
	bh=9r02JSzNqxymWlx//VD0f1K8dOGtEkZw4e7w2TKJPpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a04RRStHMizgp7+kbb5uLdz8TBbAflhoojiQ9JVTjU1X6ZeNRavr9P0XLAYkqDSi7nlG1HtHvdnjnyFcjG873uaTShaLHSRCoPl0MT7amFr9y7yHuehigN9PRcNmZFM4uKrgdeZlbkw2Lh7Wuh9KgMNfatu1HvRmK+SpOA7Cnrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CQCNnsa4; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e2e3179b224so4468164276.1
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730134214; x=1730739014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EyoLsYFSg3KFcBGm4SfWr2NTwbrxDSqXhdnxnG43kTk=;
        b=CQCNnsa4k6Vpd76lbzQDQsy+4EMua/exiW5h+iDooqEyQFzhJ4vzK+6UkcWQ2KzNF7
         26oU6GZg6qn00veBE4X2b2CR2G/EkTkP+l2UsoJtZptORIwVOvCj/z2vocCrDtD34BNz
         BAotkiqH0gC8d7GYn8zuyz8rUUZswDoRrrskQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730134214; x=1730739014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyoLsYFSg3KFcBGm4SfWr2NTwbrxDSqXhdnxnG43kTk=;
        b=fKjsA9dEZadE/4lIxdVguwpcjD0hnluXWvafwAQ0BCANXOihbhed4PYxbHd504o2lu
         v5ppQTLyWz+69iCKEziRHIK0Pk5uLyHA37SvxasnTPmvXs3FdXibKyc+RAkHMf54TsvQ
         TagsPAueFHVOMFnv9WbXO2MoELlpytcwxc0gDaCVXuw8z2GrH6PWHGBtvaRegEPJeV0P
         F0tVGn+8DWBb/Fn78XJdTsa3602ijPA3e+LXF7AJENWlPN8DQHf9dh0gMGEEU7ELIP38
         5hYXOxbLdkEfoErYZfYkI7swsl8iTMcbpzVT9Cd2nNafEVhlf/BK3/xlKDsv4RKbuOOX
         EVJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRH0RL0HVOlWJhaIGGlKDVnkYHK12kDvdl3MGeMJqrgk91f6f+LYzWWdExbW4Wl2OibzB53VYdOwbD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk7LIwTP5Bqf3/lGNBLHahpI9Wc4hLfpuwUA5f0Vq7aOmK9d/d
	s66MBkD24ymKgPjsIpkywn+lEZGrjBPgt8rqkdV5adwKeU4LoqPrdCcJfsJcT4wErvHmBkyCRSd
	+ysfK2wHkYMRIJyA4gd1ITdT5OkKerbh/0nDA
X-Google-Smtp-Source: AGHT+IFNyRWKf5/eJjk1ggFjBLftoMJybec/6pkN7/XMgbYuxztRlXL+eaCPvFiYBWx6tXGDMnWg+broT1Fh/FspC1g=
X-Received: by 2002:a05:690c:2a8f:b0:6e5:9bc2:53a0 with SMTP id
 00721157ae682-6e9d8b5d869mr62846667b3.41.1730134212446; Mon, 28 Oct 2024
 09:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1728928561-25607-1-git-send-email-selvin.xavier@broadcom.com>
 <1728928561-25607-2-git-send-email-selvin.xavier@broadcom.com> <20241028115908.GF1615717@unreal>
In-Reply-To: <20241028115908.GF1615717@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Mon, 28 Oct 2024 22:20:00 +0530
Message-ID: <CA+sbYW0VJEYguxy8aqTk9BiZ0NM1B8GJqC_sF6B+b99FeLaFXg@mail.gmail.com>
Subject: Re: [PATCH for-next v2 1/4] RDMA/bnxt_re: Add support for optimized
 modify QP
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000042c3fa06258c43ad"

--00000000000042c3fa06258c43ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 5:29=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Oct 14, 2024 at 10:55:58AM -0700, Selvin Xavier wrote:
> > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> >
> > Modify QP improvements are for state transitions
> > from INIT -> RTR and RTR -> RTS.
> > In order to support the Modify QP Optimization feature,
> > the driver is expected to check for the feature support
> > in the CMDQ_QUERY_FUNC and register its support for this
> > feature with the FW in CMDQ_INITIALIZE_FIRMWARE.
> >
> > Additionally, the driver is required to specify the new
> > fields and attribute masks for the transitions as follows:
> > 1. INIT -> RTR:
> >    - New fields: srq_used, type.
> >    - enable srq_used when RC QP is configured to use SRQ.
> >    - set the type based on the QP type.
> >    - Mandatory masks:
> >      - RC: CMDQ_MODIFY_QP_MODIFY_MASK_ACCESS,
> >            CMDQ_MODIFY_QP_MODIFY_MASK_PKEY
> >      - UD QP and QP1: CMDQ_MODIFY_QP_MODIFY_MASK_PKEY,
> >                       CMDQ_MODIFY_QP_MODIFY_MASK_QKEY
> > 2. RTR -> RTS:
> >    - New fields: type
> >    - set the type based on the QP type.
> >    - Mandatory masks:
> >      - RC: CMDQ_MODIFY_QP_MODIFY_MASK_ACCESS
> >      - UD QP and QP1: CMDQ_MODIFY_QP_MODIFY_MASK_QKEY
> >
> > Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> > Reviewed-by: Tushar Rane <tushar.rane@broadcom.com>
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 40 ++++++++++++++++++++++=
++++++++
> >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  6 ++++-
> >  drivers/infiniband/hw/bnxt_re/qplib_res.h  |  5 ++++
> >  drivers/infiniband/hw/bnxt_re/roce_hsi.h   |  3 +++
> >  4 files changed, 53 insertions(+), 1 deletion(-)
>
> <...>
>
> > diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infinib=
and/hw/bnxt_re/roce_hsi.h
> > index 3ec8952..69d50d7 100644
> > --- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> > +++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> > @@ -216,6 +216,8 @@ struct cmdq_initialize_fw {
> >       __le16  flags;
> >       #define CMDQ_INITIALIZE_FW_FLAGS_MRAV_RESERVATION_SPLIT          =
0x1UL
> >       #define CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED     =
0x2UL
> > +     #define CMDQ_INITIALIZE_FW_FLAGS_DRV_VERSION                     =
0x4UL
>
> Where is this define used?
We are not using this field now. This is structure fields are copied
from an autogenerated file. Since we updated this structure, we have
copied all update to that structure. The value we
are currently interested in is 0x8UL.

Do you want me to repost the series after removing the above define?
>
> > +     #define CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED    =
0x8UL
>
> Thanks

--00000000000042c3fa06258c43ad
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICuHnt8nElIQ
LnhykTZNPavWjXn+VIo8jydPVBdS+7iAMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MTAyODE2NTAxNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBRLqUafMXd63uUh5iUmNrVo/Fb4FyT
lxFTi6yVNK1EdDiBrakyeEEXNcjlR0fDCd6HEUkshSIqAFc7IlxWEc4LZdFcQzgKYJJo66oyc5R9
uEfT6G4QOOB4UeJq5Dl2TXSCgB8fee4j7ordGp4hWHURLemvet47WkdyXSpaxI8QmQukiC2oirFG
AEK0Wdf5z6UPNInCYGwbVxcbMDqlinzdEFbrA4N8kQsF4rza1P0OOGiOEYOsqbje9aG9RmWMxid/
V9nsZ7bEK3hIw5+pSn91OffyItiU0gI1lKs+udK7NIEnZKXeff38DYmGTVTjcop26VHZVFWIlLcn
VPgbBaFL
--00000000000042c3fa06258c43ad--

