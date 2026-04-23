Return-Path: <linux-rdma+bounces-19491-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INuWLJzo6Wn+nAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19491-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 11:38:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B89AD44FD0C
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 11:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 766F3305534A
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB373E4C63;
	Thu, 23 Apr 2026 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KfWMoPNc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ozNopPqo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KfWMoPNc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ozNopPqo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152973E3C74
	for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936469; cv=none; b=FnOlpyW93/E+OnkKhucdkr3aWGTE/cdg6faTmU1FntdbPGLgwr/yEg+5ZYlhc5/nslF+YFOGy/G2vg2NHX1XETaYjhXL7YOvzwVLNFF9jweaXINZrFni3G8GkbTTWxIImnwRZod8RfnR9yZXTMiyV8AgeOcNPmFTW9vCZTGmJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936469; c=relaxed/simple;
	bh=J8zuB+36+21An0Ys+NQd9QNXpbSjs/BAj2aMGbJaMSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjf1tQ+akZ3jkzsqJEzrnCw773CUMYVxNpIZf11u5FHMHKnOUQp3rHt+prnn3cI4puONW/arlmVtfBBgRBbmF//06Z1wxVDhhJnPfBnllcD4rdicUqhLS2AO9ilhEaRCWn5qabnzl6GuoqB8cmD4onT9mHh7W8s3SAXjnloONVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KfWMoPNc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ozNopPqo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KfWMoPNc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ozNopPqo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3FF2F5BCED;
	Thu, 23 Apr 2026 09:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776936466;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Szb/77FrY07rl0gE1fIlIEDTcWYlFSvdGAl1J9gVNes=;
	b=KfWMoPNcnfFZXgCW9cjsvXlQX6oPb1LzpxolFoXRWntmxAPQh0nPnBtD52lS/x+aKQJ6qO
	e7Wik//rzyPSOH8g9ngmH+hEyP3Q7hoKFPs76NQ4YRCOCtcXaw88F4pm+vn3vGOckW0ywG
	ZOXx4Y98TuRWg9w2C0hVan3Jn9zpVoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776936466;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Szb/77FrY07rl0gE1fIlIEDTcWYlFSvdGAl1J9gVNes=;
	b=ozNopPqoUB9ccdHXL6R+I69BQ5sZbLzf8A0/Mp1npdzc2eRWMDcogcEk8l/tf9aTcD8jDw
	LxSuYX6X0pkE+/Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776936466;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Szb/77FrY07rl0gE1fIlIEDTcWYlFSvdGAl1J9gVNes=;
	b=KfWMoPNcnfFZXgCW9cjsvXlQX6oPb1LzpxolFoXRWntmxAPQh0nPnBtD52lS/x+aKQJ6qO
	e7Wik//rzyPSOH8g9ngmH+hEyP3Q7hoKFPs76NQ4YRCOCtcXaw88F4pm+vn3vGOckW0ywG
	ZOXx4Y98TuRWg9w2C0hVan3Jn9zpVoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776936466;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Szb/77FrY07rl0gE1fIlIEDTcWYlFSvdGAl1J9gVNes=;
	b=ozNopPqoUB9ccdHXL6R+I69BQ5sZbLzf8A0/Mp1npdzc2eRWMDcogcEk8l/tf9aTcD8jDw
	LxSuYX6X0pkE+/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00FDC593A3;
	Thu, 23 Apr 2026 09:27:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +g4COhHm6WmmMgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 23 Apr 2026 09:27:45 +0000
Date: Thu, 23 Apr 2026 11:27:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Leon Romanovsky <leon@kernel.org>
Cc: Andrea Cervesato <andrea.cervesato@suse.de>,
	Linux Test Project <ltp@lists.linux.it>,
	Eric Biggers <ebiggers3@gmail.com>,
	Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [LTP] [PATCH 2/2] device-drivers/rdma: Add ucma_uaf01 test
Message-ID: <20260423092744.GA664042@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
 <20260325-infiniband_rdma-v1-2-9c1bd3e69d29@suse.com>
 <20260407132426.GC25645@pevik>
 <20260412141439.GD21470@unreal>
 <20260414073010.GB230573@pevik>
 <20260414091731.GT21470@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260414091731.GT21470@unreal>
X-Spam-Flag: NO
X-Spam-Score: -3.50
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.de,lists.linux.it,gmail.com,redhat.com,ziepe.ca,vger.kernel.org,oss.oracle.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19491-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:url];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[pvorel@suse.cz];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvorel@suse.cz,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: B89AD44FD0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Leon, all,

> On Tue, Apr 14, 2026 at 09:30:10AM +0200, Petr Vorel wrote:
> > Hi Leon, all,

> > > On Tue, Apr 07, 2026 at 03:24:26PM +0200, Petr Vorel wrote:
> > > > Hi Andrea,

> > > > it's been long time since this use-after-free was fixed, but IMHO still useful
> > > > to have a test (it's also kind of smoke test for rdma_cm).
> > > > Anyway, LGTM, but it'd be nice to reproduce the bug.

> > > > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > > > > Test for use-after-free in RDMA UCMA triggered by racing CREATE_ID,
> > > > > BIND_IP, and LISTEN operations. Three threads concurrently issue
> > > > > these commands to /dev/infiniband/rdma_cm and the test checks for
> > > > > kernel taint (KASAN use-after-free detection).

> > > > > The bug was fixed by kernel commit 5fe23f262e05
> > > > > ("ucma: fix a use-after-free in ucma_resolve_ip()").

> > > > > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > > > > ---
> > > > >  runtest/kernel_misc                               |   1 +
> > > > >  testcases/kernel/device-drivers/Makefile          |   1 +
> > > > >  testcases/kernel/device-drivers/rdma/.gitignore   |   1 +
> > > > >  testcases/kernel/device-drivers/rdma/Makefile     |   7 +
> > > > >  testcases/kernel/device-drivers/rdma/ucma_uaf01.c | 208 ++++++++++++++++++++++
> > > > >  5 files changed, 218 insertions(+)

> > > <...>

> > > > > +static struct tst_test test = {
> > > > > +	.test_all = run,
> > > > > +	.setup = setup,
> > > > > +	.cleanup = cleanup,
> > > > > +	.runtime = 300,
> > > > > +	.needs_root = 1,
> > > > > +	.taint_check = TST_TAINT_W | TST_TAINT_D,
> > > > > +	.needs_kconfigs = (const char *[]) {
> > > > > +		"CONFIG_INFINIBAND",
> > > > > +		"CONFIG_INFINIBAND_USER_ACCESS",

> > > I’m not familiar with the LTP tests, but I wanted to point out that these
> > > config options are insufficient. You need an actual or virtual RDMA device
> > > connected to rdma-cm for the tests to work correctly.

> > Leon, thanks for looking into it. FYI these are just config options to skip
> > kernels without required kernel modules. 

> > So using /dev/infiniband/rdma_cm (via RDMA_CM_DEV) is not enough, we need
> > another device?

> Yes, `rdma-cm` provides an interface for address resolution on
> IB/iWARP/RoCE networks without requiring knowledge of the underlying
> fabric details.

> When an IB device is registered, RDMA/core invokes `cm_add_one()`, which
> attaches `rdma-cm` to that device.
> https://elixir.bootlin.com/linux/v7.0/source/drivers/infiniband/core/cm.c#L4335

Leon, thanks a lot for a clarification. Setting patch "changes requested".

Kind regards,
Petr

> Thanks


> > Kind regards,
> > Petr

