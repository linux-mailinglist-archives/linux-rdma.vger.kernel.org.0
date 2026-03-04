Return-Path: <linux-rdma+bounces-17498-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEFmBx2IqGn2vQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17498-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 20:29:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E9020712B
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 20:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B47830104B5
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 19:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AD83DBD4C;
	Wed,  4 Mar 2026 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tw3McEQ9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97A727E049
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652570; cv=none; b=eVm5KijAkUIX6u9L7KHI66r11M4n4roapUhHkLBYjTidC8BJ6VTzulQl6myUSZ+L5TlDasUJjBMNZvxuLc9f+PC9LK28zp9iJk/holzreN0Nc4JUqnaZmvH0sw3/XlwTlMhNjhCx+ScyO12abWFLdgZT93tnJuxdCwcu1pRwt8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652570; c=relaxed/simple;
	bh=x+0a22cHFKVC7NrvpWlmeT7TYuEH3j/mSLjSZtuZIPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DLaAjRnXG/+DhdsdqKo0GhdcUzKUMAZxq/t6NSHBeStIXqQjviTukWGUMjGH/TkPE41W3UDOaUYv2PfzEAulpY2wbfiHvde6PyGjmP6YKrEO7t+eVum2aQparRcPCJRE8kjsiWgOYBvLfwhIi8vb0ekDeVPycAnctJ5766JfFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tw3McEQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F17AC4CEF7;
	Wed,  4 Mar 2026 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772652569;
	bh=x+0a22cHFKVC7NrvpWlmeT7TYuEH3j/mSLjSZtuZIPM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tw3McEQ9LfwrHgyZpZ962duQPT0OpEY77xXNUVak6u8B8WoE2qQWuCuPjV5ed1nCk
	 lhOaJ57pmciMkEYmR5XJwG5SqUgAlbrhp0giw6fNRm4QfrcShmhsZIzS5vtwyQpfgT
	 6MN+ITOpt7+18s4qeHI+9WJjc3Uv8Rhmr162DmwupDx5YXy5T6IregVM5EkMLLVg3V
	 UABcXC4qCK7/fz7QH8Jswv+2T/WFNMkw7QVQtX+Ih+naIsh9PGijc9humFmeBQXXKu
	 xTbExnJ87qAYGGHRPtEW8hpcTk2Xv/nh5+R8MvrKY4mMxUxYWgM+mXbbYJ6gnBk3l2
	 Fp23YZjLwxLGw==
Message-ID: <c8170bb8-d031-4e43-86dd-633cc1269fcb@kernel.org>
Date: Wed, 4 Mar 2026 12:29:28 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Add the support that rxe can work in net
 namespace
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20260304041607.11685-1-yanjun.zhu@linux.dev>
 <28be84a9-ad21-4a29-8199-a155e63e4cd8@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <28be84a9-ad21-4a29-8199-a155e63e4cd8@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 85E9020712B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17498-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/3/26 9:44 PM, Zhu Yanjun wrote:
> The script in the link
> https://github.com/zhuyj/linux/blob/6.19-net-namespace/net_ns_rxe.sh can
> make tests in linux distributions.

I have not read the patch, but I did look at the test script referenced
here. Comments

1. drop the sleeps. They should never be needed. If you need to wait for
some resource, then wait for that resource explicitly with a timeout.

2. tests should cover the range of features in the patch meaning IPv6,
and if you keep the attempts to delete the socket after the rxe devices
are deleted, then tests should include variations of this theme. e.g.,
per network namespace:

a. no devices = no socket

b. 1 device, sockets work, delete device, no socket

c. 2 devices, sockets work, delete 1 device, socket still works, delete
second device, no socket.

3. the script can be added to tools/testing/selftests/{infiniband,rdma}
-- whatever directory seems most appropriate. Adding it here and fitting
within kernel selftests means it can be run by CI as commits are done.

> 
> BTW, please disable firewall before making tests.

That should not be needed. The test script should be internal to a host
using only namespaces you control and configure.


