Return-Path: <linux-rdma+bounces-20534-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNVUBj3XA2ol/AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20534-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 03:43:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD7052C0D3
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 03:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 181543091456
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 01:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD45B37F747;
	Wed, 13 May 2026 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNnPZOav"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555A3603C3;
	Wed, 13 May 2026 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636531; cv=none; b=gsdCdvRHtbmsTOlZupWi5kJ2xYKjamcwCn17FDUly1HKSywYKkWLR7x0Pq4oUfeT+ZO90jgLh4Owzi7RvDem6D1DgWx2AJHxdSuD9b7CLnuojpNkcNu59quyi0/0at6pz7Qts+d2MtPj223E6F4xqg0CWADVLQlZewJhY4wi+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636531; c=relaxed/simple;
	bh=AcS6l66vmeOrnUBLByEeYYoUa+SU5u6F9CFtq41oqoU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlRKh0md92kOONFuRCw93Gqo4Bk+OF+xU3ab1AuX2T6RGAdEr13SaeKdHr8UJD1MxwZcDeX5v2o2eIq01Y1I4BsMF2K6+SM2QjNAC+XOSKhimI0b7S0y6IDiT1WHSn5JoCmngm7h7MUruBJqHcKV9cUOHNWa+3a9fv0/mn7bQVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNnPZOav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B9BC2BCB0;
	Wed, 13 May 2026 01:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778636530;
	bh=AcS6l66vmeOrnUBLByEeYYoUa+SU5u6F9CFtq41oqoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MNnPZOavBuJLi984hDOuavBnH48UVXPC6bqjqCL+d6ZIABE21CYlJpar8RL7PvmEU
	 ZP4P9sVy6AzO/RSKFNDxphi9XUADn3Vwqvb0DuuxlJT6Ja1RmMW0h+XAHwmFOlREF3
	 63TN+F34Akyg8EfTtHpivIzHcOpYEHBgSF5NL9uKCf+D3snkQWHv9sTi2F0C6WwLoe
	 dmqwMZWUNFDqqbhAg4tAt7SCMubyfsxk6zt3+Lc2HgJP2PGWkuGBrPnOtTt4TmbOrj
	 swkWn+wRrF8Q1nAr/F+QQneLpK7J0Xb3m24JySkDXDMNLgI86/EDfWNrHMfJr9Fhh9
	 7wrR3yhzostXA==
Date: Tue, 12 May 2026 18:42:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH net-next v1 0/9] selftests: rds: Add ROCE support to rds
 selftests
Message-ID: <20260512184209.0956bcf1@kernel.org>
In-Reply-To: <20260511072316.1174045-1-achender@kernel.org>
References: <20260511072316.1174045-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ABD7052C0D3
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
	TAGGED_FROM(0.00)[bounces-20534-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 00:23:07 -0700 Allison Henderson wrote:
> Currently the rds selftests only tests the tcp transport.  This means
> most of rds_rdma.ko has no testing coverage.  This series refactors the
> rds self tests to add an rdma option when running tests.  When used,
> the test creates a pair of ROCE interfaces to run the payloads through.
> 
> Most of this set is refactoring the existing test.py module.  Since most
> of this code is one long procedure, it is difficult to modularize it
> without creating a lot of pylint complaints about lengthy functions
> with too many variables or branches.  The first seven patches address
> this by breaking down test.py into helper functions.  After we have
> modularized the send/recv packet logic, we introduce the new ROCE
> equivalent network configurations, add the new command line flags to
> build and run the test with rdma support.  

Looks like there's a handful of ruff and pylint warnings flagged here.
-- 
pw-bot: cr

