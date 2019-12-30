Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE5E12CEB9
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfL3K3r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:29:47 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36193 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfL3K3r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:29:47 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so32197687edp.3;
        Mon, 30 Dec 2019 02:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uHfNZfuZfuWx9jrr7nmCvIqY9LdGmVI27785StFil5k=;
        b=ueCop21Mp38DVR4o7TvSS2BXGTfx9ZxpcfmHG9MfXbKYaee0m/fyINidS8g0D0IeZ6
         0oVWOpehP2NuxMud/ipNA0Rum8u/zCB6mQZOrXujw9FPXDZf9Y+Aga+7sBmhUY9BWYi4
         1VAiQrRmofTlUrqnhKChxPWDGeNBhkQt0pwzj2QardYN+AbPl+VH8oC4vg9lvdzZU18G
         MJah0I9pBjfFRiieOIYmLu+m0XXfDnVI18kJsad40LTidp6jZGE/abU8RO/lFlNXWaDI
         yC91CaD4kiTdvUTk51DRXAYXwib8qZ6cus8vNwwuESyFdTyAYM3N3md71eYYDaEmixaN
         y+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uHfNZfuZfuWx9jrr7nmCvIqY9LdGmVI27785StFil5k=;
        b=lx8UJZi7HIV9YzhRjqgaiL6uIV1OUgHTbvs8YMbMuDUwLHEXj1KnxKA/DKYmc+xqB0
         TQE/KiV82up4jo7DYEx+q6HtSAe6NCMayEESmznh35jqkr5+lCcPhLztHa1KuKpgswMP
         +oCeDPMxnZttKHCShUOsG6v4SfzaGuKE3xv4tjTF5tBExVI/bzX1ojdlY5FiuEIEY1WA
         UV4wMiJKO7FBRLOQaIBpI8P4LtC/Qgu642PnyemGzXhHy/FAaXdChZaZ7IRFAsChUDIT
         8VaiVspskc0W3gR0w6RKuB1UMzlFNjBHXu6dlw3sytisOkUh8g+eoSY75MFpRFb2R/JJ
         Gz9Q==
X-Gm-Message-State: APjAAAXi7Mdz/v1an8Sl+lRixvECf2tZx2ypPDdLZy4PyoBNgP1fvHk/
        KMyS5D/0FdFZU68EpT03VJ7aZbtq
X-Google-Smtp-Source: APXvYqwdk9iJW8m+3LVDbfdDsbv1kozFxyrLG1wuDOX+x0FsOQOAyPu0JYQr3h5SasDjL6ec0mgHJQ==
X-Received: by 2002:a17:906:a394:: with SMTP id k20mr67418410ejz.216.1577701784473;
        Mon, 30 Dec 2019 02:29:44 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:29:43 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 00/25] RTRS (former IBTRS) rdma transport library and RNBD (former IBNBD) rdma network block device
Date:   Mon, 30 Dec 2019 11:29:17 +0100
Message-Id: <20191230102942.18395-1-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

here is V6 of the RTRS (former IBTRS) rdma transport library and the
corresponding RNBD (former IBNBD) rdma network block device.

Changelog since v5:
1 rebased to linux-5.5-rc4
2 fix typo in my email address in first patch
3 cleanup copyright as suggested by Leon Romanovsky
4 remove 2 redudant kobject_del in error path as suggested by Leon Romanovsky
5 add MAINTAINERS entries in alphabetical order as Gal Pressman suggested


Introduction
-------------

RTRS (RDMA Transport) is a reliable high speed transport library
which allows for establishing connection between client and server
machines via RDMA. It is based on RDMA-CM, so expect also to support RoCE
and iWARP, but we mainly tested in IB environment. It is optimized to
transfer (read/write) IO blocks in the sense that it follows the BIO
semantics of providing the possibility to either write data from a
scatter-gather list to the remote side or to request ("read") data
transfer from the remote side into a given set of buffers.

RTRS is multipath capable and provides I/O fail-over and load-balancing
functionality, i.e. in RTRS terminology, an RTRS path is a set of RDMA
connections and particular path is selected according to the load-balancing policy.
It can be used for other components not bind to RNBD.

RNBD (InfiniBand Network Block Device) is a pair of kernel modules
(client and server) that allow for remote access of a block device on
the server over RTRS protocol. After being mapped, the remote block
devices can be accessed on the client side as local block devices.
Internally RNBD uses RTRS as an RDMA transport library.

Commits for kernel can be found here:
   https://github.com/ionos-enterprise/ibnbd/commits/linux-5.5-rc4-ibnbd-v6
The out-of-tree modules are here:
   https://github.com/ionos-enterprise/ibnbd

As always, please review and share your comments, 

thanks.

