Return-Path: <linux-rdma+bounces-20478-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIOODyIEA2pczgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20478-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 12:42:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE22351EC4A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 12:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92BF1303FDF1
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 10:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03803839AA;
	Tue, 12 May 2026 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chFG42Pf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A8D383995;
	Tue, 12 May 2026 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582272; cv=none; b=EqeecoGAB9XOIWDegmsIz2zp4qZgvJIZW78opPI9sUtlZuy67BWG5fX/2gpqYR9pvNggLn/NRVtdXgCKFLSpt13IBEnY1WDdgygjb4ICfBow+gHtLaZemu5GJG82TbJ1NOfb1A9w+Hvi8pph1J9TAin4l2I3lO+URSWhK1XFDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582272; c=relaxed/simple;
	bh=GLgaYUx4BzRSrBv/2Xam7U8WQHjl9Q0D65xABqKs5pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PL7bztbS8VrVHn+luVUu1QUtS29BguPV5oxKsYXPgS2AFCM3XwC1dQiFGE2j0V8zbwiv9Aj3SSdC3hoHuKWuxrbzTTi9ibyIFd//p3ZRcB9x4l4Bt7W35thhZ5XRlPfvJ0quWZCVUnc7tLxNk+TEc7qPh7/evr4tXUzFoyPejCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chFG42Pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBC3C2BCB0;
	Tue, 12 May 2026 10:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778582272;
	bh=GLgaYUx4BzRSrBv/2Xam7U8WQHjl9Q0D65xABqKs5pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=chFG42Pf9BnHnsTkzNR0YSWepcisC4RHbxSVmzP0nRY4f4GiRn54O8g3XzUGT2UVm
	 aa+Ix8d2yzQV9ohZevPEyG+5P7vuhdLsKkqK3adyoo7kowq25yaQehSEgA72rfZ4XR
	 pKA1tU2HCzikESWte8w53iX8Hg47Yzlhb0gkk3/ctmvKJbFM1LWpFt70Va0ipEhELN
	 CeG9KMNhcqGx6mjTzH22jUe3nrA1lTCE1N0BDbYn1WzqFTWpjfN0HshPpLXe/UdsQx
	 5YedHXHJf0t5JGG+7DTwoJGHjFgz3ei3OqRD3NIIYf3n5igm5eu+uF8b9BTzlJWzqz
	 ZWUcYMR8KjGzA==
Date: Tue, 12 May 2026 11:37:47 +0100
From: Simon Horman <horms@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: achender@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org, maoyi.xie@ntu.edu.sg,
	praveen.kakkolangara@aumovio.com
Subject: Re: [PATCH net v2] rds: filter RDS_INFO_* getsockopt by caller's
 netns
Message-ID: <20260512103747.GJ27589@horms.kernel.org>
References: <20260507081332.2868770-1-maoyixie.tju@gmail.com>
 <20260510145425.1372018-3-horms@kernel.org>
 <CAHPEe=FDQUTZn5QVfYiqf_p1OwiUOehe49WLXHGWzB+hgnnWrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHPEe=FDQUTZn5QVfYiqf_p1OwiUOehe49WLXHGWzB+hgnnWrw@mail.gmail.com>
X-Rspamd-Queue-Id: AE22351EC4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20478-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 02:41:58PM +0800, Maoyi Xie wrote:
> Hi Simon,
> 
> Thanks for the review.
> 
> > Does this early-out check using the global rds_sock_count break the
> > namespace isolation and force callers to over-allocate memory?
> 
> Both effects are present. The size returned via lens to a probing
> caller is still the global count. A caller in an isolated ns that
> sizes its buffer to that value can also see ENOSPC on the second
> call. The precheck compares against the global count. The data
> written only covers entries in the caller's ns.
> 
> v3 addresses this. Each handler now does a first pass to count
> entries in the caller's ns. The precheck uses that count. A second
> pass fills the buffer. The change applies to four handlers:
> rds_sock_info and rds6_sock_info in net/rds/af_rds.c, plus
> rds_tcp_tc_info and rds6_tcp_tc_info in net/rds/tcp.c. lens->nr
> now reflects the ns scoped count on both probe and full reads.
> 
> Re-verified on a KASAN VM. One AF_RDS socket is bound in init_net
> to 127.0.0.1:4242. The attacker is the same process after
> unshare(CLONE_NEWUSER | CLONE_NEWNET) and uid_map "0 0 1".
> 
>   [init]     count-probe rc=-1 errno=ENOSPC optlen_after=28 entries=1
>   [init]     full-read   rc=0  len=28 entries=1 (127.0.0.1:4242)
>   [attacker] count-probe rc=0  optlen_after=0 entries=0
>   [attacker] full-read   rc=0  len=0 entries=0
> 
> Pre-v3 the precheck returned the global count of 1 to the attacker
> via lens->nr on the zero-length probe. v3 returns 0.

Thanks. I will look over the updated code.

> > Can concurrent getsockopt calls trigger a NULL pointer dereference
> > here?
> 
> Yes, the window looks reachable.
> 
> The writer takes rds_tcp_tc_list_lock and calls list_add_tail. It
> releases the lock. Only after that it assigns tc->t_sock = sock.
> The reader takes the same lock, walks the list, and dereferences
> inet_sk(tc->t_sock->sk). There is no NULL check on the read side.
> A reader that enters between the writer's spin_unlock and the
> t_sock store observes a list entry whose t_sock is still NULL.
> 
> The companion restore_callbacks path is safe. list_del_init is
> inside the lock. A reader holding the lock cannot observe the
> unlinked entry. The matching tc->t_sock = NULL outside the lock
> is then harmless. Another reader in the same file at line 676
> already checks !tc->t_sock before use.
> 
> The smallest fix is to move tc->t_sock = sock into the
> rds_tcp_tc_list_lock critical section in rds_tcp_set_callbacks,
> just before list_add_tail. The list insertion and the t_sock
> store then become atomic from the reader's view. The diff is
> one line moved. It does not affect the callback_lock side
> effects below.
> 
> This is independent of the netns filter. I have not built a
> runtime PoC. The window is short. Does the code analysis above
> match your reading? If yes, I can send this as a separate patch
> with a Fixes tag.

Likewise, Thanks.

I agree that should be sufficient to address this problem.
And that is is appropriate to post it as a separate patch for with a Fixes tag.

