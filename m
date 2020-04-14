Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271AD1A8B45
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 21:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505111AbgDNTm0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 15:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504949AbgDNTmU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 15:42:20 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F6FC061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 12:42:19 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id s18so534048qvn.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eusG5D6jcFoy32ZD4LulM4BOYOy0kUnD+bxHesDKhdU=;
        b=O9T8qqpQWQ87msScjiKzIJLRknJxbSzRuDQmETQVLA1tGAPQ1LRLgZMPeHoT4i3mY8
         tan73AgfXIiCtHXOlw26W6VZeeiksZLeBv/2DQ1RWNdom8EfjAN6JRd6QCB9Fhg2tw8w
         QHdApRqV+wWMPObm0sTG1wqFylH0pf1zgEbUabUj6Nx4oQ6H4Jcz3wh9gCDW/qRDEzFb
         o/PfEhpLNpz6eVZSE+JVAjeFdK+1rF2cYsREnNW+erUOyv6s3eMo2szoJh7BZRPKFtmy
         ZiAsft9tBwi+HO8RrRM5ZqMo38QNlCsu/PEmrHilpsN7dNip/24TmbxNEVQWQtxjA1y6
         GMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eusG5D6jcFoy32ZD4LulM4BOYOy0kUnD+bxHesDKhdU=;
        b=LeYXA+PAxN2dTiYRtlbxltizR+jrt+sFPcyfScLjqYPcudMmashMBgPi9pXG6W7lxS
         G7ZRr3QBiACxH4wCiLkBv8Poa245uRJhzaurXUuDk3e/2v/7Yn7d983n3CnNpktZIm4i
         tAOYxGLq0tUkgJ7LTjDY4wOpnG8cnwlajh7akyK1dFpWgG87l6jdOHHGT8V0HsLAWX0/
         D7QWz3QIh3Y8XRPxScQD+UJlPuDc1oEvlu/DBYNUdsizD4fdpVtjCWtZW94MfvBTPxfb
         xZHHHFksefvN0nkvI04KoHrluNyV9t0j6G46is4hL7w22UV19DQSrKve8ceEVBBEkAHL
         1vJg==
X-Gm-Message-State: AGi0PuantT7UPc06Okp+PHkY5363qRM1iYFhOA4hXYdToK0pD+qcfERT
        EhqF3CeFkJks699wQoSjefxeWVkmbGLpzQ==
X-Google-Smtp-Source: APiQypK6aI1cBeozShFpJuOD5OWiwixHnlaI1rHE/i+5s0oFtL+1008+PDhy5YNXgc79BKqHX7mvvQ==
X-Received: by 2002:ad4:498c:: with SMTP id t12mr1665855qvx.27.1586893338564;
        Tue, 14 Apr 2020 12:42:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c124sm7678336qke.13.2020.04.14.12.42.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 12:42:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jORRp-00077A-Ox; Tue, 14 Apr 2020 16:42:17 -0300
Date:   Tue, 14 Apr 2020 16:42:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com
Subject: Re: [PATCH for-next 0/4] Further improvements to bnxt_re driver
Message-ID: <20200414194217.GA27323@ziepe.ca>
References: <1585851136-2316-1-git-send-email-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585851136-2316-1-git-send-email-devesh.sharma@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 02, 2020 at 02:12:11PM -0400, Devesh Sharma wrote:
> This short patch series is an extension to the previous
> refactor series. The main pourpose of these patches is to
> streamline the queue management code in slightly better
> way.
> 
> Devesh Sharma (4):
>   RDMA/bnxt_re: reduce device page size detection code
>   RDMA/bnxt_re: Update missing hsi data structures
>   RDMA/bnxt_re: simplify obtaining queue entry from hw ring
>   RDMA/bnxt_re: Remove dead code from rcfw

Applied to for-next, thanks

Jason
