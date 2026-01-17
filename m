Return-Path: <linux-rdma+bounces-15649-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B442D38D2D
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Jan 2026 09:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81A8B3024243
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Jan 2026 08:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993FD2F1FC4;
	Sat, 17 Jan 2026 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F0W9F4nS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B5A26E165
	for <linux-rdma@vger.kernel.org>; Sat, 17 Jan 2026 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768637257; cv=pass; b=IMHKHQ0ZjRgN6apx7u0M8fDoWW40WSZN6wegek/cGhF8+s9vo2EA4MgilCNNEsU3OtiyMUJ7zwgvwvuqzjxzEWjlGlm8yWbRSAfPq9wHH50pb+ylS/eFe5XbqAobShXVdIPklOAbYDgcoQ+pnPHDWKZk2qH9O0QloBZlY3yIOtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768637257; c=relaxed/simple;
	bh=RwxWB9gXPWOiJk5M2oJwqUWUD2PpnjLThkWcRjv49LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maYF9fwLFzF3Gqo3Z1fIGrp3wcG2eZAumQi1nZSLIDxlzjucUiV8fX2yY5LhSUUs0UuqBS3hsPvafEyCdyU4XebijHLJH41JgwRBLcAA7lOUqcgVMCobM59BULxsDR+3q05s48GfAJffk8PyHGFdzGN0Irq34ZLfxH2oENugESE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F0W9F4nS; arc=pass smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-5014b7de222so27409801cf.0
        for <linux-rdma@vger.kernel.org>; Sat, 17 Jan 2026 00:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768637255; x=1769242055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SP3JQjmta1y22dm8bUiW/w5Yyk9C4tZpSQZPcS9i1Ic=;
        b=tgCFTbYEZIpgaE3/mhZBgOKSwvaTSoSgbUZhGasJPst4mnT0Rx2J6TIXJQtkOEunMl
         XpGcTJYctgN8pUfvLSJGOCWSm1OWur43RBi6wahVksGKzSWiiGmgo2EPTyAWVgFjSrSz
         NOsbzyW7Kiyaz9t8M28AKo/aUBTYU0Bry1IFv1hiK9n5LxDzi/auVQUXdJ/x8bM04RxS
         mjELVURd2OFadGjSQnogxam14DwPiDMAPXHgsQxrxTvDnayDeb1un0z1Xb61hax87p1k
         0ay91K3jVcUBglcmFGWzS30zD/7LhSXdoURG5bH7n62rS4UezxFweNHW0W9Q1nkfXlNU
         VJAQ==
X-Forwarded-Encrypted: i=2; AJvYcCVZhKIPH6IoQSdbe+80ORum8yI6OTVFX7r2HhbVQ/CydXfRL37eWGRVBlvNH8FK7an3xrGkm2j+W1L0@vger.kernel.org
X-Gm-Message-State: AOJu0YyuK6k+t1/o8JCZIoVZFTyS+6Jo2om1jYTZ0wAvnWGL4P7Xcdxo
	Z26Yex5NZVKnP/jvN4pYeGSUmujFmrjmD3NF64pDH17quDxErHxm7Ims+qH4aUnY51UzZOpaIWM
	A4FmF/fykCwC4r/Rh9+4rTlEY2m2khSu+DyFWSRkeUMZtZ8YNsRdWVHmyMmIC0a+Rp01YyExPsk
	KYWJxfKZp9OsCxzwuniVnW2u0VEynlgcJHv0Kz1Jakc9IYPul0hJe6OL7UfBbA8N3TojtZmusQU
	SXEr+h6vhPfiNexQDWUeiSePCdl
X-Gm-Gg: AY/fxX4paYSfOhu5GcUtFFmRpovCQoHVhmPpHaG7EcZA3uxJrPjXl7lQmYMIDDGQ8/P
	NRqFS7nkzjVb+cE1REONRiChH/9lXTH18veVhOiHG2LQY2I9QOqhwyt2U0ayk6ucN91AS0gnYJJ
	dhfC1ec5L/85BaopvcN4DUk1MVC3kJ/p1gdx+wtvxcYkZus90rmffL4f23tvxE1jCV5148gHIU2
	7cmIYJySD8bbCYonlmYUsFZAwYNHNjm8+eLGYNulxRuXalHL3j9XB/TXEDAMNfzWasdpdNVOTyZ
	BSrPWcqerTF8v9/f11Dk8RHLoj7QIPVO1GTw4TxUKOu7kq/BXl8gX4cZQiZL+DcnW+ETddpPKmi
	vRhfEKQ9JW+okp2Yaupm/T/Rj6eL/6r4Ooe1x2SVqSTZiBWbBsGzEeCD3hMNLZD5LYmRZORKTvm
	dMrbu5GCteitppyigHAb4E9uwXm5kuj6s7nU8Q+N6nInEht/uZ3LYefVR5
