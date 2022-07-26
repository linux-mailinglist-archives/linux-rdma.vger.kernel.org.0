Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8695815C3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jul 2022 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiGZO4C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jul 2022 10:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiGZO4A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jul 2022 10:56:00 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD0965CD
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jul 2022 07:55:59 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 7858E3F2C2
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jul 2022 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1658846899;
        bh=wdR21YLGivpVqond2dWN15b9XOCzxzR3upYyXk5Hmig=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=ZMbLOEQEtZU9ms1JGyBk3dQsxx1ec428ZzLkQ1KDhD6WRgddF6qAHKclaQ/NRY52e
         ZXcENdAMipRoCLrU//QV2NXTtr+egBr8L+HhQL/fKyCdcsCdyLvU3Bx9zo0YLEoBx9
         h1HSpCQCeFyJI/7zrnagGQ1sS5fKZhaw3dEkwZh2guE0Kycitx9ZqDb7kpK/k/+n+j
         U4rwNs8e6HhzzfPcqfJM/kNDmkySeTTJdXIlA6uICTa5B4cws64DairJafBaioe9d8
         ed14CN9DvFK4KIue8/cr0f9dHV02xOBhaiANzK9xIpUw2txNZNnbdf046vzI9yjur+
         GAB8EmHaNz4qQ==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 63EF8BDEC9
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jul 2022 14:48:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Creator @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: package-build-status
X-Launchpad-Build-State: FAILEDTOUPLOAD
X-Launchpad-Build-Arch: armhf
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Creator-Recipient: linux-rdma@vger.kernel.org
X-Launchpad-Build-Component: main
X-Launchpad-PPA: linux-rdma-rdma-core-daily
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   Launchpad Buildd System <noreply@launchpad.net>
Subject: [Build #24202590] armhf build of rdma-core 42.0~202207260842+gite97b3986~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <165884689940.14703.3464155840103766462.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Tue, 26 Jul 2022 14:48:19 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="838936ad8731cbffa846f19d2e8c722348d216bb"; Instance="buildmaster"
X-Launchpad-Hash: 828dfd016dc45023173dd47ff02e05d352d397a9
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


 * Source Package: rdma-core
 * Version: 42.0~202207260842+gite97b3986~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to upload
 * Duration: 10 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/24202590/+files/buildlog_ubuntu-bionic-armhf.rdma-core_42.0~202=
207260842+gite97b3986~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-068
 * Source: not available

Upload log:
Uploading build 20220726-142555-PACKAGEBUILD-24202590 failed.

If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 42.0~202207260842+gite97b3986~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/24=
202590

You are receiving this email because you created this version of this
package.

