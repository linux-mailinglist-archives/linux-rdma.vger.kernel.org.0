Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1817E591
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2020 18:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgCIRSF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 13:18:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39086 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgCIRSD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Mar 2020 13:18:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id e16so9992876qkl.6
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2020 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nToBEoh6tfWiB/VJHVs7IOJAt3gO0xfBje1E0nagTRA=;
        b=EYIG8iOVqclVWrFhVXS1LbD/gapSJHWQ4ayOkaZRvtQTKYr9UK2xUdoVgszQXVi90e
         WBLg3xg6U5d26DF8nXf2sbwTapCDa5WqkHNXpS23HjSN/yWegSvMmt9iN+EAm7VKpD+n
         xuWVOXMWpnL9U5AIgybU2Si9GazQKQ5UwuXJq7sowl2MDIOOi5Gp7S3EJIO9pMFlnO+z
         YB0v3nTcMjiHCaAD/Vj3AUr2JmzafkrCV5xKgtjvxFwqlhGyza05NZs7t/9PvJFq7mpf
         a+e7jOKOflfAqFj+glsfCycp/G6HepllRX5gvbSOthVUilBdnmNIQ3RDDzr2hgSSY5IR
         3hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nToBEoh6tfWiB/VJHVs7IOJAt3gO0xfBje1E0nagTRA=;
        b=q7kiM0Pjr2Q1Vi9/sOcWffOTAUesB5MZQ7Fuv/HItlJOKKbx3OjPd3Hp4U/O/MIfzH
         szl7UhIlJtcY8Kb/0oFEwhVwXRrsNeoUAi2y+Hwk2STy+C11WTWtXL8agK0M0A4TTpIi
         RIByr/1RClZNd8Op/OjHSInjlwTNkVmaeJG02jnlzEf3Ol13h3WyJk4TizERSyQTgrwA
         2hGaCibWGDWtK3LCn4FbVOYXRPzYCeXn1lHKTSIxbKX2x+SYh79sbhdc3og9nM4M6Eoe
         Suh8Z81G1i/F50AmPI/GgK4p/946meqrRcjt+Ej+DdOf/pj06ZEE8EsqZk6+fZELg5mf
         l/Ow==
X-Gm-Message-State: ANhLgQ3lOQvxrzK2euYg/zoMxJqF+bmRy5rMjtKOyX5LCTSfbIGKtXVB
        93ejvVBwNlAm8s2J0y0L4uqzgg==
X-Google-Smtp-Source: ADFU+vvWwdJIJlZ9GMGzucSugkOew68wrWEBXrrrFGFgTMIv3CcZ/+wvcwW3CEBRD6Lvq5mqU8qN5Q==
X-Received: by 2002:a37:b042:: with SMTP id z63mr10282439qke.269.1583774281941;
        Mon, 09 Mar 2020 10:18:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id z11sm4966506qti.23.2020.03.09.10.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 10:18:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBM2S-0003az-R2; Mon, 09 Mar 2020 14:18:00 -0300
Date:   Mon, 9 Mar 2020 14:18:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+2b10b240fbbed30f10fb@syzkaller.appspotmail.com>
Cc:     chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, syzkaller-bugs@googlegroups.com
Subject: Re: BUG: corrupted list in cma_listen_on_dev
Message-ID: <20200309171800.GR31668@ziepe.ca>
References: <20200304135649.GE31668@ziepe.ca>
 <0000000000003406b805a0378b77@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003406b805a0378b77@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 06, 2020 at 02:55:02PM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger crash:
> 
> Reported-and-tested-by: syzbot+2b10b240fbbed30f10fb@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         5e29d144 RDMA/mlx5: Prevent UMR usage with RO only when we..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6d613b606deeaad7
> dashboard link: https://syzkaller.appspot.com/bug?extid=2b10b240fbbed30f10fb
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> 
> Note: testing is done by a robot and is best-effort only.

#syz dup KASAN: use-after-free Read in rdma_listen (2)
