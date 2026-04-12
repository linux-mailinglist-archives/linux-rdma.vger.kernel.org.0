Return-Path: <linux-rdma+bounces-19250-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uz0EG1+R22kTDgkAu9opvQ
	(envelope-from <linux-rdma+bounces-19250-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 14:34:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA19A3E3CB7
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 14:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87CB83005D1E
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B40126059D;
	Sun, 12 Apr 2026 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="GsfLgBKJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943BB2472A2
	for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2026 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775997221; cv=none; b=fOF9xVKFXpbBWRNNVopcYuo9uYYfda84OecZjeaYD7kder6nE50T36hOu/i2oXwfhmv/92XRwyU6bKQY9ixVb9T0v8ow47U7/oHZE39MZrGYfw3vT+EOPohSWC89UE752UTM+U5jRtmUi2ujGajK6tycV3ZQ8Et8KIJn5Oxa09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775997221; c=relaxed/simple;
	bh=ZRXLTlwIaKnExgrPdcDijsJOh//duCE1TJQe4SGx05E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5cS67U+KW1T/TXTreLf6ahVDMJxdEOP5K3KjIZqNzBlJMFwRNZ0peedLbWmlDQmwAQ/iegUKkbzdCIztsJp9VBgnBKrKOaovWYeTRluVh8L0KKUctuFOYL1a9DldmhINovZX/huITi1WUbvMXfM6QmHo29Wha9N7TOh8GpMPsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=GsfLgBKJ; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775997217; x=1807533217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V0s5tr8H2PDcKgeaadKCSnm3yNzX0mnK6MUNI3oFMU4=;
  b=GsfLgBKJhjYxVseapphD6WTSKM6pdBm/0zFAti6kGD+aoikHPo1QVydQ
   wO8akrpxUsqlK0dTAPVJrom61Jo6zW+5fBm1Q3csQN859QGchEaZtDB2I
   AIXWzuUj8xYJfdccUy5w+dOHXSlJgElAFCu/Lp96l7oV9VDYhpA9NPTkT
   aHeQ9RMkiq2uQP+NsvCXCdN5TvtHxWyZv8pkFaixlUAtSSq0XyAyXeoXt
   I4dJrpL/9uVab7kyqa2BrrOEeFmalCA5Mi7eFSSmh4MDg6Jk1lT4o1/ZJ
   SprDDPxaZ3b1fbNrTvYmNsObLGk4yQmzNCeLxM13h7DzTuRM6D/AjEzsG
   A==;
X-CSE-ConnectionGUID: WCjkdQGcRWK0dMLX4i2uQQ==
X-CSE-MsgGUID: 5EygDbzvRvmt8/SmS8cryA==
X-IronPort-AV: E=Sophos;i="6.23,175,1770595200"; 
   d="scan'208";a="16910294"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 12:33:34 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:30020]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.232:2525] with esmtp (Farcaster)
 id a33374bf-0c8e-4a8d-aa1f-c6251fb640ab; Sun, 12 Apr 2026 12:33:34 +0000 (UTC)
X-Farcaster-Flow-ID: a33374bf-0c8e-4a8d-aa1f-c6251fb640ab
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 12 Apr 2026 12:33:33 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Sun, 12 Apr 2026
 12:33:29 +0000
