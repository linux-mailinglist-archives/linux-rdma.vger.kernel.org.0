Return-Path: <linux-rdma+bounces-11583-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4169AAE6584
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F812189B9EA
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673C329993A;
	Tue, 24 Jun 2025 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iLxvAMwZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C02989AC;
	Tue, 24 Jun 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769564; cv=none; b=R0vQOQ767cs9dWK+YtSyk3FukBciejXKHSK8Ebqb1vG/SAqqfpoBeG9cdvdWrVQ20Qu/L/QNLyN5hkaZf9oe7m0hfnYnjOVqaY8Z87C1W5FPOiPdH0SmKYlIQr/Qn2I8J9vAe0xYsfjtpfmL+w8CnBYlF0ujGABVHUo5Stxr3ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769564; c=relaxed/simple;
	bh=FbA/TYMucNCBfZZNrCca42Q4/4ZhWu7F6LfzMnQUCmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWbqXX5+QBFaoFG4z0DFVC/6PT+o31rx/xLSfERwVmVakFvMdzGRgaC2wLWtsESIVtej31IvS0GLoJbiAjTs/4uHheZJToWEhYHCJ+M+kkhsQL4BZVoGHNIQMJ+3hNO5/D5UlPoj/HWeYSJtLvP1pctpcCplVdNgm5P5jCZQR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iLxvAMwZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SgSnp6jT3yDmnCE63WVs5cKLX8hIMpg3ImbKMxGBDuc=; b=iLxvAMwZbPH7UUQxoS234Ajpr6
	B3WUcczFPHG6XRZRmPJAPO5+Yao/aSRmlhKXjsvQFDQJXpWrXYaEGVyqVb7VF1LQ2vgt648QJG+cq
	Uf1j55Wt3VInL8pkbynWGb5I2E5rx1/tiGFR19h0+fwdIzRu5SkkAGeY8jeQLixdNvHzLLfb6tb9h
	aU+9rKm1lrjpmoyuksiRJTNYhZbNWB/ljaaBIDEBxB5Dcb58wksz1POeKsy2sCxpuiEZrX3zAS8BJ
	slT5Ju2CYlSNuRIqVLj3Pn0ZQoqI3PEplWS13Xj0OyGJ827eyHHYUQJXjZifV+iwx625TABmBjCBQ
	kGIdvQeA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU38f-00000005dtd-0YOU;
	Tue, 24 Jun 2025 12:52:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"Ewan D. Milne" <emilne@redhat.com>,
	Laurence Oberman <loberman@redhat.com>,
	linux-rdma@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: fix virt_boundary_mask handling in SCSI v2
Date: Tue, 24 Jun 2025 14:52:26 +0200
Message-ID: <20250624125233.219635-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series fixes a corruption when drivers using virt_boundary_mask set
a limited max_segment_size by accident, which Red Hat reported as causing
data corruption with storvsc.  I did audit the tree and also found that
this can affect SRP and iSER as well.

Changes since v1:
 - improve the srp commit log
 - slightly simplify the limits assignment in hosts.c

Diffstat:
 infiniband/ulp/srp/ib_srp.c |    5 +++--
 scsi/hosts.c                |   18 +++++++++++-------
 2 files changed, 14 insertions(+), 9 deletions(-)

