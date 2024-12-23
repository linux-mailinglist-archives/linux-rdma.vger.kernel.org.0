Return-Path: <linux-rdma+bounces-6710-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A309FB0D3
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 16:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D5A188345F
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 15:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C4019D074;
	Mon, 23 Dec 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qn92D7Sa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E413A26F
	for <linux-rdma@vger.kernel.org>; Mon, 23 Dec 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734968590; cv=none; b=spOOo7yu+YTRIuVr94VjX6Se8JLKh79jpuHJ8kSk9rAsC6kzOm6RiJiS/WY7mUoFRIG5/gB9Brw3h8zbGIlPH6RrjYQsshU2ma47JcLqYzy1u+rja6ev/9/zgubt6TeRSCUph3KBTaXJXLIpVNOieR14tZ5XmNSm7oiCGhIyo2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734968590; c=relaxed/simple;
	bh=a5jId7yIkSrehlD24MI+Hqg0r+6FVe0YCbwWP9aSIak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=km1HYonHzVMchRCSB7EEigUgUz7L7xCR57pO/yz0jex8gbhZ/2Vrr98ZCSH3cv1J90nnW/XU85/VPSx9GOlOzc2V0MzfCf4YncMCYLQ8uTBIZEKU+iNxTJ97+WSGf7/pu3n1cKTv4lxRoSWCB3qsaOM+/OSse/fF5u2pGfH3bu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Qn92D7Sa; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaedd529ba1so109197866b.1
        for <linux-rdma@vger.kernel.org>; Mon, 23 Dec 2024 07:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734968586; x=1735573386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+g6nXBmEzYg4mLAyl8u3cEb4CKZMW1IqYiQsDpJsjWA=;
        b=Qn92D7SaMHEoiF1hSP1oxaqBQJ0QX1/+Ys+BRSJ8SdKFH5sklvL8okyiwXh+eYIHdX
         G3WxdZiQcU4OE/azIF+du41DoUbsOc00hkZJM/ev4ns3/4SDeEUunM8020+kDO7/JSlF
         Nyq3mR9fF7XXL9ZD3tGh7Lf/+oRuD+QBpdBfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734968586; x=1735573386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+g6nXBmEzYg4mLAyl8u3cEb4CKZMW1IqYiQsDpJsjWA=;
        b=s7RBmgI8z/oCP1UhXDWTPVhfnt0PecxOHLNVaB3gqPCwLg8CMwqhG8GPtWCebmAnX0
         gDyk5iOxmml3rVMmcvQirry0inSX1Degf3HaUVbftkUcUqN+EdtzKsZojaLuNXTTLCYZ
         Eo0dnj3WEpHAdy1RT1dVefyAEPn/aZj+7L2WXTnFqaeOHKvoorTzk0zCWmye04ddLi6j
         mQfhO9rkEraGT65Eu/F8QA2CC20BKY1CunJUREsz7fR3XA7HSqIYtcmYq8iMEJHO45k+
         ni/f63BCYAhV/X6KaghqS2YRF/QxiactcVOd6CCyQmD3pnMwNVVREv9ddIK2GR3iOajf
         elLA==
X-Forwarded-Encrypted: i=1; AJvYcCV/RpjP66DCeibbcZG1/s4lfAe16xY0CaHjSBDhJ5yPPLrOtvdZ23Qdt/HHjHgTsWP/Q78NBqVwDQIL@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXUYi/VjRCEy6V0ZcOB0Ak/xvbuiuCP2S1Pc9FjEujuo5sJQ4
	52bllpVkKHAQPfQvxKTFJWAdmrCaf2haKQtse/2fb7pO16jZALATv8ciiFDftOpQ7t5ueuOAzZb
	xMZC24kJiK8nzaPSaWRttQpF3WV8YkUjaLEBR
X-Gm-Gg: ASbGnctfCzL3IMbHEAzmNlKVFw0K/3QvNwoBquyTiJwfAiMJfXPfBoAygNy7WAanOa2
	JAt4STy66AF07FshztMNZLrDvej1ci1V1wKJWxHeSodfQzvtVrt+Lp8fEPVBFKlPGd5E/5GOW
