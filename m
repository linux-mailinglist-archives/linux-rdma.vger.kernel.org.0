Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF6F1D1F44
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 06:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfJJEJd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 00:09:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41504 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfJJEJd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Oct 2019 00:09:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id t3so2781784pga.8;
        Wed, 09 Oct 2019 21:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:user-agent:date:from:to:cc:cc:subject:references
         :mime-version:content-disposition;
        bh=StQwwzl5sIUT0iWQHdYG7DfV+RABFpPOuXBX/Txahe0=;
        b=FOYtjn20cV0H0TNQ/UCyO0e88kTjZgOBpLw4yYHXoUCbkKcfbTFSfgDG/+UKIEJl9R
         DuYrOYJxhxiJ06CuJN+U65dITiJ4mLE9yUib6LucE2trQfqoBRNj8PnekYAzq3ZxSPay
         l3o0/GDHIG3fibOd7bHuJyyc7k2Bqpu6NrhUGDcRdW+InH4zW3OXWtdLHxxq929Vh0gq
         5nByXWm4hvfA07SWiKHCxAGhv5PsNgzXJ5sqQSYlLgFv1+K/OEmXmNvF/J+uty8T8vpU
         Q5ywPzQBE6WtI7n1DywrLIM/G9Enct2Shld/OtX7w1Wi8XPN8Qd1XdwxqbomqkM4WjSj
         xccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:user-agent:date:from:to:cc:cc:subject
         :references:mime-version:content-disposition;
        bh=StQwwzl5sIUT0iWQHdYG7DfV+RABFpPOuXBX/Txahe0=;
        b=g96l77A4JKzmZCLETBM4zLJ0B1M8UFD8l+wrwML7Up+7ZClR9VkaIZ0cjngdcNU99A
         6GZoxspZYlNhvws4h8rcZhswmGaqZYtNOSXrUuUduZMsGqXVzUEOJisMaKpYGobMDG80
         PcigfLjoNzlIVXac383xXe2oDNfDANXCYiSxJdsR9Ejv91gVSRabXvNCxvNDe9rcPuqs
         pYf20aBhM7Yzc3n23Ch48ux7OKrN721X9daqdwNgxS6PLRBEa2etXA9Sw0m1fl6zmhhA
         60JW57gRcIAL9UjGh3YgbnEe/dmmS0maGLuE68zqA06K7Jza++kje49h5XimdZGfX9VZ
         CIUQ==
X-Gm-Message-State: APjAAAVgFkmU/QpqdfqLtATJd+pt66uNNRk2OCMs8xi0aH4xyi9iXnNE
        yrGUnIRTad5CpLw0/HTx7kM1a6F2
X-Google-Smtp-Source: APXvYqwiBsb5RmznPX5siJ6DVI/vfThb87nulItVLSDAx4fDfNNu02CVhurjYt78Bm785UTNm8Pchw==
X-Received: by 2002:a62:6842:: with SMTP id d63mr7778614pfc.16.1570680572364;
        Wed, 09 Oct 2019 21:09:32 -0700 (PDT)
Received: from localhost ([2601:1c0:6280:3f0::9ef4])
        by smtp.gmail.com with ESMTPSA id h4sm3703901pgg.81.2019.10.09.21.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:09:31 -0700 (PDT)
Message-Id: <20191010035240.191542461@gmail.com>
User-Agent: quilt/0.65
Date:   Wed, 09 Oct 2019 20:52:49 -0700
From:   rd.dunlab@gmail.com
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 10/12] infiniband: fix core/ kernel-doc notation
References: <20191010035239.532908118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=015-iband-core-fixes.patch
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Correct function parameter names (typos or renames).
Add kernel-doc notation for missing function parameters.

../drivers/infiniband/core/sa_query.c:1263: warning: Function parameter or member 'gid_attr' not described in 'ib_init_ah_attr_from_path'
../drivers/infiniband/core/sa_query.c:1263: warning: Excess function parameter 'sgid_attr' description in 'ib_init_ah_attr_from_path'

