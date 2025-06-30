Return-Path: <linux-rdma+bounces-11756-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E37AEDA46
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 12:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE34188FE98
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 10:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7278924A044;
	Mon, 30 Jun 2025 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7iPTyjo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32095245000
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280764; cv=none; b=DYXNqrG5CA4+8QnWZuLcWLl9XeBBM6Jcb3fg2qHsjMxETYGBvnyWWaipIggsabTGBSlcJJvC3t55gBfrnRie0Z7CimmqBK0SnpQ+XMnPJdq6tEGDz8WZ9VVOXfQZpAhJ4ZyxiopF/QaFnYxwfjHfCC4gCI8cpqCvKbTLyAfPzWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280764; c=relaxed/simple;
	bh=p9BpIgBKGui+9hlMV+0ULFDXgFN4OzzCNVrjsNAB8mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSDSo6v5+Nsw93B5Ymnlygspn4jK1ZyoJ8q9MsdXytxW2gEi6H8nuo8Z1SKzP3v3OMHunLVDWPIGOenc63mHwCLGQfv9sCcaD4r4ywVp22BDP3DBldYABA6G5RDjMkPzAN/rcX9XRNnQgoSDxJjt66nMvEEXpABH4WBVJ52jD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7iPTyjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CC1C4CEF3;
	Mon, 30 Jun 2025 10:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751280761;
	bh=p9BpIgBKGui+9hlMV+0ULFDXgFN4OzzCNVrjsNAB8mk=;
	h=From:To:Cc:Subject:Date:From;
	b=L7iPTyjoUmEPF4Vm5gQUEvMDN2LL+zIfBDeVPsWMYsE8mYxAgCGbrQsCg58wawz0K
	 NH8ZQVUA9IKAuRaxrm9s1TORl4EIjAkngl05LWRxiWnRCe1tOq4CA776IL8xLNmBsX
	 zHFtWK6lNl3W2+fmBegKBmaf7Zkx7Ck6s+Rcw6vZzUKs/WaZ9NHymqeySwjaResOqi
	 wKF+gxfuHjavaVh6noR1iTR4vZggVTn1Z3CMVpdFd0D3KHoA6j50I1XqZehAoHS1Bj
	 9CzbvqINnWsIIom9t9sDSYH4D4gaR422ddNorf9OyIC8YboIqmcRekDuLx/z6afHiv
	 np0qZp4EINQzg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH rdma-next 0/5] IB service resolution
Date: Mon, 30 Jun 2025 13:52:30 +0300
Message-ID: <cover.1751279793.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

From Mark,

This patchset adds support to resolve IB service records from SM. With
this feature, the user-space is able to resolve and query IB address
information like DGID and PKEY based on an IB service name or ID,
through new ucma commands.

New CM states:
 * RDMA_CM_ADDRINFO_QUERY - Indicates cm is in the process of IB service
   resolution;
 * RDMA_CM_ADDRINFO_RESOLVED - Indicates cm has finished the process of
   IB service resolution.

New CM events:
 * RDMA_CM_EVENT_ADDRINFO_RESOLVED - Indicates successful resolution of
   address information.
 * RDMA_CM_EVENT_ADDRINFO_ERROR - Indicates a failure in address
   information resolution.

The patchset also enables writing custom events into the CM. This is
particularly useful for applications that require events not typically
generated in the standard rdmacm flow. Two new event types are
supported:

 * RDMA_CM_EVENT_USER - A user-defined event, where the event details
   are specified by the application and not interpreted by the librdmacm
   library.
 * RDMA_CM_EVENT_INTERNAL - An internal event, used and consumed exclusively
   by the librdmacm library.

For instance, the new user-space API rdma_resolve_addrinfo() will
support both SA (Service Agent) and DNS resolution. In the DNS case,
since there is no standard CM event generated upon completion, an
RDMA_CM_EVENT_INTERNAL event with "ADDRINFO_RESOLVED" information as the
parameter can be written into the CM. This allows the librdmacm library
to receive the event and report an ADDRINFO_RESOLVED event to the user,
ensuring that DNS resolution follows the same workflow as IB service
record resolution.

Thanks

Mark Zhang (5):
  RDMA/sa_query: Add RMPP support for SA queries
  RDMA/sa_query: Support IB service records resolution
  RDMA/cma: Support IB service record resolution
  RDMA/ucma: Support query resolved service records
  RDMA/ucma: Support write an event into a CM

 drivers/infiniband/core/cma.c      | 136 +++++++++++++-
 drivers/infiniband/core/cma_priv.h |   4 +-
 drivers/infiniband/core/sa_query.c | 277 +++++++++++++++++++++++++++--
 drivers/infiniband/core/ucma.c     | 120 ++++++++++++-
 include/rdma/ib_mad.h              |   1 +
 include/rdma/ib_sa.h               |  37 ++++
 include/rdma/rdma_cm.h             |  21 ++-
 include/uapi/rdma/ib_user_sa.h     |  14 ++
 include/uapi/rdma/rdma_user_cm.h   |  42 ++++-
 9 files changed, 634 insertions(+), 18 deletions(-)

-- 
2.50.0


