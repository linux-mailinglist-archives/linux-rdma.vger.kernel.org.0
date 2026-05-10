Return-Path: <linux-rdma+bounces-20309-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Crc5I8+rAGofLgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20309-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 18:01:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD62D504F74
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 18:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AA3D300A12D
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5063ACA5F;
	Sun, 10 May 2026 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrNBe+uL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA55D38F247;
	Sun, 10 May 2026 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778428873; cv=none; b=LAQV7sskvKfTWpJWUgQK86sv34Z+FjuqQoOH5615812InlV6nTuDlnu17aV6dEm6WzsODf6P34XUWHftj/shrHbzR4/8nAD3leos496qLhsj0Znn07HcsqjV7Sq5TRxjrdeBKFxFhE14Z+uuFGUdGX0c3OtUJ6ASY135Qd7epaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778428873; c=relaxed/simple;
	bh=lR7yeiNqWrMsBmf8YTNpZajlizzHwnKzQOhnkm6jv8Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e0kBf7NAUSFeTZjpDgw+SPT11H+msdQs2m/VyNo2pXcyk53+vkvJOtc5OOZZIs6R8IjHyVHjz2dcvWcnxck1kUsAOA2UOuG4WO37HL/pcxxBJ8iEIATlllWZPHtZKypjbOw+fyBRWI1yscIYPfdrVn5UydCa15iL6kPijLXv/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrNBe+uL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12C0C2BCB8;
	Sun, 10 May 2026 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778428873;
	bh=lR7yeiNqWrMsBmf8YTNpZajlizzHwnKzQOhnkm6jv8Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lrNBe+uLP47wAmlJ0IMEzyHF57u6vTldtkT78QRq8yk0/1XlKPJbHAQgZVCJIZpdi
	 3cWaGH+GmX2MTijbYUb8YZk9G+4aQRIlmTAxz9oQIWZ6oO8KVrnEUkC7+xFhEt0HmK
	 y5YbxzJ8ExSb2E+NeN1ZqnuZVnudvf+glCIZ2a9PZsdqv8/9udMyxB+LwvV/3LnM1b
	 lzdb5tFfoARPaR0BdJnWcyoW8O1ke4Hth8pFvseePOeKCnqqW4Cc+u9NvoyU2gIChY
	 Bmewk4pkpEQBtUt7WIe0jHGSESf/5Xfy+TJB8w+q3mNW1wJ95FoxFMDVlkxmbkVJIH
	 TejlXnhrwMV5w==
From: Leon Romanovsky <leon@kernel.org>
To: xuhaoyue1@hisilicon.com, Alexander.Chesnokov@kaspersky.com
Cc: lvc-project@linuxtesting.org, Oleg.Kazakov@kaspersky.com, 
 Pavel.Zhigulin@kaspersky.com, stable@vger.kernel.org, 
 Wenpeng Liang <liangwenpeng@huawei.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Xi Wang <wangxi11@huawei.com>, Weihang Li <liweihang@huawei.com>, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260413091527.39990-1-Alexander.Chesnokov@kaspersky.com>
References: <20260413091527.39990-1-Alexander.Chesnokov@kaspersky.com>
Subject: Re: [PATCH] RDMA/hns: Fix arithmetic overflow in calc_hem_config()
Message-Id: <177842887040.2063748.13930848418836925346.b4-ty@kernel.org>
Date: Sun, 10 May 2026 12:01:10 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: CD62D504F74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20309-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kaspersky.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Mon, 13 Apr 2026 12:14:43 +0300, Alexander.Chesnokov@kaspersky.com wrote:
> If bt_num is 3 or 2, then the expressions like
> l0_idx * chunk_ba_num + l1_idx are computed in 32-bit
> arithmetic before being assigned to a u64 index field,
> which can lead to overflow.
> 
> Cast the first operand to u64 to ensure the arithmetic
> is performed in 64-bit.
> 
> [...]

Applied, thanks!

[1/1] RDMA/hns: Fix arithmetic overflow in calc_hem_config()
      https://git.kernel.org/rdma/rdma/c/784e12a8c45571

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


