Return-Path: <linux-rdma+bounces-18750-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCyoA2oIyGmggQUAu9opvQ
	(envelope-from <linux-rdma+bounces-18750-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 17:57:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7905934F3A4
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 17:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D1113046F09
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 16:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7AA397E8D;
	Sat, 28 Mar 2026 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aL2IMtL9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB334D923
	for <linux-rdma@vger.kernel.org>; Sat, 28 Mar 2026 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774716988; cv=none; b=f1LgfCg/lUtKntkp4tNMbeawswnFxi2ii4ZlRIE14uEnJbvaAezWW7J/MekcTOloBM14/5r9+prAev5A+wNfV3y9RDkUDOOBNZxNa/yR+lynPX2vG5BZxlR9VLRSPTBlqmZalwf61Vofl55KY9av6yhikAxVPj0lRZ88y3y4GCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774716988; c=relaxed/simple;
	bh=3l9nmKymXPRjj8SFrHRZ+GiXjCJT7ggd7HGAdxbAC3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riu6t1qZM//sDpig1AJEaQze4I/C/UeOAVBxI+v+76DWKklBekwXjGx/hNo5GkhSByV3TtWVJjRe7Bk0Rw83/Hw73JjNA9wPJA74PaH5lqfRHKRfaUvCyqEzJUJLTuiXbh4ZzIP/5e0C4oakmuXzjzNsCDKPXe7kypvZzgVJTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aL2IMtL9; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5dadbcdd-3332-45d2-941f-c9d057cd8ea5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774716974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrIeXwWC0WEuyZXrIaayiP4jZfU0IizuKeStYTAwFIU=;
	b=aL2IMtL9gSmAr16B0m+RrZ1+HNhRnZESai32+sjqVq5KcLt1hsL0/JJ66KaoiO721L9Wsh
	EdaJS+Nk5H2DZOS+V61d5mboBwgkrqX2p70rbbeWCsFW4fpQTCuyiM2L722C7X4CKpu2nP
	RE/Ip1ldn57WsJJdfNqdfLKDswDR7/s=
Date: Sat, 28 Mar 2026 09:56:09 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] RDMA/rxe: support perf mgmt
To: zhenwei pi <zhenwei.pi@linux.dev>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org
References: <20260328092839.111499-1-zhenwei.pi@linux.dev>
 <20260328092839.111499-4-zhenwei.pi@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260328092839.111499-4-zhenwei.pi@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18750-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 7905934F3A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/3/28 2:28, zhenwei pi 写道:
> In RXE, hardware counters are already supported, but not in a
> standardized manner. For instance, user-space monitoring tools like
> atop only read from the *counters* directory. Therefore, it is
> necessary to add perf management support to RXE.
> 
> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
> ---
>   drivers/infiniband/sw/rxe/Makefile    |  1 +
>   drivers/infiniband/sw/rxe/rxe_loc.h   |  6 ++
>   drivers/infiniband/sw/rxe/rxe_mad.c   | 86 +++++++++++++++++++++++++++
>   drivers/infiniband/sw/rxe/rxe_verbs.c |  1 +
>   drivers/infiniband/sw/rxe/rxe_verbs.h |  5 ++
>   5 files changed, 99 insertions(+)
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
> index 000000000000..9148f384b05c
> --- /dev/null
> +++ b/drivers/infiniband/sw/rxe/rxe_mad.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2026 zhenwei pi <zhenwei.pi@linux.dev>
> + */
> +
> +#include <rdma/ib_pma.h>
> +#include "rxe.h"
> +#include "rxe_hw_counters.h"
> +
> +static int rxe_process_pma_info(struct ib_mad *out)
> +{
> +	struct ib_class_port_info cpi = {};
> +
> +	cpi.capability_mask = IB_PMA_CLASS_CAP_EXT_WIDTH;
> +	memcpy((out->data + 40), &cpi, sizeof(cpi));
> +
> +	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
> +}
> +
> +static int rxe_process_pma_counters(struct rxe_dev *rxe, struct ib_mad *out)
> +{
> +	struct ib_pma_portcounters *pma_cnt =
> +		(struct ib_pma_portcounters *)(out->data + 40);
> +
> +	pma_cnt->link_downed_counter = rxe_counter_get(rxe, RXE_CNT_LINK_DOWNED);
> +
> +	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
> +}
> +
> +static int rxe_process_pma_counters_ext(struct rxe_dev *rxe, struct ib_mad *out)
> +{
> +	struct ib_pma_portcounters_ext *pma_cnt_ext =
> +		(struct ib_pma_portcounters_ext *)(out->data + 40);
> +
> +	pma_cnt_ext->port_xmit_data = cpu_to_be64(rxe_counter_get(rxe, RXE_CNT_SENT_BYTES) >> 2);
> +	pma_cnt_ext->port_rcv_data = cpu_to_be64(rxe_counter_get(rxe, RXE_CNT_RCVD_BYTES) >> 2);
> +	pma_cnt_ext->port_xmit_packets = cpu_to_be64(rxe_counter_get(rxe, RXE_CNT_SENT_PKTS));
> +	pma_cnt_ext->port_rcv_packets = cpu_to_be64(rxe_counter_get(rxe, RXE_CNT_RCVD_PKTS));

In rxe_process_pma_counters_ext, cpu_to_be64() is used to calculate the 
64-bit counters.

But in rxe_process_pma_counters, pma_cnt->link_downed_counter = 
rxe_counter_get(), this misses the endianness conversion. The IB spec 
requires MAD data to be in Big Endian.

struct ib_pma_portcounters {
	u8 reserved;
	u8 port_select;
	__be16 counter_select;
	__be16 symbol_error_counter;
	u8 link_error_recovery_counter;
	u8 link_downed_counter;           <--- It is u8.
	__be16 port_rcv_errors;
	__be16 port_rcv_remphys_errors;
	__be16 port_rcv_switch_relay_errors;
	__be16 port_xmit_discards;
	u8 port_xmit_constraint_errors;
	u8 port_rcv_constraint_errors;
	u8 reserved1;
	u8 link_overrun_errors; /* LocalLink: 7:4, BufferOverrun: 3:0 */
	__be16 reserved2;
	__be16 vl15_dropped;
	__be32 port_xmit_data;
	__be32 port_rcv_data;
	__be32 port_xmit_packets;
	__be32 port_rcv_packets;
	__be32 port_xmit_wait;
} __packed;

Please fix it.

> +
> +	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
> +}
> +
> +static int rxe_process_perf_mgmt(struct rxe_dev *rxe, const struct ib_mad *in,
> +				 struct ib_mad *out)
> +{
> +	switch (in->mad_hdr.attr_id) {
> +	case IB_PMA_CLASS_PORT_INFO:
> +		return rxe_process_pma_info(out);
> +
> +	case IB_PMA_PORT_COUNTERS:
> +		return rxe_process_pma_counters(rxe, out);
> +
> +	case IB_PMA_PORT_COUNTERS_EXT:
> +		return rxe_process_pma_counters_ext(rxe, out);
> +
> +	default:
> +		break;
> +	}
> +
> +	return IB_MAD_RESULT_FAILURE;
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
> +	switch (mgmt_class) {
> +	case IB_MGMT_CLASS_PERF_MGMT:
> +		if (method == IB_MGMT_METHOD_GET)

The function rxe_process_mad receives *in* MAD and populates the *out* 
MAD. Since the out buffer is eventually transmitted back to the 
caller—which could be a user-space application or a remote node on the 
network—it is important to ensure that any unassigned bytes (padding) 
within the out packet are initialized to zero. If the underlying 
framework does not pre-zero the out memory, areas outside of the 
memcpy((out->data + 40), &cpi, sizeof(cpi)) call could inadvertently 
leak sensitive residual kernel data.

Thus add this line in the function before filling in data:

memset(out->data, 0, 256);

256 is the length of out->data, please adjust this number based on the 
actual data length.

Please also consider adding support for IB_MGMT_METHOD_SET. This would 
allow the user space application to clear or reset specific metrics by 
calling atomic64_set(..., 0) on the underlying RXE counters.

Thanks a lot.
Zhu Yanjun
> +			return rxe_process_perf_mgmt(rxe, in, out);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return IB_MAD_RESULT_FAILURE;
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


