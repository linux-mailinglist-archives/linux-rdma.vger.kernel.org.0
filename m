Return-Path: <linux-rdma+bounces-18767-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP6VOHHPyGkNrAUAu9opvQ
	(envelope-from <linux-rdma+bounces-18767-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 09:06:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A336350FA7
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 09:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E106E303639F
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 07:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE12270ED7;
	Sun, 29 Mar 2026 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rW7q6LcW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F651C862D
	for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2026 07:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774767852; cv=none; b=cYI/m/KfiXIy9rg3O/gxDAQ9pECB2/lKzJsCclcjF+jFmdCptCpG1vBFmTXY4mVeS2vGvTjslu0qA87t+GNDFMr5IRG1t5P4xgxy9J7s2qmQWAY/QgEAc/xvskSqzWQekBR7roe7G620NwDN76oTnhPveHCVwy0WG9sSSULd8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774767852; c=relaxed/simple;
	bh=3YuDEFzv6OWQazZEvCoh4OLCLPDE6LsIcuQC07StFEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eI1p9H+gmGDc+adXQ6mG7slGzgY+Q5tYBq4JAMatvaAQ+5hi68YIO5iGWhCA5Hvj/9X4MMAhPv3k/+6lvHi4I3kfOkB4bc1MOJZiXYPJiYGEgUDMmTrvYy0fXninTA4+GBG4XuFokmmydEb+z3AT/ebWi4QE/03u81oDhlyIiLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rW7q6LcW; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <513bf712-3aae-4998-8879-314d9293c2a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774767838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IubR5hT098FLsxYFg/mWry32zs/W8mfdFLhwp8ia7h0=;
	b=rW7q6LcWMSPPUbqFnVREt/zWmbjPN+iJ9MfY9pX+ZYtzTB7oZI2eFJG+YneCDBB9q3H6/W
	5/A5cIWsDseIVBCC1fmJL6DQEx5WZh2QAO7DxCtxD69Z2yQ/i9pj2UjSgxNpV5pb+XPbz/
	ziaICBuiTX3gKoUXPzhl45d2cLlOgyc=
Date: Sun, 29 Mar 2026 00:03:53 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/3] RDMA/rxe: support perf mgmt GET method
To: zhenwei pi <zhenwei.pi@linux.dev>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org
References: <20260329054156.125362-1-zhenwei.pi@linux.dev>
 <20260329054156.125362-4-zhenwei.pi@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260329054156.125362-4-zhenwei.pi@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18767-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A336350FA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/3/28 22:41, zhenwei pi 写道:
> In RXE, hardware counters are already supported, but not in a
> standardized manner. For instance, user-space monitoring tools like
> atop only read from the *counters* directory. Therefore, it is
> necessary to add perf management support to RXE.
> 
> Also use rxe_counter_get instead of raw atomic64_read in hw-counters.
> 

