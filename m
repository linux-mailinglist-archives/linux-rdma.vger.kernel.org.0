Return-Path: <linux-rdma+bounces-20966-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGS/G+1uDGpKhgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20966-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 16:08:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F5658045A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 16:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C85543074007
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1377C348C75;
	Tue, 19 May 2026 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UYxkTtEZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C48370D6B
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199165; cv=none; b=mw3QsLz/jfXAwM9KdcR+tz81Rf+an0tWo4uKjSQpvF+E03KWXnQ8pTqXaDXNImddW/KnTSWRz2ok2XsOdP7Lxaka/rhMOMvJyK4MFSlEbfv2GjOCPMcmXFhp6WgzBzTyWSY++eWjbevgldKZeZQrIPq0K8w+JbtlvHNx0S/sGMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199165; c=relaxed/simple;
	bh=jEQ6n4me4eqWSwcz2mW4d3F4Ki9SLD+2qPX1S3TLrS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClDqV/P6xQo+/HHGkwFJcJ5TplJ8k56PVQx76HrVr3n4rr4UL9zuF0WjN2pUCDxNkUd3wi9iGexj+iRdzOORKklY+G30OAyjEH7rA//iVrBPw/jUrKnfR7az2RWKvdNCZkH5zLxmC6KLKbxWM0BuYEo0KajWUE3w6huX5tWtuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UYxkTtEZ; arc=none smtp.client-ip=74.125.82.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-12c1a170a50so4385222c88.0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 06:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199164; x=1779803964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+Vv0qZebdQTKpo54P8TebXSeV5YGyCQdzI563JH8gQ=;
        b=KSJgDDWrKWiOA/VvcE+ANvTpMenMJtwmRPKqcoCc8x7ayjPbmT4tbcwA8B+6f1Ue9m
         XIZl7QVugLYF5o9hUPSjLGm4vCtbUdH2vqr/qZGUVE82qnWy95f/RMMtZ/S4vaU4lHzP
         pvhMTRkndhEWmvZRZ4H6oh/aaPosujKvAG/rxP9aU+uTUycrSMHt6o8q80u9beq/VePr
         S05P3DfuKwFnJgUwUAxw59pZ/mf+EeRMWqpFo/nnqNmAt96fPFbzBh7AWwcEr1hZDk7N
         Mnk5bW0xbApo54uy0+2rWzd5vBQnQF6A6av+FM417ziEmwx9PMIrQOxmFe9/VXKgxW+D
         3adA==
X-Forwarded-Encrypted: i=1; AFNElJ+LZvqniWyXxt+/g0/RXnYEuaf5SyAlwm8aZzvxGmoW9HzINZTKrjlM4hOLnGahNXt3h0TXqnIcGTMO@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqTbzkRt1rGq+S30smGdrO7cFPCRCz/LMl5C/lzVckIMZIzD7
	a/TmblXqvdaKXs9DjaBHxj8hVqaLR9VasXlj2frHEFmRMgKieH3GmOmnm1j4Hbkoats3nR0mtcW
	h8gExcCsqwFRI8RJ/rv/imKkQ0TJEsOUBUuGwYnYthajIAc7f6w60caYMVhhHymrJG9lEAZSN5+
	a7/+w5YmJCIGdJp7jlOQnqKb6IUUVpsN8BPFwbnc+bqDSBkKJrziqZ4jKFwdDywFMoynEjz2Jhb
	1BXdaxmikw2r27hHepdTp6ANBgu
X-Gm-Gg: Acq92OFm+2UmIvOEm9h4f01mYIqvW4GVrTkEVAhXU2KhhVgrQNC3YBn732TpT/k7R1m
	EuhRzxkFAfbR3IAqtyLabTIKYxy0uZowFQXolcA3DJuVrQwqnIA38XaqluXspJW+D9XfVJt4z+T
	Ybtx3TYkvrLjKqciVjBvg0AXAXCgaOgyk7OQZ0IsVtyhNqWgdIqgQJdo+KeWYTQqncHHal/YexV
	183nmqn+EgAOpNfOhDlaVHnBWA/Fsj0l/22GBBGqtAUXJ2iDKsbLTWwNEwrDy43QsIjvJQE6s1J
	1uqD038Ho6li7nnnjJL7S21r7rwfAbcvOqhIykPyXZ2Q/D3KTP+lNPhL+HbPDX9ZaciGa66Qrld
	h0/ve6tnx0WMH6jNbRVN5U1eq8gZvhFMbmMo97XF+en7apDMS1XUJAVimWP/1GTreoJzkssLgJZ
	QznmE7z83K3LdIhZuVBHLGpZ02SEvHKXHKD0xkqvnj3l3utjo61OwpeBclqs6EfKV0MvM5
X-Received: by 2002:a05:7022:251f:b0:133:1d3d:f93e with SMTP id a92af1059eb24-13504a4f6bfmr8591933c88.42.1779199163384;
        Tue, 19 May 2026 06:59:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-134cc112e38sm1862633c88.3.2026.05.19.06.59.22
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 06:59:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d789cebcfso3096829f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779199161; x=1779803961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J+Vv0qZebdQTKpo54P8TebXSeV5YGyCQdzI563JH8gQ=;
        b=UYxkTtEZBFfgU4dhwJga6rm7DEwFaQU2glSh0yFK2folVY8FlJ4CB4NzM3kHCQcBO4
         t9/1c3KP3XEsoxe1iseszX5XJY++E9/FbyRbWki5NhfkQt0QNvYAwFLyY+MkARz9TlGx
         50WgngKCIi8A0lBWxWVtAhAY/EloO6l7YTwIM=
