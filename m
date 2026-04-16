Return-Path: <linux-rdma+bounces-19391-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMgDJfDm4GkhnQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19391-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 15:41:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E55DE40EF9C
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 15:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D763303817E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A5B3C4544;
	Thu, 16 Apr 2026 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="WGkP1GgF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1834B43F
	for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776346455; cv=none; b=trBwswkxsFiuhq8J+4XIJh4DhIMsQ2po9vfa5gPQ3UNfOaZlwS21OSulWjxDFGEk4YSgodKYR1fe86rte2rtkfKM+tuJga6rfWJZxfnulncEDinskl3O8s/AKUJNkS43l2P8dX11Kw6LZCBQTcrXLttdS+4mDti8J95kZrCogqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776346455; c=relaxed/simple;
	bh=iDaUG9bDMvr1ZLSVOKNUH3ZOSVS4/FKEEPZf5mknlpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4+1yFiVBR/yvZb/mv9TE5nhCLG0JgyaXOsAzhyag/vqjLLsT6Zio/gkvNZnn6gxf1hQQoPzhG3A/DUrDGh2EPKmeE+H+X3162bu8OkLgr6jTKni5Wxr27wMSHpZVzbja30x4vI1+e+zJEYaDq6eI/KRsG1Ctav7HFFFBGIz6gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=WGkP1GgF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cf8fe9c2aso4957620f8f.2
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776346450; x=1776951250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+pkw9wanFRD0CS8lc+o+CU/n7MLPVbQqexK3KXCU+M=;
        b=WGkP1GgFz4CN3ND5VgH4ib8blJUp+W7lXoGwlME25V70HuzDHkDcwo38R35NBNcdha
         rF4t10I0wXfjd16ZqbNXNYBS3hgHEPj6zPyHrE+4+KIDJ4ZTFmcjIOBOlon8T6zcwBJ1
         yjsIM/EIgNR7QCDP2FtRQk80Tp+bRyNBCdSibFiH58YWReZ8EHFx761vu6jZcgUEfP0v
         IbQ/Aye7xRftWfDsOqcbCnhJXrFbyTSv/gvbUD3SbUObxJFqkBzFcxqQ93Y2QbK71eD6
         H2sqVQLrRPljlJxFX9OtFTx4mGQ9cZGdvGo16VVw0K84KaieSjEH1qFtp9knD5sriceX
         KIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776346450; x=1776951250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+pkw9wanFRD0CS8lc+o+CU/n7MLPVbQqexK3KXCU+M=;
        b=jykEAOYYB7ocLXlKQIdJZvM1dvq5riVtyp95TVlI7EJJ6lyK8+Y61r9CPwN7+Mz0e5
         /Hirytym1u6Cdyv8UAjunAV+hwKZoufi+SDrzmNZUyqGFyGvsX0BmHGrDx6UGH23qtWk
         I3IJR3GryiTnhiSPIyzHfvNOwX8uCIQQy658jNkdJB92t6Mf16V35HbCl7Enn83roxYR
         cL/weiSwFKmH3LL15LU4G78j2IANRewGjB86YkjvK7gfjRQLeihlrMMW89yCkLGBvFl2
         t105SPFE0QQ3Ws5GBydOwvY7uSuwts9RK0YsSMOLed6hHOG5xwi2TBnSwLN4R/LnzRpB
         776Q==
X-Gm-Message-State: AOJu0YxKYLo5ALbwEHXi9ZN2Zk9xVJ7zvUptdlq2H9MsgDL3n52p5h91
	Egq0o//RHcOLHAc77ax2T02YN7WUZ/DWciOGCvhjyvw4ySW3wuc3oWStf+qs+C52g0g=
X-Gm-Gg: AeBDiesbzGdlI04kPEv+EFY+nBpDFtRtaSEmknDRH7LiwUQ3AsiaCl1L98W/YxCsdZU
	1otiZwsf8nTZSR8wHi0gx8tLLGxNnxA8fGKG4gHX1CydXwJSq9ro+SUGE7xpL4TQ5G7ySWonyfU
	y2SgisjcCpzsbiW6t1CjTPr1p+WddXn5C3p3Zjhjvwc9+yoRfsAiEzYhmiRm8fgTReUbf8lTrR0
	FbgfeBe4kvlESxu+/cr9gs8RvCbnl2wyc8wgKH6127JrpMY7ZYW1QeT27q7yr8zo5WD5kjzdcHx
	RVLJyuXGNRhi7AJS7Ff017H8kXmxT58WaW+ufNB7FvvpiOwvhq++YPc/lvq134c33PkCF7YDlwW
	zIz3j0hNeN1bdan91GcJFo91QITbUbgwMTeZdW/9dcakK5txm6SqmKK7FNEDuOOKrRCB7tLvCnP
	Mqf2KjZbsNg9f8UGf0e7arfzpPUr6wbro9Gg==
