Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689477514EA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jul 2023 02:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGMAC3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 20:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjGMAC2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 20:02:28 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DFB1FCC
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 17:02:26 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 466373F1FB
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jul 2023 00:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1689206544;
        bh=T2QS+QQ2TwhK6c8fH215AOwQ7UO8YeEffxb4L3Dfjak=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=kvp34TzeJFhW7/6dOZ0qYtz9vB/d3bOZudOHhb+kD21obh9bTx6Z6x4YQjz8eQoke
         b9e2y7nO6zmxv8tVSrLo72Fd9QibHU13fe9cXAFzepW2YnoACa1zfrKHi3iYF+Y/Tj
         KIvSug3UDcBXTO1K7kpeh0c51FdUW69bmggPt3ZRnfly3dEzZF6jVlONDaa96VVJHz
         OcSkIPhqIEMKFaIILX0rJLmpDbuBrcXFQS6ZdCM8QjqDN4yjbQB1w5IfyxyKJJy289
         YvItZ1oBHuXr4qwPbem/Rrr8ER6DUc8KNOCuamQDPUS/3iU2Bk0pMH24RkpLrQcQxE
         X4GAJxbfO4ITA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id F2E8BBDEE8
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jul 2023 00:02:23 +0000 (UTC)
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
Subject: [recipe build #3572315] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168920654398.5552.4873372939732773979.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Thu, 13 Jul 2023 00:02:23 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="ccbe59747eef140d0cf53ac3cf52a84c024f6e9d"; Instance="buildmaster"
X-Launchpad-Hash: be942b98d17a836696ce4b552fc5e6d0ab4e58c8
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
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3572315/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-103

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3572315
Your team Linux RDMA is the requester of the build.

