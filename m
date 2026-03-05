Return-Path: <linux-rdma+bounces-17563-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOjbBdIUqmnFKgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17563-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 00:42:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BFB2196DD
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 00:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2496E300C57C
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 23:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3A5368282;
	Thu,  5 Mar 2026 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eieDWPdC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E584736654D
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772754115; cv=none; b=X5sy7TL0kirIGgyWGpDeW7d8Jo6VXf3oYsn0BmZRcXUwwkQJkmmjVl6l2xza/5eH/g0jz05oAmnwQcZz+XuA9Dvqr55cQhyy2IScN7i+7nE9cyDJJSyzOcvC8gVsEqM50dqticDD3GoXynMTg/lRDrDycF/P5Z1U2FGqdSKgeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772754115; c=relaxed/simple;
	bh=GU+b2XBroKc7ZBRTnLsSfRWgZcKEBpMwgYQS6Md3cR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SKwoNfp7VpGWFduJWkXrFl2xgkACyu5w6V9NCuGqGw7Bffg30z+0iPRC/mrWbmDyrTluibKSC8Z9wKreJeWXbjFVA8fs9nlzfhWMO+Pc2BAUYi8zua7EcGPEb53VntHW2bYDqCK68zfD7vFC8XPpn4UcwL/N8hjqQfGDfG/c93U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eieDWPdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394CDC116C6;
	Thu,  5 Mar 2026 23:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772754114;
	bh=GU+b2XBroKc7ZBRTnLsSfRWgZcKEBpMwgYQS6Md3cR4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=eieDWPdCc00vRzch4Vk0B7gI8ryZtajNM+0PcJpmOvbvfeunNtZQk9E4QjI/9NHUp
	 ug7wb1RxTHnm2SY1zs291jC2i6ivwAmr6IuNlCfnOSFAVUovn97L6I9a+/bvmPG6xC
	 DzIF63t2hPs1tpybktmQ2OitK5ga6ekKY2/4eE+68MbpGC2JGo6nQ8Pv5vMnlEsK2j
	 O2DtK9OPiK3zmcQ+1kkYd3ulQzHrQdjB6KySd83KzRcaLHXagWzUe8jFbvB8Xu/n05
	 UMMGhpSQlF6oG+KpEaL+hEXtmhBwRzfW7gVfzb0/h1roDUdeAYPKAGRYCTRdPhYuJQ
	 Pd37mrjaNbQJw==
Message-ID: <51db4f77-0835-4087-9ec3-ea851885aef9@kernel.org>
Date: Thu, 5 Mar 2026 16:41:53 -0700
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
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20260304041607.11685-1-yanjun.zhu@linux.dev>
 <28be84a9-ad21-4a29-8199-a155e63e4cd8@linux.dev>
 <c8170bb8-d031-4e43-86dd-633cc1269fcb@kernel.org>
 <f576b139-cf1c-423f-a8cd-f51c23f7e18d@linux.dev>
 <915d650f-ca19-4cd0-8d1a-74fa6a045528@kernel.org>
 <ba7d1501-4038-4542-836f-5eb71b806128@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ba7d1501-4038-4542-836f-5eb71b806128@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 04BFB2196DD
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
	TAGGED_FROM(0.00)[bounces-17563-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/5/26 4:15 PM, Yanjun.Zhu wrote:
> I ran the three test cases, and the output is shown above. I would like
> to confirm whether this output format looks appropriate for the RDMA
> selftests.
> 
> If the format is acceptable, I plan to keep it as is and continue
> expanding the RDMA selftests based on this structure.

Having tests is the important piece. I pointed out the existing tests as
a way of making things more user friendly. Simple output, easy to follow
what was tested.

