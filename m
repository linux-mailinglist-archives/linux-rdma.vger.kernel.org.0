Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D62D29FD69
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 06:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgJ3Fq4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 01:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgJ3Fqz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 01:46:55 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956F8C0613D4
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 22:46:55 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b2so4620894ots.5
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 22:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qHOdm0C4J08y8qn8DLdPKVru+H714VVwBZpBWPFtHr8=;
        b=Tob8R3F6hgjXs7upwsBnR5JwUHW1PNbrpKSRxzYU7pu5LCcBULdQPWacMT5w4nZpmx
         g6hFdl7C5SpyG4zMJVnDNfGtGTo3KiuoGCzSmLZNJjCzyG362QzlIVCiFhrT6UrXomUr
         AiXd6p4f7oF4UCuFe1+qJ013M4GGJaO5tJyzGeA53Df+NWIQQUm7aTgeZ/TNZAG3aQPb
         iE9kShV1+fzc91RAY+zEc3BHYsQ2gRUQe3L3o+FG/EWFnn+vDc2fg+Q+geoVA+97ZKTw
         d0zUEgzV/amW1WxIKbWKhXCvcy1nGJkx4Fxi7FeHajcFelchPlF1c5bNFSW451eEAC/g
         u8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qHOdm0C4J08y8qn8DLdPKVru+H714VVwBZpBWPFtHr8=;
        b=IwAgFQquBKGSRPtturnw2oIpuT1hbn2a5DYPOqf96HrJ9bAzkCddCYURlv7Qi3dNJK
         fWMrP+C7Ka0iqwbv/iK8AOWFJeWxrTkToxDF/ZpebFPYarAxKLXvEcO1z+S81DAhauMX
         8lJKJB8HG3oFsUWQ7K0xzASQeJOQUOSsHpRayOxD8pPYsjXY69CsJ/V+hJkBrA6xsr60
         rOBq4peXdfPZVMn612EethdKt3MsDJUrAHSeBPpXur318Lqiqb8l1YJB7XDPciTWqJEv
         cXejf+lmH3ow+YhdF+bfq94/num7k7lCcNKS1hHRNFRst+MlyUFCxcACrhewHMIe3lKD
         C03w==
X-Gm-Message-State: AOAM533DbaeAmLcMUwAa2YI+Vfav9iIa/fHQOsver9kW3//Hmf+2ph8Y
        zTT1lfO7sNwtXSrLrWwjdJg=
X-Google-Smtp-Source: ABdhPJxYrjBu6LFOvA/hXAreUICjT2HDaztlUOGovfyFrGm3Bj+Aq+4/hhaX+f4NmFbSlRKn+LhtxA==
X-Received: by 2002:a9d:370:: with SMTP id 103mr436598otv.89.1604036814975;
        Thu, 29 Oct 2020 22:46:54 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:b6dc:62b4:e209:78d4? (2603-8081-140c-1a00-b6dc-62b4-e209-78d4.res6.spectrum.com. [2603:8081:140c:1a00:b6dc:62b4:e209:78d4])
        by smtp.gmail.com with ESMTPSA id j3sm1216839oij.9.2020.10.29.22.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 22:46:54 -0700 (PDT)
Subject: Re: [PATCH for-next] RDMA/rxe: fix regression caused by recent patch
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
References: <20201029212545.6616-1-rpearson@hpe.com>
Message-ID: <703e1658-1efa-9dbb-1803-9f7392a2439d@gmail.com>
Date:   Fri, 30 Oct 2020 00:46:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201029212545.6616-1-rpearson@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/29/20 4:25 PM, Bob Pearson wrote:
> The commit referenced below performs additional checking on
> devices used for DMA. Specifically it checks that
> 
> device->dma_mask != NULL
> 
> Rdma_rxe uses this device when pinning MR memory but did not
> set the value of dma_mask. In fact rdma_rxe does not perform
> any DMA operations so the value is never used but is checked.
> 
> This patch gives dma_mask a valid value. Without this patch
> rdma_rxe does not function at all.
> 
> Fixes: f959dcd6ddfd2 ("dma-direct: Fix potential NULL pointer dereference")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 7652d53af2c1..116a234e92db 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1134,8 +1134,15 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
>  	dev->node_type = RDMA_NODE_IB_CA;
>  	dev->phys_port_cnt = 1;
>  	dev->num_comp_vectors = num_possible_cpus();
> +
> +	/* rdma_rxe never does real DMA but does rely on
> +	 * pinning user memory in MRs to avoid page faults
> +	 * in responder and completer tasklets
> +	 */
>  	dev->dev.parent = rxe_dma_device(rxe);
> +	dev->dev.dma_mask = DMA_BIT_MASK(64);
>  	dev->local_dma_lkey = 0;
> +
>  	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
>  			    rxe->ndev->dev_addr);
>  	dev->dev.dma_parms = &rxe->dma_parms;
>

Ignore this patch. It turns out it works because any nonzero number in dma_mask will stop the check that is failing and since rxe never uses DMA it won't affect anything. But, it doesn't compile cleanly because the dma_mask is a pointer to the actual dma_mask and not the mask. Somehow I missed the warning. I have a newer version that uses the function dma_coerce_mask_and_coherent() and also works. (Works means it gets to the next problem as mentioned in the prvious note.)

Bob
