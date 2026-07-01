Return-Path: <linux-rdma+bounces-22660-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4XRXEgkzRWpF8goAu9opvQ
	(envelope-from <linux-rdma+bounces-22660-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 17:32:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 943646EF43E
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 17:32:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=LV47hc1n;
	dkim=pass header.d=redhat.com header.s=google header.b=EiIoxfZ4;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22660-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22660-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E78AC303308F
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 15:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4206448BD59;
	Wed,  1 Jul 2026 15:27:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B67748AE0D
	for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2026 15:27:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919641; cv=none; b=NAfCQGTMTXo1Kqx9Cdd3QaRoni7X3d6DPw0STXGGrS1pg34yE4gjpcLSGGdgyD4lizhnlA+W5AvvfyO3rGPQe0UlAEA1vENMMn96Eym8NIi8chO/qkNTVn0wDxZWLcC6kfDNuJmC8HQbBx20HPnFgfv+flzik60YsgtLgdzTqMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919641; c=relaxed/simple;
	bh=HYrbqswVMwTk4kuKtL5hvsLl3UN33eSIAa6Clnw68Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OM44a3rErDNdXfmMIegpaDsb5ZY5xs+DVVp5kmYKDewXNg6qAS8RTFxaYdkB0fdnigt/p1T8djge7pzXaAjrKKINbGa4ViuBv4NZoeMgIIzo+7Alc1UAe0xY063xIPcrh3xPLLPuHFSVTRvd6mUyVAOAv4W/mGv68i5qe5zg82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LV47hc1n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EiIoxfZ4; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782919638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auHUwjD5Zohk1V2S34LD+3/BNdV8kbrNPDmWnQVZGEc=;
	b=LV47hc1nsOIwCtMk8x+81zCtvPp9pJMJ6TKLdD5CC/pvy6RBrwtjdctqgSWyX+HwMVX+oG
	N+HfR+SBrt8EWp1a0KHvsf6yH3OqeHsrRsuQWEBhWTYxgzlaG9yBRLtkCNxJb4YuxAMRK9
	TgpjHr7RwFZBaGDvMvDKI57XW0ieeEM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-ms2g7FUjN8m5N6QtIAwPCw-1; Wed, 01 Jul 2026 11:27:16 -0400
X-MC-Unique: ms2g7FUjN8m5N6QtIAwPCw-1
X-Mimecast-MFC-AGG-ID: ms2g7FUjN8m5N6QtIAwPCw_1782919635
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47407691804so563551f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2026 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782919635; x=1783524435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=auHUwjD5Zohk1V2S34LD+3/BNdV8kbrNPDmWnQVZGEc=;
        b=EiIoxfZ4lh/9INR/6hgveLmGNx7YWbe5NVlWp8IvDO8iR81V/ayYyfsTSPdD85tNO4
         BzdaXuxPtgD7RoYJilDg/naaK3VpDOKqomf51rYfgB0OcAwopCpD9Pd9nOutvP3N5RH1
         aObLch26Bd4SDlSEVmcXN6D++2DH8/yJ+CNSPGKogq4rgAmYaafKd6NDdUjksS+cwtyl
         sa8vnmBlphvg1HIt+q5kW0U27S8pcra0L4qOIBZO8MIWcgaqHbTx6Rifm/VkBPTg0qLm
         Xw7z/tDpohszQzhGpKPf3XzBMESAsA2GG2ZTK3MuKTPOac3ehd6MxCdiKd9iQOyOEcQW
         3t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782919635; x=1783524435;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auHUwjD5Zohk1V2S34LD+3/BNdV8kbrNPDmWnQVZGEc=;
        b=PTyCBI1HwOrhlYZF3BpDMILLIFXSTAOueQBWBLfFM85L34PESxPcB/8jdZN3xS5DZi
         xL5eAOFo6nsqV2faIhesJyOM8ngN17UVc3sTXq7bMS8lAQzt+MXcm24lYrB66T+12KmA
         1uXKDgTQWfBN2VpiOQ/NrTx+lCqeUT5SbPdH5V2XpiOx2M2NFpELM7LMAIOc8Mb0S0WZ
         owN55v3d97xuJ7VxtB2XowmCqStfEqIxeMQczNS4WuEszubDlFZiOxb1znNBCS3ojie5
         5ePWjHwkAM2D3ypJsJ8kC5b3pRfUt5AN4qhGOfYIZmnd05RcR1zuiuowLr98vv+5T/ij
         AddA==
X-Forwarded-Encrypted: i=1; AHgh+RpYslymgPg2gKEppzKFo55BhqZeLygnOAQeoY84vyMIYf2XLTf1E8GrPI3KX9vwbWcwjJ160Nelj0KW@vger.kernel.org
X-Gm-Message-State: AOJu0YyhsBOrpduTf8g8SxSdZtsrw57a2fBHpMe83tZ7UgzcbeFYHYon
	AfwmZv5jlt8hR1fgM64yL01Z4mzhrp71EuPtTisY6QXSGeYaa9Ax9pvt3ZiSGbmMXkbNR3eQ6at
	gsN//MZVQFlaLuWpvcGko6JvBpNxFTbW/w6r6urzmUqO5WGz4A5Psu1m205QhBCg=
X-Gm-Gg: AfdE7ck0TLmzWEhyyUqUelaG+f8YJdAAWHS5Mm4T9r7Bw4BRtMp5K+sOaANva5ROQJV
	p0mT3+PAA2hKWwUnjfLWq/PRVxZJjqxITdtN9816+6+orXRFPdZA02zSpqupWC2BNTz6FylWDu7
	J1Rgot04qdG8BvwYWf6RYEo2QrTvbNSIun6gsjN7qcPKW3/46t2z9ZMfoY7JaQwojlvifhwcpnC
	ePJGRxBmYZg8TT+xYNJIoPIjBItJQpR3HM9IJJKCTh5GkFcXDhIEwEoHdhWt/Vw1grTQCnuqlM/
	GAl+ctVgGbsoOGadLlsiFkrq3XXtrCIu3D2Js7Q3NW1VqgQoIfr7KV5ChE7utjDg1+Gift3++09
	OWThC05iAN6UeSiLs38E2HUQht5cF3jAzAZ6wksMxubIFVkSNzDfVkkh57fOt+w7YoMFZ0I5AdM
	CQ1p6a3zi3Bg==
X-Received: by 2002:a05:6000:186f:b0:475:cd6f:720a with SMTP id ffacd0b85a97d-477571cb959mr3680963f8f.1.1782919635225;
        Wed, 01 Jul 2026 08:27:15 -0700 (PDT)
X-Received: by 2002:a05:6000:186f:b0:475:cd6f:720a with SMTP id ffacd0b85a97d-477571cb959mr3680896f8f.1.1782919634784;
        Wed, 01 Jul 2026 08:27:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94ce4csm706993f8f.17.2026.07.01.08.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 08:27:13 -0700 (PDT)
Message-ID: <c222390f-96c7-4dc3-8f33-f4dd277c3639@redhat.com>
Date: Wed, 1 Jul 2026 17:27:11 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/smc: fix out-of-bounds read when sk_user_data
 holds a sk_psock
To: Sechang Lim <rhkrqnwk98@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 Simon Horman <horms@kernel.org>, Karsten Graul <kgraul@linux.ibm.com>,
 Guvenc Gulce <guvenc@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260629095140.679754-1-rhkrqnwk98@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260629095140.679754-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22660-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:kgraul@linux.ibm.com,m:guvenc@linux.ibm.com,m:ubraun@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com,linux.ibm.com,davemloft.net,google.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 943646EF43E

On 6/29/26 11:51 AM, Sechang Lim wrote:
> A passive-open child inherits the listener's smc_clcsock_data_ready().
> sk_clone_lock() clears its sk_user_data to NULL because the listener tagged
> it SK_USER_DATA_NOCOPY. Until accept restores the callback, a BPF sock_ops
> program can add the established child to a sockmap, and sk_psock_init()
> installs a sk_psock into the NULL sk_user_data. The inherited callback then
> reads it back through smc_clcsock_user_data(), which strips only NOCOPY,
> takes the sk_psock for an smc_sock, and dereferences a clcsk_* field past
> its end:
> 
>   BUG: KASAN: slab-out-of-bounds in smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
>   Read of size 8 at addr ffff8880013b8674 by task syz.6.12484/67930
>    <IRQ>
>    smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
>    tcp_urg+0x24d/0x360 net/ipv4/tcp_input.c:6264
>    tcp_rcv_state_process+0x280d/0x4940 net/ipv4/tcp_input.c:7336
>    tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
>    tcp_v4_rcv+0x1eaa/0x2a00 net/ipv4/tcp_ipv4.c:2186
>    [...]
>    </IRQ>
> 
>   Allocated by task 67930:
>    sk_psock_init+0x142/0x740 net/core/skmsg.c:766
>    sock_hash_update_common+0xd3/0x990 net/core/sock_map.c:1010
>    bpf_sock_hash_update+0x114/0x170 net/core/sock_map.c:1229
>    __cgroup_bpf_run_filter_sock_ops+0x74/0xa0 kernel/bpf/cgroup.c:1727
>    tcp_init_transfer+0x1085/0x1100 net/ipv4/tcp_input.c:6693
>    [...]
> 
> Resolve the conflict on the write path. Reserve the child's sk_user_data
> with a NULL pointer tagged SK_USER_DATA_NOCOPY so sk_psock_init() returns
> -EBUSY, and release it at accept. smc_clcsock_user_data() still strips the
> tag to NULL, so the inherited callback stays a no-op.
> 
> Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
> v3:
>  - reserve sk_user_data on the write path instead of the read-side check (D. Wythe)
> 
> v2:
>  - https://lore.kernel.org/netdev/20260619150342.3626224-1-rhkrqnwk98@gmail.com/
> 
> v1:
>  - https://lore.kernel.org/netdev/20260614120931.4041687-1-rhkrqnwk98@gmail.com/
> 
>  net/smc/af_smc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index b5db69073e20..78f162344fe3 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -154,7 +154,11 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  					       own_req, opt_child_init);
>  	/* child must not inherit smc or its ops */
>  	if (child) {
> -		rcu_assign_sk_user_data(child, NULL);
> +		/* reserve sk_user_data so sockmap cannot claim the slot */
> +		write_lock_bh(&child->sk_callback_lock);
> +		__rcu_assign_sk_user_data_with_flags(child, NULL,
> +						     SK_USER_DATA_NOCOPY);
> +		write_unlock_bh(&child->sk_callback_lock);
>  
>  		/* v4-mapped sockets don't inherit parent ops. Don't restore. */
>  		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
> @@ -1773,6 +1777,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
>  	/* new clcsock has inherited the smc listen-specific sk_data_ready
>  	 * function; switch it back to the original sk_data_ready function
>  	 */
> +	write_lock_bh(&new_clcsock->sk->sk_callback_lock);
>  	new_clcsock->sk->sk_data_ready = lsmc->clcsk_data_ready;
>  
>  	/* if new clcsock has also inherited the fallback-specific callback
> @@ -1786,6 +1791,9 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
>  		if (lsmc->clcsk_error_report)
>  			new_clcsock->sk->sk_error_report = lsmc->clcsk_error_report;
>  	}
> +	/* release the slot reserved in smc_tcp_syn_recv_sock() */
> +	rcu_assign_sk_user_data(new_clcsock->sk, NULL);
> +	write_unlock_bh(&new_clcsock->sk->sk_callback_lock);

Sashiko reports that this still cause problem on fallback.

@Wythe, I understand from previous discussion that you would prefer to
address such issues separately (and thus you are fine with the patch in
the current form). Could you please confirm?

/P
>  
>  	(*new_smc)->clcsock = new_clcsock;
>  out:


