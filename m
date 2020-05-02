Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7948D1C28F0
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2020 01:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgEBXdb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 2 May 2020 19:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbgEBXdb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 2 May 2020 19:33:31 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B8BC061A0C
        for <linux-rdma@vger.kernel.org>; Sat,  2 May 2020 16:33:30 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 23so12991059qkf.0
        for <linux-rdma@vger.kernel.org>; Sat, 02 May 2020 16:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZUn+LcF8eVDJOfZ9L9ca4LvEQHpVc3OHuy+gnVB0x5o=;
        b=XQyCyMd+wdMeGAwMK6fTfgJQWlyxirbcGfdwNV5fQIX3FoaSUadNcQS3R97niFSMpg
         dwrF+tLCyGglQsix8cevOmFU97Mq78KFt1Rqncv8bK8T1EJaJPFS57paEvPknN1Otp+S
         3EI30P5ivVtHthQoItzYzm2SAlolwbJM3UVbFkFmLWktcDpI2TSerdWuETfwHoMeOgZ8
         CgDASaeGowaNl3+OvPz6NCUnNh0hjVUIV8eY92hCvWgpNromO9FAdF8pzBTEsmjO1ags
         wFdjbZ0f9fO3roffUaHpmIqVHHAOtNJMuX4uygQeArI1PTdDgQ0o9eZxcFIJK5NDdABw
         /VXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZUn+LcF8eVDJOfZ9L9ca4LvEQHpVc3OHuy+gnVB0x5o=;
        b=YItE3qPYhUaKBdKdiOvRw38ERUX9k+YyB6dUEDklXuepNpjNR39RdIxws+DqRxTGGO
         1jJ0doZ+h6EQD6hVKuQxajhMtTzOCTivB7JVtD1HhVJY16XnoboOJz0aSKBaW1K/Jjn6
         XlmiYHsglfrU/xFRKuVem9y0i+RI7+nIae+jl7n+Sbq3P1Uxm11dbX4BjUoG/q/Eup96
         mab7fuQTIhU5L8jDHlVp8ZQbcirsQVyrb4ux8nCXQNRyxNKO6ySrhLs+TBqV1Ak21rgC
         PBHyA/vnG9CgdoNQVXp5dHEW4RyLJ3WhndLYfwh/GQXm1/6gDW3XJ3cPPSr7YfqVpLc8
         ASYw==
X-Gm-Message-State: AGi0PubxpkmnrUioQq2GoFEvZj0bjZyaCgVlOdxObP7VnMcn1lEF/rS5
        xPG19gyQmErz56t5YVIu4zBzyg==
X-Google-Smtp-Source: APiQypIAHHFUIiIvRRPFkoKUOCZ7GpvWuF97vvI7wi7Tr2BuehfAgpgXxRabQdLdhlAXgvFZF7Dt7g==
X-Received: by 2002:a05:620a:2110:: with SMTP id l16mr2740671qkl.106.1588462410145;
        Sat, 02 May 2020 16:33:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l12sm6159651qke.89.2020.05.02.16.33.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 May 2020 16:33:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jV1dR-0007En-7r; Sat, 02 May 2020 20:33:29 -0300
Date:   Sat, 2 May 2020 20:33:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>
Subject: Re: [PATCH for-next 0/3] EFA statistics minor updates
Message-ID: <20200502233329.GA27778@ziepe.ca>
References: <20200420062213.44577-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420062213.44577-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 20, 2020 at 09:22:10AM +0300, Gal Pressman wrote:
> This series contains three small patches to collect a few counters we
> found helpful when encountering different issues.

Applied to for-next, thanks

Jason
