Return-Path: <linux-rdma+bounces-17414-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JjjJvhUpmkbOAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17414-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 04:26:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C3F1E87B3
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 04:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C0463015D8D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 03:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C80E37DE86;
	Tue,  3 Mar 2026 03:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZzYK34q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA61A6810;
	Tue,  3 Mar 2026 03:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772508403; cv=none; b=l2bHR3AmJowFyFrb9ZWiqlntTP7jVHv5VPK50C2zXiurKZd+2JGbneYVL91SOcVplecHT0qryt0dNmOJdQtmR5wWjVxjk8bCqyIw7krVTPyk5DNukamyR93FxBoCtnifZa6/1WrAmYujO2G8CEb0mkdzp/celxU3X/O7qEzXdFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772508403; c=relaxed/simple;
	bh=4zf61ALQTMK14img1HViSIDfxFknaHCr69Rl17qSQGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBm03PgMY975O5aWP/6kSLknKhXHdqO3N9tqzdL7Ul5SBUIVUHgL9eWmN6UcpTnaYxeevr7qyIDxVSwJeIW3Dnf5Tamtuxose+e/zZp+BGuJymxhGpi+vt36UZNc/ZQzPjtPGr0khCNWzXEwLm40jvGsG3cBz1purs2uqLIFaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZzYK34q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4766C19423;
	Tue,  3 Mar 2026 03:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772508402;
	bh=4zf61ALQTMK14img1HViSIDfxFknaHCr69Rl17qSQGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sZzYK34q0BRTj07TilzGsQwaXUIwwANpvSCCq/V9QelZ5EHSUiF8FPL24xGhjPWTw
	 /k/VfPBRODiDwVF8MTGdyebPO/HSzlCyaBCfVc8MSodNuEWJaXblnXJ0bJULhRY5lG
	 glziYAWp9B5Ti71/OQRLLuaNin8ZjvbZVD1N1SqvXX4+Y2Xj1S74JfBzPbz9//ggVo
	 WCtESLc46MPYF1kEzz8O1hSY/HrPw+PAKHL8h1k93eGDWmcr5eorH6d+jv37SXPTLg
	 ttKItjGaEyPwHMrqgahjd80aG/McSVbE//TsRlaJIRO3DFGkUFiUJ9+PQqPfw4sp7H
	 yR+RnyItx4wfA==
Date: Mon, 2 Mar 2026 19:26:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource
 support
Message-ID: <20260302192640.49af074f@kernel.org>
In-Reply-To: <20260226221916.1800227-1-tariqt@nvidia.com>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 45C3F1E87B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17414-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 00:19:06 +0200 Tariq Toukan wrote:
> With this series, users can query per-port resources:
> 
> $ devlink port resource show pci/0000:03:00.0/196608
> pci/0000:03:00.0/196608:
>   name max_SFs size 20 unit entry
> 
> $ devlink port resource show
> pci/0000:03:00.0/196608:
>   name max_SFs size 20 unit entry
> pci/0000:03:00.1/262144:
>   name max_SFs size 20 unit entry

Code LGTM, I have a question about having a new cmd, tho.

Does it matter to the user how the resource is scoped? 
Whether the resource is at the instance level or at the port level?

I worry we are mechanically following the design of other commands.
Since the dump handler is new we could just dump resources with port-id
there. No existing user space may be using it. Alternatively we could
add a new attribute to select a bitmask of which scope user wants to
dump.

I have a strong suspicion that the user will want to access all
resources of a device. `devlink resource show [$dev]` should dump 
all resources devlink knows about, including port ones.

What's the reason for the new command?

