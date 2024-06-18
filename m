Return-Path: <linux-rdma+bounces-3278-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9087290D908
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 18:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BAAB2899B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470B34C602;
	Tue, 18 Jun 2024 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tG4lcb0F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935934C630
	for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726864; cv=none; b=rvTlMx4ajH2pkrkOjLUAd1bfqnm3mtoi/cT4V2LazGG1ovNtqZGnUwhHPFD1czmVXlEKU9LUW4xsj70ExfGixKxSHF06JTTUU4q3w70sYRShqc8HgU/g/GUFa9Y2rm7PnEqQL3tPinlWwknZrQJatZKcORiFBkik2J0XjJNIPa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726864; c=relaxed/simple;
	bh=mxYcdCTq26eSDmRxffKDC+ZR12rjvrRcKeWVemdETPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZnoTKD3Ztmrb+gthgilFrDUZtbH1I+8DFRWxLXC1uHI4tWu1CIt9WLWYK2a2+CeT5Ix8asQE+UPd8jkBLnKP2F1Hjahp/kdZdbm6p9ICMX7jNj+0QAwjV2qRfKSrdwBXElagtRKSe9CXBMaAOdzKXqaB6Y5jVHkUHSp8EJVpkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tG4lcb0F; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4W3WqX0FBqzlgMVS;
	Tue, 18 Jun 2024 16:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718726852; x=1721318853; bh=IbPD88wHeIbMByJw6Ni+dWXf
	+0prdKlH7gqjYAmu0lk=; b=tG4lcb0F1Wu1/8hhoO2kVSihdMXuai9iJp4BMfgs
	BtGa/2oQsgolAErZu/Q0KEYh52oKWNi22iJypwgI6e2MYxn4l05JxYkTeNNPYuwl
	r4lfq3C/BJ0Htwsq3261nwwBwWT84fWxJy3u1x9bHLeCybfeZlD/LVjdl9+ty3m7
	uzzDcxac2+Yofwa9vhVx67wxwq/vt4B1L+CKMC/wUMPXRcL6UyAzSXxwn7XmKtxv
	OoZcDb8mWUBziAz1NS2MuqcagB2ow2AkBU+9Fi+6jtRsq/36W3xM6/emvcKygqxO
	6kO94ySyAfxJQl9U91qOBC3rktTs4x9eSBusWvmCws/DHQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zRDhB_nSnvNl; Tue, 18 Jun 2024 16:07:32 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4W3WqP3flczlgMVR;
	Tue, 18 Jun 2024 16:07:29 +0000 (UTC)
Message-ID: <244b708e-be75-435a-8b27-c48e976d4cdd@acm.org>
Date: Tue, 18 Jun 2024 09:07:26 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] IB/core: add support for draining Shared receive
 queues
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, shiraz.saleem@intel.com, edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-2-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240618001034.22681-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/24 5:10 PM, Max Gurtovoy wrote:
> +	if (wait_for_completion_timeout(&qp->srq_completion, 10 * HZ) > 0) {
> +		while (polled != cq->cqe) {
> +			n = ib_process_cq_direct(cq, cq->cqe - polled);
> +			if (!n)
> +				return;
> +			polled += n;
> +		}
> +	}

Why a hardcoded timeout (10 * HZ) instead of waiting forever?

Thanks,

Bart.