X-Forwarded-Encrypted: i=1; AFNElJ+++vxH9L3Vr+1wipWzv/RB8votps0mKbEpZdO4tiBQ4CE/71UD0tr5YxXtGgtFkIlJUq4c5RKrZQVp@vger.kernel.org
X-Received: by 2002:a05:6000:4308:b0:45e:8ad3:86a9 with SMTP id ffacd0b85a97d-45e8ad388bemr4723881f8f.8.1779199161259;
        Tue, 19 May 2026 06:59:21 -0700 (PDT)
X-Received: by 2002:a05:6000:4308:b0:45e:8ad3:86a9 with SMTP id
 ffacd0b85a97d-45e8ad388bemr4723821f8f.8.1779199160684; Tue, 19 May 2026
 06:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
 <20260518153721.183749-8-sriharsha.basavapatna@broadcom.com>
 <CAHHeUGWK_2RNG=CaHTnNh2JeAXa9mcTam6p_7Qp6eG+6Nip+_w@mail.gmail.com>
 <20260519124600.GX7702@ziepe.ca> <CAHHeUGWpp8n1dHAu=MfYiLhntzK=PtvNyRBHhD0W9KkthEgYUw@mail.gmail.com>
 <20260519132730.GZ7702@ziepe.ca>
In-Reply-To: <20260519132730.GZ7702@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 19 May 2026 19:29:08 +0530
X-Gm-Features: AVHnY4JHhUKsaCWxyMYNIOjYVnYilaUlVOwvJ1qdCkI2IgUcMvLs-ahqbg_RN2Y
Message-ID: <CAHHeUGUeQssyz2fsb_aOzgi=wu2KaCyRJHU7vBC=wk4XRbpgOQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next v6 7/9] RDMA/bnxt_re: Enhance dpi lifecycle
 logic in doorbell uapis
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000349bf06522c16c8"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20966-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ziepe.ca:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: C6F5658045A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000000349bf06522c16c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 6:57=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, May 19, 2026 at 06:50:38PM +0530, Sriharsha Basavapatna wrote:
> > > > ufile_destroy_ucontext(reason =3D=3D RDMA_REMOVE_DRIVER_REMOVE) -->
> > > > uverbs_user_mmap_disassociate() --> rdma_user_mmap_entry_put() -->
> > > > rdma_user_mmap_entry_free() --> ucontext->device->ops.mmap_free()
> > >
> > > Yes, that's right. The disassociate removes the references from all
> > > the VMAs so it should always eventually call free.
> > Ok, so disassociate() triggers mmap free in the driver while
> > ib_ucontext is still valid, right?  The use-after-free concern raised
> > above, where uctx has been freed, shouldn't occur?
>
> As far as I can see. At least you would be in good company making this
> assumption...
Thanks for confirmation.
>
> > > However, it would be best if we didn't have this code in the free
> > > callback at all, ideally the destruction of the object will happen in
> > > the uobject destructor not the mmap free. However, I think we lack th=
e
> > > ability to do that right now.
> > >
> > I had to move it into mmap_free() because a prior concern pointed out
> > that the dpi could be reallocated to another process, while the
> > original process's mmap is still active.  Although the bnxt_re library
> > unmaps first and then destroys the dbr object (i.e in the right
> > sequence), I still tried to address that concern by moving it into
> > mmap free context.
>
> Yes, we lack the ability to shoot down a single mmap_entry during the
> uboject destruction so it has to work like this :(
Ok, got it.

There is another concern about exhausting/hogging DPI resources.

"Does tying the hardware DPI slot lifecycle to the VMA lifecycle allow
userspace to exhaust the hardware DPI pool? If a process allocates a
DBR object, maps it via mmap(), and then immediately destroys the DBR
object, the uverbs object is freed (replenishing the process's general
RDMA object quota). Since the active VMA keeps the mmap entry alive,
bnxt_re_mmap_free() is not called, and the hardware DPI slot is
leaked. Could a user repeat this process to hoard hardware DPI slots
until the device's entire DPI table capacity is exhausted?"

Even without this change, the DBR_ALLOC() uverb allows a process to
allocate multiple DPIs (that are meant to be distributed across QPs).
We don't want to restrict it. Again here, the library properly handles
this by unmapping and destroying each DBR object.

Thanks,
-Harsha
>
> Jason

--0000000000000349bf06522c16c8
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC2GtfI3ZFKiXO/2lwSCJpUPAykFjKQSxKH
4kdh1mYG1jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA1MTkx
MzU5MjFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQAM1gnsUuWVCf5ge8rRoV/0aDyzo0AW9O++EuK1zMrn4r9n2/r3v8Gj/lUpd4gc5+ttukx2
xZrw7Ko29x5MCCj+NUjzeoQksHT3rzeB2lSfwNyvo1+EgwnuoM+QMxc9F4NFMwpqX2Gd7KuzBmlH
bejybokBOfJEcz075NUeOQE1tVYaud1AJtkQwaecbn4np4YxakDTP6+bjnAImoYONIkvf1FwQU7J
tZaYJ0xLgMzBsJoV7m0gaKs6bdASLx3p5LJZxDHngNrVcl8j7+wmCwnW2iSqIqAOyB/I8CnKP7z1
K3KwIQ4JaiFRoN8Uk6+qMZr7gXFjBny9NB7FeOH/++AU
--0000000000000349bf06522c16c8--

