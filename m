Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33ADF18CD8D
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 13:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgCTMRE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 08:17:04 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:34414 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgCTMRD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 08:17:03 -0400
Received: by mail-wm1-f50.google.com with SMTP id 26so2888422wmk.1
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hTiyZCtJ5yIwWcoiETL9tbss+sl/Qg8JKF1emRbYluI=;
        b=FkTr6Qg5djLomlTqWPuzl2X55o8C6pfm6ro6cV7/PTFAkKPGYUtLh1fXqOWto0x/me
         iZRyiaCpM3IWpsdzfnnxT6P9LHQXt2NpASco52rv0PgzoEeiQ/05XiLfOCgLnBJWVbTd
         gWz84kcNjeI03MtFjBU2wrUZ08d+wZhWgrh7e8CC3yUL+m1YR5xjgIhS8U0yVfNEpOmu
         PS9VeMyoRJbJRDKc8MHfrRMc4ZRKtlusbxWSpoWXQdhU9BbuVPPi3NDM6qywLaKSXd/R
         ZnV1sVanAWnma532K07VLnUZiaapIxQjkRxt3FvYqv/0usOJXR7HJqWmS0rFp1vgzHOE
         3xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hTiyZCtJ5yIwWcoiETL9tbss+sl/Qg8JKF1emRbYluI=;
        b=a/qGx+0LwhPBluyjylqlF/ZCvq6wC/W4hA1HIBuLFNvC/cg3/1BU6RiWhMJKg2J8xN
         70ECgKYnPQwcjQ1lwb46+2IL6WF42Q9uUG9WJ1HhmeT+XHV0WXtN+t0AWxLKdJVMKRgk
         XhVrj1cAGNRyuUiKoVGCaEt7jn5XiuRhhKrE4Nj/Zk7T/HczQNyN0Il2mjr+V4emh8iK
         YaBJoWLeikJY1Midv9D7wppTVGZQwyNIi7MK6K/VWdrG73Y1tMdAxGRYq76YPbRtFxq5
         QE3bapavO75s6GTbIsOhw0hxUk5nx69sm+QXVbKuKmoI6QvtymXfH5YVjX7fID8QAPmh
         4gAQ==
X-Gm-Message-State: ANhLgQ0z7Gbv1J77IJv5++Vhq9fw1Xw0+CpHDqIv9CA2KspSdhCfavIe
        emN4FbNVXQp2WLXDuw12crsqOQ==
X-Google-Smtp-Source: ADFU+vvK9QwNA6V3ApPrpl4MmF0f38BJYhmJHBtmTB/dvVcaa2wlhe7f6ZzR502y+dxi+EuST/idgQ==
X-Received: by 2002:a1c:6745:: with SMTP id b66mr9890542wmc.30.1584706620649;
        Fri, 20 Mar 2020 05:17:00 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:16:59 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v11 00/26] RTRS (former IBTRS) RDMA Transport Library and RNBD (former IBNBD) RDMA Network Block Device
Date:   Fri, 20 Mar 2020 13:16:31 +0100
Message-Id: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,
Here is v11 of  the RTRS (former IBTRS) RDMA Transport Library and the
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
   https://github.com/ionos-enterprise/ibnbd/commits/linux-5.6-rc6-ibnbd-v11

Testing
-------

All the changes have been tested with our regression testsuite in our staging environment
in IONOS data center. it's around 200 testcases, for both always_invalidate=N and
always_invalidate=Y configurations.

Changelog
---------
v11:
 o Rebased to linux-5.6-rc6
 o rtrs-clt: use rcu_dereference_protected to avoid warning suggested by Jason
 o rtrs-clt: get rid of the second cancel_delayed_work_sync(reconnect_work) call
 suggested by Jason
 o rtrs-clt: remove unneeded synchronize_rcu suggested by Jason
 o rtrs-clt: removing the opened flag suggested by Jason
 o rtrs-clt: postpone uevent until sysfs is created suggested by Jason
 o rtrs-srv: postpone uevent until sysfs is created.
 o rtrs: remove unnecessary module_get/put call suggested by Jason
 o rtrs-clt: fix up error path in alloc_clt() reported by Jason
 o rtrs: move kdocs to .c files suggested by Jason and Bart
 o rtrs/rnbd: remove print during load/unload module reported by Jason
 o rtrs/rnbd: add missing mutex_destroy
 o rtrs: cleanup dead code
 o rtrs-srv: fix error handling
 o other misc cleanup

