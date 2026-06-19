Return-Path: <linux-rdma+bounces-22376-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JRYmAv5aNWp0twYAu9opvQ
	(envelope-from <linux-rdma+bounces-22376-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 17:06:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 666786A6962
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 17:06:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=tKoDilM2;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22376-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22376-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9928130BA0C1
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB1F3B2FED;
	Fri, 19 Jun 2026 15:00:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2923B19D1
	for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2026 15:00:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881214; cv=none; b=aBipIIbpwmRRTFR0PDzArkbLe5Z4Nmwt7s2WkXwc83bx9ZVLO/gbu3YPdbHLe41iiLH+iyRkd2t3uCQB1MuZYpmYS/08V2O0iFo0nzusvmm6b190Go3I03R6q4+jpF8e63ZQGJnin8K8bSpP8OGvl1WSS6CFy9N4PcqjoeLfzX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881214; c=relaxed/simple;
	bh=VQaH1wvSCcUtVwxxxrJu7Tdk9Yv26o0XHxhe+r5CnPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlgcTuVhxqPnghii3IYlvzKXLNQlbu0VtjQLNibxw8Us3ko34TmCiCL+jd19WdYT5EYrtqo9iJ8IPzxNeqDs00jYOtKAFrWDI/yE/R58Oy9je7b39LXP2MDEVK3XUDvaHiyYVsEkUDgjFACA7dW6Ckl4ybuvXC1vlqebsGU5Ko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKoDilM2; arc=none smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c89ab9a9f6cso1302109a12.2
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2026 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881211; x=1782486011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/uXujLL2+ngck/ILaxQvK6OxWBpJRclqR1IeaIZXkpg=;
        b=tKoDilM2jWAD/Ic4U7oWLx1hQZ1tx/+/OVZOWQWFadPycKBayOKBdHzJAWyvzC2Dvy
         8sqXGwuLoJnTEJjEyyAzgWGGjgmpLBuLrwEbljXOlQmJP1kVwKrBWaFra6Z+q3+scVfi
         N1DA1zD8UhvEQD9zqIxBA0WKHl/bzYehGa74ZnWTdhWmKxWD68BGMibn/N75cLbj3ybd
         uSumgxj8sX91gbNx0QU1G2faMhQ3epqOLEDDJqkn5PeTGpP3/mtNGAnDhvAo63aq9jmc
         eBjSHYGZOyuG+eLsyUeMniyFGu9Y6e1d3dxsZSpqRzOnSotzLlT65BcrVjk0Nsbt4yqA
         TNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881211; x=1782486011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uXujLL2+ngck/ILaxQvK6OxWBpJRclqR1IeaIZXkpg=;
        b=RKBrXOdRgUlB+7Q+8gTcRlulxGL9SVzELW1fnBoFGrsTui8v0x0XrdEHc4Xx4AEr+L
         1jULLTui2riBpz6sUFQlQtDHNB/NxLzLH8h8YZE1jNV9HgdhsyRlNFkNIP3mTYB/SOKm
         aiZoDIDcVAPvrGRExpQhArqEXl+St6BTmyoOGugLGAT/qaJkedWXyxNNeBX/nk38GcOb
         Wk5ZYvxMnZbNGlvc8oc6YqNBvqtqDAhuoew7UUk3oQtSb7U9ZJankkqnK8H/UVvFeWAV
         PBTCGRDT33M2uQ1UMhAt69h3is83NLyteAtzSQWVMj0BOefNgS0/Hlq8/WtKA7AS0Q8p
         fGjg==
X-Forwarded-Encrypted: i=1; AFNElJ/3NqyD05UFq94TzzuwnP0QKn54dduWKO6xDy8kxYsrP2/o4nlX+o7iDE55bLNER4c8QlnBWqRxPCVw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu8G+pXz8kTLNtzzDrrNPHcUd6p2lAN3mDgeM95UbKyUybDAFG
	+E88hXckn+VvAphnj/YVLyS+0ib+uIuGek8nCk0W+B7sD2fEXIUDUape
X-Gm-Gg: AfdE7cngxomg5H2WwwSoJivJZIUMTSErteUKtPxZ7G+sdaUEDb0jad2Yj4zshB9ISfJ
	NDbWv3o+bOfV219pkQ5FnypnswPnwMnOpdnVqxT5LBpUneUrRyOyS4ggDRhpwUrSq7Z/Sg8n80g
	fNE8nJZRNzDVLa4rCMHwCvVzGbZ766I+Z3zXueN493POhZm/vG6dYvK5fzeb1ZiTNu/ApLQMYWy
	9fPg9jDuhQZIJNiTbOsdwybagZ9Z50xFAEVzkjDH4nntFlI7+7Q5W0ONhhPJkVxLORJUozL+i95
	+1RbHb5MSHlLrQJmhwt+ajD7DLLxvaLS6OmVI+uiG5Wi32+/wo/TsOzNgfrvUO6TMwnSDsbbBvt
	4hBIRbrjFn7kIfqNkpYSs6s4NzoMc/TJTBR8M8+/KKr5FYrfIE7oUy2tVr5PqyncVYdyW0R2iei
	7wmrxwkqo4qltWqX+SwwW1MzFAohfUV//JSHWWvWWGiMIFZBO3
X-Received: by 2002:a05:6a20:db97:b0:3bb:78b:9dcb with SMTP id adf61e73a8af0-3bb3486bb3cmr4411766637.42.1781881209586;
        Fri, 19 Jun 2026 08:00:09 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bbffc2329sm86900a12.0.2026.06.19.07.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:00:08 -0700 (PDT)
Date: Fri, 19 Jun 2026 14:59:48 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>, 
	Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, 
	Guvenc Gulce <guvenc@linux.ibm.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix out-of-bounds read in
 smc_clcsock_data_ready()
Message-ID: <k4p7go5fz7wx2gp6tp5rqawrpwdiouiyzgw3tf3u3sygxuivnq@eeo7qi5ym47e>
References: <20260614120931.4041687-1-rhkrqnwk98@gmail.com>
 <20260616071639.GA104390@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260616071639.GA104390@j66a10360.sqa.eu95>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.ibm.com,m:kgraul@linux.ibm.com,m:guvenc@linux.ibm.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22376-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,eeo7qi5ym47e:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 666786A6962

On Tue, Jun 16, 2026 at 03:16:39PM +0800, D. Wythe wrote:
>On Sun, Jun 14, 2026 at 12:09:30PM +0000, Sechang Lim wrote:
>> smc_clcsock_data_ready() is installed on the listen socket and reads its
>> sk_user_data as an smc_sock. A passive-open child inherits this callback,
>> but sk_clone_lock() clears the child's sk_user_data because it is tagged
>> SK_USER_DATA_NOCOPY. smc_tcp_syn_recv_sock() restores the child's af_ops,
>> but the inherited sk_data_ready() is left in place until accept.
>>
>> In that window the child is established. A cgroup sock_ops program can run
>> bpf_sock_hash_update() on it from tcp_init_transfer(); sk_psock_init()
>> stores a sk_psock in the NULL sk_user_data. The inherited callback then
>> reads sk_user_data via smc_clcsock_user_data(), which masks only
>> SK_USER_DATA_NOCOPY, mistakes the sk_psock for an smc_sock, and reads a
>> callback pointer past the end of the sk_psock:
>>
>>   BUG: KASAN: slab-out-of-bounds in smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
>>   Read of size 8 at addr ffff8880013b8674 by task syz.6.12484/67930
>>    <IRQ>
>>    smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
>>    tcp_urg+0x24d/0x360 net/ipv4/tcp_input.c:6264
>>    tcp_rcv_state_process+0x280d/0x4940 net/ipv4/tcp_input.c:7336
>>    tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
>>    tcp_v4_rcv+0x1eaa/0x2a00 net/ipv4/tcp_ipv4.c:2186
>>    ip_protocol_deliver_rcu+0x226/0x420 net/ipv4/ip_input.c:207
>>    ip_local_deliver_finish+0x35a/0x5f0 net/ipv4/ip_input.c:241
>>    __netif_receive_skb_one_core+0x1e5/0x210 net/core/dev.c:6216
>>    process_backlog+0x631/0x1470 net/core/dev.c:6682
>>    __napi_poll+0xb3/0x320 net/core/dev.c:7749
>>    net_rx_action+0x4fa/0xcb0 net/core/dev.c:7969
>>    handle_softirqs+0x236/0x800 kernel/softirq.c:622
>>    </IRQ>
>>
>>   Allocated by task 67930:
>>    sk_psock_init+0x142/0x740 net/core/skmsg.c:766
>>    sock_map_link+0x646/0xdf0 net/core/sock_map.c:279
>>    sock_hash_update_common+0xd3/0x990 net/core/sock_map.c:1010
>>    bpf_sock_hash_update+0x114/0x170 net/core/sock_map.c:1229
>>    __cgroup_bpf_run_filter_sock_ops+0x74/0xa0 kernel/bpf/cgroup.c:1727
>>    tcp_init_transfer+0x1085/0x1100 net/ipv4/tcp_input.c:6693
>>    tcp_rcv_state_process+0x241e/0x4940 net/ipv4/tcp_input.c:7231
>>    tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
>>
>> Restore the inherited sk_data_ready() in smc_tcp_syn_recv_sock(), where the
>> child's sk_user_data is already cleared, rather than only at accept.
>>
>> Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
>> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>> ---
>>  net/smc/af_smc.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index b5db69073e20..152971e8ad17 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -156,6 +156,12 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>>  	if (child) {
>>  		rcu_assign_sk_user_data(child, NULL);
>>
>> +		/*
>> +		 * the child inherited the listen-specific sk_data_ready();
>> +		 * restore it here, as sk_user_data may be reused before accept
>> +		 */
>> +		child->sk_data_ready = smc->clcsk_data_ready;
>
>One concern:
>
>smc_clcsock_user_data_rcu() together with refcount_inc_not_zero() only
>pins the smc_sock; it does not guarantee anything about the lifetime or
>consistency of smc->clcsk_data_ready. In the listen-close path,
>smc_clcsock_restore_cb() clears that field under sk_callback_lock,
>while smc_tcp_syn_recv_sock() reads it without any lock. These are
>independent protection domains. If close wins the race,
>child->sk_data_ready can end up NULL and the next data arrival will
>crash.
>

will drop the syn_recv restore in v2. Thanks for your review.

>Also, I don't object to this fix, but I'd rather see the underlying cause
>addressed directly. The real issue seems to be the conflict between
>SMC's sk_user_data and sk_psock. Maybe there is a cleaner solution, e.g.
>always setting user_data.
>

Agreed. 

Thanks, will send v2.

Best,
Sechang

