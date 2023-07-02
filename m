Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10481744D82
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jul 2023 14:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGBMC2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Jul 2023 08:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjGBMC1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 2 Jul 2023 08:02:27 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F2E72
        for <linux-rdma@vger.kernel.org>; Sun,  2 Jul 2023 05:02:24 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id A70523F06B
        for <linux-rdma@vger.kernel.org>; Sun,  2 Jul 2023 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1688299341;
        bh=QJrT/CrA0CEIQDTrTHcKAv+JO01VWKNzeleZFibOXzU=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=GNrXOcF1V4r0GP/GO2yWEb0eWdWG1TcCeiPbPeDiY5PyT/ala7IvAVWsuPqJ6Mh3S
         +eWNGvRig2qYrc7UZ6x04O0DFFrw/nkLVDqdRyh3K9eqSI42xLPOewcslv78zaldm/
         OGWOr3EXAo7ldYMN5kSLWHV7hUIAYWqHh2MUMdhMCLAzDew3HLTYuUZ4+wgiy5TrR+
         mHuXZg6mnLWJ89Z25TXS6RhiqDRmKCRnDokmAYnJWtCODLfNDDkssSS6/PsqE0aV1p
         ea29SYb3sG8disaC8tv5qE651JAOzayic2g+cUe3kA/noHrZukOf+PHdLNa9nrPXfn
         43D6evl8eDhUg==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 6FD8BC07B7
        for <linux-rdma@vger.kernel.org>; Sun,  2 Jul 2023 12:02:21 +0000 (UTC)
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
Subject: [recipe build #3567060] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168829934140.30368.5421236111663689424.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Sun, 02 Jul 2023 12:02:21 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="0574793d91fb0560c250e5488455be37b7fc4914"; Instance="buildmaster"
X-Launchpad-Hash: 8ffb7d7af5af90c21db5ad8d2d3ea1726a77ec38
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3567060/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/bos03-amd64-021

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3567060
Your team Linux RDMA is the requester of the build.

