Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB5254C3BA
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 10:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiFOIlB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 04:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbiFOIk7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 04:40:59 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F1B4B1C3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 01:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=wIQd2RIwUL1SA36+GJqNw1ll3sXcFMx8j1a/I3oud7k=; b=x7C8+TDQZGzhO3A/OxFjiDsqeR
        G1prx1soh25sATG53JouLrAa/wPZ/RghNQhrJi6iWOwZNh5oApG5sNXjAuZ1JeNgloSndDei031zu
        3SEG8Xvwgv+jYZZNRtormAidJ9xQJL8unH0cWoEG7vPMYgS+tnqwWbsSznp4Q0ID7+kBx3aNgzULa
        8nK0VWb9n5k6VuxW9dOv/F9Onaqf7q/YadVLi9U2Ef+mLak3orJMttZY0u+g8tjlVTz67wMBhlrbw
        L5SrOEIubmB6ymRXfVNLx4rS6nf9y/z1Sow8zkUHjh9oXFsjuG0ycJlRRtE2eeFcmjpmno9aI0bdy
        fiWgy4tkYGrNHMPmokLilo4Gb1lC4C2oupKlStKXWpuepPX90IchEdaEp/TwRmuzZTdaJYR0dflRI
        pL+N3otAL6JxW8NEKc+OfNexA1dtFhGhJti5Fif8ts2KlIttCkGMLMNRR3SKZitUEUJLtsGBwDcR3
        cv4e4FpUqKT45SG73edfU73t;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1Oa5-005p8w-6D; Wed, 15 Jun 2022 08:40:53 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     Stefan Metzmacher <metze@samba.org>, linux-rdma@vger.kernel.org
Subject: [PATCH 0/7] rdma/siw: implement non-blocking connect
Date:   Wed, 15 Jun 2022 10:40:00 +0200
Message-Id: <cover.1655248086.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
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

Patches 1-6 are preparation patches to siw_connect()
in order to do the real non-blocking split in Patch 7.

Please have a look.

Thanks!
metze

Stefan Metzmacher (7):
  rdma/siw: make use of kernel_{bind,connect,listen}()
  rdma/siw: let siw_connect() set AWAIT_MPAREP before
    siw_send_mpareqrep()
  rdma/siw: create a temporary copy of private data
  rdma/siw: use error and out logic at the end of siw_connect()
  rdma/siw: start mpa timer before calling siw_send_mpareqrep()
  rdma/siw: call the blocking kernel_bindconnect() just before
    siw_send_mpareqrep()
  rdma/siw: implement non-blocking connect.

 drivers/infiniband/sw/siw/siw_cm.c | 165 ++++++++++++++++++++++-------
 drivers/infiniband/sw/siw/siw_cm.h |   1 +
 2 files changed, 127 insertions(+), 39 deletions(-)

-- 
2.34.1

