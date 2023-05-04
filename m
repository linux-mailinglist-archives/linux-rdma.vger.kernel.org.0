Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65506F696B
	for <lists+linux-rdma@lfdr.de>; Thu,  4 May 2023 13:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjEDLCS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 May 2023 07:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEDLCR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 May 2023 07:02:17 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1008659E8
        for <linux-rdma@vger.kernel.org>; Thu,  4 May 2023 04:02:01 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6BCEF3F9D7
        for <linux-rdma@vger.kernel.org>; Thu,  4 May 2023 11:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1683198119;
        bh=128Vd+2pUoEjtf6nuc2IifG1ivUzkCa2AvtpmbqeScs=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=NbdHkN/Y3JnFwYqmk31w+vNiyVXjinHxRYvufKL6YN+vHBBhHPyiRY2vkJjP9oMX9
         IGyv6V9ZHd3/pPrvzp6CqeoTOkACC78TuOastRO8D1rUydFZPUKFPiRcSh8LIYcNBo
         PqpMmTRfBCHU9vq6VRchtJkRYYyKdR20eN/p1mNyIOu/n91rBtzN3PBFVoLOP+ZGsB
         Q7EK8qHWtpbY4jvULWKVs5f+HwNgo22nd7kYcodfRudyCMsZd5tLhbVJtPlHrDEgZk
         AbxLfC4dsFg6Ot0fXFG7myXgCjTKVGHRPbSyi5kxwww6SScE3YFGaFiV6Fe01jCVRP
         sOk7UX1tJfaAg==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 28D61C06DC
        for <linux-rdma@vger.kernel.org>; Thu,  4 May 2023 11:01:59 +0000 (UTC)
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
Subject: [recipe build #3535534] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168319811913.5418.2267868775849006924.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Thu, 04 May 2023 11:01:59 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="90e2150bef31b411d7bae5c4032c7e320fcaaec8"; Instance="buildmaster"
X-Launchpad-Hash: a4e30667abda11a3d7321916e8681551ba619ed9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
aily/+recipebuild/3535534/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-012

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3535534
Your team Linux RDMA is the requester of the build.

