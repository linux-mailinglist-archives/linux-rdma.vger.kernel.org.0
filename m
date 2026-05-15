Return-Path: <linux-rdma+bounces-20767-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PV0BBL+BmpiqgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20767-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 13:05:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B1F54E099
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 13:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 455EE30EE699
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 10:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A1E44CAC9;
	Fri, 15 May 2026 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XHbYhsu/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3044BCA5
	for <linux-rdma@vger.kernel.org>; Fri, 15 May 2026 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841565; cv=none; b=jRQU8qj8k8+2TYlL8s0sNflY67ogCdItUsUP30gwI9a8HbdDYdBN6VPq6QE6c2b/MwabF8xDf9rcNRPsnJTK4qYd2zx9eNfYx1im2zhOa6lvEZD3m+DVRk1gip88HkYaWnlfrT5vQn7OU9TYjBmqW6tgsr/P55Jtrc/ZCZVmk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841565; c=relaxed/simple;
	bh=baX5yRwBjzcnqba5gTosTuzsmuc2+nJ1s5BXDiMfmm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+PlC1ioMk+avz4QAf7l5HjZmjnBWOjF69Fq0sFqEB3kG5SsAal9J2jPWhjis4hwVE2/g/smFpi8eCPjn7PRn6N2vUf7qMCwUKs0Ke3n2CYeEGnEVbJ7xluwbedGyBrkZk4yomLl5WCj/A9wVNGJRpq9DIdhOKkAWAcV4sAwOaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XHbYhsu/; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aa21dc7c-1c68-4795-8de4-44e9021c5d04@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778841560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Gr4p4PAo819SL88WyKwUkwyrgGI7wkH/U9BAuIThzg=;
	b=XHbYhsu/KWxVwo7R7xkftdJbHWhWiBjSffPispZJdqr60eyw/nsKUDKFHLx+N/sGB2DQ9+
	nv0BJKlc5swPSTU9hLcoz+W0sYV6fEtSxV9EUPp9QypSoW6MDME110sqgjc75yz0qTc38t
	51Cf89+yNnt1e/Fmmn8t3rU8fnTxmfY=
Date: Fri, 15 May 2026 12:39:17 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] RDMA/siw: add KUnit tests for MPA receive parsing
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260513175325.2042630-1-michael.bommarito@gmail.com>
 <20260513175325.2042630-3-michael.bommarito@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <20260513175325.2042630-3-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 04B1F54E099
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20767-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,arg.data:url]
X-Rspamd-Action: no action

On 13.05.2026 19:53, Michael Bommarito wrote:

This is great code to create broken protocol headers and I
regard it very useful for testing during code development.
I am not sure though if it should become part of the siw
driver. In fact, do we want to distribute code which assists
in crashing remote systems which are running a non-fixed driver?
I don't think we should.

Furthermore, iWarp is a protocol running on top of TCP. So it is
rather simple to feed a user land TCP socket with any broken or
correct iWarp header without writing any extra kernel code.

Thanks,
Bernard.


