Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29E5633BA
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfGIJzP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 05:55:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36337 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfGIJzP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 05:55:15 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so26239685iom.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jul 2019 02:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g28ewgu3PEIy6WR2nZnTXXY+P5BVPY2YX8c512lYR/0=;
        b=g+JBpHsTTp4fibOxnPjhEV6bf/MWx3NAHwHQmAETUudxbqElhdV3rprUcijyZe4R7x
         2Pw2o602GpD08VEiSwx4XWdkFIjM3LAFMa3ML2KlpSCMx3Uj88i1MhYy73KOVlz6DlcU
         PYIy/WBBBtCHnMiufKHiLifWz784Fo0XlAwjWrONicMRh8bd1QRwfJ2PcSuvVzyuS6Bv
         sOSQfQMLym1O4xu9a/fbnBxjxgmcPdONigcOVvO6JZ5CXlM/CRzTxiVHaGZWumJnL5Cz
         mWRSWYI4EBBDBnYqpK4HbrweQdt6enBT45/+V8D4t/vdKOEs2b6LNhLcVW0bM+INtyox
         CKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g28ewgu3PEIy6WR2nZnTXXY+P5BVPY2YX8c512lYR/0=;
        b=nsQe/Ixvf4SuimQyCSfsgyI1jPbwanVMwe0wryB17qQuJF1h/ZOBBzIe9gxoMX/S58
         jkvjXr2Sv/StAGeJXcGvstlz6rj5jqcvc5NdbPLnoRhNE70/lHYElmr96Xr9B0CRKbDE
         OYYl8NLcDxWK/L0Ns1fBHCWrBoiNV8tF5nVkpBbRna9uWK0E2yL5AviRj7PqXpd9jF0V
         YaUX4gH94wiPOJlfSWMJduN7I4OyBrSyaTuQVVDngUOSn6ZpJk8e2jVQb+LbdZ6No1BP
         DjqIzJD0GbQRFAc7WbaH4jpDdzHwYALOBr86zUPnh6iWM4IEEDBikkxNPg8pRbzBRUWC
         urrg==
X-Gm-Message-State: APjAAAUf4QxsKuWyxATHtTBVCHvoTYJaIecFCGrVVEcACLbh0LDPa2hB
        AkkrA+5ufj09Cmign0j/t45iLNABtR0okKVpC5Uc
X-Google-Smtp-Source: APXvYqzct1/tIO3nEIHVmSQewosSGSjypfcnK7czUlJiGCmeSLkJeDaTsG8Le+jUXxZq5Pg5XTpO2Fxg2uQMZq5Zorc=
X-Received: by 2002:a6b:5b01:: with SMTP id v1mr19748790ioh.120.1562666114366;
 Tue, 09 Jul 2019 02:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com>
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Tue, 9 Jul 2019 11:55:03 +0200
Message-ID: <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>, bvanassche@acm.org,
        jgg@mellanox.com, dledford@redhat.com,
        Roman Pen <r.peniaev@gmail.com>, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hallo Doug, Hallo Jason, Hallo Jens, Hallo Greg,

Could you please provide some feedback to the IBNBD driver and the
IBTRS library?
So far we addressed all the requests provided by the community and
continue to maintain our code up-to-date with the upstream kernel
while having an extra compatibility layer for older kernels in our
out-of-tree repository.
I understand that SRP and NVMEoF which are in the kernel already do
provide equivalent functionality for the majority of the use cases.
IBNBD on the other hand is showing higher performance and more
importantly includes the IBTRS - a general purpose library to
establish connections and transport BIO-like read/write sg-lists over
RDMA, while SRP is targeting SCSI and NVMEoF is addressing NVME. While
I believe IBNBD does meet the kernel coding standards, it doesn't have
a lot of users, while SRP and NVMEoF are widely accepted. Do you think
it would make sense for us to rework our patchset and try pushing it
for staging tree first, so that we can proof IBNBD is well maintained,
beneficial for the eco-system, find a proper location for it within
block/rdma subsystems? This would make it easier for people to try it
out and would also be a huge step for us in terms of maintenance
effort.
The names IBNBD and IBTRS are in fact misleading. IBTRS sits on top of
RDMA and is not bound to IB (We will evaluate IBTRS with ROCE in the
near future). Do you think it would make sense to rename the driver to
RNBD/RTRS?

Thank you,
Best Regards,
Danil

