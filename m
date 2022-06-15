Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D00354CCCA
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 17:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353475AbiFOP1u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353431AbiFOP1O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 11:27:14 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7E6403E3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=+Y32Wl6FCV1kUINAe5LvZMOBrJqeRWkl2vDxA2k/t08=; b=mKSLPtKCDEgMOtX7vcSBqXwk9C
        FJ2Fao5kiq9qYF2tMEOB4cD22VUywpRcpS+RmQr3z9/wGxVQOdKyzE2RPSfX7o3DLAH/F8UygSL24
        81SH/sjBYc2qa8AwBmQ68bNjdVE1ptL93rgVle/05YehKI3L7KAhJ4mWbn9z9U71FY/3K/503XToX
        c3n78Oxot15PEjTszNZuwyaAL9WkJ4PH9TdYnjv580YmX2nL/XK9x3tGCNkfjyexbXWTYW3h3MPEG
        XGgmNeYJBtqDJdy4GsioRRQcA1cSUF3MnnR4V7vX+zF/q2zwGA+CzEhkYY4gg96XuIClmpPbk6CEm
        q3raEitOudLptgt6HQUB092TlWKVXL1ZN7fMpV5wYGZ1i2D6wnm0UG8izAh16kBfSJqL3OeCg9nEq
        K2KEIWG1Zwblbt4ezFUVhpgLvvEjLrW9WdD29/iC9h2VtME5CvQIHV7aNPrEHMWdnp+vZcmlsKWqg
        achJ37tmRQUL9ii7ebBWKcmN;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1Uv5-005rsr-9b; Wed, 15 Jun 2022 15:26:59 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     Stefan Metzmacher <metze@samba.org>, linux-rdma@vger.kernel.org
Subject: [PATCH v2 00/14] rdma/siw: implement non-blocking connect
Date:   Wed, 15 Jun 2022 17:26:38 +0200
Message-Id: <cover.1655305567.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655248086.git.metze@samba.org>
References: <cover.1655248086.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bernard,

as written a few month ago, I have a patchset with a lot
of fixes for siw.ko.

As requested I'm only send isolated chunks for easier review.

This is the first chunk adressing deadlocks in siw_connect()

The RDMA application layer expects rdma_connect() to be non-blocking
as the completion is handled via RDMA_CM_EVENT_ESTABLISHED and
other async events. It's not unlikely to hold a lock during
the rdma_connect() call.

Without out this a connection attempt to a non-existing/reachable
server block until the very long tcp timeout hits.
The application layer had no chance to have its own timeout handler
as that would just deadlock with the already blocking rdma_connect().

First rdma_connect() holds id_priv->handler_mutex and deadlocks
rdma_destroy_id().

And iw_cm_connect() called from within rdma_connect() sets
IWCM_F_CONNECT_WAIT during the call to cm_id->device->ops.iw_connect(),
siw_connect() in this case. It means that iw_cm_disconnect()
and iw_destroy_cm_id() will both deadlock waiting for
IWCM_F_CONNECT_WAIT being cleared.

Patch 1: Fixes a refcounting problem

Patches 2-7: Intruduces __siw_cep_terminate_upcall()
making he upcall handling much more consistent handling
more state combinations.

Patches 8-13 are preparation patches to siw_connect()
in order to do the real non-blocking split in Patch 14.

Please have a look.

Thanks!
metze

Fixed issues in v2:
- Include more preparation patches related to __siw_cep_terminate_upcall()
  bases on review from Cheng Xu <chengyou@linux.alibaba.com>

Stefan Metzmacher (14):
  rdma/siw: remove superfluous siw_cep_put() from siw_connect() error
    path
  rdma/siw: make siw_cm_upcall() a noop without valid 'id'
  rdma/siw: split out a __siw_cep_terminate_upcall() function
  rdma/siw: use __siw_cep_terminate_upcall() for indirect
    SIW_CM_WORK_CLOSE_LLP
  rdma/siw: use __siw_cep_terminate_upcall() for SIW_CM_WORK_PEER_CLOSE
  rdma/siw: use __siw_cep_terminate_upcall() for SIW_CM_WORK_MPATIMEOUT
  rdma/siw: handle SIW_EPSTATE_CONNECTING in
    __siw_cep_terminate_upcall()
  rdma/siw: make use of kernel_{bind,connect,listen}()
  rdma/siw: let siw_connect() set AWAIT_MPAREP before
    siw_send_mpareqrep()
  rdma/siw: create a temporary copy of private data
  rdma/siw: use error and out logic at the end of siw_connect()
  rdma/siw: start mpa timer before calling siw_send_mpareqrep()
  rdma/siw: call the blocking kernel_bindconnect() just before
    siw_send_mpareqrep()
  rdma/siw: implement non-blocking connect.

 drivers/infiniband/sw/siw/siw_cm.c | 347 ++++++++++++++++++-----------
 drivers/infiniband/sw/siw/siw_cm.h |   1 +
 2 files changed, 224 insertions(+), 124 deletions(-)

-- 
2.34.1

