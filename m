Return-Path: <linux-rdma+bounces-6660-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238449F83CF
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 20:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251171881B06
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 19:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159DF1A2632;
	Thu, 19 Dec 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="AOu0n1GA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0BC194C96
	for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2024 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635388; cv=none; b=Cv5Hu+YO0AHqFbSea4uOV6/fN/1d94v1aS6vl3ufQbx0Wx4qlvs7oESk5iSXK94WsVKL6U4771hnSgyY0y0EE8d8mDlLthgZBl//pwg8emylzMB+FjppnRPELYEvzFo3GTcmtvF4QDPflGvAVkODVSZXGXvrUkXYqEgU/vqxEK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635388; c=relaxed/simple;
	bh=+neKZhwJttOQSPggIH3NzTEjUbHkZrUntvVYjfLw1Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pR19eRrhqSHwxvBdcpa59yn1HsnFTAZWdn7uQ2E0F3K1ykiV90/s+T8AnuxVqhpT3eG1brIGQrQGlZkR9W4Ne0RDn/o5q2RPY6COmEV0Jcf7RWnJ6FpF4pRXKtWccH9KmkeVopc/RkE5PdQQzfDFeWF3WcBV93+sMrNfUj/GGo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=AOu0n1GA; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1734635383; bh=+neKZhwJttOQSPggIH3NzTEjUbHkZrUntvVYjfLw1Jc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AOu0n1GA/AEjvQWpP/ijIWVE/spKE0giPoNSnmVFqv4Gj0oVViOV2mI4IIiA8G6RP
	 DOA++s1IjbDC4LfwKX2dT+U7jM5rSCKxxBF33O1xFepqnPSvz193zRCyjwm6mNBdXZ
	 MUMUA0aNV7JgleIZJSVUwLDRP2Wmuv6hKW6GOO8aKErOVERjWq0rqtOPxjfgUUc6nK
	 P9/cHYBGDWTO0aOLa9Rng1GM9cnNZZ+hGj9BbJ6rxzgbNFcjx+qqhQZM+hM5/SAbrp
	 lxGSGv7YP7a5SF+c7bSF43tK2qv6hwhy0BbheaGK66foVrESASC88OG2UBeAwZHgG+
	 dbfa73ve04v/qyanYVwr4bau8IooTyYOo7IA4DmlvxW/YiW78WHDTtUCjyegr/DA+y
	 PREonQEgD6R5kfRU9KzZg1SgFvDeKl7L7U/7uXHlQv5Y/CEwxpJcw7d9i9dVkV3pi9
	 L/EHZv3UG4s4xL5Ao0ea7hKbDonDDvJPA/51e8cEGeiBzZy+6aoRZRk0dENPc4iIkQ
	 H1o8SedyuoKuN/QV/MZmDZxve6/bgkpjSVcT7ONwvOvMk7O1dELY4ddRbRacCHkIub
	 ABZArLTqoAsA2EU6NGTb8SAk66bAygRevRyRXYYHNxvGRxtKQzGzaGyAV/6tgM1Wj2
	 vD1Kg5U7PHZhg6k8wcKsl9mw=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 6786C18010B;
	Thu, 19 Dec 2024 20:09:42 +0100 (CET)
Message-ID: <3853b8d2-0333-4501-9002-aaa677910bb9@ijzerbout.nl>
Date: Thu, 19 Dec 2024 20:09:40 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 8/8] RDMA/erdma: Support UD QPs and UD WRs
To: Boshi Yu <boshiyu@linux.alibaba.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com,
 chengyou@linux.alibaba.com
References: <20241211020930.68833-1-boshiyu@linux.alibaba.com>
 <20241211020930.68833-9-boshiyu@linux.alibaba.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241211020930.68833-9-boshiyu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 11-12-2024 om 03:09 schreef Boshi Yu:
> The iWARP protocol supports only RC QPs previously. Now we add UD QPs
> and UD WRs support for the RoCEv2 protocol.
>
> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>   drivers/infiniband/hw/erdma/erdma_cq.c    | 20 +++++++
>   drivers/infiniband/hw/erdma/erdma_hw.h    | 37 +++++++++++-
>   drivers/infiniband/hw/erdma/erdma_qp.c    | 71 ++++++++++++++++++-----
>   drivers/infiniband/hw/erdma/erdma_verbs.c | 29 +++++++--
>   4 files changed, 136 insertions(+), 21 deletions(-)
>
> [...]
> diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
> index 03d93f026fca..4dfb4272ad86 100644
> --- a/drivers/infiniband/hw/erdma/erdma_qp.c
> +++ b/drivers/infiniband/hw/erdma/erdma_qp.c
> @@ -398,17 +398,57 @@ static int fill_sgl(struct erdma_qp *qp, const struct ib_send_wr *send_wr,
>   	return 0;
>   }
>   
> +static void init_send_sqe_rc(struct erdma_qp *qp, struct erdma_send_sqe_rc *sqe,
> +			     const struct ib_send_wr *wr, u32 *hw_op)
> +{
> +	u32 op = ERDMA_OP_SEND;
> +
> +	if (wr->opcode == IB_WR_SEND_WITH_IMM) {
> +		op = ERDMA_OP_SEND_WITH_IMM;
> +		sqe->imm_data = wr->ex.imm_data;
> +	} else if (op == IB_WR_SEND_WITH_INV) {
> +		op = ERDMA_OP_SEND_WITH_INV;
> +		sqe->invalid_stag = cpu_to_le32(wr->ex.invalidate_rkey);
> +	}
> +
> +	*hw_op = op;
> +}
> +
The else if condition is always false. Is there maybe a typo?
-- 
Kees

