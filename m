Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7796C2E2E
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Mar 2023 10:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCUJrB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Mar 2023 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCUJrA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Mar 2023 05:47:00 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA25941B64
        for <linux-rdma@vger.kernel.org>; Tue, 21 Mar 2023 02:46:56 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id F140D4242D
        for <linux-rdma@vger.kernel.org>; Tue, 21 Mar 2023 09:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1679392013;
        bh=ha8FhAuE+PCD8lmywj2/wf3imzsmlT2hLphJtJX4hRo=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=Q03M/CbpHV3Qz8bi/HKzif3HEc+PAqx0npWTdKs9X2U4fBTpRcVwcWVCyyNvF6202
         subB01aoHBM5qJBC0ZFIhnRbkBt0meqh6ienYO7o9KrWlk2E0Zga3YzkvzIHldUgTT
         6ELzdJzaVPNv3d2y95oi+qLbAev7yrW43SdHARj700rHh8x9rkZePOxM2nDH5xfp+0
         SkMeH5ak8xh7Jw2ao/AEvTozGJ3lrICdtGmkR+uEHQizzFA3iOu2y9oh/JyrvU0A+P
         nsh41PwWR2tTBnDdHH+gtoscRNYHiWyOyqf0MXd7tkOi1QalY3Uk1nNQ5PTF+BsMCf
         3SW8j2gQOgGvQ==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 12E9CC06CC
        for <linux-rdma@vger.kernel.org>; Tue, 21 Mar 2023 09:46:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Requester @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: recipe-build-status
X-Launchpad-Build-State: MANUALDEPWAIT
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   noreply@launchpad.net
Subject: [recipe build #3513633] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <167939201307.23376.15415859776254622358.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Tue, 21 Mar 2023 09:46:53 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="997ba17554f0ee82f56d9282fce82d3e09a43780"; Instance="buildmaster"
X-Launchpad-Hash: 08b02d597e04ff3ebaa57148d4fa06976c9e94f1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
aily/+recipebuild/3513633/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-043

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3513633
Your team Linux RDMA is the requester of the build.

