Return-Path: <linux-rdma+bounces-15532-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7EBD1ADC3
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 19:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B46213039980
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBCC33DED6;
	Tue, 13 Jan 2026 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bPp5qpTx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE7A34F254
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329417; cv=none; b=CLnAUkNZs5UO09+EB23XmzxwXjxETKpKgl859oUruGL6ZIz+MxTgEL/zEEoPZI05e0Y1RoLTRaik2sY1kpZpdIFunQ39QbPpVv4HADGyUJFa0h+iGrEoB2oQpAfTh7Zeg9iZxxevuOu+f0gG694+8RDw+GdqXHF85WOfCcfV0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329417; c=relaxed/simple;
	bh=CMjO6GLHuO3AFmHmLG7XB65FwvXy+7C1Tf78+IbE/pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSQs7HXsRdpoUJiBMjCT2BVxMU/P3wuO0Z4UUgGirDV1Ie6QYYXgB6yGHTJpZ/wtOhlgsUJq08e4bs6lYpNdG7K/3Hr1tZcwYPNF2lJY3Xiyc5E9G4pWHY9xToPDwcJL0Qd8yObCqX4KpwuOGDlsPGpHA+iAstG+/j4kwsSTWqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bPp5qpTx; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-34c24f4dfb7so4223942a91.0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 10:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768329415; x=1768934215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TT4b9mOTl4nvRm0Bs61xyIxLS9fXFhQ7UKPF7Ov52jk=;
        b=fejfkIr0RQgPREIzrny+8DutZceh3O3vronpunJfKv+diKW8KbC2Sp4Adu3y3iD4rw
         0WiAJo5cFjgisyn7k2gzyhR5dspQ1Y5QMaOINWdGg7RkU6cLiyIkLbFb9XVAevQx2ujC
         +aZECaQ6qxOdVXg0pWWdH9pKEl3LvCgHZsAmSPoGrvM7R7MS7GumEU0VEvA9SeQ1msfj
         XZmngptEKBu+tkv1J21NZzhyCEppo3bzqfV7QgiD+rP32bzZI0aQC7jzrmxOIVUxpm8B
         r2cvvczArybP6TSu0+PHQuqvcewQQWwli0MpfHQuyO50a3qU5ZuwWiuFfsQMPS5St31N
         Q5BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaYlbdamfnpOBq9WYnkPwxrQdO8jd5Td7AnQc2ZKleSmu/hPNbGStL3GIiIMZbDDqsAuGk19Ldirtf@vger.kernel.org
X-Gm-Message-State: AOJu0YwmBldvRWNS5kY8jmphxF+oQFlH6AbE1K18oJA4I/Q7KNsAj5/7
	7pfZRGYDmOyOUeLSEnGgjdEVL6s8ND+OXKYF1L7kVg68TEBZkEV/stUS942gFPc667T6LSU+bg+
	gut+/xip15n5QmUqRbJjdnvS+tTQm0vLCPlwsN5kQb1IRtlqu/o24eVfuT7QAJ98pnBGAbYEv0E
	dsWtOhkxCCTfupyVre5uDxRwOKjimrq5gdi8R3FUS9Gcb6PA3hyWbd8FJYHWnmdhAgwV4YdyAVy
	k6B3xkDojVqro+NSR5WxbFLrwa+
X-Gm-Gg: AY/fxX7thOQXofLiX7w7ZpEPOSK4osByGq7roaoKcCsSTfFCiTww4/C94sP5+9ghNR0
	GrEGRwV6fdGuafCEfCIBAoYShNRbZ9YLWPH+eMej2V0Lkd097GeiyKHH06iJhv7f4f0yqX5IA5e
	MT3xpWmt4sYeZmhRkq/bIbdX3vZgdYPbMZ/na00ltGHpmMEwozZNrHVXSbkOxCe3iZjdYmv7Wam
	D1hvOgC6dIOcIh2UPIH0l5Nj72RokhOqdJspLzbL1xebJXtS/GrQhSmO95pFdMG90EtbxailnH+
	SO70Jt82KcuysxzKihiV/nLE0TOKgWG2Ts3wDpZcxRLW/BEYprKW7FlD0mKwqSCUmNhzBLVLfFw
	R95vywTi2+GcTkJJRfEcOJEtulvPDMxGeX8F2+PBOwCSqLjRo4fPqptaZ/F6LbdFHgVFtIw9isb
	kOYDP/
