Return-Path: <linux-rdma+bounces-14260-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E03C35CBE
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 14:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D9374F1F6A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 13:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEED3164C5;
	Wed,  5 Nov 2025 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMdPfoug"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10230C61E;
	Wed,  5 Nov 2025 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348641; cv=none; b=C7sOg/Ov00Hl11x1B82bomMB8N9Dp5gWScUoqKdp3ThlUNjCJqs0fASkwej1AmQ2KKr2A+3iFB9PaYRJZUxg+YlVIelSVX0tpHdpnoZlZmIOhKPonXOcfvwKVTonOde8DVMJzEynY6fOa4ifSjajeVfFUn6vhzZROcxNcw25TLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348641; c=relaxed/simple;
	bh=bLxDqXBX8K8Vjlzjd8C7ymdM8fXtuJMsKxknQnu4/K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeaNjc6M4eu1qg88mXAvxhNe4xX3NzRDitCGVqh3CQpsaPhfNYZTtX4Hz5wRzT+3AiSB4O9UBqt7YtR6b1QUdF9Zj5kEb+RApzis0CzH2IIkoHmvxP3bXZcnRcHW2+9jfyrsV9DLYL2uV0tMqL2v/YKw8vSsMxKnG7in0WGxOZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMdPfoug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C547CC4CEF8;
	Wed,  5 Nov 2025 13:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762348641;
	bh=bLxDqXBX8K8Vjlzjd8C7ymdM8fXtuJMsKxknQnu4/K0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMdPfoug6TCmKIXTnbMF8GnCZFF3aqE12inf+YDun3vddfLfsQ6TiUriJCO53QccX
	 fFA0JI55Mr6uw+l29ZUa4d6iq1r94wT/s78sMgvxUA1VEjXM8r2dXl2hyzOkgVqPwn
	 wXU1/5YUyOgEUpYaeMte0YZbUtywZh7dL14Z9OwzQ9DC6tNjEzJ5eLtuJ7TnIaaPCQ
	 idGc6cWGwrLtQCrANjSUivztDHnhiIc4lfc3d4gezrwOUDCmT+D2w6q9inQkQWz5nj
	 Jam+1JawYgPoizGpd6zn0jQfgMUads+04AhT1yI4FgGvaCT4o9yWgwiMO8sbFpb+QP
	 3ANYPof57i0Eg==
Date: Wed, 5 Nov 2025 15:17:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/rdmavt: rdmavt_qp.h: clean up kernel-doc comments
Message-ID: <20251105131717.GF16832@unreal>
References: <20251105045127.106822-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105045127.106822-1-rdunlap@infradead.org>

On Tue, Nov 04, 2025 at 08:51:27PM -0800, Randy Dunlap wrote:
> Correct the kernel-doc comments format to avoid around 35 kernel-doc
> warnings:
> 
> - use struct keyword to introduce struct kernel-doc comments
> - use correct variable name for some struct members
> - use correct function name in comments for some functions
> - fix spelling in a few comments
> - use a ':' instead of '-' to separate struct members from their
>   descriptions
> - add a function name heading for rvt_div_mtu()
> 
> This leaves one struct member that is not described:
> rdmavt_qp.h:206: warning: Function parameter or struct member 'wq'
>  not described in 'rvt_krwq'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> ---
>  include/rdma/rdmavt_qp.h |   70 +++++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 34 deletions(-)

I applied this to RDMA tree.

➜  kernel git:(wip/leon-for-next) ./scripts/get_maintainer.pl /tmp/0001-IB-rdmavt-rdmavt_qp.h-clean-up-kernel-doc-comments.patch
Jason Gunthorpe <jgg@ziepe.ca> (maintainer:INFINIBAND SUBSYSTEM)
Leon Romanovsky <leon@kernel.org> (maintainer:INFINIBAND SUBSYSTEM)
linux-rdma@vger.kernel.org (open list:INFINIBAND SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)
INFINIBAND SUBSYSTEM status: Supported

Thanks

