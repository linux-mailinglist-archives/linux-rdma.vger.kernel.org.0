Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B96754E8D
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jul 2023 14:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGPMBq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Jul 2023 08:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPMBq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Jul 2023 08:01:46 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E777191
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jul 2023 05:01:44 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 1237D3F338
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jul 2023 12:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1689508902;
        bh=04qmFGmD5iOI+BnQYE68ehLafmVZAkEhwgVh3EqYRGs=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=SpSpUbobC289NiuIU6Tk2QMWIKyI73LkRtaKxPYDuCbVf5lE+OFsNNvdX8yuOEC1n
         pZD8C8UDeGWB8aPf4fAONWdpTHZrdwOOhlXNZHFjZXdu9YZxeg5k0ixZj383Mh26ga
         9+Il/19PQoCuC2m6Lxz8gNKFt42SoGOpkqa9S2rSVNBGGFPukkj+JkX96Qmk9HQtaD
         fhTRfR3GtSkQNiBZR54vMboAt+mqdj7v2hfmLK1+MUnWsRIs4Q+mUj5Ej2QdWet6tR
         g72BoICVgXTSUjCSSqZeK1M6l/XQcgaj60n3yMXWLEiZP8lVlfTBgMwFOBIwUh+zen
         1fWvler5x0CfA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 70E9CBDE6A
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jul 2023 12:01:39 +0000 (UTC)
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
Subject: [recipe build #3573841] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168950889943.21609.14363189792666778685.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Sun, 16 Jul 2023 12:01:39 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="ac0db76515d6b1e1f8320253cd793df53073930c"; Instance="buildmaster"
X-Launchpad-Hash: 4107457e8b96404abbdb7361ba2c27d42cecb99d
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
aily/+recipebuild/3573841/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/bos03-amd64-016

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3573841
Your team Linux RDMA is the requester of the build.

