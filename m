Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43868457579
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 18:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhKSRbe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 12:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbhKSRbd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Nov 2021 12:31:33 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC38BC061574
        for <linux-rdma@vger.kernel.org>; Fri, 19 Nov 2021 09:28:31 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id t11so10192538qtw.3
        for <linux-rdma@vger.kernel.org>; Fri, 19 Nov 2021 09:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iXQ4+gLUPcPHaTcicpJXtpkkdVa1a/NR3itVceD2GTY=;
        b=Sx/vjCrIvPmY6ItexZ7vvp0BvFtHql3ryYc7Mo4ispcOhv5s8JTw8s+re6jx30uAlC
         M5pV8PulZsuxhN3SHab3IuZ7jA8lW+Ou878I1QN5pYQPV7cRbqTkXMHvaVIMh/GGLF7+
         zmNY0fl2e2LwtYOP0+U3CwTWYuw7nJtz1quDZvozcshNHYIxFcp6hfaBnxwSrNkekoqW
         d+7Qw8B7h/vF3lYbXXduhSW6IQudlmDZ2e1a+P5wXOpN6Fy63z6NdS3P5S00Y7tRQO22
         qvckfB05UQJF7V/mx1uGXAGsDFKifkDBN8FC0w+BR1FlatOS9jF6Bxu0pcOFYWQaRgKW
         9s3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iXQ4+gLUPcPHaTcicpJXtpkkdVa1a/NR3itVceD2GTY=;
        b=D5ZxZZORKXjB0rJLiuwnHuj3+BBt9khlc+bf9lwjZRL4ORfct8oynqyogLmkhwINbG
         rqO9QQvMPppFTfMmCbjCAnm9uT+qa0UwCugf4AA9Z1R5tnY36TJmhtj/uT96JstgWnMr
         rIfp+L1w1FK52ptf4GI5s71WhQ5T/lO7m+DSb6CqUTK3O1CbFjavBbDdWR8s/pn9dOox
         wH8Pbt6mBylPYMp2sKXjlKexG911bW1Ugp8pmaZLO6M0f+UprCSzglnsCvTtQqwepZsj
         6vezX+XH1fH11dkpBG7n2HKloZzjwmqr5+L0fs87H9hAPix8kbXpUdZkE2eXflDJrC2o
         L7HQ==
X-Gm-Message-State: AOAM5322Yd5I2cvmcvcCXPVvrLeYpEoa61n2hppwB7jMBN6Vs0tIvvux
        w0wyONh9l28vjrmt4hjtVRDtyH0y9gnkDQ==
X-Google-Smtp-Source: ABdhPJyH1/EeB8yLtdfjbWsysprmi8DbXbpjso3EYl9kWW65z4Ka86WdSk/14smHfcNioOwDee3K0g==
X-Received: by 2002:a05:622a:40a:: with SMTP id n10mr8028947qtx.161.1637342911057;
        Fri, 19 Nov 2021 09:28:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id x125sm159514qkd.8.2021.11.19.09.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 09:28:30 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mo7gc-00CXOL-2W; Fri, 19 Nov 2021 13:28:30 -0400
Date:   Fri, 19 Nov 2021 13:28:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 7/9] RDMA/hns: Add void conversion for function
 whose return value is not used
Message-ID: <20211119172830.GL876299@ziepe.ca>
References: <20211119140208.40416-1-liangwenpeng@huawei.com>
 <20211119140208.40416-8-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119140208.40416-8-liangwenpeng@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 19, 2021 at 10:02:06PM +0800, Wenpeng Liang wrote:
> From: Xinhao Liu <liuxinhao5@hisilicon.com>
> 
> If the return value of the function is not used, then void should be
> added.

AFAIK we don't do this in the kernel

Jason
