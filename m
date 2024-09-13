Return-Path: <linux-rdma+bounces-4932-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05274977A60
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 09:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677EF282613
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 07:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253751BBBD5;
	Fri, 13 Sep 2024 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XdtJvuCp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896D1BB6A4
	for <linux-rdma@vger.kernel.org>; Fri, 13 Sep 2024 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214376; cv=none; b=DTTr+mn3z/GD9GLzb/KcQYKDapOGgqE8lHPHFMCZv/0CXwUEhaOnEGmrswDRle3HwoLe7jHNtzpP3Fmjl1FiYygJoRgP18Lq63LG/rGL26F304H64tG5Jsk31Rbmvr0jhsDqFBMv569tdagevixuNTtjiehx5w3ailcpvGR74ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214376; c=relaxed/simple;
	bh=+ADlYSmwOQ82PhK7J/aK6E87eqU1HRD6H1Y5qgnjCj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tECF+0XOXOaJnAmbJ9fmpWuYDrIboYGv2kwQ3Oxfx9n2jkAeOZmmxfk9AvrQRbNR9f48ZWd4cx4vMlIbrfEWsNF07GMHVnTkgTBGb5svgIUWNtLFR5EvXuDojLbSG8yms4SXHY53MqxXNGOlQiJ6jhA0TR2KnqBBV3TM56VeNno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XdtJvuCp; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a90780f6dso1718107276.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 Sep 2024 00:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726214374; x=1726819174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qvRdXY8nMvAED+Ug0sacrYaGuRcHSFsnnjv6L2yStKM=;
        b=XdtJvuCp9ZBbLWCz6k0OlIBWzNQA6RjOW1YnooG+AHyFiCayureLmBCFJyOm6WWiqE
         7EXIispzJHJBxeWSLf6T/vQ7PUZwLkANlJ3s3qZTut7In8P66WCIbgLqo32XgQWy+pvk
         JYEj3lncOvfeI+2UEhVBcqEzHAwbI35S4xc14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726214374; x=1726819174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvRdXY8nMvAED+Ug0sacrYaGuRcHSFsnnjv6L2yStKM=;
        b=pi2uVxNPucBfmwfzfuUBkf682QkfzVayL6co8Z5CCXPyO3Y5IDtcaeYGTQUAfMCXKW
         iCDfXphx3/QrXrp1SQca0sXhkHp4Uj+SyqfAEhrYsy1jvX9oIPrpKW0RV0HILxAyv2yl
         5WCeZdBtTe4eio1QCCkYiLp5Ts5aZNszaV+6Ece6rw9Qd4kIiYOi2zlQANJ7UfaKoBE/
         9rKvkq0eSdFUl2VRNm0Rg2nFuktWzB8f2I5rsFh7uCqByQxjtVPsA1qcFLoVfvG0XtR5
         Ub6wEWC/h3Sfjz4d4inv66At46DUPf+eS14eSPUu9QDzOvthp4dDJRkm/WXKEnIiR6hy
         MS4g==
X-Forwarded-Encrypted: i=1; AJvYcCXTxzCNEjlj027Wf7Zjl8Sw2Sb3cYscr3/9F/pdR9UrCdcADkN41gqwg+uqUAmoCfbsVWCbUasiEE87@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3d7KRZoPapUXQDVcbvOef34M2yOyJLeoLj78pdw8MK/OdqDFG
	1J7LN9+VI8y8+Nh35v6GUyRr2MPAIOm6E3fVj8KOFc1UcDrmIxG+ANwXoT8+oW4oB/FG8fwMw/6
	V3xTQA28caTkWJS2E0A7mGESINDlBxpjdga71
X-Google-Smtp-Source: AGHT+IGjP77e1zEYcE7j0ORpv8riszTmz85OwDPrctbQcGlISujmgraOYwhi9tZlQyvtkjMu2ngHHdiJB31JPYDASac=
X-Received: by 2002:a05:6902:2183:b0:e0b:b85b:b8c3 with SMTP id
 3f1490d57ef6-e1d9dc3deb1mr4851608276.39.1726214373981; Fri, 13 Sep 2024
 00:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1726079379-19272-1-git-send-email-selvin.xavier@broadcom.com>
 <1726079379-19272-5-git-send-email-selvin.xavier@broadcom.com> <cb3ec05b-9c6d-47f1-a4e5-562a30f6f855@linux.dev>
In-Reply-To: <cb3ec05b-9c6d-47f1-a4e5-562a30f6f855@linux.dev>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Fri, 13 Sep 2024 13:29:22 +0530
Message-ID: <CA+sbYW1XNsmHbU5JQ3UTQLF0SDDq8hEBiLqe3fS1J2yrY7+u9Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] RDMA/bnxt_re: synchronize the qp-handle table array
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009816840621fb9ac8"

