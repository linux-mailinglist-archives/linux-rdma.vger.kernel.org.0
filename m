Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416FE542F80
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jun 2022 13:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiFHLyK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 07:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238401AbiFHLyH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 07:54:07 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8842F2050CF
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 04:54:02 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id 2so14710573qtw.0
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jun 2022 04:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kmW5A2G6WAjN72Ws1TwuN1zr+vCqFfRBHDfsGcuJi9g=;
        b=k565Nqo5CeomHIc8hXa/37c8wMJcsz2k7nBzaiMeQvyobg87+N8E2kDTqGv7qrxTWI
         t1ZI2GXM4k8Bp4c3+pJqwTQgiPLjEKNmkrW7oDV6vVMAfeKwkv/N9mfq7F4+nmiEwDes
         K70swk7OESVCDXcjhGZXb/e2tySqnIJQJXy9RdeTsREr1owyVX1goOzRK1IYf0gwdPdj
         wZJ/2pC9JxdCpmF1uQ5mrBiuB5Vl9gK1+jBF0QoYPOJwWLOGMAaEoYROrytPlUE4FFgt
         Up4Qtz2Di4viX5PYMJL3M7NQNWXhLhflNl0ZbSaez6JGDMCsqJjpPLSaAIFP5ZK5YgeS
         lllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kmW5A2G6WAjN72Ws1TwuN1zr+vCqFfRBHDfsGcuJi9g=;
        b=u/lpiUGz8NX+1TT3B03uW+F03hW/IY2dFIZW2COFPXb4I+zXvglxfbr0uweqjK0fak
         VocSdZfcLpqqE99+4+/jNKhJVJ6JuepiDrD+A3qm/wUBi3biEMPl6iAihPq92WaGuhRo
         o8NzxyOharuk8WpFdJqvWdmIawrTuA+rA1UJ9bPuFYrjsezrTDoFyqGvh1eN1S0cXt/E
         8yvbHu2kgzx5UEWNUz9r1F/07Rqoh6zpYRT46FiPlHju6TI0nSAN75VkBkPOOFSYlF7c
         wMqwqCXaQsJYbrD3bQciqYZa3Kzw+D2zpsFP98cUuyd+dzI4rtTr+XJortw7LKbYaKS+
         u0UQ==
X-Gm-Message-State: AOAM531krOZibLDtR15qY6qvX1uYmRSsm4JGXburdcWDUZlkhWYn8urF
        3NqTtoFZSFr/BeJ9rzNSVSIWVw==
X-Google-Smtp-Source: ABdhPJxIYVWf0vDdLjNwyq8QeTK1FMc5Ok+hT9So2jYyuXJoH7ZctHxVdjokTg8Q7mfHQwIhIrScNg==
X-Received: by 2002:a05:622a:30d:b0:304:e42d:fe06 with SMTP id q13-20020a05622a030d00b00304e42dfe06mr18609347qtw.617.1654689241608;
        Wed, 08 Jun 2022 04:54:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id r14-20020a05620a03ce00b006a6d3a6d597sm4441559qkm.71.2022.06.08.04.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 04:54:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nyuG8-003enV-A4; Wed, 08 Jun 2022 08:54:00 -0300
Date:   Wed, 8 Jun 2022 08:54:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v10 00/11] Elastic RDMA Adapter (ERDMA) driver
Message-ID: <20220608115400.GK3932382@ziepe.ca>
References: <20220608104320.53066-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608104320.53066-1-chengyou@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 08, 2022 at 06:43:09PM +0800, Cheng Xu wrote:
> Hello all,
> 
> This v10 patch set introduces the Elastic RDMA Adapter (ERDMA) driver,
> which released in Apsara Conference 2021 by Alibaba. The PR of ERDMA
> userspace provider has already been created [1].
> 
> ERDMA enables large-scale RDMA acceleration capability in Alibaba ECS
> environment, initially offered in g7re instance. It can improve the
> efficiency of large-scale distributed computing and communication
> significantly and expand dynamically with the cluster scale of Alibaba
> Cloud.
> 
> ERDMA is a RDMA networking adapter based on the Alibaba MOC hardware. It
> works in the VPC network environment (overlay network), and uses iWarp
> transport protocol. ERDMA supports reliable connection (RC). ERDMA also
> supports both kernel space and user space verbs. Now we have already
> supported HPC/AI applications with libfabric, NoF and some other internal
> verbs libraries, such as xrdma, epsl, etc,.
> 
> For the ECS instance with RDMA enabled, our MOC hardware generates two
> kinds of PCI devices: one for ERDMA, and one for the original net device
> (virtio-net). They are separated PCI devices.
> 
> Fixed issues in v10:
> - Remove unneeded semicolon in erdma_qp.c reported by Abcci Robot.
> - Remove duplicated include in erdma_cm.c reported by Abcci Robot.
> - Fix return value check in erdma_alloc_ucontext() reported by Hulk
>   Robot.
> - Sort the include headers.

I updated it, but please wait longer before sending v11.

Jason
