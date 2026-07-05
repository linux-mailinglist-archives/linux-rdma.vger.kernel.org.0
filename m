Return-Path: <linux-rdma+bounces-22776-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /pm0AtZjSmorCQEAu9opvQ
	(envelope-from <linux-rdma+bounces-22776-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:01:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EE770A346
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:01:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Z4/tOJdH";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22776-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22776-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6A030107E2
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423D637AA74;
	Sun,  5 Jul 2026 14:00:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17FE37E301
	for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2026 14:00:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260053; cv=none; b=tp0mGhovh7C+RxiizuC9KTjsZ/moi2hjvL6a/sOB9VmpGzDYKglRuImo/53PLDw4DW9/hXeZsdvXmQGta9bz6rhIPCGqpTKRUWyP69gzwW6A8Pk9168gVjR+c33quQizh6qYqBZvziXiGuWhHlp3Xvcq6/tigry8UqZRVvH7uKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260053; c=relaxed/simple;
	bh=/ulckH4rilkvkBPQjpnfN1QzqqkGizYF5HwfU+wLLC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KDEw4fZ9bHZWZUw9ZTwPwuePtIKgMt6dZ2Ycb5MLEgp3ALtYtFYiMMAJORMAabWelpfriXhBtt/ATnYdPgjuDxiUWbl7WvB+vpG28Ai2+J+I6LQRIGpb26vI49hChWqGVRQ637EmzZWxcUlxUHdEQiU7Y9eUBC2Ckh22Ky6Z6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4/tOJdH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3C11F000E9;
	Sun,  5 Jul 2026 14:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260052;
	bh=QMjiKqu6kLPmdyoHGdkTb4zB7tK0oF29Fo9GzEDmT+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Z4/tOJdHTeXfgTzIabQ8P/T7pEdcDhIDA2tpoYhgzNtOwe8JJphVA/ags1rKULjB7
	 wrN0ky9ektUEIn+o97YEIvARASrMFjyzYelJbpuWWxhOkkUlprHS6UbOu5mjljMPMs
	 k3eGC+ZxcdQPiG9W0vwqmjiZZu08iYk3BJTGkZT/TITL44xZW7QdGBKpfz9yl2SnCQ
	 GxSaebnXUZcdJ+u5JPKNqoDLJt62001tOs7npV8v5zDOTbUWBRsSPtpm7tMqd7P+7w
	 b2/sVEgBWKpHtCxGoQ+3ayB9qllzGmSopP0uj+S8Hwa5NKmPHsQXcxcVyiKsbcB8VO
	 BS01i6lHuIMIQ==
From: Leon Romanovsky <leon@kernel.org>
To: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, 
 Jacob Moroni <jmoroni@google.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20260618201458.875740-1-jmoroni@google.com>
References: <20260618201458.875740-1-jmoroni@google.com>
Subject: Re: [PATCH rdma-next 0/4] RDMA/irdma: Prevent premature
 deregistration of user ring MRs
Message-Id: <178324830896.903355.7673142526387836159.b4-ty@kernel.org>
Date: Sun, 05 Jul 2026 06:45:08 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22776-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:jmoroni@google.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88EE770A346


On Thu, 18 Jun 2026 20:14:54 +0000, Jacob Moroni wrote:
> When a QP/CQ/SRQ is created, a two step process is used where the
> buffer is allocated in userspace and explicitly registered with the
> normal reg_mr mechanism prior to creating the actual QP/CQ/SRQ object.
> 
> Even though these special MRs are internal to the verbs provider,
> nothing actually prevents a custom/malicious user application from
> manually invoking dereg_mr on these regions. If this occurs, the PBL
> is freed and umem is released while the HW may still be accessing it.
> 
> [...]

Applied, thanks!

[1/4] RDMA/irdma: Deduplicate the irdma_del_memlist logic
      https://git.kernel.org/rdma/rdma/c/097f50384e1877
[2/4] RDMA/irdma: Add a refcount to track user ring MR associations
      https://git.kernel.org/rdma/rdma/c/a7d0a6b58256a7
[3/4] RDMA/irdma: Add irdma_cq fields to track pbl allocations
      https://git.kernel.org/rdma/rdma/c/971e99623ed7a0
[4/4] RDMA/irdma: Add refcounting to user ring MRs
      https://git.kernel.org/rdma/rdma/c/f67d8a08f60c92

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


