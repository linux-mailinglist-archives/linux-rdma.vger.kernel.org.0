Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3931E5C9
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfENXtq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43969 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfENXtq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:46 -0400
Received: by mail-qk1-f194.google.com with SMTP id z6so383339qkl.10
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G82XXP8YiGLQfQ4GwG8HsWwFaR0GhQtI+Q+SWa4TYsU=;
        b=BpQRmXZiTljTKRxV+5NSUN74ZDRdemLcxFah36faba/AvQh8QMP+br8EjYjwP4LQog
         N89I7264bMNI1iw9e753gpSSuDZxGcq99Ki+v1SdOHOaOMtjT+erep/zLmQWopGS1Tq6
         r7qGU6oLr/dhaapRgBKg4vOROUBJ8pj3xLkZvaJZEqlQe1TvJL8ktjBpCR43btZnBVLF
         AP28sfJJasB4I4lHVFtHLlbiPvk0RV3aJEhGE+d9TPZo7+LuBl/NoEnKiY/E8K1on+H6
         uIOy7ZT55g/w8BUky5b7K2bG9w5XlfB908Tcjvimy5ysdGAXQ05Mzi22LvBflAW1tPb8
         xsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G82XXP8YiGLQfQ4GwG8HsWwFaR0GhQtI+Q+SWa4TYsU=;
        b=SW5U9YrMLVeulHLbZkchjb3qTGNnEBUTa7aFN40Yn1QO7O+D6FSV/07OHWOUlSa/J3
         ATGtV+rRjRoQhNDOAkBLSte8hGREvP9YEwrJ5A6r+btTTniRrkjI0J8zeBq0qILkReNx
         ONmB1q9UA4rY2gRcpfwZMaGNiQwToVxXR7aPCAr52qLtuLNHki/h4+/A0jH6MWaHBmI5
         C7c9e9xh9wHFUzisHBOFBximyW0nq2CicZTkTyz9PHHeldubVw0iDmotHwHgkF4SQpwn
         H4wugm2QNHPj2oSBtj6XCRnuG70H341LimWOG9mWj8LNBA2sBMW47O99g8T4g27zF3TZ
         tprw==
X-Gm-Message-State: APjAAAWakwo/eSOjz/BKlEASeWZKncfqfTwbtwMFNNOPmNY8crR4Mbb9
        RGjLDuUN7ocuyyRI/BvVvCJWHAXkoac=
X-Google-Smtp-Source: APXvYqy8G2wknJL9IA8Ofb1dxCXkzEb0sBc3h0gqjYaIH4rvtb6nIgDaV1nBQW2pZb2bqej1hV7ezA==
X-Received: by 2002:a37:6352:: with SMTP id x79mr25765756qkb.133.1557877783532;
        Tue, 14 May 2019 16:49:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id e25sm372861qta.18.2019.05.14.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAx-0001OI-Ei; Tue, 14 May 2019 20:49:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 17/20] ibdiags: Flatten the infiniband-diags tools into one directory
