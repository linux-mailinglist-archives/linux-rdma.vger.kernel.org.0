Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2A657322
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2019 22:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFZUzB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jun 2019 16:55:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44954 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFZUzA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jun 2019 16:55:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id t7so2071698plr.11
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jun 2019 13:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bMxdvEdLjD1A9AKJa7buamnua6ndE13zHk8/3SA0xpk=;
        b=TBi220P0cqoilOs0VNo/aK3h3vIh4DHqMWYM3/xsM7rxg8vRC9vB3FeKKle7xEF+Ub
         c/A2Ia6QYlSw7cwbMBQyfBdYv54uyZ6xKUQ+QkDRfgWgo5RypRkGjFaWm2ykPW6JTo8F
         AnNSsV+rqWfslkCLRdq/e71/2TQZYL1quvSzRdMEfoUwlhYKvfJFQIhaWQUK4ia+k7eR
         cgPQ5KRJ0Rg5DrgjBR3TmHFiMZKA7Ljeag/N58i2HxUNVWt0ybAgynqXMm44Jvtl115E
         cwHup5Tv7BqDlSNc2j2kshgnuFrTydujMQM6+FISacSwwNM9jBiIB0QzVlt2S/qrgn6h
         p0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bMxdvEdLjD1A9AKJa7buamnua6ndE13zHk8/3SA0xpk=;
        b=ZwUZLr4eg/Z8angorrwfSwCtvcXIsZ7yFq77dzGh1JB1xiFSf01jQrFR0PLk1dThHK
         uGutpgu8aMSI7UM46QDNE5TwbIpTU/wPs0ohU5+eXeT8dOHWTotIPKXKJUq9J/K6OnXS
         eJKNHyXAw5sawPrEUStLuJfj0nf7zj4vxNK6wXNMv8Q8m2ivdBx+cph60a54wtElcfaU
         nikia/tM6Pv3Bnh20c2TKOfYTbAyVaxWPrg6cn+XhDZeZRvMGLpRUyJZIMWSIYvvyjZh
         8SX9645g5ILV+JUINlKgDnaqf07tcAUvcuihhR7CK8bRVwYo/6pEBRpnDI0bOpfv91V+
         +JCQ==
X-Gm-Message-State: APjAAAXU8BopiOAPvVzbVXega7amQYy4nCIgog6dZQfB/8Jov9G/05XN
        bSIEwrJ7HBEwca9t1b2qJWbWkw==
X-Google-Smtp-Source: APXvYqzgDH5/ikCzES5M0MRO5K7K3ifgbGjP1mRuUaIUZdDHCGw68bO7qf91SGAx47qMnghFOmD8Fw==
X-Received: by 2002:a17:902:9a87:: with SMTP id w7mr65029plp.221.1561582500008;
        Wed, 26 Jun 2019 13:55:00 -0700 (PDT)
Received: from ziepe.ca ([148.87.23.38])
        by smtp.gmail.com with ESMTPSA id t13sm3856107pjo.13.2019.06.26.13.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:54:59 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hgEwU-0001lK-9d; Wed, 26 Jun 2019 17:54:58 -0300
Date:   Wed, 26 Jun 2019 17:54:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190626205458.GA6392@ziepe.ca>
References: <20190624072752.GA3954@lst.de>
 <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com>
 <20190625072008.GB30350@lst.de>
 <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com>
 <20190625170115.GA9746@lst.de>
 <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
 <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
 <20190626202107.GA5850@ziepe.ca>
 <CAPcyv4hCNoMeFyOE588=kuNUXaPS-rzaXnF2cN2TFejso1SGRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hCNoMeFyOE588=kuNUXaPS-rzaXnF2cN2TFejso1SGRw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 26, 2019 at 01:39:01PM -0700, Dan Williams wrote:
> Hmm, that sounds like dev_pagemap without the pages.

Yes, and other page related overhead. Maybe both ideas can exist in
the pagemap code?

All that is needed here is to map a bar phys_addr_t to some 'bar info'
that helps the mapping.

Jason
