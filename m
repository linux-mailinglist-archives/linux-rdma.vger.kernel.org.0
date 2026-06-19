Return-Path: <linux-rdma+bounces-22374-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5rFBLzPjNGpwjQYAu9opvQ
	(envelope-from <linux-rdma+bounces-22374-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 08:35:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5576A421A
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 08:35:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=wlhaCKT9;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22374-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22374-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65E8E304C60D
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 06:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF10735295C;
	Fri, 19 Jun 2026 06:35:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FAA23ED5B;
	Fri, 19 Jun 2026 06:35:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850921; cv=none; b=S1PQ1BVo0yN4wep/C+6bl9Wu/DYSh7tSLP2wlEOGNI+/QsYkyLccljPk7XolExe7W5NF5LJxvvQiEbNtRJIzCcyNhsvaEb2qpgLjOFu8OYjTxngkLZ5WksW8TJ88eTIzzuSW+Cu/XBhf1EHGWZ4VeS5e5kwm8g66VvyYEpJtrrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850921; c=relaxed/simple;
	bh=44fmCjC9fVUGPXXrd3HwQxzlSiz4jyFTZqz1jkBeNqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHXXFqGDo70l6t6eogrn71dFGVu1lcHkOdGNT41snbNan3bbj31z18RrCbxafi6KG2+9KI6JmT6MmAyb9dZJyWEsYWFcnxLmqBRN3ESjGSfyZQLiMFRppldyrtNoPH4oWx8vpAgXHjlRqF35+re0cRV1oRzfdPO9pr+Z6KAcjgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wlhaCKT9; arc=none smtp.client-ip=115.124.30.133
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781850915; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=45U6L2scHXerIc02dhZiR8csZdzJQqHBYsy1D50eKBQ=;
	b=wlhaCKT9qF3NlKFKM8/m+0WjD3sfpC6AgxJTnV12LmdMWpwrNC0V3ChYSRa6bfl6MZU7137C29rniDiN8+WuoFiGeEtFV/6LVYQmlWv3e0q190UFAeXaLXse00mebh5wj4oh1kdrQ16KM+mArnfCeJJjJ5EtIEACTIQAs6FvgVU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X58zH3Z_1781850913;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X58zH3Z_1781850913 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Jun 2026 14:35:14 +0800
Date: Fri, 19 Jun 2026 14:35:13 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
	Karsten Graul <kgraul@linux.ibm.com>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net/smc: avoid recursive sk_callback_lock in listen
 data_ready
Message-ID: <ajTjIbm4qPvukJzr@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22374-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:kgraul@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A5576A421A

On 2026-06-17 23:28:55, Runyu Xiao wrote:
>smc_listen() installs smc_clcsock_data_ready() as the underlying TCP
>listen socket's sk_data_ready callback.  smc_clcsock_data_ready() then
>immediately takes sk_callback_lock before looking up the SMC listener and
>queuing smc_tcp_listen_work().
>
>That is unsafe once the TCP listen socket is leaving TCP_LISTEN.  The TCP
>close/flush path can run the installed sk_data_ready callback with
>sk_callback_lock already held, so entering smc_clcsock_data_ready() again
>tries to take the same rwlock recursively in the same thread.  The nvmet
>TCP listener had to make the same state check before taking
>sk_callback_lock for this reason.
>
>This issue was found by our static analysis tool and then manually
>reviewed against the current tree.
>
>The grounded PoC kept the SMC listen callback installation path:
>
>  smc_listen()
>  smc_clcsock_replace_cb()
>  sk_data_ready = smc_clcsock_data_ready()
>
>It then modeled the close/flush carrier that invokes the installed
>sk_data_ready callback while sk_callback_lock is already held.  Lockdep
>reported the same-thread recursive acquisition:
>
>  WARNING: possible recursive locking detected
>  smc_clcsock_data_ready+0xa/0x4d [vuln_msv]
>  smc_close_flush_work+0x1f/0x30 [vuln_msv]
>  *** DEADLOCK ***
>
>Return before taking sk_callback_lock when the underlying TCP socket is no
>longer in TCP_LISTEN.  In that state there is no listen accept work to
>queue for SMC, and avoiding the callback lock mirrors the fix used by the
>TCP nvmet listener.

Hi Runyu,

I noticed the lockdep splat comes from your own kernel module
([vuln_msv]) that models the condition, rather than from a real
TCP code path.

Could you point me to the specific mainline TCP code path that calls
sk_data_ready() while holding sk_callback_lock? If such a path
exists, I'm happy to take this patch. But if this is based solely on
static analysis without a confirmed real call chain, I'd prefer to
focus our review bandwidth on issues that have demonstrated impact.

Thanks,
Dust


