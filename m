Return-Path: <linux-rdma+bounces-20627-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNHOCdQyBWonTQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20627-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 04:26:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E116A53D033
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 04:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ECB8303B4CB
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 02:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8097F322A1F;
	Thu, 14 May 2026 02:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brAapiQq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237B2EB5B8;
	Thu, 14 May 2026 02:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725541; cv=none; b=rNxQ9+WTWHVaFb1FO7WCMTpqEkCZ7IHBB1L2sF7BkzMf4hGpMSubDcqp+6qKoabzhN+v3LJyaJldGHzKAuN+63FA6V0gM7Ag9C0zN1tvBsywQOVf9fDvA2vZ3MGb1E7k/vlq36ohSxNiK4otulOAnD0AOKBHdMmp83aBbbY6WCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725541; c=relaxed/simple;
	bh=S5JiDsKbGffYIP42Ec6J22ZFOf/nCruJ9RWcrymOaJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjdF+9T+D1G5oDTsPFE/tUGjJvNDgtcQPPIFgQvp2XHshybJm5TAyjxiGvAGFwsnJJTbSMDAPs9wGzIncM+DPk9emuF5PcDLuAz8p9TDPutYeiVPfyRYn9g3frNzmn4BweUt5DbzH/Lz47X3QtIKYekLwBObLQv8BonsaHEXsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brAapiQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C796C19425;
	Thu, 14 May 2026 02:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778725540;
	bh=S5JiDsKbGffYIP42Ec6J22ZFOf/nCruJ9RWcrymOaJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=brAapiQqmxvAfqKmys7aGjR79rgi23o3BwHTgTkhz7eJ5GPwnNXMJggQTd6gxp/UL
	 D7A9Ezzar8XqhBdJG4jLFWTXdgWB9Cvrilg8/++o/wsfKQ1FHcr7zrwtRAKjjc2N7j
	 7uFgKgHkxyLQyLO/Iow5985d2joUbIBYvaqP7yBxxRgKPU+pebyZbuDs17S60395l2
	 PaaC0n0Avu5scMpRLK/pZJbHceELHvPrwC+RdaOdmCQVqIufZEokqhpHDAS2wUIv7G
	 K72ijbi2XJiXWAqYimrRvS5LIPH8KGpkbIFFJ1ZJrePaDrnj8nQx3hwdDq9m4oGytN
	 3aERGKGQQ8PIQ==
Date: Wed, 13 May 2026 19:25:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, "Moshe Shemesh"
 <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 0/8] net/mlx5: Prepare eswitch infrastructure
 for satellite PF support
Message-ID: <20260513192539.7fd96592@kernel.org>
In-Reply-To: <20260510053448.326823-1-tariqt@nvidia.com>
References: <20260510053448.326823-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E116A53D033
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20627-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, 10 May 2026 08:34:40 +0300 Tariq Toukan wrote:
> This series prepares the mlx5 eswitch command interface and vport
> infrastructure for satellite PF support.

Could you perhaps start by explaining what "satellite PF" is?
And how it differs from "socket direct"

