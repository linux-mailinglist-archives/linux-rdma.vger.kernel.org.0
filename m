Return-Path: <linux-rdma+bounces-7084-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CA7A16135
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 11:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B5F3A4FC4
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9163413C80E;
	Sun, 19 Jan 2025 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rj2Y6OQZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0616AA7
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737282731; cv=none; b=UUbIdzYAjNA/rzm3Z7vYNRN1SBh/kCCVGVbQVuE3JkXyS4gC5Kn+BjsLgVbdMqauFewshYuYA4wtBBCJqDu1QMupKq7Joq/B1I88UxdLMzmY1Bl5Cqn2dO9iv16AHXHsZKlWHZE/t0ir0yqfFjy1QLRAg+jFrxLyOoCaGeaGTUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737282731; c=relaxed/simple;
	bh=jGFwtvmoL3p4ocTfv2Cvf1t6hgX7dCkuCh6afCFA2Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxJNmf7NLm4xyhgcftDtSaHjn189NY15PkiLApgFC6TYL9xe1C7YKqfemD4j3TDiRF2LB/poNspVmJD8YrGiNN+8hMmaKGEmiZfMLf7QmUYK+8WOGtop2vFJ6dO26lpyHXiEmVmw0RZHfDsVsLtfIea9SdadtO7U+/vKACIwNQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Rj2Y6OQZ; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-29f88004a92so2042332fac.1
        for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 02:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737282728; x=1737887528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PmupBSVTzy+G0SwYvU093pKyRewrb2urHbdRb4tDNsc=;
        b=Rj2Y6OQZdNo6U4ahRkV7qYHB1bLDqiCbvzcPgwqM40pyquP3M3F1bNXgtcXKuyMDj0
         7anx1MZK+oZrpih7o1ZWFCpoPAyI1FAa868t1Kt+LA2KtFgg8ONOd1e/55j7w0LIvSed
         6cl5qPGJkz5upruDETQcqEQurTENrEsUl7RFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737282728; x=1737887528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmupBSVTzy+G0SwYvU093pKyRewrb2urHbdRb4tDNsc=;
        b=jeri1OLcPEuF2YiT/lBDn8k2CSoidAjm2d9tndOAY4tAXArbdJFBtILJLpJ4o/1Yyx
         5LjFp4MyMZw/rDHFwBaxx9nG7rWwetikb457cBVb76qPdn5La1k0DMJbYsxn4y13KAvO
         MIaQS/ZvLWB1sKXOlqZ//L/qYg10eo5p83ehNQEf5se5lUcIJ4FCF19JqRm4MRb8tEAD
         cFmM1hRGCPD+CH2EOSoIXGP7lW1VQWJwySvGo5FGYfIV9+uHmO0KnFPdxbmjWSjDNFTQ
         SlrK6dHuGHCNmwHAl8ZjjGnH0U6RlAbXnNW6hKIOIvgPuq6zX5qBH8falnlb71gpsUB1
         S4sg==
X-Forwarded-Encrypted: i=1; AJvYcCVDsRViObvPmESGqvAYRorfcbrqYq1mlt4OM3gDH13+WQhU5Y9S3TwUY44Z4ITpxhhXngcQmgn+rj8i@vger.kernel.org
X-Gm-Message-State: AOJu0YzEgQ65a36O3I8fAfETQoP2tcjtfwhVBEN1M0/pVVZetwg6QIHI
	lCmI362NBwCnaajbOu3jA29GNd/+ljNqPuoazZXSbnmHM3tLxiWE/dTqKTEnHZ3+X4EfoA6xiS6
	F9zNrJBpgcjVHfK5nh4H5+zxh8PwqZFSzbBZsn6pSYVLIvT3y6g==
X-Gm-Gg: ASbGncuuGQue2utUssbneYQErftBTQb4Eeo4j0jzz6o+bQjBD77q3UdfmS+eY8jqNyQ
	GDYddlBhM3dRvaUfFOSr9cY+c0bXGK5ipCV8A6hyNN396Cm3XWg==
X-Google-Smtp-Source: AGHT+IGVdk1IfTF49gZX+3cf0SiOqM+ttHE2LYO8Oh9FoGNLc2ZUYMz9U4ED4Gs81R3SN8KXhtNruksrvd4UXjnrgEI=
X-Received: by 2002:a05:6870:92ca:b0:29e:2bbd:51cb with SMTP id
 586e51a60fabf-2b1c0afc5e0mr5042966fac.24.1737282728402; Sun, 19 Jan 2025
 02:32:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1737174544-2059-1-git-send-email-selvin.xavier@broadcom.com> <20250119095750.GC21007@unreal>
In-Reply-To: <20250119095750.GC21007@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Sun, 19 Jan 2025 16:01:55 +0530
X-Gm-Features: AbW1kvYeIwMO2TLCA595wEehHXCJvgfrZtI3QwWdaDmyeu2aO1S6MLKEXWX0OeY
Message-ID: <CA+sbYW3fsjMxqMPyq7HGLMuhb2TEkG8Jo3PmgOyMR7ba5TF3DQ@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Congestion control settings using
 debugfs hook
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ec201f062c0ca74c"

