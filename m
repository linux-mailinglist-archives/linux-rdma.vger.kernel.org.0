Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAF7201BA6
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 21:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390739AbgFSTvr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 15:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390635AbgFSTvp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jun 2020 15:51:45 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80570C0613EF
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 12:51:45 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w1so10117255qkw.5
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zP3mPfj8fYVGpA7X3i9lQw/wDhwl6Nv+h6HgzhW86WQ=;
        b=MMmRJ8t4j4VSr9X/gdvrRhfckKKnEPttgsjRqD7r42N3dR4TTyyqhwnzRR2Zmqw9vU
         /eO8RZr/A4nHSOyE8HOfUMCXLr5V4yKzT96SAI89H9oM6ivtb11eu4o1b5IwFl/nQYDG
         BnpCLEibfwPpM+qQe2fTwD8TqkotDnif2MXx2+W5OqJhUu02J9GSkKwpu8Dh9btmlQsW
         HfPeSb4neRXQnhdWbAQBoeJfQU5yXw4BH7QCQBZFfTz7zBx/ENEemRvnCmMQHQcSOvEj
         0arcTcBmJyDOK1t36aFed0to462HbPkMSNhWvaHJO5I28iu9xV3xW3atg8lfxqqFsEQb
         IKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zP3mPfj8fYVGpA7X3i9lQw/wDhwl6Nv+h6HgzhW86WQ=;
        b=J6cnIzC+OppquRUF4gJ5c7ItZKjbjRb4zuiKkWvGRXsDSPvDdM99Nm+CiEZCZaH7v1
         23ul0juHzYs/ijrtKTQaGPTC/S/BcaEkZO4ts4Nkuw6nBD6kK9FXUtKTg9N5eA0tbpgT
         uGKgWGOHJ/jAinKeLaZtOJG+dgjZ8INOFNddtmLXTGl42TUt57NL9AiB8kndRyf2pNQ7
         TszmBc55dDHA3s9Zq5q+KbgfDFY9pH0bwNlX6kNlmCvN4+ndu5M8X/DGjNlFe9Zo60Ua
         VsgQRuxO6TDbCDj9hm5xdmP40H/9ohbBCgrfs6Ux4JbikdCKWRZUrC85DRoYYLgX0spa
         CZog==
X-Gm-Message-State: AOAM533edfFJPlIlFHd/JlZ9VHz6V/tFrpukCCrATuESzOZYna3H0VrE
        PB2GatsgN3yr+ZDFNjTqtkVh88kmzCvM5Q==
X-Google-Smtp-Source: ABdhPJyeNbiGf5pDE6/nVlB6izIza9irK+wIFfmkUW9Wq6/rfhl4M8xllFEi5LwJ5619wnq0QRE14Q==
X-Received: by 2002:a37:b401:: with SMTP id d1mr5401845qkf.206.1592596304691;
        Fri, 19 Jun 2020 12:51:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a81sm7609057qkb.24.2020.06.19.12.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 12:51:44 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jmN39-00B0gQ-Jd; Fri, 19 Jun 2020 16:51:43 -0300
Date:   Fri, 19 Jun 2020 16:51:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
Message-ID: <20200619195143.GS6578@ziepe.ca>
References: <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca>
 <20200619180935.GA10009@redhat.com>
 <CADnq5_Pw_85Kzh1of=MbDi4g9POeF3jO4AJ7p2FjY5XZW0=vsQ@mail.gmail.com>
 <86f7f5e5-81a0-5429-5a6e-0d3b0860cfae@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f7f5e5-81a0-5429-5a6e-0d3b0860cfae@amd.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 19, 2020 at 03:30:32PM -0400, Felix Kuehling wrote:
> We have a potential problem with CPU updating page tables while the GPU
> is retrying on page table entries because 64 bit CPU transactions don't
> arrive in device memory atomically.

Except for 32 bit platforms atomicity is guarenteed if you use uncached
writeq() to aligned addresses..

The linux driver model breaks of the writeX() stuff is not atomic.

Jason
