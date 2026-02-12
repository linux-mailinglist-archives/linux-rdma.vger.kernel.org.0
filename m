Return-Path: <linux-rdma+bounces-16790-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKdqMOEGjmkT+wAAu9opvQ
	(envelope-from <linux-rdma+bounces-16790-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 17:59:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CC212FBC9
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 17:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3BF9305C8F4
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 16:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7235D60B;
	Thu, 12 Feb 2026 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8YUzu3b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F0776025
	for <linux-rdma@vger.kernel.org>; Thu, 12 Feb 2026 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770915313; cv=none; b=AiwUIK+VMWsoZBLAlDRPxRg4nZCjLAgK1ul+pSOe41dYRD6Tw1VEH28OrKgETeXzY7gzMlZ3+1atkCO7lmMDc+3Jil3Fv8MCc0KZ+fBYcsCDzgMMq5HLqPnTL0r0snhyvUqD+gcBurovDLMDEZTaWWXITqJB/TPrXUQr8zSE+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770915313; c=relaxed/simple;
	bh=9r5zFrQosL0yVB0rrp+iVbkJ5U6f4/67mywIMS3MDkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFKJAqItjpzWTeXpMgelp1IHy703HjpxVNo561BnhZalfjC1SEi7XZCYRQn1iiGC12sfxSOjS+ha0A3mrs3rIegb790impVpC/6dwoF4brskUWYuFIb/CtyLeg1wonOssd4P6xP9GePYfcfJb0I0N5hm6IxaehbYrlx7Fo029XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8YUzu3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636DDC4CEF7;
	Thu, 12 Feb 2026 16:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770915312;
	bh=9r5zFrQosL0yVB0rrp+iVbkJ5U6f4/67mywIMS3MDkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8YUzu3bosMh9kTxUc826nYvD5nb3zooOBumDKxyTM+YwfsBIOshbyyb3VJtbQfRD
	 hJ6CYAY8YEJ4HFSFZG4i0TvzOSEQ6I0nVbATlQNvWsRIuOApUsBvXivVzBNioWLfDf
	 d/+Xh6IktrzWc8YG2XkLRIB40icsMKiorZUQoZVmRMN0IsrjarLjAZWDFs00S/Jyy5
	 rdfEIhGyb7uvTiuEPYIFHVQ5m/ZslkJEClDQ5gs92FE5Q/Ew354yHogeJxzVH8Waxs
	 R01RDo4HmqMJJnT1s1omG3TjjI/ewzfXItnlWgEDzYOCMz4vje+uZzy7fZXhe6Dvy+
	 Xkd9RNb6ngesA==
Date: Thu, 12 Feb 2026 18:55:07 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 2/3] RDMA/hns: Add write support to debugfs
Message-ID: <20260212165507.GH12887@unreal>
References: <20260206103110.3414311-1-huangjunxian6@hisilicon.com>
 <20260206103110.3414311-3-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206103110.3414311-3-huangjunxian6@hisilicon.com>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16790-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hisilicon.com:email]
X-Rspamd-Queue-Id: 22CC212FBC9
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 06:31:09PM +0800, Junxian Huang wrote:
> Add write support to debugfs.
> 
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_debugfs.c | 38 +++++++++++++++++---
>  drivers/infiniband/hw/hns/hns_roce_debugfs.h |  1 +
>  2 files changed, 35 insertions(+), 4 deletions(-)

<...>

>  static const struct file_operations hns_debugfs_seqfile_fops = {
>  	.owner = THIS_MODULE,
>  	.open = hns_debugfs_seqfile_open,
>  	.release = single_release,
>  	.read = seq_read,
> +	.write = hns_debugfs_seqfile_write,
>  	.llseek = seq_lseek
>  };
>  

<...>

> -	debugfs_create_file(name, 0400, parent, seq, &hns_debugfs_seqfile_fops);
> +	debugfs_create_file(name, ops->write ? 0600 : 0400, parent,
> +			    seq, &hns_debugfs_seqfile_fops);

What is this "ops->write ?" check? You added write callback in this
exactly patch. It is always true.

Thanks

