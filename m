Return-Path: <linux-rdma+bounces-6325-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A12D9E8A76
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 05:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5AD1885251
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 04:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E6D192598;
	Mon,  9 Dec 2024 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BB44/IRr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246FD189B9F
	for <linux-rdma@vger.kernel.org>; Mon,  9 Dec 2024 04:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733719420; cv=none; b=gYn/F8Z0Mmsic9FikTse6qIWZzja25s/hxg1fk5SFhKfAygGuzzx+L08XDOZnsI7eFR8RJ7IGKRIQPkcHjX5BS69jxBLDn+pHPNIteXYKfN1+21fb9rVIbLumJLdcAolveXRSu/DXRjMUU/6GDsVERLiG6b2rsG0TZ1BpcN7EsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733719420; c=relaxed/simple;
	bh=J5uF+YK8Kub0I6bs8LyXxQcKpD6JxBE4SniUQltDiLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fw4LxHdgXJkM+jp2Er2e4ptBPyfPtu0ptKJxmYKUqUrIESCi77zk3QJj7AhpAyW91U/qSzrmb566apnwd1esY3N4gFAYzKyMiOroglcpXPq+J5McN1T1uTlsxDh8MoPSLclXhueUgwXb4IYghYyL/Ysv8d6ZFgsWC7DrD5DGuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BB44/IRr; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6eff4f0d9fcso15827877b3.3
        for <linux-rdma@vger.kernel.org>; Sun, 08 Dec 2024 20:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733719417; x=1734324217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vBsbku2s9AXzQnI8VnDx1q3r+shMnijf3ftKtmycaj8=;
        b=BB44/IRrgWH9mh7E0D7XEAQtZS7lwGL7Y5BF86paA7rlZMbAsD5hGeqwDiNKqhwPjQ
         P05gzzWSO3gJin6uwWjB3zirfknpl7JnpoejDO+VCsiWezpIOrqwAjyk1+i6N22pWXlK
         v4VTtczsQ9Qy90JA2d7u+h+m2y2lsLRYYI8Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733719417; x=1734324217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBsbku2s9AXzQnI8VnDx1q3r+shMnijf3ftKtmycaj8=;
        b=SMz/bIGcoeUVWfvXNBKEj1wS+Tc/AUhRI+JXJuHUrj2X/y4npSyhdhZPBG+KPZ69Rs
         wlmb3vUEXNhF1Em4ZsPchxTZ1f1fyQuRkc+gFJOfoJVl5lzKwE9U6eh7YMIMB/n5vqc+
         EC4DvSCAqnQJkzkyv4sdhe5MTIqS7/eXTiHoDnhkw8pb1icRGjp+1rC1lVz/yfVqsdZo
         nz2MEHpVtpyUDGggZZ9x2o9aHsvmzc7w7Wj92FMmiigj4jj5Oy5D2EOqwYclcmqUw5CD
         J9AMT2zmAV3WMkeOByMTOyfvmFDOwmqfGrNwToZY8iAmzIbLNHITEQbb0C311MifvzGU
         kDBw==
X-Forwarded-Encrypted: i=1; AJvYcCW3plNhfrJFcNFyp/hzn5jHaXSWqNmXbzS4cfaeKgSs8HbCCwGHGiZaV1/9wtMl7DD/5W2f3goXcbGb@vger.kernel.org
X-Gm-Message-State: AOJu0YyuDvEVSLVfyDwaskD+9Hg12+/aeFA6OMGSEuNVlbDsiJnKIX20
	QukIhgoWBxTIRemxPPFULaa4AiiY+Jcswoy3jsEutIbYT777T6ly1F5qtNSrfD7eJvE1bZ9Te8A
	gT3XIgRjl69M0ZvPlgvP7NgAilha9JY6at+FQ
X-Gm-Gg: ASbGncshBkZ4CvLRsAa/5gOHOm9EZh51eByOY7IewAcLZnDmF/ukCd/2PmawfLmMF2I
	uB2UeQkrUzwX/+HUsx+42npeD1FdWmZnE
X-Google-Smtp-Source: AGHT+IEsMtv7QWo+tpKDBhoM18yntnUJr2Um4BU7sDBw1QyfNxO3G4w3OlnAyttIUketanyF9b8zZ80R+BEuF7tBK+I=
X-Received: by 2002:a05:690c:48c7:b0:6ef:5688:f95e with SMTP id
 00721157ae682-6efe3c91019mr104381667b3.42.1733719416920; Sun, 08 Dec 2024
 20:43:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
 <20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com>
 <20241205090716.GU1245331@unreal> <CAH-L+nN0C=0ZoJmAgBTbjCUcwoQO00WoUc3d3BKn_tGPdk5UbA@mail.gmail.com>
 <20241205113841.GY1245331@unreal>
