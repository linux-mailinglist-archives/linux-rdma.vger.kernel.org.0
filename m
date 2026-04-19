Return-Path: <linux-rdma+bounces-19428-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMSVIJE25GlbSgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19428-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2026 03:57:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 246BB422DC8
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2026 03:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 935DA3025738
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2026 01:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BEC20010A;
	Sun, 19 Apr 2026 01:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDmse0co"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C669175A87
	for <linux-rdma@vger.kernel.org>; Sun, 19 Apr 2026 01:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776563851; cv=pass; b=hXeiCcXh/6nMFVzR7KsqXMftvo/zNgVzwrA0l6QjmhzulCqTrjYjamb5wRIxtxWQ5m6LEmy+R7r/aRtFQJKN7WkkbhiKGAudtucxplCbKjPVCrs/eGb2ZumMEEgtWJW7+nh4MHYffi71EznbUzcmWTqedv6IRiEqP3bmeyFm15Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776563851; c=relaxed/simple;
	bh=KMq74mI7lW+JvFzg3siri3oXIgSEt4nO7wZ/2UTrxg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8y7tpumw+s5POvFRgmvoHzkUjxhkQ+hd4ojPgu0XbuH991Pjyl0VYnimaAO6yygBnFF1zoXntzdnUmWV22jHCqG67CGEtOJRjxOb4G+wa5IJVjkPitpD56tLrH8vLc8J8qe8jdqpak/byYzdnBCGwb8kySTqnBxko4HsJYHTOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDmse0co; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a46ebe2beso18269197b3.2
        for <linux-rdma@vger.kernel.org>; Sat, 18 Apr 2026 18:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776563849; cv=none;
        d=google.com; s=arc-20240605;
        b=PE3WX/y90vFFhyuEM+rW2RdjhHVqAoRBYqo+5K4R0lz7pibWyLTNE4UQTL5qwA4+Mm
         FKjRlcZ4mj+UNlzWMh/VJd3Cl/uNRHsGsHKOUfPOXStpoFIYQ/E7OwTs9gUwxwrTA5+8
         05V/PZiw9FhsTYanwqPn/LNY+sdBZbEZM0i7cWDMmMKEuYp5K9dnLUUFnuxJl0BmxRjA
         8Uu274hSbUhdR8LlcZ6VvMTm3QA0r59uKUTfgrchT3ODYh8aQOupSQ/SwTq8gusJPBfc
         qhk8K1La7ZWBMVnOy5mJI5RsT8xBM1zCY7R0cYQKTpNEQzkBVtUr3puI+HXqUduTIAw7
         +Ifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KRivGt/UpYKdXnj9/hJbLdqitHSz+4nM8CUP8CxzmNo=;
        fh=RarXcUCb+MKLKv8GEwRzElC1P5w3+L7KwMGOLV56gNw=;
        b=Y0YT8Ei9Y8TGVnK823q8oAx5lGRqusOu00W59ASNsOfEXMTL6y4T2QPZI1HCwaK7ig
         vkvNe2tDlnUmFeBgaxrhIPhFsrPQQG3EMgzwNA31HMDWmKyyw4wWreMjujrbcj4/Sukh
         m6llH7lgm/tNkfz+ZJV19acLW237sZ5Zms7ZCg2h7C4hDae6jjxIBak3sOpQTiphhKeo
         e2/z7YowXLiZHq/GTEdSvH//NKH+kfnf5wJA3E4WlP2jg1JlGYt9tAYXxn57MwX9CcNj
         KQUwleaVKPGkStqLxdJRGvsVonCLPYDUXQrqN7cmojTF1M2HpLR2EC6vZv2I29F3Ab4r
         cCVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776563849; x=1777168649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRivGt/UpYKdXnj9/hJbLdqitHSz+4nM8CUP8CxzmNo=;
        b=iDmse0coIRfNlkNF1M6ix2fa7fZcTIxkJ9w/noBnFn4JvEIxX7sXuKODxsudvnzpMa
         cgJpQOD54tHmA+ozZ/cyxLQU4F4jfd9RknPZmwigBAOZ9voN8STqzk9mYM2YrizM/uPf
         PxT6NKGrx+adcFJcCKyypuKdVjSGBzNIZqsfZI2++wtDhG0magRNBTfbdioHIl4XVlqz
         znzlNzOX0uaHbS/dn9W8kMQ4yLGy7XoYau+4KyIEIZ4oFQY0XGw00/x9VV7Nj50IUfvm
         F9SKLbOnkX0FyQJOFFLK/JDaapka1VvuksrqnRFm4JN0p3GdMpfCm0oE/O7dg1olTyeX
         zVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776563849; x=1777168649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRivGt/UpYKdXnj9/hJbLdqitHSz+4nM8CUP8CxzmNo=;
        b=TSbEInYOKmNT8z9cEcPfLT+Z+6hOu6sNSxu5IBzAHC4lBJTM09AktDozrer20GclfZ
         QNrU6N/pWAHSFHv7hCsu01R0Jg7RmSsG2Ojwy29SHGolEb+M8XFrnehAg6BqDn+v0jrn
         542OJT25UnyE59KEQplAXuRdBfXurENNwD+dDyc1RzqhmYNj/2tC/EVBKJyWROIdhE92
         mhjYzOv9+mtH0SCoFZzWu59j9cPzaSayrYqBAf6YZ1FCihcVGPUn6MAsBoDgMpPqx4Te
         8ZXwyYVwqx2lVxrs2K19wScUe0sx7Nxy5542TfvcMk82+HXqz76k9mV4SaZrXcLPwgR+
         DJJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+BNNXsVLZwObsFGnugtWPTLhy4LtkrlYRqWvdwlyb2c68QribGCilAAWEN2ch/aE1i9SdwfsKDmp0@vger.kernel.org
