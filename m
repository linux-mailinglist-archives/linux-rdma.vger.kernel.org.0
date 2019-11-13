Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7FAF9F5B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 01:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKMAhQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 19:37:16 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35740 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfKMAhQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 19:37:16 -0500
Received: by mail-qv1-f65.google.com with SMTP id y18so123723qve.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2019 16:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jWZd9pwpH+9x5HYAVCTRl5+EYNROfoTEt5ODE0BkliY=;
        b=WskKgFfkAQ5rXavoIDwVHCMJJIzIF2oUOUhCtpcKXClT1dCH7zmE1I4MbT0xvfiUYO
         yGGe3Xml6OZcRfvORZir+maxQV+mbi+B5olSqNWSrQQ5VniX9ndidYaXwH/Fk6eADP5I
         QbhSFnbl4MRk6wb7cBvsP4o8Loi2itv4sxW4o9M9qlIs2gdbPy5TXFaRd5OOddw5QU+K
         WoqBIE9govkYABfI67nEU9uO5fjmBMz14MZHAyBQF4pbAPuuS04NgQV9VShW+kEkIJrG
         U+leDe3WjE69ZPR1xbbReFsIIx40Bd8Fwmn+1fmY+EsrwTwdVfdOay3OmuhpPvOWG5Eu
         oJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jWZd9pwpH+9x5HYAVCTRl5+EYNROfoTEt5ODE0BkliY=;
        b=Jhd0k9lX1CXM4i0E+4jyRdJk1Divwn1SBKT3EglaAT2ub3DbmStchgpVH7dDapquyi
         t2LpzZO6AAbkR92btwTqI5v7V8mFCGyDU/x6bYbkHLrDFTv0bSXyYMS3OLtA51DX/nBT
         Gtjb6gEXk7rBnBPRKi3k93H67SJ0scb7PEd383epQHze5dgizYN5FViqFOBmgPMa3UZA
         vx0ok39/IW0qflx3qOLk/nJ7h8+PpRSK67/SXKJss980v51e98MARLRM0anb3KF1WuBz
         Js1SXBQKUBq2JlruRxxOfnyWSiVeCN7SgLL8D/tFZzvCQ5zy/zyuiT2eu05eRWlokrIp
         VM6g==
X-Gm-Message-State: APjAAAUZIPmrhv3oe/rUt0eWYqlaxOZ2QYdTnurVvvAriB89a8FAMx+k
        HC8UPityXM8z7L3bTQbz/XCaOX8uoZE=
X-Google-Smtp-Source: APXvYqxyg1g4xw0H8jO54mgTK9gYIj1CSkyD5a4lJzhkaOrp/zayCmAUurxZVW4kuFj6K50YuOYF7Q==
X-Received: by 2002:a0c:f4d2:: with SMTP id o18mr470896qvm.100.1573605434893;
        Tue, 12 Nov 2019 16:37:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id w18sm187461qkb.41.2019.11.12.16.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 16:37:14 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUgen-0003F0-N4; Tue, 12 Nov 2019 20:37:13 -0400
Date:   Tue, 12 Nov 2019 20:37:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: Re: [PATCH rdma-next 00/16] MAD cleanup
Message-ID: <20191113003713.GA12415@ziepe.ca>
References: <20191029062745.7932-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029062745.7932-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 08:27:29AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Let's clean MAD code a little bit.
> 
> It is based on
> https://lore.kernel.org/linux-rdma/20191027070621.11711-1-leon@kernel.org
> 
>   RDMA/hfi1: Delete unreachable code
>   RDMA: Change MAD processing function to remove extra casting and
>     parameter

Applied to for-next, thanks

Jason
