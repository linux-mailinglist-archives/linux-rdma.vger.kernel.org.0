Return-Path: <linux-rdma+bounces-19390-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A7+3EuzS4GkGmgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19390-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 14:15:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4083440DF43
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 14:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24245301E57E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA34396B63;
	Thu, 16 Apr 2026 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TucjjPvj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E2737C907
	for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341417; cv=none; b=SriCTkJriKN4kTD3kOt7IkAzVt2wr/oG9vmGZMZlMRTbu8bXs0zkzy6UBM96MWke8Kq1cmU+t8DI6dK08yEvIAfUfLXmTTCL/aOdeDB6H9RuRHcU9rjfz4lz2uqovQ9/M7oFM8WLv8r66gxYxHq6UKiBPd5oVCVH9IYaSZMV2rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341417; c=relaxed/simple;
	bh=DtraLyvytubmF10K7mnT+7KRmiKSkrTLU2Vaex7ANT4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9to80uMj3rUKLHqDbIg42D7AF/zwcWwOPfSjtkY4Xf+n9pC1evg3xXzEsEBfzePEemfLBoNL1KjTpb4AyHgCiEa+DXunMIUxnIhOjHJglXG5CD6EzYrKwJqYC9vEy/YnqnFJrpZbcjF0YkiYrR/SPvr1U00di3/ZZOQXwSq9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TucjjPvj; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776341416; x=1807877416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RpJO+OjwK0Xgw8cJ+OiicFStdT0ud3g7ij0XypfXbjM=;
  b=TucjjPvjxZ6G9GFBLGDwWRdC1AzYYl1mGO2TbhI18YPuti1aQ9aoAT2m
   xDLT5xhIkZC/qRvMqL2y4GPF4WR5vkKAXwFK7toqZ29imLX6Y0CAB14+d
   O7kf4yQ9qTLYXg8756SaISuEr91uFo1wXt8Ml2WWIGmUIi/433o2MV00n
   S/pm3HLckDMc91upnkiIK6inWpZSOolonBwXEMdCN2C8t4jDuiGGPg0Lq
   PvPPQ6wPfSzm4pArpJhLyRHZWFueIr3NYCqeahl9JICPOcjK1JMY5FfIU
   0X7kxBeV1BoHbcY3nxIEbpw6OlZT7gcGDvxLxFUOacVMSXaZP11gHdMvQ
   A==;
X-CSE-ConnectionGUID: RmvsY7MDTvGGdVjJLO00BQ==
X-CSE-MsgGUID: pdq7s/wwQTeZhRrCg4SAxA==
X-IronPort-AV: E=Sophos;i="6.23,181,1770595200"; 
   d="scan'208";a="17235522"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 12:10:13 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:19271]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.173:2525] with esmtp (Farcaster)
 id 9edeb6cf-4558-40fc-accf-a55964772d82; Thu, 16 Apr 2026 12:10:13 +0000 (UTC)
X-Farcaster-Flow-ID: 9edeb6cf-4558-40fc-accf-a55964772d82
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 16 Apr 2026 12:10:12 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 16 Apr 2026
 12:10:08 +0000
Date: Thu, 16 Apr 2026 12:10:00 +0000
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
Message-ID: <20260416121000.GA20519@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260412123322.GA5166@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <fzughzkkr5zkr436pdzu6p2j4sdlphtxpbbpztxoerbms6a37f@4dzcxphdyjg2>
 <20260413160232.GA21984@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <dy6nbf2vibl3aeopeb7im7fksh5436isqcmcarghkm5e2ontoi@unvvimhthp53>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <dy6nbf2vibl3aeopeb7im7fksh5436isqcmcarghkm5e2ontoi@unvvimhthp53>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
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
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19390-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[amazon.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4083440DF43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 08:22:05PM +0200, Jiri Pirko wrote:
> >> >While I like the idea of standardizing the way we pass buffer
> >> >information to the kernel, the list thing looks like over generalization
> >> >to me, especially after Leon's refactoring of CQ creation. Maybe we can
> >> >add buffer as a new attribute type that can be used for multiple
> >> >parameters in a command, and have a helper with the code below that
> >> >takes an attribute id and returns a umem object, letting each handler
> >> >store it. This would also make it easier for drivers to pass their
> >> >private buffers using this infrastructure.
> >> 
> >> Currently we have set of attrs (4) to pass CQ umem. I tried to make this
> >> very smooth for all possible uverbs, passing single attr of array of
> >> structs describing a buffer. Uverb attr api knows how to work with
> >> arrays, all clicks.
> >> 
> >> Drivers can easily pass their specific buffers over this list too. I
> >> didn't implement it as there was no need, but the idea is to have index>X
> >> for driver specific indexes.
> >
> >Why do we need to invent a new way instead of just adding another
> >argument in a command, that consists of all the info needed to pass a
> >buffer? Also how can this work for objects that have only private umem?
> 
> You can put the buf array attr to any uverb, some may not have
> "standard" indexes.
> 
Not sure I fully follow your idea here, can you elaborate on how you
plan to reserve index>X range in an enum used as index into dynamic
array?
 
> >
> >> What's the benefit of passing per-uverb attrs with a struct? Perhaps I'm
> >> missing something.
> >
> >Mostly simplification by untying two unrelated things:
> >1) way of passing args to kernel
> >2) object lifetime management
> 
> Could you be more specific please?
> 
> 
> >
> >And also significantly reducing the amount of code changes required to
> >achieve this.
> 
> Significantly? I'm not sure I follow, but I guess that is related to my
> previous question. I'm not sure I understand what you have exacly in
> mind. Regarding UAPI, I think I understand, but regarding kernel
> internals, I don't :(
> 

