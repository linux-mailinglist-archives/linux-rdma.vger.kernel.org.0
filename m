Return-Path: <linux-rdma+bounces-13147-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B335B484C9
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 09:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E5B173BB4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 07:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9C72E3AF1;
	Mon,  8 Sep 2025 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOqvzagB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A02E06EF
	for <linux-rdma@vger.kernel.org>; Mon,  8 Sep 2025 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315074; cv=none; b=tzw5aBSw+iJQ03Thvi91zQPeRiyFSZb52DOAkUbOGvkksFY0UiQynB3bgtwNxp41FwjkOXnmkcgyjnGfv9yeqaZfX3Kt4akS+/hLxTFg7fvFVWaYGd7t9KhPyPYIVaB96MTP2YPBq/NptAuXynVU1IJAB/xugu9wsiS+p7jtuxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315074; c=relaxed/simple;
	bh=9BxETapSLWjN3S8JGQJx9PLAGbIRUno0tu32lZ+u8Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufl14yn9kAwAOfJgQ5XTwe/+MPxoF6sPDIBcBLg0yxx8vJyUTXPKskAIJPYyyme8NOh+CQt6fB2h/FSJnhqBEgfHRABIpUH8RSLbQXrxzDpT30c0nP09+9127ST0XGP24MiydGXKS+GO6AtgJME63fnevzN8tFEAjp7baAQ5eqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOqvzagB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFB5C4CEF5;
	Mon,  8 Sep 2025 07:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757315073;
	bh=9BxETapSLWjN3S8JGQJx9PLAGbIRUno0tu32lZ+u8Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qOqvzagBZKSHm1dkZ6LCGzFqf6Qd3vuK4xMBQXJO7TYijDvxlKI3Z7lTHNmv1Nb5G
	 rqP0ohHrq/6WukLFrqeW8BRL4Lxu7SQoY8v37jNec0kzk6lvTokqDJpi3mhlWPTk3R
	 EX+cFH1sANmFAJbNT0KwNOsFbwzGaDF0vx/09gUsux/vFYw3LKs/+z1LBKNBFWQwTU
	 8MjqZ4t3RNzb0pyVvUCjvo7/cIS/EZBCimwbJU3aNRtJd034obfxuRHExvYlwmXAnJ
	 PB08sAFpeGehNfCjT24ktUVGK46V34CrJGECo8PEDL5Ir1e/5lpS3KHZjIiGDUvM78
	 4KHUmtGpsZxfg==
Date: Mon, 8 Sep 2025 10:04:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	Shravya KN <shravya.k-n@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: Re: [PATCH rdma-next 4/9] RDMA/bnxt_re: Avoid GID level QoS update
 from the driver
Message-ID: <20250908070428.GD25881@unreal>
References: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
 <20250814112555.221665-5-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814112555.221665-5-kalesh-anakkur.purayil@broadcom.com>

On Thu, Aug 14, 2025 at 04:55:50PM +0530, Kalesh AP wrote:
> From: Shravya KN <shravya.k-n@broadcom.com>
> 
> The driver inserts a VLAN header into RoCE packets when the
> traffic was untagged by modifying the existing GID entries.
> This has caused the firmware to enforce only VLAN-based
> priority mappings, ignoring other valid priority configurations
> set via APP TLVs (e.g., DSCP selectors).
> 
> Driver now has support for selecting the service level (vlan id)
> and traffic class (dscp) during modify_qp. So no need to override
> the priority update using the update gid method. Hence removing
> the code that handles the above operation.
> 
> Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
> Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c     | 94 ------------------------
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c | 40 ----------
>  2 files changed, 134 deletions(-)

<...>

> -
> -		INIT_DELAYED_WORK(&rdev->worker, bnxt_re_worker);
> -		set_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags);

You should delete worker from struct bnxt_re_dev and
BNXT_RE_FLAG_QOS_WORK_REG too.

Thanks