X-Received: by 2002:a05:6000:1379:b0:43d:6787:9934 with SMTP id ffacd0b85a97d-43d67879a5emr25981369f8f.9.1776346449814;
        Thu, 16 Apr 2026 06:34:09 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3ebaf1sm14076949f8f.33.2026.04.16.06.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:34:09 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:34:05 +0200
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
Message-ID: <mxyzifm2htpmyeouhkeycliwo4ye6qov7vs2rhefyn3ghvp7nl@uxadwty5dvtj>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260412123322.GA5166@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <fzughzkkr5zkr436pdzu6p2j4sdlphtxpbbpztxoerbms6a37f@4dzcxphdyjg2>
 <20260413160232.GA21984@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <dy6nbf2vibl3aeopeb7im7fksh5436isqcmcarghkm5e2ontoi@unvvimhthp53>
 <20260416121000.GA20519@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416121000.GA20519@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
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
	TAGGED_FROM(0.00)[bounces-19391-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E55DE40EF9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, Apr 16, 2026 at 02:10:00PM +0200, mrgolin@amazon.com wrote:
>On Mon, Apr 13, 2026 at 08:22:05PM +0200, Jiri Pirko wrote:
>> >> >While I like the idea of standardizing the way we pass buffer
>> >> >information to the kernel, the list thing looks like over generalization
>> >> >to me, especially after Leon's refactoring of CQ creation. Maybe we can
>> >> >add buffer as a new attribute type that can be used for multiple
>> >> >parameters in a command, and have a helper with the code below that
>> >> >takes an attribute id and returns a umem object, letting each handler
>> >> >store it. This would also make it easier for drivers to pass their
>> >> >private buffers using this infrastructure.
>> >> 
>> >> Currently we have set of attrs (4) to pass CQ umem. I tried to make this
>> >> very smooth for all possible uverbs, passing single attr of array of
>> >> structs describing a buffer. Uverb attr api knows how to work with
>> >> arrays, all clicks.
>> >> 
>> >> Drivers can easily pass their specific buffers over this list too. I
>> >> didn't implement it as there was no need, but the idea is to have index>X
>> >> for driver specific indexes.
>> >
>> >Why do we need to invent a new way instead of just adding another
>> >argument in a command, that consists of all the info needed to pass a
>> >buffer? Also how can this work for objects that have only private umem?
>> 
>> You can put the buf array attr to any uverb, some may not have
>> "standard" indexes.
>> 
>Not sure I fully follow your idea here, can you elaborate on how you
>plan to reserve index>X range in an enum used as index into dynamic
>array?

#define UVERBS_BUF_DRIVER_BASE	1024

and then:

struct ib_uverbs_buffer_desc bufs[] = {
	{
		.fd     = cq_dmabuf_fd,
		.type   = IB_UVERBS_BUFFER_TYPE_DMABUF,
		.index  = UVERBS_BUF_CQ_BUF,           /* 0 */
		.addr   = 0,
		.length = cq_buf_size,
	},
	{
		.fd     = dbr_dmabuf_fd,
		.type   = IB_UVERBS_BUFFER_TYPE_DMABUF,
		.index  = UVERBS_BUF_CQ_DBR,           /* 1 */
		.addr   = dbr_offset,
		.length = 8,
	},
	{
		.fd     = uar_dmabuf_fd,
		.type   = IB_UVERBS_BUFFER_TYPE_DMABUF,
->>>>>>>>>	.index  = MLX5_BUF_CQ_UAR,             /* 1024 */
		.addr   = 0,
		.length = 4096,
	},
};



> 
>> >
>> >> What's the benefit of passing per-uverb attrs with a struct? Perhaps I'm
>> >> missing something.
>> >
>> >Mostly simplification by untying two unrelated things:
>> >1) way of passing args to kernel
>> >2) object lifetime management
>> 
>> Could you be more specific please?
>> 
>> 
>> >
>> >And also significantly reducing the amount of code changes required to
>> >achieve this.
>> 
>> Significantly? I'm not sure I follow, but I guess that is related to my
>> previous question. I'm not sure I understand what you have exacly in
>> mind. Regarding UAPI, I think I understand, but regarding kernel
>> internals, I don't :(
>> 
>
>I imagine the changes for getting umem using the new mechanism in
>create CQ command are about:
>
>Define a new optional buffer attribute:
>
>-       UVERBS_ATTR_UHW());
>+       UVERBS_ATTR_UHW(),
>+       UVERBS_ATTR_BUFFER(UVERBS_ATTR_CREATE_CQ_BUFFER,
>+                          UA_OPTIONAL));

Okay, that may be doable. I'm just curious about the in-kernel
management of umems. With list, it aligns. With your suggested approach
we would have to iterate over these attrs and assemble in-kernel list to
manage umems.


