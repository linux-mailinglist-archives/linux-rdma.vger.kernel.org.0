Return-Path: <linux-rdma+bounces-15907-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPUlHd3dcmmNqgAAu9opvQ
	(envelope-from <linux-rdma+bounces-15907-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 03:33:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E473A6FA9E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 03:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B90F33028375
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 02:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B0A33EAF8;
	Fri, 23 Jan 2026 02:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HMWBLuax"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872D7279329
	for <linux-rdma@vger.kernel.org>; Fri, 23 Jan 2026 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135091; cv=pass; b=Umyp4dqULy3KMBLQ0TVxq5x1alQF++c685Xh+uxS+Iix3GjJiFIN+DN9mHdfihgxu4y1dLS/aGMsPdbfbMAwCigKK2K0iulPGVXzBioScY6urUOomR7gIa/r7yiJfvkh0jn3cqW6iKiKFPGsWF1nO6eeGBfKjmoVK2MtKXPCOZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135091; c=relaxed/simple;
	bh=PYka8J4PdgGJ24kWlesftxqAJBWnrt2YPr+tCqpItbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGlo6IvrCURJOK37TzPrarcyJ+KQT6zj+ri0ikFL93e6bBNve+VbEu+q9Pmx9ddTErUntxnbWQtJRfl5JT73+sE6FLBt8d+SiW+ZAgQzzU9+52ph3bxNyOgdoVoLLO9ebBDGT1kSObe/jmhH9pOAnZUBNBn0J99dkHf5VuLsEdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HMWBLuax; arc=pass smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-56635de8acfso375802e0c.0
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 18:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769135074; x=1769739874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI0wql6r4V64WOaAdxWa2TtKNDCS93bhgQOab7+RzTo=;
        b=CmFGR6+vWYBOU3RR4Cm0Fb1jX/0wsUfgqvtAD8G1b3tCPUsburOLSKDE1P/Z4cPTga
         Lbv6SWNCZrdyIvHWnmcafkHUz/JZO/XHbolshq0Kn2Ro3gp80HuJGwPasVdjhSAq6KrA
         c4IVP8QTwywKB022a5NZArelfIqm0Q/2994bbxDO/qbNzw29L00rip+MEjRopayn6hZ7
         7af/rnJASV/4CN+fLggMjFcTbaXT6pkQrkwKlp3k0mrDGPJUHpjICmDAZdCE4Wc2UJVD
         UWeDk+3GUL0siCsnYGuIHCSv8mFuuMG7MF4/dkSVmkl0C4tx+GvXs5tPiwMZlxjKU3B4
         dPow==
X-Forwarded-Encrypted: i=2; AJvYcCWyuMMtxpRTcIHh1MTxLCZG9izywnSRT++lhOAJvt32g+sLyo+47gCeOcvzfXjKIETVJFzFbRQPQfhw@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhH9W0PRitQmn/5O+Ga5t6yIb9WEJQSh9w6478NjJvx8NTj8k
	g1sWlzeD2cIC6TMn6Evvu9YL07krwHZ1Dbs+KjjrVWcQSAALqHXTIHiWuH/LuJSbSp83Eqf0y1y
	A9gdo36psKVLY4QrVJi2Vg75ryaWIesiOxe5lfL4dBoliCiBbOpXoO5RJUE93mbNcYGtvqTcNlJ
	kwl5l3tDhj/VprJ+sKF6xVVJbjGT6XPE1P7fVheHdPRN6rQtN3038MhojzZ8LPs1JHPU0K2qyzd
	+MWhTJ9wF4VcBRbU9DFE6LRXZAY
X-Gm-Gg: AZuq6aJOGhej3tcEkiytwi6s4Y81e/ohW+HVoj/2ocHNNrBtTBUIySYkRtNlKXuJReS
	TDxDhrFPrwIzYvaQqJ2/gGIdyJ89/jR1dyeE6VS4uYMbBvlNb2Jv0jRCncIKxiTJmwkQNuIRgjt
	y30G2tfZJs5rZokQ96VLDUzmGezdQvXqaHoEwwUO3uNpTvFqVyp8tqpkMi9Jw4gKAcshXmSB5cv
	efzZCehmHTl9cuShnx1t0Df6Ei/ICa8d7utxZDiRLHbOlvVOiFm2h1wuF6Kmve6i0O1MbNU+kS9
	mG2HQX4ZjoqFX07M10YUSuAEsw1R7PNvY+YwE2gUlsMA90BGpWAG7gb1o7D2Tpdk1H6yKE9gcOd
	FEgHoHZGKs0xE3rJZFyn3Vfdi1BC3WTPasSHviV0Gx9GivifN7ED37BbStv1e47ga6XRWTDdJnR
	0WaNvDgdkQ9opPmaWhw3TayuPLcvvXRb1O4Txs4Wvv3jqH0WCTLGUmh6re/iA=
X-Received: by 2002:a05:6123:88:b0:55f:f2f3:699b with SMTP id 71dfb90a1353d-5663eb5e94amr494568e0c.11.1769135073810;
        Thu, 22 Jan 2026 18:24:33 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5663fa58d08sm141636e0c.2.2026.01.22.18.24.33
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jan 2026 18:24:33 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d4029340aso18728295e9.3
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 18:24:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769135072; cv=none;
        d=google.com; s=arc-20240605;
        b=Zwz6yX9StZrqNwqb5vLH3tNOi6wqC1qpyJM3vaNqjHONCYl51ii7bdePROZ77FoHCc
         9QgRH/O5cagKcPgcd/Eme+GP4tnkxqscM0/Qb0H+k3P547qY+sOEHYuuRFjADZO87Ds5
         NxiudYH15YDyQKBN7ApbHhkHTNrM/d/lst2TSfw+Tld3ps+sUu2Zf3dPbtF5zkwZ7z2p
         js623QECWrvn7P1NFTAmHu8vHJn6rTKZPK1fw6pqFpiQjP43/3ctGIeDZHktwE6ICQ/q
         kN3wmci5M1gXe05zHUAbaO5wFexNU+0zTMQEeq6BmrTH3Kz2GaBwr/9CCu1pLYfL0w8r
         P0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tI0wql6r4V64WOaAdxWa2TtKNDCS93bhgQOab7+RzTo=;
        fh=ZC8JxqoHtaAItETJ4kpYo2Dnyim4qBBz6VmylcdKMnc=;
        b=HQmS+aehbE1DajgLbmNoKez/wuoX2KHIEWKwozrLkXrf5dMPpuao2lOijmHukqoiXl
         SkwipgUYKk8O+j/Oy2VEw9F7WX7BlyBYI24pctjIjx3wUnEPNjEzx2+yoYGO+Gnef+v4
         WTU/poAOYyhOqEhK26PvPFtatw6DsDFPyeSEDZtmQGZgiHqRx8+ZBAGeV2e6BXxiijMg
         V9uMSeUxJbdau5Wf9PXmmj7lENoWZNPzpdRlf9QxJNouKrgzpkrPYORVPtKRQqStSjj5
         ATMC522PGpKD0ul+7MLrwM2JDoueuGcLTWFpuNFS3jnRkZzpPL2ioBgOY00QILi5sIAv
         iYbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769135072; x=1769739872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tI0wql6r4V64WOaAdxWa2TtKNDCS93bhgQOab7+RzTo=;
        b=HMWBLuaxYUeI8Ub/9wG5viU/xyUnFELlZAzsnzUfs4x3PWu8C+fSGfsmeWgftmnyUy
         7YbY6YOg0Mg7nmHM4Nzd+I9oc1wX35Pp/QIbsXK6gZt6CczDgAC32lh6Jbfa7bOwA8cA
         gPZB+rOtPFO3DQF5g6YPjR1cOBqRSFoUhc2Kc=
X-Forwarded-Encrypted: i=1; AJvYcCWHFjJ5uIzQeiOaygjH1vzDTgO5/UPcn4HhjfvV+rXBjnmwEMKm0zaYgWptL0yYAVRr4kgdxPiclh/v@vger.kernel.org
X-Received: by 2002:a05:600c:4e02:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-4804c957df6mr24220055e9.11.1769135071752;
        Thu, 22 Jan 2026 18:24:31 -0800 (PST)
X-Received: by 2002:a05:600c:4e02:b0:476:4efc:8ed4 with SMTP id
 5b1f17b1804b1-4804c957df6mr24219855e9.11.1769135071422; Thu, 22 Jan 2026
 18:24:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
 <k3mj4pl3ifyrva44z4bscpzwgmvctr2stgorixsj2xwtvi6sws@7miulfpsl2zw>
 <20260122140742.GI961572@ziepe.ca> <CACDg6nWkZTGj=rnHorFBXgTVDoKcb1rPRSgVBnbj9xjh_Uj3Mw@mail.gmail.com>
 <20260122210910.GK961572@ziepe.ca>
In-Reply-To: <20260122210910.GK961572@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Fri, 23 Jan 2026 07:54:18 +0530
X-Gm-Features: AZwV_QiiHuorw-PQ6M3UMKttKLrd16VpwQNu2ZLQ2sH7Z7ZzMhZz8OaYhmYyX58
Message-ID: <CAHHeUGX-zRg+dTHUea+e5tXq7weCbaZHYxugzZ0uqS_b3YTNtQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Jiri Pirko <jiri@resnulli.us>, 
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	Selvin Xavier <selvin.xavier@broadcom.com>, 
	Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000885c77064904db02"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15907-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: E473A6FA9E
X-Rspamd-Action: no action

--000000000000885c77064904db02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 2:39=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Jan 22, 2026 at 02:36:59PM -0500, Andy Gospodarek wrote:
> >    It sounds like Jiri's proposed core changes are the right long-term
> >    approach. We would be happy to collaborate with him to accommodate t=
his
> >    in the next kernel release.
>
> There are two things here, Jiri pointed out that we already have
> create_cq_umem() which bnxt_re_dv_create_qplib_cq() should use instead
> of calling into bnxt_re_dv_umem_get().
>
> And the second is Jiri gave you a patch to add a create_qp_umem() to
> do the same thing.
>
> We definately need to see the CQ moved over, and I have a strong
> preference to see the QP as well given Jiri gave you the code.
>
> I forgot about this new addition the first few times I looked at this,
> but I think you guys should have noticed too :\
>
> >    However, based on your comments in the other v8 thread/message, the =
v8
> >    series will still be accepted and added to for-next, correct?
>
> It is only rc6, Linus promised an rc8, I think you have time to adjust
> it?
>
> This stuff is important, it is uAPI so we can't exactly fix it later.
Ok, will look into this.
Thanks,
-Harsha
>
> Jason

--000000000000885c77064904db02
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC0Z2F5DiBN7fSW5jecKXMbzCTvw1d5NsLb
Dod0d6v7LTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMjMw
MjI0MzJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQABdXdvHn5COfRgfTGpB3Cr6GK+u21K/hNlnZ2ydEU36CAgL3AuldUEJa/QlsmQhTn5Q785
FfbzD6KZNXHMCHke3CW3RTOY1cw9xy7qsT9hz8uhWrfdgriyUjoeHKcZPuTbVvIKKZl8nfp6KqGB
mMKdK4azjSmQCEEOEiuQDhG/H4jzPeSop08Fh9n0NxRjnEi6dHW6dMCF/xkfq7ppfzE2ja1FafCc
Sd3SEXzvtZPF+OuT3GD+4ZNB7KNjmwSR511VjpK7n1Hd7Jd/9y6M+nn0N478Y2rzAu/OmXYbO1R8
mQoaQUp49WV7IYXePt0b5NggeZmQxFNniGjNpRhQjTFQ
--000000000000885c77064904db02--

