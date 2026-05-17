Return-Path: <linux-rdma+bounces-20831-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cADdAlaZCWqqhAQAu9opvQ
	(envelope-from <linux-rdma+bounces-20831-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 12:32:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B985607C6
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 12:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD0CA300A505
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3431C32C94A;
	Sun, 17 May 2026 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTUeFww/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A71B808
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779013966; cv=none; b=itDRsppUhfxsDdOlRaVFHXQ8fS1ueJ2Lu1oQ/Wy/XVWFCfgVMDPNCBR50s3NglGYPq53dmvUlHFlD9FDaCnKpXU6mtFrc+FlTiLEwW0L1GjO/WPcE6/i+bg+wtv1tXbchGIdptbqP7wTYOM+8AZljR7sidjhQSqXfvHc+hkIR/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779013966; c=relaxed/simple;
	bh=i++zmOlgyIRhxzXRAzGDA9Q2mB3jYD25F/SLIHLTYzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4x3zdo4AVY08JZwmIvtDUt2r7wrYAQE9+6aopTuosw/v6X+euJodogwbltjAlgTkXFncwdtnKwckExD2eHr3e8IItPvXhZkIjM+yocW7qjNtqsM/8ZF3wv4DIct7fMb2ORydpZq4ZMJ+XXm8l3DBKclh43F5VDIfl/AmarouI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTUeFww/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CF6C2BCB0;
	Sun, 17 May 2026 10:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779013965;
	bh=i++zmOlgyIRhxzXRAzGDA9Q2mB3jYD25F/SLIHLTYzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZTUeFww/lrQ5QtTzY6gUEBwFStt1PR3M5dsetdA10v/lppCnFTchczp9ctUTJnLcU
	 I8i3pjYzNx3/QFtmiu8x/jGZVU6jpGJCDDHyWnWvSmz/CPUgGsBf6nWu884MOzuUGj
	 0qtUuUOaCUU6N4JkZXkhD86jcIYAF8l6EGT1rKi/Vu3EILI/aKvxY5mg2WDiO1Ljwr
	 U6MBAUnoZRmJmVlU6+vODbKld6nT8AHKFheBCghDlcMV1XNBQ/LjVnnHLoMRe8nY1n
	 XO8xftZ3IYuIsi9cuN1m8+r1A4KksiSxFMWlv8UZqZ9M8MGUrB+ggQ82tqNg1VOd+B
	 OeqONEpMU06Ow==
Date: Sun, 17 May 2026 13:32:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <kees@kernel.org>,
	Etienne AUJAMES <eaujames@ddn.com>,
	zhenwei pi <zhenwei.pi@linux.dev>, Jiri Pirko <jiri@resnulli.us>,
	Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/cache: Check GID table references before attempting
 deletion
Message-ID: <20260517103240.GC33515@unreal>
References: <20260513080707.3929955-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513080707.3929955-1-zhaochenguang@kylinos.cn>
X-Rspamd-Queue-Id: A5B985607C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20831-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 04:07:07PM +0800, Chenguang Zhao wrote:
> In the NFS over RDMA environment, repeatedly performing frequent
> ifdown/ifup operations on the client may cause df -h to hang.
> The kernel log reports an error:
>   __ib_cache_gid_add: unable to add gid
>   0000:0000:0000:0000:0000:ffff:c0a8:0115 error=-28.
> Error code -28 indicates the GID table is full.
> The call stack during ifdown is as follows:
>   put_gid_entry_locked()
>   del_gid()
>   _ib_cache_gid_del()
>   update_gid()
>   update_gid_event_work_handler()
> 
> In put_gid_entry_locked(), kref_put(&entry->kref) does not
> drop the reference count to zero.

Why?

> so free_gid_entry() is never invoked to release the entry. Subsequent ifup
> attempts keep adding new entries into the GID table,
> eventually exhausting the table capacity.

This behavior is not what we expect from the IB/cache layer.

Thanks

> 
> To fix this, check whether the GID entry still has
> outstanding references in del_gid(), and only remove
> and release the entry when no other references remain.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  drivers/infiniband/core/cache.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 647a547e2d7f..c71522fbf89f 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -596,6 +596,34 @@ int ib_cache_gid_add(struct ib_device *ib_dev, u32 port,
>  	return __ib_cache_gid_add(ib_dev, port, gid, attr, mask, false);
>  }
>  
> +/**
> + * gid_table_is_shared - Check if GID table has other reference owners
> + * @table: GID table to check
> + * @ix: index of entry
> + *
> + * Returns true if the gid table refcount is greater than 1,
> + */
> +static bool gid_table_is_shared(struct ib_gid_table *table, int ix)
> +{
> +	unsigned int refcount;
> +	struct ib_gid_table_entry *entry;
> +
> +	write_lock_irq(&table->rwlock);
> +
> +	entry = table->data_vec[ix];
> +	refcount = kref_read(&entry->kref);
> +
> +	write_unlock_irq(&table->rwlock);
> +
> +	if (refcount > 1) {
> +		pr_debug("%s: The GID table is still referenced and cannot be deleted.\n",
> +			__func__);
> +		return true;
> +	} else {
> +		return false;
> +	}
> +}
> +
>  static int
>  _ib_cache_gid_del(struct ib_device *ib_dev, u32 port,
>  		  union ib_gid *gid, struct ib_gid_attr *attr,
> @@ -615,6 +643,9 @@ _ib_cache_gid_del(struct ib_device *ib_dev, u32 port,
>  		goto out_unlock;
>  	}
>  
> +	if (gid_table_is_shared(table, ix))
> +		goto out_unlock;
> +
>  	del_gid(ib_dev, port, table, ix);
>  	dispatch_gid_change_event(ib_dev, port);
>  
> -- 
> 2.25.1
> 
> 

