Return-Path: <linux-rdma+bounces-21705-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tMhUHENxIGob3gAAu9opvQ
	(envelope-from <linux-rdma+bounces-21705-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 20:24:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD163A855
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 20:24:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HcpGlrGu;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21705-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21705-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05CA13003720
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 18:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F2A3DCD92;
	Wed,  3 Jun 2026 18:20:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA83CEBB8
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2026 18:20:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510817; cv=pass; b=cH97MoaO9ScWaKi9pEa6hRSVGRpQnU/wt18UP462T/2wwjcZbLDEkZtx2e5O4hfCQHwKDielb2QADQSr/enuPsZ4SwL5cYlbLHm0KatPqrglFkT71rhIxFDX989YcgkPNsI4mYRAcatkdDjzwPjH4c0QnQbNrEQcAEG9wq1dMmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510817; c=relaxed/simple;
	bh=nDd/qvvIkL8yPJgYiNDZEKASX0pDnHeCOcIyAH5I6VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DO/SytLgYgztCtZDH5PBNxVEYWZjjOW6mLzfaBiVdxAKks1SuYEhbRwARkXeYqQzxCGwmeRc4OtHqeuil0S/xIQzboIcKgw7W95/vWYoILu5xm8tk5Xjnxw/g4GtwnI1ygZl9j0Y9Dg28eO3c9sL17gj0ROV0sYjhVK4lkBOuU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcpGlrGu; arc=pass smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf20f6be6bso35814895ad.3
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2026 11:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780510816; cv=none;
        d=google.com; s=arc-20240605;
        b=BW5tTrzRwIkDND2OErkIrGRp3bsittpOSyBYuU1AdLp5qHZPC6GR9zf48w9KqURzjO
         0ttBFw0LUqqCIuHlxpNsbloRF7rC/NVmyv8xS/XJPGXiP9by02riCI0uF3kJftZkpOrd
         syrqv+RzdJI1b7tqLFiYiGS4rNaHXtP1/g4g3qclQI4znp3ts9e3LrRc2EhG94H1VaM8
         Czh78cEYhPtDwHI2r3gGoK76rlo/RtVIDAWXGSQnlyXNW1+YGzdx77nDYPJKdJ0IVDjX
         o0T15sf7vjXcrlgm2l8czRoAi1qkEXQ2e1wnJQoSpEmS8EJM54jtaDS2j7hQNhVsNotB
         YKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E/xKk/OwjaxQKXU03tfhIHQaaH7nE7zS1IRGXiU5gzc=;
        fh=/712KcidJ3G7QWwW4fjD3ed9FiB4FfPIGEjLa4tnpus=;
        b=ifOPcaIEokwmSJZEkdZfHvAdsO0nd5hjVyV6iscU3qW+QOwpNz6nfWS6ZkoKLH79Lj
         b8BYKFcj/ZKkFBNTurN62orXvBifXlpY+M+ardaumNrEyW/8NDsNPDVIByreKYIBNA62
         o+NEt7OQUQUj/lW9LbmAMZ8N3BSoo2dGoggxCApj6acezHnJ54aWpSGyXI2KuSEor8D/
         hRZmQDY3RX0MIUGRoSgId+wYgshJOy8OPrujHYO7P0m0+W/M32aH7dMn/CWQvYJ8cwBe
         eMacMxBU+jUXp2VbKdXX9gzFfULmWim2eiyHLp1J6F1rPQlM4AO+qYdFMFCjX1OLFiLi
         n4nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780510816; x=1781115616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/xKk/OwjaxQKXU03tfhIHQaaH7nE7zS1IRGXiU5gzc=;
        b=HcpGlrGu0ThJEyfcwAzFnvv0cQjmu9yoPPRb+NUFUZGZRMsMOsyxJWqmm8ytfEclw1
         ijZ27TXGtWRLaVg8db8D/YGajOOb14loMDDbulBB5YTHwQdZEM3VscZZjNBeqt5UkHX8
         62ZPAwA8SIf48MvBRwxoy+BG+7mPear9TEYSRtLd6nPnKVbl3YT85YQduw69L3VS1GFC
         ojyimLC9mdtCJvbEXO+HhVu9OuxUw0LsYAfyx/AFgVRLK5b+xRoXIeGYHo+xjSdq5Sm4
         1cW7RVoMRj2CPTgyoGrCBqCeaHKSO4xowRYo8pSZyA7lgM8aRb0EyK2pHJPU8L4KY/GG
         9B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780510816; x=1781115616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/xKk/OwjaxQKXU03tfhIHQaaH7nE7zS1IRGXiU5gzc=;
        b=ae17cPECJYgwfZ3h9NV0dtO3P0bh1jnYgu91z2aIEEl3xBR5teXV29tpAkIYA77Yqm
         giE4ClVG8RQ8bVPmJjJv8IdCq4Bs+L+DcWQLzcJzo9lAlC9VagZTKeNQnR6UnQBJ8x+v
         +oFo5JGyFXMYICB05JPJObB0I2cGxa9SlvrGqdk/0nE0O7teoXBIbmxhIq5+U1ObwL1h
         CY1QwyWuoRLBaNt3R9W9OsoFFRsWfzpDdS+/HR9gmV8lGFOIk+uJC7i7xzLjeK4P+Cf9
         eZGLbFPfT7g4aheYm58YcUokW6dZm/CjWxQxBFMh+4ze6aIaMT1FLtm7fq1kfx5mAkhL
         cNvA==
X-Forwarded-Encrypted: i=1; AFNElJ9wpqLyR7vItHLCp5RqkZgRu7xkO8tCwooNwrzaUWFn7Bad38LQar+Ikzi+kmMQS94SsO2UJ7MgcdCX@vger.kernel.org
X-Gm-Message-State: AOJu0YxpngCN18h8fjpC9YFIY06d43+aDBa3zfcavBwLC1sRd/MdVXB4
	nRPcPHuTuciK3sGQayLYEw5WyD5Jj9dl3B+N45TwNfAVXl9ZtAHci/myfq+otE+VeEc9kVdxL39
	rD06Se95W9PIkC1SP/JSe4z/TsnpWqgQ=
X-Gm-Gg: Acq92OEMm4oK0duZH9jW7Mo6OEytGXltOZ/V1E/r48Fxw8FrPGVInGNtWt916+InPOF
	fNcEzgaC4wHFxwIZvawKFtBs4PcbjROY/ROvlB4mFLinPEOdoq4FFUs1/97c41GU3N9BqN8Y1jm
	B/HWXNk9C+zR0E7reKyeY9eZqFyPzS+uG6cok1dsSJMCNW22fkxwIK0iG/ecckddTOi8Gx2Wi6d
	jtKJxtnRDYEUNtfeTFioSArFMjkf+F8VugLJrzJl3ZvWlHis2rzDpBdCpPNUfCrJIzlYuJE5dKO
	5z7quvP5mxAXqRE/Ixcp8fCxY8QOUtLk7FJr0987FqsdrU0=
X-Received: by 2002:a17:903:acd:b0:2c0:bd76:cf18 with SMTP id
 d9443c01a7336-2c1646df446mr47625875ad.38.1780510815853; Wed, 03 Jun 2026
 11:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518212336.337104-1-michael.bommarito@gmail.com>
 <20260520154715.1457495-1-michael.bommarito@gmail.com> <20260603175455.GA1554392@nvidia.com>
In-Reply-To: <20260603175455.GA1554392@nvidia.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 3 Jun 2026 14:20:03 -0400
X-Gm-Features: AVHnY4K9-vy-xLKYffHfh0DLdmiI2YKCvImD1UjcMB8ApiVt3f8nUnGCu8vXfNA
Message-ID: <CAJJ9bXyva8La+ZLbG5cwaE87AR3GizLH9U37XKgKR1xxOHB6kg@mail.gmail.com>
Subject: Re: [PATCH v2] IB/mad: cap RMPP reassembly window size
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vlad Dumitrescu <vdumitrescu@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, 
	Bob Pearson <rpearsonhpe@gmail.com>, Sean Hefty <shefty@nvidia.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leonro@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:vdumitrescu@nvidia.com,m:ohartoov@nvidia.com,m:rpearsonhpe@gmail.com,m:shefty@nvidia.com,m:kees@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21705-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6ABD163A855

On Wed, Jun 3, 2026 at 1:55=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
> Why do you think it is OK to only search back 64? Where do these
> numbers come from?

512 >> 3 from IB_MAD_QP_RECV_SIZE in mad_priv.h and max_active.

> Is this a real issue?  It looks to me like all this code is gated by
> IB_USER_MAD_USER_RMPP and no in-kernel user makes use of RMPP.

I originally found these issues looking for reachable quadratic
runtimes with libclang+Claude, and these are in my notes on
reachability.
<CLAUDE>
  - sa_query.c:2436: the in-kernel SA client registers its GSI agent
with rmpp_version =3D IB_MGMT_RMPP_VERSION and flags =3D 0. So
ib_mad_kernel_rmpp_agent() (mad.c:856) is true for it, and
ib_process_rmpp_recv_wc()
  =E2=86=92 find_seg_location runs on its receive path. ib_sa is always
loaded. Not a umad-only path.
</CLAUDE>

So I think the reachability is wider than you expect.  Perhaps that's
the real fix you'd prefer.

> So I don't see why we should be changing this and risking regressions
> with the window reduction?

It's obviously your choice as maintainers, but I'd encourage you to
test the pathological worst case from an unprivileged peer to see the
impact before totally writing it off.

Thanks,
Mike

