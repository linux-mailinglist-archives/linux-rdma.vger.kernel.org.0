Return-Path: <linux-rdma+bounces-20698-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP1lLljXBWqacAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20698-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:08:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3269E542C78
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AABCB3062DB3
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9599C3F211E;
	Thu, 14 May 2026 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3PT/VTo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570B23E51CA;
	Thu, 14 May 2026 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767100; cv=none; b=TXbstj9TZEZ9y687R9W7V1s7WvxrQ+zDvBhPAfr34nc1jBWBBuQpHg4U69IyJtxthDE4RjPwFijD+i9Tz5ZG+VBPhTIE9D964rM+v3WrHZFLnWB2IlmEpnlxM4iFKKy9QtiTQ/jxvdL63ND75nDbyvD2J5Z5Pzpplrmo7Hbwwrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767100; c=relaxed/simple;
	bh=8oyZ/VO926g2lRdJgN02SOY8dwZhWLcwWuq6M6cDJys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bamvvoedCRnos97VydtbiyYf6sXgBgT508LlYaxPxlCRFWS2XgPaxq+OiFz1k4HaHLI02Is3xjNfrnfc4meHVjVPp6gOuOxaStdnxA8czuRQEIKhoiQDxRV8WqnYDS05Qxn/AhdDMHRwC35d9/sF1Mo8D1IK2ddLxAyJBKi2LIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3PT/VTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519A7C2BCB3;
	Thu, 14 May 2026 13:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767100;
	bh=8oyZ/VO926g2lRdJgN02SOY8dwZhWLcwWuq6M6cDJys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i3PT/VTo3H2Z40TYgAHf60r2KXNlFgPxv0dhTjhOCRCQd/PwGsvt3q74nemk9NVEk
	 wJ8eJD9ByWD1LYssmiR7hD+XQfyKjLGCuJ8Un7xZwksNXr8rD9gaqmneDpSpotsVp5
	 vGc9Vxa+sDcj0uGhcW41A8fFJ0+j5/igO6RoSPus1Iw+7yZqlTgyiFrKVJKfo6vOrv
	 yTKSoTuayFud6LihcH/hOxTAjvk75d+rrFSQrrrAekQOSzjnUzLnKzIE/aww5/3Ueu
	 6jBGK6pczhWtewfVZg31/zKrK6h0oUkGrYlaTAF+/LeWSHYnwQ3Cr0251HdrZ4JziT
	 7hv00CF4h6XsA==
Message-ID: <139794f1-80b8-49d9-829a-0629379def51@kernel.org>
Date: Thu, 14 May 2026 07:58:18 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/nldev: add mutual exclusion in nldev_dellink()
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Edward Adam Davis <eadavis@qq.com>
Cc: akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net,
 edumazet@google.com, hdanton@sina.com, horms@kernel.org, kuba@kernel.org,
 kuniyu@google.com, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
References: <20260513234655.GW7702@ziepe.ca>
 <tencent_3CCD70788A6EAC2D356D4C9674E8D2EEEA0A@qq.com>
 <20260514115048.GX7702@ziepe.ca>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260514115048.GX7702@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3269E542C78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20698-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,qq.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,google.com,sina.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com,linux.dev,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/14/26 5:50 AM, Jason Gunthorpe wrote:
> On Thu, May 14, 2026 at 03:31:22PM +0800, Edward Adam Davis wrote:
>> On Wed, 13 May 2026 20:46:55 -0300, Jason Gunthorpe wrote:
>>> On Wed, May 13, 2026 at 02:17:28PM -0400, Leon Romanovsky wrote:
>>>>
>>>> On Thu, 07 May 2026 20:50:10 +0800, Edward Adam Davis wrote:
>>>>> We must serialize calls to nldev_dellink() or risk a crash as syzbot
>>>>> reported:
>>>>>
>>>>> Call Trace:
>>>>>  udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
>>>>>  rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
>>>>>  rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
>>>>>  rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
>>>>>  rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
>>>>>
>>>>> [...]
>>>>
>>>> Applied, thanks!
>>>>
>>>> [1/1] RDMA/nldev: add mutual exclusion in nldev_dellink()
>>>>       https://git.kernel.org/rdma/rdma/c/0b28000b64f40d
>>>
>>> This seems like a rxe bug, I would have expected the lock to be inside
>>> rxe to protect its racy implementation of rxe_net_del(), which looks
>>> like it is possibly also triggered by NETDEV_UNREGISTER...
>> No, it was triggered by RDMA_NLDEV_CMD_DELLINK, you can see the "call trace".

Not that Jason's point. Code wise

rxe_dellink -> rxe_net_del

netdev NETDEV_UNREGISTER:
 rxe_notify -> rxe_net_del

both can lead to the same problem

>>>
>>> ie it should not change nldev_dellink().
>> While this could be fixed within RXE, the same issue affects all other
>> RXE-like submodules when they subsequently support the "dellink" interface,
>> therefore, handling this within nldev_dellink() is relatively more appropriate.
> 
> Why would other modules have an issue? The problem is rxe's racey
> refcounting scheme for its lazy socket creation. There is nothing
> wrong with nldev, and now you've created some nasty BKL in the nldev
> code to fix rxe while ignoring its other races.

+1


