Return-Path: <linux-rdma+bounces-5950-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18509C68DD
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2024 06:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1870FB22DBF
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2024 05:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8F4175D54;
	Wed, 13 Nov 2024 05:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hEb8W7aT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F334176237
	for <linux-rdma@vger.kernel.org>; Wed, 13 Nov 2024 05:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476666; cv=none; b=Ccz51VW/ApbkvPc4fH9S7mQI8kabfEvFY2NtXCOoQq0s8paPnl+0DDVrjsi9tYQFCjSAZpDV4zdpklrU7CDCK4bmtIz95L9EA+5HY3I0JCLFA+wdTOrOg8sndYwWzx78vQ0J425rawvOf72NTI1F2zaDI/QOE7ldeP1kB5r2th8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476666; c=relaxed/simple;
	bh=WlAfoeW1sqtgNt7vMCWqUgnMuNORWFVKMYN4dZjYxr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6J0okF74Uk4QMt+Y9aiIi4k8jDWhtO2wQatcS82Lgtt++4Fcn4fTTB0GIAXz7unVxuijevsM5vzjbqsUtWqUqQr35avi0XmZSgqwXmIfuz4LKOb7eTKLUl4VOwq1SaxrgVOebQJSgHD+W9idCubWQMieWfHlbIsLtBwm4pWbXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hEb8W7aT; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6eb0e90b729so30854017b3.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 21:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731476663; x=1732081463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0UfgdtyyQQ1KkmQ3RxndeBcGbUFrsGLySd3boG4XSrk=;
        b=hEb8W7aT5L+hwp+mamiXvS2gr/ASU/v/RQZFO4zj8dhX+HrEjcy9lhJURlZOAGX2Bf
         IpH9fsW9APTm/AnQXhvgX70GyayrbQTGcNAJG6uR6HS5qlVSS9xPq6QnnOjIohonHlq9
         TNWMgYFhQOE3a7R034kylZ5kogfOB+eIHuAho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731476663; x=1732081463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UfgdtyyQQ1KkmQ3RxndeBcGbUFrsGLySd3boG4XSrk=;
        b=NYndEGpeRSnmf9SHtyk8LNDYsQ2HORl3SNjiIvIO/tABwGmdggcURHB/VFZdD29UKT
         PVNFuczqKM9z1wkZxHdAUwwdOtfl3d1NDIbLP+RIl7lbYlB7camDu6qfQi7wVG0Cage8
         Y3kqOky4XRQSd4ioCGXULERzXTMGdSXMhcbv1LPbeTkSKWVyivqy80aeJCCLfckAArt8
         O0cBbQFs8mny68sOcO6sKOsC9/EOw74xDRYLQl6RwIgt+M0Ifp6WN79EX3SYXZ5OdwoT
         5eDqr2XHJ2Dqz0A3/FiuB13Ib7NgdURShxyJFw6vd+ws/T8oV7xCOqhZrO9RT9aUPRGl
         XE3A==
X-Forwarded-Encrypted: i=1; AJvYcCVOGmLXOe15uS/E5Y7LPrySWWI8ZVZoTCzoW10bW1YzPzAqH74lmCi/t11Dvpjp/3huCeUXOl0FTZWn@vger.kernel.org
X-Gm-Message-State: AOJu0YwPvcT6zE4IkdOSLyy0SBHv9zT+XKTOmKNFYNIXU81nsk3h8Gg/
	MGhu+sRLt84Vi2+iTljGeAIYwLnA5DsslKMRjSVbef2sVYMKnFBUf+Y7xSvtDxGep1FbUSs97+O
	c9/zUjAVTQPsk5LC7vY42E5Stm+SC5v1Yfw5M7TXVuoyB38k=
X-Google-Smtp-Source: AGHT+IHirOgxh5Yk08XjL5YvgVZPbuCZc+kE/3b8S5oYvJvU9ZPDd/W0JM3qxXmS7JeY9eoorRZCbueCqg0hnTvHY+8=
X-Received: by 2002:a05:690c:4985:b0:6ea:4b07:31a6 with SMTP id
 00721157ae682-6eadddb5b7cmr193684267b3.25.1731476663515; Tue, 12 Nov 2024
 21:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
 <1731055359-12603-6-git-send-email-selvin.xavier@broadcom.com>
 <20241112081746.GI71181@unreal> <CA+sbYW2BAUXLyk0Fa_hmXoQ1e7Ocmj-jw41JNBmjJQupimaD8Q@mail.gmail.com>
 <20241112103429.GK71181@unreal>
