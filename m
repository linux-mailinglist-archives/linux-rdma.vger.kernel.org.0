Return-Path: <linux-rdma+bounces-2897-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460118FD124
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 16:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0468228473B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B889625601;
	Wed,  5 Jun 2024 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="N1JpBdvo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201A19D8A3
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599103; cv=none; b=QruIjqX+5D0QEItgwnVFWYLttzMofqjBA7LqvG+hvCFG6FIk90dp4e5/OK8/EaWqEpH9yZJw+hslznqiPMGa9Sq3X3YGqaAu7BMQUFaJmYkFBiDYVYfYq/XTYD3ApKc8OSgqlrpLOkkJNzYj7mMvNmkrBUXRR51cAXsNglHSOv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599103; c=relaxed/simple;
	bh=moSFPCrDfimcA+gxfEnbX3UjvW7jqAL1uXSwfkesA/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgiIb47Ml/C4HHXWwoQ6JxsUt8AC5N9EkNqo8hc/b/BqkmJcoRY4SbfTR+O3EnkK1YGBbYVFVABjqPHybucy4AZaJg0qaxAA0haPj6cJvZtKMdAkxtMLm8uBoMPteuPu2H7WLSedQdJKa1T589yD1hrHC/Mhry2otl9GMKl/x7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=N1JpBdvo; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VvVlx2ZVXzlgMVV;
	Wed,  5 Jun 2024 14:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1717599099; x=1720191100; bh=UZ5otdMPOl8sn5WoS4mJMJM3t9Txf9Ub5Gz
	1dQNZhFA=; b=N1JpBdvo6fxV09VWYn9oFN1VzokK7ebCzcLDkG2prRM4s132VAq
	M6ULQNL19RPeBbOCiqMow8jsu9MzwjSDcFkO91TK8K38AYsmBP0GRhKAAHsrtn14
	ZBhTf0ngiP+gcXZ7KVq16q2t5NscD+uVRfHR3DwLXVI3cO+zdD1f9wtwf0i0tuhG
	P9O7Sfm6YNvYJBWpbzsha+g+evbXfvtx+pzheaEGNh3JJhkaQeyihjtfRxhFN+1Q
	0dDlHGtwGKRlrc55Kttf6rgxfNdvm/HVWIgoPzRqUa2gKBh0eX5act8gS7i6mJIv
	5QWkPmOKQDHoCF6BxfWDAuYRAqf9cIoCQcQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id v6V76NZWUpFS; Wed,  5 Jun 2024 14:51:39 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VvVlt5nz5zlgMVS;
	Wed,  5 Jun 2024 14:51:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	linux-rdma@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/5] iWARP Connection Manager patches
Date: Wed,  5 Jun 2024 08:50:56 -0600
Message-ID: <20240605145117.397751-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jason,

This patch series includes four cleanup and one bug fix patch for the iwc=
m.
Please consider this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (5):
  RDMA/iwcm: Use list_first_entry() where appropriate
  RDMA/iwcm: Change the return type of iwcm_deref_id()
  RDMA/iwcm: Simplify cm_event_handler()
  RDMA/iwcm: Simplify cm_work_handler()
  RDMA/iwcm: Fix a use-after-free related to destroying CM IDs

 drivers/infiniband/core/iwcm.c | 41 +++++++++++++++-------------------
 1 file changed, 18 insertions(+), 23 deletions(-)


