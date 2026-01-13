Return-Path: <linux-rdma+bounces-15523-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA081D1A8F1
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 18:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51FA7300F040
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F4C350A2A;
	Tue, 13 Jan 2026 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dUdYHi5C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC29350A25
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324541; cv=none; b=tLFUP36blmgK+MlpzIqD5lgYDk6W0A9q8JYtbMMWg7jl5d469T9pPKtwRaxg+Ek2ev2Ckzq8csmEVS9GBoIVB8IRpdrwjOWzqpML0NPm6+OwLgQPumV334cKFZ3lKLFZ26HQhXoMoZRL6jsiBJbSwFSj5r29HbM7KN+PD3n8R+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324541; c=relaxed/simple;
	bh=+2zI4rMYPedOI+Tyj7M8TGAQ7oven07ggmx2FncndeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wlj9ewnTmMkSadK+jGX+ZqLxqx2qckHy5qi9QFH1d8oqYaCnHzq6mbTQ5TndAgXIa80kvTJuVzBC9eR59+ibtWR8TikR0deddThMaaC06DHmjiWOxfdYzNRARN/G9uWdxVReLi0a0zUc5x658I2jzNlycXRsW5iacN7ykCTzX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dUdYHi5C; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-560227999d2so2687976e0c.1
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768324538; x=1768929338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WQB9/KQZzfIKYhVa+LwHyKhmluf+Js5l3VEKHKWRv0=;
        b=biQKygg5sLerbyfPVAb/h86LVypHH+g+GO0conzIJfmpD63RXNvQElacXrTuI3nO2p
         sv2ultdybRviHt2B03CTgEaBjebvHg2necUbmXIMPCykL20YOmXd56hd0kJU+YGT39jC
         3/0DuLNmSPLH+WAd45egaKHt2Xmhp/720GNXUw4+DnUubYE5SzAY+P1WRzf4POM5+42C
         N7r6IzmJNmOzCYWguxXyZp1LNuWKU5mJCRXXe8un1a5MHfWN8evJBAFBE6Zlf3hjSC8o
         eI3/+PmkMGyS7URpPjWO4szDOWAKnuaRYP1KabeQbMDf2+rdHdMAaN5Kes3g39GtwT9U
         geyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtMGj9bo9EQZwoczq4sFyAiCd7YfUx2TW9n4UFPTXjqmxbsSRyBLv1bkxX2Lx3Z5HFStaJ/wp+5bQR@vger.kernel.org
X-Gm-Message-State: AOJu0YzKHcGpzZUKI76iM0ZwhA1sFbb0AHZ7en7jJmWsQv/9pMNvL59u
	yFnckDoaJCS+ymxpVW/MZ0rz8xL5VDrkct+BDEpqmbA8atrgyZXIAFDvFszDXcVJd4t1BADzOxC
	efgKIGr8sqG6RiKg2q+atGdzcuKRJFZLbALNC+FoGHLljiecoxa6P9N5SVd/S6+hbAGf8cgQ3Bm
	FIGGKPrzd50Y3f2oX8s2PWHMew9cBVT47Ri0wmyrfyg/8gzwhAkxbtIX1TTscrFLhQvF3jikI4e
	pF5CTeF/RufBbEgHQAvEtMcXmNv
X-Gm-Gg: AY/fxX6yULI1HmToNzWPbcKQe4UL+07uW3JQgVwwBICE33l7YmPEmK1oOkPbNvXs4ZO
	znWoHVRPvoUjao96DrNrZgiIIKUydklHtvRHbt4CV+GAK5VSx35G2jBY4tJ+BI4WSpO3+4Q9fhC
	MOl4tbeeDWs4fERq6mDqT8j6aaD1nfjigYXS7fem9rpD5dERGJXZJITNs4ZTeXfiyZeTkoDgvas
	mrM1pIeY7DK8g95xayNwDojeLMi1GDmZsIcSNMekOo0hH4ni/jTsbltV0VhHiOtCbNHJUUNpT3u
	6+ttZm/OAwDxvRrQo7jtESGdQ1yuuH7QviHTb/qF3g3rwt+t0961x1kcuftfZkSthLMMDJU9LPK
	HNjptTz5g05vm2gOQgcPdgS0oNb7+dbYHluYYVyuU09g5ClRFBnXHevfrQ0vxOAOu/rTahwBoGo
	3TlauDQONsA1fFV/j6MEiuhHdMJOSdtot35SFj8+WUz/XUXNFKRQ9crg==
