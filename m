Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5A9132F97
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 20:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgAGThq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 14:37:46 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35392 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgAGThp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 14:37:45 -0500
Received: by mail-qv1-f67.google.com with SMTP id u10so388600qvi.2
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 11:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Ck4pUpVOy7SW33RXzc7snzdHuEICisJeXljpgSs0is=;
        b=fOHBidA15ZfXrVOmUb6YbyhZGDvKfP7UeoRzD0WVn80aej+o65Gci4Cw2cjgdc1JV6
         sEslNgV6EuvX0MJHQ6YBUdtJxlysPCav8d+qe8oBLmmxNDRoR67/hVbJ03Y77RqeTx0F
         +Aq8mvAGOt8Gd12VpIsBQKJrVPCwLRNK30PSIcLREmhcAucXIkDqpOHVsOapwNU3L0ZH
         6n3ryoOnvzn49+wepy+SrsOKOm/o20hullKpVJ5i2AFWNpuWxAZ6HP6UMCeLYv8EHkFh
         EAa9cjqYDjZexa2owSAzLC+5Mmqv/S5qnkd360+uOwjjZipaqjAR16YmvchIUCm2H4mF
         32kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Ck4pUpVOy7SW33RXzc7snzdHuEICisJeXljpgSs0is=;
        b=kwYs8oAgXdF+NnMrCKqUM3YIC/rQBpg8WwStg/ZsQj88JMICHMhzVFGhQFHIaZTTa0
         Fc+bHxahhYSv2FsFaFHr0ENghgeKwCBcQQYwFDjLLt0+2FGvDLPlbAA7eWirEr2Sfjw6
         DM5D84oe9+/+mKNrQPiStcCGTfACKpMaj0a06ixiWvTwDfzbTg6DhCJQ0YhtYRjgAXj/
         RYaURnBoiUgbKjyfX31XQ8GivzDBkQFBviNXlK9YXKAfY9++LYLZybSNhwADqUwVFbzB
         +pXSFKiiZ4c4ZZiU2cPFgfrqngXOH9nhw5YlwJb+R02DadXwT5HByplJ7RwzL1bgamff
         jmUg==
X-Gm-Message-State: APjAAAVWIH1eHJbEtHXLctwVYGMOZKUgqbNzZnMuqM20byfnAOYwO5di
        sRcD93FwtLn7uI0c4VSVPktgtw==
X-Google-Smtp-Source: APXvYqwDaCqepnfZmA8I+9XCtRX1PuflUuZN3/mO9DaS9sR8LLZT/W94NdlHKMTKkW6lbU6fd10Ytw==
X-Received: by 2002:ad4:5562:: with SMTP id w2mr949745qvy.147.1578425864935;
        Tue, 07 Jan 2020 11:37:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d5sm367760qtk.96.2020.01.07.11.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 11:37:44 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ioufg-0004nS-4H; Tue, 07 Jan 2020 15:37:44 -0400
Date:   Tue, 7 Jan 2020 15:37:44 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Shahaf Shuler <shahafs@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 0/5] VIRTIO_NET Emulation Offload
Message-ID: <20200107193744.GB18256@ziepe.ca>
References: <20191212110928.334995-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212110928.334995-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 12, 2019 at 01:09:23PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> In this series, we introduce VIRTIO_NET_Q HW offload capability, so SW will
> be able to create special general object with relevant virtqueue properties.
> 
> This series is based on -rc patches:
> https://lore.kernel.org/linux-rdma/20191212100237.330654-1-leon@kernel.org
> 
> Thanks
> 
> Yishai Hadas (5):
>   net/mlx5: Add Virtio Emulation related device capabilities
>   net/mlx5: Expose vDPA emulation device capabilities

This series looks OK enough to me. Saeed can you update the share
branch with the two patches?

https://patchwork.kernel.org/patch/11287947/
https://patchwork.kernel.org/patch/11287955/

Thanks,
Jason
