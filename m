Return-Path: <linux-rdma+bounces-6936-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CDBA07FF8
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 19:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755E3165D17
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 18:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC191ACEB8;
	Thu,  9 Jan 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T7OHN4+6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB7F199FB0
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jan 2025 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447941; cv=none; b=TpFHKCMWKonrWyX9PiKSkk3Hlrz7kOgmWHarrNzEwIMSbD4tODhPX7EDqp+uNyaImcmk8x8GRui4DPmPJWt1aDiBbxL1691Lidzd3rg7Gt/RleRNrkrzNEzSwR+ki+M8qOw8/JutcM2Csy8KRExO3/1i+3IVuLIWxqrDUPX9rv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447941; c=relaxed/simple;
	bh=6ZnHWYkioJPJ5WrswKZGwKoXCzyNMDNGECPfY/IJido=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LBgq46oAg2MUk4j/CT6yYsXHtSmRdpSHq1IhbcrLFUn5fyl2nh+T0Vru7gfT0cprhDkXLrbyk+JHIbQ1ImKddaanZrMlNyOu3WhAhwqdQP6NbWZIxEz3nPIzb1fO5eO/hip+Ii/kQeuXgnegPCadgdI6wVPIghxW3wb400crJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T7OHN4+6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216634dd574so14066155ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jan 2025 10:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736447939; x=1737052739; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=le+N/sYVBOBUQkBrw3s3SHaWb3fKKdUjD6nlj8+vqSM=;
        b=T7OHN4+6i0X6u6GN1VH/N/7MgXmaW0nsMfcetavB60Yi98fIRMhJjuJQjthPlGIIKU
         2cO+IQxrOkoNaZI1/tqldYjYlSp+tzwk4OEOmVHG+g7j1CCPqT29TSUqgLAAb7dLLW83
         iskn1PY2msLt6dGyktZ+zVRZEMC7GvqoXWJWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736447939; x=1737052739;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=le+N/sYVBOBUQkBrw3s3SHaWb3fKKdUjD6nlj8+vqSM=;
        b=j1oMMnSemNKLrnuf+ShOhwj1vG80QDEYFvkBXEGRtoOjX9Wh3w7WrdlVDxUd2AwJ1l
         o3FwaLufHJqO98dDpjaEgld7M4+ZG8NraStnG0YEKJ5cJo5oSkmVYqc3B6ftcgSII33O
         E8mclsASuhXWUl4LkJfR2uxgvGmJgMCoN6qRMx0qw0tEjFLnyW04VNVD++gZGMZHxV5j
         pIC1fdVw+RzjjTqY3BqPvNmLzvZd8y69/qsiu3MFe9IC4bZzG+tKfF819mGkecLE/u8H
         6tfJEp4gV+oC3rF+GaUBoMAGWb/m2vSVwi1MnXsg+acJ3l1epvI8Qqaaoxzju4JqGLpI
         L99w==
X-Gm-Message-State: AOJu0Yx+s3mf9RMRDXfBw7UqKR8lg6GSOdXU3xKQYO3PbbDiq0nYUsY+
	623HBm8Jxn3jnMalW9v+H5d84gn2nRW/0fNYuwy5gkImcxrl07XRL5WfuU36zQ==
X-Gm-Gg: ASbGnct0SNtI3+PAqsx1NckbVgKY5kg9ekUpd8sNC4cm0uYn0jUAISYg6Wj5fQyvq9j
	urA7pXDiVEsN0x65oNY5zHgMnn0LDfQwL66PlSCNfL+DLJ/kMOqvpoS8/UQGK4Ch+f6MYKaoBgC
	RFdNoctqTjZv2NBHrCbTD0pK6HfkG0DrUs+6Bs7OL2wSgHfJhGNRWhMaGqMfqio3fmkWFOywjzE
	lLvgDQQhykIl81rplPuBtxlEwomLjI0q8LYFwzN11h+bbpRY23lDghX/bZDsn5X8sFFWltQptqG
	nMl4g3VedKMtEsGA1PuIf1jg5yPUc2d7s3Hr
X-Google-Smtp-Source: AGHT+IE1T+uYEDLxQAm7fdAObOUg8O82VsZcLbpDyoN3xnC6iZNXl23BEUGD4EOX+cu7tLoJ+88rXA==
X-Received: by 2002:a17:903:178f:b0:216:84e9:d334 with SMTP id d9443c01a7336-21a83f767e2mr108736225ad.33.1736447939320;
        Thu, 09 Jan 2025 10:38:59 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22dd30sm1017475ad.171.2025.01.09.10.38.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2025 10:38:58 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 0/2] RDMA/bnxt_re: Driver update
Date: Thu,  9 Jan 2025 10:18:11 -0800
Message-Id: <1736446693-6692-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Generic updates to bnxt_re driver. Pass the info that indicates
the context of the caller in ulp_irq_stop. Also, code reorganization
to optimize the device data structure.

This series is created on top of the changes from Kalesh
https://patchwork.kernel.org/project/linux-rdma/list/?series=922731

Please review and apply.

Thanks,
Selvin Xavier

Kalesh AP (2):
  RDMA/bnxt_re: Pass the context for ulp_irq_stop
  RDMA/bnxt_re: Allocate dev_attr information dynamically

 drivers/infiniband/hw/bnxt_re/bnxt_re.h       |  2 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.c   |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 38 ++++++++++-----------
 drivers/infiniband/hw/bnxt_re/main.c          | 48 +++++++++++++++++++--------
 drivers/infiniband/hw/bnxt_re/qplib_res.c     |  7 ++--
 drivers/infiniband/hw/bnxt_re/qplib_res.h     |  4 +--
 drivers/infiniband/hw/bnxt_re/qplib_sp.c      |  4 +--
 drivers/infiniband/hw/bnxt_re/qplib_sp.h      |  3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  5 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  2 +-
 10 files changed, 67 insertions(+), 48 deletions(-)

-- 
2.5.5


