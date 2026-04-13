Return-Path: <linux-rdma+bounces-19304-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKSoIO003Wl9agkAu9opvQ
	(envelope-from <linux-rdma+bounces-19304-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 20:24:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C113F1F3B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 20:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24C91303BB00
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 18:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971ED23D7E6;
	Mon, 13 Apr 2026 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="t8ojyfFc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384F34CFAB
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104541; cv=none; b=tNH6n9oiNnUnmscJ4Pl4qtY/UrqjNG5ix3WJwyFJ8iqlKhXitk+pv2UC94hssxt4adSzGv8QXg4pcPq1x+WeUZYNp8owdfakCxR4fS42sh1/ihja0oxkQCE1xJThrhlah2/zcXRGVI0DAerrgIfLVv3lN2mJeKiOFOeY/KA9zII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104541; c=relaxed/simple;
	bh=TvuKXD6drq6jAfG59toBFhKgx3hm+m0eovww4l+kKGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS4p5fBtnxwAOcDcmbjxqRxTDWapi08xhRRywPMDsW8e3p+RoM4dbhqsuln3yUJpfJbfd2uxDwHl9WCue4gA+0GcM+64QwsH+cWzwAROWCSILTshLFNxsgqZ4SnysNsLUDM4wOkP6PcH6ZAuYmW8uX8qCmA5BEG3H23DaTt7U5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=t8ojyfFc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488971db0fdso47005105e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776104531; x=1776709331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UtnmW/a3y25xO3XBT5TpcNqGUoG6+XDdkG3ZTmfBt4=;
        b=t8ojyfFccNhoBLyP2z3S/a12UgIiOyg7IVYYPMF6GN8TtHN5R2MMSGNYUBH8llB1OH
         +V7p1zFIMLFQ4qNmemRhtVM17wkiiRpy3R3/H560IAMXRHiiJl6VnoX5iS/GUBDxSANs
         5CUB60rutqphIgV1tzbtLC/SB3Y4v7LucylffKHwA8tb2MX91fR/dh1l21KYLH8X2eku
         3p2p37v/frBL8WeW01vNElvFmphNxrXIbEdbYqJ86tVlE/XBwLR6518Wb5nGHrWaJnFH
         q6X+r31KBPTUXXIVh5rt2GdrwZc8koR81vlpF3AJCUp7/igJbC9iEPT0WSe9qQOh1JOr
         +aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776104531; x=1776709331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UtnmW/a3y25xO3XBT5TpcNqGUoG6+XDdkG3ZTmfBt4=;
        b=SebFLmsTEmYuOt4nYcXQ2iLFa0pKSOnysxG9sVJAgBuNKvyG0vWjvcapiPeZSsy54M
         nCfbMG31X0b62iRC4IpIULRdkNfI9jejDXrfooL6+f6j51khmfeMezV8W1yeEbZ5ah92
         ZzYRmjvxI54fS4gMXMpEJmVVDeImb9ab3X66JKTohLD3PQ4Y4szy5TmLlQujQ47o5k3E
         76gQXdwl/4oGtC22mHI38TrOBxJF/XLul+jrvztd9eeUiEFsPGLr6PyAteSWidSb/7Dj
         2LIuRgSNaQ76ZyADH54xjR1x2Uyqe/s/6UJAc6aXGcW0Y2QYdwafsjzuB7xBYO9kZT0l
         oFRg==
X-Gm-Message-State: AOJu0YwwzDWPeSDQsGcogkpD4WZqU/+g9Ng3ss0PBwZCuceB0VQhRz2l
	hPw+ltXTG7qOVobNwL1h8ijEknqZUJVOeQ1bKT+9loddp+O2dXxkE0vfcOZFa9R4B0k=
X-Gm-Gg: AeBDieuT4IO6192qErrMxpr5O2a1tzVOougtHBEhFlGeyVQO7lfdVhJ199uhWiCiRTH
	48eVGNbwIvpslJBumqicr6JFw5qUTqasKxMWyd3iyLzJUUGkt/s+OAGaeQjwDfCJx8IFp7Rhziw
	+uo8BijOfmS789wRCXg+yZaBzoXCWwT7nPA5LeDA8z3ZwyiwEPziFJHs+3OujU7+t6WkDJakdwi
	f/k4FgF/hj6CH94u6LFrtaspoW+gvpsDGbCZS5f0WnIcYR4bdwMadVG3CBLNGNgMKNNjbxkisQQ
	BdC03L0MIh6z4kzj8mEMjXMHiSPeFb1tanI6GH/egtIOK6Yvd+qRCOHaxZzZcGi/64WFGXMDQ7B
	FBNWJcgnxhlCUiIWrxW9J6fbZZchoohi0da4eU+Fm5blEtowD2ZQ4oc7kGcpawXf/d7XXyiixon
	F6vTAM6B9fJPbfUnNstrna4B0zEVp/HQE=
X-Received: by 2002:a05:600c:45cd:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-488d67f0bb7mr174537175e9.10.1776104531222;
        Mon, 13 Apr 2026 11:22:11 -0700 (PDT)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5888acbsm370083005e9.1.2026.04.13.11.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:22:10 -0700 (PDT)
Date: Mon, 13 Apr 2026 20:22:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michael Margolin <mrgolin@amazon.com>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v2 01/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <dy6nbf2vibl3aeopeb7im7fksh5436isqcmcarghkm5e2ontoi@unvvimhthp53>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260412123322.GA5166@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <fzughzkkr5zkr436pdzu6p2j4sdlphtxpbbpztxoerbms6a37f@4dzcxphdyjg2>
 <20260413160232.GA21984@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413160232.GA21984@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19304-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C5C113F1F3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Apr 13, 2026 at 06:02:32PM +0200, mrgolin@amazon.com wrote:
>On Mon, Apr 13, 2026 at 10:32:15AM +0200, Jiri Pirko wrote:
>> Sun, Apr 12, 2026 at 02:33:22PM +0200, mrgolin@amazon.com wrote:
>> >On Sat, Apr 11, 2026 at 04:49:01PM +0200, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> Add a unified mechanism for userspace to pass memory buffers to any
>> >> uverbs command via a single UVERBS_ATTR_BUFFERS attribute. Each
>> >> buffer is described by struct ib_uverbs_buffer_desc with a type
>> >> discriminator supporting dma-buf and user VA backed memory, extensible
>> >> for future buffer types.
>> >> 
>> >> The ib_umem_list API enables any uverbs command to accept multiple
>> >> buffers indexed by per-command slot enums, without requiring new UAPI
>> >> attributes for each buffer. A consumption check ensures userspace and
>> >> driver agree on which buffers are used.
>> >> 
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> ---
>> >>  drivers/infiniband/core/umem.c          | 248 ++++++++++++++++++++++++
>> >>  include/rdma/ib_umem.h                  |  54 ++++++
>> >>  include/rdma/uverbs_ioctl.h             |  14 ++
>> >>  include/uapi/rdma/ib_user_ioctl_cmds.h  |   1 +
>> >>  include/uapi/rdma/ib_user_ioctl_verbs.h |  27 +++
>> >>  5 files changed, 344 insertions(+)
>> >> 
>> >> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
>> >> index 786fa1aa8e55..f5b03e903b9d 100644
>> >> --- a/drivers/infiniband/core/umem.c
>> >> +++ b/drivers/infiniband/core/umem.c
>> >> @@ -37,6 +37,7 @@
>> >>  #include <linux/dma-mapping.h>
>> >>  #include <linux/sched/signal.h>
>> >>  #include <linux/sched/mm.h>
>> >> +#include <linux/err.h>
>> >>  #include <linux/export.h>
>> >>  #include <linux/slab.h>
>> >>  #include <linux/pagemap.h>
>> >> @@ -332,3 +333,250 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>> >>  		return 0;
>> >>  }
>> >>  EXPORT_SYMBOL(ib_umem_copy_from);
>> >> +
>> >> +struct ib_umem_list {
>> >> +	unsigned int count; /* Total slots in the list. */
>> >> +	unsigned long provided; /* Bitmask of slots provided by the user. */
>> >> +	unsigned long loaded; /* Bitmask of slots loaded by the driver. */
>> >> +	struct ib_umem *umems[] __counted_by(count);
>> >> +};
>> >> +
>> >> +/**
>> >> + * ib_umem_list_create - Create a umem list from UVERBS_ATTR_BUFFERS
>> >> + * @device: IB device
>> >> + * @attrs: uverbs attribute bundle
>> >> + * @slot_max: highest buffer slot index (count = slot_max + 1)
>> >> + *
>> >> + * Return: umem list, or ERR_PTR on failure.
>> >> + */
>> >> +struct ib_umem_list *ib_umem_list_create(struct ib_device *device,
>> >> +					 const struct uverbs_attr_bundle *attrs,
>> >> +					 unsigned int slot_max)
>> >> +{
>> >> +	const struct ib_uverbs_buffer_desc *descs;
>> >> +	struct ib_umem_dmabuf *umem_dmabuf;
>> >> +	struct ib_umem_list *list;
>> >> +	struct ib_umem *umem;
>> >> +	unsigned int count;
>> >> +	int num_descs;
>> >> +	int err;
>> >> +	int i;
>> >> +
>> >> +	if (WARN_ON_ONCE(slot_max >= BITS_PER_LONG))
>> >> +		return ERR_PTR(-EINVAL);
>> >> +	count = slot_max + 1;
>> >> +
>> >> +	num_descs = uverbs_attr_ptr_get_array_size(
>> >> +		(struct uverbs_attr_bundle *)attrs, UVERBS_ATTR_BUFFERS,
>> >> +		sizeof(*descs));
>> >> +	if (num_descs == -ENOENT) {
>> >> +		num_descs = 0;
>> >> +		descs = NULL;
>> >> +	} else if (num_descs < 0) {
>> >> +		return ERR_PTR(num_descs);
>> >> +	} else if (num_descs > count) {
>> >> +		return ERR_PTR(-EINVAL);
>> >> +	} else {
>> >> +		descs = uverbs_attr_get_alloced_ptr(attrs, UVERBS_ATTR_BUFFERS);
>> >> +		if (IS_ERR(descs))
>> >> +			return ERR_CAST(descs);
>> >> +	}
>> >> +
>> >> +	list = kzalloc(struct_size(list, umems, count), GFP_KERNEL);
>> >> +	if (!list)
>> >> +		return ERR_PTR(-ENOMEM);
>> >> +	list->count = count;
>> >> +
>> >> +	for (i = 0; i < num_descs; i++) {
>> >
>> >While I like the idea of standardizing the way we pass buffer
>> >information to the kernel, the list thing looks like over generalization
>> >to me, especially after Leon's refactoring of CQ creation. Maybe we can
>> >add buffer as a new attribute type that can be used for multiple
>> >parameters in a command, and have a helper with the code below that
>> >takes an attribute id and returns a umem object, letting each handler
>> >store it. This would also make it easier for drivers to pass their
>> >private buffers using this infrastructure.
>> 
>> Currently we have set of attrs (4) to pass CQ umem. I tried to make this
>> very smooth for all possible uverbs, passing single attr of array of
>> structs describing a buffer. Uverb attr api knows how to work with
>> arrays, all clicks.
>> 
>> Drivers can easily pass their specific buffers over this list too. I
>> didn't implement it as there was no need, but the idea is to have index>X
>> for driver specific indexes.
>
>Why do we need to invent a new way instead of just adding another
>argument in a command, that consists of all the info needed to pass a
>buffer? Also how can this work for objects that have only private umem?

You can put the buf array attr to any uverb, some may not have
"standard" indexes.


>
>> What's the benefit of passing per-uverb attrs with a struct? Perhaps I'm
>> missing something.
>
>Mostly simplification by untying two unrelated things:
>1) way of passing args to kernel
>2) object lifetime management