X-Gm-Message-State: AOJu0YzqF9SwV9TeKvZT9nTGjRr/BNc71zkqlBE2Sy5E8lRKYDiEc6kR
	93fI4KmSKJmFruqM6ZTcuhGCJ1h+27B46WQJyZvee3VTt1QsGLPWeytglhtlitpiYrQG9MmGgVR
	+NotvnuAxvg4/j5Fto/6NS/Tlx+xRb4oSX/vEKkg=
X-Gm-Gg: AeBDievNSB8/ywZiGSQ0wTphhPyEToIyAcKhqNB2u6/1sjZmxfnwLERC3N2mlONvoCc
	Z6SOD0BMFBlN5/T9PXn/9f7ELJTxWkvu4UeklqCqOuH0XJcszf9uoa8M3RXL4D0s4n+vc6A0ljk
	8jJRPbXwaFhhbh6sGNRbqydW+/w2SUKFdaLtNTduHL2tgvmkv2LWu56dpjykYqY3hJFQD8Aw7xM
	JJrbwIXCXu6wGk9jsNXg7pOP+5w7q9hr8NWTnGn3AZlJv6QVI8bAgmYSAbj+7BIFgbfrj+0/Yx5
	ZAnNaco423u81rJeqlif3Pb557nXqkw9Mlk0vho+bSo1Ioc=
X-Received: by 2002:a05:690c:e3ea:b0:7b7:400a:870b with SMTP id
 00721157ae682-7b9ecf86538mr91437667b3.24.1776563849203; Sat, 18 Apr 2026
 18:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418162141.3610201-1-michael.bommarito@gmail.com>
 <06470bbf-ee39-4094-8c01-5860935af0f8@linux.dev> <CAJJ9bXza+XAX36-Fse1aW7FM-=G11bqKqf6Ds_9sArzUbZh9-w@mail.gmail.com>
 <1bd36ce7-e3dd-4ff5-867a-b8b9ade90a1e@linux.dev>
In-Reply-To: <1bd36ce7-e3dd-4ff5-867a-b8b9ade90a1e@linux.dev>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 18 Apr 2026 21:57:16 -0400
X-Gm-Features: AQROBzAfFDguRRz_JykT0iTqFwdw3-7VxFQRh0wpO6PLwt-2bSaD1K3iWySlbus
Message-ID: <CAJJ9bXxd5jzzGcsf-sTw-v2zk-9Q0AtDrNwXRtyh-m5O9tr-6Q@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: reject non-8-byte ATOMIC_WRITE payloads
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19428-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,fujitsu.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 246BB422DC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026 at 7:18=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
> The fix should stand on its own, and the test case can be added as a
> follow-up patch under tools/testing/selftests/rdma (or rdma-core if more =
appropriate).
> This keeps each patch focused on a single logical change and makes review=
 easier.

It seems like mainlining rdma tests might not be a good idea.  I found
the last time here:
Kamal Heib, 23 Oct 2019 =E2=80=94 [PATCH for-next] selftests: rdma: Add rdm=
a tests

I put the tests here and will PR it into linux-rdma/rdma-core tomorrow:
https://github.com/mjbommar/rdma-core/blob/4104d991a764de4aad9f645a2f0ec723=
f6076209/tests/test_rxe_atomic_write_oob.py

Thanks,
Mike Bommarito

