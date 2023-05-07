Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EBD6F985A
	for <lists+linux-rdma@lfdr.de>; Sun,  7 May 2023 13:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjEGLCT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 May 2023 07:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEGLCT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 7 May 2023 07:02:19 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE491493D
        for <linux-rdma@vger.kernel.org>; Sun,  7 May 2023 04:02:16 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 2565C3F099
        for <linux-rdma@vger.kernel.org>; Sun,  7 May 2023 11:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1683457334;
        bh=fO6WC74XJ6Nc0Jr7vkxeoXhvMLYXWDs0n8cVXz4Zjdw=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=mZTQDK4uYm8KjM50waRG3x/XLrjhU0L/0YEAyxxiP/AnuCX0NTox+v41IMEvAv7y7
         UXnifpECK92w/az+0Kqz17jgz/+gC++oj90nT97g0KLXnY9MCteZS+Q3zpD4WO0kMK
         ErLFocYbDe2VBbJkx5zNJWIDxEsx85cY/BnXZm2EmfNaDIHC17pXh7zp9FDDqoZYq1
         zfAF9nj5AkxbQOWP/PWcbw9bTwa7DRPOFVUKPkWHoDbBho3X8sUab/iX+QgMmZYXm+
         SrNSCUByJNxIyTPvaSF85j2/9INjBcYrNAvUw1RQ8z+OTqZu7cct2UKe3WlteaHrlc
         y0jscxVpw5EGA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 4FC2AC06ED
        for <linux-rdma@vger.kernel.org>; Sun,  7 May 2023 11:02:13 +0000 (UTC)
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
Subject: [recipe build #3536952] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168345733328.21762.9841168271641432248.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Sun, 07 May 2023 11:02:13 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="90e2150bef31b411d7bae5c4032c7e320fcaaec8"; Instance="buildmaster"
X-Launchpad-Hash: 149c55abd0f8cbb88b549ac6ec81b3cf8671e913
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
aily/+recipebuild/3536952/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-094

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3536952
Your team Linux RDMA is the requester of the build.

