Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8567B3DDC93
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhHBPh3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 11:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbhHBPh3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Aug 2021 11:37:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A32C06175F
        for <linux-rdma@vger.kernel.org>; Mon,  2 Aug 2021 08:37:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z11so2630555edb.11
        for <linux-rdma@vger.kernel.org>; Mon, 02 Aug 2021 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=N4oV2h0KqYz1wh4MCVsUoIlQUB0CxZvz7kVPgolci2M=;
        b=rI5fWVN8aKUEZpxeyqSG7uOC8iUUriv8Z6Wb3nEvUsimb2sTsOehr3FHwseQLDKZEZ
         aG2LXp/ChVv+3BuiEZ0Xud73LnIyt2+k6OAdACsE4K7/DfWZM0vsUumW86aU6nZhio43
         Nhzgbc9vCep6PSV4XtB+gkuwEz2uCaD5l0+okmGnesOMEB38DyP2SzetIUUd3My+lVEf
         l30z7DjguOVFur9pEn+rHnR3rodvq+vjSLIDusnGPcb7NVZM+/bDqVw6J0qhkWODh7YU
         CQmwqQDJb5XFhwxdSWQjCYQkrD0sVrmgoUApfM5zTdFtdzldm+b00nnQf47qLiIO42T3
         gBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=N4oV2h0KqYz1wh4MCVsUoIlQUB0CxZvz7kVPgolci2M=;
        b=RE9Q1bXp0f2UUAJqiHP9KLpHelZYp7Xwthvy4d+ZS42i+ERQvxeIBGxft1WU/C40cu
         xSQhrA4ZUNw1/UKyiBOJGPBgwWJnq4JcqQUH+UwOhpqW1bNIhFEJIQP4KrMISRzNQKBo
         fbZwPB4g7mx8tPZSTPgipealOXbSfd5kb3PnQ7j+OrrriGnumJJ1ZPhhUiSjXRnU2nhU
         CAc9b3XHGG5yRPLeCQQo7q2bKN895IeSg9yoEe20ODZq3GnuvISFcVNcRwD+hMIIIBkC
         N9r+kf5lhHQgHlOvR5knSGsiFesxMyCzJ2odlwg1lHKnOJg+IgdpytrlHevK/yJL6D7r
         AeYw==
X-Gm-Message-State: AOAM530Stwk2ThBdupoXmJPwkeK0lR3DqePJaK4HEVEVr4NT2Z/9w8oI
        LOloNys1kmcNcE5r7jxpKgG0kNoPErxio9nWS/SgKOUQ1PU=
X-Google-Smtp-Source: ABdhPJylo55qdmslogp/d8X9yhpqOVTZzLut4583e0D1MHYT8MHSmcCv47PPfO/rxW0pn5sox+h0NlimhcqK1F4orC0=
X-Received: by 2002:aa7:d8c1:: with SMTP id k1mr19889205eds.28.1627918637750;
 Mon, 02 Aug 2021 08:37:17 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 2 Aug 2021 11:37:06 -0400
Message-ID: <CAN-5tyEiv0-Mjfq5aSpzURjAx4Uu=ydobZCQ-rKFTOUDTapo+A@mail.gmail.com>
Subject: help with "PSN sequence error" in Ubuntu 20.04 (using CX-4 or CX-6
 mellanox cards)
To:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi folks,

We are encountering an error condition (while doing NFSoRDMA) but the
problem seems to be in the RDMA core itself. The problem is that the
client at some point is ending in an RDMA NAK with "PNS Sequence
error" but the network trace shows all the PSNs are accounted for
(snippet at the bottom). It's as if the client lost its knowledge of
the current PSN.

Questions:
1. Is PSN handling done by the hardware card itself (in firmware) and
not in the kernel (making this a card/firmware specific problem)? I
was trying to look thru the rdma core/mlx5 driver code to see what
would generate a NAK with such error but wasn't able to find one. Only
found counters for nak_seq_error which made me think this is a
firmware problem.
2. If this is a kernel issue is this something that perhaps has been
fixed upstream but not present in Ubuntu?

Thank you for your help.

160 2021-07-22 13:17:52.579023 192.168.100.51 -> 192.168.100.28 NFS
v4.0 reply xid:0x0982a167 PUTFH;GETATTR (PSN: 15729419)
161 2021-07-22 13:17:52.579026 192.168.100.28 -> 192.168.100.51 RRoCE
RC_Acknowledge QP=0x017c PSN=15729419
162 2021-07-22 13:17:52.579247 192.168.100.28 -> 192.168.100.51 NFS
v4.0 call  xid:0x0a82a167 PUTFH;READDIR             DH:0xbee72168
cookie:0 verf:0x0000000000000000 count:8170
163 2021-07-22 13:17:52.579249 192.168.100.51 -> 192.168.100.28 RRoCE
RC_Acknowledge QP=0x0244 PSN=16086680
164 2021-07-22 13:17:52.579631 192.168.100.51 -> 192.168.100.28 RRoCE
RC_RDMA_WRITE_First QP=0x0244 PSN=15729420 size=4096 rkey=0x40000a13
dmalen=9824
165 2021-07-22 13:17:52.579644 192.168.100.51 -> 192.168.100.28 RRoCE
RC_RDMA_WRITE_Middle QP=0x0244 PSN=15729421 size=4096
166 2021-07-22 13:17:52.579652 192.168.100.51 -> 192.168.100.28 RRoCE
RC_RDMA_WRITE_Last QP=0x0244 PSN=15729422 size=1632
167 2021-07-22 13:17:52.579653 192.168.100.51 -> 192.168.100.28 NFS
v4.0 reply xid:0x0a82a167 PUTFH;READDIR
verf:0x0000000000000000 eof:TRUE (PSN: 15729423)
168 2021-07-22 13:17:52.579653 192.168.100.28 -> 192.168.100.51 RRoCE
RC_Acknowledge QP=0x017c PSN=15729420 PSN_SEQ_ERR
