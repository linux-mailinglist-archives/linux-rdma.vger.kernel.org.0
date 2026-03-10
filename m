Return-Path: <linux-rdma+bounces-17870-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEcWN+UjsGnYgQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17870-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 15:00:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 523E2251293
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 15:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D82D32F61A5
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9DE3DC4AF;
	Tue, 10 Mar 2026 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mE96N4l2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58F3DC4A1
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146322; cv=none; b=uRGG11emUTmi0iKN3Eib4pYAf5lRcfijkHFHPnJQk/yhFcl2K/UtoYy/8Kzz3yckd2GuihkS4cjmwPonP6vqKJS+czpDGadGkLqhDenktrlodMOkVWJwnhsn5BNWojoJcgzmZQnx8TN5SKA4GUXkePoGojbuTNWtApVGUTyCI0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146322; c=relaxed/simple;
	bh=CTpIvISwHm/A71DqOvdlv0hatiRYcvynfbWDp7A7wDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwnOSS3UKb32BsNFhUwhTJm6sV8eBPdgA5Pclg3daTM39LvBdZHzx2mvebdM+zoaKUnKiUBQ4tPtFgdB6+2/+OBkaiVL3thq1anaFiDbYNLguN0bt5HNbo+17ZiY3eRdinfHqKnClLEWBQHP3ZTYWtV0j1ZZa/25zFw57Q9KfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mE96N4l2; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <270e708d-cb52-413c-860e-16945ae98012@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773146309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDizjKfKLjRprs2izCP8nlt9BhCmmNO1wOtyhYNrASw=;
	b=mE96N4l2+SLN8WLkJ+TFSdj/gGYT0r4bavqiVkrIaKOFpw6fh3BqVgYNCOGLaHLdA46nhW
	zO9fO0g0ZztDJp9QtBKNmLzJhvSKECRVukAcO5jqRWZHGsaPkeVUMqo1wpMn5sQamnSdW9
	JX/MXfIuVvfYRSyvTOkguCBW+rgyetE=
Date: Tue, 10 Mar 2026 20:38:10 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] net/smc: fix NULL dereference and UAF in
 smc_tcp_syn_recv_sock()
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com,
 "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260310120053.136594-1-jiayuan.chen@linux.dev>
 <CANn89iK-Kj7Gthff+Q8vSUDTYs9t6YZepm5uAv_2ZZJ4AkyxOw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CANn89iK-Kj7Gthff+Q8vSUDTYs9t6YZepm5uAv_2ZZJ4AkyxOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 523E2251293
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-17870-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On 3/10/26 8:13 PM, Eric Dumazet wrote:
> On Tue, Mar 10, 2026 at 1:01 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>>
>> Syzkaller reported a panic in smc_tcp_syn_recv_sock() [1].
>>
>> smc_tcp_syn_recv_sock() is called in the TCP receive path
>> (softirq) via icsk_af_ops->syn_recv_sock on the clcsock (TCP
>> listening socket). It reads sk_user_data to get the smc_sock
>> pointer. However, when the SMC listen socket is being closed
>> concurrently, smc_close_active() sets clcsock->sk_user_data
>> to NULL under sk_callback_lock, and then the smc_sock itself
>> can be freed via sock_put() in smc_release().
>>
>> This leads to two issues:
>>
>> 1) NULL pointer dereference: sk_user_data is NULL when
>>     accessed.
>> 2) Use-after-free: sk_user_data is read as non-NULL, but the
>>     smc_sock is freed before its fields (e.g., queued_smc_hs,
>>     ori_af_ops) are accessed.
>>
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
>>
>
>
>> diff --git a/net/smc/smc.h b/net/smc/smc.h
>> index 9e6af72784ba..8b3eabcdb542 100644
>> --- a/net/smc/smc.h
>> +++ b/net/smc/smc.h
>> @@ -342,8 +342,7 @@ static inline void smc_init_saved_callbacks(struct smc_sock *smc)
>>
>>   static inline struct smc_sock *smc_clcsock_user_data(const struct sock *clcsk)
>>   {
>> -       return (struct smc_sock *)
>> -              ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
>> +       return (struct smc_sock *)rcu_dereference_sk_user_data(clcsk);
>>   }
> Are you sure all smc_clcsock_user_data() callers  hold rcu_read_lock() ?
> In order to avoid surprises, I would have added a new helper.
>
>   static inline struct smc_sock *smc_clcsock_user_data_rcu(const struct
> sock *clcsk)
> ...
>
> to allow gradual conversion ?
>
> Thanks !

Sorry I missed that.

pw-bot: cr


