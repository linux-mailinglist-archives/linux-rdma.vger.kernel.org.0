Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3032BC37
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 00:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfE0Wud (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 18:50:33 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35273 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfE0Wuc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 18:50:32 -0400
Received: by mail-ua1-f65.google.com with SMTP id r7so4858502ual.2
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 15:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fxo8yTiGyxdN/vAempwBnvBkD311Zpt8/tNnnY00LBg=;
        b=AXiUSPwCx89Nx6+cPS/tjmeyCJnPb3eSyLHtTtPhT0hqyPkVgBA2m1t8jB7M1qpvRk
         El6EJATV/SLoJ059vTFeOndaKVzrrUsEfKOA+uECckphmKQfwplGWfV0UzzOn5z4opJx
         mTcGijzmIqJ8JZenhnA/Lsj1F870v4Ry0+5a71aHIOfjhpyHYKO+sQjE2iNCfONAoFLN
         YYRCA2PMpZlp6fNJ83nXvrwRiY9gOmY7i59HrBxIZ9zgkHzaAlU4pUREVRzWPADyvoU7
         o+q53ELVbgqBX6uyORRyzX3i3q/iysiA8OAEKFtdWOXyKS2mWrfdb6u4DtFzQLJhA1Ju
         FEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fxo8yTiGyxdN/vAempwBnvBkD311Zpt8/tNnnY00LBg=;
        b=SURu8v76pkAKQ8tWKCDnU7zMrNfyEgJ6gCoa/I2c8tnY0J9I/0gkSOtr2E8oHe/CA/
         /FdF2AHfA3Z4bwYMpjGZ1ACMzFcXy4doILeV3GkvWEnSacsNNt1YEdo5zfsL5UPSwkXQ
         7rCxvLK/jOs5ncyZfl8g332h/JedpupoM3cX2cf1j/ukAP2bV96DqGAX4LEh1C6xdRfS
         vDPe39WP4W3H2HioWUhRIhPSa0jywYG6TJ8rqCERT1HAlX9mjqpMoC6K+rORQeFk2Cxd
         /AYmG78aBZ47sxKKP2Me79/X69UPtgz8eJeS817Wo+go/HjBR7Vk31AbwT3W7Gd7MCpu
         3zTw==
X-Gm-Message-State: APjAAAUSJBfZFFYnPnEN6rhT4q3/eDFFyFLMwmHre+cHE41zsDQNiHQs
        57NRGTbKDq3CiuY3gVhZaWD8pA==
X-Google-Smtp-Source: APXvYqzY/NH0JIAoWsEu4UJd7xmbHrQvkt37r+geRG8CPCL4rYyWazn8oiNDWLKFLQAfz6TUjKJOhw==
X-Received: by 2002:ab0:806:: with SMTP id a6mr37879511uaf.10.1558997431699;
        Mon, 27 May 2019 15:50:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id x71sm8314138vkd.24.2019.05.27.15.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 15:50:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVORq-0004r4-2T; Mon, 27 May 2019 19:50:30 -0300
Date:   Mon, 27 May 2019 19:50:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Clear magic number
Message-ID: <20190527225030.GA18640@ziepe.ca>
References: <1558711776-11053-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558711776-11053-1-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 11:29:36PM +0800, Lijun Ou wrote:
> This patch makes the code more readable by clearing magic numbers.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_db.c     |  8 ++--
>  drivers/infiniband/hw/hns/hns_roce_device.h | 37 +++++++++++++---
>  drivers/infiniband/hw/hns/hns_roce_hem.c    | 18 ++++----
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  4 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 65 ++++++++++++++++-------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 ++
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  7 ++--
>  drivers/infiniband/hw/hns/hns_roce_mr.c     | 43 ++++++++++---------
>  8 files changed, 116 insertions(+), 70 deletions(-)

Applied to for-next thanks

Jason
