Return-Path: <linux-rdma+bounces-14549-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDECC658F7
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 18:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6EBE63496B6
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B47F3016FC;
	Mon, 17 Nov 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O2Qp1D2d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA042C21F6
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400837; cv=none; b=ele89RGdiQ8S/3b3b64iW23nxvSpuF/qa3Lkp02ZwLF4WSBaQ6gLdD4p+zjG5UaT7U6NLJ9hYa0WDUuNLSF0BVkYh+z9yZowbq+Ovyppd4gn9mlwo5aFcchIwiT6piX+EtoV8wNGPnSX2kXuKGi9k/5WSB6fx4aGVvKqiR4ctaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400837; c=relaxed/simple;
	bh=bdnBjm/uYGg9K2BCaEGDsBtbYsD5nLnLzXjQxXahe5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgQOOuwEb2BnuHrCuWWedj2Ice0LZl3I9ADfIraYNVJHD9rKD5mTBy/GEobVx2eK752H3JX8e3TF+dSzkE10FhBnbmStYN36BMllFCj9fB8hDRGoxwEYfligGWISSHFo3z4VKxZ966xeJmMDFe4JuPl/ZN6uCU07fE8UL5oLtDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O2Qp1D2d; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b144ec3aa8so463592085a.2
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 09:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763400834; x=1764005634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OGgS8qIOwGn9HKgahi1d6zJbs/9jew2a8tviFpwwlTA=;
        b=O2Qp1D2ds/on9xcWcF+7WXZKP7eZURnfBbwxDAoVQ5XhJoDy7XSvjroWI2Z7XzpJtk
         47qDUz36yRdAY1W7cFLM9YQ3vWHBXzq3s8HhBpIXRYyvR0sr+0qApk2Wod956UwwJyR8
         Vh8/kL0egM5LOroCE3Uk4ibYB8DqxZxRdyN1gxEtetKHyAOzaRrAMe8Y9uhcmK0gZpkY
         wuSzuvV/bZc3xjaNhwyrHkVYJGxDv9cXKHwRvrgO+XaJQQfEb25Ae7Adih35XZK4ENcf
         xWJDAgeyDy+//YD+FhCoqUv4P5kAk/8og6TTGa7DGdYf8Y0yOadoEnMdR2J2JX5RQKgo
         ixWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763400834; x=1764005634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGgS8qIOwGn9HKgahi1d6zJbs/9jew2a8tviFpwwlTA=;
        b=JPzQSU1gG0fu3yOTDGiREHz98YfIBpQWWR4stHSbSWTWspbkDIm3IAM10DfUtAByG6
         BUDyRcFbRsoANEK5q+ocEdbDrdq1vx7gRUiyTzth46iC+IhRZqiXzgWAEV8BLcFUCuEe
         8TbCyOBHjDkoGHsHg3Z/NMj7uKJW87+7NyH2TTR1Hu5ZEiLDxDFubJ5y8TJBLjEQN1YH
         NlDRwmuyOqSG46YSf0qrtLVR5yfAoGxZZhO4iTZOLsmSGE/+eby+hSRC1ltAHLG5eLx2
         TGNOVAZqjG0WmBA22Pb88fs0ztS3kAbhZm3Js77UXx23P4IKPcmW97vbGGMVOtGbqz5g
         Ki8w==
X-Forwarded-Encrypted: i=1; AJvYcCWjQ/XqFbq+mPewHQ35LZ0GQLOMVfSbzGJ2RRL+E24CHdrQxoORDIUVLsSe8zfHdFkMp5eCjXEYvd2e@vger.kernel.org
X-Gm-Message-State: AOJu0YzrNAEPpEK0JzKzplB+8BCJkUs7dKJbxjoxemXEL/EvLUWQIH++
	cx9a4dgRF3cIpkn0JjkyIou5Qs8YhVbRtXV5Lh+j+LuWU6cc3nQzgACEQcP6SGeKcJs=
X-Gm-Gg: ASbGnctxwQArGqkdW1414x9nUD6eWU/0dN9rNyugodydzY8g8+ADWz6/N2Zk3kktNO+
	LNjqS85oVQ25g+byx3TwXI6rykoFbMsazn+FsySX+tUXJim96jSFhTumxo/FFv6y/7IwwS+3djb
	vM1gG7wu/ZUTnRJIxA4/7cgHogLNYQzZLr5/peMsHypsVp162pQ9yZPvhxhAqrPIvkybt/CPw5I
	nHS6f7Th9spuTp82k6Ha7GSde7AKcDQeECJtWGzm7uuS/WkP8Gy1md9ERCbVwP60GTBgt76I+oR
	ecTit8ehAwun/devR3tsVzsitWeAp8ZZE2Ic4AxIjXtJpLLrbgvHXLXedTVuQtIC7pW9qhEJTEC
	tm2WRGnBKAndLdQg5rNbbZXa6iH99BycbuS44s8rAk2NNrJYpTlZXJ01xLEWYfQwrnSHYpo3qFd
	rCCLlATX3d1FPc046KaIdOrYn9ZPF4APvymL8zJrWctCZScy7J3zFVRH11eOPnWuRwR9Q=
