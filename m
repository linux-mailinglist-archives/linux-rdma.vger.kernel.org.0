Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0788133094
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 21:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgAGUbg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 15:31:36 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45498 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGUbg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 15:31:36 -0500
Received: by mail-qt1-f195.google.com with SMTP id l12so843412qtq.12
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 12:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NYeIqOnE0tXBb1ubt+4+p6gRfXvs4Hv/Z5yt+Eg24fE=;
        b=Madi4cIHDcM83NMCI83l+OrA5Myo3KZDNY9QBm4bOh1gAnCENFYDVySuHsofuCuI5b
         kGYS8iKjcPZL53jSfG1r/mRKlDPUhib3gEmWXoS9BPXngP0InTXnDF8tnIoR5GY5PTLC
         0H+Z0+uneyWYKlmpZdjuk8qwK3xeEGCmY7/mpqHmN4HzC6Pv97pDPGJtG9GZYQLilgBI
         FpjwgvMbuWtHGxAXOgpF4bLsMycvEHGz2aB/5E6DYdJKNT6k6XUsTGP5Zr48pHPuJXNF
         +VPI2D2CuOhq+wckBMLcpnYOKj08flv2vO8lvSA/xsf9dNsgg+RX0Cts5tHtNL0N5tMg
         blRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NYeIqOnE0tXBb1ubt+4+p6gRfXvs4Hv/Z5yt+Eg24fE=;
        b=LpScmhrNyzoHF5Sj2cUqMesiC+API47sPa1HbQnHIOZu5D25B1ztbn4AaknlBku/uv
         1Nps63pjfegk59tq6E0M8SqX5OHU9UHEnENUY2/OgVzcLnYsvSpMl95jSEplJDO5uQ4r
         nw08a0WDl2XHbaziFxMZyN6zAfB5KR8HS9eT86h6YhmIdspRWD74lHcCycFglFioYWoY
         JjlS+qNAN2K1cEKKHJ5Y5qQxi9+/zx1Jyvlv5Or+lS1P7psGeaJRZ7kzPP7QFXzq2I/6
         eauH9Rf3GJP3oSm7dlBZjHF5tE5ZZuQOH7oOIeZZkKoiP0sFx06eiXNpXpKKhn4qzZ5Q
         H8JQ==
X-Gm-Message-State: APjAAAXRVOiZ+EJUugkf/rfUFsRQFQ3aoakWjBxh/eqCVuVlD+xYQCLj
        EVa03tXRajmOmlJIDxKAmFs1Qw==
X-Google-Smtp-Source: APXvYqymqTJ4f5LZWxtFPYE/Jey/cG+Zqkh77VFaO6XLYmEv8xLFB5shieqwwRx1pTyAuFCvgUSSMw==
X-Received: by 2002:ac8:53cb:: with SMTP id c11mr718935qtq.14.1578429095398;
        Tue, 07 Jan 2020 12:31:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l17sm369867qkk.22.2020.01.07.12.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 12:31:35 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iovVm-0001R5-D8; Tue, 07 Jan 2020 16:31:34 -0400
Date:   Tue, 7 Jan 2020 16:31:34 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/7] RDMA/hns: Various cleanups
Message-ID: <20200107203134.GB5313@ziepe.ca>
References: <1578313276-29080-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578313276-29080-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 06, 2020 at 08:21:09PM +0800, Weihang Li wrote:
> No logic of code was changed by these patches, all of them are tiny
> cleanups.
> 
> By the way, this series has nothing to do with the series I sent a PR to
> rdma-core recently.
> 
> Lijun Ou (4):
>   RDMA/hns: Remove unused function hns_roce_init_eq_table()
>   RDMA/hns: Update the value of qp type
>   RDMA/hns: Delete unnessary parameters in hns_roce_v2_qp_modify()
>   RDMA/hns: Fix coding style issues
> 
> Wenpeng Liang (2):
>   RDMA/hns: Avoid printing address of mtt page
>   RDMA/hns: Replace custom macros HNS_ROCE_ALIGN_UP
> 
> Yixing Liu (1):
>   RDMA/hns: Remove redundant print information

Applied to for-next, thanks

Jason
