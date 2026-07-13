Return-Path: <linux-rdma+bounces-23109-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aEeXBXSwVGolpgMAu9opvQ
	(envelope-from <linux-rdma+bounces-23109-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 11:31:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6A9749554
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 11:31:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FVHzMCd+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23109-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23109-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2196B300CC39
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 09:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CC73E2752;
	Mon, 13 Jul 2026 09:31:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCDB3E2740
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 09:31:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935088; cv=none; b=BPo8zjs+Z5DaZz/WhtoZPVljSYHPw3ao9IlzKRH81MD2sQhWucoTJyRegfaKVUEal6jNCN0EEy/+q9PB0UCD+lLF2CMFaDmMY1SCbet+Xb8a8Dk7cX0WcIDpGaEvPFT5tmJ3YLTp8CgJWWP1zwM2oG2xjamxJKv/DZWgD5PWnTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935088; c=relaxed/simple;
	bh=2aXTKaBMNIUe9nPsA0eXQfctdexrBZnHwxDTgwQzm2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdQnTIQe+u+s1QdoW3xJpq0XJi385fcAmQcteYVXCiF4XhbKGz2cpnT0RxM4SBctwTFFA2cgzWidGo/Oad9AeF1lYQ4JMc23I32FmMVTv4dxLCa1Ttk+VO0krTtCcyiHwaXmGfr6yQQqAZOK4nJ4CVzHaCZQSxJI5yyJ3mVFIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVHzMCd+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436151F000E9;
	Mon, 13 Jul 2026 09:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783935085;
	bh=j87FAVdL8QX8CLGBOOpgMD1rrilY5IgwAcNAUG7qJbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FVHzMCd+qv8L/nG+eeHR0ThTbWjK8m8nG1w26DsGC+7jjqiu2PCOW2FkoP6W9Mu4R
	 K9YdNGfl/IdR3Q4ut9BcRNoGCEycMf9recCIxxLSX0ZtJD2kuSkvmndE0K6MMrglbc
	 kqeH6oBG4v7nmPwyHAGoM5euYR7lVLh7yjsXTIFEy53hHCJ88IK1FzPNFvqF0bWy3T
	 QFue46Q/iw7Ac6j8oI0qayfmfjqL5MWkLrGXZglF+WpS3/CdXnhv7P6BAlMrGz8p2n
	 txGJYYy4/2muOyRvckBaYoo+FcDKQFZJQfBTjRz+TUXTaguuhu4NI7H8coaOqoK1aq
	 yB5zx3gLQWDMA==
Date: Mon, 13 Jul 2026 12:31:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Michael Margolin <mrgolin@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next 1/2] RDMA/efa: Extend page-shift field in MR
 registration
Message-ID: <20260713093118.GK33197@unreal>
References: <20260712134413.19226-1-mrgolin@amazon.com>
 <20260712134413.19226-2-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712134413.19226-2-mrgolin@amazon.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mrgolin@amazon.com,m:jgg@nvidia.com,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23109-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,unreal:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B6A9749554

On Sun, Jul 12, 2026 at 01:44:12PM +0000, Michael Margolin wrote:
> Update device interface adding one more bit from reserved to enable
> >4GB page sizes that can be supported on 0xefa4 devices.
> 
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> index 826790ca9d83..3eb3a4de8912 100644
> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> @@ -367,10 +367,10 @@ struct efa_admin_reg_mr_cmd {
>  
>  	/*
>  	 * flags and page size
> -	 * 4:0 : phys_page_size_shift - page size is (1 <<
> +	 * 5:0 : phys_page_size_shift - page size is (1 <<
>  	 *    phys_page_size_shift). Page size is used for
>  	 *    building the Virtual to Physical address mapping
> -	 * 6:5 : reserved - MBZ
> +	 * 6 : reserved - MBZ
>  	 * 7 : mem_addr_phy_mode_en - Enable bit for physical
>  	 *    memory registration (no translation), can be used
>  	 *    only by privileged clients. If set, PBL must
> @@ -1103,7 +1103,7 @@ struct efa_admin_host_info {
>  #define EFA_ADMIN_MODIFY_QP_CMD_RNR_RETRY_MASK              BIT(5)
>  
>  /* reg_mr_cmd */
> -#define EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_MASK      GENMASK(4, 0)
> +#define EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_MASK      GENMASK(5, 0)

How will the new kernel behave on non-0xefa4 devices? The new
kernel sets one additional bit that these devices do not expect.

Thanks

