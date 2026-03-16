Return-Path: <linux-rdma+bounces-18184-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFogEaonuGnhZgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18184-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 16:54:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B230A29CCE3
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 16:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 253BE3037C1D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 15:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA823AE6E0;
	Mon, 16 Mar 2026 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZcOMDf3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795439F184
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676308; cv=none; b=kNmFmhMhVM10j6OcF+vKtINvMwwjgWQXo/TY0KJ+lpnsUqb2/VvpmVG5QMEnQeXO14dIXFUDm3265hoLE3ZjWV6pCDU9e+CL9g+xnbavbAghMKuFz295G2bz+Lgbt/FB/CkXndoAc2VVpXPzgD2YkuhyG78eqyqF3kUQuQFT/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676308; c=relaxed/simple;
	bh=M9Rxr3YJba7nY9n1j+ZirfnApTBfw33xSJmeArBfGD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep1eo91TaDNgTOcCIg1UraG9H+Aq7lj/af0H69bbxH0ZCDJxJculPhvaxwAqWiIfTkiTJyonzCjm0WpKVqtPRsS0UVnM4FyubDmLP35YlqLUJk4wQzasE76OgkWXKTeyAcgAqFMYOcpp68D/KIthx10qY0HP4smy0NBEvKYzsTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZcOMDf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A32C19425;
	Mon, 16 Mar 2026 15:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773676308;
	bh=M9Rxr3YJba7nY9n1j+ZirfnApTBfw33xSJmeArBfGD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZcOMDf3UYFJQGVlheyRtQv1n3IFWye2SQe+XVb7DxKO2yvuSL0e3WmveV8whvFnE
	 V9LLflQvJePBWVLVxJ0EaqyScHh1LYE6imwJCdMiNeUhHkRVDZ1JmRyBOfmN6eFR8h
	 drI4x2gvXC79Uatt6HAAVzOZs01j/vzPka1ybmgdCfyWFd0GVzVhTw6FDqt1TKlqgx
	 SfSO8JSCkhLIsJa3V/bASGuG/eflevCrZ5MHx1Jv4j1a8OQjoaGcPjeI6in3bDPUZn
	 Gnh7IYhrIEN7MLgMUFTMdPXkgPmfVlwDRnMcpasT2XX2m71tQ1Ozd6MnseF+Fa8/oX
	 N0nVBzQLwk6Kw==
Date: Mon, 16 Mar 2026 17:51:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	Douglas Miller <doug.miller@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next resend 01/24] RDMA/hfi2: Start hfi2 driver by
 basing off of hfi1
Message-ID: <20260316155141.GC61385@unreal>
References: <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
 <177325163046.57064.2112731243866122444.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177325163046.57064.2112731243866122444.stgit@awdrv-04.cornelisnetworks.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18184-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cornelisnetworks.com:email]
X-Rspamd-Queue-Id: B230A29CCE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 01:53:50PM -0400, Dennis Dalessandro wrote:
> The hfi1 driver has seen a near complete rewrite. Instead of trying to
> wedge all of the changes back into hfi1 we are going to deprecate the
> driver in favor of a new driver. This driver will not have the
> objectionalbe private cdev and instead will rely on the infrastructure
> provided by the ib core for doing user interaction.
> 
> This new driver will support both the old/existing chip (WFR) as well as
> the new (JKR) chip and follow on chips for 800Gbps and 1.6Tbps.
> 
> Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
> Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
> Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
> Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
> Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
> Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi2/hfi2.h | 3471 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 3471 insertions(+)
>  create mode 100644 drivers/infiniband/hw/hfi2/hfi2.h
> 
> diff --git a/drivers/infiniband/hw/hfi2/hfi2.h b/drivers/infiniband/hw/hfi2/hfi2.h
> new file mode 100644
> index 000000000000..a522f4606d3d
> --- /dev/null
> +++ b/drivers/infiniband/hw/hfi2/hfi2.h
> @@ -0,0 +1,3471 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/*
> + * Copyright(c) 2025-2026 Cornelis Networks, Inc.
> + * Copyright(c) 2015-2020 Intel Corporation.
> + */
> +
> +#ifndef _HFI2_KERNEL_H
> +#define _HFI2_KERNEL_H
> +
> +#include <linux/refcount.h>
> +#include <linux/interrupt.h>
> +#include <linux/pci.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/mutex.h>
> +#include <linux/list.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/fs.h>
> +#include <linux/completion.h>
> +#include <linux/kref.h>
> +#include <linux/sched.h>
> +#include <linux/cdev.h>
> +#include <linux/delay.h>
> +#include <linux/kthread.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-algo-bit.h>
> +#include <linux/xarray.h>
> +#include <rdma/ib_hdrs.h>
> +#include <rdma/opa_addr.h>
> +#include <linux/rhashtable.h>
> +#include <rdma/rdma_vt.h>
> +
> +struct hfi2_devdata;
> +struct hfi2_devrsrcs;

