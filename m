Return-Path: <linux-rdma+bounces-14484-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB051C5D4E7
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Nov 2025 14:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E09934E20C8
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Nov 2025 13:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AEE27990C;
	Fri, 14 Nov 2025 13:12:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795619E7D1;
	Fri, 14 Nov 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125958; cv=none; b=gow99QKnvJNy+pQ9cPaIrq3O+39rirWCfUFYO//ue+9LNitiadRxd493Yk/5SZI3yNkds5rLFxneLsUssv2iYsEjbv8o02PSyX93iAh3G2D1vJhsSKOsgj/gzrt2BFeGzSlfXTJ7FfsYNEeUbHPRHpjAU0qWg3EcaoOkKFv4lj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125958; c=relaxed/simple;
	bh=1hXjKIg4/jA/DRDAjapwgRzU4bIgIF8InlmC3moADzU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7U6+RCvMgBBUL9lplCbMS52VziXashmhlA7R+NHQYvC9gb2M/DU6jQTBTT1XTrKJvyQj6Yxypre8tarLY1dURyLvdZPbxzxBMmyeBo0oZcr8rE4uYEBYXZNDVXkpYlWhkkYCR2jo71k4zoKZ4R7hlU9/voNEUqmgHfAKAePZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d7Hbf4QRDzJ46F0;
	Fri, 14 Nov 2025 21:11:58 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 601F714027A;
	Fri, 14 Nov 2025 21:12:34 +0800 (CST)
Received: from localhost (10.126.173.232) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 14 Nov
 2025 13:12:33 +0000
Date: Fri, 14 Nov 2025 13:12:32 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Zhiping Zhang <zhipingz@meta.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>, Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
	<yishaih@nvidia.com>
Subject: Re: [RFC 1/2] Set steering-tag directly for PCIe P2P memory access
Message-ID: <20251114131232.00006e9e@huawei.com>
In-Reply-To: <20251113213712.776234-2-zhipingz@meta.com>
References: <20251113213712.776234-1-zhipingz@meta.com>
	<20251113213712.776234-2-zhipingz@meta.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 13 Nov 2025 13:37:11 -0800
Zhiping Zhang <zhipingz@meta.com> wrote:

> PCIe: Add a memory type for P2P memory access
> 
> The current tph memory type definition applies for CPU use cases. For device
> memory accessed in the peer-to-peer (P2P) manner, we need another memory
> type.
> 
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

Trivial but this time definitely add the trailing comma!  Maybe there will never
be any more in here but maybe there will and we can avoid a line of
churn next time.

>  };
>  
>  #ifdef CONFIG_PCIE_TPH


