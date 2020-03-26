Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D62194606
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2020 19:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgCZSHF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Mar 2020 14:07:05 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33991 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZSHF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Mar 2020 14:07:05 -0400
Received: by mail-qv1-f67.google.com with SMTP id o18so3528028qvf.1
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2020 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8blfNKcDeoBIPufjTFZsklBm/0Dor9f8ZVJaWR3UrK8=;
        b=DKUX1BHk06ERJh37xYHb/jP5oKcKpIiiWkKxSM4+Wt0c456Dfl5tzDVsEqk7jx5DUA
         OfKMJNUR1TtyFSfq8mmICmCGU3LRPPJCaHY/ANeBElf0olb0V63JVX6Tmj6WJbVpDVBi
         XJp0BYOtBj8v/bAemow3Lx3Od8VCHCKNFNW8wUhaYiaKxV5I06PPH+49OJXN1xNoKLn6
         /JQnJGBEBxNBGF7b2pS1oDApysM4NrLdJvlMiVWsIT3VxCVZ1isOoOju1yzohDMDlcCt
         YO8Cc84vaWXLgkYRpem3h5o3uR1dKOdwTYtAn5gE59E6h4WSKBgVkaWcmpVla+zsSARm
         nbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8blfNKcDeoBIPufjTFZsklBm/0Dor9f8ZVJaWR3UrK8=;
        b=dFeoynflZlXf+Jcf2Okh51DMLlxfKycrJ4z420rDBfDRpcziQDncAt5sj1TBdv6f92
         O0orzGf0FvkxUEYHdG409YUP6GqjpnATer+xsCtuOLvn4jgejN14SX3oHZzFY4EmeHZT
         OQS6ndAJydF5McMxtE0Ror3q+srjPWbqRZKy3yMFXvkaIPbaPMpp+mrulGkNFGbrSLec
         ITAuzN++vUkdQ3KBli94AHmTjx188zePyCMfVsqyrt7Tibyl7HxdtEONDSTCKez1Ebs0
         SlKxd00GuWDdUGFUnW41NKtGxvJp264/doMMrHk9JcFZXzVzgOHiQROms4dWhR6988+p
         QUhA==
X-Gm-Message-State: ANhLgQ0Qgq43GsQw/f/2FXs5Ivs86fIF5QseT0ve2S9N5GQjne5frNqN
        nr0ZuflLXLRWGyeWnTOw28Wu4Q==
X-Google-Smtp-Source: ADFU+vvi09yZFDxKdrNic5iQNWICdw4JgkAgWBCUWoeItEYtkI1mOy3qoP1EGWX8cOeu7dngrT8qdg==
X-Received: by 2002:a0c:a998:: with SMTP id a24mr9425908qvb.141.1585246023828;
        Thu, 26 Mar 2020 11:07:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id b189sm1848209qkc.104.2020.03.26.11.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 11:06:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHWu7-00048x-Q3; Thu, 26 Mar 2020 15:06:55 -0300
Date:   Thu, 26 Mar 2020 15:06:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] infiniband: hfi1: Use scnprintf() for avoiding potential
 buffer overflow
Message-ID: <20200326180655.GA15899@ziepe.ca>
References: <20200319154641.23711-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319154641.23711-1-tiwai@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 19, 2020 at 04:46:41PM +0100, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/infiniband/hw/hfi1/fault.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
