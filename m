Return-Path: <linux-rdma+bounces-16922-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK2uIpgxk2k72gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16922-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 16:02:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B26144FC8
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 16:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A3B3303A878
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 15:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3297314A65;
	Mon, 16 Feb 2026 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RyUC6TIG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5B3148DC
	for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254053; cv=pass; b=IRetDbQnOdjsFIYERm0cc7WpfbfCjKWuTHvDmd+E1OakrmZn+dgazepBaGrOLcISoWXItDqcDheiyDLPFHYgvvjvq0eTrv3Ta5LnNjGPxwFctJGhwF0r+LCQI34o2vSqNI8+w0Y8a0azME8uR76wRbEOpQ9Re05kLVkK7h9e0BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254053; c=relaxed/simple;
	bh=DoEBT8lNBs6l2TbeB7v3Ffe5iJf8Z+5igEkTvQKgNrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5Wb+DYRYpJJVQCiJzWi0mhC7ykhAE3uk68bptal+rv1Ba39tC2tL0NO4GKRyyYqlji2GeMg+nH82kd4WAWQBIZV5vmIfi2D+FlT9eZsmg8WzR7qKGtzu6as/jYtQ2kGIsaUdQflLqtPurDLRDu6vBj2I51V6uhuh+UcP9JQA3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RyUC6TIG; arc=pass smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-89577f866d6so41538386d6.0
        for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 07:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771254051; x=1771858851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32aLfH3ojFZFii/LpXXLNDRCp8pNIv1k7GPDSWuRr0Y=;
        b=qb2KuA6CX/g7yZmqz5KIqnNAshlKHLAr1mmiesXQAVaRiXG5W3wcu/LWtLaE4A7iza
         ML9OAUvIpn8D8L8+MRjS29vVULwNQ+pv6gqVCPpqRPXfrGafT5zm585w8ipija2vZru4
         Eetn2bWJmGT84koXPEU5pu+1ak7xlLCdEN2E1plU7iNzzvmWDqdJHpjSRPHXcPHWVu/X
         WbWXjWy45UOG529dZJ0sIYzTNCblk2N/jFHqDRKunOJKoJe0onmmDKSXJVpxhOw02i8g
         noTO0f1aBxTua/OnSwuEnURJ/FIirQAO+26B42e9x9MV3nOVwLgKXQgum9DY3OZq4y4m
         F4mw==
X-Forwarded-Encrypted: i=2; AJvYcCWkUQLLAkjAp3loY1rn+T8UCaY2ZYEj0ZJB6RK48+v+sfsghCCw1Zi+DhOpIYyQ9pA66WgylqyBAGhN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/u+t9ov+yDm2RpUi67EBgbFNT0WXQFyFtOL8Yz/tPfvFK3w0X
	fqFev1nT2kQ1XSbisG9L4Zc4v8t7S1FDaAaycH3g+9U4Fn4IfEuRvR7jpw++APefYPNKwHDV+3j
	J9s0Yd6Li7rLTJ9GMFDlOXItPUoVQNTrKnmwbswbfcFijbdYhLTzMgvxBX/dCFrFqzELYzLcWfp
	t8ht7uBJTgDxG/uhlJhy+Mqv/GQ24M4s+p9lj4pxZTcnoHbSjQs0GT8UI162ASBh2Nd6E82fJWi
	25i7RY1bE4J4Y7+2ddI0+tTjdPH
