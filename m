Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD870173B93
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2020 16:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgB1PiL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Feb 2020 10:38:11 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46841 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgB1PiL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Feb 2020 10:38:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id u124so3273924qkh.13
        for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2020 07:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UlcMQxfu2WJaijM9QYrJUXWQke9024C1BDXEERj6XQA=;
        b=bln9lq61MEw5z+lk21AhKg5ijsty+wsl1aKO5tFxpzk0FHTQ2tAtXfpcOF3BNUINBT
         yrvX5zPzLfdBU2foLYvW+IF0wQ312xS0lJ7NDSye6aRA74dSWd5tI9T98sLR2UfsQOKK
         2R4qGbFtyMGSarOaQdxij0obmuSPXW4xheKh+ntDswTZbbO9tPB5D1YMXiywyp7Dzmrd
         u/iCe9McBSce91EfLMi3SAS9Z5w6ToMufx9COXQZeME49/mIK43CvhmhHRntC7B6OB6M
         W+jIjbCA6+0pWBcl6BqfkSSz2kptia17iT9i6vvM9ctLB++BAQbStRxuntvJ9ChSj87N
         UvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UlcMQxfu2WJaijM9QYrJUXWQke9024C1BDXEERj6XQA=;
        b=XpumkTDMN8LUh4odnP1eKaKYievgkhNbF79IM83bFo5Vxo9rrjmeVJLFgq7y7lps1G
         nTm9wBJ98rtims6ugGbt61Iqb4Nupc/GarZqYsn9ZTWgAN9DeFx2I+mJksvAaAjeJNlk
         /lljzEM7HZcR6tF96p5ejnJ8QFSMQOZsn4Zqlzb1baVSr7ItvVCKcZKmtTepjo2AMFrC
         HYjavxnQPsQ60pe7uUT9fyUPwyCHaOFrEPv/JasXk5RagKV0jg98A+b/Eg890TBb/m7S
         /SxBN1aS4QSaFvsW2eBDfv2O9zc64+Y4/pHiwLwIbIJP/qwF6SLCyxMFYgL/X9MaVEFk
         e1SQ==
X-Gm-Message-State: APjAAAV1hFzLv0Z49OwfVUA1R86VcjLsL4itIwOx+Gz7/42DwiylT6k1
        y96wG5GROyo6jFP/PtggeGxq+g==
X-Google-Smtp-Source: APXvYqybktO/R9e2GmtJt4OKnUj037+4EeZosT4DsxJ9u/RBCQYcWV7vIW/19nTC9W06i2jY3r2wvA==
X-Received: by 2002:a37:4755:: with SMTP id u82mr4786425qka.43.1582904290007;
        Fri, 28 Feb 2020 07:38:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v12sm3702030qti.84.2020.02.28.07.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 07:38:09 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7hiL-00028n-7a; Fri, 28 Feb 2020 11:38:09 -0400
Date:   Fri, 28 Feb 2020 11:38:09 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 for-next 0/7] RDMA/hns: Refactor qp related code
Message-ID: <20200228153809.GC8161@ziepe.ca>
References: <1582526258-13825-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582526258-13825-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 24, 2020 at 02:37:31PM +0800, Weihang Li wrote:
> This series refactor qp related code, including creating, destroying qp and
> so on to make the processs easier to understand and maintain.
> 
> Previous disscussion can be found at:
> https://patchwork.kernel.org/cover/11372841/
> https://patchwork.kernel.org/cover/11341265/
> 
> Changes since v3:
> - Fix wrong judgments of inlen and outlen in udata to maintain
>   compatibility in patch 7/7. Other similar issues in hns driver will be
>   fixed by another patch.
> 
> Changes since v2:
> - Change some macros into static inline functions as Jason suggested.
> - Unify all prints into format of "Failed to xxx".
> 
> Changes since v1:
> - Reduce the number of prints as Leon suggested.
> - Fix a wrong function name in description of patch 4/7.
> 
> Xi Wang (7):
>   RDMA/hns: Optimize qp destroy flow
>   RDMA/hns: Optimize qp context create and destroy flow
>   RDMA/hns: Optimize qp number assign flow
>   RDMA/hns: Optimize qp buffer allocation flow
>   RDMA/hns: Optimize qp param setup flow
>   RDMA/hns: Optimize kernel qp wrid allocation flow
>   RDMA/hns: Optimize qp doorbell allocation flow

Applied to for-next, thanks

Jason
