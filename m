Return-Path: <linux-rdma+bounces-18054-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPb6JVMfsmm5IwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18054-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 03:05:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D4826C139
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 03:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DDB83038FEB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 02:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E632377001;
	Thu, 12 Mar 2026 02:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS2prP0M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC0375F7D;
	Thu, 12 Mar 2026 02:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773281100; cv=none; b=ZxezMqBWvn8BAcIl/aY8iZFYcw3StzNJmWqoaHmppTwFfGbaJoB/bYUZoy5NHzRGqOEEwvuO0ANbVI+qZH3a2AF9BJS+cBCcQjLjJde71X2pJcgRT0ExgSnfs8XbzG+YXe87sD0olIxtbaTeqVcuJa6h5fhLmVpiiM4KFjdC6rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773281100; c=relaxed/simple;
	bh=LBDqdRbRH1XE6aUpZ1Y24sieKCpeFHI1paVWNbe8EdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMOolmRgS0CCccWdwlXdF64rR1wLu8kBccmzuSUSNP1zDsRf8FzfBhRMDeGL2bCG92ZcqUHnGWVZ30rDmbVN2SyGAw57BnX/2VgKwjuG280NPAJPi3LeQDl3ZXVqo4pY4MY4BCfTLVsQ3jwaerD48aHlNEnJ3yqwOSNkcdLcwZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cS2prP0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59342C19421;
	Thu, 12 Mar 2026 02:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773281099;
	bh=LBDqdRbRH1XE6aUpZ1Y24sieKCpeFHI1paVWNbe8EdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cS2prP0MeJ9Q003JCXBqmgpB4RjaAmJR5X2vPoP9uqSESZyiTe3YR+6mTvl2tzUMJ
	 h3SDXgNgqsRZw52J4nONTj6XGYP6ZmlZv23DLD9hZFz/pfTJKWbKiQkQKxd+zpK5yh
	 xadpWrVCW8xd3CXQRtJCyHSG9Wb5+++kcpvpQsxhTjEkRxa+up+3hXdVH9mjTpEOET
	 diMBUwMtMK7vXldPJpNC/ocEnbYtZs9ZeMFzn0/ZdLgrk2CCDk8RZDa3VhndF4ID2E
	 LphOj+rVTVYRFAelnQ2bcjDf603J99RcvSRcliVeA2UOeBUGtr9ny+iDMcEFt4qIGy
	 uGlTPFgU/WpYw==
Message-ID: <b5c2053c-f911-4e0d-8589-4d969bd580a4@kernel.org>
Date: Wed, 11 Mar 2026 20:04:58 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] RDMA/nldev: Add dellink function pointer
Content-Language: en-US
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, zyjzyj2000@gmail.com, shuah@kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260310020519.101415-1-yanjun.zhu@linux.dev>
 <20260310020519.101415-2-yanjun.zhu@linux.dev>
 <20260310190140.GL12611@unreal>
 <5700c718-d10e-4b23-adfc-c14ee1930b18@linux.dev>
 <20260311085434.GW12611@unreal>
 <6a8b0983-a198-470a-8125-b0133ccb7032@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <6a8b0983-a198-470a-8125-b0133ccb7032@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,gmail.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18054-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13D4826C139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/11/26 4:01 PM, Yanjun.Zhu wrote:

> Got it. The commit log explains how the netdev_notifier mechanism is

netdev notifiers are the NETDEV_UNREGISTER and friends. This dellink
handler is not related to that; this is an IB stack thing when the rxe
link is removed.

> used to clean up the related resources.
> 
> In the source code, additional comments have been added to explain how
> the dellink operation for rxe is triggered. For iWARP, this change
> should not make any difference because iWARP does not implement the
> dellink function.
> 
> The commit is shown below. Please take a look and share your comments.
> If you agree, I will send out the latest commits out very soon.
> 
> From c05038dcdf69c5985837736a8926ba76d9f3e8e4 Mon Sep 17 00:00:00 2001
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> Date: Fri, 23 Sep 2022 16:52:45 +0000
> Subject: [PATCH 1/1] RDMA/nldev: Add dellink function pointer
> 
> The newlink function pointer was previously added to support
> dynamic RDMA link creation. In the RXE driver, this path creates
> a transport socket listening on port 4791. Consequently, a dellink
> function pointer is required to ensure these sockets are properly
> closed when a user administratively removes a link via rdma link
> delete <dev>.
> 
> Furthermore, RXE does not rely solely on this nldev path for resource
> management. It also monitors the underlying net_device state via a
> registered netdev_notifier. The rxe_net_event callback serves as a
> fallback mechanism to ensure that transport sockets are forcibly closed
> and all resources are released even if dellink is not explicitly called
> (e.g., if the parent NIC interface is removed or the driver is forcefully
> unloaded).

IMHO, this explanation belongs in the patch that implements dellink for rxe.

This patch adds the handler to allow link implementations to cleanup any
resources created by newklink as needed.


