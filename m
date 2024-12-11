Return-Path: <linux-rdma+bounces-6420-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0979D9EC48F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 07:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE8E284DB6
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 06:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7F25661;
	Wed, 11 Dec 2024 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hyOi3Mgr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E58635A
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 06:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733897034; cv=none; b=kqWdqHH/a5/3kfp3GEFr5t6JnOVXRnQ7t3+R3C5HzwflXNTbGpNk4MTdl7GYJzgMmbDNpppjVUK6vxN5CILZ3DKA7MWqf14KPIAYQmy1UiQ9g/JFcmtbPPPNCuHOcE90i0InboC9Y3iUeUqAQNNZ3v1w2JQu26d5zaVkcRLiKdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733897034; c=relaxed/simple;
	bh=dzt3BNaEo1FrlHmI1FH0Pqz/WuzSlbBaqVN0qJD6JRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ftf3wHyZdu+6CjR16o/SkT6lNjsKn3IRafqNPNxyN7jdAUSodsvqYFurfWzDNGHOert7c3SEj1psvZzfto2LCQFoPoknk7hDzsBd8HdNK3e0sWZmPuYcBUO5su4mLf3tmh0RC03Vkwdi39R99K3fWPCrnavuwyeZnnKqBlJeSlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hyOi3Mgr; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ef81222be7so59129567b3.3
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 22:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733897031; x=1734501831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X9tqW1nyJr9FbtQCT3hfToY3IJUZvi3/UlC/uUMQ9g0=;
        b=hyOi3MgrqoYoGBTw+JD0+Nz3Y/4Bqj5PrDBmelQyVZnJFhSno2usOyC7LXgJphU4Ec
         F3m48qr1R8kuB4wfXKoSpZahMF1C/dLMvt+PMfn6CdQqwK6gJ0TPrZ9dpZshRKmXq7+m
         /wPVk4fTzz/3RisJ3egZjmFxrFASX2NI6DUDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733897031; x=1734501831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9tqW1nyJr9FbtQCT3hfToY3IJUZvi3/UlC/uUMQ9g0=;
        b=emzpjznqqvrt3vk1Ro39aAF7snpG3ZJ9b/yd7wCz7M7eHSk0/hDRn8VvAJlZDvja9w
         5iDu7Dt5Mi1qgTiZrbU5IjMZxNMnKgNE6m5I0Lqr0jB9VxE+yI7sDnQTHwdZ+vfGYRv7
         YcuU+7F9VXOlU+KR5rFxzL6oHyQ9aoeIMlQ9zBZql5v3nNgv5wbmHrnjhuT3jtL8dCRN
         y5/id611rCBZb2791R6+WwSppSNaH5XqK5HwwphLCGTwiTfVYPobgy5Eo8iGHPOtWDsA
         ycl6D8CDKhBfV7KuJvlqGLCf/BG3a/uyo5zaKg/6MwEZ4So09brNJge1T83RkkorJ1Xc
         HFTA==
X-Forwarded-Encrypted: i=1; AJvYcCX9VsJV+YG6I04PuLNqHXg0RmRVDCgqg0pMlLth5UHIsg7UbnCs5cFJnu5ziDnTaYhIecIuIl81DVKi@vger.kernel.org
X-Gm-Message-State: AOJu0YxXY0VQAGc3x7qGHZG6fofno+e80nAxHZx/P1/Srtina2mGK2RG
	mLf+5e1uh1f4ZY37fgd7RxlKgzQbdG6riliUyEyx/Y89Ibo6cJmZGlUaMLJ07H9Md6HsX8C0HPS
	1bBXgtROjF7gOvXD5qSPsmxY4JTHx3HQuN79eTWx52lEykZwB0Nuv
X-Gm-Gg: ASbGnctmKUXKuFzcJYH5RYv6H+cL9ssqTr91/SzuXDiBhiQATgx9Vej1UOSmV1bzSeL
	qZ8EFDUlA4b88a7XGA7Vj5T94lcSp6ik4/Jat
