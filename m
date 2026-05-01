Return-Path: <linux-rdma+bounces-19835-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH3DC4nR9GkYFQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19835-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 18:15:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7964AE012
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 18:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B96C43071B2E
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B7F3E0C60;
	Fri,  1 May 2026 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuDKym33"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C63D34AB
	for <linux-rdma@vger.kernel.org>; Fri,  1 May 2026 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651909; cv=pass; b=bMPDBIFk3Y5FlG64SuAWIO5c7ataMz0QXm7gdvIYXUsHnK13yAkSIh44BKYoIHyqDoa86iTwns2r6sICj8S0EhC4FWEm3RdQjIK0qFYQ6gVf3JwR6aiIhb8wu7UA2Xc6MGYDXPtG0M/4Fh2fduqNjtQ0RkXz01+bUEaI5lkO6H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651909; c=relaxed/simple;
	bh=Lg3I4a5CVSLmEfFpzSrc+IJ6RbdpOOFMUy6frdtkKdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0kh15yOw2iodu+90qgNV7V9PddBs5NYxkbuhZ43j5uhbc1VSG/G37p9Orx/S3TipczuCyZhJBu7riqr3avU2FUbgM2o9Ye++TnS2ow//oG9S2NrbsQgGGxH38RdEVHR6uA6+cZYypjPoZGr9nso23bjx+sxD3YmtE1jOQSVGig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iuDKym33; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c565dd3a7so2914423c88.1
        for <linux-rdma@vger.kernel.org>; Fri, 01 May 2026 09:11:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777651899; cv=none;
        d=google.com; s=arc-20240605;
        b=QLb3j1BxdpdjsUW0Ta40hD3QFu0MHulKWnUzEjcJ5o46uguEKkA4EqigGnau5JO4Oj
         ARJX05ssefyf5RIcv4crnRfIlb9lFvEdKOgUKC6rGuw3YFsginxGz/AxaJL+5kWmTOmd
         cSoRRkYIdDERU1jwn/uSz1vWSuyc+ms2m3hT2StG9IexT0OflfrZrdFDkhyDZMVCh28x
         XT1IyZwcwN9AmK3mpfm2xSazvL5h2/vy4BszHu+ASOPs6GBbC+8S7c78E1YEDE0tx8jB
         BAozQbAsCSlJJITyxhjEFoSDJFCneSgsoXa3XMWshX9LorE8Fz1u+uBxMu/KzvHRhA93
         MgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qUtLnk45BiKrXHINpVcyMQeBwCn16A0KrBFa2QFTWtI=;
        fh=iZc8yxojbxe/o4rDYExxRLi6gFFO7lr3xzFYQMp3cas=;
        b=RY5OPVm0F1EhTUvWWY3e9HwG+jCX6dIiewueXxYxZLjuWb5Vt9sFSIMaaxgC4k6Cvd
         bqvf8HB6ga1+q1TdxBTfU+qcqEoFa326DxHWNPtKP2YV8c8+xnG9/2D3kgvR7KPBwa1K
         DCFRpA4Z0yZM/iCr571JJjMaDf3Ojj2y6OsFlAgURGC/Erctl/41071Jkj18KFRJmUqo
         4Y64zX4n2gYRymBhr1vJQlefuR2VN/bMJ6k5q/tGcaKBei0mNCbxX4AosVVOPPdiUMY6
         A/8WM0YeF/JYpWh9UR+Xus1UYtHteLOO8A6JXQFu4SxKIe2RfHBVYeQeMIEH08lmynb/
         eomw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777651899; x=1778256699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUtLnk45BiKrXHINpVcyMQeBwCn16A0KrBFa2QFTWtI=;
        b=iuDKym332S3y8j2Dh8gx5+R6x5q9ow83jxo2eSebtwLzoL7A08OmajBfhFzWCdKifv
         tSC2/qCqb0EUCeKQDXArWwsFbvxZshdj6+YxZkOwWJCHAlm9NTkqeDbUD5DhrBf+uT8b
         7OVSxiC+3KhCsYvtennSRH1IZs6NYrEzCC0WKMmPy12hYAmghoqQEMvJSKgRc/MER5jp
         SdoEm9F7/eDVT3mm6gVwb+36REfhqT1KtcCZSynk5T8jlVrrv2iHBADepDV4W4Fny6Ce
         VqcOd4HzKiBmsbe9OdD/EaQKN8No8kqjD+EfMrTpOxVlFahLEr+8c0miMiEYERdd7FJz
         H1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777651899; x=1778256699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qUtLnk45BiKrXHINpVcyMQeBwCn16A0KrBFa2QFTWtI=;
        b=PkVGChVsSx3YDPv5SrpqbZzw1KmKKeukDQTU8f7f1tMNv5FvqKdQkiiOSmnmZjIQgl
         WUhu8nBmD1Mn8XskdzKCyA2umz6/EzYleBZIK/OHhctV+RgnblYdeRvxlgIOKWZzSkJt
         h/+y4s++eSpY3QtTwIxMWF/6VgFXUKAajVgy/h8A4U6PoF7A3fQW3YvrnbfwHv99vid9
         BlWH4zBQINAnqossqfjQl1x9ZJOOgfcrmbx/3X+qjnKeZN0a8qRJ0G0RMIubhCGktiCv
         mPaU4JnttqFXeMRkeQTxWQytCWK8ed69Fw/OX7Sy8xe1WXjxVPhNzM3fcViHhUVAPSlw
         U2UA==
