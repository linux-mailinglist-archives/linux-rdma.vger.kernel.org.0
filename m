Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8E723BD3D
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 21:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389314AbfFJT43 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 15:56:29 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34480 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389170AbfFJT42 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jun 2019 15:56:28 -0400
Received: by mail-ua1-f68.google.com with SMTP id 7so3598923uah.1
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2019 12:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OUvXRss51vuZbQiadfmhsCC0g5u+ZZ9EIKQF586Z7FM=;
        b=INgxWvaUjGseW6JzGG0bZ8lcpE4o2afZp4lH6GyIyTYExm/cAhd2riTujXw55rry9C
         7pSCltY+on5d6wF8NyFbGW1W3F6yfhF9f8bhHneJV5SqtegDttu58EEwIhayJBhrtChh
         47nj6csTQH5KNixLtiC2cXwvVcWv5kiZBVVdXvFJlFwSbQgGM0hMv/GLA8/y/Z4vGLZU
         v64GCfHh3ZcSfgarqIcD/YgRafMriaYxH1Wq5lOyuAK1Mu07FaEMr3hjWoXN7uAZDOqw
         TQ10kfxWBz0NmCN2V8Pep4z0QgmAThLPRIg+mtCZnf5nDJiWBmIM/u20nkJY5HT86puB
         OmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OUvXRss51vuZbQiadfmhsCC0g5u+ZZ9EIKQF586Z7FM=;
        b=duj/HVw7AryKmba5pd1t1kBl+c0/sevHdjNxpaxsR1PnSXHvzYNLYqKmtodAwSjoii
         seYUulDUyAqnApNjRNaa1PK3gE4vbjGZoOgsVU+1bgscWq5TjPyx8bApQOpQOHLfci2+
         1zoLISXM/vS70XTtYS148XZycgsNd2w/5NUAefts1HiDWdwP+JTt984UEDXfAyPdU0Os
         1p16yUpjAKTEqBJQ92t7AW4DKBh0Dl2PBRhD3zb86Ne1Ecaj335QUsiYGiF0N0lNDiUV
         EU6WEq9xf+9WuQVcm44dx8FL8GCXeOQb3J+q9K50PSWftKbpWLALuE0Wk9aKotM2hpUp
         2qbA==
X-Gm-Message-State: APjAAAV0omVhga0IvfwHrCPOjPbDaE31iRjje4brkMk4aaxSrL1JwXvO
        Bv/e5OveM2IU2p9ioJxyiWj2PGWm7HIN7Q==
X-Google-Smtp-Source: APXvYqzEasaCSTLjaNVllPlXSF4vHbLu6QWh4S4MdvxeT+rUbntLkA3o3p7TagFcuJjhWmXNLpsITw==
X-Received: by 2002:ab0:5a64:: with SMTP id m33mr12392796uad.135.1560196587720;
        Mon, 10 Jun 2019 12:56:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h13sm3854244vke.50.2019.06.10.12.56.27
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 12:56:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1haQP4-00055d-Ra
        for linux-rdma@vger.kernel.org; Mon, 10 Jun 2019 16:56:26 -0300
Date:   Mon, 10 Jun 2019 16:56:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/3] Move more constant stuff into struct ib_device_ops
Message-ID: <20190610195626.GA19534@ziepe.ca>
References: <20190605173926.16995-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605173926.16995-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 05, 2019 at 02:39:23PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Each driver has a single constant value for
>  - driver_id
>  - uverbs_abi_ver
>  - module owner
> 
> So set them in the ib_device_ops along with the other constant stuff.
> 
> Jason Gunthorpe (3):
>   RDMA: Move driver_id into struct ib_device_ops
>   RDMA: Move uverbs_abi_ver into struct ib_device_ops
>   RDMA: Move owner into struct ib_device_ops

Applied to for-next

Jason