../drivers/infiniband/core/device.c:145: warning: Function parameter or member 'dev' not described in 'rdma_dev_access_netns'
../drivers/infiniband/core/device.c:145: warning: Excess function parameter 'device' description in 'rdma_dev_access_netns'
../drivers/infiniband/core/device.c:1333: warning: Function parameter or member 'name' not described in 'ib_register_device'
../drivers/infiniband/core/device.c:1461: warning: Function parameter or member 'ib_dev' not described in 'ib_unregister_device'
../drivers/infiniband/core/device.c:1461: warning: Excess function parameter 'device' description in 'ib_unregister_device'
../drivers/infiniband/core/device.c:1483: warning: Function parameter or member 'ib_dev' not described in 'ib_unregister_device_and_put'
../drivers/infiniband/core/device.c:1550: warning: Function parameter or member 'ib_dev' not described in 'ib_unregister_device_queued'

Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-doc@vger.kernel.org
---
 drivers/infiniband/core/device.c   |   23 +++++++++++------------
 drivers/infiniband/core/sa_query.c |    2 +-
 2 files changed, 12 insertions(+), 13 deletions(-)

--- linux-next-20191009.orig/drivers/infiniband/core/sa_query.c
+++ linux-next-20191009/drivers/infiniband/core/sa_query.c
@@ -1246,7 +1246,7 @@ static int init_ah_attr_grh_fields(struc
  * @port_num: Port on the specified device.
  * @rec: path record entry to use for ah attributes initialization.
  * @ah_attr: address handle attributes to initialization from path record.
- * @sgid_attr: SGID attribute to consider during initialization.
+ * @gid_attr: SGID attribute to consider during initialization.
  *
  * When ib_init_ah_attr_from_path() returns success,
  * (a) for IB link layer it optionally contains a reference to SGID attribute
--- linux-next-20191009.orig/drivers/infiniband/core/device.c
+++ linux-next-20191009/drivers/infiniband/core/device.c
@@ -128,17 +128,14 @@ module_param_named(netns_mode, ib_device
 MODULE_PARM_DESC(netns_mode,
 		 "Share device among net namespaces; default=1 (shared)");
 /**
- * rdma_dev_access_netns() - Return whether a rdma device can be accessed
+ * rdma_dev_access_netns() - Return whether an rdma device can be accessed
  *			     from a specified net namespace or not.
- * @device:	Pointer to rdma device which needs to be checked
+ * @dev:	Pointer to rdma device which needs to be checked
  * @net:	Pointer to net namesapce for which access to be checked
  *
- * rdma_dev_access_netns() - Return whether a rdma device can be accessed
- *			     from a specified net namespace or not. When
- *			     rdma device is in shared mode, it ignores the
- *			     net namespace. When rdma device is exclusive
- *			     to a net namespace, rdma device net namespace is
- *			     checked against the specified one.
+ * When the rdma device is in shared mode, it ignores the net namespace.
+ * When the rdma device is exclusive to a net namespace, rdma device net
+ * namespace is checked against the specified one.
  */
 bool rdma_dev_access_netns(const struct ib_device *dev, const struct net *net)
 {
@@ -1317,7 +1314,9 @@ out:
 
 /**
  * ib_register_device - Register an IB device with IB core
- * @device:Device to register
+ * @device: Device to register
+ * @name: unique string device name. This may include a '%' which will
+ * cause a unique index to be added to the passed device name.
  *
  * Low-level drivers use ib_register_device() to register their
  * devices with the IB core.  All registered clients will receive a
@@ -1444,7 +1443,7 @@ out:
 
 /**
  * ib_unregister_device - Unregister an IB device
- * @device: The device to unregister
+ * @ib_dev: The device to unregister
  *
  * Unregister an IB device.  All clients will receive a remove callback.
  *
@@ -1466,7 +1465,7 @@ EXPORT_SYMBOL(ib_unregister_device);
 
 /**
  * ib_unregister_device_and_put - Unregister a device while holding a 'get'
- * device: The device to unregister
+ * @ib_dev: The device to unregister
  *
  * This is the same as ib_unregister_device(), except it includes an internal
  * ib_device_put() that should match a 'get' obtained by the caller.
@@ -1536,7 +1535,7 @@ static void ib_unregister_work(struct wo
 
 /**
  * ib_unregister_device_queued - Unregister a device using a work queue
- * device: The device to unregister
+ * @ib_dev: The device to unregister
  *
  * This schedules an asynchronous unregistration using a WQ for the device. A
  * driver should use this to avoid holding locks while doing unregistration,


