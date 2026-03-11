Return-Path: <linux-rdma+bounces-18024-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMU9O++/sWkwFAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18024-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:18:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2D6269305
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1B703043AD9
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 19:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C77282F3D;
	Wed, 11 Mar 2026 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFNYAuJK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0BC30B508
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256676; cv=none; b=qtcYOnryhLY79g6Auo7iGaB+MVvjb+dc0yqzK0VP11PNi7iOWy+hNkN6mgc93El4ijl6GHvdEKqkY54U490NlCvPjYCMJxFaVv88BCSHSwR+eP8pfhOIiSr9Z+HwJVJ5KxKOG4tRsLkNY7jE/XInnmpuJeyX6w70kgj/X0epBQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256676; c=relaxed/simple;
	bh=BRifPSWvfDHRt9uv25VS4k+ie2oFCXB7w2HteZlN3vk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n5CMkU+ADSyQPbLHiOxpnkPf1P/QQYyC4+xzrWMl5iz9Oz5D1BBSbZ/zno7yQfZwhxGjX9xCR0ig/IESaa+DnrQITi+HJTtKSeW70/Maw5QjcEWnGmSMxzgOk5ODf2EgbsEykf7q+MarSaCS958U04V3iOARxNDK3W+4aXrDVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFNYAuJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AA7C116C6;
	Wed, 11 Mar 2026 19:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773256676;
	bh=BRifPSWvfDHRt9uv25VS4k+ie2oFCXB7w2HteZlN3vk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nFNYAuJK+Ouc4Ua6141XwV5I/qM391cYlJc/VvEClmffoAGdoiGZP32yZvTLdrbnM
	 vdXL/Wpz4jxfcVxw88lEJwiK5yrTrxypmHwVZe5LvE+xg4ZgnYKYIErs66XA6cBDmF
	 WPz0FitiEG3DD4HyC8XwDn52T+Og1jWST2UAtpfXXqYNdc6CZsCaXSKtVVq2u2JROL
	 a0Rcd1G02nP6bbYv36AOS3WzWY8Ha9sKF638kp8Sp/coC8JXUDNJryK/qGFidWcQEc
	 yGaONPPtEGMsMXj/S+sBU+l+7swH7U38KkinDS6jfJ1nGy2Ei3PUA6iZ42RhbhYACA
	 77e+NR+DwQkeg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, 
 linux-rdma@vger.kernel.org
In-Reply-To: <177308892140.1279894.3475429390519673020.stgit@awdrv-04.cornelisnetworks.com>
References: <177308892140.1279894.3475429390519673020.stgit@awdrv-04.cornelisnetworks.com>
Subject: Re: [PATCH for-next 0/4] Prepare for hfi2 submission
Message-Id: <177325667358.1852743.12346760381110554038.b4-ty@kernel.org>
Date: Wed, 11 Mar 2026 15:17:53 -0400
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18024-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A2D6269305
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 09 Mar 2026 16:44:39 -0400, Dennis Dalessandro wrote:
> These 4 patches get rdmavt ready for hfi2 support. This is being split out
> from the previous patch submission [1].
> 
> [1] https://lore.kernel.org/linux-rdma/175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com/

Applied, thanks!

[1/4] RDMA/OPA: Update OPA link speed list
      https://git.kernel.org/rdma/rdma/c/ba8c700185d62b
[2/4] RDMA/rdmavt: Add ucontext alloc/dealloc passthrough
      https://git.kernel.org/rdma/rdma/c/e2849b3929743c
[3/4] RDMA/rdmavt: Correct multi-port QP iteration
      https://git.kernel.org/rdma/rdma/c/2ad64eeaefd293
[4/4] RDMA/rdmavt: Add driver mmap callback
      https://git.kernel.org/rdma/rdma/c/1487bad4ea518a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


