Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FD5407F36
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Sep 2021 20:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbhILSRF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Sep 2021 14:17:05 -0400
Received: from saphodev.broadcom.com ([192.19.11.229]:34518 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234478AbhILSRE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Sep 2021 14:17:04 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id BAA837DBA;
        Sun, 12 Sep 2021 11:15:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com BAA837DBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631470550;
        bh=sck2EGLB77p98xCQ1sHtfWD3pzdrxB+eVp3cEIqqmfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/RpQl7ayEj1rdn2+ToT0VN01kWPbW5c9SQgSq+K1aPdgsNFokWkWGZ9woDGX7RRt
         yduGOp2XoEM5G8vF7GHXg1Tde8Zlb+zo6aAgD0csM5qbl/CYFei+d+rhCA5kgF1pfq
         jK272G/6EOJt2GuWyhV15YltbjHVruOf50/F7+zk=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 12/12] MAINTAINERS: Update Broadcom RDMA maintainers
Date:   Sun, 12 Sep 2021 11:15:26 -0700
Message-Id: <1631470526-22228-13-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Updating the bnxt_re maintainers as Naresh
decided to leave Broadcom.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b25f14a..d7d7c71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3795,7 +3795,6 @@ F:	drivers/scsi/mpi3mr/
 
 BROADCOM NETXTREME-E ROCE DRIVER
 M:	Selvin Xavier <selvin.xavier@broadcom.com>
-M:	Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 W:	http://www.broadcom.com
-- 
2.5.5