--000000000000ec201f062c0ca74c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2025 at 3:27=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Fri, Jan 17, 2025 at 08:29:04PM -0800, Selvin Xavier wrote:
> > Implements routines to set and get different settings  of
> > the congestion control. This will enable the users to modify
> > the settings according to their network.
> >
> > Currently supporting only GEN 0 version of the parameters.
> > Reading these files queries the firmware and report the values
> > currently programmed. Writing to the files sends commands that
> > update the congestion control settings.
> >
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h |   2 +
> >  drivers/infiniband/hw/bnxt_re/debugfs.c | 215 ++++++++++++++++++++++++=
+++++++-
> >  drivers/infiniband/hw/bnxt_re/debugfs.h |  15 +++
> >  3 files changed, 231 insertions(+), 1 deletion(-)
>
> <...>
>
> > +static const char * const bnxt_re_cc_gen0_name[] =3D {
> > +     "enable_cc",
> > +     "g",
>
> ????
It is the "running avg. weight" used by Congestion control algo in HW.
It is referred as "g" in the parameters and the FW command. So used
the same name for the debugfs file.
>
> > +     "num_phase_per_state",
> > +     "init_cr",
> > +     "init_tr",
> > +     "tos_ecn",
> > +     "tos_dscp",
> > +     "alt_vlan_pcp",
> > +     "alt_vlan_dscp",
> > +     "rtt",
> > +     "cc_mode",
> > +     "tcp_cp",
> > +     "tx_queue",
> > +     "inactivity_cp",
> > +};
>
> <...>
>
> > +static int map_cc_config_offset_gen0_ext0(u32 offset, struct bnxt_qpli=
b_cc_param *ccparam, u32 *val)
> > +{
> > +     u64 map_offset;
> > +
> > +     map_offset =3D BIT(offset);
> > +
> > +     switch (map_offset) {
> > +     case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ENABLE_CC:
> > +             *val =3D ccparam->enable;
> > +             break;
> > +     case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_G:
> > +             *val =3D ccparam->g;
> > +             break;
> > +     case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_NUMPHASEPERSTATE:
> > +             *val =3D ccparam->nph_per_state;
> > +             break;
> > +     case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INIT_CR:
> > +             *val =3D ccparam->init_cr;
> > +             break;
> > +     case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INIT_TR:
> > +            *val =3D ccparam->init_tr;
> > +             break;
> > +     case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_ECN:
> > +            *val =3D ccparam->tos_ecn;
> > +             break;
> > +     case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_DSCP:
> > +            *val =3D  ccparam->tos_dscp;
> > +     break;
>
> Wrong indentations, above and below.
My bad. Will fix it.
>
> > +     case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ALT_VLAN_PCP:
> > +             *val =3D ccparam->alt_vlan_pcp;
> > +             break;
> > +     case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ALT_TOS_DSCP:
> > +             *val =3D ccparam->alt_tos_dscp;
> > +             break;
> > +     case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_RTT:
> > +            *val =3D ccparam->rtt;
> > +             break;
> > +     case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_CC_MODE:
> > +           *val =3D ccparam->cc_mode;
> > +             break;
> > +     case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TCP_CP:
> > +          *val =3D  ccparam->tcp_cp;
> > +             break;
> > +     default:
> > +          return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static ssize_t bnxt_re_cc_config_get(struct file *filp, char __user *b=
uffer,
> > +                                  size_t usr_buf_len, loff_t *ppos)
> > +{
> > +     struct bnxt_re_cc_param *dbg_cc_param =3D filp->private_data;
> > +     struct bnxt_re_dev *rdev =3D dbg_cc_param->rdev;
> > +     struct bnxt_qplib_cc_param ccparam =3D {};
> > +     u32 offset =3D dbg_cc_param->offset;
> > +     char buf[16];
> > +     u32 val;
> > +     int rc;
> > +
> > +     rc =3D bnxt_qplib_query_cc_param(&rdev->qplib_res, &ccparam);
> > +     if (rc) {
> > +             dev_err(rdev_to_dev(rdev),
> > +                     "%s: Failed to query CC parameters\n", __func__);
>
> Let's not have debug print, and especially dev_err here.
Sure. Will correct it.
>
> > +             return -EINVAL;
>
> bnxt_qplib_query_cc_param() can return ENOMEM, there is no need to
> overwrite return value.
Ok
>
> > +     }
> > +
> > +     rc =3D map_cc_config_offset_gen0_ext0(offset, &ccparam, &val);
> > +     if (rc)
> > +             return rc;
> > +
> > +     rc =3D snprintf(buf, sizeof(buf), "%d\n", val);
> > +     if (rc < 0)
> > +             return rc;
> > +
> > +     return simple_read_from_buffer(buffer, usr_buf_len, ppos, (u8 *)(=
buf), rc);
> > +}
> > +

--000000000000ec201f062c0ca74c
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHSAJ5lWQCA4
b7Zj4v1lyrlaad5WNkc9Dy+U8zRVLsyJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI1MDExOTEwMzIwOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCQnrMAxc6Ox2ASi6D4hr5lMNnCOIH9
LCOTKRsl5ktFBoicgIdTlRbkpqJEW58H+jfa+bWLoWuesGoch2Gle7SSK1W1KzC4GSTncU8x1IjI
EScEMvSwgQYCcW+z9sOV9bUaqKwqRa66jnvfUzQZkxQGPia16EHh1nTb40SL1rujd2BrKNA50MI0
/ixW2SGn0xBwQ+nbM3v8Q29x1qa/yYRTi43/MhmV0wlmIuFLnwG9ytcJ1gsmkWWQf74RgSbJ+Y1q
eE4wZ97rr3h9S+lkiBeorkbhJPKiZ0+BynqSBfWMrJ+IorL6VfXuHIkoTCZfXdUkrG60VmEMcayj
qeaIgZds
--000000000000ec201f062c0ca74c--

