Return-Path: <linux-rdma+bounces-21253-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP9kM0umFGrJPAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21253-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 21:43:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1815CE11F
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 21:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 240993019063
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 19:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418CF38E5C5;
	Mon, 25 May 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8XEbhfU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F3337418A;
	Mon, 25 May 2026 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738180; cv=none; b=qLSV6fagi1Ba0bA51Y8URt/Kp9TCsKdFM3zu9sJ9xUXxzmGlLyNmI+4AR7eaqTWec0zjzYCzDb8/gnEqO1BLKfNiCOA8tX4H2oXHrMA7tLaf18AFwC+9JcolcVrl+cppMQjw1ggqTPIqNDzKzSQb3u3yGlz2QFc18gMTeHexVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738180; c=relaxed/simple;
	bh=Jo/OJzYZCIImOcYJ3WAb+KzIrcs9HUZLvpuvO2g0qN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVC5Bq/WcRBUcE91kqDl1CaF5LkgCNSWQdKJDY3RaAWSlNYq32rM9A2NJBbBze4tqEIv2Uxst/SEnkVU9R+4M0woibbckPEBt+HCeQ1mV5F99m8wnog0RNOYXV7r6eMLLgwfiI27OjkEsz+2siXCM4TQkX6EH/tGuKeKi1I9mg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8XEbhfU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545351F000E9;
	Mon, 25 May 2026 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779738178;
	bh=Jo/OJzYZCIImOcYJ3WAb+KzIrcs9HUZLvpuvO2g0qN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E8XEbhfU+Afan/bFYy1JgvUMS3Zbc4YmVrT4d5tqKLycF4xYhScC26GaE86G7e8+2
	 rAuF2srlkmB+0nHlGGPXNk/4mUeGxzxKL60QK/Nz4S6EHrZcKtuuu2EIUlxq+gO1Ha
	 AvMtKH4yI6yfFEMCVJpYnRnqs2sBqc6hLepzK+qHLsWD0XSWxUdDbzn01T7HIOFuoO
	 CHntSDes8C1OEFrx51qX0o8x7Uo+u0S3PqYQETslmQqSbfUju/4eeMLCKBQa/QbqS7
	 ZjiYaMJSdVSvkykmsExT3nSPKBsYwCbozjZGWfTgeZW3V6BbDeg16HmZ5DayeqgtB1
	 gyVBDUnypvYXA==
Date: Mon, 25 May 2026 12:42:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, "Saeed Mahameed" <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, "Borislav
 Petkov (AMD)" <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, "Tejun Heo" <tj@kernel.org>, Vlastimil Babka
 <vbabka@kernel.org>, Feng Tang <feng.tang@linux.alibaba.com>, Christian
 Brauner <brauner@kernel.org>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco
 Elver <elver@google.com>, Li RongQing <lirongqing@baidu.com>, Eric Biggers
 <ebiggers@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 0/3] devlink: Add boot-time eswitch mode
 defaults
Message-ID: <20260525124256.650fbd9d@kernel.org>
In-Reply-To: <20260521072434.362624-1-tariqt@nvidia.com>
References: <20260521072434.362624-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21253-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5F1815CE11F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 10:24:31 +0300 Tariq Toukan wrote:
> This series adds a devlink_eswitch_mode= kernel command line parameter
> for applying a default devlink eswitch mode during device
> initialization.

Jiri? Are you okay with this?

