Return-Path: <linux-rdma+bounces-14619-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19065C701AE
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 17:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0BED34BBF3
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 16:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F60F32FA1D;
	Wed, 19 Nov 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nb4ZyBuZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3D327BE9
	for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568869; cv=none; b=YJ6JnPHOqRr+In3BznBhhu5wGXgVG0O39Ls7toBo/9H1CCCTnbRyOZlWX0oZhGl8UhMWTa1qYhDWE/0UIq4PhpAXKrCvr6WBa7nP+R98XCRglckkqN8ydYdqBx2sCygkIK21zyz0iKAWr717Tf/cJEdCTiKJY9rc8VlSFcDcr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568869; c=relaxed/simple;
	bh=o6ezhvTMX0TDDRB1mF5siSvSILmzV6twnzB783zY1zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAcwAt6ms12FBOnjCDhD6GShz15YbxDTJGyKPRp6dH3HRcPe87QAkeireuv0vfUnM2k3Jpb8EGemDXgBXFQBrglNglTukqqFJpiX3TsjhFc/WRgTZBzX0dyU6bP+HQ9Mpm6oMh2aPWbcrq72Ub3eZEkDCie6RU5l2xx3CIzqwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nb4ZyBuZ; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7c6e815310aso3924399a34.0
        for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 08:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763568867; x=1764173667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBeftxPhxPO/vWlWJze166tYrfk7L9hOrgA+dq6w7M4=;
        b=LArwBgynkLUiuhJEOypTHFp645VTvcC9p5+Aueq9C8mBVM+xwz7mzunzNf/39i55Lq
         gzMVh9ks8Pt6nEdTpQTzSkm7nyLAFqmgJbpw+ByG6lY2SATadJc+zDbmLkftiidYEs8x
         fMLDJRb5ah1X6XY0Q5zvSse+f+LbZNOXiHGIMw6U4GfnU0u+l8rRSaBmwCezfNljq79i
         X9YR2cAShNdJVfFfmJ4S03tbe3a7upfXYZlMycdtQecCf534npWjvb+/0PMOF1WihNqb
         mJ+j1y++9n0dRV5t3XdIDoq9V7g+Y6tKf6HjOeWgvB/OqhT+6Lvz80/IYVfCRDreqDKe
         OccQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMO/lm4bitPWp3mgt6GiMF8Q7QG5NQiW6p3CaxnKUtYDqNsDRRjbtRKeNiDcVW9Xb8J84eo2OTTt68@vger.kernel.org
X-Gm-Message-State: AOJu0YzGAmW3rxrY+VU8VQ3KfFYQcz01CNkinCQBh4ZvjFkQ7sYYPhgU
	6RdyBpvAfHWd3rkN0mJY3S/qzXn30Tt5w+JIxdNPJ0hteqlCwg3yTZMGaddKGuZVYT8EQvHucZB
	wcmrWl/el4FoVy868ZALHLwwsZl5vKh/aD3zyaSUTR1aF4z+hXhdJSC6uC8BURAKjMArfKILfP6
	vKLn3p3ph5kF+FCTTYgu3GND3Xplda1hfKhn1IUcWw07XoDg+96BWXDaBPgh0oHIQT9s+pgs4Xc
	+WqvLpU4eZFXZDNNVJHuFCIZEyU
X-Gm-Gg: ASbGnctFmBcCRCrdUGchXNg0Cki2AQzk7QkMpzwYaFMYQctMs+7hG2559SKJevhlud2
	vNqAzQL5nctdJFNdfsnS+CcI9stgjrFrWsCjRShVFf17stSwHfxFRdZkg2TXixGBa+Ie0ds1Xbi
	uRoXSqlhlKV/fslglgyBh1MDk3NgDhTpU54YrStb6IzcnXivwyQLGR2W4M1TWpD1QnW3v/C1yvu
	3FxJG34aO8QRX9zse2Jbas76Hm/9AxR0R9pxL/DLPmOxWhSsQMMIaKPJs16dlfUSJtZAOULtu66
	awk0qQDE3yfklvX+ttZnqWKj2V9awzCS9KWv12CalQDvDffEsWFCXoAY5rzgxO60qVcgvd8McKn
	M0Pqzrvxjqxmx1jcd0L2trEX6KQnU4ycP0CMsuN9DX0dcAiJuPEuA5T8xungJdwJQo/mP2wz6aq
	XM9bhHDy9TgNB99eCp4eaYroPo+khkE9gUF+Ba+VUpPBrI0gTknGg2mwb5
