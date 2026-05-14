Return-Path: <linux-rdma+bounces-20677-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAR3BUKeBWr4YwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20677-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 12:04:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8098754019D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 12:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8BEF3071629
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 10:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7B6386572;
	Thu, 14 May 2026 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="sf7jvPwv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8C38B142
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752957; cv=none; b=YxuFDhvxeyt/+eEOOmmO23Awfb6WL2Q7Wk4hGmVltzIOYOqjTeJxD+nH8lGHb3lNXNnVNwAucmql0ywnlm+Zz7Jidjvx7A1loeJaTnL3bZ7xmcN7IPtuAj9+sScJZ4kIv44XAlFnvpwwpbMXOT71+HLgkXkQw+n/wexe8bleKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752957; c=relaxed/simple;
	bh=UyCdkAxXtB8chzF0EBFHVUFWuXIpUrrSZujSVtVZ/Ns=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ng/dmGSX9bHr9q+h6A6jKpZyLCocRhGPKSsYsbL1wTXzgszPCoYuVWKyLqzAICGVetQq2X4ANWysl2O1LJlV9Qskd2sl388qkBWtuZ3omIG4ibyTe1iwvKo/3G+e+aKCyTkF/EKJZQvj6KL3ALhZjFJ8cJJ1zBpG6yaYUCY+2SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=sf7jvPwv; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778752956; x=1810288956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2Csh6c7mBMRA8qcRdVcp+D2eyEalAKrxlNOYG/vtEak=;
  b=sf7jvPwvBUMIWKq2jPgD9e4yX/G5zKz2Z/lgPI8JK2fsuyCWc9PfPvEe
   HMYp3HGD601EVK0fhXmxDAhYuQN4EDFoetoNwn/g0vZ4FkoonpmLvKRmL
   cydBWYxUyZiIeKbITFEhk8a5j4fNPYPs1THjLm1FvAtuOjDaBMJ7VL04X
   prQeM8t9KHMwa7tHOMF+lw3938415YuTT2eWLqSnwmPc/GfSsjEv3Txmr
   Or/UFGsH4DSx6qy6mGyJoUBRNamveerCtSkM6Ash9qcY637h/Tqe9hM7/
   p8fl0jhsP+9sTwU5RuN6+dOsPQdEIQxstMt8d2/KvcNDYS3ezgILLXSMu
   Q==;
X-CSE-ConnectionGUID: /4wSOMt6TDmQKLXJIzfV6w==
X-CSE-MsgGUID: F4qYr2WXSXaaSNGqz23K0A==
X-IronPort-AV: E=Sophos;i="6.23,234,1770595200"; 
   d="scan'208";a="19639996"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 10:02:32 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:24325]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.132:2525] with esmtp (Farcaster)
 id dc8c17ee-da29-47a3-b014-a723ec9ab8ee; Thu, 14 May 2026 10:02:32 +0000 (UTC)
X-Farcaster-Flow-ID: dc8c17ee-da29-47a3-b014-a723ec9ab8ee
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 14 May 2026 10:02:29 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 14 May 2026
 10:02:28 +0000
Date: Thu, 14 May 2026 10:02:14 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
CC: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v2 1/2] RDMA/efa: Add initialization of AH cache
 rhashtable
Message-ID: <20260514100214.GA22423@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
References: <20260512061121.2177521-1-ynachum@amazon.com>
 <20260512061121.2177521-2-ynachum@amazon.com>
 <346a4118-4902-46a6-9245-ef37322b30b1@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <346a4118-4902-46a6-9245-ef37322b30b1@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 8098754019D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20677-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 10:12:01PM -0700, Zhu Yanjun wrote:
> 在 2026/5/11 23:11, Yonatan Nachum 写道:
> >New EFA devices don't support the creation of multiple address handles
> >to the same remote on the same PD.
> >To overcome this limitation, introduce an AH cache rhashtable which will
> >store the refcounts of the same AH creation on the same PD and will
> >allow the driver to manage AH reuse. The hashtable key is the
> >combination of PD and GID. Add initialization and teardown logic for the
> >rhashtable.
> >
> >Reviewed-by: Firas Jahjah <firasj@amazon.com>
> >Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> >Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> >---
> >  drivers/infiniband/hw/efa/Makefile       |  4 +--
> >  drivers/infiniband/hw/efa/efa_ah_cache.c | 30 ++++++++++++++++++++
> >  drivers/infiniband/hw/efa/efa_ah_cache.h | 36 ++++++++++++++++++++++++
> >  drivers/infiniband/hw/efa/efa_com.c      | 12 +++++++-
> >  drivers/infiniband/hw/efa/efa_com.h      |  5 +++-
> >  5 files changed, 83 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
> >  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h
> >
> >diff --git a/drivers/infiniband/hw/efa/efa_ah_cache.h b/drivers/infiniband/hw/efa/efa_ah_cache.h
> >new file mode 100644
> >index 000000000000..25288fdf778a
> >--- /dev/null
> >+++ b/drivers/infiniband/hw/efa/efa_ah_cache.h
> >@@ -0,0 +1,36 @@
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> >+/*
> >+ * Copyright 2026 Amazon.com, Inc. or its affiliates. All rights reserved.
> >+ */
> >+
> >+#ifndef _EFA_AH_CACHE_H_
> >+#define _EFA_AH_CACHE_H_
> >+
> >+#include <linux/refcount.h>
> >+#include <linux/rhashtable.h>
> >+
> >+#define EFA_AH_GID_SIZE 16
> >+
> >+struct efa_ah_cache_key {
> >+	u8 gid[EFA_AH_GID_SIZE];
> >+	u16 pd;
> >+};
> 
> I am not sure if we add __packed to avoid memory hole.
> 
> Zhu Yanjun

Currently there is no holes in the struct (verified using pahole) and we
Zero-initialize AH cache key so I don't think packed is really needed.

Thanks

