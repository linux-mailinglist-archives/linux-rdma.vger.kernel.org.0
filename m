Return-Path: <linux-rdma+bounces-21401-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN8sD9pZF2oPBQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21401-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 22:53:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D02005EA3BE
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 22:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 991DD3009087
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 20:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A043BFE52;
	Wed, 27 May 2026 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="RNYOFR4v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SYR/FQvF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24BD313520;
	Wed, 27 May 2026 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915220; cv=none; b=LBbLmP851AbhKwSIyFRhDy0cst41VU975YUOqAKUqBc9lA5samH5KawKEjwWaYqNgsFVHDU+I00HuKJfBHUDdVoBEc90hDXkDeA2dimdwI860izm8PF1i9ONFfB/vS0sEiJuVE9ppbSI68/cEEGSr/3hegdnaijLtCyeG6SsP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915220; c=relaxed/simple;
	bh=4YfWInZ9CLb2AOWifcQm5snj/1dxglE9jo08vZEeOVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYVnDN2MmYURVCbiheNB0bjaUaZih8Ltu3kzjIMdTKhbhc3WHkEeqbk1WGcqwB59+1GSlSLFwsRFiR7L70l2ER3s0sDW3X+rLNr7+vcHedYWP/zqLTM9eBN3aT0kARQvC0tOufE6C/zcGyE62dciUR3FzUHKVo2F7MJri1tvmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=RNYOFR4v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SYR/FQvF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A26A0EC0077;
	Wed, 27 May 2026 16:53:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 27 May 2026 16:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779915215;
	 x=1780001615; bh=TzsAIWJKWxLMYgzdxaWg1KgQLd4L0BjlB8TYvo0b3Wo=; b=
	RNYOFR4v5bWL/PM5DIyXR4qJ7Z6D92QH4Cy3LppgJ2E10MJO0PuwTaB/1ZS4mPXs
	HCy0NsxoHbYMZFe3VwIxnIk7UalNGjMCyXkVRadKJ/QJRllBlcvLK0US9bDnRRwH
	6klEt3FAKvTL2P4spELYW/PugDCje8LL0Ak2B8lpWgrlMieFy0qqty5mthOK6YVr
	Rhf9Iewhj29R21KaCbpTOdDzjPQiJ0CmO+Rk7JOctajA/BmSBddG/tAdkJT5GGtW
	zBuDNHNOx3392bRIFbVn1Ult5hkbN35Ha4jR+7jPRHGfTjrPROxBLy/cGuNVSNd3
	ViIUKxEjTTS2UcxD0OILWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779915215; x=
	1780001615; bh=TzsAIWJKWxLMYgzdxaWg1KgQLd4L0BjlB8TYvo0b3Wo=; b=S
	YR/FQvFC4ejpPKA5OBsG13goMswKVWLYt6j6dBBPa74VeBdvIyoCVVHp1jCXiqIU
	07UC5auhDx18L36o7Zewh5c80pfPFKlgetlVnNkUbmTCcPGme4t6P2IrLyA3FYl1
	2nYaYTArJB2lHcUyoxswLCD9xVmvtAiYlF2pFMU6So7MkExYpS+C+rzrlorO0HIl
	jBiU6PuyZz+kIvrGRvD213X+hEG3/+Rg7HED7lIYZvRy7Gjz8NdPcJ4wYfnRIUlS
	fw2ts1qxs9BqHIwWUkgLiWw72+YfKObWsWa7EzK6/QVHc3wQUozvmjRXvnBdLVNX
	seAoShWn6kLhUu2+63EhQ==
X-ME-Sender: <xms:z1kXamIPytd-cXsTONJm-Aj97UNRY8erds7YIJI34uyND3oBSi-Z4g>
    <xme:z1kXaltoxOt0GRjv_2UhRNeWXGOr9itEAPa_TWXD4vrODN9l-pRVdYFbvyClNSOc2
    GPZWW5WX3-vmnTuTB94M_xbapRKUN0E3HboovE7EYH_6QzzUvDDZg>
