Return-Path: <linux-rdma+bounces-3438-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A7E914ED9
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 15:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33081F23419
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810A1411C2;
	Mon, 24 Jun 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J2Bup/LT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36EC13E888
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236001; cv=none; b=KR05KV7wH0c16tYNi5UOs6Nk+uQC6w1yHPGYGu9clTaj2GyZ1ErYxkJEKKBwRmxacFUzzIpby5BpsYNHYi+iT11dUrF1niDStHgzQ5sDFNJVIUfLQWg2gaQsC2E6i7lYuB4sHIwKXq2pOVyK67Uxez1rNeOVKpC8FXx/jsc6Mlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236001; c=relaxed/simple;
	bh=4aDw0vbKihlm8IIMGeyNrffWnGhjKa2WF6glcTBW7RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEnD7PLR1a75cn48URfpUE5V1U4TNw8o1ECrRg9/ySLp3kLA+u1bYnqcAfv63BjiGiANd5d+G/E3Z6KArq6ipH85ZCTU5A5cTtkIS+5OKxFGRKEVxR7LstvPXrsp9g2u8pCoyLspBxc4oJh/FKtFOo9Mw8/P5a8Zbvj4mCZx2YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J2Bup/LT; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: honggangli@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719235996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eAuPG9melbsvMZGm108DD8e1b3EnUYIKPJPdHwzBpk=;
	b=J2Bup/LTis8aJyfZiZSwQCMUXMAPCz7CnMKjQyGFJ/vWhmoipWRnCO2RYws6X3boogh1Y7
	oko9UVuwUe+zlNKwLhk5yuQOUN3kjcyPTnQjsLylFLqzCBfX+wbiIj991W7zIATW5nScbS
	kXfT7O7UcCEud0Wrods1jkCmM8yi5No=
X-Envelope-To: zyjzyj2000@gmail.com
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: leon@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: dledford@redhat.com
X-Envelope-To: kamalh@mellanox.com
X-Envelope-To: amirv@mellanox.com
X-Envelope-To: monis@mellanox.com
X-Envelope-To: haggaie@mellanox.com
Message-ID: <93f8901a-15fb-4a5b-a378-f26c8c93b43a@linux.dev>
Date: Mon, 24 Jun 2024 21:33:06 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Don't set BTH_ACK_MASK for UC or UD QPs
To: Honggang LI <honggangli@163.com>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org, linux-rdma@vger.kernel.org
Cc: dledford@redhat.com, kamalh@mellanox.com, amirv@mellanox.com,
 monis@mellanox.com, haggaie@mellanox.com
References: <20240624020348.494338-1-honggangli@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240624020348.494338-1-honggangli@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/6/24 10:03, Honggang LI 写道:
> BTH_ACK_MASK bit is used to indicate that an acknowledge
> (for this packet) should be scheduled by the responder.
> Both UC and UD QPs are unacknowledged, so don't set
> BTH_ACK_MASK for UC or UD QPs.

 From IBTA
"
o9-30: If a TCA responder implements Reliable Connection service, or if
a CA responder implements Reliable Datagram or XRC service, the 
responder shall behave as follows. A responder shall acknowledge each 
request packet received. A responder shall generate an explicit response
for each RDMA READ request received. A responder shall generate an
explicit response for each ATOMIC Request received. A responder shall
generate response packets in the PSN order in which the original request
packets were received, including RDMA READ responses.
"

This ack_req should be based on "Reliable Connection service".
As such, I am fine with this commit.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks,
Zhu Yanjun

> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Honggang LI <honggangli@163.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_req.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index cd14c4c2dff9..ffd7ed712a02 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -445,8 +445,12 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
>   	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
>   					 qp->attr.dest_qp_num;
>   
> -	ack_req = ((pkt->mask & RXE_END_MASK) ||
> -		(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
> +	if (qp_type(qp) == IB_QPT_UD || qp_type(qp) == IB_QPT_UC)
> +		ack_req = 0;
> +	else {
> +		ack_req = ((pkt->mask & RXE_END_MASK) ||
> +			(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
> +	}
>   	if (ack_req)
>   		qp->req.noack_pkts = 0;
>   


