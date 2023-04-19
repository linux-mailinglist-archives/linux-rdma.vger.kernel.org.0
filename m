Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9DE6E77F7
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Apr 2023 13:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjDSLCs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Apr 2023 07:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjDSLCr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Apr 2023 07:02:47 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6067297
        for <linux-rdma@vger.kernel.org>; Wed, 19 Apr 2023 04:02:41 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 454E14241B
        for <linux-rdma@vger.kernel.org>; Wed, 19 Apr 2023 11:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1681902159;
        bh=Gy091qVQdCK07jQqGx+kciYxKarRtBtyPHiFXbe7etw=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=NvQuBMOezurgxerclzwReLs/S4AGO75NK9XKxO5fJ4flvxNFbVYM9W38YT+DsNmCt
         eXeUubJz1y+Dn5R3yACgtmqWMd7PBKnsiIzcMmEfYvXttojcCjK/dSGViehmE2r+Wj
         nuG9XMFOTrDf1ypvgtvfr2Tym43wsWADxgXjfoNYXSEJx1Rcv6gYzhdKrSEZ3vUyCI
         WtA0zZUoGpecon36yhbXw7bRQq5qkxVPsQdZflQ8pLK8d+pI/lV9dozwlI1Xne6gc6
         uY8n2U3IzRJzzvTwm6RwIx5GCK/38LOydslkthN4yZNXKJuKi5Q3WwehcVKuiVFxjr
         OCjK6n8IlyrPg==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 2F653BDEB9
        for <linux-rdma@vger.kernel.org>; Wed, 19 Apr 2023 11:02:39 +0000 (UTC)
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
Subject: [recipe build #3528689] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168190215919.12723.739220334580666448.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 19 Apr 2023 11:02:39 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="473868c1cc6b58a9bc722c23840374c93a7a274b"; Instance="buildmaster"
X-Launchpad-Hash: 31a90ac0212aa06edff78e047e7bff79fc2e01e5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
aily/+recipebuild/3528689/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-101

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3528689
Your team Linux RDMA is the requester of the build.

