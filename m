Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87EC457577
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 18:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbhKSRah (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 12:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbhKSRag (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Nov 2021 12:30:36 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F96C061574
        for <linux-rdma@vger.kernel.org>; Fri, 19 Nov 2021 09:27:34 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id t11so10189793qtw.3
        for <linux-rdma@vger.kernel.org>; Fri, 19 Nov 2021 09:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ksjWkVD/hG6n1WObjUIFqxDucrKO54XOY5Wsy/pFFc=;
        b=XGEIZ5HhwziGb/60wJzaiwEZINyCByIytdgpf9AK/xr5YjKTfaUPh2dNI3niR51QLV
         Qc4/0n49/xMMB/eZ6zXZ+PaHwAZQdmHgmUCK5zyl6ChqnL05iL12tajz6V4RqLe7XBog
         ncjU4KfX74GiqlQ4cbhwFEW8fdMB2zWBN2Ykfd5K9ZjLLN7R+QhdSKz7+ng8+PsoaXxe
         MwtNN+V3EPpPyo3CsQYXGz96rob7kDHyrAcKE7njU6fAj32y95Cx7rOUDkZk8zqKw1oc
         Qu04cNjTpZ3aT9nOCVMVcKLF0yAHaB/IbDiFgbK8FHhkMatgs6xcNLBsMGWRs/WO5tLA
         pHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ksjWkVD/hG6n1WObjUIFqxDucrKO54XOY5Wsy/pFFc=;
        b=OS1VZPmZt1RUqPx5/zJGe8nLOIzAgITUm7huwUCgwyXqy+k7uIFIxMyTa8IphWDXj9
         4utyiFhvdLze3jLXI1ybm915C9Ve00Ro+ef0BfT7mEQrU59fImWiK7yCeWC8meFgxVJZ
         0LQl0hipQsnHQeQ9FH/xtQk5BAIKkJrqoHBYr/UQJ0OkGDR5LwU/FgwcQo9QYGSfrDZq
         y8A3iks37zo5KEMQ8R/22Oi21PHdFKBYKr8inS0wZjheAYf00WNtK4yczAR2xGI44RNN
         +oJDbTH1sh4dXIzSJiiE8f82qHb2iPOwQM9OONf/jvSQ27ZGjVzwWpmRkkNk6UTQ5/Nd
         PPQg==
X-Gm-Message-State: AOAM532ftFtVqKIy1tt8Nx72nPgHBfpCjKBMhVreFQUVDjLb14cD7M2b
        8cCJzxYBo3bpa6wGyAQpg9ARPQ==
X-Google-Smtp-Source: ABdhPJygl6szxvSCh7k4PkQCUPrFPLB4hrQda70653tRlcZgZto5X8t1YcMLtsmuX2ubB6W6DG2nlA==
X-Received: by 2002:ac8:674a:: with SMTP id n10mr7778613qtp.145.1637342853934;
        Fri, 19 Nov 2021 09:27:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id m20sm230131qtx.39.2021.11.19.09.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 09:27:33 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mo7fg-00CXNV-Rm; Fri, 19 Nov 2021 13:27:32 -0400
Date:   Fri, 19 Nov 2021 13:27:32 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 5/9] RDMA/hns: Initialize variable in the right
 place
Message-ID: <20211119172732.GK876299@ziepe.ca>
References: <20211119140208.40416-1-liangwenpeng@huawei.com>
 <20211119140208.40416-6-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119140208.40416-6-liangwenpeng@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 19, 2021 at 10:02:04PM +0800, Wenpeng Liang wrote:
> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
> 
> The "ret" should be initialized when it is defined instead of in the loop.

Why?

It is a bit weird, but the code is fine as written

The only suggestion I'd make is

 	if (hns_roce_cmq_csq_done(hr_dev)) {
                ret = 0;
		for (i = 0; i < num; i++) {

Just because the , operator is not so typically used like that

Jason
