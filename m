Return-Path: <linux-rdma+bounces-17000-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLqzMGzzlWlTWwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17000-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 18:14:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF8C158272
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 18:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AE75300AB3F
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760B034405F;
	Wed, 18 Feb 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vH0j1bU/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dROlG5Y0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KRN/vjqF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qeOBMTSf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55D33F389
	for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771434855; cv=none; b=jgjg3uapdBI2zZPUpiNgLQWOMbOjsN70lulj2FUJ47O/MTaN55X7gsQsKrb8mOLH2fRbToua082xlQ/kSUrtUnigxon3n220iL5XtOLB+yTooD7WnkdCMQa3w+2W8jAW5TmCuy5inq4jrnBHMNvQTSI54B2VUnxXAjIMt3SM9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771434855; c=relaxed/simple;
	bh=V4ubtxTZe6qjg85/HutGSAp8jrshlZZcGnuQ7i3rRsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyQRbxS6BfOD3efZdqUTS59jrPrPe1cGXUTpew6ayFx7dgU6M95UK8vIQS7j0DYsb3XYRF/A/yM/JRGLLWIBg+iwZnrXCHSMzKdjmRfcnbiDmm0yW3uII2UNbuEz/jOj4myO1rFc3qfCKhLQERVyBAVLmDFLJY/3ffEo/OtP4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vH0j1bU/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dROlG5Y0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KRN/vjqF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qeOBMTSf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BAA885BCE5;
	Wed, 18 Feb 2026 17:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771434852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+145KWOw3QDQIRqPhnmXA3oHucxMq9auILbBaUBYpl0=;
	b=vH0j1bU/gRr05S3sHY60kx3an2rq/YBi07seig6P/nxO9Zef49VKHwgDmwMU+YBHGdzewR
	PR/QBO0aQUhG3DOHueFy4qrfniCqFRH3MDO6RFNPMbblj7oraIftr41s8PdbWm+0jsMwNq
	hLjpXtTJ9EdIHzvspgbypm8wodd6kog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771434852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+145KWOw3QDQIRqPhnmXA3oHucxMq9auILbBaUBYpl0=;
	b=dROlG5Y05UXillUiWdRnvk1k1Q9a+bVchpMeJpasQGyr7WdF1uGLzgCnbt6VnpTduuJLm6
	W4xJWQ5HhYFp6xAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="KRN/vjqF";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qeOBMTSf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771434850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+145KWOw3QDQIRqPhnmXA3oHucxMq9auILbBaUBYpl0=;
	b=KRN/vjqFRKPS5cVQL8RkgNpwbVPqx4b5jyCh1aLbiPHtBw+3JY8kfH7E9M16IncdeZVRZj
	d+kVFt9bhslH6HtnMbIB5Q9lGI1LC4LiNgotRvjVn/4Vh3JIUzsW4OXAP1tYsMh5j71tGX
	1YkngPibDlB/wMGRRUoypxUUVkjfK1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771434850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+145KWOw3QDQIRqPhnmXA3oHucxMq9auILbBaUBYpl0=;
	b=qeOBMTSfU3QIUkXBwkk4CVHE1kCnudFcf4x0si44RwmRVy2XSdWixbJ8HFnlQ75nd+fEVy
	oHYQ1bN90YL/XWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02AD63EA65;
	Wed, 18 Feb 2026 17:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EPXYOGHzlWmUTwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 18 Feb 2026 17:14:09 +0000
Message-ID: <59c133d4-9e5c-4eee-95c2-4a8877b052be@suse.de>
Date: Wed, 18 Feb 2026 18:13:56 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,v2] net/rds: fix recursive lock in
 rds_tcp_conn_slots_available
To: Simon Horman <horms@kernel.org>
Cc: pabeni@redhat.com, davem@davemloft.net, allison.henderson@oracle.com,
 syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com, kuba@kernel.org,
 rds-devel@oss.oracle.com, gerd.rausch@oracle.com, netdev@vger.kernel.org,
 edumazet@google.com, linux-rdma@vger.kernel.org
References: <20260217223802.21659-1-fmancera@suse.de>
 <20260218100206.88254-1-horms@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260218100206.88254-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17000-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,5efae91f60932839f0a5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 2AF8C158272
X-Rspamd-Action: no action