On Thu, Jun 20, 2019 at 5:03 PM Jack Wang <jinpuwang@gmail.com> wrote:
>
> Hi all,
>
> Here is v4 of IBNBD/IBTRS patches, which have minor changes
>
>  Changelog
>  ---------
> v4:
>   o Protocol extended to transport IO priorities
>   o Support for Mellanox ConnectX-4/X-5
>   o Minor sysfs extentions (display access mode on server side)
>   o Bug fixes: cleaning up sysfs folders, race on deallocation of resources
>   o Style fixes
>
> v3:
>   o Sparse fixes:
>      - le32 -> le16 conversion
>      - pcpu and RCU wrong declaration
>      - sysfs: dynamically alloc array of sockaddr structures to reduce
>            size of a stack frame
>
>   o Rename sysfs folder on client and server sides to show source and
>     destination addresses of the connection, i.e.:
>            .../<session-name>/paths/<src@dst>/
>
>   o Remove external inclusions from Makefiles.
>   * https://lwn.net/Articles/756994/
>
> v2:
>   o IBNBD:
>      - No legacy request IO mode, only MQ is left.
>
>   o IBTRS:
>      - No FMR registration, only FR is left.
>
>   * https://lwn.net/Articles/755075/
>
> v1:
>   - IBTRS: load-balancing and IO fail-over using multipath features were added.
>
>   - Major parts of the code were rewritten, simplified and overall code
>     size was reduced by a quarter.
>
>   * https://lwn.net/Articles/746342/
>
> v0:
>   - Initial submission
>
>   * https://lwn.net/Articles/718181/
>
>
>  Introduction
>  -------------
>
> IBTRS (InfiniBand Transport) is a reliable high speed transport library
> which allows for establishing connection between client and server
> machines via RDMA. It is based on RDMA-CM, so expect also to support RoCE
> and iWARP, but we mainly tested in IB environment. It is optimized to
> transfer (read/write) IO blocks in the sense that it follows the BIO
> semantics of providing the possibility to either write data from a
> scatter-gather list to the remote side or to request ("read") data
> transfer from the remote side into a given set of buffers.
>
> IBTRS is multipath capable and provides I/O fail-over and load-balancing
> functionality, i.e. in IBTRS terminology, an IBTRS path is a set of RDMA
> CMs and particular path is selected according to the load-balancing policy.
> It can be used for other components not bind to IBNBD.
>
>
> IBNBD (InfiniBand Network Block Device) is a pair of kernel modules
> (client and server) that allow for remote access of a block device on
> the server over IBTRS protocol. After being mapped, the remote block
> devices can be accessed on the client side as local block devices.
> Internally IBNBD uses IBTRS as an RDMA transport library.
>
>
>    - IBNBD/IBTRS is developed in order to map thin provisioned volumes,
>      thus internal protocol is simple.
>    - IBTRS was developed as an independent RDMA transport library, which
>      supports fail-over and load-balancing policies using multipath, thus
>      it can be used for any other IO needs rather than only for block
>      device.
>    - IBNBD/IBTRS is fast.
>      Old comparison results:
>      https://www.spinics.net/lists/linux-rdma/msg48799.html
>      New comparison results: see performance measurements section below.
>
> Key features of IBTRS transport library and IBNBD block device:
>
> o High throughput and low latency due to:
>    - Only two RDMA messages per IO.
>    - IMM InfiniBand messages on responses to reduce round trip latency.
>    - Simplified memory management: memory allocation happens once on
>      server side when IBTRS session is established.
>
> o IO fail-over and load-balancing by using multipath.  According to
>   our test loads additional path brings ~20% of bandwidth.
>
> o Simple configuration of IBNBD:
>    - Server side is completely passive: volumes do not need to be
>      explicitly exported.
>    - Only IB port GID and device path needed on client side to map
>      a block device.
>    - A device is remapped automatically i.e. after storage reboot.
>
> Commits for kernel can be found here:
>    https://github.com/ionos-enterprise/ibnbd/tree/linux-5.2-rc3--ibnbd-v4
> The out-of-tree modules are here:
>    https://github.com/ionos-enterprise/ibnbd
>
> Vault 2017 presentation:
>   https://events.static.linuxfound.org/sites/events/files/slides/IBNBD-Vault-2017.pdf
>
>  Performance measurements
>  ------------------------
>
> o IBNBD and NVMEoRDMA
>
>   Performance results for the v5.2-rc3 kernel
>   link: https://github.com/ionos-enterprise/ibnbd/tree/develop/performance/v4-v5.2-rc3
>
> Roman Pen (25):
>   sysfs: export sysfs_remove_file_self()
>   ibtrs: public interface header to establish RDMA connections
>   ibtrs: private headers with IBTRS protocol structs and helpers
>   ibtrs: core: lib functions shared between client and server modules
>   ibtrs: client: private header with client structs and functions
>   ibtrs: client: main functionality
>   ibtrs: client: statistics functions
>   ibtrs: client: sysfs interface functions
>   ibtrs: server: private header with server structs and functions
>   ibtrs: server: main functionality
>   ibtrs: server: statistics functions
>   ibtrs: server: sysfs interface functions
>   ibtrs: include client and server modules into kernel compilation
>   ibtrs: a bit of documentation
>   ibnbd: private headers with IBNBD protocol structs and helpers
>   ibnbd: client: private header with client structs and functions
>   ibnbd: client: main functionality
>   ibnbd: client: sysfs interface functions
>   ibnbd: server: private header with server structs and functions
>   ibnbd: server: main functionality
>   ibnbd: server: functionality for IO submission to file or block dev
>   ibnbd: server: sysfs interface functions
>   ibnbd: include client and server modules into kernel compilation
>   ibnbd: a bit of documentation
>   MAINTAINERS: Add maintainer for IBNBD/IBTRS modules
>
>  MAINTAINERS                                   |   14 +
>  drivers/block/Kconfig                         |    2 +
>  drivers/block/Makefile                        |    1 +
>  drivers/block/ibnbd/Kconfig                   |   24 +
>  drivers/block/ibnbd/Makefile                  |   13 +
>  drivers/block/ibnbd/README                    |  315 ++
>  drivers/block/ibnbd/ibnbd-clt-sysfs.c         |  691 ++++
>  drivers/block/ibnbd/ibnbd-clt.c               | 1832 +++++++++++
>  drivers/block/ibnbd/ibnbd-clt.h               |  166 +
>  drivers/block/ibnbd/ibnbd-log.h               |   59 +
>  drivers/block/ibnbd/ibnbd-proto.h             |  378 +++
>  drivers/block/ibnbd/ibnbd-srv-dev.c           |  408 +++
>  drivers/block/ibnbd/ibnbd-srv-dev.h           |  143 +
>  drivers/block/ibnbd/ibnbd-srv-sysfs.c         |  270 ++
>  drivers/block/ibnbd/ibnbd-srv.c               |  945 ++++++
>  drivers/block/ibnbd/ibnbd-srv.h               |   94 +
>  drivers/infiniband/Kconfig                    |    1 +
>  drivers/infiniband/ulp/Makefile               |    1 +
>  drivers/infiniband/ulp/ibtrs/Kconfig          |   22 +
>  drivers/infiniband/ulp/ibtrs/Makefile         |   15 +
>  drivers/infiniband/ulp/ibtrs/README           |  385 +++
>  .../infiniband/ulp/ibtrs/ibtrs-clt-stats.c    |  447 +++
>  .../infiniband/ulp/ibtrs/ibtrs-clt-sysfs.c    |  514 +++
>  drivers/infiniband/ulp/ibtrs/ibtrs-clt.c      | 2844 +++++++++++++++++
>  drivers/infiniband/ulp/ibtrs/ibtrs-clt.h      |  308 ++
>  drivers/infiniband/ulp/ibtrs/ibtrs-log.h      |   84 +
>  drivers/infiniband/ulp/ibtrs/ibtrs-pri.h      |  463 +++
>  .../infiniband/ulp/ibtrs/ibtrs-srv-stats.c    |  103 +
>  .../infiniband/ulp/ibtrs/ibtrs-srv-sysfs.c    |  303 ++
>  drivers/infiniband/ulp/ibtrs/ibtrs-srv.c      | 1998 ++++++++++++
>  drivers/infiniband/ulp/ibtrs/ibtrs-srv.h      |  170 +
>  drivers/infiniband/ulp/ibtrs/ibtrs.c          |  610 ++++
>  drivers/infiniband/ulp/ibtrs/ibtrs.h          |  318 ++
>  fs/sysfs/file.c                               |    1 +
>  34 files changed, 13942 insertions(+)
>  create mode 100644 drivers/block/ibnbd/Kconfig
>  create mode 100644 drivers/block/ibnbd/Makefile
>  create mode 100644 drivers/block/ibnbd/README
>  create mode 100644 drivers/block/ibnbd/ibnbd-clt-sysfs.c
>  create mode 100644 drivers/block/ibnbd/ibnbd-clt.c
>  create mode 100644 drivers/block/ibnbd/ibnbd-clt.h
>  create mode 100644 drivers/block/ibnbd/ibnbd-log.h
>  create mode 100644 drivers/block/ibnbd/ibnbd-proto.h
>  create mode 100644 drivers/block/ibnbd/ibnbd-srv-dev.c
>  create mode 100644 drivers/block/ibnbd/ibnbd-srv-dev.h
>  create mode 100644 drivers/block/ibnbd/ibnbd-srv-sysfs.c
>  create mode 100644 drivers/block/ibnbd/ibnbd-srv.c
>  create mode 100644 drivers/block/ibnbd/ibnbd-srv.h
>  create mode 100644 drivers/infiniband/ulp/ibtrs/Kconfig
>  create mode 100644 drivers/infiniband/ulp/ibtrs/Makefile
>  create mode 100644 drivers/infiniband/ulp/ibtrs/README
>  create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-clt-stats.c
>  create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-clt-sysfs.c
>  create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-clt.c
>  create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-clt.h
>  create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-log.h
>  create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-pri.h
>  create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv-stats.c
>  create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv-sysfs.c
>  create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv.c
>  create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv.h
>  create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs.c
>  create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs.h
>
> --
> 2.17.1
>
