Return-Path: <linux-rdma+bounces-18943-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLqeDH6TzmkBowYAu9opvQ
	(envelope-from <linux-rdma+bounces-18943-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 18:04:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D1F38B9FD
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 18:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DBA130222FD
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8652BEC3F;
	Thu,  2 Apr 2026 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjGokgI5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903635957
	for <linux-rdma@vger.kernel.org>; Thu,  2 Apr 2026 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145793; cv=none; b=nQknH3Qvitdup1M6qH4hyasr1HCxf0KVCoQHLzhmyfZI8WkdklrS/m3RnzA2TemGPzfRQgkGASoXyWXUXB6r5hZ7iRAN4wPKcOHSTwg7XHuoTMj+I0tjEqh0Ba+DV0HqRwJGiGw1wu9+TMV3vlErBjbYcIc4mZ6wj3TSRxZsKJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145793; c=relaxed/simple;
	bh=Mm2YYx0g/jXisS8cGXfYHq/4evFs6yazjodt1RAx87U=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxmcliHC6EWfCZgl6fseqZe3kuttfJ5YEJxsk1C9SM5sYBRBrEGcFJ6Y67gGhkLIjUUWcXaDYjU17ubn9jhVgdlv6cxTc2BJ5Yu5IRaULN6c1oOO970EX7CYce/oNH8Lygls4n5OCYeRZHCovkr0l/m+WFWca3Pm1KQaJ9R1ZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjGokgI5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b0b260d309so80655ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 02 Apr 2026 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775145792; x=1775750592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pCnmZKRIMS35Lh57vQ/HsyrBXVgqJJZgqbAADUnFMI0=;
        b=hjGokgI5IXt/6SuRLa7SHD4RbV+mPa3nfp31KR3uejijIHOCFRWGRw7Jwtc3jF3hD8
         dKC55fKUxlvYWuaoTpnIv8de9bNTTaZos5cDR2gQ2emPMfU08+pIZ4daJ6uOsKMmGrSc
         JALqQFDLTDBoedinrKq15MzwN2avbwn4ZlGYrcFKBG2O1hYzFbNDKGGz6JDccukpi9VE
         dWzivg1kY9XYNsVPQ0q6hqZefgHJDn0nXo538xKux0Qq/QlyRRK5f5mYlm3XaWtVQHo5
         Kj4EfrKTvQf1zndJPDptxFURlAIv1qyVIUy5QZIrMKhjDwwWASaMURv+uMVHX5H9cLoT
         41JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775145792; x=1775750592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pCnmZKRIMS35Lh57vQ/HsyrBXVgqJJZgqbAADUnFMI0=;
        b=dJdRaeLFst2ARWgtCE5ZOFp4IppPDHifasIQF4Vhx9gcMO29+8uaIoF4PE9njtJ3ES
         KH9CStQhq1bjc1xxnJpuiOsZTTAGSmuA3gLWrmHS7hUBb3HvuS6Sn9nZBdQvDz1dG+NK
         JVHIM71Xl4gHJ8HTdKsP+R4naSfDKRSSLY/QgYIOnk/lmb54Qhr2DgJtGtpJ8bgWOzcp
         2twj9N/Ou3cjQDHl8sT19CTkhPWAgTfrO+NEcJ12Jul0xh/Qsz/ZPsWyP/qkopUD9wDg
         dB0AecuQoJaRKqp4JVZXOrP2DzVnh8zGs1AK9n/+nMq3KWiL0ac8ZEczbz+7OSoAYTvp
         5WdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0wYeKENhrY1mYuVkjwI94R2hj/fAgjgXP2sTYhvQ3nTo53sv3BVm0eD0s6npj25nD55uSIfM2Nk2n@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6lynN+NxrVrevwnDfgRQmacMDLxycE8HioLKoV2mrSqxN3m/V
	ERk12Szje9zM4QkoMDm5xR99LBNDYRsiUYRu8q2Bxw8NrEFC2LNFbWb6yZZkfXF6yA==
X-Gm-Gg: AeBDiev8WfYdHZwzt3mE6GPH43rQsCTDPXVws3doGbPfMhywTsUgaJCEpSpD+pmEUKb
	AhddYq/YJZESaG86o5KLijK1RcdzNj73z9UrrEVy5RJf4SquyhSMYNDE70UIkwxBTibeuI+QidP
	D3g26CsoUrazyctpzM5gbhDYbviNPiYlu4YtlNyoJhxfbaYubdLfBkjDCDJ7Ar+H3hdupG3Xwej
	Zr9I8S4Zuwwg3yL3cW12YxVemACoh41smOmlt70b9R0olJjfAdGCUa04hV3Xx15OhFKZHCghuNF
	Telv/p9VjtkfJ5crMCb1auNG6GaCpxWH0K9UH+K2Dt8M9xNH1hpUdUIEKYiaPUQg/ZUooCRqaM9
	NAIkw6GDZeBJvcWiqUSghl0iOWepHxEqwYB4O1P5/nlqJntSUdLvlfOWXH3GLkHTlh69Md8okvX
	llBjIMoOyDVBB+tZSHN0ZOyCei0tfatoLc9wUDdo32Dyp6z5iy1bTPqv4tjQ==
X-Received: by 2002:a17:902:db04:b0:2b2:4a2e:5dd5 with SMTP id d9443c01a7336-2b278424fa6mr2381835ad.3.1775145791219;
        Thu, 02 Apr 2026 09:03:11 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm11237137a91.10.2026.04.02.09.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:03:10 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:03:04 +0000
From: Pranjal Shrivastava <praan@google.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kch@nvidia.com
Subject: Re: [RFC PATCH v2] nvme: enable PCI P2PDMA support for RDMA transport
Message-ID: <ac6TOJMXtmBzNL_X@google.com>
References: <20260402073001.2039625-1-shivajikant@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402073001.2039625-1-shivajikant@google.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18943-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1D1F38B9FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 07:30:01AM +0000, Shivaji Kant wrote:
> Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
> RDMA controller supports it.
> 
> This patch depends on the PCI P2PDMA support added in this
> patch [1].
> 
> Suggested-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Shivaji Kant <shivajikant@google.com>
> ---
> [1] https://lore.kernel.org/all/20260323234416.46944-3-kch@nvidia.com/
> ---
>  drivers/nvme/host/rdma.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 35c0822edb2d..09eefd7c3ff4 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2189,6 +2189,13 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
>  	nvme_rdma_reconnect_or_remove(ctrl, ret);
>  }
>  
> +static bool nvme_rdma_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_rdma_ctrl *r_ctrl = to_rdma_ctrl(ctrl);
> +
> +	return ib_dma_pci_p2p_dma_supported(r_ctrl->device->dev);
> +}
> +
>  static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
>  	.name			= "rdma",
>  	.module			= THIS_MODULE,
> @@ -2203,6 +2210,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
>  	.get_address		= nvmf_get_address,
>  	.stop_ctrl		= nvme_rdma_stop_ctrl,
>  	.get_virt_boundary	= nvme_get_virt_boundary,
> +	.supports_pci_p2pdma	= nvme_rdma_supports_pci_p2pdma,
>  };
>  

+Chaitanya.

Hi Chaitanya, would you like to pick this up with your v2 for the
multipath p2p enablement series [1] ?

For the changes (with Chaitanya's mpath patch):
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

[1] https://lore.kernel.org/all/20260323234416.46944-3-kch@nvidia.com/

