Return-Path: <linux-rdma+bounces-16465-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH6WK6oegmmhPQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16465-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 17:13:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CF8DBBE2
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 17:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7170A309B19C
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 16:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BE33C196C;
	Tue,  3 Feb 2026 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmsb8G4q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389A190462;
	Tue,  3 Feb 2026 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135080; cv=none; b=G5jIgwQoyp2g3J3vh7iaKcFQ7p1Wmt+HqsqZCGJMTzcFMT79A+CDu5YgcK3Zu+2m5I14PcZA6dIUUmDXwO+ivkILYk6TWCWbaO/f9oqbQptWlZrzjponOxwSVTKXTOrD51o/TR+/BUZnIqeC6ta6+JWZf7ZqedcQyV2fjGGUJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135080; c=relaxed/simple;
	bh=1tbIX25+8uE6MY6wp88tD9hkDQp221nFtwfC6Jl67ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLfG9iAiHcj6ifmuL6VmxJu6whZLc+SS5QdpMWSaARzHwO1Aa8V16VgR849iLxeJNCuEWlaEL9kSQFH4AjzTJJDwQ82Nq1lw9+W6th1tCBRT/aG8tNgneCERtWbfHHjhmkdvTTHcq1wouYb7GG2jaS7UKckXRwjCBDkvx7RIjUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmsb8G4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7489C116D0;
	Tue,  3 Feb 2026 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770135080;
	bh=1tbIX25+8uE6MY6wp88tD9hkDQp221nFtwfC6Jl67ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jmsb8G4qpkmXi91BggH1JrBWPeFNli0npPW+MBfy9+3crsdSYQ2EtJt5uEvWy+8EF
	 p1pfJz0kXtBcroFMeY2v9SjKhWZixreEcjYD8e/PX/AISi6b/VpLq41N4tGWiYk/Yo
	 K00vxt3eE1vsNY5n7YlgG1moDVr4rCj2Bko/ksSMwOXwBjMX57ZmBZA0XAmIL6/Q6g
	 3wb4g3I2XqnGXLc4mSzDU15k0uqzm6a/nEzS3uGMcfWlXYHBs7oNF0IzX3VCz7M665
	 l9zYsUfA2hL7QiBh9l4i6CFPvrI9oEW33iOo8o4FwgUWiP3URE0GjmDEVTEeqh/2Qx
	 jwvcaSWrGf/vg==
From: Simon Horman <horms@kernel.org>
To: ivecera@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	richardcochran@gmail.com,
	arkadiusz.kubalewski@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	kuba@kernel.org,
	tariqt@nvidia.com,
	netdev@vger.kernel.org,
	grzegorz.nitka@intel.com,
	poros@redhat.com,
	davem@davemloft.net,
	vadim.fedorenko@linux.dev,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aleksander.lobakin@intel.com,
	jonathan.lemon@gmail.com,
	jiri@resnulli.us,
	anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org,
	Prathosh.Satish@microchip.com,
	leon@kernel.org,
	edumazet@google.com,
	mbloch@nvidia.com
Subject: Re: [net-next,v4,7/9] dpll: Add reference count tracking support
Date: Tue,  3 Feb 2026 16:11:02 +0000
Message-ID: <20260203161102.1894146-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202171638.17427-8-ivecera@redhat.com>
References: <20260202171638.17427-8-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,lunn.ch,redhat.com,nvidia.com,vger.kernel.org,davemloft.net,linux.dev,resnulli.us,lists.osuosl.org,microchip.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-16465-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12CF8DBBE2
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
dpll: Add reference count tracking support

This commit adds REF_TRACKER infrastructure support to the DPLL subsystem,
allowing developers to track and debug reference counting leaks for
dpll_device and dpll_pin objects via debugfs.

> diff --git a/include/linux/dpll.h b/include/linux/dpll.h
> --- a/include/linux/dpll.h
> +++ b/include/linux/dpll.h

[ ... ]

> @@ -223,16 +231,17 @@ dpll_netdev_add_pin_handle(struct sk_buff *msg, const struct net_device *dev)
>  }
>
>  static inline struct dpll_pin *
> -fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
> +fwnode_dpll_pin_find(struct fwnode_handle *fwnode, dpll_tracker *tracker);
>  {
>  	return NULL;
>  }

There appears to be a stray semicolon at the end of the function signature
on the line with the tracker parameter. This would cause a compile error
when CONFIG_DPLL is disabled since the function body follows what looks
like a forward declaration.

Should the semicolon be removed so the stub function compiles correctly?

