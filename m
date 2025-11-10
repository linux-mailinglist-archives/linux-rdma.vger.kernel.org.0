Return-Path: <linux-rdma+bounces-14359-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7370C4757C
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 15:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BBDF349D4E
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B42314B6B;
	Mon, 10 Nov 2025 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SOuYQzus"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC2313E21
	for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786203; cv=none; b=ByaoSWY57rfoTlTeNRIc56E3QBQYznzpfsrTbVnwIsnUC33mZ04gy5egVtenxkCv4MqAxsRgGOvCB3dtSEw+WTrWOrP7D2GdJzsmuLVg84u/XGsCGmGJpd35+Y+aioDXSfAhqz7KFw+0jTqbE+Def14ebCWfdOb3qWkjGvPfi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786203; c=relaxed/simple;
	bh=Qe28yt/JbhTqU1tybdhgjR2w9n80qVEDS8P47ngLyU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liP9VASeQV5VkHPZv5Cw0SlakqwcdIhue9GCjlN4zbFO0aoHHZzOFhEK8FpROsXcNe5QsKI9HC/yGO6EyrsCQUrrnEujhNpFxzWt/61IEoKpOUKe9ezcm3qGiIm/929F01J1p4k+1ERjJiUwIV7xBa3xk7n6lzGMhn9sHr9eytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SOuYQzus; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-880570bdef8so35819996d6.3
        for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 06:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786200; x=1763391000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTUr8SEpXWvcIJ4UkgoXqvGoxps8kih5EFaKtH+0NjA=;
        b=PZ040H+RyUhRzjWdxROmpD1XI3DuLVLSF+jrztcvd0MGkwH3ZISSC7Cfx53u8Z/C3B
         +GOYjoBDGuTPGtW/pcmzTYef4AZfUB/mZhNhs48anVSdftxbC1KGDasD8UIlihLXMEGU
         opzBUV2irwe7YgxtK/AxUii5xdwgUvr1zqd8l0z5+HJ5euPdSpVsOgIRjhikiBHi5xUR
         wq5NAyJGQf13XWwYwG/Eg+l173CLSJqodfw5fB/JkDnx5UXxeyM3wac1bwjMkEnftSVS
         knvsdaR1qvYM0ZGvSoqZMkeu5l5nnTY+7zavKK6BJbeOKEHU67zhS2CLKdtyO6+6BSPz
         W7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUH07+KpvkANbOd3tN1vIk9HDSzxTrmgbeZfpI9mszybK6CmCZRr3UKpagFlDvLiF7rwgGdOpLe7xX8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjy7TLj+ESouPwOJPAts7Nm4MKZvOcWVDgOUgfb9WYKLuKMs72
	UAMZpsUTi6/zEU/Nj/0uLWsGB+o5jWTAnSoZADBg3IG4G70N1HHOv6XVu99V/rw4c/EUoHSRHJ1
	34FfFhbhlrA1QgMawniD2Rn+zyqO1yRIwS0VEX7QMFLP9/XIJelyZJ1BKnhWnRilC8rQz+zsLG9
	G+zbUVPiqOQqko6B3hAJK/3cSo6/ygkaIOZpb4cV3yjxEaxs2q+9QJ7THhUDKXKuqjOBZ9hKy+2
	y9bU8xVvssAyKqeXYQl6kcSt0i2
X-Gm-Gg: ASbGncurO39x3AGdDADw8wEZvrrniYyrZnPzHpvflB0O71SNY6Ogd9uWuUBdMGfZ20t
	iLR5SLzAAPZmSMxscI/LPirMIBLylc8TAft+OESWYlkAPq5qYhwfiZ/TixX5uIW380jdgo5Z0TK
	d+6sDk1LJBI+6tlGFl20O9DyTRgv5JFfdxqGBFCprSa73FxbJNyL/ymrmLFcW7Gi0+wchOPldOh
	nlvEzFCF7a3buocQS4DyBzo3H6sofT/OXauvJtkVyl2lm0jTdIA9g0m9cwnfHTP7gntISSk0HHz
	6l3V8bstOTz8Xqz2qSjnyEzJRxnCvISwcQENwmgw7CoZ1f0odplH1LEt/kF59KL8jX0MG0cG1hd
	TiwH0t2FPROhzNf9sqpyOz5uAXU48txguab41c/fMilCzr/o/PIIdBFGzcqUEhZCsKYr0w4EfvB
	5/dkxZIjHEQhZvxdQbqCWq0S0qNgwgkiO3uu4EsxWq7D+Vyw==
X-Google-Smtp-Source: AGHT+IHD/YlKl9wYTNKUJv/kOV9AkIUKhOYvlMNu9yRa/9sGZG4bW2Yz3UxUxO9GHEQBXpASvVq39AUN7rtF
X-Received: by 2002:a05:6214:c66:b0:880:6263:fe5a with SMTP id 6a1803df08f44-882385be823mr123367796d6.6.1762786199852;
        Mon, 10 Nov 2025 06:49:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88238998846sm9181856d6.13.2025.11.10.06.49.59
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:49:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b2ffbba05so841803f8f.0
        for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 06:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762786198; x=1763390998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vTUr8SEpXWvcIJ4UkgoXqvGoxps8kih5EFaKtH+0NjA=;
        b=SOuYQzusuw5vKmbt49hVDItQhcvYRbBVPAwyaCnfGap/Ckj6D1xUZYmkSjSXl3t1aC
         0OJM7ptZqZVatFRvIT73Ghz5ptTtLLCBa8tz7iDLOaJizYMQwZHAEG3n/AEsw/O14pQf
         uUsQAKJaz7CAOOeT2iJgHupPY3Gy1wIq+cyY0=