--0000000000009816840621fb9ac8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 10:00=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> =
wrote:
>
> =E5=9C=A8 2024/9/12 2:29, Selvin Xavier =E5=86=99=E9=81=93:
> > There is a race between the CREQ tasklet and destroy
> > qp when accessing the qp-handle table. There is
> > a chance of reading a valid qp-handle in the
> > CREQ tasklet handler while the QP is already moving
> > ahead with the destruction.
> >
> > Fixing this race by implementing a table-lock to
> > synchronize the access.
> >
> > Fixes: f218d67ef004 ("RDMA/bnxt_re: Allow posting when QPs are in error=
")
> > Fixes: 84cf229f4001 ("RDMA/bnxt_re: Fix the qp table indexing")
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >   drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  5 +++++
> >   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 12 ++++++++----
> >   drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  2 ++
> >   3 files changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infinib=
and/hw/bnxt_re/qplib_fp.c
> > index 42e98e5..5d36216 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> > @@ -1524,12 +1524,15 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res=
 *res,
> >       struct creq_destroy_qp_resp resp =3D {};
> >       struct bnxt_qplib_cmdqmsg msg =3D {};
> >       struct cmdq_destroy_qp req =3D {};
> > +     unsigned long flags;
> >       u32 tbl_indx;
> >       int rc;
> >
> > +     spin_lock_irqsave(&rcfw->tbl_lock, flags);
>
> Because the race occurs between tasklets, spin_lock_bh is enough to this?
You are right. The race occurs in the BH handler.
bnxt_qplib_service_creq , which is scheduled in the tasklet context,
is already using the spin_lock_irqsave for synchronizing this function
with other contexts.  The current code change is with-in this context.
I added this change on top of the current code and used irqsave.

But  I will fix both the spin lock usage and post a v2.

Thanks for the review.

>
> Zhu Yanjun
>
> >       tbl_indx =3D map_qp_id_to_tbl_indx(qp->id, rcfw);
> >       rcfw->qp_tbl[tbl_indx].qp_id =3D BNXT_QPLIB_QP_ID_INVALID;
> >       rcfw->qp_tbl[tbl_indx].qp_handle =3D NULL;
> > +     spin_unlock_irqrestore(&rcfw->tbl_lock, flags);
> >
> >       bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
> >                                CMDQ_BASE_OPCODE_DESTROY_QP,
> > @@ -1540,8 +1543,10 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res =
*res,
> >                               sizeof(resp), 0);
> >       rc =3D bnxt_qplib_rcfw_send_message(rcfw, &msg);
> >       if (rc) {
> > +             spin_lock_irqsave(&rcfw->tbl_lock, flags);
> >               rcfw->qp_tbl[tbl_indx].qp_id =3D qp->id;
> >               rcfw->qp_tbl[tbl_indx].qp_handle =3D qp;
> > +             spin_unlock_irqrestore(&rcfw->tbl_lock, flags);
> >               return rc;
> >       }
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infin=
iband/hw/bnxt_re/qplib_rcfw.c
> > index 3ffaef0c..993c356 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > @@ -637,17 +637,21 @@ static int bnxt_qplib_process_qp_event(struct bnx=
t_qplib_rcfw *rcfw,
> >       case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
> >               err_event =3D (struct creq_qp_error_notification *)qp_eve=
nt;
> >               qp_id =3D le32_to_cpu(err_event->xid);
> > +             spin_lock(&rcfw->tbl_lock);
> >               tbl_indx =3D map_qp_id_to_tbl_indx(qp_id, rcfw);
> >               qp =3D rcfw->qp_tbl[tbl_indx].qp_handle;
> > +             if (!qp) {
> > +                     spin_unlock(&rcfw->tbl_lock);
> > +                     break;
> > +             }
> > +             bnxt_qplib_mark_qp_error(qp);
> > +             rc =3D rcfw->creq.aeq_handler(rcfw, qp_event, qp);
> > +             spin_unlock(&rcfw->tbl_lock);
> >               dev_dbg(&pdev->dev, "Received QP error notification\n");
> >               dev_dbg(&pdev->dev,
> >                       "qpid 0x%x, req_err=3D0x%x, resp_err=3D0x%x\n",
> >                       qp_id, err_event->req_err_state_reason,
> >                       err_event->res_err_state_reason);
> > -             if (!qp)
> > -                     break;
> > -             bnxt_qplib_mark_qp_error(qp);
> > -             rc =3D rcfw->creq.aeq_handler(rcfw, qp_event, qp);
> >               break;
> >       default:
> >               /*
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infin=
iband/hw/bnxt_re/qplib_rcfw.h
> > index 45996e6..07779ae 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > @@ -224,6 +224,8 @@ struct bnxt_qplib_rcfw {
> >       struct bnxt_qplib_crsqe         *crsqe_tbl;
> >       int qp_tbl_size;
> >       struct bnxt_qplib_qp_node *qp_tbl;
> > +     /* To synchronize the qp-handle hash table */
> > +     spinlock_t                      tbl_lock;
> >       u64 oos_prev;
> >       u32 init_oos_stats;
> >       u32 cmdq_depth;
>

--0000000000009816840621fb9ac8
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICM4sJXQuQPc
imItP+u/H+BPfoKaCk7zRG5vSpyJGbnwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDkxMzA3NTkzNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBHZl2PePxS9unGVzU2trCnmmHY6x6j
W6DxGM5trgU4v1YEXIe2x5VFubwJkO4nrCTz23q7AoDJ/eTaygRlq+vYQbA9w+7rYbZbx2o5m1mv
cZTFaPwsImdvrnDRRwFff64AG/0C9UKhRsT1/PBqV/0+P4oEUIZtNjuN/d8EXh2k8noX5AQ2SLgl
Gc+3+ZrBw3KIfwbwh8YwhVWW3n7pKww4X126MpTe4KdssOxXT5DMwVFk/ZD8hq/cQqY52MbZF4cU
+MmssIO14fyXAatkT5AHqIVEUregsu2DouRKeoZJ6bTQ3l6xZfDqsZUrgPcamsTA3aN7MPAoI2sy
CCC3/vw+
--0000000000009816840621fb9ac8--

