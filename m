Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 737D075310
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 17:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389348AbfGYPmu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 11:42:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43313 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389338AbfGYPmu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 11:42:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so5198406qto.10
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2019 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VdsiE7PwnNCqPYMWC9Usqlf8mELKmiXFo/BWpMUIGHQ=;
        b=aY+uSE9KsCww6ugTJthadVvy+L1ffmObEIE6BkUYCCyEWWdYPNPK0Z/aL1KBggV8BO
         YUTWxG/wFHlT3tIHWr+ZRyc18XWC9FVZACvAjoWHQR55OGGJxDizTNUh6BOTXZRb9N0I
         ehsZDQq8D6YMH6P4LA+8ABHRqnZeZSjF3Y2clD8KqGCyEAFtKbQM6sJ/utt1Q/UMU9SO
         UheW58lGR+fjGk43UcyOUzkXpbJBfEbqEtXub87UZeIJH/Q0emDKELEe4BaPxUBLRPtZ
         feNAxz9/XsxiABH4GRNEcDEavzN+2VI8UMR3zYiiwCRNHXrhqQXVV/N6WQF+/gyK8/yl
         RXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VdsiE7PwnNCqPYMWC9Usqlf8mELKmiXFo/BWpMUIGHQ=;
        b=H/N0p2T2Vxp0+GYcT4JZZ3gl/VJwlP/HRH22RWM6aFIcYRWJPmHt37YnXn/O5we5Nj
         l0VrAIT/wHwJa6ZAxW/6E3cwE8FTbCkohOb8/bI2cKSIbk+rUD671f03dih3yVyTeTEc
         BmwqndFy7e5G65EO263r2oiZzCiu72w9oc+H+u51KrUn2svcivYWnzbNbwtgsbSClkEH
         PkxTCv0qedUFWAx1WaxpR1zcfkIUCZldW26YIMnJGXiKdby3uZ5U7u9EqfCITxqI5JJz
         Ri1dXDZskyCFkwYbE2UXiiNQouydRhgC5t1LOzOG8rO6qmQW6TJzFVC6VB+GURkcnuoe
         Y5wQ==
X-Gm-Message-State: APjAAAX7Moe4wIemoiWb/oMQoHkdZk1I0wOKNlt2yRG5B1510oJ0lfnh
        /CqBOxTOZ98d6fbZjyqddfdEPQ==
X-Google-Smtp-Source: APXvYqzXQTiUXs/ASR0Wx9y8UcfQp6AkB0QyZUgsg9X7YRvKQYN3jVQbRK4tRagSTr5PU/Epyhd1HA==
X-Received: by 2002:ac8:2425:: with SMTP id c34mr60832837qtc.257.1564069369701;
        Thu, 25 Jul 2019 08:42:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o5sm22050643qkf.10.2019.07.25.08.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 08:42:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqftI-0007Ip-Op; Thu, 25 Jul 2019 12:42:48 -0300
Date:   Thu, 25 Jul 2019 12:42:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/9] Codes optimization for hip08
Message-ID: <20190725154248.GA28014@ziepe.ca>
References: <1562593285-8037-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562593285-8037-1-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 08, 2019 at 09:41:16PM +0800, Lijun Ou wrote:
> Here are codes optimization in order to reduce complexity and
> add readability.
> 
> Lijun Ou (6):
>   RDMA/hns: Package the flow of creating cq
>   RDMA/hns: Refactor the code of creating srq
>   RDMA/hns: Refactor for hns_roce_v2_modify_qp function
>   RDMA/hns: Use a separated function for setting extend sge paramters
>   RDMA/hns: Package for hns_roce_rereg_user_mr function
>   RDMA/hns: Refactor hem table mhop check and calculation
> 
> Xi Wang (1):
>   RDMA/hns: optimize the duplicated code for qpc setting flow
> 
> Yixian Liu (1):
>   RDMA/hns: Refactor eq table init for hip08
> 
> chenglang (1):
>   RDMA/hns: Optimize hns_roce_mhop_alloc function.

Applied to for-next

Thanks,
Jason
