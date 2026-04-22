Return-Path: <linux-rdma+bounces-19470-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP8/IOji6GkHRQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19470-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 17:02:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CACBB447A4F
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 17:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5927D3042D4D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE7232143F;
	Wed, 22 Apr 2026 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PavkPGQS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD95E337107
	for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869393; cv=pass; b=CuujmImlv71mfmgXaAPmsCCM1j01Ndc0lwdid0BqAYPrmaNl3kXR4YGawg+HXMKOZewAYadmdVSOPxj9oJLBX9ORSXvnaee2VKvw6Nrtca7ZEXPPCcsm/sK6sTKpdD3XK3GuU+cu0snyAfLOFk4mjmQJ8Zrk5ZNFlO9GEzpVYTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869393; c=relaxed/simple;
	bh=t2XbN8ULAb+GBwQSJq0X9aog7nk2s64iwqFA/9Fv6hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PC/zAfWZQegsDEhwhhgDBGUX0akhwkv3240Uxuo/xERZaeTV3pu6cizGC0EpHhNeSUQOKCl2F+Qfud+cU8O0dJSufcEkUjqXWpOE6p7ukDgcwqOYN9bN5z4daEveWxR6jMVY999QRo/sGn4nwtKRIgldy58I0lCSVFTvJlYSjRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PavkPGQS; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-953a26a9abcso1599016241.3
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 07:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776869386; cv=none;
        d=google.com; s=arc-20240605;
        b=Fwe+ojbWmvSkOYGLCMEyaFFwx9cZ9quTra9bNkAytE6zqVIQQXcR/KdRYLKJ8V4qY0
         om7UABn17hO2aipbKW/uByL9U1iGI+yZ437yxgAwJFIftCOpaxlOnPNfMxUtgZKLCWiX
         m4FpdfNobWXyVpGBG8WToKAjhfkPgyGesDm+PDQLK5c73R+5YDYpFSkuVeo0Jg4N96K0
         fVsPUcAUzm5cL1krZH5u/bIk0JGfH7EIKkk/alxjFsXJR4wiv3HVrJLW9Y24WqvqSXhz
         FgcSn4L4IVkdQA1UpTAJ2wUHS5LT1Ou6vDxv0RxlxcKcfT5qpa1I91YhPShDJAnm8Lno
         /Jag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eAJBfQ8yKFwcszC8n4aL6C6Ym0YtNvc5vil4gI8HbLY=;
        fh=syMWiEe7H7Ry5bbcK7HFLshaT9xfBrAPyc2p8iF4GLI=;
        b=FsQ0/C5WOJoaW3xYpo98AnsD2gk2owEEelvXv/jhD0RWb45RnaOFN5/VzyWdQ04RxW
         iqJCe1cdnRpeQMdb/QsYABsmtNe9IYB/MZ8HQP8LsHFO4EXM9I96QZDHZjF4sDfhy/oj
         Vy5ZNP1TRRGBHwjMJtPE/i4cXA64jBhrC86eST+aoZnqxezVdmHpYqkoBaAjPQBod7p6
         wRR7Tw1peNg0+x+y2ZzkPJBLM78hW/B1+TehQdfMtriibYZIk1i65hhqbNtYDUBCKZ3Z
         R/17iX/6G4sN4goySYUGMn8+fLBZc0Zyo4g3FN0TFxSz/p7RGvO0iQuAOyiDWPT10ed2
         XiKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776869386; x=1777474186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAJBfQ8yKFwcszC8n4aL6C6Ym0YtNvc5vil4gI8HbLY=;
        b=PavkPGQSrm67SCvoEkjxKqeVDJpf87RFHgfX70qWMonI948KR8OsAH7peaRSXa8N+L
         clc2DKRMIdfjY2XyIyoovf2ofRdwHCZ5y5NJYsr+C4WnHuHnQs/DmjKNr0717mv6OtDL
         eDhOhVyxmznoBpY3u/Zelpd/x+URfxzyaIOIEaz91AKnJ40VVprx/zWn1mppEIkJCAMH
         RFhR7QvyetudXIjwmL7Wsjzw8sK33F47c454cRWbjiTwnaCDEEX3LIVJnlK3fsCoECvZ
         v8rEN3PimrpQEMPV+zRVqXo41bwkX8sthSULAVb3wEBlBbpat72q8JFGIN5+UAFZBXd+
         IK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776869386; x=1777474186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAJBfQ8yKFwcszC8n4aL6C6Ym0YtNvc5vil4gI8HbLY=;
        b=hkpSXhZKZvkYqBTD/FVGQlbwDDKE7OJ7Y2Ht4zAWbh3zPEvq9PuPvpjcFt6k2hjnu2
         LePnHO9RnE4h5QWMhPhiOWvoQh5wCY5bIuBALbVGoULGC3ujcOJ2zuAEPGlisHru0iPa
         yl+QmXt2+46u+smLgjCTzmMVi/Kstn2SlDvcGaxzp8xt1kNbe5DAntqy35pDIXRVHDkb
         d64HkrEn5EFiISeQQZNen7qC6acuKWkCR098V13PQVAN5NWQasU7xC82FgJm89h4TIbW
         O9CWbXENHUtC4s9mBfHr8uZpG2PJs2Tg1g3u0ZkubgOkPfdVgDVzx0Ggp1+CmlYi6MrS
         z/2w==
