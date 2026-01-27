Return-Path: <linux-rdma+bounces-16084-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOpuDszKeGmNtQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16084-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 15:25:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C23189593A
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 15:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7ED430FFFD0
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 14:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457553559F0;
	Tue, 27 Jan 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS+pYW7s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DB61E1DFC;
	Tue, 27 Jan 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523619; cv=none; b=GwHdoRGjGuFHETEloLCdVb1aPlEbuS9309PXB5slS5HSBYfy/SB4HYbe9Dpo+zF0rb15oJ41P9wD0wCvMXepgvK7HqK9PQuc3XiTV+BC2AKF7PACTXidWzw5nDTyLqqI5WkjIk55iet2WM2P6sXrUs2X4zY7UnWLpYOdB6lKGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523619; c=relaxed/simple;
	bh=T8zQub03vXPnd5hqr0xNscuKwDcvEebFeLOJfzUCjS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FSQcAgoxghXq5Lg3rkUJRUcpQgyNhjWQ3Mx0eLd2OxKJxY39gGoC6mIVKud7UIU7BciHTvRuv/cwUSCYqnsFkk/CxDaDBslAoTtElrHvuXsLDH8/6xrtGN4EU/fqkhL2VeN8ekOQNyi2YRej+sgtl2wM0s7Ojr0K5zAHB1ONTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS+pYW7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63296C19422;
	Tue, 27 Jan 2026 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769523618;
	bh=T8zQub03vXPnd5hqr0xNscuKwDcvEebFeLOJfzUCjS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MS+pYW7sk9hSTxua0tNxvvwQDfn/C21a7f67YsANXNMLV6ald76nwHDgiejQFaw0k
	 VcP8QaZZLv7o3VjFAioNEOyE4VuSfK30HaDO37Bg0oM1Lt4HjWuz0ZhY+JXIXzT9Ds
	 afezgOEExWjuG+/qM73sZGZe+V1ZKoHob0sfn4arh2luSpwEvP40qSmlX8IiRYvsWS
	 h8+u3VSRxzU9XFSR+YUZ+3JwbRSVm1+IWizUenqQwK0BA7r7TkLTXP3XF1vs7r0MeR
	 ruBASPLYrxmO7IFvWn0vtGJkDivAqUtiVT0eNQc1WlmkmcDZzH/A/0TdVWU3X4IaCl
	 DHamfIX5PJhMA==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, shirazsaleem@microsoft.com, 
 longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260127082649.429018-1-kotaranov@linux.microsoft.com>
References: <20260127082649.429018-1-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: device memory support
Message-Id: <176952361602.919365.13871249642943514688.b4-ty@kernel.org>
Date: Tue, 27 Jan 2026 09:20:16 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16084-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: C23189593A
X-Rspamd-Action: no action


On Tue, 27 Jan 2026 00:26:49 -0800, Konstantin Taranov wrote:
> Basic implementation of DM allowing to create and register
> DM memory and use its memory keys for networking.
> 
> 

Applied, thanks!

[1/1] RDMA/mana_ib: device memory support
      https://git.kernel.org/rdma/rdma/c/a01745ccf7c410

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


