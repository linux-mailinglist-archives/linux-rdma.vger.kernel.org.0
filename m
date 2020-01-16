Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B233613DAC1
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 14:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgAPM7V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 07:59:21 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:37499 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAPM7U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 07:59:20 -0500
Received: by mail-ed1-f45.google.com with SMTP id cy15so18848134edb.4;
        Thu, 16 Jan 2020 04:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GYgjziMLeHgdGGA83ma0tZliePuxdHHV9DFvcy1rYCI=;
        b=epBzLunJ5cTClr0Xr220YiSNz9zg0Cw3Da6Nz5JC/Ys9ZBsOMrWvCrqJIzr0aPci6d
         lLyBTSFCDHXZmZzRqxzs7/wIVSgAmqvCdPCUJ7bop/3fn2vzSCv5tuWxn/noIS+X9Spw
         nyawT6n0bS8cVmP6fgrcYSjbxs/688nURFnBsgu+/IxaTX5JBg1RTpiedbnj0JNbI8zU
         JPGLkbO5Caz1Ei4mWUV3hgjvsLpbpnW5pUzMP1CjidJi3C9Yqy5r18+ioj4+z0d94Nxf
         yiw2gJoMwh8RUs4RD6v7IxUkijBSkPHdw32E5fR3HrnEEy+2Wi0oy00oEOwHVTclxKJP
         ca2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GYgjziMLeHgdGGA83ma0tZliePuxdHHV9DFvcy1rYCI=;
        b=EWPYfDxOzhDxWg/X3RtrmWFb78pN9PM7Jv67w6hR2JKzd/oiDlfCgMCHCzk8l+TVhH
         +HhmiVZzOCCUpG0i7Yz+iXq8omtJV5n1hUPt0S9iskYdYrwBkz1CUE02qv0dxGaMmiEn
         YfxvmYJT2FBFed764P2aycEb7wlUmRQRUhZK/Gv+d8z8YLCPZ9nbHJWOSDrtHFk1io4O
         Vm1uSpUlWIqIXUk4xlPUdzIIyMUE8xs+hat02Q+jIgRGcmJgYJvvHwH89nTl9rZcBfd8
         zjjw25wujp9dtXgMguhp6K+yEHRslBC7QwKQJx2zHcii7EiKOPYN1ZEblMPTT8cvcTYE
         kLJg==
X-Gm-Message-State: APjAAAWiJ5WVzz3uxwLCKy27EmRO623MOhaFkfW/fr+O8JWZETvuwFYI
        zxhHYhRa5/vBXljod52urqR8XgbA
X-Google-Smtp-Source: APXvYqwlcPzGV4/Nmso67pWw8CL2vrVtjU8gqKtwteBtivKrt4pRzajgzf7jBuEatSpzHy8pWD959Q==
X-Received: by 2002:a17:907:2179:: with SMTP id rl25mr2843455ejb.8.1579179557885;
        Thu, 16 Jan 2020 04:59:17 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4956:1800:d464:b0ea:3ef4:abbb])
        by smtp.gmail.com with ESMTPSA id b13sm697289ejl.5.2020.01.16.04.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:59:17 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v7 00/25] RTRS (former IBTRS) RDMA Transport Library and RNBD (former IBNBD) RDMA Network Block Device
Date:   Thu, 16 Jan 2020 13:58:50 +0100
Message-Id: <20200116125915.14815-1-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,
 
Here is v7 of  the RTRS (former IBTRS) RDMA Transport Library and the
corresponding RNBD (former IBNBD) RDMA Network Block Device, which includes
changes to address comments from the community.
 
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
connections and particular path is selected according to the load-balancing
policy. It can be used for other components beside RNBD.
 
Module parameter always_invalidate is introduced for the security problem
discussed in LPC RDMA MC 2019. When always_invalidate=Y, on the server side we
invalidate each rdma buffer before we hand it over to RNBD server and
then pass it to the block layer. A new rkey is generated and registered for the
buffer after it returns back from the block layer and RNBD server.
The new rkey is sent back to the client along with the IO result.
The procedure is the default behaviour of the driver. This invalidation and
registration on each IO causes performance drop of up to 20%. A user of the
driver may choose to load the modules with this mechanism switched off
(always_invalidate=N), if he understands and can take the risk of a malicious
client being able to corrupt memory of a server it is connected to. This might
be a reasonable option in a scenario where all the clients and all the servers
are located within a secure datacenter.
 
RNBD (RDMA Network Block Device) is a pair of kernel modules
(client and server) that allow for remote access of a block device on
the server over RTRS protocol. After being mapped, the remote block
devices can be accessed on the client side as local block devices.
Internally RNBD uses RTRS as an RDMA transport library.
 
Commits for kernel can be found here:
   https://github.com/ionos-enterprise/ibnbd/commits/linux-5.5-rc6-ibnbd-v7
The out-of-tree modules are here:
   https://github.com/ionos-enterprise/ibnbd
 
Performance results for the v5.5-rc2 kernel (NVMeoF vs RNBD):
  link: https://github.com/ionos-enterprise/ibnbd/tree/develop/performance/v7-v5.5-rc2
The hardware configuration and fio profile are documented in the README, graphs are generated.
 
Testing
-------
 
All the changes have been tested with our regression testsuite in our staging environment
in IONOS data center. it's around 200 testcases, for both always_invalidate=N and
always_invalidate=Y configurations.
 