X-Google-Smtp-Source: AGHT+IHhhYPAWMJfz44bks8/jpK3wgJy2gkNzLSxuzvKTjeTVOyvwwzxY9251qzxmoYElYIrDqxye9DYiM9n
X-Received: by 2002:a05:6830:3153:b0:7c5:2c10:b6b8 with SMTP id 46e09a7af769-7c7442ca64amr10553707a34.2.1763568866686;
        Wed, 19 Nov 2025 08:14:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7c73a324d05sm2019643a34.3.2025.11.19.08.14.26
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Nov 2025 08:14:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-295595cd102so153634075ad.3
        for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 08:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763568865; x=1764173665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CBeftxPhxPO/vWlWJze166tYrfk7L9hOrgA+dq6w7M4=;
        b=Nb4ZyBuZvZDGpNRQgUMXvxY+oBvouT1s2swbnaNFwcEtRWbO878Nd+7Q5w0q2dzvJY
         qO4gAEguntU30xWHtG3YEkTxIT4X1M7pFg6LhEgoTqyco/tdDn4qKo5PmmJ4VkQcG+gh
         Xha25L9mekZ7kIHW1kELAPNUdSp5aJAhEDCW4=
X-Forwarded-Encrypted: i=1; AJvYcCUzbKSkAmcymTHOqF2uzZrIyOiYjqlLvNDnGAsbmWlQKrtVNeaPtRcgnedsZx9y9uszzaf2MtgNVp+O@vger.kernel.org
X-Received: by 2002:a17:902:f705:b0:295:9871:81dd with SMTP id d9443c01a7336-2986a6f3f40mr238944225ad.25.1763568865246;
        Wed, 19 Nov 2025 08:14:25 -0800 (PST)
X-Received: by 2002:a17:902:f705:b0:295:9871:81dd with SMTP id
 d9443c01a7336-2986a6f3f40mr238943915ad.25.1763568864752; Wed, 19 Nov 2025
 08:14:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104072320.210596-1-sriharsha.basavapatna@broadcom.com>
 <20251104072320.210596-5-sriharsha.basavapatna@broadcom.com> <20251117173352.GC17968@ziepe.ca>
In-Reply-To: <20251117173352.GC17968@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 19 Nov 2025 21:44:09 +0530
X-Gm-Features: AWmQ_bnNeSuHlXMq_3pDs6vOcMrQSiTTVtotnaKIxJeBUhmzr31WMyHGX4R-g5c
Message-ID: <CAHHeUGXGTfsK66DOGdE6Y5VYVaOR=1YA6b2inds6_EkPSwTBuA@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c586fe0643f4df5a"

--000000000000c586fe0643f4df5a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 11:03=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Nov 04, 2025 at 12:53:20PM +0530, Sriharsha Basavapatna wrote:
> > The following Direct Verb (DV) methods have been implemented in
> > this patch.
> >
> > CQ Direct Verbs:
> > ----------------
> > - BNXT_RE_METHOD_DV_CREATE_CQ:
> >   Create a CQ of requested size (cqe). The application must have
> >   already registered this memory with the driver using DV_UMEM_REG.
> >   The CQ umem-handle and umem-offset are passed to the driver. The
> >   driver now maps/pins the CQ user memory and registers it with the
> >   hardware. The driver returns a CQ-handle to the application.
> >
> > - BNXT_RE_METHOD_DV_DESTROY_CQ:
> >   Destroy the DV_CQ specified by the CQ-handle; unmap the user memory.
> >
> > QP Direct Verbs:
> > ----------------
> > - BNXT_RE_METHOD_DV_CREATE_QP:
> >   Create a QP using specified params (struct bnxt_re_dv_create_qp_req).
> >   The application must have already registered SQ/RQ memory with the
> >   driver using DV_UMEM_REG. The SQ/RQ umem-handle and umem-offset are
> >   passed to the driver. The driver now maps/pins the SQ/RQ user memory
> >   and registers it with the hardware. The driver returns a QP-handle to
> >   the application.
> >
> > - BNXT_RE_METHOD_DV_DESTROY_QP:
> >   Destroy the DV_QP specified by the QP-handle; unmap SQ/RQ user memory=
.
> >
> > - BNXT_RE_METHOD_DV_MODIFY_QP:
> >   Modify QP attributes for the DV_QP specified by the QP-handle;
> >   wrapper functions have been implemented to resolve dmac/smac using
> >   rdma_resolve_ip().
> >
> > - BNXT_RE_METHOD_DV_QUERY_QP:
> >   Return QP attributes for the DV_QP specified by the QP-handle.
>
> I think this is generally not how things should work..
>
> If you want to create enhanced QP/CQ objects then you should use the
> existing create QP/CQ ioctls and enhance them with a driver specific
> uverb spec, not special ioctls like this.
>
> Certainly new stuff should be broadly avoiding the 'struct
> bnxt_re_dv_create_qp_req' kind of design pattern in favour of the new
> ioctl system's finer grained specs.
>
We chose the new ioctl approach since it provides a simple direct path
from the bnxt_re library to the driver, without going through
ibv_cmd_*() and also since there's really no need to have the kernel
IB objects (ib_cq/ib_qp) for the DV use case. But we will discuss this
internally and consider redesigning this based on driver specific
udata, like you are suggesting.

