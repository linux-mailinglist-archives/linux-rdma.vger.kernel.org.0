Return-Path: <linux-rdma+bounces-7611-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B5A2DF50
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 18:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0289218863C9
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 17:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1FF1DFD94;
	Sun,  9 Feb 2025 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MZwpcd+I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EF81D934C
	for <linux-rdma@vger.kernel.org>; Sun,  9 Feb 2025 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739121529; cv=none; b=GLDTNhlMsqOZVnZLXCBXBG08aOEhWEPm/Eq73Xj138YiHm6oLBFnMQMfKGeGyfvJkdIGskjZ+NbBz4Kro42/fAgeesN4yZr2td6rQQp0oqQFFreFXvMLDP73+8jaCWD0rhTOvoLBPS1LcGnamWo0s8AYP4aFRK0qpSFFnPIvb1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739121529; c=relaxed/simple;
	bh=1vqm+ZL2ZaTb8Gtev5YQ5Y/Mqu/e35IJyzFISvBVI9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d16ogB6nxsfJMkpQGx/SLvHXB9z/QgS2ZqeWs3ToOMBXvBdLQc7bJCaZrGZ5nJ0JDoyUwS+Lv9F3ghjHVqBBr6PKm3CMSVXLGoalopEVZep8CJG3KnXbD8ScNHI934LQl0e/g4H/F4uTes4pWYz+T8bWb0HR7gEqw5cZeixZUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MZwpcd+I; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso4022939fac.2
        for <linux-rdma@vger.kernel.org>; Sun, 09 Feb 2025 09:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739121527; x=1739726327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UAp1LifaA18fkBxPNdMO5OVXYhc6NlxxFzSguq09Wsk=;
        b=MZwpcd+IjlkVEgQVbXOfiAhdcgvLqKsxfTzrQJM8Ttd/6l/5GIqIS4oOlsylxpkHot
         6IIn7EGEI0eMvXGZMnmG32o8U5lG57D87cMyv9/75wXvV+fwKgWgiB3NTpeqphk3Ba9X
         ZxXgeMZorx0JSOl69m2donlS549tw/g3umDwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739121527; x=1739726327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAp1LifaA18fkBxPNdMO5OVXYhc6NlxxFzSguq09Wsk=;
        b=FMkG0gzTSIQw2RIdddkVOj1rJiirM8kP+JZsBYu1BqbbBZJw5xx3XqwNkYxFVdOjK6
         CwDK5lkKp0ZQY1GmcDj4Hwl7gomraPr4dw4xruMpih2vov7UdB76+xyWoXRx8JeBK5/x
         j0uHERrfKh6alQlC+pjz8IDVjVrNK8QcE6enEHfWDpp8SWZcQfYbQQ0K0p9lnEu7lTIq
         lAglfXV0xUg0TGlvbdwHP7bP9GE7rV+VMIsx8ae+0v1IgVpT5HCe1fwveoG+z2LR376o
         99XU16XhFePChzWzycURwa32RH7NgyTbtLSWy2kqfxZzrDQGeTU2tX4DVtbAWtk/xZ1C
         jd8A==
X-Forwarded-Encrypted: i=1; AJvYcCUbXMGnG54SP09GlYmi7wXykJNEjNmHu6PJwJJue+LRzx2xRYTW7lWcuTnNa5/YPFmFOFyalOt4y3og@vger.kernel.org
X-Gm-Message-State: AOJu0YxTRU933BcbIkrcoyTkeALmIHhjVx61TAmcdOJt5ie7VPZLgxcb
	wv7/mwWBSHhftQJOlKNHWZH5njDlMQv586iqL4Om8+h1S/mT/b1L1Pi/6y8thd81IPje9AKpAZ+
	i7GStjjGopTz4HHzibrW3mFS03FGIRLAcQv0iLcLwKg9omh8=
X-Gm-Gg: ASbGncu14WdKPHELS4IxLnWXeqmXpfyyO9TedCujBcbqyXIifB4rWshutYp+jx/CoMe
	wZVXkhax+oTl89trrZBzIfDvNGmtSDPZwczU6w26Njtx45P+7UsuMrCQb4D4XpF1S4ChMNjP1
