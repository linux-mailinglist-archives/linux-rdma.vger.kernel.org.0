Return-Path: <linux-rdma+bounces-7425-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FFCA2881D
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 11:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8384C1887F7A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 10:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC3422ACEF;
	Wed,  5 Feb 2025 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CJJUOhwA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5F7218E81;
	Wed,  5 Feb 2025 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738751723; cv=none; b=Z16NqkW7r9Ag7eFff+m/m94qDDbj2Km4cLMnKvN9bMjQhZeS3NKgvX/Cbpn8CnQb2oofoRrfzM+sOreJ8KtfFZ6XIXfzurUyDnrQRU2v59SHaFbBqLxIUnTuzdTwC+wwsQrt7gaO3SGwKImB+x0L59yPbJgDsLHEgS7W5HbpJCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738751723; c=relaxed/simple;
	bh=OH69oe18aAKA53DNHSHaw+UpY+548RBbmHGQuaz6Hq4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OP+fP7sw/w2F3G3Rzq17NTjo0BqNFDu6L+i3D5OK3plZxCv1ly05lEBGQ7TyRDmNgcSu63+PoNlxWzN4scAi1i/B9odcIZ7hjPRRlQEfmyhbufokaxbKnD5FeEvSe4f0IEUTz9r3P3mXD4ICyie53iOlt4qp8GNVrNxhfrTX+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CJJUOhwA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0611A203F588;
	Wed,  5 Feb 2025 02:35:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0611A203F588
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738751722;
	bh=84Q0HKW7+aiugNDptGU8An7QGYuvzgzMAHvs+3Tvqls=;
	h=From:To:Cc:Subject:Date:From;
	b=CJJUOhwAz6GMsOU0UnXPqR5TfzhiU8bbfRJ068Kqpo3JUHnkSzMRk8znWmkG1hn1i
	 Q6JR630yy/Q92rDJg2aCV6t1ozuaTZOspq9O56579gNHUcNWFzHFdKKLdWEbi/wF/Z
	 oyYAOtfd1C38pm3CXTOPNrkkES4FA/QqlU9jSiRQ=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 0/2] RDMA/mana_ib: enable error cqes
Date: Wed,  5 Feb 2025 02:35:11 -0800
Message-Id: <1738751713-16169-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patchset enables the mana_ib driver to query capabilities and
enable creation of error cqes.

Konstantin Taranov (1):
  RDMA/mana_ib: request error CQEs when supported

Shiraz Saleem (1):
  RDMA/mana_ib: Query feature_flags bitmask from FW

 drivers/infiniband/hw/mana/main.c    |  6 +++++-
 drivers/infiniband/hw/mana/mana_ib.h | 10 ++++++++++
 include/net/mana/gdma.h              |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.43.0


