Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED435718884
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjEaRcq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 13:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjEaRcp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 13:32:45 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2EFB3
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 10:32:43 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 075833F1A1
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1685554362;
        bh=SEJI4MfVqrnyWU3bpuIIRzY35AKsLYY8YEF7D0+vkAo=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=WWUY1zmtT4emlcY6SCzXB1SyloKjm0/nYU/4Ity+x81Sgrm2651jpq6EBeBPxkz9S
         hYXaNpTolhhjuo89E+oSDbUOAsFKARsxN9rp61jjXVYeY5z7QUh2PwWYu3n4qS3Taq
         D4vAM3bEa0SmmvpmEqh486hvewFO73R5zGCSD9QyvP9uWWXPg1/myYf7V+L4HwfG5z
         sgXo8PgMVxSXbkex3TQ5ocfFm/JuPhxAsledWiBFnxu8qUoCrr725WG4bPuqw934ge
         1KDpiMY7FsGqKNqVylc7JEiGpS5tTJ2igiypRrb7vxMEsOrPheqKBwPZtOD0woB4zq
         UdbmZvJbmEvLg==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id CF87DC0700
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 17:32:41 +0000 (UTC)
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
Subject: [recipe build #3549453] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168555436180.6034.11325856785320002163.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 31 May 2023 17:32:41 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="060234aa1273238f7880ac19de947f3512a7e11c"; Instance="buildmaster"
X-Launchpad-Hash: d9214b094e8a392ad6ce54a0bee32f8d83247603
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
aily/+recipebuild/3549453/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-060

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3549453
Your team Linux RDMA is the requester of the build.

