Return-Path: <linux-rdma+bounces-19329-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGyJJEcG3mlRmQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19329-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 11:17:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E94E33F7C79
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 11:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 814E630097E0
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 09:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D983BD242;
	Tue, 14 Apr 2026 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOSbjvsQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7812A3B9DA2
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158256; cv=none; b=nSuTFKtCY7CmIvt0So2z+I7efsdVwCydLK11SdIr3gEbPga4eP1Q5rRSykwSIwYP2j3LfTWe/M9U1mOv7DMTOVc0bmzW7mfWTHS3agOemBIyvZNHBh/bwJWGuTUk047feVOKxXtftFkS/FFQjxYDovu3xovZbT9vr97JjBlznhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158256; c=relaxed/simple;
	bh=Im93hMGzOEyfazCH17jiGCvum7o6LX/tIusdrDkKZ9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAHd1wd6Ga43AHpp2v2g6xfpa4azunh/MxIXfDlzTv8rgY13iNNibZsBfr6mXkjikRvr/3mHV1630WZYXNwyo++o+pzZXoPV4iP0vXB5nspB9fhfgGbvPZV6Ow8J+xQv6e/RXjhxzOMrjhO0hDJ+fAuuT5ytF652XAcVnPPSyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOSbjvsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C23C19425;
	Tue, 14 Apr 2026 09:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776158256;
	bh=Im93hMGzOEyfazCH17jiGCvum7o6LX/tIusdrDkKZ9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOSbjvsQZ2O7av5rPQBvKKjxgqhi8Pe9xnGh6UQoCqqHs/LKYcqWxhP7O2ZYReVCp
	 YPd4jxY3Q/XVCAsztKMGvtqWiTt1vFatCdI/uLPCQrr7kCPMyG9+PN6XfTl1qVrhTt
	 h0CEehodMWXkwrsl1mv0n49kLrOkk8M1Uuav1Ao7csKYhTkbsaCNXEs/846JWAzG9r
	 uEel4Fm/k1uNApky5SH6FrxCP+NNl7sJ7VloacVpNwB2reZ8Jc5veHiDnPDtfVKGox
	 1eeNrhaYovfDQckKBiq2S2T2AY7i2Or7E0IbjvaV4ULrOyfGImxKZ0QvIeKHIWWGVt
	 OsNxzSAFA8cug==
Date: Tue, 14 Apr 2026 12:17:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: Andrea Cervesato <andrea.cervesato@suse.de>,
	Linux Test Project <ltp@lists.linux.it>,
	Eric Biggers <ebiggers3@gmail.com>,
	Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [LTP] [PATCH 2/2] device-drivers/rdma: Add ucma_uaf01 test
Message-ID: <20260414091731.GT21470@unreal>
References: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
 <20260325-infiniband_rdma-v1-2-9c1bd3e69d29@suse.com>
 <20260407132426.GC25645@pevik>
 <20260412141439.GD21470@unreal>
 <20260414073010.GB230573@pevik>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260414073010.GB230573@pevik>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.de,lists.linux.it,gmail.com,redhat.com,ziepe.ca,vger.kernel.org,oss.oracle.com];
	TAGGED_FROM(0.00)[bounces-19329-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E94E33F7C79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 09:30:10AM +0200, Petr Vorel wrote:
> Hi Leon, all,
> 
> > On Tue, Apr 07, 2026 at 03:24:26PM +0200, Petr Vorel wrote:
> > > Hi Andrea,
> 
> > > it's been long time since this use-after-free was fixed, but IMHO still useful
> > > to have a test (it's also kind of smoke test for rdma_cm).
> > > Anyway, LGTM, but it'd be nice to reproduce the bug.
> 
> > > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> > > > Test for use-after-free in RDMA UCMA triggered by racing CREATE_ID,
> > > > BIND_IP, and LISTEN operations. Three threads concurrently issue
> > > > these commands to /dev/infiniband/rdma_cm and the test checks for
> > > > kernel taint (KASAN use-after-free detection).
> 
> > > > The bug was fixed by kernel commit 5fe23f262e05
> > > > ("ucma: fix a use-after-free in ucma_resolve_ip()").
> 
> > > > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > > > ---
> > > >  runtest/kernel_misc                               |   1 +
> > > >  testcases/kernel/device-drivers/Makefile          |   1 +
> > > >  testcases/kernel/device-drivers/rdma/.gitignore   |   1 +
> > > >  testcases/kernel/device-drivers/rdma/Makefile     |   7 +
> > > >  testcases/kernel/device-drivers/rdma/ucma_uaf01.c | 208 ++++++++++++++++++++++
> > > >  5 files changed, 218 insertions(+)
> 
> > <...>
> 
> > > > +static struct tst_test test = {
> > > > +	.test_all = run,
> > > > +	.setup = setup,
> > > > +	.cleanup = cleanup,
> > > > +	.runtime = 300,
> > > > +	.needs_root = 1,
> > > > +	.taint_check = TST_TAINT_W | TST_TAINT_D,
> > > > +	.needs_kconfigs = (const char *[]) {
> > > > +		"CONFIG_INFINIBAND",
> > > > +		"CONFIG_INFINIBAND_USER_ACCESS",
> 
> > I’m not familiar with the LTP tests, but I wanted to point out that these
> > config options are insufficient. You need an actual or virtual RDMA device
> > connected to rdma-cm for the tests to work correctly.
> 
> Leon, thanks for looking into it. FYI these are just config options to skip
> kernels without required kernel modules. 
> 
> So using /dev/infiniband/rdma_cm (via RDMA_CM_DEV) is not enough, we need
> another device?

Yes, `rdma-cm` provides an interface for address resolution on
IB/iWARP/RoCE networks without requiring knowledge of the underlying
fabric details.

When an IB device is registered, RDMA/core invokes `cm_add_one()`, which
attaches `rdma-cm` to that device.
https://elixir.bootlin.com/linux/v7.0/source/drivers/infiniband/core/cm.c#L4335

Thanks

> 
> Kind regards,
> Petr

