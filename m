Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FDD770FA6
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Aug 2023 14:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHEMbY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 5 Aug 2023 08:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjHEMbX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 5 Aug 2023 08:31:23 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EB244B6
        for <linux-rdma@vger.kernel.org>; Sat,  5 Aug 2023 05:31:21 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 67409402E6
        for <linux-rdma@vger.kernel.org>; Sat,  5 Aug 2023 12:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1691238679;
        bh=DR+4iJhzMQ2luPFrjEyvvXu4iQYSp4w6QEcLhwQmxRo=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=sh6CRJnAK0Ci+ApsOEXQsfRjus2poqgce+MMvBDjCMtYYJiZjUd9TZf9bNiogO3dH
         WK0GASUfR9X/XZSD8jWq0xiNb9Eu4uD3/rxI5rVqC5g1v5HFh4eimdX45/gzfgu5L1
         1IGk/OO3RYyEUiuX1dKddC/SDsETEzchwADjvHSxkCT2Yp8KbPbOqjbg3U8WxdabQ3
         HMQAtCeKXhCv1VImAeNEI5ykr1eRrUEZrMkteFYV8XXThaVQbqX/atl2Sb8lxkp37S
         H4ovuvMR/yVg1lntMkwinM3jK5CcR/PmQP35lXnJOnhKyxxMmJrUYHDRwO/sydToUS
         FZHH0+toWyScQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 4CE977E036
        for <linux-rdma@vger.kernel.org>; Sat,  5 Aug 2023 12:31:16 +0000 (UTC)
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
Subject: [recipe build #3584682] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169123867629.2513737.11928687732171412577.launchpad@buildd-manager.lp.internal>
Date:   Sat, 05 Aug 2023 12:31:16 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="6a25791a70c738891354c9239ccb07c6c99f87b3"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: f3c078433e0b056df8705d73ef86aeedf0235465
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3584682/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-005

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3584682
Your team Linux RDMA is the requester of the build.

