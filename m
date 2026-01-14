Return-Path: <linux-rdma+bounces-15563-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AF9D20B95
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 19:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95735300646F
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF442FFDFC;
	Wed, 14 Jan 2026 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CdrZCA78"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99AF52F88
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413846; cv=none; b=kzaCK4tspHg+C1QbXOjKDxAlVcyhSXCbo20jCRmWfuDOqZ78QDGUBLpkB/VltWyKcl9B9L3noMcX7oLGVX+MglV9hnHoqupuZa2nRkB7WMrtJ34x9OHhT4RAuGNflqKi8SNisw5QwymJttjt8XfI/U5yXM0gerq7fCSQQxsLMno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413846; c=relaxed/simple;
	bh=NFDCTLgjHIjOEGCIkoscJQG/xpbhbWJVFjk6+nkzoWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hpt2MVqPDda8LSUhPAgHu49CsxPTPzrkD83E2sJzyrmQFMoGyOyDQ0ONKSv+9YFdcje2hf/QPdtZrUNjVw0wYjx2OkHDttyuolzCeQOBJCEfo6Zp7KWlqxfdEj96wGxvxHIcbm06ZSpVR6NSqPN6eo1A2ioKSFYVqkrqWQabeWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CdrZCA78; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-5013c1850bdso615111cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 10:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413844; x=1769018644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoinrWKzm3s8DzyFMBR5rVVNPLmlsooIWnqMaX5FzqI=;
        b=q2nNDFTn3FMoSHQ3CpkHGe/5Gbfl2As+HGf007BCwPrJVDwyUmfAnseUxYzwZWooDA
         PaaygSLop4MtqQmq9FpGyU2mp9NB/PUVwrIwIwQokXGAaqAfmDwBrVItqBpVLgFS4QXC
         F0OuLMF1nTLd9C5NwY7QsAJ8GUBtI5vIern70acNXFVLeSgDe5KVD41QxB2xpJsR5mwl
         xHLBJpAi93GA1ZJ7TWiTgcVZ0q/lJ/X0VgPH1AErgLGsHNSZU6V1XjW6j0YbejDi5Zx2
         i3fPZWZjERj4h9Jn6vt61ciutV7D6U2bUxHYG18rsuIDNshZPQu/4dGPKfp+R66cELAh
         kiwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUUcoBly8P//b9jLqY7sBInCHJtdrMF/0AI73DNyNkB+xg3WMqjA3q+RO9mWd5PsRudJ5qfrdhw7nd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyso2J/Eg/Qc9IDlA2w4PFWlSDst8SvZxsNw7IItk/fY4vUvSts
	amVxZOt1D3gzavMd3iehbKSTGtTfSfZ5p65W/9TIbXSl0G2V8/YNt7w50Vgac9ql6gdm3AGpdj2
	0O3AHoOP+aao0Rhdauj/1qlQh1FNQxp65Dni7LqQ1M3+Bi/QZSe7EvoBnnL/+91WdmJTIfIDfmB
	tYCcmENOYkaoa6dHUrFq/x7uLTu+zJWEF+yyED75PZeloOX7zSIByUV8d2MGyuLZPHkV+FoF5gS
	2I4TscAVCTLBR077Hf9DW54iN0M
X-Gm-Gg: AY/fxX7qTK6jObH3shO/3rj0Cm73I+Cx/KI40DaybHLCy7Y3XI7xPOj2DmpzyzcQidM
	lCsLRlGuJT5hu1H1wM7CVxeYrhS9Zu0oKkyE5OD9GxLEKIs/cYmuLyZF25kGYERnFiTxvh5zYFC
	Ofo3LR2djGRirVhMurf2c8UgecJ1lc7AO238JbDHb2iVuncKdCUfwfF6xHGljb7Z+9hCohFswdo
	Vsfc7WVEzDKUIoJ7N2UNy/cLeDFU7tXkU0DGkr10dBlBE3JSoHLjqY3svTj8EavyVLhF8mJU0bT
	D68hAuJ7ApI6t+GM4hZ40WQlmC88mZiI8FH5tR/vLkFNLJno2kyX3jHt/IIkPP5bf9vgashoY4T
	0cUnv3WTuG81uDJgJxpbuppqj4oKJ+s0ah1wu6W0hwAPsA73rUDmGTU+ffwY8MdTQ+Qlx4SYOz9
	1cKtEe9aCuIfWaVOj4of29EleqblDMwo7PAy6SuJH6ku+4kJCggnnohYodzQE=
X-Received: by 2002:a05:622a:188a:b0:4f0:131f:66fe with SMTP id d75a77b69052e-5014847ff92mr46780781cf.59.1768413841367;
        Wed, 14 Jan 2026 10:04:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50148eb1da6sm427941cf.5.2026.01.14.10.04.00
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jan 2026 10:04:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42fb1c2c403so106941f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 10:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768413839; x=1769018639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AoinrWKzm3s8DzyFMBR5rVVNPLmlsooIWnqMaX5FzqI=;
        b=CdrZCA78B1rIbc5sEC13gntrPhAO4b7pmHYGhY0dunDKzyFkDXLvh1MYX1unWkP39W
         cwiXVs4MrUAIS8XeTjIZwaPTLNjCVVpcH0CNJaVzEnfs68aExDsdkUGc6qEXtqKNGQgT
         bg++HVmS6lZMItkqJUNSXoH58Bkx9jYItei1U=
X-Forwarded-Encrypted: i=1; AJvYcCXhPREeIKd7HM/GFeWmOQqCDQBZVUJ/AzZQHvRNuLLcYqjHW7xpmFPT9Ky1Qy5jho582h8w+A+dEKAD@vger.kernel.org
X-Received: by 2002:a05:6000:438a:b0:431:35a:4a8f with SMTP id ffacd0b85a97d-4342d5ced24mr4295562f8f.47.1768413839110;
        Wed, 14 Jan 2026 10:03:59 -0800 (PST)
