Return-Path: <linux-rdma+bounces-19781-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C4XAzhJ82kMzAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19781-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 14:21:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 506744A2B2D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 14:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D2803046EB1
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 12:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B778740245F;
	Thu, 30 Apr 2026 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="enXxYPhb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFF13FE358
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551529; cv=none; b=DtZ93BBfu8WelR8ipkNGQfD759NYc8EW/Mr5jTgpdvIKHjXmptro+LPB7faQs3kcdAVW6S33OVN2SvLzi2Sv0ky8z/CpL3Hs54z/+agbJStCE0Ky7y/Q+tzKI+UbnnbmJHcyO0ALSfgIblEzGQqdc/LD0qh1+hTZwdHEXF1I2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551529; c=relaxed/simple;
	bh=Hlde/57lPqwAtlUXT/O/N6Dtt+qlJCxTWQ9mp4z51NE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc5k+RMZB1Ibq0yhqOObbZeX75DhY5muAbPplxRxJ2u076FyQOmogN8U9aZdjXS62/E+0/YAk8RYFXRZjsM5rVe7iZXHLJjI94Qh24CL6KR9jsXVm5HTN8sGDjyNhGCIJhcOAU3gV+NkCEOCVjWUXD2KjV9e1Frkz8kU0vUqaag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=enXxYPhb; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777551527; x=1809087527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V8uwyWSLGZFFRPI4uMk7obfLLvHTAZDNqqYmOha+xQA=;
  b=enXxYPhbv387WFM+uvBCP6Dow1lk+mYTMYR/8R1le5Sz4+X284mCov58
   EXZbFgLwAs93qQvlZdXU7fNvJ1O27bF4shDEN8uGw1hQSl+0VgLVza+UC
   6j78StCC6OYeEOu0HPb4Rtz4R7vYthSNJB/x57FNKgCunO32aWrS/5Mc4
   RPEFQDH7tkuzPBF75PPQMVHXz3yl+V7vLzFuMVALSMzS9m4YZbSNZk6kd
   tF+wvPXcnrU9VD5Ot8IQQ3q0X9SHDXpCKf5rB4oPVUxGnRAyvdDbhzdOh
   ZBcJ/eMDi9Vn2IOclYwN9zcF42d0Qa4n3ISbmZOYQ7dO3aO0ktsit/ORu
   g==;
X-CSE-ConnectionGUID: +k4/6xFvT9SYTznTowllNQ==
X-CSE-MsgGUID: I5CZ/fa0Rgun4IwfCvdWyA==
X-IronPort-AV: E=Sophos;i="6.23,208,1770595200"; 
   d="scan'208";a="18556390"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 12:18:44 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:9635]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.227:2525] with esmtp (Farcaster)
 id 6dc1dd92-52a2-4335-9f86-af38bec2f447; Thu, 30 Apr 2026 12:18:44 +0000 (UTC)
X-Farcaster-Flow-ID: 6dc1dd92-52a2-4335-9f86-af38bec2f447
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 30 Apr 2026 12:18:43 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 30 Apr 2026
 12:18:41 +0000
Date: Thu, 30 Apr 2026 12:18:33 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Doug Ledford <doug.ledford@hpe.com>
CC: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Yonatan
 Nachum" <ynachum@amazon.com>
Subject: Re: [PATCH for-next v2 1/5] RDMA/core: Add Completion Counters
 support
Message-ID: <20260430121833.GA30363@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260416212327.18191-1-mrgolin@amazon.com>
 <20260416212327.18191-2-mrgolin@amazon.com>
 <2bfaa4cc-8e4f-43ad-a483-36ac1ae3caea@hpe.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <2bfaa4cc-8e4f-43ad-a483-36ac1ae3caea@hpe.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 506744A2B2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19781-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hpe.com:email];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]

On Wed, Apr 29, 2026 at 06:50:54PM -0600, Doug Ledford wrote:
> On 4/16/26 4:23 PM, Michael Margolin wrote:
> >Add core infrastructure for Completion Counters, a light-weight
> >alternative to polling CQ for tracking operation completions.
> >
> >Define the UVERBS_OBJECT_COMP_CNTR ioctl object with create, destroy,
> >set, inc and read methods for both success and error counters. Add a
> >QP attach method on the QP object to associate a completion counter
> >with a queue pair.
> >
> >The create handler constructs umem from user-provided VA or dmabuf for
> >each counter, following the CQ buffer pattern.
> 
> Description here doesn't match implementation.  The umem or dmabuf
> is optional, while this reads that they are the only two options.
> If neither is passed in, then the counter is on the hardware and the
> read operation is used to get the value (as per the code anyway).

Thanks, I'll make that path more clear in the commit message.
> 
> Which raises a different scenario our hardware enables.  We can pass
> in a umem on create, but that doesn't mean the counter exists in
> umem, it exists on the device and it is copied to umem.  If you copy
> it on every counter update, that kills PCI-e usage, so we have an

Why would it load PCIe more than writing CQEs into a CQ?

