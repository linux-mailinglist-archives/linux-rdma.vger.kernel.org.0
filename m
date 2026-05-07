Return-Path: <linux-rdma+bounces-20161-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHgCIQyf/GkMSAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20161-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 16:17:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CDF4E9FA6
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 16:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8A743097EAF
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 14:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FC33FCB07;
	Thu,  7 May 2026 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O6hBsj6g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E83FB7D9;
	Thu,  7 May 2026 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163140; cv=none; b=eSNBU7vbGkzhNh4qo2g6K3Q8ZcrWCQ0E4Bej4+vOFm00sKYjgWNiNulHfrOcMBh1v37ljxRK4RiflZtre5bJVFto1rAUZwnX8AKW28E0keQCFfScyv4S3xOMaZlFPu299s0mcF+3WBMLU/yK8TrJvfSYmKSDpFSyKfUbJa6swHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163140; c=relaxed/simple;
	bh=IfPdZLxkx4Se/6l+tDdfRRRtJTUpSWKEiidzy0SmIDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfechpPhbo2Jiu/0bf+1AwiVECskfylrp124Y4iz0Fi9u51rrJ3BpNNbt5tUhXN3WwiSJZdJ2HygBqAJcAQ99QqrU4rkAtZigB/B64bV2hwmI74snQU8P2kaPD9LHptjKCQ+OhvbaCLOIlkxUuMcPWlZVZ5w5cDSPxX73BlRURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O6hBsj6g; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7688543c-b2c3-477c-b894-643995af08bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778163127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JE0MIr1dxYT1PjuTUSJgptucJ/9w1unHy1nCM1mXmt0=;
	b=O6hBsj6g0S5ocjN2nip6oPyTTlQl5P2zLsr2Xg41JzHb+sfWatttJqPI0eqEDmjPXSeQ+i
	tqa5JthzG8eNbe9OLX5oDhMq3xH243sB0tJ3FIexw2H4UQxsBtzoEkS+5BTTMV/kobqxUj
	OXnqXNmMAMLadmqPHKDkTYIGCayGRlg=
Date: Thu, 7 May 2026 07:11:38 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/nldev: add mutual exclusion in nldev_dellink()
To: Edward Adam Davis <eadavis@qq.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, hdanton@sina.com, horms@kernel.org,
 jgg@ziepe.ca, kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com,
 leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com
References: <3c4264e6-2e93-4121-a8ec-5ac20e5cc213@linux.dev>
 <tencent_D175A964A3A32452D77DB76B66C2B3730305@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <tencent_D175A964A3A32452D77DB76B66C2B3730305@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D1CDF4E9FA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20161-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[qq.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,ziepe.ca,gmail.com,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action


在 2026/5/7 6:40, Edward Adam Davis 写道:
> On Thu, 7 May 2026 06:25:54 -0700, Zhu Yanjun wrote:
>>> We must serialize calls to nldev_dellink() or risk a crash as syzbot
>>> reported:
>>>
>>> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
>>> Call Trace:
>>>    udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
>>>    rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
>>>    rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
>>>    rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
>>>    rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
>>>
>>> Fixes: a60e3f3d6fba ("RDMA/nldev: Add dellink function pointer")
>>> Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
>>> Tested-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
>>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>> Thanks a lot. This looks like a good solution. Since the issue is
>> reproducible,
>>
>> have you sent this commit to syzbot for verification?
> The patch has been verified by syzbot.

Thanks a lot.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>
> BR,
> Edward
>
-- 
Best Regards,
Yanjun.Zhu


