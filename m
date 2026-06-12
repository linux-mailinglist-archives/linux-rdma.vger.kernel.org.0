Return-Path: <linux-rdma+bounces-22181-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qICcC946LGo4OAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22181-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 18:59:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C7967B241
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 18:59:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shazbot.org header.s=fm3 header.b=lFXpnGwc;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="X APZINl";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22181-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22181-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=shazbot.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80D5131FE92F
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C649C403EB1;
	Fri, 12 Jun 2026 16:52:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944D401495;
	Fri, 12 Jun 2026 16:52:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283175; cv=none; b=ri1HKE05ZtEBIjvWewzpctBzfoFLXluBl6vxbYokvNtwZHawa7wUv2+Y+uzAAwDi8navPrHXy/PmDSg6iMcfMNoPIXJppDfx/UjG3Ct1Qvp7GB6CI7BwBMD3muU8bRZAeYMaHH4DPtkKcvHfEHLrvERP4oUTfhaKnxlO4j44clI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283175; c=relaxed/simple;
	bh=24wQChAQOJp4jUd0/0DfoMQ1yU723OejhdZTkJTDDq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9lFVIEjgLwvhuQAYuZthLs2dEtx1PekSR146CHA97X7dcdaO/fXBmCQEO08FgOtA0lXGiq+UJc8rbQ/QWblCGSRUwr9aoGPVl7C+FTherVql1rsLY258bJsqq3ORqk3Sb0Zlx2pEq0fvFQ06Ag1DBlEXKw+xZyqaY/FCrV2qLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=lFXpnGwc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XAPZINl4; arc=none smtp.client-ip=103.168.172.145
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id E25FBEC019E;
	Fri, 12 Jun 2026 12:52:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 12 Jun 2026 12:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781283171;
	 x=1781369571; bh=IMjdTnzoJaPEHm5nCFiglgf4MQ8JbUyD46xJ1bIgrWU=; b=
	lFXpnGwcIYKgvYDL/3TehmOZ1Kgfm1m9vLzM4mh/5yn9qC778edLi/zuF7hTlyjf
	7qEddjjKjzQuqm4uSKFbE6qGiqy87DoZM+mEUczzThnuFEmt90jrmxS3aBeAnGCT
	XR6O4Ttz0NeqrMcB3aPpr/UlrBguVCNi+DHhbmDneCLjeS0+jFP86IFiYg90472U
	SImrX52qe13TDNV4Epnsmtwhk7mv1AfA7Umy7q8gdJrFtohQ0BOhAN8uS9LfCQ2d
	IMhJF8PgmNrTDeybihtO5vB9OaVtSmVL60l9g2vudNSJP5ZqHfsJ6JdGjswJ1v1L
	mE5nOq5ghRbU3QikXVqOdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781283171; x=
	1781369571; bh=IMjdTnzoJaPEHm5nCFiglgf4MQ8JbUyD46xJ1bIgrWU=; b=X
	APZINl4QZ2sv1IAtwV0X5I8RtX9LZO0DG52Yrq77EpvCfmoAZanl1Bcy13qDZ78K
	/QmmDrVv7f9cAbtBNMjIGiVPYZgk4qz40C+evlq/XC/2ZOLcgEN7n4ZtlI7xIdgz
	ZdoYzn5cZSQPcxSk1l58haSDHhQO2cGpqc9uI3LlsgN4QuDs3C11qacpFjlfhyIO
	1s74t5LKX2qQkmhWEm1buNr9kVfNyKn0cJLFU0+402Vls/QFsZPQx1ERZD6Yp7sB
	bER8rgxmB3n5pR89AHF6pJ05DONBN+AbqpEYi8dEWcWHG7qNQ3aePRSgAj90jyPM
	+CcYbYwDpu73ohUoyvW1g==
X-ME-Sender: <xms:YzksaijV2vVVUTeeAYkagwU2paX2dIwLb_OUzgO-wNF4pW33MyD0lw>
    <xme:Yzksan9nG4juEl0zI9_NI5U2clxUya8qLszrV6BIOBPwGC6yIXFClGT8G-Bh4nuEc
    RNpoF3nWEeDnvz29gNLRBhJZnl8vSCnNOlHZJYaprprovFIvUt6ZcQ>
X-ME-Received: <xmr:YzksauVaO59SZ3a4kcLchXtf9Bh4Hi0PbFSaICy-IiC_xVKHRZIm6WBpr54>
X-ME-Proxy-Cause: dmFkZTFArRAgYvj57o1HapZcwzWeF52p9meQLcL+oU7S3KkL5oUp5Lte8sAxnl9d9x1/ZI
    RLFZ0Ew+UiUwi/bM4ff5ppqTuM4MbAYuNZ75VRe8KfLHkgZhmp8++kMM/+DL0wkBbwFkul
    qPjutE0A+8Ns3D6Ada0IOAt+c8rgQLsrFffQHinYO2qulO1USE+gglknL0VN+6P9H726m5
    xBHH7ldOezsD2nyYupyaUaQzGEd8EyJEiGUbuztdXsBXFLTQH5YARqX5ywuXUgloMOyRNA
    au3HGF1JmRmCEZQgn2zLFDygU/9/t+ISKtlsVhjl+pgWu+H0VAwpKmNqtmlE0VuNvgzFpv
    79z9rjoK/mTGkTTkHeSOa2riRWrtXHZp9rH+GivfOr7tBEWEU7mBYi5EUpEB5MD+muV0xY
    2XWDeOTkxIfpa+VeTxPv+hLFY0shiD3Zp4AbBphRn0nFhZ2xFzvKF1uHC4u6E/6h/4/dSS
    Y7BcM9/DwiCm6uf6FdJF5IdZLr3MWWDNtIUO27SpNPI0bgVid1LGh7BW2BlD/e4d0zZoGb
    cmS27lyXQB19Q9qua0syP3urPPGJnavmgyGab4irYA114Yx70Yi4VLqqGxxXmUAUfrQ4Vl
    nrpUizVG/kbLfNqXaw7fRDMW4JTQ3BhiKpuYO3fX2mmJtUA+mKUs1t7VxTVg
