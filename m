Return-Path: <linux-rdma+bounces-18360-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHsSG0vruml0dAIAu9opvQ
	(envelope-from <linux-rdma+bounces-18360-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 19:13:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D93D52C1115
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 19:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D4C53018413
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 18:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABDC3B583E;
	Wed, 18 Mar 2026 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qnp6rRiR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC4234676D;
	Wed, 18 Mar 2026 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773857605; cv=none; b=Ycpb5MPzdrqUTq/luuw87CKcQn9QLUe0Dn7ITQIiIRYBeJRNR78lhlP1VgW2/NX1ujZIcSxNc7pPFZejeum8W4I8sW/m1/QaGo1hWD3fUELvj/bdm4hTc6bk8E/pRTljxjCuOYKY12XjR2ztYgZXeVuFWH0D9roYHtKEMWqTJXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773857605; c=relaxed/simple;
	bh=XHgYIwhFIbPpDkjJOT8MLyAiDU8FGpSWii4Xa0iuyjg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ScTUDFzpvQ4KKCYPtwCHGboxnt7bfZO9ThqQnoetg2el016FRIHxBN5VD6b1LKTFEQIRTFaS7KuJGF9gKXvsz+MVDeoK2Njoo+ZjmyftMLJHDAK3SuDcH1hk5Y9p1z2sJWA9IPEJmBrqriJrXukT4deqK+uLCzhrqoJSULaDqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qnp6rRiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBB6C19421;
	Wed, 18 Mar 2026 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773857605;
	bh=XHgYIwhFIbPpDkjJOT8MLyAiDU8FGpSWii4Xa0iuyjg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Qnp6rRiRP1zwNooxC7sQ4dSdZVs99uZg/+NTBA+1FpyVl7vCEOusyyWZU7dIQHq0w
	 zZ1sgCHQt+mOd2bpZigRuqIACivXIJiOMmQrdVmeIJ4bz+aOkcqBI/1G+o9M7N6wHS
	 mfLtkOm/g9Mhj2v57ZJrvDctH2uK8hiHYAz1gO38J4Hd/lqzoQ99GcfHPUGapcg9A6
	 mEWT+s2H9ORneO9usatY7aGh6Jelbm48S3xZY7n8Nv2XYHwzhUKw0HzlQDyA7IQPxa
	 334cKr8SX8/Jvg6RoU1ZojKCvoiDkQYVMOvyhJ2jVvJ8xxJ3gJzUTt7IuLruTCBQDN
	 XAb9kmqg3nKVA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20260318152748.837388-1-marco.crivellari@suse.com>
References: <20260318152748.837388-1-marco.crivellari@suse.com>
Subject: Re: [PATCH v2] RDMA/rxe: Replace use of system_unbound_wq with
 rxe_wq
Message-Id: <177385760172.774155.8831510625996711948.b4-ty@kernel.org>
Date: Wed, 18 Mar 2026 14:13:21 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18360-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D93D52C1115
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 18 Mar 2026 16:27:48 +0100, Marco Crivellari wrote:
> This patch continues the effort to refactor workqueue APIs, which has begun
> with the changes introducing new workqueues and a new alloc_workqueue flag:
> 
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The point of the refactoring is to eventually alter the default behavior of
> workqueues to become unbound by default so that their workload placement is
> optimized by the scheduler.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Replace use of system_unbound_wq with rxe_wq
      https://git.kernel.org/rdma/rdma/c/2102cbaf8db4ef

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


