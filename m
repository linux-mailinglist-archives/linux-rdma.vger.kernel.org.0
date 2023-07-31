Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94438769B0C
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGaPqt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGaPqt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 11:46:49 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40C411A
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 08:46:47 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id B03CC3F078
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1690818400;
        bh=NYvZ3oiFP819Swpwu2VW9FxW8i7N+usJUEshacIwfT4=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=TDiXHLsvFTrnCZNrv/GH9rDzD+bqyxW5x1+iUeDuAGSN4DKPQujTUzETSjZqPZhSe
         Hbo2qduswCj5T4xWMZc2Djs7igUIq5VHIFUzrc4qyJuj0mUenJMxly34oAxqJmWuZn
         v+Yus/jUQ/sn9eX+63+P+SgzVtrVRxfCjIWffGueJzjm/QSx9O2/YoLKNa4vShR5hm
         jTERNtFNkTGVKKtBwwIM09xmojfAePuroL3SCraA8jzEvNduAEDPeWH/G0y3mB2jhk
         uBMXyGcS24qn9x2R5uLgpUgXBaplJjgiNZyMWa0eWy/dnsb/kN7WlxNtCm83AQ36lu
         oQQ8x5keXsV6A==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id BD6897E005
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 15:46:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Requester @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: recipe-build-status
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: MANUALDEPWAIT
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   noreply@launchpad.net
Subject: [recipe build #3581277] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169081839777.473079.14226893817247015841.launchpad@buildd-manager.lp.internal>
Date:   Mon, 31 Jul 2023 15:46:37 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="d80dbb5bdc9110f3a64cc968928033472d5e0509"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 1337bb8054829069a5361efa2883b34ba81f79d7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3581277/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-022

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3581277
Your team Linux RDMA is the requester of the build.