X-Google-Smtp-Source: AGHT+IFeY/lI4CPvz/ZLmKO4ReXJ8qiTi9cv7XjPjn8zz4iPEMVpoRwdp+JH7V3H6EdHBFEyi3OVz+rPcUcdogaa1Ag=
X-Received: by 2002:a05:690c:2d86:b0:6ef:9e74:c09b with SMTP id
 00721157ae682-6f14803f3f2mr15129097b3.33.1733897031402; Tue, 10 Dec 2024
 22:03:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
 <20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com>
 <20241205090716.GU1245331@unreal> <CAH-L+nN0C=0ZoJmAgBTbjCUcwoQO00WoUc3d3BKn_tGPdk5UbA@mail.gmail.com>
 <20241205113841.GY1245331@unreal> <CA+sbYW21nc0JPs-N0rmR-DgUvX0pydCY_bZXUC57aA0rXUst1A@mail.gmail.com>
 <20241210114841.GE1245331@unreal>
In-Reply-To: <20241210114841.GE1245331@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 11 Dec 2024 11:33:38 +0530
Message-ID: <CA+sbYW0n5CPupxByysd7Dc9=QLQm33ivC1YH5T2UbvG6MBVymg@mail.gmail.com>
Subject: Re: [PATCH for-rc 4/5] RDMA/bnxt_re: Fix error recovery sequence
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>, jgg@ziepe.ca, 
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	Kashyap Desai <kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a7bb0b0628f85c5d"

