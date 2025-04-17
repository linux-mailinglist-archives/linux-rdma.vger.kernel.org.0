Return-Path: <linux-rdma+bounces-9522-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 636A3A91E31
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 15:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C724C3ABD47
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 13:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD85024A060;
	Thu, 17 Apr 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nEiRdiLc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF7124A040
	for <linux-rdma@vger.kernel.org>; Thu, 17 Apr 2025 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897116; cv=none; b=LRNuy2QsLKzbnEd2VrfY8NtdeWLLcmcw+cYh073tlHVyH//NiybTLJrHM0wZnrJ9ysxS76qUkVLEsJCGUfnIGFLOcnot2szwTQVUczYqOxXrH+aruxwCSC9e0ftQ7FO2Id4FIVbpIcoJG7CLQxdeTGtyoM3fZI+M7oAlTSweUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897116; c=relaxed/simple;
	bh=TuA6iIcB1pBTWGgkSMVSFyR+JdrhY2OU3rmRcvufNOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eSlRWVVqeodyVdzJBEGUHjv+nYfp7NwDj71j9bdKFVP0ylz1kL+MfqoV5FBeNdDGTGsBCI1O4zfXZW/vyfpZzO4nk0fWFHgmAMtf8IjsYVgOuIV89bX6D/kycFw3ZrvHSwUT5EsMfaEHHK7PwdEsi6Tl0Ie4mXmlQsF3/GJzAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nEiRdiLc; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b1e513f8-2e0d-4b09-aa10-02b7b593d3c9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744897110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwWArQ9MRFGh/K/eEnUGpTzjpxS8V4e6gJ+d+OE0Wg4=;
	b=nEiRdiLcOXl/0JZ4b+MhjzFuKTUxxNRdxzCe3bwodYNkgAoRAzFmzv0T1D76gH31bw08tR
	5UchRm/hc0tt2THRDjE6P5O+cHTBxb/L5At8yJCxJEXVlBS4wC4kp6TxL0VeLewIrqf2Rv
	kaPtM3CIlyDDYAXIvfHE3D5Cn2JsKoM=
Date: Thu, 17 Apr 2025 15:38:26 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] net: mana: Add speed support in
 mana_get_link_ksettings
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, kent.overstreet@linux.dev,
 brett.creeley@amd.com, schakrabarti@linux.microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 rosenp@gmail.com, paulros@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
 <1744876630-26918-2-git-send-email-ernis@linux.microsoft.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1744876630-26918-2-git-send-email-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17.04.25 09:57, Erni Sri Satya Vennela wrote:
> Add support for speed in mana ethtool get_link_ksettings
> operation. This feature is not supported by all hardware.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 42 +++++++++++++++++++
>   .../ethernet/microsoft/mana/mana_ethtool.c    |  6 +++
>   include/net/mana/mana.h                       | 17 ++++++++
>   3 files changed, 65 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 2bac6be8f6a0..ba550fc7ece0 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1156,6 +1156,48 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
>   	return err;
>   }
>   
> +int mana_query_link_cfg(struct mana_port_context *apc)
> +{
> +	struct net_device *ndev = apc->ndev;
> +	struct mana_query_link_config_resp resp = {};
> +	struct mana_query_link_config_req req = {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_LINK_CONFIG,
> +			     sizeof(req), sizeof(resp));
> +
> +	req.vport = apc->port_handle;
> +
> +	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
> +				sizeof(resp));
> +
> +	if (err) {
> +		netdev_err(ndev, "Failed to query link config: %d\n", err);
> +		goto out;
> +	}
> +
> +	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_LINK_CONFIG,
> +				   sizeof(resp));
> +
> +	if (err || resp.hdr.status) {
> +		netdev_err(ndev, "Failed to query link config: %d, 0x%x\n", err,
> +			   resp.hdr.status);
> +		if (!err)
> +			err = -EPROTO;

EPROTO means Protocol error. Thus, ENOTSUPP or EPROTONOSUPPORT is better?

Zhu Yanjun

> +		goto out;
> +	}
> +
> +	if (resp.qos_unconfigured) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +	apc->speed = resp.link_speed_mbps;
> +	return 0;
> +
> +out:
> +	return err;
> +}
> +