X-Forwarded-Encrypted: i=1; AFNElJ8fICThGCb/maeW3s10B/ZyO7Mcs7b1QJ4bkmavJbVeEoBEfjHJYFpJ5xHP3qwLXWdKFKPwfI3PLmuJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8W6ebI5ADMAou5paLVDExKtAnsy5KP9TVAXPRJNXy9CAAytM+
	1yPeGxFy5kZ10wvAt69Y2w24ZvebrtwQ6+u2qCmHvY8BhI4x9JTdOEighUtbwxVVWPHJquMIHbH
	MpNtBZS1ujqkhJXcy7v9z34GtJxAFjyc=
X-Gm-Gg: AeBDieuY6AyRu9brddmc2W8JAzrhSJZ8pc2dJwa0g2bDl1H8dEt5v+Aw6wgKI+JhZqt
	yXuhJuQ0hmf7DPEG05iaM35o1PzD/CmmO7P6s4BiToOUK1lWfjAboLQMyMlp04vvCUg9hz8PNea
	xRmmPM6QIFjNMaBcl8y+JmRJ8nx+PHASdx7e9k0VK/1l6LIX7WIdLagVA+PGXGpjDNxB9ysSVVI
	WbDwvSiRckaM6Xxcia4GBBYh2yMtJmZ+XLxlMiNvq0aL/jn1FB35IoMnfzCVAO6wpo/lncV4fzH
	l0zP32NiTLow/zklTCeg0CWyt7wi+7snFDjlx/g4QS4PkP9SWrjuXQfLqZyojq0WdkRe00ZVps2
	F2Oh29yF6U70T2wGHsSPKIpEG9SdKNUxvce7bPcL/EIRsb9QbtMXWMa5L2bLs7OiKgd/a6sCs0g
	==
X-Received: by 2002:a67:e718:0:b0:5f5:4055:4558 with SMTP id
 ada2fe7eead31-616f4546fd5mr11177594137.2.1776869386083; Wed, 22 Apr 2026
 07:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419192018.3046449-1-metze@samba.org> <aehrPuY60VMcYGU8@infradead.org>
 <9cb0901c-18c5-4858-941c-3b37ee112af9@samba.org>
In-Reply-To: <9cb0901c-18c5-4858-941c-3b37ee112af9@samba.org>
From: Steve French <smfrench@gmail.com>
Date: Wed, 22 Apr 2026 09:49:34 -0500
X-Gm-Features: AQROBzCYzdLfMWSd1uFLJ8XC1YCZMAbk3sG8ZrbfCGB_aYlDD1y44LjlIIB4UJs
Message-ID: <CAH2r5msb3-HiPSv+HgBknEwDXGsv0xU=TGCxHdmc-VCLKzYCmw@mail.gmail.com>
Subject: Re: [PATCH] smb: smbdirect: move fs/smb/common/smbdirect/ to fs/smb/smbdirect/
To: Stefan Metzmacher <metze@samba.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-cifs@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	samba-technical@lists.samba.org, Tom Talpey <tom@talpey.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19470-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[samba.org:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CACBB447A4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 3:16=E2=80=AFAM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> Hi Christoph,
>
> >> diff --git a/fs/smb/Makefile b/fs/smb/Makefile
> >> index 9a1bf59a1a65..353b1c2eefc4 100644
> >> --- a/fs/smb/Makefile
> >> +++ b/fs/smb/Makefile
> >> @@ -1,5 +1,6 @@
> >>   # SPDX-License-Identifier: GPL-2.0
> >>
> >>   obj-$(CONFIG_SMBFS)                +=3D common/
> >> +obj-$(CONFIG_SMBDIRECT)             +=3D smbdirect/
> >
> > Why is this not in net/smbdirect/ or driver/infiniband/ulp/smdirect?
>
> Yes, I also thought about net/smbdirect.

I would prefer to leave it in fs/smb for the time being, since it makes it
easier to track since fs/smb/server and fs/smb/client have dependencies
on it.   In the long run, I don't mind moving it, if it starts being
used outside
of smb client and server.


> As IPPROTO_SMBDIRECT or PF_SMBDIRECT will be the next step,
> see the open discussion here:
> https://lore.kernel.org/linux-cifs/cover.1775571957.git.metze@samba.org/
> (I'll follow with that discussion soon)
>
> I was just unsure about the consequences, e.g. would
> the maintainer/pull request flow have to change in that case?
> Or would Steve be able to take the changes via his trees?
> Any I also didn't want to offend anybody, so I just took
> what Linus proposed.
>
> Using driver/infiniband/ulp/smdirect would also work,
> if everybody prefer that.
>
> > As far as I can tell there is zero file system logic in this code.
> >
> >> -#include "../common/smbdirect/smbdirect_public.h"
> >> +#include "../smbdirect/public.h"
> >
> > And all these relative includes suggest you really want a
> > include/linux/smdirect/ instead.
>
> Yes, that's my also my goal in the next steps.
>
> > While we're at it: __SMBDIRECT_EXPORT_SYMBOL__ is really odd.
> > One thing is the __ pre- and postfix that make it look weird.
>
> Yes, the __SMBDIRECT_EXPORT_SYMBOL__ was mainly a temporary
> thing, now it's useless and I'll remove it.
>
> > The other is that EXPORT_SYMBOL_FOR_MODULES is for very specific
> > symbols that really should not exported.  What this warrants instead
> > is a normal EXPORT_SYMBOL_NS_GPL.
>
> I want the exported functions be minimal, as most of
> of should go via the socket layer instead.
>
> If EXPORT_SYMBOL_NS_GPL(func, "smbdirect") is better than
> EXPORT_SYMBOL_FOR_MODULES() I can change that.
>
> It means cifs.ko and ksmbd.ko would need MODULE_IMPORT_NS("smbdirect"), c=
orrect?
>
> Thanks!
> metze



--=20
Thanks,

Steve

