Return-Path: <linux-rdma+bounces-11290-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B655AD8400
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jun 2025 09:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73210189B0E3
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jun 2025 07:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3522C3262;
	Fri, 13 Jun 2025 07:22:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD42C3253;
	Fri, 13 Jun 2025 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749799319; cv=none; b=pFo/GRVsgdu/RlrMXcUpe0mUs3N9J7nQ0CJJukDigGWHOSZSI7NyBY+6lYtlCk1ZK/5E1nYHO8X8gs4gPk4sytq7tVnmgI4tmfiJQtwes/uQV0ZmuFEzlD866/QTkepC259bvtqvicHh96rK6QcXsRDN2MhUFEGr9CWChK2mchE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749799319; c=relaxed/simple;
	bh=f53e8zCVldZKex7V8wT3fscn8249BPn315N+wutkj7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ta0cISN1XQvAlELp4dmSIgjRFJPawVOCM/0tCUW4vt6H74myJWlRc/i/YoeLSHrzXdvTFyAAL561MLu49g5W02kQkR7HgIYQlR51jqt6Bek298219IHKdcf9MkxF9YO/IbTD1QOeo+svPGFEaUhyPa0WuUTQad2HWb9CmOTyJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.111] (p57bd96bf.dip0.t-ipconnect.de [87.189.150.191])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9B75561E647A3;
	Fri, 13 Jun 2025 09:21:09 +0200 (CEST)
Message-ID: <1dbe36d4-c272-4af0-a83b-0ab7ff0464c3@molgen.mpg.de>
Date: Fri, 13 Jun 2025 09:21:08 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-next v2 0/6] Add RDMA support for Intel
 IPU E2000 in idpf
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
References: <20250612220002.1120-1-tatyana.e.nikolova@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250612220002.1120-1-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Tatyana,


Thank you for this patch series.


Am 12.06.25 um 23:59 schrieb Tatyana Nikolova:
> This idpf patch series is the second part of the staged submission
> for introducing RDMA RoCEv2 support for the IPU E2000 line of products,
> referred to as GEN3.
> 
> To support RDMA GEN3 devices, the idpf driver uses
> common definitions of the IIDC interface and implements
> specific device functionality in iidc_rdma_idpf.h.

This could be re-flowed for longer lines.

> The IPU model can host one or more logical network endpoints called
> vPorts per PCI function that are flexibly associated with a physical
> port or an internal communication port.
> 
> Other features as it pertains to GEN3 devices include:
> * MMIO learning
> * RDMA capability negotiation
> * RDMA vectors discovery between idpf and control plane
> 
> These patches are split from the submission
> "Add RDMA support for Intel IPU E2000 (GEN3)" [1]
> and are based on 6.16-rc1. A shared pull request for net-next and
> rdma-next will be sent following review.

Still mention the datasheet?

Also, it’d be great to have a paragraph on how this was tested.

> Changelog:
> 
> v2:
> * Minor improvements like variable rename, logging,
> remove a redundant variable, etc.
> * A couple of cdev_info fixes to properly free it in
> error path and not to dereference it before NULL check.
> 
> Changes since split (v1) at [4]:
> * Replace core dev_ops with exported symbols
> * Align with new header split scheme (iidc_rdma.h common header
> and iidc_rdma_idpf.h specific header)
> * Align with new naming scheme (idc_rdma -> iidc_rdma)
> * The idpf patches are submitted separately from the ice and
> irdma changes.
> 
> At [3]:
> * Reduce required minimum RDMA vectors to 2
> 
> At [2]:
> * RDMA vector number adjustment
> * Fix unplugging vport auxiliary device twice
> * General cleanup and minor improvements
> 
> [1] https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/
> [2] https://lore.kernel.org/all/20240824031924.421-1-tatyana.e.nikolova@intel.com/
> [3] https://lore.kernel.org/all/20250207194931.1569-1-tatyana.e.nikolova@intel.com/
> [4] https://lore.kernel.org/all/20250523170435.668-1-tatyana.e.nikolova@intel.com/
> 
> Joshua Hay (6):
>    idpf: use reserved RDMA vectors from control plane
>    idpf: implement core RDMA auxiliary dev create, init, and destroy
>    idpf: implement RDMA vport auxiliary dev create, init, and destroy
>    idpf: implement remaining IDC RDMA core callbacks and handlers
>    idpf: implement IDC vport aux driver MTU change handler
>    idpf: implement get LAN MMIO memory regions
> 
>   drivers/net/ethernet/intel/idpf/Makefile      |   1 +
>   drivers/net/ethernet/intel/idpf/idpf.h        | 117 ++++-
>   .../net/ethernet/intel/idpf/idpf_controlq.c   |  14 +-
>   .../net/ethernet/intel/idpf/idpf_controlq.h   |  19 +-
>   drivers/net/ethernet/intel/idpf/idpf_dev.c    |  49 +-
>   drivers/net/ethernet/intel/idpf/idpf_idc.c    | 497 ++++++++++++++++++
>   drivers/net/ethernet/intel/idpf/idpf_lib.c    | 102 +++-
>   drivers/net/ethernet/intel/idpf/idpf_main.c   |  32 +-
>   drivers/net/ethernet/intel/idpf/idpf_mem.h    |   8 +-
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   1 +
>   drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  45 +-
>   .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 190 ++++++-
>   .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   3 +
>   drivers/net/ethernet/intel/idpf/virtchnl2.h   |  42 +-
>   include/linux/net/intel/iidc_rdma_idpf.h      |  55 ++
>   15 files changed, 1102 insertions(+), 73 deletions(-)
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_idc.c
>   create mode 100644 include/linux/net/intel/iidc_rdma_idpf.h


Kind regards,

Paul

