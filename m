Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB1E1D4AF1
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2020 12:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgEOK3T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 May 2020 06:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgEOK3R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 May 2020 06:29:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6E5C061A0C
        for <linux-rdma@vger.kernel.org>; Fri, 15 May 2020 03:29:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h4so1777083wmb.4
        for <linux-rdma@vger.kernel.org>; Fri, 15 May 2020 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0x9+knLiqpCTsDrq30I7RwfFkdV3eQc0B6+GYjs7Jmg=;
        b=EPHxTpEcq1xF61CEZKbLPW6rKUUXyu2mb5zG5hi0ideumG8DOTLs/95flWMNfMA/27
         NKw67kUItFM+85NTBEhrAdjtpV79gijlbYU9t4gtf6DaY2QfWP9ZDjeS6oyYlUatLKW5
         1AJ/bTrpXpPjx/XoJCzo7TPLMuwGGPPBIcbKY/J+cd4CfZJrx5gyflRkGQ4JkDzgiT3Y
         EiDMBCwrQONFL0MKkF1wWozVfe0EsxceDWVZNgmWRoz0OVGCdhksfYuVz3pRxUfiH8Oq
         9e5nPfSxzc/T8EW/SBhfY8W+HRcNBMU4/hYwA4MtKXoxQBL4QPxaGvDNH67i7WVBFaPq
         tXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0x9+knLiqpCTsDrq30I7RwfFkdV3eQc0B6+GYjs7Jmg=;
        b=k2C30fgdXd/81Hn1q7Y6vzrpubb5/Rk3nM24CGkN7t3PZ3ggEqoNQHnW6qUcfIy7I8
         4cSEkU89gH9zEhMPmJeUFG4+sCXcixl9ubG172O66L9cbEIhm57TsDD8vejPPyHYLNxs
         +IAYmFZKkNbx3SQhUODcWu5Ow4Cm6aLuJLtnwJOnXgyM5bhxrPQkuER1XmKYQbIwJG3E
         E6RdgDA8GKqhzUq6ovgBl2MIq3MK35/bCLaCcrBAdzWSJ0HF1ftdefBxianeQvieeqyC
         8Br/AEoZtxXf8tlsl4xM73Ghhjv++zaeA9n9OqqOEMfzc4ILNKj30yF/ldCZH18bZYPG
         /BAQ==
X-Gm-Message-State: AOAM532Uhty1LIqLEZnHewbDJ/Duh7RS6zrzYpJDKh0Hp3C0MW5qR0sz
        PIVKIiGUp5XGl5L7riGyQyprwgkp7RFC/8PSrb85
X-Google-Smtp-Source: ABdhPJxtSegfbbAyIYFLHuzyaE2TUcTzrtVw+W5NyO60RjODJu/5eGUR0pDt3Bk/zy8H613qQwM6NUD1qsj5Iw7z+jo=
X-Received: by 2002:a1c:5402:: with SMTP id i2mr3498718wmb.185.1589538555760;
 Fri, 15 May 2020 03:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
