Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B78217E77
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 18:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfEHQuY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 12:50:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41687 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfEHQuY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 May 2019 12:50:24 -0400
Received: by mail-qt1-f193.google.com with SMTP id c13so23994722qtn.8
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2019 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0eXYxRY71S0/CCu2EUfDJpPElyn6Lr0REpE6ed0UF1g=;
        b=BdPICgvp3dFpUUhvgLHiEgmbNGaGM4wRbvtUbQGKN4joBY3mqLU5FC8wuEnHCKnlUK
         2/UyIsXstZv8muHJzgOL19rTkdE3sdjgRDfadIsdttwNjx1uvi2VpuuBqDY76PIHOEc0
         Zub2if6HGZRHgC4MxX0Nl6zyCSp4TbAxeA3Av4Xb+bAzJU6yRngbmKl32/d8tgVyADSz
         ClfxuS0VEILVMzSHqh3a5X/UAwwj9F5vcAJn6Eh1iZ7Nw/4FBW+2hlN6mLDV7CRseTY3
         yaEwF4BZNuZVvc04pN68gEUm9VEddIQE3bqyiEm0Zj5WaqkD/8BBxgX+z4tvQik4b7iX
         n5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0eXYxRY71S0/CCu2EUfDJpPElyn6Lr0REpE6ed0UF1g=;
        b=Y2vNgJhIURH+ZdUgiUFsDt7nZN5i418EEUrO8lNXxlNIrYXGit0vVq2lRTKWbNBm92
         mrOd2ix1VxylFozrE346G4jfUZd2S4dgBJCzTUGgZgTph2UHKCFhRO+mxAzGNNeIbUB7
         h2V48pZxa5IoBqElcffopfLsugq1/hKqVgjzM2Dem94/rxnZjVaT3snOrE+5qsn0/hrn
         Q9U860a1cmu58fLlJxFklHwJ/j2sbuJvOpU8pL5tHDKyaUUhH5ufhd2YoWxJFuA0Fz7p
         +nUY0wPJdPsvo8Qnli1A14GDogLojr8ESHzCAta/viDJFjJHbMFW/pNs84UTXT6M6r7a
         /pIw==
X-Gm-Message-State: APjAAAVhFA9aVt9U9/f/1No3WDW/JurDl4J4kOFUWygmM3g4SGlixNVF
        c6uc0yG9kRXNuxfTBrlGwUrmdQ==
X-Google-Smtp-Source: APXvYqwJk/jA+ZVtmuRDWYOU9tFPzb8ZEqS0v76iPT9InbZe5gZi3O7s1IKOz0oglKwj+zqQ6KObuw==
X-Received: by 2002:ac8:875:: with SMTP id x50mr14010978qth.345.1557334223765;
        Wed, 08 May 2019 09:50:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id y189sm9217755qke.34.2019.05.08.09.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 09:50:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hOPlt-0003cb-Gv; Wed, 08 May 2019 13:50:21 -0300
Date:   Wed, 8 May 2019 13:50:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: iWARP and soft-iWARP interop testing
Message-ID: <20190508165021.GE32282@ziepe.ca>
References: <20190508142530.GE6938@mtr-leonro.mtl.com>
 <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
 <20190507161304.GH6201@ziepe.ca>
 <20190508062600.GV6938@mtr-leonro.mtl.com>
 <20190508133028.GB32282@ziepe.ca>
 <20190508140644.GB6938@mtr-leonro.mtl.com>
 <20190508141841.GD32282@ziepe.ca>
 <OF5AD65D44.561F332B-ON002583F4.0050EC64-002583F4.0053DCBB@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF5AD65D44.561F332B-ON002583F4.0050EC64-002583F4.0053DCBB@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 08, 2019 at 03:15:59PM +0000, Bernard Metzler wrote:

> Without questioning the concept here, moving allocation and freeing
> of core resources to the mid layer may induce complex changes at
> driver level. Especially for a SW driver, which references those
> objects on the fast path.

It usually doesn't make sense to keep referencing a deleted QP in the
'fast path'.

Again the usual approach is to build some kind of fence in the destory
function that guarantees the fast path is done referencing the QP and
then let destroy complete.

Otherwise there are almost certainly going to be bugs with referencing
a destroyed but not freed QP all over the place.

Jason
