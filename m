Return-Path: <linux-rdma+bounces-17924-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD0JGQfLsGnYnAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17924-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 02:53:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8CC25A86B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 02:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCB3B316D498
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C7528643A;
	Wed, 11 Mar 2026 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYrNcpAx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0152620E5;
	Wed, 11 Mar 2026 01:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193987; cv=none; b=IbR+qGGv/yqaalIjzOdgXEcH2c8b5AlQ8c9PCw1RQw+MeWKhxHbD9SkPI5U8JpNC4wpdlg3rkA1FK/ahW1Qw6DlV1TxgFix4ePBS3xj67+GSsWqMT/CnxPLuRbbuMNxAM+FwXXc6SQzLDSR0XzLqoWp83nwbo+zlltc/Pkh8F74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193987; c=relaxed/simple;
	bh=hA1SOMBfQcJ1nRyGdPSf7nW/4Wt8S46qe4n/LLTcF2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLycdMhDkGP4xyx61QEVhryUyieM3B81BPFisehCFIkr/5QBus4uDgQqrGpbUbKAc/tWJb8PAE2osA6DisvPsbfccqQBqiYhUqXTet/vD00e9j8fvsmJlx24FwQAl+GujnZWQ6+UrSG3hmJq3r1/i/0AAk68MDMtJVyRqJ1v+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYrNcpAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA0CC19423;
	Wed, 11 Mar 2026 01:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773193986;
	bh=hA1SOMBfQcJ1nRyGdPSf7nW/4Wt8S46qe4n/LLTcF2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NYrNcpAxtyqsiPAte9gleZbgNjrSsBJ6AE5vndEEkx7AfRgZgYyFIZSjFzj+kogQO
	 kdd8Tdg9af9CBdyaa6Y29M+LPqnWF7LYIIYbZKadjB87YankB24xlaDWVoXb3nSK5k
	 qryTXYsVx0Zl6+uK/s1U/ulTG54T+PSZbPzJ06E1D5zR0qRQ9QYXKGPLt8UVfgB2xj
	 Cd6GnUYcRmIGhiKVaiMQRTj5QDjYCZ+amZB7612Epd6wqgN+vw0SoUDaddZB37Docc
	 M2uABxIo/O822l34wAvunTxO3ri5GKkBds9m+yQ815FcoPj0OWbH/qB1NkU5D/bPeW
	 zMYbOnme+b+Mw==
Date: Tue, 10 Mar 2026 18:53:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, rds-devel@oss.oracle.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, allison.henderson@oracle.com
Subject: Re: [PATCH net-next v1 0/3] selftests: rds: ksft cleanups
Message-ID: <20260310185305.017976e4@kernel.org>
In-Reply-To: <20260308055835.1338257-1-achender@kernel.org>
References: <20260308055835.1338257-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2F8CC25A86B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-17924-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat,  7 Mar 2026 22:58:32 -0700 Allison Henderson wrote:
> This set addresses a few rds selftests clean ups and bugs encountered
> when running in the ksft framework.  The first patch is a clean up
> patch that addresses pylint warnings, but otherwise no functional
> changes.  The next patch moves the test time out to a ksft settings
> file so that the time out is set appropriately.  And lastly we fix a
> tcpdump segfault caused by deprecated a os.fork() call.

Looks good! So this is enough to make ksft work? Or just the first
batch of obvious fixes? :)

