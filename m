Return-Path: <linux-rdma+bounces-17809-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FL3GaIXr2kiNwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17809-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 19:55:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D169223EE9B
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 19:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E53E301C95B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 18:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE38F3EDAA8;
	Mon,  9 Mar 2026 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHc562fV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB83ED5BA;
	Mon,  9 Mar 2026 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082505; cv=none; b=t3oM8BKlJDgwzwJgCGl7AxRSK2qVKQ3E8Nc13LPlaLaH4D/LoGbGUtZX2Wc7rKjHzx5Fk/MWcpwO9L15oSa5ei8sB2zaG1w0v5M61q8yblLhUZixHITzcNaWiJpAZiCiNm4aSoyeKjXSAjqQgxjuz7CeYeTB9V/flq0uVqinqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082505; c=relaxed/simple;
	bh=iA52zluXRWMpXdOK4ruJ3MkjDHyulqqdVTyLLan3BPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f2zPwDyxvOX+StXkduvxHvFGF3VvkI530B6NBneSTwVkb40j1aYg5TsdmCqeWy/kks7UCeStzRzJ2Lx3TSge/z43z+pVYp6urGOJ1Fj9tTdIZItQCG3JV47e6OAQ572CXEG69osQM4a67OeOAjzynaUjIvJ3U3AlDCP8dU618wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHc562fV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37029C4CEF7;
	Mon,  9 Mar 2026 18:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773082505;
	bh=iA52zluXRWMpXdOK4ruJ3MkjDHyulqqdVTyLLan3BPM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aHc562fVI3KEQp6nFoV+dchqZTkAUQm1VAp7KeNgcrHlasIw/yW4y0Q5T6QjcVW01
	 B+w4E2sXqW8H21uEtFG7OWt3MKrnjjaoySjGvkd76blwwOK+Xax1IGCJaXwiT7pZ6l
	 F9HJlhiyVnEiw6yJVFbc4KmGGd0hkI2Xli+aS2i1wUCSxIC0+6Oj9qe73wVM5hGqpy
	 BMi4ivGeLV2WaG0Eouf/c8+aLvHx/YHLAr9Kk8ZXLRI65H3skWZGbFcrgPM+zm6DCe
	 mgLrKKQowa+S/WUMJYatE3eWaQ9qvdUDQLt3I7UUhY2NfdzJQIry7JPMhtfcPnjCL2
	 HWionBGFUfa3g==
Message-ID: <83f6ede0-f65e-41a5-8c79-2d0d96cbff5e@kernel.org>
Date: Mon, 9 Mar 2026 12:55:05 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] RDMA/rxe: Add the support that rxe can work in net
 namespace
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260308233540.13382-1-yanjun.zhu@linux.dev>
 <45947149-36ef-41f2-8ad0-aa3519344ce0@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <45947149-36ef-41f2-8ad0-aa3519344ce0@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D169223EE9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17809-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,rxe_socket_with_netns.sh:url,rxe_ipv6.sh:url,rxe_rping_between_netns.sh:url,rxe_test_netdev_unregister.sh:url]
X-Rspamd-Action: no action

On 3/8/26 5:40 PM, Zhu Yanjun wrote:
> # make -C tools/testing/selftests/ TARGETS=rdma run_tests
> make: Entering directory '/root/Development/linux/tools/testing/selftests'
> make[1]: Nothing to be done for 'all'.
> TAP version 13
> 1..4
> # timeout set to 45
> # selftests: rdma: rxe_rping_between_netns.sh
> # server DISCONNECT EVENT...
> # wait for RDMA_READ_ADV state 10
> ok 1 selftests: rdma: rxe_rping_between_netns.sh
> # timeout set to 45
> # selftests: rdma: rxe_ipv6.sh
> ok 2 selftests: rdma: rxe_ipv6.sh
> # timeout set to 45
> # selftests: rdma: rxe_socket_with_netns.sh
> ok 3 selftests: rdma: rxe_socket_with_netns.sh
> # timeout set to 45
> # selftests: rdma: rxe_test_NETDEV_UNREGISTER.sh
> ok 4 selftests: rdma: rxe_test_NETDEV_UNREGISTER.sh
> make: Leaving directory '/root/Development/linux/tools/testing/selftests'
> "
> 

Just put that in the cover letter; no need for followup emails to the set.

