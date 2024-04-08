Return-Path: <linux-rdma+bounces-1819-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8483A89B61E
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 04:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09429B20F9B
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 02:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673A74430;
	Mon,  8 Apr 2024 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s7zvsb0F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD58617F7;
	Mon,  8 Apr 2024 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712544872; cv=none; b=bWDS3PM26xRLobvpVnVdShpuGVGzzbgA7amV3RuzwqFHiEcdEtpMQDinWHfHaW+/BSlE8KQnbFBimd924voSkj7lNsQaDzGRx+2hJyYJzD5gBeC99ZtzLOoj4mIOnnYOiM4NaOCquntT6JIzFgoTAoSPvqrABjHqukJ2Agaetqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712544872; c=relaxed/simple;
	bh=94RvMc6Rf0UIsnYRM2ZlngrhDBe/mSI9V8l2Gsna8QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twA4HHnZv3gkuRizWXCMUZG5Hu9W1ypKTXMhg/aYDsfgv+j+fZHq5e/zsK01t4EwqKxM//CsoBw3+Y+GhBLyJPUHoOzaYL4fogcF3/5220lXNiusB6JpOtvE7/iZS9GL1wpGEKIOgcRIxKzgML8iUYljkvP8PsuC/mL8rwBZW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s7zvsb0F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sVZokRLRtK/U1jkTDOTUDvOWvOdsjK6uSS0rAvoMvMU=; b=s7zvsb0FszY3b8Zjx3MaQsPz6c
	J+9tShR/usOzuGoOe9mjdBVGE8Afqk9VwBM6KnmdVSQ4bt3/u20STOWDCBzyAK34uZdbPuWEigubv
	JO0GTIZJo6P0v/tDUbtKns/v2I15RPbLgYXaldVUNbvd7FKySEOuRN7ylM8S9UwlUXafqZeMwp3Aw
	04wm3TKLe7mmnsSsv5G82rUlfORZyyj+NEALgljEUx2fXNOtysCoXj+ARLIeWlB0SSKVhSMAqnG5i
	SjxHPqpkySPz9kkWlX17RS/T2Zt3FR+upavdCEj0KAvYwqQOhkb6Om3t7B8s3VqiN3A6kUU9nDiaV
	l42C0+3w==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtf9S-0000000E7aj-106x;
	Mon, 08 Apr 2024 02:54:30 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-scsi@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH 4/8] scsi: iser: fix @read_stag kernel-doc warning
Date: Sun,  7 Apr 2024 19:54:21 -0700
Message-ID: <20240408025425.18778-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408025425.18778-1-rdunlap@infradead.org>
References: <20240408025425.18778-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct kernel-doc comments for struct iser_ctrl to prevent warnings:

iser.h:76: warning: Function parameter or struct member 'read_stag' not described in 'iser_ctrl'
iser.h:76: warning: Excess struct member 'reaf_stag' description in 'iser_ctrl'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Cc: target-devel@vger.kernel.org

 include/scsi/iser.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/scsi/iser.h b/include/scsi/iser.h
--- a/include/scsi/iser.h
+++ b/include/scsi/iser.h
@@ -63,7 +63,7 @@ struct iser_cm_hdr {
  * @rsvd:         reserved
  * @write_stag:   write rkey
  * @write_va:     write virtual address
- * @reaf_stag:    read rkey
+ * @read_stag:    read rkey
  * @read_va:      read virtual address
  */
 struct iser_ctrl {

