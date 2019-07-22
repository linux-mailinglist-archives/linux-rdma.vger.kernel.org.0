Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC56FEF0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 13:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfGVLsa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 07:48:30 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:41398 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbfGVLs3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 07:48:29 -0400
Received: by mail-qk1-f174.google.com with SMTP id v22so28306378qkj.8
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 04:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YKGvraGrR1kLx8RodaFYKDqgifq2hCB7S1RvMGmoSF8=;
        b=YjK8m+yeW38Rlix5Zqmn8xuvTRGubrGf+wPFUYUYJQeUBSNaM5XDIQ3dEQl2cEBx9d
         4EqDAlIq3hBBDnMp6wkrBIDkypoo5PzObT0GNdtQHrze/zOba/xIFBVilvvLV8E/0oxD
         aM7wLSIU2W3CP7Qls9XCRqTWihlCu/x6AH+YqsvlhfX7ryaqSb605M/Eq4jXmAwrXAPg
         +gNHnva5s4b1BeuEKTzCMDXIYrB3EfHys8uFAfqVyeZE5EKfM5a5T24QFEe8CX026KVW
         tNI6nNE4qpyfYz/LuJLImU98jSPN8FzISAb9uvvrUfGlI1Td15ReCjSkKEsEHbL/Ph5p
         KKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YKGvraGrR1kLx8RodaFYKDqgifq2hCB7S1RvMGmoSF8=;
        b=Axo65YRRJzf4gz2X+9qncCY4u5o4ue8jhkuA7q7lr0ZH7QMSH+AnwH7/XuiCeeTpgy
         44vM9gFPAXvLNombRM8m03OJ4b6ZKgleCb58a7/z/PalBafPdBI/gR3OC7ysm3HA21kd
         uAE/nPgiXEm2pIlAj7WS7prZ5W2NMY61SVbj/j4IOP0O1rhCKYp6F1q1U+FSqxF+ZHxC
         3jYeNROCNiBOv2hLqThBs2TFsRUW5JAzag+GCLmv6NbHI/8TALjMn0rN1Whl3HWyRHu5
         xwNfoAlqpIIhU85JljXeI5SJzcME4cJ02BL/2vA104oMNTsLVgE3OsqhOkj5mU8FseZp
         O/Pg==
X-Gm-Message-State: APjAAAWRE8/4XTjAdEA6QaCX+770UIlVB0LGj6L8jjBWgsoW0xIa03e9
        eWLHdlVfuMvosmKnIVC4RRpf3iiszuKLWg==
X-Google-Smtp-Source: APXvYqw7d21JwVeyi7JSrf1VlMuSaOpN9MWa8NqnGM4G0bCjr2O7uLmwY9zdFpotprEVRlleXlFDjg==
X-Received: by 2002:a37:4944:: with SMTP id w65mr45043442qka.111.1563796108918;
        Mon, 22 Jul 2019 04:48:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z19sm18993923qkg.28.2019.07.22.04.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 04:48:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpWnr-00028z-Ko; Mon, 22 Jul 2019 08:48:27 -0300
Date:   Mon, 22 Jul 2019 08:48:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: rdma-core device memory leak
Message-ID: <20190722114827.GA7607@ziepe.ca>
References: <9c250b8c-df24-7491-deda-ede0b72fd689@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c250b8c-df24-7491-deda-ede0b72fd689@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 22, 2019 at 11:10:51AM +0300, Gal Pressman wrote:
> Hi all,
> 
> I'm seeing memory leaks when running tests with valgrind memcheck tool [1]. It
> seems like it's caused due to verbs_device refcount never reaching zero.
> 
> Last related commit is 8125fdeb69bb ("verbs: Avoid ibv_device memory leak"),
> which seems like it should prevent this issue - but I'm not sure it covers all
> cases.
> 
> When calling ibv_get_device_list, try_driver will eventually get called and set
> the device refcount to one. The refcount for each device will be increased when
> iterating the devices list, and on each verbs_init_context call.
> 
> In the free flow, the refcount is decreased on verbs_uninit_context and when
> iterating the devices list - which brings the refcount back to one, as initially
> set by try_driver (hence uninit_device isn't called).

It is supposed to cache the device list in the library
(device.:device_list) and there is no function to cleanup the cache to
silence the valgrind warnings.

Jason
