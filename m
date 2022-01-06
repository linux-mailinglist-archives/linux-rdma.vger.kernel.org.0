Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C92B485D10
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 01:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343733AbiAFAXj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 19:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343693AbiAFAXI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 19:23:08 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACD8C061212
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 16:23:01 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id i30so846224pgl.0
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jan 2022 16:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9zXKg8lACaveFenHplydQL59rY+pCMITjAWSZJt6urw=;
        b=ZgGdonMGgEtBOOMaNPyxQVi1qz37G3nYYtrOSHJZWjRI9jw8mqy/HyBaQOOT0CGKMl
         MpIeEp30q8h2xMGBcuuzwLmvUpn+hNgrXaiQl70GBsma9uAteoBOOymrWRk8vg2K6WrG
         XUG9BStf0juv72uKvbzkxTPqgu5y8s2+bbksF7TfvPIFrzf4EHPxA0XrFia1w7eDz/4I
         hT+Js2rT01eZHJkMNYul2GhZyPjbNq7WDGqyO7tkAhPwjxAgwt7amxhfT776FdlK23Rg
         ErUwtzm70niCZR3TA+WJZ6wm9p7iTnfYhAM8QlTi2qTUD8fxS2423YKHPBlzV/2wc1YD
         yGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9zXKg8lACaveFenHplydQL59rY+pCMITjAWSZJt6urw=;
        b=zXgCouxSJ2CG/pJ2FrwH6CZJ1ebNM0bQ37uc4E/XX3Dv26uv9r7AXQU9sTQNQrDz5r
         OESjiy3N/HpjyeGH4C6pGBFGclLxlJBjCfVtL/b4uE5cK2/Ol8NdLU3Ildh+6jNu41xh
         OT1H0c0LWl7iOHl8jKEVRV4dd/aI1JYPjfPD/U6Z5v0/YRtnYMBZvIKTr2qEfmos1mys
         FsJHb69XDZxY3iFj8t7mjTfRnPQ0uQUZubx8B/w4Gl+hicK70wf5ddBhabFh7sxnabvL
         0FKAbIVS8lY+e1aOJ2Q/xAEtRE/9cBM2WerfHVyD1F5tzC+KNQ5fkAxX+/hlagW/wGif
         jxZw==
X-Gm-Message-State: AOAM5312DBFJEh6DyMtvnmTHwb1GYLbWNzfTzouWCtPbg0NpOWVf5qzq
        7aUoqUBLvrLckhINIUsrjZNA1g==
X-Google-Smtp-Source: ABdhPJxeGq/jSwAJlXCenjTKEnrqRh5dufu8ODrh7hKulDnQ+UGRxpp5M1Bry9s7/6+7fnk9gCD5ZA==
X-Received: by 2002:a63:7519:: with SMTP id q25mr48783724pgc.597.1641428581251;
        Wed, 05 Jan 2022 16:23:01 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id gg23sm3677932pjb.31.2022.01.05.16.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 16:23:00 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n5GYV-00CDYG-DZ; Wed, 05 Jan 2022 20:22:59 -0400
Date:   Wed, 5 Jan 2022 20:22:59 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        aharonl@nvidia.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        mbloch@nvidia.com, liweihang@huawei.com, liangwenpeng@huawei.com,
        yangx.jy@cn.fujitsu.com, rpearsonhpe@gmail.com, y-goto@fujitsu.com
Subject: Re: [RFC PATCH rdma-next 04/10] RDMA/rxe: Enable
 IB_DEVICE_RDMA_FLUSH for rxe device
Message-ID: <20220106002259.GR6467@ziepe.ca>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-5-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228080717.10666-5-lizhijian@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 28, 2021 at 04:07:11PM +0800, Li Zhijian wrote:
> We will enable the RDMA FLUSH on rxe device later.

Then this is the wrong patch order

Jason
