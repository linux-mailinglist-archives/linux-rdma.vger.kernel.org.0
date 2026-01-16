Return-Path: <linux-rdma+bounces-15615-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A15D2E916
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 10:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD50B3011ED8
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2871831A808;
	Fri, 16 Jan 2026 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NxOhKEOA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4704C81
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554838; cv=none; b=PmU+TgmyscOyt+Jtv1uwjv7W9upchn91NIcgAR7cpZq/Dc4GAtPC2yAHlfak3P6LDaZef6rSAH+c69uf64LBvvFpD+fc7y8qqBRfrpBJAB7Ci7euM1Eic9P95hSiOKMy4UXQc4mWKb5DM/x1qJdTzE5KSLJpyKFt8DuVORNIPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554838; c=relaxed/simple;
	bh=dUMXNfVUMTNli1BTsdtlga50MrwuwJltEy7TuU8hd8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CiifGLbh8L5cvwMx8pX3jPNUpENKI10ZS81/5TVismt6yQwS1bLcsddK0aZPBjwVLZnqd4FUfU6etIlpvfADKws3G5XnjrZlZQp4QenCpol1Fv39GkdFHqlcV4b29HNztc57k/ScRNd35bSz6J4qtDIhil8EWtuY25OIfw+xZ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NxOhKEOA; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-5014b7de222so16923981cf.0
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 01:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768554836; x=1769159636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qg4QALalKPRVNoriyozh7G9YShTG/CGjZp6U9HnOKNQ=;
        b=ZFNzdauOF2H/vFN2IM3Hksq4/KV+p5q7jRd0W82OE7UM0NlXwkM7IjGYxbDr9r3mUp
         BOSEQeBLSh0JasoaQ1mXTQqbU6WnsLBgJD+fbq/Ocprn1Pm6uo8XufF+rWzjscKPbO90
         wj+ZsCWdLpu7acIe+l7qgVkd0G5d4MU5U/dd743q/wFy5swMPhxI0hn0LGhPdSnTiy1p
         kMeJ/RQ/oLKjs3MyNsh7yhGh+zKduL5ZPnRfalGAD5yiMEkygPN+cKjp+vrwpEdo8DMH
         NIY2CHUse/NkJkGNZT27yMeT9/EG707YzIOP+4QSEXHFoYTba5p/PU9P2ei0bviI76H1
         PXfg==
X-Gm-Message-State: AOJu0YxRZG7puBHWvl7cScejFuofI72cMXxglqzLjG1VqYV7NH2/1jRz
	ee6Ln56s/8YKkqhQyPIcplnWsY9ESt/DivkjtoOhUe+BGvvNwnlqy9x6TwMIDD/bO3yMwPBykRj
	gNJ2hrptSh8LGZHsq1m0PGNhTd56x4lA4+vkSU9YKFflqixDqOwM4FXU2j4/2Lo1kg3ApPPN+iF
	HIttTylbpWfAeldYmRM++IuSe+UDUoqlFxmUotO1a9wV/jdZn7HfaQA/oMBD53ptHEY++OQsexl
	nMqrPhKJtRH8ktBnH39447orGpg/w==
X-Gm-Gg: AY/fxX4kXxxct8j8hNGFf+g0jR5u5UoE8XqPOf9s4wAXSfo6SXcgXE06jz53Fw7IbXu
	EiSO2CEP7qFL/VsAbuY1MWG3RdMQc5N0TUcSYGKm6jieg4rLPd4xPZwRtqpCnh770hmHbZ0nG27
	mfrNpcWhdhI/mrPWkDVkmAOBhmdr3gmn8osBPHdGd61c7qiOYAypNON3tlK497lRt0EBm0C6gRq
	VQgZPlvff5zFlWs0d20RisbI9H9+vPidbhHVpYqipCGvHNVYpPVufMW73hFaiaBxVEwqGrfjbhs
	f2nrplAO1NqY/yIH8DZfT2foMRT7SkEBBhUCBJ8XrO6NPOtU+DA2I8soeEiPJiy0FT3vpECkTjY
	5I8OsAa2A++IYTPeGROAwiPa3U2691XT/Ue2KPpdwBjEO/usSLhxTeD30hBCy6z3nUGH7VHry3L
	Mls9XxlWO/GCpTVMH+nEhEeeqdbGUMbDf2ddUub2Nu5xTg4P9+9rE1Cq833icV
X-Received: by 2002:a05:622a:1350:b0:4f3:57ec:b252 with SMTP id d75a77b69052e-502a1756f4cmr34706571cf.48.1768554836505;
        Fri, 16 Jan 2026 01:13:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-502a1ed083esm1054811cf.7.2026.01.16.01.13.56
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 01:13:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a351686c17so18075935ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 01:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768554835; x=1769159635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg4QALalKPRVNoriyozh7G9YShTG/CGjZp6U9HnOKNQ=;
        b=NxOhKEOADahygyKHF63nlT9bqttilkR32X7ycrDstYg+4NOWeKLZ3R7Ag7BQjZLGy1
         YzaAdTGdEuZ68t3UcsJeE2x8e6pIxYHTgMftJqriBZX0Tr5SEKXlxeaXER39hgHDBmn4
         ZUhc2UDtOwK5WTgCFolZXEwBfwsHxgEwvpe5A=
X-Received: by 2002:a17:903:2ed0:b0:2a2:ecb6:545b with SMTP id d9443c01a7336-2a71751c84cmr26075875ad.2.1768554834984;
        Fri, 16 Jan 2026 01:13:54 -0800 (PST)
X-Received: by 2002:a17:903:2ed0:b0:2a2:ecb6:545b with SMTP id d9443c01a7336-2a71751c84cmr26075675ad.2.1768554834620;
        Fri, 16 Jan 2026 01:13:54 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a3dsm4161100a91.13.2026.01.16.01.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:13:54 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rext 0/4]  RDMA/bnxt_re: Add QP rate limit support
Date: Fri, 16 Jan 2026 14:48:04 +0530
Message-ID: <20260116091808.2028633-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This patchset supports QP rate limit in the bnxt_re driver.

Broadcom P7 devices supports setting the rate limit while changing
RC QP state from INIT to RTR, RTR to RTS and RTS to RTS. Or, once
the QP is transitioned to RTR or RTS state.

First patch adds stack support for rate limit for RC QPs.

Second patch adds support for QP rate limiting in the bnxt_re driver.

Third patch adds support to report packet pacing capabilities in the
query_device.

Forth patch adds support to report QP rate limit in debugfs QP info.

The pull request for rdma-core changes are at:

https://github.com/linux-rdma/rdma-core/pull/1692

Regards,
Kalesh

Kalesh AP (4):
  IB/core: Extend rate limit support for RC QPs
  RDMA/bnxt_re: Add support for QP rate limiting
  RDMA/bnxt_re: Report packet pacing capabilities when querying device
  RDMA/bnxt_re: Report QP rate limit in debugfs

 drivers/infiniband/core/verbs.c           |  9 ++++--
 drivers/infiniband/hw/bnxt_re/debugfs.c   | 14 ++++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 39 +++++++++++++++++++++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 ++++++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  3 ++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  5 +++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 ++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 13 +++++---
 include/uapi/rdma/bnxt_re-abi.h           | 16 ++++++++++
 10 files changed, 107 insertions(+), 12 deletions(-)

-- 
2.43.5


