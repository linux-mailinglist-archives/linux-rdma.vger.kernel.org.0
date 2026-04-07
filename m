Return-Path: <linux-rdma+bounces-19089-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Iy3G3gG1WnbzgcAu9opvQ
	(envelope-from <linux-rdma+bounces-19089-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 15:28:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C043AF17D
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 15:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 307CF302EEE7
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 13:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B463B7776;
	Tue,  7 Apr 2026 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AQop48uv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C68PrTC0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kNPysONF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VVT9jt8f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB213B6C10
	for <linux-rdma@vger.kernel.org>; Tue,  7 Apr 2026 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568275; cv=none; b=MysDI8AayR9WO7/uVWstCTnesHQA/MNUk+ipIhg9igNQbH20suxKCsjJfR96Q6eAoGeizVcxCo0V8f52L5FPI8AAy7aYxkOcoxQrs97dyC7Ct/3CXuwb6N9RMGeV4482th/aTW64OSr+KOyqdsHJf1yYjJO+/XTqtrQwutIbQCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568275; c=relaxed/simple;
	bh=XpzG+9JdXT5E+0bLUdXX6WiWDYjnxTgKUfIlQMzAtrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEzN0dex3s4ELawXSS92s+WKTTl5M0EDO25FAuoY2B+3oKkoe63m5MFX5bYryycPq5oLF7NS3kgqBG09bFSKc463+gE+BXRuR8NmIAOHqYSYLQjpw+r54ZUps8gn0DwmzGjDPWSnLJM1euOdWe5WO+sRYgvmXoArTCjWzxsmlcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AQop48uv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C68PrTC0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kNPysONF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VVT9jt8f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6DDB4D2D5;
	Tue,  7 Apr 2026 13:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775568272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqPwf+sdRUS1BWQR3nmfljFdlROcvK34Nt72M/HdBk0=;
	b=AQop48uvC1SEMVPtD5xGUZuwvcvHygsDpfci//4L/wEXXKqX5O/Wmxld04nRHwgYVartyJ
	iHOzmY6IONvcPxfMGWaRxhM5xz4K4KW1+2lr/B1JPjtryqd430DilmLW2dd2hhFj4Eiw72
	sfpJ6yaTKovz2uWkunN2jEuAhoyags0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775568272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqPwf+sdRUS1BWQR3nmfljFdlROcvK34Nt72M/HdBk0=;
	b=C68PrTC0e7wHOZU/MvDtKBdVQ8UcF5k0/30GWH4nxPYZt8iirO2LPLSU6Xcwkpcv4NRwx3
	8Iq/mStout6Aa/Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kNPysONF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VVT9jt8f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775568271;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqPwf+sdRUS1BWQR3nmfljFdlROcvK34Nt72M/HdBk0=;
	b=kNPysONFXiQeaP2uS9TnLcjFs4mSdWErNp2lE9NiwLJ6l+lJwNCYB/XSYu/s4vGkrGZ0zj
	wMskyWiS/zaTtggvR6a6z43tQP+B5UklaWRZaIrcv9PBr4+PFoHRBeGOWdWf0BMVPG/YXi
	1nt8Y5419W+c58vdNr6TmCsLpoP95xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775568271;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqPwf+sdRUS1BWQR3nmfljFdlROcvK34Nt72M/HdBk0=;
	b=VVT9jt8f4yPhO+wYFz3cf2XGhL67kus0mZdghNEv3NEhq4n0e2yG6i/3K5TMrHtWStxOLL
	ZmHu0bRnrMQGchAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 696DF4A0B0;
	Tue,  7 Apr 2026 13:24:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pn/cGI8F1WnZTQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 07 Apr 2026 13:24:31 +0000
Date: Tue, 7 Apr 2026 15:24:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Cc: Linux Test Project <ltp@lists.linux.it>,
	Eric Biggers <ebiggers3@gmail.com>,
	Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [LTP] [PATCH 2/2] device-drivers/rdma: Add ucma_uaf01 test
Message-ID: <20260407132426.GC25645@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
 <20260325-infiniband_rdma-v1-2-9c1bd3e69d29@suse.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-infiniband_rdma-v1-2-9c1bd3e69d29@suse.com>
X-Spam-Flag: NO
X-Spam-Score: -3.71
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,redhat.com,ziepe.ca,vger.kernel.org,oss.oracle.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19089-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[pvorel@suse.cz];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvorel@suse.cz,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 18C043AF17D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrea,

it's been long time since this use-after-free was fixed, but IMHO still useful
to have a test (it's also kind of smoke test for rdma_cm).
Anyway, LGTM, but it'd be nice to reproduce the bug.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Test for use-after-free in RDMA UCMA triggered by racing CREATE_ID,
> BIND_IP, and LISTEN operations. Three threads concurrently issue
> these commands to /dev/infiniband/rdma_cm and the test checks for
> kernel taint (KASAN use-after-free detection).

> The bug was fixed by kernel commit 5fe23f262e05
> ("ucma: fix a use-after-free in ucma_resolve_ip()").

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/kernel_misc                               |   1 +
>  testcases/kernel/device-drivers/Makefile          |   1 +
>  testcases/kernel/device-drivers/rdma/.gitignore   |   1 +
>  testcases/kernel/device-drivers/rdma/Makefile     |   7 +
>  testcases/kernel/device-drivers/rdma/ucma_uaf01.c | 208 ++++++++++++++++++++++
>  5 files changed, 218 insertions(+)

> diff --git a/runtest/kernel_misc b/runtest/kernel_misc
> index 78f00d305fea10367fb4fd2845f25dd151a833ea..dcc3c0a44fb52a968f91a52758dbd43a3ce7a9ec 100644
> --- a/runtest/kernel_misc
> +++ b/runtest/kernel_misc
> @@ -3,6 +3,7 @@ kmsg01 kmsg01
>  fw_load fw_load
>  rtc01 rtc01
>  rtc02 rtc02
> +ucma_uaf01 ucma_uaf01
>  block_dev block_dev
>  tpci tpci
>  tbio tbio
> diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
> index 229a50683f5f629904ff591daa6fcd4f1c35fdf1..538df555395bf21062906ffa4125da4c767c1e24 100644
> --- a/testcases/kernel/device-drivers/Makefile
> +++ b/testcases/kernel/device-drivers/Makefile
> @@ -11,6 +11,7 @@ SUBDIRS		:= acpi \
>  		   locking \
>  		   pci \
>  		   rcu \
> +		   rdma \
>  		   rtc \
>  		   tbio \
>  		   uaccess \
> diff --git a/testcases/kernel/device-drivers/rdma/.gitignore b/testcases/kernel/device-drivers/rdma/.gitignore
> new file mode 100644
> index 0000000000000000000000000000000000000000..399ea290e4f9abd6b66800b21f4aea3eb33d3799
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/rdma/.gitignore
> @@ -0,0 +1 @@
> +/ucma_uaf01
> diff --git a/testcases/kernel/device-drivers/rdma/Makefile b/testcases/kernel/device-drivers/rdma/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..5df01972aeab257b6ef24a928204b6b722c1cdef
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/rdma/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2026 Linux Test Project
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/device-drivers/rdma/ucma_uaf01.c b/testcases/kernel/device-drivers/rdma/ucma_uaf01.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..313e2aee0ea0114ce37f006eca93ea66d86ddeea
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/rdma/ucma_uaf01.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Linux Test Project
> + */
> +
> +/*\
> + * Test for use-after-free in RDMA UCMA triggered by concurrent CREATE_ID,
> + * BIND_IP, and LISTEN operations via /dev/infiniband/rdma_cm.
> + *
> + * Requires root to open /dev/infiniband/rdma_cm.
> + *
> + * Three threads race to create, bind, and listen on RDMA connection manager
> + * IDs. On vulnerable kernels, this triggers a use-after-free in
> + * cma_listen_on_all() detected by KASAN.
> + *
> + * Based on a syzbot reproducer:
> + * syzbot+db1c219466daac1083df@syzkaller.appspotmail.com

Maybe link simplified C source from Eric on which you base LTP test (according
to the cover letter)?
https://lore.kernel.org/lkml/20180513230237.GG677@sol.localdomain/

NOTE C reproducer [1] on db1c219466daac1083df page [2] is more complicated than
the one From Eric.

[1] https://syzkaller.appspot.com/text?tag=ReproC&x=1258d593800000
[2] https://syzkaller.appspot.com/bug?extid=db1c219466daac1083df

Kind regards,
Petr

> + *
> + * Fixed in:
> + *
> + *  commit 5fe23f262e05
> + *  ucma: fix a use-after-free in ucma_resolve_ip()
> + */
> +
> +#include "tst_test.h"
> +#include "tst_safe_pthread.h"
> +#include "lapi/rdma_user_cm.h"
> +
> +#define RDMA_CM_DEV "/dev/infiniband/rdma_cm"
> +
> +static int cmfd = -1;
> +static volatile uint32_t shared_id;
> +static volatile int stop_threads;
> +
> +static void destroy_id(uint32_t id)
> +{
> +	ssize_t ret;
> +
> +	struct {
> +		struct rdma_ucm_cmd_hdr hdr;
> +		struct rdma_ucm_destroy_id destroy;
> +	} msg = {
> +		.hdr = {
> +			.cmd = RDMA_USER_CM_CMD_DESTROY_ID,
> +			.out = sizeof(struct rdma_ucm_create_id_resp),
> +		},
> +		.destroy = {
> +			.id = id,
> +		},
> +	};
> +	struct rdma_ucm_create_id_resp resp;
> +
> +	msg.destroy.response = (uintptr_t)&resp;
> +
> +	/* Errors expected due to racing with stale IDs */
> +	ret = write(cmfd, &msg, sizeof(msg));
> +	(void)ret;
> +}
> +
> +static void *thread_create(void *arg)
> +{
> +	uint32_t id, prev_id = 0;
> +	int has_prev = 0;
> +
> +	while (!stop_threads) {
> +		struct {
> +			struct rdma_ucm_cmd_hdr hdr;
> +			struct rdma_ucm_create_id create;
> +		} msg = {
> +			.hdr = {
> +				.cmd = RDMA_USER_CM_CMD_CREATE_ID,
> +				.out = sizeof(id),
> +			},
> +			.create = {
> +				.response = (uintptr_t)&id,
> +				.ps = RDMA_PS_IPOIB,
> +			},
> +		};
> +
> +		if (write(cmfd, &msg, sizeof(msg)) > 0) {
> +			if (has_prev)
> +				destroy_id(prev_id);
> +			prev_id = id;
> +			has_prev = 1;
> +			shared_id = id;
> +		}
> +	}
> +
> +	if (has_prev)
> +		destroy_id(prev_id);
> +
> +	return arg;
> +}
> +
> +static void *thread_bind(void *arg)
> +{
> +	ssize_t ret;
> +
> +	while (!stop_threads) {
> +		struct {
> +			struct rdma_ucm_cmd_hdr hdr;
> +			struct rdma_ucm_bind_ip bind;
> +		} msg = {
> +			.hdr = {
> +				.cmd = RDMA_USER_CM_CMD_BIND_IP,
> +			},
> +			.bind = {
> +				.addr = {
> +					.sin6_family = AF_INET6,
> +					.sin6_addr = {
> +						.s6_addr = { 0xff },
> +					},
> +				},
> +				.id = shared_id,
> +			},
> +		};
> +
> +		/* Errors expected due to racing with stale IDs */
> +		ret = write(cmfd, &msg, sizeof(msg));
> +		(void)ret;
> +	}
> +
> +	return arg;
> +}
> +
> +static void *thread_listen(void *arg)
> +{
> +	ssize_t ret;
> +
> +	while (!stop_threads) {
> +		struct {
> +			struct rdma_ucm_cmd_hdr hdr;
> +			struct rdma_ucm_listen listen;
> +		} msg = {
> +			.hdr = {
> +				.cmd = RDMA_USER_CM_CMD_LISTEN,
> +			},
> +			.listen = {
> +				.id = shared_id,
> +			},
> +		};
> +
> +		/* Errors expected due to racing with stale IDs */
> +		ret = write(cmfd, &msg, sizeof(msg));
> +		(void)ret;
> +	}
> +
> +	return arg;
> +}
> +
> +static void setup(void)
> +{
> +	cmfd = open(RDMA_CM_DEV, O_WRONLY);
> +	if (cmfd < 0) {
> +		if (errno == ENOENT || errno == ENXIO)
> +			tst_brk(TCONF, RDMA_CM_DEV " not available");
> +		tst_brk(TBROK | TERRNO, "open(" RDMA_CM_DEV ")");
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (cmfd != -1)
> +		SAFE_CLOSE(cmfd);
> +}
> +
> +static void run(void)
> +{
> +	pthread_t threads[3];
> +
> +	stop_threads = 0;
> +
> +	SAFE_PTHREAD_CREATE(&threads[0], NULL, thread_create, NULL);
> +	SAFE_PTHREAD_CREATE(&threads[1], NULL, thread_bind, NULL);
> +	SAFE_PTHREAD_CREATE(&threads[2], NULL, thread_listen, NULL);
> +
> +	while (tst_remaining_runtime())
> +		sleep(1);
> +
> +	stop_threads = 1;
> +
> +	SAFE_PTHREAD_JOIN(threads[0], NULL);
> +	SAFE_PTHREAD_JOIN(threads[1], NULL);
> +	SAFE_PTHREAD_JOIN(threads[2], NULL);
> +
> +	if (tst_taint_check())
> +		tst_res(TFAIL, "Kernel is vulnerable (use-after-free in UCMA)");
> +	else
> +		tst_res(TPASS, "No kernel taint detected");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.runtime = 300,
> +	.needs_root = 1,
> +	.taint_check = TST_TAINT_W | TST_TAINT_D,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_INFINIBAND",
> +		"CONFIG_INFINIBAND_USER_ACCESS",
> +		NULL
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "5fe23f262e05"},
> +		{}
> +	},
> +};