Please put these declarations in relevant header files.

> +#include "chip_registers.h"
> +#include "chip_registers_jkr.h"
> +#include "common.h"
> +#include "opfn.h"
> +#include "verbs.h"
> +#include "pio.h"
> +#include "chip.h"
> +#include "mad.h"
> +#include "qsfp.h"
> +#include "platform.h"
> +#include "affinity.h"
> +#include "msix.h"
> +#include "cport.h"
> +#ifdef CONFIG_HFI_L8SIM

This config needs to be in hfi_sim.h file.

> +#include "hfi_sim.h"
> +#endif

<...>

> +/*
> + * per driver stats, either not device nor port-specific, or
> + * summed over all of the devices and ports.
> + * They are described by name via ipathfs filesystem, so layout
> + * and number of elements can change without breaking compatibility.
> + * If members are added or deleted hfi2_statnames[] in debugfs.c must
> + * change to match.
> + */

What is ipathfs filesystem?

> +struct hfi2_ib_stats {
> +	__u64 sps_ints; /* number of interrupts handled */
> +	__u64 sps_errints; /* number of error interrupts */
> +	__u64 sps_txerrs; /* tx-related packet errors */
> +	__u64 sps_rcverrs; /* non-crc rcv packet errors */
> +	__u64 sps_hwerrs; /* hardware errors reported (parity, etc.) */
> +	__u64 sps_nopiobufs; /* no pio bufs avail from kernel */
> +	__u64 sps_ctxts; /* number of contexts currently open */
> +	__u64 sps_lenerrs; /* number of kernel packets where RHF != LRH len */
> +	__u64 sps_buffull;
> +	__u64 sps_hdrfull;
> +};
> +
> +extern struct hfi2_ib_stats hfi2_stats;
> +extern const struct pci_error_handlers hfi2_pci_err_handler;
> +
> +extern int num_driver_cntrs;

git grep shows that hfi1 has too many extern variables. Can we reduce
that number?

<...>

