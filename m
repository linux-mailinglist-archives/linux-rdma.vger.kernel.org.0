Return-Path: <linux-rdma+bounces-19475-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIJ+GBrr6GkGRwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19475-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 17:36:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA23447FB5
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 17:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF86A30138BF
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4548E340293;
	Wed, 22 Apr 2026 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QT3E+80I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37C91DE4EF
	for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872216; cv=none; b=M1xSp/IACJD9gbaQlCgpPekzKnI5vQSpHJ8ht57wes1bi5v2EJ0gqiQ/chBnnuL+TvU/+0ryfBPFG61dMGBDlXmi5dg9xhxYs4U/GnJxmniRf/hkYeZsnyNW+JTFWV1JSmbe+zfvZvU4eUcYtKOuODK3Qh8x/Qu2zr6GfafYGiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872216; c=relaxed/simple;
	bh=I4Jmwzz1ODBCvCGD3inyJttCoNK7K9OZ/Wca1zGloR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sol1qtx0hPI7ECt9IJ4UzHMS/7on0TxElAkDsVgOnlTfSjCWtJi7FlN8PoFQ1qD7jRYQfOBemJ/hjl75lwOsQDmm+fQJF1CEqar3He3+33kDFoAJWOgOgIDx4IlFihWXJEkxrEpvcWnKYzOPza3HMnNgBYx7jSgqyvWdJXnecs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QT3E+80I; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so9287014a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 08:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776872213; x=1777477013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+DwNRPBKYrcNA3RvMgBSsOLry+hrRQ+hSlc37tD2IM=;
        b=QT3E+80IWCDmcPyrWXy0Fn3L7dsT6+3G896rsCyUtwzLBWE1oKlOWEfsLnExPJ69v8
         4Ehcoa6PtTHHs2jw/+nl8PTimwN3OSlD0IdySkBbRgAcSP3WxC0fR3AaBMiR16bdrSrA
         zzbMtGxqulWXcRIkBkGMvgfdq7vq/MsX+3xD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776872213; x=1777477013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+DwNRPBKYrcNA3RvMgBSsOLry+hrRQ+hSlc37tD2IM=;
        b=PVQCqIm2Zplz9CHXPdZIGMyJX1FJ5q1FuSnPlGi75w25o4x/lqDEoLWaGZA3YW7rJA
         ear6BDaygsICL26dt/d4eyZ4F+096i3qTl6uiZvC0fVRkkIa8Ylg/BR0Nuk08qc1OYrm
         ckjZEfU1RQeEVNOmLCbHEjWd3UC/5aGFgz4ib6NFbRkCJ5EFQKOfwJ0Nwwi64cVVPHRm
         Bf3Kc6fFE7vzd1HEyf4z1sGKCSzIdgMxOK4P6jHrqaSCZor3jqucPPaeAitTMK3oWxFI
         h7DZMawpE/7QXyhMLp10FP52Oz+taXJgkMyt4+p32hnXA8opupOVZE5mQ9+IOE1iGlOG
         jhBA==
X-Forwarded-Encrypted: i=1; AFNElJ9xhN8n5jM1b71BdnbHv4bSbQNU6ypdGYcak+4xd5AbT7TfE5wwSaBpuLwbvRxMFbHC1dkcyBgdE+1l@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXEne8m2z6D28UrA6R83d9JdUs7YQtTmmP+KvfC55UnrUJG+U
	NI4ROYokFfywS+SF4JtNsSP8CGDxGSr6QWR1dmfluhLSKLJUbKSYo8v11ehEwHmh70OxdrhoAaW
	8Ntar4FE=
X-Gm-Gg: AeBDievgJhWSajuTcgjIeO1vpW5rf2C2pSgJYt/FFbS61I/HvQgLYTOdL9qnTauiBIR
	GqtVcDeKFA+gNMgdP67vMJyZl40O58g05Ip8qNmPDmkfQTDD2klNspO+vdGJaBZrCJXSfegJHlx
	RKuBAtSEcJVPXWixuZfPHCipIbExvL5+ErFUYmLayk7Nb4yegNkW1sc8VvGi5S2kec40iF2irBH
	+q5Z9C7RHpzm5nHtyQe3X+pSGLPgd6UTm2n0mPvmhW3CE3fNZAuL5uBmH2qhpkIDGeYtJqrs2tb
	bSWZzT7imsvEvebbMpNS/iFgpIA50Y0r6Je7HUs7EwrQN7yryxNp6Lj/sJTc/9SRdkoo0MF/Ctz
	RQbssdr7lXhJTfLr30bJOpkVLQxx+NGyD6le+4jnlRvPVM8ssvdmLm6XG1BXEnTDTPkVQ3rvP7O
	tQQ0pvZKY+tOp2WaSazD6sPUzBrw5gRNTGUd/FAGD9xdhwNKsls1g1Zntad7awbEy/tLHJeITy8
	svIeHYmjTk=
