Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1A766A0F4
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jan 2023 18:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjAMRpM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 12:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjAMRop (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 12:44:45 -0500
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B073CEE
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 09:32:17 -0800 (PST)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 4AEA642C58
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 17:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1673631134;
        bh=+8L9wRSWvYrVYWGq6XMAuw6DqTs/UVjB4aMRdkf1lQA=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=qmRMfgLk5izMO1/nyZggzW71rz+8kCqxB3dlMetR6jHnZN6E+qmU6VzJQDPuzmSbp
         xgKNeBTO95eN7OfpH3h9JIUUJgcYB/4E3+z8RXAZRkb77G8iJfOoB9mBUsM9oygjQC
         2wSu6Sm449TReiQxn3WYBJdYhI6JCYObDkdpoSf1YB0sXkHT2e6yoeBx+2dU7ETb77
         1pqR6wmy27clIvBjC99D3VjwpnAbwaD7G3DS4AatZiHPMfCHfWaNtmv/uebq7uhd29
         vQWfYu/ZaB+1Xl6sTf+BXdG2qfqxwQQ/7z3k9uGvcKJOxjnotCK4MOQ3fLd7MvPWQR
         d37fVALYJWhmQ==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 2248FBB816
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 17:32:14 +0000 (UTC)
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
Subject: [recipe build #3478597] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <167363113410.21439.14728360310356982057.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Fri, 13 Jan 2023 17:32:14 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="dbb0e65afe3a4c62ee3f8f6b6ed6b1afa2685380"; Instance="buildmaster"
X-Launchpad-Hash: 7161c78e5f64a60f7aaef2ecbd525d8272e9c83c
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
aily/+recipebuild/3478597/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-119

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3478597
Your team Linux RDMA is the requester of the build.

