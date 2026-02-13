Return-Path: <linux-rdma+bounces-16801-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLHMK0OVjmmhDAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16801-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 04:06:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A371328DB
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 04:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CB4330A4FEC
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 03:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64415238D27;
	Fri, 13 Feb 2026 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvAYX/Vy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24936221726;
	Fri, 13 Feb 2026 03:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951936; cv=none; b=Ri0n5zgVws0EYqviGbvmqvcscr/H1CtrW6LoJzfDm8Rewtm9LPdXQgiTjh4ggdqS44uvKB9k7bu0FI3n/atgqCsUAy9OzzKYfOEEBuj2HVtkFBQn5JUaKUNDkF5DTKQ+0a0sPkAw97jCkUFs161QEjxiSR8o4xAzoXVBOuQfLrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951936; c=relaxed/simple;
	bh=xy1H1KWisVrqdFCNDf6YZe11NWXWdfjP3WJvVZI50/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CiYJ8uWzKOIz35M6VVM3NxeItIqGYlos8kK7S9jRSJ/BN8YBx4E1oMgHqlieLDeHU2ysgbVDcxxWHgM+qScVs8iF/eW/t9adAA5NzKfqMc58R+hTTHRiSys8bWkD+zkI5DGoOcpLQiD5c7eqmAptfOi8PeVvq6E/fhiYfoTy9rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvAYX/Vy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564E7C19422;
	Fri, 13 Feb 2026 03:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770951935;
	bh=xy1H1KWisVrqdFCNDf6YZe11NWXWdfjP3WJvVZI50/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AvAYX/VybRQDKfBqGIse30m1sc/96Y1356IAkLiD7lhY0jPB7FHEr0MvpGlHm1yp1
	 BgRvHGPVyDvKyvLZBMhz86HvpH7PesCSfblXboASu7ZUyrY/zLdc2w5ayBybR/zlrl
	 PEnSThEpO3tKfFINiWSfueUE/BcGwi9G7tAB8/dgPyVALKUjF/Z3Wr390p4CMPx5gQ
	 MHSAvP1uQ516t/0nyjh4Fr4Lxu4XARbdKiVEQuOxQe5x/LoyJPoSOgURJiexvqZCLu
	 Bn5FVIU9ac9QE6F6g8JvGoEFbbKHJjTn7JydhKrnpEuLtIZYCOQD5+MpPoXlvxiGgg
	 vMuDj9pAA7fIQ==
Date: Thu, 12 Feb 2026 19:05:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, rds-devel@oss.oracle.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, allison.henderson@oracle.com
Subject: Re: [PATCH net v2] net/rds: rds_sendmsg should not discard
 payload_len
Message-ID: <20260212190534.7faf2878@kernel.org>
In-Reply-To: <20260210170952.1836306-1-achender@kernel.org>
References: <20260210170952.1836306-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16801-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57A371328DB
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 10:09:52 -0700 Allison Henderson wrote:
> Commit 3db6e0d172c9 ("rds: use RCU to synchronize work-enqueue with
> connection teardown") modifies rds_sendmsg to avoid enqueueing work
> while a tear down is in progress. However, it also changed the return
> value of rds_sendmsg to that of rds_send_xmit instead of the
> payload_len. This means the user may incorrectly receive errno values
> when it should have simply received a payload of 0 while the peer
> attempts a reconnections.  So this patch corrects the teardown handling
> code to only use the out error path in that case, thus restoring the
> original payload_len return value.

net-next now became net so this no longer applies.
Please rebase?
-- 
pw-bot: cr

