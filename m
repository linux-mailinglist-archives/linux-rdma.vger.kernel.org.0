Return-Path: <linux-rdma+bounces-6270-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA049E5168
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 10:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED5B16392E
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 09:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF9D191F6F;
	Thu,  5 Dec 2024 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NNbMctNl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D709B2391A4
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391101; cv=none; b=j+syZ/qpyDR9ES5Q07Oibq/PM1M1IAiFKDU7FbUC+ztFGTIxp4hyvMJEa+u5CqvuergUqJ8UTFWWEv8Sxn69GkfUSHoAQhbBsDNIhteaC25kwPk+d6kVCDb7KcGGGWz3R89iYT5PxZg8FRAL4bnmApv6HTfsDen1ITuzdQx2Lls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391101; c=relaxed/simple;
	bh=9Muw752PtIBvtT4r9QeI66zMpV82YZZx1xcb0xgyzUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdaS7AWbs4f8zvaNbCKepGIJ6UNFz53LhpjWwbT0l12W9I/ttyDd3BnQsnhl4nx5REEp5DY1wD96FU7nVGVDtYt+WPrCqs7VVJzZZ9G4sdz9d5t3f76Ece2ojsxj7+id62l2nR/ELDJ3hf5c6HBSZoZFYm8xcxxpsLF6qlnUQy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NNbMctNl; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53de771c5ebso705621e87.2
        for <linux-rdma@vger.kernel.org>; Thu, 05 Dec 2024 01:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733391098; x=1733995898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=esirPIEo/mdjEEOlM7s+jYfMT/Q80jS5dARM0gBevFE=;
        b=NNbMctNl89oSmTqt54DNcq7pPcbjBC9W00kdn8NTBXRc+xeiB9uS7A74qWTgfTb3e5
         2TLuCxfqjh/0ixdeogtKP42mMMS1ZIYfl5by6wIREZgVey7XMJyd5nJIVXI/8AdZymbq
         xPKOl0xouG/pV8kkewu0ox4AjGiy5uf2zRnOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733391098; x=1733995898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esirPIEo/mdjEEOlM7s+jYfMT/Q80jS5dARM0gBevFE=;
        b=c8Wr7qxer9h38DL9d8h9Xdqv8gNEb19CF71KUA3pGx/NzUVtP2imJ7cIQahbGEOOcQ
         oQYIDzgCAZ42cYU5m6yVkkPYba0tGsQ4icQ5EK7X3AkIokkOLqndwn6y9Rka3DvODNvE
         5Byc9InXHeC2Mwxy5JXdUviJyNJloIPljOWPDIw6FsMbG9NK34nZ5I/4R2aVnXTWVKfX
         /XQqbWdxw03W7CaLDc6F7Y4rlo7SJktFEowa9wjX8LgS5n8PI+L3nf7eify8JBueVN5H
         K9tPSFvR/yfPQAZW+wan7uV17UMoPq9AitZo5q4sVu2EwRzRHp0/XGBP59CWbmOi4yCi
         Q9qg==
X-Forwarded-Encrypted: i=1; AJvYcCXMqsEE4sKTv47RpMtKtMgNbX836rSOTwx80szKtuUEOoLHPd1TnRmFdAnzqMpCaKTnY6UKGjdGb5Aq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3h4b5pe1wxfGgPbP+CXDlljFJDgJTN0Hu95/T55EptJ+qsGv9
	dAic/qmac6gHkyHLJVhMdrVOpJ9AxwB45jOX1/+HtJahDElliGKng/QbDtNJTymIbXPlLnAjL9E
	feMjFAtLqW3wpcLTR7a14E/j9so0KcDWGaLbk
X-Gm-Gg: ASbGncud1ms7aynLvDH0sgG6R30duyY9iNF/PEFAuokbnrgP4DDixP7oaGMJQUA2pY2
	RvGJR6Ds9bTK3Qh4+scKJGAr+tF9q2HHm
X-Google-Smtp-Source: AGHT+IHgs+b4NO65+74QWUa5IcPs4UwTe9BAFH8xvPKuef7v/c84ws/g/YjMOUthp63Ce47tW70pIuA3GLWly0U1nkY=
X-Received: by 2002:a05:6512:3c8d:b0:53e:2760:de0a with SMTP id
 2adb3069b0e04-53e2760dfa5mr148114e87.26.1733391097858; Thu, 05 Dec 2024
 01:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
 <20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com> <20241205090716.GU1245331@unreal>
In-Reply-To: <20241205090716.GU1245331@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Thu, 5 Dec 2024 15:01:25 +0530
Message-ID: <CAH-L+nN0C=0ZoJmAgBTbjCUcwoQO00WoUc3d3BKn_tGPdk5UbA@mail.gmail.com>
Subject: Re: [PATCH for-rc 4/5] RDMA/bnxt_re: Fix error recovery sequence
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, Kashyap Desai <kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ab8e5f06288290ca"

--000000000000ab8e5f06288290ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 2:37=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Wed, Dec 04, 2024 at 01:24:15PM +0530, Kalesh AP wrote:
> > Fixed to return ENXIO from __send_message_basic_sanity()
> > to indicate that device is in error state. In the case of
> > ERR_DEVICE_DETACHED state, the driver should not post the
> > commands to the firmware as it will time out eventually.
> >
> > Removed bnxt_re_modify_qp() call from bnxt_re_dev_stop()
> > as it is a no-op.
> >
> > Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW error is=
 detected")
