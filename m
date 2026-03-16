Return-Path: <linux-rdma+bounces-18169-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJeHEv1Ut2kwQAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18169-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 01:55:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6DB293299
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 01:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D897E3009F08
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 00:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7491A1FF7B3;
	Mon, 16 Mar 2026 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rlwh14Pe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359CD6FC5;
	Mon, 16 Mar 2026 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773622519; cv=none; b=pPhiaS4hUGsC7NlQHXSA4Ji6Hsr49FR/tqqEhzMyzA+/s7HJQqw8H2xkkJZ02Y+DJurh5WzvzM/kFcHltcZs6l6i6Pggqqqbb0fC/ROyfpdR7purlD6Zqte9t8I+eaX3U32s56+H6gP2+S2ZhsYTtJl5HndHre+V7BtJeKlRPRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773622519; c=relaxed/simple;
	bh=v36fktXtgJNkHjnROW8rniqu54DGzcSXIgzHxd0XQ54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvCsRlZjW/cR79QXhn3WCBxMGtST+w6FaKlx4QF+vyGlhQNSPUCsWrbj82+HMVNcGaYC2tJQ7AUqvp8coxLzFOa5uQ+7sgWoyVb6DMdajSMz+0QF0uKi+HbS1nEwh38ba98ny4C2+fafo6NZf1dCcprzDWfawDHYNxzlr7vcpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rlwh14Pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5227BC4CEF7;
	Mon, 16 Mar 2026 00:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773622518;
	bh=v36fktXtgJNkHjnROW8rniqu54DGzcSXIgzHxd0XQ54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rlwh14PenDKFBSeE9gBgZmbBs5s5aAsXTkfgpX+3SYnchEH586GSgB9kc3K5pp8D0
	 jJqka2EpoBGcQ97nn4AiyDGJAj3pRjQ8amy03EoO5JWPdsK6Rxbqq8t/wV3MuvkroY
	 WUO3NmHzfr+J/WeFwG2L2b9W0PiJOr1JvW7cH46gmHAewDjszn0cYEpWQbQo80K821
	 FJlegePRNzmy971vbqRusta2gxitOHd7ata59btxJRJiIjghZSGsU5xg7AnH2RcmC5
	 68OikMKT94zO8V1dIDyaur9exw6gqLu11vZSZauFLKS1ZhGlcmhmO4NVcL1WqxT1oj
	 GtOQfD1qyAZ8A==
Date: Sun, 15 Mar 2026 17:55:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "achender@kernel.org" <achender@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>, "horms@kernel.org"
 <horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 0/3] selftests: rds: ksft cleanups
Message-ID: <20260315175517.3c8cca92@kernel.org>
In-Reply-To: <20260311170557.7155dab1@kernel.org>
References: <20260308055835.1338257-1-achender@kernel.org>
	<20260310185305.017976e4@kernel.org>
	<7bc8d62f5f7e8e4a79ab5aa486d660854455a493.camel@oracle.com>
	<20260311170557.7155dab1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18169-lists,linux-rdma=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D6DB293299
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 17:05:57 -0700 Jakub Kicinski wrote:
> > > Looks good! So this is enough to make ksft work? Or just the first
> > > batch of obvious fixes? :)    
> > 
> > Those were all the ksft bugs I encountered on my end.  Let me know if
> > you run into any trouble with it.  
> 
> SG! I'll retry over the weekend

Didn't get far. We're missing a config file. TAL at other targets
there has to be a config file listing all the dependencies.
We're building a minimal config for the tests.

I think I already linked but FWIW:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

