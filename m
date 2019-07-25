Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC0C755D7
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 19:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfGYRgO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 13:36:14 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:60655 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfGYRgO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 13:36:14 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x6PHaCI0007684;
        Thu, 25 Jul 2019 10:36:13 -0700
Date:   Thu, 25 Jul 2019 23:06:11 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
Subject: verbs_match_ent device field uninitialised with new driver id
 matching
Message-ID: <20190725173610.GA26368@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,
0c3cecfe04d (verbs: Use CHARDEV info from netlink to bind drivers)
With above commit, `device and vendor` fields of verbs_match_entry are left 
unintialised as match_driver_id succeeds always. This has broken user space 
cxgb4 iwarp as it uses `device` to get the chipversion. I am sending a patch 
to fix it in cxgb4 But I wanted to know if device and vendor fields being 0 
is as expected. 

(gdb) p *(const struct verbs_match_ent *)0x155553d7d0c0
$2 = {
  driver_data = 0x0,
    u = {
        modalias = 0x4 <Address 0x4 out of bounds>,
	    driver_id = 4 '\004'
	      },
	        vendor = 0,
		  device = 0,
		    kind = 3 '\003'
		    }

Thanks,
Bharat

