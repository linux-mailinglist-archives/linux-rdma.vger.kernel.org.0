Return-Path: <linux-rdma+bounces-16675-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDxUDJomiGmEjwQAu9opvQ
	(envelope-from <linux-rdma+bounces-16675-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Feb 2026 07:00:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91633107F67
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Feb 2026 07:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03944300D6B7
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Feb 2026 06:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83B21D585;
	Sun,  8 Feb 2026 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6l+vdF0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC94C6C
	for <linux-rdma@vger.kernel.org>; Sun,  8 Feb 2026 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770530453; cv=pass; b=tNqLOF/PO0578Gbwsog32cY4tZ3lLXWdgwzhqTjW3m/dpxVvH9b3nNN7DxQHRc6EZ8TvKntX8PENEKTfT0Nf4zUuHzOthLGCTThTrnq8dXyk0uBDyzpkYF/xjwEgBjLdl89WrZX0/3aT7CGWphX8ZjgjgPwnslnGzhLCRHMELbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770530453; c=relaxed/simple;
	bh=e/7Rp0EitaI11Hgpal9bjYkFFm2Aq3H16ynsbBvqxfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtJ6mP4CZ/iBMhu61s4GpqoLFn8yhWnfD16/W06YwxUdmqyRWnsNaGdeaZCe876NOuJv7VYndSdxm+0q1npTOswoQaG6ittoUacRRK+9HlG69XWfiI/Rr6iiEmgUA2gvOOItIWW/0gSe3oUlIqgNd7r+8mKUl4xqC90IivxRTgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6l+vdF0; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3530e7b3dc2so2937159a91.3
        for <linux-rdma@vger.kernel.org>; Sat, 07 Feb 2026 22:00:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770530452; cv=none;
        d=google.com; s=arc-20240605;
        b=HTE+9+AyprmtDZIFipqYU6W+MBOmLuWuwchXgyRjzAt5nr8DKpm1MOD1Puhh2wjehG
         u86jWd4XHIBgk7j37nzpu7q+1jJutYv8dzPTzb3Dnh3H3G4etSbg2E5Mq4R9VjrebLDp
         udfDQZmqvcE9nX7e5GIgtvXrJcAFZfMGwCWmtsMq73HWG05CQUpuapMfc8IRPskrYVoa
         eoEyV22riU29WTel4PmYmXv75UNQ1ayjeBhv4LN8gvSw4EYkJ2QCctblhrY8H6cZERE5
         dSipUjvshnIeApv0avjoSQug9UKPNJCiY9ZwOT5bNYBrRHEHZsihQc/BIsmULXKEtv/C
         29PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c7NuFUTTLd0OsiutW0KDpQYjtRJpTa5MW5ZavoS5tPA=;
        fh=tCPkibM14nTKl2plZRo3YI8MAqvt9GDfn/IuWhpvslI=;
        b=k8PQ2rtDJRAa4p34sh5yDFVEdU0xBUkLUxLp3/2hcZK7zGB942hkU/8gqRnIFLJ/Ze
         pT1oJazV3fRpXk+8eRfW3gXh8q/Ll7Yx5UYDNogkLHztew2ms444j/waHX2jA58siGxX
         FiPkMgH4aeXApJwZDG36o3nIBA3ptVZh4m17Q8NPMZJcqBFoW7nnoLpAN7EM22xox/PU
         mhNTFtrf2yBrqa5INUVdK7Pk/XzRAc3Wduigs9PRujenzo14oKjE/PTbWER6GRmy0OJO
         FZrY9pUUnMPM+eXgYTN9e6wD+GY9G0PZ9Jyne8AFy+ocrcA2VYU0eJ1G8ipmSSxcEVeM
         heCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770530452; x=1771135252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7NuFUTTLd0OsiutW0KDpQYjtRJpTa5MW5ZavoS5tPA=;
        b=f6l+vdF06dSX8H/qNoSa8JxQGI6ZEWCCd0PN6bM+0Yj6rVveSmhTsUobImF3jyi9us
         P0o1ifymcPkRFHVIbpUY4MDxY+HylSE+Gkxn8uXWzbULKeUDMveexqBqys70pqsW56OB
         uuOuhQEkte8XdfM8sYuXMq/Wi2E+SWxYvCkn4iXndnSj27FhQ3R0FmR8vgOVdy/wdXxo
         L/QUcMuGJLp3CZ0SXvu3z9Dcohlyd1SMFJtR2E87PYm03skOnE1Ua42OftAJxV0cYRxc
         bEWU+HG3sxc7InQw0uLPPQlR4STH9yUMBv1RpNHRfMh0fJM7REKA4w59faJ/+/FPOzQD
         3sdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770530452; x=1771135252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c7NuFUTTLd0OsiutW0KDpQYjtRJpTa5MW5ZavoS5tPA=;
        b=uFrU0dQXNrclY+GQrtOsaD9SnXFoCZotUwdzAtJnVbpEHZvnOV3GjNKlyLG6iDO++A
         yjLIo5/Jkiw72al33NtGizARb2MHIV+dEuuro9rInjvhhZj0eJ1iGAowPGwnK2TxeIwo
         Q0zWK2x3NFvKuVTH7MxrCll0Jk8l+VBWdhyuzn88sSGj/Fw4oHICswqo5cMaBzUPxIBk
         Mj0aJlCng9EP8y2iUJmFEyXp0k/kJ5flSFk/wCyM2GPtOKCtLx/Z/NDSfKpQ1nScKR9o
         AU6RzsXU5HwPDx7YV3dpKl/iPn0Rnr5gZtwTfk/Oc+/WI8jwd5AA7IDXchchmGFTMt8c
         SJJg==
X-Forwarded-Encrypted: i=1; AJvYcCW9PavAEf+qgvu9Vk14aZ3lZZJ81YhGpxmSgEGQMOAbwPUARULNY8SDk1VWZnHuHByoDNHv6I5DD+md@vger.kernel.org
X-Gm-Message-State: AOJu0YywzYr3zmLXMstikXhYLpGh+kHNtdoh+nZ+ixnt0hxPRPBoaiq4
	WIr+vwPWQb7Mz0ewAHHSi0genceZngKKkTTgIlwZNHtxyOxFynYyCy9DGS3AmdG31GTC1SuTh3E
	48Po5HarzFFf1KJrT5Kmwk1Z0o6dzY2nCg5axSSY=
X-Gm-Gg: AZuq6aKVfpCrX+Wq/laJM3scXgLqyIOclqLVMN9IloYk4kELoJHbZv4/gK+rLdEvLej
	tf1Nkh8WQmTV/plt6fNrAw37uB7XW7iBxQHWwRnjCU5b1KMmIMMezHbtlY7I61z0fU4SfougUTH
	hkm4HcbEDl2x4ARqtmHHSXX3yM93Q/hYnbyqoUDaap4x7azMTxswFsWRAGWlvdRDTU/7BySVgvi
	DNF8LKGdYjYdB5Nqy8uZO6zE5or8a1TBDJgod8GhxIExOoEqqBa6uMQK7YYWwvgNWmcKcIr
X-Received: by 2002:a17:90b:3809:b0:34a:b8fc:f1d8 with SMTP id
 98e67ed59e1d1-354b3e7644bmr7322075a91.37.1770530452542; Sat, 07 Feb 2026
 22:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203100628.1215408-1-ioerts@kookmin.ac.kr> <177029600846.954009.5373952829243937545.b4-ty@kernel.org>
In-Reply-To: <177029600846.954009.5373952829243937545.b4-ty@kernel.org>
From: yunje shin <yjshin0438@gmail.com>
Date: Sun, 8 Feb 2026 15:00:41 +0900
X-Gm-Features: AZwV_QgVbBM36jkP1egfW3wW5J-XxBPwYgnXxGYIT-j-nx8wwI37TrYQsmFZ-pk
Message-ID: <CAMX6_QFeVW=ZgyLT_07GeEbn443osvaPa6XUWFeqztFRmfUEmg@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/umad: Reject negative data_len in ib_umad_write
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, ioerts@kookmin.ac.kr, joonkyoj@yonsei.ac.kr, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16675-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yjshin0438@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91633107F67
X-Rspamd-Action: no action

I noticed I missed the Cc: stable tag. Should this fix be backported
to stable trees as well?

Thanks, YunJe Shin

On Thu, Feb 5, 2026 at 9:53=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
>
> On Tue, 03 Feb 2026 19:06:21 +0900, YunJe Shin wrote:
> > ib_umad_write computes data_len from user-controlled count and the
> > MAD header sizes. With a mismatched user MAD header size and RMPP
> > header length, data_len can become negative and reach ib_create_send_ma=
d().
> > This can make the padding calculation exceed the segment size and trigg=
er
> > an out-of-bounds memset in alloc_send_rmpp_list().
> >
> > Add an explicit check to reject negative data_len before creating the
> > send buffer.
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] RDMA/umad: Reject negative data_len in ib_umad_write
>       https://git.kernel.org/rdma/rdma/c/5551b02fdbfd85
>
> Best regards,
> --
> Leon Romanovsky <leon@kernel.org>
>

