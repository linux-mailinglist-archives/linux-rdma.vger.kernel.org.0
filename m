Return-Path: <linux-rdma+bounces-1820-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169A789B626
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 04:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1F41F217DD
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 02:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3296FB6;
	Mon,  8 Apr 2024 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wsmjHel6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD6717EF;
	Mon,  8 Apr 2024 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712544873; cv=none; b=dnvl81bWd6X0U4c/uRtH5+FK9VT6KQAdDa3bK39h3Vszdd+YtI32Bk5LMXdpxNhQeohhI2IIBE18QKL/w7SsfDLCHxZQfrwuW+H+TnH8G4HrAxh387SrHgBe0wN9PKMLUxO/zmZcpXgkCZrEWf5Q04p0uPufJKZKKV30VE42hK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712544873; c=relaxed/simple;
	bh=gRV4N5xFYiInE+BHk6JlA221X5cSHeaIFbd90umqfVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4A9HDg+U8M5Mr71HEoKKnPGfPfVEKxfNYVpOF05y9aaLUKCKLmc/vObSOdpKHwI/KCH4Ge+B+RzMF97ww9APxqzA/FEETAImzkYgJ+H6gKyuUbWT5yeGFiVAqISlwZj+527FkypfxiP1eHHJYO1imCfUIJ4pAWNz6yfCaM5KYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wsmjHel6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ezkU5mMjz5A11jgyDYvnajpAqZ2htzfK9oaZIm4uNd8=; b=wsmjHel6lSKY+Sa3I96c5LcXEx
	T6EoL1aJPCogjyD/prWwQBnG8O/ISMkN+HpV2BXenw1EAT4xnmhYsMTeWzStxPzJx59gyUfQoX/GO
	3XBKqSU3QQx8Qz07CeBBkQC2c0f6XdDNdJYOKiPFcU9/lFcEYLkuoFnyFZUW48tquAK+IzlboHSZv
	vD/xegC1eaeXqczi33vzhxZwtpZQd/3jpt2edgq1rvraawC5N4P6VvqkPQ7IZ4rTDpex0w/eqC4ne
	1ToHPd9ve1zsffn49O4yBQ0+COl9+xqzb4mDuvyPoajzi0wLuLgUyr6q4mDUgcpzewrlCbUd+apgY
	R2eIBXkA==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtf9Q-0000000E7aj-2PWl;
	Mon, 08 Apr 2024 02:54:28 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-scsi@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Doug Gilbert <dgilbert@interlog.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/8] scsi: documentation: clean up docs and fix kernel-doc
Date: Sun,  7 Apr 2024 19:54:17 -0700
Message-ID: <20240408025425.18778-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up some SCSI doc files and fix kernel-doc in 6 header files in
include/scsi/.


 [PATCH 1/8] scsi: documentation: clean up overview
 [PATCH 2/8] scsi: documentation: clean up scsi_mid_low_api.rst
 [PATCH 3/8] scsi: core: add kernel-doc for scsi_msg_to_host_byte()
 [PATCH 4/8] scsi: iser: fix @read_stag kernel-doc warning
 [PATCH 5/8] scsi: libfcoe: fix a slew of kernel-doc warnings
 [PATCH 6/8] scsi: core: add function return kernel-doc for 2 functions
 [PATCH 7/8] scsi: scsi_transport_fc: add kernel-doc for function return
 [PATCH 8/8] scsi: scsi_transport_srp: fix a couple of kernel-doc warnings

 Documentation/driver-api/scsi.rst       |   15 ++++++-------
 Documentation/scsi/scsi_mid_low_api.rst |   20 ++++++++---------
 include/scsi/iser.h                     |    2 -
 include/scsi/libfcoe.h                  |   25 +++++++++++++++-------
 include/scsi/scsi.h                     |    7 +++---
 include/scsi/scsi_cmnd.h                |    2 +
 include/scsi/scsi_transport_fc.h        |    5 +---
 include/scsi/scsi_transport_srp.h       |    4 +--
 8 files changed, 46 insertions(+), 34 deletions(-)


Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: Doug Gilbert <dgilbert@interlog.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Cc: target-devel@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org