v10:
 o Rebased to linux-5.6-rc5
 o Collect Reviewed-by from Bart
 o Update description in Kconfig for RNBD
 o Address comments from Bart for naming/typo/comments/etc
 o removal of rnbd_bio_map_kern by reexporting bio_map_kern suggested by Bart
 o kill some inline wrappers suggested by Bart
 o rtrs: use mutex more consistently reported by Leon
 o rtrs/rnbd: remove prints for allocation failure suggested by Leon
 o rtrs/rnbd: avoid typedefs for function callbacks suggested by Leon
 o rtrs-srv: handle sq_full situation suggested by Jason
 o rtrs-clt: remove useless get_cpu()/put_cpu() in __rtrs_get_permit suggested
 by Jason and Bart.
 o rtrs-srv: inline rtrs_srv_update_rdma_stats
 o other minor cleanup
 * https://lore.kernel.org/linux-block/20200311161240.30190-1-jinpu.wang@cloud.ionos.com/
v9:
 o Rebased to linux-5.6-rc2
 o Update Date/Kernel version in Documentation
 o Update description in Kconfig for RNBD
 o rtrs-clt: inline rtrs_clt_decrease_inflight
 o rtrs-clt: only track inflight for Min_inflight policy
 * https://lore.kernel.org/linux-block/20200221104721.350-1-jinpuwang@gmail.com/
v8:
 o Rebased to linux-5.5-rc7
 o Reviewed likey/unlikely usage, only keep the one in IO path suggested by Leon Romanovsky
 o Reviewed inline usage, remove inline for functions longer than 5 lines of code suggested by Leon
 o Removed 2 WARN_ON suggested by Leon
 o Removed 2 empty lines between copyright suggested by Leon
 o Makefile: remove compat include for upstream suggested by Leon
 o rtrs-clt: remove module parameters suggested by Leon
 o drop rnbd_clt_dev_is_mapped
 o rnbd-clt: clean up rnbd_rerun_if_needed
 o rtrs-srv: remove reset_all sysfs
 o rtrs stats: remove wc_completion stats
 o rtrs-clt: enhance doc for rtrs_clt_change_state
 o rtrs-clt: remove unused rtrs_permit_from_pdu
 * https://lore.kernel.org/linux-block/20200124204753.13154-1-jinpuwang@gmail.com/
v7:
 o Rebased to linux-5.5-rc6
 o Implement code-style/readability/API/Documentation etc suggestions by Bart van Assche
 o Make W=1 clean
 o New benchmark results for Mellanox ConnectX-5
 o second try adding MAINTAINERS entries in alphabetical order as Gal Pressman suggested
 * https://lore.kernel.org/linux-block/20200116125915.14815-1-jinpuwang@gmail.com/
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

As always, please review, share your comments, and consider to merge to
upstream.

Thanks.


Jack Wang (26):
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
  block: reexport bio_map_kern
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
 .../ABI/testing/sysfs-class-rtrs-client       |  131 +
 .../ABI/testing/sysfs-class-rtrs-server       |   53 +
 MAINTAINERS                                   |   14 +
 block/bio.c                                   |    1 +
 drivers/block/Kconfig                         |    2 +
 drivers/block/Makefile                        |    1 +
 drivers/block/rnbd/Kconfig                    |   28 +
 drivers/block/rnbd/Makefile                   |   15 +
 drivers/block/rnbd/README                     |   92 +
 drivers/block/rnbd/rnbd-clt-sysfs.c           |  619 ++++
 drivers/block/rnbd/rnbd-clt.c                 | 1729 ++++++++++
 drivers/block/rnbd/rnbd-clt.h                 |  148 +
 drivers/block/rnbd/rnbd-common.c              |   23 +
 drivers/block/rnbd/rnbd-log.h                 |   41 +
 drivers/block/rnbd/rnbd-proto.h               |  305 ++
 drivers/block/rnbd/rnbd-srv-dev.c             |   94 +
 drivers/block/rnbd/rnbd-srv-dev.h             |   88 +
 drivers/block/rnbd/rnbd-srv-sysfs.c           |  211 ++
 drivers/block/rnbd/rnbd-srv.c                 |  852 +++++
 drivers/block/rnbd/rnbd-srv.h                 |   77 +
 drivers/infiniband/Kconfig                    |    1 +
 drivers/infiniband/ulp/Makefile               |    1 +
 drivers/infiniband/ulp/rtrs/Kconfig           |   27 +
 drivers/infiniband/ulp/rtrs/Makefile          |   15 +
 drivers/infiniband/ulp/rtrs/README            |  213 ++
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c  |  205 ++
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  |  480 +++
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        | 2963 +++++++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-clt.h        |  252 ++
 drivers/infiniband/ulp/rtrs/rtrs-log.h        |   28 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h        |  399 +++
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c  |   40 +
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c  |  298 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c        | 2146 ++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-srv.h        |  147 +
 drivers/infiniband/ulp/rtrs/rtrs.c            |  610 ++++
 drivers/infiniband/ulp/rtrs/rtrs.h            |  193 ++
 fs/sysfs/file.c                               |    1 +
 41 files changed, 12750 insertions(+)
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

