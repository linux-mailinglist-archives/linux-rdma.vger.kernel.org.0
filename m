Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48597127FD2
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 16:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLTPvP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 10:51:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32952 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfLTPvP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 10:51:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so9914723wrq.0;
        Fri, 20 Dec 2019 07:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IBm6feFWVANJYZl9XJ1kqzu+aNqxi1qNzlQiL2i7G3E=;
        b=SIBcsOZ13INH8qU7RMOiV4mmwGVCp9sa7Xu9VYr22/MJJpJn+fGVj3/RYmS4czRbqr
         luywoEUfS9kToNcio0QjuK2Hg575KNRx2vVNY1W/28cdbevXOeRMpkjEu1OqciMqrs2Q
         nPaGPSDWg3ccRQVgAlQDmbDtrg1sS8wVV8wuz1e6RkHEa8mqaOhUWov9CxkaHO7nlOH9
         xe43GvLlSLWwVyh3D8gowGX/deMPCQtiyPzjC+QUpnbDEXzckV7KZ7n0GhpzwnXHIuPr
         Fjvq6+pvX9Cq0T9e6xplWJG1K5TQLqiae5fDDpSA8y9IdDLlMRk3cy4zb43COT0jTZz8
         kvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IBm6feFWVANJYZl9XJ1kqzu+aNqxi1qNzlQiL2i7G3E=;
        b=ith/kb2MS8wcCEkGKZA9hp3ZD/2ZUnmyReD12FMoXik89rwn4n9osinSxLtrcT+jrJ
         5Ub6uBFJ4DzsN7iVtLq4mnXQ4cMRBj+FKDbb9Fvhv0DyZFAPU82RPuWLLiWOqimxDji5
         +ipjPuvC8TEOjYWz6XTbtTWAR7qdfcflCPiWuTNCv1kIjKw8cQ2YFay4dERRIyzPuDOT
         /bMpEc0/8z/QMxOt2QoljgghU0VLtz6XkAMFCCtNtEIjPdHbUICE/HlQ4R1cMsQfWL6X
         LvyPlRd9VaSFftjNKsaIbji5l57TRmkC0/baKHLY6dVbT0xL6d7FGNMs6BmTOoh+Y4sp
         nbug==
X-Gm-Message-State: APjAAAVKNrBx4UFMIOOmBFofeArZZh2XQz207sOH79C1HcncO78OrGbG
        jhnuUB3MWaH2Cb6AB575zwVTpKbV4xA=
X-Google-Smtp-Source: APXvYqypHPln0erGTP8FbpmA7alGrB8cjkjQ0CRfJtUXcpSH4kZ2UW/5hmoVcu7pF+jhwrhxISXgFg==
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr16480557wrn.101.1576857071483;
        Fri, 20 Dec 2019 07:51:11 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4972:cc00:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id u14sm10372139wrm.51.2019.12.20.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:51:10 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v5 00/25] RTRS (former IBTRS) rdma transport library and the corresponding RNBD (former IBNBD) rdma network block device
Date:   Fri, 20 Dec 2019 16:50:44 +0100
Message-Id: <20191220155109.8959-1-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

here is V5 of the RTRS (former IBTRS) rdma transport library and the 
corresponding RNBD (former IBNBD) rdma network block device.

Main changes are the following:
1. Fix the security problem pointed out by Jason
2. Implement code-style/readability/API/etc suggestions by Bart van Assche
3. Rename IBTRS and IBNBD to RTRS and RNBD accordingly
4. Fileio mode support in rnbd-srv has been removed.

The main functional change is a fix for the security problem pointed out by 
Jason and discussed both on the mailing list and during the last LPC RDMA MC 2019.
On the server side we now invalidate in RTRS each rdma buffer before we hand it
over to RNBD server and in turn to the block layer. A new rkey is generated and
registered for the buffer after it returns back from the block layer and RNBD
server. The new rkey is sent back to the client along with the IO result.
The procedure is the default behaviour of the driver. This invalidation and
registration on each IO causes performance drop of up to 20%. A user of the
driver may choose to load the modules with this mechanism switched off
(always_invalidate=N), if he understands and can take the risk of a malicious 
client being able to corrupt memory of a server it is connected to. This might
be a reasonable option in a scenario where all the clients and all the servers
are located within a secure datacenter.

Huge thanks to Bart van Assche for the very detailed review of both RNBD and 
RTRS. These included suggestions for style fixes, better readability and 
documentation, code simplifications, eliminating usage of deprecated APIs,
too many to name.

The transport library and the network block device using it have been renamed to
RTRS and RNBD accordingly in order to reflect the fact that they are based on 
the rdma subsystem and not bound to InfiniBand only.

Fileio mode support in rnbd-server is not so efficent as pointed out by Bart,
and we can use loop device in between if there is need, hence we just
removed the fileio mode support.


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
   https://github.com/ionos-enterprise/ibnbd/commits/linux-5.5-rc2-ibnbd-v5
The out-of-tree modules are here:
   https://github.com/ionos-enterprise/ibnbd

LPC 2019 presentation:
  https://linuxplumbersconf.org/event/4/contributions/367/attachments/331/555/LPC_2019_RMDA_MC_IBNBD_IBTRS_Upstreaming.pdf

Performance results for the v5.5-rc1 kernel
  link: https://github.com/ionos-enterprise/ibnbd/tree/develop/performance/v5-v5.5-rc1

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
 drivers/block/rnbd/README                     |   80 +
 drivers/block/rnbd/rnbd-clt-sysfs.c           |  659 ++++
 drivers/block/rnbd/rnbd-clt.c                 | 1761 ++++++++++
 drivers/block/rnbd/rnbd-clt.h                 |  169 +
 drivers/block/rnbd/rnbd-common.c              |   43 +
 drivers/block/rnbd/rnbd-log.h                 |   61 +
 drivers/block/rnbd/rnbd-proto.h               |  325 ++
 drivers/block/rnbd/rnbd-srv-dev.c             |  162 +
 drivers/block/rnbd/rnbd-srv-dev.h             |  130 +
 drivers/block/rnbd/rnbd-srv-sysfs.c           |  234 ++
 drivers/block/rnbd/rnbd-srv.c                 |  882 +++++
 drivers/block/rnbd/rnbd-srv.h                 |   99 +
 drivers/infiniband/Kconfig                    |    1 +
 drivers/infiniband/ulp/Makefile               |    1 +
 drivers/infiniband/ulp/rtrs/Kconfig           |   27 +
 drivers/infiniband/ulp/rtrs/Makefile          |   17 +
 drivers/infiniband/ulp/rtrs/README            |  137 +
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c  |  453 +++
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  |  519 +++
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        | 2952 +++++++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-clt.h        |  314 ++
 drivers/infiniband/ulp/rtrs/rtrs-log.h        |   50 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h        |  426 +++
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c  |  109 +
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c  |  315 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c        | 2187 ++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-srv.h        |  159 +
 drivers/infiniband/ulp/rtrs/rtrs.c            |  646 ++++
 drivers/infiniband/ulp/rtrs/rtrs.h            |  334 ++
 fs/sysfs/file.c                               |    1 +
 40 files changed, 13811 insertions(+)
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