Jack Wang (25):
  sysfs: export sysfs_remove_file_self()
  rtrs: public interface header to establish RDMA connections
  rtrs: private headers with rtrs protocol structs and helpers
  rtrs: core: lib functions shared between client and server modules
  rtrs: client: private header with client structs and functions
  rtrs: client: main functionality
  rtrs: client: statistics functions
  rtrs: client: sysfs interface functions
  rtrs: server: private header with server structs and functions
  rtrs: server: main functionality
  rtrs: server: statistics functions
  rtrs: server: sysfs interface functions
  rtrs: include client and server modules into kernel compilation
  rtrs: a bit of documentation
  rnbd: private headers with rnbd protocol structs and helpers
  rnbd: client: private header with client structs and functions
  rnbd: client: main functionality
  rnbd: client: sysfs interface functions
  rnbd: server: private header with server structs and functions
  rnbd: server: main functionality
  rnbd: server: functionality for IO submission to file or block dev
  rnbd: server: sysfs interface functions
  rnbd: include client and server modules into kernel compilation
  rnbd: a bit of documentation
  MAINTAINERS: Add maintainers for RNBD/RTRS modules

 Documentation/ABI/testing/sysfs-block-rnbd    |   51 +
 .../ABI/testing/sysfs-class-rnbd-client       |  117 +
 .../ABI/testing/sysfs-class-rnbd-server       |   57 +
 .../ABI/testing/sysfs-class-rtrs-client       |  190 ++
 .../ABI/testing/sysfs-class-rtrs-server       |   81 +
 MAINTAINERS                                   |   14 +
 drivers/block/Kconfig                         |    2 +
 drivers/block/Makefile                        |    1 +
 drivers/block/rnbd/Kconfig                    |   28 +
 drivers/block/rnbd/Makefile                   |   17 +
 drivers/block/rnbd/README                     |   92 +
 drivers/block/rnbd/rnbd-clt-sysfs.c           |  641 ++++
 drivers/block/rnbd/rnbd-clt.c                 | 1743 ++++++++++
 drivers/block/rnbd/rnbd-clt.h                 |  151 +
 drivers/block/rnbd/rnbd-common.c              |   25 +
 drivers/block/rnbd/rnbd-log.h                 |   43 +
 drivers/block/rnbd/rnbd-proto.h               |  307 ++
 drivers/block/rnbd/rnbd-srv-dev.c             |  144 +
 drivers/block/rnbd/rnbd-srv-dev.h             |  112 +
 drivers/block/rnbd/rnbd-srv-sysfs.c           |  213 ++
 drivers/block/rnbd/rnbd-srv.c                 |  864 +++++
 drivers/block/rnbd/rnbd-srv.h                 |   81 +
 drivers/infiniband/Kconfig                    |    1 +
 drivers/infiniband/ulp/Makefile               |    1 +
 drivers/infiniband/ulp/rtrs/Kconfig           |   27 +
 drivers/infiniband/ulp/rtrs/Makefile          |   17 +
 drivers/infiniband/ulp/rtrs/README            |  149 +
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c  |  435 +++
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  |  501 +++
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        | 2934 +++++++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-clt.h        |  296 ++
 drivers/infiniband/ulp/rtrs/rtrs-log.h        |   32 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h        |  408 +++
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c  |   91 +
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c  |  297 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c        | 2169 ++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-srv.h        |  141 +
 drivers/infiniband/ulp/rtrs/rtrs.c            |  628 ++++
 drivers/infiniband/ulp/rtrs/rtrs.h            |  316 ++
 fs/sysfs/file.c                               |    1 +
 40 files changed, 13418 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-block-rnbd
 create mode 100644 Documentation/ABI/testing/sysfs-class-rnbd-client
 create mode 100644 Documentation/ABI/testing/sysfs-class-rnbd-server
 create mode 100644 Documentation/ABI/testing/sysfs-class-rtrs-client
 create mode 100644 Documentation/ABI/testing/sysfs-class-rtrs-server
 create mode 100644 drivers/block/rnbd/Kconfig
 create mode 100644 drivers/block/rnbd/Makefile
 create mode 100644 drivers/block/rnbd/README
 create mode 100644 drivers/block/rnbd/rnbd-clt-sysfs.c
 create mode 100644 drivers/block/rnbd/rnbd-clt.c
 create mode 100644 drivers/block/rnbd/rnbd-clt.h
 create mode 100644 drivers/block/rnbd/rnbd-common.c
 create mode 100644 drivers/block/rnbd/rnbd-log.h
 create mode 100644 drivers/block/rnbd/rnbd-proto.h
 create mode 100644 drivers/block/rnbd/rnbd-srv-dev.c
 create mode 100644 drivers/block/rnbd/rnbd-srv-dev.h
 create mode 100644 drivers/block/rnbd/rnbd-srv-sysfs.c
 create mode 100644 drivers/block/rnbd/rnbd-srv.c
 create mode 100644 drivers/block/rnbd/rnbd-srv.h
 create mode 100644 drivers/infiniband/ulp/rtrs/Kconfig
 create mode 100644 drivers/infiniband/ulp/rtrs/Makefile
 create mode 100644 drivers/infiniband/ulp/rtrs/README
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.c
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.h
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-log.h
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-pri.h
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.c
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.h
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.c
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.h

-- 
2.17.1

