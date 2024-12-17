Return-Path: <linux-rdma+bounces-6564-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 017E49F45B4
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 09:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5D6188E70B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 08:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FFF1D63D9;
	Tue, 17 Dec 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zJBPn0dS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VOaQattS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y7aTsgPZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JcTevVWp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A1126BF7
	for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423057; cv=none; b=Yc5sTylSWFydPb7WI1idLf5I9CqAC/HuteroQn98/ijjOgJ92LLTu3aal/7aqM1okaalc6y5W5BvYyt5XdPuOc62wT9Znpbti9fNrBiAqY53w3U9VawW7PaIq0i8pvC6EgOY/wBxvNwcEIIUNqUiQgAB0+4ZrizHQ/i8lQJdU+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423057; c=relaxed/simple;
	bh=gdwKvyrR2x3/vqIKePE2WCQUFwb9b9SJAXwNzKfeQHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNVkUbsJMo44d8nEouNCKClIq9dOb+fMRkaXvwSHxJAi2rzD4od0Ke9z/vtSMKXfIjZs0kFvIuj12FAN2nVhoJIQ3KB3kBOz1zqi0owiVQp6RKvg0AG/cXYBRFvilTcSEROAxn/JRYzyxRE+J3xeddFdTofXRYhNDBNtfizqQrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zJBPn0dS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VOaQattS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y7aTsgPZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JcTevVWp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CEC0D1F385;
	Tue, 17 Dec 2024 08:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734423054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atemCgV4vYG5vtjXsboCRaVK85rO2gt63sLTqJQh4/Y=;
	b=zJBPn0dS3z1nuU3Uis2feErpynObdWMCmN+ZHOTyVGjMx5yTLGRyUOh9S/z4QaZRH96s9y
	/sR7BcSOM3aL2otP3hJ1KAOjr5nkNX1utqnBhddIMIIZrA9YHmTSX24ZjtY5JUddafsNB7
	ZqHSGlGmubjM2ZXLic4GPwx7JaYse8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734423054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atemCgV4vYG5vtjXsboCRaVK85rO2gt63sLTqJQh4/Y=;
	b=VOaQattShvRqopilCAAfYohWr2MCCenra/gBK+hNSMtDMOS5NeEehiioToRDEqy8l5X0oY
	XigSTiJVpiIPnaBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734423053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atemCgV4vYG5vtjXsboCRaVK85rO2gt63sLTqJQh4/Y=;
	b=y7aTsgPZwDbmj4se8e/v6KSUNqMjW7Z5hyu+cbQ7CdXss05RpMmZ90iH4Ezj75de8v8bEi
	7T/W/C6KD2MehQhmuOvnuh2T4pj/tNvTbHsh/p4Rdl/6QSNYfxo+Pb0VlxsXFnBLVK437P
	zui8IVGXNyHhHMvNlIMFhs0B4UZZw7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734423053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atemCgV4vYG5vtjXsboCRaVK85rO2gt63sLTqJQh4/Y=;
	b=JcTevVWpJ6Seo2j0pg4XUQdMFYP/RIXxvLrExBxsGvgEXQHFDr0hbOMIZUvrBqSAqtWObZ
	fA06qqOgg1YBMYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A77ED13A3C;
	Tue, 17 Dec 2024 08:10:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fojSJg0yYWeRFgAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Tue, 17 Dec 2024 08:10:53 +0000
Date: Tue, 17 Dec 2024 09:10:42 +0100
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: tpearson@raptorengineering.com
Cc: rug@usm.lmu.de, linux-rdma@vger.kernel.org
Subject: Re: Infiniband crash
Message-ID: <20241217091042.6a4f1759@samweis>
In-Reply-To: <fba3779b3e870b9f26bb97a9e5c5b0e4.tpearson@raptorengineering.com>
References: <fba3779b3e870b9f26bb97a9e5c5b0e4.tpearson@raptorengineering.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 16 Dec 2024 12:05:39 -0600
tpearson@raptorengineering.com wrote:

> Did you ever find a solution for this?  We're running into the same probl=
em on a highly customized aarch64 system (NXP QorIQ platform), same Infinba=
nd adapter and very similar crash:
>=20
> [    4.544159] OF: /soc/pcie@3600000: no iommu-map translation for id 0x1=
00 on (null)
> [    4.551873] ib_mthca: Mellanox InfiniBand HCA driver v1.0 (April 4, 20=
08)
> [    4.558690] ib_mthca: Initializing 0000:01:00.0
> [    6.258309] ib_mthca 0000:01:00.0: HCA FW version 5.1.000 is old (5.3.=
000 is current).
> [    6.266272] ib_mthca 0000:01:00.0: If you have problems, try updating =
your HCA FW.
> [    6.393143] ib_mthca 0000:01:00.0 ibp1s0: renamed from ib0
> [    6.399038] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000010
> [    6.407865] Mem abort info:
> [    6.410662]   ESR =3D 0x0000000096000004
> [    6.414419]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [    6.419748]   SET =3D 0, FnV =3D 0
> [    6.422806]   EA =3D 0, S1PTW =3D 0
> [    6.425952]   FSC =3D 0x04: level 0 translation fault
> [    6.430842] Data abort info:
> [    6.433725]   ISV =3D 0, ISS =3D 0x00000004
> [    6.437569]   CM =3D 0, WnR =3D 0
> [    6.440540] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000008086f60000
> [    6.447003] [0000000000000010] pgd=3D0000000000000000, p4d=3D000000000=
0000000
> [    6.453819] Internal error: Oops: 0000000096000004 [#1] SMP
> [    6.459412] Modules linked in: ib_ipoib(E) ib_umad(E) rdma_ucm(E) rdma=
_cm(E) iw_cm(E) ib_cm(E) configfs(E) ib_mthca(E) ib_uverbs(E) ib_core(E)
> [    6.472263] CPU: 0 PID: 100 Comm: kworker/u17:0 Tainted: G            =
E      6.1.0+ #55
> [    6.480297] Hardware name: Freescale Layerscape 2080a RDB Board (DT)
> [    6.486670] Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
> [    6.492636] pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [    6.499624] pc : mthca_poll_cq+0x4f0/0x9a0 [ib_mthca]
> [    6.504703] lr : mthca_poll_cq+0x1e8/0x9a0 [ib_mthca]
>=20
> Since this is apparently hitting two different architectures, I suspect t=
he problem is in the driver, not the arch-specific code.  I may recommend w=
e upgrade the card to work around this, but given the rarity of the hardwar=
e it's not something I want to recommend tinkering with and it may or may n=
ot even accept the new card in the first place.

which kernel version is this ? It looks like the bug fixed with

dc52aadbc184 RDMA/mthca: Fix crash when polling CQ for shared QPs

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich

