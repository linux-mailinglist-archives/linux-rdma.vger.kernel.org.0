Return-Path: <linux-rdma+bounces-15887-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMrMN5ErcmmadwAAu9opvQ
	(envelope-from <linux-rdma+bounces-15887-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 14:52:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CF4678FE
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 14:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EAE6749DEB
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 13:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD903176EB;
	Thu, 22 Jan 2026 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGPMFjUO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2F23EA90;
	Thu, 22 Jan 2026 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087687; cv=none; b=Jd/qddvIUZVZoFY7r42U8bMcwaXs1gIVfJ4P2UI1WzM11sQ9KJlAwm3+afEEm1Vvk3BVEm0UOrKBzvw5vgjiM+iqwWGF7Rw3201MpOXMBMwB72+pUIUTAv+yq/jK28EwTx1BJBarXKE5lZDlbvH2pD/xxZU5W+qTOanSSRfaqEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087687; c=relaxed/simple;
	bh=Ar6ljAQ4kGGGoGcl8iBgvNAY4OZnFYqFluVi35JyBT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIXRCFA1Ft3ErzbAdJWUJjvgXKgkmHJ1DutGQMXKlUhEbVXbcU/vwDo0rLFiQkMoMAZJIqJXy/EfX/g3gxpRZJoghsKLgMui98CkSzFJiE4J5fEL1Gck1AaEjkVXHq84e2vAUCA8QFSCLP/zUSNOSQmB2q7IfhJVIPmQhpjYXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGPMFjUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FDFC116C6;
	Thu, 22 Jan 2026 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769087686;
	bh=Ar6ljAQ4kGGGoGcl8iBgvNAY4OZnFYqFluVi35JyBT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HGPMFjUO2zij6oeWdI7gm2UY4ha0GTVWjGAeRrK3cdcXIO/eONItwr0nCm+4vTb9R
	 lPFmM3ZOeOKE/svfoubO+54Th6Aj7nNDBKbxVDUwwbuiWtasNeZ8PkPqARBHeH07cq
	 f190dtbtq0sVot1CGj0bqQ5ZMsVD2KAtGTrno7l0l0+Vt67vzWRBo19HFmsblri96R
	 2rwT4briusLXDDzL6d3jXgGQee68izs7rOpJ8fqqxOwgQ2IBWpPGb11QCy2luikYqE
	 RenJNcT3/4WPvetaVnnYStmgMR7RGT4H7E2NnGa6KrrHJJop4MUlsBdHV4kTtVAVeJ
	 ITVzNAaCYmixg==
Date: Thu, 22 Jan 2026 15:14:42 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: device memory support
Message-ID: <20260122131442.GL13201@unreal>
References: <20260116090450.250432-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116090450.250432-1-kotaranov@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-15887-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B2CF4678FE
X-Rspamd-Action: no action

On Fri, Jan 16, 2026 at 01:04:50AM -0800, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Basic implementation of DM allowing to create and register
> DM memory and use its memory keys for networking.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c  |   7 ++
>  drivers/infiniband/hw/mana/mana_ib.h |  12 +++
>  drivers/infiniband/hw/mana/mr.c      | 138 +++++++++++++++++++++++++++
>  include/net/mana/gdma.h              |  47 ++++++++-
>  4 files changed, 201 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
> index bdeddb642..ccc2279ca 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -69,6 +69,12 @@ static const struct ib_device_ops mana_ib_device_stats_ops = {
>  	.alloc_hw_device_stats = mana_ib_alloc_hw_device_stats,
>  };

<...>

> +static int mana_ib_gd_alloc_dm(struct mana_ib_dev *mdev, struct mana_ib_dm *dm,
> +			       struct ib_dm_alloc_attr *attr)
> +{
> +	struct gdma_context *gc = mdev_to_gc(mdev);
> +	struct gdma_alloc_dm_resp resp = {};
> +	struct gdma_alloc_dm_req req = {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, GDMA_ALLOC_DM, sizeof(req), sizeof(resp));
> +	req.length = attr->length;
> +	req.alignment = attr->alignment;
> +	req.flags =  attr->flags;
> +
> +	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> +	if (err || resp.hdr.status) {
> +		ibdev_dbg(&mdev->ib_dev, "Failed to alloc dm err %d, %u", err,
> +			  resp.hdr.status);
> +		if (!err)
> +			err = -EPROTO;
> +
> +		return err;
> +	}
> +
> +	dm->dm_handle = resp.dm_handle;
> +
> +	return 0;
> +}
> +
> +struct ib_dm *mana_ib_alloc_dm(struct ib_device *ibdev,
> +			       struct ib_ucontext *context,
> +			       struct ib_dm_alloc_attr *attr,
> +			       struct uverbs_attr_bundle *attrs)
> +{
> +	struct mana_ib_dev *dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
> +	struct mana_ib_dm *dm;
> +	int err;
> +
> +	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
> +	if (!dm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	err = mana_ib_gd_alloc_dm(dev, dm, attr);
> +	if (err) {
> +		ibdev_dbg(ibdev, "Failed allocate dm memory, %d\n", err);

I intended to apply this patch, but encountered too many minor issues that
needed local fixes.

You already printed debug message when mana_ib_gd_alloc_dm() failed.

> +		goto err_free;
> +	}
> +
> +	return &dm->ibdm;
> +
> +err_free:
> +	kfree(dm);
> +	return ERR_PTR(err);
> +}
> +
> +static int mana_ib_gd_destroy_dm(struct mana_ib_dev *mdev, struct mana_ib_dm *dm)
> +{
> +	struct gdma_context *gc = mdev_to_gc(mdev);
> +	struct gdma_destroy_dm_resp resp = {};
> +	struct gdma_destroy_dm_req req = {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_DM, sizeof(req), sizeof(resp));
> +	req.dm_handle = dm->dm_handle;
> +
> +	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> +	if (err || resp.hdr.status) {
> +		ibdev_dbg(&mdev->ib_dev, "Failed to destroy dm err %d, %u", err,
> +			  resp.hdr.status);
> +		if (!err)
> +			err = -EPROTO;
> +
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +int mana_ib_dealloc_dm(struct ib_dm *ibdm, struct uverbs_attr_bundle *attrs)
> +{
> +	struct mana_ib_dev *dev = container_of(ibdm->device, struct mana_ib_dev, ib_dev);
> +	struct mana_ib_dm *dm = container_of(ibdm, struct mana_ib_dm, ibdm);
> +	int err;
> +
> +	err = mana_ib_gd_destroy_dm(dev, dm);
> +	if (err)
> +		ibdev_dbg(ibdm->device, "Failed destroy dm memory, %d\n", err);

Same error print as for alloc.

In order to simplify things for you: unless you can clearly justify why this
print is required and why you cannot proceed without it, I must ask you to stop
adding any new debug or error messages to the mana_ib driver. There is a wide
range of existing tools and well‑established practices for debugging the kernel,
and none of them require spamming dmesg.

> +	/* Free dm even on HW errors as we do not use the DM anymore.
> +	 * Since DM is a purely HW resource, faulty HW cannot harm the kernel.
> +	 */
> +	kfree(dm);
> +	return err;

You have already freed the DM, so you should return 0 here and make
mana_ib_gd_destroy_dm() return void, as no one uses its return value.

Thanks