X-Google-Smtp-Source: AGHT+IEXgRnYrOWIMkoS4K9NfMcIYD31JxEKXEO98UQROIxjdG483Nc+UXO4qx0KF0LrLbsa9y6KGlo3BO3UbQAEBd0=
X-Received: by 2002:a05:6402:3884:b0:5d3:ff93:f5f9 with SMTP id
 4fb4d7f45d1cf-5d81ddd625dmr30380644a12.20.1734968586248; Mon, 23 Dec 2024
 07:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220075920.1566165-1-kalesh-anakkur.purayil@broadcom.com> <20241223150033.GA171473@unreal>
In-Reply-To: <20241223150033.GA171473@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 23 Dec 2024 21:12:53 +0530
Message-ID: <CAH-L+nPAkBggkMx1VVwLs4xSRZZLuidoHT77doKJSw1KWSPT8A@mail.gmail.com>
Subject: Re: [PATCH for-rc v2] RDMA/bnxt_re: Fix error recovery sequence
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, Kashyap Desai <kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000509b380629f1dacd"

--000000000000509b380629f1dacd
Content-Type: multipart/alternative; boundary="00000000000047f4340629f1dae1"

--00000000000047f4340629f1dae1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Regards,
Kalesh AP


On Mon, 23 Dec 2024 at 8:30=E2=80=AFPM, Leon Romanovsky <leon@kernel.org> w=
rote:

