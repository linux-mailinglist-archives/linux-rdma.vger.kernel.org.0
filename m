Return-Path: <linux-rdma+bounces-15519-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FA4D1A8A0
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 18:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FA5D3008D58
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 17:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2F12F0C63;
	Tue, 13 Jan 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ep7MIYa7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D465E50097B
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324423; cv=none; b=Migd43e8onveaX+cO9nHKI+ktNRWG6JYjY2qQdFvC7IyjSvmHBSfBVU6k2GJ3n9HbeS8Hk/Sjt7C1ygkHpcASOOxQXY0a8Bv4HmlbFrchf9sg46IQwPUsW1rH3BMpynCJZPftNx23r3pBo631VZhu+/tylfBd/Neo88eQqGAuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324423; c=relaxed/simple;
	bh=4jgDtPerRleXB2GTBCHZFsO6KhVkYWnG/fa1J/jLvQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7ZKi1zeVecPMKQOahH8EnMV+EMetkoea9nE9DQahBIHlUsjbAm500GUuT7BHj3s6B18EaryUR1RC4mzSKcEEuigbpPU8FEoIomL/KIJ1OFqZ/3MtcgMCtAMwrBEQ8AzrKzS07wD90o72hBEQzIUnCECKrZYv6EhN67L+1Ysj9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ep7MIYa7; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8b21fc25ae1so848184285a.1
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768324421; x=1768929221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vWk82uiEOzKdO/4w7S2ixj6yCUNnC1DsDFU9LOZN6M=;
        b=FbA8GqkgHBC2L6HdtESE1RfaSnCkbJ3H8BCMqEdNQ2H8iAxrCFYk8KqOyblF7OqT8Q
         fEcE69TLWVPmZcajsPq+5h2lbF8d/F4f3mgu6/2tw5jnB4/BZwvJ1r1pbq85sVj28smX
         DTGDZAcCeBjEmqko5p4Ym55UUKWYoWjTOKSzO2dxwF0ZNNROvAiWt+jOS46bPr7tBawG
         TNUyDxWEVWDkGMAQO1ZD+o32i1Ap55hiJ9lcHpNsEIWlODZX1mXaU1+cqh0tQo9n74D3
         mZ2s0YLnLAFrXJDWCfsK4vF9aDmzsV68b6GYPm5AX2M8TVvZeREhvjDXrV5v8YeqUA2b
         mwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr8Qe1YUwe6wh1w3uGfYh9L0aepcqSx2gixw3UsjCOvOcRL/Z8FG9Jx1rovRKa7UlvH7kspW242LAs@vger.kernel.org
X-Gm-Message-State: AOJu0YxsprviAHi/21bAUyuACklBQMjPpzFKY76iFtmGyhyjxN6LjjHq
	WE2x/SrzgaycTvKDgOlw7r4p7kSKqVNnaDuyrGCfjPo0FSAOFGLluKlse0HN6mrwPGloiUjm71A
	zVgeyjBXqg8JbNd5ObbqFj+yobWXVE/INaGzzTI+jGLhCO88RmeFWVP96+wBd1JA6PZADMqLtdt
	LjfYKbM/xJhw3K8TO5Es/25OLlWe9XP6RbotmO4nM/gB20uoGfXpyocpub/Hx8EgFA4FynmykpD
	Xp1cnMXOY1IqhJa/vN2RKLu4Ofo
X-Gm-Gg: AY/fxX6i/CPNQZqLBxBV/O/slJo3Nta3xFz9jV5BZCStKzmv5z4du1j83KsXpGcXKk4
	3hJfZQjTOP5a24fS/L8qW7I+F0CF/b0jYVNc2lwjtSoDKNbaevYfo47BL11Ad/jh4ra8w+bD4pb
	BEvJUbeKcx0LXGfK2HCmzsUJaCtwD1uLgbQSorwIUvWc8e+uXqHkIyqg80zh2edFCPZyfSEgC5u
	7vg/JfMcFqQKppAAShgeAyUORAS4bb90BWvb0DNaf8yQPycmPYnznSAev4sNHppDdinz9qexYhJ
	wDbLnzCN2I6RrkzYVbsJ42ACfaVd5mleSrMNL//eK0MEaBsvFw+UiuiNWouz336anDsDygaFNc0
	vb1jgf7rxmfIjDRfkcoXiucPG1QKSiD7gCuZML3d3FAYBOVgnJ1etavjys8UnM7hmd5yUi981bh
	AKjIj0
