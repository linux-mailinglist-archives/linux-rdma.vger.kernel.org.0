Return-Path: <linux-rdma+bounces-5576-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9681D9B2F72
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 12:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2490EB20F3B
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 11:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBDE1D3648;
	Mon, 28 Oct 2024 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn6aFT42"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D90189B8D
	for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116755; cv=none; b=BJ0bWMn2oBQm90EwCV+jUjyZGvAjs1Jot6WXU3RKcrHtE7Zukx/dTEHt7kztfT/6V1MCxnBkxLPOHAGc5i8YJE86PtP3BHJ+giu0WufvwMGgCCnQGQStXH48ioY285Om2MYFxXY7qASXturliVd0FA/AiJo/qVgeEYCnNizP5TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116755; c=relaxed/simple;
	bh=yiVJ+xsNynxrBCO9skdBjyzUB/FYfeYy0F42UNdVGoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0zuW7V4Kd6cMgeQRRtTy6aFrk17qlWmQFphWb+C8igQNAOomZ71J9KxGyqvl/5V/bRpIgNhhsKkhk8+WTrYME0CQK25nf7KLiypVFh9rf4yhyqAoz/75sYhxMPVXgUtIDQafa4yyQ39/e10QRkk9c6su6oh/wPqWLo0H8wV3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vn6aFT42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C9DC4CEC3;
	Mon, 28 Oct 2024 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730116753;
	bh=yiVJ+xsNynxrBCO9skdBjyzUB/FYfeYy0F42UNdVGoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vn6aFT42m2x7uIa0kDikLBjjBB4XEGxJQnPf5X16mlW+K7tYUjJHQX6Hq0Cr53AeI
	 t2VhTTBULXV8OwiiEA4WXQusD6F84JEJRKCKTE66De9RDxaTxeSuq31vJqLZ6281K/
	 iLO4udQQCaJdJQi8fcuVA6Q5+Sp8RCyXoDajCYd8+83Qfy2riSl/UmQABXAgZPjoFv
	 ztJZrKrq//4avZUJSyOu5xoLxlvexu4MkYE8Zi61GnDte2FWmkxXQNmuhgFcKtpXgT
	 s5TExGGGfN/TXp140iH0gFyie8wHflcJNiQdlt71JR2vkt+UjNicG5bqf8KxkShl8b
	 lxswoM9DCvfiQ==
Date: Mon, 28 Oct 2024 13:59:08 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH for-next v2 1/4] RDMA/bnxt_re: Add support for optimized
 modify QP
Message-ID: <20241028115908.GF1615717@unreal>
References: <1728928561-25607-1-git-send-email-selvin.xavier@broadcom.com>
 <1728928561-25607-2-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728928561-25607-2-git-send-email-selvin.xavier@broadcom.com>

On Mon, Oct 14, 2024 at 10:55:58AM -0700, Selvin Xavier wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> Modify QP improvements are for state transitions
> from INIT -> RTR and RTR -> RTS.
> In order to support the Modify QP Optimization feature,
> the driver is expected to check for the feature support
> in the CMDQ_QUERY_FUNC and register its support for this
> feature with the FW in CMDQ_INITIALIZE_FIRMWARE.
> 
> Additionally, the driver is required to specify the new
> fields and attribute masks for the transitions as follows:
> 1. INIT -> RTR:
>    - New fields: srq_used, type.
>    - enable srq_used when RC QP is configured to use SRQ.
>    - set the type based on the QP type.
>    - Mandatory masks:
>      - RC: CMDQ_MODIFY_QP_MODIFY_MASK_ACCESS,
>            CMDQ_MODIFY_QP_MODIFY_MASK_PKEY
>      - UD QP and QP1: CMDQ_MODIFY_QP_MODIFY_MASK_PKEY,
>                       CMDQ_MODIFY_QP_MODIFY_MASK_QKEY
> 2. RTR -> RTS:
>    - New fields: type
>    - set the type based on the QP type.
>    - Mandatory masks:
>      - RC: CMDQ_MODIFY_QP_MODIFY_MASK_ACCESS
>      - UD QP and QP1: CMDQ_MODIFY_QP_MODIFY_MASK_QKEY
> 
> Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> Reviewed-by: Tushar Rane <tushar.rane@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 40 ++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  6 ++++-
>  drivers/infiniband/hw/bnxt_re/qplib_res.h  |  5 ++++
>  drivers/infiniband/hw/bnxt_re/roce_hsi.h   |  3 +++
>  4 files changed, 53 insertions(+), 1 deletion(-)

<...>

> diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> index 3ec8952..69d50d7 100644
> --- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> +++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> @@ -216,6 +216,8 @@ struct cmdq_initialize_fw {
>  	__le16	flags;
>  	#define CMDQ_INITIALIZE_FW_FLAGS_MRAV_RESERVATION_SPLIT          0x1UL
>  	#define CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED     0x2UL
> +	#define CMDQ_INITIALIZE_FW_FLAGS_DRV_VERSION                     0x4UL

Where is this define used?

> +	#define CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED    0x8UL

Thanks