> On Fri, Dec 20, 2024 at 01:29:20PM +0530, Kalesh AP wrote:
> > Fixed to return ENXIO from __send_message_basic_sanity()
> > to indicate that device is in error state. In the case of
> > ERR_DEVICE_DETACHED state, the driver should not post the
> > commands to the firmware as it will time out eventually.
> >
> > Removed bnxt_re_modify_qp() call from bnxt_re_dev_stop()
> > as it is a no-op.
> >
> > Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW error is
> detected")
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> > Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> > V2: No changes since v1 and is just a resend.
> > V1:
> https://patchwork.kernel.org/project/linux-rdma/patch/20241204075416.4784=
31-5-kalesh-anakkur.purayil@broadcom.com/
> > ---
> >  drivers/infiniband/hw/bnxt_re/main.c       | 8 +-------
> >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 7 ++++---
> >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 3 +++
> >  3 files changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/main.c
> b/drivers/infiniband/hw/bnxt_re/main.c
> > index b7af0d5ff3b6..c143f273b759 100644
> > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -1715,11 +1715,8 @@ static bool bnxt_re_is_qp1_or_shadow_qp(struct
> bnxt_re_dev *rdev,
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
> > @@ -1727,12 +1724,9 @@ static void bnxt_re_dev_stop(struct bnxt_re_dev
> *rdev)
> >                       if (qp->qplib_qp.state !=3D
> >                           CMDQ_MODIFY_QP_NEW_STATE_RESET &&
> >                           qp->qplib_qp.state !=3D
> > -                         CMDQ_MODIFY_QP_NEW_STATE_ERR) {
> > +                         CMDQ_MODIFY_QP_NEW_STATE_ERR)
> >                               bnxt_re_dispatch_event(&rdev->ibdev,
> &qp->ib_qp,
> >                                                      1,
> IB_EVENT_QP_FATAL);
> > -                             bnxt_re_modify_qp(&qp->ib_qp, &qp_attr,
> mask,
> > -                                               NULL);
> > -                     }
> >               }
> >       }
> >       mutex_unlock(&rdev->qp_lock);
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > index 5e90ea232de8..c8e65169f58a 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > @@ -423,8 +423,9 @@ static int __send_message_basic_sanity(struct
> bnxt_qplib_rcfw *rcfw,
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
> > @@ -493,7 +494,7 @@ static int __bnxt_qplib_rcfw_send_message(struct
> bnxt_qplib_rcfw *rcfw,
> >
> >       rc =3D __send_message_basic_sanity(rcfw, msg, opcode);
> >       if (rc)
> > -             return rc;
> > +             return rc =3D=3D -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;
> >
> >       rc =3D __send_message(rcfw, msg, opcode);
> >       if (rc)
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > index 88814cb3aa74..4f7d800e35c3 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > @@ -129,6 +129,9 @@ static inline u32 bnxt_qplib_set_cmd_slots(struct
> cmdq_base *req)
> >
> >  #define RCFW_MAX_COOKIE_VALUE                (BNXT_QPLIB_CMDQE_MAX_CNT
> - 1)
> >  #define RCFW_CMD_IS_BLOCKING         0x8000
> > +#define RCFW_NO_FW_ACCESS(rcfw)
>       \
> > +     (test_bit(ERR_DEVICE_DETACHED, &(rcfw)->cmdq.flags) ||          \
> > +      pci_channel_offline((rcfw)->pdev))
>
> You promised me that this patch handles races, so how is this
> pci_channel_offline() check protected?
>
> Thansk

Hi Leon,

Sorry, I may be missing something here.
Could you help me understand what is the race condition here? I can then
internally discuss with the team based on your input.

Regards,
Kalesh AP

>
>
> >
> >  #define HWRM_VERSION_DEV_ATTR_MAX_DPI  0x1000A0000000DULL
> >  /* HWRM version 1.10.3.18 */
> > --
> > 2.43.5
> >
>

--00000000000047f4340629f1dae1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br clear=3D"all"><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gma=
il_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Regards,<=
div>Kalesh AP</div></div></div></div></div><div><br></div><div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Mon, 23 Dec 2024 at 8:30=E2=80=AFPM, Leon Romanovsky &lt;<a href=3D"=
mailto:leon@kernel.org">leon@kernel.org</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">On Fri, Dec 20, 2024 at 01:29:20PM +0530, Kalesh AP wro=
te:<br>
&gt; Fixed to return ENXIO from __send_message_basic_sanity()<br>
&gt; to indicate that device is in error state. In the case of<br>
&gt; ERR_DEVICE_DETACHED state, the driver should not post the<br>
&gt; commands to the firmware as it will time out eventually.<br>
&gt; <br>
&gt; Removed bnxt_re_modify_qp() call from bnxt_re_dev_stop()<br>
&gt; as it is a no-op.<br>
&gt; <br>
&gt; Fixes: cc5b9b48d447 (&quot;RDMA/bnxt_re: Recover the device when FW er=
ror is detected&quot;)<br>
&gt; Signed-off-by: Kalesh AP &lt;<a href=3D"mailto:kalesh-anakkur.purayil@=
broadcom.com" target=3D"_blank">kalesh-anakkur.purayil@broadcom.com</a>&gt;=
<br>
&gt; Signed-off-by: Kashyap Desai &lt;<a href=3D"mailto:kashyap.desai@broad=
com.com" target=3D"_blank">kashyap.desai@broadcom.com</a>&gt;<br>
&gt; Reviewed-by: Selvin Xavier &lt;<a href=3D"mailto:selvin.xavier@broadco=
m.com" target=3D"_blank">selvin.xavier@broadcom.com</a>&gt;<br>
&gt; ---<br>
&gt; V2: No changes since v1 and is just a resend.<br>
&gt; V1: <a href=3D"https://patchwork.kernel.org/project/linux-rdma/patch/2=
0241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com/" rel=3D"norefer=
rer" target=3D"_blank">https://patchwork.kernel.org/project/linux-rdma/patc=
h/20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com/</a><br>
&gt; ---<br>
&gt;=C2=A0 drivers/infiniband/hw/bnxt_re/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 8 +-------<br>
&gt;=C2=A0 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 7 ++++---<br>
&gt;=C2=A0 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 3 +++<br>
&gt;=C2=A0 3 files changed, 8 insertions(+), 10 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband=
/hw/bnxt_re/main.c<br>
&gt; index b7af0d5ff3b6..c143f273b759 100644<br>
&gt; --- a/drivers/infiniband/hw/bnxt_re/main.c<br>
&gt; +++ b/drivers/infiniband/hw/bnxt_re/main.c<br>
&gt; @@ -1715,11 +1715,8 @@ static bool bnxt_re_is_qp1_or_shadow_qp(struct =
bnxt_re_dev *rdev,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int mask =3D IB_QP_STATE;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct ib_qp_attr qp_attr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bnxt_re_qp *qp;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0qp_attr.qp_state =3D IB_QPS_ERR;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;rdev-&gt;qp_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0list_for_each_entry(qp, &amp;rdev-&gt;qp_lis=
t, list) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Modify the st=
ate of all QPs except QP1/Shadow QP */<br>
&gt; @@ -1727,12 +1724,9 @@ static void bnxt_re_dev_stop(struct bnxt_re_dev=
 *rdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (qp-&gt;qplib_qp.state !=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0CMDQ_MODIFY_QP_NEW_STATE_RESET &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0qp-&gt;qplib_qp.state !=3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0CMDQ_MODIFY_QP_NEW_STATE_ERR) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0CMDQ_MODIFY_QP_NEW_STATE_ERR)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_re_dispatch_event(&amp;rdev-&=
gt;ibdev, &amp;qp-&gt;ib_qp,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1, IB_EVENT_QP_FATAL);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_re_modify_qp(&amp;qp-&gt;ib_qp, &am=
p;qp_attr, mask,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;rdev-&gt;qp_lock);<br>
&gt; diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infi=
niband/hw/bnxt_re/qplib_rcfw.c<br>
&gt; index 5e90ea232de8..c8e65169f58a 100644<br>
&gt; --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c<br>
&gt; +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c<br>
&gt; @@ -423,8 +423,9 @@ static int __send_message_basic_sanity(struct bnxt=
_qplib_rcfw *rcfw,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cmdq =3D &amp;rcfw-&gt;cmdq;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Prevent posting if f/w is not in a state =
to process */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(ERR_DEVICE_DETACHED, &amp;rcfw-&gt;c=
mdq.flags))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return bnxt_qplib_map=
_rc(opcode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (RCFW_NO_FW_ACCESS(rcfw))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENXIO;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (test_bit(FIRMWARE_STALL_DETECTED, &amp;c=
mdq-&gt;flags))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ETIMEDOU=
T;<br>
&gt;=C2=A0 <br>
&gt; @@ -493,7 +494,7 @@ static int __bnxt_qplib_rcfw_send_message(struct b=
nxt_qplib_rcfw *rcfw,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __send_message_basic_sanity(rcfw, msg=
, opcode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rc =3D=3D -ENX=
IO ? bnxt_qplib_map_rc(opcode) : rc;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __send_message(rcfw, msg, opcode);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
&gt; diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infi=
niband/hw/bnxt_re/qplib_rcfw.h<br>
&gt; index 88814cb3aa74..4f7d800e35c3 100644<br>
&gt; --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h<br>
&gt; +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h<br>
&gt; @@ -129,6 +129,9 @@ static inline u32 bnxt_qplib_set_cmd_slots(struct =
cmdq_base *req)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define RCFW_MAX_COOKIE_VALUE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (BNXT_QPLIB_CMDQE_MAX_CNT - 1)<br>
&gt;=C2=A0 #define RCFW_CMD_IS_BLOCKING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
8000<br>
&gt; +#define RCFW_NO_FW_ACCESS(rcfw)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0(test_bit(ERR_DEVICE_DETACHED, &amp;(rcfw)-&gt;cm=
dq.flags) ||=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 pci_channel_offline((rcfw)-&gt;pdev))<br>
<br>
You promised me that this patch handles races, so how is this<br>
pci_channel_offline() check protected?<br>
<br>
Thansk</blockquote><div dir=3D"auto">Hi Leon,</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Sorry, I may be missing something here.=C2=A0</div><d=
iv dir=3D"auto">Could you help me understand what is the race condition her=
e? I can then internally discuss with the team based on your input.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Regards,</div><div dir=3D"auto"=
>Kalesh AP</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex" dir=3D"auto"><br>
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define HWRM_VERSION_DEV_ATTR_MAX_DPI=C2=A0 0x1000A0000000DULL<b=
r>
&gt;=C2=A0 /* HWRM version 1.10.3.18 */<br>
&gt; -- <br>
&gt; 2.43.5<br>
&gt; <br>
</blockquote></div></div>

--00000000000047f4340629f1dae1--

--000000000000509b380629f1dacd
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
AQkEMSIEIEgf4FkmR9wyxFch0Pixb/U6LFhoy75G6zfWi4YbXvCZMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTIyMzE1NDMwNlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBFNhpBIlTH
m+gciQvpoW1e5O5nS5aaTCSancSIHpWsfJS+2AeryXmhYAn/HOLorjPs3/gotePGj/m8S/r9Ax4Q
c/F4OL0ZQWbokzcOI07Vmp26ZOfYenHe8BwUQ/Inqnot2IW1d/ZCuyV3TH4DSyCY8kQaCS4KLUMn
qzr2ueu6PGhgXo0flzl8HLgIr7o/vrptGyne6R8WA2UlalHNpdq8/DbyLhGdDZgHCvt92DS+vFm7
YhAtNNuKWcmJaXuuk8gl/tYZPjB2jLJNAYtLl7F72Q0j4ATPOPU/C3ATINcUmnrLvlbCozvmtgMs
NHnrerxj7zWEwPmVg1zFDes+FcFe
--000000000000509b380629f1dacd--