> option to use a trigger to only update on a periodic basis (but then
> user space authors start polling on the umem location and killing
> CPU cycles, so this option is not preferred), or there is a wait
> option where you can set the target and then in your app use a wait
> call to wait for the count to be reached (we've found this is about
> the only performant way to implement these counters).
> 
> Also, we don't really attach counters to QPs.  That isn't usually
> what we care about counting.  Given that our EPs are not connected,
> counters on it are usually only useful for recv operations where you
> can get aggregate data for a given EP.  For send, it is often that
> we really want counters on a per-flow basis knowing that we have
> many flows that go through that one EP (soon to be QP).  So, for us,
> we create a counter, then during our send operations, if we want a
> specific transfer to be included in a specific counter, it's flagged
> in the command we send to the hardware for that send operation.
> That implies that a proper place to hang a list of counters is
> probably off of an AH instead of a QP for us.
> 
> I think we can extend this API to suit our needs, relax some of the
> current restrictions/assumptions, and be good.  But, as this is a
> user visible API, if it's taken as-is, I would suggest that the
> rdma-core portion be marked as experimental until we've made the
> changes needed for our hardware in order to avoid user API churn.
> 
> These changes could be summed up as:
> 
> 1) Make qp attachment optional

The attachment is already a separate call that can be avoided.

> 2) Extend create verb to differentiate between on-card counter with
> umem target and in-umem counter

Can you elaborate on the extension you have on your mind? This seems to
me as a totally driver-device level implementation detail. EFA for
instance has device level counters that are being synced into the
provided memory on each update. Others may choose a different sync
strategy.

> 3) Extend create verb to pass in optional trigger or wait capability
> to perform limited umem updates based upon passed in option

I think this can be vendor specific extension rather than a common
interface. Providers that want to support this mode can easily add
their own "update frequency" attribute in create ioctl or introduce
a "sync" verb that will do what's needed for the sequential read to
return an up-to-date value.

> 4) Modify read operation so that it can either return the value
> directly or just trigger an async update of a buffer backed counter
> (especially useful if the umem counter is on a GPU, is set for a
> triggered update, and you just want to force an immediate async
> update)

See my suggestion above. I think what you describe here should be a
separate command.


Michael

