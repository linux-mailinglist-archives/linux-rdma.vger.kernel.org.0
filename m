Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF181C7A6C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 21:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgEFTiv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 15:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgEFTiu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 15:38:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694EFC061A41
        for <linux-rdma@vger.kernel.org>; Wed,  6 May 2020 12:38:50 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i14so3415951qka.10
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2020 12:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cbJdFNNUj8YFhOecTKRGNRonN2B9d8cRZOa5IORn8+s=;
        b=oUpD9vvl4JJHe8DNGfzpMqvkPO+kzlUmoQqGhCdKw75+BI+m7bXNiv0klYJ1vmX+94
         SNHt8MpihfCXwN4Z56qeRYu0LAyxnp+k7Px0vLHITqwP0wlRSnhB31NPROnJ3/41GLIE
         8LzeXjZ7rqUKYT+T2xX5LIKLB67UGfmR/j4sNdo/ssrYfmZfNVuqGR1y0A1+vg+dZrld
         FfP8FCjPIr47dsdu0G/k2pGVobmX8iInb1Iiot3eGvaF3WeZCyo26qG/N2QLcuxZWk+H
         ySXdAKPvaeLynl26s7lfFZS06XYtAjyktDeZ5Xo93TLymwQg2aJjkp+41G5KyRJuGWpe
         gAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cbJdFNNUj8YFhOecTKRGNRonN2B9d8cRZOa5IORn8+s=;
        b=C0soo8vzpd4PN+0FCv0MCQX0dBvB6tD0DDKrLRuaI9UAOzD0JlezXz2Js1FVxDRvGG
         UggBJRQCs71T+XOrfrtJN8gMumcsxhV5r7gNki4WmlcYQ57FGH5g5dPVFqHaLYoAESXQ
         4rtSEexIemsib77+lhezbuDuEtjyG+Y2UH1puCSRNC9PY8YDZ+sAxR41s/2CWEfE4DPI
         XPf6EG3NWqVdZywBINIoc0E5uG1GDGKlIwttvoPF/B05CZPq/72DOCc25R73owp8kG5s
         b+KjfNZFAibjjHOLzy7kvAVJ4LK4C0K9YHBiZnhuUTtjm55WuFnyiXFG2yN432UHgP3D
         w8qw==
X-Gm-Message-State: AGi0PuYNHI0ubi9bOwSfPtDg3QY5O0B3uETZapcIxpAdHyr7jFKUOL3J
        SOFBQ2w9H7B7BoQE/JDzxEAZmQ==
X-Google-Smtp-Source: APiQypIAFAMJdD8EpoR2nj1ZvH3BkodGgOPCjTKcRgjsY9FCZUpW+jCbWXWHG2FeYsHBVvGZjyABkg==
X-Received: by 2002:a05:620a:490:: with SMTP id 16mr10411517qkr.203.1588793929550;
        Wed, 06 May 2020 12:38:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c41sm2445201qta.96.2020.05.06.12.38.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 12:38:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWPsW-0004Xq-Fp; Wed, 06 May 2020 16:38:48 -0300
Date:   Wed, 6 May 2020 16:38:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v10 0/3] mm/hmm/test: add self tests for HMM
Message-ID: <20200506193848.GA17442@ziepe.ca>
References: <20200422195028.3684-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422195028.3684-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 22, 2020 at 12:50:25PM -0700, Ralph Campbell wrote:
> This series adds basic self tests for HMM and are intended for Jason
> Gunthorpe's rdma tree since he is making some HMM related changes that
> this can help test.
> 
> Changes v9 -> v10:
> Patches 1 & 2 include Jason's changes from his cover letter:
> https://lkml.org/lkml/2020/4/21/1320
> Patch 3 now adds the files alphbetically and removed the outdated
> reference to include/uapi/linux.

Applied to hmm.git, thanks

Jason
