Return-Path: <linux-rdma+bounces-7083-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42115A16101
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 10:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129C63A61C7
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2408C199E8D;
	Sun, 19 Jan 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkVju9UB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E118785D
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737280676; cv=none; b=RbTfU6pWKEGmJKoh9MPv/EZ86pmeBw7aE/c+nfNAOO71e/HL/khL2aJnX2Ga3VQAxRh5AXpjji3VToFdhrmVXEytbepUK3a5VA5BSCdpx2eKYrobOfL+gGzxNTLoLAUaoqnQZnzDY8s+Q//JuXNYa2TuC4Aan1D6dhnxYsDkqUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737280676; c=relaxed/simple;
	bh=bRJ3o8CKyjDTbCqKeoYq0s6c21YTvBEzMSnGq/3N24w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkwiW1sGw8HasKgka60xJNEabu7tsEeZPptbJ52M09KKOPl7HW9M3vVRK6MOJ9L6JgawwxLLSxT80fmlKbOnsMFXPBXDZSe95LPseDXVhCWvm1WgqwxwB3eBHkloodlNm0gtHXYlc4efpb9xQ9hVlk6eqRQm7stRzPdswtvfa78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkVju9UB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C5EC4CED6;
	Sun, 19 Jan 2025 09:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737280676;
	bh=bRJ3o8CKyjDTbCqKeoYq0s6c21YTvBEzMSnGq/3N24w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fkVju9UB2mL05/Yyb4eH1LRp9r+HYZII0NyoYFv1aIHkwd2UxMxmUny65qspv7tPZ
	 /l5RWly0zy5ASGavB/56T9uDoBmOBEt70mtQJNPhobzEs91y8L0pssP4VxBVr3v49/
	 dGWUyYz/8oBde+QB2gpuDUslxPtukMgvHCpogND6pmAmybEpVF+Qh6MkR2u/o7BIfp
	 1Zycm9QRrf5BD1vjZPLBjNj2uqs5FGLzhRIbSye+7uaGdozkbFOfIwhlYxLyw9lXUG
	 xDQvs8+tqV/8A/pYd9rz4ptyUKIoYo3RkvykJ8yuHfC1dTbtGQhOdKYJdHa57K+rBh
	 bF/x500SCO8Ew==
Date: Sun, 19 Jan 2025 11:57:50 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Congestion control settings using
 debugfs hook
Message-ID: <20250119095750.GC21007@unreal>
References: <1737174544-2059-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1737174544-2059-1-git-send-email-selvin.xavier@broadcom.com>

On Fri, Jan 17, 2025 at 08:29:04PM -0800, Selvin Xavier wrote:
> Implements routines to set and get different settings  of
> the congestion control. This will enable the users to modify
> the settings according to their network.
> 
> Currently supporting only GEN 0 version of the parameters.
> Reading these files queries the firmware and report the values
> currently programmed. Writing to the files sends commands that
> update the congestion control settings.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h |   2 +
>  drivers/infiniband/hw/bnxt_re/debugfs.c | 215 +++++++++++++++++++++++++++++++-
>  drivers/infiniband/hw/bnxt_re/debugfs.h |  15 +++
>  3 files changed, 231 insertions(+), 1 deletion(-)

<...>

> +static const char * const bnxt_re_cc_gen0_name[] = {
> +	"enable_cc",
> +	"g",

????

> +	"num_phase_per_state",
> +	"init_cr",
> +	"init_tr",
> +	"tos_ecn",
> +	"tos_dscp",
> +	"alt_vlan_pcp",
> +	"alt_vlan_dscp",
> +	"rtt",
> +	"cc_mode",
> +	"tcp_cp",
> +	"tx_queue",
> +	"inactivity_cp",
> +};

<...>

> +static int map_cc_config_offset_gen0_ext0(u32 offset, struct bnxt_qplib_cc_param *ccparam, u32 *val)
> +{
> +	u64 map_offset;
> +
> +	map_offset = BIT(offset);
> +
> +	switch (map_offset) {
> +	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ENABLE_CC:
> +		*val = ccparam->enable;
> +		break;
> +	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_G:
> +		*val = ccparam->g;
> +		break;
> +	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_NUMPHASEPERSTATE:
> +		*val = ccparam->nph_per_state;
> +		break;
> +	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INIT_CR:
> +		*val = ccparam->init_cr;
> +		break;
> +	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INIT_TR:
> +	       *val = ccparam->init_tr;
> +		break;
> +	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_ECN:
> +	       *val = ccparam->tos_ecn;
> +		break;
> +	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_DSCP:
> +	       *val =  ccparam->tos_dscp;
> +	break;

Wrong indentations, above and below.

> +	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ALT_VLAN_PCP:
> +		*val = ccparam->alt_vlan_pcp;
> +		break;
> +	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ALT_TOS_DSCP:
> +		*val = ccparam->alt_tos_dscp;
> +		break;
> +	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_RTT:
> +	       *val = ccparam->rtt;
> +		break;
> +	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_CC_MODE:
> +	      *val = ccparam->cc_mode;
> +		break;
> +	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TCP_CP:
> +	     *val =  ccparam->tcp_cp;
> +		break;
> +	default:
> +	     return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t bnxt_re_cc_config_get(struct file *filp, char __user *buffer,
> +				     size_t usr_buf_len, loff_t *ppos)
> +{
> +	struct bnxt_re_cc_param *dbg_cc_param = filp->private_data;
> +	struct bnxt_re_dev *rdev = dbg_cc_param->rdev;
> +	struct bnxt_qplib_cc_param ccparam = {};
> +	u32 offset = dbg_cc_param->offset;
> +	char buf[16];
> +	u32 val;
> +	int rc;
> +
> +	rc = bnxt_qplib_query_cc_param(&rdev->qplib_res, &ccparam);
> +	if (rc) {
> +		dev_err(rdev_to_dev(rdev),
> +			"%s: Failed to query CC parameters\n", __func__);

Let's not have debug print, and especially dev_err here.

> +		return -EINVAL;

bnxt_qplib_query_cc_param() can return ENOMEM, there is no need to
overwrite return value.

> +	}
> +
> +	rc = map_cc_config_offset_gen0_ext0(offset, &ccparam, &val);
> +	if (rc)
> +		return rc;
> +
> +	rc = snprintf(buf, sizeof(buf), "%d\n", val);
> +	if (rc < 0)
> +		return rc;
> +
> +	return simple_read_from_buffer(buffer, usr_buf_len, ppos, (u8 *)(buf), rc);
> +}
> +

