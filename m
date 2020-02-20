Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA66165849
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 08:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgBTHMt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 02:12:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgBTHMt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Feb 2020 02:12:49 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D365424656;
        Thu, 20 Feb 2020 07:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582182768;
        bh=dViDeOl1RXJspvgA/3Crf+b7WLlKCWKmiS6Li2z5boQ=;
        h=From:To:Cc:Subject:Date:From;
        b=i4jK2+Pte7aivQIkivBxjmAD5HW6nbMi1RodNar1GE+kx6Wq2ly56kDGGVhaylClY
         aWcobH5H2IFNJ6V4pLVhd+8RLEVNkGBJUFATBXNw7L2/m9ShCMlZnbzJle1S2KOT/m
         cxk5eOHRqfuga+rKAFr2kN4ZAUHZyPHtUhNLOar4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: [PATCH rdma-next 0/2] Drop driver version in favor of default ethtool
Date:   Thu, 20 Feb 2020 09:12:37 +0200
Message-Id: <20200220071239.231800-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Following the change in ethtool to provide default driver version which
is aligned with kernel in use, drop the static assignments of driver
versions in IPoIB and OPA_VNIC.

Thanks

Leon Romanovsky (2):
  RDMA/ipoib: Don't set constant driver version
  RDMA/opa_vnic: Delete driver version

 drivers/infiniband/ulp/ipoib/ipoib.h                | 2 --
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c        | 3 ---
 drivers/infiniband/ulp/ipoib/ipoib_main.c           | 4 ----
 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c  | 2 --
 drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h | 1 -
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c     | 5 -----
 6 files changed, 17 deletions(-)

--
2.24.1

