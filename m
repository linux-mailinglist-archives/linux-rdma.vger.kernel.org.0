Return-Path: <linux-rdma+bounces-17410-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKm4HFY6pmnQMgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17410-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 02:33:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B141E7B5A
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 02:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA39A302F7C1
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 01:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7698B373C0B;
	Tue,  3 Mar 2026 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj1dklSB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A15830148B;
	Tue,  3 Mar 2026 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772501584; cv=none; b=IC1u+8cBCK7alKO4itomJZzWpkl8RpsJC/yQBr34lvYXwdcV5q7PMoBm/FE0Pc/BdLhBL0kh/0gahgP0mt4XTOnLuyU/BoAdmOLFJN4PysT/MXNtfSUtgLEJ3T+tWW6lj/A9DbEFwkVr2UT/cginq/2rzt5kqEqDevF6H8s5Uvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772501584; c=relaxed/simple;
	bh=IUUZMklsuDqt9XDyM9yk4sjEMlG0JCQemvWf3MVHwlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5HJdpj9BRDpMqJhCD1ZQR/vRK0cRVlBhK8lbM+WU8g4r9e0IhWFBk5/fFmJlKCqZqkvpQxSY5BCSixaZtpQpxjW+AWQG5bnkl51sMZnLI70s3rUfTW7cezop2PSnuN6rrMwrmISf2jnIcFr9YB2P8JoA3MaDmcxwSu+anffkPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj1dklSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9B6C19423;
	Tue,  3 Mar 2026 01:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772501583;
	bh=IUUZMklsuDqt9XDyM9yk4sjEMlG0JCQemvWf3MVHwlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bj1dklSB20+0Kay/8hcYBsj29heJW2oqguhj7spRmyhM8d0TF6NbRWyKNGDjZ0Dvc
	 3Rsq1JnW2WuGk36M6P9w8+MsFx3wVl0cKkz1lJ3lKIcsUBw3b0qMznwdouEHq/5j+D
	 y2NfYxMS7DzP0mRyTdHMgbTDhEWqm3fwYSqBaiEA1LlKLXR/BBSSvRM6QWRavvlv8Y
	 8XdtHbycUO3SV91pgi4YKG/ExD+oYobj3cmt580hxvcoAs4thhzmQKrSz9yDnJDeOO
	 zmIS4Js6XenCLxEAoTRCF4Ax4M3T9MWRg4om8OmUzj0Y9It+csZRPF2eS20yPnZV0e
	 JlGtq4Bm1NpEg==
Date: Mon, 2 Mar 2026 17:33:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, rds-devel@oss.oracle.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, allison.henderson@oracle.com
Subject: Re: [PATCH net-next v1 0/2] selftests: rds: refactor and expand rds
 selftests test
Message-ID: <20260302173302.4d1634be@kernel.org>
In-Reply-To: <20260302055518.301620-1-achender@kernel.org>
References: <20260302055518.301620-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E4B141E7B5A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-17410-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun,  1 Mar 2026 22:55:16 -0700 Allison Henderson wrote:
> This series aims to improve the current rds selftests.  The first patch
> refactors the existing test.py such that the networking set up can be
> reused as general purpose infrastructure for other tests.  The existing
> send and receive code is hoisted into a separate rds_basic.py.  The next
> patch adds a new rds_stress.py that exercises RDS via the external
> rds-stress tool from the rds-tools package if it is available on the host.
> We add two new flags to test.py, -b and -s to select rds_basic or
> rds_stress respectively.  The intent is to make the RDS selftests more
> modular and extensible.  Let me know what you all think.
> 
> Questions, comments, suggestions appreciated!

IDK Allison. I tried to integrate the remaining tests with Netdev CI
this weekend. The two groups of networking tests which can't be run
like all the other selftests are vsock and RDS. I get vsock being
different. vsock is used to communicate between VMs and host, setting
up the vms with the locally built kernel makes it different.

But I'm not exactly sure what makes RDS different. Would you mind
explaining the challenges with fitting RDS into the ksft framework?

