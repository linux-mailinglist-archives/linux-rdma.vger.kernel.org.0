Return-Path: <linux-rdma+bounces-6741-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA679FC5B6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 14:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879B116411B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046921B4150;
	Wed, 25 Dec 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XdO6vKJF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742875809
	for <linux-rdma@vger.kernel.org>; Wed, 25 Dec 2024 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735134925; cv=none; b=XFqLRiVt//nIyVU7y+sEvU9kjPVjJVarl19wztjiWqtp5T9joyzqH0RC4BXO59H3rjJniIDnZuEtccGqd24xWzhSPvxsG2TKqhIeefQ2BtnFcapIsNrc+Dy1xLwA1nPL/AlD2cZSScOwoSrPVpn9FiHhl1WAIfNbsqXLQzal3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735134925; c=relaxed/simple;
	bh=64Ma8POTqh0wvpUu/NvHMO2oQHuX61QgDFT3u3vKVxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4HudbYuofWe3QpZRiRy1BvCM7R28EBYcpne22PA3pdusYF20wc1zYS7Si24fTG8HfahYuSTmG7hC5Tq1pHqHQJRfrUCeJDbjZ4qRozbXrMuGWAF4GEbxOcOYHq+QYZI7+0Sky2Fz7RckYvghdd4L2zwWvS8eqeEtgxHWnymgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XdO6vKJF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d84179ef26so5647698a12.3
        for <linux-rdma@vger.kernel.org>; Wed, 25 Dec 2024 05:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1735134922; x=1735739722; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SPL+EbFg5xvFsEcleiZZZTcyCvWbjy0I/W1h3g7Twjg=;
        b=XdO6vKJFzadUwDTPzseUkNCPm36b7S670V7vvYyXYYT5SyPRcgu3BA9xgoJtJIq3gb
         wk1nbHnjMlxaVEhvjxwShdXEaogDGE5FclkLe5C5fw0kn9K096I4xfXeCGfiypPcqEVL
         vBa8LhJnX9GsJvbSGywjpBuLug171xaZSglKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735134922; x=1735739722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPL+EbFg5xvFsEcleiZZZTcyCvWbjy0I/W1h3g7Twjg=;
        b=Tf5CttxguGqQNC8yGVid+CiHiyEqsUmwNpbYjC0O5I0OJcUDHCGI805jrrsKG+hrxs
         xyT3/NfirgQn35lBHmEuQDL3DAwx6/l48+OvKMEovqBEuXepCSfDnWlLuDR8SOXt0R9t
         pxq6vlMP2EiikjyxKJ0wKT4YfUgsYeQrqyDm4EueaySkGLtxIfGS3JWbbeDbiiCAExgY
         J0Vugt/OEno0tPbk3tzBSZNw08+6IoWBBD+5YEB91vzaEwc5lVo2z1LCIWUbM9XgRUMG
         gxVA8TkRWKC+ddBP8H7+wzre9R2zGKgRwXer9pcEhSWWczGxjiKil57BBBYVSCgJ37Qx
         45/w==
X-Forwarded-Encrypted: i=1; AJvYcCW4TggWf1fst9krsdrjLxZZq7O8iUYXOwRJftBVHDYhVmevGN8KVa/kAnKvXxtvVHscm7au1GAapWiC@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJWTux8eo/qYAV5YbduvfD+HVPRD+q28+CSTQOPfmEICtoNIE
	7taGKDpkFCVYoSx8LDadg3FFNuiKBouAbow2bRNgvXAySsDMDdA7urcipScRIZoDhEKC86u+cc3
	598ESn7pzi6xTpSyUTmZnw4PTQJn8Z7AzLRhX
X-Gm-Gg: ASbGncuuO9ayUlbfiruqgWSsWLK7fjtITXRTsvqc2LgIq8xCfogFGKCoPtcuXXN2Tt5
	/ai86fZtQYMvwa9uyqV+cX4VAZ0aDZ+51QxyfQdnDuC4RIYsu99BahXC+bmLvNUFV5y0pHCc9