X-Received: by 2002:a05:6402:2810:b0:671:eac2:d328 with SMTP id 4fb4d7f45d1cf-672bfd9d002mr10550351a12.10.1776872212945;
        Wed, 22 Apr 2026 08:36:52 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-673032b9e83sm3396532a12.4.2026.04.22.08.36.51
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 08:36:51 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-671ab90fc1fso11255239a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 08:36:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+3ABJ0YI44wHJuGsjxFjTSKnC+UQa7LfgYzVt8Dqb2bj/9FMCv4spFafV4lxGpw9dMNnDUS/s8U43N@vger.kernel.org
X-Received: by 2002:a17:907:a646:b0:ba9:3f1a:8735 with SMTP id
 a640c23a62f3a-ba93f1a878amr484489766b.33.1776872209534; Wed, 22 Apr 2026
 08:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419192018.3046449-1-metze@samba.org> <aehrPuY60VMcYGU8@infradead.org>
 <9cb0901c-18c5-4858-941c-3b37ee112af9@samba.org> <CAH2r5msb3-HiPSv+HgBknEwDXGsv0xU=TGCxHdmc-VCLKzYCmw@mail.gmail.com>
In-Reply-To: <CAH2r5msb3-HiPSv+HgBknEwDXGsv0xU=TGCxHdmc-VCLKzYCmw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Apr 2026 08:36:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHACPH7vBLo8CVSqR5-mgzP4ff7qJU6F=1exKTpQ0-7g@mail.gmail.com>
X-Gm-Features: AQROBzAXxjIZr7XwIp1v_ivj2KCglqqVek-fwbJ8jkNR7q5nEXQKW0WRvzxwAW8
Message-ID: <CAHk-=whHACPH7vBLo8CVSqR5-mgzP4ff7qJU6F=1exKTpQ0-7g@mail.gmail.com>
Subject: Re: [PATCH] smb: smbdirect: move fs/smb/common/smbdirect/ to fs/smb/smbdirect/
To: Steve French <smfrench@gmail.com>
Cc: Stefan Metzmacher <metze@samba.org>, Christoph Hellwig <hch@infradead.org>, linux-cifs@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	samba-technical@lists.samba.org, Tom Talpey <tom@talpey.com>, 
	Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19475-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samba.org:email]
X-Rspamd-Queue-Id: CAA23447FB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 at 07:49, Steve French <smfrench@gmail.com> wrote:
>
> On Wed, Apr 22, 2026 at 3:16=E2=80=AFAM Stefan Metzmacher <metze@samba.or=
g> wrote:
> > >
> > > Why is this not in net/smbdirect/ or driver/infiniband/ulp/smdirect?
> >
> > Yes, I also thought about net/smbdirect.
>
> I would prefer to leave it in fs/smb for the time being, since it makes i=
t
> easier to track since fs/smb/server and fs/smb/client have dependencies
> on it.   In the long run, I don't mind moving it, if it starts being
> used outside of smb client and server.

I personally have no hugely strong opinions, but I think Christophs
very question that gives two different alternative locations argues
for just leaving it in fs/smb/

That driver/infiniband/ulp/smdirect location in particular is just a
disgusting path.

It sure as hell is *not* a driver, it just uses the rdma infrastructure.

If rdma were to eventually itself split itself up into the driver code
and non-driver code (like networking does), that might change things,
but that's not happening now.

And as long as we expect smbdirect code to go through the smb
maintainer, I'd rather have the location be about that clear situation
rather than some arbitrary "it uses the rdma code" or "it's
networking".

Because that code is not primarily about networking or about rdma.
That code is primarily about smb.

So while I have no *strong* opinions and can deal with whatever
maintainers find convenient, I think fs/smb/smbdirect is at least
currently the sane location.

          Linus

