Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C1C6C93A3
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Mar 2023 11:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjCZJrt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Mar 2023 05:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCZJrs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Mar 2023 05:47:48 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701A68A40
        for <linux-rdma@vger.kernel.org>; Sun, 26 Mar 2023 02:47:47 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id C24493F0B7
        for <linux-rdma@vger.kernel.org>; Sun, 26 Mar 2023 09:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1679824065;
        bh=TIP1SlMKWtrrQTcs6GSOBwX38s6aonseWln8WuwwLOg=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=VWgLeV5k60mOD8ZOQmdSmgl4U88hU4uZWJoUWwhxhIH2RnHBlInajz/CoZAOzzXSY
         yls1gnCiwNhiOYwjPAR250OtHwPTIuk8kXzOukpmH+7FjNtuEUk++Evm+L/g4aEV1L
         aLs2tMgVG1spdMetNW3JMqxgNPQmtF5YsKiXLmbS1fiNrcaGrs0gom/Xs161ZLgaqd
         TQunf4VdA1qxculc/OXjL6qvf7osNhlzqKNhyNmkKB1hLP2P/mx+KwhTlRLu3uGL70
         0299rMorvGILXQhZ89TjZSFugWP4PYi9cw0nZtsBMfNxRPOSZpEknh+QnBbWWlUTS5
         pRttNPiuxeN7w==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 6F3A3C06D4
        for <linux-rdma@vger.kernel.org>; Sun, 26 Mar 2023 09:47:45 +0000 (UTC)
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
Subject: [recipe build #3515968] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <167982406545.27463.11125236947436213886.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Sun, 26 Mar 2023 09:47:45 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="610eeb74559fa4aabb929a482afece263183fac0"; Instance="buildmaster"
X-Launchpad-Hash: 4a65e931abec3f04511df0763fe7dc62078215f3
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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
aily/+recipebuild/3515968/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-091

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3515968
Your team Linux RDMA is the requester of the build.