In-Reply-To: <20241205113841.GY1245331@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Mon, 9 Dec 2024 10:13:23 +0530
Message-ID: <CA+sbYW21nc0JPs-N0rmR-DgUvX0pydCY_bZXUC57aA0rXUst1A@mail.gmail.com>
Subject: Re: [PATCH for-rc 4/5] RDMA/bnxt_re: Fix error recovery sequence
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>, jgg@ziepe.ca, 
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	Kashyap Desai <kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000002b3600628cf02c4"

--00000000000002b3600628cf02c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 5:08=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Thu, Dec 05, 2024 at 03:01:25PM +0530, Kalesh Anakkur Purayil wrote:
> > On Thu, Dec 5, 2024 at 2:37=E2=80=AFPM Leon Romanovsky <leon@kernel.org=
> wrote:
> > >
> > > On Wed, Dec 04, 2024 at 01:24:15PM +0530, Kalesh AP wrote:
> > > > Fixed to return ENXIO from __send_message_basic_sanity()
> > > > to indicate that device is in error state. In the case of
> > > > ERR_DEVICE_DETACHED state, the driver should not post the
> > > > commands to the firmware as it will time out eventually.
> > > >
> > > > Removed bnxt_re_modify_qp() call from bnxt_re_dev_stop()
> > > > as it is a no-op.
> > > >
> > > > Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW erro=
r is detected")
> > > >
> > >
> > > Please don't add blank line here.
> > Sure, my bad. I missed it. Thanks for pointing it out.
> > >
> > > > Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
> > > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > ---
> > > >  drivers/infiniband/hw/bnxt_re/main.c       | 8 +-------
> > > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 7 ++++---
> > > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 3 +++
> > > >  3 files changed, 8 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infinib=
and/hw/bnxt_re/main.c
> > > > index b7af0d5ff3b6..c143f273b759 100644
> > > > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > > @@ -1715,11 +1715,8 @@ static bool bnxt_re_is_qp1_or_shadow_qp(stru=
ct bnxt_re_dev *rdev,
> > > >
> > > >  static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
> > > >  {
> > > > -     int mask =3D IB_QP_STATE;
> > > > -     struct ib_qp_attr qp_attr;
> > > >       struct bnxt_re_qp *qp;
> > > >
> > > > -     qp_attr.qp_state =3D IB_QPS_ERR;
> > > >       mutex_lock(&rdev->qp_lock);
> > > >       list_for_each_entry(qp, &rdev->qp_list, list) {
> > > >               /* Modify the state of all QPs except QP1/Shadow QP *=
/
> > > > @@ -1727,12 +1724,9 @@ static void bnxt_re_dev_stop(struct bnxt_re_=
dev *rdev)
> > > >                       if (qp->qplib_qp.state !=3D
> > > >                           CMDQ_MODIFY_QP_NEW_STATE_RESET &&
> > > >                           qp->qplib_qp.state !=3D
> > > > -                         CMDQ_MODIFY_QP_NEW_STATE_ERR) {
> > > > +                         CMDQ_MODIFY_QP_NEW_STATE_ERR)
> > > >                               bnxt_re_dispatch_event(&rdev->ibdev, =
&qp->ib_qp,
> > > >                                                      1, IB_EVENT_QP=
_FATAL);
> > > > -                             bnxt_re_modify_qp(&qp->ib_qp, &qp_att=
r, mask,
> > > > -                                               NULL);
> > > > -                     }
> > > >               }
> > > >       }
> > > >       mutex_unlock(&rdev->qp_lock);
> > > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/i=
nfiniband/hw/bnxt_re/qplib_rcfw.c
> > > > index 5e90ea232de8..c8e65169f58a 100644
> > > > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > > @@ -423,8 +423,9 @@ static int __send_message_basic_sanity(struct b=
nxt_qplib_rcfw *rcfw,
> > > >       cmdq =3D &rcfw->cmdq;
> > > >
> > > >       /* Prevent posting if f/w is not in a state to process */
> > > > -     if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
> > > > -             return bnxt_qplib_map_rc(opcode);
> > > > +     if (RCFW_NO_FW_ACCESS(rcfw))
> > > > +             return -ENXIO;
> > > > +
> > > >       if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
> > > >               return -ETIMEDOUT;
> > > >
> > > > @@ -493,7 +494,7 @@ static int __bnxt_qplib_rcfw_send_message(struc=
t bnxt_qplib_rcfw *rcfw,
> > > >
> > > >       rc =3D __send_message_basic_sanity(rcfw, msg, opcode);
> > > >       if (rc)
> > > > -             return rc;
> > > > +             return rc =3D=3D -ENXIO ? bnxt_qplib_map_rc(opcode) :=
 rc;
> > > >
> > > >       rc =3D __send_message(rcfw, msg, opcode);
> > > >       if (rc)
> > > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/i=
nfiniband/hw/bnxt_re/qplib_rcfw.h
> > > > index 88814cb3aa74..4f7d800e35c3 100644
> > > > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > > @@ -129,6 +129,9 @@ static inline u32 bnxt_qplib_set_cmd_slots(stru=
ct cmdq_base *req)
> > > >
> > > >  #define RCFW_MAX_COOKIE_VALUE                (BNXT_QPLIB_CMDQE_MAX=
_CNT - 1)
> > > >  #define RCFW_CMD_IS_BLOCKING         0x8000
> > > > +#define RCFW_NO_FW_ACCESS(rcfw)                                   =
           \
> > > > +     (test_bit(ERR_DEVICE_DETACHED, &(rcfw)->cmdq.flags) ||       =
   \
> > > > +      pci_channel_offline((rcfw)->pdev))
> > >
> > > There is some disconnection between description and implementation.
> > > ERR_DEVICE_DETACHED is set when device is suspended, at this stage al=
l
> > > FW commands should stop already and if they are not, bnxt_re has bugs
> > > in cleanup path. It should flush/cancel/e.t.c and not randomly test s=
ome
> > > bit.
> > Yes, the device is in reset state. All outstanding firmware commands
> > are suspended. We do not want to post any new commands to firmware in
> > the recovery teardown path. Any commands sent to firmware at this
> > point will time out.
> > To avoid that, before posting the command driver checks the state and
> > returns early.
>
> I understand that. Please reread my sentence "all FW commands should stop
> already and if they are not, bnxt_re has bugs in cleanup path.", and answ=
er
> is how is it possible to get FW commands during restore.
Hi Leon,

Not sure if I also got your point correctly. Once the error recovery
gets initiated, we
unregister the ib device in the suspend path. During the ib_unregister_devi=
ce,
we get verb commands to destroy the QP, CQs etc. We want to prevent sending=
 the
new commands to FW for all these operations. We also want to avoid sending
any resource creation commands from the stack while the device is
getting re-initialized
This is a common check that prevents more commands from the stack down
to Firmware.

>
> > >
> > > In addition, pci_channel_offline() in driver which doesn't manage PCI
> > > device looks strange to me. It should be part of bnxt core and not
> > > related to IB.
> > The bnxt_re driver also has a firmware communication channel where it
> > writes to BAR to issue firmware commands. When the PCI channel is
> > offline, any commands issued from the driver will time out eventually.
> > To prevent that we added this extra check to detect that condition earl=
y.
>
> This micro optimization where you check in some random place for pci chan=
nel
> status is not correct.
Will remove pci_channel_offline check and come up with some other
mechanism to handle this case.
>
> Thanks
>
> >
> > >
> > > Thanks
> > >
> > > >
> > > >  #define HWRM_VERSION_DEV_ATTR_MAX_DPI  0x1000A0000000DULL
> > > >  /* HWRM version 1.10.3.18 */
> > > > --
> > > > 2.31.1
> > > >
> >
> >
> >
> > --
> > Regards,
> > Kalesh A P
>
>

--00000000000002b3600628cf02c4
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFSPXOgExUOj
UtHFSCmNlXgqTgq1v+Rz/oQSKMgTB/frMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MTIwOTA0NDMzN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCYGzhQHTzEQWu+zr9/gijI1vcymMdO
fBqbPDfLuOWeMXboppwldpl5hM139F3yvCNlRMDn9O0yyoPF5fetCd3xNplnW44O11Wv+AmUVCXC
EJ3JwCYvoxBBwnVMN0gU5qr1w948dOf0uwVVD3u6ka0Zk9VKIZm9QNIecNsFMWGWT6cQPcBV2Z6e
kWI9ioxQbeJRWayvIwK30GqQpNGrPhiLLMN5dVQkV95f9h2o2cwXhekQ228JSveaNtak1qTTpjqj
U2wEOIthA8FdkqsjoRNI2Iw5l0SVGumw6MT1/eO/lfOiNamNMKFhuPnoXALuy3uHd4vLmRZZ6ukN
Cf8E2esI
--00000000000002b3600628cf02c4--

