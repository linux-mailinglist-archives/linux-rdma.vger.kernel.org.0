Return-Path: <linux-rdma+bounces-16749-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK/3Gj9njGkdnAAAu9opvQ
	(envelope-from <linux-rdma+bounces-16749-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 12:25:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B5F123D74
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 12:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD0583004DB2
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 11:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A8A36BCE0;
	Wed, 11 Feb 2026 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X+S09Z25"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE73148A8
	for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770809145; cv=pass; b=pWrsFDpFAa2PmqJ0FtqWLFthD4oyW+sq8W73ROBT4EW3+Tf388Olh51YaGvqDIQEtspzvje9KhyegIgnoVsm590xOtiwRxc91GLrGfPVwdR4uxPw4cu7ssfh3wyfVuViMwqssTNGBLiXdQcW11iMKF9GGGbHelj0ehdMvV8NLbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770809145; c=relaxed/simple;
	bh=04oFgEw5tsHiZ7bXqRnMo41uF5NxGTSkA3oy9W5OGkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrTdbYNmbyNsPbb8Y9F54Yr/xwN8zIXm7h8HeoY/4nOOa2IeDt5mUh2YBdZ59rcK3GOIPOng4ewKQcWIRYVjk44LthvpflMyU0Jxt+Hho0jZhhyUZ/1A9c58QLdw8+UK1tpm2a3k2Q111BC6n8Ia/Mw+E1CiMrRH0nefeQPdA6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X+S09Z25; arc=pass smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-790884840baso63339797b3.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 03:25:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770809143; x=1771413943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tZZqJgYTyfYlQuqd//m4zxLbOc7AZMZHpblYYKy/Is=;
        b=UlVYmA6C6PHk/JEfp/LFyVPHDDQnFwHIV1fL7x6c5opYtwkEKoFZEzZeTC6nZsN9P8
         kxgmAtFpVf4ewTyJwdtf8JZAhIh3djr65Jb0NBvb4AR7lqeGVOqd+xAN7UWz/RBabgB2
         B8MkAr4VPv2A+jrCcTtVi6lvjREa6mOWQK1Z0zx/RbSlCnDMnRqqw+77fDm8/5hlczA4
         jetQd3gerwdYt569hWnNu10muiVinZ88o9/g0YRmkDwxmDElIjsB8j/gn8yOl5aUm+dg
         Fa20WnDBn9LgKQa/FSFie2L92Z9beBlGoq+zgyzpANeZpNctGsqRQZEsE7i+4M2UPncl
         fuYA==
X-Forwarded-Encrypted: i=2; AJvYcCUQbVlJmvrfTpt0qw5FKtWEWDI04nOtEpEubum/7y2nhTTOrmk2bDyTD8tlk1cYRFh7UgbvlrqzNluH@vger.kernel.org
X-Gm-Message-State: AOJu0YwKuRZbqNqy5oVGnq/qI+BKFUQz60VoUUVBCUMyC3K1YbmdRAnd
	Pl8H0JqmjyMbXGsFErpCl6acU5wsOvUW7W5RNrlspqLq1nCQkZtfJaQdpnQLzCEp1A4Oyvk6zOq
	KJ1JprrXqssykI0fgXoNupDy3P2mFKDt1gzpFAZKqQ+TaT7dWLRQH1MTQ+1qeun2jp4lpRYLNAL
	RyLYsyaCC9wALCXG4UMGtmrox2GJjKkD/BID+mwAIyOCSgOHFi1paSSm8By68kUZQZRJw8I2uDC
	Mjknl5rgIokVtAWvRQOHntC79dU
X-Gm-Gg: AZuq6aJca/RfZayWH9Nyrxau3KEJ6FiKsKV/3YtAiWGOtxJ/2cZV58Ka30/Noo+5Xmo
	aSwbX6rkCG+0SQvQIFh0cZZbDe8pjY6lq5VKMHBBam9cbqavKGtHg8kUVPuva6z3+gdMuLBFm6b
	06besTcdUO7F6SWeM8ycmmcI4AIJ8opZgVyOtvEpgo48vhSMjvHlljPd/OfjR5hhN1VAlZwz2aV
	NZVS05o75rprtfuTENEop30JPwLUvX8HPOul7sMla1/1ouG+BLHSn+bhZ2j1xB084yK9nQXBSLx
	nxLdGhYvgUYDhmT8/sNy12Ls7QaKowOGNDyaqKitlWWy2PtJ1YV2KpisPg9wfcdr2MEjVr7gNDq
	Cgc7p4QxdIcUkPt7grk1dlwTAXX8nLeejhUSlnSg8vH+KvSPFZogXhljo2v8pW5kX9bxryonW8z
	oGqtK/iCUqODkPZucKKN2D/2zgKxe/R1wjMSt/EOaQXZAJPMtDXrs6P1TSv60a6JeeiUpx
X-Received: by 2002:a05:690c:805:b0:796:2dfb:4af1 with SMTP id 00721157ae682-7965ee92182mr35939537b3.9.1770809143442;
        Wed, 11 Feb 2026 03:25:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7966c24cb57sm1481647b3.25.2026.02.11.03.25.43
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2026 03:25:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4801bceb317so20318555e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 03:25:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770809142; cv=none;
        d=google.com; s=arc-20240605;
        b=Xe1KKhT0iQ/mVREY7ITVrEa7XT3xK4uLqcEs2sE7B//cNAPkuToBtGqJuWcopAThQu
         tpvG2ft8ZkWgZUdxGGUhR2fl4k4zT8pnOB0wRn+0DoIExdF0YV6CyPoIzChm5JF8QXmx
         wzwe1U1FilfG/TXavTB32A8y7SfihWSBScIMJrBRPspMNQbQbAaYG2l1oXxURl1tcZql
         4Eb2pCHASmrIM8KEeMIp1x/SuNG05vFdT+3kybqit2BQNBvOh4QWM1yccyjDB9XMCvV5
         tw2y9vYsh4mFvfAJVnRmumhV0j1kUUhxwCTmAadwuvvh9SeXGY7UZ6v4DdQbuJab8Eyi
         rWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9tZZqJgYTyfYlQuqd//m4zxLbOc7AZMZHpblYYKy/Is=;
        fh=hMw5u1vAOjOOAlgRau7+bsFjqqawhs21Hf4dFDWmXKM=;
        b=i/zSRW16hrWz4PxueWlMdtHbUDkPNIOrq5ybfCAKy2k0tsFerJU5Eqice5Z3Gtte44
         XI8IpcjcPTmhvVW6I+Yg+COtBgGZuvWMgUQkaAN3iplQaFiEYWHbJpE0HEU7YFeFwPZp
         4XU11525IN6DVQ93of38z5WSmkOYxReaePoe8pd9QlSo0SUdsheQsDnCeNWXGt68jRya
         3/pfNLKryUGK5lksRqLTAkfhhldr0mUy9PFzpFTtIheTnIoNLVhWaNlUWO2VW0cInV9O
         qYzwr39C2QcvTClibw8sELp9thLdlmyrh7qD9lLYYvDKJ7XwVRa4LL6A1FmvcJCGpV/5
         9DcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770809142; x=1771413942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9tZZqJgYTyfYlQuqd//m4zxLbOc7AZMZHpblYYKy/Is=;
        b=X+S09Z254Vf24z6Is8FT/9WrZDowUlmgHTxYlAKIy6PXsGrUudiV7SA0F6Qwcq20+a
         FvBEFaGAU7T1FncabLq6FjHndmUzTCCJXBSpIYGXkFj1VGw2Yx9zO4kRKKtDuliWbMTq
         iNRn+5o0Wp7wXEGDMfS6yYW5PXAYXtoAcSze8=
X-Forwarded-Encrypted: i=1; AJvYcCWXJmHXY+7BW2m7BpWZiEXZds6zOwDOv9ktB+XD9OiE7/BsfR+8KnCQOneW6sk7QE3ASrhTmhjm43RC@vger.kernel.org
X-Received: by 2002:a05:6000:2dc5:b0:436:8058:453 with SMTP id ffacd0b85a97d-436805809cemr22386802f8f.33.1770809141868;
        Wed, 11 Feb 2026 03:25:41 -0800 (PST)
X-Received: by 2002:a05:6000:2dc5:b0:436:8058:453 with SMTP id
 ffacd0b85a97d-436805809cemr22386757f8f.33.1770809141419; Wed, 11 Feb 2026
 03:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210165939.41625-1-sriharsha.basavapatna@broadcom.com>
 <20260210165939.41625-5-sriharsha.basavapatna@broadcom.com> <20260210190750.GD750753@ziepe.ca>
In-Reply-To: <20260210190750.GD750753@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 11 Feb 2026 16:55:28 +0530
X-Gm-Features: AZwV_QiPvGaXiJdr7JGs4bzs4mIbUefHPyu3c0Ot106xqW6AwQuYPjyu6-mqm4w
Message-ID: <CAHHeUGUSL9_p9JzY6+-B+RXDa55KfWCWmP7iV1K7_NVcCuMqVQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next v11 4/6] RDMA/bnxt_re: Refactor bnxt_re_create_cq()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e33979064a8aa1de"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16749-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,ziepe.ca:email]
X-Rspamd-Queue-Id: 84B5F123D74
X-Rspamd-Action: no action

