Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACD44D14B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfFTPDn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:03:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35412 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfFTPDn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:03:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so5213802edr.2;
        Thu, 20 Jun 2019 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yjlrECafP1UAhBZTppwIjsg+5Wc/+pSe/lUTk3WuWE0=;
        b=NXz6swAcF91kdyhRtEmS7i+1Y4bVvtho+j9udQHCT3zTe77s/YUbg7xM/2IADiK3A8
         WOeaEcDFMNGftocY/+5Log6slDFCsoJXjk5v+CjNfb5pgiS7UC2xi4J7bqaFWnyXNVRK
         hlwSC6c8IzKZJ6xnVpCedmfTkcPq7BO/f7AUTcNTHrIDIs+GROSZVgF9WYbyNqlExXDC
         uVcIaBNGermBsZzwc+1MgAIsKxbUde2g5578rMIcYlofhpHKXcar0BZ9qqKwG+SMOoH3
         UZ8xmw7oxliIALTNWOt6oU4NO+dx7Oo1x9IwG+X+dm7jood9pghltJAmvz1uPkMpoSP+
         KRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yjlrECafP1UAhBZTppwIjsg+5Wc/+pSe/lUTk3WuWE0=;
        b=N0oi4F4z6vKFq+cuTo5TLdFkez+QL1PXQz9k+Jk/uPzb49vEeIJ8XkqUtsyA9nmapq
         kI1xmcpu5OCeoM/KpHGrO7VgTDEuhiYJdGEGawAjQksll0x+MagB92hew+HxyPsO1/ir
         ZJJUNSdYEj1Z4YWSX9XG9C/677b7Pt6Fk7BUPvuy9QgBCuuqZKyxXe9cR2m7+zxYrKP1
         T/YeYYbeFAfydtrdARHitiHc8fBLawErpoH2FwHLycx/fGA+9hXXVwONieHYLQZosAQc
         ya0nYsIcRM7YyUSaXZC7YXpAgQXKtHADsuwp5hyTCvwK87Po5j2mppMEkC3sGlZAKpT7
         t6iA==
X-Gm-Message-State: APjAAAXwnwyyy7cXU6Ig7+ccNU/vpemy3t1D3k56WffTzGhTbpfQX+jx
        lazG3eqjGdUc5uCwPOWRXS9A3xYM0vU=
X-Google-Smtp-Source: APXvYqyZEkOmpSy4I4bIHP8T4lBbdQEoqvLpV9SOjeG6xgeqxZbpglFLC+GfeXKYSTHY1ww/5uUqtA==
X-Received: by 2002:a17:906:eb93:: with SMTP id mh19mr39100484ejb.42.1561043020589;
        Thu, 20 Jun 2019 08:03:40 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.03.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:03:40 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block Device (IBNBD)
Date:   Thu, 20 Jun 2019 17:03:12 +0200
Message-Id: <20190620150337.7847-1-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

Here is v4 of IBNBD/IBTRS patches, which have minor changes

 Changelog
 ---------
v4:
  o Protocol extended to transport IO priorities
  o Support for Mellanox ConnectX-4/X-5
  o Minor sysfs extentions (display access mode on server side)
  o Bug fixes: cleaning up sysfs folders, race on deallocation of resources
  o Style fixes

v3:
  o Sparse fixes:
     - le32 -> le16 conversion
     - pcpu and RCU wrong declaration
     - sysfs: dynamically alloc array of sockaddr structures to reduce
	   size of a stack frame

  o Rename sysfs folder on client and server sides to show source and
    destination addresses of the connection, i.e.:
	   .../<session-name>/paths/<src@dst>/

  o Remove external inclusions from Makefiles.
  * https://lwn.net/Articles/756994/

v2:
  o IBNBD:
     - No legacy request IO mode, only MQ is left.

  o IBTRS:
     - No FMR registration, only FR is left.

  * https://lwn.net/Articles/755075/

v1:
  - IBTRS: load-balancing and IO fail-over using multipath features were added.

  - Major parts of the code were rewritten, simplified and overall code
    size was reduced by a quarter.

  * https://lwn.net/Articles/746342/

