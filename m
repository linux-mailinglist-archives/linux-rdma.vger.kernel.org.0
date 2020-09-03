Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DBE25BE7F
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 11:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgICJfJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 05:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgICJfJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 05:35:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC01EC061244;
        Thu,  3 Sep 2020 02:35:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v4so2163118wmj.5;
        Thu, 03 Sep 2020 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YmN6TYlQSwbm/wl1f5Jflst3Mjgwzhs4CRceNi7GnDQ=;
        b=ohCM+ip22BVbqXf47OCWm47Nucq2P7yWHYLgqXl6cWN4Ap17kV1B9BwEojfKVQUD3c
         lbtr+AwWpMYU9NFOcwzSLKlFeWU51tPiCfkWTUaXuMykeDkyeYjylbLGK1W4R6I9Bo/F
         EW8UUJcWYcF3ioXQgbhTG2tTnJweTqvwZ3x1EpGp0Fkfn/rbYLl5+5wmPGxX6br9f/pI
         x64CmyHNRo4yZRKk1eKKy1hRoXaV/H/hjwKkUJZH/uMJsRW1EKrBh2qjFMvayxlT44l8
         Z0FTg393wkWA6oU6rHsBI4AkSFLLf1Hv6dmsaxxnKyWiMuGehk2Gn/nkBLlQOTlvimsk
         pzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YmN6TYlQSwbm/wl1f5Jflst3Mjgwzhs4CRceNi7GnDQ=;
        b=Zt1tMkWxisdKwLMudiGVN9EriYeGzyz+JdS4Tn8Zrw7DfnPPGfYYIt6PSwnALT2ZI6
         wWBOGniFCPz5nzkj4984jjPdDsWLZGhNgLkzgW7Jt26AmNASAWQ79wVDPwbNbDAyB7VP
         OO0j70Fd8DVSrosL46odar8X89RtG22oh/kFTpx3JxvCdlZc7S61NWCJejBneOCarfbH
         vzrewjHSSYeCmpnJLMvFBxeoZ4wWcJc3w3R6CFPH8bhS+Jh7HzS27zIQdaAhNUJDYwfH
         S/20IGxrTSOaEAVfOEGc79rSlwUA7GLU5S5mXvanNSYy5iZ8FTVTqPwkUkj0h+gxg9qL
         Ixaw==
X-Gm-Message-State: AOAM533Uddisa8GEU3WEkxBIVTk3SA8llzJA1bKUU90vKzu8fLPw3veQ
        swrfuT5TueBxDDhDP17YYDI=
X-Google-Smtp-Source: ABdhPJzdYF4jAWN0nANFY3nmh0Og5LZpu/SJBN4ONUwY/Hts0Uuj+rxmZuzWvbLPoOHu782HW5ZUmA==
X-Received: by 2002:a7b:c38f:: with SMTP id s15mr521509wmj.16.1599125707468;
        Thu, 03 Sep 2020 02:35:07 -0700 (PDT)
Received: from medion (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id e18sm3515525wrx.50.2020.09.03.02.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 02:35:06 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Thu, 3 Sep 2020 10:35:04 +0100
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/ucma: Fix resource leak on error path
Message-ID: <20200903093504.ita7taa67a6x6k7p@medion>
References: <20200902162454.332828-1-alex.dewar90@gmail.com>
 <83132be0-a33b-ab7a-0da9-cc5c9398d0d4@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83132be0-a33b-ab7a-0da9-cc5c9398d0d4@embeddedor.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 07:34:26PM -0500, Gustavo A. R. Silva wrote:
> Hi Alex,
> 
> On 9/2/20 11:24, Alex Dewar wrote:
> > In ucma_process_join(), if the call to xa_alloc() fails, the function
> > will return without freeing mc. Fix this by jumping to the correct line.
> > 
> > In the process I renamed the jump labels to something more memorable for
> > extra clarity.
> > 
> > Addresses-Coverity: ("Resource leak")
> 
> If you are using a public Coverity scan, please also include the Coverity ID.
> In this case ID 1496814, something like:
> 
> Addresses-Coverity-ID: 1496814 ("Resource leak")

Ahh ok. Thanks for the pointer :)
> 
> People that don't include an CID is because they are using a private Coverity
> scan, so it doesn't make sense for them to add an ID because no one but
> them have access to that scan report.
> 
> Thanks
> --
> Gustavo
> 
