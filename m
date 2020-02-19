Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D786163881
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 01:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBSAYv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 19:24:51 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33039 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgBSAYv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 19:24:51 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so15997779qto.0
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 16:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FhF0ZDyYKNk5Yq7ZCEqXSDJQMEKVIumdy/wollI5R68=;
        b=cfgAwvjvb/VB7SWmcerqu/ZyUwshT0CVr5ZIulzf4plfCSpJdpPpyg07bgx30E6yhB
         z1K0LyKRH7WtzU4F35eW72koqyztJDHsZN8bJ9rMZ9lbB7zGBTSt1oPUMHpIBVDrq0dt
         7N572uEP/glYaRFIsRtr9BHWGeSLADfP65Pl6F10aYeOJHLfCDVLCLa4ekee3ry2JJGK
         pDLuURBxTR78Pgr14za88DzQzMZU7tt70XODF8tpIfy/vPDiddCBn9YyXQGGl72HTlex
         EWbGQ3lX7j/HtdS8cOJJ3fF6jdN2UFQYFMrMXXZydVyLn3A6gwFToRXzH1lRnOgem/YT
         dVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FhF0ZDyYKNk5Yq7ZCEqXSDJQMEKVIumdy/wollI5R68=;
        b=VzTes6dviRgGeiBno/r3uG6aOlDa/lb8jOBv79eBn2nbHbksf3U8aV3mx4QXoX8m07
         reYs6/NTsd8hjwEqiMJG3+PtQAfQbU6OiiqMYmhIigRt9rS5sk+BUoUJv5gKZTDqHpZm
         wcsHTdBG9q1WJ0NnlzuUYa8jriEE+Xztx0SJ+4bmHYGYGzEMJp44+hBw8CQ+K0Yjp8UR
         ADM4kipeYguaIut95OQF/iAqWBZjYbTbQKelOh0YIx5c/kyn4hevAdQyGvJswAfQv+ne
         MT0O9EUdryb+q2CL9CAjgSMIqsfR6ikltEyq1+OuYS7X7cwPy66FUdqVRS0gMY9dc1uX
         1TbA==
X-Gm-Message-State: APjAAAVRJ5uvH11C0KMo437KXPrWK/EZUxcSAjyNlsMZNG62hw/N38Y0
        mddHmPCb+L1v5DJht6SUMxrfYA==
X-Google-Smtp-Source: APXvYqyi9lhP3wSZE+ti5Vo+9JmVlEjKnucnVmZUWRpTNqkLz64F+yn/m4F4y1SBatd06kYNJN4+DA==
X-Received: by 2002:ac8:4419:: with SMTP id j25mr19800017qtn.378.1582071890465;
        Tue, 18 Feb 2020 16:24:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 132sm156980qkn.109.2020.02.18.16.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 16:24:49 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4DAX-00037W-5U; Tue, 18 Feb 2020 20:24:49 -0400
Date:   Tue, 18 Feb 2020 20:24:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jinpu Wang <jinpuwang@gmail.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCH v8 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
Message-ID: <20200219002449.GA11943@ziepe.ca>
References: <20200124204753.13154-1-jinpuwang@gmail.com>
 <CAHg0HuzLLHqp_76ThLhUdHGG_986Oxvvr15h_13T12eEWjyAxA@mail.gmail.com>
 <20200131165421.GB29820@ziepe.ca>
 <f657d371-3b23-e4b2-50b3-db47cd521e1f@kernel.dk>
 <CAD9gYJLVMVPjQcCj0aqbAW3CD86JQoFNvzJwGziRXT8B2UT0VQ@mail.gmail.com>
 <a1aaa047-3a44-11a7-19a1-e150a9df4616@kernel.dk>
 <CAMGffEkLkwkd73Q+m46VeOw0UnzZ0EkZQF-QcSZjyqNcqigZPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEkLkwkd73Q+m46VeOw0UnzZ0EkZQF-QcSZjyqNcqigZPw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 06, 2020 at 04:12:22PM +0100, Jinpu Wang wrote:
> On Fri, Jan 31, 2020 at 6:49 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 1/31/20 10:28 AM, Jinpu Wang wrote:
> > > Jens Axboe <axboe@kernel.dk> 于2020年1月31日周五 下午6:04写道：
> > >>
> > >> On 1/31/20 9:54 AM, Jason Gunthorpe wrote:
> > >>> On Fri, Jan 31, 2020 at 05:50:44PM +0100, Danil Kipnis wrote:
> > >>>> Hi Doug, Hi Jason, Hi Jens, Hi All,
> > >>>>
> > >>>> since we didn't get any new comments for the V8 prepared by Jack a
> > >>>> week ago do you think rnbd/rtrs could be merged in the current merge
> > >>>> window?
> > >>>
> > >>> No, the cut off for something large like this would be rc4ish
> > >>
> > >> Since it's been around for a while, I would have taken it in a bit
> > >> later than that. But not now, definitely too late. If folks are
> > >> happy with it, we can get it queued for 5.7.
> > >>
> > >
> > > Thanks Jason, thanks Jens, then we will prepare later another round for 5.7
> >
> > It would also be really nice to see official sign-offs (reviews) from non
> > ionos people...
> 
> Totally agree.
> Hi Bart, hi Leon,
> 
> Both of you spent quite some time to review the code, could you give a
> Reviewed-by for some of the patches you've reviewed?

Anyone? I don't want to move ahead with a block driver without someone
from the block community saying it is OK

Jason
