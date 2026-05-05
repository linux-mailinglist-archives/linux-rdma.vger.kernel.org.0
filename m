Return-Path: <linux-rdma+bounces-19989-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGgVDiGh+WnR+QIAu9opvQ
	(envelope-from <linux-rdma+bounces-19989-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:49:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A64AA4C83D9
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17A3B300F147
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 07:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B11B3E3D8F;
	Tue,  5 May 2026 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Z2BVkdkA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378153CF679
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967231; cv=none; b=ncOEtkYh5VOwv4BD+0hcbw2GBJBrFalJCNyRq9fb5amz5JMbnRZsJ2A0kUu1VMvUKWYK17ezvzijsjXrfAtsQBL+N4x+atZz/PlW89Nyb2WDHY2bwf+BwiYoiyRm1lJAaW/jPbZusvZ4Vf5cgxv/1gSqhnaL8j40I9ab8peqgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967231; c=relaxed/simple;
	bh=6ZXj16g3fEJcozefgZWcR9D8SA/Rm5KEiZR4mV3Uyyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbAiVFQstPv2OtjOt9/+DoB9s9Inle+wTyoiCw6KN0yJWyG5EVKhk/OTgK7Hhyq0Vf2MXe7NB48In+pyC3IS72MktsKwY9we/GV0kxQfAtTJH0M8fqhDgHpvfUqc0ZijJh28MMPz+orS+Lks4WAHJqNGaKQRu4X7vRK2y+n7bas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Z2BVkdkA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so55344105e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 00:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777967226; x=1778572026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=onecfRphJlnqE/oCTJaBYZT0sys6LeQeVoSHHXdD2ss=;
        b=Z2BVkdkAAFhu+GneoEIeNZE3XOTf8H8vdCmMKA0caYcyVtsvdvT9buRXeKhdh9a9rC
         ILMS0Xfqb3MTy8UVWYj+oHQeUj1SJONt0y52c45vAKXOpsQGO5SisazSmp0JdWHfruQ3
         Z+i+Vk1ukNs7G/EELNpNlRTIumXgakactSJn9bJwhfqbPBPN9uqbZpl2HeFft4wR7NYU
         o4Zsm9Sro/RcMTjyayy8GN8UdcTJN9fKT9xKy2EHoV2b2/vZ7BQfwGQi3QoWwiEwqxYv
         /vFk3V6AY2bFeotNOUks+U52T44JfPjKrFlUNWja34e8F5UQOZptugmPRp0wngk5HmT+
         293Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967226; x=1778572026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onecfRphJlnqE/oCTJaBYZT0sys6LeQeVoSHHXdD2ss=;
        b=cDQ8+zYkapFVghiRmTeCAhajLH4CLrG83JN9syJAMc8ZolVMWW7XlOFmBtKQPYX9S7
         013NV6v23wAAllBYyCANFBTRTOpl40rReU1uLtkwLbWAKr7GcDjr8jivLGnufXqpp+Ow
         aowcV2NXdS21d5sPbHsyPVbifUsQUyj1byeFFIO0Vv9YzUxQekG00CTqrjibZv/ppOSN
         J0XFNj36MdLpIU7Gh2LA7iv3VzBf7ELiAekFF97sV8eeZeQr2QCXRpfBznf+1jVLGwm7
         TsBWdDhJQoXtmHtK21LDkCFBL4IKy85Kwe1gHsO+QMfb8egjqKWSiVdvTD+iR9bG1Ep8
         /RDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8x8J+5e8GLpU1jbGpIVgdcBwMNO/AMfhHn5kujTrrhle2sX6rQtxSrVkdE19xoGhOai27xLoX23n9o@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7yqYosG/pc2pjgfW57bS6naZA4WVhTfzO3TOetRjko1SnJfRq
	Ih7Nhl7bJR7pRNjG5mB0iNaz8GS+WifmootKG1FvzJWnzliXDeyChXRI3SFCIT8W6hA=
X-Gm-Gg: AeBDietT3Ap5nTYXy+UOqv/ayj6+w+yZ0wM9oLwEfYi6IPDBq+7VSFXPfCPHKX25BL8
	julFmt3ssk0ANMesJ0HwrGkdMEEy2f4iDjCPQ9nJxbE3alXcGds4m7xKffB0aNYgWLI5/oFqAJz
	/EOVue726ghKgOZjceTsGoCg8H9dFd+0m4hbb04rHyMO/TNUFVWu2Co3HIK/VEWBaE5yEU/JFEh
	qI1U1l4jBMEj/ySkHF4yRL7E/62VZm96fLJ8Gb5wYly5ALi/839JckXoJz0HEIwclCbO3fJq0Y0
	3AyWuapXAv+MtQlasEoaqJizdqaBefgnFHdWIxgQ/BaU+xpcuQEMrCmHeXCRz4V118p+nX1cZac
	heuek6vIMpON9kl3dXBLNTb/3DEocZjEhC6637t2mKUFyfYxD2EFonS6fpI7kfXufMGeuKP6wiH
	fUk03PmgZNjUSNIUoIvkSYqBulSRC/12ilHsk1aQUgmIgz9bN1Eu9LU+fz4xlVoBDWGsjprhuaf
	Ko+0rVF1l33/ycMNnb0KsaeBtXGCkjqRS8dUYCAuoEsr1BcrNvf11g0
X-Received: by 2002:a05:600c:4e43:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48a98638227mr224821345e9.12.1777967225951;
        Tue, 05 May 2026 00:47:05 -0700 (PDT)
Received: from lb03189.fkb.profitbricks.net ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d186d97c4sm10617125e9.35.2026.05.05.00.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:47:05 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	axboe@kernel.dk,
	bvanassche@acm.org,
	hch@lst.de,
	jgg@ziepe.ca,
	leon@kernel.org,
	jinpu.wang@ionos.com,
	Md Haris Iqbal <haris.iqbal@ionos.com>
Subject: [LSF/MM/BPF RFC PATCH 00/13] 
Date: Tue,  5 May 2026 09:46:12 +0200
Message-ID: <20260505074644.195453-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A64AA4C83D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.02 / 15.00];
	SUBJ_ALL_CAPS(2.18)[29];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19989-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[ionos.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

Following a conversation with Bart yesterday, I am sending the RMR+BRMR
code through patch for easier review.

The patches apply over the for-next branch of the block tree over commit
07dfa981ca3

For context,
RMR (Reliable Multicast over RTRS) is a kernel module that provides
active-active block-level replication over RDMA. It guarantees delivery
of IO to a group of storage nodes and handles resynchronization of data
directly between storage nodes without involving the compute client.

BRMR (Block device over RMR) sits on top of RMR and exposes a standard
Linux block device (/dev/brmrX) backed by an RMR pool. Together, RMR and
BRMR provide a single-hop replication and resynchronization solution for
RDMA-connected storage clusters.

My session is on Wednesday, at 12 in the storage room (Istanbul).

The modules are still in-development. Many of the parts are only
functionally complete. Some features (backend store replace) are
disabled for now.

Documentation: https://ionos-cloud.github.io/rmr.io/index.html
GitHub link: https://github.com/ionos-cloud/RMR (for kernel v6.12)

Md Haris Iqbal (13):
  RDMA/rmr: add public and private headers
  RDMA/rmr: add shared library code (pool, map, request)
  RDMA/rmr: client: main functionality
  RDMA/rmr: client: sysfs interface functions
  RDMA/rmr: server: main functionality
  RDMA/rmr: server: sysfs interface functions
  RDMA/rmr: include client and server modules into kernel compilation
  block/brmr: add private headers with brmr protocol structs and helpers
  block/brmr: client: main functionality
  block/brmr: client: sysfs interface functions
  block/brmr: server: main functionality
  block/brmr: server: sysfs interface functions
  block/brmr: include client and server modules into kernel compilation

 drivers/block/Kconfig                      |    2 +
 drivers/block/Makefile                     |    1 +
 drivers/block/brmr/Kconfig                 |   28 +
 drivers/block/brmr/Makefile                |   16 +
 drivers/block/brmr/brmr-clt-reque.c        |  228 ++
 drivers/block/brmr/brmr-clt-stats.c        |  332 ++
 drivers/block/brmr/brmr-clt-sysfs.c        |  463 +++
 drivers/block/brmr/brmr-clt.c              | 1222 +++++++
 drivers/block/brmr/brmr-clt.h              |  299 ++
 drivers/block/brmr/brmr-proto.h            |  121 +
 drivers/block/brmr/brmr-srv-sysfs.c        |  707 ++++
 drivers/block/brmr/brmr-srv.c              | 1402 +++++++
 drivers/block/brmr/brmr-srv.h              |  133 +
 drivers/infiniband/Kconfig                 |    1 +
 drivers/infiniband/ulp/Makefile            |    1 +
 drivers/infiniband/ulp/rmr/Kconfig         |   35 +
 drivers/infiniband/ulp/rmr/Makefile        |   23 +
 drivers/infiniband/ulp/rmr/rmr-clt-stats.c |   29 +
 drivers/infiniband/ulp/rmr/rmr-clt-sysfs.c | 1496 ++++++++
 drivers/infiniband/ulp/rmr/rmr-clt-trace.c |   11 +
 drivers/infiniband/ulp/rmr/rmr-clt-trace.h |  110 +
 drivers/infiniband/ulp/rmr/rmr-clt.c       | 3866 ++++++++++++++++++++
 drivers/infiniband/ulp/rmr/rmr-clt.h       |  291 ++
 drivers/infiniband/ulp/rmr/rmr-map-mgmt.c  |  933 +++++
 drivers/infiniband/ulp/rmr/rmr-map.c       |  904 +++++
 drivers/infiniband/ulp/rmr/rmr-map.h       |  246 ++
 drivers/infiniband/ulp/rmr/rmr-pool.c      |  401 ++
 drivers/infiniband/ulp/rmr/rmr-pool.h      |  400 ++
 drivers/infiniband/ulp/rmr/rmr-proto.h     |  273 ++
 drivers/infiniband/ulp/rmr/rmr-req.c       |  796 ++++
 drivers/infiniband/ulp/rmr/rmr-req.h       |   65 +
 drivers/infiniband/ulp/rmr/rmr-srv-md.c    |  764 ++++
 drivers/infiniband/ulp/rmr/rmr-srv-sysfs.c | 1047 ++++++
 drivers/infiniband/ulp/rmr/rmr-srv.c       | 3306 +++++++++++++++++
 drivers/infiniband/ulp/rmr/rmr-srv.h       |  219 ++
 drivers/infiniband/ulp/rmr/rmr.h           |  229 ++
 36 files changed, 20400 insertions(+)
 create mode 100644 drivers/block/brmr/Kconfig
 create mode 100644 drivers/block/brmr/Makefile
 create mode 100644 drivers/block/brmr/brmr-clt-reque.c
 create mode 100644 drivers/block/brmr/brmr-clt-stats.c
 create mode 100644 drivers/block/brmr/brmr-clt-sysfs.c
 create mode 100644 drivers/block/brmr/brmr-clt.c
 create mode 100644 drivers/block/brmr/brmr-clt.h
 create mode 100644 drivers/block/brmr/brmr-proto.h
 create mode 100644 drivers/block/brmr/brmr-srv-sysfs.c
 create mode 100644 drivers/block/brmr/brmr-srv.c
 create mode 100644 drivers/block/brmr/brmr-srv.h
 create mode 100644 drivers/infiniband/ulp/rmr/Kconfig
 create mode 100644 drivers/infiniband/ulp/rmr/Makefile
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-clt-stats.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-clt-sysfs.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-clt-trace.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-clt-trace.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-clt.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-clt.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-map-mgmt.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-map.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-map.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-pool.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-pool.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-proto.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-req.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-req.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-srv-md.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-srv-sysfs.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-srv.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-srv.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr.h

-- 
2.43.0


