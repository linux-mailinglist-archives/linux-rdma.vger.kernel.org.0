Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2D3B8016
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 19:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389807AbfISRhF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 13:37:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42153 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388938AbfISRhF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Sep 2019 13:37:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id w14so818573qto.9
        for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2019 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eV+2RC7+GRPXMo5kGyraP5zXmLEa6rfTpk4J0Wnb4Mo=;
        b=X4B9C3+D+2pxC2GlIaFESKh3KrjPiikU8D8vDVEzjvk9x9YZXYgGUIRz0CrAfsUNcU
         w2qGIrLQpnUYR3mJiW6TExeG+A6lKVfH6G/tlGz6i/W5NfpN8kh2UMyz7TyitpXz87VG
         GdxDnKF9Q0Ja1K/BQ4PJq64iiqfHIxK2o0QRZlT6om3jZvyp/s2+9WOMOK1KD/V3wz+p
         EMj7HbghpWRLYbSNIlSROZw3L2wO012VC5itKJhQ2U3AifgaucYS3F54NGmcUhMYLxhr
         j40MivrLdzGRXQ3bEq4e0OCwn5QKgSE3u2LWULqJhSLGPoKJRu+y9f37cTOkvk0eMECp
         EU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eV+2RC7+GRPXMo5kGyraP5zXmLEa6rfTpk4J0Wnb4Mo=;
        b=aEmRech6weplaWmq+AmKGs9cDBTfataU68zpVfAHiYd7aLbDNLHdVfzeft5nb6Hevv
         r032O6Q+octV7NlZGETWvULRhUVpmb13Fo9ctTP1ak3uyiH8SUkB+Vu4YJMPjU+Ym+wk
         sK5RkIwSxBNPnYFzUN5iIZz+M6tVr6Y1Mw8FJb2FXlESIAtD9Qki12DLP/1NS8CJPvQt
         m7vRXr3rW67TVz2dsEATmHbvoPUU2d7moHSr7ICzmWgmj3vcie00Cq6Qmwil0Uj/LMlD
         OrTtukzrFO3d/+/wlHCpJCc6JeqaALkPoZYOFVDjcepctuFSRrvhmBokLUuBIyjKDX0I
         7Izg==
X-Gm-Message-State: APjAAAUEEefePhYz0nIXJdKKRvFUYUUuR5AsDJrJEO4H1XLcOTgc61ns
        MfX9Qk6D+p8I2nuUUqDqKe3DBA==
X-Google-Smtp-Source: APXvYqyYJ0AD2eISmMqjbZTbenTidpWgTQ5DWT5JerFCBqFZnj+YNd2CypB+XWNo988KFRcO7DHPsg==
X-Received: by 2002:ac8:65d9:: with SMTP id t25mr2566211qto.261.1568914624028;
        Thu, 19 Sep 2019 10:37:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id f144sm4885577qke.132.2019.09.19.10.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Sep 2019 10:37:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iB0MX-0002O1-SL; Thu, 19 Sep 2019 14:37:01 -0300
Date:   Thu, 19 Sep 2019 14:37:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        bmt@zurich.ibm.com, galpress@amazon.com, sleybo@amazon.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v11 rdma-next 3/7] RDMA/efa: Use the common mmap_xa
 helpers
Message-ID: <20190919173701.GB4132@ziepe.ca>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-4-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905100117.20879-4-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 05, 2019 at 01:01:13PM +0300, Michal Kalderon wrote:
>  static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
> -		      struct vm_area_struct *vma, u64 key, u64 length)
> +		      struct vm_area_struct *vma, u64 key, size_t length)
>  {
> -	struct efa_mmap_entry *entry;
> +	struct rdma_user_mmap_entry *rdma_entry;
> +	struct efa_user_mmap_entry *entry;
>  	unsigned long va;
>  	u64 pfn;
>  	int err;
>  
> -	entry = mmap_entry_get(dev, ucontext, key, length);
> -	if (!entry) {
> +	rdma_entry = rdma_user_mmap_entry_get(&ucontext->ibucontext, key,
> +					      length, vma);
> +	if (!rdma_entry) {

This allocates memory and assigns it to vma->vm_private

>  		ibdev_dbg(&dev->ibdev, "key[%#llx] does not have valid entry\n",
>  			  key);
>  		return -EINVAL;
>  	}
> +	entry = to_emmap(rdma_entry);
> +	if (entry->length != length) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "key[%#llx] does not have valid length[%#zx] expected[%#zx]\n",
> +			  key, length, entry->length);
> +		err = -EINVAL;
> +		goto err;

Now we take an error..

> +err:
> +	rdma_user_mmap_entry_put(&ucontext->ibucontext,
> +				 rdma_entry);

And this leaks the struct rdma_umap_priv

I said this already, but it looks wrong that rdma_umap_priv_init() is
testing vm_private_data. rdma_user_mmap_io should accept the struct
rdma_user_mmap_entry pointer so it can directly and always create the
priv instead of trying to pass allocated memory through the vm_private

The only place that should set vm_private_data is rdma_user_mmap_io()
and once it succeeds the driver must return success back through
file_operations->mmap()

This hidden detail should also be noted in the comment for
rdma_user_mmap_io..

Jason
