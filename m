Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B07229A96
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 17:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389352AbfEXPHJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 11:07:09 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40131 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389350AbfEXPHJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 11:07:09 -0400
Received: by mail-vs1-f66.google.com with SMTP id c24so5991810vsp.7
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2019 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mKemcv8by79IPZnaniy6Y+zcMWw4kiAbtu3LKiVJ/+o=;
        b=KciMXCAO16tqC+NBh95gtSiSpbmeeRjyjZD0SItB4WkkMi124VSjx2BKbayivCheoy
         hk/r9yRa6fOcs9NCAvaxYLQw63qvK/hAAQYALUr8Wih5GG3QTV4OwmsGnP+1MptVSv6Y
         2JCeLahcRGnm6zT7wXV0me5pa0nYX0rZl/bLXwK3CVPL3NTWNuluO1Z8R4JdJRNvONF/
         mZS7o4WK+WFDuMPT9/qKH0DlpNTT9h/OKeEcqS53UPlZWYwSKyUfA0F87ky4hmDskHjS
         zR+DozS9X9OtldRd9JvGpoYhtJOEMuhEAoIAd9k4OiBEYGHPHswO0wYxxCB8kbuxebFy
         3keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mKemcv8by79IPZnaniy6Y+zcMWw4kiAbtu3LKiVJ/+o=;
        b=SUhs0WgWzofIGBB+PonQwF3Ir/RfN780b0H5MHrGioa/ZhnH4gQWroxfAIiR0lqTOi
         Yc6jHnQzlvc0JyQU2UrC6TcgXGBWTRFXqLHa9UVF2iSnxpkqVzATtqhyn5OelvTziTA0
         +YvVGbSoIRrxXvZsk5VG8BvNGcPn/DMB9ZJq08jOI5sZSFYr4tRd/h/6eJ1ahu3qQM2l
         GwfqkrYwUM8GpFkSih3/XWJ7EKP2NljbdnyCsTNfEost7loRTKJe9fJKzRZTc/E1C423
         MOJJHh9X1o3Uzxn+v8auyudqBuVCzNo1IhCcazK4v4Kuz0xARdm8C8CiysoItJuh/nFV
         a75w==
X-Gm-Message-State: APjAAAUhmxG1z7/iN3W1WNuzvKT2Mpda+dJM9M9JgfhMoSbK1dJ1CNbN
        dXLP3cTse5bb2TzDpucecrmSdA==
X-Google-Smtp-Source: APXvYqwgzHNB6IV3Gc4fyOZV2slSuBkfyyiI7ztAx7xjl0xE4VxNiU6v22F5G9xPq/CiLjBvrNhRgA==
X-Received: by 2002:a67:fa51:: with SMTP id j17mr12405910vsq.89.1558710428227;
        Fri, 24 May 2019 08:07:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id x14sm862986uae.16.2019.05.24.08.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 08:07:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hUBml-0007d6-2d; Fri, 24 May 2019 12:07:07 -0300
Date:   Fri, 24 May 2019 12:07:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerd Rausch <gerd.rausch@oracle.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Aron Silverton <aron.silverton@oracle.com>,
        Sharon Liu <sharon.s.liu@oracle.com>,
        "ZUOYU.TAO" <zuoyu.tao@oracle.com>
Subject: Re: <infiniband/verbs.h> & ICC
Message-ID: <20190524150707.GC16845@ziepe.ca>
References: <54a40ca4-707b-d7a8-16b0-7d475e64f957@oracle.com>
 <20190524013033.GA13582@mellanox.com>
 <e9d86a45-a3b0-e303-027b-02474ed3a2ac@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9d86a45-a3b0-e303-027b-02474ed3a2ac@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 11:14:42PM -0700, Gerd Rausch wrote:

> I can't say that I'm thrilled with this behavior though,
> as it appears error-prone:
> As soon as an enum value goes out of range for an "int", the
> type silently changes, potentially rendering structures and functions silently incompatible.
> It's quite the pitfall (e.g. the foo.c vs bar.c case above).

Indeed, I would be very careful using this extension with
non-anonymous enums :)

However, an anonymous enum can never have storage allocated, so it
doesn't experience any ABI concern.

It is a good and very useful extension, it is unfortuntate that C11
did not standardize it. (C++11 did though)

Jason
