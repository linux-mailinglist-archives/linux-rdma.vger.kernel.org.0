Return-Path: <linux-rdma+bounces-17412-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLyLDzNSpmkbOAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17412-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 04:14:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA071E8618
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 04:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2380305B95C
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 03:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD3637CD3B;
	Tue,  3 Mar 2026 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQWu+XoT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907E19ADB0;
	Tue,  3 Mar 2026 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507690; cv=none; b=CvEEFXqQxKvskZrjAv9mLWE80LJmEPQIdGhPfSLBnt4BEr10yR23uvrvE4nvSOuGylRIbcNpcxXQEw5emspwk75bSS3gH4cjlG7mIBMBfBx9mgMGSDtiCMOgNvuRx+leJyxpP9xps9xV+iWkg4PHMLzIvDbvvlTphWihZEyYupo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507690; c=relaxed/simple;
	bh=fkufFEILEgr60R+q2FwGShsko0FhfpQaQOtbm/Dl9K4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8CuQjMveLmsawwaZOIGZj5jQ0XCxmPOjIXqCCw0mc2UEnLqnl4F9mXaiqWUEB78A2tos7dYZ/AUxUDfRCWSDC9bwVgDyWBsHSMgsBEvWLGS5KbmP1X9OE61zQjUpUUjtkQy6d/LX3CJ3jgXle66tg0zZhLL4WZkmavwcjVse7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQWu+XoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D74BC19423;
	Tue,  3 Mar 2026 03:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772507690;
	bh=fkufFEILEgr60R+q2FwGShsko0FhfpQaQOtbm/Dl9K4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LQWu+XoTYOcyh6LMYgIvXa4ZEZxcfojfe2Q2usEm7VJYdH8P+ffjashH8Ygx8Ffae
	 hL2gZcpVXUw9Dz5Wt/QGR6NCli7MmCl1DbCEkUxww/Kf+HY7ESarYtoW65iXumnhYM
	 svKRVTBBGb03Huh87q+TbbsTTi75DZOK1l7ic+jg83K+SHRzSJ0bFvE0tMJH3d4CzG
	 QMlh/9/VdVpIveRArncztY1q+VVvKugReQP+6t/a7LEsDrbdShUGHPbroKnyAU8+R4
	 jF/xXs7MKNuzPiysgBSYvrjkXeFUrubm6YneeGizHm1VtobgW395tSZFXd7/fJ7T41
	 m/fSJEjatpoqQ==
Date: Mon, 2 Mar 2026 19:14:48 -0800
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
 <jiri@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Or Har-Toov
 <ohartoov@nvidia.com>
Subject: Re: [PATCH net-next V3 10/10] devlink: Document port-level
 resources
Message-ID: <20260302191448.4750a2b8@kernel.org>
In-Reply-To: <20260226221916.1800227-11-tariqt@nvidia.com>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
	<20260226221916.1800227-11-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DFA071E8618
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
	TAGGED_FROM(0.00)[bounces-17412-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 00:19:16 +0200 Tariq Toukan wrote:
> +Currently, port-level resources only support the ``GET`` command for viewing
> +resource information.

In case there is v4, AI says:

> +Currently, port-level resources only support the ``GET`` command for viewing
                                                         ^^^^^

This isn't a bug, but the terminology here appears inconsistent with the
rest of the documentation. The document uses user-facing command names
elsewhere (like "devlink port resource show"), but this line uses "GET
command" which seems to reference the internal DEVLINK_CMD_PORT_RESOURCE_GET
netlink command.

Should this be reworded to match the user-facing terminology used throughout
the rest of the document, perhaps "only support the show command" or
"only support viewing"?

