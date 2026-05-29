Return-Path: <linux-rdma+bounces-21519-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOupDyzFGWoIzAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21519-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 18:56:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD3B60602F
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 18:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89D9533A263C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 16:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D41F2E8B67;
	Fri, 29 May 2026 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPiZKmOr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28158280A56;
	Fri, 29 May 2026 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070958; cv=none; b=stI/TRzF6Hy1fCX7uDaYMWxt9dsfvhWEU98VzrjVumdeI35g8aXmbAt5jELG7zFVYrc9LDbwVoiMc0/Mpenc9l6DeoH14zTWN8Nd/3uMQYPBIMWduku4YPxyWPsKniSOFDiaGyegD3DTcw2KCa1fTEh45dMAGbWyPvs86qJz5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070958; c=relaxed/simple;
	bh=oBrYq3NPOTsafZxLmGqel4H4r0MtIgCWzquM8e4pLNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlmOXq4iN2rWPZP+JsJNGSYPOraYETvOSoWEMz1xrxF6ZncDKLl1ozSbX9+vahTTxYtBTr4UbfAN/D9gw2VLCDZi0ha/PUXazSOYNAswZASM+p/JLElt/KUBGELx3l3J47e7yDhDUCqrlPsNf7oId7GNUITdzNcz4T/huljH/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPiZKmOr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780631F00893;
	Fri, 29 May 2026 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780070956;
	bh=jxl9Cd1ekcjiytj6Bw9vuKytspEwY89flUAtcmDugAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mPiZKmOrsXkaUctu8xLtcMIMerVGh5L/JbNZT2E32PEowB7APOvhQ8Q2Hl9fU9CAy
	 S50d12OD3vgSmWXKW9kqsOGTsjjSObfQLsiyZ9pRtfEtpK8OEk9MpGqYMZo0VF4fvC
	 hMrX5veA7TrrclNKe6ki+lndFKOqAyl42T/5eLnyYxNC1gcnBU+tuS7UaX76ybHtT4
	 hPf9lwIj/Yk+Vm/IIAIOchlyyWVzc0NRKG5SW66k2wzjkU6jDixq58O1H0fl7l7nie
	 Yv6vsPOWFzO6EjIicSkH0xGnJAUfI1l0BZhIXBeTaBjPgv48CLyc/oVEAXKSnOUQhS
	 TOtOOOFktGz0Q==
Date: Fri, 29 May 2026 10:09:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: hexlabsecurity@proton.me
Cc: "security@kernel.org" <security@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"kch@nvidia.com" <kch@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [REPORT] nvmet-rdma: integer overflow in inline-data SGL bounds
 check -> pre-auth kernel-memory read + remote crash (candidate patch inline)
Message-ID: <ahm6Ksr3rfGdnOsN@kbusch-mbp>
References: <LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21519-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:email]
X-Rspamd-Queue-Id: 9FD3B60602F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 06:52:13AM +0000, hexlabsecurity@proton.me wrote:
> @@ -847,6 +848,7 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
>  	struct nvme_sgl_desc *sgl = &rsp->req.cmd->common.dptr.sgl;
>  	u64 off = le64_to_cpu(sgl->addr);
>  	u32 len = le32_to_cpu(sgl->length);
> +	u64 bound;
> 
>  	if (!nvme_is_write(rsp->req.cmd)) {
>  		rsp->req.error_loc =
> @@ -854,7 +856,8 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
>  		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>  	}
> 
> -	if (off + len > rsp->queue->dev->inline_data_size) {
> +	if (check_add_overflow(off, (u64)len, &bound) ||
> +	    bound > rsp->queue->dev->inline_data_size) {

Since you don't use "bound" for anything other than the final check, I
think we make this simpler without it:

	if (off > rsp->queue->dev->inline_data_size ||
	    len > rsp->queue->dev->inline_data_size - off) {

Thanks for the report.

