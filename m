Return-Path: <linux-rdma+bounces-19145-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Gd9J6k412nwLggAu9opvQ
	(envelope-from <linux-rdma+bounces-19145-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 07:27:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3343C64B7
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 07:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BFEF30072B8
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 05:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA2F2EA749;
	Thu,  9 Apr 2026 05:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ioTLOn39"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F52F3C3E
	for <linux-rdma@vger.kernel.org>; Thu,  9 Apr 2026 05:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775712420; cv=none; b=Bqmc0pLu0ZmqekISh9mTQGXTzZm3OwaUhAa4Nwt3Ajf/vl2LMLlkSl9ixpkVBggHOyT62G/RvEAoN987GRRjbxp+ZYKTsiGpOR6PseywU7V73RxT0NKLGSXf/Yo4EhQMAxlOWApMV4mp8+iCImWf4TEPhB0reE7bQAvIP78GxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775712420; c=relaxed/simple;
	bh=6ix+a5Rm0eQUsImyIQA8KqXzYyQzzTN51y11diP5/U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ooHRJTelm05/GqgoEk0uo2E8abaIuiufa22G2QAdRbuk5hCQBIESLenYiavzrzorvQ6ESM9cdaZgbUkpvHvqP/pGdc156aDoVk8rTrFa0q5GUD813Z/Z7qNTn3QoXDVvGLz8VDSG2pEk3yTdu31P1NUu2j5c7wQNRRkq/BURg1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ioTLOn39; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c46ef990-f011-465d-be83-ddad0082d4d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775712406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D25wIH05oHnxo5lg0PiW0xA4fW+v1IyN6zMZtWyPhMY=;
	b=ioTLOn39k+igxwByGYG96lPVCL4w7i90DHkx7D2CtL/Mx9T0snFhfLY7zX2WO2Z81ouaqE
	U64Q2gsONugBpMikQxdbz/0WFC2aL8jXTDJZR7LdD43W0uoPvcmw/PorlXOsNEfadEdP10
	v95Dvtxe78KQm0isfr74XlnPmuBrkmo=
Date: Wed, 8 Apr 2026 22:26:27 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/3] Support PERF MGMT for RXE
To: zhenwei pi <zhenwei.pi@linux.dev>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org
References: <20260408000956.486522-1-zhenwei.pi@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260408000956.486522-1-zhenwei.pi@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19145-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 9B3343C64B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/4/7 17:09, zhenwei pi 写道:
> v5:
> - remove patch "RDMA/core: Fix memory free for GID table", it was
>    applied by Jason separately.
> - suggested by Yanjun, use 'skb_network_offset' to calculate the
>    length of received packets.
> 

I am not sure whether you would prefer to add a test case under 
tools/testing/selftests/rdma or in rdma-core to verify this feature.

If it is possible to include a test case in either selftests or 
rdma-core, it would be very helpful for the supporters to validate this 
patch set.

Just my two cents.

Zhu Yanjun

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
> zhenwei pi (3):
>    RDMA/rxe: remove rxe_ib_device_get_netdev() and RXE_PORT
>    RDMA/rxe: add SENT/RCVD bytes
>    RDMA/rxe: support perf mgmt GET method
> 
>   drivers/infiniband/sw/rxe/Makefile          |   1 +
>   drivers/infiniband/sw/rxe/rxe_hw_counters.c |   2 +
>   drivers/infiniband/sw/rxe/rxe_hw_counters.h |   2 +
>   drivers/infiniband/sw/rxe/rxe_loc.h         |   6 ++
>   drivers/infiniband/sw/rxe/rxe_mad.c         | 101 ++++++++++++++++++++
>   drivers/infiniband/sw/rxe/rxe_mcast.c       |   4 +-
>   drivers/infiniband/sw/rxe/rxe_net.c         |   9 +-
>   drivers/infiniband/sw/rxe/rxe_recv.c        |   2 +
>   drivers/infiniband/sw/rxe/rxe_verbs.c       |   5 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.h       |  10 +-
>   10 files changed, 129 insertions(+), 13 deletions(-)
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_mad.c
> 