I imagine the changes for getting umem using the new mechanism in
create CQ command are about:

Define a new optional buffer attribute:

-       UVERBS_ATTR_UHW());
+       UVERBS_ATTR_UHW(),
+       UVERBS_ATTR_BUFFER(UVERBS_ATTR_CREATE_CQ_BUFFER,
+                          UA_OPTIONAL));

Get umem from the new attribute if available or fallback to existing
attributes:

-       umem = uverbs_create_cq_get_umem(ib_dev, attrs);
-       if (IS_ERR(umem)) {
-               ret = PTR_ERR(umem);
-               goto err_event_file;
-       }
+       if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER)) {
+               ret = uverbs_get_umem(&umem, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER);
+               if (ret)
+                       goto err_event_file;
+       } else {
+               umem = uverbs_create_cq_get_umem(ib_dev, attrs);
+               if (IS_ERR(umem)) {
+                       ret = PTR_ERR(umem);
+                       goto err_event_file;
+               }
+       }

Drivers don't need to change.


> >> >> + * Optional array of struct ib_uverbs_buffer_desc describing memory regions
> >> >> + * backed by dma-buf or user virtual address. Can be added to any method
> >> >> + * that needs external buffer support.
> >> >> + * Each entry carries an index field selecting the per-command buffer slot.
> >> >> + * Use ib_umem_list_create() to map them and ib_umem_list_load() to access.
> >> >> + */
> >> >> +#define UVERBS_ATTR_BUFFERS()                                                  \
> >> >> +	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_BUFFERS,                               \
> >> >> +			   UVERBS_ATTR_MIN_SIZE(                               \
> >> >> +				sizeof(struct ib_uverbs_buffer_desc)),         \
> >> >> +			   UA_OPTIONAL,                                        \
> >> >> +			   UA_ALLOC_AND_COPY)
> >> >> +
> >> >>  /* =================================================
> >> >>   *              Parsing infrastructure
> >> >>   * =================================================
> >> >> diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
> >> >> index 72041c1b0ea5..10aa6568abf1 100644
> >> >> --- a/include/uapi/rdma/ib_user_ioctl_cmds.h
> >> >> +++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
> >> >> @@ -64,6 +64,7 @@ enum {
> >> >>  	UVERBS_ATTR_UHW_IN = UVERBS_ID_DRIVER_NS,
> >> >>  	UVERBS_ATTR_UHW_OUT,
> >> >>  	UVERBS_ID_DRIVER_NS_WITH_UHW,
> >> >> +	UVERBS_ATTR_BUFFERS,

I don't think you can add anything here as it overlaps with driver
specific attributes. I suggest defining per command attr id and passing
it by caller into ib_umem_list_create.

> >> >>  };
> >> >>  
> >> >>  enum uverbs_methods_device {
> >> >> diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
> >> >> index 90c5cd8e7753..41ed9f75b4de 100644
> >> >> --- a/include/uapi/rdma/ib_user_ioctl_verbs.h
> >> >> +++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
> >> >> @@ -273,4 +273,31 @@ struct ib_uverbs_gid_entry {
> >> >>  	__u32 netdev_ifindex; /* It is 0 if there is no netdev associated with it */
> >> >>  };
> >> >>  
> >> >> +enum ib_uverbs_buffer_type {
> >> >> +	IB_UVERBS_BUFFER_TYPE_DMABUF,
> >> >> +	IB_UVERBS_BUFFER_TYPE_VA,
> >> >> +};
> >> >> +
> >> >> +/*
> >> >> + * Describes a single buffer backed by dma-buf or user virtual address.
> >> >> + * Passed as an array via UVERBS_ATTR_BUFFERS. Each uverb command that
> >> >> + * accepts this attribute defines its own per-command buffer slot enum.
> >> >> + * The index field selects the buffer slot this descriptor maps to.
> >> >> + *
> >> >> + * @fd: dma-buf file descriptor (valid for IB_UVERBS_BUFFER_TYPE_DMABUF)
> >> >> + * @type: buffer type from enum ib_uverbs_buffer_type
> >> >> + * @index: per-command buffer slot index
> >> >> + * @reserved: must be zero
> >> >> + * @addr: offset within dma-buf, or user virtual address for VA
> >> >> + * @length: buffer length in bytes
> >> >> + */
> >> >> +struct ib_uverbs_buffer_desc {
> >> >> +	__s32 fd;
> >> >> +	__u32 type;
> >> >> +	__u32 index;
> >> >> +	__u32 reserved;
> >> >> +	__aligned_u64 addr;
> >> >> +	__aligned_u64 length;
> >> >> +};
> >> >> +
> >> >>  #endif
> >> >> -- 
> >> >> 2.53.0
> >> >> 