>
>Get umem from the new attribute if available or fallback to existing
>attributes:
>
>-       umem = uverbs_create_cq_get_umem(ib_dev, attrs);
>-       if (IS_ERR(umem)) {
>-               ret = PTR_ERR(umem);
>-               goto err_event_file;
>-       }
>+       if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER)) {
>+               ret = uverbs_get_umem(&umem, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER);
>+               if (ret)
>+                       goto err_event_file;
>+       } else {
>+               umem = uverbs_create_cq_get_umem(ib_dev, attrs);
>+               if (IS_ERR(umem)) {
>+                       ret = PTR_ERR(umem);
>+                       goto err_event_file;
>+               }
>+       }
>
>Drivers don't need to change.

uverbs_create_cq_get_umem only works with legacy attrs. Not that
interesting. How do you propose to handle other umems, when uverb
supports multiple umems (like + DRB umem for create CQ)? I'm
particularly interested in consumption validation and life-cycle
management (that is a bit trickier for create QP).



>
>
>> >> >> + * Optional array of struct ib_uverbs_buffer_desc describing memory regions
>> >> >> + * backed by dma-buf or user virtual address. Can be added to any method
>> >> >> + * that needs external buffer support.
>> >> >> + * Each entry carries an index field selecting the per-command buffer slot.
>> >> >> + * Use ib_umem_list_create() to map them and ib_umem_list_load() to access.
>> >> >> + */
>> >> >> +#define UVERBS_ATTR_BUFFERS()                                                  \
>> >> >> +	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_BUFFERS,                               \
>> >> >> +			   UVERBS_ATTR_MIN_SIZE(                               \
>> >> >> +				sizeof(struct ib_uverbs_buffer_desc)),         \
>> >> >> +			   UA_OPTIONAL,                                        \
>> >> >> +			   UA_ALLOC_AND_COPY)
>> >> >> +
>> >> >>  /* =================================================
>> >> >>   *              Parsing infrastructure
>> >> >>   * =================================================
>> >> >> diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
>> >> >> index 72041c1b0ea5..10aa6568abf1 100644
>> >> >> --- a/include/uapi/rdma/ib_user_ioctl_cmds.h
>> >> >> +++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
>> >> >> @@ -64,6 +64,7 @@ enum {
>> >> >>  	UVERBS_ATTR_UHW_IN = UVERBS_ID_DRIVER_NS,
>> >> >>  	UVERBS_ATTR_UHW_OUT,
>> >> >>  	UVERBS_ID_DRIVER_NS_WITH_UHW,
>> >> >> +	UVERBS_ATTR_BUFFERS,
>
>I don't think you can add anything here as it overlaps with driver
>specific attributes. I suggest defining per command attr id and passing
>it by caller into ib_umem_list_create.
>
>> >> >>  };
>> >> >>  
>> >> >>  enum uverbs_methods_device {
>> >> >> diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
>> >> >> index 90c5cd8e7753..41ed9f75b4de 100644
>> >> >> --- a/include/uapi/rdma/ib_user_ioctl_verbs.h
>> >> >> +++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
>> >> >> @@ -273,4 +273,31 @@ struct ib_uverbs_gid_entry {
>> >> >>  	__u32 netdev_ifindex; /* It is 0 if there is no netdev associated with it */
>> >> >>  };
>> >> >>  
>> >> >> +enum ib_uverbs_buffer_type {
>> >> >> +	IB_UVERBS_BUFFER_TYPE_DMABUF,
>> >> >> +	IB_UVERBS_BUFFER_TYPE_VA,
>> >> >> +};
>> >> >> +
>> >> >> +/*
>> >> >> + * Describes a single buffer backed by dma-buf or user virtual address.
>> >> >> + * Passed as an array via UVERBS_ATTR_BUFFERS. Each uverb command that
>> >> >> + * accepts this attribute defines its own per-command buffer slot enum.
>> >> >> + * The index field selects the buffer slot this descriptor maps to.
>> >> >> + *
>> >> >> + * @fd: dma-buf file descriptor (valid for IB_UVERBS_BUFFER_TYPE_DMABUF)
>> >> >> + * @type: buffer type from enum ib_uverbs_buffer_type
>> >> >> + * @index: per-command buffer slot index
>> >> >> + * @reserved: must be zero
>> >> >> + * @addr: offset within dma-buf, or user virtual address for VA
>> >> >> + * @length: buffer length in bytes
>> >> >> + */
>> >> >> +struct ib_uverbs_buffer_desc {
>> >> >> +	__s32 fd;
>> >> >> +	__u32 type;
>> >> >> +	__u32 index;
>> >> >> +	__u32 reserved;
>> >> >> +	__aligned_u64 addr;
>> >> >> +	__aligned_u64 length;
>> >> >> +};
>> >> >> +
>> >> >>  #endif
>> >> >> -- 
>> >> >> 2.53.0
>> >> >> 

