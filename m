Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5F8E77F3
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 18:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfJ1R6G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 13:58:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41143 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfJ1R6F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 13:58:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id o3so15848054qtj.8
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RfGx63e795zWqzkl7OD6MawrhXv+b73myPZMFVCO4Z0=;
        b=S8jXEa+JCu40jvaI17jTeU9YDwoykTkhwkoxVQthNosWMe/5bIpqwe2Bx0dgVKPBrP
         gJa+7Sibomkr8RsT8tsM1uQMgToXrLC2QzjdPn+Hvq4FDPXPq4ls5xBDe6UdoW3BwV+u
         s/O+2O5noVobxE+56Z4OtuowY+j3YVUFjJJjmjE69cuykhJX3DMj2eTGwobR2FDa0otH
         sDvGD+0HOM/GHotngDqZIVwWFrtTuVljVm/5QRXrzkyROFBfVF7DVWVcSHHvUhfAMsTA
         kHJO0cNtoh8AVr9t806/ufiCy5lWBAm2M29ffAV113HxAW6wCe2AlUMYBklFhe4+ar5i
         RziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RfGx63e795zWqzkl7OD6MawrhXv+b73myPZMFVCO4Z0=;
        b=S9zAXNMl1AXoeHP/cd+JeQ7EBQvqkBVBoF6pB/NB1Jlg8gj6hdRmFum1NGs6xeW/no
         43svBGuyw56zF80as5CCJh2CR0mopa+7hFcFF9eP8YQcr8PlU1XsEvWzX65yYP57heuZ
         OQFikaMcRqlVMRBeZ7bY7rLO9tUxy3e2FhkQfXa2y1LPXy0EdUUCijUxPDdcCOXv6VDB
         jLgFHb0QdSCDsU4JWTBTT+kzZNfgdTseaQAkb83GPU9oXWAOSelDHYUhEDk2gGFtnN71
         B01H3c2S3+HLkEZIzoJ8aeizMQ06wdwQURXV2zUTJyX1rCwuamuSElWUH7Q86ifbfe/B
         uHSw==
X-Gm-Message-State: APjAAAUt6CDlZ/jjX950GbKCMbRrag6kem076/8CAGxy3eTPFAhBn17u
        5lHR/WSxx9c+/x+8sz9aX+5u4A==
X-Google-Smtp-Source: APXvYqxCIii4hvhpYVn2rN95KKxgzwwH+NLDrPOiI4tKXACYZsj7cMidJzFHnNVPJhgpsH1+LBtFhA==
X-Received: by 2002:ac8:ac4:: with SMTP id g4mr18499459qti.326.1572285484687;
        Mon, 28 Oct 2019 10:58:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id k17sm4617496qkg.63.2019.10.28.10.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 10:58:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP9HH-0001a4-DN; Mon, 28 Oct 2019 14:58:03 -0300
Date:   Mon, 28 Oct 2019 14:58:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Fixes related to the DMA max_segment_size
 parameter
Message-ID: <20191028175803.GA6051@ziepe.ca>
References: <20191025225830.257535-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025225830.257535-1-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 25, 2019 at 03:58:26PM -0700, Bart Van Assche wrote:
> Hi Jason,
> 
> These four patches are what I came up with while analyzing a kernel warning
> triggered by the ib_srp kernel driver. Please consider these patches for
> inclusion in the Linux kernel.
> 
> Thanks,
> 
> Bart.
> 
> Changes compared to v1:
> - Restored the dma_set_max_seg_size() call in setup_dma_device(). Reordered
>   this patch series to keep it bisectable.
> 
> Bart Van Assche (4):
>   RDMA/core: Fix ib_dma_max_seg_size()
>   rdma_rxe: Increase DMA max_segment_size parameter
>   siw: Increase DMA max_segment_size parameter
>   RDMA/core: Set DMA parameters correctly

Applied to for-next, thanks

Jason
