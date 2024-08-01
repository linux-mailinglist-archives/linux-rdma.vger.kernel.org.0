Return-Path: <linux-rdma+bounces-4172-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0733945065
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 18:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6791F26B1F
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ADC1EB498;
	Thu,  1 Aug 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XMOlUaM5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF41D696;
	Thu,  1 Aug 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529256; cv=none; b=MiYNEuBYm7AfTrFJibPbd4SapFtvUHVBmPvN3t9EzESy0K6AJs8UkB4G0bcpIaBHSYTSJQejZmJ8teoOfVXpPzAtEJlq6nu4ICHnTLlwVxzk1n7AXJ7qIdwKdvkzeopVTxlMhskbKq6fU3I1zMqCwJDJdH5yhsQ9E1OAE3eNIPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529256; c=relaxed/simple;
	bh=AV4j/NxpeNbE2wHcTX9p8WSiDIp04m+LcerB6SAq9ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4bMohZgDxZt/vLV/Pua/U56Na9h5iEgA1lBZxZ0v5a/wgPSXQZVbxoAV0bXugWfgV1Ges3v9WIGJoY+vLiuHcMpAo3D9+VtqRLzu5h+veGGz6/VHmuMWtt9Gk/3ztNbWvbNMZZcAJ59cMY1ykzZC611l7m7++iPqyCliAPZiD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XMOlUaM5; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WZZ2W6LJ2z6ClY9G;
	Thu,  1 Aug 2024 16:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1722529248; x=1725121249; bh=bqwtgbTBpT4dQI8XCJolG60P
	zzEIHELp+3Ld7b5xNf8=; b=XMOlUaM50uBfH0qr40a0PaFZl7KnuOohrqkxu8+L
	1veRNvPOiTL7sFqtlHo4N+G2B25VG6j2ax5vA/ZCUfCqKNnZvB/CYnc3GDwykMuZ
	UMcAe5Su7eWXRDIpEJL2M38BETEnEF71GON/yD2hccFUu7/XJAloksWmoTHtUBt/
	kH82GU71inKjeII7/T3/9CO02CvENtVUP6hCVrSVtRn6vNTq1l6jUO3ePxL1Be4x
	YE4GA30sqJfA8MGH5x680q3lz6mDex7OhyHOkLaSMhPAMM3F8LCgibZpLEy/zs2g
	8VScL7lvz93hzXtfpqEulm4k7lRYfRrZ6U5aC9p5AVJY+A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sdUIef_huBjj; Thu,  1 Aug 2024 16:20:48 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2e14:8:b0e8:3901:a8d2:924f] (unknown [104.135.204.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WZZ2S0PNVz6ClbJB;
	Thu,  1 Aug 2024 16:20:47 +0000 (UTC)
Message-ID: <98763329-897a-4f91-ab08-62bbd6afc8ec@acm.org>
Date: Thu, 1 Aug 2024 09:20:45 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-rc] RDMA/srpt: Fix UAF when srpt_add_one() failed
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
 leon@kernel.org, nab@risingtidesystems.com
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, target-devel@vger.kernel.org
References: <20240801123253.2908831-1-huangjunxian6@hisilicon.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240801123253.2908831-1-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 5:32 AM, Junxian Huang wrote:
> Besides, exchange the order of INIT_WORK() and srpt_refresh_port()
> in srpt_add_one(), so that when srpt_refresh_port() failed, there
> is no need to cancel the work in this iteration.

The above description is wrong. There is no need to cancel work after
INIT_WORK() has been called if the work has never been queued. Hence,
moving the INIT_WORK() call is not necessary.

> @@ -3220,7 +3221,6 @@ static int srpt_add_one(struct ib_device *device)
>   		sport->port_attrib.srp_max_rsp_size = DEFAULT_MAX_RSP_SIZE;
>   		sport->port_attrib.srp_sq_size = DEF_SRPT_SQ_SIZE;
>   		sport->port_attrib.use_srq = false;
> -		INIT_WORK(&sport->work, srpt_refresh_port_work);
>   
>   		ret = srpt_refresh_port(sport);
>   		if (ret) {
> @@ -3229,6 +3229,8 @@ static int srpt_add_one(struct ib_device *device)
>   			i--;
>   			goto err_port;
>   		}
> +
> +		INIT_WORK(&sport->work, srpt_refresh_port_work);
>   	}

I don't think that this change is necessary.

Bart.


