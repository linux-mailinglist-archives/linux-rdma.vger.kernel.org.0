Return-Path: <linux-rdma+bounces-17461-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH3HNN8BqGkRnQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17461-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 10:56:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 565491FDF64
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 10:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBF2530E97CB
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E792396593;
	Wed,  4 Mar 2026 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OegnusqS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77CB3822AC
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617953; cv=none; b=URR0xz/lqQCyGqXJe8AhuTd4vD6J2m90xHi4Uf8N43Itv7AOudBXFw5EOaP8LO/0tkHP5/V6TZ2/6/76qMNRsgZ7gG4/ZSbVGGD9P/9Es3JwI34D6D0Pu6wYtl5aFVDYSn2Hriw4R8fqSwYI3zpKZ9XuCSabNdVi3+dpC/EWy/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617953; c=relaxed/simple;
	bh=q3ayAUUenqkGYyJgA29XrvCrzhaDXES5hDIS2yEOVpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UERU79hoPzoetf//xYrpm3zyd9sSqrL9BZ2N1tKUyCMmhUBA0BCKTLBD2qr3q2xls+6nZUFg/MkaP7peO5eo4jF3zhatOhTiPjgLc+ZJL6//8TcxckPtttaLugrP8hPS2yUgROgHFJ4tnluEwvKmvIGnYGctX5FV1bfkpo2Uajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OegnusqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F6AC19423;
	Wed,  4 Mar 2026 09:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772617953;
	bh=q3ayAUUenqkGYyJgA29XrvCrzhaDXES5hDIS2yEOVpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OegnusqSz2XEd68Io5Df5zVO/Vy9FRENcDeIuQItoB/kcNpG/jMF/5DEyF1Cu7NW6
	 vGHSC3NovqHJCaDxzCpgINwwlSVV0z0Vx7+jzJfDVdiQ/iAt1Kd7nZ4zBtaJPz4DL9
	 CFahRj0yMYGe2tqjpp7f1AKjDuJZPksGTHroOeKfJHkMru6xCPGQekp4l4I9Yrd8Vi
	 myTsi+NxPHlnUvXFw5MqrPECIDU9+rCnevznyzidRV+5iidvn5mjYb8xezdI0nj3NK
	 HsyictCFfVYhhH+icWifEtkOtqGW9cwB/wizc45Cy6q6AJh4rMvpcQbLzoxNkQtObi
	 LPRR3BzqA7jew==
Date: Wed, 4 Mar 2026 11:52:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: usman.ansari@broadcom.com, siva.kallam@broadcom.com, jgg@ziepe.ca,
	kalesh-anakkur.purayil@broadcom.com, vikas.gupta@broadcom.com,
	bhargava.marreddy@broadcom.com, linux-rdma@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH] RDMA/bng_re: Fix CREQ BAR base validity check in
 bng_re_map_creq_db
Message-ID: <20260304095229.GX12611@unreal>
References: <20260227154002.71038-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227154002.71038-1-alok.a.tiwari@oracle.com>
X-Rspamd-Queue-Id: 565491FDF64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17461-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,ziepe.ca,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 07:35:21AM -0800, Alok Tiwari wrote:
> bng_re_map_creq_db() initializes creq_db->reg.bar_id to the fixed BAR
> index used for the CREQ doorbell, then reads the BAR start address via
> pci_resource_start().
> 
> The existing code checked !bar_id, which is not a validity test for the
> PCI resource start. Check !bar_base instead and log an error when the
> BAR start address is 0.
> 
> Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firmware channel")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/infiniband/hw/bng_re/bng_fw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/hw/bng_re/bng_fw.c
> index 17d7cc3aa11d..92e7fa4dcf1a 100644
> --- a/drivers/infiniband/hw/bng_re/bng_fw.c
> +++ b/drivers/infiniband/hw/bng_re/bng_fw.c
> @@ -581,7 +581,7 @@ static int bng_re_map_creq_db(struct bng_re_rcfw *rcfw, u32 reg_offt)
>  	creq_db->dbinfo.flags = 0;
>  	creq_db->reg.bar_id = BNG_FW_COMM_CONS_PCI_BAR_REGION;
>  	creq_db->reg.bar_base = pci_resource_start(pdev, creq_db->reg.bar_id);
> -	if (!creq_db->reg.bar_id)
> +	if (!creq_db->reg.bar_base)

Why is this check needed in the first place? The driver does nothing except
print an error message, which is unlikely to ever occur.

IMHO, you can remove it.

Thanks

>  		dev_err(&pdev->dev,
>  			"CREQ BAR region %d resc start is 0!",
>  			creq_db->reg.bar_id);
> -- 
> 2.50.1
> 

