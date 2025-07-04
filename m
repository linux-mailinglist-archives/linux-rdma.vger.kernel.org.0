Return-Path: <linux-rdma+bounces-11894-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BCCAF86D1
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 06:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 009647B4E00
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 04:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34D11F0994;
	Fri,  4 Jul 2025 04:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JDzhd0dE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211001EF0A6
	for <linux-rdma@vger.kernel.org>; Fri,  4 Jul 2025 04:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751603585; cv=none; b=q24h2MbHyEI1oqWqGoQFK5ZGiot9HgR7PBGfekNz8hOC+FfSpTWJJfB5S//gNsBEdzTNuT8ITdqzDMmYgv/6CnhiwCA+6GFqQClCGjv6GPw599LgzHdChJitq9iAkS7fE8icJBHaixHELRJpJfl1e8TpWKxhgKLJCpZ3xhi0qVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751603585; c=relaxed/simple;
	bh=zCwfbDLWwx6y1DrzVTJ4w1+HnltV1NcOsSql4t9l+ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UsYZp8s9UIYIJLO/rU+3rLYb5NgnJqkeLhGYoiDeYTY5AZswJg76hC31RAS65KoaVPa5zQ+2WdfAmAhkLqW/Q+i6dHk/7/Y4cDugxOtq61hYLgcWWlNOBpjY0M3VNiHN9R//TLIkKaTA2i457ZNJlA1wUR0VFx4vvX3rvWFkaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JDzhd0dE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74931666cbcso546153b3a.0
        for <linux-rdma@vger.kernel.org>; Thu, 03 Jul 2025 21:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751603583; x=1752208383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cIHaJyZrnaI86Pbb636FtXudp+csned1V1dIOFwIrO4=;
        b=JDzhd0dE46m3ofVONAMIL3tPcfBPu/haJ+XFWWnWnqIhM7t4tH0SPA/sKduLcuza0q
         s4ax8buQmy7Kt8kdmvMEMw5Ven2Ga//jl5ougfm2zz5ZwQrwDYlWoN5rEHqMozrfLGpz
         Hu/BF8wQ/e5FmvzCth3iBdIXvFVrteqeouVr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751603583; x=1752208383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIHaJyZrnaI86Pbb636FtXudp+csned1V1dIOFwIrO4=;
        b=KTQWeFisvy3ksrCzy1ZApKPjh3Cr0gnL+5r6hfbK4nx1A4jXo+587HO2/eBl5HLca7
         yPtXd0XGlOn4TDUqTpQgU7mqw1VMfekEetj7aAq++xCq02WqemCAlq+X64hUYh75i+Ku
         KYuPQ6p+sgAEJnH+uDUemueWs6T7RpOkCRKhlpUJT6f7rpxHnCcFSj1SbkhXxctdjxnQ
         rVVpLJs6ljbrN/H5M5LUFaun+on45rYL7CusvzLOraw1orfUZcrduu03qL3Zjo0byL7W
         o9ER0E6NOfq4NvC8pYC1LF+Dj+zdeeL0l1uJnpdArCow5/MK/SLcMyZdWGOgv2gYZrOd
         ryUA==
X-Gm-Message-State: AOJu0YyFo0+Smjwvl7PLU6y7evfLmat/rbAXMtN+YtoobJkLgMnK6Chu
	q1pX81YJx+jKgZrS9T5uv/rJsX84AF967Ls5rm4OR6Hqsj//4f7GVsXpscqT6wLRDg==
X-Gm-Gg: ASbGncvwgtZZbnX/YDSf5mt1qCOWzts+0GvU8wwgn9cK2gGGKmlCW8tZXrzRArG3mng
	aloxUid+VGRnQNqurxGk1KmdB6YnA/UuEKi6gB6vaEYhZbsW5dlyv913iP3XJo1z+OdRlxNwVso
	VyPfmQErYs6VLI0VjREX/xP/f4DjGlCOdVgq+fBIkKmq5xcH++TB8bT4jCmYPX9KixhuRK6K7Tn
	mgMwkpxqaWpzSva8QJ9jvjmuXV4zkFF4Btk6EB9YJpAOlWO2Vcl6TxOsFIqIvu7eGFlS7sNulHT
	8Ilcj5fgkquFZanEAWxBNegf76A5pqKj93YtT4iJfMH74hioaBH+vX0wrXEVjWBcLfDOgz3ox3f
	nhO9OVPyVGzm3evuq94CwsNFiAskFVmMPnhJ5IMXtWuhJgZ8ZscAHKBdXnZ8sH54cjpFwimr9ht
	92
X-Google-Smtp-Source: AGHT+IFul1D/CBEWFSrI65lK/gcZOz5x1VH/Q1/B8nCK5WcOxTqcEEVI9TiRoulWZC+V1w16beBUfA==
X-Received: by 2002:a05:6a21:9990:b0:1f5:79c4:5da6 with SMTP id adf61e73a8af0-225be2f66e6mr1935066637.5.1751603583344;
        Thu, 03 Jul 2025 21:33:03 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee74cf48sm976223a12.77.2025.07.03.21.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:33:02 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 0/3] bnxt_re driver update
Date: Fri,  4 Jul 2025 10:08:54 +0530
Message-ID: <20250704043857.19158-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support for 2G page size in the bnxt_re driver.
There are couple of cosmetic changes as well.

Kalesh AP (2):
  RDMA/bnxt_re: Fix size of uverbs_copy_to() in
    BNXT_RE_METHOD_GET_TOGGLE_MEM
  RDMA/bnxt_re: Use macro instead of hard coded value

Selvin Xavier (1):
  RDMA/bnxt_re: Support 2G message size

 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 28 ++++++++++++------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |  3 +++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |  1 +
 5 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.43.5


