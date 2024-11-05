Return-Path: <linux-rdma+bounces-5757-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEAC9BCA37
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 11:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70311F22928
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 10:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659AB1D1F46;
	Tue,  5 Nov 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f5Z8SXhQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43EF1D172E
	for <linux-rdma@vger.kernel.org>; Tue,  5 Nov 2024 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802015; cv=none; b=mPnNg6BsxtqwmSzGRXDtSclmbi4VO0jOVPSmhIFNrp9SIJMZLIMcaD27kpzRLaJc1Z1/AFlVd1tOanmaEL6dpD6n8ugQAtTIHqpLfcYTnwhDDlPsGkD/KFkT8ATSv/1/gWAx3NUfDToD2L4Ula88JrOVO+ZsWDUMMJzbbkZVWKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802015; c=relaxed/simple;
	bh=6nw6ijKpq+gJsxL4Ty2fRH6JptU2ieialFH3jNp6qvY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=J2joF3UOl8URTTJ7W4E6e0q0i93yHdaoYIssD5/w2KZYV66oFYgQd/JJhvUaFqJ+VPmw2Rbb6gVkWToQlkwDTNyOCufOMYYjOLqIIsubjUzAUReE/LlikUgsM3GlEF4A5SCT+goezqXwOHxpc845Qh3o5meA3piPMBIiYr+ErAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f5Z8SXhQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20bb39d97d1so49793615ad.2
        for <linux-rdma@vger.kernel.org>; Tue, 05 Nov 2024 02:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730802013; x=1731406813; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tl8xPC5nMv+lK8i7s5d0f3zT49bzbVgtjgtDBZtUy+8=;
        b=f5Z8SXhQUy0Me2GX8uGC9Uf7S5I9/o4WsyNuTXyyY/qhdvSV74KcINehuCWmEfN2RZ
         2D5oKGesy0PZScKuur/cwa8uOfKBymMCOl3pSOLbzyKG0bWns2Li/4R1yBeEtAsouiEY
         Lo7bjNKt9Sr6ayRpPB8aYK7xIpuimCrwnQqgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730802013; x=1731406813;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tl8xPC5nMv+lK8i7s5d0f3zT49bzbVgtjgtDBZtUy+8=;
        b=mg2E4ZHMePiwcKRqhMp/qBjqDHIDCmSju7obt2GaVBs5c16q9vFTos2HJXk7tg+XRH
         G9g7+8YsbLk8TKmsqLtzb6I84qRWusPnL3iHXsQbD+Wx6LMzcjtnPKgriG9x+lcHLZt9
         KY3gqjv0m9nChwvXDLhRNawwxN4AmrI29TsYCd7PocDe3cHOl4O6IXrlRCHOseza7gAA
         fJDdHno+4/c8GJ+XruhDfrjPdvxH57WisA1O4kxgJEVEUvomvniD7+b0OC4iZknc0Yvj
         oLazyJt254O6MYCvpzeHU33yvoNZc+UaZArYGoC99PU+vSa4MjAvjaexUVKhqOBJxIZm
         Xgdg==
X-Gm-Message-State: AOJu0YzE+IGq23LI58vzBxOisMEYjcn1N3Ue44ing/9Opx+/xIAp9gTC
	K0y4W/zFg0Ywn/0Mms9WYDnRuoWxmzI0/lIhSXFBJk0FqxicwEkSyYfada90Gw==
X-Google-Smtp-Source: AGHT+IEfOuBtKJRnI3DvnmykiMzaWZQzR6zk1HTgE5uBwDAMOa4C81xwnTJXzqmndU8xgm1alzn9TA==
X-Received: by 2002:a17:902:fb4b:b0:20c:5533:36da with SMTP id d9443c01a7336-210f76d678bmr233553575ad.42.1730802012913;
        Tue, 05 Nov 2024 02:20:12 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105707132sm75306615ad.96.2024.11.05.02.20.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2024 02:20:12 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 0/3] bnxt: Enhance the resource distribution for RoCE VFs
Date: Tue,  5 Nov 2024 01:59:09 -0800
Message-Id: <1730800752-29925-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Implements the mechanism to distribute the RoCE VF resource
based on the active VFs. If the firmware support the feature,
NIC driver will distribute the resources for Active VFs. For
older Firmware, the driver will continue to distribute the
resources across the total number of VFs.

Please review and apply.

Thanks,
Selvin

Bhargava Chenna Marreddy (1):
  RDMA/bnxt_re: Enhance RoCE SRIOV resource configuration design

Kalesh AP (1):
  RDMA/bnxt_re: Add set_func_resources support for P5/P7 adapters

Vikas Gupta (1):
  bnxt_en: Add support for RoCE sriov configuration

 drivers/infiniband/hw/bnxt_re/main.c            | 24 ++++++-----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c      | 13 ++----
 drivers/infiniband/hw/bnxt_re/qplib_res.h       |  3 ++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h        |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       |  6 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h       |  6 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 53 +++++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c   |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h   |  1 +
 9 files changed, 89 insertions(+), 20 deletions(-)

-- 
2.5.5


