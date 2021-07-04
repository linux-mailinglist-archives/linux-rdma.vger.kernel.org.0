Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24493BAF3D
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jul 2021 23:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhGDVqQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Jul 2021 17:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhGDVqQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Jul 2021 17:46:16 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F55FC061574
        for <linux-rdma@vger.kernel.org>; Sun,  4 Jul 2021 14:43:39 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l17-20020a9d6a910000b029048a51f0bc3cso4531512otq.13
        for <linux-rdma@vger.kernel.org>; Sun, 04 Jul 2021 14:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nJhEa1QwZlor7AIfDOIPjSjh9nWmHpQG8HHrMUiUDRo=;
        b=T1QkKILW24f0esDNC8E3jiF9WzDUeRT/n2Hl0rsXNsb7vAwzObBGkZ5rZ3bNtVnGqw
         AKL2tkXfwR1Lhx6tkhI3ZoICxFwpf35HVq1cCjwy+NpIgA6yiXIxyaWYAoSxDFiITx3e
         pPr58JY88Mk2V93nWcBt++3NV4K7KfoiQzydN1y/3Wsy1PUrbd2ZopW5z4SeCFSCya6V
         nINtp1DFzeAzV3xyg4KbBpjKjSk/zM1zauWO8bCg2c5JU0hzi35Xhhs48y9HfNAn+tWg
         R2Dm7mKKq9pbMl9vpDDTu8ZE0nnApw8kUMQ3tmKwPNU+1d81HB7uE4uhB6m0EMreR6z9
         PqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nJhEa1QwZlor7AIfDOIPjSjh9nWmHpQG8HHrMUiUDRo=;
        b=GHl94sgqWpOLdJBlFiOSjWAep9oHSp6n0bmyYyFT85Oa5ZejgU2YV2wtei59tIN6RF
         IRX9KYoqKAcXDHpUH7EP2BV/Uo8jpwI1fkOQ4IwxLTR1FA43hWFbsKDp5B0t8SwE9YgV
         r3VJsx1dtOXqO/a9erjd1ML0rmkLh63wGnPMs+f1vBRMxreofcV7vZuT2uqiEcPZ/otG
         Cu9grL364o3hqRBC+qnHAheh/dNpPIl1K+KPxGHSts6IIlfOn82W8btdrtbm5Xs95Xji
         YLPNlKH6qhF462fOXCAfMm3oLp27RITpve5hBEiUH5h0pNL2zP3+cg9ZUmBzxjBMmucu
         UhSA==
X-Gm-Message-State: AOAM530SB89NXoRHkIIswbDEzxWECF2pZ8PkOQU66x09taqFb+nDUh0G
        ZtUy3DK9aTFuiVEwL6iELNhOAuO0pmY=
X-Google-Smtp-Source: ABdhPJythXFqt6D0RbqnQXdca4w7Y6ORRguNH8UZdVzBfIVJfXkoRQxQHCFGuuijI7NSrUSlqsK9zQ==
X-Received: by 2002:a9d:628:: with SMTP id 37mr8413982otn.120.1625435018990;
        Sun, 04 Jul 2021 14:43:38 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:e370:af2e:f4f:b7fe? (2603-8081-140c-1a00-e370-af2e-0f4f-b7fe.res6.spectrum.com. [2603:8081:140c:1a00:e370:af2e:f4f:b7fe])
        by smtp.gmail.com with ESMTPSA id o17sm2259597oie.56.2021.07.04.14.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 14:43:38 -0700 (PDT)
Subject: Re: [PATCH] RDMA/rxe: Remove the repeated 'mr->umem = umem'
To:     ice_yangxiao@163.com, linux-rdma@vger.kernel.org
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com,
        Xiao Yang <yangx.jy@fujitsu.com>
References: <20210702123024.37025-1-ice_yangxiao@163.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <24f83a1c-6bdc-a56a-8e56-42146f4fb86b@gmail.com>
Date:   Sun, 4 Jul 2021 16:43:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702123024.37025-1-ice_yangxiao@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/2/21 7:30 AM, ice_yangxiao@163.com wrote:
> From: Xiao Yang <yangx.jy@fujitsu.com>
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 6aabcb4de235..487cefc015b8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -122,7 +122,6 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>  		goto err1;
>  	}
>  
> -	mr->umem = umem;
>  	num_buf = ib_umem_num_pages(umem);
>  
>  	rxe_mr_init(access, mr);
> 

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>

Looks good.
