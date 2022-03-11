Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2AE4D6822
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Mar 2022 18:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350461AbiCKR6n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Mar 2022 12:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350472AbiCKR6n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Mar 2022 12:58:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15CBE78925
        for <linux-rdma@vger.kernel.org>; Fri, 11 Mar 2022 09:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647021458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CBCkVn9C4rk/VT3+b4+mUYdTQuzP3cBuRTrOGEiGfng=;
        b=PdoNONRIdzKUuE2pAKX9HCiHKjHuDrUPBNhBrDPLAsZRAM+3MtmWXP0p58+4iSVbEK7/zV
        vCBD1GfW+Gyw/su72gwEmfvcjvklSqZRQt/xpzUMAFNwOW6R+5OtyBpAIdYRZmw++GtYjZ
        3EIAmoAVGg2+GOVALiCO/yUhSFqtPqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-E0wrlHKIO4qwL3QodW_TYQ-1; Fri, 11 Mar 2022 12:57:35 -0500
X-MC-Unique: E0wrlHKIO4qwL3QodW_TYQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A360801AFE;
        Fri, 11 Mar 2022 17:57:34 +0000 (UTC)
Received: from gluttony.redhat.com (unknown [10.22.19.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDA7580685;
        Fri, 11 Mar 2022 17:57:18 +0000 (UTC)
From:   David Jeffery <djeffery@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     target-devel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Laurence Oberman <loberman@redhat.com>,
        David Jeffery <djeffery@redhat.com>
Subject: [Patch 0/2] iscsit/isert deadlock prevention under heavy I/O
Date:   Fri, 11 Mar 2022 12:57:11 -0500
Message-Id: <20220311175713.2344960-1-djeffery@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With fast infiniband networks and rdma through isert, the isert version of
an iSCSI target can get itself into a deadlock condition from when
max_cmd_sn updates are pushed to the client versus when commands are fully
released after rdma completes.

iscsit preallocates a limited number of iscsi_cmd structs used for any
commands from the initiator. While the iscsi window would normally be
expected to limit the number used by normal SCSI commands, isert can exceed
this limit with commands waiting finally completion. max_cmd_sn gets
incremented and pushed to the client on sending the target's final
response, but the iscsi_cmd won't be freed for reuse until after all rdma
is acknowledged as complete.

This allows more new commands to come in even as older commands are not yet
released. With enough commands on the initiator wanting to be sent, this can
result in all iscsi_cmd structs being allocated and used for SCSI commands.

And once all are allocated, isert can deadlock when another new command is
received. Its receive processing waits for an iscsi_cmd to become available.
But this also stalls processing of the completions which would result in
releasing an iscsi_cmd, resulting in a deadlock.

This small patch series prevents this issue by altering when and how
max_cmd_sn changes are reported to the initiator for isert. It gets delayed
until iscsi_cmd release instead of when sending a final response.

To prevent failure or large delays for informing the initiator of changes to
max_cmd_sn, NOPIN is used as a method to inform the initiator should the
difference between internal max_cmd_sn and what has been passed to the
initiator grow too large.

David Jeffery (2):
  isert: support for unsolicited NOPIN with no response.
  iscsit: increment max_cmd_sn for isert on command release

 drivers/infiniband/ulp/isert/ib_isert.c    | 11 ++++++-
 drivers/target/iscsi/iscsi_target.c        | 18 +++++------
 drivers/target/iscsi/iscsi_target_device.c | 35 +++++++++++++++++++++-
 drivers/target/iscsi/iscsi_target_login.c  |  1 +
 drivers/target/iscsi/iscsi_target_util.c   |  5 +++-
 drivers/target/iscsi/iscsi_target_util.h   |  1 +
 include/target/iscsi/iscsi_target_core.h   |  8 +++++
 include/target/iscsi/iscsi_transport.h     |  1 +
 8 files changed, 68 insertions(+), 12 deletions(-)

-- 
2.31.1