> +struct hfi2_ctxtdata {

<...>

> +	/* Reference count the base context usage */
> +	struct kref kref;
> +	/* numa node of this context */
> +	int numa_id;

I have very strong feeling that these two shouldn't be stored in the driver.

> +	/* same size as task_struct .comm[], command that opened context */
> +	char comm[TASK_COMM_LEN];

This is too.

> +	/* The version of the library which opened this ctxt */
> +	u32 userversion;

And this.

<...>

> +struct rvt_sge_state;

No random forward declarations, please

> +
> +/*
> + * Get/Set IB link-level config parameters for f_get/set_ib_cfg()
> + * Mostly for MADs that set or query link parameters, also ipath
> + * config interfaces
> + */

Please put the below into enum and the one after that.

> +#define HFI2_IB_CFG_LIDLMC 0 /* LID (LS16b) and Mask (MS16b) */
> +#define HFI2_IB_CFG_LWID_DG_ENB 1 /* allowed Link-width downgrade */
> +#define HFI2_IB_CFG_LWID_ENB 2 /* allowed Link-width */
> +#define HFI2_IB_CFG_LWID 3 /* currently active Link-width */
> +#define HFI2_IB_CFG_SPD_ENB 4 /* allowed Link speeds */
> +#define HFI2_IB_CFG_SPD 5 /* current Link spd */
> +#define HFI2_IB_CFG_RXPOL_ENB 6 /* Auto-RX-polarity enable */
> +#define HFI2_IB_CFG_LREV_ENB 7 /* Auto-Lane-reversal enable */
> +#define HFI2_IB_CFG_LINKLATENCY 8 /* Link Latency (IB1.2 only) */
> +#define HFI2_IB_CFG_HRTBT 9 /* IB heartbeat off/enable/auto; DDR/QDR only */
> +#define HFI2_IB_CFG_OP_VLS 10 /* operational VLs */
> +#define HFI2_IB_CFG_VL_HIGH_CAP 11 /* num of VL high priority weights */
> +#define HFI2_IB_CFG_VL_LOW_CAP 12 /* num of VL low priority weights */
> +#define HFI2_IB_CFG_OVERRUN_THRESH 13 /* IB overrun threshold */
> +#define HFI2_IB_CFG_PHYERR_THRESH 14 /* IB PHY error threshold */
> +#define HFI2_IB_CFG_LINKDEFAULT 15 /* IB link default (sleep/poll) */
> +#define HFI2_IB_CFG_PKEYS 16 /* update partition keys */
> +#define HFI2_IB_CFG_MTU 17 /* update MTU in IBC */
> +#define HFI2_IB_CFG_VL_HIGH_LIMIT 19
> +#define HFI2_IB_CFG_PMA_TICKS 20 /* PMA sample tick resolution */
> +#define HFI2_IB_CFG_PORT 21 /* switch port we are connected to */
> +
> +/*
> + * HFI or Host Link States
> + *
> + * These describe the states the driver thinks the logical and physical
> + * states are in.  Used as an argument to set_link_state().  Implemented
> + * as bits for easy multi-state checking.  The actual state can only be
> + * one.
> + */
> +#define __HLS_UP_INIT_BP	0
> +#define __HLS_UP_ARMED_BP	1
> +#define __HLS_UP_ACTIVE_BP	2
> +#define __HLS_DN_DOWNDEF_BP	3	/* link down default */
> +#define __HLS_DN_POLL_BP	4
> +#define __HLS_DN_DISABLE_BP	5
> +#define __HLS_DN_OFFLINE_BP	6
> +#define __HLS_VERIFY_CAP_BP	7
> +#define __HLS_GOING_UP_BP	8
> +#define __HLS_GOING_OFFLINE_BP  9
> +#define __HLS_LINK_COOLDOWN_BP 10
> +
> +#define HLS_UP_INIT	  BIT(__HLS_UP_INIT_BP)
> +#define HLS_UP_ARMED	  BIT(__HLS_UP_ARMED_BP)
> +#define HLS_UP_ACTIVE	  BIT(__HLS_UP_ACTIVE_BP)
> +#define HLS_DN_DOWNDEF	  BIT(__HLS_DN_DOWNDEF_BP) /* link down default */
> +#define HLS_DN_POLL	  BIT(__HLS_DN_POLL_BP)
> +#define HLS_DN_DISABLE	  BIT(__HLS_DN_DISABLE_BP)
> +#define HLS_DN_OFFLINE	  BIT(__HLS_DN_OFFLINE_BP)
> +#define HLS_VERIFY_CAP	  BIT(__HLS_VERIFY_CAP_BP)
> +#define HLS_GOING_UP	  BIT(__HLS_GOING_UP_BP)
> +#define HLS_GOING_OFFLINE BIT(__HLS_GOING_OFFLINE_BP)
> +#define HLS_LINK_COOLDOWN BIT(__HLS_LINK_COOLDOWN_BP)
> +
> +#define HLS_UP (HLS_UP_INIT | HLS_UP_ARMED | HLS_UP_ACTIVE)
> +#define HLS_DOWN ~(HLS_UP)
> +
> +#define HLS_DEFAULT HLS_DN_POLL

<...>

> +/*
> + * Possible fabric manager config parameters for fm_{get,set}_table()
> + */
> +#define FM_TBL_VL_HIGH_ARB		1 /* Get/set VL high prio weights */
> +#define FM_TBL_VL_LOW_ARB		2 /* Get/set VL low prio weights */
> +#define FM_TBL_BUFFER_CONTROL		3 /* Get/set Buffer Control */
> +#define FM_TBL_SC2VLNT			4 /* Get/set SC->VLnt */
> +#define FM_TBL_VL_PREEMPT_ELEMS		5 /* Get (no set) VL preempt elems */
> +#define FM_TBL_VL_PREEMPT_MATRIX	6 /* Get (no set) VL preempt matrix */

enum again


<...>

> +static inline void incr_cntr64(u64 *cntr)
> +{
> +	if (*cntr < (u64)-1LL)
> +		(*cntr)++;
> +}

This is too close to size_add/check_add_overflow. Let's not open-coded
variants of existing functions.

> +

<...>

> +	void (*setextled)(struct hfi2_pportdata *ppd, u32 on);
> +	void (*start_led_override)(struct hfi2_pportdata *ppd,
> +				   unsigned int timeon,
> +				   unsigned int timeoff);
> +	void (*shutdown_led_override)(struct hfi2_pportdata *ppd);
> +	void (*read_guid)(struct hfi2_devdata *dd);
> +	int (*early_per_chip_init)(struct hfi2_devdata *dd);
> +	int (*mid_per_chip_init)(struct hfi2_devdata *dd);
> +	void (*init_other)(struct hfi2_devdata *dd);
> +	int (*late_per_chip_init)(struct hfi2_devdata *dd);
> +	void (*start_port)(struct hfi2_pportdata *ppd);
> +	void (*stop_port)(struct hfi2_pportdata *ppd);
> +	void (*put_tid)(struct hfi2_ctxtdata *rcd, u32 index,
> +			u32 type, unsigned long pa, u16 order, bool flush);
> +	void (*rcv_array_wc_fill)(struct hfi2_ctxtdata *rcd, u32 index,
> +				  u32 type);
> +	void (*set_port_tid_config)(struct hfi2_devdata *dd, int pidx, u16 ctxt,
> +				    u32 eager_base, u16 alloced,
> +				    u32 expected_base, u32 expected_count);
> +	void (*set_port_max_mtu)(struct hfi2_pportdata *ppd, u32 maxvlmtu);
> +	void (*update_rcv_hdr_size)(struct hfi2_pportdata *ppd, u16 ctxt,
> +				    u32 size);
> +	bool (*check_synth_status)(struct hfi2_devdata *dd);
> +	void (*update_synth_status)(struct hfi2_devdata *dd);
> +	u64 (*create_pbc)(struct hfi2_pportdata *ppd, bool loopback, u64 flags,
> +			  int srate_mbs, u32 vl, u32 dw_len, u32 l2, u32 dlid, u32 sctxt);
> +	void (*set_pio_integrity)(struct hfi2_devdata *dd, u32 pidx, u32 ctxt, int type,
> +				  enum spi_cmds cmd);
> +	int (*find_used_resources)(struct hfi2_devdata *dd);
> +	void (*read_link_quality)(struct hfi2_pportdata *ppd, u8 *link_quality);
> +	void (*set_rheq_addr)(struct hfi2_devdata *dd, u16 ctxt, u64 dma_addr);
> +	void (*handle_link_bounce)(struct work_struct *work);
> +	void (*enable_rcv_context)(struct hfi2_pportdata *ppd, u16 ctxt,
> +				   u64 *kctxt_ctrl, bool enable);

Do you really need function pointers inside driver? It makes possible refactoring harder.

> +};