X-Received: by 2002:a05:6000:438a:b0:431:35a:4a8f with SMTP id
 ffacd0b85a97d-4342d5ced24mr4295519f8f.47.1768413838709; Wed, 14 Jan 2026
 10:03:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
 <20260113173247.GT745888@ziepe.ca> <CAHHeUGWErNHmhFX13VHw3V6feswyV6JVzULegGoBNg+2x6O12w@mail.gmail.com>
 <20260113185957.GU745888@ziepe.ca> <CAHHeUGUgacV=t6pUJDX_orvxwzv4LEH_cnzyN61mCA-MMY7acA@mail.gmail.com>
 <20260114165909.GA961572@ziepe.ca> <CAHHeUGUuN+WBX5xKHH2MeS0XoRdDbZHDduDD_8aK=Tv8d12Zeg@mail.gmail.com>
 <20260114174931.GB961572@ziepe.ca>
In-Reply-To: <20260114174931.GB961572@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 14 Jan 2026 23:33:45 +0530
X-Gm-Features: AZwV_QhyE1XXVyjrFqZHtO111wxvgqHI32va3n2wcT9vrDVwHC6RKzYiUib2FUQ
Message-ID: <CAHHeUGVdfmJtZDnHUduX8OJNPDVnOou+9X-irruN6N3dpxWH0w@mail.gmail.com>
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b9ffd006485cee1a"

--000000000000b9ffd006485cee1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 11:19=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Wed, Jan 14, 2026 at 11:14:30PM +0530, Sriharsha Basavapatna wrote:
>
> > > Please don't pass object handles in structs, the attributes must be
> > > used to pass these things. The driver can obtain the pointer with a
> > > simple
> > >
> > >                         send_cq =3D uverbs_attr_get_obj(attrs,
> > >                                         UVERBS_ATTR_CREATE_QP_SEND_CQ=
_HANDLE);
> > But there's no cmd buffer to fill this in as an attribute from the
> > bnxt_re library, since it is using ibv_cmd_create_qp_ex().
>
> ??
>
> DECLARE_UVERBS_NAMED_METHOD(
>         UVERBS_METHOD_QP_CREATE,
>         UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_HANDLE,
>                         UVERBS_OBJECT_QP,
>                         UVERBS_ACCESS_NEW,
>                         UA_MANDATORY),
>         UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_XRCD_HANDLE,
>                         UVERBS_OBJECT_XRCD,
>                         UVERBS_ACCESS_READ,
>                         UA_OPTIONAL),
>         UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_PD_HANDLE,
>                         UVERBS_OBJECT_PD,
>                         UVERBS_ACCESS_READ,
>                         UA_OPTIONAL),
>         UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_SRQ_HANDLE,
>                         UVERBS_OBJECT_SRQ,
>                         UVERBS_ACCESS_READ,
>                         UA_OPTIONAL),
>         UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_SEND_CQ_HANDLE,
>                         UVERBS_OBJECT_CQ,
>                         UVERBS_ACCESS_READ,
>                         UA_OPTIONAL),
>         UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_RECV_CQ_HANDL
> [..]
>
> DECLARE_UVERBS_NAMED_METHOD(
>         UVERBS_METHOD_CQ_CREATE,
>         UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_CQ_HANDLE,
>                         UVERBS_OBJECT_CQ,
>                         UVERBS_ACCESS_NEW,
>                         UA_MANDATORY),
>         UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_CQE,
>                            UVERBS_ATTR_TYPE(u32),
>                            UA_MANDATORY),
>         UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_USER_HANDLE,
>                            UVERBS_ATTR_TYPE(u64),
>                            UA_MANDATORY),
> [..]
>
> You can add a driver specific attribute using the mechanism:
>
> ADD_UVERBS_ATTRIBUTES_SIMPLE(
>         mlx5_ib_cq_create,
>         UVERBS_OBJECT_CQ,
>         UVERBS_METHOD_CQ_CREATE,
>         UVERBS_ATTR_PTR_IN(
>                 MLX5_IB_ATTR_CREATE_CQ_UAR_INDEX,
>                 UVERBS_ATTR_TYPE(u32),
>                 UA_OPTIONAL));
>
> const struct uapi_definition mlx5_ib_create_cq_defs[] =3D {
>         UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_CQ, &mlx5_ib_cq_create),
>         {},
>
> Shouldn't be a problem?
Thanks for this example on driver specific attributes, let me look into thi=
s.
-Harsha
>
> Jason

--000000000000b9ffd006485cee1a
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBM6FW821K/GJaeeh/cN4I7aCJNwXB/++1D
wNGv9QwkkDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTQx
ODAzNTlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBfCCY9va1JEsAFVFdUUpMdr5aNp2S6QDwc2y4E55q2Y7nG19UdHlFb9nOZO1O3qVlp3Pf5
EFnEkIo8QbQplW8mQn/qZ0yfBdVYSkljaXk1GT2q1/0nyGdXaIa7dOVpyritAG314ApCVlxPvwFj
dMt+pSxVXfuVVgTAinJz78T/m0V7Tti7UIu/8dZupHSaBvQBIfCGWvyQd8u0JVz7ZFGRwN73QqqT
aV0q77XKOrIrP81gPwFo6rIA7F+RsVPkK70j2+LjIOOmiuXU2dr5a/a9StqdT8RdtEuDp5/fPmsO
nUAW/1MMiidt8y9nSwxVrnwe1++sqb9Ma4067krU63eW
--000000000000b9ffd006485cee1a--