X-Google-Smtp-Source: AGHT+IGBDwzTpZfnckxjg9n0ZayWixy9cAQz5CBKyg4yjxh+h54o/lX3CcT+QEcNCibyG1cZJI7Ye4qsD3nj2P2yq78=
X-Received: by 2002:a05:6870:d0c5:b0:29e:4cab:5954 with SMTP id
 586e51a60fabf-2b83ecc19dbmr6857109fac.17.1739121526805; Sun, 09 Feb 2025
 09:18:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
 <1738657285-23968-3-git-send-email-selvin.xavier@broadcom.com>
 <20250204114400.GK74886@unreal> <CAH-L+nPzuSdKN=WQccTP2crfMp8hSLqq-uTXqw_Ck=sHtWbyEQ@mail.gmail.com>
 <20250205071747.GM74886@unreal> <CAH-L+nM6+-v6dvgzA6UDhgbhjysr55BJ859N5aWWXNEm4k+EDw@mail.gmail.com>
 <20250205095215.GN74886@unreal> <CAH-L+nP7MxtcVzAXK0q4V9qYZ-vf=vAbPW2fX2=V-yKE0VJyQA@mail.gmail.com>
In-Reply-To: <CAH-L+nP7MxtcVzAXK0q4V9qYZ-vf=vAbPW2fX2=V-yKE0VJyQA@mail.gmail.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Sun, 9 Feb 2025 22:48:34 +0530
X-Gm-Features: AWEUYZman4lOrTSlaR0NyjfjQKq_9I6aU47hEWzAYxptpkXu3hjrV9rMlksqzlA
Message-ID: <CA+sbYW2nMOxkSxSLk2W1vgDoYVSctHMKs7FCshEagpnqNFLayA@mail.gmail.com>
Subject: Re: [PATCH rdma-rc 2/4] RDMA/bnxt_re: Add sanity checks on rdev validity
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: Leon Romanovsky <leon@kernel.org>, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d7c393062db8c83f"

--000000000000d7c393062db8c83f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 9:45=E2=80=AFPM Kalesh Anakkur Purayil
<kalesh-anakkur.purayil@broadcom.com> wrote:
>
> Hi Leon,
>
> On Wed, Feb 5, 2025 at 3:22=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
> >
> > On Wed, Feb 05, 2025 at 01:54:14PM +0530, Kalesh Anakkur Purayil wrote:
> > > Hi Leon,
> > >
> > > On Wed, Feb 5, 2025 at 12:47=E2=80=AFPM Leon Romanovsky <leon@kernel.=
org> wrote:
> > > >
> > > > On Tue, Feb 04, 2025 at 10:10:38PM +0530, Kalesh Anakkur Purayil wr=
ote:
> > > > > Hi Leon,
> > > > >
> > > > > On Tue, Feb 4, 2025 at 5:14=E2=80=AFPM Leon Romanovsky <leon@kern=
el.org> wrote:
> > > > > >
> > > > > > On Tue, Feb 04, 2025 at 12:21:23AM -0800, Selvin Xavier wrote:
> > > > > > > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > > > > >
> > > > > > > There is a possibility that ulp_irq_stop and ulp_irq_start
> > > > > > > callbacks will be called when the device is in detached state=
.
> > > > > > > This can cause a crash due to NULL pointer dereference as
> > > > > > > the rdev is already freed.
> > > > > >
> > > > > > Description and code doesn't match. If "possibility" exists, th=
ere is
> > > > > > no protection from concurrent detach and ulp_irq_stop. If there=
 is such
> > > > > > protection, they can't race.
> > > > > >
> > > > > > The main idea of auxiliary bus is to remove the need to impleme=
nt driver
> > > > > > specific ops.
> > > > >
> > > > > There is no race condition here.
> > > > >
> > > > > Let me explain the scenario.
> > > > >
> > > > > User is doing a devlink reload reinit. As part of that, the Ether=
net
> > > > > driver first invokes the auxiliary bus suspend callback. The RDMA=
 driver
> > > > > will do the unwinding operation and hence rdev will be freed.
> > > > >
> > > > > After that, during the devlink sequence, Ethernet driver invokes =
the
> > > > > ulp_irq_stop() callback and this resulted in the NULL pointer
> > > > > dereference as the RDMA driver is in detached state and the rdev =
is
> > > > > already freed.
> > > >
> > > > Shouldn't devlink reload completely release all auxiliary drivers?
> > > > Why are you keeping BNXT RDMA driver during reload?
> > >
> > > That is the current design. BNXT core Ethernet driver will not destro=
y
> > > the auxiliary device for RDMA, but just calls the suspend callback. A=
s
> > > a result, RDMA driver will remains loaded and remains registered with
> > > the Ethernet driver instance.
> >
> > This is wrong.
>
> We understand that. BNXT core driver team has already started working
> on the auxiliary device removal instead of invoking auxdrv->suspend
> callback in the devlink relaod path. That will avoid these NULL checks
> in RDMA driver. for time being we need these NULL checks.
> That will be posted to net-next tree once internal testing and review is =
done.
> >
> > > > BNXT core driver controls reload, it shouldn't call to drivers whic=
h
> > > > doesn't exist.
> > > Since the RDMA driver instance is registered with Ethernet driver,
> > > core Ethernet driver invokes the callback.
> > > >
> > > > >
> > > > > We are trying to address the NULL pointer dereference issue here.
> > > >
> > > > You are hiding bugs and not fixing them.
> > >
> > > Yes, but this change is critical for the current design of the driver=
.
> >
> > Please fix it once and for all by doing proper reload sequence.
> > I warned you that setting NULLs to pointers hide bugs.
> > https://lore.kernel.org/linux-rdma/20250114112555.GG3146852@unreal/
>
> Yes, I understand. We will work on the suggestion that you had given
> based on the new design mentioned in last comment.
Hi Leon,
 Is it okay to merge this change along with the other fixes in the
