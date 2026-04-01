Return-Path: <linux-rdma+bounces-18879-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL79LbrVzGnnWwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18879-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 10:22:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DA0376B3A
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 10:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E292E30704A6
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 08:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562B73A6B8B;
	Wed,  1 Apr 2026 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VB9zQOMS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OX6ZYRT6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UumfGlpe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9DVUgKCQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FCA30E0DC
	for <linux-rdma@vger.kernel.org>; Wed,  1 Apr 2026 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775030843; cv=none; b=OHzsOgKHASB3fnoCiuAmVNItiugjcjkHu10QMB7s4YcAGY+rjXQj2C1HksS+ClRxxTX8c79YglSlGMImXG/S+tHufsRASq+DMv+RKLTd5IcP8eEWriS6SnFyittW1gCRl2+U6w3/+b01m+01ER5RUYrp+pbKBT0H6ox9gxgczzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775030843; c=relaxed/simple;
	bh=CCx+GFAORQjDm/2O1NV4OJKRWSjlc+6Y6ZiWC9pYoiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iSPImWGICVQkIOwX7pT3KspIaPj7RufagqPpKFSKenzXoIuNP2MQfbqbloT7xt/fW9xg9jTYQxXHvZ4NVg4m/e7H/JFkGUtlqcCh7tlY/RilOQ/5MYEaAUXg+2q1j/JPo6l74RQwebbmDp6Wp/imjkHur0bjUGHzJO2/tuij6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VB9zQOMS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OX6ZYRT6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UumfGlpe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9DVUgKCQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC7414D1E6;
	Wed,  1 Apr 2026 08:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775030839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxElQ1mKL+40DbJrKWdPV5blyGGdtJ7Ol4ZcG0VUW8g=;
	b=VB9zQOMSu+/79FqZGb4QKiNjM48c9y9y2hT63fknB2qki9ANwYF33Ti5dw4wPP1DTJ0o9f
	ju2feKQc5NBgsEEgDOL59uxeQqUkGldHg9qX/1fVAAaRNekh77ZQxtKu5rBiDaycxF6NLi
	w5VifXEgy4UYnv0vFRFFoc2KiLC7lXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775030839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxElQ1mKL+40DbJrKWdPV5blyGGdtJ7Ol4ZcG0VUW8g=;
	b=OX6ZYRT6B/jOrZXGBQwTNiiKCedPi2A6TEjRf1vhqrUO3ghftCTnNjW3pIaNkoQtU5mY+k
	0tbgZMEIIzHv7hDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UumfGlpe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9DVUgKCQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775030838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxElQ1mKL+40DbJrKWdPV5blyGGdtJ7Ol4ZcG0VUW8g=;
	b=UumfGlpeBZ9uFiThr/HUVcFG48FqBqF61QCK9ba479A6Xtab5CK5lPZm28acp+Tx2z5DHc
	omNSfmEnwHIVlLbCuNJ3knNW80VzUXAadW797/yAgXt28dxJxjZvRQtZ/zb4qi7wMwGM6t
	yO7ALJkKMcU5UjO7pSLGlS9aEDRl9NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775030838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxElQ1mKL+40DbJrKWdPV5blyGGdtJ7Ol4ZcG0VUW8g=;
	b=9DVUgKCQYkafabgN/89Y8m75p2RUkalDiYDEH4T5pK50lCZnkIyayKSDkWuIPcc3/XRTSa
	DyM1FlrzsCWGUXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D6B24A0B0;
	Wed,  1 Apr 2026 08:07:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ig1cADTSzGmjbwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 01 Apr 2026 08:07:16 +0000
Message-ID: <42caa438-3854-449c-b0ee-4f40772e5c1b@suse.de>
Date: Wed, 1 Apr 2026 10:07:11 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Deprecate Legacy IP
To: David Woodhouse <dwmw2@infradead.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, Guillaume Nault <gnault@redhat.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>,
 Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 oss-drivers@corigine.com, bridge@lists.linux.dev, bpf@vger.kernel.org,
 linux-wireless@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, torvalds@linux-foundation.org,
 jon.maddog.hall@gmail.com
References: <20260401074509.1897527-1-dwmw2@infradead.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260401074509.1897527-1-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[infradead.org,nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,amazon.co.uk,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18879-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2DA0376B3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/26 9:44 AM, David Woodhouse wrote:
> RFC1883, the IPv6 standard, was published in the final decade of the 1900s.
> That's closer in time to the Apollo 11 moon landing than it was to today.
> 
> Even our esteemed Maddog has worked with computers for longer in the IPv6
> era, than he ever did before it.
> 
> Yet Linux still can't even be *built* with only IPv6 support and without
> support for Legacy IP. This long overdue patch series fixes that, and
> immediately marks Legacy IP for deprecation.
> 
> It also cleans up a few tautological "INET && IPV6" and "INET || IPV6"
> checks, since IPV6 (and now LEGACY_IP) cannot be selected without the
> overall CONFIG_INET option.
> 
> For now, we only add a warning when a process *listens* on a Legacy IP
> socket (since you can listen on IPv6 and still accept connections which
> have come through a timewarp from the 20th century. Adding warnings for
> making outbound connections or *accepting* on Legacy IP can come later.
> 
>    'I would be happy if "Legacy IP" ceased to be the "industry standard"
>     and IPv6 be the default, even if I had to beat IPv6 into the head of
>     every single network administrator's head with a shovel.' said Jon
>    'maddog' Hall, ancient supporter of Free and Open Source Software.
> 

Dammit, you've beaten me to it! This was my next step for 7.2.

Fully-endorsed-by: Fernando Fernandez Mancera <fmancera@suse.de>

