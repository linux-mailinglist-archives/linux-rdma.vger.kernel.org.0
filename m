Return-Path: <linux-rdma+bounces-17397-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFnUMXflpWlLHwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17397-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 20:31:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2391DED5A
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 20:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C17EC304023C
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 19:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1F947D93B;
	Mon,  2 Mar 2026 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdXib4Jd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B072E093A;
	Mon,  2 Mar 2026 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479861; cv=none; b=mHCbVKBomjmlBfver23Lr5QE3UAgSF1h74flr+kk65HnI3rce7Yhv5GOSneX9e9skX1mItF3sd7PKyQ3HdnKo5C4KKWO6HNxJISAsM1R3rcOuvbhg6Hwrt+Yj2qZSYy+RV6U5RJzwjrxtl3BhmMqmYJQ1TtTFkbOWxrsHR5XBdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479861; c=relaxed/simple;
	bh=UaxCx6pLegsl1qn8O7A155htJD0jzBecFsM9ZsY1tQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDEJ0KjXgW8RCyknPHz0DWJdk5jxc1fHKzhPSdlG5gA2IMNjw2087WxM4Aa3mCZORe7Tykgm8nLsf9IKeU9FoW9SSCeBx5du1HLqT6pnc3SjIop2040EGiWOlK95ivZ4VpWCQdHcwWuiEdaqtlnSEZI+kA645PNvWQ1NFQrJFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdXib4Jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01095C19423;
	Mon,  2 Mar 2026 19:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772479860;
	bh=UaxCx6pLegsl1qn8O7A155htJD0jzBecFsM9ZsY1tQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdXib4JdvRooOA1VuZB2Fv9NF/jyQCfGKZhS2f4iED4SJlw4ZzjoOtePsLM5mxTyU
	 bO2LvkHRZrlurN7pPVnLG3VXqE+mp/l9mxyEFrIO74ek0M7TkAnNALE2L8mp/gPh3x
	 /Fab1YnCkJnCQZkCx5tgGSYw9jgSKVNde/eCBqRqnbw1KNm4SCzHgOZGAiIQ+D5llL
	 P6hTiViYaYjhSuLlehyIMit3EB8hPMZY4JGbd8n1oACAlABlb0Q9XLXyC4SK3QPTQY
	 26p9thyhTGXIUEQqDGRlqcD5Tf9W9KMkMqDGNC3W4NIi0akPcYdScvcOG5Kp8OtEs1
	 jZcRA98AUsZ/g==
Date: Mon, 2 Mar 2026 21:30:56 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 02/13] RDMA/core: Add rdma_udata_to_dev()
Message-ID: <20260302193056.GT12611@unreal>
References: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
 <2-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
X-Rspamd-Queue-Id: 0B2391DED5A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17397-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 09:11:05PM -0400, Jason Gunthorpe wrote:
> Get an ib_device out of a udata so it can be used for debug prints.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/ib_core_uverbs.c | 27 ++++++++++++++++++++++++
>  include/rdma/uverbs_ioctl.h              |  2 ++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
> index d3836a62a00495..bfe37a9c8a72bf 100644
> --- a/drivers/infiniband/core/ib_core_uverbs.c
> +++ b/drivers/infiniband/core/ib_core_uverbs.c
> @@ -389,3 +389,30 @@ int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
>  						 U32_MAX);
>  }
>  EXPORT_SYMBOL(rdma_user_mmap_entry_insert);
> +
> +/**
> + * rdma_udata_to_dev - Get a ib_device from a udata
> + * @udata: The system calls ib_udata struct
> + *
> + * The struct ib_device that is handling the uverbs call. Must not be called if
> + * udata is NULL. The result can be NULL.
> + */
> +struct ib_device *rdma_udata_to_dev(struct ib_udata *udata)
> +{
> +	struct uverbs_attr_bundle *bundle =
> +		rdma_udata_to_uverbs_attr_bundle(udata);
> +
> +	lockdep_assert_held(&bundle->ufile->device->disassociate_srcu);
> +
> +	if (bundle->context)
> +		return bundle->context->device;
> +
> +	/*
> +	 * If the context hasn't been created yet use the ufile's dev, but it
> +	 * might be NULL if we are racing with disassociate.
> +	 */
> +	return srcu_dereference(bundle->ufile->device->ib_dev,
> +				&bundle->ufile->device->disassociate_srcu);
> +}
> +EXPORT_SYMBOL(rdma_udata_to_dev);

Thanks for this function, looks great, however I wonder about use of it
in debug prints. What about changing:

+       ibdev_dbg(
+               rdma_udata_to_dev(udata),
...

to be something
+       udata_dbg(
+               udata,
....

Together with keeping this rdma_udata_to_dev() function.

Thanks

