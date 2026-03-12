Return-Path: <linux-rdma+bounces-18065-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4+uVNsgysmkuJgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18065-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 04:28:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F05B026CC77
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 04:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5F71304925C
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 03:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E30376BE8;
	Thu, 12 Mar 2026 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MJHaDuDZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754B32B98A
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773286084; cv=none; b=ipRMG5CHhJEhXX8RuB/hKmA66Tm12VKHRXbD9xf71HwonprTGtYYzkIPNVN7iVGu5AqcTWQwD2JcwvO0Q5wX4OSYrQo1zj+FtinEos7P+dF7/Wh4eCDjLbfpJbBiNeLV5OSbav09UNkbCctP1ZC2wKriUsbXM+tjnzE55l/quEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773286084; c=relaxed/simple;
	bh=8go2IFq4rIEAN9M5SBSAkfUlbNjCnuvntdlcINAZArY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UoJgyrmH16lUKUiQZxew53L0NdEOn9lkxG2TcTeibbiONZPrxe4khYU0qLPscF+coWfjSZ6ENKrfe3yEvAFEmvtcwzIMWkEqONrhz9OICJLjm0TELshmRDSN7YNpx2LTMimiyDfioVDR/NHIEDxh+F9GqLbGBmaS1ApZjJy/6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MJHaDuDZ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7762c04a-e28c-4b29-af24-18550391f699@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773286080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2SyG3QplUVb9nRJgkTAarwyWE9+/9zbBg+z/sU96iE=;
	b=MJHaDuDZya55VDVFeNiZKEBGCspS3uviutCSigEAMTp79Vagsd4pLHTM8CH/z5VZcH7tgO
	mqnU/FXe/9IrZGWXbG8+4fqgw3DQFMbPdWYBhqp0tDLxBKuUbRi1iiyen2gmGE1bg/WvX/
	0Lof6tmjNFz6+zfipqo5qZt5ac5lQXw=
Date: Thu, 12 Mar 2026 11:27:46 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net,v4] net/smc: fix NULL dereference and UAF in
 smc_tcp_syn_recv_sock()
To: Jakub Kicinski <kuba@kernel.org>
Cc: jiayuan.chen@shopee.com, mjambigi@linux.ibm.com, wenjia@linux.ibm.com,
 horms@kernel.org, sidraya@linux.ibm.com, guwen@linux.alibaba.com,
 davem@davemloft.net, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, dust.li@linux.alibaba.com,
 syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com, pabeni@redhat.com,
 tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org, edumazet@google.com,
 alibuda@linux.alibaba.com
References: <20260311022451.395802-1-jiayuan.chen@linux.dev>
 <20260312030520.626362-1-kuba@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260312030520.626362-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18065-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F05B026CC77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the review.


On 3/12/26 11:05 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
>
> This patch fixes a race condition in smc_tcp_syn_recv_sock() where
> sk_user_data can be nullified or the smc_sock can be freed during
> concurrent socket closure, using RCU and refcount_inc_not_zero() for
> safe access.
>
> Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GAE@google.com/T/
>
>> The race window looks like this:
>>
>>    CPU A (softirq)              CPU B (process ctx)
>>
>>    tcp_v4_rcv()
>>      TCP_NEW_SYN_RECV:
>>      sk = req->rsk_listener
>>      sock_hold(sk)
>>      /* No lock on listener */
>>                                 smc_close_active():
>>                                   write_lock_bh(cb_lock)
>>                                   sk_user_data = NULL
>>                                   write_unlock_bh(cb_lock)
>>                                   ...
>>                                   smc_clcsock_release()
>>                                   sock_put(smc->sk) x2
>>                                     -> smc_sock freed!
>>      tcp_check_req()
>>        smc_tcp_syn_recv_sock():
>>          smc = user_data(sk)
>>            -> NULL or dangling
>>          smc->queued_smc_hs
>>            -> crash!
> The race diagram describes the tcp_check_req() path (TCP_NEW_SYN_RECV
> handling), but the actual syzbot crash occurred through a different path.
> Looking at the syzbot stacktrace, the crash shows:
>
> smc_tcp_syn_recv_sock+0xa7/0x4b0 called from tcp_get_cookie_sock+0xd5/0x790
>
> This is the SYN cookie path:
>
> tcp_v4_rcv() -> tcp_v4_do_rcv() -> tcp_v4_cookie_check() ->
> cookie_v4_check() -> tcp_get_cookie_sock() -> smc_tcp_syn_recv_sock()
>
> The syzbot log even shows 'Possible SYN flooding on port [::]:20002.
> Sending cookies.' confirming syncookies were active. Both paths are
> vulnerable to the race, but the race diagram doesn't match the actual
> crash path that the fuzzer triggered.
>
> Would it be more accurate to note that both paths (tcp_check_req for
> normal SYN handling and tcp_get_cookie_sock for SYN cookies) can trigger
> the race?


For the first point about the call stack: both the tcp_check_req() path 
(normal SYN handling)
and the tcp_get_cookie_sock() path (SYN cookies) call syn_recv_sock() 
without holding the
listener lock, so the race condition is the same. The diagram uses 
tcp_check_req() as an
example because I have reproduced it under my env, but the fix covers 
both paths.

>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -131,7 +131,13 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>>   	struct smc_sock *smc;
>>   	struct sock *child;
>>
>> -	smc = smc_clcsock_user_data(sk);
>> +	rcu_read_lock();
>> +	smc = smc_clcsock_user_data_rcu(sk);
>> +	if (!smc || !refcount_inc_not_zero(&smc->sk.sk_refcnt)) {
>> +		rcu_read_unlock();
>> +		return NULL;
> When smc_tcp_syn_recv_sock() is called from the SYN cookie path
> (tcp_get_cookie_sock() in net/ipv4/syncookies.c:205 and
> net/ipv6/syncookies.c:275), the dst parameter is non-NULL.
>
> The new early return here returns NULL without calling dst_release(dst).
> The syn_recv_sock contract requires the callee to either consume dst
> (attach to child socket on success) or release it (call dst_release on
> failure).
>
> Looking at tcp_get_cookie_sock() in net/ipv4/syncookies.c:
>
>      child = af_ops->syn_recv_sock(..., &dst, ...)
>      if (!child) {
>          reqsk_free(req);
>          return NULL;
>      }
>
> When syn_recv_sock returns NULL, tcp_get_cookie_sock immediately returns
> NULL without releasing dst, expecting the syn_recv_sock callee to have
> already handled it.
>
> The existing 'drop:' label at line 165 correctly calls dst_release(dst),
> but the new early return at line 138 bypasses it. This causes a dst_entry
> reference count leak under SYN flood conditions on an SMC listener.
>
> Should this be: goto drop instead of return NULL, or should dst_release(dst)
> be added before the return NULL?



The second point about the dst leak is valid. Will fix in v3.


