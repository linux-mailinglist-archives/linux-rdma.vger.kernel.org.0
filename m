Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0601596E4
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 18:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgBKRwJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 12:52:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40145 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgBKRwJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Feb 2020 12:52:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id b7so10940232qkl.7
        for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2020 09:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T/OvsVdpWzJEOJUPC/Fj4kYk8Ohg9S0pGXn9l4F9KXY=;
        b=PvXG/CS65NGWkKXkbYjUul++DHDv0giPdc1sV0qhiXFlagSPepkovI/BbYyGyazrid
         X5aABg+57qSKCVUozRfZQ5qdgfSecAR1r5i9x41ME1mEfj236Ww8QVbL+ohp35Igazkz
         aOtx6VNJE06c848KEOnd+2/t9xR0OP2nt8PAKqvprjsSKaVSD/cNwk5BIcA6YE4CzY5a
         lca4AfYoEWafvFd5okEjefQd3kMQM5HUeQZslXI+m09tzUVKNf8cQf81lgR7iweMWkvn
         jSdCdspf0eZh0IeJUFzvXM43ha0tOgAQiME8UIr2xzRuo6gViZSY8hstf0nGopo5iJlW
         qfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T/OvsVdpWzJEOJUPC/Fj4kYk8Ohg9S0pGXn9l4F9KXY=;
        b=rAkRO96h1LEW56AUkAIcPMogo+kgaUhN7+oa6Pf33sNkRdd2ngU9+FllCCfLagOgs1
         GhVoCvktblXldno0ssl3aK0DzFI1brDPOrugHRm3ze/ZJJrLt4l8AQAo2jOjGIa0l9KM
         4q7kDI8MvpfVQKxVVl/ClnBZ0TcXw0+lugjGJnSXdVDMzGAnTGckqGwX1SyQQT6raGz3
         yjYnW7vET4bq0duvvg6RyIATHRzbXCJQwJTTUCvo7YVYl4PjWb04cVpG3mIHKlGrnMo2
         7YRP2aYD+pX+hm+7buwD2cANUnGtuqj/WUMTmrwvlIUxpxg+7oEs1sAuGNmgmTSSy0tX
         Q4Rg==
X-Gm-Message-State: APjAAAUWNpE9W35Oc7YHyRt+p10+0qDRI1LPHRbG70Wz+J+mQJI4mTgy
        XwwnuANp4vGtRV8gY0cx8+dp1w==
X-Google-Smtp-Source: APXvYqwkddxWqwn8BYLfrNciVO9Kvj+BfcJMAJT86ShF00rV9CaEl1NtMV3q+Dk2EXZ5fHElJiGvjQ==
X-Received: by 2002:ae9:f818:: with SMTP id x24mr7240277qkh.182.1581443528643;
        Tue, 11 Feb 2020 09:52:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id s20sm2300800qkg.131.2020.02.11.09.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 09:52:08 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j1Zhf-0004Qk-OY; Tue, 11 Feb 2020 13:52:07 -0400
Date:   Tue, 11 Feb 2020 13:52:07 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/3] Series short description
Message-ID: <20200211175207.GA17005@ziepe.ca>
References: <20200210130712.87408.34564.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210130712.87408.34564.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 10, 2020 at 08:10:20AM -0500, Dennis Dalessandro wrote:
> Here are some fixes for the current rc cycle. The first fixes a potential data
> corruption and involves adding a mutex lock around a missed criitcal section.
> The other two patches are a bit more involved but they fix panics.
> 
> 
> Kaike Wan (2):
>       IB/hfi1: Acquire lock to release TID entries when user file is closed
>       IB/rdmavt: Reset all QPs when the device is shut down
> 
> Mike Marciniszyn (1):
>       IB/hfi1: Close window for pq and request coliding

Applied to for-rc

Thanks,
Jason
