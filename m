Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA00543C7E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jun 2022 21:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiFHTJQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 15:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbiFHTJO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 15:09:14 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEADC3CFEE
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 12:09:08 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id A56433F07A
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1654715346;
        bh=WGCp6vluTBLoXXzHzz0GUTMAOfL26K1Yz2GXBgf3MoM=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=Je4aT3vlWzXdCMxrUTfLX72uNr7apNkp5hJHRT5XxMy4AemffWaOnrFhcCG4KKQF4
         kJ7r8MzAGKFhXhx+Iaai0q933uEzVhkkdAJ09kBajM0FD+VpQeTNCJEZ19T3OvdqZc
         t+H5jZzmrOE7ByDUv3KV39vZqZpkUE2THTsBvyyZtu++XP8w4Ap958Bz5iF//CGh1y
         Bbbw6aWbzFdGOVLJ5A050hbyhnW9W0qjx+b6HMygwFMpofFMJL5VlYZ9bkBQFgAR2M
         2lSvG+s4lk9yfEVldc3OoP+wX1WudpBaS3eCJeKW5CVgLvE5Ra4LDd0ZBA8aOh0SBs
         6YR1oCUhOlWXA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 87025C0718
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 19:09:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Creator @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: package-build-status
X-Launchpad-Build-Arch: ppc64el
X-Creator-Recipient: linux-rdma@vger.kernel.org
X-Launchpad-Build-Component: main
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: FAILEDTOUPLOAD
X-Launchpad-PPA: linux-rdma-rdma-core-daily
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   Launchpad Buildd System <noreply@launchpad.net>
Subject: [Build #23830711] ppc64el build of rdma-core 42.0~202206080810+gitc590cbd5~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <165471534654.22589.3685702939939729702.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 08 Jun 2022 19:09:06 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="0f209dcba08bdd5fd387de120244a7b387be6615"; Instance="buildmaster"
X-Launchpad-Hash: 259d3ba4733c56008a5e2655ff0d94a780b5ac75
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


 * Source Package: rdma-core
 * Version: 42.0~202206080810+gitc590cbd5~ubuntu20.04.1
 * Architecture: ppc64el
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to upload
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/23830711/+files/buildlog_ubuntu-focal-ppc64el.rdma-core_42.0~20=
2206080810+gitc590cbd5~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-ppc64el-024
 * Source: not available

Upload log:
Uploading build 20220608-190736-PACKAGEBUILD-23830711 failed.

If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
ppc64el build of rdma-core 42.0~202206080810+gitc590cbd5~ubuntu20.04.1 in u=
buntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/23=
830711

You are receiving this email because you created this version of this
package.

