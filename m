Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113396FDC1D
	for <lists+linux-rdma@lfdr.de>; Wed, 10 May 2023 13:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbjEJLCK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 May 2023 07:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbjEJLCG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 May 2023 07:02:06 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4958A4EFE
        for <linux-rdma@vger.kernel.org>; Wed, 10 May 2023 04:01:50 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 49DD43F90B
        for <linux-rdma@vger.kernel.org>; Wed, 10 May 2023 11:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1683716508;
        bh=zUyqLnIpzTrLg0D/np4EREbwG5mz+I0sy+mNttLl4EU=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=bzP9H75wMdQc5VX7EHJMAGXg5SKtWeIpy+UupgFbUJOTUEta8JjLvc8qnjXQ1mHyL
         HrRQ8o2J4txYf1N0Iy3Pn4GIXwntqCbN0K01w658k8cZkqudiG/VigsGyhMol1gtOw
         OAAk7/A2fTjPaO+A3cl+MpPQzR5/WSoBXnTKufnAhJBqfQmOqvigREjxDz0oDk/DJx
         swwdri74HeEdkyY67Ioyh+bhqaK6D/YE/S7DJQM++gPswMMPwb8fXLl/f4V/MEhYV9
         m5K5hq1Uv2sVWnLw7YgGOyUlC/YRDR4fiBOT04X4JmirRU7Hv2GqaKclOL5Hd0JDQn
         QmUd3ozyyAFUw==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 215E4C06FA
        for <linux-rdma@vger.kernel.org>; Wed, 10 May 2023 11:01:48 +0000 (UTC)
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
Subject: [recipe build #3538445] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168371650810.2969.12856004368028491325.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 10 May 2023 11:01:48 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="90e2150bef31b411d7bae5c4032c7e320fcaaec8"; Instance="buildmaster"
X-Launchpad-Hash: 57ebfb3d2889aa16074b7e3c08d997fa17948596
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
aily/+recipebuild/3538445/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-094

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3538445
Your team Linux RDMA is the requester of the build.

