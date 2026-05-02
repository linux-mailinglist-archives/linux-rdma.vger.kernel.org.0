Return-Path: <linux-rdma+bounces-19857-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNLQMawo9mkSSwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19857-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 18:39:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCF64B2D6D
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 18:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A6E8300FC4E
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 16:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8013138228E;
	Sat,  2 May 2026 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJ8HIbHJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F59463;
	Sat,  2 May 2026 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777739940; cv=none; b=FT5LmOznR2Kk1ctdX+78sQbeB5ZOV/7O/lnifEyFYWWKnOiNUhdHEPr+5CdfbPxA1+PYcf/9kwzr+jjkxNqMKhGATrivKC+P522YkX0yzGhNQxQaU4JHAkCNPhafutxo3ihh+FxsKoAeLnDMNQNHtklcoume2ONghi5zVD21+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777739940; c=relaxed/simple;
	bh=Z5nCRgne7eNYBRvJ4vlO/FCOvZarm4F5SNo4cIXNnXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QutInUN4orcHA2qjeZORFIVMnYuNTjdE3VuKCEsdQQJkBRTasDV9ivYNMrQGyfkMxv+zOUZAZ1Y28Fs29b74f+qnBs7j22mbEMaQyRlrHvp9e4TSatFaa9AwNRH3vMwLQr2eBN5y5tTYPsGqCnpUUFiZOdESUrkGSc8DQJxNxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJ8HIbHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E561C19425;
	Sat,  2 May 2026 16:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777739940;
	bh=Z5nCRgne7eNYBRvJ4vlO/FCOvZarm4F5SNo4cIXNnXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AJ8HIbHJN841AEPhBO3qBsVjkjEtebLa7Dq8zYMPVE5dJEUi0aY4TX/ZQfWXjcS6v
	 BuTRgGshVU8pj/m1unFCQgUuInCl1C2bvh71pEEnpuz3NOM166uFHCFluZIVQiw/Jh
	 6QLGhn3TSmjvMtNnB2f8/EM4NAdYT70zBTbxtHnSnJEOgSn+TVKLnpLhvkRDsdQ2Wv
	 4XSxjKK6LQ3tVVZaVkLtcFLfsobtj9oB6pkf0PAav+X0xNzRL9HAaEqMXSWryZQstq
	 U/6LAGPytBPjMK5ssfuX1+rD6Bszuax2w6augnmUimieSvEO7DsZc3c2b/3L5lvyIs
	 8hSjPr7vpaB5g==
Date: Sat, 2 May 2026 09:38:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH net-next v2 5/7] selftests: rds: Fix gcov and pcap
 collection
Message-ID: <20260502093858.35b27793@kernel.org>
In-Reply-To: <843faae8c03ce534fad28e73b155d33c84f69bee.camel@kernel.org>
References: <20260428222716.2960871-6-achender@kernel.org>
	<20260430024206.2452353-1-kuba@kernel.org>
	<20260429194806.6ae176a9@kernel.org>
	<843faae8c03ce534fad28e73b155d33c84f69bee.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6DCF64B2D6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-19857-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,run.sh:url]

On Fri, 01 May 2026 22:43:04 -0700 Allison Henderson wrote:
> > point #2 my vng does have an overlayfs mounted over /tmp so the
> > mountpoint check doesn't trigger IDK if this is what you meant 
> > or I have a different version.  
> 
> I did try using --overlay-rwdir, and I think that gives rw to the
> guest, but it's ro to the host, so we dont get to keep the pcaps post
> mortem.
> 
> What we can do, if it sounds ok to you, is set up a temp scratch area
> in the rds_logs folder so it's not mounting over /tmp, and then
> run.sh can handle the mount with a cleanup trap addressing Sashiko's
> concern
> 
> Let me know what you think?

Oh, you need these files for a post mortem analysis? I missed that
point. IDK if there's a well established way to save extra debug info
from the tests. runner has per_test_log_dir but I don't think it's
exposed to tests? Until ksft has such a thing I'd probably go with
an extra env variable to point the test to a specific dir.
Which dir will depend on the CI harness. If var is not set - don't
output the logs or use /tmp and clean up when test exits.

