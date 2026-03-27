Return-Path: <linux-rdma+bounces-18740-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCwBBUvtxmkIQQUAu9opvQ
	(envelope-from <linux-rdma+bounces-18740-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 21:49:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEA534B492
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 21:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D943316D627
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 20:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9484F395DB1;
	Fri, 27 Mar 2026 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUMieCM4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F8395261;
	Fri, 27 Mar 2026 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644004; cv=none; b=YBcDTGDkUaDUgUBVAeYxqMdnH5D7iwrf1GkFs2f+vbhjc0Q/dqNlTmz5HxXhg7mi9FTuXNYsRsqm6zY/6AEqux7Bq80svDes92dqhI9p27T7ise6dJrs+W9Sy4P7ZQgG8TlTOMc40SQbJM2fiKDlsPdTg+7bPxVZDlK0YSieXXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644004; c=relaxed/simple;
	bh=RQMAAZwY0bq/NFWwUwY26cDuBhb/pYkHTZ9ga8dwFYw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j87e9Y8k60668WGMqm7ApeVBJUM1+2YRa8YsWBVzimIBvwhFfNWJUXb+S003RK+u5EW7hoAIO/00wXooVqcemnW13ovY1G2cRGBPF87MGGxhEszutyzWn1L9umwAsMpgWJ167clDFFYS+6SffWeWl0Gh4IiLPdT/8vvXMxRR+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUMieCM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6D5C19423;
	Fri, 27 Mar 2026 20:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774644004;
	bh=RQMAAZwY0bq/NFWwUwY26cDuBhb/pYkHTZ9ga8dwFYw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eUMieCM4Ohw6swwOc0aRoUDLjMwtgXVChloG8ba0msdjtDK9EK9dZ6bCexDtk3zkd
	 Y/UqHYWTLm8pjMIOH8UGySew1SYDB4wagAJzcsARR2y3tYvTrgUbV29870CmXVuHF1
	 54QfE3MgGWzKeuwb/uWB5O/MSvlWplnR7rCBVe5KBcbqF7IJlaQE81tA/tRcSV977V
	 qaZxnrWZP0kOJHXk0GOBJDcWgHp/QOfd31WFx2vNw9Qskyq6VOeX7FGzNOeWID1Y4f
	 0VHjIdbq2+rNq1XSA7ItyQh5MG5njSDdOk8EowH293V90vlrXBhWP91AHrGSCPdTky
	 N/6GnCe/HUfnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE7C3806928;
	Fri, 27 Mar 2026 20:39:51 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260327150924.GA361486@nvidia.com>
References: <20260327150924.GA361486@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260327150924.GA361486@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: e37afcb56ae070477741fe2d6e61fc0c542cce2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7df48e36313029e4c0907b2023905dd7213fd678
Message-Id: <177464398980.3654421.7108849590572451979.pr-tracker-bot@kernel.org>
Date: Fri, 27 Mar 2026 20:39:49 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18740-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BEA534B492
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Fri, 27 Mar 2026 12:09:24 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7df48e36313029e4c0907b2023905dd7213fd678

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