Changelog
---------
v7:
 o Rebased to linux-5.5-rc6
 o Implement code-style/readability/API/Documentation etc suggestions by Bart van Assche
 o Make W=1 clean
 o New benchmark results for Mellanox ConnectX-5
 o second try adding MAINTAINERS entries in alphabetical order as Gal Pressman suggested
v6:
  o Rebased to linux-5.5-rc4
  o Fix typo in my email address in first patch
  o Cleanup copyright as suggested by Leon Romanovsky
  o Remove 2 redudant kobject_del in error path as suggested by Leon Romanovsky
  o Add MAINTAINERS entries in alphabetical order as Gal Pressman suggested
  * https://lore.kernel.org/linux-block/20191230102942.18395-1-jinpuwang@gmail.com/
v5:
  o Fix the security problem pointed out by Jason
  o Implement code-style/readability/API/etc suggestions by Bart van Assche
  o Rename IBTRS and IBNBD to RTRS and RNBD accordingly
  o Fileio mode support in rnbd-srv has been removed.
  * https://lore.kernel.org/linux-block/20191220155109.8959-1-jinpuwang@gmail.com/
v4:
  o Protocol extended to transport IO priorities
  o Support for Mellanox ConnectX-4/X-5
  o Minor sysfs extentions (display access mode on server side)
  o Bug fixes: cleaning up sysfs folders, race on deallocation of resources
  o Style fixes
  * https://lore.kernel.org/linux-block/20190620150337.7847-1-jinpuwang@gmail.com/
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
  * https://lore.kernel.org/linux-block/20180606152515.25807-1-roman.penyaev@profitbricks.com/
v2:
  o IBNBD:
     - No legacy request IO mode, only MQ is left.
  o IBTRS:
     - No FMR registration, only FR is left.
  * https://lore.kernel.org/linux-block/20180518130413.16997-1-roman.penyaev@profitbricks.com/
v1:
  o IBTRS: load-balancing and IO fail-over using multipath features were added.
  o Major parts of the code were rewritten, simplified and overall code
    size was reduced by a quarter.
  * https://lore.kernel.org/linux-block/20180202140904.2017-1-roman.penyaev@profitbricks.com/
v0:
  o Initial submission
  * https://lore.kernel.org/linux-block/1490352343-20075-1-git-send-email-jinpu.wangl@profitbricks.com/
 
As always, please review and share your comments, 
 
Thanks.

Jack Wang (25):
  sysfs: export sysfs_remove_file_self()
  RDMA/rtrs: public interface header to establish RDMA connections
  RDMA/rtrs: private headers with rtrs protocol structs and helpers
  RDMA/rtrs: core: lib functions shared between client and server
    modules
  RDMA/rtrs: client: private header with client structs and functions
  RDMA/rtrs: client: main functionality
  RDMA/rtrs: client: statistics functions
  RDMA/rtrs: client: sysfs interface functions
  RDMA/rtrs: server: private header with server structs and functions
  RDMA/rtrs: server: main functionality
  RDMA/rtrs: server: statistics functions
  RDMA/rtrs: server: sysfs interface functions
  RDMA/rtrs: include client and server modules into kernel compilation
  RDMA/rtrs: a bit of documentation
  block/rnbd: private headers with rnbd protocol structs and helpers
  block/rnbd: client: private header with client structs and functions
  block/rnbd: client: main functionality
  block/rnbd: client: sysfs interface functions
  block/rnbd: server: private header with server structs and functions
  block/rnbd: server: main functionality
  block/rnbd: server: functionality for IO submission to file or block
    dev
  block/rnbd: server: sysfs interface functions
  block/rnbd: include client and server modules into kernel compilation
  block/rnbd: a bit of documentation
  MAINTAINERS: Add maintainers for RNBD/RTRS modules

 Documentation/ABI/testing/sysfs-block-rnbd    |   46 +
 .../ABI/testing/sysfs-class-rnbd-client       |  111 +
 .../ABI/testing/sysfs-class-rnbd-server       |   50 +
 .../ABI/testing/sysfs-class-rtrs-client       |  156 +
 .../ABI/testing/sysfs-class-rtrs-server       |   71 +
 MAINTAINERS                                   |   14 +
 drivers/block/Kconfig                         |    2 +
 drivers/block/Makefile                        |    1 +
 drivers/block/rnbd/Kconfig                    |   28 +
 drivers/block/rnbd/Makefile                   |   17 +
 drivers/block/rnbd/README                     |   92 +
 drivers/block/rnbd/rnbd-clt-sysfs.c           |  621 ++++
 drivers/block/rnbd/rnbd-clt.c                 | 1730 ++++++++++
 drivers/block/rnbd/rnbd-clt.h                 |  150 +
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
 drivers/infiniband/ulp/rtrs/README            |  213 ++
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c  |  346 ++
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  |  492 +++
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        | 2967 +++++++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-clt.h        |  270 ++
 drivers/infiniband/ulp/rtrs/rtrs-log.h        |   30 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h        |  406 +++
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c  |   91 +
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c  |  297 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c        | 2170 ++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-srv.h        |  144 +
 drivers/infiniband/ulp/rtrs/rtrs.c            |  597 ++++
 drivers/infiniband/ulp/rtrs/rtrs.h            |  318 ++
 fs/sysfs/file.c                               |    1 +
 40 files changed, 13266 insertions(+)
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

