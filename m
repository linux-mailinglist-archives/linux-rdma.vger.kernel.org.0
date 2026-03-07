Return-Path: <linux-rdma+bounces-17645-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ+WMv56q2kSdgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17645-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 02:10:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1366F229426
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 02:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB993300A241
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 01:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4B3276049;
	Sat,  7 Mar 2026 01:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXvQ+vmV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E37C27BF6C;
	Sat,  7 Mar 2026 01:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845817; cv=none; b=fD6YPQeIEVE/7otAerxW8XavL3P7OEE1jZfmnKymFTLNPFefT8HrfzQwg8YFsy5VUHAvAUxUYHHkl82vtwqfyeOWVVgnMhYPkq8DsSwCLDz0ycZRGw1TvCjxFXs5bB5UQhlcArhf3gz3B6lT7a0YPsBFrnp83BB1c3wSg+ixYB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845817; c=relaxed/simple;
	bh=R68DNntYLFN6s8j3GiH5+I7lrC33xnx3Srtl1F6k2Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aF1G1XacMvEDf+OuZeB4BWfMeviYrG3JOh7R3Qp+S2qEZIEDFFJG4cf+EqJgsqjvdmMpaZM+Jepa8u3UVKO00agDkUUDZNa6pfbDPq38G2uUe/j8eczD1adAcY9kgGiMEM5NIW55fuqKmOVrhK8ndlk6lwAj2pir0yeP3TxL34o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXvQ+vmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5819C4CEF7;
	Sat,  7 Mar 2026 01:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772845817;
	bh=R68DNntYLFN6s8j3GiH5+I7lrC33xnx3Srtl1F6k2Lw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tXvQ+vmVxr/gYIfGk/ToN63bzIh4f+QIx8ppjVATKN3Ez2vpeefHSCi+5lorDmsOZ
	 OqbZ2t90a0EVg9mW1PKtQWvv8+4WbNuWHMrVIRRtXC8sCh2f3t0kjSAUQaabkwYiRU
	 hjdxucO1qd9JOj4J3Qd6GrtTsfOraJIF5eXDJ4wUO4X0Pb3nIRPGvsRWDbztgyaYaT
	 Ew2OGR8BINq5jycZd5tzhcqkrUKzpLkbLXbcHvEtOGR+CUh85co3vho/8FTBu+cM1P
	 EnGT9DpXR+OJM3xfTt3R/jD9mMeAyTpBkX1zUOMQVht/2Yi/NMuIYnuQWZjVhs8bxj
	 DpFnH5yK18A8A==
Message-ID: <629cb649-5e0d-43dd-8dd2-b48bd880ddcd@kernel.org>
Date: Fri, 6 Mar 2026 18:10:15 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] RDMA/rxe: Add testcase for net namespace rxe
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260306082452.1822-1-yanjun.zhu@linux.dev>
 <20260306082452.1822-2-yanjun.zhu@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260306082452.1822-2-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1366F229426
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17645-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.942];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email]
X-Rspamd-Action: no action

On 3/6/26 1:24 AM, Zhu Yanjun wrote:
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  MAINTAINERS                                   |  1 +
>  tools/testing/selftests/Makefile              |  1 +
>  tools/testing/selftests/rdma/Makefile         |  5 ++
>  tools/testing/selftests/rdma/config           |  3 +
>  .../selftests/rdma/rping_between_netns.sh     | 57 +++++++++++++++++
>  tools/testing/selftests/rdma/rxe_ipv6.sh      | 47 ++++++++++++++
>  .../testing/selftests/rdma/socket_with_rxe.sh | 64 +++++++++++++++++++
>  7 files changed, 178 insertions(+)
>  create mode 100644 tools/testing/selftests/rdma/Makefile
>  create mode 100644 tools/testing/selftests/rdma/config
>  create mode 100755 tools/testing/selftests/rdma/rping_between_netns.sh
>  create mode 100755 tools/testing/selftests/rdma/rxe_ipv6.sh
>  create mode 100755 tools/testing/selftests/rdma/socket_with_rxe.sh
> 

Test patch should be last since it relies on the next 3 patches to work.


