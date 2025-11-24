Return-Path: <linux-rdma+bounces-14721-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC7AC82885
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7790A34AF71
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 21:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9E832E6A0;
	Mon, 24 Nov 2025 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5a7p2XY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FD72F363B;
	Mon, 24 Nov 2025 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019676; cv=none; b=kXGntbdJ31l3ZnJfzoTMPOd0QNYE7mah1xmlljTV/rY0qpNxRxqEcZyUtaXUwjBLamHW5CFbvwBXC3fwITLfkxZ2RxXgbPA3ryaUNGZ4L7QjEZImjuRBD+3xMzCqyU20jt0opuc3UKIObrRtjGU8fZSL54W5T3/mZw4qBdXaAaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019676; c=relaxed/simple;
	bh=HSRYKWBW9pOroBohYQkSBsBpthFOGxhpexSq+GXtG8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eeH8QltqlwpSJQtToKR/czEPnXfwkkheht0MkN+R3fqAGzhBwqXAhI/MtfMhHLAsfgoCSBoQ2Hzz6+Vo4+9jAs0CCkPpHasYtwUWIMXoo0nyI6brgS208NoZjL2YfP+QxwqDEJ75JiFgC040pfqBFsWCCP0zyw4EYi3TOOTNY4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5a7p2XY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30539C4CEFB;
	Mon, 24 Nov 2025 21:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764019675;
	bh=HSRYKWBW9pOroBohYQkSBsBpthFOGxhpexSq+GXtG8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C5a7p2XYEWgnqtt6D6T0VdRdS3UNCMTPzV5RYVZFzJ4cmviKO0NRGOAhjzAaa1L8g
	 m7Y89o/sTe7GSTjwjnxEWOHBlA7rY5XqMpA6o6AqelZ7+I5KR1WmtElWfAT6frqmaC
	 zzn3fokF6Fm3LnpJI1cy2F0ZQgcOXXoL9WG3i2TCVxsrGFtKbUjQx/6Jnn0ibdETR2
	 7nkjKPTRbh54NjaNIgPHJKaMmtxzwfMtD5bBC+vPoBjHoGC9Ih5HAkLm3VZf+MGs1b
	 20ChU2xPL9Puh+KsuGFKVXyKasOU55A+/9Yu0jWnPR8L6tVy503Kqw3GIzfl+Sk8qC
	 Ur4i+LRnKS8Qg==
Date: Mon, 24 Nov 2025 15:27:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC 1/2] Set steering-tag directly for PCIe P2P memory access
Message-ID: <20251124212753.GA2714985@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113213712.776234-2-zhipingz@meta.com>

On Thu, Nov 13, 2025 at 01:37:11PM -0800, Zhiping Zhang wrote:
> PCIe: Add a memory type for P2P memory access

This should be in the Subject: line.

It should also start with "PCI/TPH: ..." (not "PCIe") to match
previous history.

> The current tph memory type definition applies for CPU use cases. For device
> memory accessed in the peer-to-peer (P2P) manner, we need another memory
> type.

s/tph/TPH/

Make this say what the patch does (not just that we *need* another
memory type, that we actually *add* one).

The subject line should also say what the patch does.  I don't think
this patch actually changes the *setting* of the steering tag (I could
be wrong, I haven't looked carefully).

> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/pci/tph.c       | 4 ++++
>  include/linux/pci-tph.h | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index cc64f93709a4..d983c9778c72 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -67,6 +67,8 @@ static u16 tph_extract_tag(enum tph_mem_type mem_type, u8 req_type,
>  			if (info->pm_st_valid)
>  				return info->pm_st;
>  			break;
> +		default:
> +			return 0;
>  		}
>  		break;
>  	case PCI_TPH_REQ_EXT_TPH: /* 16-bit tag */
> @@ -79,6 +81,8 @@ static u16 tph_extract_tag(enum tph_mem_type mem_type, u8 req_type,
>  			if (info->pm_xst_valid)
>  				return info->pm_xst;
>  			break;
> +		default:
> +			return 0;
>  		}
>  		break;
>  	default:
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index 9e4e331b1603..b989302b6755 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -14,10 +14,12 @@
>   * depending on the memory type: Volatile Memory or Persistent Memory. When a
>   * caller query about a target's Steering Tag, it must provide the target's
>   * tph_mem_type. ECN link: https://members.pcisig.com/wg/PCI-SIG/document/15470.
> + * Add a new tph type for PCI peer-to-peer access use case.
>   */
>  enum tph_mem_type {
>  	TPH_MEM_TYPE_VM,	/* volatile memory */
> -	TPH_MEM_TYPE_PM		/* persistent memory */
> +	TPH_MEM_TYPE_PM,	/* persistent memory */
> +	TPH_MEM_TYPE_P2P	/* peer-to-peer accessable memory */
>  };
>  
>  #ifdef CONFIG_PCIE_TPH
> -- 
> 2.47.3
> 

