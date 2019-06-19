Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E56F4BC9C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFSPQT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 11:16:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfFSPQT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jun 2019 11:16:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F7523082263;
        Wed, 19 Jun 2019 15:16:19 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EA765C221;
        Wed, 19 Jun 2019 15:16:18 +0000 (UTC)
From:   Doug Ledford <dledford@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, jgg@ziepe.ca, leon@kernel.org
Subject: [PATCH v1 0/2] RDMA/netlink: cleanups
Date:   Wed, 19 Jun 2019 11:16:10 -0400
Message-Id: <cover.1560957168.git.dledford@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 19 Jun 2019 15:16:19 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to make it easier to add new netlink attributes into the policy
array in the future while avoiding duplication, sort the array on the
attribute name.  While at it, audit the policy settings for strings and
make a few cleanups.

v0->v1: The first patch didn't contain the whitespace fixes, which made
the second patch much noisier than it should be.  Move all of the
whitespace and sorting changes to patch 1 with no functional changes,
and make patch 2 only have functional changes.

Doug Ledford (2):
  RDMA/netlink: Resort policy array
  RDMA/netlink: Audit policy settings for netlink attributes

 drivers/infiniband/core/nldev.c  | 159 ++++++++++++++++---------------
 include/uapi/rdma/rdma_netlink.h |   1 +
 2 files changed, 81 insertions(+), 79 deletions(-)

-- 
2.21.0

