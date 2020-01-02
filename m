Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D81212E9F5
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 19:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgABS3j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 13:29:39 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:47028 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgABS3j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 13:29:39 -0500
Received: by mail-qk1-f180.google.com with SMTP id r14so31973237qke.13
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jan 2020 10:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9S/RnlYUTiW5scmZn1rpA3s27gWfLJPlKX02uUmU8iE=;
        b=OvFYN9N7+5SyTDmLFjXB54DHeTZwPBYhVdmsktc8tQiKiVzVXXEqQkAACMAyrXF7Y0
         Z4v9KcwNgghd4W50g/qPPpmIOoBrRy05r7f5AK0vI8bf0Uya2R63SQYxA7M/fIJqbNAL
         UItxMrxvUr+at1Dx+RBjigxkTIFb+kv+eQQSuOt54m0SBjZr53eeHm6fUp7B92jYPrku
         S38ovCbk+OWtI/8c6fXJfxOGEBPnmQboNHvKBbrIlEDVrO5UVqBb1A4yUid6F/4dRH0c
         qQAOC46KAznOwyTD9Bu8sYTZESj3yyWMR7J2PcqUxtICxurecmoKwkLdxhhqCSKuFt3d
         jxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9S/RnlYUTiW5scmZn1rpA3s27gWfLJPlKX02uUmU8iE=;
        b=S6W8txEbOyZJxKQqR/hC6oRMEuJHgEDwmEU6mS4Nc1qOW1PkyhKVrS6ggGLRIcSSZ5
         N+LQGbvWlrvw9VuT+zy3REBUbEO5+mILuyv+wHXF60xcu1lLwlDF1iQrONWvz31woNWN
         0vS7l8LOvCxmHdAcxhuc4dFAG6CoiF1ejUudQoRtxqZXFPTMeNrf9lPTZCtEAZpyYCeB
         b90Cm1woc7mrZeBxm8/NKeRpKb7WD4zSJ8R+ibzVugzQ3zXG2TFLqCe7fo93xUigDhMW
         XG9x1nIzQffosw6Wtrn2P8Uq9HPpe2unKqNJYHBWr2aaVY4OkFHiLcs8s8OYEd9Xdelz
         p7tw==
X-Gm-Message-State: APjAAAW3SJgAKELkOXDsTIdyBihL1XUowyiUIC4az/nGeJZphU6RD3J4
        vJlIe8QBjaBhcghYrD34kiiSJCrIdls=
X-Google-Smtp-Source: APXvYqwsWQ9aSEtfGbklx39DxS5hPl+qXOI85g0RMVrJL4ghc6jlxvLOCyfoi/pG3yWmugQETEdEIw==
X-Received: by 2002:ae9:f709:: with SMTP id s9mr67131364qkg.463.1577989778700;
        Thu, 02 Jan 2020 10:29:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id s33sm17364471qtb.52.2020.01.02.10.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jan 2020 10:29:38 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1in5E1-0003fD-Oc; Thu, 02 Jan 2020 14:29:37 -0400
Date:   Thu, 2 Jan 2020 14:29:37 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Terry Toole <toole@photodiagnostic.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Is it possible to transfer a large file between two computers
 using RDMA UD?
Message-ID: <20200102182937.GG9282@ziepe.ca>
References: <CADw-U9BHcoHy3WJ8iSdYjAw3RxQf2vhkOKyL7k0yJdR3mP7Mug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADw-U9BHcoHy3WJ8iSdYjAw3RxQf2vhkOKyL7k0yJdR3mP7Mug@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 02, 2020 at 09:47:06AM -0500, Terry Toole wrote:
> Hi,
> Is it possible to transfer a large file, say 25GB, between two computers using
> RDMA UD, and have an exact copy of the original file on the receiving side? My
> understanding is that the order of the messages is not guaranteed with UD.
> But I thought that if I only use one QP I could ensure that the ordering of the
> data will be predictable.

It is not guaranteed to be in order.

Why would you do this anyhow? The overhead to use RC is pretty small

Jason
