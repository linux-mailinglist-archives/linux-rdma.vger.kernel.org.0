Return-Path: <linux-rdma+bounces-8352-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCC9A4FAEA
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 10:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A45A3A60F7
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 09:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2632063EE;
	Wed,  5 Mar 2025 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhQPN9i+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D32063DF
	for <linux-rdma@vger.kernel.org>; Wed,  5 Mar 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168517; cv=none; b=nIUgHxoFRH6g9TJlYZPuzFC2PJH9y91LrLQLG1s62t8RD9bYNPI1PoFdyj68eZm1jQtT5GwlQGJqdMThcxkz+zWRdGPM0csuyAO/t+A7lABFRHPuOIPeiX9jl2MKu8C8e17K0OKgdV+OTGRpJMW9MLYQlnmFWfoPmIjVs5amq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168517; c=relaxed/simple;
	bh=orVnR3L84n6RTjhnWKbavb0TLId+7AWhnXglp6or6Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbVCkl+NDtCwQv0M9l/kezmm9VrxnIqyA5vH49X4pJRNtCnZ9gAYcZI0ASs5kndXLR7Gp1rKP2zhS4qacjB+7NwKFKWBHy1ZNf0/nDfGAL/0GruaFw+s+3rdgU6AcT9JEmNO/1M87PHVqyDVGg1DM28bIwWo1vRR2C7WJjYCeUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhQPN9i+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE646C4CEE2;
	Wed,  5 Mar 2025 09:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741168517;
	bh=orVnR3L84n6RTjhnWKbavb0TLId+7AWhnXglp6or6Js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhQPN9i+6jh1NymUyFa/nChjhoko6cf0mBC/YwylZOJtvsh/pUDjVbj9OrxHcQGxT
	 2b9StJ7sr+8zMP4fSPSwpRIy7xL/2y7188ummZRB2x0I1dp1Bvi9r/oNqAVPVN7w+H
	 XDPuUqB8H5g95sbRFVtgDDIeB4jGdSMLAQ48j2GB6yCcK9uss8xzarI3/GodH8cpXh
	 oBfY67ihwZbTamgnkAe/tW1wpYJT2hBO+ua3BvBxNaP/Gyk15zKYYV2+E057PoO7lp
	 qFHGPEU2pe+08i3e6FUHWibhuKJycMDjE9frsid4O600iwwG3lMnL0hKDKNRJ2X4Cd
	 mt6uY9JHzrxhg==
Date: Wed, 5 Mar 2025 11:55:11 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Chiara Meiohas <cmeiohas@nvidia.com>,
	linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 1/6] RDMA/uverbs: Introduce UCAP (User
 CAPabilities) API
Message-ID: <20250305095511.GI1955273@unreal>
References: <cover.1740574943.git.leon@kernel.org>
 <558b28bc07d2067478ec638da87e01a551caa367.1740574943.git.leon@kernel.org>
 <CAH-L+nPoVOMHq-hzAVBXa5-8Ehc75qg0pP4mBnYtT8qH7zNUpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nPoVOMHq-hzAVBXa5-8Ehc75qg0pP4mBnYtT8qH7zNUpg@mail.gmail.com>

On Wed, Mar 05, 2025 at 02:01:13PM +0530, Kalesh Anakkur Purayil wrote:
> On Wed, Feb 26, 2025 at 7:50 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Chiara Meiohas <cmeiohas@nvidia.com>
> >
> > Implement a new User CAPabilities (UCAP) API to provide fine-grained
> > control over specific firmware features.
> >
> > This approach offers more granular capabilities than the existing Linux
> > capabilities, which may be too generic for certain FW features.
> >
> > This mechanism represents each capability as a character device with
> > root read-write access. Root processes can grant users special
> > privileges by allowing access to these character devices (e.g., using
> > chown).
> >
> > UCAP character devices are located in /dev/infiniband and the class path
> > is /sys/class/infiniband_ucaps.
> >
> > Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> > Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leon@kernel.org>
> > ---
> >  drivers/infiniband/core/Makefile      |   3 +-
> >  drivers/infiniband/core/ucaps.c       | 255 ++++++++++++++++++++++++++
> >  drivers/infiniband/core/uverbs_main.c |   2 +
> >  include/rdma/ib_ucaps.h               |  25 +++
> >  4 files changed, 284 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/infiniband/core/ucaps.c
> >  create mode 100644 include/rdma/ib_ucaps.h

<...>

> > +       device_initialize(&ucap->dev);
> > +       ucap->dev.class = &ucaps_class;
> > +       ucap->dev.devt = MKDEV(MAJOR(ucaps_base_dev), type);
> > +       ucap->dev.release = ucap_dev_release;
> > +       dev_set_name(&ucap->dev, ucap_names[type]);
> > +
> > +       cdev_init(&ucap->cdev, &ucaps_cdev_fops);
> > +       ucap->cdev.owner = THIS_MODULE;
> > +
> > +       ret = cdev_device_add(&ucap->cdev, &ucap->dev);
> > +       if (ret)
> > +               goto err_device;
> Memory leak in the error path, need to free ucap here?

It is done through call to put_device(&ucap->dev) below.
This is how device is freed after device_initialize().

<...>

> > +err_device:
> > +       put_device(&ucap->dev);
> > +unlock:
> > +       mutex_unlock(&ucaps_mutex);
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL(ib_create_ucap);

<...>

> > +       ucaps_list[type] = NULL;
> > +       cdev_device_del(&ucap->cdev, &ucap->dev);
> > +       put_device(&ucap->dev);
> need to free ucap here

Same as above.

Thanks

