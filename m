Return-Path: <linux-rdma+bounces-18342-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFCnIJjHumlobwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18342-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:41:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA292BE70A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 516C030514A0
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8067F2D838E;
	Wed, 18 Mar 2026 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkOjyRdI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D12EF66B
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848164; cv=none; b=luMkkiKsv6q5a15ZGQfzRqo3FR0LngjxkMRdysiQGVDBUykPgDgmu4Emo2NdNijCF0cqM5qAlKer+U9ppbUFp+y4ZZVLF4x8SZ1wxH9xhgAGXo1KqnrJNMQDTke30xBkeb/dsojbCZe/eG0YZOBgX8DRaLKG7OO2jUAnCZQzw7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848164; c=relaxed/simple;
	bh=n58CUVlAF+StDUY0PZHeeymhZ/QYoVWjPRMtnUnk/OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0zfcE+S6TMio5fyShWWss3mwmrfh7kQ5nXe7mixeL+61QErVjK5ZVbn1CBiyLMjqm2rebmdLvvN1QRW9oXykuxDSAxbhddwb+5tEwASkDnFEGWjf2Dm7wqTwnO03UYmEEVLgneRdoTtBhlN4OFMvwn6Z/Rt2AtZq1NZFDv32nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkOjyRdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AF7C2BC87;
	Wed, 18 Mar 2026 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773848163;
	bh=n58CUVlAF+StDUY0PZHeeymhZ/QYoVWjPRMtnUnk/OI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BkOjyRdIcVrVm9d+3t/G8m51nXME6vzg3VHXqUGAL57/RBch1AzmIy1gWJ06+w7bG
	 ZIUofQnVQqaqTYeA66ZK3x4fvVWROxXoDqxTyUZMcRgk8RJjDbaZusz/NVQWxKIqfj
	 Ntug8EWyCzoZK+FuG3tO1TsmbmE8yJ33LDQ1Zj1lE0B3ePlr/V0aCXV11bVIrMLlpB
	 WxJyJ9sChlQS6vEcNzszSDbkiXYFTO1jSSbC3Fr32ECtVMBEHPvzuNi+3FDBOTEtGo
	 V4K2mdaTfs/jAYAaUKjSDkElrrLXfXbXgAGYmuqxAZnevR4nfDZVksgAFloyx3n7Fy
	 DSR7e4Sj+OO+g==
Date: Wed, 18 Mar 2026 17:35:58 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/hfi2: Consolidate ABI files and setup
 uverbs access