> 
> --- linux-next-20251103.orig/include/rdma/rdmavt_qp.h
> +++ linux-next-20251103/include/rdma/rdmavt_qp.h
> @@ -144,7 +144,7 @@
>  #define RVT_SEND_COMPLETION_ONLY	(IB_SEND_RESERVED_START << 1)
>  
>  /**
> - * rvt_ud_wr - IB UD work plus AH cache
> + * struct rvt_ud_wr - IB UD work plus AH cache
>   * @wr: valid IB work request
>   * @attr: pointer to an allocated AH attribute
>   *
> @@ -184,10 +184,10 @@ struct rvt_swqe {
>   * struct rvt_krwq - kernel struct receive work request
>   * @p_lock: lock to protect producer of the kernel buffer
>   * @head: index of next entry to fill
> - * @c_lock:lock to protect consumer of the kernel buffer
> + * @c_lock: lock to protect consumer of the kernel buffer
>   * @tail: index of next entry to pull
> - * @count: count is aproximate of total receive enteries posted
> - * @rvt_rwqe: struct of receive work request queue entry
> + * @count: count is approximate of total receive entries posted
> + * @curr_wq: struct of receive work request queue entry
>   *
>   * This structure is used to contain the head pointer,
>   * tail pointer and receive work queue entries for kernel
> @@ -309,10 +309,10 @@ struct rvt_ack_entry {
>  #define RVT_OPERATION_MAX (IB_WR_RESERVED10 + 1)
>  
>  /**
> - * rvt_operation_params - op table entry
> - * @length - the length to copy into the swqe entry
> - * @qpt_support - a bit mask indicating QP type support
> - * @flags - RVT_OPERATION flags (see above)
> + * struct rvt_operation_params - op table entry
> + * @length: the length to copy into the swqe entry
> + * @qpt_support: a bit mask indicating QP type support
> + * @flags: RVT_OPERATION flags (see above)
>   *
>   * This supports table driven post send so that
>   * the driver can have differing an potentially
> @@ -552,7 +552,7 @@ static inline struct rvt_rwqe *rvt_get_r
>  
>  /**
>   * rvt_is_user_qp - return if this is user mode QP
> - * @qp - the target QP
> + * @qp: the target QP
>   */
>  static inline bool rvt_is_user_qp(struct rvt_qp *qp)
>  {
> @@ -561,7 +561,7 @@ static inline bool rvt_is_user_qp(struct
>  
>  /**
>   * rvt_get_qp - get a QP reference
> - * @qp - the QP to hold
> + * @qp: the QP to hold
>   */
>  static inline void rvt_get_qp(struct rvt_qp *qp)
>  {
> @@ -570,7 +570,7 @@ static inline void rvt_get_qp(struct rvt
>  
>  /**
>   * rvt_put_qp - release a QP reference
> - * @qp - the QP to release
> + * @qp: the QP to release
>   */
>  static inline void rvt_put_qp(struct rvt_qp *qp)
>  {
> @@ -580,7 +580,7 @@ static inline void rvt_put_qp(struct rvt
>  
>  /**
>   * rvt_put_swqe - drop mr refs held by swqe
> - * @wqe - the send wqe
> + * @wqe: the send wqe
>   *
>   * This drops any mr references held by the swqe
>   */
> @@ -597,8 +597,8 @@ static inline void rvt_put_swqe(struct r
>  
>  /**
>   * rvt_qp_wqe_reserve - reserve operation
> - * @qp - the rvt qp
> - * @wqe - the send wqe
> + * @qp: the rvt qp
> + * @wqe: the send wqe
>   *
>   * This routine used in post send to record
>   * a wqe relative reserved operation use.
> @@ -612,8 +612,8 @@ static inline void rvt_qp_wqe_reserve(
>  
>  /**
>   * rvt_qp_wqe_unreserve - clean reserved operation
> - * @qp - the rvt qp
> - * @flags - send wqe flags
> + * @qp: the rvt qp
> + * @flags: send wqe flags
>   *
>   * This decrements the reserve use count.
>   *
> @@ -653,8 +653,8 @@ u32 rvt_restart_sge(struct rvt_sge_state
>  
>  /**
>   * rvt_div_round_up_mtu - round up divide
> - * @qp - the qp pair
> - * @len - the length
> + * @qp: the qp pair
> + * @len: the length
>   *
>   * Perform a shift based mtu round up divide
>   */
> @@ -664,8 +664,9 @@ static inline u32 rvt_div_round_up_mtu(s
>  }
>  
>  /**
> - * @qp - the qp pair
> - * @len - the length
> + * rvt_div_mtu - shift-based divide
> + * @qp: the qp pair
> + * @len: the length
>   *
>   * Perform a shift based mtu divide
>   */
> @@ -676,7 +677,7 @@ static inline u32 rvt_div_mtu(struct rvt
>  
>  /**
>   * rvt_timeout_to_jiffies - Convert a ULP timeout input into jiffies
> - * @timeout - timeout input(0 - 31).
> + * @timeout: timeout input(0 - 31).
>   *
>   * Return a timeout value in jiffies.
>   */
> @@ -690,7 +691,8 @@ static inline unsigned long rvt_timeout_
>  
>  /**
>   * rvt_lookup_qpn - return the QP with the given QPN
> - * @ibp: the ibport
> + * @rdi: rvt device info structure
> + * @rvp: the ibport
>   * @qpn: the QP number to look up
>   *
>   * The caller must hold the rcu_read_lock(), and keep the lock until
> @@ -716,9 +718,9 @@ static inline struct rvt_qp *rvt_lookup_
>  }
>  
>  /**
> - * rvt_mod_retry_timer - mod a retry timer
> - * @qp - the QP
> - * @shift - timeout shift to wait for multiple packets
> + * rvt_mod_retry_timer_ext - mod a retry timer
> + * @qp: the QP
> + * @shift: timeout shift to wait for multiple packets
>   * Modify a potentially already running retry timer
>   */
>  static inline void rvt_mod_retry_timer_ext(struct rvt_qp *qp, u8 shift)
> @@ -753,7 +755,7 @@ static inline void rvt_put_qp_swqe(struc
>  }
>  
>  /**
> - * rvt_qp_sqwe_incr - increment ring index
> + * rvt_qp_swqe_incr - increment ring index
>   * @qp: the qp
>   * @val: the starting value
>   *
> @@ -811,10 +813,10 @@ static inline void rvt_send_cq(struct rv
>  
>  /**
>   * rvt_qp_complete_swqe - insert send completion
> - * @qp - the qp
> - * @wqe - the send wqe
> - * @opcode - wc operation (driver dependent)
> - * @status - completion status
> + * @qp: the qp
> + * @wqe: the send wqe
> + * @opcode: wc operation (driver dependent)
> + * @status: completion status
>   *
>   * Update the s_last information, and then insert a send
>   * completion into the completion
> @@ -891,7 +893,7 @@ void rvt_ruc_loopback(struct rvt_qp *qp)
>  
>  /**
>   * struct rvt_qp_iter - the iterator for QPs
> - * @qp - the current QP
> + * @qp: the current QP
>   *
>   * This structure defines the current iterator
>   * state for sequenced access to all QPs relative
> @@ -913,7 +915,7 @@ struct rvt_qp_iter {
>  
>  /**
>   * ib_cq_tail - Return tail index of cq buffer
> - * @send_cq - The cq for send
> + * @send_cq: The cq for send
>   *
>   * This is called in qp_iter_print to get tail
>   * of cq buffer.
> @@ -929,7 +931,7 @@ static inline u32 ib_cq_tail(struct ib_c
>  
>  /**
>   * ib_cq_head - Return head index of cq buffer
> - * @send_cq - The cq for send
> + * @send_cq: The cq for send
>   *
>   * This is called in qp_iter_print to get head
>   * of cq buffer.
> @@ -945,7 +947,7 @@ static inline u32 ib_cq_head(struct ib_c
>  
>  /**
>   * rvt_free_rq - free memory allocated for rvt_rq struct
> - * @rvt_rq: request queue data structure
> + * @rq: request queue data structure
>   *
>   * This function should only be called if the rvt_mmap_info()
>   * has not succeeded.
> 

