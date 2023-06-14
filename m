Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A12E730649
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 19:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbjFNRri (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jun 2023 13:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbjFNRre (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jun 2023 13:47:34 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C76F2689
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 10:47:22 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 9A07F41633
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 17:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1686764836;
        bh=6FHQMjRYlYSjsen4F78p98scnICFZAGDgam41zGGmrE=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=MIRn7rAnNGgPIPaIoiwrtmFhMr335DF04MBvdzgEqX+475pmqx4Qc3oikmDIrsrRr
         WOWh7MHdW+0i6aHWEd2KBGzWRIsTLTJcoRSNkzq3+66YU23eXAGLVOPwA+Gh4Lkmlq
         vykmfD6HE5db+uKSzlEoYNdZGItJJMsZkJSr6NdejqGgobnVV9JLzhylSdNXuKIySC
         IlfB18uNFcezYxVvflYukUS/ERa2IYg1GMIFxgH8z6SWHQcX6CZJPFC6p2K1rOSooS
         dhbXSWgjh2r5E+iVZSz8bR9vcxkh/eGTu1k8pGXageJAvWwAtnE73B6PZrlbUsfRjX
         C/CUhWoJq1Pwg==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id DB721C0C67
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 17:46:38 +0000 (UTC)
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
Subject: [recipe build #3557116] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168676479886.655.12877511176407312046.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 14 Jun 2023 17:46:38 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="2edb915d3e46a38cd09521fa848436c630bd11ce"; Instance="buildmaster"
X-Launchpad-Hash: 534ed4e8762951fe93899ba5c0ed9cea8cc8d37b
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
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3557116/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-027

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3557116
Your team Linux RDMA is the requester of the build.

