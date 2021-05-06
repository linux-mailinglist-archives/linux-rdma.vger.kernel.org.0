Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608A2375D7F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhEFXh7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhEFXh7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:37:59 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F3BC061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=HEhI1uX59CHq4mvBJkxKLkk0tilSIJx6eBLA9GbPMt8=; b=L/iWcYdYHL0Jn2XG6S8g/nkUFe
        DkzKmCMBhIAHJA+9YuJCdOspYEJ1RiLkQZsfTxsR5BObef7i+FMKBkaG6/0LZCyYr3JeWy+LiA/aq
        6uiLAHOj1yzsz8x4Od4qZeaCdHp3GvWptWxx59vAH6zR3btBuSWQF19uDjvWEosX96AIgrvYCTq7h
        EiYbX61W2vUnmcZXOo9SJEpL1VfekIO0vt8hEbIFNn6QBHp3CyV0NP/7E+NA35pJHci5daAie3V7G
        xyNQcky7XHfo7oXCkrTJW87g/rkBjEgBosZqtKv/j/EoG5zeNEr9PkE8rjbPTQDJaBEpODE8srixu
        +zqB443hLQ91NX0/v8DbBmb1Q9GtBjf7EUXHzZsn/ntFYBwNHOmlDdF2Dh458SBtpjaBULDO7MuZ2
        UfGY9D9xGpupRBn8IbSyZ7DzFBEGqdYL3S+lZbc8DCj7kFwr2UC3HuB0y0CKdqGlhrVNHkrUofHTG
        yruV2KxiurpIxdAaq7UH4dIi;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenY7-0004I0-57; Thu, 06 May 2021 23:36:55 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 00/31] rdma/siw: fix a lot of deadlocks and use after free bugs
Date:   Fri,  7 May 2021 01:36:06 +0200
Message-Id: <cover.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bernard,

while testing with my smbdirect driver I hit a lot of
bugs in the siw.ko driver. They all cause problems where
the siw driver was not able to unload anymore and I had to
reboot the machine.

I implemented:
- a non blocking connect
- fixed a lot of bugs where siw_cep_put() was called too often.
- fixed bugs where siw_cm_upcall() confused the core IWCM logic

I have some more changes to follow, but I wanted to send them
finally out after having them one and a half year sitting in some
private branch...

Stefan Metzmacher (31):
  rdma/siw: fix warning in siw_proc_send()
  rdma/siw: call smp_mb() after mem->stag_valid = 0 in
    siw_invalidate_stag() too
  rdma/siw: remove superfluous siw_cep_put() from siw_connect() error
    path
  rdma/siw: let siw_accept() deferr RDMA_MODE until EVENT_ESTABLISHED
  rdma/siw: make use of kernel_{bind,connect,listen}()
  rdma/siw: make siw_cm_upcall() a noop without valid 'id'
  rdma/siw: split out a __siw_cep_terminate_upcall() function
  rdma/siw: use __siw_cep_terminate_upcall() for indirect
    SIW_CM_WORK_CLOSE_LLP
  rdma/siw: use __siw_cep_terminate_upcall() for SIW_CM_WORK_PEER_CLOSE
  rdma/siw: use __siw_cep_terminate_upcall() for SIW_CM_WORK_MPATIMEOUT
  rdma/siw: introduce SIW_EPSTATE_ACCEPTING/REJECTING for
    rdma_accept/rdma_reject
  rdma/siw: add some debugging of state and sk_state to the teardown
    process
  rdma/siw: handle SIW_EPSTATE_CONNECTING in
    __siw_cep_terminate_upcall()
  rdma/siw: let siw_connect() set AWAIT_MPAREP before
    siw_send_mpareqrep()
  rdma/siw: create a temporary copy of private data
  rdma/siw: use error and out logic at the end of siw_connect()
  rdma/siw: start mpa timer before calling siw_send_mpareqrep()
  rdma/siw: call the blocking kernel_bindconnect() just before
    siw_send_mpareqrep()
  rdma/siw: split out a __siw_cep_close() function
  rdma/siw: implement non-blocking connect.
  rdma/siw: let siw_listen_address() call siw_cep_alloc() first
  rdma/siw: let siw_listen_address() call siw_cep_set_inuse() early
  rdma/siw: make use of __siw_cep_close() in siw_accept()
  rdma/siw: do the full disassociation of cep and qp in
    siw_qp_llp_close()
  rdma/siw: fix double siw_cep_put() in siw_cm_work_handler()
  rdma/siw: make use of __siw_cep_close() in siw_cm_work_handler()
  rdma/siw: fix the "close" logic in siw_qp_cm_drop()
  rdma/siw: make use of __siw_cep_close() in siw_qp_cm_drop()
  rdma/siw: make use of __siw_cep_close() in siw_reject()
  rdma/siw: make use of __siw_cep_close() in siw_listen_address()
  rdma/siw: make use of __siw_cep_close() in siw_drop_listeners()

 drivers/infiniband/sw/siw/siw_cm.c    | 537 +++++++++++++++-----------
 drivers/infiniband/sw/siw/siw_cm.h    |   3 +
 drivers/infiniband/sw/siw/siw_mem.c   |   2 +
 drivers/infiniband/sw/siw/siw_qp.c    |   3 +
 drivers/infiniband/sw/siw/siw_qp_rx.c |   2 +-
 5 files changed, 316 insertions(+), 231 deletions(-)

-- 
2.25.1

