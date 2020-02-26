Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 486A216F6D0
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 06:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgBZFKG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 00:10:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34355 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgBZFKG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Feb 2020 00:10:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id j7so811106plt.1
        for <linux-rdma@vger.kernel.org>; Tue, 25 Feb 2020 21:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZfHtaxQVbFEpUqrpNK/La06e4MN1pPtT7pSzVvBDz28=;
        b=WDS8rnw//hZjNOv1bhYUNmmmcEeLc+y3zZqPWefI3l4CwNNhEQChBYypdXG0B6jAVc
         YZE0hD9Yrt8vW37ADsXffGzMlvDwbnN7ovhd37x7SLYAEj6x6VxqVf4BEYaNEocatrKu
         pdjjt8nbP7P0HKNaQgJnqkZfp8zIWT+ih/WQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZfHtaxQVbFEpUqrpNK/La06e4MN1pPtT7pSzVvBDz28=;
        b=e/7mg85Ghvr/SBFMTIj0pWvLT+6ukFxnkfZzcrMVHGyv9WJ9WRCP+mqOgi35eTJ3AE
         hRflExhm/e3+WgR0cAp/lvMQp70K02dqsi87Ngi2zvjDdiFmvumeE22lzYo4UNeB1k6Y
         n/BT1UNlGgwbIAF4OYCHh5ZHIsq+Q7orVDeMQjVflgZd4zXWzawlZNN3fkrZuxNMCt8D
         zxlJq6hJ5v+NLpOVBNAtOcM6MaEzIupXaLRCB1IB7HcYB3UhVAKHHx3EWyWXkqrbbiKb
         naqG3y2+hf0wtHN0FPfIXvo8cC/IasizfAU3JNkEF+iDOFUbZ9ZYLfj0JBbilu5qtKDd
         e6og==
X-Gm-Message-State: APjAAAVvVeMlVQRuCEhy48sQHPNzDM8/cX+Za4Oh1bSJHtBGiFFeH54q
        VkPcZpinBQiF6YINGYzoRBWsW0vEBCs=
X-Google-Smtp-Source: APXvYqwgnZK8BTSdTpdiv5SuMOwlTOsPSLB9AOqkw5052Ig/xX9IMlIgtE7CYbfpPmmmsZUXgqwGGw==
X-Received: by 2002:a17:90a:d990:: with SMTP id d16mr2993666pjv.143.1582693804596;
        Tue, 25 Feb 2020 21:10:04 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id o73sm817962pje.7.2020.02.25.21.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 21:10:03 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 0/2] RDMA/bnxt_re driver update
Date:   Tue, 25 Feb 2020 21:09:52 -0800
Message-Id: <1582693794-23373-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Includes code refactoring in the device init/deinit path and
use the new driver unregistration APIs.

Please apply to for-next.

v2 -> v3:
 - Droped the patch which was adding more state macros
 - To prevent addition of any device during driver removal,
   unregister netdev notifier and delete the driver's workqueu
   before calling ib_unregister_driver
v1-> v2:
 - Remove the patches 1,2 and 6 from the v1 series.
   They are already merged.
 - Added ASSERT_RTNL instead of comment in Patch 2
 - For Patch 3, explicitly queue the removal of the VF devices
   before calling ib_unregister_driver. This can avoid command
   timeouts seen, if the PFs gets removed before the VFs.
   Previous discussion - https://patchwork.kernel.org/patch/11260013/




Selvin Xavier (2):
  RDMA/bnxt_re: Refactor device add/remove functionalities
  RDMA/bnxt_re: Use driver_unregister and unregistration API

 drivers/infiniband/hw/bnxt_re/main.c | 209 +++++++++++++++++------------------
 1 file changed, 104 insertions(+), 105 deletions(-)

-- 
2.5.5

