Return-Path: <linux-rdma+bounces-5294-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF9994213
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 10:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517722909A1
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 08:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7461EABC3;
	Tue,  8 Oct 2024 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FKzZFbQG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE111EABAD
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374560; cv=none; b=JanH9w4/oF45S7QYsfmo83s93th6a9YxjG6HYI5a55SDgBXnZt+5CTQ8UiuW/AAEyt2Ff1soBM+niBRCrsRsr0j+LdMteDEl1aoEocpuu3ENJpl8qrKqkKStrjPZR5aTLw7FBSkVe/gbwRc7pBLm1yQKlyBbwPx94X4zS+u3dUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374560; c=relaxed/simple;
	bh=7JcZN0DKEMsBsYB2Oi0zxziEdZ6swL09ST/TnZZynxM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hgjf7V8eROwaq4CcOG9AKDd3WTA2JwEJQpQnptTyraSL2WooC2TdZ/nst5ee5VksYLbjHfZc5rmUZ5W3hqBAGb2azL15TUprwT4teH70WuV+CgIvWncLsJjk40ckUTsDXOC5eke6WgzWnGzEBOpMdTYlvR2EpoJfSo3yuPr9abk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FKzZFbQG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b9b35c7c3so55913835ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2024 01:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728374558; x=1728979358; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJPszLXhPambKhB+Sa56UUjg4/Cm3yX6WbL+AT3kqZo=;
        b=FKzZFbQGMud06JEXKy9DpXpxaYStvYaR2ZEaVC2SVKq8UcKOSiAScoM4Zy3ICo35jn
         kRCqIUWtLRAUtoASyBL9L8lEztq0SANQtd419WGTG3ycbx4g6j5J6wAFHyBUP9OTesCu
         RtcHDbyXVTxXOrlDSB0/VJC60Xe6mpHXhGTV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374558; x=1728979358;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJPszLXhPambKhB+Sa56UUjg4/Cm3yX6WbL+AT3kqZo=;
        b=KwaZeI2TamgUp96ljTQNE+nS6w5N4ySOpQNyi6xkH60Vr9ISds65nIkx3CZv/Lxy/H
         N3at6LPuH7xvLQ6I65gGvU1xvpMkVwpvtjeeVAvQ1M7r8dsGcO6AS2PKgS50LMYnf0Wb
         xHAB8ObtbgZmKWH1CW2cC03RvNingSm3DruEdgVDa55qXAJHmNtagxAmWPr4klRWEZQo
         QwFVs0hneHRUm0VZHtb0zf4w6MJEkclqM00MliAFecYEoAWtHfIHNGRVMl2gk6zl69ov
         ESUcINCntczk9JZi/m9XLUn9n8igPSffTl1Jf3VyFnLhSyvl8F88l/p1dSB0R0rgz5qo
         5n1g==
X-Gm-Message-State: AOJu0Yx6ROT9Bm02Pht3PePt7l7uGQISpsTFQOt4tYSEj2taYc2gMa1r
	c7h7NbxOUpYL/KpFQZGdRKT2sw5FLwIeT2tZGO5hysUMFXqtNIXntDgUZ0zFjA==
X-Google-Smtp-Source: AGHT+IFcOqZes7uSFh1GtV0hUrCOx7fCuRMnPkZZHs2FIA/pKzJuB+NL1syjFsbzd+PG4AquVq8E0g==
X-Received: by 2002:a17:903:1247:b0:20b:5fa6:1fb3 with SMTP id d9443c01a7336-20bfdf6cc80mr235860305ad.5.1728374558419;
        Tue, 08 Oct 2024 01:02:38 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1396d547sm50339915ad.223.2024.10.08.01.02.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:02:37 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 00/10] RDMA/bnxt_re: Bug fixes
Date: Tue,  8 Oct 2024 00:41:32 -0700
Message-Id: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Few bugfixes for bnxt_re driver. Please review and apply.

Thanks,
Selvin Xavier

Abhishek Mohapatra (1):
  RDMA/bnxt_re: Fix the max CQ WQEs for older adapters

Bhargava Chenna Marreddy (1):
  RDMA/bnxt_re: Fix a bug while setting up Level-2 PBL pages

Chandramohan Akula (1):
  RDMA/bnxt_re: Change the sequence of updating the CQ toggle value

Kalesh AP (5):
  RDMA/bnxt_re: Fix out of bound check
  RDMA/ bnxt_re: Return more meaningful error
  RDMA/bnxt_re: Fix a possible NULL pointer dereference
  RDMA/bnxt_re: Fix an error path in bnxt_re_add_device
  RDMA/bnxt_re: Fix the GID table length

Kashyap Desai (1):
  RDMA/bnxt_re: Fix incorrect dereference of srq in async event

Selvin Xavier (1):
  RDMA/bnxt_re: Avoid CPU lockups due fifo occupancy check loop

 drivers/infiniband/hw/bnxt_re/hw_counters.c |  2 +-
 drivers/infiniband/hw/bnxt_re/main.c        | 42 ++++++++++++++---------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.c    |  5 ++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c  |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c   | 19 +++----------
 drivers/infiniband/hw/bnxt_re/qplib_sp.c    | 11 +++++++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h    |  1 +
 7 files changed, 42 insertions(+), 40 deletions(-)

-- 
2.5.5