Could you be more specific please?


>
>And also significantly reducing the amount of code changes required to
>achieve this.

Significantly? I'm not sure I follow, but I guess that is related to my
previous question. I'm not sure I understand what you have exacly in
mind. Regarding UAPI, I think I understand, but regarding kernel
internals, I don't :(


>
>Michael
>
>> >
>> >> +		unsigned int idx = descs[i].index;
>> >> +
>> >> +		if (descs[i].reserved) {
>> >> +			err = -EINVAL;
>> >> +			goto err_release;
>> >> +		}
>> >> +		if (idx >= count || (list->provided & BIT(idx))) {
>> >> +			err = -EINVAL;
>> >> +			goto err_release;
>> >> +		}
>> >> +
>> >> +		switch (descs[i].type) {
>> >> +		case IB_UVERBS_BUFFER_TYPE_DMABUF:
>> >> +			umem_dmabuf = ib_umem_dmabuf_get_pinned(
>> >> +				device, descs[i].addr, descs[i].length,
>> >> +				descs[i].fd, IB_ACCESS_LOCAL_WRITE);
>> >> +			if (IS_ERR(umem_dmabuf)) {
>> >> +				err = PTR_ERR(umem_dmabuf);
>> >> +				goto err_release;
>> >> +			}
>> >> +			list->umems[idx] = &umem_dmabuf->umem;
>> >> +			break;
>> >> +		case IB_UVERBS_BUFFER_TYPE_VA:
>> >> +			umem = ib_umem_get(device, descs[i].addr,
>> >> +					   descs[i].length, IB_ACCESS_LOCAL_WRITE);
>> >> +			if (IS_ERR(umem)) {
>> >> +				err = PTR_ERR(umem);
>> >> +				goto err_release;
>> >> +			}
>> >> +			list->umems[idx] = umem;
>> >> +			break;
>> >> +		default:
>> >> +			err = -EINVAL;
>> >> +			goto err_release;
>> >> +		}
>> >> +		list->provided |= BIT(idx);
>> >> +	}
>> >> +
>> >> +	return list;
>> >> +
>> >> +err_release:
>> >> +	ib_umem_list_release(list);
>> >> +	return ERR_PTR(err);
>> >> +}
>> >> +EXPORT_SYMBOL(ib_umem_list_create);
>> >> +
>> >> +/**
>> >> + * ib_umem_list_release - Release all umems in the list and free it
>> >> + * @list: umem list
>> >> + */
>> >> +void ib_umem_list_release(struct ib_umem_list *list)
>> >> +{
>> >> +	int i;
>> >> +
>> >> +	if (!list)
>> >> +		return;
>> >> +	for (i = 0; i < list->count; i++)
>> >> +		ib_umem_release(list->umems[i]);
>> >> +	kfree(list);
>> >> +}
>> >> +EXPORT_SYMBOL(ib_umem_list_release);
>> >> +
>> >> +/**
>> >> + * ib_umem_list_check_consumed - Verify all provided umems were loaded
>> >> + * @list: umem list
>> >> + *
>> >> + * Return: 0 if all provided slots were loaded, -EINVAL otherwise.
>> >> + */
>> >> +int ib_umem_list_check_consumed(const struct ib_umem_list *list)
>> >> +{
>> >> +	return (list->provided & ~list->loaded) == 0 ? 0 : -EINVAL;
>> >> +}
>> >> +EXPORT_SYMBOL(ib_umem_list_check_consumed);
>> >> +
>> >> +/**
>> >> + * ib_umem_list_insert - Insert a umem into the list at a given index
>> >> + * @list: umem list
>> >> + * @index: per-command buffer slot index
>> >> + * @umem: umem pointer to store
>> >> + *
>> >> + * Stores @umem at @index (replacing any existing). For use from create_cq
>> >> + * when the buffer comes from legacy ATTRs rather than the buffer list.
>> >> + */
>> >> +void ib_umem_list_insert(struct ib_umem_list *list, unsigned int index,
>> >> +			 struct ib_umem *umem)
>> >> +{
>> >> +	ib_umem_list_replace(list, index, umem);
>> >> +	if (umem)
>> >> +		list->provided |= BIT(index);
>> >> +}
>> >> +EXPORT_SYMBOL(ib_umem_list_insert);
>> >> +
>> >> +/**
>> >> + * ib_umem_list_load - Load a umem from the list by index
>> >> + * @list: umem list (may be NULL)
>> >> + * @index: per-command buffer slot index
>> >> + * @size: minimum required umem length
>> >> + *
>> >> + * Return: umem pointer, or NULL if the slot is empty or
>> >> + * the slot is out of bounds, or ERR_PTR(-EINVAL) if the umem is too small.
>> >> + */
>> >> +struct ib_umem *ib_umem_list_load(struct ib_umem_list *list,
>> >> +				 unsigned int index, size_t size)
>> >> +{
>> >> +	struct ib_umem *umem;
>> >> +
>> >> +	if (!list || index >= list->count)
>> >> +		return NULL;
>> >> +	umem = list->umems[index];
>> >> +	if (!umem)
>> >> +		return NULL;
>> >> +	if (umem->length < size)
>> >> +		return ERR_PTR(-EINVAL);
>> >> +	list->loaded |= BIT(index);
>> >> +	return umem;
>> >> +}
>> >> +EXPORT_SYMBOL(ib_umem_list_load);
>> >> +
>> >> +/**
>> >> + * ib_umem_list_load_or_get - Umem from list or pin user memory
>> >> + * @list: umem list (may be NULL)
>> >> + * @index: per-command buffer slot index
>> >> + * @device: IB device for ib_umem_get when the list slot is empty
>> >> + * @addr: user virtual address for ib_umem_get
>> >> + * @size: length for ib_umem_get
>> >> + * @access: access flags for ib_umem_get
>> >> + *
>> >> + * If @list has a umem at @index, returns it like ib_umem_list_load() (and
>> >> + * marks the slot loaded). Otherwise calls ib_umem_get() with the given
>> >> + * @access flags and on success stores the result at @index when
>> >> + * @list is non-NULL.
>> >> + *
>> >> + * Return: valid umem pointer, or ERR_PTR.
>> >> + */
>> >> +struct ib_umem *ib_umem_list_load_or_get(struct ib_umem_list *list,
>> >> +					 unsigned int index,
>> >> +					 struct ib_device *device,
>> >> +					 unsigned long addr, size_t size,
>> >> +					 int access)
>> >> +{
>> >> +	struct ib_umem *umem;
>> >> +
>> >> +	umem = ib_umem_list_load(list, index, size);
>> >> +	if (IS_ERR(umem) || umem)
>> >> +		return umem;
>> >> +	umem = ib_umem_get(device, addr, size, access);
>> >> +	if (IS_ERR(umem))
>> >> +		return umem;
>> >> +	if (list && index < list->count)
>> >> +		list->umems[index] = umem;
>> >> +	return umem;
>> >> +}
>> >> +EXPORT_SYMBOL(ib_umem_list_load_or_get);
>> >> +
>> >> +/**
>> >> + * ib_umem_list_replace - Replace umem at index, releasing the previous one
>> >> + * @list: umem list (may be NULL)
>> >> + * @index: per-command buffer slot index
>> >> + * @umem: new umem pointer (may be NULL to clear the slot)
>> >> + *
>> >> + * Stores @umem at @index. If a different umem was already stored there, it is
>> >> + * released. Used for CQ resize and similar.
>> >> + */
>> >> +void ib_umem_list_replace(struct ib_umem_list *list, unsigned int index,
>> >> +			  struct ib_umem *umem)
>> >> +{
>> >> +	struct ib_umem *old;
>> >> +
>> >> +	if (!list || index >= list->count)
>> >> +		return;
>> >> +	old = list->umems[index];
>> >> +	list->umems[index] = umem;
>> >> +	if (old && old != umem)
>> >> +		ib_umem_release(old);
>> >> +}
>> >> +EXPORT_SYMBOL(ib_umem_list_replace);
>> >> +
>> >> +/**
>> >> + * ib_umem_release_non_listed - Release a umem that is not stored in the list
>> >> + * @list: umem list
>> >> + * @index: per-command buffer slot index
>> >> + * @umem: umem pointer to release
>> >> + *
>> >> + * Releases @umem if it is not stored in @list.
>> >> + */
>> >> +void ib_umem_release_non_listed(struct ib_umem_list *list, unsigned int index,
>> >> +				struct ib_umem *umem)
>> >> +{
>> >> +	if (!list || index >= list->count || list->umems[index] != umem)
>> >> +		ib_umem_release(umem);
>> >> +}
>> >> +EXPORT_SYMBOL(ib_umem_release_non_listed);
>> >> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
>> >> index 2ad52cc1d52b..924acb8d08c3 100644
>> >> --- a/include/rdma/ib_umem.h
>> >> +++ b/include/rdma/ib_umem.h
>> >> @@ -11,6 +11,7 @@
>> >>  
>> >>  struct ib_device;
>> >>  struct dma_buf_attach_ops;
>> >> +struct uverbs_attr_bundle;
>> >>  
>> >>  struct ib_umem {
>> >>  	struct ib_device       *ibdev;
>> >> @@ -80,6 +81,36 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
>> >>  void ib_umem_release(struct ib_umem *umem);
>> >>  int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>> >>  		      size_t length);
>> >> +
>> >> +/**
>> >> + * struct ib_umem_list - collection of pre-mapped umems
>> >> + *
>> >> + * Created from the UVERBS_ATTR_BUFFERS attribute. Each entry is indexed
>> >> + * by a per-command buffer slot enum (e.g., IB_UMEM_CQ_BUF for CQ CREATE).
>> >> + * Drivers use ib_umem_list_load() to retrieve a specific umem by index.
>> >> + */
>> >> +struct ib_umem_list;
>> >> +
>> >> +struct ib_umem_list *ib_umem_list_create(struct ib_device *device,
>> >> +					 const struct uverbs_attr_bundle *attrs,
>> >> +					 unsigned int slot_max);
>> >> +void ib_umem_list_release(struct ib_umem_list *list);
>> >> +int ib_umem_list_check_consumed(const struct ib_umem_list *list);
>> >> +void ib_umem_list_insert(struct ib_umem_list *list, unsigned int index,
>> >> +			 struct ib_umem *umem);
>> >> +
>> >> +struct ib_umem *ib_umem_list_load(struct ib_umem_list *list,
>> >> +				  unsigned int index, size_t size);
>> >> +struct ib_umem *ib_umem_list_load_or_get(struct ib_umem_list *list,
>> >> +					 unsigned int index,
>> >> +					 struct ib_device *device,
>> >> +					 unsigned long addr, size_t size,
>> >> +					 int access);
>> >> +void ib_umem_list_replace(struct ib_umem_list *list, unsigned int index,
>> >> +			  struct ib_umem *umem);
>> >> +void ib_umem_release_non_listed(struct ib_umem_list *list, unsigned int index,
>> >> +				struct ib_umem *umem);
>> >> +
>> >>  unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
>> >>  				     unsigned long pgsz_bitmap,
>> >>  				     unsigned long virt);
>> >> @@ -230,5 +261,28 @@ static inline void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf
>> >>  static inline void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf) {}
>> >>  static inline void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf) {}
>> >>  
>> >> +struct ib_umem_list;
>> >> +
>> >> +static inline void ib_umem_list_release(struct ib_umem_list *list) { }
>> >> +static inline struct ib_umem *ib_umem_list_load(struct ib_umem_list *list,
>> >> +						unsigned int index,
>> >> +						size_t size)
>> >> +{
>> >> +	return ERR_PTR(-EOPNOTSUPP);
>> >> +}
>> >> +static inline struct ib_umem *
>> >> +ib_umem_list_load_or_get(struct ib_umem_list *list, unsigned int index,
>> >> +			 struct ib_device *device, unsigned long addr,
>> >> +			 size_t size, int access)
>> >> +{
>> >> +	return ERR_PTR(-EOPNOTSUPP);
>> >> +}
>> >> +static inline void ib_umem_list_replace(struct ib_umem_list *list,
>> >> +					unsigned int index,
>> >> +					struct ib_umem *umem) { }
>> >> +static inline void ib_umem_release_non_listed(struct ib_umem_list *list,
>> >> +					      unsigned int index,
>> >> +					      struct ib_umem *umem) { }
>> >> +
>> >>  #endif /* CONFIG_INFINIBAND_USER_MEM */
>> >>  #endif /* IB_UMEM_H */
>> >> diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
>> >> index e2af17da3e32..05bcab27a87d 100644
>> >> --- a/include/rdma/uverbs_ioctl.h
>> >> +++ b/include/rdma/uverbs_ioctl.h
>> >> @@ -590,6 +590,20 @@ struct uapi_definition {
>> >>  			    UA_OPTIONAL,                                       \
>> >>  			    .is_udata = 1)
>> >>  
>> >> +/*
>> >> + * Optional array of struct ib_uverbs_buffer_desc describing memory regions
>> >> + * backed by dma-buf or user virtual address. Can be added to any method
>> >> + * that needs external buffer support.
>> >> + * Each entry carries an index field selecting the per-command buffer slot.
>> >> + * Use ib_umem_list_create() to map them and ib_umem_list_load() to access.
>> >> + */
>> >> +#define UVERBS_ATTR_BUFFERS()                                                  \
>> >> +	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_BUFFERS,                               \
>> >> +			   UVERBS_ATTR_MIN_SIZE(                               \
>> >> +				sizeof(struct ib_uverbs_buffer_desc)),         \
>> >> +			   UA_OPTIONAL,                                        \
>> >> +			   UA_ALLOC_AND_COPY)
>> >> +
>> >>  /* =================================================
>> >>   *              Parsing infrastructure
>> >>   * =================================================
>> >> diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
>> >> index 72041c1b0ea5..10aa6568abf1 100644
>> >> --- a/include/uapi/rdma/ib_user_ioctl_cmds.h
>> >> +++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
>> >> @@ -64,6 +64,7 @@ enum {
>> >>  	UVERBS_ATTR_UHW_IN = UVERBS_ID_DRIVER_NS,
>> >>  	UVERBS_ATTR_UHW_OUT,
>> >>  	UVERBS_ID_DRIVER_NS_WITH_UHW,
>> >> +	UVERBS_ATTR_BUFFERS,
>> >>  };
>> >>  
>> >>  enum uverbs_methods_device {
>> >> diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
>> >> index 90c5cd8e7753..41ed9f75b4de 100644
>> >> --- a/include/uapi/rdma/ib_user_ioctl_verbs.h
>> >> +++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
>> >> @@ -273,4 +273,31 @@ struct ib_uverbs_gid_entry {
>> >>  	__u32 netdev_ifindex; /* It is 0 if there is no netdev associated with it */
>> >>  };
>> >>  
>> >> +enum ib_uverbs_buffer_type {
>> >> +	IB_UVERBS_BUFFER_TYPE_DMABUF,
>> >> +	IB_UVERBS_BUFFER_TYPE_VA,
>> >> +};
>> >> +
>> >> +/*
>> >> + * Describes a single buffer backed by dma-buf or user virtual address.
>> >> + * Passed as an array via UVERBS_ATTR_BUFFERS. Each uverb command that
>> >> + * accepts this attribute defines its own per-command buffer slot enum.
>> >> + * The index field selects the buffer slot this descriptor maps to.
>> >> + *
>> >> + * @fd: dma-buf file descriptor (valid for IB_UVERBS_BUFFER_TYPE_DMABUF)
>> >> + * @type: buffer type from enum ib_uverbs_buffer_type
>> >> + * @index: per-command buffer slot index
>> >> + * @reserved: must be zero
>> >> + * @addr: offset within dma-buf, or user virtual address for VA
>> >> + * @length: buffer length in bytes
>> >> + */
>> >> +struct ib_uverbs_buffer_desc {
>> >> +	__s32 fd;
>> >> +	__u32 type;
>> >> +	__u32 index;
>> >> +	__u32 reserved;
>> >> +	__aligned_u64 addr;
>> >> +	__aligned_u64 length;
>> >> +};
>> >> +
>> >>  #endif
>> >> -- 
>> >> 2.53.0
>> >> 

