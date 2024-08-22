Return-Path: <linux-rdma+bounces-4496-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD695C17E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 01:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7665B2852E3
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 23:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106011531C7;
	Thu, 22 Aug 2024 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="5KcoojEf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1E81DA5F
	for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2024 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724369465; cv=none; b=n35vMEk/GHDLuSAJ4gHKW+YhEhsiMBYyjo4fh1W96AN+GYlwoCGn/rGi4v3b+J9yRFFJSPGJ+Z2Sc1ngQxWIJsYLE+YL1eepm8y/wA4yAgVZ8A4KJ2E99aryVIaF70rtoo9QygYNC7ECaxo5n+V0WmtKnsAO8GkCs4Eujqx/qPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724369465; c=relaxed/simple;
	bh=wX/jNtFNibdCM4G4NnaXuzanseFblb+5tjabB2fqPIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aYusqGNShOakBrKUJXTVCfa2w+hP7poSkfdZ9BsnqoyL6pq65YRQKCUzBHAMJ0u/CFHMGtb0+PBoOHcHuYlzN1X9PjV4icvVuZ3udxScIJh5+sb0NR78rIZuL8DKh57JDPSCrwqvEdDzXzAblriH+4clqlxapkSzJWjkkkYgdS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=5KcoojEf; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WqfbB1Rc1zlgVnK;
	Thu, 22 Aug 2024 23:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1724369459; x=1726961460; bh=Kkj6JmC65EKbQy5ms/WbmJy/
	WVQJUdt2Mt7r9UG1tp0=; b=5KcoojEfXg+Sl3mx05kKWtUTOTCDqZ+3vKLkB0ZZ
	vTTO6do4YZLz7GMBUbR+5PQBiKQJPBfEpNZryyfBzAAeuyabP7/sVmHkbUsIMfjO
	wxsx1DpWn3r9J70zU9PKU/jRwfTcPQJHR//vNniFYxmcoGuBLPdaSRl6jVbgu89Q
	izQSAyoaKD2Z0K//gH6vNKH4DujmtUKCB7Tv3/UWWuNgPyAc2ucTu/keYdcw86GG
	yvC5EZWJgJJtDaumm5NyZvDAKHW9DRgKbc9QP9ClPyMo48iMIqFF5BsGGPIPT4x6
	qk6hdlOl1JhlrUUWtPtLwP0cm3789eyhChjYhOx8l829HA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id p4kQltL9ZI_S; Thu, 22 Aug 2024 23:30:59 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Wqfb71VNfzlgVnF;
	Thu, 22 Aug 2024 23:30:58 +0000 (UTC)
Message-ID: <f97c93c2-6636-4a05-8cfb-073881758821@acm.org>
Date: Thu, 22 Aug 2024 16:30:58 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] RDMA/iwcm: Fix
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
To: Zhu Yanjun <yanjun.zhu@linux.dev>, leon@kernel.org,
 linux-rdma@vger.kernel.org, shinichiro.kawasaki@wdc.com,
 oliver.sang@intel.com, jgg@nvidia.com
References: <20240820113336.19860-1-yanjun.zhu@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240820113336.19860-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/24 4:33 AM, Zhu Yanjun wrote:
> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> index 1a6339f3a63f..7e3a55349e10 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -1182,7 +1182,7 @@ static int __init iw_cm_init(void)
>   	if (ret)
>   		return ret;
>   
> -	iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", 0);
> +	iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", WQ_MEM_RECLAIM);
>   	if (!iwcm_wq)
>   		goto err_alloc;

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

