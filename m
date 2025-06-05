Return-Path: <linux-rdma+bounces-11040-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A3FACF375
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 17:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE42179B0C
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 15:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972521E5B64;
	Thu,  5 Jun 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HyIhVUcB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TFQv1fIq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699141DED69;
	Thu,  5 Jun 2025 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749138851; cv=none; b=nHdbbEYAEJ0LzqEoN15zFi9ltm1Bjj78m6DfJCutP2Qdi9vswLOFlw8c00rvQ3WxtHmZzK5GgDzJe+W0h8ju6TwpXfEVbiDmEi7TWTOVsX0l2f42NnHrIsqXDjyknhsQvTBHOSZRCKW0eSlpnjxiDOBSbh8d6euQ0btEaSkv1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749138851; c=relaxed/simple;
	bh=GG5pH0WumM+1EtuumeUEtMhwO7i52Jn7UO0eiIvnzoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPDh1NMLqYFHVDgQ2V99O9RJuSC+Ke/g9qx1hbmL1t2bWJWuzjZjm9H1ZLOQZ98BcqY5pkSKdKGs82Ud4TIUK267fR2zGRSdY7uwAZDlAa+/nyKA5Nf3ahkNp5D1FOlhZA3o6bEXxbjMatgBUO+9sRIMZIpJ6qfgOrowmrRpaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HyIhVUcB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TFQv1fIq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Jun 2025 17:54:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749138847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUZKiCDB3kruCoH3meBGYpAjvuH1dsB48dpAegEVExA=;
	b=HyIhVUcBRunFL+9nv9XcR33JwHfWW6DX1qu4vYh6buxnGMLY4ZHnx7xjt6Zu2VA0F7E4/M
	Gec6JWwVk/Wki4z+D2+4LOBW/glSFhxSwHZaaisrYoCXffM3VmtZymfMcIZ1S2EbU3+V/i
	55G9TcJ1zb89JLdfL7FisVctMHjg4YYHw/6fvAFLFU3Xs+KZjP8tn/RA95IqlWhDimF+FM
	HuDs9KIGjEgQt7jgJ0WUU9kwasw/kw7uA5V2GTseK3wW6zGqYnyc3HWd1U9to3p5ZrY5IO
	yrIdzT/x6UbwfmOnfpTaU6P1Rg0sDGQeKwh3Ait4vCsUwhO2le7AJrAdl93LIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749138847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUZKiCDB3kruCoH3meBGYpAjvuH1dsB48dpAegEVExA=;
	b=TFQv1fIqG2rR9BuyhfqHSruT9hCxu8iBZVCvPsWvP7P8zrc4RO+xIwZUK3pDpha3FNap7l
	3HXm19ax10u6I5CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] module: Make sure relocations are applied to the
 per-CPU section
Message-ID: <20250605155405.3BiTtQej@linutronix.de>
References: <202506041623.e45e4f7d-lkp@intel.com>
 <20250604152707.CieD9tN0@linutronix.de>
 <20250605060738.SzA3UESe@linutronix.de>
 <beb343ec-6349-4f9c-9fea-588b04eb49ee@suse.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <beb343ec-6349-4f9c-9fea-588b04eb49ee@suse.com>

On 2025-06-05 15:44:23 [+0200], Petr Pavlu wrote:
> Isn't this broken earlier by "Don't relocate non-allocated regions in mod=
ules."
> (pre-Git, [1])?

Looking further back into the history, we have
	21af2f0289dea ("[PATCH] per-cpu support inside modules (minimal)")

which does

+       if (pcpuindex) {
+               /* We have a special allocation for this section. */
+               mod->percpu =3D percpu_modalloc(sechdrs[pcpuindex].sh_size,
+                                             sechdrs[pcpuindex].sh_addrali=
gn);
+               if (!mod->percpu) {
+                       err =3D -ENOMEM;
+                       goto free_mod;
+               }
+               sechdrs[pcpuindex].sh_flags &=3D ~(unsigned long)SHF_ALLOC;
+       }

so this looks like the origin.

=E2=80=A6
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2816,6 +2816,10 @@ static struct module *layout_and_allocate(struct=
 load_info *info, int flags)
> >  	if (err)
> >  		return ERR_PTR(err);
> > =20
> > +	/* Add SHF_ALLOC back so that relocations are applied. */
> > +	if (IS_ENABLED(CONFIG_SMP) && info->index.pcpu)
> > +		info->sechdrs[info->index.pcpu].sh_flags |=3D SHF_ALLOC;
> > +
> >  	/* Module has been copied to its final place now: return it. */
> >  	mod =3D (void *)info->sechdrs[info->index.mod].sh_addr;
> >  	kmemleak_load_module(mod, info);
>=20
> This looks like a valid fix. The info->sechdrs[info->index.pcpu].sh_addr
> is set by rewrite_section_headers() to point to the percpu data in the
> userspace-passed ELF copy. The section has SHF_ALLOC reset, so it
> doesn't move and the sh_addr isn't adjusted by move_module(). The
> function apply_relocations() then applies the relocations in the initial
> ELF copy. Finally, post_relocation() copies the relocated percpu data to
> their final per-CPU destinations.
>=20
> However, I'm not sure if it is best to manipulate the SHF_ALLOC flag in
> this way. It is ok to reset it once, but if we need to set it back again
> then I would reconsider this.

I had the other way around but this flag is not considered anywhere
else other than the functions called here. So I decided to add back what
was taken once.

> An alternative approach could be to teach apply_relocations() that the
> percpu section is special and should be relocated even though it doesn't
> have SHF_ALLOC set. This would also allow adding a comment explaining
> that we're relocating the data in the original ELF copy, which I find
> useful to mention as it is different to other relocation processing.

Not sure if this makes it better. It looks like it continues a
workaround=E2=80=A6
The only reason why it has been removed in the first place is to skip
the copy process.
We could also keep the flag and skip the section during the copy
process based on its id. This was the original intention.

> For instance:
>=20
> 	/*
> 	 * Don't bother with non-allocated sections.
> 	 *
> 	 * An exception is the percpu section, which has separate allocations
> 	 * for individual CPUs. We relocate the percpu section in the initial
> 	 * ELF template and subsequently copy it to the per-CPU destinations.
> 	 */
> 	if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC) &&
> 	    infosec !=3D info->index.pcpu)
> 		continue;
>=20

If you insist but=E2=80=A6

Sebastian

