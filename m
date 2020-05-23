Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DB21DF3C2
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2020 03:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbgEWBLE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 21:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbgEWBLE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 21:11:04 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17663C061A0E
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 18:11:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id y22so12610746qki.3
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 18:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U9h6CrjkqhaOUHyKt4mr1/okaz1oNykSWxaZyPBg7Bg=;
        b=mc3dyM3GbiwrkbLnaTWtvzSjBNdME8IsnJmWHyWHLap+UiJc9tsGpZefW6mf7zjtqr
         vSKClrLTESVWTgHlvnu6KteazF2DhFjQcNDfTDMatNaqSmooFiwXVKp3TWg9mZklqBP5
         kY9NC5FP+INftnmVKsVLMlu9mLzC46OSwhFTOfxlE6d68vyknZhIkFvwXtPFhhlDTh3o
         k5eeXhCTm/RpTrYYbHiJffztsPGJW0+Zl50W0x6nzZuOIlKgIFJjyL4YLME2600RRs24
         FukgeGzEQCJw+0rH5tzPdlqaDCCj79SuRgmGDpCnCrvSCWnv3fm2YQK+8lfqj0KobLBd
         46SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U9h6CrjkqhaOUHyKt4mr1/okaz1oNykSWxaZyPBg7Bg=;
        b=GxKQrWj22LjhLCdsXQL0KHH57WTV3ATLkVcSsCmVC61FCUagqFJ+MZ8cv/2t0bLujO
         ihz5kaNGaUVa6YKFVlpyg6q9FnfeTyeslUUyqnzkY0dZGk88SZ9IiDtvrimULHYePSqJ
         0IfJo7JyeihtX6WltN3kM7rX5WzCICgMNsht6RJgOvdckpHRDEGXErajA5UQjIYaKL8I
         rFwL7h9HfpBRPsLH+2P/HawrXMMkEFHdcKLjTn/JYPb8NTn17e2uKW1DS89lEIdd/Pmy
         0CwrGG9UXFMwfafJfIe2pdV2HshJ4M1dT71BJGkWeqVXs5chXA1KCQP99Df5SKyes9zh
         9sPQ==
X-Gm-Message-State: AOAM530CRC5UAgVHVKfiA2Hnmlfsjhf9o0I5J7XjUgs5ffYtNmlDjP8O
        JxHl4q03kCSPpLA2/uf2jCa86TLmuSA=
X-Google-Smtp-Source: ABdhPJxRGCJnaxjIL/B0kT0VVqA3xGJexogPO1XddvxNPX8bnKMAC58UZkTsDY4e7TaoNmVaQV7m/g==
X-Received: by 2002:a05:620a:211d:: with SMTP id l29mr17576775qkl.310.1590196263234;
        Fri, 22 May 2020 18:11:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id n35sm9296373qte.55.2020.05.22.18.11.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 18:11:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jcIgo-00034p-5F; Fri, 22 May 2020 22:11:02 -0300
Date:   Fri, 22 May 2020 22:11:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: rdma-for-next lockdep complaint
Message-ID: <20200523011102.GN17583@ziepe.ca>
References: <70057e07-abd3-0254-1566-8c489cfa1c5f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70057e07-abd3-0254-1566-8c489cfa1c5f@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 22, 2020 at 02:29:15PM -0700, Bart Van Assche wrote:
> Hi,
> 
> If I run test srp/015 from the blktests test suite then the lockdep complaint
> shown below is reported. Since I haven't seen this complaint in the past I
> think that this is a regression. This complaint was triggered by the code on
> the for-next branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git. Is this a known
> issue?

I haven't seen it before, and it doesn't look like anything changed
here lately.

I think your test must have got unlucky to hit one of the
rdma_destroy_id paths.

It looks like a false positive from lockdep as these are never the
same lock.

Perhaps it could be fixed by lifting the mutex_unlock to before
the rdma_destroy_id ? Would need some study

Jason