v0:
  - Initial submission

  * https://lwn.net/Articles/718181/


 Introduction
 -------------

IBTRS (InfiniBand Transport) is a reliable high speed transport library
which allows for establishing connection between client and server
machines via RDMA. It is based on RDMA-CM, so expect also to support RoCE
and iWARP, but we mainly tested in IB environment. It is optimized to
transfer (read/write) IO blocks in the sense that it follows the BIO 
semantics of providing the possibility to either write data from a 
scatter-gather list to the remote side or to request ("read") data
transfer from the remote side into a given set of buffers.

IBTRS is multipath capable and provides I/O fail-over and load-balancing
functionality, i.e. in IBTRS terminology, an IBTRS path is a set of RDMA
CMs and particular path is selected according to the load-balancing policy.
It can be used for other components not bind to IBNBD.


IBNBD (InfiniBand Network Block Device) is a pair of kernel modules
(client and server) that allow for remote access of a block device on
the server over IBTRS protocol. After being mapped, the remote block
devices can be accessed on the client side as local block devices.
Internally IBNBD uses IBTRS as an RDMA transport library.


   - IBNBD/IBTRS is developed in order to map thin provisioned volumes,
     thus internal protocol is simple.
   - IBTRS was developed as an independent RDMA transport library, which
     supports fail-over and load-balancing policies using multipath, thus
     it can be used for any other IO needs rather than only for block
     device.
   - IBNBD/IBTRS is fast.
     Old comparison results:
     https://www.spinics.net/lists/linux-rdma/msg48799.html
     New comparison results: see performance measurements section below.

Key features of IBTRS transport library and IBNBD block device:

o High throughput and low latency due to:
   - Only two RDMA messages per IO.
   - IMM InfiniBand messages on responses to reduce round trip latency.
   - Simplified memory management: memory allocation happens once on
     server side when IBTRS session is established.

o IO fail-over and load-balancing by using multipath.  According to
  our test loads additional path brings ~20% of bandwidth.  

o Simple configuration of IBNBD:
   - Server side is completely passive: volumes do not need to be
     explicitly exported.
   - Only IB port GID and device path needed on client side to map
     a block device.
   - A device is remapped automatically i.e. after storage reboot.

Commits for kernel can be found here:
   https://github.com/ionos-enterprise/ibnbd/tree/linux-5.2-rc3--ibnbd-v4
The out-of-tree modules are here:
   https://github.com/ionos-enterprise/ibnbd

Vault 2017 presentation:
  https://events.static.linuxfound.org/sites/events/files/slides/IBNBD-Vault-2017.pdf

 Performance measurements
 ------------------------

o IBNBD and NVMEoRDMA

  Performance results for the v5.2-rc3 kernel
  link: https://github.com/ionos-enterprise/ibnbd/tree/develop/performance/v4-v5.2-rc3