X-Forwarded-Encrypted: i=1; AFNElJ+1y/ap4d1XvqvR3NKbgjmHAX+b1oRSTKJgyxJv+KNFCylnMN0phNGROvMvxDt6MQWhzxaUQbNh6Y3X@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QM/1qPnawcxx0sC+kKCrI5ZT6V8tMgD/CAdM/4BkVWJM/OvM
	e5WU/3wW2cCteL+GUKYMNl46aKMEZc66+z4KSdlJf5ynwqSpo+9f+TJaEbmNthGVx5nZdQEywlw
	UgRjFx6eyrjC24O2X8M9fJjrDl+U/veNvKwcjl722
X-Gm-Gg: AeBDievRUkE1h46LQsLJiCdUlWgmDaOY1RV5KCNDNjrftbDDKlBOawfg7lCE++V2HLk
	bliuSOypbKYpHRhrE6SQBKCY6oSezFW2LN/NKnoVFBIWKIGWel+x7qYCOKZvNvyU6Ox2rI+MgUD
	ZYSlGTyNLAEYa/0sWXCra/ic83XUojrV5pa+461ll3G8mMrI6ru+Aq4jnQJShUFNUZydrkWN7Iv
	zV0QM/TYONM1dFQSIKqjD8jW7NkSFB7XReGjRn6x+EELLtK8grc6e476QFngDMJW2zCwPJ67h2X
	/ERvd+1TmXmABfyw1Ebok7nIUi9yI1I7iTTzwDF2
X-Received: by 2002:a05:7022:423:b0:12d:e126:b7c8 with SMTP id
 a92af1059eb24-12deac411demr3607716c88.13.1777651898369; Fri, 01 May 2026
 09:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 1 May 2026 09:11:11 -0700
X-Gm-Features: AVHnY4IcOZBEwRDeFauz0p7wo2ItTFGZpUDr4nDVbee6fBs6NBQ1Q0W5r-m7yp8
Message-ID: <CALzav=ci8bi3=sY+F3HJTB5sOQ_pJ8Lm+kz0CDBBWVXry5P98w@mail.gmail.com>
Subject: Re: [PATCH 00/11] mlx5 support for VFIO self test
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9A7964AE012
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19835-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,qemu.org:url]

On Thu, Apr 30, 2026 at 5:08=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> Add an mlx5 driver to VFIO self test. This is largely a remix of the
> existing VFIO mlx5 driver in rdma-core. It uses an RDMA loopback QP
> to issue RDMA WRITE operations which effectively perform memory
> copies using DMA. Since mlx5 has a stable programming ABI this
> should work on devices from CX5 to current HW. The device FW must
> support the QP loopback configuration.

> This entire series was coded by Claude Code in about 4 days.

Very exciting. Josh Hilke from Google is also working on using AI to
create a selftest driver for Intel IGB NICs so VFIO selftests can run
in QEMU [1]. So it's encouraging to see you were able to do it with
mlx5.

[1] https://www.qemu.org/docs/master/system/devices/igb.html

> For those interested, the flow I used was broadly a prompt sequence
> sort of like:
>
>  - Hey Claude, go look at the falcon series, VFIO self test, the
>    mlx5 driver, rdma-core and some PDF documentation and make a
>    plan to put mlx5 under the selftest.
>  - Write an rdma-core application using the built-in VFIO provider
>    that can do the required memcpy operations that vfio selftests
>    wants.
>    (This resulted in a 1k loc C file that compiled and ran the
>     first time but had a few bugs related to device programming
>     that the AI resolved.)
>  - Replace the rdma-core components with open-coded versions to
>    create a fully stand-alone program that does the DMA memcpy.
>  - Review and audit the thing.
>  [Pause and de-slop it]
>  - Make it work on a PF too (this is surprisingly hard!).

Can it work on CX VFs? We're interested in continuously performing
memory copies across a Live Update using a VF via selftests to
demonstrate SR-IOV preservation (when we eventually get there).

>  [Move to a kernel tree and copy all the .md files and .c program
>   it made]
>  - Hey Claude, look at all this stuff and make a broad plan to
>    actually build a VFIO self test.
>  - Here is my 1 sentence advice on what each patch should look
>    like, make a detailed plan to make a patch for every one.
>  [Pause and polish the patch plans]
>  - Execute plan X then commit it [pause and de-slop each patch,
>    repeat].
>  [Review and final polish]
>
> It is based on a tree with the falcon series applied.

Thanks for sending, I look forward to reviewing!

