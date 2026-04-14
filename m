Return-Path: <linux-rdma+bounces-19325-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDoELj/t3WmulAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19325-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 09:31:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D25E3F6A4F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 09:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 921CE300AD81
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 07:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A98A370D41;
	Tue, 14 Apr 2026 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vO9aFAS3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R4WbjvE+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vO9aFAS3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R4WbjvE+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E633636E465
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151815; cv=none; b=Z4gJ7bQMsvkgm7MkzEYovtaNgYS6M2OxvZhZHRUbR/dRdF/wV/wozXu7LBZQTypJPlEoWvBD4h0POniZwE5fo4ULV2SeqD9VRmyyzcs0urHSkR/+FEdk3mEIIezorOiXDbzIk+ExnSiFBULj4Pg1PSTtu1zZMkeAp+gZ+s1UsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151815; c=relaxed/simple;
	bh=3hFK0HZasNyhIjHnXNJ40uKqmqMx5gZeOwYEt+tKLCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shqirFkzn3+K0OZak0598XW5NYJEPccYnvvp7QAqlTNsF7ic4KMPw3NNL102z7hoMoxXVt7KRIWnH4TZuJudrzJpE9ruN1++0c1XdT8zmMwmqG/Qs/l1NFlaV7m7kKB0MWP1R3/oyjYJS04SchDo+F73IyPap3BBOjYyFdbpN7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vO9aFAS3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R4WbjvE+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vO9aFAS3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R4WbjvE+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 254D05BDB5;
	Tue, 14 Apr 2026 07:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776151812;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nljOM/O1kIK+0e+n0gw6fJtlQl6wZ38dkY60SNCfVB8=;
	b=vO9aFAS3JrZqzqhwLzuysdrEi3nzu67BiK7OHpbPoeYJSQSC1AyvqO2Dqt83GymQybvANV
	PSyRWrDeuvPqa/vtam93eG3oJ8j7YwFTJjqROSBh9GufWQwdnDTVqfiS1KbQjTuEx/Jx+K
	jIY2QdAvxbL87SSVt4VOcsHxbQO4VCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776151812;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nljOM/O1kIK+0e+n0gw6fJtlQl6wZ38dkY60SNCfVB8=;
	b=R4WbjvE+qtSOdfIkDV0P8vGgMAVpLuFFNimEANwsesdPZq7uNtO3wJomXFPSau2tZcaqte
	piriBTRytzJ/F9CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776151812;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nljOM/O1kIK+0e+n0gw6fJtlQl6wZ38dkY60SNCfVB8=;
	b=vO9aFAS3JrZqzqhwLzuysdrEi3nzu67BiK7OHpbPoeYJSQSC1AyvqO2Dqt83GymQybvANV
	PSyRWrDeuvPqa/vtam93eG3oJ8j7YwFTJjqROSBh9GufWQwdnDTVqfiS1KbQjTuEx/Jx+K
	jIY2QdAvxbL87SSVt4VOcsHxbQO4VCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776151812;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nljOM/O1kIK+0e+n0gw6fJtlQl6wZ38dkY60SNCfVB8=;
	b=R4WbjvE+qtSOdfIkDV0P8vGgMAVpLuFFNimEANwsesdPZq7uNtO3wJomXFPSau2tZcaqte
	piriBTRytzJ/F9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7B7C4B317;
	Tue, 14 Apr 2026 07:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v42tNwPt3WmiVQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 14 Apr 2026 07:30:11 +0000
Date: Tue, 14 Apr 2026 09:30:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Leon Romanovsky <leon@kernel.org>
Cc: Andrea Cervesato <andrea.cervesato@suse.de>,
	Linux Test Project <ltp@lists.linux.it>,
	Eric Biggers <ebiggers3@gmail.com>,
	Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [LTP] [PATCH 2/2] device-drivers/rdma: Add ucma_uaf01 test
Message-ID: <20260414073010.GB230573@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
 <20260325-infiniband_rdma-v1-2-9c1bd3e69d29@suse.com>
 <20260407132426.GC25645@pevik>
 <20260412141439.GD21470@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260412141439.GD21470@unreal>
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
	TAGGED_FROM(0.00)[bounces-19325-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:dkim,suse.cz:replyto,suse.cz:email];
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
X-Rspamd-Queue-Id: 5D25E3F6A4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Leon, all,

> On Tue, Apr 07, 2026 at 03:24:26PM +0200, Petr Vorel wrote:
> > Hi Andrea,

> > it's been long time since this use-after-free was fixed, but IMHO still useful
> > to have a test (it's also kind of smoke test for rdma_cm).
> > Anyway, LGTM, but it'd be nice to reproduce the bug.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > > Test for use-after-free in RDMA UCMA triggered by racing CREATE_ID,
> > > BIND_IP, and LISTEN operations. Three threads concurrently issue
> > > these commands to /dev/infiniband/rdma_cm and the test checks for
> > > kernel taint (KASAN use-after-free detection).

> > > The bug was fixed by kernel commit 5fe23f262e05
> > > ("ucma: fix a use-after-free in ucma_resolve_ip()").

> > > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > > ---
> > >  runtest/kernel_misc                               |   1 +
> > >  testcases/kernel/device-drivers/Makefile          |   1 +
> > >  testcases/kernel/device-drivers/rdma/.gitignore   |   1 +
> > >  testcases/kernel/device-drivers/rdma/Makefile     |   7 +
> > >  testcases/kernel/device-drivers/rdma/ucma_uaf01.c | 208 ++++++++++++++++++++++
> > >  5 files changed, 218 insertions(+)

> <...>

> > > +static struct tst_test test = {
> > > +	.test_all = run,
> > > +	.setup = setup,
> > > +	.cleanup = cleanup,
> > > +	.runtime = 300,
> > > +	.needs_root = 1,
> > > +	.taint_check = TST_TAINT_W | TST_TAINT_D,
> > > +	.needs_kconfigs = (const char *[]) {
> > > +		"CONFIG_INFINIBAND",
> > > +		"CONFIG_INFINIBAND_USER_ACCESS",

> I’m not familiar with the LTP tests, but I wanted to point out that these
> config options are insufficient. You need an actual or virtual RDMA device
> connected to rdma-cm for the tests to work correctly.

Leon, thanks for looking into it. FYI these are just config options to skip
kernels without required kernel modules. 

So using /dev/infiniband/rdma_cm (via RDMA_CM_DEV) is not enough, we need
another device?

Kind regards,
Petr

