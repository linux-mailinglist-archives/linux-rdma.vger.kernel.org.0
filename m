Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CC059CB35
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbiHVV6g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 17:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbiHVV6f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 17:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E99DFC7
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 14:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661205513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQUeuV51GD+/Z3NmS3oF64vuc80M1JzNM209IAEm6Lo=;
        b=QDKSwbWktfcpbVu17nly/LEBErjdoK1I3QSToM/CARQj2SN9DRr81yns2cgabr7pIiiGv6
        zjTAXjL821rSBus5LvgnMai44jV5qjqUn+nqDth/vE5D2gquHP75Qwt5H7moWFr/cQuXsh
        UGRUGkgY+wP7FSslxaJ9kIw1p2MDm3I=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-297-zD8zWoULN6-SkmBPWZTMqw-1; Mon, 22 Aug 2022 17:58:32 -0400
X-MC-Unique: zD8zWoULN6-SkmBPWZTMqw-1
Received: by mail-io1-f69.google.com with SMTP id g12-20020a5d8c8c000000b006894fb842e3so5744317ion.21
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 14:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=mQUeuV51GD+/Z3NmS3oF64vuc80M1JzNM209IAEm6Lo=;
        b=U44Tk6E8xyphtiqXTRd01am8eKj+9FmGJdBfeNgPcClwWeqF29iIMj2p6raVtIy6es
         7qyb+iVTm+5p254iJU0mzv0UF7Dn+qoQaw7313CAH8VGuo7ZqzpenKsdYCNHxS1VOOvk
         eu2gZ4LdGiGNRTLENd6cn+9Az83tpQiFucWn5s6i/JiWPYfK/OC0cMiluhYSjDtMV3Xy
         nRkvLvLoYZg/TqQBdpQUTN7jKOV4KHNktdFFlwJjQvxxwwkKqxmIh6lF6HMHM7F4VJrH
         XE5XNjsKSSXkVTTTYSNvfMZP6uWL776zIm+tjI6FtDpNrr243wmK2iqW6jbbPeVtyFHq
         UxzA==
X-Gm-Message-State: ACgBeo06zuN0GqJZDBE/9Lu8C0xzNz8piP1xCbXH9BrSYbU99fo531dY
        waIUF7bcg/u2Uds20gaW7S6OZsLV2pwCiH+PFIenro6emyyMD6mn3QMI7bEJ4x0sN0l1fDl0IR/
        xx1rHgsw+u7YfNNoe7cZyHg==
X-Received: by 2002:a05:6638:3892:b0:342:8aa5:a050 with SMTP id b18-20020a056638389200b003428aa5a050mr10967573jav.145.1661205511223;
        Mon, 22 Aug 2022 14:58:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Ji5Aas470cfaDuYoFCQXCz8xDov2+WjpaEqjz4PP+196q6rswlxrWF7iO99xdkBAv+YQNFg==
X-Received: by 2002:a05:6638:3892:b0:342:8aa5:a050 with SMTP id b18-20020a056638389200b003428aa5a050mr10967567jav.145.1661205510943;
        Mon, 22 Aug 2022 14:58:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id g2-20020a05660203c200b006788259b526sm6276185iov.41.2022.08.22.14.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:58:30 -0700 (PDT)
Date:   Mon, 22 Aug 2022 15:58:28 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Cornelia Huck <cohuck@redhat.com>,
        dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Oded Gabbay <ogabbay@kernel.org>
Subject: Re: [PATCH 0/4] Allow MMIO regions to be exported through dma-buf
Message-ID: <20220822155828.6fa6a961.alex.williamson@redhat.com>
In-Reply-To: <Yv4rBEeUMQyIdEzi@nvidia.com>
References: <0-v1-9e6e1739ed95+5fa-vfio_dma_buf_jgg@nvidia.com>
        <Yv4rBEeUMQyIdEzi@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 18 Aug 2022 09:05:24 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Aug 17, 2022 at 01:11:38PM -0300, Jason Gunthorpe wrote:
> > dma-buf has become a way to safely acquire a handle to non-struct page
> > memory that can still have lifetime controlled by the exporter. Notably
> > RDMA can now import dma-buf FDs and build them into MRs which allows for
> > PCI P2P operations. Extend this to allow vfio-pci to export MMIO memory
> > from PCI device BARs.
> > 
> > This series supports a use case for SPDK where a NVMe device will be owned
> > by SPDK through VFIO but interacting with a RDMA device. The RDMA device
> > may directly access the NVMe CMB or directly manipulate the NVMe device's
> > doorbell using PCI P2P.
> > 
> > However, as a general mechanism, it can support many other scenarios with
> > VFIO. I imagine this dmabuf approach to be usable by iommufd as well for
> > generic and safe P2P mappings.
> > 
> > This series goes after the "Break up ioctl dispatch functions to one
> > function per ioctl" series.
> > 
> > This is on github: https://github.com/jgunthorpe/linux/commits/vfio_dma_buf
> > 
> > Jason Gunthorpe (4):
> >   dma-buf: Add dma_buf_try_get()
> >   vfio: Add vfio_device_get()
> >   vfio_pci: Do not open code pci_try_reset_function()
> >   vfio/pci: Allow MMIO regions to be exported through dma-buf
> > 
> >  drivers/vfio/pci/Makefile           |   1 +
> >  drivers/vfio/pci/vfio_pci_config.c  |  22 ++-
> >  drivers/vfio/pci/vfio_pci_core.c    |  33 +++-
> >  drivers/vfio/pci/vfio_pci_dma_buf.c | 265 ++++++++++++++++++++++++++++  
> 
> I forget about this..
> 
> Alex, do you want to start doing as Linus discused and I will rename
> this new file to "dma_buf.c" ?
> 
> Or keep this directory as having the vfio_pci_* prefix for
> consistency?

I have a hard time generating a strong opinion over file name
redundancy relative to directory structure.  By my count, over 17% of
files in drivers/ have some file name redundancy to their parent
directory structure (up to two levels).  I see we already have two
$FOO_dma_buf.c files in the tree, virtio and amdgpu among these.  In
the virtio case this is somewhat justified, to me at least, as the
virtio_dma_buf.h file exists in a shared include namespace.  However,
this justification only accounts for about 1% of such files, for many
others the redundancy exists in the include path as well.

I guess if we don't have a reason other than naming consistency and
accept an end goal to incrementally remove file name vs directory
structure redundancy where it makes sense, sure, name it dma_buf.c.
Ugh. Thanks,

Alex