> If you want to just create some kind of object by raw FW call then you
> need something like mlx5's devx to push raw FW calls (eg create QP)
> and wire them up securely.
>
Currently we are not looking to create objects by raw FW calls, but we
understand your point that a new ioctl could be used when there's a
requirement for raw FW interface.

> > Some applications might want to allocate memory for all resources of a
> > given type (CQ/QP) in one big chunk and then register that entire memor=
y
> > once using DV_UMEM_REG. At the time of creating each individual
> > resource, the application would pass a specific offset/length in the
> > umem registered memory.
> >
> > - The DV_UMEM_REG handler (previous patch) only creates a dv_umem objec=
t
> >   and saves user memory parameters, but doesn't really map/pin this
> >   memory.
>
> That doesn't sound sensible, what is the point of that?
>
> The umem in mlx5 is all about pinning the memory and sending to the
> firwmare immediately. If you are not doing that, then you shouldn't
> havea "umem" type object at all.
>
> There is no reason, indeed it is a pretty bad idea, to have the kernel
> hold onto some userspace pointer and NOT pin it within the same system
> call.
>
This design was chosen since some of the applications written by our
customers are already using umem APIs for mlx devices and they wanted
to use similar code flow with our devices.  Our adapter requires
pinning only when resources are created. So we choose deferred
pinning.  We will address your concern by terminating the umem APIs in
the library and not going to the driver. Later, at the time of
resource creation (cq/qp) we will pass the address directly like you
suggested in your next comment below.

> > - The mapping would be done at the time of creating individual objects.
> > - This actual mapping of specific umem offsets is implemented by the
> >   function bnxt_re_dv_umem_get(). This function validates the
> >   umem-offset and size parameters passed during CQ/QP creation. If the
> >   request is valid, it maps the specified offset/length within the umem
> >   registered memory.
>
> We don't support "remote" pinning. This code is wrong:
>
> +       dv_umem->addr =3D obj->addr + umem_offset;
This is not remote pinning. This is the local queue memory allocated
by the application.

> [..]
> +               umem =3D ib_umem_get(&rdev->ibdev, (unsigned long)dv_umem=
->addr,
> +                                  dv_umem->size, dv_umem->access);
>
> Since "addr" is only valid for pinning within the single system call that
> specifies it. You cannot pass it over to another, later, systemcall.
>
> I have no idea why you would want to do a design like this, if you
> want deferred pinning then pass the addr/etc directly later.
>
Responded above, in the previous comment on umem objects.
Thanks,
-Harsha
> Jason

--000000000000c586fe0643f4df5a
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCSqbMKchfVeMOW6ShzYS7lWZ7gyxzVp59I
OhnH9aBeNjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTExMTkx
NjE0MjVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBkVBzLGvb8RJ4UA7PP8jEDcu8OZyVa+jw2Odizm8T79lztMnII9GNpvI+DfVuHgZwD9w8y
ayjVQkjIvuHf9E0LxmcYHIBxIVepiNK6jDkwGzSEwoqg5icbh0TtPDnQMPh4kYx6O4bgpVko6vAJ
gllPDcE3XsW6Q/w9JcqjmvtmcAZeHCtwfEoYObUO5fR5JrhD7eCdaKddHcUVY+49Bi4Bex/9q4HL
3XJlhhQqvlcyfxlv4Q3gKiT7i9VsieShnWHz6/q/svEfn9HpZ6sohO6kXNhXT0EqGL2JOtuAcdqR
3GI5Vyadwast9wGNYGYW1BwtfRcujetsdK1XGalH+E4R
--000000000000c586fe0643f4df5a--

