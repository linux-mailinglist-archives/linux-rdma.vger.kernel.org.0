Return-Path: <linux-rdma+bounces-14230-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DC9C2F9DA
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 08:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D345D3BBFCA
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 07:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB53930748E;
	Tue,  4 Nov 2025 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZdEP4cv7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39B1F5435
	for <linux-rdma@vger.kernel.org>; Tue,  4 Nov 2025 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241425; cv=none; b=X5rzPKebr3mdNGDluk9xToRH4VVDoelFBLU3fGVhsdf6EVrJflAk5Fnz4+QzY0uMAPz1TJ42/Y7V8TwjyQt6PyALg+68yyybMNj85ZmagbN2LRZSlTloOwm+MnuX6/GdVDM+V0kMIsv/DbgRki9YCfFVapa6XUOKr1z5pPsIqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241425; c=relaxed/simple;
	bh=ps+Ka8DCa9Se9rRnfUDxa8hzxtz1cNStgm6TI3sAyZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGw241N8s4I+A/p9xxJT1/pV0hjKhZKlbjrF0vVFkoPijoW0vXmPDk/2kEo7iwSbre6RTZlZA3+YE7RfnubkjNuydwmi5yMABtnAtPVwkGRGkbHms4LLnElIaebsOBdXKjVZEelY9AdjONdaRyCnYYRD9ZtrJQVbdASZ9XLZFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZdEP4cv7; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so4920363b3a.2
        for <linux-rdma@vger.kernel.org>; Mon, 03 Nov 2025 23:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762241422; x=1762846222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jwF3GSYcIZlaR5KQWvyLiv8mM5L/eAloUNzX1oXtrY=;
        b=X5ABbfBMxHwz4GgL/3TeaNYiz58c0AV+NHLr1sz9ribFbS+ANU9CtWEFnb0dRpPEkq
         aX7QCL936tMo2qWH9P/GebkfqEY7xtMgk8p7qzJoTn4i7HlanGi4WNhggT297/RlGZXk
         TDzZd7A4hzylMKJYhkbtzG/GMVCPjkSfycOlFDa4/f1q4fuy0AaUqFN2luaMIneIWnl5
         XQziJMe/prUMSjj4BUUrIWuLuTOyc2AIXv0nPo/kUTUuF6oILw2xe9158EsKFJsaXdm3
         qQbKLRfmu+G39nsfZC+WFvMQX/EFiaeYhhrzBsmuvJCZ33DwedDHvBTILGzaNAjqJUG3
         gVAA==
X-Gm-Message-State: AOJu0YynxBYH2kR9GfEllSpihYqd+cJ41MtFeYUv6d5FevPhW+Z/dxah
	poehyx9y1E3G9/oiQslkJWE5Qf192G+t/Zu5W+VKpvzb3A2N6JbQGKJjttj3jfUX7jKt81vjYnM
	3e4Y7fSxdBkpRrLF9EO6Ci0lSVA0j9CPpgZ1u+bemTasyLavGxLHAJYo9N0Gcz2VzmWqgoIaBZQ
	XiLKrjDBbGdrtguBmKL5+NCFd8gAhTwDAZHJK+vGDrikWSWQ/0X0h0BlkpgHoWcrwiQ/U4WVpFI
	xBTw03Pljvl0cqwyjey0ikK4aJY
X-Gm-Gg: ASbGnctO3nptUTdolyWuACR3kO5Xfihy+fMkU4pUO0+E7epHZKda7M8LeIqN3AwRbQy
	55+nWc8B+AIZeOnutAwf2+sskprR7bQZafb6XgtbEHw7dulThj1ZHzgT+kNxfdkKEAvCK6YLw+X
	tJEW6r6i6lFMXBd/hh/t/8HMO4/TXT5WykLMNAOLCuYsmSEszp5nCPTUPn7yOSLwz4nrhvXaegL
	VfrucGRKebjPSPF+pEXzcqXARYWI75aBibyt/Yc9mR4uaaGclV8/clEDTGwevKVXlzZ1i0lUppn
	SdhwDoLlD+UxB7W2Kv0igsDbVIwRAgmV9e/IXYuHmRL5QVTzjU60Ao84tqZdAL/LWQbbLmMaBIo
	y9VNAzUc4isGErw31M4TlQ32Z3LQVqo3Hc6eYMVHXQH49GgWKxCjveRKISi0/sPfeZTKyIUAX5+
	x3we/jiMYvFFsyZBGX2RS3Kqq6vDQ+Wdn9cqTZ6DX8EsUtdA==