X-ME-Proxy: <xmx:YzksarAnrZKlgWMr7tYnezzEzpPKIZDoosrd7p34OGBYFuHuyubiMw>
    <xmx:YzksajECqQSpPRwwqlRdjFdQU-8hAni02m_bnQn7L76gkVJVJsvorg>
    <xmx:Yzksas7b5c6J5oiWIJNPM1yDVPdq2FH4dzrnaR7CE0ODnqekJGRsOQ>
    <xmx:Yzksapnj51SIs-6eVY3tPprGjn80B5MTc3l41_NSEqdyR9WLTTbGuw>
    <xmx:YzksaplYLxICKNcYipUieI2lwGVGIjbIAV3k_FYYCwDCp_JGEDX1j6F->
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 12:52:50 -0400 (EDT)
Date: Fri, 12 Jun 2026 10:52:48 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: <netdev@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
 alex@shazbot.org
Subject: Re: [PATCH v7 2/5] PCI/TPH: Add requester/completer type helpers
Message-ID: <20260612105248.7d8431f2@shazbot.org>
In-Reply-To: <20260611161546.4075580-3-zhipingz@meta.com>
References: <20260611161546.4075580-1-zhipingz@meta.com>
	<20260611161546.4075580-3-zhipingz@meta.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22181-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:netdev@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:bhelgaas@google.com,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:dkim,shazbot.org:mid,shazbot.org:from_mime,meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78C7967B241

On Thu, 11 Jun 2026 09:11:17 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:

> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> requester mode without reaching into pci_dev internals.
> 
> Add pcie_tph_completer_type() so drivers that publish TPH metadata for
> a device acting as a completer can gate on the "TPH Completer
> Supported" field of Device Capabilities 2 (bits 13:12,
> PCI_EXP_DEVCAP2_TPH_COMP_MASK) rather than reusing requester-side
> state. Fold the reserved 0b10 encoding into NONE so callers only see
> the defined values.
> 
> This keeps pci_dev::tph_req_type and the completer-capability decode
> inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for
> callers.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

This is carrying forward an ack for v6, where half the interface here
was dropped and changed shape.  Thanks,

Alex

> ---
>  drivers/pci/tph.c       | 43 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-tph.h |  8 ++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 91145e8d9d95..4fe076bba953 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -174,6 +174,49 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
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
> +/**
> + * pcie_tph_completer_type - Return the device's TPH Completer support
> + * @pdev: PCI device to query
> + *
> + * Reads the "TPH Completer Supported" field (bits 13:12) of Device
> + * Capabilities 2. The reserved 0b10 encoding is folded into
> + * "not supported" so callers only need to compare against the three
> + * defined values.
> + *
> + * Return: one of %PCI_EXP_DEVCAP2_TPH_COMP_NONE,
> + *         %PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY or
> + *         %PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH.
> + */
> +u8 pcie_tph_completer_type(struct pci_dev *pdev)
> +{
> +	u32 reg;
> +
> +	if (pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP2, &reg))
> +		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
> +
> +	switch (FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg)) {
> +	case PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY:
> +		return PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY;
> +	case PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH:
> +		return PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH;
> +	default:
> +		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
> +	}
> +}
> +EXPORT_SYMBOL(pcie_tph_completer_type);
> +
>  /*
>   * Return the size of ST table. If ST table is not in TPH Requester Extended
>   * Capability space, return 0. Otherwise return the ST Table Size + 1.
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index be68cd17f2f8..7743af6fe432 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -9,6 +9,8 @@
>  #ifndef LINUX_PCI_TPH_H
>  #define LINUX_PCI_TPH_H
>  
> +#include <linux/pci_regs.h>
> +
>  /*
>   * According to the ECN for PCI Firmware Spec, Steering Tag can be different
>   * depending on the memory type: Volatile Memory or Persistent Memory. When a
> @@ -30,6 +32,8 @@ void pcie_disable_tph(struct pci_dev *pdev);
>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
> +u8 pcie_tph_completer_type(struct pci_dev *pdev);
>  #else
>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>  					unsigned int index, u16 tag)
> @@ -41,6 +45,10 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  { return -EINVAL; }
> +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> +{ return PCI_TPH_REQ_DISABLE; }
> +static inline u8 pcie_tph_completer_type(struct pci_dev *pdev)
> +{ return PCI_EXP_DEVCAP2_TPH_COMP_NONE; }
>  #endif
>  
>  #endif /* LINUX_PCI_TPH_H */