Message-ID: <20260318153558.GE352386@unreal>
References: <177384649619.507973.16055266883386579175.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177384649619.507973.16055266883386579175.stgit@awdrv-04.cornelisnetworks.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18342-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cornelisnetworks.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEA292BE70A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 11:08:16AM -0400, Dennis Dalessandro wrote:
> hfi1 driver is being replaced eventually with an hfi2 driver. Until that
> happens rather than have all the duplicated code in header files, make hfi1
> use hfi2 variants where it can. When compatibility breaks we'll keep a
> separate hfi1 version.
> 
> This is the case for the <dev>_status struture. The hfi1 varaint is single
> port and uses a freezemsg char array while the new hfi2 chip provides
> multiple ports and thus needs and array of ports.
> 
> Likewise the tid info struct is expanded for hfi2 so we include both an
> hfi1 and hfi2 vaiant.
> 
> There is a naming conflict with the trace_hfi1_ctxt_info() call. It has been
> renamed to remove the 1 from the function name to keep the code readable
> but allow it to compile due to the #define in hfi1_ioctl.h.
> 
> The big departure from hfi1 is that we are no longer supporting access from
> users through a private character device. Instead we define two custom
> verbs ojects. dv0/1, which proivdes methods for what in hfi1 are individual
> IOCTLs. We have added an additional method to get stats related to page
> pinning done by the driver.
> 
> The hfi1_user.h is no longer needed and is removed from the uapi directory.
> There is a private compat header in hfi1 that will be deleted when hfi1 is.
> This removes driver specific content from generic RDMA UAPI headers.
> 
> Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
> Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
> Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
> Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> 
> ---
> 
>   Changes since v1:
>     - Remove include/uapi/rdma/hfi/hfi1_user.h; user-space libraries copy
>       UAPI headers rather than including them from the kernel tree directly,
>       so the hfi1_* compatibility aliases do not need to be exported as UAPI
>     - Move hfi1_* to hfi2_* aliases into a new private driver header
>       drivers/infiniband/hw/hfi1/hfi1_user_compat.h; hfi1 continues to use
>       hfi1_* names with no changes to driver source files
>     - Move HFI1_IOCTL_* command definitions from rdma_user_ioctl.h into
>       hfi1_ioctl.h, removing the driver-specific include from the generic
>       RDMA UAPI header
> ---
>  drivers/infiniband/hw/hfi1/common.h           |    2 
>  drivers/infiniband/hw/hfi1/file_ops.c         |    2 
>  drivers/infiniband/hw/hfi1/hfi1_user_compat.h |   93 +++
>  drivers/infiniband/hw/hfi1/trace_ctxts.h      |    2 
>  include/uapi/rdma/hfi/hfi1_ioctl.h            |  140 +----
>  include/uapi/rdma/hfi/hfi1_user.h             |  268 ---------
>  include/uapi/rdma/hfi2-abi.h                  |  726 +++++++++++++++++++++++++
>  include/uapi/rdma/ib_user_ioctl_verbs.h       |    1 
>  include/uapi/rdma/rdma_user_ioctl.h           |   47 --
>  9 files changed, 854 insertions(+), 427 deletions(-)
>  create mode 100644 drivers/infiniband/hw/hfi1/hfi1_user_compat.h
>  delete mode 100644 include/uapi/rdma/hfi/hfi1_user.h
>  create mode 100644 include/uapi/rdma/hfi2-abi.h

While I the idea looks right, I have a couple of comments.

> 
> diff --git a/drivers/infiniband/hw/hfi1/common.h b/drivers/infiniband/hw/hfi1/common.h
> index 8abc902b96f3..011e0f12cea7 100644
> --- a/drivers/infiniband/hw/hfi1/common.h
> +++ b/drivers/infiniband/hw/hfi1/common.h
> @@ -6,7 +6,7 @@
>  #ifndef _COMMON_H
>  #define _COMMON_H

<...>

> +#define HFI1_USER_SWMAJOR HFI2_USER_SWMAJOR
> +#define HFI1_USER_SWMINOR HFI2_USER_SWMINOR
> +#define HFI1_SWMAJOR_SHIFT HFI2_SWMAJOR_SHIFT

I think you need to keep these for hfi1, but hfi2 should not use this
approach. Instead, it should rely on the XXX_UVERBS_ABI_VERSION define,
as other drivers do.

<...>

