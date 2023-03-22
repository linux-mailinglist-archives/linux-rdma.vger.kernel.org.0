Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD836C58F3
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 22:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCVVrD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 17:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVVrC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 17:47:02 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295A933CE7
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 14:46:58 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 7D0C7426FB
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 21:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1679521616;
        bh=Fe4Y36qN2x9lRC56REKZFZIp3p0Iq4OIj93rcBADutQ=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=vfEJPDRMSa6M60Gouo2LPHAZ8UfFlJTLZW2tpTf1OFN37pclQ7wBgrupcgge9sZSf
         BpC9SiCff17QeuxSJAYVkL/o746JjzyMmy3nUUwe019XSevNIT2oE+mPAaWIb7Kryn
         8aFiYHG7GsLD1q0lc9yGGmfONWrP6It4G7lJS5xvoN4thuqWpBglkNUuH4p1CIqQO1
         6w2V45W8/+2QKJ+GjwEkK70f7QKvDJpGAL4abvC9X3jCqr2rpskoZPd8kSeFaiLFTV
         EKkOKdAdv3S422TvFW5VM0uqhlbCSE/4V3l02CvfPOCbZhhSPdJCikP52wqxrNv+G1
         l7b7ptNb2AvWg==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 508FCBDEE6
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 21:46:55 +0000 (UTC)
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
Subject: [recipe build #3514433] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <167952161532.18546.14893626120203608343.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 22 Mar 2023 21:46:55 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="c5a134908fde0a645e56f24c14f906bf278db3e0"; Instance="buildmaster"
X-Launchpad-Hash: 7b335068693a1731e04e9e3ce249b5ef64421cc3
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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
aily/+recipebuild/3514433/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-003

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3514433
Your team Linux RDMA is the requester of the build.

