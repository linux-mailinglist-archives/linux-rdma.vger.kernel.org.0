Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E0F67154
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 16:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfGLO2L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 10:28:11 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:38572 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfGLO2L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 10:28:11 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x6CERKI4029405;
        Fri, 12 Jul 2019 07:27:21 -0700
Date:   Fri, 12 Jul 2019 19:57:19 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     jgg@ziepe.ca, linux-rdma@vger.kernel.org
Cc:     BMT@zurich.ibm.com, monis@mellanox.com, nirranjan@chelsio.com,
        bharat@chelsio.com
Subject: User SIW fails matching device
Message-ID: <20190712142718.GA26697@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,
I observe the following behavior on one of my machines configured for siw.

Issue:
SIW device gets wrong device ops (HW/real rdma driver device ops) instead of
siw device ops due to improper device matching.

Root-cause:
In libibverbs, during user cma initialisation, for each entry from the driver 
list, sysfs device is checked for matching name or device.
If the siw/rxe driver is at the head of the list, then sysfs device matches 
properly with the corresponding siw driver and gets the corresponding siw/rxe 
device ops. Now, If the siw/rxe driver is after the real HW driver cxgb4/mlx5 
respectively in the driver list, then siw sysfs device matches pci device and 
wrongly gets the device ops of HW driver (cxgb4/mlx5).

Below debug prints from verbs_register_driver() and driver_list entries, where 
siw is after cxgb4. I see verbs alloc context landing in cxgb4_alloc_context 
instead of siw_alloc_context, thus breaking user siw.

<debug> verbs_register_driver_22: 184: driver 0x176e370
<debug> verbs_register_driver_22: 185: name ipathverbs
<debug> verbs_register_driver_22: 184: driver 0x176f6a0
<debug> verbs_register_driver_22: 185: name cxgb4
<debug> verbs_register_driver_22: 184: driver 0x176fd50
<debug> verbs_register_driver_22: 185: name cxgb3
<debug> verbs_register_driver_22: 184: driver 0x1777020
<debug> verbs_register_driver_22: 185: name rxe
<debug> verbs_register_driver_22: 184: driver 0x1770a30
<debug> verbs_register_driver_22: 185: name siw
<debug> verbs_register_driver_22: 184: driver 0x1771120
<debug> verbs_register_driver_22: 185: name mlx4
<debug> verbs_register_driver_22: 184: driver 0x1771990
<debug> verbs_register_driver_22: 185: name mlx5
<debug> verbs_register_driver_22: 184: driver 0x1771ff0
<debug> verbs_register_driver_22: 185: name efa

<debug> try_drivers: 372: driver 0x176e370, sysfs_dev 0x1776b20, name: ipathverbs
<debug> try_drivers: 372: driver 0x176f6a0, sysfs_dev 0x1776b20, name: cxgb4
<debug> try_drivers: 372: driver 0x176fd50, sysfs_dev 0x1776b20, name: cxgb3
<debug> try_drivers: 372: driver 0x1777020, sysfs_dev 0x1776b20, name: rxe
<debug> try_drivers: 372: driver 0x1770a30, sysfs_dev 0x1776b20, name: siw
<debug> try_drivers: 372: driver 0x1771120, sysfs_dev 0x1776b20, name: mlx4
<debug> try_drivers: 372: driver 0x1771990, sysfs_dev 0x1776b20, name: mlx5
<debug> try_drivers: 372: driver 0x1771ff0, sysfs_dev 0x1776b20, name: efa

Proposed fix:
I have the below fix that works. It adds siw/rxe driver to the HEAD of the 
driver list and the rest to the tail. I am not sure if this fix is the ideal 
one, so I am attaching it to this mail.

diff --git a/libibverbs/init.c b/libibverbs/init.c
index 930d91811ca9..e44f0d743063 100644
--- a/libibverbs/init.c
+++ b/libibverbs/init.c
@@ -182,7 +182,10 @@ void verbs_register_driver(const struct verbs_device_ops *ops)

	driver->ops = ops;

-       list_add_tail(&driver_list, &driver->entry);
+       if (!strcmp(ops->name, "siw") || !strcmp(ops->name, "rxe"))
+               list_add(&driver_list, &driver->entry);
+       else
+               list_add_tail(&driver_list, &driver->entry);
 }
---

Thanks,
Bharat
