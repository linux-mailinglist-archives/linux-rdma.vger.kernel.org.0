Return-Path: <linux-rdma+bounces-2775-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A598D8078
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 12:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693501C21675
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E064A83CB9;
	Mon,  3 Jun 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="btdc6ZCy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814F183CAA
	for <linux-rdma@vger.kernel.org>; Mon,  3 Jun 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412370; cv=none; b=kpksG2GfHKPn9axg58AqrFJrqMZ2MOPS8XoDEAlBjw/wt8sTDsHdsQTKlF+MW8/faRclJdQwwtbCUwLymLmjVJmJ4TbTFb1Jp7JLce3TD3H3NLkcQME7JahuQnHEJJmOL9bUImKRboMZuSQf2dbZt+dhdcdcCVPCnjDpgEVOVjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412370; c=relaxed/simple;
	bh=YmPPbke6e92Yj+eV02jb8C04D++PMs8QO086gTmasm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7Ct7Pnh/30wm7F2JV2pJCNP66lcARMFW4stFrBwLXMmfMZYrLxOZvJ66OEJjjBx4o2Udc0H8n3/dbTo2GuqQegQRSEf4GhB+NQc6/1N0Ou4nZu1tezpNEQg+AMI3q5jvxbQsQy/D9CNUz7n5YYSrecpYU23wZeV9oda5SSAwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=btdc6ZCy; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: cel@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717412366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLaCf4711wZ++xieKqsYaGmbPkHU10XDetYSRDXNfVE=;
	b=btdc6ZCyJnTnBwcdZNtDEE/hUMHelhm3tK0betNts1CoAu9u5IbGO45U2BPMchXW+mPtrl
	9UDa4jcj3KeHC2b1pvb0VSjh6tZptpqvCoG2kmocDd1XuUxM/jWeYR/fJ/S/uI+Znjj5+J
	8NdtHC/XAwe8/MzKBz9xRfia3QBdYrE=
X-Envelope-To: linux-nfs@vger.kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: chuck.lever@oracle.com
Message-ID: <9ae0657b-b430-9318-4e19-eae9f40307fb@linux.dev>
Date: Mon, 3 Jun 2024 18:59:13 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] svcrdma: Refactor the creation of listener CMA ID
To: cel@kernel.org, linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
References: <20240531131550.64044-4-cel@kernel.org>
 <20240531131550.64044-5-cel@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20240531131550.64044-5-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/31/24 21:15, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> In a moment, I will add a second consumer of CMA ID creation in
> svcrdma. Refactor so this code can be reused.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/svc_rdma_transport.c | 67 ++++++++++++++----------
>   1 file changed, 40 insertions(+), 27 deletions(-)
>
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 2b1c16b9547d..fa50b7494a0a 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -65,6 +65,8 @@
>   
>   static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
>   						 struct net *net, int node);
> +static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
> +				   struct rdma_cm_event *event);
>   static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
>   					struct net *net,
>   					struct sockaddr *sa, int salen,
> @@ -122,6 +124,41 @@ static void qp_event_handler(struct ib_event *event, void *context)
>   	}
>   }
>   
> +static struct rdma_cm_id *
> +svc_rdma_create_listen_id(struct net *net, struct sockaddr *sap,
> +			  void *context)
> +{
> +	struct rdma_cm_id *listen_id;
> +	int ret;
> +
> +	listen_id = rdma_create_id(net, svc_rdma_listen_handler, context,
> +				   RDMA_PS_TCP, IB_QPT_RC);
> +	if (IS_ERR(listen_id))
> +		return listen_id;

I am wondering if above need to return PTR_ERR(listen_id), and I find 
some callers (in net/rds/, nvme etc)
return PTR_ERR(id) while others (rtrs-srv, ib_isert.c) return 
ERR_PTR(ret) with ret is set to PTR_ERR(id).

Thanks,
Guoqing