> 
> Doug
> 
> >Set, inc and read
> >handlers pass through to driver callbacks. The QP attach handler
> >validates the operation mask flags and delegates to the driver.
> >
> >Add ib_comp_cntr struct, ib_comp_cntr_attach_attr, device ops, and
> >DECLARE_RDMA_OBJ_SIZE for driver object allocation.
> >
> >Only userspace Completion Counters are supported at this stage.
> >
> >Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> >Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> >---
> >  drivers/infiniband/core/Makefile              |   1 +
> >  drivers/infiniband/core/device.c              |   7 +
> >  drivers/infiniband/core/rdma_core.h           |   1 +
> >  drivers/infiniband/core/uverbs_cmd.c          |   1 +
> >  .../core/uverbs_std_types_comp_cntr.c         | 290 ++++++++++++++++++
> >  drivers/infiniband/core/uverbs_std_types_qp.c |  45 ++-
> >  drivers/infiniband/core/uverbs_uapi.c         |   1 +
> >  include/rdma/ib_verbs.h                       |  37 +++
> >  include/uapi/rdma/ib_user_ioctl_cmds.h        |  50 +++
> >  include/uapi/rdma/ib_user_ioctl_verbs.h       |  14 +
> >  include/uapi/rdma/ib_user_verbs.h             |   2 +-
> >  11 files changed, 447 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/infiniband/core/uverbs_std_types_comp_cntr.c
> >
> >diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
> >index dce798d8cfe6..4767339608a1 100644
> >--- a/drivers/infiniband/core/Makefile
> >+++ b/drivers/infiniband/core/Makefile
> >@@ -35,6 +35,7 @@ ib_umad-y :=			user_mad.o
> >  ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
> >  				rdma_core.o uverbs_std_types.o uverbs_ioctl.o \
> >  				uverbs_std_types_cq.o \
> >+				uverbs_std_types_comp_cntr.o \
> >  				uverbs_std_types_dmabuf.o \
> >  				uverbs_std_types_dmah.o \
> >  				uverbs_std_types_flow_action.o uverbs_std_types_dm.o \
> >diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> >index 4c174f7f1070..60c41fc1aa4d 100644
> >--- a/drivers/infiniband/core/device.c
> >+++ b/drivers/infiniband/core/device.c
> >@@ -2733,6 +2733,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
> >  	SET_DEVICE_OP(dev_ops, create_ah);
> >  	SET_DEVICE_OP(dev_ops, create_counters);
> >  	SET_DEVICE_OP(dev_ops, create_cq);
> >+	SET_DEVICE_OP(dev_ops, create_comp_cntr);
> >  	SET_DEVICE_OP(dev_ops, create_user_cq);
> >  	SET_DEVICE_OP(dev_ops, create_flow);
> >  	SET_DEVICE_OP(dev_ops, create_qp);
> >@@ -2753,6 +2754,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
> >  	SET_DEVICE_OP(dev_ops, destroy_ah);
> >  	SET_DEVICE_OP(dev_ops, destroy_counters);
> >  	SET_DEVICE_OP(dev_ops, destroy_cq);
> >+	SET_DEVICE_OP(dev_ops, destroy_comp_cntr);
> >  	SET_DEVICE_OP(dev_ops, destroy_flow);
> >  	SET_DEVICE_OP(dev_ops, destroy_flow_action);
> >  	SET_DEVICE_OP(dev_ops, destroy_qp);
> >@@ -2804,6 +2806,8 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
> >  	SET_DEVICE_OP(dev_ops, modify_hw_stat);
> >  	SET_DEVICE_OP(dev_ops, modify_port);
> >  	SET_DEVICE_OP(dev_ops, modify_qp);
> >+	SET_DEVICE_OP(dev_ops, inc_comp_cntr);
> >+	SET_DEVICE_OP(dev_ops, qp_attach_comp_cntr);
> >  	SET_DEVICE_OP(dev_ops, modify_srq);
> >  	SET_DEVICE_OP(dev_ops, modify_wq);
> >  	SET_DEVICE_OP(dev_ops, peek_cq);
> >@@ -2827,12 +2831,14 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
> >  	SET_DEVICE_OP(dev_ops, query_ucontext);
> >  	SET_DEVICE_OP(dev_ops, rdma_netdev_get_params);
> >  	SET_DEVICE_OP(dev_ops, read_counters);
> >+	SET_DEVICE_OP(dev_ops, read_comp_cntr);
> >  	SET_DEVICE_OP(dev_ops, reg_dm_mr);
> >  	SET_DEVICE_OP(dev_ops, reg_user_mr);
> >  	SET_DEVICE_OP(dev_ops, reg_user_mr_dmabuf);
> >  	SET_DEVICE_OP(dev_ops, req_notify_cq);
> >  	SET_DEVICE_OP(dev_ops, rereg_user_mr);
> >  	SET_DEVICE_OP(dev_ops, resize_user_cq);
> >+	SET_DEVICE_OP(dev_ops, set_comp_cntr);
> >  	SET_DEVICE_OP(dev_ops, set_vf_guid);
> >  	SET_DEVICE_OP(dev_ops, set_vf_link_state);
> >  	SET_DEVICE_OP(dev_ops, ufile_hw_cleanup);
> >@@ -2841,6 +2847,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
> >  	SET_OBJ_SIZE(dev_ops, ib_ah);
> >  	SET_OBJ_SIZE(dev_ops, ib_counters);
> >  	SET_OBJ_SIZE(dev_ops, ib_cq);
> >+	SET_OBJ_SIZE(dev_ops, ib_comp_cntr);
> >  	SET_OBJ_SIZE(dev_ops, ib_dmah);
> >  	SET_OBJ_SIZE(dev_ops, ib_mw);
> >  	SET_OBJ_SIZE(dev_ops, ib_pd);
> >diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
> >index 269b393799ab..2569550e4c6d 100644
> >--- a/drivers/infiniband/core/rdma_core.h
> >+++ b/drivers/infiniband/core/rdma_core.h
> >@@ -156,6 +156,7 @@ uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata);
> >  extern const struct uapi_definition uverbs_def_obj_async_fd[];
> >  extern const struct uapi_definition uverbs_def_obj_counters[];
> >+extern const struct uapi_definition uverbs_def_obj_comp_cntr[];
> >  extern const struct uapi_definition uverbs_def_obj_cq[];
> >  extern const struct uapi_definition uverbs_def_obj_device[];
> >  extern const struct uapi_definition uverbs_def_obj_dm[];
> >diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> >index a768436ba468..4bc493b3b624 100644
> >--- a/drivers/infiniband/core/uverbs_cmd.c
> >+++ b/drivers/infiniband/core/uverbs_cmd.c
> >@@ -3673,6 +3673,7 @@ static int ib_uverbs_ex_query_device(struct uverbs_attr_bundle *attrs)
> >  	resp.cq_moderation_caps.max_cq_moderation_period =
> >  		attr.cq_caps.max_cq_moderation_period;
> >  	resp.max_dm_size = attr.max_dm_size;
> >+	resp.max_comp_cntr = attr.max_comp_cntr;
> >  	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
> >  	return uverbs_response(attrs, &resp, sizeof(resp));
> >diff --git a/drivers/infiniband/core/uverbs_std_types_comp_cntr.c b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
> >new file mode 100644
> >index 000000000000..7651a565bb9f
> >--- /dev/null
> >+++ b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
> >@@ -0,0 +1,290 @@
> >+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> >+/*
> >+ * Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
> >+ */
> >+
> >+#include <rdma/uverbs_std_types.h>
> >+#include <rdma/ib_umem.h>
> >+#include <rdma/ib_umem_dmabuf.h>
> >+#include "rdma_core.h"
> >+#include "uverbs.h"
> >+
> >+static int uverbs_free_comp_cntr(struct ib_uobject *uobject, enum rdma_remove_reason why,
> >+				 struct uverbs_attr_bundle *attrs)
> >+{
> >+	struct ib_comp_cntr *cc = uobject->object;
> >+	int ret;
> >+
> >+	ret = cc->device->ops.destroy_comp_cntr(cc);
> >+	if (ret)
> >+		return ret;
> >+
> >+	ib_umem_release(cc->comp_umem);
> >+	ib_umem_release(cc->err_umem);
> >+	kfree(cc);
> >+	return 0;
> >+}
> >+
> >+static int comp_cntr_get_umem(struct ib_device *ib_dev, struct uverbs_attr_bundle *attrs,
> >+			      int va_attr, int fd_attr, int offset_attr, struct ib_umem **umem_out)
> >+{
> >+	struct ib_umem_dmabuf *umem_dmabuf;
> >+	u64 buffer_offset;
> >+	u64 buffer_va;
> >+	int buffer_fd;
> >+	int ret;
> >+
> >+	*umem_out = NULL;
> >+
> >+	if (uverbs_attr_is_valid(attrs, va_attr)) {
> >+		if (uverbs_attr_is_valid(attrs, fd_attr) ||
> >+		    uverbs_attr_is_valid(attrs, offset_attr))
> >+			return -EINVAL;
> >+
> >+		ret = uverbs_copy_from(&buffer_va, attrs, va_attr);
> >+		if (ret)
> >+			return ret;
> >+
> >+		*umem_out = ib_umem_get(ib_dev, buffer_va, sizeof(u64), IB_ACCESS_LOCAL_WRITE);
> >+		if (IS_ERR(*umem_out)) {
> >+			ret = PTR_ERR(*umem_out);
> >+			*umem_out = NULL;
> >+			return ret;
> >+		}
> >+	} else if (uverbs_attr_is_valid(attrs, fd_attr)) {
> >+		if (uverbs_attr_is_valid(attrs, va_attr))
> >+			return -EINVAL;
> >+
> >+		ret = uverbs_get_raw_fd(&buffer_fd, attrs, fd_attr);
> >+		if (ret)
> >+			return ret;
> >+
> >+		ret = uverbs_copy_from(&buffer_offset, attrs, offset_attr);
> >+		if (ret)
> >+			return ret;
> >+
> >+		umem_dmabuf = ib_umem_dmabuf_get_pinned(ib_dev, buffer_offset, sizeof(u64),
> >+							buffer_fd, IB_ACCESS_LOCAL_WRITE);
> >+		if (IS_ERR(umem_dmabuf))
> >+			return PTR_ERR(umem_dmabuf);
> >+
> >+		*umem_out = &umem_dmabuf->umem;
> >+	}
> >+
> >+	return 0;
> >+}
> >+
> >+static int UVERBS_HANDLER(UVERBS_METHOD_COMP_CNTR_CREATE)(struct uverbs_attr_bundle *attrs)
> >+{
> >+	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs,
> >+							  UVERBS_ATTR_CREATE_COMP_CNTR_HANDLE);
> >+	struct ib_device *ib_dev = attrs->context->device;
> >+	struct ib_comp_cntr *cc;
> >+	int ret;
> >+
> >+	if (!ib_dev->ops.create_comp_cntr ||
> >+	    !ib_dev->ops.destroy_comp_cntr ||
> >+	    !ib_dev->ops.qp_attach_comp_cntr)
> >+		return -EOPNOTSUPP;
> >+
> >+	cc = rdma_zalloc_drv_obj(ib_dev, ib_comp_cntr);
> >+	if (!cc)
> >+		return -ENOMEM;
> >+
> >+	cc->device = ib_dev;
> >+	cc->uobject = uobj;
> >+
> >+	ret = comp_cntr_get_umem(ib_dev, attrs,
> >+				 UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_VA,
> >+				 UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_FD,
> >+				 UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_OFFSET,
> >+				 &cc->comp_umem);
> >+	if (ret)
> >+		goto err_free;
> >+
> >+	ret = comp_cntr_get_umem(ib_dev, attrs,
> >+				 UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_VA,
> >+				 UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_FD,
> >+				 UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_OFFSET,
> >+				 &cc->err_umem);
> >+	if (ret)
> >+		goto err_comp_umem;
> >+
> >+	ret = ib_dev->ops.create_comp_cntr(cc, attrs);
> >+	if (ret)
> >+		goto err_err_umem;
> >+
> >+	uobj->object = cc;
> >+	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_CREATE_COMP_CNTR_HANDLE);
> >+
> >+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_COMP_CNTR_RESP_COUNT_MAX_VALUE,
> >+			     &cc->comp_count_max_value, sizeof(cc->comp_count_max_value));
> >+	if (ret)
> >+		return ret;
> >+
> >+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_COMP_CNTR_RESP_ERR_COUNT_MAX_VALUE,
> >+			     &cc->err_count_max_value, sizeof(cc->err_count_max_value));
> >+	return ret;
> >+
> >+err_err_umem:
> >+	ib_umem_release(cc->err_umem);
> >+err_comp_umem:
> >+	ib_umem_release(cc->comp_umem);
> >+err_free:
> >+	kfree(cc);
> >+	return ret;
> >+}
> >+
> >+static int UVERBS_HANDLER(UVERBS_METHOD_COMP_CNTR_SET)(struct uverbs_attr_bundle *attrs)
> >+{
> >+	struct ib_comp_cntr *cc = uverbs_attr_get_obj(attrs, UVERBS_ATTR_SET_COMP_CNTR_HANDLE);
> >+	enum ib_comp_cntr_entry entry;
> >+	u64 value;
> >+	int ret;
> >+
> >+	if (!cc->device->ops.set_comp_cntr)
> >+		return -EOPNOTSUPP;
> >+
> >+	ret = uverbs_get_const(&entry, attrs, UVERBS_ATTR_SET_COMP_CNTR_ENTRY);
> >+	if (ret)
> >+		return ret;
> >+
> >+	ret = uverbs_copy_from(&value, attrs, UVERBS_ATTR_SET_COMP_CNTR_VALUE);
> >+	if (ret)
> >+		return ret;
> >+
> >+	return cc->device->ops.set_comp_cntr(cc, entry, value);
> >+}
> >+
> >+static int UVERBS_HANDLER(UVERBS_METHOD_COMP_CNTR_INC)(struct uverbs_attr_bundle *attrs)
> >+{
> >+	struct ib_comp_cntr *cc = uverbs_attr_get_obj(attrs, UVERBS_ATTR_INC_COMP_CNTR_HANDLE);
> >+	enum ib_comp_cntr_entry entry;
> >+	u64 amount;
> >+	int ret;
> >+
> >+	if (!cc->device->ops.inc_comp_cntr)
> >+		return -EOPNOTSUPP;
> >+
> >+	ret = uverbs_get_const(&entry, attrs, UVERBS_ATTR_INC_COMP_CNTR_ENTRY);
> >+	if (ret)
> >+		return ret;
> >+
> >+	ret = uverbs_copy_from(&amount, attrs, UVERBS_ATTR_INC_COMP_CNTR_VALUE);
> >+	if (ret)
> >+		return ret;
> >+
> >+	return cc->device->ops.inc_comp_cntr(cc, entry, amount);
> >+}
> >+
> >+static int UVERBS_HANDLER(UVERBS_METHOD_COMP_CNTR_READ)(struct uverbs_attr_bundle *attrs)
> >+{
> >+	struct ib_comp_cntr *cc = uverbs_attr_get_obj(attrs, UVERBS_ATTR_READ_COMP_CNTR_HANDLE);
> >+	enum ib_comp_cntr_entry entry;
> >+	u64 value;
> >+	int ret;
> >+
> >+	if (!cc->device->ops.read_comp_cntr)
> >+		return -EOPNOTSUPP;
> >+
> >+	ret = uverbs_get_const(&entry, attrs, UVERBS_ATTR_READ_COMP_CNTR_ENTRY);
> >+	if (ret)
> >+		return ret;
> >+
> >+	ret = cc->device->ops.read_comp_cntr(cc, entry, &value);
> >+	if (ret)
> >+		return ret;
> >+
> >+	return uverbs_copy_to(attrs, UVERBS_ATTR_READ_COMP_CNTR_RESP_VALUE, &value, sizeof(value));
> >+}
> >+
> >+DECLARE_UVERBS_NAMED_METHOD(
> >+	UVERBS_METHOD_COMP_CNTR_CREATE,
> >+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_COMP_CNTR_HANDLE,
> >+			UVERBS_OBJECT_COMP_CNTR,
> >+			UVERBS_ACCESS_NEW,
> >+			UA_MANDATORY),
> >+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_VA,
> >+			   UVERBS_ATTR_TYPE(u64),
> >+			   UA_OPTIONAL),
> >+	UVERBS_ATTR_RAW_FD(UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_FD,
> >+			   UA_OPTIONAL),
> >+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_OFFSET,
> >+			   UVERBS_ATTR_TYPE(u64),
> >+			   UA_OPTIONAL),
> >+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_VA,
> >+			   UVERBS_ATTR_TYPE(u64),
> >+			   UA_OPTIONAL),
> >+	UVERBS_ATTR_RAW_FD(UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_FD,
> >+			   UA_OPTIONAL),
> >+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_OFFSET,
> >+			   UVERBS_ATTR_TYPE(u64),
> >+			   UA_OPTIONAL),
> >+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_COMP_CNTR_RESP_COUNT_MAX_VALUE,
> >+			    UVERBS_ATTR_TYPE(u64),
> >+			    UA_MANDATORY),
> >+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_COMP_CNTR_RESP_ERR_COUNT_MAX_VALUE,
> >+			    UVERBS_ATTR_TYPE(u64),
> >+			    UA_MANDATORY),
> >+	UVERBS_ATTR_UHW());
> >+
> >+DECLARE_UVERBS_NAMED_METHOD_DESTROY(
> >+	UVERBS_METHOD_COMP_CNTR_DESTROY,
> >+	UVERBS_ATTR_IDR(UVERBS_ATTR_DESTROY_COMP_CNTR_HANDLE,
> >+			UVERBS_OBJECT_COMP_CNTR,
> >+			UVERBS_ACCESS_DESTROY,
> >+			UA_MANDATORY));
> >+
> >+DECLARE_UVERBS_NAMED_METHOD(
> >+	UVERBS_METHOD_COMP_CNTR_SET,
> >+	UVERBS_ATTR_IDR(UVERBS_ATTR_SET_COMP_CNTR_HANDLE,
> >+			UVERBS_OBJECT_COMP_CNTR,
> >+			UVERBS_ACCESS_WRITE,
> >+			UA_MANDATORY),
> >+	UVERBS_ATTR_CONST_IN(UVERBS_ATTR_SET_COMP_CNTR_ENTRY,
> >+			     enum ib_uverbs_comp_cntr_entry,
> >+			     UA_MANDATORY),
> >+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_SET_COMP_CNTR_VALUE,
> >+			   UVERBS_ATTR_TYPE(u64),
> >+			   UA_MANDATORY));
> >+
> >+DECLARE_UVERBS_NAMED_METHOD(
> >+	UVERBS_METHOD_COMP_CNTR_INC,
> >+	UVERBS_ATTR_IDR(UVERBS_ATTR_INC_COMP_CNTR_HANDLE,
> >+			UVERBS_OBJECT_COMP_CNTR,
> >+			UVERBS_ACCESS_WRITE,
> >+			UA_MANDATORY),
> >+	UVERBS_ATTR_CONST_IN(UVERBS_ATTR_INC_COMP_CNTR_ENTRY,
> >+			     enum ib_uverbs_comp_cntr_entry,
> >+			     UA_MANDATORY),
> >+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_INC_COMP_CNTR_VALUE,
> >+			   UVERBS_ATTR_TYPE(u64),
> >+			   UA_MANDATORY));
> >+
> >+DECLARE_UVERBS_NAMED_METHOD(
> >+	UVERBS_METHOD_COMP_CNTR_READ,
> >+	UVERBS_ATTR_IDR(UVERBS_ATTR_READ_COMP_CNTR_HANDLE,
> >+			UVERBS_OBJECT_COMP_CNTR,
> >+			UVERBS_ACCESS_READ,
> >+			UA_MANDATORY),
> >+	UVERBS_ATTR_CONST_IN(UVERBS_ATTR_READ_COMP_CNTR_ENTRY,
> >+			     enum ib_uverbs_comp_cntr_entry,
> >+			     UA_MANDATORY),
> >+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_READ_COMP_CNTR_RESP_VALUE,
> >+			    UVERBS_ATTR_TYPE(u64),
> >+			    UA_MANDATORY));
> >+
> >+DECLARE_UVERBS_NAMED_OBJECT(
> >+	UVERBS_OBJECT_COMP_CNTR,
> >+	UVERBS_TYPE_ALLOC_IDR(uverbs_free_comp_cntr),
> >+	&UVERBS_METHOD(UVERBS_METHOD_COMP_CNTR_CREATE),
> >+	&UVERBS_METHOD(UVERBS_METHOD_COMP_CNTR_DESTROY),
> >+	&UVERBS_METHOD(UVERBS_METHOD_COMP_CNTR_SET),
> >+	&UVERBS_METHOD(UVERBS_METHOD_COMP_CNTR_INC),
> >+	&UVERBS_METHOD(UVERBS_METHOD_COMP_CNTR_READ));
> >+
> >+const struct uapi_definition uverbs_def_obj_comp_cntr[] = {
> >+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_COMP_CNTR,
> >+				      UAPI_DEF_OBJ_NEEDS_FN(destroy_comp_cntr)),
> >+	{}
> >+};
> >diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
> >index be0730e8509e..2c607b02d9d5 100644
> >--- a/drivers/infiniband/core/uverbs_std_types_qp.c
> >+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
> >@@ -367,11 +367,54 @@ DECLARE_UVERBS_NAMED_METHOD(
> >  			    UVERBS_ATTR_TYPE(struct ib_uverbs_destroy_qp_resp),
> >  			    UA_MANDATORY));
> >+static int UVERBS_HANDLER(UVERBS_METHOD_QP_ATTACH_COMP_CNTR)(
> >+	struct uverbs_attr_bundle *attrs)
> >+{
> >+	struct ib_uobject *qp_uobj = uverbs_attr_get_uobject(
> >+		attrs, UVERBS_ATTR_QP_ATTACH_COMP_CNTR_QP_HANDLE);
> >+	struct ib_comp_cntr *cc = uverbs_attr_get_obj(
> >+		attrs, UVERBS_ATTR_QP_ATTACH_COMP_CNTR_HANDLE);
> >+	struct ib_comp_cntr_attach_attr attr = {};
> >+	struct ib_qp *qp = qp_uobj->object;
> >+	int ret;
> >+
> >+	if (!cc->device->ops.qp_attach_comp_cntr)
> >+		return -EOPNOTSUPP;
> >+
> >+	ret = uverbs_get_flags32(&attr.op_mask, attrs,
> >+				 UVERBS_ATTR_QP_ATTACH_COMP_CNTR_OP_MASK,
> >+				 IB_UVERBS_COMP_CNTR_ATTACH_OP_SEND |
> >+				 IB_UVERBS_COMP_CNTR_ATTACH_OP_RECV |
> >+				 IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_READ |
> >+				 IB_UVERBS_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_READ |
> >+				 IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_WRITE |
> >+				 IB_UVERBS_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_WRITE);
> >+	if (ret)
> >+		return ret;
> >+
> >+	return qp->device->ops.qp_attach_comp_cntr(qp, cc, &attr);
> >+}
> >+
> >+DECLARE_UVERBS_NAMED_METHOD(
> >+	UVERBS_METHOD_QP_ATTACH_COMP_CNTR,
> >+	UVERBS_ATTR_IDR(UVERBS_ATTR_QP_ATTACH_COMP_CNTR_QP_HANDLE,
> >+			UVERBS_OBJECT_QP,
> >+			UVERBS_ACCESS_WRITE,
> >+			UA_MANDATORY),
> >+	UVERBS_ATTR_IDR(UVERBS_ATTR_QP_ATTACH_COMP_CNTR_HANDLE,
> >+			UVERBS_OBJECT_COMP_CNTR,
> >+			UVERBS_ACCESS_READ,
> >+			UA_MANDATORY),
> >+	UVERBS_ATTR_FLAGS_IN(UVERBS_ATTR_QP_ATTACH_COMP_CNTR_OP_MASK,
> >+			     enum ib_uverbs_comp_cntr_attach_op,
> >+			     UA_OPTIONAL));
> >+
> >  DECLARE_UVERBS_NAMED_OBJECT(
> >  	UVERBS_OBJECT_QP,
> >  	UVERBS_TYPE_ALLOC_IDR_SZ(sizeof(struct ib_uqp_object), uverbs_free_qp),
> >  	&UVERBS_METHOD(UVERBS_METHOD_QP_CREATE),
> >-	&UVERBS_METHOD(UVERBS_METHOD_QP_DESTROY));
> >+	&UVERBS_METHOD(UVERBS_METHOD_QP_DESTROY),
> >+	&UVERBS_METHOD(UVERBS_METHOD_QP_ATTACH_COMP_CNTR));
> >  const struct uapi_definition uverbs_def_obj_qp[] = {
> >  	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_QP,
> >diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
> >index 31b248295854..a3f42a50a14f 100644
> >--- a/drivers/infiniband/core/uverbs_uapi.c
> >+++ b/drivers/infiniband/core/uverbs_uapi.c
> >@@ -628,6 +628,7 @@ void uverbs_destroy_api(struct uverbs_api *uapi)
> >  static const struct uapi_definition uverbs_core_api[] = {
> >  	UAPI_DEF_CHAIN(uverbs_def_obj_async_fd),
> >  	UAPI_DEF_CHAIN(uverbs_def_obj_counters),
> >+	UAPI_DEF_CHAIN(uverbs_def_obj_comp_cntr),
> >  	UAPI_DEF_CHAIN(uverbs_def_obj_cq),
> >  	UAPI_DEF_CHAIN(uverbs_def_obj_device),
> >  	UAPI_DEF_CHAIN(uverbs_def_obj_dm),
> >diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> >index 9dd76f489a0b..b0db80447bf0 100644
> >--- a/include/rdma/ib_verbs.h
> >+++ b/include/rdma/ib_verbs.h
> >@@ -453,6 +453,7 @@ struct ib_device_attr {
> >  	u64			max_dm_size;
> >  	/* Max entries for sgl for optimized performance per READ */
> >  	u32			max_sgl_rd;
> >+	u32			max_comp_cntr;
> >  };
> >  enum ib_mtu {
> >@@ -1746,6 +1747,33 @@ struct ib_cq {
> >  	struct rdma_restrack_entry res;
> >  };
> >+struct ib_comp_cntr {
> >+	struct ib_device *device;
> >+	struct ib_uobject *uobject;
> >+	struct ib_umem *comp_umem;
> >+	struct ib_umem *err_umem;
> >+	u64 comp_count_max_value;
> >+	u64 err_count_max_value;
> >+};
> >+
> >+enum ib_comp_cntr_entry {
> >+	IB_COMP_CNTR_ENTRY_COMP = IB_UVERBS_COMP_CNTR_ENTRY_COMP,
> >+	IB_COMP_CNTR_ENTRY_ERR = IB_UVERBS_COMP_CNTR_ENTRY_ERR,
> >+};
> >+
> >+enum ib_comp_cntr_attach_op {
> >+	IB_COMP_CNTR_ATTACH_OP_SEND = IB_UVERBS_COMP_CNTR_ATTACH_OP_SEND,
> >+	IB_COMP_CNTR_ATTACH_OP_RECV = IB_UVERBS_COMP_CNTR_ATTACH_OP_RECV,
> >+	IB_COMP_CNTR_ATTACH_OP_RDMA_READ = IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_READ,
> >+	IB_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_READ = IB_UVERBS_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_READ,
> >+	IB_COMP_CNTR_ATTACH_OP_RDMA_WRITE = IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_WRITE,
> >+	IB_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_WRITE = IB_UVERBS_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_WRITE,
> >+};
> >+
> >+struct ib_comp_cntr_attach_attr {
> >+	u32 op_mask;
> >+};
> >+
> >  struct ib_srq {
> >  	struct ib_device       *device;
> >  	struct ib_pd	       *pd;
> >@@ -2624,6 +2652,8 @@ struct ib_device_ops {
> >  			 struct ib_udata *udata);
> >  	int (*modify_qp)(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
> >  			 int qp_attr_mask, struct ib_udata *udata);
> >+	int (*qp_attach_comp_cntr)(struct ib_qp *qp, struct ib_comp_cntr *cc,
> >+				   struct ib_comp_cntr_attach_attr *attr);
> >  	int (*query_qp)(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
> >  			int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr);
> >  	int (*destroy_qp)(struct ib_qp *qp, struct ib_udata *udata);
> >@@ -2645,6 +2675,12 @@ struct ib_device_ops {
> >  	 * post_destroy_cq - Free all kernel resources
> >  	 */
> >  	void (*post_destroy_cq)(struct ib_cq *cq);
> >+	int (*create_comp_cntr)(struct ib_comp_cntr *cc,
> >+				struct uverbs_attr_bundle *attrs);
> >+	int (*destroy_comp_cntr)(struct ib_comp_cntr *cc);
> >+	int (*set_comp_cntr)(struct ib_comp_cntr *cc, enum ib_comp_cntr_entry entry, u64 value);
> >+	int (*inc_comp_cntr)(struct ib_comp_cntr *cc, enum ib_comp_cntr_entry entry, u64 amount);
> >+	int (*read_comp_cntr)(struct ib_comp_cntr *cc, enum ib_comp_cntr_entry entry, u64 *value);
> >  	struct ib_mr *(*get_dma_mr)(struct ib_pd *pd, int mr_access_flags);
> >  	struct ib_mr *(*reg_user_mr)(struct ib_pd *pd, u64 start, u64 length,
> >  				     u64 virt_addr, int mr_access_flags,
> >@@ -2878,6 +2914,7 @@ struct ib_device_ops {
> >  	DECLARE_RDMA_OBJ_SIZE(ib_ah);
> >  	DECLARE_RDMA_OBJ_SIZE(ib_counters);
> >  	DECLARE_RDMA_OBJ_SIZE(ib_cq);
> >+	DECLARE_RDMA_OBJ_SIZE(ib_comp_cntr);
> >  	DECLARE_RDMA_OBJ_SIZE(ib_dmah);
> >  	DECLARE_RDMA_OBJ_SIZE(ib_mw);
> >  	DECLARE_RDMA_OBJ_SIZE(ib_pd);
> >diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
> >index 72041c1b0ea5..6ff6a2afdc60 100644
> >--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
> >+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
> >@@ -57,6 +57,7 @@ enum uverbs_default_objects {
> >  	UVERBS_OBJECT_ASYNC_EVENT,
> >  	UVERBS_OBJECT_DMAH,
> >  	UVERBS_OBJECT_DMABUF,
> >+	UVERBS_OBJECT_COMP_CNTR,
> >  };
> >  enum {
> >@@ -168,6 +169,7 @@ enum uverbs_attrs_destroy_qp_cmd_attr_ids {
> >  enum uverbs_methods_qp {
> >  	UVERBS_METHOD_QP_CREATE,
> >  	UVERBS_METHOD_QP_DESTROY,
> >+	UVERBS_METHOD_QP_ATTACH_COMP_CNTR,
> >  };
> >  enum uverbs_attrs_create_srq_cmd_attr_ids {
> >@@ -434,4 +436,52 @@ enum uverbs_attrs_query_gid_entry_cmd_attr_ids {
> >  	UVERBS_ATTR_QUERY_GID_ENTRY_RESP_ENTRY,
> >  };
> >+enum uverbs_methods_comp_cntr {
> >+	UVERBS_METHOD_COMP_CNTR_CREATE,
> >+	UVERBS_METHOD_COMP_CNTR_DESTROY,
> >+	UVERBS_METHOD_COMP_CNTR_SET,
> >+	UVERBS_METHOD_COMP_CNTR_INC,
> >+	UVERBS_METHOD_COMP_CNTR_READ,
> >+};
> >+
> >+enum uverbs_attrs_create_comp_cntr_cmd_attr_ids {
> >+	UVERBS_ATTR_CREATE_COMP_CNTR_HANDLE,
> >+	UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_VA,
> >+	UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_FD,
> >+	UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_OFFSET,
> >+	UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_VA,
> >+	UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_FD,
> >+	UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_OFFSET,
> >+	UVERBS_ATTR_CREATE_COMP_CNTR_RESP_COUNT_MAX_VALUE,
> >+	UVERBS_ATTR_CREATE_COMP_CNTR_RESP_ERR_COUNT_MAX_VALUE,
> >+};
> >+
> >+enum uverbs_attrs_destroy_comp_cntr_cmd_attr_ids {
> >+	UVERBS_ATTR_DESTROY_COMP_CNTR_HANDLE,
> >+};
> >+
> >+enum uverbs_attrs_set_comp_cntr_cmd_attr_ids {
> >+	UVERBS_ATTR_SET_COMP_CNTR_HANDLE,
> >+	UVERBS_ATTR_SET_COMP_CNTR_ENTRY,
> >+	UVERBS_ATTR_SET_COMP_CNTR_VALUE,
> >+};
> >+
> >+enum uverbs_attrs_inc_comp_cntr_cmd_attr_ids {
> >+	UVERBS_ATTR_INC_COMP_CNTR_HANDLE,
> >+	UVERBS_ATTR_INC_COMP_CNTR_ENTRY,
> >+	UVERBS_ATTR_INC_COMP_CNTR_VALUE,
> >+};
> >+
> >+enum uverbs_attrs_read_comp_cntr_cmd_attr_ids {
> >+	UVERBS_ATTR_READ_COMP_CNTR_HANDLE,
> >+	UVERBS_ATTR_READ_COMP_CNTR_ENTRY,
> >+	UVERBS_ATTR_READ_COMP_CNTR_RESP_VALUE,
> >+};
> >+
> >+enum uverbs_attrs_qp_attach_comp_cntr_cmd_attr_ids {
> >+	UVERBS_ATTR_QP_ATTACH_COMP_CNTR_QP_HANDLE,
> >+	UVERBS_ATTR_QP_ATTACH_COMP_CNTR_HANDLE,
> >+	UVERBS_ATTR_QP_ATTACH_COMP_CNTR_OP_MASK,
> >+};
> >+
> >  #endif
> >diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
> >index 90c5cd8e7753..f38236b056a7 100644
> >--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
> >+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
> >@@ -273,4 +273,18 @@ struct ib_uverbs_gid_entry {
> >  	__u32 netdev_ifindex; /* It is 0 if there is no netdev associated with it */
> >  };
> >+enum ib_uverbs_comp_cntr_entry {
> >+	IB_UVERBS_COMP_CNTR_ENTRY_COMP,
> >+	IB_UVERBS_COMP_CNTR_ENTRY_ERR,
> >+};
> >+
> >+enum ib_uverbs_comp_cntr_attach_op {
> >+	IB_UVERBS_COMP_CNTR_ATTACH_OP_SEND = 1 << 0,
> >+	IB_UVERBS_COMP_CNTR_ATTACH_OP_RECV = 1 << 1,
> >+	IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_READ = 1 << 2,
> >+	IB_UVERBS_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_READ = 1 << 3,
> >+	IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_WRITE = 1 << 4,
> >+	IB_UVERBS_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_WRITE = 1 << 5,
> >+};
> >+
> >  #endif
> >diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
> >index 3b7bd99813e9..45d142f4a7f8 100644
> >--- a/include/uapi/rdma/ib_user_verbs.h
> >+++ b/include/uapi/rdma/ib_user_verbs.h
> >@@ -299,7 +299,7 @@ struct ib_uverbs_ex_query_device_resp {
> >  	struct ib_uverbs_cq_moderation_caps cq_moderation_caps;
> >  	__aligned_u64 max_dm_size;
> >  	__u32 xrc_odp_caps;
> >-	__u32 reserved;
> >+	__u32 max_comp_cntr;
> >  };
> >  struct ib_uverbs_query_port {
> 
> 
> -- 
> Doug Ledford <doug.ledford@hpe.com>
>     GPG KeyID: B826A3330E572FDD
>     Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD




