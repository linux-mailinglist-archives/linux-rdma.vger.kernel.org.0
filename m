Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AB56FAA7A
	for <lists+linux-rdma@lfdr.de>; Mon,  8 May 2023 13:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjEHLDS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 May 2023 07:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjEHLCq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 May 2023 07:02:46 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D88E21553
        for <linux-rdma@vger.kernel.org>; Mon,  8 May 2023 04:01:55 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 4D04A3F352
        for <linux-rdma@vger.kernel.org>; Mon,  8 May 2023 11:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1683543712;
        bh=3f6KdnfsVtGvbcOPUTLClobRoioUpK/4f5V9ksEUFBI=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=mcjFYaFXJesxDLOgggVTvf5P09Cabfi3nloKEdeyO8+2uW+Z621J+e9cFgSWONjR/
         6k1npC9Q0jB0gjcE+3d6w5XvidT5AbFcDpiNq5PN+L8WOwpi9Pp5heviXejD4FGKuZ
         qvu28gangZ3K6mMCylQe0sr0K7vUG45D9aEv1j9pAMRxPBrpqHgW47GiBJRaPR7CIJ
         SmK8qSYgE9aJ2w82H8cMkXMQ3+utwHdKMpKxrj1133hLCHABcBOj6HahBZPrwfF0Tu
         cG90Wjh4ALacyaZbUuk6UzuXRXvUVKZRDYZR0lQaEDgC5cf01bZGchKpMsMHMWtGky
         kTjcqqy0qlx4Q==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id DEAF9C06EC
        for <linux-rdma@vger.kernel.org>; Mon,  8 May 2023 11:01:51 +0000 (UTC)
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
Subject: [recipe build #3537289] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168354371188.12887.10430893475399173931.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Mon, 08 May 2023 11:01:51 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="90e2150bef31b411d7bae5c4032c7e320fcaaec8"; Instance="buildmaster"
X-Launchpad-Hash: 6770a20f765de7776fa9859e8d6cddfd88190702
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3537289/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-034

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3537289
Your team Linux RDMA is the requester of the build.

