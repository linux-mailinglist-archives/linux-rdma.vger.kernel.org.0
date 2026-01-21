Return-Path: <linux-rdma+bounces-15792-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iINMDGNDcGnXXAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15792-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 04:09:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0239450403
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 04:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 558614E3F95
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 03:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3F33563E9;
	Wed, 21 Jan 2026 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+exQdwZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321B3563E0;
	Wed, 21 Jan 2026 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768964955; cv=none; b=Ub4XH+2/EK4Imumr2rLr7nsdz3jAYg4YVhK5QfLPMc8upIzmwD5KpKzx0AbVDlDkQFkqpF30XsE2Pt8iX7uXtKMcKFJFH0G3hxXl7gIyoOqH/QeA1QKMKezVFCSeQ8w1VE96RR95U4m2C9mBbq/L7p4zoUtQXT6rjte4mPzDaVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768964955; c=relaxed/simple;
	bh=i8EJvfhAHrx2u7DC/NAzF8B3wu0pX6ZGRg3ukSwxT0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pp0ntPXWzQVwuOlWT5417vP3MXCLKglQHd47tIx6UyE99b8FFIstip0L/yGdxPeN1uq2FFwaoa8xbevAGwxz662FiK3NSc/Oh1QCv2UZ+WI905wCHwqtVb0dblEmZBcm32rdCIaRFFtZqJZ8l8Nej2E0FgrA5dq5+TwI4494Xzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+exQdwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962A3C16AAE;
	Wed, 21 Jan 2026 03:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768964955;
	bh=i8EJvfhAHrx2u7DC/NAzF8B3wu0pX6ZGRg3ukSwxT0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S+exQdwZuUPQGuCtjY62QV9oq09R88Ir5IR1Ya3s21Ii3LGHWkS2S01P0tKTTCT/D
	 IhnSulBWfey0v8gsWfdA/VaYF4oVEbTtlpUid26Jozo07UV+b5ShKmmVkSrCJXl/xk
	 zLcaPaw9hdN89mOOC8ozM2hLSRr5PE6nIzw7Bzt3ZcOAviUZ/s/ljOIjF+eOLNqo3i
	 gFnJr7sZOK9M7eT6tMT8QQ8S2idOMBoAWRqvIlBZxqLxgGkC2N5SRcc7doMWX7FgBq
	 IzEWhkL4S7e6maeXl+ksoREqb7Vq6Rih8g15j6Jdeaoww7/sdMpsQEw7UkO502v301
	 Z4adIeTLTpO+w==
Date: Tue, 20 Jan 2026 19:09:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 rds-devel@oss.oracle.com, horms@kernel.org, linux-rdma@vger.kernel.org,
 allison.henderson@oracle.com
Subject: Re: [PATCH net-next v1 0/3] net/rds: RDS-TCP bug fix collection,
 subset 2: lock contention, state machine bugs, message drops
Message-ID: <20260120190913.20a16e15@kernel.org>
In-Reply-To: <20260118024911.1203224-1-achender@kernel.org>
References: <20260118024911.1203224-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15792-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0239450403
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 17 Jan 2026 19:49:08 -0700 Allison Henderson wrote:
> net/rds: RDS-TCP bug fix collection, subset 2: lock contention, state machine bugs, message drops

If these are bug fixes they must have Fixes tags and target net.
If they are resiliency improvements please don't call them bug
fixes and remove the Fixes tag on patch 2.
-- 
pw-bot: cr