Roman Pen (25):
  sysfs: export sysfs_remove_file_self()
  ibtrs: public interface header to establish RDMA connections
  ibtrs: private headers with IBTRS protocol structs and helpers
  ibtrs: core: lib functions shared between client and server modules
  ibtrs: client: private header with client structs and functions
  ibtrs: client: main functionality
  ibtrs: client: statistics functions
  ibtrs: client: sysfs interface functions
  ibtrs: server: private header with server structs and functions
  ibtrs: server: main functionality
  ibtrs: server: statistics functions
  ibtrs: server: sysfs interface functions
  ibtrs: include client and server modules into kernel compilation
  ibtrs: a bit of documentation
  ibnbd: private headers with IBNBD protocol structs and helpers
  ibnbd: client: private header with client structs and functions
  ibnbd: client: main functionality
  ibnbd: client: sysfs interface functions
  ibnbd: server: private header with server structs and functions
  ibnbd: server: main functionality
  ibnbd: server: functionality for IO submission to file or block dev
  ibnbd: server: sysfs interface functions
  ibnbd: include client and server modules into kernel compilation
  ibnbd: a bit of documentation
  MAINTAINERS: Add maintainer for IBNBD/IBTRS modules

 MAINTAINERS                                   |   14 +
 drivers/block/Kconfig                         |    2 +
 drivers/block/Makefile                        |    1 +
 drivers/block/ibnbd/Kconfig                   |   24 +
 drivers/block/ibnbd/Makefile                  |   13 +
 drivers/block/ibnbd/README                    |  315 ++
 drivers/block/ibnbd/ibnbd-clt-sysfs.c         |  691 ++++
 drivers/block/ibnbd/ibnbd-clt.c               | 1832 +++++++++++
 drivers/block/ibnbd/ibnbd-clt.h               |  166 +
 drivers/block/ibnbd/ibnbd-log.h               |   59 +
 drivers/block/ibnbd/ibnbd-proto.h             |  378 +++
 drivers/block/ibnbd/ibnbd-srv-dev.c           |  408 +++
 drivers/block/ibnbd/ibnbd-srv-dev.h           |  143 +
 drivers/block/ibnbd/ibnbd-srv-sysfs.c         |  270 ++
 drivers/block/ibnbd/ibnbd-srv.c               |  945 ++++++
 drivers/block/ibnbd/ibnbd-srv.h               |   94 +
 drivers/infiniband/Kconfig                    |    1 +
 drivers/infiniband/ulp/Makefile               |    1 +
 drivers/infiniband/ulp/ibtrs/Kconfig          |   22 +
 drivers/infiniband/ulp/ibtrs/Makefile         |   15 +
 drivers/infiniband/ulp/ibtrs/README           |  385 +++
 .../infiniband/ulp/ibtrs/ibtrs-clt-stats.c    |  447 +++
 .../infiniband/ulp/ibtrs/ibtrs-clt-sysfs.c    |  514 +++
 drivers/infiniband/ulp/ibtrs/ibtrs-clt.c      | 2844 +++++++++++++++++
 drivers/infiniband/ulp/ibtrs/ibtrs-clt.h      |  308 ++
 drivers/infiniband/ulp/ibtrs/ibtrs-log.h      |   84 +
 drivers/infiniband/ulp/ibtrs/ibtrs-pri.h      |  463 +++
 .../infiniband/ulp/ibtrs/ibtrs-srv-stats.c    |  103 +
 .../infiniband/ulp/ibtrs/ibtrs-srv-sysfs.c    |  303 ++
 drivers/infiniband/ulp/ibtrs/ibtrs-srv.c      | 1998 ++++++++++++
 drivers/infiniband/ulp/ibtrs/ibtrs-srv.h      |  170 +
 drivers/infiniband/ulp/ibtrs/ibtrs.c          |  610 ++++
 drivers/infiniband/ulp/ibtrs/ibtrs.h          |  318 ++
 fs/sysfs/file.c                               |    1 +
 34 files changed, 13942 insertions(+)
 create mode 100644 drivers/block/ibnbd/Kconfig
 create mode 100644 drivers/block/ibnbd/Makefile
 create mode 100644 drivers/block/ibnbd/README
 create mode 100644 drivers/block/ibnbd/ibnbd-clt-sysfs.c
 create mode 100644 drivers/block/ibnbd/ibnbd-clt.c
 create mode 100644 drivers/block/ibnbd/ibnbd-clt.h
 create mode 100644 drivers/block/ibnbd/ibnbd-log.h
 create mode 100644 drivers/block/ibnbd/ibnbd-proto.h
 create mode 100644 drivers/block/ibnbd/ibnbd-srv-dev.c
 create mode 100644 drivers/block/ibnbd/ibnbd-srv-dev.h
 create mode 100644 drivers/block/ibnbd/ibnbd-srv-sysfs.c
 create mode 100644 drivers/block/ibnbd/ibnbd-srv.c
 create mode 100644 drivers/block/ibnbd/ibnbd-srv.h
 create mode 100644 drivers/infiniband/ulp/ibtrs/Kconfig
 create mode 100644 drivers/infiniband/ulp/ibtrs/Makefile
 create mode 100644 drivers/infiniband/ulp/ibtrs/README
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-clt-stats.c
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-clt-sysfs.c
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-clt.c
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-clt.h
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-log.h
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-pri.h
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv-stats.c
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv-sysfs.c
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv.c
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv.h
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs.c
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs.h

-- 
2.17.1

