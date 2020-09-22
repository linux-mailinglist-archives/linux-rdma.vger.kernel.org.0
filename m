Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FB3274032
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 12:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgIVK4u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 06:56:50 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:54861 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgIVK4q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Sep 2020 06:56:46 -0400
X-Greylist: delayed 709 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 06:56:46 EDT
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 08MAiUP7027984;
        Tue, 22 Sep 2020 03:44:31 -0700
Date:   Tue, 22 Sep 2020 16:14:25 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: reduce iSERT Max IO size
Message-ID: <20200922104424.GA18887@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Please reduce the Max IO size to 1MiB(256 pages), at iSER Target.
The PBL memory consumption has increased significantly after increasing
the Max IO size to 16MiB(with commit:317000b926b07c).
Due to the large MR pool, the max no.of iSER connections(On one variant
of Chelsio cards) came down to 9, before it was 250.
NVMe-RDMA target also uses 1MiB max IO size.

Thanks,
Krishnam Raju.
