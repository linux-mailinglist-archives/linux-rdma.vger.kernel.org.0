Return-Path: <linux-rdma+bounces-19253-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKjREgWV22mxDgkAu9opvQ
	(envelope-from <linux-rdma+bounces-19253-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 14:50:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A5A3E3D80
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 14:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35EFC30022C1
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 12:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92A71B4F2C;
	Sun, 12 Apr 2026 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVJiijhl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA25376492;
	Sun, 12 Apr 2026 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775998210; cv=none; b=bcRUlnhOy7JYwKiikZV1tMyUnUVUFJKpaCfMCDWUdd4hPJOAirSTRBQ269Oon1IOv0NZOcOH7+BJHAk277clrDNLUyf+z3Vd4qx3K8tMgBNODXw9RSGiwzN73sPEzdQ+eXWOjjxXo4JlD99NISwg6/Lg4Wu0CWy9GmNcme3oF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775998210; c=relaxed/simple;
	bh=UctMIAZJjUIkI9bcFxFVqtMglx8Sn3GMHxD5PPywcD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1t5y2Y2bW5LIKzoTi5CZjRLkpnKimsmW597qQu5n+9xgcJjKIGfDfYNkrhxoTeqSJfzexc1ECMTpVjGM2m/1gx+1i3RpbMO7RRqFTSzgG/jD6ROtNBeQ8P+J7q5OrNFQ0JxEe6DbZIU1P5FyNNz4fkIz2j8fsHnt3bUSp5TYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVJiijhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995D9C19424;
	Sun, 12 Apr 2026 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775998210;
	bh=UctMIAZJjUIkI9bcFxFVqtMglx8Sn3GMHxD5PPywcD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVJiijhlBb3b8995eHFh0+LVGq4XGVZVjQr+WlYMF2XHwIMkfeyzE1ylwx2du7s9v
	 IVuHUNJEXwMOglYKE4m7UXDTd0cIbAlMuua0PKRlxdKNa/2Fzov2d45VdcP3Ki7M0n
	 S318Ec8ZJFEXPRi8827HjMzU3Oc84wBf6cjbHvVasuFH1z3wizT1xmsuq9VvrBpvtQ
	 IPjCGILrRAw6lWAcxZCcLH0QxoUyd47L8cTPXjN0VZfP8+smpznmtFaX0lAbj3+BiK
	 7iQM793FIGhpkTIYwn73xzpWJFRjOr/9na/QJtgUxwIbClhcbSwKPjGmzebdOhrPNW
	 XZw+6AUJ09vGw==
Date: Sun, 12 Apr 2026 15:50:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Xi Wang <wangxi11@huawei.com>,
	Weihang Li <liweihang@huawei.com>, Wei Xu <xuwei5@hisilicon.com>,
	Shengming Shu <shushengming1@huawei.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: fix out-of-bounds write in IRQ array during
 configuration
Message-ID: <20260412125005.GB21470@unreal>
References: <SYBPR01MB7881512F49EA80F0146EEEA1AF5CA@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881512F49EA80F0146EEEA1AF5CA@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19253-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,hisilicon.com,ziepe.ca,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28A5A3E3D80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 04:15:44PM +0800, Junrui Luo wrote:
> hns_roce_hw_v2_get_cfg() writes IRQ vector numbers into hr_dev->irq[]
> using handle->rinfo.num_vectors as the loop bound. num_vectors originates
> from firmware via hclge_query_pf_resource() without validation against
> the array size.
> 
> If firmware reports more than 128 MSI-X vectors for RoCE, the loop
> overflows hr_dev->irq[], corrupting adjacent struct members in the
> heap-allocated hns_roce_dev structure.

Is this an actual issue, or just another imagined problem?

Thanks

