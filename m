Return-Path: <linux-rdma+bounces-19689-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM0XE7f48GlpbgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19689-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 20:13:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C9048A854
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 20:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BAD13026C9D
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 18:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B139146AF0B;
	Tue, 28 Apr 2026 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K714a/eO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711F7466B5E;
	Tue, 28 Apr 2026 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399896; cv=none; b=Rj7FqfkMzpy4cOCTZ5rzVskA0hROyv+JoPVdRbYI/j5nSlU8SupJdM4PIyNgH4eW9cJe+ggtRFTHNZl0kcKBoSqUvV7unl6AmVyQzJyviKqehzSv34XFN/iKwb97PwGKJ9xY2WStWxuUdPaUqAZpGRQEzKkdkSzK8YkplN6HfK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399896; c=relaxed/simple;
	bh=S/AnHKW3MK/QE2PR1Fk+tXCjOwZd0eCKlknwW999+GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcwZTEdiAzzD+Qc9oUEyrf0h5doyBlVrDOz85uHaZOme3LAhiIT+w2aG9QKPbQ9DWYqn3KC/Scxnp5AAr2IgN6HsIssFHnscF76hV1eL1Ki/rHTmKDL/7Ree65jlU7vsYTbm6tMJEaaMpk0pmFIxvPARqOCQo1l8JUjv7AGLonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K714a/eO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11162C2BCB5;
	Tue, 28 Apr 2026 18:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777399896;
	bh=S/AnHKW3MK/QE2PR1Fk+tXCjOwZd0eCKlknwW999+GY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K714a/eO+/Y7k7FhslO+mkEDqrtUdvQnYBBGcPDmuyC/av0LquXiS3ZSo/NwBNlTe
	 LjPE9P74ZLxA6qWdok7vWL20cA6PG0XKASXYhBXzSKzx6L82DWz8T9JjUZyt7lGqOE
	 vkj/i3t3fC1Hu/ui2zk3Q8wHlsTKkNYoQiBt9VFMMIa7VAtL/QJmszfYgfYhiYD4+h
	 ZIw8FOeWH17tNrKM3OuoVZ3KERZkXu/6Q5h8ouDcmYeN5oSf1JSkei58CpCTMGZkCF
	 onsKkG6ps1cZMQJKTDgYmBJe0Ydr2lt792035v+hxq9wGBQLxOPwDfVMVEmBMs6ZzX
	 EkoBWpID0Tk5w==
Date: Tue, 28 Apr 2026 19:11:31 +0100
From: Simon Horman <horms@kernel.org>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: saeedm@nvidia.com, leon@kernel.org, kuba@kernel.org, tariqt@nvidia.com,
	cratiu@nvidia.com, cjubran@nvidia.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net/mlx5: Fix eswitch offloads cleanup on QoS
 init failure
Message-ID: <20260428181131.GV900403@horms.kernel.org>
References: <20260425003046.6889-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425003046.6889-1-prathameshdeshpande7@gmail.com>
X-Rspamd-Queue-Id: F1C9048A854
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19689-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]

On Sat, Apr 25, 2026 at 01:29:59AM +0100, Prathamesh Deshpande wrote:
> If mlx5_esw_qos_init() fails after esw_offloads_init() succeeds,
> mlx5_eswitch_init() jumps to reps_err and skips esw_offloads_cleanup(),
> leaking the offloads initialization state.
> 
> Add a dedicated unwind label for QoS init failure that cleans up
> offloads before continuing the existing vport and outer eswitch cleanup.
> 
> Fixes: cac7356c653d ("net/mlx5: Rework esw qos domain init and cleanup")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


