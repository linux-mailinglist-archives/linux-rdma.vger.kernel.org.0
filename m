Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8473B5C6
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 15:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389508AbfFJNJR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 09:09:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43611 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfFJNJR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jun 2019 09:09:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id z24so3833515qtj.10
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2019 06:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4F5p4XvqxWD0TPhx038sRdW6UkfS+pQjYQgLxUjnBMI=;
        b=BhIIjcgOeQFdpsXOGxWnmGvjoyeGrIjjevpQNRl/I2/FM8ihdN5hXQobSh95XYjgPy
         BcVai4r/g1HxBTsXAlAV0qer0KY857kzqTHnHg2h6eEGGmmeCl7I6rNfu1lMP1j2s+65
         HMCq4j4xGVfZGz9FHAfQJXTacr+yVjc2YESaxykFfinvyANrOti3zkztW1T11pGgbt+m
         ogx8XVpNVzdJsodX6ozViM6hnDCL71wrSt/am17+Hfd0sGLK4ljxB0UQChBHCVSbWxea
         5/soEI9XcHDofveKfkWMk8uTfUv0yVeOC28YGBJDNyrnMAdm6q1bApQkogtXbzNnCf+V
         garw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4F5p4XvqxWD0TPhx038sRdW6UkfS+pQjYQgLxUjnBMI=;
        b=oSCDuU9+1xU177pYAc2y6E51dkMXqti0yHlqILu4xz5KCNtyWB0lsawrKf6Ruy41Hi
         /rV/oA5NHn6SC+Fbmw/EJkzVtHlR81wz875DXlhvOOf9tHFE45ZG2f7dxhLNWcPb6BQI
         lYhhCAGT2JwFzRSSlGE01cnvNm4P3RP/Ayw73YdDdYFy7m8ue0GWntfMSbTdUgkN3fWW
         FI7QHA3hmeuSTThretVz8nmqvj9eIF7xJsjt8hcXJpzJ/G0r1v/xYOliKTbnza12E9mn
         /uRhRwtFTsOixPB1ARS7ubYm4kkIWcgkgnKBFo2wcKg2/ELuUd8usPT3KYj/sGy99izc
         R9pQ==
X-Gm-Message-State: APjAAAUlc8NUB6utbODD0DyCGnsVrzyo/Lj+O1KVrnsGxScRZgPdpTl2
        6T9WdDM6WWrjUFafdSsTo8C+Tg==
X-Google-Smtp-Source: APXvYqyfdzwD7zPoXm7GvJhg1KqfurFKZJX3W/vApYwm27bMvAhRfi5kk7rnbLbo+akkzc5tVyXK/g==
X-Received: by 2002:ac8:1af4:: with SMTP id h49mr51085239qtk.183.1560172156644;
        Mon, 10 Jun 2019 06:09:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v30sm1245889qtk.45.2019.06.10.06.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 06:09:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1haK31-0006cK-Gt; Mon, 10 Jun 2019 10:09:15 -0300
Date:   Mon, 10 Jun 2019 10:09:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 02/11] mm/hmm: Use hmm_mirror not mm as an
 argument for hmm_range_register
Message-ID: <20190610130915.GA18468@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-3-jgg@ziepe.ca>
 <4a391bd4-287c-5f13-3bca-c6a46ff8d08c@nvidia.com>
 <e460ddf5-9ed3-7f3b-98ce-526c12fdb8b1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e460ddf5-9ed3-7f3b-98ce-526c12fdb8b1@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 03:39:06PM -0700, Ralph Campbell wrote:
> > > +    range->hmm = hmm;
> > > +    kref_get(&hmm->kref);
> > >       /* Initialize range to track CPU page table updates. */
> > >       mutex_lock(&hmm->lock);
> > > 
> 
> I forgot to add that I think you can delete the duplicate
>     "range->hmm = hmm;"
> here between the mutex_lock/unlock.

Done, thanks

Jason
