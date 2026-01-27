Return-Path: <linux-rdma+bounces-16076-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eItTDVO4eGlzsQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16076-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 14:06:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7705C94A59
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 14:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CCAD3026ABE
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 13:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3B4354AEF;
	Tue, 27 Jan 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SeIgNw8m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057862ED846
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519085; cv=pass; b=YRftRSdtRcP4UCn5HwY2a3pRIa6amT4ujEqCLfvxgLYt7yYFqB9Cs5LdLJz450u2NJAvoHWM7X6bqwXQ20BZCCb/C+A/TtutJ0ZhDD6mj1jrCexiBVuMrz7LsXeq6zyaEi88OwMkNRQBuuta5iUQ6s0Q2Zm8J+P17S7Oj5eclyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519085; c=relaxed/simple;
	bh=capNkUWB7CIgMuo65Q6O5YPRf5qRzkvtsZ5BGps74Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZmBnuBEwRYOtosTHWQzAoHrL2k9p5nsbWMQYcrkVGJrBHVkPsmBzVkry2r+PKASDCFe2PwAsaLNsOz00ib6lepVL7pMLKdNEE0Mp9sUkzol0YGseFMYzWMTch/4Y7TjJ+hsrf1Gg/34uDI8jZZVWhwMF2/u7LS5tWvToMdhvnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SeIgNw8m; arc=pass smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-89476eaaf16so57494486d6.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 05:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769519083; x=1770123883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyaxI/9FPuzdvR6bhPBlpP8aaFK0j/2vLqhvBXzksJY=;
        b=EuRRnnK59O7jvp2S3tVkl6YRwuUnlVf2KBvUi+Llus/phLUMnV5nE7JQINmNdRkwOa
         pvP+aP5jQ8pIUWwaWbu2GY2T7WSBWLQtsCZ0LQBzkBlruPe+CHQJDui1tWqo20YyR7sD
         +BU0zJeBmld6h3Ah/fZGcC1qic1sFwxtz2mq3tn+eyJWDrlaut4oW5f24AFUAHgxR4jP
         k707lA+h4YiBYOmrR8/NX6XHSrBa4V0euzo/k30XKaO66oRtjiflljrd1li929/Jmb7x
         qF30pUa3zwPXAuCdvJp3+K8YFRLPqszankL2D4VS3OhWRG5+d5Aze25lCFPOOKca8dUj
         cYrA==
X-Forwarded-Encrypted: i=2; AJvYcCUVpA9WW/Z+wWMyv7RN5ab9L9Ewm1JsG8k9p8pkOJqNndvp5zT+toylpU2fudInfwGfhipprfmqNPbV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhga+nlY8nixdytSV9ztctgEGjQ4OpG0bkbZHhM+U/rNvdKG6F
	5/UeWQVA3crd4y6lfExnoxeJfM2cXAP4u2M3f2bKYSiRX+QJ4Jyj4W/wleMDQqsiAnhK7vqWdww
	WFdRJ2j9UZDvdtDoR2HArZQdPmM93MqKOI2R5jwi1otzLHA24KRHYrtq1MYszn2haNFUMQhe9E5
	OPdTLEXXTuyzOPUwsfFFAE3U/PGrgUDQTR2Hqnf9Cq2VDxxFDVKjg0U4U2hmnX2ti5FLPJY9NBr
	SFW/CWQTRpfepklty3Hct2HFxVD
