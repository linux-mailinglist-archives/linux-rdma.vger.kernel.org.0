Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A90B1E5CC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfENXtm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35575 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfENXtm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id a39so1251104qtk.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShOBYI1I4IEYV5J0OWWWXED/MqnOw37sCAMOg8ZGy/U=;
        b=IoCCXBsgu4fFpu0Z5onHHFOzqKIubiR/uuTynIHF/GwaOJy9cWwTk/P1YgJEPHfRMA
         wFd+NU3OnN/3k1m7HdhwSBBzPDafz6T3pjShGQ+wnEiqNNCWV7vIbWGb1Uv0MlUXxB92
         3gs6tXZNc/++dEV4YEtFwI0IVHl0u1p/mMiKmpr4yhv3A+Ry7VbswHFul9io0CzUU74t
         eSrKP/AYOzToPQBUnehRca8wF27jDZFbLyOxv+PvlpiauzqeVd9DuxuIGV2v1DREb3Pf
         iokOqHrviudqTcPBNAuusGflAz6Zx/P28RC5ZzGaZB1P1kC81xRnHHp2mEH2fe0djmgj
         lsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShOBYI1I4IEYV5J0OWWWXED/MqnOw37sCAMOg8ZGy/U=;
        b=TgFKgJXVYoSEQJdjZ/IIkM2h1oLylr5Ay0vbZsqQYDicQ6gC6HG80FLzQojb3aNqTL
         EwajK34lB8AaiDvVY3sObyID8ejdpnqao6/xQuY8g6VtccEnNG/YOqk0czjc8lvWqUyf
         QlZRa2hVXjFX5XarztwDk0YXxM0M+1L5HDLGjvmKl1z54P8it9qL8AQx2qrUQQy/ouzi
         2qZ2xHP1g/svdfdTqcseIV36R8W2xsxybw0T4OaSiJyZ+mtDDIDKsauVq3dyDVdvp+Ug
         p0gtK0x04K1gwYRpb1Fq8Ibero2kji2Ka0wPKthDj1lH7jM6I2cK5mUvUAuECr1XprlP
         /GhA==
X-Gm-Message-State: APjAAAVQtSv4Q00AB13mimM8M3mUskYXzwmaLidhqoHltyZMhkitjY9t
        sGlFtRyzQ2CLA/pqd6758jgryIbD7tM=
X-Google-Smtp-Source: APXvYqzq/FlfQxIStcSqTAhVFfMpHZAWbbmNqKsIgmacEI96MJ7aMB+v6n3vOHEmPiPeqy8BycpEJA==
X-Received: by 2002:ac8:3613:: with SMTP id m19mr33548198qtb.351.1557877779741;
        Tue, 14 May 2019 16:49:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id 17sm136519qkg.30.2019.05.14.16.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAw-0001Md-K2; Tue, 14 May 2019 20:49:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 00/20] Incorporate infiniband-diags into rdma-core
Date:   Tue, 14 May 2019 20:49:16 -0300
Message-Id: <20190514234936.5175-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Ira would like to stop maintaining infiniband-diags, and also bring it up to
the level of CI, packaging, static analysis, etc that rdma-core has. Since it
is a fairly small and complementary code base, just roll it into rdma-core.

The packaging is based on what Debian, Fedora and suse have already.

I've already sent many commits to infinbiand-diags that clean up warnings/etc
so this drops in and passes travis CI.

Like all the past aggregations this preserves the GIT commit history and
per-file history and blame works with --follow.

This should not be merged until after we make the next rdma-core release.

It is a github PR:

https://github.com/linux-rdma/rdma-core/pull/529

The diffs attached are based off the merge point that includes the entire
infiniband-diag's source as a subdirectory to rdma-core. They show the
transformation of infiniband-diags to fit into rdma-core.