In-Reply-To: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 15 May 2020 12:29:04 +0200
Message-ID: <CAHg0HuyYO913MmHt7qi12T6mVXo9nabUs6GJyqRAGfWAdfPjCQ@mail.gmail.com>
Subject: Re: [PATCH v15 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jens,

we've fixed the kbuild cross-compile problem identified for our
patches for 5.7-rc4. The block part has been reviewed by Bart van
Assche (thanks a lot Bart), we also replaced idr by xarray there as
Jason suggested. You planned to queue us
for 5.7: https://www.spinics.net/lists/linux-rdma/msg88472.html. Could
you please give Jason an OK to take this through the rdma tree, see
https://www.spinics.net/lists/linux-rdma/msg91400.html?

Thank you,
Danil.


On Mon, May 11, 2020 at 3:53 PM Danil Kipnis
<danil.kipnis@cloud.ionos.com> wrote:
>
> Hi all,
>
> Here is v15 of the RTRS (former IBTRS) RDMA Transport Library and the
> corresponding RNBD (former IBNBD) RDMA Network Block Device, which
> fixes the issues in Makefile in V14 reported-by
> the kbuild test robot (see changelog below). The patchset applies for
> kernel v5.7-rc5.
>
> Introduction
> -------------
>
> RTRS (RDMA Transport) is a reliable high speed transport library
> which allows for establishing connection between client and server
> machines via RDMA. It is based on RDMA-CM, so expect also to support RoCE
> and iWARP, but we mainly tested in IB environment. It is optimized to
> transfer (read/write) IO blocks in the sense that it follows the BIO
> semantics of providing the possibility to either write data from a
> scatter-gather list to the remote side or to request ("read") data
> transfer from the remote side into a given set of buffers.
>
> RTRS is multipath capable and provides I/O fail-over and load-balancing
> functionality, i.e. in RTRS terminology, an RTRS path is a set of RDMA
> connections and particular path is selected according to the load-balancing
> policy. It can be used for other components beside RNBD.
>
> Module parameter always_invalidate is introduced for the security problem
> discussed in LPC RDMA MC 2019. When always_invalidate=Y, on the server side we
> invalidate each rdma buffer before we hand it over to RNBD server and
> then pass it to the block layer. A new rkey is generated and registered for the
> buffer after it returns back from the block layer and RNBD server.
> The new rkey is sent back to the client along with the IO result.
> The procedure is the default behaviour of the driver. This invalidation and
> registration on each IO causes performance drop of up to 20%. A user of the
> driver may choose to load the modules with this mechanism switched off
> (always_invalidate=N), if he understands and can take the risk of a malicious
> client being able to corrupt memory of a server it is connected to. This might
> be a reasonable option in a scenario where all the clients and all the servers
> are located within a secure datacenter.
>
> RNBD (RDMA Network Block Device) is a pair of kernel modules
> (client and server) that allow for remote access of a block device on
> the server over RTRS protocol. After being mapped, the remote block
> devices can be accessed on the client side as local block devices.
> Internally RNBD uses RTRS as an RDMA transport library.
>
> Commits for kernel can be found here:
>    https://github.com/ionos-enterprise/ibnbd/commits/linux-5.7-rc5-ibnbd-v15
>
> Testing
> -------
>
> All the changes have been tested with our regression testsuite in our staging environment
> in IONOS data center. it's around 200 testcases, for both always_invalidate=N and
> always_invalidate=Y configurations.
>
> Changelog
> ---------
> V15:
>  o Fix include statement in Makefile reported-by: kbuild test robot <lkp@intel.com>. Use  $(srctree) as suggested by Leon
>  o Fix resource deallocation order for rtrs_clt_stats
>  o Rebase to kernel 5.7-rc5
> v14:
>  o Fix ordering in Makefile as suggested by Jason Gunthorpe
>  o Switch from idr to xarray as suggested by Jason Gunthorpe
>  o Fix multiple issues Reported-by: kbuild test robot <lkp@intel.com>
>   (https://www.spinics.net/lists/linux-rdma/msg91406.html)
>  o Rebase to kernel 5.7-rc4
>  * https://lore.kernel.org/linux-block/20200504140115.15533-1-danil.kipnis@cloud.ionos.com/
> v13:
>  o Rebased to linux-5.7-rc3
>  o Reviewed-by Bart van Assche added to the block part
>  * https://lore.kernel.org/linux-block/20200427141020.655-1-danil.kipnis@cloud.ionos.com/
> v12:
>  o Rebased to linux-5.7-rc1
>  o rtrs/rnbd: add release call back for kobject suggested by Bart & Jason
>  o rtrs-clt: drop reexport bio_map_kern, open-code it using bio_add_page
>  suggested by Christoph
>  o rnbd-srv: replace rwlock with RCU.
>  o rnbd-srv: get rid of sysfs_release_compl suggested by Bart.
>  o rnbd-clt: add a option to specify the destination port in map_device operation
>  suggested by Bart.
>  o rnbd-srv: remove io_cb use rnbd_endio directly
>  o Address other comments from Bart for naming/typo/comments/coding style/etc
>  * https://lore.kernel.org/linux-block/20200415092045.4729-1-danil.kipnis@cloud.ionos.com/
> v11:
>  o Rebased to linux-5.6-rc6
>  o rtrs-clt: use rcu_dereference_protected to avoid warning suggested by Jason
>  o rtrs-clt: get rid of the second cancel_delayed_work_sync(reconnect_work) call
>  suggested by Jason
>  o rtrs-clt: remove unneeded synchronize_rcu suggested by Jason
>  o rtrs-clt: removing the opened flag suggested by Jason
>  o rtrs-clt: postpone uevent until sysfs is created suggested by Jason
>  o rtrs-srv: postpone uevent until sysfs is created.
>  o rtrs: remove unnecessary module_get/put call suggested by Jason
>  o rtrs-clt: fix up error path in alloc_clt() reported by Jason
>  o rtrs: move kdocs to .c files suggested by Jason and Bart
>  o rtrs/rnbd: remove print during load/unload module reported by Jason
>  o rtrs/rnbd: add missing mutex_destroy
>  o rtrs: cleanup dead code
>  o rtrs-srv: fix error handling
>  o other misc cleanup
>  * https://lore.kernel.org/linux-block/20200320121657.1165-1-jinpu.wang@cloud.ionos.com/
> v10:
>  o Rebased to linux-5.6-rc5
>  o Collect Reviewed-by from Bart
>  o Update description in Kconfig for RNBD
>  o Address comments from Bart for naming/typo/comments/etc
>  o removal of rnbd_bio_map_kern by reexporting bio_map_kern suggested by Bart
>  o kill some inline wrappers suggested by Bart
>  o rtrs: use mutex more consistently reported by Leon
>  o rtrs/rnbd: remove prints for allocation failure suggested by Leon
>  o rtrs/rnbd: avoid typedefs for function callbacks suggested by Leon
>  o rtrs-srv: handle sq_full situation suggested by Jason
>  o rtrs-clt: remove useless get_cpu()/put_cpu() in __rtrs_get_permit suggested
>  by Jason and Bart.
>  o rtrs-srv: inline rtrs_srv_update_rdma_stats
>  o other minor cleanup
>  * https://lore.kernel.org/linux-block/20200311161240.30190-1-jinpu.wang@cloud.ionos.com/
> v9:
>  o Rebased to linux-5.6-rc2
>  o Update Date/Kernel version in Documentation
>  o Update description in Kconfig for RNBD
>  o rtrs-clt: inline rtrs_clt_decrease_inflight
>  o rtrs-clt: only track inflight for Min_inflight policy
>  * https://lore.kernel.org/linux-block/20200221104721.350-1-jinpuwang@gmail.com/
> v8:
>  o Rebased to linux-5.5-rc7
>  o Reviewed likey/unlikely usage, only keep the one in IO path suggested by Leon Romanovsky
>  o Reviewed inline usage, remove inline for functions longer than 5 lines of code suggested by Leon
>  o Removed 2 WARN_ON suggested by Leon
>  o Removed 2 empty lines between copyright suggested by Leon
>  o Makefile: remove compat include for upstream suggested by Leon
>  o rtrs-clt: remove module parameters suggested by Leon
>  o drop rnbd_clt_dev_is_mapped
>  o rnbd-clt: clean up rnbd_rerun_if_needed
>  o rtrs-srv: remove reset_all sysfs
>  o rtrs stats: remove wc_completion stats
>  o rtrs-clt: enhance doc for rtrs_clt_change_state
>  o rtrs-clt: remove unused rtrs_permit_from_pdu
>  * https://lore.kernel.org/linux-block/20200124204753.13154-1-jinpuwang@gmail.com/
> v7:
>  o Rebased to linux-5.5-rc6
>  o Implement code-style/readability/API/Documentation etc suggestions by Bart van Assche
>  o Make W=1 clean
>  o New benchmark results for Mellanox ConnectX-5
>  o second try adding MAINTAINERS entries in alphabetical order as Gal Pressman suggested
>  * https://lore.kernel.org/linux-block/20200116125915.14815-1-jinpuwang@gmail.com/
> v6:
>   o Rebased to linux-5.5-rc4
>   o Fix typo in my email address in first patch
>   o Cleanup copyright as suggested by Leon Romanovsky
>   o Remove 2 redudant kobject_del in error path as suggested by Leon Romanovsky
>   o Add MAINTAINERS entries in alphabetical order as Gal Pressman suggested
>   * https://lore.kernel.org/linux-block/20191230102942.18395-1-jinpuwang@gmail.com/
> v5:
>   o Fix the security problem pointed out by Jason
>   o Implement code-style/readability/API/etc suggestions by Bart van Assche
>   o Rename IBTRS and IBNBD to RTRS and RNBD accordingly
>   o Fileio mode support in rnbd-srv has been removed.
>   * https://lore.kernel.org/linux-block/20191220155109.8959-1-jinpuwang@gmail.com/
> v4:
>   o Protocol extended to transport IO priorities
>   o Support for Mellanox ConnectX-4/X-5
>   o Minor sysfs extentions (display access mode on server side)
>   o Bug fixes: cleaning up sysfs folders, race on deallocation of resources
>   o Style fixes
>   * https://lore.kernel.org/linux-block/20190620150337.7847-1-jinpuwang@gmail.com/
> v3:
>   o Sparse fixes:
>      - le32 -> le16 conversion
>      - pcpu and RCU wrong declaration
>      - sysfs: dynamically alloc array of sockaddr structures to reduce
>            size of a stack frame
>   o Rename sysfs folder on client and server sides to show source and
>     destination addresses of the connection, i.e.:
>            .../<session-name>/paths/<src@dst>/
>   o Remove external inclusions from Makefiles.
>   * https://lore.kernel.org/linux-block/20180606152515.25807-1-roman.penyaev@profitbricks.com/
> v2:
>   o IBNBD:
>      - No legacy request IO mode, only MQ is left.
>   o IBTRS:
>      - No FMR registration, only FR is left.
>   * https://lore.kernel.org/linux-block/20180518130413.16997-1-roman.penyaev@profitbricks.com/
> v1:
>   o IBTRS: load-balancing and IO fail-over using multipath features were added.
>   o Major parts of the code were rewritten, simplified and overall code
>     size was reduced by a quarter.
>   * https://lore.kernel.org/linux-block/20180202140904.2017-1-roman.penyaev@profitbricks.com/
> v0:
>   o Initial submission
>   * https://lore.kernel.org/linux-block/1490352343-20075-1-git-send-email-jinpu.wangl@profitbricks.com/
>
> As always, please review, share your comments, and consider to merge to
> upstream.
>
> Thanks.
>
> Jack Wang (25):
>   sysfs: export sysfs_remove_file_self()
>   RDMA/rtrs: public interface header to establish RDMA connections
>   RDMA/rtrs: private headers with rtrs protocol structs and helpers
>   RDMA/rtrs: core: lib functions shared between client and server
>     modules
>   RDMA/rtrs: client: private header with client structs and functions
>   RDMA/rtrs: client: main functionality
>   RDMA/rtrs: client: statistics functions
>   RDMA/rtrs: client: sysfs interface functions
>   RDMA/rtrs: server: private header with server structs and functions
>   RDMA/rtrs: server: main functionality
>   RDMA/rtrs: server: statistics functions
>   RDMA/rtrs: server: sysfs interface functions
>   RDMA/rtrs: include client and server modules into kernel compilation
>   RDMA/rtrs: a bit of documentation
>   block/rnbd: private headers with rnbd protocol structs and helpers
>   block/rnbd: client: private header with client structs and functions
>   block/rnbd: client: main functionality
>   block/rnbd: client: sysfs interface functions
>   block/rnbd: server: private header with server structs and functions
>   block/rnbd: server: main functionality
>   block/rnbd: server: functionality for IO submitting to block dev
>   block/rnbd: server: sysfs interface functions
>   block/rnbd: include client and server modules into kernel compilation
>   block/rnbd: a bit of documentation
>   MAINTAINERS: Add maintainers for RNBD/RTRS modules
>
>  Documentation/ABI/testing/sysfs-block-rnbd    |   46 +
>  .../ABI/testing/sysfs-class-rnbd-client       |  111 +
>  .../ABI/testing/sysfs-class-rnbd-server       |   50 +
>  .../ABI/testing/sysfs-class-rtrs-client       |  131 +
>  .../ABI/testing/sysfs-class-rtrs-server       |   53 +
>  MAINTAINERS                                   |   14 +
>  drivers/block/Kconfig                         |    2 +
>  drivers/block/Makefile                        |    1 +
>  drivers/block/rnbd/Kconfig                    |   28 +
>  drivers/block/rnbd/Makefile                   |   15 +
>  drivers/block/rnbd/README                     |   92 +
>  drivers/block/rnbd/rnbd-clt-sysfs.c           |  636 ++++
>  drivers/block/rnbd/rnbd-clt.c                 | 1729 ++++++++++
>  drivers/block/rnbd/rnbd-clt.h                 |  156 +
>  drivers/block/rnbd/rnbd-common.c              |   23 +
>  drivers/block/rnbd/rnbd-log.h                 |   41 +
>  drivers/block/rnbd/rnbd-proto.h               |  303 ++
>  drivers/block/rnbd/rnbd-srv-dev.c             |  134 +
>  drivers/block/rnbd/rnbd-srv-dev.h             |   92 +
>  drivers/block/rnbd/rnbd-srv-sysfs.c           |  215 ++
>  drivers/block/rnbd/rnbd-srv.c                 |  844 +++++
>  drivers/block/rnbd/rnbd-srv.h                 |   78 +
>  drivers/infiniband/Kconfig                    |    1 +
>  drivers/infiniband/ulp/Makefile               |    1 +
>  drivers/infiniband/ulp/rtrs/Kconfig           |   27 +
>  drivers/infiniband/ulp/rtrs/Makefile          |   15 +
>  drivers/infiniband/ulp/rtrs/README            |  213 ++
>  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c  |  200 ++
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  |  483 +++
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c        | 2994 +++++++++++++++++
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h        |  251 ++
>  drivers/infiniband/ulp/rtrs/rtrs-log.h        |   28 +
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h        |  399 +++
>  drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c  |   38 +
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c  |  320 ++
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c        | 2175 ++++++++++++
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h        |  148 +
>  drivers/infiniband/ulp/rtrs/rtrs.c            |  612 ++++
>  drivers/infiniband/ulp/rtrs/rtrs.h            |  195 ++
>  fs/sysfs/file.c                               |    1 +
>  40 files changed, 12895 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-block-rnbd
>  create mode 100644 Documentation/ABI/testing/sysfs-class-rnbd-client
>  create mode 100644 Documentation/ABI/testing/sysfs-class-rnbd-server
>  create mode 100644 Documentation/ABI/testing/sysfs-class-rtrs-client
>  create mode 100644 Documentation/ABI/testing/sysfs-class-rtrs-server
>  create mode 100644 drivers/block/rnbd/Kconfig
>  create mode 100644 drivers/block/rnbd/Makefile
>  create mode 100644 drivers/block/rnbd/README
>  create mode 100644 drivers/block/rnbd/rnbd-clt-sysfs.c
>  create mode 100644 drivers/block/rnbd/rnbd-clt.c
>  create mode 100644 drivers/block/rnbd/rnbd-clt.h
>  create mode 100644 drivers/block/rnbd/rnbd-common.c
>  create mode 100644 drivers/block/rnbd/rnbd-log.h
>  create mode 100644 drivers/block/rnbd/rnbd-proto.h
>  create mode 100644 drivers/block/rnbd/rnbd-srv-dev.c
>  create mode 100644 drivers/block/rnbd/rnbd-srv-dev.h
>  create mode 100644 drivers/block/rnbd/rnbd-srv-sysfs.c
>  create mode 100644 drivers/block/rnbd/rnbd-srv.c
>  create mode 100644 drivers/block/rnbd/rnbd-srv.h
>  create mode 100644 drivers/infiniband/ulp/rtrs/Kconfig
>  create mode 100644 drivers/infiniband/ulp/rtrs/Makefile
>  create mode 100644 drivers/infiniband/ulp/rtrs/README
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.c
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.h
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-log.h
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-pri.h
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.c
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.h
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.c
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.h
>
> --
> 2.20.1
>
