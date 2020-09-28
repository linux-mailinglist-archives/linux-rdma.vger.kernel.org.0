Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F7627AD52
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Sep 2020 13:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgI1Lzv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Sep 2020 07:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1Lzt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Sep 2020 07:55:49 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50811C061755
        for <linux-rdma@vger.kernel.org>; Mon, 28 Sep 2020 04:55:49 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e7so445453qtj.11
        for <linux-rdma@vger.kernel.org>; Mon, 28 Sep 2020 04:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O+dJtTci3eD3nmfqR/g8Ssfc2v3e4C147vKh7tn+c9s=;
        b=XUreKkADqc+Ca8Lo7EJeDIn+KMzk+TJYoYHlQjKiE0ZIv+DHIGz2525H8zfGJjbIIL
         rxd5yLwiTFzJ3eYN+e09JBV1N4+wmkdU0OXsbpQsC4Mv/fviFiFMdcZsm8J22ZuYi9B1
         XrYaqIajcd7uX0B8vQrDdW67wHrOe/I7WmuPyYmq+tkZKHklgMQmUbm3AonH1g7wwLc4
         RBZ0KUCBN45SGqNt4gCmt0u/+6X3IgaZrfU1Ch19OuFK+DJ3V89y5oVRZl1dyaWALOq1
         noeEtCTYUT8ku1gYAIuNTI7O6F4fqiff3r7QZZU2L1oEBoQu2L3eRTlj3FzfDurithcF
         ydFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O+dJtTci3eD3nmfqR/g8Ssfc2v3e4C147vKh7tn+c9s=;
        b=tIf75hCX9gTVLu5LNYs18JhB6NAwWNoiqSesv6dW/rxrBkiRr92ObbSoCDSFtlDZH1
         jLTUSDyM+24hfZDkVRCWrXJQ8CHTNDUdhkXvPnq65E4PG8JgLP+X0sDQc81M9chU6j2x
         whuV2ePVCS/TqtgsL0udEw7eZgu6YgYp0bjdMkqblUxsgzpWS8uGRn2yOlyz+3AkZwCE
         xd71VhOXo0uzkgQWgOSrrIWlx3w86T6Zzo+55n8UQn4b1h5n8bEZdxQosUhuOEWjapLI
         slpVb7jfY9PfS90MyjImgVoIsfnUvZOW4bim5fywdFGqv1RsgvcGI/QF4lrmVShqIM2a
         yMZw==
X-Gm-Message-State: AOAM531ELm1vbCSNcgxFkxdj6qd8/E7muCcGyMKxbbdccG4H3gDA2EHF
        bmmwOmUXou+YTPsRkvrbBd8BF+I70JAFfoNX
X-Google-Smtp-Source: ABdhPJzylAqZGfOxuRwSYONTE3GYcr+QYn1ezgqfH4AcedHlWdd7iwKbupX1xNlT4CdQZ2dmvZJ+yw==
X-Received: by 2002:aed:2946:: with SMTP id s64mr1052235qtd.335.1601294148580;
        Mon, 28 Sep 2020 04:55:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k26sm982791qtf.35.2020.09.28.04.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 04:55:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kMrkx-001tim-3Z; Mon, 28 Sep 2020 08:55:47 -0300
Date:   Mon, 28 Sep 2020 08:55:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Remove unused variables and
 definitions
Message-ID: <20200928115547.GL9916@ziepe.ca>
References: <1601200341-7924-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601200341-7924-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 27, 2020 at 05:52:21PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Some code was removed but the variables were still there, and some
> parameters have been changed to be queried from firmware. So the
> definitions of them are no longer needed.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h | 8 --------
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 2 --
>  2 files changed, 10 deletions(-)

Should have a fixes for the patch that removed the code

Jason
