Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1684BB24
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 16:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfFSOSu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 10:18:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfFSOSu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jun 2019 10:18:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9554681DE1;
        Wed, 19 Jun 2019 14:18:45 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C43E35D71B;
        Wed, 19 Jun 2019 14:18:44 +0000 (UTC)
From:   Doug Ledford <dledford@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, jgg@ziepe.ca, leon@kernel.org
Subject: [PATCH 0/2] RDMA/netlink: cleanups
Date:   Wed, 19 Jun 2019 10:18:26 -0400
Message-Id: <cover.1560953757.git.dledford@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 19 Jun 2019 14:18:50 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to make it easier to add new netlink attributes into the policy
array in the future while avoiding duplication, sort the array on the
attribute name.  While at it, audit the policy settings for strings and
make a few cleanups.

Doug Ledford (2):
  RDMA/netlink: Resort policy array
  RDMA/netlink: Audit policy settings for netlink attributes

 drivers/infiniband/core/nldev.c  | 157 ++++++++++++++++---------------
 include/uapi/rdma/rdma_netlink.h |   1 +
 2 files changed, 80 insertions(+), 78 deletions(-)

-- 
2.21.0