X-Google-Smtp-Source: AGHT+IF3W2gi2DrK2TNzcI3qaWGgMsuH6TERnTPaNpUDCP7aQB45xgh/tPdnhMX5UsO/l3hSPJFK9Gx4vKy4
X-Received: by 2002:a05:6a21:83:b0:34e:8864:7930 with SMTP id adf61e73a8af0-34e88648125mr1340822637.12.1762241422072;
        Mon, 03 Nov 2025 23:30:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-ba1eefd629csm97267a12.6.2025.11.03.23.30.21
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 23:30:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27c62320f16so65192015ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 03 Nov 2025 23:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762241420; x=1762846220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5jwF3GSYcIZlaR5KQWvyLiv8mM5L/eAloUNzX1oXtrY=;
        b=ZdEP4cv7b0+ob/7m3VhuBh1fq4gC99PhkENONVErTeq0k7+FUX7rSZ39C1vALTMmoi
         pgUvDiKHP6Eil0N0DGsbm2e2AfQq6vLKzB6dpWaoqYpMnYnFb26auWEH2rptbcvLS/VY
         jsjPNcjfBri89z0qJL3WIemLdklGtB6g06a+U=
X-Received: by 2002:a17:902:d2d0:b0:295:49ab:35bf with SMTP id d9443c01a7336-29549ab547emr154290465ad.23.1762241420107;
        Mon, 03 Nov 2025 23:30:20 -0800 (PST)
X-Received: by 2002:a17:902:d2d0:b0:295:49ab:35bf with SMTP id d9443c01a7336-29549ab547emr154290075ad.23.1762241419529;
        Mon, 03 Nov 2025 23:30:19 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a7435dsm15317235ad.101.2025.11.03.23.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:30:19 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v2 0/4] RDMA/bnxt_re: Support direct verbs
Date: Tue,  4 Nov 2025 12:53:16 +0530
Message-ID: <20251104072320.210596-1-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This patchset supports Direct Verbs in the bnxt_re driver.

This is required by vendor specific applications that need to manage
the HW resources directly and to implement the datapath in the
application.

To support this, the library and the driver are being enhanced to
provide Direct Verbs using which the application can allocate and
manage the HW resources (Queues, Doorbell etc) . The Direct Verbs
enable the application to implement the control path.

Patch#1 Move uapi methods to a separate file
Patch#2 Refactor existing bnxt_qplib_create_qp() function
Patch#3 Support dbr and umem direct verbs
Patch#4 Support cq and qp direct verbs

Thanks,
-Harsha

******

Changes:

v2:
- Fixed build warnings reported by test robot in patches 3 and 4.

v1: https://lore.kernel.org/linux-rdma/20251103105033.205586-1-sriharsha.basavapatna@broadcom.com/

******

Kalesh AP (3):
  RDMA/bnxt_re: Move the UAPI methods to a dedicated file
  RDMA/bnxt_re: Refactor bnxt_qplib_create_qp() function
  RDMA/bnxt_re: Direct Verbs: Support DBR and UMEM verbs

Sriharsha Basavapatna (1):
  RDMA/bnxt_re: Direct Verbs: Support CQ and QP verbs

 drivers/infiniband/hw/bnxt_re/Makefile    |    2 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |   12 +-
 drivers/infiniband/hw/bnxt_re/dv.c        | 1816 +++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  549 +++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   23 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  |  311 ++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |   10 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c |   43 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   10 +
 include/uapi/rdma/bnxt_re-abi.h           |  142 ++
 10 files changed, 2376 insertions(+), 542 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/dv.c

-- 
2.51.2.636.ga99f379adf


