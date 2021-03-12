Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8F3338EA7
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 14:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhCLNUv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 08:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhCLNUi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Mar 2021 08:20:38 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961C0C061574
        for <linux-rdma@vger.kernel.org>; Fri, 12 Mar 2021 05:20:38 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id t4so24198590qkp.1
        for <linux-rdma@vger.kernel.org>; Fri, 12 Mar 2021 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IQJQuNPhxd6ZXNBRhJav9JiavT8ViMzEpWL/f1TM8Cw=;
        b=DPoLUzXofu5fP+bcfMqJTz74HBsy2pAyjyjg68Z07Lo5RJj4obiH1/dLLeMjWW5aHq
         mO/R44pFd3trsHu+u3sIdvGrssqD9SXQhbr8GQKo2EG9UwQXEX55Dacvjpoi+TR4EWGy
         6px2eB09hwK2FGe630G4dwW8P7Ypz7sSkPhy5gVZAazpsprxX76uxL2NzIhU8IVd2U7S
         pnc5MJEShDZjd8aicV9DuEQ6cj4xnHHnlx/QtUhJ5Bj3TFbLgTIxOyYeyEa/zH0+3XOz
         l7pon5c5heHPbbHhjjlFDhmzls1AgJBZzdtIYgCMPkxcMureUCu9lbuYgi1x8wl6RUdM
         buaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQJQuNPhxd6ZXNBRhJav9JiavT8ViMzEpWL/f1TM8Cw=;
        b=XpVHbFesjvCcVtkfrmbH8abvQK/11rswHl2sMHSVngoL2+aE8C8fDEZz9YKSoM/woH
         w29s9vZmP0EMc6V+izYWY9IWagTZyE0Rcxri+qJl+CkpFiYHzGlmiBuW6gC6WUYueH0Q
         lD+viLWxqZoQ+3i919n5kYA2Pqkxjh3SJQPitwTHiSLXnRhb4KHTG79YeCSa3a+MBaVJ
         3tNsO57Rp6scaNTIMfLYT+jLNZgEQlAsNNHRIZhdTaAMO99lBTMQIEd/BYhnpu0ITntg
         2gvR/39s3ZssBheKUc+WfcgQoymwdZ4LQRT4x3lt0eFtcV+6CIOdlWFFIQN0MLrmSZAq
         nGhA==
X-Gm-Message-State: AOAM5330azqSiiJEa83LBg7SEyCSnBePKHSmtgX2/Rs2vjeKCbD3yafE
        uBo8yplvWs1hUE5uTNArIecafw==
X-Google-Smtp-Source: ABdhPJwiU9FUdKYvzC0SKpA/k8L0cGhhm8WwOy2QHs//qBrw2eHK5LjaZYEIJDY2vbuqo9vIu9VW0w==
X-Received: by 2002:a05:620a:16d4:: with SMTP id a20mr12620934qkn.410.1615555237745;
        Fri, 12 Mar 2021 05:20:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id d12sm3865507qth.11.2021.03.12.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 05:20:37 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lKhiW-00Bu2d-MJ; Fri, 12 Mar 2021 09:20:36 -0400
Date:   Fri, 12 Mar 2021 09:20:36 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH for-rc] RDMA/hns: Fix bug during CMDQ initialization
Message-ID: <20210312132036.GC2710221@ziepe.ca>
References: <1615541933-35798-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615541933-35798-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 12, 2021 at 05:38:53PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> When reloading driver, the head/tail pointer of CMDQ may be not at position
> 0. Then during initialization of CMDQ, if head is reset first, the firmware
> will start to handle CMDQ because the head is not equal to the tail. The
> driver can reset tail first since the firmware will be triggerred only by
> head. This bug is introduced by changing macros of head/tail register
> without changing the order of initialization.
> 
> Besides, the same name represents opposite meanings in new/old driver, it
> is hard to maintain, so rename them to PI/CI.

Please split this to two patches for the -rc flow

> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index c3934ab..c359f09 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -1194,8 +1194,10 @@ static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
>  			   upper_32_bits(dma));
>  		roce_write(hr_dev, ROCEE_TX_CMQ_DEPTH_REG,
>  			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
> -		roce_write(hr_dev, ROCEE_TX_CMQ_HEAD_REG, 0);
> -		roce_write(hr_dev, ROCEE_TX_CMQ_TAIL_REG, 0);
> +
> +		/* Make sure to write CI first and then PI */
> +		roce_write(hr_dev, ROCEE_TX_CMQ_CI_REG, 0);
> +		roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, 0);

Only this hunk should be in -rc

Thanks,
Jason
