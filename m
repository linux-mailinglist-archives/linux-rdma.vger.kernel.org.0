Return-Path: <linux-rdma+bounces-3770-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EAF92BE1A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 17:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14455B299E3
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175D319D88E;
	Tue,  9 Jul 2024 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fdjWeDhG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D919CD11
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jul 2024 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537285; cv=none; b=Y1go3nGNLbu9cKn/hD6MV4QWV98U7KyWuXsR+0IILxuLjjR6diP2R7hkDXKNwWa2lDVwOQwvoy7MF2+0Y2QYPE4G/LbrKqgkzsYkBVb2r4exvwPHIYONzJ81DR2R6MPEiLE7nBsmJwMN8NdpaLU7whmhOh2tAMjBiKQvOXF27aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537285; c=relaxed/simple;
	bh=U7qiUsI2htMNsTCT/ORFDsopx08ziEbA1lzS95XiqkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gVzQ7NylYm9OJbTvUSQDud2JE+JG/nCaJCW2MNdAO/2AfwNO+lVHS4jYQFr/NC5jy24zpfF20znDo+jRu/ZqfAI4VIzpekRCsyC9kJbKlhb4gtKEIMSKtPVkIXrAB3blQj2v6g+l3BHV1lfQEefLugA7qqQxLhqMMFcoFu/N9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fdjWeDhG; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so730199a12.2
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jul 2024 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1720537281; x=1721142081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ9Fcy6jInXMAlQdB9t8EgtlchCzqUWqiuYiAj5dAM4=;
        b=fdjWeDhGto9XDjak33U05Mpt3Y3ouRf5j9RRDoYRcrd2TfLU1K95cMk7AiDef7UJqb
         qvy36tPHWTuHorpZ5Zn0cThN3YBv+Zbrx9eeX/q135JEjQjBf6P9roILpY7OXc0ZM0Z7
         SvQQ5PfTShzV6ZQl8YyMgOD+yWBPtuOmMZqBl4cxGeLvWl+XRukqp510bZZpipAtjfDe
         icXmlch3RfSMkz7RFsiMQ3KBmtqDhWMpd/61OC7MUfGK+bMPVIDzL0cmPsY/cVwAI2nl
         X0834LlcgqILPaA4KqiVwlFChZFxdZwekfu3Fq/YYJiyPGvi1sMXzrYb7KD4LzjK9YGB
         SLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720537281; x=1721142081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJ9Fcy6jInXMAlQdB9t8EgtlchCzqUWqiuYiAj5dAM4=;
        b=gou+0hPTaqzrM5vwS3dGSEBn6pm26SevplUrUFEdbiujBFYglTAVZ66uWHjBjKNsEX
         mUh+yGPrNKj8Yi/hfFssIUC9kH6qD2+vOfK8gz7XIrsL3ol4XqMb7KfjEPYZPFBu7WzE
         mczsV2YCgJfLGcXJM3Ma/4z7tVZgXff8MscJP/BubmquPT73pW60uh/tHYiasVs1Mb4M
         O55HcNs8cU8rutvVqZ6YhfHd+eojTaUIbozbi+2XJsDAyuCxYb2YFLl5xx7HVgdZC0G/
         P9QAl6/mE+6hPhoRW6Jg8UwmcwySvijHeOdIKbpLJL+89+KF3CbdGg2K0KDVj6i8rRcP
         XsBw==
X-Gm-Message-State: AOJu0Yzoh7wIGwMpjkYzS/UAB5wtZd5qW8jMK3ZG/YY5edv2BpGUuHL9
	GAQ+ZFl7FplWWG/b6D+vw1rnhiQNtZKFXRO3n2EDbrQFunCcog/z3j5Re+IdHzyBC8r/9oC072Q
	m
X-Google-Smtp-Source: AGHT+IFbID3MxTyyhk+4uqV4y4hD1ROay1VnZEcHF2YuvFeh41n2nFxjB7J1zkJKqXVr47C+uC+ZIw==
X-Received: by 2002:a17:906:1304:b0:a6f:dffc:54b6 with SMTP id a640c23a62f3a-a780b89c9eemr167868766b.73.1720537281100;
        Tue, 09 Jul 2024 08:01:21 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:1436:4f00:2ca:d136:a29a:bb96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc4e80c6sm1166172a12.46.2024.07.09.08.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:01:20 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	selvin.xavier@broadcom.com,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com
Subject: [PATCH for-next 0/2] Fix for bnxt_re endianness issue
Date: Tue,  9 Jul 2024 17:01:17 +0200
Message-Id: <20240709150119.29937-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have found an issue when map a RNBD device between MLX and BCM nics.
When map a device between servers with MLX and BCM RoCE nics, RTRS
server complain about unknown imm type, and can't map the device,

The problem is bnxt_re do not handle endianness correctly in some cases,
hence this small patchset.

I tested it between BCM RoCE nics, also BCM and MLX NiCs for RNBD traffic.

Please review and consider for next release, the bug exists since the
beginning of bnxt_re.

Jack Wang (2):
  bnxt_re: Fix imm_data endianness
  bnxt_re: Fix inv_key endianness

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 14 +++++++-------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.34.1


