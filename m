Return-Path: <linux-rdma+bounces-19431-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM0oHKXO5WlIoAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19431-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 08:58:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8998142789A
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 08:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D62C5300C6CC
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 06:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C5333B6D3;
	Mon, 20 Apr 2026 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="JttpORxB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EAD27B32C
	for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2026 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668149; cv=none; b=Ff9Fr8VQzCsdYQAxXwJ3cgt9YdbKn2AI6/6vGaz9LvtVmnTyy4xVD7hzaDqrjNZBp76KEpNjMXPwGysAQ5MXNBwtTIHsnW1p3dC43cIOBUIujxkuJl47A95mMCM2KtQJT848D06vhNNqQuSBvvJn/0OaHbZbTuqqQQDUUnaZkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668149; c=relaxed/simple;
	bh=hv6oJnoaplZKbLUB8GX84i+m0HL9WVJWhbnvVFyHveM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWrojoDkt4j3kMf5X/EqUAEQbsGvIQEU2vP+gW7up1fB53bOt6lLkN7fv0IxT3ERnchsps5MdUdp8XqHij2oN+lUB69yD1471MCgOyFDKWPzkn7QQZS8TSqeZDTJ5+JbSt0M5B1baE7s/KzDihc3GdO8viPf7AKYDdwMNWRT9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JttpORxB; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776668148; x=1808204148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X4sb7TBlKUOzQg0Zrc01llV/KnjDeL1JdgeNptcyiNk=;
  b=JttpORxBlKu+6wp3Bq9EG7UTl3qdUQJIhO/iT0RqsaB+0A/EGQs7JhNX
   UP/bTmf/dzGin670VZX0FNpnHa0j2TQ9AfuxaZnWAsohbHaBEo40m94i/
   wCD6Ztw3AXgZ2Y3+krMFQklKFed9nX1jnXRC8vxWPGhY7+sKvfAGHPY1G
   +SGdYNh+ad2v9qWBnm4lxaIqJYMg5dATq/rZB+7RQelN7wBtuBiv8AZ3+
   Sml2IRqY9keYWcS2Iz+iyjsaRkvT7nn7mVDQFmEi0H1Fu7zUqnESgnoGS
   V0A3TD49lNsArdS3Oh/coCmNfetuNyj3E4K0MvyvQ1fPbR2ygK2eqCO3+
   g==;
X-CSE-ConnectionGUID: sSYsNSbaQC+eBJVuEzEniA==
X-CSE-MsgGUID: hxf/UzhyQr2Shb4SN4Gndw==
X-IronPort-AV: E=Sophos;i="6.23,189,1770595200"; 
   d="scan'208";a="17688764"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 06:55:44 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:22627]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.81:2525] with esmtp (Farcaster)
 id 3417becc-3f8d-462e-acae-ca2c1f8a323b; Mon, 20 Apr 2026 06:55:44 +0000 (UTC)
X-Farcaster-Flow-ID: 3417becc-3f8d-462e-acae-ca2c1f8a323b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 06:55:43 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 20 Apr 2026
 06:55:41 +0000
Date: Mon, 20 Apr 2026 06:55:28 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add checksum support for admin
 responses
