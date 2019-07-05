Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4905F60B05
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2019 19:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfGERXx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Jul 2019 13:23:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34887 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfGERXx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Jul 2019 13:23:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so11887297qto.2
        for <linux-rdma@vger.kernel.org>; Fri, 05 Jul 2019 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nWB3Xl18yB6jyDbIvd/2x3/FAkMrpBjdbE7XUsYTdXo=;
        b=CkxqO6JM9xxB5qZBbO+ElxFuozP60P2qgNzO8ljVH9rOnGJipcSh6kv/q7erD9MbE4
         AuxR4JDclV9RG9s7A8pUdRHSV3w41Cmba+Y4llxTnMsdgJ4mQHGJV7EPlLDQSJy2X7T8
         kwz9YUOTyb9HcyBRolOWPqhQfGEG3K/0Ugccr8eekfIZuXsPZhaT7e9K09a0Mh096DPI
         rMUl9MlRammNdyDxA8BCB4rjnYeBp/VG8GQo44cG8Q4R8FLI/+D/7fFoFb3uCHzS/sQz
         CCvErBB2THF3+MXEuSgKxoC/SsiRzD1n4LYlg4fTuhSRXq/pNY1Nm0LFxW1v/ZrpuAew
         dp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nWB3Xl18yB6jyDbIvd/2x3/FAkMrpBjdbE7XUsYTdXo=;
        b=SPisEHvdGLs7Wh83lpk1+6mdlRzflArGsNdlfhz2M1DNG2xL3/yJjnqc3nIbFTk01N
         FhcezoIrzc4wok+9adwAGTkhxJWlEgqgNhDp3kgJIi2uSLwHXvV/+Z9fsg7/A3xzR4Xw
         g9LEv/7cnNDY/O4a8okOPkfjAA4eebkxvgzvodgaFT4ge528QxvoBqLEwR57seiuxrzx
         NOg8EDz64PRQ6TMZKV8JbUZdnr6fmbBGqPr/Q4Oeg/Smi9hHIsHqx2UO6ABBFTfcXg4a
         LF4cX5YqodxMMWYOMPjVibjdY+24x8Xxxfm3mNKEdkgpx2UzKtcDk4lsXOQSKXpK0fOR
         vdLQ==
X-Gm-Message-State: APjAAAVJOxqvaKnp4fuu/tal1kN6on3FvSwGf9dYBLa76w/CKueKQTZr
        fJY/U0cjB9vyZaXyoZPmuBjKcA==
X-Google-Smtp-Source: APXvYqyrAFr6PA9hc932caOUqKqw25vr5MNrnEmAHYJJVpeon59IejQ/FZ8tltHyJGIFqEXHTIr0wA==
X-Received: by 2002:a0c:b66f:: with SMTP id q47mr4322420qvf.102.1562347432464;
        Fri, 05 Jul 2019 10:23:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q9sm3831593qkm.63.2019.07.05.10.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2019 10:23:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hjRw7-0001t6-C2; Fri, 05 Jul 2019 14:23:51 -0300
Date:   Fri, 5 Jul 2019 14:23:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/8] Some fixes from hns
Message-ID: <20190705172351.GA7234@ziepe.ca>
References: <1561376872-111496-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561376872-111496-1-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 24, 2019 at 07:47:44PM +0800, Lijun Ou wrote:
> Here are some bug fixes as well code optimization.
> 
> Lang Cheng (3):
>   RDMA/hns: Set reset flag when hw resetting
>   RDMA/hns: Use %pK format pointer print
>   RDMA/hns: Clean up unnecessary variable initialization
> 
> Lijun Ou (1):
>   RDMA/hns: Bugfix for cleaning mtr
> 
> Xi Wang (1):
>   RDMA/hns: Fixs hw access invalid dma memory error
> 
> Yangyang Li (1):
>   RDMA/hns: Modify ba page size for cqe
> 
> chenglang (1):
>   RDMA/hns: Fixup qp release bug
> 
> o00290482 (1):
>   RDMA/hns: Bugfix for calculating qp buffer size
> 
>  drivers/infiniband/hw/hns/hns_roce_cmd.c   |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c |  4 +++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  9 +++++----
>  drivers/infiniband/hw/hns/hns_roce_main.c  |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_pd.c    |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c    | 13 ++++---------
>  6 files changed, 15 insertions(+), 17 deletions(-)
>

Applied to for-next, thanks

Jason
