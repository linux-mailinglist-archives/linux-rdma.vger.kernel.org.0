Return-Path: <linux-rdma+bounces-17558-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEJCOlzSqWmYFgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17558-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 19:58:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE332172D9
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 19:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FDD0304DC83
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80A52E266C;
	Thu,  5 Mar 2026 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGWGdYaQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAC62DC359
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772737112; cv=none; b=KXzfeRKrarIZMSQNNLQtIKHd258CsA3CC/eh0MogvjcrQ2WyJ9m1zJXdMtMHTViPKCyvL4z31WyVkVHzfdXy4q2toZg6yGyo1Rx/VfsYQUseKCqOdbMAurtTLpaIpuYXFhFW++iw7aHrgLw3hYRQjMDm0G1U2JshgYDD2SfRgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772737112; c=relaxed/simple;
	bh=zzPJH7id9WWOj/c/q3YN2BofLZ/V2jUF5Ry/m6yXWjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pYeKWmirvMYFUaMhIT5o+7KDMXl/Cijaom0smay38eESZJc8Lvo5ThphefiU4ABtdHLheDogHTBf3IbvCcVUIOwbmSvnH8WuUv4K/wV8ylWrbg/v7uTRsJoT90SG9/Haox1ZWTZhgK0BgFOCsNx0XltpK1yD56f7JtmNAZs2oMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGWGdYaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F53C116C6;
	Thu,  5 Mar 2026 18:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772737112;
	bh=zzPJH7id9WWOj/c/q3YN2BofLZ/V2jUF5Ry/m6yXWjA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=JGWGdYaQMhi8iVBAnKJDhgpXQlFiEpry/iOSNYtWQOoe5PFCAZ1cI2DJvnqb12j1F
	 P2eVf7XNJudh05qulDTBUEDGZLoAyydJzvlrG30D7ki0h6hG1gwVi8HNaf4p/t8BG/
	 NogEA1Ltawgmz97ywRKxKhQ6H/IzFwIhv1aYnlmbJuoxHkJz2zFkE99fq6/eLvKqxz
	 GgirauDz/djoB5G081DSWTx4jIMm6ktBz69VkIlJbfdFCdIgWbgPosgin0ewsRPhrV
	 zSvSxbyoO5/782F9icAYVq/FN6NnsJinv71/2uxOg8Pqt6wXryrqMvFR9MFk7gYwvu
	 +h4XlTo0XYAPg==
Message-ID: <915d650f-ca19-4cd0-8d1a-74fa6a045528@kernel.org>
Date: Thu, 5 Mar 2026 11:58:31 -0700
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
 <c8170bb8-d031-4e43-86dd-633cc1269fcb@kernel.org>
 <f576b139-cf1c-423f-a8cd-f51c23f7e18d@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <f576b139-cf1c-423f-a8cd-f51c23f7e18d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4EE332172D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17558-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/4/26 8:29 PM, Zhu Yanjun wrote:
> The script has been added to tools/testing/selftests/rdma. The commit is
> 
> https://github.com/zhuyj/linux/commit/0fa99629c1a656592b7b2011dc5cad16de2320fd
> 
> It can be tested by running:
> 
> make -C tools/testing/selftests TARGETS=rdma run_tests
> 
> Please let me know if there are any additional concerns or suggestions.
> 


Thanks for the enhancements to the testing.

Progress and success / fail on what has been tested at each step would
improve the user experience. See any number of test scripts under
tools/testing/selftests/net/ from me - e.g.,
tools/testing/selftests/net/fib_nexthops.sh walks through permutations
of an API, tools/testing/selftests/net/icmp_redirect.sh is a much
simpler example.


