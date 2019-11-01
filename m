Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5910EC8F6
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 20:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfKATUC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 15:20:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33744 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfKATUB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Nov 2019 15:20:01 -0400
Received: by mail-qk1-f194.google.com with SMTP id 71so11758468qkl.0
        for <linux-rdma@vger.kernel.org>; Fri, 01 Nov 2019 12:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GwL3BzOKq0ds1hKB7ElDSudCiv4GvOB/hy58iKY5/B8=;
        b=kA4XkYghuc1JhsLIKqtgHvYOYkbQmmO6SYAQeEOYSvqnxdZ9jZjDhUnlYr3SdULzs/
         VoX2uPnnM2cxYanlj78zNtQ8A185ZcJgnYIuK+wcaBJKUjnadFHxwWHFnNobP8aT09Cn
         HnhVwCqE58/HmHF5+ja6RFYUyhDE8o8qki7WdccEAWeGPWKB8fIH17+S7MdnxhZ3jZwr
         y9zYt4pe9WYFRB7vGaJ1TV38vnomkwp60DMN7hZ5n6Ba4axjFUG3uuRMMSdF/nELroE0
         XD1ENSPS4tRu1keLPM7zbG3a+3hiST+P1cHzfwyt+Rx8K72rUFTYxupuLkm6utoV1HB1
         nhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GwL3BzOKq0ds1hKB7ElDSudCiv4GvOB/hy58iKY5/B8=;
        b=muSVJgIVB3L+V3CQuMEVjIHSpcTRmaclq4Fg1SDE4KatD3pdj5ooCR9U2GZvFWASsU
         YmLchOYzDtmUngCV6zsQDZvi+1IOk6VZDGIBvxuvTvyyMYYJaVilv7aiIhxbsuQisIYx
         cYFOxFJ4Kcwqmo+5QdE/unsP0ZZ1w+iPKIB2/QA6IaR36D9LUy/RxiQMhmi2gzF43e4r
         dV6U2kwfVjT+6ojTcpSPm/BIrMwOJSY9qYzDM6q37eMUc1nnDoII7c3kvuAqnAps/0Lo
         p7NnqI3q1S1ZhV6c+FQDa/0PgoNh8m+UD77CTsK11R6gcelmXXtyWGehNQ6Z/svzrFFe
         0pQQ==
X-Gm-Message-State: APjAAAVzmD6/PZc/FPh0j6YgUEzYvQgNxO2Ypqi8cwYI1Xwfw2PMgE3d
        B5vqpQOsIfga0Rh6ScYn5jzliA==
X-Google-Smtp-Source: APXvYqzEDkQfD72DvPVzNHUDGv0HzF9IhjVJJOU3fqLQvuuBBx1c6gvz8fC1Pmu9FXNbHzO5K/kLfA==
X-Received: by 2002:a37:a5d3:: with SMTP id o202mr11070822qke.283.1572636000661;
        Fri, 01 Nov 2019 12:20:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id n20sm4777802qkn.118.2019.11.01.12.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 12:19:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iQcSl-0001WJ-Af; Fri, 01 Nov 2019 16:19:59 -0300
Date:   Fri, 1 Nov 2019 16:19:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Yang, Philip" <Philip.Yang@amd.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v2 14/15] drm/amdgpu: Use mmu_range_notifier instead of
 hmm_mirror
Message-ID: <20191101191959.GC30938@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-15-jgg@ziepe.ca>
 <a456ebd0-28cf-997b-31ff-72d9077a9b8e@amd.com>
 <20191029192544.GU22766@mellanox.com>
 <30b2f569-bf7a-5166-c98d-4a4a13d1351f@amd.com>
 <20191101151222.GN22766@mellanox.com>
 <8280fb65-a897-3d71-79f9-9f80d9e474e9@amd.com>
 <20191101174221.GO22766@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101174221.GO22766@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 01, 2019 at 02:42:21PM -0300, Jason Gunthorpe wrote:
> On Fri, Nov 01, 2019 at 03:59:26PM +0000, Yang, Philip wrote:
> > > This test for range_blockable should be before mutex_lock, I can move
> > > it up
> > > 
> > yes, thanks.
> 
> Okay, I wrote it like this:
> 
> 	if (mmu_notifier_range_blockable(range))
> 		mutex_lock(&adev->notifier_lock);
> 	else if (!mutex_trylock(&adev->notifier_lock))
> 		return false;

Never mind, this routine sleeps for other reasons it should just be as
it was:

	if (!mmu_notifier_range_blockable(range))
		return false;

	mutex_lock(&adev->notifier_lock);

Jason