Thanks a lot.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
> ---
>   drivers/infiniband/sw/rxe/Makefile          |  1 +
>   drivers/infiniband/sw/rxe/rxe_hw_counters.c |  2 +-
>   drivers/infiniband/sw/rxe/rxe_loc.h         |  6 ++
>   drivers/infiniband/sw/rxe/rxe_mad.c         | 93 +++++++++++++++++++++
>   drivers/infiniband/sw/rxe/rxe_verbs.c       |  1 +
>   drivers/infiniband/sw/rxe/rxe_verbs.h       |  5 ++
>   6 files changed, 107 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_mad.c
> 
> diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
> index 93134f1d1d0c..3c47e5b982c2 100644
> --- a/drivers/infiniband/sw/rxe/Makefile
> +++ b/drivers/infiniband/sw/rxe/Makefile
> @@ -22,6 +22,7 @@ rdma_rxe-y := \
>   	rxe_mcast.o \
>   	rxe_task.o \
>   	rxe_net.o \
> +	rxe_mad.o \
>   	rxe_hw_counters.o
>   
>   rdma_rxe-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += rxe_odp.o
> diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
> index 17edaa9a9b9b..a612e96f7a88 100644
> --- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
> +++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
> @@ -37,7 +37,7 @@ int rxe_ib_get_hw_stats(struct ib_device *ibdev,
>   		return -EINVAL;
>   
>   	for (cnt = 0; cnt < ARRAY_SIZE(rxe_counter_descs); cnt++)
> -		stats->value[cnt] = atomic64_read(&dev->stats_counters[cnt]);
> +		stats->value[cnt] = rxe_counter_get(dev, cnt);
>   
>   	return ARRAY_SIZE(rxe_counter_descs);
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 7992290886e1..a8ce85147c1f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -245,4 +245,10 @@ static inline int rxe_ib_advise_mr(struct ib_pd *pd,
>   
>   #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>   
> +/* rxe-mad.c */
> +int rxe_process_mad(struct ib_device *ibdev, int mad_flags, u32 port_num,
> +		    const struct ib_wc *in_wc, const struct ib_grh *in_grh,
> +		    const struct ib_mad *in, struct ib_mad *out,
> +		    size_t *out_mad_size, u16 *out_mad_pkey_index);
> +
>   #endif /* RXE_LOC_H */
> diff --git a/drivers/infiniband/sw/rxe/rxe_mad.c b/drivers/infiniband/sw/rxe/rxe_mad.c
> new file mode 100644
> index 000000000000..f41b8d5cdfe1
> --- /dev/null
> +++ b/drivers/infiniband/sw/rxe/rxe_mad.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2026 zhenwei pi <zhenwei.pi@linux.dev>
> + */
> +
> +#include <rdma/ib_pma.h>
> +#include "rxe.h"
> +#include "rxe_hw_counters.h"
> +
> +static int rxe_get_pma_info(struct ib_mad *out)
> +{
> +	struct ib_class_port_info cpi = {};
> +
> +	cpi.capability_mask = IB_PMA_CLASS_CAP_EXT_WIDTH;
> +	memcpy((out->data + 40), &cpi, sizeof(cpi));
> +
> +	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
> +}
> +
> +static int rxe_get_pma_counters(struct rxe_dev *rxe, struct ib_mad *out)
> +{
> +	struct ib_pma_portcounters *pma_cnt = (struct ib_pma_portcounters *)(out->data + 40);
> +	s64 val;
> +
> +	/* IBA release 1.8, 16.1.3.5: During operation, instead of overflowing, they shall stop
> +	 * at all ones.
> +	 */
> +	val = rxe_counter_get(rxe, RXE_CNT_LINK_DOWNED);
> +	if (val > U8_MAX)
> +		pma_cnt->link_downed_counter = U8_MAX;
> +	else
> +		pma_cnt->link_downed_counter = (u8)val;
> +
> +	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
> +}
> +
> +static int rxe_get_pma_counters_ext(struct rxe_dev *rxe, struct ib_mad *out)
> +{
> +	struct ib_pma_portcounters_ext *pma_cnt_ext =
> +		(struct ib_pma_portcounters_ext *)(out->data + 40);
> +
> +	pma_cnt_ext->port_xmit_data = cpu_to_be64(rxe_counter_get(rxe, RXE_CNT_SENT_BYTES) >> 2);
> +	pma_cnt_ext->port_rcv_data = cpu_to_be64(rxe_counter_get(rxe, RXE_CNT_RCVD_BYTES) >> 2);
> +	pma_cnt_ext->port_xmit_packets = cpu_to_be64(rxe_counter_get(rxe, RXE_CNT_SENT_PKTS));
> +	pma_cnt_ext->port_rcv_packets = cpu_to_be64(rxe_counter_get(rxe, RXE_CNT_RCVD_PKTS));
> +
> +	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
> +}
> +
> +static int rxe_get_perf_mgmt(struct rxe_dev *rxe, const struct ib_mad *in, struct ib_mad *out)
> +{
> +	switch (in->mad_hdr.attr_id) {
> +	case IB_PMA_CLASS_PORT_INFO:
> +		return rxe_get_pma_info(out);
> +
> +	case IB_PMA_PORT_COUNTERS:
> +		return rxe_get_pma_counters(rxe, out);
> +
> +	case IB_PMA_PORT_COUNTERS_EXT:
> +		return rxe_get_pma_counters_ext(rxe, out);
> +
> +	default:
> +		out->mad_hdr.status = cpu_to_be16(IB_MGMT_MAD_STATUS_UNSUPPORTED_METHOD_ATTRIB);
> +		return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
> +	}
> +}
> +
> +int rxe_process_mad(struct ib_device *ibdev, int mad_flags, u32 port_num,
> +		    const struct ib_wc *in_wc, const struct ib_grh *in_grh,
> +		    const struct ib_mad *in, struct ib_mad *out,
> +		    size_t *out_mad_size, u16 *out_mad_pkey_index)
> +{
> +	struct rxe_dev *rxe = to_rdev(ibdev);
> +	u8 mgmt_class = in->mad_hdr.mgmt_class;
> +	u8 method = in->mad_hdr.method;
> +
> +	if (port_num != RXE_PORT)
> +		return IB_MAD_RESULT_FAILURE;
> +
> +	memset(out, 0, sizeof(*out));
> +	switch (mgmt_class) {
> +	case IB_MGMT_CLASS_PERF_MGMT:
> +		if (method == IB_MGMT_METHOD_GET)
> +			return rxe_get_perf_mgmt(rxe, in, out);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	out->mad_hdr.status = cpu_to_be16(IB_MGMT_MAD_STATUS_UNSUPPORTED_METHOD);
> +	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
> +}
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index bcd486e8668b..7df0cb5a09a3 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1509,6 +1509,7 @@ static const struct ib_device_ops rxe_dev_ops = {
>   	.post_recv = rxe_post_recv,
>   	.post_send = rxe_post_send,
>   	.post_srq_recv = rxe_post_srq_recv,
> +	.process_mad = rxe_process_mad,
>   	.query_ah = rxe_query_ah,
>   	.query_device = rxe_query_device,
>   	.query_pkey = rxe_query_pkey,
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 2bcfb919a40b..1c4fa8eaa733 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -466,6 +466,11 @@ static inline void rxe_counter_add(struct rxe_dev *rxe, enum rxe_counters index,
>   	atomic64_add(val, &rxe->stats_counters[index]);
>   }
>   
> +static inline s64 rxe_counter_get(struct rxe_dev *rxe, enum rxe_counters index)
> +{
> +	return atomic64_read(&rxe->stats_counters[index]);
> +}
> +
>   static inline struct rxe_dev *to_rdev(struct ib_device *dev)
>   {
>   	return dev ? container_of(dev, struct rxe_dev, ib_dev) : NULL;