--000000000000e33979064a8aa1de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 12:37=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Feb 10, 2026 at 10:29:37PM +0530, Sriharsha Basavapatna wrote:
> > +static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
> > +                             struct ib_umem *umem,
> > +                             struct bnxt_qplib_sg_info *sginfo)
> > +{
> > +     unsigned long page_size;
> > +
> > +     if (!umem)
> > +             return -EINVAL;
> > +
> > +     page_size =3D ib_umem_find_best_pgsz(umem, SZ_4K, 0);
> > +     if (!page_size || page_size !=3D SZ_4K)
> > +             return -EINVAL;
> > +
> > +     sginfo->umem =3D umem;
> > +     sginfo->npages =3D ib_umem_num_dma_blocks(umem, page_size);
>
> This ends up doing ib_umem_num_dma_blocks() twice:
>
> bnxt_qplib_alloc_init_hwq()
>  bnxt_qplib_create_cq()
>   bnxt_re_create_cq()
>
> And then again for a third time:
>
> static int __alloc_pbl(struct bnxt_qplib_res *res,
>                        struct bnxt_qplib_pbl *pbl,
>                        struct bnxt_qplib_sg_info *sginfo)
>
>         if (sginfo->umem)
>                 pages =3D ib_umem_num_dma_blocks(sginfo->umem, sginfo->pg=
size);
>         else
>                 pages =3D sginfo->npages;
>
> etc. :\
>
> It looks to me like npages is only expected to be used in kernel mode
> where there is no umem.
>
> So maybe don't add another num_dma_blocks here and make a note to go
> and clean up this code properly as a followup? Properly means the
> function that allocates the memory for the sginfo fills it in
> completely instead of sprinkling it all over.
>
> Jason
Agreed; is it ok to do this clean up as a separate patch (or series)
later, since it is not related to this series? And since it also
involves several callers of bnxt_qplib_alloc_init_hwq()?
The changes in the other patch (CQ) are done, if this is ok I can send
it out, please let me know.
Thanks,
-Harsha

--000000000000e33979064a8aa1de
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAkY5j6Bo+d3a2Gd0F7l4A+YBiQsoIlNLIp
b+C61WqGHTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMTEx
MTI1NDJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCNuoYV7zNRXXizbVY54sUUHsudhWHl+hYEz0sI6QCHys0gA2yJSVdx4B6fpvCp6AZkVCNR
GitZrryZwezmwV9S5v0DyPqVaeojZC1OwrLUBm2MfhY6CinVmtuVXK9barOm7jLOQFyFvmB6V8mZ
sibOvGbZ28gjvF3EG1Upa/g0wqlx3Sj4zvPmJg/XHzOPSK2ZqPlmO7il9BCm82bG7xJtr0dt2Bh4
KeIOAE7bTVOvKact+/FNvhnFpVHft+nzlyEjQyqt67A7yM0I/ug5e8no9S6KCU5ljgougpVpKxRh
miahMr5Oaj6wS/o6LFBuKPkn0wUVMhWIg9noeEbqFdTw
--000000000000e33979064a8aa1de--

