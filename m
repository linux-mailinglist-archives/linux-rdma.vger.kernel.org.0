Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885AA68F252
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Feb 2023 16:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjBHPrS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Feb 2023 10:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBHPrR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Feb 2023 10:47:17 -0500
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3093C9742
        for <linux-rdma@vger.kernel.org>; Wed,  8 Feb 2023 07:47:16 -0800 (PST)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6B7EE423F0
        for <linux-rdma@vger.kernel.org>; Wed,  8 Feb 2023 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1675871234;
        bh=zbHW5OiwDHfJhrnfnKDZ6smwtDbCXJ/wl/HiQ0Rwu70=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=QCVwOwFk2QViUEi0KPv+fCK+inOVi1fDKwSpcdb67OvD4cdEgnDwp/zQLwIpkXajH
         avjohDOwtOeIB/yxJqejSTu+ghUiuzlddfe6kceaWBvzU9wGtCVZ724uqokSLQ/Kfo
         eSv3rvBts684D+uRs4g5GmapTZScMMTIJFxnBTQeu/IRWdDxoxUAOT14aGNDQGvHlw
         zNehRI3qtp0o3myNCZUUyR3HMSmTs+FRsAN/gwavuLqgGA/IGflyT0lplK8mJglan/
         N4LiKgk1ZBY/i0ZTAG8wgAw2aDjV3HOMAjRGQoJGnwJX0KMufij5uMNzEgc2uWWQ7R
         56KGp7jdrpXTA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 5531BBB85B
        for <linux-rdma@vger.kernel.org>; Wed,  8 Feb 2023 15:47:14 +0000 (UTC)
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
Subject: [recipe build #3492133] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <167587123434.20877.16288628546223857083.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 08 Feb 2023 15:47:14 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="33dc2e2ab7f8e563f52b8c81cbdf9e3946d2097e"; Instance="buildmaster"
X-Launchpad-Hash: cfabe47ecfc4303098806bd9b024981b3e8efe05
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
aily/+recipebuild/3492133/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-104

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3492133
Your team Linux RDMA is the requester of the build.

