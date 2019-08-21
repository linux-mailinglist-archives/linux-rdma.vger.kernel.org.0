Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0C7E984BE
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 21:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbfHUTsN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 15:48:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39412 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbfHUTsM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 15:48:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so4558822qtu.6
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2019 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RKaQWnWiA/zCcExfi75lqB9ALEnDHuRristulqneTd4=;
        b=VF//ZkIgb0ccMf/fYMR8ys1oZHmy5JRKO8S8IVnwY93iOCu/W7+tqrcWFw+5rldxNI
         aOtLu3PsXm0Him3edXbZNXCIhRk5dw4XYfKu4e3yv8iN/mxXDcev7A64Goh60uRoeToj
         KsbYARzI5dfW3WUW2nHR+o8WkktwHJGaehfIiJX8Npx8V5kKAL0zIUWne13iFi3yzfE0
         Mr3GgB9fCwjOgBICH92Ndb17k2AjhI3vfLJVcZ59QAI/xkGuigPoWEVo0xwQOrmHgZvG
         +llknKnaKUAXOzinx5ExtHyGDbPgE5bGB/pnb1FjLysYXUDhwnplOXXe90luAkrxNaEF
         /MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RKaQWnWiA/zCcExfi75lqB9ALEnDHuRristulqneTd4=;
        b=rI8IUlsLQupe3TmtMK70xAlL6AezFF18BC/C0EPViWMwqe62XKc3EF+FtnQZAwdFeA
         mW0E2vS9cKeFx9AhDOl6urIJH2WB1DzUQyxzoo1kndmMW7MvvEtDgjMbsWbNzdYwQTu0
         rRj/Qd0SB7WzhY8D1dHYowgN5v14Q07JzhygfXl7MhQtIcbmBatIy1mDkV2ZxktCTUNJ
         avay6oQ1mTG0anRcVik3EBg/l1Y5/ThHlFUOGmXcp5yRPbvkz7GnWq/cLAqPmjl2BFyv
         Hjh9i8PzURE7mw/Ta6G49dW44HSlGHskXalr4h4K1Y+fzm0NJrfaXSp+2/wEGgy3DVZQ
         f35w==
X-Gm-Message-State: APjAAAVDbJ5GSYGkEpttxdJvauYIPuFyKI+hpwTNjXbtuMYZr4+PK/Iu
        k5Rgnyvbm+7HB0h25shLi5iE9A==
X-Google-Smtp-Source: APXvYqynnJZ0Zi7g4jGmr+xM0aj4NgAU3mYFQCm90qX+6uBLqZGFaKsA8ELnMbT3xzkDRjmj+/uCGg==
X-Received: by 2002:ac8:468f:: with SMTP id g15mr33328922qto.353.1566416891773;
        Wed, 21 Aug 2019 12:48:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q62sm11253497qkb.69.2019.08.21.12.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 12:48:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0WaY-0005kK-I1; Wed, 21 Aug 2019 16:48:10 -0300
Date:   Wed, 21 Aug 2019 16:48:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
Message-ID: <20190821194810.GI8653@ziepe.ca>
References: <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 11:57:03AM -0700, Ira Weiny wrote:

> > Oh, I didn't think we were talking about that. Hanging the close of
> > the datafile fd contingent on some other FD's closure is a recipe for
> > deadlock..
> 
> The discussion between Jan and Dave was concerning what happens when a user
> calls
> 
> fd = open()
> fnctl(...getlease...)
> addr = mmap(fd...)
> ib_reg_mr() <pin>
> munmap(addr...)
> close(fd)

I don't see how blocking close(fd) could work. Write it like this:

 fd = open()
 uverbs = open(/dev/uverbs)
 fnctl(...getlease...)
 addr = mmap(fd...)
 ib_reg_mr() <pin>
 munmap(addr...)
  <sigkill>

The order FD's are closed during sigkill is not deterministic, so when
all the fputs happen during a kill'd exit we could end up blocking in
close(fd) as close(uverbs) will come after in the close
list. close(uverbs) is the thing that does the dereg_mr and releases
the pin.

We don't need complexity with dup to create problems.

Jason
