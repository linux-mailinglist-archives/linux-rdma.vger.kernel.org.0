Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AB340C557
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 14:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbhIOMe0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 08:34:26 -0400
Received: from lpdvsmtp09.broadcom.com ([192.19.166.228]:46892 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237369AbhIOMeZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 08:34:25 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A538C22586;
        Wed, 15 Sep 2021 05:33:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A538C22586
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631709186;
        bh=sck2EGLB77p98xCQ1sHtfWD3pzdrxB+eVp3cEIqqmfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nb3SAiUw1Ia2ianPgDAtd4R5awkguN6ezf3lQK+fAugd1nBcVKNcpO3woA6FHN+Xx
         KGXIZ/owGM8PBoVUNddkQjW+zWhCrwsOf3aayYtc33r7kcKnWKW+NIR/0r68l8q3mA
         4/lBVc49oEzEeaJPR9Iau3P7+9OeL+4340RRI/1M=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-next v2 12/12] MAINTAINERS: Update Broadcom RDMA maintainers
Date:   Wed, 15 Sep 2021 05:32:43 -0700
Message-Id: <1631709163-2287-13-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
References: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
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

