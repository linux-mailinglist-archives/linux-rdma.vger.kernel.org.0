Return-Path: <linux-rdma+bounces-10236-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA73AB1E4E
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 22:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12BADB278CD
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 20:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5378F25F797;
	Fri,  9 May 2025 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7hnUgHj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F418122D9E3;
	Fri,  9 May 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746822627; cv=none; b=ljaDinbpZT9Xs6J2UBxkxiYVRtj2RMTwy3SeFU7MevxHdvNkYns/C+sKZ4LUKPGY9aJK1g6YYPkgbXAEiemFGEIioEjiAT8cBQxcy9ThHf8lkMHHwaIbOP/cUEc4zVWKeJ6DjhR55SautjsQDM1++aRNyU8uqdmVy2rNU2uDMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746822627; c=relaxed/simple;
	bh=jMwohjVVGQqtvJZ1usYIncXOugAXv27ycTElX0R2Djg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXMrco0rzBz7CaCLMPmtLJ+B0xvCkSDSKS/whK39Qznmue3KmbprQX7j8pyQRvk+gSEWLi1G00jj7L2dzn7EUhsqme7HuLXXmS/qOeoW+s+NeIoMmSD6MnI4gdOtIOt/Akt0r9/qLO4Rsoa+k4LyHrfrhxynk+U0bvm+kHqEK9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7hnUgHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F93C4CEE4;
	Fri,  9 May 2025 20:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746822626;
	bh=jMwohjVVGQqtvJZ1usYIncXOugAXv27ycTElX0R2Djg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J7hnUgHjbSM4KYKxaAbLHSxWJLQ693XYhDEfraUrkO26jKr4/OUrC5CaD+hy6xyZw
	 rLjcqCdkRvvnHLhMLj3UX/3RDO87PJ8heHU4bYqFLgwiRer/bAfIBGUdbPl8+RJ1v3
	 QEkKu5W+LvDbdD07ti63/rOddOABTUpBhhZf8cOFDMsjX13N+N+FNAIrmqP5AoosNj
	 Hwv0efOetSQZnEmulF35ym9ge29isEnEU5BWW5o5mF0weZFsFJCdWt7KhK2cVop8A7
	 WwEioB0E1+DvR0q1uxLQV9eBQ821Dm0xDqRD2IAPqdVOQiUA6BkxhTtRPFj1TEV1c6
	 SCaOB+gGzQwgQ==
Date: Fri, 9 May 2025 21:30:21 +0100
From: Simon Horman <horms@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, jgg@ziepe.ca, leon@kernel.org,
	andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] net: ionic: Create an auxiliary device for rdma
 driver
Message-ID: <20250509203021.GR3339421@horms.kernel.org>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
 <20250508045957.2823318-2-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508045957.2823318-2-abhijit.gangurde@amd.com>

On Thu, May 08, 2025 at 10:29:44AM +0530, Abhijit Gangurde wrote:
> To support RDMA capable ethernet device, create an auxiliary device in
> the ionic Ethernet driver. The RDMA device is modeled as an auxiliary
> device to the Ethernet device.
> 
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>

...

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.c b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
> new file mode 100644
> index 000000000000..ba29c456de00
> --- /dev/null
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
> +
> +#include <linux/kernel.h>
> +#include "ionic.h"
> +#include "ionic_lif.h"
> +#include "ionic_aux.h"
> +
> +static DEFINE_IDA(aux_ida);
> +
> +static void ionic_auxbus_release(struct device *dev)
> +{
> +	struct ionic_aux_dev *ionic_adev;
> +
> +	ionic_adev = container_of(dev, struct ionic_aux_dev, adev.dev);
> +	kfree(ionic_adev);
> +}
> +
> +int ionic_auxbus_register(struct ionic_lif *lif)
> +{
> +	struct ionic_aux_dev *ionic_adev;
> +	struct auxiliary_device *aux_dev;
> +	int err, id;
> +
> +	if (!(lif->ionic->ident.lif.capabilities & IONIC_LIF_CAP_RDMA))

Hi Abhijit,

There is an endian mismatch here: .capabilities is a __le64,
whereas IONIC_LIF_CAP_RDMA is host byte order.

Flagged by Sparse

...

