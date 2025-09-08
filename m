Return-Path: <linux-rdma+bounces-13146-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B3DB484B3
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 09:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B60716B8CC
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 07:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECD02E266A;
	Mon,  8 Sep 2025 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9+F+7Rg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EBE156C40
	for <linux-rdma@vger.kernel.org>; Mon,  8 Sep 2025 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314988; cv=none; b=H5NuniNcWFmUYRG8zYRjj6S9qU5gq9WLYnJ/YeSr9a+u+YFjwsixtY/Nhl4qVeDC70kwzhFTvzBvRPqOp1eZmyKHSYO4J7qz+NmlC2tqXO3w5CRq7/IcSYqOh12f9lPZ4zOxQIWYIThSIARVElk6N2WEjO46ForJtXshR6FW1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314988; c=relaxed/simple;
	bh=zfV6j/r4gM/v9rFyRcD+qIJDT/PCALNjIgG7t4KOq+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhTGeUv1oyXFTPEJ5HkQV6RtjMX3bwvi9x3Ma853he1jHK0sieneynlVh0M2G6ROgNG5kTR1hu3QF3M/TNqzYMM6izdled+y/njSFzq+q65BumHd8lQHyxvfhj7rFqVvYNHnTnmPv+jogzTV5zw/46BkNENAamqAtexBfyYl4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9+F+7Rg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CD8C4CEF5;
	Mon,  8 Sep 2025 07:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757314988;
	bh=zfV6j/r4gM/v9rFyRcD+qIJDT/PCALNjIgG7t4KOq+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9+F+7RghSUa4+fDaTtZv7dtZcZckO/xtsD0g4SXWUdeS16VajhfV9STZsoJScQzh
	 GoRpERgJ77dJyUrpAGTPkgiS3uT0faNA5xlgsJKozdxqZO9/E0qhsr1kJLUlZvn+Xw
	 Cq5upIjQEyJyNNsUDGX1dzr+bKinvA7Z1YuhWwNwSWgSRbOeT6bdnsq4TiyyJSiwkW
	 KbfkIDj3BKywTNF1I1KHaCY8kUBS4lers57VfOFEpiOorUhyqQbFFYYLCoTzWJhGh6
	 D4m/V+TI9RIusubz8D0M6bC9I8pde18yRDBUMpu9IlR4ZhKZWCg4JF3NNF2hcNOHWh
	 MSAqM/2l0QqSQ==
Date: Mon, 8 Sep 2025 10:03:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	Anantha Prabhu <anantha.prabhu@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: Re: [PATCH rdma-next 1/9] RDMA/bnxt_re: Update sysfs entries with
 appropriate data
Message-ID: <20250908070302.GC25881@unreal>
References: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
 <20250814112555.221665-2-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814112555.221665-2-kalesh-anakkur.purayil@broadcom.com>

On Thu, Aug 14, 2025 at 04:55:47PM +0530, Kalesh AP wrote:
> From: Anantha Prabhu <anantha.prabhu@broadcom.com>
> 
> Updated the existing sysfs entries with correct data.
> This change is to align the behavior with our OOB driver.
> Added "board_id" sysfs entry which will provide the
> VPD Part number, if exists.
> 
> Signed-off-by: Anantha Prabhu <anantha.prabhu@broadcom.com>
> Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h |  2 +
>  drivers/infiniband/hw/bnxt_re/main.c    | 49 ++++++++++++++++++++++++-
>  2 files changed, 49 insertions(+), 2 deletions(-)

<...>

> +static ssize_t board_id_show(struct device *device, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct bnxt_re_dev *rdev = rdma_device_to_drv_device(device,
> +							     struct bnxt_re_dev, ibdev);
> +	char buffer[BNXT_VPD_FLD_LEN] = {};
> +
> +	if (!rdev->is_virtfn)
> +		memcpy(buffer, rdev->board_partno, BNXT_VPD_FLD_LEN - 1);
> +	else
> +		scnprintf(buffer, BNXT_VPD_FLD_LEN, "0x%x-VF",
> +			  rdev->en_dev->pdev->device);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", buffer);

You should use sysfs_emit() here.

> +}
> +static DEVICE_ATTR_RO(board_id);

Thanks

