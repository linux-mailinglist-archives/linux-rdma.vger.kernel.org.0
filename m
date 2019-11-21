Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABE11049A6
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 05:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfKUEYN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 23:24:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26132 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725819AbfKUEYN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Nov 2019 23:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574310252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MiQoAlmb+4j2v6SgDa1Q9v4RQh84PVKLEKwv2xgY9M=;
        b=P9PYpmjfPBV+S5ClgSCNkwO6DV7joiQ6/7nzOEaeS4WaE6VCtyjqC9x9onmKxukpmAVwfG
        OwzF1P3GZZiLa16Ou7/A4ifSJW8VjVptddh8YMB1vbrbm+IQY+W/5rD2BY2tK88MGo59G5
        iUSjbVaTUAYTcVvYXho0W1t5RRvNUyU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-GMbWaODiMbmRP-QSpKdrQA-1; Wed, 20 Nov 2019 23:24:10 -0500
Received: by mail-qt1-f197.google.com with SMTP id t5so876917qtp.5
        for <linux-rdma@vger.kernel.org>; Wed, 20 Nov 2019 20:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h002/KfwzNnHwaVFHvMAKKzPg+NcqTlO07ep/sFR+MI=;
        b=goCT/iH1HSc82e24rqXxxETKHjk5GUAF3ocffiNFRa/IY+zEhj6gFW+1CFz6Nh/Cat
         3xaVj9OCI+FJHjN7BCrXyrAtlK521f96cGOyT2pDq0OGdhc+Qi1+URddu0W/tIEL/AA1
         VbMfYxIC4j0AtB4HhhulewaMgfajncSEGUaKAbkjA4GQTWjS9THI9k7mQJEtS+4yrpmK
         S5pYBDbXXnwyg0M9VH8C/gyLfAdsa4woDOQ6v612ZZxlpgt3kN9+W6xo2lxBItiboCxo
         Oo8gDnS6HpUvh/bkeXApbm7htfHdZrDII7XgMPHsR+ygcNcuuvhoUD4Do2ZopTeHRD9W
         nSOQ==
X-Gm-Message-State: APjAAAWG/VLUygEvm0st7uIenSHBX9UZnuv+YsHzWoZGV7lAGVE3wyKS
        XxA4S+HFPgD/sGk+rA3AoxR06Tw5K3pSYxquSVII/sAmyBXyK5PXOBHPT/DkcA2mlx79f2l0sld
        C/aMUlcCEi44J7mzIySgGVw==
X-Received: by 2002:a37:ac09:: with SMTP id e9mr6184770qkm.258.1574310250073;
        Wed, 20 Nov 2019 20:24:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqw7XNl+H+UW6snu6/5KF765mQrBqtDgv/zVy1Mne2H0maYjusu3isdX7aEJ7G7ZUYWVtX6mNw==
X-Received: by 2002:a37:ac09:: with SMTP id e9mr6184754qkm.258.1574310249852;
        Wed, 20 Nov 2019 20:24:09 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id b185sm809197qkg.45.2019.11.20.20.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 20:24:08 -0800 (PST)
Date:   Wed, 20 Nov 2019 23:24:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Dave Ertman <david.m.ertman@intel.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, nhorman@redhat.com,
        sassmann@redhat.com, Kiran Patil <kiran.patil@intel.com>,
        Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [net-next v2 1/1] virtual-bus: Implementation of Virtual Bus
Message-ID: <20191120232320-mutt-send-email-mst@kernel.org>
References: <20191119163147-mutt-send-email-mst@kernel.org>
 <20191119231023.GN4991@ziepe.ca>
 <20191119191053-mutt-send-email-mst@kernel.org>
 <20191120014653.GR4991@ziepe.ca>
 <134058913.35624136.1574222360435.JavaMail.zimbra@redhat.com>
 <20191120133835.GC22515@ziepe.ca>
 <20191120102856.7e01e2e2@x1.home>
 <20191120181108.GJ22515@ziepe.ca>
 <20191120150732.2fffa141@x1.home>
 <20191121030357.GB16914@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191121030357.GB16914@ziepe.ca>
X-MC-Unique: GMbWaODiMbmRP-QSpKdrQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 20, 2019 at 11:03:57PM -0400, Jason Gunthorpe wrote:
> Frankly, when I look at what this virtio stuff is doing I see RDMA:
>  - Both have a secure BAR pages for mmaping to userspace (or VM)
>  - Both are prevented from interacting with the device at a register
>    level and must call to the kernel - ie creating resources is a
>    kernel call - for security.
>  - Both create command request/response rings in userspace controlled
>    memory and have HW DMA to read requests and DMA to generate responses
>  - Both allow the work on the rings to DMA outside the ring to
>    addresses controlled by userspace.
>  - Both have to support a mixture of HW that uses on-device security
>    or IOMMU based security.

The main difference is userspace/drivers need to be portable with
virtio.

--=20
MST

