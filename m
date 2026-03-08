Return-Path: <linux-rdma+bounces-17709-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EjVL/JXrWmd1gEAu9opvQ
	(envelope-from <linux-rdma+bounces-17709-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 12:05:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CBB22F65B
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 12:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 158D93012500
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 11:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C52D369996;
	Sun,  8 Mar 2026 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rxqg3C5I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CD83644C3;
	Sun,  8 Mar 2026 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772967909; cv=none; b=uBePvAiM6Co902l3HA0+uVy4AyG5ofm/M3WNXDQoYa57d0LgPuA9B4WLy0K7rxVhvgGvSyGUYYUOYsWARkp3JrThf/4YGWAPK0/+7Og/xlwWEZl6/H676ttYVdDu9hnseyWOS0L84OqzWUA9yQ7Aw9f6SU4w3ll1JxDptPz5i4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772967909; c=relaxed/simple;
	bh=xU+ZsYo1Cn3jnMX/5Vt2zS9nMaOH+Ut8sp5g2LzaQ9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SFEk6pefBQRjuiqk6pX3xWH8uzLt4zTPqwL/+7fkZGm2FrlQzCpy8F53wL0YCg9kOC+kNO83j4XUGiUv5o4QxFEYDgwlxC8aM9N9aVpgv0y9KdyMpWdAa+MCfDD/UtaPNPLttNlkNG8Ihe2gbCpHfQOxqaBWM7bWOJrXPPSojy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rxqg3C5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E661DC116C6;
	Sun,  8 Mar 2026 11:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772967909;
	bh=xU+ZsYo1Cn3jnMX/5Vt2zS9nMaOH+Ut8sp5g2LzaQ9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Rxqg3C5I2q4Rr+YeVzBaZk9coICrIR0ux+KzNTEiiwZCw/cIAqKgr3CJFvN1g964Z
	 snCBBNCOibfcNPGDnBnJTFNUkxjyfl7crhhV0S4/xQlACfsYdJ+WL/zql+cJbnomXB
	 W6ms6xDO4oX2f9Gnoozab9wBvgOzp9F83UqzE9x5L1SMMYHbxtHeuK3QWAqw2eXFAJ
	 FzSNralg9LvhnPMrVVV9od7LhXn7Mv2G3tLLeBjmObUjcuYEQTRT+d7ioJBqxJXtAp
	 Ukl8odaTeXKiF+YoKoANJc4honKmxVH4jmLtX8+4rDXbrzyurpUgv/Tgjp8K75okVf
	 CcSd7/jW4FHrg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, "Md . Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20260305154117.326472-1-marco.crivellari@suse.com>
References: <20260305154117.326472-1-marco.crivellari@suse.com>
Subject: Re: [PATCH] RDMA/rtrs: add WQ_PERCPU to alloc_workqueue users
Message-Id: <177296790644.1461936.14617612915039201170.b4-ty@kernel.org>
Date: Sun, 08 Mar 2026 07:05:06 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: 56CBB22F65B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,ionos.com,ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17709-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Thu, 05 Mar 2026 16:41:17 +0100, Marco Crivellari wrote:
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The refactoring is going to alter the default behavior of
> alloc_workqueue() to be unbound by default.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rtrs: add WQ_PERCPU to alloc_workqueue users
      https://git.kernel.org/rdma/rdma/c/8db7b7d9ba170e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


