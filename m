Return-Path: <linux-rdma+bounces-1562-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EF988BC43
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 09:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FABC1C29AE1
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 08:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A67D134723;
	Tue, 26 Mar 2024 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iw6U8WjZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF041292FD;
	Tue, 26 Mar 2024 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441679; cv=none; b=Bdzz7ITTDEcaqsqKP9gnhj2LJI/uFj7cus5ISTqq9VFtLyJTvElDG+yT4Pgin5FCF8hHCHem8H4H7YdXbkSTLPidqlX+H5OQklfHGfbESNti4HS/TzPrtFDbeqlpUWnCaXSZoZ7eTJMS8y9TXSRxubh/dD8FrL2Of9cRXNstaKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441679; c=relaxed/simple;
	bh=nQyk3qdNwZ8anxHMwxL1UdJZCo+TRv8Hz9hdRnnLqBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIvGGafcDht630G7qp1qfE8LIp4yhIOGWkOQPGcCvaAu/dZ+VxIMuDbCgsOaL1ZyF0cUrBD+nT7xY8s9bJVMjXqHHj8Qowv20z7xXMBo+IyZYYf2ukw6Zs7QWU+iOzMX8Jl5AmG6j3AZpNY4lDvtoMh8O2kkuzS3uD70pAJJs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iw6U8WjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8715C43394;
	Tue, 26 Mar 2024 08:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711441678;
	bh=nQyk3qdNwZ8anxHMwxL1UdJZCo+TRv8Hz9hdRnnLqBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iw6U8WjZi0ZrwwftN3emjcJ/oZOIzjr7swKZOnMNp/4chnUfYm+SEpuiRo28qOLEZ
	 05RijM8OUNxINXKYuwPEO7Ht/fCvBCqa1KgnTXedu6EYOEENmKvfR1mkZnQy9URTTN
	 u4AC8W9q5PVErxInCdbfvkZkLUegBAglB4RLcz9Q=
Date: Tue, 26 Mar 2024 09:27:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
	Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
	amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/28] misc: vmci_guest: Use PCI_IRQ_ALL_TYPES
Message-ID: <2024032646-cosigner-whoopee-cd17@gregkh>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
 <20240325070944.3600338-14-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325070944.3600338-14-dlemoal@kernel.org>

On Mon, Mar 25, 2024 at 04:09:24PM +0900, Damien Le Moal wrote:
> In vmci_guest_probe_device(), remove the reference to PCI_IRQ_LEGACY by
> using PCI_IRQ_ALL_TYPES instead of an explicit OR of all IRQ types.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

