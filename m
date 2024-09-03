Return-Path: <linux-rdma+bounces-4720-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80CD969C74
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 13:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC801F234C2
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017361A42C2;
	Tue,  3 Sep 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FtNdC5Hb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F31A42D8
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364302; cv=none; b=kIzsjFgQtf0/rnD5bNXI7P6FPb3o3bq+DHJJoW0SJWL9tCuPsY3P6ZFPJjZm8uctG5YZn4A7lR+smJzYtOzoKHfarcgpl9Uuh1ffiEi+Qdlp70JBe6cNCV53xJt2Mhh9q41AMumWCUACrpn7SzwlRzMc3JYwsyiXNkxrRT12Rlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364302; c=relaxed/simple;
	bh=6N4wY9gLSBGu3jPHgSEaiZCn3L049iGArH30pk9TK08=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LuJa2LEvsIblznNcJ6+6hVf4OU0w99q2Fbw1TjG+isMrB3OX6nO3L0VPvPOYyda6OKUkLz6K7ksTG9DGTV0YiRC6QTjHCKl0xS/AyBnTYPpkWMEQZoJUreKGtDFQFE7+GLsa1Xv+ps3dffuSsRFjN6of499iejTqIhS6BVSJekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FtNdC5Hb; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cb3db0932cso3928869a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Sep 2024 04:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725364300; x=1725969100; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8Usk/8lxIv1Z+yRv3zpIhj4hAyiciX7hv/Fefhce8U=;
        b=FtNdC5HbSesUdBHwyehjyPqD26mcYA9XgaZZlpGyVB6S8I0uSLt/qvAzdRAZX+nWeW
         5XB/zuwnXNufOn7kKvXDGExPZ1uo8EuDIyFY7FaUZ7rCCRxwbTH6rz7uWRfovzwdQcYI
         WOELZNqJ+4H5EeT71E7KkIdU+WecOh3CHSPDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725364300; x=1725969100;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8Usk/8lxIv1Z+yRv3zpIhj4hAyiciX7hv/Fefhce8U=;
        b=CuU1GoaG5pj2jfzm+KG43JC6rxiosXi3RDKz2jjHsJU3hRQ3im1epZodWn331ZprIF
         gjD7mouXlHelA791JTAKwuow5jI5vBUz+CWRtPSEFRmyw/vayTHrrweRC3BtsvhETRVM
         HY2LH4lGA/JWCOWUYFkUSKP1aVyCBhaGKIpOrUuf7ThDIHooCjpi6VEwR7JNjJB3ovUb
         oDU4878feftTiIdR+LneXU3zBUdbzSLXBVx7PB62OhS5YkNsR2MEYP+e5mjGHZxgySOi
         +jVhsD7I1Rd7YD8EQYASTEfSsfYIQRJwgDyZpSp8YHGr+CORI4kSApKZWr20r3eXgd9X
         DgAQ==
X-Gm-Message-State: AOJu0YzrwTjBRKWUO97yCNyB+H6mxcqaTE4nF/yJv63JQaV68YrUXXUe
	IrTs9QJ/yC9eFYOH4iJcercleBTRnj8yvQ2nm8VMK9gxBDGWp2Gtpi4bdpRj/g==
X-Google-Smtp-Source: AGHT+IGWxNP99PZpahGe6mxy61ToZDRZNes+prLMsP4aN5MPBvZDxL9L2ryRG80NbGCpCzm6oQ87/g==
X-Received: by 2002:a17:902:dac6:b0:202:3cd0:5ef2 with SMTP id d9443c01a7336-2050c4c385amr230775865ad.63.1725364300441;
        Tue, 03 Sep 2024 04:51:40 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20532b81016sm62077335ad.226.2024.09.03.04.51.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2024 04:51:39 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 0/4] RDMA/bnxt_re: Driver update for updating congestion configs
Date: Tue,  3 Sep 2024 04:30:47 -0700
Message-Id: <1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Adds support for receiving the Async event from FW by registering
a hook with L2 driver. Register for DCB change event. Updates
the QP1 context with the modified DSCP values.

Also, update the missing configuration while enabling Congestion control
settings.

Please review and apply.

Thanks,
Selvin Xavier

Kalesh AP (3):
  RDMA/bnxt_re: Add FW async event support in driver
  RDMA/bnxt_re: Query firmware defaults of CC params during probe
  RDMA/bnxt_re: Add support to handle DCB_CONFIG_CHANGE event

Selvin Xavier (1):
  RDMA/bnxt_re: Enable ECN marking by default

 drivers/infiniband/hw/bnxt_re/bnxt_re.h       |   3 +
 drivers/infiniband/hw/bnxt_re/main.c          | 158 ++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h      |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c      | 113 ++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h      |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  31 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |   1 +
 8 files changed, 312 insertions(+)

-- 
2.5.5


