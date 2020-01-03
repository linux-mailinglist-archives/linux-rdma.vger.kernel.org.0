Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF53912FD0A
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 20:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgACT3l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 14:29:41 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46408 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgACT3l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 14:29:41 -0500
Received: by mail-qt1-f194.google.com with SMTP id g1so30692619qtr.13
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 11:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iIulf9j/Io21cncxP49Bpjr22RwoRzTnI961S7bK8pg=;
        b=D0Up1ZLwZFeywFAEVBoncvlKIblgXEfxgYKylPCc/n1aFgLnUEZ/64maPw3PhvC10E
         ZR0Iwpj/NrJVZPyYU5bUc/Y938zazHXRTvjV4gJG8eFGqVG5zG3pJETUsesmNabMudrq
         OM6XXv1Tz+uq9sNJAsnwDgC7NxdyYNLGv6tuzfq1iaiO9YIPl3+xeSgflVX94QpbLqLa
         nt5n0uElj5SUUdtRGDiQi32ZIhU5tdlkaTey1KXri6ab6OZSsnRqtwmtS3zQ3Q+VO/Ti
         HaV8HFzTytatgq20k1WiNlYl/U1dhDnd2tHuqa8zVhTzojzqQ9asJcnN9CIGM5QCTjw3
         3XXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iIulf9j/Io21cncxP49Bpjr22RwoRzTnI961S7bK8pg=;
        b=mNFLa6jtO6H3v8wQ/1f5JUlu4BCZ5EJDbYrKJ+lgIYWKJCyMdqa04cPQ/gbIIPd6My
         0f2lGwZyhBTPZRqhkzcyxS739IHi3EEWHR2RcCe+UFtlgueZcr8rWO43/VrXsopJ3kwu
         UyP0Ydz7yCK/KfWimS2yqj+UQsshdx9s83aR8xmRTv54FVOA6HXDtRU88ccJnEvuY+il
         5vOJ40rJ7L0jG3Nd/gR6nTV0A+7Jx4TQRbFJa/P153utz3MciPpIOv5j9S1fYueEVJCJ
         3/XKJVQMUxfXCvzvEKE//DQgK7lL3VPUctCjZ3TgRlOxQrTuQGWyuX2Tis63EkEeEvGI
         jSiQ==
X-Gm-Message-State: APjAAAVUqsWGhzxl6K3yVnBBhWsHHyqk+d89sedCtUEBrOUk4h+TD7TL
        2bmXtiHcrSlfinPDdtczW4TtEw==
X-Google-Smtp-Source: APXvYqxv0LR4BLdUzRe7cb2UwoiHJDfoDAfI5cCBtmJcLsv58A6u8MBxxQ68GOJXH5HlxyfSqXNggA==
X-Received: by 2002:ac8:3751:: with SMTP id p17mr66678897qtb.9.1578079780672;
        Fri, 03 Jan 2020 11:29:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id r28sm19331277qtr.3.2020.01.03.11.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 11:29:40 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inSdf-00049B-Rr; Fri, 03 Jan 2020 15:29:39 -0400
Date:   Fri, 3 Jan 2020 15:29:39 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/6] RDMA/bnxt_re driver update
Message-ID: <20200103192939.GA15875@ziepe.ca>
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 25, 2019 at 12:39:28AM -0800, Selvin Xavier wrote:
> This series includes couple of bug fixes and
> code refactoring in the device init/deinit path.
> Also, modifies the code to use the new driver unregistration APIs.
> 
> Please apply to for-next.
> 
> Thanks,
> Selvin Xavier
> 
> Selvin Xavier (6):
>   RDMA/bnxt_re: Avoid freeing MR resources if dereg fails
>   RDMA/bnxt_re: Fix Send Work Entry state check while polling
>     completions

These two have been applied to -rc, thanks

Jason
