Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD8B543C99
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jun 2022 21:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbiFHTMR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 15:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiFHTMQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 15:12:16 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA84410577
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 12:12:13 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 8DEE63FCB1
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 19:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1654715195;
        bh=rDlMlxDQ1mNjrXebgtkwheDGZ4MR25MtlD9eUIFmmK4=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=ashb7xNOYUe30FYrrx6BcLGTzICuGK+8GfKV6ynQ18fypWx2wJRglKlf8Cn9ro2w9
         1azMDuSDGFRYUOAZrBCfTZrfGYg0rdha/RCccda/lUIInDecqlzwTEy0EZyogavfi3
         qONAO8DPO7LjtYhtcAvxcd6YXG2f9hlbeaJ41rClRWpmW24K1LqKfQvBpTln5tXWWk
         l8gUgAZlVDwzDlkulr+GNpZk71z7tJfRZx5xIYx3sVrbGS4EZx4giGsSCuIdm//+Hf
         EomDkc7jKJdDgjduCrb9rdDPCkL+7xwaV/aIZrwI38FLL9ZgiOMrzSFMp64US0/1AY
         yGFZFJuTzq6Xw==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 1A477C0719
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 19:06:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Creator @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: package-build-status
X-Launchpad-Build-Arch: amd64
X-Launchpad-Build-State: FAILEDTOUPLOAD
X-Creator-Recipient: linux-rdma@vger.kernel.org
X-Launchpad-Build-Component: main
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-PPA: linux-rdma-rdma-core-daily
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   Launchpad Buildd System <noreply@launchpad.net>
Subject: [Build #23830701] amd64 build of rdma-core 42.0~202206080810+gitc590cbd5~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <165471519310.21610.6827270265896964473.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 08 Jun 2022 19:06:33 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="0f209dcba08bdd5fd387de120244a7b387be6615"; Instance="buildmaster"
X-Launchpad-Hash: 0554d8da775d8d02e9116d687b59c03ed484cf18
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
 * Architecture: amd64
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to upload
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/23830701/+files/buildlog_ubuntu-bionic-amd64.rdma-core_42.0~202=
206080810+gitc590cbd5~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/lcy02-amd64-093
 * Source: not available

Upload log:
Uploading build 20220608-190538-PACKAGEBUILD-23830701 failed.

If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
amd64 build of rdma-core 42.0~202206080810+gitc590cbd5~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/23=
830701

You are receiving this email because you created this version of this
package.

