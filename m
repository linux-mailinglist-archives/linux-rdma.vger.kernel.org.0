Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36FA39D712
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 10:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhFGIUV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 04:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbhFGIUU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 04:20:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 526C160FF1;
        Mon,  7 Jun 2021 08:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623053910;
        bh=PNugdwjkUZoLaNdfxU2actNEEGYYe41d04vO/Xty504=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=niLf7MtPqCoPADAPkl0WztMVMtS+Zn9VDsA40hFsv5gEEmHtUnq40P+EaYOTZebwB
         e6vASXsDV3JbBeV9hm1LFTG5VmI4K3EPVaDpuwt1MOxGEK9jiybbvFn5S4VP2xYSWc
         4htRHvMuqGluUK65ZVByO2QCXHre2EygvdmWcRhiJaaqGzb2ijGoEgKQDtqCNAgRr+
         ZoyOkfkLP5otClpCMBv6r9KS2pYwK/mi/+wJFFmhVipOadnLD+q2TKl7nBdPcMknaz
         Ec60mgA70H82jAnKrVdsC6liGb3ai/Ygd8ZG9nQ8xkJI/3Z1neXdKfst3iPhM95G7K
         1wGkT60Tw34lw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next v1 08/15] RDMA/core: Remove the kobject_uevent() NOP
Date:   Mon,  7 Jun 2021 11:17:33 +0300
Message-Id: <0d1deca036afe09cdddd9bead8cb6e0a6e52be60.1623053078.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623053078.git.leonro@nvidia.com>
References: <cover.1623053078.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

This call does nothing because the ib_port kobj is nested under a struct
device kobject and the dev_uevent_filter() function of the struct device
blocks uevents for any children kobj's that are not also struct devices.

A uevent for the struct device will be triggered after
ib_setup_port_attrs() returns which causes udev to pick up all the deep
"attributes" which are implemented as kobjects nested under a struct
device and assign them to the udev object for the struct device:

 $ udevadm info -a /sys/class/infiniband/ibp0s9
     ATTR{ports/1/counters/excessive_buffer_overrun_errors}=="0"

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 07a00d3d3d44..14b838863b5d 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1422,8 +1422,6 @@ int ib_setup_port_attrs(struct ib_core_device *coredev)
 			if (ret)
 				goto err_put;
 		}
-
-		kobject_uevent(&port->kobj, KOBJ_ADD);
 	}
 	return 0;
 
-- 
2.31.1

