Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C415B147410
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2020 23:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgAWWyt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jan 2020 17:54:49 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50236 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgAWWyt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jan 2020 17:54:49 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so152356pjb.0
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jan 2020 14:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zCt+pEZF8rtCpQZT079nkBs/OA1g4Pz4/A9DOj6oVKM=;
        b=EPODQQd/OGO571bXNFZrBYUmthH4IP6QCRf3zcCWjWU+dFUqCrsywLonEyz9db/PG0
         k7nHh3l4uAdpJkmafZXR9OIrM9XjN0d6ehAaiyrLvEoPLsb3dN9N7b4DTnvCFVe79uPo
         LK+AIZBWCxoc1JTmyh2zHgdRUyWsb65lt8ddqNbOCWclfBHPCRE3do/YCt8108NJIlJV
         +e9qhSWgmytfIEeH7cy4tuJI5VwNRPM5bZLFWDba0tr6rqFR+O+ThH2TeGU0L6lnBwzb
         8+GKvZT3WhXvpx6hFUtiNop0S6v+WLE7ipWKO+RBrD9OVWzeqM9iyNc+Letc40FM8zW9
         ND5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zCt+pEZF8rtCpQZT079nkBs/OA1g4Pz4/A9DOj6oVKM=;
        b=KUsFiuHbRraibiyw8QMO4QvU7Nb5tvunEo2VlQpO61CGQV/GDohU0NfPoP3ee//BBH
         i1bZ8yjsNzT9rgbrkjRPq1lFBslQHmQsZQ7wygAzyzOJshVnmI4si+ahOY2EnjiQutpc
         N0mZ0G6tLNBgDR9IDpGBIJ58USBHlWAT6N+HBPghgtBHoNZR8vZpWzyV3Bhrp9D1qqN6
         hEzXu6rH0pFjPBkinDkdM3lK6HpcMC60UAM+mLx364iDb2I2xsGizzIAZQqgvri4sas0
         myuN9j6hwqem+r5W78DMishNU786pofxQHsUfibPaKy+nlIvQ3lB9MkfXpKF4T5pkHeH
         tg+w==
X-Gm-Message-State: APjAAAXO50ERMJdGP0etHsj4zfzBVjCTV+GsMcVqnNsirBaQ6I4S0u9R
        xkRDP5ajBrH/mSzVU8wRhvDyHvcnhoeKfQ==
X-Google-Smtp-Source: APXvYqwdLKDI2EBTZM2L25CWTs/hIf7yeCIFNmNXwWAwJs4Nji23pTBIvwqAMUu3PFmNsEh0YlwDrA==
X-Received: by 2002:a17:902:463:: with SMTP id 90mr444853ple.213.1579820088965;
        Thu, 23 Jan 2020 14:54:48 -0800 (PST)
Received: from ziepe.ca ([199.201.64.131])
        by smtp.gmail.com with ESMTPSA id x65sm3942542pfb.171.2020.01.23.14.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jan 2020 14:54:48 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iulN9-0003yh-JT; Thu, 23 Jan 2020 18:54:47 -0400
Date:   Thu, 23 Jan 2020 18:54:47 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Add support for extended atomic in
 userspace
Message-ID: <20200123225447.GA15167@ziepe.ca>
References: <1579052546-11746-1-git-send-email-liweihang@huawei.com>
 <20200115205611.GG25201@ziepe.ca>
 <9b7a3629-0564-6643-f6e7-c2f098afd010@huawei.com>
 <20200116195118.GG10759@ziepe.ca>
 <cebc88dc-09fe-a1dd-a3da-a3de55deb732@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cebc88dc-09fe-a1dd-a3da-a3de55deb732@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 22, 2020 at 04:54:55PM +0800, Weihang Li wrote:
> 
> 
> On 2020/1/17 3:51, Jason Gunthorpe wrote:
> >>> What happens to your userspace if it runs on an old kernel and tries
> >>> to use extended atomic?
> >>>
> >>> Jason
> >>>
> >> Hi Jason,
> >>
> >> If the hns userspace runs with old kernel, the hardware will report a asynchronous
> >> event for the extended atomic operation and modify the qp to error state because
> >> the enable bit in this qp's context hasn't been set.
> >>
> >> The driver will print like this:
> >>
> >> [ 1252.240921] hns3 0000:7d:00.0: Invalid request local work queue 0x9 error.
> >> [ 1252.247772] hns3 0000:7d:00.0: no hr_qp can be found!
> > Ideally the provider will not set
> > IBV_PCI_ATOMIC_OPERATION_4_BYTE_SIZE_SUP and related without kernel
> > support..
> > 
> > I've applied this patch, but I feel like you may need a followup to
> > fix the capability reporting?
> > 
> > Jason
> 
> Hi Jason,
> 
> Thank for your suggestions.
> 
> But I'm confuse about the relationship between "PCI ATOMIC" in this macro
> and atomic operations in RDMA.
> 
> I found the related series on patchwork:
> https://patchwork.kernel.org/cover/10782873/

I may have got the wrong capability bit here, I'm not sure where the
capability bits for extended atomics are actually

Jason
