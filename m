Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40F8485D0E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 01:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343694AbiAFAXK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 19:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343696AbiAFAWs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 19:22:48 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AB0C06118C
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 16:22:41 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id y9so792218pgr.11
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jan 2022 16:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eLN4Qu7jiPvT/bnMkPGvZfv+ICsN3yFETlJS3bgJu8k=;
        b=atrsA4XY8w6SPc4roYagrz6R4hYh8Bu3G0o3mf7+ziNudB7NiqcTEgwgnTGt3+4vla
         Sflg4u7SNw9S34v1NU1NaeUFv2q/hiP21vG+bNgr/Wl7iyALNTu+Q1rJMVnL+DhRzO6b
         FPRQzu26KryM7hsTba1THdeMOOkPtmmlfvL51vyZ+pNhz1SqE84my8EWyGpRxcVBGkCs
         uDGrijAYWnI5jGclTmWH3jXBCIhtam9x4URkvJ87Kyq5TEHDl0uUnotspOV6yFE+aezG
         677O5bD2rhZGhDHd3kcesmsE0kLDcAdHyILNTF3myt9unZ4aeDklTOP0DB7wdFYFyhfR
         f5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eLN4Qu7jiPvT/bnMkPGvZfv+ICsN3yFETlJS3bgJu8k=;
        b=P7W3qnf25yyo8GwirPllGs3XqRQSHba738h2QmMveQRmFDlxoHUdwRRudhpY21emG/
         mHn6oHv3SWdEveKPjXRzR+BfqboqeJHZnWUVoipK5+3UqadCWlmaE7N8iuKgQUlNUk4Q
         dbLVcPKob4BzSDSnazNXcerWM9QCVL/GmV/Yq57sgQ29MYTkR95knhP/FlXagGDsS4Tj
         eOPlO/ukGFcRpQMH97QApARCzB066Nd9YiPn/+3Gx7aOCy/wYszCFdB+DL0cIb6rGoEz
         v6utdSDd2lZkEfAzsiorX2+5gP6n8ioSlyjETIanjZCC1PQ/i52CEAYR4v5A1nEhXK7O
         ayWw==
X-Gm-Message-State: AOAM530mTit4ukdbJ3LqBephpSO+frh91sF5FyxZI8mDE77OiUpL7UkJ
        fbJRG4vHDhil9atDcKwqMO0OnQ==
X-Google-Smtp-Source: ABdhPJxCS2dhH8jSim3EZ0Du+VwkS7obM4QKX9INAQoJp7L4fQBhj8xXWmpaLjmHlj50TBfNgdu7qg==
X-Received: by 2002:a05:6a00:1403:b0:4bc:80a3:19eb with SMTP id l3-20020a056a00140300b004bc80a319ebmr22369569pfu.1.1641428561216;
        Wed, 05 Jan 2022 16:22:41 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id u6sm3666253pja.32.2022.01.05.16.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 16:22:40 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n5GYB-00CDXd-3M; Wed, 05 Jan 2022 20:22:39 -0400
Date:   Wed, 5 Jan 2022 20:22:39 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        aharonl@nvidia.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        mbloch@nvidia.com, liweihang@huawei.com, liangwenpeng@huawei.com,
        yangx.jy@cn.fujitsu.com, rpearsonhpe@gmail.com, y-goto@fujitsu.com
Subject: Re: [RFC PATCH rdma-next 03/10] RDMA/rxe: Allow registering FLUSH
 flags for supported device only
Message-ID: <20220106002239.GQ6467@ziepe.ca>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-4-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228080717.10666-4-lizhijian@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 28, 2021 at 04:07:10PM +0800, Li Zhijian wrote:
> Device should enable IB_DEVICE_RDMA_FLUSH capability if it want to
> support RDMA FLUSH.
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  include/rdma/ib_verbs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index f04d66539879..51d58b641201 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -291,6 +291,7 @@ enum ib_device_cap_flags {
>  	/* The device supports padding incoming writes to cacheline. */
>  	IB_DEVICE_PCI_WRITE_END_PADDING		= (1ULL << 36),
>  	IB_DEVICE_ALLOW_USER_UNREG		= (1ULL << 37),
> +	IB_DEVICE_RDMA_FLUSH			= (1ULL << 38),
>  };
>  
>  enum ib_atomic_cap {
> @@ -4319,6 +4320,10 @@ static inline int ib_check_mr_access(struct ib_device *ib_dev,
>  	if (flags & IB_ACCESS_ON_DEMAND &&
>  	    !(ib_dev->attrs.device_cap_flags & IB_DEVICE_ON_DEMAND_PAGING))
>  		return -EINVAL;
> +
> +	if (flags & IB_ACCESS_FLUSH &&
> +	    !(ib_dev->attrs.device_cap_flags & IB_DEVICE_RDMA_FLUSH))
> +		return -EINVAL;
>  	return 0;
>  }

This needs to be combined with the previous patch

Jason