On 2/18/26 11:02 AM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "I'm passing this on, not becuase of the first coment
> regarding fan-out, which I think seems reasonable in it's current
> form. But because of the second comment, at the end, regarding the
> receive path. I'm not sure about that one either way, but it seems
> worth passing on to you."
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net/rds: fix recursive lock in rds_tcp_conn_slots_available
> 
> This commit addresses a recursive lock warning reported by syzbot in
> rds_tcp_get_peer_sport() by replacing kernel_getpeername() calls with
> direct socket struct access to read the peer port number.
> 
> Closes: https://syzkaller.appspot.com/bug?extid=5efae91f60932839f0a5
> 
>> diff --git a/net/rds/connection.c b/net/rds/connection.c
>> index 185f73b01694..a542f94c0214 100644
>> --- a/net/rds/connection.c
>> +++ b/net/rds/connection.c
>> @@ -455,6 +455,9 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
>>   		rcu_read_unlock();
>>   	}
>>
>> +	/* we do not hold the socket lock here but it is safe because
>> +	 * fan-out is disabled when calling conn_slots_available()
>> +	 */
> 
> Is this comment potentially misleading about the safety reasoning?
> 
> The comment says "we do not hold the socket lock here but it is safe
> because fan-out is disabled." This is factually accurate - with fan_out
> set to false, the code path that reads from the socket (via
> rds_tcp_get_peer_sport) is never reached.
> 
> However, the phrasing could confuse readers about what happens if fan_out
> were true but the lock weren't held. In that scenario, the new code
> (reading inet_dport directly) would still be safe because inet_dport is an
> atomic-width read of a stable field.
> 
> The comment conflates two independent safety properties: (1) the socket
> isn't accessed at all when fan_out is false, and (2) if it were accessed,
> the new implementation would still be safe without the lock.
> 
> Could the comment more precisely explain the safety reasoning?
> 
>>   	if (conn->c_trans->conn_slots_available)
>>   		conn->c_trans->conn_slots_available(conn, false);
>>   }
> 
> [ ... ]
> 
>> @@ -59,30 +59,12 @@ void rds_tcp_keepalive(struct socket *sock)
>>   static int
>>   rds_tcp_get_peer_sport(struct socket *sock)
>>   {
>> -	union {
>> -		struct sockaddr_storage storage;
>> -		struct sockaddr addr;
>> -		struct sockaddr_in sin;
>> -		struct sockaddr_in6 sin6;
>> -	} saddr;
>> -	int sport;
>> -
>> -	if (kernel_getpeername(sock, &saddr.addr) >= 0) {
>> -		switch (saddr.addr.sa_family) {
>> -		case AF_INET:
>> -			sport = ntohs(saddr.sin.sin_port);
>> -			break;
>> -		case AF_INET6:
>> -			sport = ntohs(saddr.sin6.sin6_port);
>> -			break;
>> -		default:
>> -			sport = -1;
>> -		}
>> -	} else {
>> -		sport = -1;
>> -	}
>> +	struct sock *sk = sock->sk;
>> +
>> +	if (!sk)
>> +		return -1;
>>
>> -	return sport;
>> +	return ntohs(inet_sk(sk)->inet_dport);
>>   }
> 
> The commit message states "For rds_tcp_conn_slots_available() the lock is
> already held because we are in the receiving path." Is this claim accurate
> across all receive paths?
> 
> Looking at the two receive sub-paths:
> 
> 1. In the backlog processing path (shown in the syzbot stack trace), the
> socket IS owned because __release_sock() runs while the lock_sock
> ownership bit is still set:
> 
> tcp_sock_set_cork() -> lock_sock() -> release_sock() -> __release_sock()
>    -> sk_backlog_rcv() -> tcp_v6_do_rcv() -> tcp_rcv_established()
>    -> tcp_data_ready() -> sk->sk_data_ready() -> rds_tcp_data_ready()
>    -> rds_tcp_read_sock()
> 
> 2. However, rds_tcp_data_ready() can also be called directly from the
> normal softirq receive path via tcp_data_ready() -> sk->sk_data_ready(),
> where the socket lock is NOT held. In this path, rds_tcp_read_sock()
> calls tcp_read_sock() without lock_sock.
> 
> The fix is still correct in both cases because inet_dport is a stable
> atomic-width field, but the claim "the lock is already held" is not
> universally true for all receiving paths.
> 
> Should the commit message be more precise about when the lock is held?
> 

While I think that is right, the relevant part is the atomicity. The 
operation is safe but it requires a READ_ONCE() annotation probably.