X-Received: by 2002:ac8:43ce:0:b0:502:ad63:e15e with SMTP id d75a77b69052e-502ad63e2b4mr25722171cf.55.1768637254717;
        Sat, 17 Jan 2026 00:07:34 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-502a1d53296sm3781571cf.2.2026.01.17.00.07.33
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jan 2026 00:07:34 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43284edbbc8so2301686f8f.0
        for <linux-rdma@vger.kernel.org>; Sat, 17 Jan 2026 00:07:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768637252; cv=none;
        d=google.com; s=arc-20240605;
        b=dit6/Xrb3MDcuHlrtXYHH4vTW2BLe5dd/CLgy2GzKlfaV3yaZC1omQrYvJUCu3sPZf
         qQjD4Q1REJnAMElqxa/Rt3TFX8Q+Eepz7D5v0PAhcTXYjmA89JaFhdFMcT7nCxE899GW
         oMJIsaoh3kMCmnqH6zn08hmYOPPG8gc8ad6Tx2uxvwQaY95ActSE5R1yW6u46miK0BOR
         1OSvgtI31huh40tMy1ArchxIpzSMyNBbSSYIFXUToPgCleN7ffKdZHu9vWrOEnup+B0p
         j4VPQUptiZwvtwcqL+iH0CBJOz33QY2dHrTe5GvGEWJFdOxWlDctPJ4LZuB5du/xvBnR
         JJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SP3JQjmta1y22dm8bUiW/w5Yyk9C4tZpSQZPcS9i1Ic=;
        fh=VfSYTqbAMavc6314PgMuXnRfVBRcjgc8RCqxgTsd+WU=;
        b=DFslLX6pdmR7CJdUbOqA89xcR280p1uGjK+W+Lw19+OXf/GKfVSG60pRMu1JzOCAqo
         tfyZWv1bErHyeHlZjGTK1r75eGg8BTj7RCQGXrO1iM6Ii/SwQ9bVynX4Te0IiRVY5CH4
         PsNyEgVEM9M+yeFrIsdzP5xUyI15QlXD2lFAtJ4+Zc73I7aHSHHBDv51V7x/Xsa0OJTL
         zy6wMiNRIn1kf9IDnnHmlH8KnfCy5CRAa3NJUuU2MvW2f+Fv5wYdYt7rCTd9svGzf9yU
         scTZSyiBOXmTUgTErSlCwqdggpUq0pIFm/hmVFPolOMdTyZvxTA0t0ArQX0wZpHfzYTG
         STmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768637252; x=1769242052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SP3JQjmta1y22dm8bUiW/w5Yyk9C4tZpSQZPcS9i1Ic=;
        b=F0W9F4nSgq/iuz98bMqmDmlWaZkH7ESWjr/wGdulhzSDbnUxIpkVm9VsEsJfI75GRh
         KXKVNed3Wi+2f1VPleQGyGmWZhxG9d9DcLX2jYJ9+UmY5NKaHn3uPz8L+l0zylEEnVa8
         Y89gTlf5uMkjFSs9/e8hlrZbpaJn3XWZpUr1M=
X-Forwarded-Encrypted: i=1; AJvYcCW+em4l6doxmdyyKeianeWtHcFfLQOg1/lIz70jSAqXWxiZ0PQF4SJc6twa4LoG4qY7/ZhlMLx3/mHD@vger.kernel.org
X-Received: by 2002:a05:6000:240c:b0:431:a33:d864 with SMTP id ffacd0b85a97d-43569980c19mr6175432f8f.18.1768637252362;
        Sat, 17 Jan 2026 00:07:32 -0800 (PST)
X-Received: by 2002:a05:6000:240c:b0:431:a33:d864 with SMTP id
 ffacd0b85a97d-43569980c19mr6175400f8f.18.1768637251963; Sat, 17 Jan 2026
 00:07:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224042602.56255-1-sriharsha.basavapatna@broadcom.com>
 <20251224042602.56255-5-sriharsha.basavapatna@broadcom.com>
 <20260109190857.GO545276@ziepe.ca> <CAHHeUGWHkfNKK9qahDf6ZSxnbAso8skT-bny3=MsR+ZM9uckFg@mail.gmail.com>
 <20260113172720.GR745888@ziepe.ca>
In-Reply-To: <20260113172720.GR745888@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Sat, 17 Jan 2026 13:37:18 +0530
X-Gm-Features: AZwV_QiCsxr6eYI20ClsRa_SnpqZ1LKw0sn6QSut2frxNSpQ0d41NAt4wX5YcHc
Message-ID: <CAHHeUGX373aeRoHoRvjY7i15WFzf9E2TT3XP6tGT_iK9kXSBKw@mail.gmail.com>
Subject: Re: [PATCH rdma-next v6 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000030eb4b064890f36d"

--00000000000030eb4b064890f36d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 10:57=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Jan 13, 2026 at 10:44:21PM +0530, Sriharsha Basavapatna wrote:
> > On Sat, Jan 10, 2026 at 12:38=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> > >
> > > On Wed, Dec 24, 2025 at 09:56:02AM +0530, Sriharsha Basavapatna wrote=
:
> > > > +static struct ib_umem *bnxt_re_dv_umem_get(struct bnxt_re_dev *rde=
v,
> > > > +                                        struct ib_ucontext *ib_uct=
x,
> > > > +                                        int dmabuf_fd,
> > > > +                                        u64 addr, u64 size,
> > > > +                                        struct bnxt_qplib_sg_info =
*sg)
> > > > +{
> > > > +     int access =3D IB_ACCESS_LOCAL_WRITE;
> > > > +     struct ib_umem *umem;
> > > > +     int umem_pgs, rc;
> > > > +
> > > > +     if (dmabuf_fd) {
> > > > +             struct ib_umem_dmabuf *umem_dmabuf;
> > > > +
> > > > +             umem_dmabuf =3D ib_umem_dmabuf_get_pinned(&rdev->ibde=
v, addr, size,
> > > > +                                                     dmabuf_fd, ac=
cess);
> > > > +             if (IS_ERR(umem_dmabuf)) {
> > > > +                     rc =3D PTR_ERR(umem_dmabuf);
> > > > +                     goto umem_err;
> > > > +             }
> > > > +             umem =3D &umem_dmabuf->umem;
> > > > +     } else {
> > > > +             umem =3D ib_umem_get(&rdev->ibdev, addr, size, access=
);
> > > > +             if (IS_ERR(umem)) {
> > > > +                     rc =3D PTR_ERR(umem);
> > > > +                     goto umem_err;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     umem_pgs =3D ib_umem_num_dma_blocks(umem, PAGE_SIZE);
> > >
> > > I should never see PAGE_SIZE passed to dma_blocks, and you can't call
> > > dma_blocks without previously calling ib_umem_find_best_pgsz() to
> > > validate that the umem is compatible.
> > >
> > > I assume you want to use SZ_4K here, as any sizing of the umem should
> > > be derived from absolute hardware capability, never PAGE_SIZE.
> > Changed to use SZ_4K.
>
> You also MUST call ib_umem_find_best_pgsz()
>
> Jason
Ack.
Thanks,
-Harsha

--00000000000030eb4b064890f36d
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDx3s746wu8yGY9HRcfR4+z0EGTj8o1x/iq
3wGbyLdb9jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTcw
ODA3MzJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBuuWcTtPjuSWsLwnEjMSPXT4ynM8n+P92xdV4o5ycJbPAEbmAPouASDD2SGz30b1OS6r2i
abD6TqUin/H4nazH3w6ufuekQvlmu/mNJTFVMTYJVPd4c8K1dSIZJSiEFro6xz778p9NfUu2ED+m
fsKVHYi18gb6Qoub6Ms2ppNMyVYOFgY7ji3WvTnKxrCoWGqF19BLJBCaIvRGtyTdjv/rWv9tGT3s
2yAnfMz/oqnV4F5kFqTE+WKTxarrQqUxcTn3HZ4FKStY+RXZrOFB82Q2Am5iAz5PGHOZKtqhFciG
0WoArBizGpOr+vL1q5dHS/0DmVxWRRxYxOd2tPIo/anp
--00000000000030eb4b064890f36d--