X-Google-Smtp-Source: AGHT+IGiqSYyJBmtGR7j8JTp9f688MPxHosZbfDSFeISrezFgGV95/5YF2dUkjwrkcb6dnqua5uNYeDeR0/npPpzd1A=
X-Received: by 2002:a05:6402:274c:b0:5d3:f325:2c3 with SMTP id
 4fb4d7f45d1cf-5d81de1c3a7mr19284746a12.33.1735134921626; Wed, 25 Dec 2024
 05:55:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220075920.1566165-1-kalesh-anakkur.purayil@broadcom.com>
 <20241223150033.GA171473@unreal> <CAH-L+nPAkBggkMx1VVwLs4xSRZZLuidoHT77doKJSw1KWSPT8A@mail.gmail.com>
 <20241223164215.GB171473@unreal>
In-Reply-To: <20241223164215.GB171473@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 25 Dec 2024 19:25:08 +0530
Message-ID: <CAH-L+nMLU5wqqJk9-Kw6gMUzmDZotcwbXRn-UW3Tr+7xJhJ8hw@mail.gmail.com>
Subject: Re: [PATCH for-rc v2] RDMA/bnxt_re: Fix error recovery sequence
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, Kashyap Desai <kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000aa6ad3062a1894c4"

--000000000000aa6ad3062a1894c4
Content-Type: multipart/alternative; boundary="000000000000a44927062a18945a"

--000000000000a44927062a18945a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Dec 2024 at 10:12=E2=80=AFPM, Leon Romanovsky <leon@kernel.org> =
wrote:

> On Mon, Dec 23, 2024 at 09:12:53PM +0530, Kalesh Anakkur Purayil wrote:
> > Regards,
> > Kalesh AP
> >
> >
> > On Mon, 23 Dec 2024 at 8:30=E2=80=AFPM, Leon Romanovsky <leon@kernel.or=
g> wrote:
> >
> > > On Fri, Dec 20, 2024 at 01:29:20PM +0530, Kalesh AP wrote:
> > > > Fixed to return ENXIO from __send_message_basic_sanity()
> > > > to indicate that device is in error state. In the case of
> > > > ERR_DEVICE_DETACHED state, the driver should not post the
> > > > commands to the firmware as it will time out eventually.
> > > >
> > > > Removed bnxt_re_modify_qp() call from bnxt_re_dev_stop()
> > > > as it is a no-op.
> > > >
> > > > Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW erro=
r
> is
> > > detected")
> > > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > > Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> > > > Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > ---
> > > > V2: No changes since v1 and is just a resend.
> > > > V1:
> > >
> https://patchwork.kernel.org/project/linux-rdma/patch/20241204075416.4784=
31-5-kalesh-anakkur.purayil@broadcom.com/
> > > > ---
> > > >  drivers/infiniband/hw/bnxt_re/main.c       | 8 +-------
> > > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 7 ++++---
> > > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 3 +++
> > > >  3 files changed, 8 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c
> > > b/drivers/infiniband/hw/bnxt_re/main.c
> > > > index b7af0d5ff3b6..c143f273b759 100644
> > > > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > > @@ -1715,11 +1715,8 @@ static bool bnxt_re_is_qp1_or_shadow_qp(stru=
ct
> > > bnxt_re_dev *rdev,
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
> > > > @@ -1727,12 +1724,9 @@ static void bnxt_re_dev_stop(struct
> bnxt_re_dev
> > > *rdev)
> > > >                       if (qp->qplib_qp.state !=3D
> > > >                           CMDQ_MODIFY_QP_NEW_STATE_RESET &&
> > > >                           qp->qplib_qp.state !=3D
> > > > -                         CMDQ_MODIFY_QP_NEW_STATE_ERR) {
> > > > +                         CMDQ_MODIFY_QP_NEW_STATE_ERR)
> > > >                               bnxt_re_dispatch_event(&rdev->ibdev,
> > > &qp->ib_qp,
> > > >                                                      1,
> > > IB_EVENT_QP_FATAL);
> > > > -                             bnxt_re_modify_qp(&qp->ib_qp, &qp_att=
r,
> > > mask,
> > > > -                                               NULL);
> > > > -                     }
> > > >               }
> > > >       }
> > > >       mutex_unlock(&rdev->qp_lock);
> > > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > > index 5e90ea232de8..c8e65169f58a 100644
> > > > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > > @@ -423,8 +423,9 @@ static int __send_message_basic_sanity(struct
> > > bnxt_qplib_rcfw *rcfw,
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
t
> > > bnxt_qplib_rcfw *rcfw,
> > > >
> > > >       rc =3D __send_message_basic_sanity(rcfw, msg, opcode);
> > > >       if (rc)
> > > > -             return rc;
> > > > +             return rc =3D=3D -ENXIO ? bnxt_qplib_map_rc(opcode) :=
 rc;
> > > >
> > > >       rc =3D __send_message(rcfw, msg, opcode);
> > > >       if (rc)
> > > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > > index 88814cb3aa74..4f7d800e35c3 100644
> > > > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > > @@ -129,6 +129,9 @@ static inline u32 bnxt_qplib_set_cmd_slots(stru=
ct
> > > cmdq_base *req)
> > > >
> > > >  #define RCFW_MAX_COOKIE_VALUE
> (BNXT_QPLIB_CMDQE_MAX_CNT
> > > - 1)
> > > >  #define RCFW_CMD_IS_BLOCKING         0x8000
> > > > +#define RCFW_NO_FW_ACCESS(rcfw)
> > >       \
> > > > +     (test_bit(ERR_DEVICE_DETACHED, &(rcfw)->cmdq.flags) ||
>   \
> > > > +      pci_channel_offline((rcfw)->pdev))
> > >
> > > You promised me that this patch handles races, so how is this
> > > pci_channel_offline() check protected?
> > >
> > > Thansk
> >
> > Hi Leon,
> >
> > Sorry, I may be missing something here.
> > Could you help me understand what is the race condition here? I can the=
n
> > internally discuss with the team based on your input.
>
> pci_channel_offline() is placed completely randomly here. There is no
> guarantee that PCI card won't be offline immediately after this check.

Thank you Leon. I will discuss with the team about this and take it forward
as a separate patch.
For the time being, I will push a V3 with pci_channel_offline() check
removed, is that okay with you?

Regards,
Kalesh

>
>
> Thanks
>
>
> >
> > Regards,
> > Kalesh AP
> >
> > >
> > >
> > > >
> > > >  #define HWRM_VERSION_DEV_ATTR_MAX_DPI  0x1000A0000000DULL
> > > >  /* HWRM version 1.10.3.18 */
> > > > --
> > > > 2.43.5
> > > >
> > >
>
>
>

--000000000000a44927062a18945a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br></div><div><br></div><div><br><div class=3D"gmail_quo=
te gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 23 =
Dec 2024 at 10:12=E2=80=AFPM, Leon Romanovsky &lt;<a href=3D"mailto:leon@ke=
rnel.org">leon@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">On Mon, Dec 23, 2024 at 09:12:53PM +0530, Kalesh Anakkur Purayil wrot=
e:<br>
&gt; Regards,<br>
&gt; Kalesh AP<br>
&gt; <br>
&gt; <br>
&gt; On Mon, 23 Dec 2024 at 8:30=E2=80=AFPM, Leon Romanovsky &lt;<a href=3D=
"mailto:leon@kernel.org" target=3D"_blank">leon@kernel.org</a>&gt; wrote:<b=
r>
&gt; <br>
&gt; &gt; On Fri, Dec 20, 2024 at 01:29:20PM +0530, Kalesh AP wrote:<br>
&gt; &gt; &gt; Fixed to return ENXIO from __send_message_basic_sanity()<br>
&gt; &gt; &gt; to indicate that device is in error state. In the case of<br=
>
&gt; &gt; &gt; ERR_DEVICE_DETACHED state, the driver should not post the<br=
>
&gt; &gt; &gt; commands to the firmware as it will time out eventually.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Removed bnxt_re_modify_qp() call from bnxt_re_dev_stop()<br>
&gt; &gt; &gt; as it is a no-op.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Fixes: cc5b9b48d447 (&quot;RDMA/bnxt_re: Recover the device =
when FW error is<br>
&gt; &gt; detected&quot;)<br>
&gt; &gt; &gt; Signed-off-by: Kalesh AP &lt;<a href=3D"mailto:kalesh-anakku=
r.purayil@broadcom.com" target=3D"_blank">kalesh-anakkur.purayil@broadcom.c=
om</a>&gt;<br>
&gt; &gt; &gt; Signed-off-by: Kashyap Desai &lt;<a href=3D"mailto:kashyap.d=
esai@broadcom.com" target=3D"_blank">kashyap.desai@broadcom.com</a>&gt;<br>
&gt; &gt; &gt; Reviewed-by: Selvin Xavier &lt;<a href=3D"mailto:selvin.xavi=
er@broadcom.com" target=3D"_blank">selvin.xavier@broadcom.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt; V2: No changes since v1 and is just a resend.<br>
&gt; &gt; &gt; V1:<br>
&gt; &gt; <a href=3D"https://patchwork.kernel.org/project/linux-rdma/patch/=
20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com/" rel=3D"norefe=
rrer" target=3D"_blank">https://patchwork.kernel.org/project/linux-rdma/pat=
ch/20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com/</a><br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 drivers/infiniband/hw/bnxt_re/main.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 8 +-------<br>
&gt; &gt; &gt;=C2=A0 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 7 ++++---=
<br>
&gt; &gt; &gt;=C2=A0 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 3 +++<br>
&gt; &gt; &gt;=C2=A0 3 files changed, 8 insertions(+), 10 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/drivers/infiniband/hw/bnxt_re/main.c<br>
&gt; &gt; b/drivers/infiniband/hw/bnxt_re/main.c<br>
&gt; &gt; &gt; index b7af0d5ff3b6..c143f273b759 100644<br>
&gt; &gt; &gt; --- a/drivers/infiniband/hw/bnxt_re/main.c<br>
&gt; &gt; &gt; +++ b/drivers/infiniband/hw/bnxt_re/main.c<br>
&gt; &gt; &gt; @@ -1715,11 +1715,8 @@ static bool bnxt_re_is_qp1_or_shadow_=
qp(struct<br>
&gt; &gt; bnxt_re_dev *rdev,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)=
<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0int mask =3D IB_QP_STATE;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0struct ib_qp_attr qp_attr;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bnxt_re_qp *qp;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0qp_attr.qp_state =3D IB_QPS_ERR;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;rdev-&gt;qp_lock);=
<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0list_for_each_entry(qp, &amp;rdev-=
&gt;qp_list, list) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Mod=
ify the state of all QPs except QP1/Shadow QP */<br>
&gt; &gt; &gt; @@ -1727,12 +1724,9 @@ static void bnxt_re_dev_stop(struct b=
nxt_re_dev<br>
&gt; &gt; *rdev)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (qp-&gt;qplib_qp.state !=3D<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CMDQ_MODIFY_QP_NEW_STATE_RESET &amp;&=
amp;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qp-&gt;qplib_qp.state !=3D<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CMDQ_MODIFY_QP_NEW_STATE_ERR) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CMDQ_MODIFY_QP_NEW_STATE_ERR)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_re_dispatch_event(=
&amp;rdev-&gt;ibdev,<br>
&gt; &gt; &amp;qp-&gt;ib_qp,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1,<br>
&gt; &gt; IB_EVENT_QP_FATAL);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_re_modify_qp(&amp;qp-&gt;=
ib_qp, &amp;qp_attr,<br>
&gt; &gt; mask,<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;rdev-&gt;qp_lock=
);<br>
&gt; &gt; &gt; diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c<br>
&gt; &gt; b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c<br>
&gt; &gt; &gt; index 5e90ea232de8..c8e65169f58a 100644<br>
&gt; &gt; &gt; --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c<br>
&gt; &gt; &gt; +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c<br>
&gt; &gt; &gt; @@ -423,8 +423,9 @@ static int __send_message_basic_sanity(s=
truct<br>
&gt; &gt; bnxt_qplib_rcfw *rcfw,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cmdq =3D &amp;rcfw-&gt;cmdq;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Prevent posting if f/w is not i=
n a state to process */<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(ERR_DEVICE_DETACHED, &amp;=
rcfw-&gt;cmdq.flags))<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return bnxt=
_qplib_map_rc(opcode);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (RCFW_NO_FW_ACCESS(rcfw))<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENX=
IO;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (test_bit(FIRMWARE_STALL_DETECT=
ED, &amp;cmdq-&gt;flags))<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 -ETIMEDOUT;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -493,7 +494,7 @@ static int __bnxt_qplib_rcfw_send_messag=
e(struct<br>
&gt; &gt; bnxt_qplib_rcfw *rcfw,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __send_message_basic_sanity=
(rcfw, msg, opcode);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rc =
=3D=3D -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __send_message(rcfw, msg, o=
pcode);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
&gt; &gt; &gt; diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h<br>
&gt; &gt; b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h<br>
&gt; &gt; &gt; index 88814cb3aa74..4f7d800e35c3 100644<br>
&gt; &gt; &gt; --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h<br>
&gt; &gt; &gt; +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h<br>
&gt; &gt; &gt; @@ -129,6 +129,9 @@ static inline u32 bnxt_qplib_set_cmd_slo=
ts(struct<br>
&gt; &gt; cmdq_base *req)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 #define RCFW_MAX_COOKIE_VALUE=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (BNXT_QPLIB_CMDQE_MAX_CNT<br>
&gt; &gt; - 1)<br>
&gt; &gt; &gt;=C2=A0 #define RCFW_CMD_IS_BLOCKING=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x8000<br>
&gt; &gt; &gt; +#define RCFW_NO_FW_ACCESS(rcfw)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0(test_bit(ERR_DEVICE_DETACHED, &amp;(rc=
fw)-&gt;cmdq.flags) ||=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 pci_channel_offline((rcfw)-&gt;pdev))<=
br>
&gt; &gt;<br>
&gt; &gt; You promised me that this patch handles races, so how is this<br>
&gt; &gt; pci_channel_offline() check protected?<br>
&gt; &gt;<br>
&gt; &gt; Thansk<br>
&gt; <br>
&gt; Hi Leon,<br>
&gt; <br>
&gt; Sorry, I may be missing something here.<br>
&gt; Could you help me understand what is the race condition here? I can th=
en<br>
&gt; internally discuss with the team based on your input.<br>
<br>
pci_channel_offline() is placed completely randomly here. There is no<br>
guarantee that PCI card won&#39;t be offline immediately after this check.<=
/blockquote><div dir=3D"auto">Thank you Leon. I will discuss with the team =
about this and take it forward as a separate patch.=C2=A0</div><div dir=3D"=
auto">For the time being, I will push a V3 with pci_channel_offline() check=
 removed, is that okay with you?</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Regards,=C2=A0</div><div dir=3D"auto">Kalesh</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex" dir=3D"auto"><br>
