Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8D12F8DB
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 14:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgACNjJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 08:39:09 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44144 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgACNjJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 08:39:09 -0500
Received: by mail-qk1-f196.google.com with SMTP id w127so33724788qkb.11
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 05:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D4QmgTv89I70sY5TqGum0pBx8vfzpXiNe3R3/6II6cE=;
        b=CwP8Fafyb4BpplualUd7VkMaxQOh/cajcr/8NLCOpU2YEOfm3NQq6jtf+yZ4Iqduqw
         nvdUG/ZCydr0LYh68vU/Dymzysxpa8jK/3VpVTck2BjrdtJSm+L0Tf28xY4UPakMkpr8
         pwfiM4THfxW91vCSZODXQFFmU2aLTD7GCRPPfTrLFUPrRGMwFRCcOxntdaSu68KQ1omu
         a4pThXhZytm/JtJxoktpaRwMXkNQ2VT8knCwYD8YNCpPvT8hAUTBLcgC4lF+I1wC6AFz
         bMWrde3w6/TUUrNh2g/AO9DQ/jVnwulUo0CmOA7DyZUTqQK0Y39Qag43WViyIn/4p7td
         UY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D4QmgTv89I70sY5TqGum0pBx8vfzpXiNe3R3/6II6cE=;
        b=H+WLVLr5L/Q7AG9+rYnqHg1BFO7M1EK2pj3P0h/qhg39zcS3TgfTUeioLjujlxEMd7
         PffYGR2pcU9prgvsH8ZAxcIo/xqXKaZUKsYqRJhpk4bu01AQrV2Od86wV1rnK0nwGUxP
         7JgKrLfu68YCTPZWcMdtF6HN/OaU4+X+9/LQEtUxStu0xO0j/WjfRrjTi1ULEdcwc5G8
         8yNtuddX0YUuJeue7+AdKChbDj1Y1v8kUMwIXATS8Sxl19Jxe0oIj1uI+vW1nl58WNiH
         HqsAX9AuVVqKu4b3oxF/gdEcduM2Ti+nORCgASjmJLNRp/lwFg4Pdt4yo3vbbZEMk4uL
         jEMQ==
X-Gm-Message-State: APjAAAXAU06jaY37Ia/ff+G7EFK9t68MH2Tm4zVZyRcgnY432LU0hZ5M
        GULZMwD69kVbv/Tfs6y3PUObAw==
X-Google-Smtp-Source: APXvYqx90LPY2J3JUHWIHKhrbhQVHhDBLWvjxioSqrmCpvow6tKc5kZe1h/JE60wSza4990wpmGkVQ==
X-Received: by 2002:ae9:e306:: with SMTP id v6mr70349736qkf.162.1578058748910;
        Fri, 03 Jan 2020 05:39:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k50sm18559023qtc.90.2020.01.03.05.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 05:39:08 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inNAR-0003Vo-Pc; Fri, 03 Jan 2020 09:39:07 -0400
Date:   Fri, 3 Jan 2020 09:39:07 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     Weihang Li <liweihang@hisilicon.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Add support for extended atomic
Message-ID: <20200103133907.GB9706@ziepe.ca>
References: <1573781966-45800-1-git-send-email-liweihang@hisilicon.com>
 <20200102210351.GA398@ziepe.ca>
 <2b8eb4ac-ef0c-7c7f-270f-8d3768f7c2a7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b8eb4ac-ef0c-7c7f-270f-8d3768f7c2a7@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 03, 2020 at 01:57:22PM +0800, Weihang Li wrote:

 
> This patch has no relationship with the userspace one you pointed out.
> But I have pushed a userspace patch that support extended atomic on hip08,
> maybe you were asking about the following one:
> 
> https://github.com/linux-rdma/rdma-core/pull/638

Right, sorry
 
> The kernel part is not needed by the userspace part, they are independent
> of each other.
> 
> We made this patch because we noticed that some other providers has also
> support this feature in kernel, maybe there will be some kernel users in
> future. I would be grateful if you could give me more suggestions.

I think we have no kernel users of extended atomics, it is probably an
mistake that other providers implemented this in the kernel.

I would advise against making the hns send path more complicated with
dead code.

Jason
