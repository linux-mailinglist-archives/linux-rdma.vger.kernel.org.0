Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6A95F48
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfHTM6F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 08:58:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35473 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTM6F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Aug 2019 08:58:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so4370790qke.2
        for <linux-rdma@vger.kernel.org>; Tue, 20 Aug 2019 05:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C6UpvYTpsEP7nxqequtc0g4wPRlBHrZ6ZGninWBI6oc=;
        b=gZdDMQAbtr3917oEYkF0T4VJIvgxxMYxjtrDMrGHvBnoYlUPaawJwsNkp3uoWyOMJw
         tYsXz5ZwJfacFSATUF6co4WtmaYsV9as2MVrPGdvsMElV+arc3fnL/XI0Fej3xTvl3Zp
         NEaDmOu2dKiDGH8sPKA674MTlsQkZPNNnsy9q0DfPxHsxq4cPizoBKXeW3Gc00REVPEC
         lPGo/pO7KCo8/ems6GkkRTlpQT3lcsLqbVq8SH3ykTGVjCVbFpIww5rLpi8yk2LDMcUx
         pseKMbICxKIYtlIT02vQiIZWcS4SO5uWgBnjjk6inqdgpl+uxEg0Q16SZIQivpG6bcD6
         dkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C6UpvYTpsEP7nxqequtc0g4wPRlBHrZ6ZGninWBI6oc=;
        b=LJ3cVayq67M9huGjjFCnenJJRJY1ixr5j36Ss8vGfXLgQbS36SsdM1+ATdTjMpvVCD
         H84dNe6EF2m3AEI4+fsdUlPs6VN1t+GQzsyDFIhb5JLypaXnTkHKyr4a4Hokan6f4Zu2
         s5eVF/iABlDIqYYXJCG3+J25qieyqq29cAbTuRZ4dRET4/8MEzQt6nZc2iORG0NgDwOJ
         62AaXwGwvy7z7O8D2ynfI9IQJ0gOXRmlFTt6Cw08JvAZxEZeB5ZYUi374OvwOkMtjAiS
         GypRuj1eDPJ7KpaK7l57iHlJGWr7l+tcyFlcGczD9Q3D0HcXn5Rz2sjTtsw/UxdqSHV6
         yMFA==
X-Gm-Message-State: APjAAAW5r4Onh8IoLu0XSCi7CliNCByLwmsAVQBy5dy4J2Vkm0biYlEd
        GLrir7Zisyk5pCgiDP2Ztoacbw==
X-Google-Smtp-Source: APXvYqzXeOQM0SW8ZZh2BPkG+l5oTzqufyAzRd83QO7qPgl84lS+oW6g5Rk98NqPponeqG2s6K1iyQ==
X-Received: by 2002:ae9:f812:: with SMTP id x18mr25448988qkh.290.1566305884697;
        Tue, 20 Aug 2019 05:58:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h1sm11092678qtc.92.2019.08.20.05.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 05:58:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i03i7-0008Ve-Ir; Tue, 20 Aug 2019 09:58:03 -0300
Date:   Tue, 20 Aug 2019 09:58:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        bmt@zurich.ibm.com, galpress@amazon.com, sleybo@amazon.com,
        leon@kernel.org, linux-rdma@vger.kernel.org,
        Ariel Elior <ariel.elior@marvell.com>
Subject: Re: [PATCH v7 rdma-next 1/7] RDMA/core: Move core content from
 ib_uverbs to ib_core
Message-ID: <20190820125803.GB29246@ziepe.ca>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-2-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820121847.25871-2-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 20, 2019 at 03:18:41PM +0300, Michal Kalderon wrote:
> Move functionality that is called by the driver, which is
> related to umap, to a new file that will be linked in ib_core.
> This is a first step in later enabling ib_uverbs to be optional.
> vm_ops is now initialized in ib_uverbs_mmap instead of
> priv_init to avoid having to move all the rdma_umap functions
> as well.

Sneaky, lets please have a comment though

> +/*
> + * Each time we map IO memory into user space this keeps track of the mapping.
> + * When the device is hot-unplugged we 'zap' the mmaps in user space to point
> + * to the zero page and allow the hot unplug to proceed.
> + *
> + * This is necessary for cases like PCI physical hot unplug as the actual BAR
> + * memory may vanish after this and access to it from userspace could MCE.
> + *
> + * RDMA drivers supporting disassociation must have their user space designed
> + * to cope in some way with their IO pages going to the zero page.
> + */
> +void rdma_umap_priv_init(struct rdma_umap_priv *priv,
> +			 struct vm_area_struct *vma)
> +{
> +	struct ib_uverbs_file *ufile = vma->vm_file->private_data;
> +
> +	priv->vma = vma;
> +	vma->vm_private_data = priv;

   /* vm_ops is setup in ib_uverbs_mmap() to avoid module dependencies */

> +
> +	mutex_lock(&ufile->umap_lock);
> +	list_add(&priv->list, &ufile->umaps);
> +	mutex_unlock(&ufile->umap_lock);
> +}
> +EXPORT_SYMBOL(rdma_umap_priv_init);

Does rdma_umap_open need to set ops too, or does the VM initialize it
already?

Jason
