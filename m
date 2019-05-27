Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96CE72B971
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 19:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfE0Reb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 13:34:31 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39352 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfE0Reb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 13:34:31 -0400
Received: by mail-vs1-f66.google.com with SMTP id m1so11035068vsr.6
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 10:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9mfN34fKGWkc2pNjD4/rSPF/JWbtqCNiz4nY7+AR2y4=;
        b=H+9bfGeYfIAziFW4r4eEuQhA4mLEi8RTUHA53dXo0n1xz44y1T9lfK4VBhqvBq0dlK
         HNllE7siI6kc57N016zJp2IVJOs2hnI0aWlQ1R+zC5IUo9YwEk5YE7mMem65exZhaOlq
         1El7fcQFyiscaWBce1QvuTMXL74zd+14Nv2aGEVofgVmVyLAtdwSYRkNvdrOiruYs9MD
         0qmSsByM7t5wIOqQuPpHT8qFvZkym4tUUDAmsftY3P9NoBQEBU2rwlu8SE4NvZbP/kUH
         BE9J8b2DbRijjes8Ifog7lf0sLvE6bMQB/5HQRyYb9tBFG5S/KzQAWs+bqMRATechkJo
         X5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9mfN34fKGWkc2pNjD4/rSPF/JWbtqCNiz4nY7+AR2y4=;
        b=ZQuWzGdtjaOfd6TTuE9eG8g5dZDX4ZPENgW+v3BVebjsLFVBrdmC/l66mHDzg0T1rL
         /K61AK2+bliMnSF+fnSmmfSwMV90P3XwSDF3xj3Ipq4dqPe1UjLlFF6J6Eg+kmoFWN1y
         9u7RuQ8CDZqIk4J8ZEY5jT95KeJtsC24vP61WDMBSzxbnt7uSALfz13g94x5Cuw/mmtS
         2NJHobYDtEzdT4orKvAX1qrEXFqJRFyUz1fTs2EwZZjssZttL4msiUK4GZIMQHjCac5n
         YeJgxeRPAeKbcbw32+NdKWniMwxn+r2iktyJGpVmN+K2ELrWcBkmUIFmQhLC444UOjMR
         Pw2w==
X-Gm-Message-State: APjAAAVN1kpcjx2m5Ho530rrIfhmXc6GJqjm9LfJnzfO63xJOaEora8Y
        TFUeLH9fpfjQ/ZKlhva4S1TC2g==
X-Google-Smtp-Source: APXvYqx0AtdsDsiuGXJrxa1uYsItI7hoGFHOS5hqi3m23qFZWnw/rkSd9CE6A9a4cBmK9DipEG+2vQ==
X-Received: by 2002:a67:d613:: with SMTP id n19mr51339881vsj.7.1558978470345;
        Mon, 27 May 2019 10:34:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e187sm11617692vse.16.2019.05.27.10.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 10:34:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVJW1-0008Ab-3Z; Mon, 27 May 2019 14:34:29 -0300
Date:   Mon, 27 May 2019 14:34:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH rdma-next 00/15] Convert CQ allocations
Message-ID: <20190527173429.GA31373@ziepe.ca>
References: <20190520065433.8734-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520065433.8734-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 09:54:18AM +0300, Leon Romanovsky wrote:
>   RDMA/cxgb3: Use sizeof() notation instead of plain sizeof
>   RDMA/cxgb3: Don't expose DMA addresses
>   RDMA/cxgb3: Delete and properly mark unimplemented resize CQ function
>   RDMA/cxgb4: Use sizeof() notation
>   RDMA/cxgb4: Don't expose DMA addresses

I applied these ones to for-next as well

Jason
