Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFAF24B96D
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 13:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgHTLqY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 07:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730504AbgHTLqK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 07:46:10 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75204C061385
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 04:46:10 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s23so908524qtq.12
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hHqFMFGjNwGAY/fc9CMZMHF3w2BGPSmKdrFKLDVMtaw=;
        b=RSb0f+HHqZqEcTBvwJ9GsIe6PMgyfqitLppJP13bsrKtnPvGIwExy0KA8VPYgniu86
         /HLmSITVy2Sre35fNq8lovqDv3y2vmtaFMwFwh6BsHzgnYoKiMI6IcJsqr3+/peIM8Z5
         BZINPe0xPiznCIBRKHnJtAQl1VxTkangalsqIAe7alcC/FkePz19I8sLLWOsOx/aJn0b
         FDlmEWp12ZbfNhzu0mTQkPaRRNIJwCkenXljRzn0hStjXMadNM5UfFQtuvB4Ru2wm3nf
         C1/p7BiojvVutF2lElKCcMuKMDvI9cNkMOu6zvaI6BUpcN42fj7VPUG6HHPCwmO4S+CP
         zRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hHqFMFGjNwGAY/fc9CMZMHF3w2BGPSmKdrFKLDVMtaw=;
        b=l7yWX1li779EmbEBWNGifXuSvhY5zgGMy8VOVdimkwsnjLsoBbpijKMVAvFoFSil4S
         Yjn5mtMJwpNt9TSNdt8Czo2z/D+ExFviN4ETufc6xQmEjDTxCfrG3EsIJgDgh3SyD1SX
         jP58z7HHot1xnYRimaKq/gEOS8he2t0cK9U7eMB1GISSUOdlOakSK9bCHRzOgIxmGH4S
         0wLJV9KIA4cNonuQGLPRQqMc7IVL5el7WmN4p/PXunk2yBPbDU07W6YAboiU2USHNQxf
         yNJyg7M6zCcQndlz3jKDVSmITOk0OMzal1MZqJIDpYDafRAtOAgXG1TGPAMeCrNVd/IQ
         g85w==
X-Gm-Message-State: AOAM5320Cr6WOCT43j+9h2RXqxDb366bsAKKT5Z50ANQH12A3W+Wkpru
        J7XWUV3N0eoO8iYIChz7b01y+w==
X-Google-Smtp-Source: ABdhPJxDsjLnUxXU0PK/FEdslH/9JHqnNMdZe8i1cLJfPgoxN0jujxY0L4FfkWCneGaOIA4T6/XphA==
X-Received: by 2002:ac8:7455:: with SMTP id h21mr2202867qtr.201.1597923969734;
        Thu, 20 Aug 2020 04:46:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w2sm1867518qkf.6.2020.08.20.04.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 04:46:08 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k8j1E-009tF4-B7; Thu, 20 Aug 2020 08:46:08 -0300
Date:   Thu, 20 Aug 2020 08:46:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-rdma@vger.kernel.org, yanjunz@mellanox.com,
        bvanassche@acm.org, kamalheib1@gmail.com
Subject: Re: [PATCH] RDMA/rxe: fix the parent sysfs read when the interface
 has 15 chars
Message-ID: <20200820114608.GB24045@ziepe.ca>
References: <20200820041336.24761-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820041336.24761-1-yi.zhang@redhat.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 12:13:36PM +0800, Yi Zhang wrote:
> parent sysfs reads will yield '\0' bytes when the interface name
> has 15 chars, and there will no "\n" output.
> 
> reproducer:
> Create one interface with 15 chars
> [root@test ~]# ip a s enp0s29u1u7u3c2
> 2: enp0s29u1u7u3c2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
>     link/ether 02:21:28:57:47:17 brd ff:ff:ff:ff:ff:ff
>     inet6 fe80::ac41:338f:5bcd:c222/64 scope link noprefixroute
>        valid_lft forever preferred_lft forever
> [root@test ~]# modprobe rdma_rxe
> [root@test ~]# echo enp0s29u1u7u3c2 > /sys/module/rdma_rxe/parameters/add
> [root@test ~]# cat /sys/class/infiniband/rxe0/parent
> enp0s29u1u7u3c2[root@test ~]#
> [root@test ~]# f="/sys/class/infiniband/rxe0/parent"
> [root@test ~]# echo "$(<"$f")"
> -bash: warning: command substitution: ignored null byte in input
> enp0s29u1u7u3c2
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index bb61e534e468..91090cb1b08c 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1056,7 +1056,7 @@ static ssize_t parent_show(struct device *device,
>  	struct rxe_dev *rxe =
>  		rdma_device_to_drv_device(device, struct rxe_dev, ib_dev);
>  
> -	return snprintf(buf, 16, "%s\n", rxe_parent_name(rxe, 1));
> +	return snprintf(buf, 17, "%s\n", rxe_parent_name(rxe, 1));
>  }

This should be written as 

  return scnprintf(buf, PAGE_SIZE, "%s\n", rxe_parent_name(rxe, 1));

All places in this file should be changed

Jason
