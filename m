Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73413543C7A
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jun 2022 21:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiFHTIy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 15:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbiFHTIq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 15:08:46 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D684312D24
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 12:08:41 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 36A0C3F4C4
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 19:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1654715320;
        bh=thyRHlBC2oQBGZcv7gUDVk8sofiqk2yGbz4FL1lM92A=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=M15u4gCq6fDkQklT+EjBvgcv6+BtjoKrhfJ/PZcaO9ETclKHGQvYg0FKzSruOgl9g
         uea7ecLgL0ECcec2G7dUiQOsc30m9s7f4qcp2zVFIm6RxgPODS4MN6oUN4JcMWkyTh
         nzLguH814KNeZFMXEhK9AJGBKuXs02V1UTOrlOt/3Yg7o7WUug4R7qzfpVL99CrLfz
         KjL79I6O/iIb9edMFbrkBoSdFXYu+nps9s4FeK4hWuft14EdmGG2zzyZeL8NxaYtmr
         JOy9xFc1ZGNZt4SLEDJ7ieNXQ9n5PwMNNZHw3SAExF4U0at0n6gLvZWQnVx/Y60fvl
         zJiVXQ1NAYD+Q==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 22B0EC0719
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 19:08:40 +0000 (UTC)
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
Subject: [Build #23830705] ppc64el build of rdma-core 42.0~202206080810+gitc590cbd5~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <165471532013.22589.15007619943999246658.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 08 Jun 2022 19:08:40 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="0f209dcba08bdd5fd387de120244a7b387be6615"; Instance="buildmaster"
X-Launchpad-Hash: 034b5fec4935d6b22dffe38db0283616da19dee5
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


 * Source Package: rdma-core
 * Version: 42.0~202206080810+gitc590cbd5~ubuntu18.04.1
 * Architecture: ppc64el
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to upload
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/23830705/+files/buildlog_ubuntu-bionic-ppc64el.rdma-core_42.0~2=
02206080810+gitc590cbd5~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-ppc64el-023
 * Source: not available

Upload log:
Uploading build 20220608-190724-PACKAGEBUILD-23830705 failed.

If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
ppc64el build of rdma-core 42.0~202206080810+gitc590cbd5~ubuntu18.04.1 in u=
buntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/23=
830705

You are receiving this email because you created this version of this
package.