> Add a KUnit suite (CONFIG_SIW_MPA_RX_KUNIT_TEST) that exercises the
> real siw_tcp_rx_data() path with three cases covering the MPA length
> validation added in the previous patch:
> 
>    - siw_mpa_write_underflow_rejected
>        Constructs an sk_buff carrying a tagged RDMA WRITE FPDU whose
>        mpa_len is one below iwarp_pktinfo[opcode].hdr_len -
>        MPA_HDR_SIZE.  Registers a REMOTE_WRITE MR in mem_xa so the
>        WRITE path would otherwise reach siw_proc_write(), and calls
>        siw_tcp_rx_data() directly.  Asserts the FPDU is rejected with
>        TERM(LLP/MPA/FPDU_START) and rx_suspend = 1.
> 
>    - siw_mpa_write_minimum_valid_accepted
>        Regression control with mpa_len = hdr_len - MPA_HDR_SIZE (the
>        smallest legal value, i.e. a zero-length WRITE).  Asserts the
>        new check does not fire: no terminate, rx_stream not
>        suspended.
> 
>    - siw_mpa_write_underflow_rejected_live_socket
>        Opens a loopback AF_INET socketpair via sock_create_kern(),
>        attaches a struct siw_cep as sk_user_data so sk_to_qp()
>        resolves to the test QP, and installs siw_qp_llp_data_ready as
>        sk_data_ready on the victim socket.  Writes the malformed FPDU
>        via kernel_sendmsg from the attacker side.  The kernel TCP
>        stack delivers, sk_data_ready fires in softirq, and
>        tcp_read_sock dispatches to siw_tcp_rx_data the same way a
>        remote peer would.  Asserts the same terminate state as the
>        first case.
> 
> The third case is the design driver: it confirms the bug-fix
> codepath fires from a real softirq RX entry, not just a synthetic
> direct call.  On a stock siw tree the same harness reproduces the
> KASAN slab-out-of-bounds / use-after-free in skb_copy_bits.
> 
> Bringing siw's loopback netdev up (case 3 binds 127.0.0.1) is done
> inline via dev_change_flags() under rtnl_lock since the KUnit
> environment does not run init scripts.
> 
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
>   drivers/infiniband/sw/siw/Kconfig            |  18 +
>   drivers/infiniband/sw/siw/Makefile           |   2 +
>   drivers/infiniband/sw/siw/siw_mpa_rx_kunit.c | 349 +++++++++++++++++++
>   3 files changed, 369 insertions(+)
>   create mode 100644 drivers/infiniband/sw/siw/siw_mpa_rx_kunit.c
> 
> diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
> index 186f182b80e7..b137f5920271 100644
> --- a/drivers/infiniband/sw/siw/Kconfig
> +++ b/drivers/infiniband/sw/siw/Kconfig
> @@ -18,3 +18,21 @@ config RDMA_SIW
>   	space verbs API, libibverbs. To implement RDMA over
>   	TCP/IP, the driver further interfaces with the Linux
>   	in-kernel TCP socket layer.
> +
> +config SIW_MPA_RX_KUNIT_TEST
> +	bool "KUnit tests for Soft-iWARP MPA receive parsing" if !KUNIT_ALL_TESTS
> +	depends on KUNIT && RDMA_SIW
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Build KUnit regression tests for the Soft-iWARP MPA receive
> +	  state machine. The tests cover the MPA length consistency
> +	  check in siw_get_hdr(): malformed FPDUs whose mpa_len is
> +	  below the opcode's fixed DDP/RDMAP header must be rejected
> +	  with TERM(LLP/MPA/FPDU_START); the minimum-valid mpa_len
> +	  (zero-length WRITE) must still be accepted. One case drives
> +	  the real kernel TCP receive path via a loopback socketpair
> +	  so the same softirq sk_data_ready -> tcp_read_sock ->
> +	  siw_tcp_rx_data chain a remote peer would exercise is
> +	  covered.
> +
> +	  If unsure, say N.
> diff --git a/drivers/infiniband/sw/siw/Makefile b/drivers/infiniband/sw/siw/Makefile
> index f5f7e3867889..09d4c90d8758 100644
> --- a/drivers/infiniband/sw/siw/Makefile
> +++ b/drivers/infiniband/sw/siw/Makefile
> @@ -9,3 +9,5 @@ siw-y := \
>   	siw_qp_tx.o \
>   	siw_qp_rx.o \
>   	siw_verbs.o
> +
> +siw-$(CONFIG_SIW_MPA_RX_KUNIT_TEST) += siw_mpa_rx_kunit.o
> diff --git a/drivers/infiniband/sw/siw/siw_mpa_rx_kunit.c b/drivers/infiniband/sw/siw/siw_mpa_rx_kunit.c
> new file mode 100644
> index 000000000000..204b3213b840
> --- /dev/null
> +++ b/drivers/infiniband/sw/siw/siw_mpa_rx_kunit.c
> @@ -0,0 +1,349 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * KUnit harness for siw MPA receive-state length validation.
> + *
> + * Internal to the SIW_MPA_LEN_UNDERFLOW_RX_COPY disclosure validation tree.
> + * Not part of the upstream patch.
> + *
> + *   case 1: short mpa_len triggers the new siw_get_hdr() check via direct
> + *           siw_tcp_rx_data() call with a constructed sk_buff
> + *           - expects: TERM(LLP/MPA/FPDU_START), rx_suspend=1
> + *           - under stock siw: KASAN slab-out-of-bounds in skb_copy_bits()
> + *           - under patched siw: no splat, terminate state set
> + *
> + *   case 2: minimum-valid mpa_len control (constructed sk_buff)
> + *           - mpa_len = hdr_len - MPA_HDR_SIZE  ->  fpdu_part_rem = 0
> + *             so siw_proc_write() takes the zero-length WRITE short path
> + *             and returns 0 without calling skb_copy_bits().
> + *           - expects: no TERM, state machine progressed normally
> + *
> + *   case 3: real loopback TCP socketpair (the "live two-node" analog)
> + *           - opens AF_INET TCP sockets in-kernel via sock_create_kern()
> + *           - binds/listens on 127.0.0.1:0, connects, accepts
> + *           - installs siw_qp_llp_data_ready on the victim socket and
> + *             attaches a struct siw_cep so sk_to_qp() resolves to our qp
> + *           - writes the malformed FPDU bytes via kernel_sendmsg on the
> + *             attacker socket
> + *           - the kernel TCP stack delivers, sk_data_ready fires, and
> + *             siw_qp_llp_data_ready -> tcp_read_sock -> siw_tcp_rx_data
> + *             runs in the normal kernel receive path
> + *           - expects: TERM(LLP/MPA/FPDU_START) on the qp
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/inet.h>
> +#include <linux/in.h>
> +#include <linux/netdevice.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/skbuff.h>
> +#include <linux/tcp.h>
> +#include <linux/wait.h>
> +#include <linux/xarray.h>
> +#include <net/sock.h>
> +#include <net/tcp.h>
> +#include <rdma/ib_verbs.h>
> +
> +#include "siw.h"
> +#include "siw_cm.h"
> +#include "siw_mem.h"
> +
> +static void siw_kunit_kfree_skb(void *skb)
> +{
> +	kfree_skb(skb);
> +}
> +
> +struct siw_mpa_rx_ctx {
> +	struct siw_device *sdev;
> +	struct siw_qp *qp;
> +	struct siw_mem *mem;
> +	void *target;
> +	u32 stag;
> +};
> +
> +static void siw_mpa_rx_setup(struct kunit *test, struct siw_mpa_rx_ctx *c)
> +{
> +	void *xa_ret;
> +
> +	c->stag = 0x00000100;
> +
> +	c->sdev = kunit_kzalloc(test, sizeof(*c->sdev), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, c->sdev);
> +	xa_init_flags(&c->sdev->mem_xa, XA_FLAGS_ALLOC1);
> +
> +	c->qp = kunit_kzalloc(test, sizeof(*c->qp), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, c->qp);
> +	c->qp->sdev = c->sdev;
> +	c->qp->pd = kunit_kzalloc(test, sizeof(*c->qp->pd), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, c->qp->pd);
> +	c->qp->rx_stream.state = SIW_GET_HDR;
> +
> +	c->target = kunit_kzalloc(test, 64, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, c->target);
> +
> +	c->mem = kunit_kzalloc(test, sizeof(*c->mem), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, c->mem);
> +	kref_init(&c->mem->ref);
> +	c->mem->sdev = c->sdev;
> +	c->mem->stag = c->stag;
> +	c->mem->stag_valid = 1;
> +	c->mem->va = (u64)(uintptr_t)c->target;
> +	c->mem->len = 64;
> +	c->mem->pd = c->qp->pd;
> +	c->mem->perms = IB_ACCESS_REMOTE_WRITE;
> +
> +	xa_ret = xa_store(&c->sdev->mem_xa, c->stag >> 8, c->mem, GFP_KERNEL);
> +	KUNIT_ASSERT_FALSE(test, xa_is_err(xa_ret));
> +}
> +
> +static void siw_mpa_rx_run(struct kunit *test, struct siw_mpa_rx_ctx *c,
> +			   u16 mpa_len_val)
> +{
> +	struct iwarp_rdma_write write = { };
> +	struct sk_buff *skb;
> +	read_descriptor_t rd_desc = { };
> +	u8 payload[sizeof(write) + 1];
> +
> +	write.ctrl.mpa_len = cpu_to_be16(mpa_len_val);
> +	write.ctrl.ddp_rdmap_ctrl = DDP_FLAG_TAGGED | DDP_FLAG_LAST |
> +		cpu_to_be16(DDP_VERSION << 8) |
> +		cpu_to_be16(RDMAP_VERSION << 6) |
> +		cpu_to_be16(RDMAP_RDMA_WRITE);
> +	write.sink_stag = cpu_to_be32(c->stag);
> +	write.sink_to = cpu_to_be64((u64)(uintptr_t)c->target);
> +
> +	memcpy(payload, &write, sizeof(write));
> +	payload[sizeof(write)] = 0x41;
> +
> +	skb = alloc_skb(sizeof(payload), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, skb);
> +	skb_put_data(skb, payload, sizeof(payload));
> +	kunit_add_action_or_reset(test, siw_kunit_kfree_skb, skb);
> +
> +	rd_desc.arg.data = c->qp;
> +	rd_desc.count = sizeof(payload);
> +
> +	siw_tcp_rx_data(&rd_desc, skb, 0, sizeof(payload));
> +}
> +
> +static void siw_mpa_write_underflow_rejected(struct kunit *test)
> +{
> +	struct siw_mpa_rx_ctx c;
> +
> +	siw_mpa_rx_setup(test, &c);
> +
> +	/* mpa_len one byte short of the WRITE hdr_len - MPA_HDR_SIZE floor. */
> +	siw_mpa_rx_run(test, &c,
> +		       sizeof(struct iwarp_rdma_write) - MPA_HDR_SIZE - 1);
> +
> +	KUNIT_EXPECT_EQ(test, (int)c.qp->term_info.valid, 1);
> +	KUNIT_EXPECT_EQ(test, (int)c.qp->term_info.layer,
> +			(int)TERM_ERROR_LAYER_LLP);
> +	KUNIT_EXPECT_EQ(test, (int)c.qp->term_info.etype,
> +			(int)LLP_ETYPE_MPA);
> +	KUNIT_EXPECT_EQ(test, (int)c.qp->term_info.ecode,
> +			(int)LLP_ECODE_FPDU_START);
> +	KUNIT_EXPECT_EQ(test, (int)c.qp->rx_stream.rx_suspend, 1);
> +}
> +
> +static void siw_mpa_write_minimum_valid_accepted(struct kunit *test)
> +{
> +	struct siw_mpa_rx_ctx c;
> +
> +	siw_mpa_rx_setup(test, &c);
> +
> +	/*
> +	 * mpa_len == hdr_len - MPA_HDR_SIZE is the smallest legal value;
> +	 * it yields fpdu_part_rem = 0, i.e. a zero-length WRITE. The new
> +	 * length check in siw_get_hdr() must accept this.
> +	 */
> +	siw_mpa_rx_run(test, &c,
> +		       sizeof(struct iwarp_rdma_write) - MPA_HDR_SIZE);
> +
> +	KUNIT_EXPECT_EQ(test, (int)c.qp->term_info.valid, 0);
> +	KUNIT_EXPECT_EQ(test, (int)c.qp->rx_stream.rx_suspend, 0);
> +}
> +
> +static int siw_mpa_rx_bring_up_lo(struct kunit *test)
> +{
> +	struct net_device *lo;
> +	int rv;
> +
> +	rtnl_lock();
> +	lo = __dev_get_by_name(&init_net, "lo");
> +	KUNIT_ASSERT_NOT_NULL(test, lo);
> +	if (!(lo->flags & IFF_UP))
> +		rv = dev_change_flags(lo, lo->flags | IFF_UP, NULL);
> +	else
> +		rv = 0;
> +	rtnl_unlock();
> +	KUNIT_ASSERT_EQ(test, rv, 0);
> +	return 0;
> +}
> +
> +static int siw_mpa_rx_make_pair(struct kunit *test, struct socket **listen,
> +				struct socket **server, struct socket **client)
> +{
> +	struct sockaddr_in addr = { .sin_family = AF_INET, };
> +	struct sockaddr_in bound = { };
> +	struct socket *l = NULL, *s = NULL, *c = NULL;
> +	int rv;
> +
> +	siw_mpa_rx_bring_up_lo(test);
> +
> +	rv = sock_create_kern(&init_net, AF_INET, SOCK_STREAM, IPPROTO_TCP, &l);
> +	KUNIT_ASSERT_EQ(test, rv, 0);
> +
> +	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> +	addr.sin_port = 0;
> +	rv = kernel_bind(l, (struct sockaddr_unsized *)&addr, sizeof(addr));
> +	KUNIT_ASSERT_EQ(test, rv, 0);
> +
> +	rv = l->ops->getname(l, (struct sockaddr *)&bound, 0);
> +	KUNIT_ASSERT_GT(test, rv, 0);
> +
> +	rv = kernel_listen(l, 1);
> +	KUNIT_ASSERT_EQ(test, rv, 0);
> +
> +	rv = sock_create_kern(&init_net, AF_INET, SOCK_STREAM, IPPROTO_TCP, &c);
> +	KUNIT_ASSERT_EQ(test, rv, 0);
> +
> +	rv = kernel_connect(c, (struct sockaddr_unsized *)&bound,
> +			    sizeof(bound), 0);
> +	KUNIT_ASSERT_EQ(test, rv, 0);
> +
> +	rv = kernel_accept(l, &s, 0);
> +	KUNIT_ASSERT_EQ(test, rv, 0);
> +
> +	*listen = l;
> +	*server = s;
> +	*client = c;
> +	return 0;
> +}
> +
> +static void siw_mpa_write_underflow_rejected_live_socket(struct kunit *test)
> +{
> +	struct siw_device *sdev;
> +	struct siw_qp *qp;
> +	struct siw_cep *cep;
> +	struct siw_mem *mem;
> +	struct socket *listen_sock = NULL, *server_sock = NULL, *client_sock = NULL;
> +	struct iwarp_rdma_write write = { };
> +	struct kvec iov;
> +	struct msghdr msg = { };
> +	void *xa_ret, *target;
> +	u8 payload[sizeof(write) + 1];
> +	u32 stag = 0x00000100;
> +	int rv, i;
> +
> +	sdev = kunit_kzalloc(test, sizeof(*sdev), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, sdev);
> +	xa_init_flags(&sdev->mem_xa, XA_FLAGS_ALLOC1);
> +
> +	qp = kunit_kzalloc(test, sizeof(*qp), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, qp);
> +	qp->sdev = sdev;
> +	qp->pd = kunit_kzalloc(test, sizeof(*qp->pd), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, qp->pd);
> +	qp->rx_stream.state = SIW_GET_HDR;
> +	init_rwsem(&qp->state_lock);
> +	qp->attrs.state = SIW_QP_STATE_RTS;
> +	qp->cep = NULL;
> +
> +	/* Register a valid REMOTE_WRITE memory object. On unpatched siw
> +	 * this is what lets the negative-length copy reach skb_copy_bits;
> +	 * without an MR the STag lookup in siw_proc_write() returns NULL
> +	 * and the WRITE is terminated before the underflow primitive fires.
> +	 * With this patch in place, the new siw_get_hdr() check rejects
> +	 * the FPDU BEFORE STag lookup, so the MR is unused. We keep it in
> +	 * the test so unpatched-kernel reruns also exercise the full path.
> +	 */
> +	target = kunit_kzalloc(test, 64, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, target);
> +	mem = kunit_kzalloc(test, sizeof(*mem), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, mem);
> +	kref_init(&mem->ref);
> +	mem->sdev = sdev;
> +	mem->stag = stag;
> +	mem->stag_valid = 1;
> +	mem->va = (u64)(uintptr_t)target;
> +	mem->len = 64;
> +	mem->pd = qp->pd;
> +	mem->perms = IB_ACCESS_REMOTE_WRITE;
> +	xa_ret = xa_store(&sdev->mem_xa, stag >> 8, mem, GFP_KERNEL);
> +	KUNIT_ASSERT_FALSE(test, xa_is_err(xa_ret));
> +
> +	/* siw_qp_llp_data_ready dereferences sk_user_data as siw_cep. */
> +	cep = kunit_kzalloc(test, sizeof(*cep), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, cep);
> +	cep->qp = qp;
> +	spin_lock_init(&cep->lock);
> +	kref_init(&cep->ref);
> +
> +	rv = siw_mpa_rx_make_pair(test, &listen_sock, &server_sock, &client_sock);
> +	KUNIT_ASSERT_EQ(test, rv, 0);
> +
> +	write_lock_bh(&server_sock->sk->sk_callback_lock);
> +	server_sock->sk->sk_user_data = cep;
> +	server_sock->sk->sk_data_ready = siw_qp_llp_data_ready;
> +	qp->attrs.sk = server_sock;
> +	write_unlock_bh(&server_sock->sk->sk_callback_lock);
> +
> +	write.ctrl.mpa_len =
> +		cpu_to_be16(sizeof(write) - MPA_HDR_SIZE - 1);
> +	write.ctrl.ddp_rdmap_ctrl = DDP_FLAG_TAGGED | DDP_FLAG_LAST |
> +		cpu_to_be16(DDP_VERSION << 8) |
> +		cpu_to_be16(RDMAP_VERSION << 6) |
> +		cpu_to_be16(RDMAP_RDMA_WRITE);
> +	write.sink_stag = cpu_to_be32(stag);
> +	write.sink_to = cpu_to_be64((u64)(uintptr_t)target);
> +
> +	memcpy(payload, &write, sizeof(write));
> +	payload[sizeof(write)] = 0x41;
> +
> +	iov.iov_base = payload;
> +	iov.iov_len = sizeof(payload);
> +	rv = kernel_sendmsg(client_sock, &msg, &iov, 1, sizeof(payload));
> +	KUNIT_ASSERT_EQ(test, rv, (int)sizeof(payload));
> +
> +	/* Wait for TCP to deliver bytes and sk_data_ready to fire. */
> +	for (i = 0; i < 200; i++) {
> +		if (qp->term_info.valid)
> +			break;
> +		msleep(20);
> +	}
> +
> +	KUNIT_EXPECT_EQ(test, (int)qp->term_info.valid, 1);
> +	KUNIT_EXPECT_EQ(test, (int)qp->term_info.layer,
> +			(int)TERM_ERROR_LAYER_LLP);
> +	KUNIT_EXPECT_EQ(test, (int)qp->term_info.etype,
> +			(int)LLP_ETYPE_MPA);
> +	KUNIT_EXPECT_EQ(test, (int)qp->term_info.ecode,
> +			(int)LLP_ECODE_FPDU_START);
> +	KUNIT_EXPECT_EQ(test, (int)qp->rx_stream.rx_suspend, 1);
> +
> +	/* Detach our handler before tearing down sockets so the TCP stack
> +	 * cannot call into freed kunit memory after the test.
> +	 */
> +	write_lock_bh(&server_sock->sk->sk_callback_lock);
> +	server_sock->sk->sk_user_data = NULL;
> +	server_sock->sk->sk_data_ready = sock_def_readable;
> +	write_unlock_bh(&server_sock->sk->sk_callback_lock);
> +
> +	sock_release(client_sock);
> +	sock_release(server_sock);
> +	sock_release(listen_sock);
> +}
> +
> +static struct kunit_case siw_mpa_rx_cases[] = {
> +	KUNIT_CASE(siw_mpa_write_underflow_rejected),
> +	KUNIT_CASE(siw_mpa_write_minimum_valid_accepted),
> +	KUNIT_CASE(siw_mpa_write_underflow_rejected_live_socket),
> +	{ }
> +};
> +
> +static struct kunit_suite siw_mpa_rx_suite = {
> +	.name = "siw_mpa_rx",
> +	.test_cases = siw_mpa_rx_cases,
> +};
> +
> +kunit_test_suite(siw_mpa_rx_suite);


