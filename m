Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6645FCB09
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 17:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfKNQst (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 11:48:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46104 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKNQst (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Nov 2019 11:48:49 -0500
Received: by mail-qk1-f193.google.com with SMTP id h15so5525391qka.13
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2019 08:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7GJLu0rhCy9EmDtDkFFDYoyUr1gLUzYdPkCqHHYIzfc=;
        b=KBT/jzLXedcAjmuKV3o/ztBs23SgFvJYE5v78L/nXWv6GOSrHuU4ggZgVbi9hZNnk2
         z4Y6EFaJJNDGXVUY5CvMmu9ZTHJu+EMf2dakAOHLlwJgrQyFLl80u3eroPCavv63JTTQ
         4XPGIgCmOhiV6azehtmWxgBd07VwDtJ8N5GUJpT95bvFwSa/4VGM4RHLo72s+mMl3GRQ
         OOKVNb3sRmQHi3BNJE3ljDp21+UsU1sT1yQtL3SYmwkdmMEAwwFeTsG/UI2M59RvO4LD
         juKXQk5RRMO708m6LxxLMlVIH8H6e9OtjaZ1H4keXsoqg+ThgRK3OSUy5z1P0qmjl741
         UnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7GJLu0rhCy9EmDtDkFFDYoyUr1gLUzYdPkCqHHYIzfc=;
        b=BwaemzIzMUMHVoD6BT9+A5vZQjfaklqidaDty4ITUadJo68EOgRYjBo74kUVucop9Z
         wcs8kgS6IKL1dzBF7XnLFtDqwCbUnV0qfuZEFhONRs1uLhUvmCubtftYKX+E4l4NfF9i
         VDFzIlQ81lc+4cjWlUik5zGcbBP0VbgoiNhQNlpmQgvmE8WZvd0LVurOAg1d7559cO4K
         XZhmf6Sq0P5FqGgd29oSd4vNY6JcXeKOzBn6SpAWwJ465/UE/XUU7MHi/rlyrmzp6dtW
         BA9pvQ2+CeUbxsKxoVr1uUG2geOUZKL6TuPZCwww+lXGd4vqyf2MClIRZH56/3rJ6yJY
         60tQ==
X-Gm-Message-State: APjAAAV8MByvpOsRu7jyQS2baYL+MfhTeUKDaihot88CMDz+KA3jSv4t
        PlYLLm4uvF75LV0iPADTNsVfvg==
X-Google-Smtp-Source: APXvYqwAFNysDj7xylbnDPnfNIHmH6Ey61doLPKkZE9Pv+8qcMgfa+KBHC41utU75Sn+7VEGXGu0Ww==
X-Received: by 2002:a37:6845:: with SMTP id d66mr7678807qkc.407.1573750127975;
        Thu, 14 Nov 2019 08:48:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id p54sm3629725qta.39.2019.11.14.08.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 08:48:47 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVIIZ-0003yG-12; Thu, 14 Nov 2019 12:48:47 -0400
Date:   Thu, 14 Nov 2019 12:48:47 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dag Moxnes <dag.moxnes@oracle.com>
Cc:     dledford@redhat.com, leon@kernel.org, parav@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2] RDMA/cma: Use ACK timeout for RoCE
 packetLifeTime
Message-ID: <20191114164846.GA15241@ziepe.ca>
References: <1572439440-17416-1-git-send-email-dag.moxnes@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1572439440-17416-1-git-send-email-dag.moxnes@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 30, 2019 at 01:44:00PM +0100, Dag Moxnes wrote:
> The cma is currently using a hard-coded value, CMA_IBOE_PACKET_LIFETIME,
> for the PacketLifeTime, as it can not be determined from the network.
> This value might not be optimal for all networks.
> 
> The cma module supports the function rdma_set_ack_timeout to set the
> ACK timeout for a QP associated with a connection. As per IBTA 12.7.34
> local ACK timeout = (2 * PacketLifeTime + Local CA’s ACK delay).
> Assuming a negligible local ACK delay, we can use
> PacketLifeTime = local ACK timeout/2
> as a reasonable approximation for RoCE networks.
> 
> Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
> ---
>  drivers/infiniband/core/cma.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

This seems like a reasonable thing to do, applied to for-next

Thanks,
Jason
