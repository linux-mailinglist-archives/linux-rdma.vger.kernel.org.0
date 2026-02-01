Return-Path: <linux-rdma+bounces-16307-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id arS6D0NNf2k6ngIAu9opvQ
	(envelope-from <linux-rdma+bounces-16307-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Feb 2026 13:55:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FACFC5EEB
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Feb 2026 13:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48CB1300D6BB
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Feb 2026 12:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CDA33C192;
	Sun,  1 Feb 2026 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enFOZ4q9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91F626B2DA
	for <linux-rdma@vger.kernel.org>; Sun,  1 Feb 2026 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769950527; cv=none; b=SNhVMlQnkCQLo3cIvPgdpcRlUhzKtFKJ360edE54vAs6nzexrH9z6hRAXatQ4Krebqzm/hsPnTh8uF5Gmt3Keyk3VdK7zEesoMWPe3rFD69bpfPjkCMH77Vn3w4ujiIbtofcyX1Dy8sK92eAgR3PiFXZ1Njakq52IFk8jbvJgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769950527; c=relaxed/simple;
	bh=Ll+p7FbugVmgOkDvvG78t+G9ufd8XL5P5ff7wGSPmq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuY+iFeWsnxoQI+BxyzHmO6pwOyAWSRDgEKe71/IlC28yjUIimM3AbyYsCWRu42k1aC4y7NXsde7GC76H4JNbVL2tJlqfiTLKHO90C3CSKYQmZrcryrRIdKVMhhqJHxAXbhihJZcCfb4KfjjNAEAULbL3RHBdTjZSNQzp+N9kB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enFOZ4q9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58264C4CEF7;
	Sun,  1 Feb 2026 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769950527;
	bh=Ll+p7FbugVmgOkDvvG78t+G9ufd8XL5P5ff7wGSPmq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enFOZ4q95z28/O1itrf717w+++9QQwHGfDmOG0rFrZOQNXk4FcW9Pl6HwP/cjZD1K
	 4hKl35SNV09fP1i8jZlUuHSRutjmdKqLHD0S9PpODeRqYS6AxOy4vY6FKX2+bwIbRB
	 Q2xcG68B9/c4G/UYpK8L8tZFg+y5853ZpK8fmebbmMa38TQ7+YJI5wlAo4aFGGos4O
	 ys7z+gaf+6gIY5HE1I4cP+RkjL7X4SR9VWyuZRgpoqatHped9RVIhYqEELyMVJGaXf
	 Mh4bjIxiGealiQTp7l7Fh68SJwsjhSNw1LBc6UdpWudPk2opsYmgFOy0WtxUNS7BNU
	 5Kivwlb1c64ew==
Date: Sun, 1 Feb 2026 14:55:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: Re: [PATCH rdma-rext V2 2/5] RDMA/bnxt_re: Add support for QP rate
 limiting
Message-ID: <20260201125523.GC34749@unreal>
References: <20260129102133.2878811-1-kalesh-anakkur.purayil@broadcom.com>
 <20260129102133.2878811-3-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129102133.2878811-3-kalesh-anakkur.purayil@broadcom.com>
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-16307-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FACFC5EEB
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 03:51:30PM +0530, Kalesh AP wrote:
> Broadcom P7 chips supports applying rate limit to RC QPs.
> It allows adjust shaper rate values during the INIT -> RTR,
> RTR -> RTS, RTS -> RTS state changes or after QP transitions
> to RTR or RTS.
> 
> Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 17 ++++++++++++++++-
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 +++++++++++-
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  3 +++
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++++
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  5 +++++
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 ++
>  drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 13 +++++++++----
>  7 files changed, 52 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index f19b55c13d58..859e5b4e0d85 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -2089,7 +2089,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
>  	unsigned int flags;
>  	u8 nw_type;
>  
> -	if (qp_attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
> +	if (qp_attr_mask & ~(IB_QP_ATTR_STANDARD_BITS | IB_QP_RATE_LIMIT))
>  		return -EOPNOTSUPP;
>  
>  	qp->qplib_qp.modify_flags = 0;
> @@ -2129,6 +2129,21 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
>  			bnxt_re_unlock_cqs(qp, flags);
>  		}
>  	}
> +
> +	if (qp_attr_mask & IB_QP_RATE_LIMIT) {
> +		if (qp->qplib_qp.type != IB_QPT_RC ||
> +		    !_is_modify_qp_rate_limit_supported(dev_attr->dev_cap_flags2))
> +			return -EOPNOTSUPP;
> +		/* check rate limit within device limits */
> +		if (qp_attr->rate_limit > dev_attr->rate_limit_max ||
> +		    qp_attr->rate_limit < dev_attr->rate_limit_min) {
> +			ibdev_err(&rdev->ibdev, "Invalid rate_limit value\n");

Kernel rarely needs to check this. Or userspace, or FW should check it.

> +			return -EINVAL;
> +		}
> +		qp->qplib_qp.ext_modify_flags |=
> +			CMDQ_MODIFY_QP_EXT_MODIFY_MASK_RATE_LIMIT_VALID;
> +		qp->qplib_qp.rate_limit = qp_attr->rate_limit;
> +	}
>  	if (qp_attr_mask & IB_QP_EN_SQD_ASYNC_NOTIFY) {
>  		qp->qplib_qp.modify_flags |=
>  				CMDQ_MODIFY_QP_MODIFY_MASK_EN_SQD_ASYNC_NOTIFY;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> index c88f049136fc..3e44311bf939 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> @@ -1313,8 +1313,8 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
>  	struct bnxt_qplib_cmdqmsg msg = {};
>  	struct cmdq_modify_qp req = {};
>  	u16 vlan_pcp_vlan_dei_vlan_id;
> +	u32 bmask, bmask_ext;
>  	u32 temp32[4];
> -	u32 bmask;
>  	int rc;
>  
>  	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
> @@ -1329,9 +1329,16 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
>  		    is_optimized_state_transition(qp))
>  			bnxt_set_mandatory_attributes(res, qp, &req);
>  	}
> +
>  	bmask = qp->modify_flags;
>  	req.modify_mask = cpu_to_le32(qp->modify_flags);
> +	bmask_ext = qp->ext_modify_flags;
> +	req.ext_modify_mask = cpu_to_le32(qp->ext_modify_flags);
>  	req.qp_cid = cpu_to_le32(qp->id);
> +
> +	if (bmask_ext & CMDQ_MODIFY_QP_EXT_MODIFY_MASK_RATE_LIMIT_VALID)
> +		req.rate_limit = cpu_to_le32(qp->rate_limit);
> +
>  	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_STATE) {
>  		req.network_type_en_sqd_async_notify_new_state =
>  				(qp->state & CMDQ_MODIFY_QP_NEW_STATE_MASK) |
> @@ -1429,6 +1436,9 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
>  	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
>  	if (rc)
>  		return rc;
> +
> +	if (bmask_ext & CMDQ_MODIFY_QP_EXT_MODIFY_MASK_RATE_LIMIT_VALID)
> +		qp->shaper_allocation_status = resp.shaper_allocation_status;
>  	qp->cur_qp_state = qp->state;
>  	return 0;
>  }
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> index 1b414a73b46d..30c3f99be07b 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> @@ -280,6 +280,7 @@ struct bnxt_qplib_qp {
>  	u8				state;
>  	u8				cur_qp_state;
>  	u64				modify_flags;
> +	u32				ext_modify_flags;
>  	u32				max_inline_data;
>  	u32				mtu;
>  	u8				path_mtu;
> @@ -346,6 +347,8 @@ struct bnxt_qplib_qp {
>  	bool				is_host_msn_tbl;
>  	u8				tos_dscp;
>  	u32				ugid_index;
> +	u32				rate_limit;
> +	u8				shaper_allocation_status;
>  };
>  
>  #define BNXT_RE_MAX_MSG_SIZE	0x80000000
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> index 2ea3b7f232a3..43f9c564e97c 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> @@ -623,4 +623,10 @@ static inline bool _is_max_srq_ext_supported(u16 dev_cap_ext_flags_2)
>  	return !!(dev_cap_ext_flags_2 & CREQ_QUERY_FUNC_RESP_SB_MAX_SRQ_EXTENDED);
>  }
>  
> +static inline bool _is_modify_qp_rate_limit_supported(u16 dev_cap_ext_flags2)
> +{
> +	return !!(dev_cap_ext_flags2 &
> +		  CREQ_QUERY_FUNC_RESP_SB_MODIFY_QP_RATE_LIMIT_SUPPORTED);

There is no need in !! for boolean check of one bit.

Thanks