Jason Gunthorpe (20):
  ibdiags: Add SWITCH_FALLTHROUGH
  ibdiags: Add required definitions to rdma-core config.h
  ibdiags: Remove unneeded HAVE_ checks
  ibdiags: Remove config.h and HAVE_CONFIG_H
  ibdiags: Don't use __DATE__ and __TIME__
  build: Support rst as a man page option
  ibdiags: Add cmake files for ibdiags components
  ibdiags: Copy the cl_qmap implementation from opensm
  ibdiags: Copy part of ib_types.h from opensm
  ibdiags: Provide the cl_nodenamemap interface
  ibdiags: Add Debian packaging
  ibdiags: Add Fedora packaging
  ibdiags: Add suse packaging
  ibdiags: Obsolete mad_osd.h
  libibmad: Flatten libibmad into one directory
  libibnetdiscover: Flatten libibnetdiscover into one directory
  ibdiags: Flatten the infiniband-diags tools into one directory
  ibdiags: Remove obsolete build system and related files
  ibdiags: Remove @BUILD_DATE@ from the man pages
  ibdiags: Perform substitution on the RST include files as well

 .travis.yml                                   |    1 +
 CMakeLists.txt                                |   34 +-
 buildlib/Findrst2man.cmake                    |   21 +
 buildlib/cbuild                               |   12 +-
 buildlib/check-build                          |    6 +-
 buildlib/config.h.in                          |    5 +
 buildlib/pandoc-prebuilt.py                   |   33 +-
 buildlib/rdma_man.cmake                       |   60 +-
 debian/control                                |  102 +
 debian/infiniband-diags.install               |   64 +
 debian/libibmad-dev.install                   |    5 +
 debian/libibmad5.install                      |    1 +
 debian/libibmad5.symbols                      |  154 ++
 debian/libibnetdisc-dev.install               |   13 +
 debian/libibnetdisc5.install                  |    1 +
 debian/libibnetdisc5.symbols                  |   20 +
 debian/rules                                  |    3 +
 ibdiags/.gitignore                            |   66 -
 ibdiags/AUTHORS                               |    4 -
 ibdiags/COPYING                               |  379 ----
 ibdiags/ChangeLog                             |  470 -----
 ibdiags/Makefile.am                           |  157 --
 ibdiags/NEWS                                  |    2 -
 ibdiags/README                                |   62 -
 ibdiags/autogen.sh                            |    8 -
 ibdiags/configure.ac                          |  252 ---
 ibdiags/doc/README.rst                        |  105 -
 ibdiags/doc/generate                          |   45 -
 ibdiags/doc/man/check_lft_balance.8.in        |   67 -
 ibdiags/doc/man/dump_fts.8.in                 |  235 ---
 ibdiags/doc/man/ibaddr.8.in                   |  214 --
 ibdiags/doc/man/ibcacheedit.8.in              |   79 -
 ibdiags/doc/man/ibccconfig.8.in               |  195 --
 ibdiags/doc/man/ibccquery.8.in                |  192 --
 ibdiags/doc/man/ibfindnodesusing.8.in         |  126 --
 ibdiags/doc/man/ibhosts.8.in                  |  184 --
 ibdiags/doc/man/ibidsverify.8.in              |   79 -
 ibdiags/doc/man/iblinkinfo.8.in               |  316 ---
 ibdiags/doc/man/ibnetdiscover.8.in            |  399 ----
 ibdiags/doc/man/ibnodes.8.in                  |  176 --
 ibdiags/doc/man/ibping.8.in                   |  174 --
 ibdiags/doc/man/ibportstate.8.in              |  259 ---
 ibdiags/doc/man/ibqueryerrors.8.in            |  339 ----
 ibdiags/doc/man/ibroute.8.in                  |  290 ---
 ibdiags/doc/man/ibrouters.8.in                |  184 --
 ibdiags/doc/man/ibstat.8.in                   |  117 --
 ibdiags/doc/man/ibstatus.8.in                 |   72 -
 ibdiags/doc/man/ibswitches.8.in               |  184 --
 ibdiags/doc/man/ibsysstat.8.in                |  183 --
 ibdiags/doc/man/ibtracert.8.in                |  314 ---
 ibdiags/doc/man/infiniband-diags.8.in         |  451 -----
 ibdiags/doc/man/perfquery.8.in                |  287 ---
 ibdiags/doc/man/saquery.8.in                  |  374 ----
 ibdiags/doc/man/sminfo.8.in                   |  214 --
 ibdiags/doc/man/smpdump.8.in                  |  206 --
 ibdiags/doc/man/smpquery.8.in                 |  309 ---
 ibdiags/doc/man/vendstat.8.in                 |  217 ---
 ibdiags/include/ibdiag_version.h.in           |   39 -
 ibdiags/infiniband-diags.spec.in              |  334 ----
 ibdiags/libibmad/ChangeLog                    |   88 -
 ibdiags/libibmad/Makefile.am                  |   34 -
 ibdiags/libibmad/README                       |    7 -
 ibdiags/libibmad/include/infiniband/mad_osd.h |   49 -
 ibdiags/libibmad/libibmad.ver                 |    9 -
 ibdiags/libibnetdisc/Makefile.am              |   54 -
 ibdiags/libibnetdisc/libibnetdisc.ver         |    9 -
 ibdiags/libibnetdisc/man/ibnd_debug.3         |    2 -
 .../libibnetdisc/man/ibnd_destroy_fabric.3    |    2 -
 ibdiags/libibnetdisc/man/ibnd_find_node_dr.3  |    2 -
 .../libibnetdisc/man/ibnd_iter_nodes_type.3   |    2 -
 ibdiags/libibnetdisc/man/ibnd_show_progress.3 |    2 -
 ibdiags/man/dump_lfts.8                       |    2 -
 ibdiags/man/dump_mfts.8                       |    2 -
 ibdiags/perltidy.sh                           |   68 -
 ibdiags/tests/check_shells.sh                 |   14 -
 ibtypes.py                                    |   61 +
 infiniband-diags/CMakeLists.txt               |   49 +
 {ibdiags/src => infiniband-diags}/dump_fts.c  |    6 +-
 .../etc/error_thresholds                      |    0
 {ibdiags => infiniband-diags}/etc/ibdiag.conf |    0
 {ibdiags/src => infiniband-diags}/ibaddr.c    |    4 -
 .../src => infiniband-diags}/ibcacheedit.c    |    4 -
 .../src => infiniband-diags}/ibccconfig.c     |    4 -
 {ibdiags/src => infiniband-diags}/ibccquery.c |    4 -
 .../src => infiniband-diags}/ibdiag_common.c  |    4 +-
 .../ibdiag_common.h                           |   52 +-
 {ibdiags/src => infiniband-diags}/ibdiag_sa.c |    0
 .../include => infiniband-diags}/ibdiag_sa.h  |    2 +-
 .../src => infiniband-diags}/iblinkinfo.c     |    6 +-
 .../src => infiniband-diags}/ibnetdiscover.c  |    6 +-
 {ibdiags/src => infiniband-diags}/ibping.c    |    4 -
 .../src => infiniband-diags}/ibportstate.c    |    7 +-
 .../src => infiniband-diags}/ibqueryerrors.c  |    6 +-
 {ibdiags/src => infiniband-diags}/ibroute.c   |    6 +-
 .../src => infiniband-diags}/ibsendtrap.c     |    1 -
 {ibdiags/src => infiniband-diags}/ibstat.c    |    6 -
 {ibdiags/src => infiniband-diags}/ibsysstat.c |    4 -
 {ibdiags/src => infiniband-diags}/ibtracert.c |    6 +-
 infiniband-diags/man/CMakeLists.txt           |  106 +
 .../man}/check_lft_balance.8.in.rst           |    2 +-
 .../man}/common/opt_C.rst                     |    0
 .../man}/common/opt_D.rst                     |    0
 .../man}/common/opt_D_with_param.rst          |    0
 .../man}/common/opt_G.rst                     |    0
 .../man}/common/opt_G_with_param.rst          |    0
 .../man}/common/opt_K.rst                     |    0
 .../man}/common/opt_L.rst                     |    0
 .../man}/common/opt_P.rst                     |    0
 .../man}/common/opt_V.rst                     |    0
 .../man}/common/opt_cache.rst                 |    0
 .../man}/common/opt_d.rst                     |    0
 .../man}/common/opt_diff.rst                  |    0
 .../man}/common/opt_diffcheck.rst             |    0
 .../man}/common/opt_e.rst                     |    0
 .../man}/common/opt_h.rst                     |    0
 .../man}/common/opt_load-cache.rst            |    0
 .../man}/common/opt_node_name_map.rst         |    0
 .../man}/common/opt_o-outstanding_smps.rst    |    0
 .../man}/common/opt_ports-file.rst            |    0
 .../man}/common/opt_s.rst                     |    0
 .../man}/common/opt_t.rst                     |    0
 .../man}/common/opt_v.rst                     |    0
 .../man}/common/opt_y.rst                     |    0
 .../man/common/opt_z-config.in.rst            |    0
 .../man/common/sec_config-file.in.rst         |    0
 .../man}/common/sec_node-name-map.rst         |    0
 .../man}/common/sec_ports-file.rst            |    0
 .../man}/common/sec_portselection.rst         |    0
 .../man}/common/sec_topology-file.rst         |    0
 .../man}/dump_fts.8.in.rst                    |    2 +-
 .../man}/ibaddr.8.in.rst                      |    2 +-
 .../man}/ibcacheedit.8.in.rst                 |    2 +-
 .../man}/ibccconfig.8.in.rst                  |    2 +-
 .../man}/ibccquery.8.in.rst                   |    2 +-
 .../man/ibcheckerrors.8                       |    0
 .../man/ibcheckerrs.8                         |    0
 .../man/ibchecknet.8                          |    0
 .../man/ibchecknode.8                         |    0
 .../man/ibcheckport.8                         |    0
 .../man/ibcheckportstate.8                    |    0
 .../man/ibcheckportwidth.8                    |    0
 .../man/ibcheckstate.8                        |    0
 .../man/ibcheckwidth.8                        |    0
 .../man/ibclearcounters.8                     |    0
 .../man/ibclearerrors.8                       |    0
 .../man/ibdatacounters.8                      |    0
 .../man/ibdatacounts.8                        |    0
 .../man/ibdiscover.8                          |    0
 .../man}/ibfindnodesusing.8.in.rst            |    2 +-
 .../man}/ibhosts.8.in.rst                     |    2 +-
 .../man}/ibidsverify.8.in.rst                 |    2 +-
 .../man}/iblinkinfo.8.in.rst                  |    2 +-
 .../man}/ibnetdiscover.8.in.rst               |    2 +-
 .../man}/ibnodes.8.in.rst                     |    2 +-
 .../man}/ibping.8.in.rst                      |    2 +-
 .../man}/ibportstate.8.in.rst                 |    2 +-
 {ibdiags => infiniband-diags}/man/ibprintca.8 |    0
 {ibdiags => infiniband-diags}/man/ibprintrt.8 |    0
 .../man/ibprintswitch.8                       |    0
 .../man}/ibqueryerrors.8.in.rst               |    2 +-
 .../man}/ibroute.8.in.rst                     |    2 +-
 .../man}/ibrouters.8.in.rst                   |    2 +-
 .../man}/ibstat.8.in.rst                      |    2 +-
 .../man}/ibstatus.8.in.rst                    |    2 +-
 .../man}/ibswitches.8.in.rst                  |    2 +-
 .../man/ibswportwatch.8                       |    0
 .../man}/ibsysstat.8.in.rst                   |    2 +-
 .../man}/ibtracert.8.in.rst                   |    2 +-
 .../man}/infiniband-diags.8.in.rst            |    2 +-
 .../man}/perfquery.8.in.rst                   |    2 +-
 .../man}/saquery.8.in.rst                     |    2 +-
 .../man}/sminfo.8.in.rst                      |    2 +-
 .../man}/smpdump.8.in.rst                     |    2 +-
 .../man}/smpquery.8.in.rst                    |    2 +-
 .../man}/vendstat.8.in.rst                    |    2 +-
 .../src => infiniband-diags}/mcm_rereg_test.c |    5 -
 {ibdiags/src => infiniband-diags}/perfquery.c |    5 -
 {ibdiags/src => infiniband-diags}/saquery.c   |    7 +-
 infiniband-diags/scripts/CMakeLists.txt       |  114 ++
 .../scripts/IBswcountlimits.pm                |    0
 .../scripts/check_lft_balance.pl              |    0
 .../scripts/dump_lfts.sh.in                   |    0
 .../scripts/dump_mfts.sh.in                   |    0
 .../scripts/ibcheckerrors.in                  |    0
 .../scripts/ibcheckerrs.in                    |    0
 .../scripts/ibchecknet.in                     |    0
 .../scripts/ibchecknode.in                    |    0
 .../scripts/ibcheckport.in                    |    0
 .../scripts/ibcheckportstate.in               |    0
 .../scripts/ibcheckportwidth.in               |    0
 .../scripts/ibcheckstate.in                   |    0
 .../scripts/ibcheckwidth.in                   |    0
 .../scripts/ibclearcounters.in                |    0
 .../scripts/ibclearerrors.in                  |    0
 .../scripts/ibdatacounters.in                 |    0
 .../scripts/ibdatacounts.in                   |    0
 .../scripts/ibdiscover.map                    |    0
 .../scripts/ibdiscover.pl                     |    0
 .../scripts/ibfindnodesusing.pl               |    0
 .../scripts/ibhosts.in                        |    0
 .../scripts/ibidsverify.pl                    |    0
 .../scripts/iblinkinfo.pl.in                  |    0
 .../scripts/ibnodes.in                        |    0
 .../scripts/ibprintca.pl                      |    0
 .../scripts/ibprintrt.pl                      |    0
 .../scripts/ibprintswitch.pl                  |    0
 .../scripts/ibqueryerrors.pl.in               |    0
 .../scripts/ibrouters.in                      |    0
 .../scripts/ibstatus                          |    0
 .../scripts/ibswitches.in                     |    0
 .../scripts/ibswportwatch.pl                  |    0
 .../scripts/set_nodedesc.sh                   |    0
 {ibdiags/src => infiniband-diags}/sminfo.c    |    4 -
 {ibdiags/src => infiniband-diags}/smpdump.c   |    4 -
 {ibdiags/src => infiniband-diags}/smpquery.c  |    6 +-
 {ibdiags/src => infiniband-diags}/vendstat.c  |    4 -
 libibmad/CMakeLists.txt                       |   31 +
 {ibdiags/libibmad/src => libibmad}/bm.c       |    4 -
 {ibdiags/libibmad/src => libibmad}/cc.c       |    4 -
 {ibdiags/libibmad/src => libibmad}/dump.c     |    4 -
 {ibdiags/libibmad/src => libibmad}/fields.c   |    4 -
 {ibdiags/libibmad/src => libibmad}/gs.c       |    4 -
 libibmad/iba_types.h                          | 1734 +++++++++++++++++
 .../libibmad/src => libibmad}/libibmad.map    |    0
 {ibdiags/libibmad/src => libibmad}/mad.c      |    4 -
 .../include/infiniband => libibmad}/mad.h     |   13 +-
 .../libibmad/src => libibmad}/mad_internal.h  |    0
 libibmad/mad_osd.h                            |    1 +
 {ibdiags/libibmad/src => libibmad}/portid.c   |    4 -
 {ibdiags/libibmad/src => libibmad}/register.c |    4 -
 {ibdiags/libibmad/src => libibmad}/resolve.c  |    4 -
 {ibdiags/libibmad/src => libibmad}/rpc.c      |    4 -
 {ibdiags/libibmad/src => libibmad}/sa.c       |    4 -
 {ibdiags/libibmad/src => libibmad}/serv.c     |    4 -
 {ibdiags/libibmad/src => libibmad}/smp.c      |    4 -
 {ibdiags/libibmad/src => libibmad}/vendor.c   |    4 -
 libibnetdisc/CMakeLists.txt                   |   24 +
 .../src => libibnetdisc}/chassis.c            |    4 -
 .../src => libibnetdisc}/chassis.h            |    0
 .../src => libibnetdisc}/ibnetdisc.c          |    7 +-
 .../infiniband => libibnetdisc}/ibnetdisc.h   |    1 -
 .../src => libibnetdisc}/ibnetdisc_cache.c    |    4 -
 .../ibnetdisc_osd.h                           |    0
 .../src => libibnetdisc}/internal.h           |    2 +-
 .../src => libibnetdisc}/libibnetdisc.map     |    0
 libibnetdisc/man/CMakeLists.txt               |   14 +
 .../man/ibnd_discover_fabric.3                |    0
 .../man/ibnd_find_node_guid.3                 |    0
 .../man/ibnd_iter_nodes.3                     |    0
 .../src => libibnetdisc}/query_smp.c          |    4 -
 .../test => libibnetdisc/tests}/testleaks.c   |    5 -
 redhat/rdma-core.spec                         |  143 ++
 suse/rdma-core.spec                           |  116 ++
 util/CMakeLists.txt                           |    4 +
 util/cl_map.c                                 |  700 +++++++
 util/cl_qmap.h                                |  970 +++++++++
 util/node_name_map.c                          |  222 +++
 util/node_name_map.h                          |   19 +
 258 files changed, 4883 insertions(+), 8986 deletions(-)
 create mode 100644 buildlib/Findrst2man.cmake
 create mode 100644 debian/infiniband-diags.install
 create mode 100644 debian/libibmad-dev.install
 create mode 100644 debian/libibmad5.install
 create mode 100644 debian/libibmad5.symbols
 create mode 100644 debian/libibnetdisc-dev.install
 create mode 100644 debian/libibnetdisc5.install
 create mode 100644 debian/libibnetdisc5.symbols
 delete mode 100644 ibdiags/.gitignore
 delete mode 100644 ibdiags/AUTHORS
 delete mode 100644 ibdiags/COPYING
 delete mode 100644 ibdiags/ChangeLog
 delete mode 100644 ibdiags/Makefile.am
 delete mode 100644 ibdiags/NEWS
 delete mode 100644 ibdiags/README
 delete mode 100755 ibdiags/autogen.sh
 delete mode 100644 ibdiags/configure.ac
 delete mode 100644 ibdiags/doc/README.rst
 delete mode 100755 ibdiags/doc/generate
 delete mode 100644 ibdiags/doc/man/check_lft_balance.8.in
 delete mode 100644 ibdiags/doc/man/dump_fts.8.in
 delete mode 100644 ibdiags/doc/man/ibaddr.8.in
 delete mode 100644 ibdiags/doc/man/ibcacheedit.8.in
 delete mode 100644 ibdiags/doc/man/ibccconfig.8.in
 delete mode 100644 ibdiags/doc/man/ibccquery.8.in
 delete mode 100644 ibdiags/doc/man/ibfindnodesusing.8.in
 delete mode 100644 ibdiags/doc/man/ibhosts.8.in
 delete mode 100644 ibdiags/doc/man/ibidsverify.8.in
 delete mode 100644 ibdiags/doc/man/iblinkinfo.8.in
 delete mode 100644 ibdiags/doc/man/ibnetdiscover.8.in
 delete mode 100644 ibdiags/doc/man/ibnodes.8.in
 delete mode 100644 ibdiags/doc/man/ibping.8.in
 delete mode 100644 ibdiags/doc/man/ibportstate.8.in
 delete mode 100644 ibdiags/doc/man/ibqueryerrors.8.in
 delete mode 100644 ibdiags/doc/man/ibroute.8.in
 delete mode 100644 ibdiags/doc/man/ibrouters.8.in
 delete mode 100644 ibdiags/doc/man/ibstat.8.in
 delete mode 100644 ibdiags/doc/man/ibstatus.8.in
 delete mode 100644 ibdiags/doc/man/ibswitches.8.in
 delete mode 100644 ibdiags/doc/man/ibsysstat.8.in
 delete mode 100644 ibdiags/doc/man/ibtracert.8.in
 delete mode 100644 ibdiags/doc/man/infiniband-diags.8.in
 delete mode 100644 ibdiags/doc/man/perfquery.8.in
 delete mode 100644 ibdiags/doc/man/saquery.8.in
 delete mode 100644 ibdiags/doc/man/sminfo.8.in
 delete mode 100644 ibdiags/doc/man/smpdump.8.in
 delete mode 100644 ibdiags/doc/man/smpquery.8.in
 delete mode 100644 ibdiags/doc/man/vendstat.8.in
 delete mode 100644 ibdiags/include/ibdiag_version.h.in
 delete mode 100644 ibdiags/infiniband-diags.spec.in
 delete mode 100644 ibdiags/libibmad/ChangeLog
 delete mode 100644 ibdiags/libibmad/Makefile.am
 delete mode 100644 ibdiags/libibmad/README
 delete mode 100644 ibdiags/libibmad/include/infiniband/mad_osd.h
 delete mode 100644 ibdiags/libibmad/libibmad.ver
 delete mode 100644 ibdiags/libibnetdisc/Makefile.am
 delete mode 100644 ibdiags/libibnetdisc/libibnetdisc.ver
 delete mode 100644 ibdiags/libibnetdisc/man/ibnd_debug.3
 delete mode 100644 ibdiags/libibnetdisc/man/ibnd_destroy_fabric.3
 delete mode 100644 ibdiags/libibnetdisc/man/ibnd_find_node_dr.3
 delete mode 100644 ibdiags/libibnetdisc/man/ibnd_iter_nodes_type.3
 delete mode 100644 ibdiags/libibnetdisc/man/ibnd_show_progress.3
 delete mode 100644 ibdiags/man/dump_lfts.8
 delete mode 100644 ibdiags/man/dump_mfts.8
 delete mode 100755 ibdiags/perltidy.sh
 delete mode 100755 ibdiags/tests/check_shells.sh
 create mode 100644 ibtypes.py
 create mode 100644 infiniband-diags/CMakeLists.txt
 rename {ibdiags/src => infiniband-diags}/dump_fts.c (99%)
 rename {ibdiags => infiniband-diags}/etc/error_thresholds (100%)
 rename {ibdiags => infiniband-diags}/etc/ibdiag.conf (100%)
 rename {ibdiags/src => infiniband-diags}/ibaddr.c (98%)
 rename {ibdiags/src => infiniband-diags}/ibcacheedit.c (99%)
 rename {ibdiags/src => infiniband-diags}/ibccconfig.c (99%)
 rename {ibdiags/src => infiniband-diags}/ibccquery.c (99%)
 rename {ibdiags/src => infiniband-diags}/ibdiag_common.c (99%)
 rename {ibdiags/include => infiniband-diags}/ibdiag_common.h (76%)
 rename {ibdiags/src => infiniband-diags}/ibdiag_sa.c (100%)
 rename {ibdiags/include => infiniband-diags}/ibdiag_sa.h (98%)
 rename {ibdiags/src => infiniband-diags}/iblinkinfo.c (99%)
 rename {ibdiags/src => infiniband-diags}/ibnetdiscover.c (99%)
 rename {ibdiags/src => infiniband-diags}/ibping.c (98%)
 rename {ibdiags/src => infiniband-diags}/ibportstate.c (99%)
 rename {ibdiags/src => infiniband-diags}/ibqueryerrors.c (99%)
 rename {ibdiags/src => infiniband-diags}/ibroute.c (99%)
 rename {ibdiags/src => infiniband-diags}/ibsendtrap.c (99%)
 rename {ibdiags/src => infiniband-diags}/ibstat.c (98%)
 rename {ibdiags/src => infiniband-diags}/ibsysstat.c (99%)
 rename {ibdiags/src => infiniband-diags}/ibtracert.c (99%)
 create mode 100644 infiniband-diags/man/CMakeLists.txt
 rename {ibdiags/doc/rst => infiniband-diags/man}/check_lft_balance.8.in.rst (97%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_C.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_D.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_D_with_param.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_G.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_G_with_param.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_K.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_L.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_P.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_V.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_cache.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_d.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_diff.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_diffcheck.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_e.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_h.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_load-cache.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_node_name_map.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_o-outstanding_smps.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_ports-file.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_s.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_t.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_v.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_y.rst (100%)
 rename ibdiags/doc/rst/common/opt_z-config.rst => infiniband-diags/man/common/opt_z-config.in.rst (100%)
 rename ibdiags/doc/rst/common/sec_config-file.rst => infiniband-diags/man/common/sec_config-file.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/sec_node-name-map.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/sec_ports-file.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/sec_portselection.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/sec_topology-file.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/dump_fts.8.in.rst (98%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibaddr.8.in.rst (98%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibcacheedit.8.in.rst (98%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibccconfig.8.in.rst (99%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibccquery.8.in.rst (98%)
 rename {ibdiags => infiniband-diags}/man/ibcheckerrors.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibcheckerrs.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibchecknet.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibchecknode.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibcheckport.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibcheckportstate.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibcheckportwidth.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibcheckstate.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibcheckwidth.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibclearcounters.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibclearerrors.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibdatacounters.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibdatacounts.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibdiscover.8 (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibfindnodesusing.8.in.rst (98%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibhosts.8.in.rst (97%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibidsverify.8.in.rst (98%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/iblinkinfo.8.in.rst (99%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibnetdiscover.8.in.rst (99%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibnodes.8.in.rst (97%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibping.8.in.rst (98%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibportstate.8.in.rst (99%)
 rename {ibdiags => infiniband-diags}/man/ibprintca.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibprintrt.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibprintswitch.8 (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibqueryerrors.8.in.rst (99%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibroute.8.in.rst (99%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibrouters.8.in.rst (97%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibstat.8.in.rst (98%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibstatus.8.in.rst (97%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibswitches.8.in.rst (97%)
 rename {ibdiags => infiniband-diags}/man/ibswportwatch.8 (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibsysstat.8.in.rst (98%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibtracert.8.in.rst (99%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/infiniband-diags.8.in.rst (99%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/perfquery.8.in.rst (99%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/saquery.8.in.rst (99%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/sminfo.8.in.rst (98%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/smpdump.8.in.rst (98%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/smpquery.8.in.rst (99%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/vendstat.8.in.rst (99%)
 rename {ibdiags/src => infiniband-diags}/mcm_rereg_test.c (98%)
 rename {ibdiags/src => infiniband-diags}/perfquery.c (99%)
 rename {ibdiags/src => infiniband-diags}/saquery.c (99%)
 create mode 100644 infiniband-diags/scripts/CMakeLists.txt
 rename {ibdiags => infiniband-diags}/scripts/IBswcountlimits.pm (100%)
 rename {ibdiags => infiniband-diags}/scripts/check_lft_balance.pl (100%)
 rename {ibdiags => infiniband-diags}/scripts/dump_lfts.sh.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/dump_mfts.sh.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibcheckerrors.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibcheckerrs.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibchecknet.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibchecknode.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibcheckport.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibcheckportstate.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibcheckportwidth.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibcheckstate.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibcheckwidth.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibclearcounters.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibclearerrors.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibdatacounters.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibdatacounts.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibdiscover.map (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibdiscover.pl (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibfindnodesusing.pl (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibhosts.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibidsverify.pl (100%)
 rename {ibdiags => infiniband-diags}/scripts/iblinkinfo.pl.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibnodes.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibprintca.pl (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibprintrt.pl (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibprintswitch.pl (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibqueryerrors.pl.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibrouters.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibstatus (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibswitches.in (100%)
 rename {ibdiags => infiniband-diags}/scripts/ibswportwatch.pl (100%)
 rename {ibdiags => infiniband-diags}/scripts/set_nodedesc.sh (100%)
 rename {ibdiags/src => infiniband-diags}/sminfo.c (98%)
 rename {ibdiags/src => infiniband-diags}/smpdump.c (98%)
 rename {ibdiags/src => infiniband-diags}/smpquery.c (99%)
 rename {ibdiags/src => infiniband-diags}/vendstat.c (99%)
 create mode 100644 libibmad/CMakeLists.txt
 rename {ibdiags/libibmad/src => libibmad}/bm.c (97%)
 rename {ibdiags/libibmad/src => libibmad}/cc.c (97%)
 rename {ibdiags/libibmad/src => libibmad}/dump.c (99%)
 rename {ibdiags/libibmad/src => libibmad}/fields.c (99%)
 rename {ibdiags/libibmad/src => libibmad}/gs.c (98%)
 create mode 100644 libibmad/iba_types.h
 rename {ibdiags/libibmad/src => libibmad}/libibmad.map (100%)
 rename {ibdiags/libibmad/src => libibmad}/mad.c (98%)
 rename {ibdiags/libibmad/include/infiniband => libibmad}/mad.h (99%)
 rename {ibdiags/libibmad/src => libibmad}/mad_internal.h (100%)
 create mode 100644 libibmad/mad_osd.h
 rename {ibdiags/libibmad/src => libibmad}/portid.c (97%)
 rename {ibdiags/libibmad/src => libibmad}/register.c (98%)
 rename {ibdiags/libibmad/src => libibmad}/resolve.c (98%)
 rename {ibdiags/libibmad/src => libibmad}/rpc.c (99%)
 rename {ibdiags/libibmad/src => libibmad}/sa.c (98%)
 rename {ibdiags/libibmad/src => libibmad}/serv.c (98%)
 rename {ibdiags/libibmad/src => libibmad}/smp.c (98%)
 rename {ibdiags/libibmad/src => libibmad}/vendor.c (97%)
 create mode 100644 libibnetdisc/CMakeLists.txt
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/chassis.c (99%)
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/chassis.h (100%)
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/ibnetdisc.c (99%)
 rename {ibdiags/libibnetdisc/include/infiniband => libibnetdisc}/ibnetdisc.h (99%)
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/ibnetdisc_cache.c (99%)
 rename {ibdiags/libibnetdisc/include/infiniband => libibnetdisc}/ibnetdisc_osd.h (100%)
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/internal.h (99%)
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/libibnetdisc.map (100%)
 create mode 100644 libibnetdisc/man/CMakeLists.txt
 rename {ibdiags/libibnetdisc => libibnetdisc}/man/ibnd_discover_fabric.3 (100%)
 rename {ibdiags/libibnetdisc => libibnetdisc}/man/ibnd_find_node_guid.3 (100%)
 rename {ibdiags/libibnetdisc => libibnetdisc}/man/ibnd_iter_nodes.3 (100%)
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/query_smp.c (99%)
 rename {ibdiags/libibnetdisc/test => libibnetdisc/tests}/testleaks.c (97%)
 create mode 100644 util/cl_map.c
 create mode 100644 util/cl_qmap.h
 create mode 100644 util/node_name_map.c
 create mode 100644 util/node_name_map.h

-- 
2.21.0