X-Received: by 2002:a17:90b:2e08:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-351090d745dmr83999a91.12.1768329415315;
        Tue, 13 Jan 2026 10:36:55 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34f5f8f4df1sm3018976a91.4.2026.01.13.10.36.54
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jan 2026 10:36:55 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-432c05971c6so53662f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 10:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768329413; x=1768934213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TT4b9mOTl4nvRm0Bs61xyIxLS9fXFhQ7UKPF7Ov52jk=;
        b=bPp5qpTxtsc8o8Re1gcPSQN0o3+9f0ZumpO19hT/HoYJkqvWZHcYTPqbNgqSLZTmKn
         eNcokvB3mYDao9KCcXB0Id3CaMfVTtmge0haw85XH/Qe7uxXa5rogLGuuSozzNuwfOf9
         MgqR1V8f7KYY0MmAWGru+fLUDsfJXT8S5C0+4=
X-Forwarded-Encrypted: i=1; AJvYcCVLeF7oDNKXNx7yekiG5V5SXmRFTM3/BWbn6YMFG4GSNIyxj0mZlDcfWVam/XdiMrvcLYqeMia5jVlq@vger.kernel.org
X-Received: by 2002:a05:6000:40cc:b0:431:c06:bc82 with SMTP id ffacd0b85a97d-43423e7cf42mr5902142f8f.12.1768329412681;
        Tue, 13 Jan 2026 10:36:52 -0800 (PST)
X-Received: by 2002:a05:6000:40cc:b0:431:c06:bc82 with SMTP id
 ffacd0b85a97d-43423e7cf42mr5902119f8f.12.1768329412280; Tue, 13 Jan 2026
 10:36:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com> <20260113173247.GT745888@ziepe.ca>
In-Reply-To: <20260113173247.GT745888@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 14 Jan 2026 00:06:38 +0530
X-Gm-Features: AZwV_QgVYvfCgBuH6j2nbP5QIAQ6lSIUVtf8zrzfSv3pskTDqw33spYuqqnAZeQ
Message-ID: <CAHHeUGWErNHmhFX13VHw3V6feswyV6JVzULegGoBNg+2x6O12w@mail.gmail.com>
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000083b82f06484946a1"