<...>

> +/*
> + * This determines the source for data to fill-in dd->rsrcs.
> + */
> +#define HFI_SRIOV_MOD_PARAMS

What value should it be defined to?

> +

<...>

> +/* hfi2_put_tid types */
> +#define PT_EXPECTED       0
> +#define PT_EAGER          1

It is amazing how many times you already defined 0 and 1 :).

> +
> +struct tid_rb_node;

<...>

> +/**
> + * hfi2_rcd_head - add accessor for rcd head
> + * @rcd: the context
> + */
> +static inline u32 hfi2_rcd_head(struct hfi2_ctxtdata *rcd)
> +{
> +	return rcd->head;
> +}
> +
> +/**
> + * hfi2_set_rcd_head - add accessor for rcd head
> + * @rcd: the context
> + * @head: the new head
> + */
> +static inline void hfi2_set_rcd_head(struct hfi2_ctxtdata *rcd, u32 head)
> +{
> +	rcd->head = head;
> +}

Do we really need to define such basic operation?

> +
> +/* calculate the current RHF address */
> +static inline __le32 *get_rhf_addr(struct hfi2_ctxtdata *rcd)
> +{
> +	return (__le32 *)rcd->rcvhdrq + rcd->head + rcd->rhf_offset;
> +}
> +
> +/* return DMA_RTAIL configuration */
> +static inline bool get_dma_rtail_setting(struct hfi2_ctxtdata *rcd)
> +{
> +	return !!HFI2_CAP_KGET_MASK(rcd->flags, DMA_RTAIL);
> +}

