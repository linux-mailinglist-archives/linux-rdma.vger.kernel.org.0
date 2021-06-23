Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A39E3B15C3
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 10:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhFWIYE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 04:24:04 -0400
Received: from lpdvsmtp11.broadcom.com ([192.19.166.231]:51864 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230030AbhFWIYD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Jun 2021 04:24:03 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jun 2021 04:24:03 EDT
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1EBC124AB2;
        Wed, 23 Jun 2021 01:15:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1EBC124AB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1624436108;
        bh=Nxvg3CePTD4fU7UbeNC1eaymrfaplF9rdrUYZHyUjG4=;
        h=From:To:Cc:Subject:Date:From;
        b=EjbbQ2EPtguhB4BoWEMJ5BWRRS9W+uQdmGLqYtwlohkn9ZDtLjEaC1UJdS3pOOhld
         kq+jy/xD69YENFPyTEaxQ8q5CBxxQwULTWY8iS8+H1hUotBQft19TDbYOP9vuQUKge
         TVJIpWXAmUw6eVXuAP3SiSZMzadicKthNOHLDulc=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next] MAINTAINERS: Update Broadcom RDMA maintainers
Date:   Wed, 23 Jun 2021 01:14:49 -0700
Message-Id: <1624436089-28263-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Updating the maintainers file as Devesh decidied to
leave Broadcom.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 636b238..985e621 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3735,7 +3735,6 @@ F:	drivers/gpio/gpio-bcm-kona.c
 
 BROADCOM NETXTREME-E ROCE DRIVER
 M:	Selvin Xavier <selvin.xavier@broadcom.com>
-M:	Devesh Sharma <devesh.sharma@broadcom.com>
 M:	Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
@@ -6719,7 +6718,6 @@ F:	drivers/net/ethernet/emulex/benet/
 
 EMULEX ONECONNECT ROCE DRIVER
 M:	Selvin Xavier <selvin.xavier@broadcom.com>
-M:	Devesh Sharma <devesh.sharma@broadcom.com>
 L:	linux-rdma@vger.kernel.org
 S:	Odd Fixes
 W:	http://www.broadcom.com
-- 
2.5.5