X-Gm-Gg: AZuq6aLVYTIOMCVMcKf2nHGmBxX2qR/Lgzh0n5uWb0nrwEu9hUt5d2JHrtQnOmPDxIA
	61l0uL5Iqx0cu/uqjC5JW7QV8O4fDGDYizHQnFUeUIYM75K2ITq/geUTfizxqm43g1vcKJkQ9NR
	qwABcoMXsL68Cd+T4YneRjmcsX3lY3LIp4/lFgVvQdD6IKGC897nZWNSMy9P5DEHfko2rSbkTIc
	BStOkAEthadEiI00bD5vR12S4QtDrmTRu1ae5cTQpQpjjIZ0Z6Sgi/iscEm2bHCYZG6Evs3m3v3
	HK5ASV/T0egy8sG9Pi44W8aBQMq0vL+j4e+6azpT8KRr1j57SYmtuZrreBZK5NWGQNhnDiA0JdG
	Ps6hqzZgt+BvpwHeSuvImCCvsPQ+MmIgiqqPNBtiHJPSynFOieZE53Q/ZOq415wS6ips5TzkCLR
	sLaFsfGU+OWpFLPsquNUrsPOKHlB1atK+iD7IYv02ykgJkv2sghp36wABFSa5Th4jDKe35
X-Received: by 2002:a05:6214:2389:b0:895:4aee:ac8d with SMTP id 6a1803df08f44-8973f307240mr106034756d6.21.1771254050514;
        Mon, 16 Feb 2026 07:00:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8971cd57ef6sm19966496d6.23.2026.02.16.07.00.50
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2026 07:00:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4368060a5e5so3684862f8f.3
        for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 07:00:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771254048; cv=none;
        d=google.com; s=arc-20240605;
        b=RiJLRnix/x5lcjUSQ78sCGwUU7k1ozBMDlO9xnJaga3qAtRjvyDLD6Cyln7P0GQZm5
         Oi2GVnTPWUsmZmLW0w9YzDf8J3lqvcYa+6hjxUm7iUm08Nrmtjn5l/5kSvPO3QJ6AZHr
         MTcP455zY2kNmOoXvvaKtj8K/AwnSui0u682FQScCWnvLP9hOwpZoHZMoGvFfHz6Z6bp
         p/N55hYF3C6nKzN7so87nj1AeszorSXX14aKhbMjHXTGMiolb+rBJ+FYgmGknpNqUgc6
         9Te6shl/EcvG4zpYw/4HqVmM9ZtT5LRyunvs3DiP4tAp7EKG2NHwfcZcM73U7yeaR2HQ
         86/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=32aLfH3ojFZFii/LpXXLNDRCp8pNIv1k7GPDSWuRr0Y=;
        fh=bWLN9cGsUyYgy3UpLMg0QU9FramDI65aWiD3YNzpfgk=;
        b=hE17Ni9MkLXp1tULn2NGxKr/3Rk3mexr8KH5aNHSq6CPUVg9+jh4Ch2pC3AHedqhj0
         X07z5FFYyVnCHGdvGVAyBERLivbF1sN59tOXBSvJT4tyUNqqmJsSA+fgOY0b5OUtilMY
         p8HkWiCWFRHnmexIcjMU/TojvjosAquVzJhIA0+gROOINlgVfW+GnyHQd/X2CC/FQh72
         Eqob7CynAQOd1rN+EU0FSkk/IaIlVz3nzXYgU9R4CaqcCDE4sO5Ro7a24bQ1Gp1O8nDR
         xXI/3iBGRXVhtTwwCuf+Y3zk3pO9R4n4MpIbh5smAmYw3x0oVBt/dexqnfYu2fbpYPNV
         pfDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771254048; x=1771858848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32aLfH3ojFZFii/LpXXLNDRCp8pNIv1k7GPDSWuRr0Y=;
        b=RyUC6TIGham/1hRxbHWaxbtdCcn9WTXLsR8jtRkRIrGIOQYd7rkPBOXfpS2+qraBDo
         sUqT7krkn4tjocZQcTuI76WWjscu0QET5YsUo6ue8BDBoHF1Eb4JjM2X11ZEsHLYhr5X
         9HFdt9j7Rvtz7WBgaQyYsXdZ9UJrT6F2lkwNM=
X-Forwarded-Encrypted: i=1; AJvYcCWOec2Yktbgp//ZUUghXc33ALWx93hDg0gGqsyqs/IzDEmSS0wX+dg56eSxKCU9ld9TvdsuPHyznRw/@vger.kernel.org
X-Received: by 2002:a05:6000:2508:b0:435:930a:658e with SMTP id ffacd0b85a97d-4379dbad82fmr16331159f8f.53.1771254048194;
        Mon, 16 Feb 2026 07:00:48 -0800 (PST)
