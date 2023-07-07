Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3201674B066
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jul 2023 14:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjGGMCa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jul 2023 08:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjGGMCO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jul 2023 08:02:14 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746A31FE1
        for <linux-rdma@vger.kernel.org>; Fri,  7 Jul 2023 05:02:13 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id D8C8442586
        for <linux-rdma@vger.kernel.org>; Fri,  7 Jul 2023 12:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1688731331;
        bh=olBRBiOI5UPxv6dKnPP6VNdHS3zSC5FE9U7uLMWw5SE=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=gBrKab6Cy9dyhTjAR4z1lXHMo6bsGQxAPlOg//4NeuF/+BR9gWkaSnpo/nbT1Yyxx
         aNv/5d33d/gZ27dz5U+KPTT7/fhol9WvJiVYylPn/0caZjlR3CgQuUek7+ymn2dxYq
         IZkKIBgnkClcRIfAeIWVaYgfHZT6UNrJVLFJKf8UF7h6s8GIfOGqbp4SKOm3De63cp
         Hepz88RRy35/WO1OUlOCbxvpBJq5mZY2VzB83pnK5zze3IYIEmEAqfcgc+rQChPtnj
         2PRkvvSwf0uuXaXQ09FHsfVesS92CS9jSBC4e2ZVt2Uv4+C7GTPe02jp/J84UVD8HP
         265QHGfqNUphA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id E0D02BDE6A
        for <linux-rdma@vger.kernel.org>; Fri,  7 Jul 2023 12:02:10 +0000 (UTC)
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
Subject: [recipe build #3569706] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168873133091.11814.16610779617739883625.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Fri, 07 Jul 2023 12:02:10 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="2ac9e3bf4ab511504f8fc651371e24a6a047ba12"; Instance="buildmaster"
X-Launchpad-Hash: 0f7dff1774bad54209d67d833db870955a5bd669
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
aily/+recipebuild/3569706/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-032

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3569706
Your team Linux RDMA is the requester of the build.