X-Google-Smtp-Source: AGHT+IHYTgn8ZvsFlK6FR/zNM1E8sbQZYFtd1nKy0tjDooagvcZ1cL2uNjQVVjTPuHxKjKnwPTDylg==
X-Received: by 2002:a05:620a:690e:b0:8b2:efd6:1c82 with SMTP id af79cd13be357-8b2efd61fbfmr506527085a.2.1763400833751;
        Mon, 17 Nov 2025 09:33:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2e44c3154sm482923185a.20.2025.11.17.09.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:33:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vL36u-000000005ZN-2KHJ;
	Mon, 17 Nov 2025 13:33:52 -0400
Date: Mon, 17 Nov 2025 13:33:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v2 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20251117173352.GC17968@ziepe.ca>
References: <20251104072320.210596-1-sriharsha.basavapatna@broadcom.com>
 <20251104072320.210596-5-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104072320.210596-5-sriharsha.basavapatna@broadcom.com>

On Tue, Nov 04, 2025 at 12:53:20PM +0530, Sriharsha Basavapatna wrote:
> The following Direct Verb (DV) methods have been implemented in
> this patch.
> 
> CQ Direct Verbs:
> ----------------
> - BNXT_RE_METHOD_DV_CREATE_CQ:
>   Create a CQ of requested size (cqe). The application must have
>   already registered this memory with the driver using DV_UMEM_REG.
>   The CQ umem-handle and umem-offset are passed to the driver. The
>   driver now maps/pins the CQ user memory and registers it with the
>   hardware. The driver returns a CQ-handle to the application.
> 
> - BNXT_RE_METHOD_DV_DESTROY_CQ:
>   Destroy the DV_CQ specified by the CQ-handle; unmap the user memory.
> 
> QP Direct Verbs:
> ----------------
> - BNXT_RE_METHOD_DV_CREATE_QP:
>   Create a QP using specified params (struct bnxt_re_dv_create_qp_req).
>   The application must have already registered SQ/RQ memory with the
>   driver using DV_UMEM_REG. The SQ/RQ umem-handle and umem-offset are
>   passed to the driver. The driver now maps/pins the SQ/RQ user memory
>   and registers it with the hardware. The driver returns a QP-handle to
>   the application.
> 
> - BNXT_RE_METHOD_DV_DESTROY_QP:
>   Destroy the DV_QP specified by the QP-handle; unmap SQ/RQ user memory.
> 
> - BNXT_RE_METHOD_DV_MODIFY_QP:
>   Modify QP attributes for the DV_QP specified by the QP-handle;
>   wrapper functions have been implemented to resolve dmac/smac using
>   rdma_resolve_ip().
> 
> - BNXT_RE_METHOD_DV_QUERY_QP:
>   Return QP attributes for the DV_QP specified by the QP-handle.

I think this is generally not how things should work..

If you want to create enhanced QP/CQ objects then you should use the
existing create QP/CQ ioctls and enhance them with a driver specific
uverb spec, not special ioctls like this.

Certainly new stuff should be broadly avoiding the 'struct
bnxt_re_dv_create_qp_req' kind of design pattern in favour of the new
ioctl system's finer grained specs.

If you want to just create some kind of object by raw FW call then you
need something like mlx5's devx to push raw FW calls (eg create QP)
and wire them up securely.

> Some applications might want to allocate memory for all resources of a
> given type (CQ/QP) in one big chunk and then register that entire memory
> once using DV_UMEM_REG. At the time of creating each individual
> resource, the application would pass a specific offset/length in the
> umem registered memory.
> 
> - The DV_UMEM_REG handler (previous patch) only creates a dv_umem object
>   and saves user memory parameters, but doesn't really map/pin this
>   memory.

That doesn't sound sensible, what is the point of that?

The umem in mlx5 is all about pinning the memory and sending to the
firwmare immediately. If you are not doing that, then you shouldn't
havea "umem" type object at all.

There is no reason, indeed it is a pretty bad idea, to have the kernel
hold onto some userspace pointer and NOT pin it within the same system
call.

> - The mapping would be done at the time of creating individual objects.
> - This actual mapping of specific umem offsets is implemented by the
>   function bnxt_re_dv_umem_get(). This function validates the
>   umem-offset and size parameters passed during CQ/QP creation. If the
>   request is valid, it maps the specified offset/length within the umem
>   registered memory.

We don't support "remote" pinning. This code is wrong:

+       dv_umem->addr = obj->addr + umem_offset;
[..]
+               umem = ib_umem_get(&rdev->ibdev, (unsigned long)dv_umem->addr,
+                                  dv_umem->size, dv_umem->access);

Since "addr" is only valid for pinning within the single system call that
specifies it. You cannot pass it over to another, later, systemcall.

I have no idea why you would want to do a design like this, if you
want deferred pinning then pass the addr/etc directly later.

Jason