In-Reply-To: <20241112103429.GK71181@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 13 Nov 2024 11:14:10 +0530
Message-ID: <CA+sbYW139JBsomZ3AtJvy3sPgF9Z38deOs2VgcB+TZQ4ZEPq_g@mail.gmail.com>
Subject: Re: [rdma-next 5/5] RDMA/bnxt_re: Add new function to setup NQs
To: Leon Romanovsky <leon@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007bea490626c4d3af"

--0000000000007bea490626c4d3af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 4:04=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Nov 12, 2024 at 02:55:12PM +0530, Selvin Xavier wrote:
> > +Michael Chan
> >
> > On Tue, Nov 12, 2024 at 1:47=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Fri, Nov 08, 2024 at 12:42:39AM -0800, Selvin Xavier wrote:
> > > > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > >
> > > > Move the logic to setup and enable NQs to a new function.
> > > > Similarly moved the NQ cleanup logic to a common function.
> > > > Introdued a flag to keep track of NQ allocation status
> > > > and added sanity checks inside bnxt_re_stop_irq() and
> > > > bnxt_re_start_irq() to avoid possible race conditions.
> > > >
> > > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > ---
> > > >  drivers/infiniband/hw/bnxt_re/bnxt_re.h |   2 +
> > > >  drivers/infiniband/hw/bnxt_re/main.c    | 204 +++++++++++++++++++-=
------------
> > > >  2 files changed, 123 insertions(+), 83 deletions(-)
> > >
> > > <...>
> > >
> > > >
> > > > +     rtnl_lock();
> > > > +     if (test_and_clear_bit(BNXT_RE_FLAG_SETUP_NQ, &rdev->flags))
> > > > +             bnxt_re_clean_nqs(rdev);
> > > > +     rtnl_unlock();
> > >
> > > <...>
> > >
> > > > +             rtnl_lock();
> > > >               bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ct=
x);
> > > >               bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
> > > >               type =3D bnxt_qplib_get_ring_type(rdev->chip_ctx);
> > > >               bnxt_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, =
type);
> > > > +             rtnl_unlock();
> > >
> > > Please don't add rtnl_lock() to drivers in RDMA subsystem. BNXT drive=
r
> > > is managed through netdev and it is there all proper locking should b=
e
> > > done.
> > The main reason for bnxt_re to take the rtnl is because of the MSIx
> > resource configuration.
> > This is because the NIC driver is dynamically modifying the MSIx table
> > when the number
> > of ring change  or ndo->open/close is invoked. So we stop and restart
> > the interrupts of RoCE also with rtnl held.
>
> rtnl_lock is a big kernel lock, which blocks almost everything in the net=
dev.
> In your case, you are changing one device configuration and should use
> your per-device locks. Even in the system with more than one BNXT device,
> the MSI-X on one device will influence other "innocent" devices.
>
> > >
> > > Please work to remove existing rtnl_lock() from bnxt_re_update_en_inf=
o_rdev() too.
> > > IMHO that lock is not needed after your driver conversion to auxbus.
> > This check is also to synchronize between the irq_stop and restart
> > implementation between
> > bnxt_en and bnxt_re driver and roce driver unload.
> >
> >  We will review this locking and see if we can handle it. But it is a
> > major design change in both L2
> > and roce drivers.
>
> You are adding new rtnl_lock and not moving it from one place to
> another, so this redesign should be done together with this new
> feature.
Ok. Will drop this patch and post a v2.
>
> Thanks
>
> > >
> > > Thanks
>
>

--0000000000007bea490626c4d3af
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIF1vjotbDkHE
gbdBHYctG4E/erLN/qLrvXzSgnp3WL+HMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MTExMzA1NDQyM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCGHDn9T6bKnq7bfKOPvnmHXhyf4xpK
+mHheQulWX85z8ZtKz45pdf86kRCkeBuIapGZrP5UBmex4ylQJX4zOdtZn74Y6tok0wotBmVBEso
x3pMmVcKoT1LeE3o+kdJd94YQ2UOLL9DHfar4ItP9k9vzeLg+B8kML1NVnZgkQBm6lhQayOW4OIU
Nh2E5MdN29Y5bVpCxNK2QgDwjZorSYUkuqk7L6YWE3JOZK8at6CZdccuSCMTbt3YQNKC1PV7jZ8o
5XrHFij15lf0sRgZim0esvWYEEgSyTPRs5L6ixqSnbc8GPRecjOihDB4993QEExTnEIT2fcZSPRD
+TzJfQvv
--0000000000007bea490626c4d3af--

