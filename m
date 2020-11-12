Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D532B0B6B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 18:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgKLRjI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 12:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgKLRjI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 12:39:08 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8792C0613D1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 09:39:08 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id d38so1821122qvc.3
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 09:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9/BWB2JMcyfr9SsyIuCQhSr0cozjVOSg0qZsEvg/Gec=;
        b=ScUqn50Av3jkuanAHL9FGgKs2H2CEtXkHfhtLCKnJl/JiHzXM6ZbzMHOwZ2hp+OVWx
         Fi+0vs1eN6mEx8OmQp7fn4u8wWGm8kj8NVs7rBtEM7yvcDuwy5qDdx1T0eYjrmriTWdQ
         TA3moLECIUN1PPVAu7IX9pZj8s7lUFYHIf/pVvChzvfn/0oXRiGe/H0vUzt7bo0jX06e
         tmnOhDEESzGoBN/C/rIcyYQA3vEILCTSVyippGbU4XhjiCwQUYijQdef9FmKKpYJTadq
         RJuyOMJeRyyohYZIhVoK3M2B9uoBrkvVFWuxnJaphy18XoYCDwDAKW9xlbTD7A35Jvfi
         k+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9/BWB2JMcyfr9SsyIuCQhSr0cozjVOSg0qZsEvg/Gec=;
        b=PTsg2g8NBcUhc0IAewNiWAO8lhKvPgcseLrK+MY9EaSKRJ9dVwbNlD0R1z2/7Ydog+
         azvU77GAKCTNam4VZC5+XQi4+DHW9CKH3LIsy36YUt4szFoh31emA/lzZp2w44kv9xns
         UuZIUKHYM0klE/9B+cPCt+ylX5h/07AuSkBcr9eVORHcAm8+Cjp7q7YOU0PSg7+A5iN7
         4sUnRgVxL/27afO20goZQP10k9esIkNnPGULX4+1I8U0Lj0Z8tFK53y2y3Qd+dFvX7s4
         XvfzY6c5OP8TqcJhFzDxjO5d/AHruUrBLcQk8jxfLer0CW8mmdtfRkd3ai4xrFUK3HFF
         Lv7Q==
X-Gm-Message-State: AOAM530EGvcFPjzXYb+RkQo8sKJRT2AkgIQPYHAATHlSxu2Jt3pwqESq
        kPpcCGitTq1gSsQvSf9NBr4ayQ==
X-Google-Smtp-Source: ABdhPJxGjs7RKm1+d6vm7YlPcQDBoWbQJjGD0bECyIRJfi4QeWUNLlgH4DteMkEt2qfo5HNkxSMv+g==
X-Received: by 2002:a0c:f607:: with SMTP id r7mr714119qvm.47.1605202747806;
        Thu, 12 Nov 2020 09:39:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d12sm4989837qtp.77.2020.11.12.09.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 09:39:07 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kdGYs-003z7n-Ku; Thu, 12 Nov 2020 13:39:06 -0400
Date:   Thu, 12 Nov 2020 13:39:06 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: remove dma_virt_ops v2
Message-ID: <20201112173906.GT244516@ziepe.ca>
References: <20201106181941.1878556-1-hch@lst.de>
 <20201112165935.GA932629@nvidia.com>
 <20201112170956.GA18813@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112170956.GA18813@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 06:09:56PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 12, 2020 at 12:59:35PM -0400, Jason Gunthorpe wrote:
> >  RMDA/sw: Don't allow drivers using dma_virt_ops on highmem configs
> 
> I think this one actually is something needed in 5.10 and -stable.

Done, I added a

Fixes: 551199aca1c3 ("lib/dma-virt: Add dma_virt_ops")

Jason
