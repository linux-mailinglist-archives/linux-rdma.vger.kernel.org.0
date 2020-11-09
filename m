Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBCF2AC2F3
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Nov 2020 18:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgKIR5C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Nov 2020 12:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgKIR5C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Nov 2020 12:57:02 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E5BC0613CF
        for <linux-rdma@vger.kernel.org>; Mon,  9 Nov 2020 09:57:02 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 11so8756656qkd.5
        for <linux-rdma@vger.kernel.org>; Mon, 09 Nov 2020 09:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OoDuC22MATOviqvP9rD9+DDkxlkCgPeGOHtvGe7F5zg=;
        b=eoQmlqfdxRkFxU3TwFhi5wK5am6bkk63VJnZY4zR7ZqRza1z3E3SaelmxgU4svCNUN
         rMMVIQ9IFCk1rJrcqDBNgmXfFuXrZvmsC4BZMwnm21Y4+pvTI4A3Qr8fczIyCWGDlzpC
         HeYNmke3IPgRHYek+g5Yy31XSVtCAa8A7hCm3GeRXhRR4oNk7qkqAXaHThCnoQroi7nW
         febBr/YVRtW40+lJQf6IlgY4YPyhduxd2SEsM3Ta44xmOwutdZ/kNlJRHb2CctNo8WwT
         wFPoMyJ1+akfuD4g02HMo6+uvVTzFZc7q8fqKwbJjxecbGJCo8Weit3wNDdRuzFiqWlK
         YmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OoDuC22MATOviqvP9rD9+DDkxlkCgPeGOHtvGe7F5zg=;
        b=kZhvisjTOjhymwvtVLHywOirE+v9VgKmwKovOA0cvsmeX/ekIw9oqpfqGpdkb/uj2m
         m8mBMEWRAy6r4ziS0izwzzwV6lONPd4/qsW6V5FAmw7hoCq/xyD2JlDf8rd+gxs+SeM9
         72ervBRsRM3nfRq+JodZapXhL8lIhT9iY+xFggYQYwQ/NTbQxD4inZHvK0+Ad25p1bLI
         b97tIKv318ajbf9vsBB9ic4+EASdcqHKexkjjxxzYJLzezGVmsDIo8JSCJ6iXvNGhyeK
         rzCpx0hOIq9iaPfKsUxlGiEJwe+6VWuwC0aZ4x+3s8TtGVxOJrE5+0H9a7zTsTz15j6k
         Cg7w==
X-Gm-Message-State: AOAM5339TDuyClTnNbJT14wI1LGSgZM1hMU+gJdCenrS/5mdOTStt+Wu
        A2JAge1uM9qkNMuynJIvvlhzbg==
X-Google-Smtp-Source: ABdhPJwEqU9a05p7ZAhqmfDib+7uu1yDq4jdPo9hvqHYdyCvBNkJ16fAdqWR3+WkaY+5L3t0MDfrWg==
X-Received: by 2002:a05:620a:6d4:: with SMTP id 20mr8923140qky.4.1604944621688;
        Mon, 09 Nov 2020 09:57:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v15sm1955250qto.74.2020.11.09.09.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 09:57:00 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kcBPY-0022PY-1x; Mon, 09 Nov 2020 13:57:00 -0400
Date:   Mon, 9 Nov 2020 13:57:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/nldev: Add parent bdf to device
 information dump
Message-ID: <20201109175700.GF244516@ziepe.ca>
References: <20201103132627.67642-1-galpress@amazon.com>
 <20201103134522.GL36674@ziepe.ca>
 <20201103135719.GK5429@unreal>
 <0825e1bf-f913-d2c1-ad3f-35ba3d6b75ef@amazon.com>
 <20201103142243.GM36674@ziepe.ca>
 <5e2208ab-9e87-56ae-bc38-5827637eb5be@amazon.com>
 <20201105200005.GJ36674@ziepe.ca>
 <cd3f2926-0491-8540-d6b1-534014190bae@amazon.com>
 <20201108234935.GC244516@ziepe.ca>
 <7a9866b6-fa33-0b95-4bda-4c83112be369@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a9866b6-fa33-0b95-4bda-4c83112be369@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 09, 2020 at 11:03:47AM +0200, Gal Pressman wrote:

> > The thing is, is is still useless. You have to consult sysfs to
> > understand what bus it is scoped on to do anything further with
> > it. Can't just assume it is PCI.
> 
> This can be solved with Parav's suggestion.

Now you are adding more stuff.

What is wrong with reading sysfs? sysfs is where topology information
lives, why do we need to denormalize things?

Jason
