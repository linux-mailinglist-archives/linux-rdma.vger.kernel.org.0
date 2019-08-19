Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD77950AA
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 00:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfHSWWK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 18:22:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34525 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfHSWWK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 18:22:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id q4so3771476qtp.1
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 15:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9tF/xHAhZ516dn+gEJYG3pEDOElpvS9fvxoRear+kN4=;
        b=J7/ASB90A/7LfBNDmG0O3c4ffb8C8mJHLy3tqLBMNl5OZSeKxRxdST+9AEyTDXj/+L
         tx/IKT3agMO9523a3Vy7bWPEQ0fOd2ABYSyhQOoaM+bTrjDgVDq4ma8TX31a/SU8vvyB
         l4TJFpr1RR48pgFwTL9eLOhnG6TjzNM/7S3ZaTJri/08mEgECHxLA5zdWtnDv5F4POyR
         iv/xzAanBU7blocAW93dHdi9/Nh2xt7qwo6tIddVVVQRRkVpdKp/+f0ImnEibu+keKrV
         m/4y4ianaDFz5RzyUa1yRCvA+fbZmVuOr82Z1W1KZry1w9wY5F2FmRiQ8dUPylFYopGG
         w30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9tF/xHAhZ516dn+gEJYG3pEDOElpvS9fvxoRear+kN4=;
        b=NgMtjJnnDitXnHqCpIJaumWE1wpoo6oBRVbu1pibniEzQSRwNKiH2M/wYpRiVJJCYJ
         8xCjw+u7a9tTAnJ09Cd71mr4LbklJbN/apVh34DcHgp+TQieacPX4jvXkaEJ8aNpEMCc
         qSu7HYBSYLV5/EC/CeH8mbK/2itFPmsg01vXRFtceux+r6LsMIaz3UoBXMRZSf1yxalP
         yxSsYyixA92kQy85oBDkxFqMlaP5YPAJInKNh9fmFogo5To7Yb89p/N/LB1YBtBn8pRR
         nB9YBJkTq4PcwGfrz+Xu3AnMVqagklmWWYoYv6E0adPSALC8nCJmcN+mYH/iu2WU2CFF
         q5aw==
X-Gm-Message-State: APjAAAUUfBGDDuYIdLf+72zZop86t7knd/OoHcGMTjND8x7OcuZc2jWu
        Y8J9pL6qEODN9mO4BwAFlwIWgQ==
X-Google-Smtp-Source: APXvYqwlVaXmvsZYh+uftkLwzrbh8IfcolFD2S7v7xPBdjUDZP4/+1v3I4BraajlsyoQeHkFdwLneQ==
X-Received: by 2002:a0c:db88:: with SMTP id m8mr12556600qvk.143.1566253329715;
        Mon, 19 Aug 2019 15:22:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 145sm8112579qkm.1.2019.08.19.15.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 15:22:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hzq2S-0006eU-N4; Mon, 19 Aug 2019 19:22:08 -0300
Date:   Mon, 19 Aug 2019 19:22:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: Re: Re: [PATCH] RDMA/siw: Fix compiler warnings on
 32-bit due to u64/pointer abuse
Message-ID: <20190819222208.GA25513@ziepe.ca>
References: <20190819135213.GF5058@ziepe.ca>
 <20190819122456.GB5058@ziepe.ca>
 <20190819100526.13788-1-geert@linux-m68k.org>
 <OF7DB4AD51.C58B8A8B-ON0025845B.004A0CF6-0025845B.004AB95C@notes.na.collabserv.com>
 <OFD7D2994B.750F3146-ON0025845B.004D965D-0025845B.004E5577@notes.na.collabserv.com>
 <OFD7C97688.66331960-ON0025845B.005081B6-0025845B.0051AF67@notes.na.collabserv.com>
 <OFB73D0AD1.A2D5DDF4-ON0025845B.00545951-0025845B.00576D84@notes.na.collabserv.com>
 <OFFE3BC87B.CF197FD5-ON0025845B.0059957B-0025845B.005A903D@notes.na.collabserv.com>
 <OF0F37B635.09509188-ON0025845B.005BF4A4-0025845B.0060F5F0@notes.na.collabserv.com>
 <OF399EF474.834C3102-ON0025845B.006D75AA-0025845B.007708F2@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF399EF474.834C3102-ON0025845B.006D75AA-0025845B.007708F2@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 09:40:10PM +0000, Bernard Metzler wrote:

> >It is either an iova & lkey pair, or SGE information is inlined into
> >the WR ring.
> >
> In siw, the reference to any type of memory is kept uninterpreted
> in the send/receive queue until it gets accessed by a data
> transfer. The information on what type of memory is being referenced
> is deducted from the local memory key. As said, this step is
> being executed only when the actual buffer is to be touched.
> All it needs before that translation is to keep the 32bit key +
> length and the up to 64bit address in a work queue element within
> the send queue.
> lkey lookup and memory translation + access validation happens
> after the work queue element left the send/receive queue and a
> local copy of it is being processed by the kernel driver
> during RX or TX operations.
> 
> Inline data is implemented similar to how HW providers do
> it - user data are copied immediately into the WR array.

I still don't understand how kernel void *'s are getting into WQEs.

Jason
