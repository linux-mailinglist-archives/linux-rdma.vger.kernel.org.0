Return-Path: <linux-rdma+bounces-17545-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBNqHaSmqWnwBgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17545-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 16:52:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE55214E04
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 16:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A884A321F983
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2634C3CB2FD;
	Thu,  5 Mar 2026 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eTTByaA5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD41F7916
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725296; cv=none; b=e+Z9610LKUuLd2GTvq7Jy6IWP3DLKjGalqZnHdP6qoaM6QSMrTd7lQInY1MirApNj2/mbv0EZpFgtq7aUpVasVjAV7J2ppl/xybyVbC+91bE66GL5hP15ZBqD5yHd082lulRgFhzuFIGp9HlDFGlk8jvZ6XzkVGZgGXYVXmNlUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725296; c=relaxed/simple;
	bh=vpLfmCPr4vV5hJ9vXXb17AbwJxLpTamw7A8wLj5+FOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gvBl19qO3BRL3fN6zwXjrqGVyZJb28UnFai8LFO7vp2lxKDpTgkxR2wDAJEdESRfOY3AgwpV6NuWpjtoR+fE/FF3UtAtM1ni7Wn8Ep3sNv2OIV1fRWRbwua2qiDOh0QpZoQXVgfFyUii785vNUVrcBdatv3cg2R+j3kWdAJSiCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eTTByaA5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b611274bso3105566f8f.3
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 07:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772725293; x=1773330093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=65+53gDS8WKuE3o7Ewu7Tx/zFBhi8RAv5CZRnhyRFgA=;
        b=eTTByaA5VgoLWw4E3zpmPJmblrtcmQI5dZAa717nBlOMix2iBZcFOF6yDlnLEV70KY
         jD1PteHhAMM1k5ZmMMw82YQTdTGRTgkcrsrlvhShwcfncJlDjkVP9unbj7YEw8RFBIwe
         f5abZCPW1EEZJIUdK+A4pASyW+gA3+YvhHy9YNFgttVykHwqKdjlWnoy9E2Fdrxn0fJb
         Z6iH0XvfafXsvIul9wSsS5h4Rl/lYCWddoQqzEI1awSVr8nwmgNRlKhpF0WtKrjOClzk
         WUhZSyP/tuikyh8RGgeq1EEcdqpRJmUl3dAOOcPK8rU7fJXi2/PPvNsqQyH1bAKYz4vb
         eqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772725293; x=1773330093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65+53gDS8WKuE3o7Ewu7Tx/zFBhi8RAv5CZRnhyRFgA=;
        b=r/YNNE8fhVW+eN2fahAJhKecki/Xc/wkeBFvG3UwcoMjCW/qHyGYiQeDcCyThwUKXe
         xxiZVNi47CAE0+M5TLgaSg+FcDoJPuvmbfHmXHqtkdGgPyfLJBojQWgqGjWt5wUP9Dno
         8RrZNNnJuL7Twt1Jz3GNm4ni+EeAienr+vDRjcjWjPyS0icBEz/wpRjggfvgNkE3xLjW
         73t17aNalAhkkbIPTTMIF2pS+o6qH4xXaIRN94x+oKXHdll0NVj+5IfhtD81A/g3wHDM
         ukE3c1mJ0hWOt4gI17Pze+v8AHuR4QvjONjJ/77NUZPfN9BERQnbF6WREfQlSJcXKCfC
         rnbw==
X-Forwarded-Encrypted: i=1; AJvYcCW5jSe0LJrdHrV/1Zoq+IikjYc5571F+6EtHsQGMGZh5gokJpKktYqcUaP4h6SHJ6G68jhtqUHNSiX3@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMyuv5KlPz3tykDJE6TyuTr1itmFp21aW92hcISjlvMTmQgyX
	u0njjP5WnnHSu96c1nAubTVEYkl9aIzG+/q/Ma7r3S3b1KrwnqVfY1VzScQrEFGYau4=
X-Gm-Gg: ATEYQzyEcBOX3cFMONz9Q0zRP/hk+l/cEZbsdEeTZSifDEd8jI6DELyKNg9GdMqZK4n
	xw2r9QdXLdVodHiT/PnWOONLeRMIX6AffgrTbWNPycbnZqRkVeQHw4vUhfLKNUpMh+WI5J0BO64
	sFL3ZbiG6MviZdlgkpfHbE33x8j/tuRBoyJV7Nh3AUtucp8w6gZz+2TttKmGCrlyimfZP5hmn6N
	MQpNVJh4CyPhj8fvH3oCYgXVWcBm4vUeiMdPzcuPzzhPQjBo6WqsQIaeMLPPrJDjAfDGPQgnhUu
	4pD3HW3cFC9CjuVY2fJHD4oRrkJZeTL2ZvW/N/YCHRVzSkxejLEp6xKmk82laz4ictuRj0B8zf1
	qgyDSixiC9mOwnl+Rgumb2qT9t0VroDE0jDHtSCL75w2ZFgYobXuVfLk02I5+e06cfVfQLvCnQO
	WyRKKyz8p1H67euAx3oXPbKGAG4NoW5wcSj1jBlvYwqIDC9Ek=
X-Received: by 2002:a05:6000:4383:b0:439:c279:32df with SMTP id ffacd0b85a97d-439c7fd32d1mr12326328f8f.35.1772725292628;
        Thu, 05 Mar 2026 07:41:32 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b8807a4esm31253393f8f.4.2026.03.05.07.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 07:41:32 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Md . Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH] RDMA/rtrs: add WQ_PERCPU to alloc_workqueue users
Date: Thu,  5 Mar 2026 16:41:17 +0100
Message-ID: <20260305154117.326472-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0DE55214E04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,ionos.com,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-17545-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The refactoring is going to alter the default behavior of
alloc_workqueue() to be unbound by default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU. For more details see the Link tag below.

In order to keep alloc_workqueue() behavior identical, explicitly request
WQ_PERCPU.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 3362362f9e2e..e351552733df 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -3219,7 +3219,7 @@ static int __init rtrs_client_init(void)
 		pr_err("Failed to create rtrs-client dev class\n");
 		return ret;
 	}
-	rtrs_wq = alloc_workqueue("rtrs_client_wq", 0, 0);
+	rtrs_wq = alloc_workqueue("rtrs_client_wq", WQ_PERCPU, 0);
 	if (!rtrs_wq) {
 		class_unregister(&rtrs_clt_dev_class);
 		return -ENOMEM;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 0140bfaed721..6482ad859bd1 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -2385,7 +2385,7 @@ static int __init rtrs_server_init(void)
 	if (err)
 		goto out_err;
 
-	rtrs_wq = alloc_workqueue("rtrs_server_wq", 0, 0);
+	rtrs_wq = alloc_workqueue("rtrs_server_wq", WQ_PERCPU, 0);
 	if (!rtrs_wq) {
 		err = -ENOMEM;
 		goto out_dev_class;
-- 
2.52.0