<br>
Thanks<br>
<br>
<br>
&gt; <br>
&gt; Regards,<br>
&gt; Kalesh AP<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 #define HWRM_VERSION_DEV_ATTR_MAX_DPI=C2=A0 0x1000A000=
0000DULL<br>
&gt; &gt; &gt;=C2=A0 /* HWRM version 1.10.3.18 */<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.43.5<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
<br>
<br>
</blockquote></div></div>

--000000000000a44927062a18945a--

--000000000000aa6ad3062a1894c4
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
AQkEMSIEINB9aKe85/9ir4xTAExxQwOsID4j6mCiN8PnvmCR9d9QMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTIyNTEzNTUyMlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCFimTgFYwL
um3xhMsijvIQEUIMTiz6Rgsfv7wqXduX/QaPy9WY9be5AFwZd58H130hHir62C3vOnPkrA2Mc0OL
YwBLyf/wsBc4YHn/lYVv0Dw0IOvGb2dtK6tkR//eFJl6E0yJ7UqZ5pJYpyH+ZNkImpbAk+x+haEA
ikuv/DJ57QDnnk1mOUusuwOQndf6HBT0AH79spFPWMtQjXuwcMOoJ4MSxiXxryS09DpWAki/nyCZ
1woB+jDFsUkI2a+KFlhU2Ie5KWOXAdKVgPOOdyjKFsBblSKUrq4gROPZMQHF4JRInqzGslts52Ix
9dTd0Wo/KL2hJaWSoUuHzn6Fzhdu
--000000000000aa6ad3062a1894c4--