X-ME-Received: <xmr:z1kXamU78RBBOF3LItIWluXvjTR0m2VhE8TZFi-BcVnUEXTlyLXxbu9UCZA>
X-ME-Proxy-Cause: dmFkZTF1K9viltT52o4ie7G6CQKxrNMh36y//trnUnjN2k5DDgIcr7l1e0mhd521pVUDS/
    uUGjEBHMKe4uB8HMHx4OURBWT7vcgWNK/HbH2TS03Hxbg5FeReRt7to9/tAI+ydT7I1l89
    uhh7qF0gDk2T40TaUxMNHZxuF+GSXmiNNkylKLwO+IpzgNQ4v74oMtPuQDE3B0Xiy58k/H
    OdJyMun/gxHDWJd4SGLl8Pb+k54CNl+UmtkuZYH5bsrFwFICfdDCJITm++6BzDRZXY9DKa
    O8KAQIwlIxQ9/B+BwQfavF8kkeajVFD2pGqmPEYauMUdU+iLblknNkg8eCzti1XGaihJVh
    qVoc+YvwS0sBtLpk5V9sfF412d0n5bBVYaDlaUJ5lgZULolELwh4cY5u+BDy6Xjz92ZTQS
    dKE81COvd/li6hW7NzXrkCXp91IpDu7+2BgrEgE3Zh8JU6ezDH5h+sMjmvg/x7QvHfxIne
    lDFoJF/TIt1qrWIKqoxk5000z2TjniOuWIRbKYzld7HeHhtoTa7+acr6e0auCJQRsK+tnW
    Tlu41x61PoLJ2LbQGxryv42A/1+Mnbsx6dlJNiQ5ZutWsX43E5IDzh+73DxHGwzuwVnJLu
    qICs6bhUv4aZw/7QiJNSkhBaWYhcMLlgqC3xyqr3DgShx8Jfvzey4VBaL0zg
X-ME-Proxy: <xmx:z1kXaoJn4vy4awOhNB-9NU295v8QIWTpScmh081UN1PvO8WAuPNszA>
    <xmx:z1kXaj9mjlGWSi9WlnN52HuUcbRJ0U3AjtMA6XsHuhhdoMeuUEryYA>
    <xmx:z1kXauNgGG1dViSVnY4M55iBNlOuBJ70jXTrL4WK4i9NlB3auC950Q>
    <xmx:z1kXan1Orfv6sdp6Dbaq5FokGcKR6AgKbOBN6YPa_wJKAhs29pTzjw>
    <xmx:z1kXag0SGdBPokUwULyB2T-XuxcA1UGmGMn0kcLsKDgBKz-bZMCPSAt_>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 16:53:33 -0400 (EDT)
Date: Wed, 27 May 2026 14:53:32 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian Konig
 <christian.koenig@amd.com>, Bjorn Helgaas <helgaas@kernel.org>,
 <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>, Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 alex@shazbot.org
Subject: Re: [PATCH v5 1/4] PCI/TPH: expose the enabled TPH requester type
Message-ID: <20260527145332.30412ea4@shazbot.org>
In-Reply-To: <20260526144401.1485788-2-zhipingz@meta.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
	<20260526144401.1485788-2-zhipingz@meta.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-21401-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,shazbot.org:mid,shazbot.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D02005EA3BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 07:43:53 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:

> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> requester mode without reaching into pci_dev internals.
> 
> This keeps pci_dev::tph_req_type inside the PCI/TPH code and provides a
> !CONFIG_PCIE_TPH stub for callers.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/pci/tph.c       | 12 ++++++++++++
>  include/linux/pci-tph.h |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 91145e8d9d95..6c4492075ae9 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
>  
> +/**
> + * pcie_tph_enabled_req_type - Return the device's enabled TPH requester type
> + * @pdev: PCI device to query
> + *
> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_TPH.
> + */
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> +{
> +	return pdev->tph_req_type;
> +}
> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> +
>  /*
>   * Return the size of ST table. If ST table is not in TPH Requester Extended
>   * Capability space, return 0. Otherwise return the ST Table Size + 1.
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index be68cd17f2f8..fe572737b409 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
>  #else
>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>  					unsigned int index, u16 tag)
> @@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  { return -EINVAL; }
> +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { return 0; }

nit, s/0/PCI_TPH_REQ_DISABLE/ for consistency.  Thanks,

Alex