X-Forwarded-Encrypted: i=1; AJvYcCWBeaif2UMDfoT9sOmgEHO3zGXtt50noAGGxEGURq9X3Q8BJSpMM84n0Lm5ck+1c66UnJCHJFsbgoQ+@vger.kernel.org
X-Received: by 2002:a5d:5847:0:b0:427:6c6:4e31 with SMTP id ffacd0b85a97d-42b2dbf1088mr6890303f8f.22.1762786198196;
        Mon, 10 Nov 2025 06:49:58 -0800 (PST)
X-Received: by 2002:a5d:5847:0:b0:427:6c6:4e31 with SMTP id
 ffacd0b85a97d-42b2dbf1088mr6890272f8f.22.1762786197794; Mon, 10 Nov 2025
 06:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104072320.210596-1-sriharsha.basavapatna@broadcom.com>
 <20251104072320.210596-3-sriharsha.basavapatna@broadcom.com> <20251109092143.GG15456@unreal>
In-Reply-To: <20251109092143.GG15456@unreal>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Mon, 10 Nov 2025 20:19:45 +0530
X-Gm-Features: AWmQ_bnsrI9GBmyDKNEeHME1z-HBP3Wef2JFf4G0KH7I9Fd5kUQUQYwl9s_wW7k
Message-ID: <CAHHeUGUtZ9b_sSW6Nsfca8Vj_zrVGKgK8eKg+MD+_NbCM6HWzg@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2 2/4] RDMA/bnxt_re: Refactor
 bnxt_qplib_create_qp() function
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000301d9006433ea56a"

--000000000000301d9006433ea56a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 2:51=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Tue, Nov 04, 2025 at 12:53:18PM +0530, Sriharsha Basavapatna wrote:
> > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> >
> > Inside bnxt_qplib_create_qp(), driver currently is doing
> > a lot of things like allocating HWQ memory for SQ/RQ/ORRQ/IRRQ,
> > initializing few of qplib_qp fields etc.
> >
> > Refactored the code such that all memory allocation for HWQs
> > have been moved to bnxt_re_init_qp_attr() function and inside
> > bnxt_qplib_create_qp() function just initialize the request
> > structure and issue the HWRM command to firmware.
> >
> > Introduced couple of new functions bnxt_re_setup_qp_hwqs() and
> > bnxt_re_setup_qp_swqs() moved the hwq and swq memory allocation
> > logic there.
> >
> > This patch also introduces a change to store the PD id in
> > bnxt_qplib_qp. Instead of keeping a pointer to "struct
> > bnxt_qplib_pd", store PD id directly in "struct bnxt_qplib_qp".
> > This change is needed for a subsequent change in this patch
> > series. This PD ID value will be used in new DV implementation
> > for create_qp(). There is no functional change.
> >
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Reviewed-by: Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>
> > Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.co=
m>
> > ---
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 207 ++++++++++++--
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 311 +++++++---------------
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  10 +-
> >  drivers/infiniband/hw/bnxt_re/qplib_res.h |   6 +
> >  4 files changed, 304 insertions(+), 230 deletions(-)
>
> <...>
>
> > +free_umem:
> > +     if (uctx)
> > +             bnxt_re_qp_free_umem(qp);
>
> <...>
>
> > +     if (udata)
> > +             bnxt_re_qp_free_umem(qp);
>
> <...>
>
> Do you need to have if (..) here?
> ib_umem_release() does nothing if pointer is NULL.
Agreed, no need to have that if() check.
>
>
> > +     kfree(sq->swq);
> > +     sq->swq =3D NULL;
>
> Is this SQ reused?
SQ is not reused after this clean up, no need to reset the pointer,
will delete that line.
>
> > +     return rc;
> > +}
>
> <...>
>
> >  struct bnxt_qplib_qp {
> > -     struct bnxt_qplib_pd            *pd;
> > +     u32                             pd_id;
> >       struct bnxt_qplib_dpi           *dpi;
> >       struct bnxt_qplib_chip_ctx      *cctx;
> >       u64                             qp_handle;
> > @@ -279,6 +279,7 @@ struct bnxt_qplib_qp {
> >       u8                              wqe_mode;
> >       u8                              state;
> >       u8                              cur_qp_state;
> > +     u8                              is_user;
>
> This is already known to IB/core, use rdma_is_kernel_res().
This one is used in the qplib (fw interface) layer in the driver where
we don't have the ib context, so I'd prefer to retain it.
Thanks,
-Harsha
>
> Thanks

--000000000000301d9006433ea56a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCilCQ7AP6yKlAGFHq+y4r8JfFmHfo6AzXI
qmzlcClR7TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTExMTAx
NDQ5NThaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBMosGmRMh/nr+xNt6XUVkxfJSzlEXYl0c4B2WYv6ckXEuvenbrux+wKlYHV78B/fSmLhdi
8TJpadLLWrzHzwTMXWtKSn+1cnUSCrACK9jomg2mGdhRoJ3oqfHpL44SeBApRP34CcP+EVeP5Zgg
10VKfpVhfi/AhvP4Ogg1Rw3Phiydzv9nAnkQXpSgLDe1BqB0VROtg4F4BVDKKYNv8/HkauuT+qWR
c9U67JYnD6nzK/KJWEN6TNq4MFAYxzjx98qZkyieZpHfpZc0AOaDPzRnf6lS/uyKaHPX/Dy/QRxo
hezhONMK1VfiFgek32vxh7IbTr+WQfm4Ne9mtly5MsdI
--000000000000301d9006433ea56a--