Same question.

> +

<...>

> +/**
> + * hfi2_seq_cnt - return seq_cnt member
> + * @rcd: the receive context
> + *
> + * Return seq_cnt member
> + */
> +static inline u8 hfi2_seq_cnt(struct hfi2_ctxtdata *rcd)
> +{
> +	return rcd->seq_cnt;
> +}
> +
> +/**
> + * hfi2_set_seq_cnt - return seq_cnt member
> + * @rcd: the receive context
> + *
> + * Return seq_cnt member
> + */
> +static inline void hfi2_set_seq_cnt(struct hfi2_ctxtdata *rcd, u8 cnt)
> +{
> +	rcd->seq_cnt = cnt;
> +}
> +
> +/**
> + * last_rcv_seq - is last
> + * @rcd: the receive context
> + * @seq: sequence
> + *
> + * return true if last packet
> + */
> +static inline bool last_rcv_seq(struct hfi2_ctxtdata *rcd, u32 seq)
> +{
> +	return seq != rcd->seq_cnt;
> +}

Again

> +
> +/**
> + * rcd_seq_incr - increment context sequence number
> + * @rcd: the receive context
> + * @seq: the current sequence number
> + *
> + * Returns: true if the this was the last packet
> + */
> +static inline bool hfi2_seq_incr(struct hfi2_ctxtdata *rcd, u32 seq)
> +{
> +	rcd->seq_cnt = hfi2_seq_incr_wrap(rcd->seq_cnt);
> +	return last_rcv_seq(rcd, seq);
> +}
> +
> +/**
> + * get_hdrqentsize - return hdrq entry size
> + * @rcd: the receive context
> + */
> +static inline u8 get_hdrqentsize(struct hfi2_ctxtdata *rcd)
> +{
> +	return rcd->rcvhdrqentsize;
> +}

Again, and again and again ....

> +
> +#define DEFAULT_HDRQ_ENTSIZE 32

<...>

> +	if (link_speed == OPA_LINK_SPEED_100G)
> +		egress_rate = 100000;
> +	else if (link_speed == OPA_LINK_SPEED_50G)
> +		egress_rate = 50000;
> +	else if (link_speed == OPA_LINK_SPEED_25G)
> +		egress_rate = 25000;
> +	else /* assume OPA_LINK_SPEED_12_5G */
> +		egress_rate = 12500;

It is switch-case.

> +

<...>

> +/* MTU enumeration, 256-4k match IB */
> +#define OPA_MTU_0     0
> +#define OPA_MTU_256   1
> +#define OPA_MTU_512   2
> +#define OPA_MTU_1024  3
> +#define OPA_MTU_2048  4
> +#define OPA_MTU_4096  5

enum

