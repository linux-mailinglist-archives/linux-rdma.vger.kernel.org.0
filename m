Return-Path: <linux-rdma+bounces-20158-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM5JCSWU/Gn3RQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20158-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 15:31:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE1C4E9481
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 15:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 550E2303FAC4
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34B73FA5CD;
	Thu,  7 May 2026 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iA0O7bKl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE0303A32
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160403; cv=none; b=Paf1/TlQI40iLiV9EVdRFLC0wEPvqFj7x7cFiOiTYdWn7hzY+vcqLMBYWxhELqT3JCWCyBuhdvB8EBy3piBaiGpfpMWKaZdh7oRdpsuxjmXW482nKzwInZmbGjNonE8N206j0378L8qN+UDUJjkuyR8gBF4B40Sy9RU62Av10Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160403; c=relaxed/simple;
	bh=teBo4pWM6ORgn7mwTyHWhxDt88H/ovpdKT1vaScnHxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8jl+E5XXx+KDLIbAvMdmYss8haLpXe54Gpn9a3ZxfmErbF0czZCpt3t47GQyaNqRya7EyueQkQzJmXtbyHapHDGCrn1J3kSurskqLqJqmaeQuPpKTLvV0/zcd3Faos/NNEQ9O7BCkletjR3u3u04VaYClIdRBG0TjNY7SQU2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iA0O7bKl; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c4264e6-2e93-4121-a8ec-5ac20e5cc213@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778160387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3RRKyrlA+EuBul+O3/If9p20xxaCg6XI4XR6i54fFc=;
	b=iA0O7bKl+FP2PWd51Zg1ARCqLwIR+59jHRVDFUExTqLUtLF1cYEQDq21HFi2WZ/5NoS5v+
	pdfk9TxEFAtBY0+dhDGVCmo5airOE2zt0MIXCYpoWxh5JOy8iF4rlUodhnmdREJIMxjfLE
	0c7PQar4E3t4SybRk0+jksdLw14w5n4=
Date: Thu, 7 May 2026 06:25:54 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/nldev: add mutual exclusion in nldev_dellink()
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, hdanton@sina.com, horms@kernel.org,
 jgg@ziepe.ca, kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com,
 leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
 zyjzyj2000@gmail.com
References: <69fc0c7c.a00a0220.387fc1.0006.GAE@google.com>
 <tencent_611BEB4B141B1A2526BAA3BBB2335F9E9108@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <tencent_611BEB4B141B1A2526BAA3BBB2335F9E9108@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 7CE1C4E9481
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20158-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[qq.com,syzkaller.appspotmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,ziepe.ca,gmail.com,vger.kernel.org,redhat.com,googlegroups.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,linux.dev:mid,linux.dev:dkim,qq.com:email]
X-Rspamd-Action: no action


在 2026/5/7 5:50, Edward Adam Davis 写道:
> We must serialize calls to nldev_dellink() or risk a crash as syzbot
> reported:
>
> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> Call Trace:
>   udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
>   rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
>   rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
>   rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
>   rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
>   
> Fixes: a60e3f3d6fba ("RDMA/nldev: Add dellink function pointer")
> Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
> Tested-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Thanks a lot. This looks like a good solution. Since the issue is 
reproducible,

have you sent this commit to syzbot for verification?

Thanks,

Zhu Yanjun

> ---
>   drivers/infiniband/core/nldev.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 96c745d5bac4..3cb3cb7629fe 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -1816,6 +1816,8 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   	return err;
>   }
>   
> +static DEFINE_MUTEX(nldev_dellink_mutex);
> +
>   static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   			  struct netlink_ext_ack *extack)
>   {
> @@ -1846,7 +1848,9 @@ static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   	 * implicitly scoped to the driver supporting dynamic link deletion like RXE.
>   	 */
>   	if (device->link_ops && device->link_ops->dellink) {
> +		mutex_lock(&nldev_dellink_mutex);
>   		err = device->link_ops->dellink(device);
> +		mutex_unlock(&nldev_dellink_mutex);
>   		if (err)
>   			return err;
>   	}

-- 
Best Regards,
Yanjun.Zhu


