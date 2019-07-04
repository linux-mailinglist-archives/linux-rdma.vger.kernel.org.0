Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEDB35FC8B
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 19:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfGDReF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 13:34:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41738 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfGDReE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jul 2019 13:34:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id v22so6043364qkj.8
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jul 2019 10:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UVn9y6Dh00vfTV1YzXColHUP1deusXQZSnUMy7fJoAQ=;
        b=QEMf5meeVg9huIHurDBJ5YjuTxSOP4z6H3jqCB+8/1W0ATDwB4lM7WWHq3GRNUx1h0
         UsMw8B1WzmSNfy2jdPWDE+mCZuErbIJVZuzmgRI6OYMw6CO/UlRtDRpRba2lUCDNw2YJ
         5J4jf6bW4Qio4ShXMOBfn0tG2NCZeDBG8jt7ZbRVU7Kx2qmR1ktZSJ7Q37fBBCbcohuZ
         0Ar3sWWxPGwJx59XprgVx8s7Rt1xRN90onX1dByHRl6NsdgehK63tFBXPPZ4wLBqB8PG
         IuuJY2cY3Lk15SmBGTjQJdhvrQGmmdariEaVUX7v0J6KvR7+dglnSUCFzqoAVB2AsBuc
         kYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UVn9y6Dh00vfTV1YzXColHUP1deusXQZSnUMy7fJoAQ=;
        b=DykZhLiFvKiQudVj2yiA7J1bQwHeUfacavnbmbtmnNlRSBmb/gLZVcgPi5hO2Juzkw
         D9gp/3kYV0o6S4NRl8YyqsU8PdrQ/MZ2FOVGKzT45L+EgqXMVj7CozvyfFpF+uvxK+iP
         B1USp8DNiBKYrsIHu3pN3jRz6QnpfaBonKRaboQFMzvYrO4uTF+lLgDO3tTBoT2e65CW
         V9TpZbAkaT3/g9ifRGfBzzs5v6Fhj3IuEGSFzK1eKNz9rPR4xTO6X+oxnvTaLBKGiHAa
         Nw2os+AiITchN96T0ra+8YcQ4plKjJnS9TV+G4LXRd6EVGzW0e59RKhn/wYOs0orIRtS
         caYA==
X-Gm-Message-State: APjAAAVDYbDKwG/JUKWA/M1v2fDAePJ205xMe9ZCFwT1tDJc0gN0m6CT
        5IBcZjx33cG7VDrO6HQh6HBzcw==
X-Google-Smtp-Source: APXvYqylRQEKpaD6UE7aA/f2GKuaQSL24aLR5PPkMSxoH8ffOHjt5+1hyccM/ilf8mCKhvY73Xo1Rw==
X-Received: by 2002:ae9:d606:: with SMTP id r6mr6916304qkk.364.1562261644175;
        Thu, 04 Jul 2019 10:34:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id x8sm2717363qka.106.2019.07.04.10.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 10:34:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hj5cR-0005S8-5o; Thu, 04 Jul 2019 14:34:03 -0300
Date:   Thu, 4 Jul 2019 14:34:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH rdma-next 0/2] Allow netlink commands in non init_net net
 namespace
Message-ID: <20190704173403.GA20921@ziepe.ca>
References: <20190704130402.8431-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704130402.8431-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 04, 2019 at 04:04:00PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Now that RDMA devices can be attached to specific net namespace,
> allow netlink commands in non init_net namespace.
> 
> Parav Pandit (2):
>   IB/core: Work on the caller socket net namespace in nldev_newlink()
>   IB: Support netlink commands in non init_net net namespaces

Could someone please confirm that all the new libibverbs stuff works
properly in a container after this series?

Jason
