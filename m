Return-Path: <linux-rdma+bounces-350-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E3980CA75
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 14:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3ED6B20F8B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A373D3BF;
	Mon, 11 Dec 2023 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4Gn4NW5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2FAC3
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 05:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702299877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VzAC67twAFkoZWVKcw3UCDQq4Io2ZB3JxaBjcTMtrtA=;
	b=G4Gn4NW5KCD2vN71r7MNPT1nkgrwBlhWmZOwWEBIiAzYkl+mhM6hhN6w3GTAXwzaDdoFMw
	YgRkJ56806VdUtVjViI0iUUVNapoqP3brKWCGhi3IFO1kKdkpv+qHBjo46cyG14Wr4dbfH
	dEaJFhe2hZRwKNKODr8vY3FgTzjDEBk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-N5kNjH8EO7eFxpFD1v3Bcw-1; Mon,
 11 Dec 2023 08:04:30 -0500
X-MC-Unique: N5kNjH8EO7eFxpFD1v3Bcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BF243811F2E;
	Mon, 11 Dec 2023 13:04:30 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.45.224.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E612C1C060B1;
	Mon, 11 Dec 2023 13:04:28 +0000 (UTC)
From: Daniel Vacek <neelx@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Vacek <neelx@redhat.com>
Subject: [PATCH 0/2] IB/ipoib fixes
Date: Mon, 11 Dec 2023 14:04:23 +0100
Message-ID: <20231211130426.1500427-1-neelx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

The first patch (hopefully) fixes a real issue while the second is an
unrelated cleanup. But it shares a context so sending as a series.

Daniel Vacek (2):
  IB/ipoib: Fix mcast list locking
  IB/ipoib: Clean up redundant netif_addr_lock

 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.43.0


