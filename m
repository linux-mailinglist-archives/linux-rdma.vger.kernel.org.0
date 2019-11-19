Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6A4102BE1
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 19:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKSSqz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 13:46:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41597 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfKSSqz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 13:46:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id o3so25785844qtj.8
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 10:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=waPjNxESq+kQZWKTUPCCcC8rNU3LzzlpjxRRJn5dBkY=;
        b=dMVRKRRRyS/Z2VjIRMF5u0HVZohbRbYjFI9925oSG5pnpJIDlQBjgnxkqlYMtIES66
         magdmktzu82CONI1D6A731J+jKUTo9yQlyHN/cOCjj66zWbkms+zMVBAaPA6CsFnTYPj
         uJ6Z1SOlLzAjD0S1so69PjXwBA5CzbebtzPimiDo5/Ek29cIyhwlImlMBWoYt1eGEhX1
         03Ppca8MHX+rWTzY5fz7qyqYgY0HaXm96b5Y1jO8MrofSj6Yw9KkIAi2PDdiL+WK8JTH
         tnvWUuPr1KJ4Au+1ZOGvyLjSUddTvssm/rTYcpeCS/AwusqTfOuVV4QgEszzZ6xmBHUw
         HFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=waPjNxESq+kQZWKTUPCCcC8rNU3LzzlpjxRRJn5dBkY=;
        b=YvjhyDGZKsxP+YrrBtyepgQMRJY91tqnXVRmNm0GtQnkepSPla8CwwHiN/GTZVP0Ek
         kZSz6kv/FYQLOGDlMua9YpUrxIF2XETzYiJOXsm37C4pu0HVAXLXoKYxIpzOQwlt7vfO
         YbrXSyOM3d2rOUWE84dWu4AIIp678u3Sr27gVGdcKmfW7NrmGiTxzmPegUa33D8zZqvK
         f9J8QhTKPLWz3xz1a+PuFEy2InMwvPCRSo5HcfyuslLWdeI5xZ4sp8IXe3qJ5juECQBm
         9dfBxSMs3cx1HQQCotdtd2ZVBFtYN5mWYgMKrExqvVfpGY9qDgmpgSQy2raTOUVsszVJ
         5wcg==
X-Gm-Message-State: APjAAAWLp/WJirJ602aBF/pIBGCI/pR1RkmWmK1oBXG8RC+quQg8x9x+
        Km8NgVw65ixzet59WVhr8hmNxw==
X-Google-Smtp-Source: APXvYqzxMOh9qTELll3W9OpwNWBs1NyGIZl+b9apMVYhjp8Zd8wYsT0KHsLoAM9YOAv8kVNYYsuW7g==
X-Received: by 2002:ac8:33fb:: with SMTP id d56mr35085102qtb.377.1574189214045;
        Tue, 19 Nov 2019 10:46:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id f2sm10104929qkm.130.2019.11.19.10.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 10:46:53 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iX8Wa-0002NY-Ds; Tue, 19 Nov 2019 14:46:52 -0400
Date:   Tue, 19 Nov 2019 14:46:52 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Liuyixian (Eason)" <liuyixian@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Add the workqueue framework
 for flush cqe handler
Message-ID: <20191119184652.GH4991@ziepe.ca>
References: <1573563124-12579-1-git-send-email-liuyixian@huawei.com>
 <1573563124-12579-2-git-send-email-liuyixian@huawei.com>
 <20191115210621.GE4055@ziepe.ca>
 <523cf93d-a849-ab24-36f0-903fb1afe7ff@huawei.com>
 <20191118170229.GC2149@ziepe.ca>
 <ace6095b-f8ba-80ca-7466-fcbf0c848a33@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ace6095b-f8ba-80ca-7466-fcbf0c848a33@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 19, 2019 at 04:00:00PM +0800, Liuyixian (Eason) wrote:
> 
> 
> On 2019/11/19 1:02, Jason Gunthorpe wrote:
> > On Mon, Nov 18, 2019 at 09:50:24PM +0800, Liuyixian (Eason) wrote:
> >>> It kind of looks like this can be called multiple times? It won't work
> >>> right unless it is called exactly once
> >>>
> >>> Jason
> >>
> >> Yes, you are right.
> >>
> >> So I think the reasonable solution is to allocate it dynamically, and I think
> >> it is a very very little chance that the allocation will be failed. If this happened,
> >> I think the application also needs to be over.
> > 
> > Why do you need more than one work in parallel for this? Once you
> > start to move the HW to error that only has to happen once, surely?
> > 
> > Jason
>
> The flush operation moves QP, not the HW to error.
> 
> For the QP, maybe the process A is posting send while the other
> process B is modifying qp to error, both of these two operation
> needs to initialize one flush work. That's why it could be called
> multiple times.

The work function does something that looks like it only has to happen
once per QP.

One do you need to keep re-queing this thing every time the user posts
a WR?

Jason
