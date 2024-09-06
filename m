Return-Path: <linux-rdma+bounces-4783-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A6B96E87F
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 06:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AA6285568
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 04:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD85241E7;
	Fri,  6 Sep 2024 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H1FbNG/y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6302F4A
	for <linux-rdma@vger.kernel.org>; Fri,  6 Sep 2024 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725595406; cv=none; b=IB1DjxXZNjUnH/hiIwxH8fc0wQdbUzVVRT2KqOm7T1CeYinjiqL6cIeHR7MvERfjHFdZ1lYo+VHC5b/xj/czwMD9gRVUbpyEeql3oX6bIKWoEOApHUr4fpxKpLydMPs0DqSQVNkcmoE5rnAWQPYwKzJoou6m81j6wh91DKnJerw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725595406; c=relaxed/simple;
	bh=zNzfzn6U7K/H9nbhV3+e0XShVnKPLOgMtt60ghXwPQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UphfNXmeljATCUyKiP6rwSwjZg+bB4rTO5+TGm0viOrNOlGlu4A+cXON7UUVxg45h7czvN4kmA3bJKwVYL+rmYtkiEAeGUS1uTWxdfmfBUkYKd0mjzDPqeJE4HSoJknoFj0RuB99T37nHNRa7NXwul4ZjmdVdecU/x0K1ciXa6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H1FbNG/y; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso2177723276.1
        for <linux-rdma@vger.kernel.org>; Thu, 05 Sep 2024 21:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725595404; x=1726200204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3+nQQ3XRSiqnX+Gl79IQZWQG44TA5azeTh4ZjZyJTxY=;
        b=H1FbNG/yv5h9Qx/8nwQI/eoBtk4g4fz7Y0Qc2oZVa3IYHzFHrkxkN5KAELDd959YD5
         PoB+OM6LDBEapDD1VVRql9kNkqeSMaqq5b6smgTfhtP1LXnLvD1fXht1147cKDscNO3N
         Qj0pe9GGHAQPdjF+23kNb1c5gmSMcsypor2qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725595404; x=1726200204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+nQQ3XRSiqnX+Gl79IQZWQG44TA5azeTh4ZjZyJTxY=;
        b=ikW1eUP5ZjDbBY/YoKHLBBHUivyLtprtGPSArRsbT6DbYhkA3jxxdSwMPQLt2ap6Xz
         GzB4vy4sM8i7LBfdhfulAKCwh0a1yCEe/L6wONAFfqpDWKhodh6SESQBKB+KXXHz8I7U
         prUYTafS2ZZ9oYolD0YS9LRM5qhrMCSnLX3+7tPhRIGNxucHLWQGZitZw3BvTPysO1Ig
         xZYjVYDGd9NUDQyck32MHWPNeH98GwEiyDvVpIgqb5agPscM40eS+hYWJsIdQ8v6KqQx
         y0e+dIL7LQ67eqT5BbWiczUW4TzkzJnIiVKnk0Kb6TdNKx9ZcyiXsuQ/yEeft2AeMny4
         2HzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMz+y5EE4k9rxv4dk4b7fDFXiMMBdSbNFDCfafuIM4GogDGTSqC+IILcFSY+4nfSZZe8qQYqrVAkov@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQo/d+tdjhor5tObSSWzbRERqQmThlQDhx1SLf9iBUdjhIdcg
	CiBZScuA92J9K7c/g+lPygqYAeHT9y31+GdjUUes3hjuw8dKUpzesECkuUZRBZ8rD0rmr7iVDzT
	3PlOjNPArUOmPG7p8o7zn+ImMDcAfCaBjf3dA
X-Google-Smtp-Source: AGHT+IFJdq6FTcZ0qb5vnT3zqEM0KHu6M6lQcO6txI5TRcZkTlr25FcLBl2rwI1bG4UubUh8VwrVQLTRmguQfopzZZk=
X-Received: by 2002:a05:6902:15c8:b0:e0b:4cb6:ec53 with SMTP id
 3f1490d57ef6-e1d3425d1d7mr1229560276.3.1725595403604; Thu, 05 Sep 2024
 21:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com>
 <1725363051-19268-2-git-send-email-selvin.xavier@broadcom.com> <20240905102543.GS4026@unreal>
In-Reply-To: <20240905102543.GS4026@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Fri, 6 Sep 2024 09:33:09 +0530
Message-ID: <CA+sbYW2fN8bx1Cx6BSxcwXZ26TGYtVk4h=7JAbR2J+w2j82MPw@mail.gmail.com>
Subject: Re: [PATCH for-next 1/4] RDMA/bnxt_re: Add FW async event support in driver
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, Michael Chan <michael.chan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000157fa506216b7dc2"

