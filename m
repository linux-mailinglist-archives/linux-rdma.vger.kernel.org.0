Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABF41538ED
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 20:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBETUj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Feb 2020 14:20:39 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45924 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBETUj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Feb 2020 14:20:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id d9so2443834qte.12
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2020 11:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NMY29axAEM/sabbCIm24CqEX3IodZPKbBkp83xR6cs4=;
        b=UjKX2+DgqvZQwgbPkzaUpGPpXz2UidscEMwRxKYrYSjQw0Rmm7mPSPARtc0x4GF/rn
         z+Uz/CVmb1JdNk/ILGfwdI6f1yNBLuZ6iGPfldpSeXGdgYDzfpI09kY00HUu3i/NKjpa
         4fiW3u5RXEI+yCwAWDsiTsCPvMDqcSEKlTRPP9jH0ElOB9fr+l7qY1uuPdWVHQjIIxW+
         Sdn46z3m/U9YXNinMqsE8oHHCRx4ahutAEcOe5ePGVQKv8v9mDNb8FiJLOZQreG4hNyB
         EUgPnY/E8E200brEjmm8lhIUTl1t4L30Pq9gLyIWx7JNAs9cSWp0SqgvNSNI+vKdDIvH
         0e1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NMY29axAEM/sabbCIm24CqEX3IodZPKbBkp83xR6cs4=;
        b=Jebg3SDZBWDIuWn7fScXNoh6nPJ+gmKQk1Z/+LWAPwg5EqmQWMIc3+bXgdWTraWCcx
         kjCxshogl/xjBN0rji2emusNQnZ1dGm8hcTSN9pIjhDb0mgo30lSsimSg26MxFllegqc
         O8Kqt4f9KKv3nZztY3OHv4P33y+qvJvs0HjA1VSqmksJx5Bh/TcyuGfFukfO9qmhL/Nc
         2Drv3K7LjIEz7aRjn85GOwzLTfjnLFK8EUX18MO4H7up+fcvg3G71CbQKhsYtWyzaxv5
         QXkiRX8R+UlaxrCyoozA863sYpoLFIVlIS0BGFrX4KGMRqvkmyNNqxrypaC4N0yRBRpC
         G5AA==
X-Gm-Message-State: APjAAAXmGv8w7KZdfTbf1PIr4WzXX1VU7SqITzMKpHM43W8RbLyCwI00
        C8efdOvEYjJcIFbQBzbxPqqGipbhQ68=
X-Google-Smtp-Source: APXvYqy1rImiU0Mai5ruXfZmu8AnxbvoEACrCb0LmfF14fb56D+yyGHOuy6kBa4ELfEN36SJx2QN7Q==
X-Received: by 2002:ac8:3482:: with SMTP id w2mr34554693qtb.192.1580930438170;
        Wed, 05 Feb 2020 11:20:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l13sm424350qtf.18.2020.02.05.11.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 11:20:37 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1izQE1-0004kU-7T; Wed, 05 Feb 2020 15:20:37 -0400
Date:   Wed, 5 Feb 2020 15:20:37 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Frank Huang <tigerinxm@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: why use _ucma_find_context in ucma_destroy_id?
Message-ID: <20200205192037.GG28298@ziepe.ca>
References: <CAKC_zSv3TRgrqg_EX+ZqxQ5FecWk_pEFmDr2C3W=xLhijUOXWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKC_zSv3TRgrqg_EX+ZqxQ5FecWk_pEFmDr2C3W=xLhijUOXWQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 05, 2020 at 06:41:39PM +0800, Frank Huang wrote:
> hi, all
> 
> I found that in ucma_destroy_id when using struct ucma_context not use in pair.
> 
> 1,
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/tree/drivers/infiniband/core/ucma.c#n611
> 
> in line 611 ,use _ucma_find_context, do not call ucma_get_ctx
> 
> 2,
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/tree/drivers/infiniband/core/ucma.c#n629
> 
> in line 629, use ucma_put_ctx
> 
> will this cause an unexpect wait?

It deserves a comment, but the ucma_put_ctx() in ucma_destroy_id pairs
with the atomic_set(1) in ucma_alloc_ctx()

Jason
