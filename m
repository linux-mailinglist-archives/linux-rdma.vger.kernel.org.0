Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A6127BD1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 14:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLTNhf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 08:37:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33790 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLTNhf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 08:37:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so8222346qto.0
        for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2019 05:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mvBh76+lJR/tpWro2ArGZFD1Hq86uRUb7a5a0yDgkGc=;
        b=hMYSlvoYNOdjz3XtP4atybP8qik9sOul7OqD9jb4TGKLvrXwtHhFsdsC0dIyrJFGUa
         iGsh+ab7ST/fNWD+XmbNVJNm/GoclR5NzYaU/d9tMjFYZ0DqF1CDt/Jz0dAoMNX5E/IK
         HUFai45FGmI0IexwnlGbEKnQAveL4Tc/qtfqkpKX2Z3UaUM2oa8Lt6jrN0kx7GO0YgMj
         ZnOtOryN+jjMwM5ZU9vjSCqN/s10gh6eWf+omUGiHKUsPVXsOT3YkJqTQy2hRP6TolVi
         BI4RhRSEMuUnr+cVABloD2G0Zd/aiktIkZBhImH0r09GxZVsml+hGfzqLSzgwFlPHlAF
         LEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mvBh76+lJR/tpWro2ArGZFD1Hq86uRUb7a5a0yDgkGc=;
        b=iGPdnist5Yh3neJy5GaxIatKUesk4FAHgmkZnCyE9dTLgvqVM5biXgS02pOZaFladZ
         Pvoej4Td+f27xBjXwtidbiQPIkXUcZDjKzSpYrBJ4y0L1t9/fd0Smq1McTmNPrhmQvde
         A58E+Iz084fPHcHrJVInyCJrT9gjmeLVLgX6ii+qQAhdHYmdPDolir7+2yG6KNYI9Av7
         z2+7qIYFevOC1cu/qethheZNKKoEB6wka4Ix5yxfxu28pZPsytpyIpaGwzg4Fyu4UTZl
         4SPZP/FwBZo1G8F8jcox3vwcGD3Fzu/CYtsRowp6OY2k0SE463Dex8KzvODWTkZqUcOE
         kaZw==
X-Gm-Message-State: APjAAAXmu4DV9GexGjlTGTaHCDK52AoYb/71ccBkpvxsTk35svqCwZAs
        8u8LqYZL5Xinu5KGu46FDFin4g==
X-Google-Smtp-Source: APXvYqwtcqG36DRuM1PAWiAueB9pXE6vWKe+SSvyym8AO9qCPp1WQAQZiw4xUQx/hB44pzIQnORw0w==
X-Received: by 2002:ac8:602:: with SMTP id d2mr11809807qth.245.1576849054355;
        Fri, 20 Dec 2019 05:37:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 16sm2870532qkj.77.2019.12.20.05.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Dec 2019 05:37:33 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iiITF-0003nH-5f; Fri, 20 Dec 2019 09:37:33 -0400
Date:   Fri, 20 Dec 2019 09:37:33 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Liuyixian (Eason)" <liuyixian@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v3 for-next 0/2] Fix crash due to sleepy mutex while
 holding lock in post_{send|recv|poll}
Message-ID: <20191220133733.GC13506@ziepe.ca>
References: <1574335200-34923-1-git-send-email-liuyixian@huawei.com>
 <c6d0f4bb-aca6-86f6-f909-d91ed9e58216@huawei.com>
 <20191218140026.GF17227@ziepe.ca>
 <8e7fd052-1d3e-c408-5589-af0344084874@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e7fd052-1d3e-c408-5589-af0344084874@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 20, 2019 at 06:12:51PM +0800, Liuyixian (Eason) wrote:
> 
> 
> On 2019/12/18 22:00, Jason Gunthorpe wrote:
> > On Mon, Dec 16, 2019 at 08:51:03PM +0800, Liuyixian (Eason) wrote:
> >> Hi Jason,
> >>
> >> I want to make sure that is there any further comments on this patch set?
> > 
> > I still dislike it alot.
> > 
> 
> Hi Jason,
> 
> Thanks for reply :)
> Let us recall the previous discussions and check is there anything is pending on.
> 
> Comments in patch set V1:
> 1: why do you need a dedicated HIGHPRI work queue?
> 2. As far as I could tell the only thing the triggered the work to run
>    was some variable which was only set in another work queue 'hns_roce_irq_work_handle()'
> 3. don't do allocations at all if you can't allow them to fail.
> 
> Comments in patch set V2:
> 1. It kind of looks like this can be called multiple times? It won't work
>    right unless it is called exactly once.
> 2. Why do you need more than one work in parallel for this? Once you
>    start to move the HW to error that only has to happen once, surely?
>       Flush operation should be implemented once the QP state is going to
>       be error or the producer index is updated for the QP in error state.
> 3. The work function does something that looks like it only has to happen
>    once per QP. One do you need to keep re-queing this thing every time the user posts
>    a WR?
>       wqe every time the PI is updated. That's re-queuing is needed.
> 
> In conclusion, we have accepted all the comments in V1, and explained to all 3 comments in V2
> but no further response. Do I have missed to cover any of your concerns?
> 
> I would really appreciate it if you could help to point out the unsolved issue.

You explained you need to push the latest PI to the HW, so I still
don't understand why it needs to be coded in such a confusing

Keep a note if the PI is being pushed, if not, start pushing it. If
yes, update that PI that will be pushed and do nothing

Jason
