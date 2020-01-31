Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E067014F0E0
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jan 2020 17:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgAaQu6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jan 2020 11:50:58 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37248 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgAaQu5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jan 2020 11:50:57 -0500
Received: by mail-il1-f196.google.com with SMTP id v13so6711354iln.4
        for <linux-rdma@vger.kernel.org>; Fri, 31 Jan 2020 08:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouv9Ei7cQCWlp/5mqOSR5pCysmB5qjKiWtdzEsukZwY=;
        b=Or9Y2bCF+6dZQczeBLkYnSHXqjrvtq1yHVEl+6vyyCijiYxXMoJPuEm/1liupmU8g5
         9SLWGnv/anhXYBElTk8WqevbgBrF6MAoqN4Xff/rmwNYhffa7G6fr/dRI11TEqVWJthG
         D5J0SuD20YvwWELclZPF3ue2GPHsvP45Cz1DwlN0796WnzjuA5TK9/iKzP/aNQX4qnBs
         E3v75m/Jr6Ei6b7KAEdXJW0EHp0V3/+kbViq0vxont1aB7zIUyX/0yHePujkG7zCZEqA
         L9q7rCWXJ6LIH8/6qsBQBH6C1O5pYtHKjRXYEc6KaVPGqyjKPlmatAj8Ciqc8tdeM0j5
         De6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouv9Ei7cQCWlp/5mqOSR5pCysmB5qjKiWtdzEsukZwY=;
        b=gT7I86xL3TNkjHTqZsnb+c0GtPzwwcaMSX40hOc8w8Mbja/LXjO6Md8J0oCW2wY1mY
         om51GeM9YPIQKlcCI+w0NxwKIj4rcABkR0tcpKfDOn+5fSz/9JIndbVwzgJw4b6ROIVb
         cxLH/PrVQf9aR0sLPIRtoO0VmzwYY8ofRV6dJ8ImsC1WONjGUuXrt05NYmqZFp0NuK+Z
         iCpXedFl3/riESsEYTBqUHN6mEtecE8lLgOVEPJr+9rkNqAal7YXRDvmqy1f7/11ndMy
         /E43IplD/TThZ+Yb0BKvuhY8K/7JSHG2YLCLrPbdJEzL2U8DBd4v4MKuh4SyT748uG/J
         w1RQ==
X-Gm-Message-State: APjAAAXrzNA3ZeQpdVVCiFsoejB6WyaTeNsHYEs2S40yqmfBm5SDU7E1
        bKYf4E1CBfRBwPmQ8uO7Kywvge16A4bTM7xEqpSn
X-Google-Smtp-Source: APXvYqzjZMdskwjC6XhIGpJhCkZAUmEi3K5gZfDg+0A+Cp2c0hDQsteN+7lsX5hUlFfkMt+stUw/BhQokR7D1G781H8=
X-Received: by 2002:a92:15c2:: with SMTP id 63mr3559360ilv.111.1580489455494;
 Fri, 31 Jan 2020 08:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20200124204753.13154-1-jinpuwang@gmail.com>
In-Reply-To: <20200124204753.13154-1-jinpuwang@gmail.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 31 Jan 2020 17:50:44 +0100
Message-ID: <CAHg0HuzLLHqp_76ThLhUdHGG_986Oxvvr15h_13T12eEWjyAxA@mail.gmail.com>
Subject: Re: [PATCH v8 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Doug, Hi Jason, Hi Jens, Hi All,

since we didn't get any new comments for the V8 prepared by Jack a
week ago do you think rnbd/rtrs could be merged in the current merge
window?

Best Regards,
Danil

On Fri, Jan 24, 2020 at 9:47 PM Jack Wang <jinpuwang@gmail.com> wrote:
>
> Hi all,
>
> Here is v8 of  the RTRS (former IBTRS) RDMA Transport Library and the
> corresponding RNBD (former IBNBD) RDMA Network Block Device, which includes
> changes to address comments from the community.
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
>    https://github.com/ionos-enterprise/ibnbd/commits/linux-5.5-rc6-ibnbd-v7
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
> v8:
>  o Rebased to linux-5.5-rc7
>  o Reviewed likey/unlikely usage, only keep the one in IO path suggested by Leon Romanovsky
>  o Reviewed inline usage, remove inline for functions longer than 5 lines of code suggested by Leon
>  o Removed 2 WARN_ON suggested by Leon
>  o Removed 2 empty lines between copyright suggested by Leon
>  o Makefile: remove compat include for upstream suggested by Leon
>  o rtrs-clt: remove module paramters suggested by Leon
>  o drop rnbd_clt_dev_is_mapped
>  o rnbd-clt: clean up rnbd_rerun_if_needed
>  o rtrs-srv: remove reset_all sysfs
>  o rtrs stats: remove wc_completion stats
>  o rtrs-clt: enhance doc for rtrs_clt_change_state
>  o rtrs-clt: remove unused rtrs_permit_from_pdu
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
> As always, please review and share your comments, and consider to merge to
> upstream.
>
> Thanks!
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
>   block/rnbd: server: functionality for IO submission to file or block
>     dev
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
>  drivers/block/rnbd/rnbd-clt-sysfs.c           |  619 ++++
>  drivers/block/rnbd/rnbd-clt.c                 | 1721 ++++++++++
>  drivers/block/rnbd/rnbd-clt.h                 |  148 +
>  drivers/block/rnbd/rnbd-common.c              |   23 +
>  drivers/block/rnbd/rnbd-log.h                 |   41 +
>  drivers/block/rnbd/rnbd-proto.h               |  305 ++
>  drivers/block/rnbd/rnbd-srv-dev.c             |  142 +
>  drivers/block/rnbd/rnbd-srv-dev.h             |  110 +
>  drivers/block/rnbd/rnbd-srv-sysfs.c           |  211 ++
>  drivers/block/rnbd/rnbd-srv.c                 |  862 +++++
>  drivers/block/rnbd/rnbd-srv.h                 |   79 +
>  drivers/infiniband/Kconfig                    |    1 +
>  drivers/infiniband/ulp/Makefile               |    1 +
>  drivers/infiniband/ulp/rtrs/Kconfig           |   27 +
>  drivers/infiniband/ulp/rtrs/Makefile          |   15 +
>  drivers/infiniband/ulp/rtrs/README            |  213 ++
>  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c  |  209 ++
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  |  480 +++
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c        | 2929 +++++++++++++++++
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h        |  247 ++
>  drivers/infiniband/ulp/rtrs/rtrs-log.h        |   28 +
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h        |  401 +++
>  drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c  |   47 +
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c  |  285 ++
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c        | 2164 ++++++++++++
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h        |  138 +
>  drivers/infiniband/ulp/rtrs/rtrs.c            |  594 ++++
>  drivers/infiniband/ulp/rtrs/rtrs.h            |  310 ++
>  fs/sysfs/file.c                               |    1 +
>  40 files changed, 12894 insertions(+)
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
> 2.17.1
>