> +
> +u32 lrh_max_header_bytes(struct hfi2_pportdata *ppd);
> +int mtu_to_enum(u32 mtu, int default_if_bad);
> +u16 enum_to_mtu(int mtu);
> +static inline int valid_ib_mtu(unsigned int mtu)
> +{
> +	return mtu == 256 || mtu == 512 ||
> +		mtu == 1024 || mtu == 2048 ||
> +		mtu == 4096;
> +}

switch-case

> +
> +static inline int valid_opa_max_mtu(unsigned int mtu)
> +{
> +	return mtu >= 2048 &&
> +		(valid_ib_mtu(mtu) || mtu == 8192 || mtu == 10240);
> +}

No to module parameter.


<...>

> +/*
> + * Called by readers of cc_state only, must call under rcu_read_lock().
> + */
> +static inline struct cc_state *get_cc_state(struct hfi2_pportdata *ppd)
> +{
> +	return rcu_dereference(ppd->cc_state);
> +}
> +
> +/*
> + * Called by writers of cc_state only,  must call under cc_state_lock.
> + */
> +static inline
> +struct cc_state *get_cc_state_protected(struct hfi2_pportdata *ppd)
> +{
> +	return rcu_dereference_protected(ppd->cc_state,
> +					 lockdep_is_held(&ppd->cc_state_lock));
> +}

No to redeine of basic kernel coding routines.


<...>

> +/*
> + * Flush write combining store buffers (if present) and perform a write
> + * barrier.
> + */
> +static inline void flush_wc(void)
> +{
> +	asm volatile("sfence" : : : "memory");
> +}

It is very unexpected to see asm code in the driver. I'm aware that it
is from hfi1, but it doesn't mean that you should copy it to new code.

> +
> +void handle_eflags(struct hfi2_packet *packet);
> +void seqfile_dump_rcd(struct seq_file *s, struct hfi2_ctxtdata *rcd);
> +
> +/* global module parameter variables */

Let's remove module parameters for now.

> +extern unsigned int hfi2_max_mtu;
> +extern unsigned int hfi2_cu;
> +extern unsigned int user_credit_return_threshold;
> +extern int num_user_contexts;
> +extern unsigned long n_krcvqs;
> +extern uint krcvqs[];
> +extern int krcvqsset;
> +extern uint loopback;
> +extern uint quick_linkup;
> +extern uint rcv_intr_timeout;
> +extern uint rcv_intr_count;
> +extern uint rcv_intr_dynamic;
> +extern ushort link_crc_mask;
> +
> +extern struct mutex hfi2_mutex;
> +
> +/* Number of seconds before our card status check...  */
> +#define STATUS_TIMEOUT 60
> +
> +#define DRIVER_NAME		"hfi2"
> +#define HFI2_USER_MINOR_BASE     0
> +#define HFI2_TRACE_MINOR         127
> +#define HFI2_NMINORS             255
> +
> +#define PCI_VENDOR_ID_INTEL 0x8086

This is already defined in include/linux/pci_ids.h

> +#define PCI_DEVICE_ID_INTEL0 0x24f0
> +#define PCI_DEVICE_ID_INTEL1 0x24f1
> +#define PCI_VENDOR_ID_CORNELIS 0x434e
> +#define PCI_DEVICE_ID_CORNELIS_CN5000 0x0001
> +#define PCI_SUBDEVICE_CN5000_DUAL_PORT 0x0002
> +#define PCI_SUBDEVICE_CN5000_SINGLE_PORT_PS 0x0003 /* PS = Port Swap */
> +#define PCI_SUBDEVICE_CN5000_DUAL_PORT_PS 0x0004
> +
> +/* create a ULL mask out of the given number of bits */
> +#define MASK_ULL(bits) ((1ull << (bits)) - 1)

It is basic


<...>