Message-ID: <20260420065528.GA29767@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
References: <20260409074905.3126023-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260409074905.3126023-1-ynachum@amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19431-lists,linux-rdma=lfdr.de];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,10.13.138.214:received,205.251.233.111:received,10.253.69.224:received];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8998142789A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 07:49:05AM +0000, Yonatan Nachum wrote:
> EFA devices added support for CRC16 checksum on admin responses and to
> expose it to the driver the API version increased to 0.2. Add a check
> for support on device init and if supported validate the checksum on
> each admin response the driver receives. If the checksum validation
> failed, drop the CQE.
> 
> Add the CRC16 module to Kconfig to have the in-tree dependency.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  drivers/infiniband/hw/efa/Kconfig             |  3 +-
>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   |  3 --
>  drivers/infiniband/hw/efa/efa_admin_defs.h    | 15 +++---
>  drivers/infiniband/hw/efa/efa_com.c           | 50 ++++++++++++++++---
>  drivers/infiniband/hw/efa/efa_com.h           |  4 +-
>  5 files changed, 55 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/Kconfig b/drivers/infiniband/hw/efa/Kconfig
> index 457e18ba1d57..ff7f7c0870b3 100644
> --- a/drivers/infiniband/hw/efa/Kconfig
> +++ b/drivers/infiniband/hw/efa/Kconfig
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> -# Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
> +# Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
>  #
>  # Amazon fabric device configuration
>  #
> @@ -8,6 +8,7 @@ config INFINIBAND_EFA
>  	tristate "Amazon Elastic Fabric Adapter (EFA) support"
>  	depends on PCI_MSI && 64BIT && !CPU_BIG_ENDIAN
>  	depends on INFINIBAND_USER_ACCESS
> +	select CRC16
>  	help
>  	  This driver supports Amazon Elastic Fabric Adapter (EFA).
>  
> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> index 57178dad5eb7..dd9bfcabe8c4 100644
> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> @@ -6,9 +6,6 @@
>  #ifndef _EFA_ADMIN_CMDS_H_
>  #define _EFA_ADMIN_CMDS_H_
>  
> -#define EFA_ADMIN_API_VERSION_MAJOR          0
> -#define EFA_ADMIN_API_VERSION_MINOR          1
> -
>  /* EFA admin queue opcodes */
>  enum efa_admin_aq_opcode {
>  	EFA_ADMIN_CREATE_QP                         = 1,
> diff --git a/drivers/infiniband/hw/efa/efa_admin_defs.h b/drivers/infiniband/hw/efa/efa_admin_defs.h
> index 35700c93e639..02f86edabed8 100644
> --- a/drivers/infiniband/hw/efa/efa_admin_defs.h
> +++ b/drivers/infiniband/hw/efa/efa_admin_defs.h
> @@ -1,18 +1,20 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>  /*
> - * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
>   */
>  
>  #ifndef _EFA_ADMIN_H_
>  #define _EFA_ADMIN_H_
>  
> +#define EFA_ADMIN_API_VERSION_MAJOR          0
> +#define EFA_ADMIN_API_VERSION_MINOR          2
> +
>  enum efa_admin_aq_completion_status {
>  	EFA_ADMIN_SUCCESS                           = 0,
>  	EFA_ADMIN_RESOURCE_ALLOCATION_FAILURE       = 1,
>  	EFA_ADMIN_BAD_OPCODE                        = 2,
>  	EFA_ADMIN_UNSUPPORTED_OPCODE                = 3,
>  	EFA_ADMIN_MALFORMED_REQUEST                 = 4,
> -	/* Additional status is provided in ACQ entry extended_status */
>  	EFA_ADMIN_ILLEGAL_PARAMETER                 = 5,
>  	EFA_ADMIN_UNKNOWN_ERROR                     = 6,
>  	EFA_ADMIN_RESOURCE_BUSY                     = 7,
> @@ -78,13 +80,10 @@ struct efa_admin_acq_common_desc {
>  	 */
>  	u8 flags;
>  
> -	u16 extended_status;
> +	/* Poly 0x8005 CRC16 with initial value 0xFFFF and final XOR of 0xFFFF */
> +	u16 checksum;
>  
> -	/*
> -	 * indicates to the driver which AQ entry has been consumed by the
> -	 * device and could be reused
> -	 */
> -	u16 sq_head_indx;
> +	u16 reserved;
>  };
>  
>  struct efa_admin_acq_entry {
> diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
> index e97b5f0d7003..7cc3f4af0bb9 100644
> --- a/drivers/infiniband/hw/efa/efa_com.c
> +++ b/drivers/infiniband/hw/efa/efa_com.c
> @@ -3,6 +3,7 @@
>   * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
>   */
>  
> +#include <linux/crc16.h>
>  #include <linux/log2.h>
>  
>  #include "efa_com.h"
> @@ -22,6 +23,14 @@
>  #define EFA_CTRL_MINOR          0
>  #define EFA_CTRL_SUB_MINOR      1
>  
> +#define EFA_CRC16_INIT_VAL 0xffff
> +
> +#define EFA_CRC_MIN_ADMIN_API_VERSION_MAJOR 0
> +#define EFA_CRC_MIN_ADMIN_API_VERSION_MINOR 2
> +
> +#define EFA_MIN_ADMIN_API_VERSION_MAJOR 0
> +#define EFA_MIN_ADMIN_API_VERSION_MINOR 1
> +
>  enum efa_cmd_status {
>  	EFA_CMD_UNUSED,
>  	EFA_CMD_ALLOCATED,
> @@ -167,9 +176,8 @@ static int efa_com_admin_init_cq(struct efa_com_dev *edev)
>  	struct efa_com_admin_queue *aq = &edev->aq;
>  	struct efa_com_admin_cq *cq = &aq->cq;
>  	u16 size = aq->depth * sizeof(*cq->entries);
> -	u32 acq_caps = 0;
> -	u32 addr_high;
> -	u32 addr_low;
> +	u32 acq_caps = 0, crc_min_ver = 0;
> +	u32 addr_high, addr_low;
>  
>  	cq->entries =
>  		dma_alloc_coherent(aq->dmadev, size, &cq->dma_addr, GFP_KERNEL);
> @@ -178,6 +186,11 @@ static int efa_com_admin_init_cq(struct efa_com_dev *edev)
>  
>  	spin_lock_init(&cq->lock);
>  
> +	EFA_SET(&crc_min_ver, EFA_REGS_VERSION_MAJOR_VERSION, EFA_CRC_MIN_ADMIN_API_VERSION_MAJOR);
> +	EFA_SET(&crc_min_ver, EFA_REGS_VERSION_MINOR_VERSION, EFA_CRC_MIN_ADMIN_API_VERSION_MINOR);
> +	if (edev->dev_api_ver >= crc_min_ver)
> +		cq->validate_checksum = true;
> +
>  	cq->cc = 0;
>  	cq->phase = 1;
>  
> @@ -409,12 +422,35 @@ static int efa_com_submit_admin_cmd(struct efa_com_admin_queue *aq,
>  	return 0;
>  }
>  
> +static bool efa_com_cqe_checksum_valid(struct efa_com_admin_queue *aq,
> +				       struct efa_admin_acq_entry *cqe)
> +{
> +	u16 cqe_checksum = cqe->acq_common_descriptor.checksum;
> +	u16 calc_checksum;
> +
> +	cqe->acq_common_descriptor.checksum = 0;
> +
> +	calc_checksum = crc16(EFA_CRC16_INIT_VAL, (u8 *)cqe, sizeof(*cqe)) ^ EFA_CRC16_INIT_VAL;
> +	if (calc_checksum != cqe_checksum) {
> +		ibdev_err(aq->efa_dev,
> +			  "Received completion with invalid checksum, cqe[%u], calc[%u], sq producer[%d], sq consumer[%d], cq consumer[%d]\n",
> +			  cqe_checksum, calc_checksum, aq->sq.pc, aq->sq.cc,
> +			  aq->cq.cc);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int efa_com_handle_single_admin_completion(struct efa_com_admin_queue *aq,
>  						  struct efa_admin_acq_entry *cqe)
>  {
>  	struct efa_comp_ctx *comp_ctx;
>  	u16 cmd_id;
>  
> +	if (aq->cq.validate_checksum && !efa_com_cqe_checksum_valid(aq, cqe))
> +		return -EINVAL;
> +
>  	cmd_id = EFA_GET(&cqe->acq_common_descriptor.command,
>  			 EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID);
>  
> @@ -954,16 +990,16 @@ int efa_com_validate_version(struct efa_com_dev *edev)
>  		  EFA_GET(&ver, EFA_REGS_VERSION_MAJOR_VERSION),
>  		  EFA_GET(&ver, EFA_REGS_VERSION_MINOR_VERSION));
>  
> -	EFA_SET(&min_ver, EFA_REGS_VERSION_MAJOR_VERSION,
> -		EFA_ADMIN_API_VERSION_MAJOR);
> -	EFA_SET(&min_ver, EFA_REGS_VERSION_MINOR_VERSION,
> -		EFA_ADMIN_API_VERSION_MINOR);
> +	EFA_SET(&min_ver, EFA_REGS_VERSION_MAJOR_VERSION, EFA_MIN_ADMIN_API_VERSION_MAJOR);
> +	EFA_SET(&min_ver, EFA_REGS_VERSION_MINOR_VERSION, EFA_MIN_ADMIN_API_VERSION_MINOR);
>  	if (ver < min_ver) {
>  		ibdev_err(edev->efa_dev,
>  			  "EFA version is lower than the minimal version the driver supports\n");
>  		return -EOPNOTSUPP;
>  	}
>  
> +	edev->dev_api_ver = ver;
> +
>  	ibdev_dbg(
>  		edev->efa_dev,
>  		"efa controller version: %d.%d.%d implementation version %d\n",
> diff --git a/drivers/infiniband/hw/efa/efa_com.h b/drivers/infiniband/hw/efa/efa_com.h
> index 4d9ca97e4296..f8c692b0e092 100644
> --- a/drivers/infiniband/hw/efa/efa_com.h
> +++ b/drivers/infiniband/hw/efa/efa_com.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>  /*
> - * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
>   */
>  
>  #ifndef _EFA_COM_H_
> @@ -25,6 +25,7 @@ struct efa_com_admin_cq {
>  	struct efa_admin_acq_entry *entries;
>  	dma_addr_t dma_addr;
>  	spinlock_t lock; /* Protects ACQ */
> +	bool validate_checksum;
>  
>  	u16 cc; /* consumer counter */
>  	u8 phase;
> @@ -112,6 +113,7 @@ struct efa_com_dev {
>  	u32 supported_features;
>  	u32 dma_addr_bits;
>  
> +	u32 dev_api_ver;
>  	struct efa_com_mmio_read mmio_read;
>  };
>  
> -- 
> 2.50.1
> 

Kind reminder.

Thanks

