Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B049E88C1
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 13:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfJ2Mvd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 08:51:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36048 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfJ2Mvd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 08:51:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id x14so9657652qtq.3
        for <linux-rdma@vger.kernel.org>; Tue, 29 Oct 2019 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZF5YLLdkMxOeBnT3AEdovjyBEmTM+OTs+LDLPN0GMI8=;
        b=IHV+AJapDR5k8D6Zafc6ml2K0fa/jgF1PZBiuBMaOa/r+MK0PJ0xNtRtLiwXM8hfUM
         oyGHNxRN/O07FITOaIm5BnO1Box0mj0QkuPEB2wMXMWKVbmYTzXQRMncmXuCTctBu7gC
         91FIwEspUa/0nc1TUQ+oissChI6D4nJBO8DA40LneE6r/MnEh4dPTkicbi1e9mKDMq4W
         wpip0eIgYwCfGlBN5ll9Ug3VTlK7wx3iCECoDUwBIIk+qI/2gjDdaegrEPvi6otVA07c
         HtuIQ3uKH0+5jfdbr9pByZT3cPdoijw2I2FMN1xWV5tXm87jeYeH8MJjI7uCkOjTfH2C
         whzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZF5YLLdkMxOeBnT3AEdovjyBEmTM+OTs+LDLPN0GMI8=;
        b=lZYf8PhY7ValJ86t7LndhaZTThRVDF8uBpIRWZz6wQzD7v4SAVAjn4sUXbysMdA+3O
         F6th7HOtOODnz7DUubr/rMtADb2h2+cqAY0FjpDf7TT2tIFgKW9DKV1wA7dMhXaYAiht
         TP78XbS9IuutVGVKVFXg7lMrCd3pGGvEt9IN9XAoBRKM0In8GiltrVmrkQe0tR/rAmlO
         JaZDoHxiMxoKzRIZ9L/wix/PBtaSrkZzDdsu70Mvueoo3HfN8hS5I+qUvP4pUES3cn/e
         0zQ7uHpuG5SxDZSXnCkUuksx/ToApmpxjOZLcXsmFhcZAGMQpB5x6PEGFP7OgOTnef1J
         K7Cg==
X-Gm-Message-State: APjAAAX4KwF01PZc7Ja5jHx6RpwXl4y17kQYM64D7O+mpU/A+5Whtedb
        Jc7/9acHTWMTWaYyyp8Knm9A0A==
X-Google-Smtp-Source: APXvYqxq0ay2DLP144wUqH2TJqeYs+CM1CzDDTCAEHT8qLG70HSD8wcaxvvKBHRgPHlzCMTknReLGQ==
X-Received: by 2002:ac8:219d:: with SMTP id 29mr4121236qty.280.1572353492189;
        Tue, 29 Oct 2019 05:51:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id w69sm4027395qkb.26.2019.10.29.05.51.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 05:51:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPQyB-000522-4r; Tue, 29 Oct 2019 09:51:31 -0300
Date:   Tue, 29 Oct 2019 09:51:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 06/15] RDMA/hfi1: Use mmu_range_notifier_inset for
 user_exp_rcv
Message-ID: <20191029125131.GC6128@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-7-jgg@ziepe.ca>
 <a8644875-9133-9667-c04b-b40c296d68eb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8644875-9133-9667-c04b-b40c296d68eb@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 08:19:20AM -0400, Dennis Dalessandro wrote:
> On 10/28/2019 4:10 PM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > This converts one of the two users of mmu_notifiers to use the new API.
> > The conversion is fairly straightforward, however the existing use of
> > notifiers here seems to be racey.
> > 
> > Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> > Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> 
> I tested v1, and replied to it [1]. I can re-test with this version if you
> like as well.
> 
> [1] https://marc.info/?l=linux-rdma&m=157235130606412&w=2

I think it is fine, nothing really changed in v2, thanks

Jason