> +#define dd_dev_emerg(dd, fmt, ...) \
> +	dev_emerg(&(dd)->pcidev->dev, "%s: " fmt, \
> +		  rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), ##__VA_ARGS__)
> +
> +#define dd_dev_err(dd, fmt, ...) \
> +	dev_err(&(dd)->pcidev->dev, "%s: " fmt, \
> +		rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), ##__VA_ARGS__)
> +
> +#define dd_dev_err_ratelimited(dd, fmt, ...) \
> +	dev_err_ratelimited(&(dd)->pcidev->dev, "%s: " fmt, \
> +			    rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), \
> +			    ##__VA_ARGS__)
> +
> +#define dd_dev_warn(dd, fmt, ...) \
> +	dev_warn(&(dd)->pcidev->dev, "%s: " fmt, \
> +		 rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), ##__VA_ARGS__)
> +
> +#define dd_dev_warn_ratelimited(dd, fmt, ...) \
> +	dev_warn_ratelimited(&(dd)->pcidev->dev, "%s: " fmt, \
> +			     rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), \
> +			     ##__VA_ARGS__)
> +
> +#define dd_dev_info(dd, fmt, ...) \
> +	dev_info(&(dd)->pcidev->dev, "%s: " fmt, \
> +		 rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), ##__VA_ARGS__)
> +
> +#define dd_dev_info_ratelimited(dd, fmt, ...) \
> +	dev_info_ratelimited(&(dd)->pcidev->dev, "%s: " fmt, \
> +			     rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), \
> +			     ##__VA_ARGS__)
> +
> +#define dd_dev_dbg(dd, fmt, ...) \
> +	dev_dbg(&(dd)->pcidev->dev, "%s: " fmt, \
> +		rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), ##__VA_ARGS__)
> +
> +#define hfi2_dev_porterr(dd, port, fmt, ...) \
> +	dev_err(&(dd)->pcidev->dev, "%s: port %u: " fmt, \
> +		rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), (port), ##__VA_ARGS__)
> +
> +#define ppd_dev_err(ppd, fmt, ...) \
> +	dev_err(&(ppd)->dd->pcidev->dev, "%s.%u: " fmt, \
> +		rvt_get_ibdev_name(&(ppd)->dd->verbs_dev.rdi), (ppd)->hw_pidx, \
> +		##__VA_ARGS__)
> +
> +#define ppd_dev_warn(ppd, fmt, ...) \
> +	dev_warn(&(ppd)->dd->pcidev->dev, "%s.%u: " fmt, \
> +		 rvt_get_ibdev_name(&(ppd)->dd->verbs_dev.rdi), (ppd)->hw_pidx, \
> +		 ##__VA_ARGS__)
> +
> +#define ppd_dev_warn_ratelimited(ppd, fmt, ...) \
> +	dev_warn_ratelimited(&(ppd)->dd->pcidev->dev, "%s.%u: " fmt, \
> +			     rvt_get_ibdev_name(&(ppd)->dd->verbs_dev.rdi), (ppd)->hw_pidx, \
> +			     ##__VA_ARGS__)
> +
> +#define ppd_dev_info(ppd, fmt, ...) \
> +	dev_info(&(ppd)->dd->pcidev->dev, "%s.%u: " fmt, \
> +		 rvt_get_ibdev_name(&(ppd)->dd->verbs_dev.rdi), (ppd)->hw_pidx, \
> +		 ##__VA_ARGS__)

ibdev_* prints for any new code.


<...>

> +static inline bool rhe_crk_err(struct hfi2_packet *packet)
> +{
> +	/* same bit location on WFR, JKR; different u64 */
> +	return !!(packet->err_flags & RHF_DC_ERR);
> +}
> +
> +static inline bool rhe_tid_err(struct hfi2_packet *packet)
> +{
> +	/* same bit location on WFR, JKR; different u64 */
> +	return !!(packet->err_flags & RHF_TID_ERR);
> +}
> +
> +static inline bool rhe_len_err(struct hfi2_packet *packet)
> +{
> +	/* same bit location on WFR, JKR; different u64 */
> +	return !!(packet->err_flags & RHF_LEN_ERR);
> +}
> +
> +static inline bool rhe_icrc_err(struct hfi2_packet *packet)
> +{
> +	/* same bit location on WFR, JKR; different u64 */
> +	return !!(packet->err_flags & RHF_ICRC_ERR);
> +}

bool type doesn't need !! operator.

Thanks

