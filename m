Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890F174ED86
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 14:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjGKMCU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 08:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjGKMCE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 08:02:04 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA72710CB
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 05:02:00 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 904333F0DF
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 12:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1689076918;
        bh=7ZUZwvhCGFusihCpIOE/tYXCs+mwGkjca+ojCRAEkGY=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=erOb0o9Oy8WWkIVV3kDt/vI6ncGiS/A5r8qwj5XJj3178h5WlRRjmmCO7yahlpgfl
         8EVdvFPCGmgUj6m1ydk1So7A90kSoENeTYrLafMGp5F70vb+cVAF3lavdxReJP1ZjF
         hwN8jGF5jrNYUsYrFxT1slczGWeI0nJR+beGr8msZ13Ia1kH50Acl37lHinNuHaM9u
         3Mezli3s6fw96A9fcK0aj/cDVnfyOU2kShM/v7/csEJnliI/tYzriq4330r6MGuMGK
         SuyuU09iAPJJdy7PYwFTNwQQ0PJGtKYyYTLx2AkSAsE4L8ks0vSfuFMfxbSyJZoK9T
         XSSVlvaOczGUg==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 88CB6C0C6B
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 12:01:56 +0000 (UTC)
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
Subject: [recipe build #3571598] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168907691655.22729.15065949062575439102.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Tue, 11 Jul 2023 12:01:56 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="693ddddce2424242f6b041649b16f1b23095bed0"; Instance="buildmaster"
X-Launchpad-Hash: 381f826843484028e459d210a4cb866ebb17d90b
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
aily/+recipebuild/3571598/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-056

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3571598
Your team Linux RDMA is the requester of the build.

