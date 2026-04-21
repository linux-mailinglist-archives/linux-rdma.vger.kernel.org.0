Return-Path: <linux-rdma+bounces-19446-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDuOO/IZ52nT3wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19446-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 08:32:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBF2436FBA
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 08:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF29F3021715
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 06:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538B2301474;
	Tue, 21 Apr 2026 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pa5xBwcX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22032E728
	for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2026 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776753002; cv=none; b=n39sOXVeTgbyl0etI9TedII03vbkN1YCu4GDmX6LI7WmLBYacmugFhF2FtgGcreEYod47oo5cXZi3Y+S7jQQTbmG6Lj5g0TOxBFH8atcVZ0MN7zr3c1gQ2hnAeTyfJYfcdHQfw6vy/kclk1WYzWmCCDeAw2sJiDjkIRiFc42l1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776753002; c=relaxed/simple;
	bh=5Mnzw1dPTWV3cTrL9+2BoaoazaWKiE/ZmHJYHV6twSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fhm64UpYavZ2DEw50LQ+h82rbwownv8L/9NwqT0dK+GFslGOfuaeWKVjXPL1QA6UTbZfscVfnl7BNR6tetbSejckyIS6TLHngZAhfW7fszhI7wvhoh3v7k6qB867yN6upnAD+Qam7Ab7kmeRWVpS4NbbuLapcerYQvOzOO37E0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pa5xBwcX; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba50cde9-b26c-4dac-a494-0caa00603928@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776752988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+2bjwojJ3skPY3i3AzUXvGWv038RCeNB9z8B+VTC5KI=;
	b=Pa5xBwcX8jJ+hxcXjWGiBcei/sq76Q9rttYvHxYg+APdx5shjlp7x1S5cSRWxE/9THi04+
	lChhRLW8773KiQue3MlFJqLAowYt/MXEEG+SacxieDCv8tJwGqDTyth8oSUFUvDPdB8bS5
	BSWmzu2inw5jVbFb7fX6qFs/7664nbI=
Date: Tue, 21 Apr 2026 14:29:35 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: PING: [PATCH v7 0/4] Support PERF MGMT for RXE
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org
References: <20260414062948.671658-1-zhenwei.pi@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: zhenwei pi <zhenwei.pi@linux.dev>
In-Reply-To: <20260414062948.671658-1-zhenwei.pi@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org];
	TAGGED_FROM(0.00)[bounces-19446-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenwei.pi@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 5EBF2436FBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Greetings! Gentle ping.


On 4/14/26 14:29, zhenwei pi wrote:
> v7:
> - use 'counters/port_xmit_data' & 'counters/port_rcv_data' instead of
>    'hw_counters/sent_bytes' & 'hw_counters/rcvd_bytes'
> 
> v6:
> - return IB_MAD_RESULT_SUCCESS instead of 'IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY'
>    on unsupported method
> - add a script to verify the sent/rcvd bytes which is wrotten by Yanjun
> 
> v5:
> - remove patch "RDMA/core: Fix memory free for GID table", it was
>    applied by Jason separately.
> - suggested by Yanjun, use 'skb_network_offset' to calculate the
>    length of received packets.
> 
> v4:
> - drop rxe_ib_device_get_netdev and RXE_PORT, use 1 instead
> - avoid UAF to get skb length
> - remove one-line wrapper rxe_counter_get, use atomic64_read instead
> - fix memory free for GID table, this is a new patch in this series.
> 
> v3:
> - merge 'RDMA/rxe: use rxe_counter_get' into previous commit
> - zero *out* MAD memory
> - return success with error status rather than failure to avoid
>    uplayer hang
> 
> v2:
> - Fix overflow for PMA counter *link_downed_counter*
> - Use *rxe_counter_get* instead of *atomic64_read* for hw-counters
> 
> v1:
> Support PERF MGMT for RXE, add sent/received bytes for RXE counters,
> also improve coding style.
> 
> Zhu Yanjun (1):
>    selftest/rxe: Add selftests for perf
> 
> zhenwei pi (3):
>    RDMA/rxe: remove rxe_ib_device_get_netdev() and RXE_PORT
>    RDMA/rxe: add SENT/RCVD bytes
>    RDMA/rxe: support perf mgmt GET method
> 
>   drivers/infiniband/sw/rxe/Makefile            |   1 +
>   drivers/infiniband/sw/rxe/rxe_hw_counters.c   |   2 +
>   drivers/infiniband/sw/rxe/rxe_hw_counters.h   |   2 +
>   drivers/infiniband/sw/rxe/rxe_loc.h           |   6 ++
>   drivers/infiniband/sw/rxe/rxe_mad.c           | 101 ++++++++++++++++++
>   drivers/infiniband/sw/rxe/rxe_mcast.c         |   4 +-
>   drivers/infiniband/sw/rxe/rxe_net.c           |   9 +-
>   drivers/infiniband/sw/rxe/rxe_recv.c          |   2 +
>   drivers/infiniband/sw/rxe/rxe_verbs.c         |   5 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.h         |  10 +-
>   tools/testing/selftests/rdma/Makefile         |   3 +-
>   .../selftests/rdma/rxe_sent_rcvd_bytes.sh     |  75 +++++++++++++
>   12 files changed, 206 insertions(+), 14 deletions(-)
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_mad.c
>   create mode 100755 tools/testing/selftests/rdma/rxe_sent_rcvd_bytes.sh
> 