series? Its important
for the current driver design.

Thanks,

> >
> > Thanks
> >
> > > >
> > > > >
> > > > > The driver specific ops, ulp_irq_stop and ulp_irq_start are requi=
red.
> > > > > Broadcom Ethernet and RDMA drivers are designed like that to mana=
ge
> > > > > IRQs between them.
> > > > >
> > > > > Hope this clarifies your question.
> > > > > >
> > > > > > >
> > > > > > > Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when F=
W error is detected")
> > > > > > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com=
>
> > > > > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > > > > ---
> > > > > > >  drivers/infiniband/hw/bnxt_re/main.c | 5 +++++
> > > > > > >  1 file changed, 5 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/i=
nfiniband/hw/bnxt_re/main.c
> > > > > > > index c4c3d67..89ac5c2 100644
> > > > > > > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > > > > > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > > > > > @@ -438,6 +438,8 @@ static void bnxt_re_stop_irq(void *handle=
, bool reset)
> > > > > > >       int indx;
> > > > > > >
> > > > > > >       rdev =3D en_info->rdev;
> > > > > > > +     if (!rdev)
> > > > > > > +             return;
> > > > > >
> > > > > > This can be seen as an example why I'm so negative about assign=
ing NULL
> > > > > > to the pointers after object is destroyed. Such assignment make=
s layer
> > > > > > violation much easier job to do.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >       rcfw =3D &rdev->rcfw;
> > > > > > >
> > > > > > >       if (reset) {
> > > > > > > @@ -466,6 +468,8 @@ static void bnxt_re_start_irq(void *handl=
e, struct bnxt_msix_entry *ent)
> > > > > > >       int indx, rc;
> > > > > > >
> > > > > > >       rdev =3D en_info->rdev;
> > > > > > > +     if (!rdev)
> > > > > > > +             return;
> > > > > > >       msix_ent =3D rdev->nqr->msix_entries;
> > > > > > >       rcfw =3D &rdev->rcfw;
> > > > > > >       if (!ent) {
> > > > > > > @@ -2438,6 +2442,7 @@ static int bnxt_re_suspend(struct auxil=
iary_device *adev, pm_message_t state)
> > > > > > >       ibdev_info(&rdev->ibdev, "%s: L2 driver notified to sto=
p en_state 0x%lx",
> > > > > > >                  __func__, en_dev->en_state);
> > > > > > >       bnxt_re_remove_device(rdev, BNXT_RE_PRE_RECOVERY_REMOVE=
, adev);
> > > > > > > +     bnxt_re_update_en_info_rdev(NULL, en_info, adev);
> > > > > > >       mutex_unlock(&bnxt_re_mutex);
> > > > > > >
> > > > > > >       return 0;
> > > > > > > --
> > > > > > > 2.5.5
> > > > > > >
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Regards,
> > > > > Kalesh AP
> > > >
> > > >
> > >
> > >
> > > --
> > > Regards,
> > > Kalesh AP
> >
> >
>
>
> --
> Regards,
> Kalesh AP

--000000000000d7c393062db8c83f
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIK0gBtgTuJTI
/BGG/oGxQDQp5c2sSOysUXUtOm5uhObsMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI1MDIwOTE3MTg0N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAo0d0LpaEzsHRCzTomG3hPENQGLgNY
EVZ7OfKqsTE2DQN9D6QVOVZdPRw6y4HWxjkIVcXyCwj9ZUGT+u1EOxGLFZ6Q/725/b1ssz9VYeHP
WMlO3ZxhwBbC8Nd4gC5Te0LwoJvFPNlZZ3R0dZiXxh2Z6OrFbeJWpVbKAeaBFNA9wb8dDj1rUs67
5kw9hEw/b0+LQSH0tmYIpYgL3bxdvtCegyzeJrFEeAR75dAQAQlMNb23tK1NCiN7vVHFXF82QJA5
BvN+DtBEWEyzX09rIFofezb2Nct7eicvNz+UDvjuthL0Xdq5Y2ZxUQle850U1QB3/OldWRJSJqGH
gG4rTJ1P
--000000000000d7c393062db8c83f--

