Return-Path: <linux-rdma+bounces-11592-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DD2AE6BE1
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 17:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE5FB7A49B2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 15:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B86B274B4A;
	Tue, 24 Jun 2025 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Q4Vkeu+u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD6926CE2C;
	Tue, 24 Jun 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780476; cv=none; b=URg+H5ic8LZyrnPKX3o46jCcdpSqcdZDLPhyNH1qVSExNsdL+lLNUvZhELh/iSnmdH+owT2ixjBvDsgYr5uOkeKDxM49XfiBx2RVMi8FZcXH/kFdup3p7n+0R5YCLoQVGEwFnQrKv8opoSl8eVzlNPYH/BAIlRvJGjXysHdCjMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780476; c=relaxed/simple;
	bh=mE01Vj7YSsd6YYOQ6b7mmobTKagMRImGlSL8Pb3aiBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHaCpKE0AEmtRe0HPYkgv6Fdrpfdsa1HLozaB81lM0+mwicLMebQ8BTI6Qk4Ur9iHdYLqM1nLL0QD0WRucJatqJJSFA296kUNvSletNf2srWeT8guAXfzOr7sLkurcGD1EwwyoWpEiqohS0AdJ3PuTMfnSYc4W1ssoWoc9RXlik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Q4Vkeu+u; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bRTz73brpzm0yQf;
	Tue, 24 Jun 2025 15:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750780465; x=1753372466; bh=G1eINb8Ntv6IxHqE84T/7Pg5
	OylXDx7Wree6n/+Htsw=; b=Q4Vkeu+u3gEQYjBJlgrYFFbtcuNXh46Oy9BkpMI7
	30z72V22fS/hK9CdXo3y3oJreGud2x801fzUmdbA46osKbtFxT6j9qf3q8cC0eOi
	rAvr4gpK5LuR5GNOYM5do6mSh+7JYmWiQun7ykykVwYD+FtXMhHiFr+AZ+o5r4Hk
	dBG0EhVXMJlT+mxqaQLV6uLExZlLrp3H60O5OwUZSvIIn8QoamzpHPcu0rAARmOV
	aKrfiyv15gJXthoTgMgKNsccqr0X/10kYLlppJ8+glNKZBBgp9DkI1hPvubdMKhb
	MhVYLVrIi+t6MA7hbEV6sO8N1A+6yE3kb/T1R2g91qujyg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id d9t6Nch_UM08; Tue, 24 Jun 2025 15:54:25 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bRTyx4HBzzm0yVN;
	Tue, 24 Jun 2025 15:54:16 +0000 (UTC)
Message-ID: <fe991f7d-e6f1-4178-919e-5d096e102b15@acm.org>
Date: Tue, 24 Jun 2025 08:54:15 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] RDMA/srp: don't set a max_segment_size when
 virt_boundary_mask is set
To: Christoph Hellwig <hch@lst.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Ewan D. Milne" <emilne@redhat.com>, Laurence Oberman <loberman@redhat.com>,
 linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20250624125233.219635-1-hch@lst.de>
 <20250624125233.219635-2-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250624125233.219635-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 5:52 AM, Christoph Hellwig wrote:
> virt_boundary_mask implies an unlimited max_segment_size.  Setting both
> can lead to data corruption because __blk_rq_map_sg() can split requests
> so that the virt_boundary_mask is not respected if max_segment_size is
> not UINT_MAX.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/infiniband/ulp/srp/ib_srp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index 1378651735f6..23ed2fc688f0 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -3705,9 +3705,10 @@ static ssize_t add_target_store(struct device *dev,
>   	target_host->max_id      = 1;
>   	target_host->max_lun     = -1LL;
>   	target_host->max_cmd_len = sizeof ((struct srp_cmd *) (void *) 0L)->cdb;
> -	target_host->max_segment_size = ib_dma_max_seg_size(ibdev);
>   
> -	if (!(ibdev->attrs.kernel_cap_flags & IBK_SG_GAPS_REG))
> +	if (ibdev->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
> +		target_host->max_segment_size = ib_dma_max_seg_size(ibdev);
> +	else
>   		target_host->virt_boundary_mask = ~srp_dev->mr_page_mask;
>   
>   	target = host_to_target(target_host);

Acked-by: Bart Van Assche <bvanassche@acm.org>

