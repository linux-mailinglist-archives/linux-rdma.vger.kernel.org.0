Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A3727F5C
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jun 2023 13:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbjFHLrz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jun 2023 07:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjFHLrc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jun 2023 07:47:32 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B4430EE
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 04:47:06 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 3D7F84250F
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 11:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1686224809;
        bh=l6QiEsQ/BWv3PNJhheoCJ4tWdBzN120xDtU0X5iIBDc=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=jYos9sF/38ioDWT7b81rjiDisQNV/FWUzqQ8HVhokZd1u1Jbh3xpkmItXJa8kMSZB
         88ezKTePdFRQO8SCpAbgN7+NXD+ORT+aF5Fz7g1spYIQ3QDX2u7IroPoAL0Ib7pZQp
         PBUVbkGE+K2dscJnDu94yeaqBTVTsG5Oqv7xLj3IFpfwwgHMR7L+zaUmMpgGKa1CTF
         A7LMVvtyal1rFGT+rr6TnW2k1LHeRGf+eqyNgY4ZRWztr48uroxiN4c/vgurJoHrAW
         G4Ug1vYXyJTKRzJ0y6kDeeVpQDHnq5YMyge99RFeEgLDF4DnnFjqerUMnFKsHpEpwb
         59WtSnebHrQSQ==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 95D96C10F3
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 11:46:48 +0000 (UTC)
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
Subject: [recipe build #3553986] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168622480860.6869.8935416114404904886.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Thu, 08 Jun 2023 11:46:48 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="620cd5280e3a973662e263ebf9346837ed657a46"; Instance="buildmaster"
X-Launchpad-Hash: f5d7feaadabf92f42cea5791183a1c0de60cc84b
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
aily/+recipebuild/3553986/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-028

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3553986
Your team Linux RDMA is the requester of the build.