> >
>
> Please don't add blank line here.
Sure, my bad. I missed it. Thanks for pointing it out.
>
> > Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/main.c       | 8 +-------
> >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 7 ++++---
> >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 3 +++
> >  3 files changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/=
hw/bnxt_re/main.c
> > index b7af0d5ff3b6..c143f273b759 100644
> > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -1715,11 +1715,8 @@ static bool bnxt_re_is_qp1_or_shadow_qp(struct b=
nxt_re_dev *rdev,
> >
> >  static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
> >  {
> > -     int mask =3D IB_QP_STATE;
> > -     struct ib_qp_attr qp_attr;
> >       struct bnxt_re_qp *qp;
> >
> > -     qp_attr.qp_state =3D IB_QPS_ERR;
> >       mutex_lock(&rdev->qp_lock);
> >       list_for_each_entry(qp, &rdev->qp_list, list) {
> >               /* Modify the state of all QPs except QP1/Shadow QP */
> > @@ -1727,12 +1724,9 @@ static void bnxt_re_dev_stop(struct bnxt_re_dev =
*rdev)
> >                       if (qp->qplib_qp.state !=3D
> >                           CMDQ_MODIFY_QP_NEW_STATE_RESET &&
> >                           qp->qplib_qp.state !=3D
> > -                         CMDQ_MODIFY_QP_NEW_STATE_ERR) {
> > +                         CMDQ_MODIFY_QP_NEW_STATE_ERR)
> >                               bnxt_re_dispatch_event(&rdev->ibdev, &qp-=
>ib_qp,
> >                                                      1, IB_EVENT_QP_FAT=
AL);
> > -                             bnxt_re_modify_qp(&qp->ib_qp, &qp_attr, m=
ask,
> > -                                               NULL);
> > -                     }
> >               }
> >       }
> >       mutex_unlock(&rdev->qp_lock);
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infin=
iband/hw/bnxt_re/qplib_rcfw.c
> > index 5e90ea232de8..c8e65169f58a 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > @@ -423,8 +423,9 @@ static int __send_message_basic_sanity(struct bnxt_=
qplib_rcfw *rcfw,
> >       cmdq =3D &rcfw->cmdq;
> >
> >       /* Prevent posting if f/w is not in a state to process */
> > -     if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
> > -             return bnxt_qplib_map_rc(opcode);
> > +     if (RCFW_NO_FW_ACCESS(rcfw))
> > +             return -ENXIO;
> > +
> >       if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
> >               return -ETIMEDOUT;
> >
> > @@ -493,7 +494,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bn=
xt_qplib_rcfw *rcfw,
> >
> >       rc =3D __send_message_basic_sanity(rcfw, msg, opcode);
> >       if (rc)
> > -             return rc;
> > +             return rc =3D=3D -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;
> >
> >       rc =3D __send_message(rcfw, msg, opcode);
> >       if (rc)
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infin=
iband/hw/bnxt_re/qplib_rcfw.h
> > index 88814cb3aa74..4f7d800e35c3 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > @@ -129,6 +129,9 @@ static inline u32 bnxt_qplib_set_cmd_slots(struct c=
mdq_base *req)
> >
> >  #define RCFW_MAX_COOKIE_VALUE                (BNXT_QPLIB_CMDQE_MAX_CNT=
 - 1)
> >  #define RCFW_CMD_IS_BLOCKING         0x8000
> > +#define RCFW_NO_FW_ACCESS(rcfw)                                       =
       \
> > +     (test_bit(ERR_DEVICE_DETACHED, &(rcfw)->cmdq.flags) ||          \
> > +      pci_channel_offline((rcfw)->pdev))
>
> There is some disconnection between description and implementation.
> ERR_DEVICE_DETACHED is set when device is suspended, at this stage all
> FW commands should stop already and if they are not, bnxt_re has bugs
> in cleanup path. It should flush/cancel/e.t.c and not randomly test some
> bit.
Yes, the device is in reset state. All outstanding firmware commands
are suspended. We do not want to post any new commands to firmware in
the recovery teardown path. Any commands sent to firmware at this
point will time out.
To avoid that, before posting the command driver checks the state and
returns early.
>
> In addition, pci_channel_offline() in driver which doesn't manage PCI
> device looks strange to me. It should be part of bnxt core and not
> related to IB.
The bnxt_re driver also has a firmware communication channel where it
writes to BAR to issue firmware commands. When the PCI channel is
offline, any commands issued from the driver will time out eventually.
To prevent that we added this extra check to detect that condition early.

>
> Thanks
>
> >
> >  #define HWRM_VERSION_DEV_ATTR_MAX_DPI  0x1000A0000000DULL
> >  /* HWRM version 1.10.3.18 */
> > --
> > 2.31.1
> >



--=20
Regards,
Kalesh A P

--000000000000ab8e5f06288290ca
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIKun1rfW6ioMfAS+nxyRNg1fUk8z3wHiudEfyT7arI1aMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTIwNTA5MzEzOFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCir8qBTMwV
CA3an7vBQbsc2MS8vCyAUbUJ5sgw5zTqN3+P4stc7itxH2SzmGAJyU7rXQvLwVm+RaWhFCGx3pjw
sbra0x/pNeXcRCcHiTdhW/dAqyCbWqLFAy+fXzemWfqMPidREiFzYzJ44ukpQAif41XWOSWqEI+c
Oo6Y+cOLZqEfoQnY/62u3DAFraxX8RiWEiVxS39ycunAGv8k0cgMp3Z0PHLp6y4wbtCMVLEJTmcu
rK7OQHiS3+7JQu5QVb6WT8F8lmDInwE+1Wel+jKn5x7bsx8us5q97HtlwQO5V92N35BL5iN0gQkZ
t4NuBFoO5SP+df57QpJ0jivqo55l
--000000000000ab8e5f06288290ca--

