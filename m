Return-Path: <linux-rdma+bounces-6266-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 579619E50DD
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 10:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991CE1883974
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AE21DE2A3;
	Thu,  5 Dec 2024 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBk9O5oL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D01DDC0A
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389642; cv=none; b=Mb+kpNrC8TyuznzffEie0QOVT3x/4PhQ5NBn0uFqXdpojGd4TvfrLTWkAKk6dPV4fcd2X+fy6Jc8aQCg/8vuKkd2KzIs2q6bhVfJ+jZzkY7+1+nUn1pZHXT4DvJDWv///PyzJCMHLb56jdv9zTSbasUMApaYrDia174YIC+iQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389642; c=relaxed/simple;
	bh=TR2p0RsAfY2BamRxlZ7a/JGigAlflrdiKoJoqnNWthI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9B88pfH4qUpX6cTpTIExyS07pA64Lh9nx213I+42CgFZqblR3KAcHrlJtVigYMxxNoeYSUnF12cFcCh5dZylPbqQ0zMIiZjvkLfQUsvdVB5unSK8FDpjqYcEUeoCffy+3RH17mjqXFM0lJDH07xe/VUClJ/nqldv5sodgWIux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBk9O5oL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588B4C4CEDE;
	Thu,  5 Dec 2024 09:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733389641;
	bh=TR2p0RsAfY2BamRxlZ7a/JGigAlflrdiKoJoqnNWthI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBk9O5oLEj9poMm7+WVgf0QNR+V7vs3qWwdfoE0EVRvWuSuE2gerg8YPwbBOz/a0P
	 k3kMaQvzjxTUaVaIU5P0Mx8NZkf1ISBkzywz9no3BiMfCFW1eSJUNRMB4VJ3eEwXkZ
	 I9sd7OVQhOiEfpSl0IEJgvNwunYgfaUzIL8eWRI8DXdQDXKyc0lvgYjHalMFRLwTTd
	 DnONuPKi78oJWpfcqkhDDzqoBgyuDLdofvljjqmO3Z2oC3vPhkAjVwhWS1dLBWGqKv
	 KOCXKLk+4zWtwG4PuNkUTi1BFS68iKzK7AL61wU4Py6k03SureL2zwpg/be2+TJyWe
	 iD07Z2EEJS46g==
Date: Thu, 5 Dec 2024 11:07:16 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH for-rc 4/5] RDMA/bnxt_re: Fix error recovery sequence
Message-ID: <20241205090716.GU1245331@unreal>
References: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
 <20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com>

On Wed, Dec 04, 2024 at 01:24:15PM +0530, Kalesh AP wrote:
> Fixed to return ENXIO from __send_message_basic_sanity()
> to indicate that device is in error state. In the case of
> ERR_DEVICE_DETACHED state, the driver should not post the
> commands to the firmware as it will time out eventually.
> 
> Removed bnxt_re_modify_qp() call from bnxt_re_dev_stop()
> as it is a no-op.
> 
> Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW error is detected")
> 

Please don't add blank line here.

> Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c       | 8 +-------
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 7 ++++---
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 3 +++
>  3 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index b7af0d5ff3b6..c143f273b759 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -1715,11 +1715,8 @@ static bool bnxt_re_is_qp1_or_shadow_qp(struct bnxt_re_dev *rdev,
>  
>  static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
>  {
> -	int mask = IB_QP_STATE;
> -	struct ib_qp_attr qp_attr;
>  	struct bnxt_re_qp *qp;
>  
> -	qp_attr.qp_state = IB_QPS_ERR;
>  	mutex_lock(&rdev->qp_lock);
>  	list_for_each_entry(qp, &rdev->qp_list, list) {
>  		/* Modify the state of all QPs except QP1/Shadow QP */
> @@ -1727,12 +1724,9 @@ static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
>  			if (qp->qplib_qp.state !=
>  			    CMDQ_MODIFY_QP_NEW_STATE_RESET &&
>  			    qp->qplib_qp.state !=
> -			    CMDQ_MODIFY_QP_NEW_STATE_ERR) {
> +			    CMDQ_MODIFY_QP_NEW_STATE_ERR)
>  				bnxt_re_dispatch_event(&rdev->ibdev, &qp->ib_qp,
>  						       1, IB_EVENT_QP_FATAL);
> -				bnxt_re_modify_qp(&qp->ib_qp, &qp_attr, mask,
> -						  NULL);
> -			}
>  		}
>  	}
>  	mutex_unlock(&rdev->qp_lock);
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> index 5e90ea232de8..c8e65169f58a 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> @@ -423,8 +423,9 @@ static int __send_message_basic_sanity(struct bnxt_qplib_rcfw *rcfw,
>  	cmdq = &rcfw->cmdq;
>  
>  	/* Prevent posting if f/w is not in a state to process */
> -	if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
> -		return bnxt_qplib_map_rc(opcode);
> +	if (RCFW_NO_FW_ACCESS(rcfw))
> +		return -ENXIO;
> +
>  	if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
>  		return -ETIMEDOUT;
>  
> @@ -493,7 +494,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
>  
>  	rc = __send_message_basic_sanity(rcfw, msg, opcode);
>  	if (rc)
> -		return rc;
> +		return rc == -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;
>  
>  	rc = __send_message(rcfw, msg, opcode);
>  	if (rc)
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> index 88814cb3aa74..4f7d800e35c3 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> @@ -129,6 +129,9 @@ static inline u32 bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
>  
>  #define RCFW_MAX_COOKIE_VALUE		(BNXT_QPLIB_CMDQE_MAX_CNT - 1)
>  #define RCFW_CMD_IS_BLOCKING		0x8000
> +#define RCFW_NO_FW_ACCESS(rcfw)						\
> +	(test_bit(ERR_DEVICE_DETACHED, &(rcfw)->cmdq.flags) ||		\
> +	 pci_channel_offline((rcfw)->pdev))

There is some disconnection between description and implementation.
ERR_DEVICE_DETACHED is set when device is suspended, at this stage all
FW commands should stop already and if they are not, bnxt_re has bugs
in cleanup path. It should flush/cancel/e.t.c and not randomly test some
bit.

In addition, pci_channel_offline() in driver which doesn't manage PCI
device looks strange to me. It should be part of bnxt core and not
related to IB.

Thanks

>  
>  #define HWRM_VERSION_DEV_ATTR_MAX_DPI  0x1000A0000000DULL
>  /* HWRM version 1.10.3.18 */
> -- 
> 2.31.1
> 