X-Received: by 2002:a05:6000:2508:b0:435:930a:658e with SMTP id
 ffacd0b85a97d-4379dbad82fmr16331081f8f.53.1771254047591; Mon, 16 Feb 2026
 07:00:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211124927.57617-1-sriharsha.basavapatna@broadcom.com>
 <20260211124927.57617-6-sriharsha.basavapatna@broadcom.com>
 <20260213111256.GO12887@unreal> <20260213145425.GN750753@ziepe.ca> <20260213162211.GX12887@unreal>
In-Reply-To: <20260213162211.GX12887@unreal>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Mon, 16 Feb 2026 20:30:35 +0530
X-Gm-Features: AaiRm53aBMg15ZAqpxXkqG9rpjD2Z8Eiac_loIx4sDkjg6Nlb9bpZTwSccgzNXI
Message-ID: <CAHHeUGW5L_qkNv7y66WXK9f2XzH6Ja=uKnH5fFOTv_HLqo1yxA@mail.gmail.com>
Subject: Re: [PATCH rdma-next v12 5/6] RDMA/bnxt_re: Support dmabuf for CQ rings
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000610e34064af238c9"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16922-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 09B26144FC8
X-Rspamd-Action: no action

--000000000000610e34064af238c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 9:52=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Fri, Feb 13, 2026 at 10:54:25AM -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 13, 2026 at 01:12:56PM +0200, Leon Romanovsky wrote:
> > > > +int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_=
attr *attr,
> > > > +               struct uverbs_attr_bundle *attrs)
> > > > +{
> > > > + return bnxt_re_create_cq_umem(ibcq, attr, NULL, attrs);
> > > > +}
> > >
> > > Please don't mix create_cq and create_cq_umem.
> > > https://lore.kernel.org/linux-rdma/20260213-refactor-umem-v1-15-f3be8=
5847922@nvidia.com/T/#u
> >
> > Either we drop this one patch and put those 50 ahead of it, or we just
> > take this one and rebase the above.. The above has the advantage that
> > it enables all drivers to support cq dmabuf in one giant shot.
> >
> > However, frankly I'm getting tired of looking at this bnxt_re stuff so
> > I'd like to just see it done.
>
> In addition, push them to create 2 separate functions.
> One is .create_cq_umem() for uverbs flow and another .create_cq()
> variant for kernel flow.
>
> bnxt_re_create_cq()
>  {
>   if (udata)
>      return bnxt_re_create_cq_umem()
>
>   .... <kernel CQ>
>   }
>
> It will allow me to rebase my series more easily.
>
> Thanks
The above change can be done as a separate patch once the current
bnxt_re patch series gets merged. I can push that before your patchset
is ready to be merged. If you still want this change in the current
series itself, I can do that too. Please confirm.

Thanks,
-Harsha
>
> >
> > Jason

--000000000000610e34064af238c9
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC73Y2GTpNv8gDguEVp3k4L2vV4xBa89EBL
9yt3J6j/7jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMTYx
NTAwNDhaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCOA4lnEG7RimzIsOToWZWtd3tb9faX5LOI5+VCyokpsn7LZ/y3r+L6FshIeS33Urt1wx5f
TOqQ/x3kZ3PFOeyoUowJxUrHJiXji9ZoQClnIiAhFJv1/HEJ4QKUo9prKYuAU/7l+dqupOrNobdn
8HkwryYXNojGuqolj+LNhCraJOHhtQhier1zrNW14rflWQAZ0YdrUxF3FjaLm7sSu1pWUnDN0Dpb
OY8OtVflLTq89gMz1TpukB0sHvfZR/zmmHVCRvx0EuhCe/M+7RymVkae5ATPFRuWCl3w71bm1EHR
AYUc4PL+OvXxulf1Hm+QFet4aQDVQgyeIsyKlAsIBukP
--000000000000610e34064af238c9--

