Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0A91370F9
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 16:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgAJPSr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 10:18:47 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37665 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgAJPSr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jan 2020 10:18:47 -0500
Received: by mail-qv1-f65.google.com with SMTP id f16so882210qvi.4
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2020 07:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/NAHPDZ41YWAQcL0rV62M3k49482xYdQRnrbQbQzte8=;
        b=M9ykmeXLsboZbLH4O9rSATaYU6lBXBB+AD4sBRrLTf7PObftWddywv0H4BtF6saVht
         45KNLXExddZTShIxQWOBaKFL4w+woIV7U2wTFP6QY7kfzHNtVBwSj2Z3C0Cvin6X5B2g
         PqKGAov7uFOIV4r17IXfCVW9ba5b65obV0+j3kM6469IP94iVcTncSmhikLWRSZhpgaK
         N9LjFUVWhJOEF8HYXZSpJttMVtQUmW1R/Qw1Z+U5mxnbLE6u98+IxlNK57TYCUaYyzjW
         w24o0VYHWL+VcRzO5IM/MpOW7fv9mqrXsPUYFdVIS4P9GQ1GFE79NIhHNCvChWhapSQd
         mKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/NAHPDZ41YWAQcL0rV62M3k49482xYdQRnrbQbQzte8=;
        b=ZVChsl7/9FmaluCMa+/4h9eCiGo2TD1jMArW28ya0x3HTtdxNeP/mOXFUsnRPuwzr7
         U8cuKqDqyOYc7VeBlmSFxKpCPeBCbRhgtaigJdG8ECIoIyylJ1KcXnkqBKq/kPuHCB4U
         eOC3gCBzqeLiC0gjft9WlEZJTfkVewPkHQ7xE+FTItept9kEYCb6ITaXtIW2aEuDMTP4
         NJEGa0KH4XhSbhOBbg4yUOMqp2GOrOZcHkaTu/Smc4kvy/oj5ZyU+zpmzJ1LS6SLRA1Q
         TVwPW7mhcz5Guovr7vckNiWqRsWUKaP0sE970yGyYWxGPTJiFwLIXf+O7sz2chPHaxF6
         iWqw==
X-Gm-Message-State: APjAAAWJ+ImeAgS0cxnkI1wL0uhFsRXp/Mp/aWKVGu5e+mt3T+q0Bv2J
        DmUAF+nNAU4FFU2am6mK5/RCGw==
X-Google-Smtp-Source: APXvYqwx+v8twhz13DceDK2rBIqkftuTw8OzROcgwKcrUqUy/IpDabTe+bzB9X8tyOnXlPNwLsiHDQ==
X-Received: by 2002:a05:6214:4f2:: with SMTP id cl18mr3246825qvb.89.1578669526595;
        Fri, 10 Jan 2020 07:18:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l33sm1138160qtf.79.2020.01.10.07.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jan 2020 07:18:46 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ipw3h-0001wc-P7; Fri, 10 Jan 2020 11:18:45 -0400
Date:   Fri, 10 Jan 2020 11:18:45 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 for-next] RDMA/hns: Add support for reporting wc as
 software mode
Message-ID: <20200110151845.GB7407@ziepe.ca>
References: <1578572412-25756-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578572412-25756-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 09, 2020 at 08:20:12PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> When hardware is in resetting stage, we may can't poll back all the
> expected work completions as the hardware won't generate cqe anymore.
> 
> This patch allows the driver to compose the expected wc instead of the
> hardware during resetting stage. Once the hardware finished resetting, we
> can poll cq from hardware again.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Sorry to keep sending new version of this patch. It was because some issues
> were found since last version or there are some conflicts to apply it to
> the branch.
> 
> Considering that this patch hasn't got comments from any others in the
> community, please forget about previous versions and treat this as a new
> one. Any suggestions will be appreciated.
> 
> Changes since v3:
> - Fix conflicts with recently applied patches.
> 
> Changes since v2:
> - Fix cq poll failure for qp1 when device reseting and do a rebase.
> 
> Changes since v1:
> - Remove a deplicate cq_clean statement.
> 
>  drivers/infiniband/hw/hns/hns_roce_cq.c     |   2 +
>  drivers/infiniband/hw/hns/hns_roce_device.h |  17 +++
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  14 ++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 158 +++++++++++++++++++++++-----
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  47 +++++++++
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  48 ++++++++-
>  6 files changed, 252 insertions(+), 34 deletions(-)

Applied to for-next, thanks

Jason
