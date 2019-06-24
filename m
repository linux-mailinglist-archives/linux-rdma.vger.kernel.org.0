Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF38F51A56
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbfFXSQh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 14:16:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41991 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730028AbfFXSQh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 14:16:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so14904572wrl.9
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sJIsqOQ5eFDre2y4pDDL9/K7QpUmlmCNTD0di87N8/o=;
        b=glv0HRf2INHgoAzbU/KeaJR4l18uUuvmI/14yZG/YlQGVkZoefkf69d99mboSmSYJ3
         kUBmB3L6FHXultbhK/4JvJG5Fc1At0jKRBNni1ZrG65adIRqsOjNaABP4HA2RPqrrhc2
         vVNNd4SHFHbQJJTBSNvHIU34Cvn9PJoo9LNVbgrEEBfVdZnp3c4Bbh4CD5UlBYjP6Uwd
         WUft3HnKCm7fEh4o3QlUJrZ3p/cvjIZORsN9pnvYWJSlOVaEBZV4QIwwqrE9sSpFbWwq
         AgrKHsm2As5TJOfi2TNk7z/7mjjHrOpgpz4TRa/jfa+zOe2of3u4wRDAyHxYLZHZgkd6
         aeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sJIsqOQ5eFDre2y4pDDL9/K7QpUmlmCNTD0di87N8/o=;
        b=l+nFTz7v6JwJ9OJie85VYNSDbeGLKkUfGzJtuMY0EkmYuWuW7RBqHQdft0JE1WgMwK
         eLf39D7Es+bSrrjTw+USHxL/C34hG6gQB2HnJZdsykfH/SIkmTSvIA4jre0utw1rKl6Q
         VjKunnFmB9Idi3q2BwEtQxz9bh5ZWBEFbDIf7FVT/UMsUI5WOVmK3TUQ+Z9U/frv4jMx
         Q0DSzIx/uzMa8DKxXHf9sev+q9RKK0bQ+elvYugcsD2HC52XtDAyb+67HScfe/kcFaUt
         DtabfaKyS+aon81Tl9jN5lbqIs/B2s7WKqkxWkzWeHGAvg1HLdUMurrCY4pu9hY1jzDG
         hH9g==
X-Gm-Message-State: APjAAAXgnaGB+2xg4CBmhqsowksqyL346eJATeiEpfOg2zsmZImvPUUp
        NQ54lugUCB2G0BiwPPLizgz92A==
X-Google-Smtp-Source: APXvYqzN+tsY00ZZUnDzGCCozz2kltRbszB8xG0KA0aMF1Z60uBAcs4mW0rG08os3rQlgEHkHPz+Hg==
X-Received: by 2002:adf:ea45:: with SMTP id j5mr17926712wrn.281.1561400195211;
        Mon, 24 Jun 2019 11:16:35 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id j7sm16315095wru.54.2019.06.24.11.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 11:16:34 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfTW4-0006E8-3Z; Mon, 24 Jun 2019 15:16:32 -0300
Date:   Mon, 24 Jun 2019 15:16:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190624181632.GC8268@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
 <20190620193353.GF19891@ziepe.ca>
 <20190624073126.GB3954@lst.de>
 <20190624134641.GA8268@ziepe.ca>
 <20190624135024.GA11248@lst.de>
 <20190624135550.GB8268@ziepe.ca>
 <7210ba39-c923-79ca-57bb-7cf9afe21d54@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7210ba39-c923-79ca-57bb-7cf9afe21d54@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 24, 2019 at 10:53:38AM -0600, Logan Gunthorpe wrote:
> > It is only a very narrow case where you can take shortcuts with
> > dma_addr_t, and I don't think shortcuts like are are appropriate for
> > the mainline kernel..
> 
> I don't think it's that narrow and it opens up a lot of avenues for
> system design that people are wanting to go. If your high speed data
> path can avoid the root complex and CPU, you can design a system which a
> much smaller CPU and fewer lanes directed at the CPU.

I mean the shortcut that something generates dma_addr_t for Device A
and then passes it to Device B - that is too hacky for mainline.

Sounded like this series does generate the dma_addr for the correct
device..

Jason