> index 000000000000..a3d906759730
> --- /dev/null
> +++ b/include/uapi/rdma/hfi2-abi.h
> @@ -0,0 +1,726 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/*
> + * Copyright(c) 2025-2026 Cornelis Networks, Inc.
> + */
> +
> +#ifndef _LINUX_HFI2_USER_H
> +#define _LINUX_HFI2_USER_H
> +
> +#include <linux/types.h>
> +#include <rdma/ib_user_ioctl_cmds.h>
> +#include <rdma/rdma_user_ioctl.h>
> +
> +/*
> + * This version number is given to the driver by the user code during
> + * initialization in the spu_userversion field of hfi2_user_info, so
> + * the driver can check for compatibility with user code.

This is not how compatibility is handled in RDMA subsystem.

> + *
> + * The major version changes when data structures change in an incompatible
> + * way. The driver must be the same for initialization to succeed.
> + */
> +#define HFI2_USER_SWMAJOR 6
> +#define HFI2_RDMA_USER_SWMAJOR 10
> +
> +/*
> + * Minor version differences are always compatible
> + * a within a major version, however if user software is larger
> + * than driver software, some new features and/or structure fields
> + * may not be implemented; the user code must deal with this if it
> + * cares, or it must abort after initialization reports the difference.
> + */
> +#define HFI2_USER_SWMINOR 3
> +#define HFI2_RDMA_USER_SWMINOR 0
> +
> +/*
> + * We will encode the major/minor inside a single 32bit version number.
> + */
> +#define HFI2_SWMAJOR_SHIFT 16
> +
> +/*
> + * Set of HW and driver capability/feature bits.
> + * These bit values are used to configure enabled/disabled HW and
> + * driver features. The same set of bits are communicated to user
> + * space.
> + */
> +#define HFI2_CAP_DMA_RTAIL        (1UL <<  0) /* Use DMA'ed RTail value */
> +#define HFI2_CAP_SDMA             (1UL <<  1) /* Enable SDMA support */
> +#define HFI2_CAP_SDMA_AHG         (1UL <<  2) /* Enable SDMA AHG support */
> +#define HFI2_CAP_EXTENDED_PSN     (1UL <<  3) /* Enable Extended PSN support */
> +#define HFI2_CAP_HDRSUPP          (1UL <<  4) /* Enable Header Suppression */
> +#define HFI2_CAP_TID_RDMA         (1UL <<  5) /* Enable TID RDMA operations */
> +#define HFI2_CAP_USE_SDMA_HEAD    (1UL <<  6) /* DMA Hdr Q tail vs. use CSR */
> +#define HFI2_CAP_MULTI_PKT_EGR    (1UL <<  7) /* Enable multi-packet Egr buffs*/
> +#define HFI2_CAP_NODROP_RHQ_FULL  (1UL <<  8) /* Don't drop on Hdr Q full */
> +#define HFI2_CAP_NODROP_EGR_FULL  (1UL <<  9) /* Don't drop on EGR buffs full */
> +#define HFI2_CAP_TID_UNMAP        (1UL << 10) /* Disable Expected TID caching */
> +#define HFI2_CAP_PRINT_UNIMPL     (1UL << 11) /* Show for unimplemented feats */
> +#define HFI2_CAP_ALLOW_PERM_JKEY  (1UL << 12) /* Allow use of permissive JKEY */
> +#define HFI2_CAP_NO_INTEGRITY     (1UL << 13) /* Enable ctxt integrity checks */
> +#define HFI2_CAP_PKEY_CHECK       (1UL << 14) /* Enable ctxt PKey checking */
> +#define HFI2_CAP_STATIC_RATE_CTRL (1UL << 15) /* Allow PBC.StaticRateControl */
> +#define HFI2_CAP_OPFN             (1UL << 16) /* Enable the OPFN protocol */
> +#define HFI2_CAP_SDMA_HEAD_CHECK  (1UL << 17) /* SDMA head checking */
> +#define HFI2_CAP_EARLY_CREDIT_RETURN (1UL << 18) /* early credit return */
> +#define HFI2_CAP_AIP              (1UL << 19) /* Enable accelerated IP */

General note for whole hfi2-abi.h file, it is unclear if you really need
and use all these fields.

<...>

