Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F054C176
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 21:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfFSTZQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 15:25:16 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38441 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbfFSTZQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 15:25:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id n11so409006qtl.5
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P/oSgKtbzJr/carmAkezMBnMSv82HWuWgIe/OFv6Mwo=;
        b=mD5YJz4jvRy3QNAkq23a8kTZCag9CESbahVVFx8x+YyrG+hRYC8igpRKaSwchoXE6E
         lzpncfqF76Su9EhYO9Fme/pygtuztYVNpsRrRSwLgDYoKEkA2LHozYyb02KChpsusIk/
         zeSz+3Fm6Wl7b+muoCwE/22Z+AtFa9jKY3nNDPekrbZKoaaLmWblBqig+6F0GJR0Bb5g
         MsvnNAWA/0FKC51TAJlE5Ueg+Ovb/qy+2yjTDOjOtCCdICcCOZUkocBKLTVa/KHM6VAu
         EPEcPWaFtHe9rrRdsm+zLX3jh/caAIbqgkEv/vXbLOyOLG8S4Ke1DdXrkmjDEDiUpA3T
         hqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P/oSgKtbzJr/carmAkezMBnMSv82HWuWgIe/OFv6Mwo=;
        b=EEWlu1OSOHZYlPaTSVYuuDP4TGsrjnfhbXiun2y0Ng/CJApDPN4VoB8k4BGSlFXT4B
         wwR3AloXGUWWaETBeruJn4DOq/MrEuci1MVgHnSfDQ3euvYKvYyY84KH0bIpJDByMijQ
         UWg2QKbClv1UWZH5vOQccrYWkHSnwuPLsLzxN4ck/vAyF2rkCm8CVYN8GcWAlIcMpCiA
         Hs3zhndFVCHzzzROb2XpVk1SqK/jW96yqPh8BpwszOpFf/dl76vVmO+MrFvE4dybsdfU
         H5BMIs7qUfLvaz/65zTbccA32EQDg9a09oxrxZ0TVq0lCDRGBKIbWpct1eSbZLY2fHqR
         i5Hw==
X-Gm-Message-State: APjAAAWSpMn6mEu2NUHjhvKmjC2t7K00HBj6QHm5mt+/bPQ9WIenPIfV
        hx4YkcNQwB9yTw1q3/dlzNLlyw==
X-Google-Smtp-Source: APXvYqx7vBEWpDgbS1ppY2nyorwmGYPnFiKIZXSIGk5qgzrZ55RSNLIffJEqgAzFrltYhjChtOAkMA==
X-Received: by 2002:ac8:26d9:: with SMTP id 25mr70859956qtp.377.1560972315602;
        Wed, 19 Jun 2019 12:25:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v41sm12063765qta.78.2019.06.19.12.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 12:25:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdgCo-0003Vj-RY; Wed, 19 Jun 2019 16:25:14 -0300
Date:   Wed, 19 Jun 2019 16:25:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/netlink: Resort policy array
Message-ID: <20190619192514.GA13464@ziepe.ca>
References: <cover.1560957168.git.dledford@redhat.com>
 <a6504ecbb865862d2942d4d33ba92d7bac7b0b41.1560957168.git.dledford@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6504ecbb865862d2942d4d33ba92d7bac7b0b41.1560957168.git.dledford@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 19, 2019 at 11:16:11AM -0400, Doug Ledford wrote:
> Sort the netlink policy array by netlink attribute name.  This will make
> it easier in the future to find the entry you are looking for when you
> need to make changes, or to make sure you don't add the same entry
> twice.
> 
> Fix the whitespace while we are there.
> 
> Signed-off-by: Doug Ledford <dledford@redhat.com>
> ---
>  drivers/infiniband/core/nldev.c | 153 ++++++++++++++++----------------
>  1 file changed, 78 insertions(+), 75 deletions(-)
> 
> v0->v1: Move all whitespace changes to this patch

I always love sorted things

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
