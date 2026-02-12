Return-Path: <linux-rdma+bounces-16792-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIjHNcAXjmlF/QAAu9opvQ
	(envelope-from <linux-rdma+bounces-16792-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 19:11:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD4A1302D7
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 19:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D837C313A8B5
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 18:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D7327602C;
	Thu, 12 Feb 2026 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIOECiup"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504F626ED48;
	Thu, 12 Feb 2026 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919761; cv=none; b=FDyWcejZx4QFwE8qwHi35C2OsZCDtt33kmtXmYiJzuG0Zcj6uUFibmMkdKGlZUa0OgcSniWCJ4Dt22ljVsM4DPiB3G0E4A4DdATyPWEg4TSyN9MeAJLND/UIuc5OzySD2TUsnLP1i8I4A+9YBxb1Q2uf/WB+rcWAqhl49GYBXNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919761; c=relaxed/simple;
	bh=675eDV9sIt2add7Bg/uFdc/MTRLZILmHROOmBW1YyAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j27IvkBNsthK8TGm4fpLYT4qXkjZqDrUuabrWLoNobrcZDGkvQo9rk51g7HXpgGbbSSwVqEpk59W4xUhs/eCLtbbsMxvzv7D6JeiwMNahHsUTt8t6iCsv0Lp6fs+j5nd8+gLKluHbhrCylKZYqtOIIb3Mwcnq4K2BA1VDFvyzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIOECiup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02690C4CEF7;
	Thu, 12 Feb 2026 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770919760;
	bh=675eDV9sIt2add7Bg/uFdc/MTRLZILmHROOmBW1YyAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bIOECiupGTU7l/8oRwphVdZDCb8pSro77lIilMyxaMYzU1S0rzY7cUlaOgBiGSqtY
	 k8wgxDwtPYuVI8zwb/ow2N0xTwb9JWOkvP6lFr8PKvwPcD1RDXGJo1cBzO8Reg3RD6
	 TzOGwCtE5L+B+0603o/+CzMjd2yBa44l38ljcFjNfvk81ouQ+N5rkNxC32C5zyj394
	 o2ikMK9E6mf7h4iVRzkDjHjuqsNJy/Rp3feaWtAXVfCaQ+hJm7Krtk0H9sJwQk+azM
	 0IcZoY4rPgjBdxH/22iGVkqMgjhEWOti7j2u7+Pk2Sx7DJ6iqVbKBQGzvJKXM5v7ou
	 aFkD0cyhrl7ng==
Date: Thu, 12 Feb 2026 18:09:16 +0000
From: Simon Horman <horms@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, rds-devel@oss.oracle.com,
	kuba@kernel.org, linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: Re: [PATCH net v2] net/rds: rds_sendmsg should not discard
 payload_len
Message-ID: <aY4XTIr2qklED4cs@horms.kernel.org>
References: <20260210170952.1836306-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210170952.1836306-1-achender@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16792-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3AD4A1302D7
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:09:52AM -0700, Allison Henderson wrote:
> Commit 3db6e0d172c9 ("rds: use RCU to synchronize work-enqueue with
> connection teardown") modifies rds_sendmsg to avoid enqueueing work
> while a tear down is in progress. However, it also changed the return
> value of rds_sendmsg to that of rds_send_xmit instead of the
> payload_len. This means the user may incorrectly receive errno values
> when it should have simply received a payload of 0 while the peer
> attempts a reconnections.  So this patch corrects the teardown handling
> code to only use the out error path in that case, thus restoring the
> original payload_len return value.
> 
> Fixes: 3db6e0d172c9 ("rds: use RCU to synchronize work-enqueue with connection teardown")
> Signed-off-by: Allison Henderson <achender@kernel.org>
> 
> ---
> Changes in v2:
> - Rebased on net/main to fix apply failure in v1

Reviewed-by: Simon Horman <horms@kernel.org>