X-Google-Smtp-Source: AGHT+IGZb0PpgHvoxTtKGmHz2s2Ke0mRfaWt6eJAALd0Xl6KM3QIckB+vDRAovVh9NLbHrNtFIXCQlwx0blj
X-Received: by 2002:a05:6122:4909:b0:55b:9c3f:55f with SMTP id 71dfb90a1353d-56348006892mr8327078e0c.18.1768324537059;
        Tue, 13 Jan 2026 09:15:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56379a57e3dsm1254195e0c.3.2026.01.13.09.15.36
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jan 2026 09:15:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430f57cd2caso6135848f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768324535; x=1768929335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1WQB9/KQZzfIKYhVa+LwHyKhmluf+Js5l3VEKHKWRv0=;
        b=dUdYHi5CaQCARA1eJvMUSkzBYFxEW+k325AqpU70qaWx7h+nyaA5Tmm7QWaDWF0klZ
         MUv5cmtaLAsMybwqBA7ugMCLhFrLUCXLUX/bc8FBThBPCMwAi8UCdX653UwaxugDj6J/
         KxwEKDSlzBK4VQ8u0iwdfi22I2WGs2NiT911M=
X-Forwarded-Encrypted: i=1; AJvYcCWbQTpqmt/NUIsXJzGCykpiv3sRx6XefS3+O2cIjOSevPztlJAVoSgjHKI0a+rUK04nVSerMDzdZN3W@vger.kernel.org
X-Received: by 2002:a05:6000:2504:b0:432:aa5a:3916 with SMTP id ffacd0b85a97d-432c37950b7mr30335132f8f.40.1768324535496;
        Tue, 13 Jan 2026 09:15:35 -0800 (PST)
X-Received: by 2002:a05:6000:2504:b0:432:aa5a:3916 with SMTP id
 ffacd0b85a97d-432c37950b7mr30335098f8f.40.1768324535112; Tue, 13 Jan 2026
 09:15:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224042602.56255-1-sriharsha.basavapatna@broadcom.com>
 <20251224042602.56255-5-sriharsha.basavapatna@broadcom.com> <20260109193756.GP545276@ziepe.ca>
In-Reply-To: <20260109193756.GP545276@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 13 Jan 2026 22:45:22 +0530
X-Gm-Features: AZwV_Qh8E-MutqdjqCFfSTSKnonfovyH_okFAKRgZweCd173KqY__oIITCqHFFo
Message-ID: <CAHHeUGWH6hujdXP6OheW-fFLLJ5WGjiJgcP41MYHC6sBZE+xbQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next v6 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ce83ee064848233d"

