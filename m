Return-Path: <linux-rdma+bounces-17348-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9GyDF7TWpGnYtgUAu9opvQ
	(envelope-from <linux-rdma+bounces-17348-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 01:15:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CF51D2091
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 01:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A03E3010DB5
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 00:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9526DCE1;
	Mon,  2 Mar 2026 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qyioTYoO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEBA430B85
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772410543; cv=none; b=qGl/h9zfsFMc+ij9qnO4p+JDOE/UXSUwaqcnM9+s+x0dFui3c1zN1bCtaVAP4cVF0/ekgnU+MIlKAR0c8BGCIhNnTpI4NdRISSWrBtfP9AitzalXJAed3MusEaetZNp6qIMznzlz53uzfscjY4Fgebb89uSG43xl192m/DZmFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772410543; c=relaxed/simple;
	bh=xwDYuvoTVdhht5uJfZTvVgxfjxMhMJbPRNslXdpDLlM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ksyMB/DQMz0XV2Ki6TG0ee2LYnrrsqAYKcVtzlksNuXXBXP7qGcQ6Zo2IJPMlKQZWaoYLiEEo+ejTrmpE8FrQZH0Kc+u84tr82NW1oNqk5PdXkOntHoTeR7ATwNivJhHyrhPKaVbPgU/J3DDXhYOHVcqVNxEpGiHZ+PtQfvZbe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qyioTYoO; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-64ad18e7ffaso4546430d50.2
        for <linux-rdma@vger.kernel.org>; Sun, 01 Mar 2026 16:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772410541; x=1773015341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=93bbN74IeJcR6WWa4qknfphEuCg4/7KSTAQgFBLCbyM=;
        b=qyioTYoOORbzmPhFrKnvUt9j5VWGMbzCe1UJ3tiFQueBSeTHDJVjHNSzPAy00Kxw9F
         YqsejVDy6rYsHj6EnyJw+hJU+dYrgqbol859vcmh6eZagPVXuKQmCeuGk5CdcZR8cPJu
         CVSA4Ineqoe5MWJMv4XdAuUpx0f/tatMAXM3rz6mKZf9lgDGwbAVGsno9bVy+pEZ1a8S
         xL/BcE4x29wRy0HSF8bJyqCkZnsHHMkU8kSnv00vTP1MldNf7PH2lggH334VGvallpqC
         0RZUAovE+SqYdqSL6jmV3TFwk14bFkkg5H8cCvXSANrCstSxyEi16SpJuyhQE5zazCLU
         IT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772410541; x=1773015341;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=93bbN74IeJcR6WWa4qknfphEuCg4/7KSTAQgFBLCbyM=;
        b=Wvi2hw3VVD0e9hnnAGff1y0AlNAIe/DxfxWquygCTS/53ECrPXGHljpOtmO0+aIbBx
         5PCx3URF4C5c1Ylls66zPpLF64pIv3+d6slgzvqEoVRRjyNdG5tGyQJPUgce53n32U3b
         4uuc7O3n4t+FgvhpcmsBWala9xBoBwupY8Vn2s3p81tx1+xo/QczVYqoQGOxXH7+q4J4
         E6e5WmQS6gLw2Q7qygVEkN9sIhYkV02qPFWOL+sKVuaneQiBusSH68qSve94whzdcYv4
         wf9whULkmUF1+RqITD5CZFC103UZ+Lya8TLHiZMqgl2vWfZvKLvJXQN4vU+OYYPGZtey
         RnUA==
X-Gm-Message-State: AOJu0YwDic1nGb0ASLFgDMvn0/UAJfaNTnxdiZ0OS4RaQsZ7bPCsc6Ij
	56/p20xRwOHdhIeN0MMfLg1Q8j5RvFQoDZyd58l1lI/E1p1bzMJwBXlbYjNBdxEUJGVrgiwsksQ
	c+6UxVckTXQ==
X-Received: from yxw2.prod.google.com ([2002:a53:ac82:0:b0:64c:cfd8:45d6])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:2058:b0:649:d40c:7ee5
 with SMTP id 956f58d0204a3-64cc23228c8mr6300326d50.79.1772410541290; Sun, 01
 Mar 2026 16:15:41 -0800 (PST)
Date: Mon,  2 Mar 2026 00:15:34 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302001539.2275303-1-jmoroni@google.com>
Subject: [PATCH rdma-next v2 0/5] Add pinned revocable dmabuf import interface
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17348-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9CF51D2091
X-Rspamd-Action: no action

Some dmabuf exporters (VFIO) will require that pinned importers support
revocation. In order to support this for non-ODP drivers/devices, a new
interface is required. This new interface implements a two step process
where the driver will perform a sequence like:

    ib_umem_dmabuf_get_pinned_revocable_and_lock()
    
        ... Driver MR allocation/initialization/registration/etc
        
    ib_umem_dmabuf_set_revoke_locked()
    ib_umem_dmabuf_revoke_unlock()
    
This allows the driver to provide a callback that can be used to
perform the actual invalidation in a way that is safe against races
from concurrent revocations during initialization.

The driver must ensure that the HW will no longer access the region
before the revoke callback returns. For MRs, this can be achieved
by using the rereg capability to set the region length to 0, or
perhaps by moving the region to a new quarantine PD. For HW that
allows the driver to manage the keys (like irdma), this can be
achieved by deregistering the region in HW but not freeing the key
until the region is truly deregistered via ibv_dereg_mr.

Dependencies:
Please note that this series targets the `for-next` branch, but it depends
on the following commit currently in the `leon-for-rc` branch:

  Commit [104016eb671e] ("RDMA/umem: Fix double dma_buf_unpin in failure path")

Changes in v2:
* Created helpers for acquiring/releasing the umem_dmabuf revoke lock.
* Fixed rereg_user_mr handling in irdma to account for async revoke
  and used new revoke lock/unlock helper to simplify the dereg_mr path.
* Dropped unnecessary <linux/dma-resv.h> inclusion in irdma/main.h.

Changes in v1 (since RFCs):
* Break the interface into a two step process to avoid needing
  extra state in the driver.
* Move the majority of the functionality into the core.

v1: https://lore.kernel.org/linux-rdma/20260225210705.373126-1-jmoroni@google.com/T/#t
RFC v2: https://lore.kernel.org/linux-rdma/20260223195333.438492-1-jmoroni@google.com/T/#t
RFC v1: https://lore.kernel.org/linux-rdma/CAHYDg1TB1Xa+D700WrvrcQVdgZFE5f8iWp48EmQM9XjK9xJdew@mail.gmail.com/T/#t

Jacob Moroni (5):
  RDMA/umem: Add ib_umem_dmabuf_get_pinned_and_lock helper
  RDMA/umem: Move umem dmabuf revoke logic into helper function
  RDMA/umem: Add pinned revocable dmabuf import interface
  RDMA/umem: Add helpers for umem dmabuf revoke lock
  RDMA/irdma: Add support for revocable pinned dmabuf import

 drivers/infiniband/core/umem_dmabuf.c | 138 ++++++++++++++++++++++----
 drivers/infiniband/hw/irdma/verbs.c   | 105 +++++++++++++++++---
 include/rdma/ib_umem.h                |  24 +++++
 3 files changed, 237 insertions(+), 30 deletions(-)

-- 
2.53.0.473.g4a7958ca14-goog


