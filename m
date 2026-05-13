Return-Path: <linux-rdma+bounces-20604-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD72OG3KBGp2OwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20604-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 21:01:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC134539767
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 21:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD02314ABB1
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66E13AF650;
	Wed, 13 May 2026 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRV93xL8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E783B3C06;
	Wed, 13 May 2026 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698283; cv=none; b=bMGRbQBcRQsE/MwAYpKjzayMovaP4FLB4O7/BmvipBVU3yMOBvvX5zMUsgGy5hs+RJrwl2ZEwV2tb0BzZjSnOIlXw1VOGFb1YWNwSkl9qEpQHa87pnWlF81NZXAY3IUdbexj/G+Koxhh5PkRl/ppHGklCZCLgVmXLWcBbzN3Kfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698283; c=relaxed/simple;
	bh=M2ksEA1v6b/Rb0MrVuOptDeQ8yX8VEHPHAPll/Wxzi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rvN73hk2VrpkwZwA75wv1DN85e5TyVyCpmMXAhJJYGh/5F9Nic7Y8kstg4QCsjX6DAP3edd4vHuwqGmoPWJ9okOLeO/lAA/LQ5ROfc7TxSEY1t9xpePCmQnbEC8df6QLiroYu9bzn3FzDngI1I9fLC4KHw+xvC7PMK+Zdz5py0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRV93xL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3417C19425;
	Wed, 13 May 2026 18:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778698283;
	bh=M2ksEA1v6b/Rb0MrVuOptDeQ8yX8VEHPHAPll/Wxzi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jRV93xL8WpT03e9aWfTLUCQi0kbD5sWjqZy9FvYueW3uI7qK9xMokPOFlfF5jQpER
	 75lGSiPJi27OW6XKrEeJTlqKw4vuoD9flhSvEg61gsH/Ftz6sNOwfPc9OMQUfRN6X5
	 N/RFOuI6GD79/Bo4n6o3rdZivQYwE7RU3id/DQitg0t43dOP69+Q5qFBCNqagVrXK3
	 DAH7NbYQa42FdD1KLVk0EW+J8f83FALhCJNvuDLmj7Nt0q2yGE9OfHh68R1ah9/z53
	 VEGh4K7/If7Ow8QFzIBINGabP+GcGnCjn9yLFzw5XHqgKfo54GU2auGOq6LJAuuAMd
	 Tcxe1PPscSI/g==
From: Leon Romanovsky <leon@kernel.org>
To: Chengchang Tang <tangchengchang@huawei.com>, 
 Junxian Huang <huangjunxian6@hisilicon.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260507075437.2669363-2-u.kleine-koenig@baylibre.com>
References: <20260507075437.2669363-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] RDMS/hns: Use named initializer for pci_device_id
 array
Message-Id: <177869828038.2371282.17935591061454741759.b4-ty@kernel.org>
Date: Wed, 13 May 2026 14:51:20 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: CC134539767
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20604-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Thu, 07 May 2026 09:54:37 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> While being more verbose using a named initializer yields easier to
> understand code and doesn't rely on the two hidden zeros in the
> PCI_VDEVICE macro.
> 
> While at it, also drop the explicit zero in the terminating entry.
> 
> This doesn't introduce any changes to the compiled result of the array,
> which was confirmed on x86 and arm64.
> 
> [...]

Applied, thanks!

[1/1] RDMS/hns: Use named initializer for pci_device_id array
      https://git.kernel.org/rdma/rdma/c/9dd3e17173bfb8

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


