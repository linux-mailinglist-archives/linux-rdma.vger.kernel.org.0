Return-Path: <linux-rdma+bounces-20387-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCW7L1DKAWoRjwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20387-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 14:23:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 552C650D978
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 14:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D52730E6DC6
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E4937AA7E;
	Mon, 11 May 2026 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qT3HiOj3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D9D37757F;
	Mon, 11 May 2026 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501740; cv=none; b=eYfO1wQJDpy86uhWeFwzfvFCF1+/6hPEwtQrGgQeZqtbHzLaom906SjpsE2hAPLCIiSDiOfMRaZVHm8eUyDSsBgWb4CynoUUTmJNgWgvmem1fBl2/xBK9RlN2eFUvp3RoNoFQD7gF9wXf+23WwSZ0FdVwLsJBlasNSr1plLN2P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501740; c=relaxed/simple;
	bh=AM7/TKaRnsjfIpUrENXutvbdgWVBVCfcXrYgldxshyc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k8sV35psw3NCUfGEQWuMlI8SKqa2BQwLbUXzQqW4q76xXzz7bma6sNmaTouT/liviZFzMqWJF5GGKPcQMjDL4vKSWRFOykaStUpUzT7r8jzuGXw3xXqbGKb0HUutcBvLJZds7yQaiWGqFdyr3933zHyElSLh3jE8d5A0wjgToFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qT3HiOj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A378CC2BCB0;
	Mon, 11 May 2026 12:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778501740;
	bh=AM7/TKaRnsjfIpUrENXutvbdgWVBVCfcXrYgldxshyc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qT3HiOj3S9hFTHlWocsu5Y18uKuhvfVJveQirSAS83R0CMh5aOumO7ISaR6d7NGMH
	 64A9tX9AEUZLXRAL0JqSOU9c3CbmypcDVtuyF6koZiVxXwSAySChwUy4ECg0c0uvQM
	 k8z/j+SmXDx1eqHdfFXvcRQQYMKxmIGO2rM6pTk9cawH6V/dz3BKWvqTyp73f8Ol1c
	 CRdFrU9PU2L6BdHrE9nRG4NAmu1RwuJgXeQEVAZ4l3q80eKgAgHA2h3O582UX+NH6x
	 m/Aa6dHFSNt6o/MSrmzryXNfSeo9TEpnC15ZZ8UqTRGLloSIKeuJ+c7ZUVcSZM8x+Y
	 XwbdsMVi/2y5A==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: yishaih@nvidia.com, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260428224319.37682-1-prathameshdeshpande7@gmail.com>
References: <20260428224319.37682-1-prathameshdeshpande7@gmail.com>
Subject: Re: [PATCH v2] RDMA/mlx5: Fix devx subscribe-event unwind NULL
 dereference
Message-Id: <177850173719.2267433.1929653240735491428.b4-ty@kernel.org>
Date: Mon, 11 May 2026 08:15:37 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: 552C650D978
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
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ziepe.ca,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20387-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Tue, 28 Apr 2026 23:42:49 +0100, Prathamesh Deshpande wrote:
> MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT() links event_sub into sub_list
> before initializing the fields used by the shared error path.
> 
> If eventfd_ctx_fdget() then fails, the unwind path dereferences
> event_sub->ev_file in uverbs_uobject_put() and calls
> subscribe_event_xa_dealloc() with an unset xa_key_level1.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Fix devx subscribe-event unwind NULL dereference
      https://git.kernel.org/rdma/rdma/c/59d29eb26889b5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


