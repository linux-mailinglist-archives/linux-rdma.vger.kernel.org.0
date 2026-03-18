Return-Path: <linux-rdma+bounces-18296-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB03CWtuumnRWQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18296-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 10:20:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8035C2B8DB5
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 10:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1176631ED513
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 09:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0213B3C12;
	Wed, 18 Mar 2026 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INNtoWnw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC003A6412
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825097; cv=none; b=ap7yhsD9sbS3Hufi3NABJGpTCY6zcykCd6Tsdg6FstMC/n2G4FyccM7opqob3/SKvVCEpQ+QfMD+1m+67HB7YDKWIKXWzhLqWU4M5o/GikI2B8nO+ju/XRPQZZYlXKepgcr2QLppvyLbiM+XFnOGGMYjjpFxBXkaKhple35ewAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825097; c=relaxed/simple;
	bh=8zmLEpE8CjYwjQbwHBIrXCxIv2poxo+laJ4d4vtrpxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2v+mcxPLyoh8u3PHaWamWcC7s3Jm+j2OlklN0wofb5ColRIT1AKNz+t/akB+UTGYAxTW8f2YOoKI1nlL6UU4sjVubLAWGacPbDhstFaqY9MBMquD4GEhQIYO7WxBo7YoAk+svctqmPunjldim3xjEz1Y3zUAv4qtTdySy6aXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INNtoWnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9ACC19421;
	Wed, 18 Mar 2026 09:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773825096;
	bh=8zmLEpE8CjYwjQbwHBIrXCxIv2poxo+laJ4d4vtrpxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INNtoWnw/pb3SCBaSpGfrveNWEoOySvQWDMLZ43yVaaniuUTDNOu04EyGK2IqhlxU
	 a0XpZ7WEgmOkACZcNjWn+kW8izvf4nn1ALsIaOx9fU2g2ODlnr1ekwlVTjgkveGoOj
	 lXK6B+9j8cns0UG1f6s6WPEe005AAGncNs8bucK+a+4p46CyCWSsjDsbYulmgwUmEC
	 8L9JaAUBiMWynqoAtcHijtA/kaTx7XIjzC7vy/xznx06VtGIB0IT7e1EViUo5w3C4E
	 niirvP80svCkVYQbT3ek6pYxK8AjJCPz2C7xw6nZcamt5BCG54vC1Gp/kuLK2OJoQH
	 p4Ckx7hsTdjiA==
Date: Wed, 18 Mar 2026 11:11:31 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	Douglas Miller <doug.miller@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next resend 08/24] RDMA/hfi2: Add driver and
 interrupt infrastructure
Message-ID: <20260318091131.GF61385@unreal>
References: <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
 <177325166582.57064.10830823801759931130.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177325166582.57064.10830823801759931130.stgit@awdrv-04.cornelisnetworks.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18296-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 8035C2B8DB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 01:54:25PM -0400, Dennis Dalessandro wrote:
> Add the core driver entry points, interrupt handling, MSI-X management,
> active state power management, and EFI variable support.
> 
> Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
> Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
> Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
> Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
> Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
> Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi2/aspm.c   |  286 +++++

This file is very similar to drivers/pci/pcie/aspm.c and "pcie_aspm="
kernel command line.

In addition, I see that there are too many PCI code here.

Thanks