--000000000000157fa506216b7dc2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 3:55=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Tue, Sep 03, 2024 at 04:30:48AM -0700, Selvin Xavier wrote:
> > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> >
> > Using the option provided by L2 driver, register for FW Async
> > event. Provide the ulp hook 'ulp_async_notifier' for receiving
> > the events for L2 driver.
> >
> > Async events will be handled in follow on patches.
> >
> > CC: Michael Chan <michael.chan@broadcom.com>
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h       |  1 +
> >  drivers/infiniband/hw/bnxt_re/main.c          | 47 +++++++++++++++++++=
++++++++
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  1 +
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 31 ++++++++++++++++++
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  1 +
> >  5 files changed, 81 insertions(+)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniba=
nd/hw/bnxt_re/bnxt_re.h
> > index 2be9a62..b2ed557 100644
> > --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > @@ -198,6 +198,7 @@ struct bnxt_re_dev {
> >       struct delayed_work dbq_pacing_work;
> >       DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
> >       DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
> > +     unsigned long                   event_bitmap;
> >  };
> >
> >  #define to_bnxt_re_dev(ptr, member)  \
> > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/=
hw/bnxt_re/main.c
> > index 16a84ca..0f86a34 100644
> > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -300,6 +300,20 @@ static void bnxt_re_shutdown(struct auxiliary_devi=
ce *adev)
> >       bnxt_re_dev_uninit(rdev);
> >  }
> >
> > +static void bnxt_re_async_notifier(void *handle, struct hwrm_async_eve=
nt_cmpl *cmpl)
> > +{
> > +     struct bnxt_re_dev *rdev =3D (struct bnxt_re_dev *)handle;
> > +     u32 data1, data2;
> > +     u16 event_id;
> > +
> > +     event_id =3D le16_to_cpu(cmpl->event_id);
> > +     data1 =3D le32_to_cpu(cmpl->event_data1);
> > +     data2 =3D le32_to_cpu(cmpl->event_data2);
> > +
> > +     ibdev_dbg(&rdev->ibdev, "Async event_id =3D %d data1 =3D %d data2=
 =3D %d",
> > +               event_id, data1, data2);
> > +}
> > +
> >  static void bnxt_re_stop_irq(void *handle)
> >  {
> >       struct bnxt_re_dev *rdev =3D (struct bnxt_re_dev *)handle;
> > @@ -358,6 +372,7 @@ static void bnxt_re_start_irq(void *handle, struct =
bnxt_msix_entry *ent)
> >  }
> >
> >  static struct bnxt_ulp_ops bnxt_re_ulp_ops =3D {
> > +     .ulp_async_notifier =3D bnxt_re_async_notifier,
> >       .ulp_irq_stop =3D bnxt_re_stop_irq,
> >       .ulp_irq_restart =3D bnxt_re_start_irq
> >  };
> > @@ -1518,6 +1533,34 @@ static int bnxt_re_setup_qos(struct bnxt_re_dev =
*rdev)
> >       return 0;
> >  }
> >
> > +static void bnxt_re_net_unregister_async_event(struct bnxt_re_dev *rde=
v)
> > +{
> > +     int rc;
> > +
> > +     if (rdev->is_virtfn)
> > +             return;
> > +
> > +     memset(&rdev->event_bitmap, 0, sizeof(rdev->event_bitmap));
> > +     rc =3D bnxt_register_async_events(rdev->en_dev, &rdev->event_bitm=
ap,
> > +                                     ASYNC_EVENT_CMPL_EVENT_ID_DCB_CON=
FIG_CHANGE);
> > +     if (rc)
> > +             ibdev_err(&rdev->ibdev, "Failed to unregister async event=
");
> > +}
> > +
> > +static void bnxt_re_net_register_async_event(struct bnxt_re_dev *rdev)
> > +{
> > +     int rc;
> > +
> > +     if (rdev->is_virtfn)
> > +             return;
> > +
> > +     rdev->event_bitmap |=3D (1 << ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFI=
G_CHANGE);
> > +     rc =3D bnxt_register_async_events(rdev->en_dev, &rdev->event_bitm=
ap,
> > +                                     ASYNC_EVENT_CMPL_EVENT_ID_DCB_CON=
FIG_CHANGE);
> > +     if (rc)
> > +             ibdev_err(&rdev->ibdev, "Failed to unregister async event=
");
> > +}
> > +
> >  static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
> >  {
> >       struct bnxt_en_dev *en_dev =3D rdev->en_dev;
> > @@ -1580,6 +1623,8 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev=
 *rdev)
> >       u8 type;
> >       int rc;
> >
> > +     bnxt_re_net_unregister_async_event(rdev);
> > +
> >       if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
> >               cancel_delayed_work_sync(&rdev->worker);
> >
> > @@ -1776,6 +1821,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *r=
dev)
> >       if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT=
)
> >               hash_init(rdev->srq_hash);
> >
> > +     bnxt_re_net_register_async_event(rdev);
> > +
> >       return 0;
> >  free_sctx:
> >       bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 04a623b3..2c82a2e 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -2787,6 +2787,7 @@ static int bnxt_async_event_process(struct bnxt *=
bp,
> >       }
> >       __bnxt_queue_sp_work(bp);
> >  async_event_process_exit:
> > +     bnxt_ulp_async_events(bp, cmpl);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/ne=
t/ethernet/broadcom/bnxt/bnxt_ulp.c
> > index b9e7d3e..9a55b06 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> > @@ -339,6 +339,37 @@ void bnxt_ulp_irq_restart(struct bnxt *bp, int err=
)
> >       }
> >  }
> >
> > +void bnxt_ulp_async_events(struct bnxt *bp, struct hwrm_async_event_cm=
pl *cmpl)
> > +{
> > +     u16 event_id =3D le16_to_cpu(cmpl->event_id);
> > +     struct bnxt_en_dev *edev =3D bp->edev;
> > +     struct bnxt_ulp_ops *ops;
> > +     struct bnxt_ulp *ulp;
> > +
> > +     if (!bnxt_ulp_registered(edev))
> > +             return;
> > +     ulp =3D edev->ulp_tbl;
> > +
> > +     rcu_read_lock();
> > +
> > +     ops =3D rcu_dereference(ulp->ulp_ops);
> > +     if (!ops || !ops->ulp_async_notifier)
> > +             goto exit_unlock_rcu;
> > +     if (!ulp->async_events_bmap || event_id > ulp->max_async_event_id=
)
> > +             goto exit_unlock_rcu;
> > +
> > +     /* Read max_async_event_id first before testing the bitmap. */
> > +     smp_rmb();
> > +     if (edev->flags & BNXT_EN_FLAG_ULP_STOPPED)
> > +             goto exit_unlock_rcu;
>
> Isn't this racy with bnxt_ulp_stop()?
will review this and get back on this.  There is a possibility though
we haven't seen this in our testing. You can drop this series for now.

>
> > +
> > +     if (test_bit(event_id, ulp->async_events_bmap))
> > +             ops->ulp_async_notifier(ulp->handle, cmpl);
> > +exit_unlock_rcu:
> > +     rcu_read_unlock();
> > +}
> > +EXPORT_SYMBOL(bnxt_ulp_async_events);
> > +
> >  int bnxt_register_async_events(struct bnxt_en_dev *edev,
> >                              unsigned long *events_bmap,
> >                              u16 max_id)
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/ne=
t/ethernet/broadcom/bnxt/bnxt_ulp.h
> > index 4eafe6e..5bba0d7 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
> > @@ -28,6 +28,7 @@ struct bnxt_msix_entry {
> >  };
> >
> >  struct bnxt_ulp_ops {
> > +     void (*ulp_async_notifier)(void *, struct hwrm_async_event_cmpl *=
);
> >       void (*ulp_irq_stop)(void *);
> >       void (*ulp_irq_restart)(void *, struct bnxt_msix_entry *);
> >  };
> > --
> > 2.5.5
> >

--000000000000157fa506216b7dc2
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICgCjDNWZh71
dX3Rbs3UU6ieIx01lV6/4Xz4C5N4FfAjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDkwNjA0MDMyNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCwAmtq3G94zYss2t7Bw54yJKqE+mPc
5baX6tjbqbT/UUaFjys64Si0qfwClVbHBWbEKFJ37xlI4tbcQV12w+gI5kmLPuXXZS379y6mqeoV
m+4qcf1mWXLv3RC6WnW/A7uzrrZJNTwz0dnjoimxUBVuXG7xNS+5K2CY1qoXCs93WIs77Mjmnd67
W0erHAXYeZ2Zf8eU6ELFXJWbSya4HnsfDed8sS/rrQYrkXODPu0GyxSW1ikWCotRNQHquvTPWbE0
Vt/cVhrZN0ksPLKKKuKerTGBDaipDFE1xAxgbsH5UChN6NCRltkP8lW1W3Fo93TN6pdNOslJJ9Fl
NCKzG+ck
--000000000000157fa506216b7dc2--