X-Gm-Gg: AZuq6aKoK2yk4ce/d+wo7FL2g0XVdv14CgzL7EF7ti3q1A1aWf0gTffSEXCErMcxuwO
	lmx7NEhvvuA+b804EgOwlsjnITVSc2LyBrGXIHcjbeQt9ySf3te9Fyqe4m6Ha6a38rpu7qQI6q5
	umcELVgIIvkMunMQVKeX5zedUXegz8eNiZiL+d8aP5+gF1GYCyOYRxLRXA9mCoWIrfazNagj1Vs
	sWNazTFXUixDGj7LmQ4+47Bsm0s77BnMTjAzdpLLO2naeMr0LKrA0x9raYX2mYqYEV4ePrm1AX9
	bbt/COXo14UakLBpQpVRwvwnd1IWm58HbRQtyRcp3E0+jp1pwTA1JI5dXBbAmGE//VRWO/uf0CU
	NAQU8/1k9frW1T9oSfvPL1i0NGHxAZMGVhE7YR5npbsA+mXN4TcdT7MTdLR3YHk7C71NNlP4Ti6
	+tEi231Q3ZV1H/Fb9v6PUu22PBCu9BQEluedzsvsc+HP8dDHbM4Z4Q1w==
X-Received: by 2002:ad4:5cc4:0:b0:894:6e5d:eb8b with SMTP id 6a1803df08f44-894cc95c948mr20426706d6.62.1769519082906;
        Tue, 27 Jan 2026 05:04:42 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8c6e3820f89sm125409985a.3.2026.01.27.05.04.42
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jan 2026 05:04:42 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d5c7a2f54so66981325e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 05:04:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769519081; cv=none;
        d=google.com; s=arc-20240605;
        b=eoIGNB3E2Q/ASG3OvgAvAiRvNbQTqsfY3e9u9spRx5882dNFcCetgMXt+E7H48Tlry
         w6vu/saa66dXPQcxWt61BpGDztrhme/on3vW5ddhLyjdAmwp59V43pInG5sjdo6W4Ou0
         WbBsyxGKK2uDDMn2b15XvnGJszQkMIINYApr4RdHbBexnyAthAtJB9nfGfTuqJXXPvT0
         NQf0HdKaNJSjmROKSoJp7mzChgIxdjr/QmV6G5nsl/mWET1cPOmPjTKLRMDRFLA477pQ
         ufYz8Zof2mSZttcFHT/rVWakqg9ogrnBvxGFLifMK9SJ/qPjpqSVmeGqTN68HixTKd2C
         no0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xyaxI/9FPuzdvR6bhPBlpP8aaFK0j/2vLqhvBXzksJY=;
        fh=TCFb8qMRMgw/sIp4z529zPLIpWSZJR87hZWJLm2G0s4=;
        b=ING+ktwDUNgzwf/w4NvZaxEoZkrDpho0Ijqjkckoh/58m859xaPw1Y4Es0UxLVv69N
         3WVFqiqi0qiuMDuSnTaUaYrqYcn3dzVFuyLgmWnyc/Xj0LR+2hvyaVcZvs8GcU4giW1d
         9HB3KQD3A8MjWkwdW4kCRPemqRyUdk0QhsLUZcSPMhC/afMosUJMmPJs0TTEADt/vAqg
         GvHC4lHjmiY8+G4YvT5C7sIZvB5lPNXFv2TSjmOkSSbLLz4cjIys9z9LF7D2oy+wV5QY
         Ddh0n6/exlXGJL+4kzVRR75Ijm/KCVi7xh1nkHz6FEDRS2VTQ6j2SiZx2i4yGa+tUFi5
         N6ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769519081; x=1770123881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xyaxI/9FPuzdvR6bhPBlpP8aaFK0j/2vLqhvBXzksJY=;
        b=SeIgNw8m7WGbW0zUJ/MeA95Bq7EC2Rqpp/IIqDgsKUsucl/8E7btSKtoebLwnuCctR
         lxSML+awetiGP/64byZ1SrtteWV0hi95tHEwTIYbqoHRsDLa8MJHYH++cMf0mHOofDH+
         3DWABk7wfNIEMHMJeP20KE3Z0NhQ3Lu99vXDc=