X-Google-Smtp-Source: AGHT+IEAmSmCMk0saGbur+067JTfdPZXPwy0t9xAk0AK3QHbWSRbBQ0Y7vdvpP9CklWrlYQht9KiejxKaFL1
X-Received: by 2002:a05:620a:1726:b0:8b2:f26e:3222 with SMTP id af79cd13be357-8c389368984mr2755074285a.13.1768324420665;
        Tue, 13 Jan 2026 09:13:40 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8c37f4e2587sm237876185a.8.2026.01.13.09.13.40
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jan 2026 09:13:40 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d17fff653so34716685e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768324419; x=1768929219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4vWk82uiEOzKdO/4w7S2ixj6yCUNnC1DsDFU9LOZN6M=;
        b=ep7MIYa7niLjmn+BuraU8VgSLb5VPCMgelfAQjdA4GMhoc8fpFvS30wjUMukmNOZ1I
         Ghsdas9Glp94Z8x5BR2LyNQIEvTYhvNKBehVTTw4+FSl43/rorLgZWfRr4gtR6fVFtAk
         Vkjk+fkE+91Tp2+rFHIGZSh59yYzdzrCtcing=
X-Forwarded-Encrypted: i=1; AJvYcCXkDiBpgp2Ep7mEcmIyhG1rAkVOla4vc/wbkKitRMRBAhHz++PyW+Z+duUQW8vssL6F9w9K/jnnl8LE@vger.kernel.org
X-Received: by 2002:a05:600c:354c:b0:477:214f:bd95 with SMTP id 5b1f17b1804b1-47d84b32f1fmr262006775e9.23.1768324419131;
        Tue, 13 Jan 2026 09:13:39 -0800 (PST)
X-Received: by 2002:a05:600c:354c:b0:477:214f:bd95 with SMTP id
 5b1f17b1804b1-47d84b32f1fmr262006475e9.23.1768324418779; Tue, 13 Jan 2026
 09:13:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224042602.56255-1-sriharsha.basavapatna@broadcom.com>
 <20251224042602.56255-4-sriharsha.basavapatna@broadcom.com> <20260109185037.GL545276@ziepe.ca>
In-Reply-To: <20260109185037.GL545276@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 13 Jan 2026 22:43:26 +0530
X-Gm-Features: AZwV_QiSji3bAIulmZOhI1pY7Il_oufUzhsOYQsTdvqBCSinkiZPsEB88hQJ5NY
Message-ID: <CAHHeUGXcaAN=4T8D9GrTqp7DR2trusdc0rL-vD7Bu1CEZfPsww@mail.gmail.com>
Subject: Re: [PATCH rdma-next v6 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000de89d60648481c87"

--000000000000de89d60648481c87
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 12:20=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Wed, Dec 24, 2025 at 09:56:01AM +0530, Sriharsha Basavapatna wrote:
> > +     ret =3D uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_ALLOC_DBR=
_ATTR,
> > +                                         &dbr, sizeof(dbr));
> > +     if (ret)
> > +             goto free_entry;
> > +
> > +     ret =3D uverbs_copy_to(attrs, BNXT_RE_DV_ALLOC_DBR_OFFSET,
> > +                          &mmap_offset, sizeof(mmap_offset));
>               ^^^^^^^^^^^^
>
>
> > +DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_DBR_ALLOC,
> > +                         UVERBS_ATTR_IDR(BNXT_RE_DV_ALLOC_DBR_HANDLE,
> > +                                         BNXT_RE_OBJECT_DBR,
> > +                                         UVERBS_ACCESS_NEW,
> > +                                         UA_MANDATORY),
> > +                         UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_ALLOC_DBR_ATTR=
,
> > +                                             UVERBS_ATTR_STRUCT(struct=
 bnxt_re_dv_db_region,
> > +                                                                umdbr)=
,
> > +                                                                UA_MAN=
DATORY),
> > +                         UVERBS_ATTR_PTR_IN(BNXT_RE_DV_ALLOC_DBR_OFFSE=
T,
>                                          ^^^^^^^
>
> ptr_in shuld not be used with copy_to
Ack.
Thanks,
-Harsha
>
> Jason

--000000000000de89d60648481c87
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC4sTMtbzxhEM96im4PkxPvMiCWfYwzezCK
us3j/Eb2FDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTMx
NzEzMzlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBWjTN7Rx5F41BDsANA/bZvFOXxfnSOTj9Smf7UtXSdChUdwFa6knGC/HXqVk6klhZ6wkIW
C/nVC930E4MYR7vx3yiyRFNmEZIBYrVxR1ThGWlXtsp0gbMFGCOYyUgMl4f1CH6hHl5oD0UxCQvF
HMS8mB5P+wnNjDVI7YF+WhApYM3/zv8elLA4X9tjdEmaP5laMXLPhvl8zzWZcifGXKOI0dAK20ke
Icr7dWpIOSmkN94s7gguGcEi0d7dY3IYwDTHIRTbt655sQX62OAzFi43L+gkgGkb5QMtIuIPvlSf
D4NDfkjcQwhEOdK5jWQDQ9JYGBkKfjd94KMJqRgEfvdr
--000000000000de89d60648481c87--

