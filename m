Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10B1172996
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 21:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgB0Uk6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 15:40:58 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42814 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0Uk6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Feb 2020 15:40:58 -0500
Received: by mail-qv1-f65.google.com with SMTP id dc14so262990qvb.9
        for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2020 12:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0aBUaA0oLuJiQKERL7GgW3P0oTYHBeyzdqETg7z1aTE=;
        b=BYyyFkEh4d+yuj5RjFbfzvUF7aFwotu5yAk2gGE2miHxaKRz1bK6/Je1jcsoTHK653
         msnOW3FZ8WOBTuRako+F0UFSOTr8w1xp8Vjz2UZfMTvB3o1wdHast7E5sYUpXLA7KNbv
         HkMqa+RqmJmpxtnVulTOG49OnFqjLnAsxA0kTjpPNwWqT/OXxAo74vsAJCmOZ1gMOrAd
         BI1O4QSimq5HKaqNgMkhbHG4FpP1E3umza0gff4GPlLi4tA9/BbRkqR2nrcyVQFxHOmH
         UKG8QA/EaHxGhcLq5ukUoAczdTRNNsE10cCzRZtR4xJ5EqDSxLJwIgujrGA3crQ+GD5R
         DaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0aBUaA0oLuJiQKERL7GgW3P0oTYHBeyzdqETg7z1aTE=;
        b=gu3WOftknKJUlIwBzy0TkT/YrgF9lwhXU3C3d7dbQu4uy3u8Vukz3yBvQzM5DKI/bX
         pIweBfNqg5NC0ghGwydd6JActkLjWj6K5+gvsgdda6eKo9G2Lc+AZ2WllD2KyDkxEcfk
         ZU0TOxzxlZWti4ctZ58b4SQ9vHipwGHUGUvtQ7YzubbMmwE0st7SMSx+lePd90LZbgdN
         yf3so1CtgfyNO5JOF1Zz2+W1MfaDDtwqHpIjDmlKgW8wVL/BdOdqSFO3ndeTYg8RpmFM
         2fGxh2eA6xcK8cwuj9vVv8MFWuAc/G25hXGVPu9kBoiKROvm82HCoQTl5v7vJDWGi3oE
         epAA==
X-Gm-Message-State: APjAAAW760Qj/wF7AGm9x9EwG0JHmiGUF/K2mQJ//oztm46u0lT9uR4z
        iEyPZXJe3tc7fqi+AutofRyUyw==
X-Google-Smtp-Source: APXvYqwzBwnZ4BdN7HJPm7KkS/YrSWbhuSQfC7fAOVxVMZRvFBIN72cTytuVboXhYlEZPCj4HH4oaA==
X-Received: by 2002:a0c:bf0b:: with SMTP id m11mr797741qvi.63.1582836057653;
        Thu, 27 Feb 2020 12:40:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o127sm3812828qke.92.2020.02.27.12.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 12:40:57 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7Pxo-0008C9-F2; Thu, 27 Feb 2020 16:40:56 -0400
Date:   Thu, 27 Feb 2020 16:40:56 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH for-next v2] RDMA/siw: Fix setting active_{speed, width}
 attributes
Message-ID: <20200227204056.GA31359@ziepe.ca>
References: <20200218095911.26614-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218095911.26614-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 11:59:11AM +0200, Kamal Heib wrote:
> Make sure to set the active_{speed, width} attributes to avoid reporting
> the same values regardless of the underlying device.
> 
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Tested-by: Bernard Metzler <bmt@zurich.ibm.com>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
> V2: Change rc to rv.
> ---
>  drivers/infiniband/sw/siw/siw_verbs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