X-Forwarded-Encrypted: i=1; AJvYcCVRmAHLD4fvFHPLY3whJ8nZdIzMRNZh9sc6KzkpXeu274kxT2POpXl7vlrCreOsiISD/6MWJ2Ll1+yl@vger.kernel.org
X-Received: by 2002:a05:600c:33a6:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-48069e0fd24mr12907505e9.1.1769519081353;
        Tue, 27 Jan 2026 05:04:41 -0800 (PST)
X-Received: by 2002:a05:600c:33a6:b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-48069e0fd24mr12907295e9.1.1769519080908; Tue, 27 Jan 2026
 05:04:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-2-sriharsha.basavapatna@broadcom.com> <gn7se37zhkzzlarasfr6akpojmigjn7e3mpacusnqgzybysj3h@vmgfsazrzl32>
In-Reply-To: <gn7se37zhkzzlarasfr6akpojmigjn7e3mpacusnqgzybysj3h@vmgfsazrzl32>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 27 Jan 2026 18:34:27 +0530
X-Gm-Features: AZwV_QiOnArks2r-fE37qNaweAMpPQeIBf7g92eoqTCoNxI1omFWUfxu3fJEvCk
Message-ID: <CAHHeUGXpvj0owS6Z7Y53pxzf_MwT0EN6OdXqYN6Z-AbBXG4gVg@mail.gmail.com>
Subject: Re: [PATCH rdma-next v9 1/5] RDMA/uverbs: Support QP creation with
 user allocated memory
To: Jiri Pirko <jiri@resnulli.us>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004991c206495e44e9"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16076-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: 7705C94A59
X-Rspamd-Action: no action

--0000000000004991c206495e44e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 5:42=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Tue, Jan 27, 2026 at 11:31:05AM +0100, sriharsha.basavapatna@broadcom.com=
 wrote:
> >From: Jiri Pirko <jiri@resnulli.us>
> >
> >This patch supports creation of QPs with user allocated memory (umem).
> >This is similar to the existing CQ umem support. This enables userspace
> >applications to provide pre-allocated buffers for QP send and receive
> >queues.
> >
> >- Add create_qp_umem device operation to the RDMA device ops.
> >- Implement get_qp_buffer_umem() helper function to handle both VA-based
> >  and dmabuf-based umem allocation.
> >- Extend QP creation handler to support umem attributes for SQ and RQ.
> >- Add new uAPI attributes to specify umem buffers (VA/length or
> >  FD/offset combinations).
> >
> >Signed-off-by: Jiri Pirko <jiri@resnulli.us>
> >Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com=
>
>
> When you send patch in my name, and you do some changes (patch
> description was not present in my draft at least), I would expect some
> off-list handshake. Is it too much to ask? Looks like you are in a big
> hurry, that never brought anything good :/

I didn't know you expected an offline handshake, since I was just
updating the commit message (and that one other line I mentioned
earlier). But please feel free to suggest/revert changes or if you
want to push an updated revision yourself, I'm ok either way.
Thanks,
-Harsha

--0000000000004991c206495e44e9
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDy1yIs6RdaJ/T2L9ezkP2waR9PPBoiXvF7
3GGzexB1VDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMjcx
MzA0NDFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQAPoIW9qGlG0Z2+nC66huwXne05NqtyQIiD2HFkwX7CWW142GE4IJKa2+ovoUmXfy+R3FO/
b/BHGhDLIH8kbX5IJyR2JTJCGXZUY/c/yeI24Ld1MdWFZhDH4P33mBKcvIQpeLRt14ZNTtNTS5j/
ye23QHWC9NQQ1m1RmV9IKg8GYGsEoyQLaY/vg9rHlFw9uYdyJTtO1nXughJnym0V5HzhpaDZzOMP
p6s+0KyMbcHj2eIsC4bJWQmDFsbNsb27Al4u7oVQPQmw3ZZNX5GO0rHeqcohTiWkQxGIp6DzjM4E
MYy7y+Uq9jw4nqRtx7F5L4+PSyN4TUY8QARTK/Wt0jpx
--0000000000004991c206495e44e9--