> +#endif /* _LINIUX_HFI2_USER_H */
> diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
> index 89e6a3f13191..c7573131c862 100644
> --- a/include/uapi/rdma/ib_user_ioctl_verbs.h
> +++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
> @@ -256,6 +256,7 @@ enum rdma_driver_id {
>  	RDMA_DRIVER_ERDMA,
>  	RDMA_DRIVER_MANA,
>  	RDMA_DRIVER_IONIC,
> +	RDMA_DRIVER_HFI2,

This hunk should be separated and submitted as part of hfi2 addition.

>  };
>  
>  enum ib_uverbs_gid_type {
> diff --git a/include/uapi/rdma/rdma_user_ioctl.h b/include/uapi/rdma/rdma_user_ioctl.h
> index 53c55188dd2a..263cace86f8f 100644
> --- a/include/uapi/rdma/rdma_user_ioctl.h
> +++ b/include/uapi/rdma/rdma_user_ioctl.h
> @@ -39,47 +39,14 @@
>  #include <rdma/rdma_user_ioctl_cmds.h>
>  
>  /* Legacy name, for user space application which already use it */
> -#define IB_IOCTL_MAGIC		RDMA_IOCTL_MAGIC
> -
> -/*
> - * General blocks assignments
> - * It is closed on purpose - do not expose it to user space
> - * #define MAD_CMD_BASE		0x00
> - * #define HFI1_CMD_BAS		0xE0
> - */
> +#define IB_IOCTL_MAGIC RDMA_IOCTL_MAGIC
>  
>  /* MAD specific section */
> -#define IB_USER_MAD_REGISTER_AGENT	_IOWR(RDMA_IOCTL_MAGIC, 0x01, struct ib_user_mad_reg_req)
> -#define IB_USER_MAD_UNREGISTER_AGENT	_IOW(RDMA_IOCTL_MAGIC,  0x02, __u32)
> -#define IB_USER_MAD_ENABLE_PKEY		_IO(RDMA_IOCTL_MAGIC,   0x03)
> -#define IB_USER_MAD_REGISTER_AGENT2	_IOWR(RDMA_IOCTL_MAGIC, 0x04, struct ib_user_mad_reg_req2)
> -
> -/* HFI specific section */
> -/* allocate HFI and context */
> -#define HFI1_IOCTL_ASSIGN_CTXT		_IOWR(RDMA_IOCTL_MAGIC, 0xE1, struct hfi1_user_info)
> -/* find out what resources we got */
> -#define HFI1_IOCTL_CTXT_INFO		_IOW(RDMA_IOCTL_MAGIC,  0xE2, struct hfi1_ctxt_info)
> -/* set up userspace */
> -#define HFI1_IOCTL_USER_INFO		_IOW(RDMA_IOCTL_MAGIC,  0xE3, struct hfi1_base_info)
> -/* update expected TID entries */
> -#define HFI1_IOCTL_TID_UPDATE		_IOWR(RDMA_IOCTL_MAGIC, 0xE4, struct hfi1_tid_info)
> -/* free expected TID entries */
> -#define HFI1_IOCTL_TID_FREE		_IOWR(RDMA_IOCTL_MAGIC, 0xE5, struct hfi1_tid_info)
> -/* force an update of PIO credit */
> -#define HFI1_IOCTL_CREDIT_UPD		_IO(RDMA_IOCTL_MAGIC,   0xE6)
> -/* control receipt of packets */
> -#define HFI1_IOCTL_RECV_CTRL		_IOW(RDMA_IOCTL_MAGIC,  0xE8, int)
> -/* set the kind of polling we want */
> -#define HFI1_IOCTL_POLL_TYPE		_IOW(RDMA_IOCTL_MAGIC,  0xE9, int)
> -/* ack & clear user status bits */
> -#define HFI1_IOCTL_ACK_EVENT		_IOW(RDMA_IOCTL_MAGIC,  0xEA, unsigned long)
> -/* set context's pkey */
> -#define HFI1_IOCTL_SET_PKEY		_IOW(RDMA_IOCTL_MAGIC,  0xEB, __u16)
> -/* reset context's HW send context */
> -#define HFI1_IOCTL_CTXT_RESET		_IO(RDMA_IOCTL_MAGIC,   0xEC)
> -/* read TID cache invalidations */
> -#define HFI1_IOCTL_TID_INVAL_READ	_IOWR(RDMA_IOCTL_MAGIC, 0xED, struct hfi1_tid_info)
> -/* get the version of the user cdev */
> -#define HFI1_IOCTL_GET_VERS		_IOR(RDMA_IOCTL_MAGIC,  0xEE, int)
> +#define IB_USER_MAD_REGISTER_AGENT \
> +	_IOWR(RDMA_IOCTL_MAGIC, 0x01, struct ib_user_mad_reg_req)
> +#define IB_USER_MAD_UNREGISTER_AGENT _IOW(RDMA_IOCTL_MAGIC, 0x02, __u32)
> +#define IB_USER_MAD_ENABLE_PKEY _IO(RDMA_IOCTL_MAGIC, 0x03)
> +#define IB_USER_MAD_REGISTER_AGENT2 \
> +	_IOWR(RDMA_IOCTL_MAGIC, 0x04, struct ib_user_mad_reg_req2)

These changes are unrelated.

Thanks

>  
>  #endif /* RDMA_USER_IOCTL_H */
> 
> 