--00000000000083b82f06484946a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 11:02=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Jan 13, 2026 at 10:39:56PM +0530, Sriharsha Basavapatna wrote:
> > +int bnxt_re_dv_create_qp(struct bnxt_re_dev *rdev, struct ib_udata *ud=
ata,
> > +                      struct ib_qp_init_attr *init_attr,
> > +                      struct bnxt_re_qp *re_qp, struct bnxt_re_qp_req =
*req)
> > +{
> > +     struct bnxt_re_alloc_dbr_obj *dbr_obj =3D NULL;
> > +     struct bnxt_re_cq *send_cq =3D NULL;
> > +     struct bnxt_re_cq *recv_cq =3D NULL;
> > +     struct bnxt_re_qp_resp resp =3D {};
> > +     struct bnxt_re_ucontext *uctx;
> > +     int ret;
> > +
> > +     uctx =3D rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext=
, ib_uctx);
> > +     if (init_attr->send_cq) {
> > +             send_cq =3D container_of(init_attr->send_cq, struct bnxt_=
re_cq, ib_cq);
> > +             re_qp->scq =3D send_cq;
> > +     }
> > +
> > +     if (init_attr->recv_cq) {
> > +             recv_cq =3D container_of(init_attr->recv_cq, struct bnxt_=
re_cq, ib_cq);
> > +             re_qp->rcq =3D recv_cq;
> > +     }
> > +
> > +     re_qp->rdev =3D rdev;
> > +     rcu_read_lock();
> > +     if (req->dpi !=3D uctx->dpi.dpi) {
> > +             dbr_obj =3D bnxt_re_search_for_dpi(rdev, req->dpi);
> > +             if (!dbr_obj) {
> > +                     rcu_read_unlock();
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +     ret =3D bnxt_re_dv_init_qp_attr(re_qp, uctx, init_attr, req, dbr_=
obj);
> > +     rcu_read_unlock();
>
> So now if dbr is racily freed the QP just keeps using it? That doesn't
> make alot of sense.
>
> I think the reason you having problems with your locking here is
> because this is the wrong way to pass a handle to another uverbs
> object.
>
> Pass in the uverbs object ID and use the uverbs object lookup to
> acquire *and lock it*. Then refcount the uobject properly for the qp
> lifecycle so the underlying DBR record cannot be destroyed. Get rid of
> the hash table.
>
> Jason

I thought about it, but couldn't find a lookup function that can use
the ID (idr) passed through a driver specific ABI structure (and not
as a uverbs attribute) and find the corresponding uobject. In this
case I'd have to pass the dbr handle in bnxt_re_qp_req structure
instead of the dpi, and then look it up. Is there an example?
Thanks,
-Harsha

--00000000000083b82f06484946a1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVfQYJKoZIhvcNAQcCoIIVbjCCFWoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLqMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGszCCBJug
AwIBAgIMPiCpKhlPGjqoQ++SMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTQwNVoXDTI3MDYyMTEzNTQwNVowgfIxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEUMBIGA1UEBBMLQmFzYXZhcGF0bmExEjAQBgNVBCoTCVNyaWhhcnNoYTEWMBQGA1UEChMN
QlJPQURDT00gSU5DLjErMCkGA1UEAwwic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNv
bTExMC8GCSqGSIb3DQEJARYic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKS3kXt4zVFK0i5F3y88WV5rV0rr2S3nOVTaCGMB
o6Se8pIb2HJcdpQ4rMiJuIRSyG2XDWv6OB+66eM/6cD2oklFcdzpC4/eYOQFWJ/XM8+ms6HT7P5e
uE7sY6CeUzLzHNjcRwVgZRWlELghY7DIW9fbMzRNDFsbxuIN/7eSofavP1q7PF3+DqhHZpmrVkDu
vcEBTRZSn8NWZ0Xhy4a+Y3KN2W55hh6pWQWO0lt2TtpyaqYp95egJGqDUPtqydci+qrBzXbL05Q0
gcK0NfqGJwLsEVqxHwzz/jRrzKBYKQEK4Bpau91oxVGLmxy1nQDiyI1121xyvsJBDctKH245XZkC
AwEAAaOCAeYwggHiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSB
hjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3Nn
Y2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgw
QgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9y
ZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMy5jcmwwLQYDVR0RBCYwJIEic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJy
b2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3b
oCOFGLCgkjAdBgNVHQ4EFgQU9Dwqof/Zp1ZdK6zi7XdRGdBWQt0wDQYJKoZIhvcNAQELBQADggIB
AKzx/6ognUMhNv+rh7iQOeHdGA7WMDixk+zrD7TZL6O5DPqXfFqaTLpswyruTymA3AVxZkMJyF6D
zOAsRfU23BjVlgC95zl1glr7DorZW7B/CQDwbLHlkFy92Oa3E+gBzwdiDMjnq6tOW5p83zoVqiV4
qm4OwC9JILEkslV4uZVXHPm5cZoOQURTECE2BN34Qhg5qD3EKYqOTeMVRed1qQiIPqQv1b4xjPVS
qBwNPl7/4TJGiZGnRB7FsNnNUQRJONnEFifM3KGqjbqA4F8BhLXCYjqtBxxCGA5506StNfsjT8UU
28E6lcuJXC4hQXau+xXQ5GWqS4ecWwm22FAVy/i8FJVfXPTJnZeixmqaadbIU3fOJs5+XfyNkU2T
mlCafSr7KgV570M6tITSyminW/7rc8hdznGYypCNa+45JYJTaK4x1+Ejptaxc7TCS12B1zQNCxa7
AHX5PZra3SpDb7g1p1i1Ax0JVJTkThiCSNDbiauVn7xIJpf+H8HC6O2ddGmtKUxe6NseFnSGJsi6
7lO/cU+TpduV7w3weUy+nHhp+GsbClfvAGhFAs/GkyONExCwwIEVlFp9Mj5JLAgB+ceMbojBIoaO
d5rOzdIII5FDwKAAqyjHuniYLrP0xIH4L5kWOAy+LudP4PSze7uAxTiCiSJg5AaNBTa5NuwTnSX6
MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEo
MCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMPiCpKhlPGjqoQ++SMA0G
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCWVkjGUiD2yZV84QYRc0LAEUnUlvRrvm0B
AkT4hbZZrDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTMx
ODM2NTNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBofMY3R0tp4aR9TCcOsWJoedPtDoEaZho6+aO1QqTeuKsiur2RpeqZwjWgy7CWmMPgbcaJ
26zAuzN6NtnPL3HQaEchA1tNDWCF2nirznrpTHeKhNbHTgo2ftqQao5UfjjOh3m920Wqdfe/aLJF
SMF4TjgQIkRraFOrdfVAyguh98WQTaGR51SQLup4Kpal/tBQsLWrDw1UsYfxzsO8tXhtNfsD99Yc
EQMkcD8AS13ZWxtGW76nDH3kysDC7mVe1XwWNgEX4WfjFj48yHUch5u5EyoMkoj5whU608faXyME
I+ne5VgQc/lEpwml3wnQy4JC9aGCC60YeRWnPLxkVBiG
--00000000000083b82f06484946a1--

