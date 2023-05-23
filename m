Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377CE70DB6A
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 13:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjEWLZi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 May 2023 07:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjEWLZi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 May 2023 07:25:38 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB09119
        for <linux-rdma@vger.kernel.org>; Tue, 23 May 2023 04:25:33 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 3292C429DA
        for <linux-rdma@vger.kernel.org>; Tue, 23 May 2023 11:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1684840608;
        bh=WbfEtrzzQzAHzPEN902khr+7ZK/8fOPnoHrmI5JKBOM=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=jUsRQQX0agh0Pw1K9Jv7WL5Bm5yGH0xp0VPgO5vS8x4jlK4+EeyWptzYM6Jj9lxLg
         kBc44z4j+stRDZPjdPV6ukw7+uIumDfF2HYA8nXyK6crLXE3W0wjyfdK6I/8Scr2p8
         HmnXtwl8RqSPnAgzuzugNxroS53huapcTPMjpQVRBMgSyU6+t4rEZFTr+ec23Uw5pD
         xrD42GhK9CTcOA0/B/mH3CrE2TJUGRLTtpLYZloYRQFLze/gNdjzMvkchX9fUCD8HF
         ekzpzqXW5XtnI+j7+5G1F/iHQX7hgT6Xt6YGxx38T0H+ijPhunUKxVQH/b14Iq4dM/
         3eDQWvWfjCbmw==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id F04CDC0791
        for <linux-rdma@vger.kernel.org>; Tue, 23 May 2023 11:16:46 +0000 (UTC)
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
Subject: [recipe build #3544665] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168484060698.13576.9774557970310475009.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Tue, 23 May 2023 11:16:46 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="c43d60b7954ab6ec7298e66f7f5c3ccc58e1a52d"; Instance="buildmaster"
X-Launchpad-Hash: cdf4362620ebbb18da2ea9f2958e74e8e79cf707
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
aily/+recipebuild/3544665/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-060

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3544665
Your team Linux RDMA is the requester of the build.