--000000000000a7bb0b0628f85c5d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 5:18=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Dec 09, 2024 at 10:13:23AM +0530, Selvin Xavier wrote:
> > On Thu, Dec 5, 2024 at 5:08=E2=80=AFPM Leon Romanovsky <leon@kernel.org=
> wrote:
> > >
> > > On Thu, Dec 05, 2024 at 03:01:25PM +0530, Kalesh Anakkur Purayil wrot=
e:
> > > > On Thu, Dec 5, 2024 at 2:37=E2=80=AFPM Leon Romanovsky <leon@kernel=
.org> wrote:
> > > > >
> > > > > On Wed, Dec 04, 2024 at 01:24:15PM +0530, Kalesh AP wrote:
> > > > > > Fixed to return ENXIO from __send_message_basic_sanity()
> > > > > > to indicate that device is in error state. In the case of
> > > > > > ERR_DEVICE_DETACHED state, the driver should not post the
> > > > > > commands to the firmware as it will time out eventually.
> > > > > >
> > > > > > Removed bnxt_re_modify_qp() call from bnxt_re_dev_stop()
> > > > > > as it is a no-op.
> > > > > >
> > > > > > Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW =
error is detected")
> > > > > >
> > > > >
> > > > > Please don't add blank line here.
> > > > Sure, my bad. I missed it. Thanks for pointing it out.
> > > > >
> > > > > > Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
> > > > > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > > > ---
> > > > > >  drivers/infiniband/hw/bnxt_re/main.c       | 8 +-------
> > > > > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 7 ++++---
> > > > > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 3 +++
> > > > > >  3 files changed, 8 insertions(+), 10 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/inf=
iniband/hw/bnxt_re/main.c
> > > > > > index b7af0d5ff3b6..c143f273b759 100644
> > > > > > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > > > > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > > > > @@ -1715,11 +1715,8 @@ static bool bnxt_re_is_qp1_or_shadow_qp(=
struct bnxt_re_dev *rdev,
> > > > > >
> > > > > >  static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
> > > > > >  {
> > > > > > -     int mask =3D IB_QP_STATE;
> > > > > > -     struct ib_qp_attr qp_attr;
> > > > > >       struct bnxt_re_qp *qp;
> > > > > >
> > > > > > -     qp_attr.qp_state =3D IB_QPS_ERR;
> > > > > >       mutex_lock(&rdev->qp_lock);
> > > > > >       list_for_each_entry(qp, &rdev->qp_list, list) {
> > > > > >               /* Modify the state of all QPs except QP1/Shadow =
QP */
> > > > > > @@ -1727,12 +1724,9 @@ static void bnxt_re_dev_stop(struct bnxt=
_re_dev *rdev)
> > > > > >                       if (qp->qplib_qp.state !=3D
> > > > > >                           CMDQ_MODIFY_QP_NEW_STATE_RESET &&
> > > > > >                           qp->qplib_qp.state !=3D
> > > > > > -                         CMDQ_MODIFY_QP_NEW_STATE_ERR) {
> > > > > > +                         CMDQ_MODIFY_QP_NEW_STATE_ERR)
> > > > > >                               bnxt_re_dispatch_event(&rdev->ibd=
ev, &qp->ib_qp,
> > > > > >                                                      1, IB_EVEN=
T_QP_FATAL);
> > > > > > -                             bnxt_re_modify_qp(&qp->ib_qp, &qp=
_attr, mask,
> > > > > > -                                               NULL);
> > > > > > -                     }
> > > > > >               }
> > > > > >       }
> > > > > >       mutex_unlock(&rdev->qp_lock);
> > > > > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drive=
rs/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > > > > index 5e90ea232de8..c8e65169f58a 100644
> > > > > > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > > > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > > > > @@ -423,8 +423,9 @@ static int __send_message_basic_sanity(stru=
ct bnxt_qplib_rcfw *rcfw,
> > > > > >       cmdq =3D &rcfw->cmdq;
> > > > > >
> > > > > >       /* Prevent posting if f/w is not in a state to process */
> > > > > > -     if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
> > > > > > -             return bnxt_qplib_map_rc(opcode);
> > > > > > +     if (RCFW_NO_FW_ACCESS(rcfw))
> > > > > > +             return -ENXIO;
> > > > > > +
> > > > > >       if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
> > > > > >               return -ETIMEDOUT;
> > > > > >
> > > > > > @@ -493,7 +494,7 @@ static int __bnxt_qplib_rcfw_send_message(s=
truct bnxt_qplib_rcfw *rcfw,
> > > > > >
> > > > > >       rc =3D __send_message_basic_sanity(rcfw, msg, opcode);
> > > > > >       if (rc)
> > > > > > -             return rc;
> > > > > > +             return rc =3D=3D -ENXIO ? bnxt_qplib_map_rc(opcod=
e) : rc;
> > > > > >
> > > > > >       rc =3D __send_message(rcfw, msg, opcode);
> > > > > >       if (rc)
> > > > > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drive=
rs/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > > > > index 88814cb3aa74..4f7d800e35c3 100644
> > > > > > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > > > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > > > > @@ -129,6 +129,9 @@ static inline u32 bnxt_qplib_set_cmd_slots(=
struct cmdq_base *req)
> > > > > >
> > > > > >  #define RCFW_MAX_COOKIE_VALUE                (BNXT_QPLIB_CMDQE=
_MAX_CNT - 1)
> > > > > >  #define RCFW_CMD_IS_BLOCKING         0x8000
> > > > > > +#define RCFW_NO_FW_ACCESS(rcfw)                               =
               \
> > > > > > +     (test_bit(ERR_DEVICE_DETACHED, &(rcfw)->cmdq.flags) ||   =
       \
> > > > > > +      pci_channel_offline((rcfw)->pdev))
> > > > >
> > > > > There is some disconnection between description and implementatio=
n.
> > > > > ERR_DEVICE_DETACHED is set when device is suspended, at this stag=
e all
> > > > > FW commands should stop already and if they are not, bnxt_re has =
bugs
> > > > > in cleanup path. It should flush/cancel/e.t.c and not randomly te=
st some
> > > > > bit.
> > > > Yes, the device is in reset state. All outstanding firmware command=
s
> > > > are suspended. We do not want to post any new commands to firmware =
in
> > > > the recovery teardown path. Any commands sent to firmware at this
> > > > point will time out.
> > > > To avoid that, before posting the command driver checks the state a=
nd
> > > > returns early.
> > >
> > > I understand that. Please reread my sentence "all FW commands should =
stop
> > > already and if they are not, bnxt_re has bugs in cleanup path.", and =
answer
> > > is how is it possible to get FW commands during restore.
> > Hi Leon,
> >
> > Not sure if I also got your point correctly. Once the error recovery
> > gets initiated, we
> > unregister the ib device in the suspend path. During the ib_unregister_=
device,
> > we get verb commands to destroy the QP, CQs etc. We want to prevent sen=
ding the
> > new commands to FW for all these operations. We also want to avoid send=
ing
> > any resource creation commands from the stack while the device is
> > getting re-initialized
>
> The thing is that during ib_unregister_device nothing external to driver
> is going to be sent to FW.
ib_unregister will trigger the destroy_qp (at least QP1) and
destroy_cqs. Those verbs will be trying to
issue the FW command and we are trying to prevent sending it to FW here.
We need a check here in the common path to avoid sending any commands
and i dont see a way
to handle this otherwise. Current check has a bug where the return
code check was not correct and we
ended up sending some of the commands that eventually timeout.

Just to add, We have similar implementation in our L2 driver also,
which we were trying to replicate using
bnxt_re data structures.

#define BNXT_NO_FW_ACCESS(bp)                                   \
        (test_bit(BNXT_STATE_FW_FATAL_COND, &(bp)->state) ||    \
         pci_channel_offline((bp)->pdev))

Thanks,
Selvin
>
> > This is a common check that prevents more commands from the stack down
> > to Firmware.
> >
> > >
> > > > >
> > > > > In addition, pci_channel_offline() in driver which doesn't manage=
 PCI
> > > > > device looks strange to me. It should be part of bnxt core and no=
t
> > > > > related to IB.
> > > > The bnxt_re driver also has a firmware communication channel where =
it
> > > > writes to BAR to issue firmware commands. When the PCI channel is
> > > > offline, any commands issued from the driver will time out eventual=
ly.
> > > > To prevent that we added this extra check to detect that condition =
early.
> > >
> > > This micro optimization where you check in some random place for pci =
channel
> > > status is not correct.
> > Will remove pci_channel_offline check and come up with some other
> > mechanism to handle this case.
> > >
> > > Thanks
> > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > >  #define HWRM_VERSION_DEV_ATTR_MAX_DPI  0x1000A0000000DULL
> > > > > >  /* HWRM version 1.10.3.18 */
> > > > > > --
> > > > > > 2.31.1
> > > > > >
> > > >
> > > >
> > > >
> > > > --
> > > > Regards,
> > > > Kalesh A P
> > >
> > >
>
>

--000000000000a7bb0b0628f85c5d
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGRFQOrFIk/5
58CYCv0GlBTOvCIoWYHCnl2NkBD55Nz3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MTIxMTA2MDM1MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQASP9LYWuMOxeVFN+r9uX1hZ/bVeCwK
KradiezfnVGp9cEmilOYLlJ7uSu+Jtn2HzykdZrKshBJ3X4Y8FhM76/pUntZWVf28smgKKB/BmbE
ai4KxWuTmXgxdE4mxkU0oJdbw0wKzaN5yFlBqdGGwrD4uMG6pDxM218Z5K8fQdXFSHwfUxbRuyWi
i5a+BczcRLhH2Xbrhz84d3BkzqxXod8bwoYO3PVVOF9Kg6Gy3sDuwTV2yL0u1Q5yNTMBJ1czjXlQ
MRWDnz6jZ9ckh0Q3SxNe1NJbzXXEY+qZlhbInpzTVhEUU9D8zPn2weGdDsBZvcLyyxTpZknqJkxX
XEFLGTW2
--000000000000a7bb0b0628f85c5d--

