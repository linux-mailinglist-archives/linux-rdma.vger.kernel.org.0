Return-Path: <linux-rdma+bounces-2263-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F78BBD82
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2024 19:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E94B21614
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2024 17:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AF65FDD3;
	Sat,  4 May 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3T+/CoM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCAC11711;
	Sat,  4 May 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714845030; cv=none; b=OD7Sg5Dmxn6GevFf+GuhhV5dWxhPHzvB7W+roxRRuJuqYQOiA59yULgrlCVbMvsWlzF0DzzyTi0zETPbF0P1SN449ruVz7ck5ExOzfmhqoPFZ07yrJrsGZvQXamERGn3vgczEJ4R8PikK2TdN1dJcz/lNxxRIjItmJ/vRQ42orw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714845030; c=relaxed/simple;
	bh=nfISBoRVTLt0JxitMNryCxJFzQuU/qq3veQHuRvkNSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qigy4idLqo4+JjBTaAq1T8eXXqViA6PWeei9fLTg/ga9hi0Yhjx2NkhIG72K9im5aMTd0LaZmeLbUCcYnFhzCiCyeAWqDHZ6Q7ZAM+fh/zAniXM9sHgmkt9lFIQmA3lt46qPe5nUlBKRUdV8GIAKogL3teikB8+ACLGc22Jy2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3T+/CoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90043C072AA;
	Sat,  4 May 2024 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714845029;
	bh=nfISBoRVTLt0JxitMNryCxJFzQuU/qq3veQHuRvkNSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3T+/CoM+aOBSUZNRfLtSfDxCMLfGoDzRMkOsaUHaepcmBPfu8MTxmGwkOhYKfEgS
	 L0U/M0exuILccB5vEU0IziG8LGCTzcRcICh2xV4lzoSMLnB4Qhk0PDVb4j+6IJyAsp
	 z4Tf6+0IcjH7UDPdh//ZwJgE6ums51MTuhKGBFKkhyQUI/0Big/xaJd5hJ33E0aWTo
	 xATVBy/jb6lEYjxx7Ar8X3hnixX4NnoSKJTFxC+V5AgwI0A67YrhmcBPKrrP1zS/Or
	 bUw2VRCd5ZKKHAamdF2B+bP9wyFsXTKhCi3twULk1MrdvIr6IVVFT/Nu7b/YA9fQIq
	 RK4ggaOPCemNg==
Date: Sat, 4 May 2024 18:50:24 +0100
From: Simon Horman <horms@kernel.org>
To: Shay Drory <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, gregkh@linuxfoundation.org,
	david.m.ertman@intel.com, rafael@kernel.org, ira.weiny@intel.com,
	linux-rdma@vger.kernel.org, leon@kernel.org, tariqt@nvidia.com,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 1/2] driver core: auxiliary bus: show auxiliary device
 IRQs
Message-ID: <20240504175024.GI2279@kernel.org>
References: <20240503043104.381938-1-shayd@nvidia.com>
 <20240503043104.381938-2-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503043104.381938-2-shayd@nvidia.com>

On Fri, May 03, 2024 at 07:31:03AM +0300, Shay Drory wrote:
> PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
> and virtual functions are anchored on the PCI bus;  the irq information
> of each such function is visible to users via sysfs directory "msi_irqs"
> containing file for each irq entry. However, for PCI SFs such information
> is unavailable. Due to this users have no visibility on IRQs used by the
> SFs.
> Secondly, an SF is a multi function device supporting rdma, netdevice
> and more. Without irq information at the bus level, the user is unable
> to view or use the affinity of the SF IRQs.
> 
> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
> for supporting auxiliary devices, containing file for each irq entry.
> 
> Additionally, the PCI SFs sometimes share the IRQs with peer SFs. This
> information is also not available to the users. To overcome this
> limitation, each irq sysfs entry shows if irq is exclusive or shared.
> 
> For example:
> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
> 50  51  52  53  54  55  56  57  58
> $ cat /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/52
> exclusive
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>

...

> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c

...

> +static int auxiliary_irq_create(int irq)
> +{
> +	refcount_t *ref;
> +	int ret = 0;
> +
> +	mutex_lock(&irqs_lock);
> +	ref = xa_load(&irqs, irq);
> +	if (ref && refcount_inc_not_zero(ref))
> +		goto out;
> +
> +	ref = kzalloc(sizeof(ref), GFP_KERNEL);

Hi Shay,

Should this be sizeof(*ref) ?

Flagged by Coccinelle.

> +	if (!ref) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	refcount_set(ref, 1);
> +	ret = xa_insert(&irqs, irq, ref, GFP_KERNEL);
> +	if (ret)
> +		kfree(ref);
> +
> +out:
> +	mutex_unlock(&irqs_lock);
> +	return ret;
> +}
> +
> +/**
> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
> + * @auxdev: auxiliary bus device to add the sysfs entry.
> + * @irq: The associated Linux interrupt number.
> + *
> + * This function should be called after auxiliary device have successfully
> + * received the irq.

It would be nice to include a Return section to this kernel doc.

Flagged by ./scripts/kernel-doc -none -Wall

> + */
> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)

...

