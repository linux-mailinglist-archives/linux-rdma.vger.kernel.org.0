Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED0EB1804D5
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 18:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgCJRbl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 13:31:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38630 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJRbl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Mar 2020 13:31:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so7571987qke.5
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2020 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d01WZ3ILnt76dyCp6QoNiX7C39/Vz9z9qJJbnEhcogM=;
        b=LAnCyE4z90JChyVh3qJTQP49nX5YxYC6iwU5Ul4PzVS2eNkktPFp5+uzfdRt+ll81S
         vSPBOQ+rWVosOh6u3MhpoQjwkz/L/f/WSL15YQ3CDVG60ULBW2aKUppMP/UpyqPkpKce
         brSDRe3D57lfIAHCTg8fydgLqL/XmAcCb59n59a8Erx2Vqo8fJ3+JFy+Sd18wizXv46t
         CV/565N5pa8x63maKHNumXu8b++/aDKv0PX6mDdXT2tO4HcbR16iCuigfayAQwPl3iMk
         IuXKedBriWoQbGovUQPN6ZWvtTSw39FULhsOFNp/IF1n06iZrV/L+pnwnhZxR+BkCpm7
         hLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d01WZ3ILnt76dyCp6QoNiX7C39/Vz9z9qJJbnEhcogM=;
        b=aDI4umStRRvDk+biQSaWsOypJfC9gj4VKgYoyodiR/eAfgbudGVjmA7OogRKNJTLWp
         o8rqfb0dmg7grCx7n/bZO+dgEjPCFMDGPDfpBbNLqvD/2TE41EhnDt18yMTx7zB90ooG
         0NOt+T5J0Izps6YxYQrDjN1JuYMI8uNbSpA9+SP9zHE9cDlwLEpuSQ1CGGONshgac4Yh
         EY1NUOuDSKMANtZl8lNkptBY4kJlb4fpLTxoWnMt/Hjn9xB/L4eAz1i0Oy/rjebSdDxI
         298uSrr84WuhxEuTIPtbtQy1jVFodW2URoJg9mTY3QkM17wfhhI1tJUII5e44FfIrtEN
         3l9Q==
X-Gm-Message-State: ANhLgQ1PmZly02EEBvKxMkdSCM2MzSTC6bZ9lwbRWxZ4mDKmYSLx1Fk9
        XQcUcW/QzZ03/tceerBKtpVFKw==
X-Google-Smtp-Source: ADFU+vtrAI4WMQsmngfByjQx5lf0aBK7k+l5+oVs/ATSvWRgz2rtgdwfLJ6ZENkOhN3XAB3+w7x/QA==
X-Received: by 2002:a37:687:: with SMTP id 129mr19496651qkg.321.1583861500329;
        Tue, 10 Mar 2020 10:31:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id e38sm4975712qtc.89.2020.03.10.10.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 10:31:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBijD-0004IG-A9; Tue, 10 Mar 2020 14:31:39 -0300
Date:   Tue, 10 Mar 2020 14:31:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] MAINTAINERS: Update maintainers for HISILICON ROCE DRIVER
Message-ID: <20200310173139.GA16467@ziepe.ca>
References: <1583575114-32194-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583575114-32194-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 07, 2020 at 05:58:34PM +0800, Weihang Li wrote:
> Add myself as a maintainer for HNS RoCE drivers, and update Xavier's e-amil
> address.
> 
> Cc: Lijun Ou <oulijun@huawei.com>
> Cc: Wei Hu(Xavier) <huwei87@hisilicon.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> Acked-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc

Thanks,
Jason