--000000000000ce83ee064848233d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 1:07=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Wed, Dec 24, 2025 at 09:56:02AM +0530, Sriharsha Basavapatna wrote:
> > +static int bnxt_re_dv_create_qplib_cq(struct bnxt_re_dev *rdev,
> > +                                   struct bnxt_re_ucontext *re_uctx,
> > +                                   struct bnxt_re_cq *cq,
> > +                                   struct bnxt_re_cq_req *req)
> > +{
> > +     struct bnxt_qplib_dev_attr *dev_attr =3D rdev->dev_attr;
> > +     struct bnxt_qplib_cq *qplcq;
> > +     struct ib_umem *umem;
> > +     u32 cqe =3D req->ncqe;
> > +     u32 max_active_cqs;
> > +     int rc =3D -EINVAL;
> > +
> > +     if (atomic_read(&rdev->stats.res.cq_count) >=3D dev_attr->max_cq)=
 {
> > +             ibdev_dbg(&rdev->ibdev, "Create CQ failed - max exceeded(=
CQs)");
> > +             return rc;
> > +     }
>
> This is a racy way to use atomics, this should be an
> atomic_inc_return, then check the return code, doing a dec on all
> error paths.
Ack.
>
> > +static void bnxt_re_dv_init_ib_cq(struct bnxt_re_dev *rdev,
> > +                               struct bnxt_re_cq *re_cq)
> > +{
> > +     struct ib_cq *ib_cq;
> > +
> > +     ib_cq =3D &re_cq->ib_cq;
> > +     ib_cq->device =3D &rdev->ibdev;
>
>
> > +     ib_cq->uobject =3D NULL;
> > +     ib_cq->comp_handler  =3D NULL;
> > +     ib_cq->event_handler =3D NULL;
> > +     atomic_set(&ib_cq->usecnt, 0);
> > +}
>
> All these should already be 0 since this was freshly zallocated, no?
This function is not needed, deleted (design changed from direct
uverbs to driver specific uverbs extension).
>
> > +int bnxt_re_dv_create_cq(struct bnxt_re_dev *rdev, struct ib_udata *ud=
ata,
> > +                      struct bnxt_re_cq *re_cq, struct bnxt_re_cq_req =
*req)
> > +{
> > +     struct bnxt_re_ucontext *re_uctx =3D
> > +             rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext,=
 ib_uctx);
> > +     struct bnxt_re_cq_resp resp =3D {};
> > +     int ret;
> > +
> > +     ret =3D bnxt_re_dv_create_qplib_cq(rdev, re_uctx, re_cq, req);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D bnxt_re_dv_create_cq_resp(rdev, re_cq, &resp);
> > +     if (ret)
> > +             goto fail_resp;
> > +
> > +     ret =3D ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->o=
utlen));
> > +     if (ret)
> > +             goto fail_resp;
> > +
> > +     bnxt_re_dv_init_ib_cq(rdev, re_cq);
> > +     re_cq->is_dv_cq =3D true;
> > +     atomic_inc(&rdev->dv_cq_count);
> > +     return 0;
> > +
> > +fail_resp:
> > +     bnxt_qplib_destroy_cq(&rdev->qplib_res, &re_cq->qplib_cq);
> > +     bnxt_re_put_nq(rdev, re_cq->qplib_cq.nq);
> > +     ib_umem_release(re_cq->umem);
>
> This seems really weird error unwinding, I expect to see functions
> with error unwinds that match the calls within the function.
>
> So why doesn't bnxt_qplib_destroy_cq() do the umem release and
> req_put_nq?
Because bnxt_qplib_destroy_cq() deals with only the FW side and the
wrapper function bnxt_re_dv_create_qplib_cq() calls umem_get() and
get_nq().
Thanks,
-Harsha
>
> Jason

--000000000000ce83ee064848233d
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBP49Pzsl6iz0wFMdzIB/x9Hcl7EzJkIm86
npyjJRIC/TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTMx
NzE1MzVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBImE0927VaYF71CYHBw/cga4ndwh2O7++oClPIUwyX/iBvQCCUGJG5uCLS3F974q9mMeiv
O/S4B5ZNS1PWjvmZ4BKnuMPa9bmc8EZVm/2JpPzNfbuzpPLi8p8d7TpLzF7lfIszII0Nl8xYwqfw
lYh44EMkhdQYu8iWBXXhtqc0zrqDiqCLPGajhiJNR60IC4qExiFiPoMm/ovDsZ0sj/za7pBnwU4O
VEMyy08vSXpaD9x5uFMW1EZmdP9Pyo8d6CpOTIR6c6st2KFoUuSPfqNdmwtMJtwexATYISqi3t7w
IXRqvC4pMqWzri5aJcmKqqOaWahvhsHzEIR+nG5EPOyG
--000000000000ce83ee064848233d--

