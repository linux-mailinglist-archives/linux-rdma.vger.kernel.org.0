Return-Path: <linux-rdma+bounces-17394-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NUHB8ndpWkvHgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17394-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 19:58:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A221DE865
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 19:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD88F306F039
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 18:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F14361658;
	Mon,  2 Mar 2026 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWRa7qAN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67CE317155
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477776; cv=none; b=eQ9yOCHs3wXkFcaK9YQmftkzHy5YPwHjcTpnCuprghFKY73eWFGvwiLey5npp54gACufC4Inn/LHnKfCMqgASIJTzZC23mSfrjQfFk3S6pIQhPo7+yxBxIgE4aBWUJyI5JknrQBs8cTdLs7FVod0OMH6p2zbN7oX4R85KMz7DSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477776; c=relaxed/simple;
	bh=NtyBKumuqEKTEqNlGyQrhAoFSel9N28ZMZ8qsr/LaPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WqRU61/v+johWmDJsi5Dzgohg4A1VtCVSkx6+qDuipaLmbaUbe8SQjEXjTwZGiPpIGDpldlZRPm9moJCgMRwYmY47X3+iJNj4ZuhLII2aMKWIaxA3BZGU3x3eF8VRnLePobvpF17m049dpt6zfiBXU1XmRK60Lunob5D5dakFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWRa7qAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3111DC19423;
	Mon,  2 Mar 2026 18:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772477775;
	bh=NtyBKumuqEKTEqNlGyQrhAoFSel9N28ZMZ8qsr/LaPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gWRa7qANdm/c5COhqKv2azis7IA82Gz5LveXdXRibR31WIS1y4wNx0bd5zCYKkTzj
	 nLwf3m2w32Eh9irL8iC2xDJ+q6S1Y0GxuN26GcjCPxEkAhgiArDqNMLegkVk6Ae90l
	 2iZ03Ft2nNAxzv0+R9ukGy5GfAlei0eEmmvybBIrNivwuufbuwUYhMDYPyVSRxguQB
	 JXDNZFDg/5G2+I/fu2a1hV7dQCFguaR2asZ93KLtAIIfVzA8M6G4aHQD7UulJJQerE
	 8OsCT6IGgjpIOUNWU9iFzd4vjdoBhzF3KpL8m7lsbA8tzmoDPJml7l5rWiEqpqlbTB
	 SPVqncR0Gey3Q==
From: Leon Romanovsky <leon@kernel.org>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
 Jacob Moroni <jmoroni@google.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20260227152743.1183388-1-jmoroni@google.com>
References: <20260227152743.1183388-1-jmoroni@google.com>
Subject: Re: [PATCH] RDMA/irdma: Fix double free related to rereg_user_mr
Message-Id: <177247777272.990452.11983369454192062099.b4-ty@kernel.org>
Date: Mon, 02 Mar 2026 13:56:12 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Queue-Id: 59A221DE865
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17394-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Fri, 27 Feb 2026 15:27:43 +0000, Jacob Moroni wrote:
> If IB_MR_REREG_TRANS is set during rereg_user_mr, the
> umem will be released and a new one will be allocated
> in irdma_rereg_mr_trans. If any step of irdma_rereg_mr_trans
> fails after the new umem is allocated, it releases the umem,
> but does not set iwmr->region to NULL. The problem is that
> this failure is propagated to the user, who will then call
> ibv_dereg_mr (as they should). Then, the dereg_mr path will
> see a non-NULL umem and attempt to call ib_umem_release again.
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Fix double free related to rereg_user_mr
      https://git.kernel.org/rdma/rdma/c/1b3b0ec3df4a69

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


