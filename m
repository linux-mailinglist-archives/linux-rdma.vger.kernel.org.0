Return-Path: <linux-rdma+bounces-22352-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5LB4BM4ANGoaKwYAu9opvQ
	(envelope-from <linux-rdma+bounces-22352-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 16:29:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A55466A0F04
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 16:29:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=xrCKAHLy;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22352-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22352-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0711C302F269
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A81A3E92B4;
	Thu, 18 Jun 2026 14:29:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2074135DA6F;
	Thu, 18 Jun 2026 14:29:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792967; cv=none; b=MrxZDtJdN03Y9JWPDVge2Zsc88g2n0AE6NA0NhVcSOY+HzsrMrx0/F7wFYI072SJIDCgZdO584+KiYfn155mf4ouvL03j5/E3Q9VbqZAd9fxbcgY35JpSxLAZd8+lmF0j5SSNPfZH497cW694QXJ+j5u99e4aFpPzqf7ZQ7IiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792967; c=relaxed/simple;
	bh=0c5f64XvM9pPEdRoAqsJWItuR0+mUALLGRGxtETBYWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSrm0fxnxuCsXTyKcU8Ai7X8d14eLAMxIY+59mb6nuDy9mwpF89NtGgZV65XjtNi5UUGoij/PZ5O89xTmldQBeN+1axsd3YMmHVtbRCV+4nOrGcE3Plen/3wwr9/r/RZ89Ao0cCTPqRt4I4mJJXVU3xymczUIvkunMxdX+VgZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xrCKAHLy; arc=none smtp.client-ip=115.124.30.98
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781792961; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=nKV1yhKi1WLEd18Af9gcjOHzs+4k7wTzMcjq0H8qDLE=;
	b=xrCKAHLywgdSGiB9lgMgFPGOsw4hpcvPMQrD2825LSfu7wFCGj09v/VEBNOk4N49zIYQsdU5zx4pYXihXH9jXqAelj1xtextrKtXkMJnpDP0sbM8E0Wl52PbRsg3QM5ppWnxVXhDNbf9Nrwm99Q1OBbn9zeyLGceCHCLLFPGqeM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X57G-Qu_1781792960;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X57G-Qu_1781792960 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 22:29:21 +0800
Date: Thu, 18 Jun 2026 22:29:20 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: hexlabsecurity@proton.me, Wenjia Zhang <wenjia@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>, linux-s390@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Tony Lu <tonylu@linux.alibaba.com>
Subject: Re: [PATCH v3 1/3] net/smc: bound the wire-controlled producer
 cursor to the RMB
Message-ID: <ajQAwBMzCJfO9SM1@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me>
 <20260614-b4-disp-edd64be9-v3-1-551fa514257e@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614-b4-disp-edd64be9-v3-1-551fa514257e@proton.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:wenjia@linux.ibm.com,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:ubraun@linux.ibm.com,m:raspl@linux.ibm.com,m:linux-s390@vger.kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:kuba@kernel.org,m:tonylu@linux.alibaba.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22352-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A55466A0F04

On 2026-06-14 03:23:30, Bryam Vargas via B4 Relay wrote:
>From: Bryam Vargas <hexlabsecurity@proton.me>
>
>smc_cdc_cursor_to_host() (SMC-R) and smcd_cdc_msg_to_host() (SMC-D)
>import the peer's producer cursor from the wire into the local
>connection cursor with no upper bound against the receive buffer (RMB).
>The urgent path then uses that count as a raw index:
>
>	base = conn->rmb_desc->cpu_addr + conn->rx_off;
>	conn->urg_rx_byte = *(base + conn->urg_curs.count - 1);
>
>so a peer that advertises a producer cursor past rmb_desc->len reads
>out of bounds of the RMB allocation in the receive tasklet (softirq).
>
>Bound the producer cursor count to rmb_desc->len at the conversion
>boundary, for both SMC-R and SMC-D.  Apply the bound to the producer
>cursor only: the consumer cursor indexes the peer's RMB and is bounded
>by peer_rmbe_size, so clamping it to our rmb_desc->len would
>under-credit peer_rmbe_space and stall transmit to a peer whose RMB is
>larger than ours.
>
>Fixes: de8474eb9d50 ("net/smc: urgent data support")
>Cc: stable@vger.kernel.org
>Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
>---
> net/smc/smc_cdc.h | 27 ++++++++++++++++++++++++---
> 1 file changed, 24 insertions(+), 3 deletions(-)
>
>diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
>index 696cc11f2303..ca76ef630356 100644
>--- a/net/smc/smc_cdc.h
>+++ b/net/smc/smc_cdc.h
>@@ -221,7 +221,8 @@ static inline void smc_host_msg_to_cdc(struct smc_cdc_msg *peer,
> 
> static inline void smc_cdc_cursor_to_host(union smc_host_cursor *local,
> 					  union smc_cdc_cursor *peer,
>-					  struct smc_connection *conn)
>+					  struct smc_connection *conn,
>+					  int max_count)
> {
> 	union smc_host_cursor temp, old;
> 	union smc_cdc_cursor net;
>@@ -235,6 +236,15 @@ static inline void smc_cdc_cursor_to_host(union smc_host_cursor *local,
> 	if ((old.wrap == temp.wrap) &&
> 	    (old.count > temp.count))
> 		return;
>+	/* The peer producer cursor is wire-controlled and is later used as a
>+	 * raw index into our RMB by the urgent path; bound its count to the
>+	 * RMB.  max_count == 0 leaves the consumer cursor unbounded here: it
>+	 * indexes the peer's RMB (bounded by peer_rmbe_size, not our
>+	 * rmb_desc->len), so clamping it to rmb_desc->len would under-credit
>+	 * peer_rmbe_space and stall transmit to peers with a larger RMB.
>+	 */
>+	if (max_count && temp.count > max_count)
>+		temp.count = max_count;
> 	smc_curs_copy(local, &temp, conn);
> }
> 
>@@ -246,8 +256,13 @@ static inline void smcr_cdc_msg_to_host(struct smc_host_cdc_msg *local,
> 	local->len = peer->len;
> 	local->seqno = ntohs(peer->seqno);
> 	local->token = ntohl(peer->token);
>-	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn);
>-	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn);
>+	/* bound the wire-controlled producer cursor to our RMB (used as a raw
>+	 * index by the urgent path); leave the consumer cursor unbounded -- it
>+	 * indexes the peer's RMB and is bounded by peer_rmbe_size.
>+	 */
>+	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn,
>+			       conn->rmb_desc->len);
>+	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn, 0);
> 	local->prod_flags = peer->prod_flags;
> 	local->conn_state_flags = peer->conn_state_flags;
> }
>@@ -260,6 +275,12 @@ static inline void smcd_cdc_msg_to_host(struct smc_host_cdc_msg *local,
> 
> 	temp.wrap = peer->prod.wrap;
> 	temp.count = peer->prod.count;
>+	/* the peer producer cursor is wire-controlled and is used as a raw
>+	 * index into our RMB by the urgent path; bound it to the RMB.  The
>+	 * consumer cursor below indexes the peer's RMB and is left unbounded.
>+	 */
>+	if (temp.count > conn->rmb_desc->len)
>+		temp.count = conn->rmb_desc->len;
> 	smc_curs_copy(&local->prod, &temp, conn);
> 
> 	temp.wrap = peer->cons.wrap;

Hi Bryam,

I agree the issue is real. SMC-R's original design didn't fully
account for misbehaving peers, which is the root cause behind a
number of similar issues we've seen. The good news is that this
class of problem isn't easy to hit in practice, so it isn't
particularly urgent.

On the approach itself: once we detect that the peer is misbehaving,
I think the right action is to abort the connection and record the
event, rather than silently clamp. An invalid CDC means the whole
communication state can no longer be trusted, so continuing on a
clamped value just papers over a peer bug.

I'd suggest we add a dedicated CDC message check, and route any
failure through the existing abort path, maybe something like bellow:

    static bool smc_cdc_msg_check(struct smc_connection *conn,
                                  struct smc_cdc_msg *cdc)
    {
        u32 prod_count = ntohs(cdc->prod.count);
        u32 cons_count = ntohs(cdc->cons.count);

        if (prod_count > conn->rmb_desc->len ||
            cons_count > conn->peer_rmbe_size ||
            cdc->prod.wrap > 1 || cdc->cons.wrap > 1) {
            this_cpu_inc(net->smc.smc_stats->...cdc_inval);
            net_ratelimited_function(pr_warn,
                "smc: invalid CDC from peer (token=%u)\n",
                ntohl(cdc->token));
            return false;
        }
        return true;
    }

For -stable, your current minimal patch is fine. For net-next, though, I'd prefer
the approach above: validate at the wire boundary, abort on violation, and
make the event observable via smc_stats and a ratelimited warning.

Best regards,
Dust


