Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76AA3C3A12
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfJAQK3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 12:10:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38835 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfJAQK3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 12:10:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id j31so22309115qta.5
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8JikO0r8T0ZE4eJ2o7xeY4hgTL1wSgPWe9H6kJ7EqMM=;
        b=B26mvqmL9ORO5tFdUxr12U6P2iikn9Xa5nt7pngs5Jide3MNHlUqzu5f4U8AbtJE8G
         IEgamEt0C2AvdcsRlFIZlqtJKo0ukMFWWW5PxBTl6Bsnckmof8qOP+paYea7BJz5BFAQ
         tukiSJbIw4KbD8thx6MexVcziUkKZy0udIZdxWq3B6MvYN4ZcDbp8netE7A7IQCpgczE
         jdQBsSEGrLZDqI+nFJLh18OVXhX1AhMefFlAfaya7JzN+PUE31w2QtovZEkU24kfkLHw
         DxoP+HuwaqRZswHWL6tEP4HfcbMKkgdRcUHqKzJwCRokACuCBtKXUY2cnulsCYsPbDak
         64Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8JikO0r8T0ZE4eJ2o7xeY4hgTL1wSgPWe9H6kJ7EqMM=;
        b=uSi6Y7jXwG4fm7w9wKVZHqauababXIDCpEeu0nh4TBpHbyehrnuXaeOU4yQrUNCb97
         j2S/FVbXJDozq6Bb5f2phUQjLDyYZh7gkvx/Othv/4WOH9rAcwjdoSPRjNlw+rjYQWnZ
         kzbQQeAFOITpAmyRNiSHWciHk2UQevxGqsNkmCfx8Elhfx1LK4M91kgEMh8Eyi6M1+gf
         20lZVJUj/Yh1F/TexTsA02HMKLUdZpRgWoarjPK5/Hn/wr6/LHOZvUgCeDvigmKCaIq/
         9fwAzQXoVRR0yPfctBRDerXhr7ebrk7vRC/6BAueI/rXh4z1ET0jH0uqmYeqxHHj2SKd
         0M8w==
X-Gm-Message-State: APjAAAVua6zOoNX+pmgQmbTKxEWkPuzGkD0MNmZjIZ6HK9LaAn01B8VJ
        1eR/wYtSSPAID1xTBfNKzSYXMw==
X-Google-Smtp-Source: APXvYqxzr/VB94oC1zC90kJZIknG1QhqVNFNiEhPmZOkrpqFUjOW7uKOXrzUekbB5DIP2EyWiXjE3Q==
X-Received: by 2002:ac8:46d8:: with SMTP id h24mr21414017qto.235.1569946228641;
        Tue, 01 Oct 2019 09:10:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id p7sm7837606qkc.21.2019.10.01.09.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 09:10:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFKjL-0001lQ-Ma; Tue, 01 Oct 2019 13:10:27 -0300
Date:   Tue, 1 Oct 2019 13:10:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH for-next 0/3] RDMA: modify_device improvements
Message-ID: <20191001161027.GA6757@ziepe.ca>
References: <20190923104158.5331-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923104158.5331-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 23, 2019 at 01:41:55PM +0300, Kamal Heib wrote:
> This series includes three patches which fix the return values from
> modify_device() callbacks when they aren't supported.
> 
> Kamal Heib (3):
>   RDMA/core: Fix return code when modify_device isn't supported
>   RDMA/bnxt_re: Remove unsupported modify_device callback
>   RDMA/rxe: Verify modify_device mask

Applied to for-next, thanks

Jason
