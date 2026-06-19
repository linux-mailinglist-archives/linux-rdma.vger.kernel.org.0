Return-Path: <linux-rdma+bounces-22370-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sm8NHxC4NGoJfgYAu9opvQ
	(envelope-from <linux-rdma+bounces-22370-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 05:31:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E02966A3AC6
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 05:31:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=khGY8gE4;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22370-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22370-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 950C03059301
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 03:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DA42EBBA4;
	Fri, 19 Jun 2026 03:31:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D63A19D8BC;
	Fri, 19 Jun 2026 03:31:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781839884; cv=none; b=kCJbrLA2iiriyUwYs3W9hyVQOHdjmvZ82kGXUfKBM4iCFKwu/eWzAvYjjLU27j6Wyup7Cuo/vL+kUSzzkvLOUdiVM2MUiIkwgIngRMY9b6sMCC25oyxyn0hC/tp1CyuBxkdvlkNw0gxuvH2kaXPw2FIWcTv1yXnwTbLmLQSYJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781839884; c=relaxed/simple;
	bh=JzPjOPNYTxb3CLKqeBrTg6gSkEKoAKEwNbvjO9EzUyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abDVfaZZIdMFPcDM6zEH4JZ4FC8W5DZr82CJipM+6A7auNlcKNWCdGBiMpVXYBLtoHS78dvvoc/0VkUyGeU3x+Cju8eTdDnzoB4QigEpxNyX6iwVaec2EeoZ9Inf1WFClcwbpciDblEuh1PHYJ55KeywZyleJj7E3NWCVvCA+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=khGY8gE4; arc=none smtp.client-ip=115.124.30.98
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781839880; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=JzPjOPNYTxb3CLKqeBrTg6gSkEKoAKEwNbvjO9EzUyg=;
	b=khGY8gE4Nwby2jCpUMCww9DYAhXehD3eCMjN63720EsKnTMcR2ughCC4rW7GsGpCuxIB6/tPFQDrtxGH6gQ2gsFH2XHSteUiEsiHPjmhnFsRN9SGC7Wlecok6ExiyWuUnN7Wj7bdKBTXpF1Ni6nGoAhtZvNXX+Q+YBJ2jQPcGHE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X58XT8v_1781839879;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X58XT8v_1781839879 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Jun 2026 11:31:19 +0800
Date: Fri, 19 Jun 2026 11:31:18 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] net/smc: bound the receive length to the RMB in
 smc_rx_recvmsg()
Message-ID: <ajS4BgnyzRsa7HVm@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me>
 <20260614-b4-disp-edd64be9-v3-2-551fa514257e@proton.me>
 <ajQWxQZXzM2J8kaZ@linux.alibaba.com>
 <20260618221106.236699-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618221106.236699-1-hexlabsecurity@proton.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:wenjia@linux.ibm.com,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.ibm.com,m:raspl@linux.ibm.com,m:tonylu@linux.alibaba.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22370-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.alibaba.com:dkim,linux.alibaba.com:replyto,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E02966A3AC6

On 2026-06-18 22:11:12, Bryam Vargas wrote:
>On Fri, 19 Jun 2026 00:03:17 +0800, Dust Li wrote:
>> Once we validate the CDC message at the input boundary (as in the
>> previous patch), bytes_to_rcv can never exceed rmb_desc->len, so
>> this check becomes unreachable. So I don't think this patch is needed.
>
>This one I'd actually like to keep, and let me walk through why -- I don't think the
>boundary check closes it.
>
>bytes_to_rcv isn't set to a cursor count, it's a running accumulator:
>smc_cdc_msg_recv_action does atomic_add(diff_prod, &bytes_to_rcv), where
>diff_prod = smc_curs_diff(rmb_desc->len, old, new). So bounding each cursor's count at
>the boundary doesn't bound the sum of the deltas.
>
>The differing-wrap branch of smc_curs_diff returns (len - old.count) + new.count,
>which is up to 2*len-1 even when both cursors pass count <= len. With len=16, a prod
>going (0,0) -> (1,15) gives diff=31, so bytes_to_rcv is already 31 > len after one
>message; alternating wrap 0<->1 at count=15 keeps adding ~len and eventually wraps the
>atomic_t negative. I have an A/B for this -- happy to send it along.

Glad to see you A/B test, I think we can decide after we see the real
issue.

>
>So to make this truly unreachable from the boundary check, we'd need to bound
>prod - cons <= len there, not just the absolute count. The consumer-side clamp is two
>lines and race-free against the tasklet, so my preference would be to keep it as a
>backstop -- but if you'd rather fold it into a stronger boundary check instead, I'm
>open to that.

Another thing I'd worry about is if this really happens, should we also
abort the connection like what we did in patch #1 ?

Best regards,
Dust


