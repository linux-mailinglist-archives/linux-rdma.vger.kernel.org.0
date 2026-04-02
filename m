Return-Path: <linux-rdma+bounces-18944-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBqCKIqfzmlZpAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18944-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 18:55:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E847338C3C8
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 18:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA9CB300C6FD
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 16:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1220D3F7864;
	Thu,  2 Apr 2026 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3vICxvM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17933F211C;
	Thu,  2 Apr 2026 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147922; cv=none; b=FbaFtfGcVj5hvu0EG91QWcIvhLRWtwJl71zVKo3h0adLC/nRqeOPpU4dAIxIztuRAyk0C42wysbW9f3CN+LZVc+aVHQjA1p6DvNQ9UXaaMr2k5zqnGieb32BIcUE3neka4AooLfCB+qZZ97KhJCLQSYUr9AHsm+O/4p853czvK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147922; c=relaxed/simple;
	bh=SS+BtVdttMvo6X20fLR3JClq/W5wC0bvQxoXCy/55dc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ltqt2wDRJoBK05JjK+J50RfPayuCabZr4F35/tbp8WHV2iKyDBBKZ1MwYlOlmFXbKe2ZHdoNHZC10f0d3BlPCf3UjRAjjgEJuyo6E5klux5X1MqMCtbfge3LptRFCzx0jD5WpsXSi6ZI0fJ5AGQq1oegr6SenPZSJaib+qEJbhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3vICxvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE30C116C6;
	Thu,  2 Apr 2026 16:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775147922;
	bh=SS+BtVdttMvo6X20fLR3JClq/W5wC0bvQxoXCy/55dc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=U3vICxvMqgBh7amR+oCizO3AJ7YOv3bxzO8OCsh6ZNB5XW45uHJ/8h8WJx54f1P91
	 xDmPSvdX9WiW9SuHdR2YUbGunbzjakgfC9lpI1iEHTaYHIZ3/27UQhAdF5d8lWlB1x
	 Pd5ZE1JHkCSZ9qd9lw5ug60ehF3zJp/hs6R1OwWeq/rWlnIZq277RkUEVs2UadCRmq
	 K58kn3MHghtAlrqMVicW2YdHuCFzNec/LSZEHYXCPZmAh/+BkYJmoaCfBR6PS8wfU8
	 uWou+k7OQkgxGJ5V+67qVIGW3r+gVfCohHAvry1cjRT3YXi9BZAFZ34kvNTES8g39K
	 D+hKMQ+afiejw==
Date: Thu, 2 Apr 2026 11:38:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jay Cornwall <Jay.Cornwall@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 0/3] PCI: AtomicOps: Fix
 pci_enable_atomic_ops_to_root()
Message-ID: <20260402163840.GA279690@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-fix_pciatops-v7-0-f601818417e8@linux.ibm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18944-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E847338C3C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 03:09:43PM +0200, Gerd Bayer wrote:
> Hi Bjorn et al.
> 
> On s390, AtomicOp Requests are enabled on a PCI function that supports
> them, despite the helper being ignorant about the root port's capability
> to supporting their completion.
> 
> Patch 1: Do not enable AtomicOps Requests on RCiEPs
> Patch 2: Fix the logic in pci_enable_atomic_ops_to_root()
> Patch 3: Update references to PCIe spec in that function.
> 
> I did test that the issue is fixed with these patches. Also, I verified
> that on a Mellanox/Nvidia ConnectX-6 adapter plugged straight into the
> root port of a x86 system still gets AtomicOp Requests enabled.
> 
> Due to a lack of the required hardware, I did not test this with any PCIe
> switches between root port and endpoint. So test exposure in other
> environments is highly appreciated.
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

Thanks, applied to pci/atomics for v7.1 with minor rework of 2/3.

> ---
> Changes in v7:
> - Prepend series with a patch to explicitly exclude RCiEPs from
>   enablement of AtomicOps Requests
> - Limit the core patch 2 to enforce a full check of the entire
>   PCIe hierarchy for support of AtomicOps capabilities.
> - Rebase to v7.0-rc6
> - Link to v6: https://lore.kernel.org/r/20260325-fix_pciatops-v6-0-10bf19d76dd1@linux.ibm.com
> 
> Changes in v6:
> - Incorporate Ilpo's editorial comments.
> - Correct logic in pci_is_atomicops_capable_rp() (annotated by Sashiko)
> - Link to v5: https://lore.kernel.org/r/20260323-fix_pciatops-v5-0-fada7233aea8@linux.ibm.com
> 
> Changes in v5:
> - Introduce new pcibios_connects_to_atomicops_capable_rc() so arch's can
>   declare AtomicOps support outside of PCIe config space. Defaults to
>   "true" - except s390.
> - rebase to 7.0-rc5
> - Link to v4: https://lore.kernel.org/r/20260313-fix_pciatops-v4-0-93bc70a63935@linux.ibm.com
> 
> Changes in v4:
> - drop patch 1 - it will become the base of a new series
> - previous patch 2, now 1: reword commit message
> - add a new patch to update references to PCI spec within
>   pci_enable_atomic_ops_to_root()
> - rebase to latest master
> - Link to v3: https://lore.kernel.org/r/20260306-fix_pciatops-v3-0-99d12bcafb19@linux.ibm.com
> 
> Changes in v3:
> - rebase to 7.0-rc2
> - gentle ping
> - add netdev and rdma lists for awareness
> - Link to v2: https://lore.kernel.org/r/20251216-fix_pciatops-v2-0-d013e9b7e2ee@linux.ibm.com
> 
> Changes in v2:
> - rebase to 6.19-rc1
> - otherwise unchanged to v1
> - Link to v1: https://lore.kernel.org/r/20251110-fix_pciatops-v1-0-edc58a57b62e@linux.ibm.com
> 
> ---
> Gerd Bayer (3):
>       PCI: AtomicOps: Do not enable requests by RCiEPs
>       PCI: AtomicOps: Do not enable without support in root port
>       PCI: AtomicOps: Update references to PCIe spec
> 
>  drivers/pci/pci.c | 48 ++++++++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
> ---
> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
> change-id: 20251106-fix_pciatops-7e8608eccb03
> 
> Best regards,
> -- 
> Gerd Bayer <gbayer@linux.ibm.com>
> 