Date: Sun, 12 Apr 2026 12:33:22 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: <linux-rdma@vger.kernel.org>, <jgg@ziepe.ca>, <leon@kernel.org>,
	<gal.pressman@linux.dev>, <sleybo@amazon.com>, <parav@nvidia.com>,
	<mbloch@nvidia.com>, <yanjun.zhu@linux.dev>, <marco.crivellari@suse.com>,
	<roman.gushchin@linux.dev>, <phaddad@nvidia.com>, <lirongqing@baidu.com>,
	<ynachum@amazon.com>, <huangjunxian6@hisilicon.com>,
	<kalesh-anakkur.purayil@broadcom.com>, <ohartoov@nvidia.com>,
	<michaelgur@nvidia.com>, <shayd@nvidia.com>, <edwards@nvidia.com>,
	<sriharsha.basavapatna@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-next v2 01/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260412123322.GA5166@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260411144915.114571-2-jiri@resnulli.us>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19250-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[amazon.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AA19A3E3CB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 04:49:01PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add a unified mechanism for userspace to pass memory buffers to any
> uverbs command via a single UVERBS_ATTR_BUFFERS attribute. Each
> buffer is described by struct ib_uverbs_buffer_desc with a type
> discriminator supporting dma-buf and user VA backed memory, extensible
> for future buffer types.
> 
> The ib_umem_list API enables any uverbs command to accept multiple
> buffers indexed by per-command slot enums, without requiring new UAPI
> attributes for each buffer. A consumption check ensures userspace and
> driver agree on which buffers are used.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c          | 248 ++++++++++++++++++++++++
>  include/rdma/ib_umem.h                  |  54 ++++++
>  include/rdma/uverbs_ioctl.h             |  14 ++
>  include/uapi/rdma/ib_user_ioctl_cmds.h  |   1 +
>  include/uapi/rdma/ib_user_ioctl_verbs.h |  27 +++
>  5 files changed, 344 insertions(+)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 786fa1aa8e55..f5b03e903b9d 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -37,6 +37,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
> +#include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/pagemap.h>
> @@ -332,3 +333,250 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>  		return 0;
>  }
>  EXPORT_SYMBOL(ib_umem_copy_from);
> +
> +struct ib_umem_list {
> +	unsigned int count; /* Total slots in the list. */
> +	unsigned long provided; /* Bitmask of slots provided by the user. */
> +	unsigned long loaded; /* Bitmask of slots loaded by the driver. */
> +	struct ib_umem *umems[] __counted_by(count);
> +};
> +
> +/**
> + * ib_umem_list_create - Create a umem list from UVERBS_ATTR_BUFFERS
> + * @device: IB device
> + * @attrs: uverbs attribute bundle
> + * @slot_max: highest buffer slot index (count = slot_max + 1)
> + *
> + * Return: umem list, or ERR_PTR on failure.
> + */
> +struct ib_umem_list *ib_umem_list_create(struct ib_device *device,
> +					 const struct uverbs_attr_bundle *attrs,
> +					 unsigned int slot_max)
> +{
> +	const struct ib_uverbs_buffer_desc *descs;
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +	struct ib_umem_list *list;
> +	struct ib_umem *umem;
> +	unsigned int count;
> +	int num_descs;
> +	int err;
> +	int i;
> +
> +	if (WARN_ON_ONCE(slot_max >= BITS_PER_LONG))
> +		return ERR_PTR(-EINVAL);
> +	count = slot_max + 1;
> +
> +	num_descs = uverbs_attr_ptr_get_array_size(
> +		(struct uverbs_attr_bundle *)attrs, UVERBS_ATTR_BUFFERS,
> +		sizeof(*descs));
> +	if (num_descs == -ENOENT) {
> +		num_descs = 0;
> +		descs = NULL;
> +	} else if (num_descs < 0) {
> +		return ERR_PTR(num_descs);
> +	} else if (num_descs > count) {
> +		return ERR_PTR(-EINVAL);
> +	} else {
> +		descs = uverbs_attr_get_alloced_ptr(attrs, UVERBS_ATTR_BUFFERS);
> +		if (IS_ERR(descs))
> +			return ERR_CAST(descs);
> +	}
> +
> +	list = kzalloc(struct_size(list, umems, count), GFP_KERNEL);
> +	if (!list)
> +		return ERR_PTR(-ENOMEM);
> +	list->count = count;
> +
> +	for (i = 0; i < num_descs; i++) {

While I like the idea of standardizing the way we pass buffer
information to the kernel, the list thing looks like over generalization
to me, especially after Leon's refactoring of CQ creation. Maybe we can
add buffer as a new attribute type that can be used for multiple
parameters in a command, and have a helper with the code below that
takes an attribute id and returns a umem object, letting each handler
store it. This would also make it easier for drivers to pass their
private buffers using this infrastructure.

Michael

> +		unsigned int idx = descs[i].index;
> +
> +		if (descs[i].reserved) {
> +			err = -EINVAL;
> +			goto err_release;
> +		}
> +		if (idx >= count || (list->provided & BIT(idx))) {
> +			err = -EINVAL;
> +			goto err_release;
> +		}
> +
> +		switch (descs[i].type) {
> +		case IB_UVERBS_BUFFER_TYPE_DMABUF:
> +			umem_dmabuf = ib_umem_dmabuf_get_pinned(
> +				device, descs[i].addr, descs[i].length,
> +				descs[i].fd, IB_ACCESS_LOCAL_WRITE);
> +			if (IS_ERR(umem_dmabuf)) {
> +				err = PTR_ERR(umem_dmabuf);
> +				goto err_release;
> +			}
> +			list->umems[idx] = &umem_dmabuf->umem;
> +			break;
> +		case IB_UVERBS_BUFFER_TYPE_VA:
> +			umem = ib_umem_get(device, descs[i].addr,
> +					   descs[i].length, IB_ACCESS_LOCAL_WRITE);
> +			if (IS_ERR(umem)) {
> +				err = PTR_ERR(umem);
> +				goto err_release;
> +			}
> +			list->umems[idx] = umem;
> +			break;
> +		default:
> +			err = -EINVAL;
> +			goto err_release;
> +		}
> +		list->provided |= BIT(idx);
> +	}
> +
> +	return list;
> +
> +err_release:
> +	ib_umem_list_release(list);
> +	return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL(ib_umem_list_create);
> +
> +/**
> + * ib_umem_list_release - Release all umems in the list and free it
> + * @list: umem list
> + */
> +void ib_umem_list_release(struct ib_umem_list *list)
> +{
> +	int i;
> +
> +	if (!list)
> +		return;
> +	for (i = 0; i < list->count; i++)
> +		ib_umem_release(list->umems[i]);
> +	kfree(list);
> +}
> +EXPORT_SYMBOL(ib_umem_list_release);
> +
> +/**
> + * ib_umem_list_check_consumed - Verify all provided umems were loaded
> + * @list: umem list
> + *
> + * Return: 0 if all provided slots were loaded, -EINVAL otherwise.
> + */
> +int ib_umem_list_check_consumed(const struct ib_umem_list *list)
> +{
> +	return (list->provided & ~list->loaded) == 0 ? 0 : -EINVAL;
> +}
> +EXPORT_SYMBOL(ib_umem_list_check_consumed);
> +
> +/**
> + * ib_umem_list_insert - Insert a umem into the list at a given index
> + * @list: umem list
> + * @index: per-command buffer slot index
> + * @umem: umem pointer to store
> + *
> + * Stores @umem at @index (replacing any existing). For use from create_cq
> + * when the buffer comes from legacy ATTRs rather than the buffer list.
> + */
> +void ib_umem_list_insert(struct ib_umem_list *list, unsigned int index,
> +			 struct ib_umem *umem)
> +{
> +	ib_umem_list_replace(list, index, umem);
> +	if (umem)
> +		list->provided |= BIT(index);
> +}
> +EXPORT_SYMBOL(ib_umem_list_insert);
> +
> +/**
> + * ib_umem_list_load - Load a umem from the list by index
> + * @list: umem list (may be NULL)
> + * @index: per-command buffer slot index
> + * @size: minimum required umem length
> + *
> + * Return: umem pointer, or NULL if the slot is empty or
> + * the slot is out of bounds, or ERR_PTR(-EINVAL) if the umem is too small.
> + */
> +struct ib_umem *ib_umem_list_load(struct ib_umem_list *list,
> +				 unsigned int index, size_t size)
> +{
> +	struct ib_umem *umem;
> +
> +	if (!list || index >= list->count)
> +		return NULL;
> +	umem = list->umems[index];
> +	if (!umem)
> +		return NULL;
> +	if (umem->length < size)
> +		return ERR_PTR(-EINVAL);
> +	list->loaded |= BIT(index);
> +	return umem;
> +}
> +EXPORT_SYMBOL(ib_umem_list_load);
> +
> +/**
> + * ib_umem_list_load_or_get - Umem from list or pin user memory
> + * @list: umem list (may be NULL)
> + * @index: per-command buffer slot index
> + * @device: IB device for ib_umem_get when the list slot is empty
> + * @addr: user virtual address for ib_umem_get
> + * @size: length for ib_umem_get
> + * @access: access flags for ib_umem_get
> + *
> + * If @list has a umem at @index, returns it like ib_umem_list_load() (and
> + * marks the slot loaded). Otherwise calls ib_umem_get() with the given
> + * @access flags and on success stores the result at @index when
> + * @list is non-NULL.
> + *
> + * Return: valid umem pointer, or ERR_PTR.
> + */
> +struct ib_umem *ib_umem_list_load_or_get(struct ib_umem_list *list,
> +					 unsigned int index,
> +					 struct ib_device *device,
> +					 unsigned long addr, size_t size,
> +					 int access)
> +{
> +	struct ib_umem *umem;
> +
> +	umem = ib_umem_list_load(list, index, size);
> +	if (IS_ERR(umem) || umem)
> +		return umem;
> +	umem = ib_umem_get(device, addr, size, access);
> +	if (IS_ERR(umem))
> +		return umem;
> +	if (list && index < list->count)
> +		list->umems[index] = umem;
> +	return umem;
> +}
> +EXPORT_SYMBOL(ib_umem_list_load_or_get);
> +
> +/**
> + * ib_umem_list_replace - Replace umem at index, releasing the previous one
> + * @list: umem list (may be NULL)
> + * @index: per-command buffer slot index
> + * @umem: new umem pointer (may be NULL to clear the slot)
> + *
> + * Stores @umem at @index. If a different umem was already stored there, it is
> + * released. Used for CQ resize and similar.
> + */
> +void ib_umem_list_replace(struct ib_umem_list *list, unsigned int index,
> +			  struct ib_umem *umem)
> +{
> +	struct ib_umem *old;
> +
> +	if (!list || index >= list->count)
> +		return;
> +	old = list->umems[index];
> +	list->umems[index] = umem;
> +	if (old && old != umem)
> +		ib_umem_release(old);
> +}
> +EXPORT_SYMBOL(ib_umem_list_replace);
> +
> +/**
> + * ib_umem_release_non_listed - Release a umem that is not stored in the list
> + * @list: umem list
> + * @index: per-command buffer slot index
> + * @umem: umem pointer to release
> + *
> + * Releases @umem if it is not stored in @list.
> + */
> +void ib_umem_release_non_listed(struct ib_umem_list *list, unsigned int index,
> +				struct ib_umem *umem)
> +{
> +	if (!list || index >= list->count || list->umems[index] != umem)
> +		ib_umem_release(umem);
> +}
> +EXPORT_SYMBOL(ib_umem_release_non_listed);
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
> index 2ad52cc1d52b..924acb8d08c3 100644
> --- a/include/rdma/ib_umem.h
> +++ b/include/rdma/ib_umem.h
> @@ -11,6 +11,7 @@
>  
>  struct ib_device;
>  struct dma_buf_attach_ops;
> +struct uverbs_attr_bundle;
>  
>  struct ib_umem {
>  	struct ib_device       *ibdev;
> @@ -80,6 +81,36 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
>  void ib_umem_release(struct ib_umem *umem);
>  int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>  		      size_t length);
> +
> +/**
> + * struct ib_umem_list - collection of pre-mapped umems
> + *
> + * Created from the UVERBS_ATTR_BUFFERS attribute. Each entry is indexed
> + * by a per-command buffer slot enum (e.g., IB_UMEM_CQ_BUF for CQ CREATE).
> + * Drivers use ib_umem_list_load() to retrieve a specific umem by index.
> + */
> +struct ib_umem_list;
> +
> +struct ib_umem_list *ib_umem_list_create(struct ib_device *device,
> +					 const struct uverbs_attr_bundle *attrs,
> +					 unsigned int slot_max);
> +void ib_umem_list_release(struct ib_umem_list *list);
> +int ib_umem_list_check_consumed(const struct ib_umem_list *list);
> +void ib_umem_list_insert(struct ib_umem_list *list, unsigned int index,
> +			 struct ib_umem *umem);
> +
> +struct ib_umem *ib_umem_list_load(struct ib_umem_list *list,
> +				  unsigned int index, size_t size);
> +struct ib_umem *ib_umem_list_load_or_get(struct ib_umem_list *list,
> +					 unsigned int index,
> +					 struct ib_device *device,
> +					 unsigned long addr, size_t size,
> +					 int access);
> +void ib_umem_list_replace(struct ib_umem_list *list, unsigned int index,
> +			  struct ib_umem *umem);
> +void ib_umem_release_non_listed(struct ib_umem_list *list, unsigned int index,
> +				struct ib_umem *umem);
> +
>  unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
>  				     unsigned long pgsz_bitmap,
>  				     unsigned long virt);
> @@ -230,5 +261,28 @@ static inline void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf
>  static inline void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf) {}
>  static inline void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf) {}
>  
> +struct ib_umem_list;
> +
> +static inline void ib_umem_list_release(struct ib_umem_list *list) { }
> +static inline struct ib_umem *ib_umem_list_load(struct ib_umem_list *list,
> +						unsigned int index,
> +						size_t size)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +static inline struct ib_umem *
> +ib_umem_list_load_or_get(struct ib_umem_list *list, unsigned int index,
> +			 struct ib_device *device, unsigned long addr,
> +			 size_t size, int access)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +static inline void ib_umem_list_replace(struct ib_umem_list *list,
> +					unsigned int index,
> +					struct ib_umem *umem) { }
> +static inline void ib_umem_release_non_listed(struct ib_umem_list *list,
> +					      unsigned int index,
> +					      struct ib_umem *umem) { }
> +
>  #endif /* CONFIG_INFINIBAND_USER_MEM */
>  #endif /* IB_UMEM_H */
> diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
> index e2af17da3e32..05bcab27a87d 100644
> --- a/include/rdma/uverbs_ioctl.h
> +++ b/include/rdma/uverbs_ioctl.h
> @@ -590,6 +590,20 @@ struct uapi_definition {
>  			    UA_OPTIONAL,                                       \
>  			    .is_udata = 1)
>  
> +/*
> + * Optional array of struct ib_uverbs_buffer_desc describing memory regions
> + * backed by dma-buf or user virtual address. Can be added to any method
> + * that needs external buffer support.
> + * Each entry carries an index field selecting the per-command buffer slot.
> + * Use ib_umem_list_create() to map them and ib_umem_list_load() to access.
> + */
> +#define UVERBS_ATTR_BUFFERS()                                                  \
> +	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_BUFFERS,                               \
> +			   UVERBS_ATTR_MIN_SIZE(                               \
> +				sizeof(struct ib_uverbs_buffer_desc)),         \
> +			   UA_OPTIONAL,                                        \
> +			   UA_ALLOC_AND_COPY)
> +
>  /* =================================================
>   *              Parsing infrastructure
>   * =================================================
> diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
> index 72041c1b0ea5..10aa6568abf1 100644
> --- a/include/uapi/rdma/ib_user_ioctl_cmds.h
> +++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
> @@ -64,6 +64,7 @@ enum {
>  	UVERBS_ATTR_UHW_IN = UVERBS_ID_DRIVER_NS,
>  	UVERBS_ATTR_UHW_OUT,
>  	UVERBS_ID_DRIVER_NS_WITH_UHW,
> +	UVERBS_ATTR_BUFFERS,
>  };
>  
>  enum uverbs_methods_device {
> diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
> index 90c5cd8e7753..41ed9f75b4de 100644
> --- a/include/uapi/rdma/ib_user_ioctl_verbs.h
> +++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
> @@ -273,4 +273,31 @@ struct ib_uverbs_gid_entry {
>  	__u32 netdev_ifindex; /* It is 0 if there is no netdev associated with it */
>  };
>  
> +enum ib_uverbs_buffer_type {
> +	IB_UVERBS_BUFFER_TYPE_DMABUF,
> +	IB_UVERBS_BUFFER_TYPE_VA,
> +};
> +
> +/*
> + * Describes a single buffer backed by dma-buf or user virtual address.
> + * Passed as an array via UVERBS_ATTR_BUFFERS. Each uverb command that
> + * accepts this attribute defines its own per-command buffer slot enum.
> + * The index field selects the buffer slot this descriptor maps to.
> + *
> + * @fd: dma-buf file descriptor (valid for IB_UVERBS_BUFFER_TYPE_DMABUF)
> + * @type: buffer type from enum ib_uverbs_buffer_type
> + * @index: per-command buffer slot index
> + * @reserved: must be zero
> + * @addr: offset within dma-buf, or user virtual address for VA
> + * @length: buffer length in bytes
> + */
> +struct ib_uverbs_buffer_desc {
> +	__s32 fd;
> +	__u32 type;
> +	__u32 index;
> +	__u32 reserved;
> +	__aligned_u64 addr;
> +	__aligned_u64 length;
> +};
> +
>  #endif
> -- 
> 2.53.0
> 