Date:   Tue, 14 May 2019 20:49:33 -0300
Message-Id: <20190514234936.5175-18-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514234936.5175-1-jgg@ziepe.ca>
References: <20190514234936.5175-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The scripts get their own directory as they are largely considered
obsolete now.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 CMakeLists.txt                                |  7 +++---
 ibdiags/man/CMakeLists.txt                    | 22 ------------------
 .../src => infiniband-diags}/CMakeLists.txt   |  9 ++++++--
 {ibdiags/src => infiniband-diags}/dump_fts.c  |  0
 .../etc/error_thresholds                      |  0
 {ibdiags => infiniband-diags}/etc/ibdiag.conf |  0
 {ibdiags/src => infiniband-diags}/ibaddr.c    |  0
 .../src => infiniband-diags}/ibcacheedit.c    |  0
 .../src => infiniband-diags}/ibccconfig.c     |  0
 {ibdiags/src => infiniband-diags}/ibccquery.c |  0
 .../src => infiniband-diags}/ibdiag_common.c  |  0
 .../ibdiag_common.h                           |  0
 {ibdiags/src => infiniband-diags}/ibdiag_sa.c |  0
 .../include => infiniband-diags}/ibdiag_sa.h  |  0
 .../src => infiniband-diags}/iblinkinfo.c     |  0
 .../src => infiniband-diags}/ibnetdiscover.c  |  0
 {ibdiags/src => infiniband-diags}/ibping.c    |  0
 .../src => infiniband-diags}/ibportstate.c    |  0
 .../src => infiniband-diags}/ibqueryerrors.c  |  0
 {ibdiags/src => infiniband-diags}/ibroute.c   |  0
 .../src => infiniband-diags}/ibsendtrap.c     |  0
 {ibdiags/src => infiniband-diags}/ibstat.c    |  0
 {ibdiags/src => infiniband-diags}/ibsysstat.c |  0
 {ibdiags/src => infiniband-diags}/ibtracert.c |  0
 .../man}/CMakeLists.txt                       | 23 +++++++++++++++++++
 .../man}/check_lft_balance.8.in.rst           |  0
 .../man}/common/opt_C.rst                     |  0
 .../man}/common/opt_D.rst                     |  0
 .../man}/common/opt_D_with_param.rst          |  0
 .../man}/common/opt_G.rst                     |  0
 .../man}/common/opt_G_with_param.rst          |  0
 .../man}/common/opt_K.rst                     |  0
 .../man}/common/opt_L.rst                     |  0
 .../man}/common/opt_P.rst                     |  0
 .../man}/common/opt_V.rst                     |  0
 .../man}/common/opt_cache.rst                 |  0
 .../man}/common/opt_d.rst                     |  0
 .../man}/common/opt_diff.rst                  |  0
 .../man}/common/opt_diffcheck.rst             |  0
 .../man}/common/opt_e.rst                     |  0
 .../man}/common/opt_h.rst                     |  0
 .../man}/common/opt_load-cache.rst            |  0
 .../man}/common/opt_node_name_map.rst         |  0
 .../man}/common/opt_o-outstanding_smps.rst    |  0
 .../man}/common/opt_ports-file.rst            |  0
 .../man}/common/opt_s.rst                     |  0
 .../man}/common/opt_t.rst                     |  0
 .../man}/common/opt_v.rst                     |  0
 .../man}/common/opt_y.rst                     |  0
 .../man}/common/opt_z-config.rst              |  0
 .../man}/common/sec_config-file.rst           |  0
 .../man}/common/sec_node-name-map.rst         |  0
 .../man}/common/sec_ports-file.rst            |  0
 .../man}/common/sec_portselection.rst         |  0
 .../man}/common/sec_topology-file.rst         |  0
 .../man}/dump_fts.8.in.rst                    |  0
 .../man}/ibaddr.8.in.rst                      |  0
 .../man}/ibcacheedit.8.in.rst                 |  0
 .../man}/ibccconfig.8.in.rst                  |  0
 .../man}/ibccquery.8.in.rst                   |  0
 .../man/ibcheckerrors.8                       |  0
 .../man/ibcheckerrs.8                         |  0
 .../man/ibchecknet.8                          |  0
 .../man/ibchecknode.8                         |  0
 .../man/ibcheckport.8                         |  0
 .../man/ibcheckportstate.8                    |  0
 .../man/ibcheckportwidth.8                    |  0
 .../man/ibcheckstate.8                        |  0
 .../man/ibcheckwidth.8                        |  0
 .../man/ibclearcounters.8                     |  0
 .../man/ibclearerrors.8                       |  0
 .../man/ibdatacounters.8                      |  0
 .../man/ibdatacounts.8                        |  0
 .../man/ibdiscover.8                          |  0
 .../man}/ibfindnodesusing.8.in.rst            |  0
 .../man}/ibhosts.8.in.rst                     |  0
 .../man}/ibidsverify.8.in.rst                 |  0
 .../man}/iblinkinfo.8.in.rst                  |  0
 .../man}/ibnetdiscover.8.in.rst               |  0
 .../man}/ibnodes.8.in.rst                     |  0
 .../man}/ibping.8.in.rst                      |  0
 .../man}/ibportstate.8.in.rst                 |  0
 {ibdiags => infiniband-diags}/man/ibprintca.8 |  0
 {ibdiags => infiniband-diags}/man/ibprintrt.8 |  0
 .../man/ibprintswitch.8                       |  0
 .../man}/ibqueryerrors.8.in.rst               |  0
 .../man}/ibroute.8.in.rst                     |  0
 .../man}/ibrouters.8.in.rst                   |  0
 .../man}/ibstat.8.in.rst                      |  0
 .../man}/ibstatus.8.in.rst                    |  0
 .../man}/ibswitches.8.in.rst                  |  0
 .../man/ibswportwatch.8                       |  0
 .../man}/ibsysstat.8.in.rst                   |  0
 .../man}/ibtracert.8.in.rst                   |  0
 .../man}/infiniband-diags.8.in.rst            |  0
 .../man}/perfquery.8.in.rst                   |  0
 .../man}/saquery.8.in.rst                     |  0
 .../man}/sminfo.8.in.rst                      |  0
 .../man}/smpdump.8.in.rst                     |  0
 .../man}/smpquery.8.in.rst                    |  0
 .../man}/vendstat.8.in.rst                    |  0
 .../src => infiniband-diags}/mcm_rereg_test.c |  0
 {ibdiags/src => infiniband-diags}/perfquery.c |  0
 {ibdiags/src => infiniband-diags}/saquery.c   |  0
 .../scripts/CMakeLists.txt                    |  5 ----
 .../scripts/IBswcountlimits.pm                |  0
 .../scripts/check_lft_balance.pl              |  0
 .../scripts/dump_lfts.sh.in                   |  0
 .../scripts/dump_mfts.sh.in                   |  0
 .../scripts/ibcheckerrors.in                  |  0
 .../scripts/ibcheckerrs.in                    |  0
 .../scripts/ibchecknet.in                     |  0
 .../scripts/ibchecknode.in                    |  0
 .../scripts/ibcheckport.in                    |  0
 .../scripts/ibcheckportstate.in               |  0
 .../scripts/ibcheckportwidth.in               |  0
 .../scripts/ibcheckstate.in                   |  0
 .../scripts/ibcheckwidth.in                   |  0
 .../scripts/ibclearcounters.in                |  0
 .../scripts/ibclearerrors.in                  |  0
 .../scripts/ibdatacounters.in                 |  0
 .../scripts/ibdatacounts.in                   |  0
 .../scripts/ibdiscover.map                    |  0
 .../scripts/ibdiscover.pl                     |  0
 .../scripts/ibfindnodesusing.pl               |  0
 .../scripts/ibhosts.in                        |  0
 .../scripts/ibidsverify.pl                    |  0
 .../scripts/iblinkinfo.pl.in                  |  0
 .../scripts/ibnodes.in                        |  0
 .../scripts/ibprintca.pl                      |  0
 .../scripts/ibprintrt.pl                      |  0
 .../scripts/ibprintswitch.pl                  |  0
 .../scripts/ibqueryerrors.pl.in               |  0
 .../scripts/ibrouters.in                      |  0
 .../scripts/ibstatus                          |  0
 .../scripts/ibswitches.in                     |  0
 .../scripts/ibswportwatch.pl                  |  0
 .../scripts/set_nodedesc.sh                   |  0
 {ibdiags/src => infiniband-diags}/sminfo.c    |  0
 {ibdiags/src => infiniband-diags}/smpdump.c   |  0
 {ibdiags/src => infiniband-diags}/smpquery.c  |  0
 {ibdiags/src => infiniband-diags}/vendstat.c  |  0
 142 files changed, 33 insertions(+), 33 deletions(-)
 delete mode 100644 ibdiags/man/CMakeLists.txt
 rename {ibdiags/src => infiniband-diags}/CMakeLists.txt (86%)
 rename {ibdiags/src => infiniband-diags}/dump_fts.c (100%)
 rename {ibdiags => infiniband-diags}/etc/error_thresholds (100%)
 rename {ibdiags => infiniband-diags}/etc/ibdiag.conf (100%)
 rename {ibdiags/src => infiniband-diags}/ibaddr.c (100%)
 rename {ibdiags/src => infiniband-diags}/ibcacheedit.c (100%)
 rename {ibdiags/src => infiniband-diags}/ibccconfig.c (100%)
 rename {ibdiags/src => infiniband-diags}/ibccquery.c (100%)
 rename {ibdiags/src => infiniband-diags}/ibdiag_common.c (100%)
 rename {ibdiags/include => infiniband-diags}/ibdiag_common.h (100%)
 rename {ibdiags/src => infiniband-diags}/ibdiag_sa.c (100%)
 rename {ibdiags/include => infiniband-diags}/ibdiag_sa.h (100%)
 rename {ibdiags/src => infiniband-diags}/iblinkinfo.c (100%)
 rename {ibdiags/src => infiniband-diags}/ibnetdiscover.c (100%)
 rename {ibdiags/src => infiniband-diags}/ibping.c (100%)
 rename {ibdiags/src => infiniband-diags}/ibportstate.c (100%)
 rename {ibdiags/src => infiniband-diags}/ibqueryerrors.c (100%)
 rename {ibdiags/src => infiniband-diags}/ibroute.c (100%)
 rename {ibdiags/src => infiniband-diags}/ibsendtrap.c (100%)
 rename {ibdiags/src => infiniband-diags}/ibstat.c (100%)
 rename {ibdiags/src => infiniband-diags}/ibsysstat.c (100%)
 rename {ibdiags/src => infiniband-diags}/ibtracert.c (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/CMakeLists.txt (68%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/check_lft_balance.8.in.rst (100%)
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
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/opt_z-config.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/sec_config-file.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/sec_node-name-map.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/sec_ports-file.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/sec_portselection.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/common/sec_topology-file.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/dump_fts.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibaddr.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibcacheedit.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibccconfig.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibccquery.8.in.rst (100%)
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
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibfindnodesusing.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibhosts.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibidsverify.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/iblinkinfo.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibnetdiscover.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibnodes.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibping.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibportstate.8.in.rst (100%)
 rename {ibdiags => infiniband-diags}/man/ibprintca.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibprintrt.8 (100%)
 rename {ibdiags => infiniband-diags}/man/ibprintswitch.8 (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibqueryerrors.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibroute.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibrouters.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibstat.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibstatus.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibswitches.8.in.rst (100%)
 rename {ibdiags => infiniband-diags}/man/ibswportwatch.8 (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibsysstat.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/ibtracert.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/infiniband-diags.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/perfquery.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/saquery.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/sminfo.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/smpdump.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/smpquery.8.in.rst (100%)
 rename {ibdiags/doc/rst => infiniband-diags/man}/vendstat.8.in.rst (100%)
 rename {ibdiags/src => infiniband-diags}/mcm_rereg_test.c (100%)
 rename {ibdiags/src => infiniband-diags}/perfquery.c (100%)
 rename {ibdiags/src => infiniband-diags}/saquery.c (100%)
 rename {ibdiags => infiniband-diags}/scripts/CMakeLists.txt (96%)
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
 rename {ibdiags/src => infiniband-diags}/sminfo.c (100%)
 rename {ibdiags/src => infiniband-diags}/smpdump.c (100%)
 rename {ibdiags/src => infiniband-diags}/smpquery.c (100%)
 rename {ibdiags/src => infiniband-diags}/vendstat.c (100%)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 7b048a0fa164c1..c6b5b3ddd815b9 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -620,10 +620,9 @@ add_subdirectory(providers/rxe/man)
 add_subdirectory(libibmad)
 add_subdirectory(libibnetdisc)
 add_subdirectory(libibnetdisc/man)
-add_subdirectory(ibdiags/src)
-add_subdirectory(ibdiags/scripts)
-add_subdirectory(ibdiags/man)
-add_subdirectory(ibdiags/doc/rst)
+add_subdirectory(infiniband-diags)
+add_subdirectory(infiniband-diags/scripts)
+add_subdirectory(infiniband-diags/man)
 
 if (CYTHON_EXECUTABLE)
   add_subdirectory(pyverbs)
diff --git a/ibdiags/man/CMakeLists.txt b/ibdiags/man/CMakeLists.txt
deleted file mode 100644
index 2446acbb522c86..00000000000000
diff --git a/ibdiags/src/CMakeLists.txt b/infiniband-diags/CMakeLists.txt
similarity index 86%
rename from ibdiags/src/CMakeLists.txt
rename to infiniband-diags/CMakeLists.txt
index b28f543f2f0699..6301e8e0210af7 100644
--- a/ibdiags/src/CMakeLists.txt
+++ b/infiniband-diags/CMakeLists.txt
@@ -1,8 +1,13 @@
 publish_internal_headers(""
-  ../include/ibdiag_common.h
-  ../include/ibdiag_sa.h
+  ibdiag_common.h
+  ibdiag_sa.h
   )
 
+install(FILES
+  etc/error_thresholds
+  etc/ibdiag.conf
+  DESTINATION "${IBDIAG_CONFIG_PATH}")
+
 add_library(ibdiags_tools STATIC
   ibdiag_common.c
   ibdiag_sa.c
diff --git a/ibdiags/src/dump_fts.c b/infiniband-diags/dump_fts.c
similarity index 100%
rename from ibdiags/src/dump_fts.c
rename to infiniband-diags/dump_fts.c
diff --git a/ibdiags/etc/error_thresholds b/infiniband-diags/etc/error_thresholds
similarity index 100%
rename from ibdiags/etc/error_thresholds
rename to infiniband-diags/etc/error_thresholds
diff --git a/ibdiags/etc/ibdiag.conf b/infiniband-diags/etc/ibdiag.conf
similarity index 100%
rename from ibdiags/etc/ibdiag.conf
rename to infiniband-diags/etc/ibdiag.conf
diff --git a/ibdiags/src/ibaddr.c b/infiniband-diags/ibaddr.c
similarity index 100%
rename from ibdiags/src/ibaddr.c
rename to infiniband-diags/ibaddr.c
diff --git a/ibdiags/src/ibcacheedit.c b/infiniband-diags/ibcacheedit.c
similarity index 100%
rename from ibdiags/src/ibcacheedit.c
rename to infiniband-diags/ibcacheedit.c
diff --git a/ibdiags/src/ibccconfig.c b/infiniband-diags/ibccconfig.c
similarity index 100%
rename from ibdiags/src/ibccconfig.c
rename to infiniband-diags/ibccconfig.c
diff --git a/ibdiags/src/ibccquery.c b/infiniband-diags/ibccquery.c
similarity index 100%
rename from ibdiags/src/ibccquery.c
rename to infiniband-diags/ibccquery.c
diff --git a/ibdiags/src/ibdiag_common.c b/infiniband-diags/ibdiag_common.c
similarity index 100%
rename from ibdiags/src/ibdiag_common.c
rename to infiniband-diags/ibdiag_common.c
diff --git a/ibdiags/include/ibdiag_common.h b/infiniband-diags/ibdiag_common.h
similarity index 100%
rename from ibdiags/include/ibdiag_common.h
rename to infiniband-diags/ibdiag_common.h
diff --git a/ibdiags/src/ibdiag_sa.c b/infiniband-diags/ibdiag_sa.c
similarity index 100%
rename from ibdiags/src/ibdiag_sa.c
rename to infiniband-diags/ibdiag_sa.c
diff --git a/ibdiags/include/ibdiag_sa.h b/infiniband-diags/ibdiag_sa.h
similarity index 100%
rename from ibdiags/include/ibdiag_sa.h
rename to infiniband-diags/ibdiag_sa.h
diff --git a/ibdiags/src/iblinkinfo.c b/infiniband-diags/iblinkinfo.c
similarity index 100%
rename from ibdiags/src/iblinkinfo.c
rename to infiniband-diags/iblinkinfo.c
diff --git a/ibdiags/src/ibnetdiscover.c b/infiniband-diags/ibnetdiscover.c
similarity index 100%
rename from ibdiags/src/ibnetdiscover.c
rename to infiniband-diags/ibnetdiscover.c
diff --git a/ibdiags/src/ibping.c b/infiniband-diags/ibping.c
similarity index 100%
rename from ibdiags/src/ibping.c
rename to infiniband-diags/ibping.c
diff --git a/ibdiags/src/ibportstate.c b/infiniband-diags/ibportstate.c
similarity index 100%
rename from ibdiags/src/ibportstate.c
rename to infiniband-diags/ibportstate.c
diff --git a/ibdiags/src/ibqueryerrors.c b/infiniband-diags/ibqueryerrors.c
similarity index 100%
rename from ibdiags/src/ibqueryerrors.c
rename to infiniband-diags/ibqueryerrors.c
diff --git a/ibdiags/src/ibroute.c b/infiniband-diags/ibroute.c
similarity index 100%
rename from ibdiags/src/ibroute.c
rename to infiniband-diags/ibroute.c
diff --git a/ibdiags/src/ibsendtrap.c b/infiniband-diags/ibsendtrap.c
similarity index 100%
rename from ibdiags/src/ibsendtrap.c
rename to infiniband-diags/ibsendtrap.c
diff --git a/ibdiags/src/ibstat.c b/infiniband-diags/ibstat.c
similarity index 100%
rename from ibdiags/src/ibstat.c
rename to infiniband-diags/ibstat.c
diff --git a/ibdiags/src/ibsysstat.c b/infiniband-diags/ibsysstat.c
similarity index 100%
rename from ibdiags/src/ibsysstat.c
rename to infiniband-diags/ibsysstat.c
diff --git a/ibdiags/src/ibtracert.c b/infiniband-diags/ibtracert.c
similarity index 100%
rename from ibdiags/src/ibtracert.c
rename to infiniband-diags/ibtracert.c
diff --git a/ibdiags/doc/rst/CMakeLists.txt b/infiniband-diags/man/CMakeLists.txt
similarity index 68%
rename from ibdiags/doc/rst/CMakeLists.txt
rename to infiniband-diags/man/CMakeLists.txt
index f0e4072306a57c..845fff675f23d4 100644
--- a/ibdiags/doc/rst/CMakeLists.txt
+++ b/infiniband-diags/man/CMakeLists.txt
@@ -39,3 +39,26 @@ rdma_alias_man_pages(
   dump_fts.8 dump_lfts.8
   dump_fts.8 dump_mfts.8
   )
+
+if (WITH_IBDIAGS_COMPAT)
+  rdma_man_pages(
+    ibcheckerrors.8
+    ibcheckerrs.8
+    ibchecknet.8
+    ibchecknode.8
+    ibcheckport.8
+    ibcheckportstate.8
+    ibcheckportwidth.8
+    ibcheckstate.8
+    ibcheckwidth.8
+    ibclearcounters.8
+    ibclearerrors.8
+    ibdatacounters.8
+    ibdatacounts.8
+    ibdiscover.8
+    ibprintca.8
+    ibprintrt.8
+    ibprintswitch.8
+    ibswportwatch.8
+    )
+endif()
diff --git a/ibdiags/doc/rst/check_lft_balance.8.in.rst b/infiniband-diags/man/check_lft_balance.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/check_lft_balance.8.in.rst
rename to infiniband-diags/man/check_lft_balance.8.in.rst
diff --git a/ibdiags/doc/rst/common/opt_C.rst b/infiniband-diags/man/common/opt_C.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_C.rst
rename to infiniband-diags/man/common/opt_C.rst
diff --git a/ibdiags/doc/rst/common/opt_D.rst b/infiniband-diags/man/common/opt_D.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_D.rst
rename to infiniband-diags/man/common/opt_D.rst
diff --git a/ibdiags/doc/rst/common/opt_D_with_param.rst b/infiniband-diags/man/common/opt_D_with_param.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_D_with_param.rst
rename to infiniband-diags/man/common/opt_D_with_param.rst
diff --git a/ibdiags/doc/rst/common/opt_G.rst b/infiniband-diags/man/common/opt_G.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_G.rst
rename to infiniband-diags/man/common/opt_G.rst
diff --git a/ibdiags/doc/rst/common/opt_G_with_param.rst b/infiniband-diags/man/common/opt_G_with_param.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_G_with_param.rst
rename to infiniband-diags/man/common/opt_G_with_param.rst
diff --git a/ibdiags/doc/rst/common/opt_K.rst b/infiniband-diags/man/common/opt_K.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_K.rst
rename to infiniband-diags/man/common/opt_K.rst
diff --git a/ibdiags/doc/rst/common/opt_L.rst b/infiniband-diags/man/common/opt_L.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_L.rst
rename to infiniband-diags/man/common/opt_L.rst
diff --git a/ibdiags/doc/rst/common/opt_P.rst b/infiniband-diags/man/common/opt_P.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_P.rst
rename to infiniband-diags/man/common/opt_P.rst
diff --git a/ibdiags/doc/rst/common/opt_V.rst b/infiniband-diags/man/common/opt_V.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_V.rst
rename to infiniband-diags/man/common/opt_V.rst
diff --git a/ibdiags/doc/rst/common/opt_cache.rst b/infiniband-diags/man/common/opt_cache.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_cache.rst
rename to infiniband-diags/man/common/opt_cache.rst
diff --git a/ibdiags/doc/rst/common/opt_d.rst b/infiniband-diags/man/common/opt_d.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_d.rst
rename to infiniband-diags/man/common/opt_d.rst
diff --git a/ibdiags/doc/rst/common/opt_diff.rst b/infiniband-diags/man/common/opt_diff.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_diff.rst
rename to infiniband-diags/man/common/opt_diff.rst
diff --git a/ibdiags/doc/rst/common/opt_diffcheck.rst b/infiniband-diags/man/common/opt_diffcheck.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_diffcheck.rst
rename to infiniband-diags/man/common/opt_diffcheck.rst
diff --git a/ibdiags/doc/rst/common/opt_e.rst b/infiniband-diags/man/common/opt_e.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_e.rst
rename to infiniband-diags/man/common/opt_e.rst
diff --git a/ibdiags/doc/rst/common/opt_h.rst b/infiniband-diags/man/common/opt_h.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_h.rst
rename to infiniband-diags/man/common/opt_h.rst
diff --git a/ibdiags/doc/rst/common/opt_load-cache.rst b/infiniband-diags/man/common/opt_load-cache.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_load-cache.rst
rename to infiniband-diags/man/common/opt_load-cache.rst
diff --git a/ibdiags/doc/rst/common/opt_node_name_map.rst b/infiniband-diags/man/common/opt_node_name_map.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_node_name_map.rst
rename to infiniband-diags/man/common/opt_node_name_map.rst
diff --git a/ibdiags/doc/rst/common/opt_o-outstanding_smps.rst b/infiniband-diags/man/common/opt_o-outstanding_smps.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_o-outstanding_smps.rst
rename to infiniband-diags/man/common/opt_o-outstanding_smps.rst
diff --git a/ibdiags/doc/rst/common/opt_ports-file.rst b/infiniband-diags/man/common/opt_ports-file.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_ports-file.rst
rename to infiniband-diags/man/common/opt_ports-file.rst
diff --git a/ibdiags/doc/rst/common/opt_s.rst b/infiniband-diags/man/common/opt_s.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_s.rst
rename to infiniband-diags/man/common/opt_s.rst
diff --git a/ibdiags/doc/rst/common/opt_t.rst b/infiniband-diags/man/common/opt_t.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_t.rst
rename to infiniband-diags/man/common/opt_t.rst
diff --git a/ibdiags/doc/rst/common/opt_v.rst b/infiniband-diags/man/common/opt_v.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_v.rst
rename to infiniband-diags/man/common/opt_v.rst
diff --git a/ibdiags/doc/rst/common/opt_y.rst b/infiniband-diags/man/common/opt_y.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_y.rst
rename to infiniband-diags/man/common/opt_y.rst
diff --git a/ibdiags/doc/rst/common/opt_z-config.rst b/infiniband-diags/man/common/opt_z-config.rst
similarity index 100%
rename from ibdiags/doc/rst/common/opt_z-config.rst
rename to infiniband-diags/man/common/opt_z-config.rst
diff --git a/ibdiags/doc/rst/common/sec_config-file.rst b/infiniband-diags/man/common/sec_config-file.rst
similarity index 100%
rename from ibdiags/doc/rst/common/sec_config-file.rst
rename to infiniband-diags/man/common/sec_config-file.rst
diff --git a/ibdiags/doc/rst/common/sec_node-name-map.rst b/infiniband-diags/man/common/sec_node-name-map.rst
similarity index 100%
rename from ibdiags/doc/rst/common/sec_node-name-map.rst
rename to infiniband-diags/man/common/sec_node-name-map.rst
diff --git a/ibdiags/doc/rst/common/sec_ports-file.rst b/infiniband-diags/man/common/sec_ports-file.rst
similarity index 100%
rename from ibdiags/doc/rst/common/sec_ports-file.rst
rename to infiniband-diags/man/common/sec_ports-file.rst
diff --git a/ibdiags/doc/rst/common/sec_portselection.rst b/infiniband-diags/man/common/sec_portselection.rst
similarity index 100%
rename from ibdiags/doc/rst/common/sec_portselection.rst
rename to infiniband-diags/man/common/sec_portselection.rst
diff --git a/ibdiags/doc/rst/common/sec_topology-file.rst b/infiniband-diags/man/common/sec_topology-file.rst
similarity index 100%
rename from ibdiags/doc/rst/common/sec_topology-file.rst
rename to infiniband-diags/man/common/sec_topology-file.rst
diff --git a/ibdiags/doc/rst/dump_fts.8.in.rst b/infiniband-diags/man/dump_fts.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/dump_fts.8.in.rst
rename to infiniband-diags/man/dump_fts.8.in.rst
diff --git a/ibdiags/doc/rst/ibaddr.8.in.rst b/infiniband-diags/man/ibaddr.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibaddr.8.in.rst
rename to infiniband-diags/man/ibaddr.8.in.rst
diff --git a/ibdiags/doc/rst/ibcacheedit.8.in.rst b/infiniband-diags/man/ibcacheedit.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibcacheedit.8.in.rst
rename to infiniband-diags/man/ibcacheedit.8.in.rst
diff --git a/ibdiags/doc/rst/ibccconfig.8.in.rst b/infiniband-diags/man/ibccconfig.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibccconfig.8.in.rst
rename to infiniband-diags/man/ibccconfig.8.in.rst
diff --git a/ibdiags/doc/rst/ibccquery.8.in.rst b/infiniband-diags/man/ibccquery.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibccquery.8.in.rst
rename to infiniband-diags/man/ibccquery.8.in.rst
diff --git a/ibdiags/man/ibcheckerrors.8 b/infiniband-diags/man/ibcheckerrors.8
similarity index 100%
rename from ibdiags/man/ibcheckerrors.8
rename to infiniband-diags/man/ibcheckerrors.8
diff --git a/ibdiags/man/ibcheckerrs.8 b/infiniband-diags/man/ibcheckerrs.8
similarity index 100%
rename from ibdiags/man/ibcheckerrs.8
rename to infiniband-diags/man/ibcheckerrs.8
diff --git a/ibdiags/man/ibchecknet.8 b/infiniband-diags/man/ibchecknet.8
similarity index 100%
rename from ibdiags/man/ibchecknet.8
rename to infiniband-diags/man/ibchecknet.8
diff --git a/ibdiags/man/ibchecknode.8 b/infiniband-diags/man/ibchecknode.8
similarity index 100%
rename from ibdiags/man/ibchecknode.8
rename to infiniband-diags/man/ibchecknode.8
diff --git a/ibdiags/man/ibcheckport.8 b/infiniband-diags/man/ibcheckport.8
similarity index 100%
rename from ibdiags/man/ibcheckport.8
rename to infiniband-diags/man/ibcheckport.8
diff --git a/ibdiags/man/ibcheckportstate.8 b/infiniband-diags/man/ibcheckportstate.8
similarity index 100%
rename from ibdiags/man/ibcheckportstate.8
rename to infiniband-diags/man/ibcheckportstate.8
diff --git a/ibdiags/man/ibcheckportwidth.8 b/infiniband-diags/man/ibcheckportwidth.8
similarity index 100%
rename from ibdiags/man/ibcheckportwidth.8
rename to infiniband-diags/man/ibcheckportwidth.8
diff --git a/ibdiags/man/ibcheckstate.8 b/infiniband-diags/man/ibcheckstate.8
similarity index 100%
rename from ibdiags/man/ibcheckstate.8
rename to infiniband-diags/man/ibcheckstate.8
diff --git a/ibdiags/man/ibcheckwidth.8 b/infiniband-diags/man/ibcheckwidth.8
similarity index 100%
rename from ibdiags/man/ibcheckwidth.8
rename to infiniband-diags/man/ibcheckwidth.8
diff --git a/ibdiags/man/ibclearcounters.8 b/infiniband-diags/man/ibclearcounters.8
similarity index 100%
rename from ibdiags/man/ibclearcounters.8
rename to infiniband-diags/man/ibclearcounters.8
diff --git a/ibdiags/man/ibclearerrors.8 b/infiniband-diags/man/ibclearerrors.8
similarity index 100%
rename from ibdiags/man/ibclearerrors.8
rename to infiniband-diags/man/ibclearerrors.8
diff --git a/ibdiags/man/ibdatacounters.8 b/infiniband-diags/man/ibdatacounters.8
similarity index 100%
rename from ibdiags/man/ibdatacounters.8
rename to infiniband-diags/man/ibdatacounters.8
diff --git a/ibdiags/man/ibdatacounts.8 b/infiniband-diags/man/ibdatacounts.8
similarity index 100%
rename from ibdiags/man/ibdatacounts.8
rename to infiniband-diags/man/ibdatacounts.8
diff --git a/ibdiags/man/ibdiscover.8 b/infiniband-diags/man/ibdiscover.8
similarity index 100%
rename from ibdiags/man/ibdiscover.8
rename to infiniband-diags/man/ibdiscover.8
diff --git a/ibdiags/doc/rst/ibfindnodesusing.8.in.rst b/infiniband-diags/man/ibfindnodesusing.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibfindnodesusing.8.in.rst
rename to infiniband-diags/man/ibfindnodesusing.8.in.rst
diff --git a/ibdiags/doc/rst/ibhosts.8.in.rst b/infiniband-diags/man/ibhosts.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibhosts.8.in.rst
rename to infiniband-diags/man/ibhosts.8.in.rst
diff --git a/ibdiags/doc/rst/ibidsverify.8.in.rst b/infiniband-diags/man/ibidsverify.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibidsverify.8.in.rst
rename to infiniband-diags/man/ibidsverify.8.in.rst
diff --git a/ibdiags/doc/rst/iblinkinfo.8.in.rst b/infiniband-diags/man/iblinkinfo.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/iblinkinfo.8.in.rst
rename to infiniband-diags/man/iblinkinfo.8.in.rst
diff --git a/ibdiags/doc/rst/ibnetdiscover.8.in.rst b/infiniband-diags/man/ibnetdiscover.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibnetdiscover.8.in.rst
rename to infiniband-diags/man/ibnetdiscover.8.in.rst
diff --git a/ibdiags/doc/rst/ibnodes.8.in.rst b/infiniband-diags/man/ibnodes.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibnodes.8.in.rst
rename to infiniband-diags/man/ibnodes.8.in.rst
diff --git a/ibdiags/doc/rst/ibping.8.in.rst b/infiniband-diags/man/ibping.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibping.8.in.rst
rename to infiniband-diags/man/ibping.8.in.rst
diff --git a/ibdiags/doc/rst/ibportstate.8.in.rst b/infiniband-diags/man/ibportstate.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibportstate.8.in.rst
rename to infiniband-diags/man/ibportstate.8.in.rst
diff --git a/ibdiags/man/ibprintca.8 b/infiniband-diags/man/ibprintca.8
similarity index 100%
rename from ibdiags/man/ibprintca.8
rename to infiniband-diags/man/ibprintca.8
diff --git a/ibdiags/man/ibprintrt.8 b/infiniband-diags/man/ibprintrt.8
similarity index 100%
rename from ibdiags/man/ibprintrt.8
rename to infiniband-diags/man/ibprintrt.8
diff --git a/ibdiags/man/ibprintswitch.8 b/infiniband-diags/man/ibprintswitch.8
similarity index 100%
rename from ibdiags/man/ibprintswitch.8
rename to infiniband-diags/man/ibprintswitch.8
diff --git a/ibdiags/doc/rst/ibqueryerrors.8.in.rst b/infiniband-diags/man/ibqueryerrors.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibqueryerrors.8.in.rst
rename to infiniband-diags/man/ibqueryerrors.8.in.rst
diff --git a/ibdiags/doc/rst/ibroute.8.in.rst b/infiniband-diags/man/ibroute.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibroute.8.in.rst
rename to infiniband-diags/man/ibroute.8.in.rst
diff --git a/ibdiags/doc/rst/ibrouters.8.in.rst b/infiniband-diags/man/ibrouters.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibrouters.8.in.rst
rename to infiniband-diags/man/ibrouters.8.in.rst
diff --git a/ibdiags/doc/rst/ibstat.8.in.rst b/infiniband-diags/man/ibstat.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibstat.8.in.rst
rename to infiniband-diags/man/ibstat.8.in.rst
diff --git a/ibdiags/doc/rst/ibstatus.8.in.rst b/infiniband-diags/man/ibstatus.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibstatus.8.in.rst
rename to infiniband-diags/man/ibstatus.8.in.rst
diff --git a/ibdiags/doc/rst/ibswitches.8.in.rst b/infiniband-diags/man/ibswitches.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibswitches.8.in.rst
rename to infiniband-diags/man/ibswitches.8.in.rst
diff --git a/ibdiags/man/ibswportwatch.8 b/infiniband-diags/man/ibswportwatch.8
similarity index 100%
rename from ibdiags/man/ibswportwatch.8
rename to infiniband-diags/man/ibswportwatch.8
diff --git a/ibdiags/doc/rst/ibsysstat.8.in.rst b/infiniband-diags/man/ibsysstat.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibsysstat.8.in.rst
rename to infiniband-diags/man/ibsysstat.8.in.rst
diff --git a/ibdiags/doc/rst/ibtracert.8.in.rst b/infiniband-diags/man/ibtracert.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/ibtracert.8.in.rst
rename to infiniband-diags/man/ibtracert.8.in.rst
diff --git a/ibdiags/doc/rst/infiniband-diags.8.in.rst b/infiniband-diags/man/infiniband-diags.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/infiniband-diags.8.in.rst
rename to infiniband-diags/man/infiniband-diags.8.in.rst
diff --git a/ibdiags/doc/rst/perfquery.8.in.rst b/infiniband-diags/man/perfquery.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/perfquery.8.in.rst
rename to infiniband-diags/man/perfquery.8.in.rst
diff --git a/ibdiags/doc/rst/saquery.8.in.rst b/infiniband-diags/man/saquery.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/saquery.8.in.rst
rename to infiniband-diags/man/saquery.8.in.rst
diff --git a/ibdiags/doc/rst/sminfo.8.in.rst b/infiniband-diags/man/sminfo.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/sminfo.8.in.rst
rename to infiniband-diags/man/sminfo.8.in.rst
diff --git a/ibdiags/doc/rst/smpdump.8.in.rst b/infiniband-diags/man/smpdump.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/smpdump.8.in.rst
rename to infiniband-diags/man/smpdump.8.in.rst
diff --git a/ibdiags/doc/rst/smpquery.8.in.rst b/infiniband-diags/man/smpquery.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/smpquery.8.in.rst
rename to infiniband-diags/man/smpquery.8.in.rst
diff --git a/ibdiags/doc/rst/vendstat.8.in.rst b/infiniband-diags/man/vendstat.8.in.rst
similarity index 100%
rename from ibdiags/doc/rst/vendstat.8.in.rst
rename to infiniband-diags/man/vendstat.8.in.rst
diff --git a/ibdiags/src/mcm_rereg_test.c b/infiniband-diags/mcm_rereg_test.c
similarity index 100%
rename from ibdiags/src/mcm_rereg_test.c
rename to infiniband-diags/mcm_rereg_test.c
diff --git a/ibdiags/src/perfquery.c b/infiniband-diags/perfquery.c
similarity index 100%
rename from ibdiags/src/perfquery.c
rename to infiniband-diags/perfquery.c
diff --git a/ibdiags/src/saquery.c b/infiniband-diags/saquery.c
similarity index 100%
rename from ibdiags/src/saquery.c
rename to infiniband-diags/saquery.c
diff --git a/ibdiags/scripts/CMakeLists.txt b/infiniband-diags/scripts/CMakeLists.txt
similarity index 96%
rename from ibdiags/scripts/CMakeLists.txt
rename to infiniband-diags/scripts/CMakeLists.txt
index 3d65ed837a2d83..ae4dcc5b7d9cbe 100644
--- a/ibdiags/scripts/CMakeLists.txt
+++ b/infiniband-diags/scripts/CMakeLists.txt
@@ -84,11 +84,6 @@ rdma_sbin_perl_program(
 install(FILES "IBswcountlimits.pm"
   DESTINATION "${CMAKE_INSTALL_PERLDIR}")
 
-install(FILES
-  "../etc/error_thresholds"
-  "../etc/ibdiag.conf"
-  DESTINATION "${IBDIAG_CONFIG_PATH}")
-
 if (WITH_IBDIAGS_COMPAT)
   rdma_sbin_shell_program(
     ibcheckerrors.in
diff --git a/ibdiags/scripts/IBswcountlimits.pm b/infiniband-diags/scripts/IBswcountlimits.pm
similarity index 100%
rename from ibdiags/scripts/IBswcountlimits.pm
rename to infiniband-diags/scripts/IBswcountlimits.pm
diff --git a/ibdiags/scripts/check_lft_balance.pl b/infiniband-diags/scripts/check_lft_balance.pl
similarity index 100%
rename from ibdiags/scripts/check_lft_balance.pl
rename to infiniband-diags/scripts/check_lft_balance.pl
diff --git a/ibdiags/scripts/dump_lfts.sh.in b/infiniband-diags/scripts/dump_lfts.sh.in
similarity index 100%
rename from ibdiags/scripts/dump_lfts.sh.in
rename to infiniband-diags/scripts/dump_lfts.sh.in
diff --git a/ibdiags/scripts/dump_mfts.sh.in b/infiniband-diags/scripts/dump_mfts.sh.in
similarity index 100%
rename from ibdiags/scripts/dump_mfts.sh.in
rename to infiniband-diags/scripts/dump_mfts.sh.in
diff --git a/ibdiags/scripts/ibcheckerrors.in b/infiniband-diags/scripts/ibcheckerrors.in
similarity index 100%
rename from ibdiags/scripts/ibcheckerrors.in
rename to infiniband-diags/scripts/ibcheckerrors.in
diff --git a/ibdiags/scripts/ibcheckerrs.in b/infiniband-diags/scripts/ibcheckerrs.in
similarity index 100%
rename from ibdiags/scripts/ibcheckerrs.in
rename to infiniband-diags/scripts/ibcheckerrs.in
diff --git a/ibdiags/scripts/ibchecknet.in b/infiniband-diags/scripts/ibchecknet.in
similarity index 100%
rename from ibdiags/scripts/ibchecknet.in
rename to infiniband-diags/scripts/ibchecknet.in
diff --git a/ibdiags/scripts/ibchecknode.in b/infiniband-diags/scripts/ibchecknode.in
similarity index 100%
rename from ibdiags/scripts/ibchecknode.in
rename to infiniband-diags/scripts/ibchecknode.in
diff --git a/ibdiags/scripts/ibcheckport.in b/infiniband-diags/scripts/ibcheckport.in
similarity index 100%
rename from ibdiags/scripts/ibcheckport.in
rename to infiniband-diags/scripts/ibcheckport.in
diff --git a/ibdiags/scripts/ibcheckportstate.in b/infiniband-diags/scripts/ibcheckportstate.in
similarity index 100%
rename from ibdiags/scripts/ibcheckportstate.in
rename to infiniband-diags/scripts/ibcheckportstate.in
diff --git a/ibdiags/scripts/ibcheckportwidth.in b/infiniband-diags/scripts/ibcheckportwidth.in
similarity index 100%
rename from ibdiags/scripts/ibcheckportwidth.in
rename to infiniband-diags/scripts/ibcheckportwidth.in
diff --git a/ibdiags/scripts/ibcheckstate.in b/infiniband-diags/scripts/ibcheckstate.in
similarity index 100%
rename from ibdiags/scripts/ibcheckstate.in
rename to infiniband-diags/scripts/ibcheckstate.in
diff --git a/ibdiags/scripts/ibcheckwidth.in b/infiniband-diags/scripts/ibcheckwidth.in
similarity index 100%
rename from ibdiags/scripts/ibcheckwidth.in
rename to infiniband-diags/scripts/ibcheckwidth.in
diff --git a/ibdiags/scripts/ibclearcounters.in b/infiniband-diags/scripts/ibclearcounters.in
similarity index 100%
rename from ibdiags/scripts/ibclearcounters.in
rename to infiniband-diags/scripts/ibclearcounters.in
diff --git a/ibdiags/scripts/ibclearerrors.in b/infiniband-diags/scripts/ibclearerrors.in
similarity index 100%
rename from ibdiags/scripts/ibclearerrors.in
rename to infiniband-diags/scripts/ibclearerrors.in
diff --git a/ibdiags/scripts/ibdatacounters.in b/infiniband-diags/scripts/ibdatacounters.in
similarity index 100%
rename from ibdiags/scripts/ibdatacounters.in
rename to infiniband-diags/scripts/ibdatacounters.in
diff --git a/ibdiags/scripts/ibdatacounts.in b/infiniband-diags/scripts/ibdatacounts.in
similarity index 100%
rename from ibdiags/scripts/ibdatacounts.in
rename to infiniband-diags/scripts/ibdatacounts.in
diff --git a/ibdiags/scripts/ibdiscover.map b/infiniband-diags/scripts/ibdiscover.map
similarity index 100%
rename from ibdiags/scripts/ibdiscover.map
rename to infiniband-diags/scripts/ibdiscover.map
diff --git a/ibdiags/scripts/ibdiscover.pl b/infiniband-diags/scripts/ibdiscover.pl
similarity index 100%
rename from ibdiags/scripts/ibdiscover.pl
rename to infiniband-diags/scripts/ibdiscover.pl
diff --git a/ibdiags/scripts/ibfindnodesusing.pl b/infiniband-diags/scripts/ibfindnodesusing.pl
similarity index 100%
rename from ibdiags/scripts/ibfindnodesusing.pl
rename to infiniband-diags/scripts/ibfindnodesusing.pl
diff --git a/ibdiags/scripts/ibhosts.in b/infiniband-diags/scripts/ibhosts.in
similarity index 100%
rename from ibdiags/scripts/ibhosts.in
rename to infiniband-diags/scripts/ibhosts.in
diff --git a/ibdiags/scripts/ibidsverify.pl b/infiniband-diags/scripts/ibidsverify.pl
similarity index 100%
rename from ibdiags/scripts/ibidsverify.pl
rename to infiniband-diags/scripts/ibidsverify.pl
diff --git a/ibdiags/scripts/iblinkinfo.pl.in b/infiniband-diags/scripts/iblinkinfo.pl.in
similarity index 100%
rename from ibdiags/scripts/iblinkinfo.pl.in
rename to infiniband-diags/scripts/iblinkinfo.pl.in
diff --git a/ibdiags/scripts/ibnodes.in b/infiniband-diags/scripts/ibnodes.in
similarity index 100%
rename from ibdiags/scripts/ibnodes.in
rename to infiniband-diags/scripts/ibnodes.in
diff --git a/ibdiags/scripts/ibprintca.pl b/infiniband-diags/scripts/ibprintca.pl
similarity index 100%
rename from ibdiags/scripts/ibprintca.pl
rename to infiniband-diags/scripts/ibprintca.pl
diff --git a/ibdiags/scripts/ibprintrt.pl b/infiniband-diags/scripts/ibprintrt.pl
similarity index 100%
rename from ibdiags/scripts/ibprintrt.pl
rename to infiniband-diags/scripts/ibprintrt.pl
diff --git a/ibdiags/scripts/ibprintswitch.pl b/infiniband-diags/scripts/ibprintswitch.pl
similarity index 100%
rename from ibdiags/scripts/ibprintswitch.pl
rename to infiniband-diags/scripts/ibprintswitch.pl
diff --git a/ibdiags/scripts/ibqueryerrors.pl.in b/infiniband-diags/scripts/ibqueryerrors.pl.in
similarity index 100%
rename from ibdiags/scripts/ibqueryerrors.pl.in
rename to infiniband-diags/scripts/ibqueryerrors.pl.in
diff --git a/ibdiags/scripts/ibrouters.in b/infiniband-diags/scripts/ibrouters.in
similarity index 100%
rename from ibdiags/scripts/ibrouters.in
rename to infiniband-diags/scripts/ibrouters.in
diff --git a/ibdiags/scripts/ibstatus b/infiniband-diags/scripts/ibstatus
similarity index 100%
rename from ibdiags/scripts/ibstatus
rename to infiniband-diags/scripts/ibstatus
diff --git a/ibdiags/scripts/ibswitches.in b/infiniband-diags/scripts/ibswitches.in
similarity index 100%
rename from ibdiags/scripts/ibswitches.in
rename to infiniband-diags/scripts/ibswitches.in
diff --git a/ibdiags/scripts/ibswportwatch.pl b/infiniband-diags/scripts/ibswportwatch.pl
similarity index 100%
rename from ibdiags/scripts/ibswportwatch.pl
rename to infiniband-diags/scripts/ibswportwatch.pl
diff --git a/ibdiags/scripts/set_nodedesc.sh b/infiniband-diags/scripts/set_nodedesc.sh
similarity index 100%
rename from ibdiags/scripts/set_nodedesc.sh
rename to infiniband-diags/scripts/set_nodedesc.sh
diff --git a/ibdiags/src/sminfo.c b/infiniband-diags/sminfo.c
similarity index 100%
rename from ibdiags/src/sminfo.c
rename to infiniband-diags/sminfo.c
diff --git a/ibdiags/src/smpdump.c b/infiniband-diags/smpdump.c
similarity index 100%
rename from ibdiags/src/smpdump.c
rename to infiniband-diags/smpdump.c
diff --git a/ibdiags/src/smpquery.c b/infiniband-diags/smpquery.c
similarity index 100%
rename from ibdiags/src/smpquery.c
rename to infiniband-diags/smpquery.c
diff --git a/ibdiags/src/vendstat.c b/infiniband-diags/vendstat.c
similarity index 100%
rename from ibdiags/src/vendstat.c
rename to infiniband-diags/vendstat.c
-- 
2.21.0

