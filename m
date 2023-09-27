Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896337B0436
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Sep 2023 14:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjI0Mc0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Sep 2023 08:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjI0McZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Sep 2023 08:32:25 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369CE12A
        for <linux-rdma@vger.kernel.org>; Wed, 27 Sep 2023 05:32:23 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6F5D13F13F
        for <linux-rdma@vger.kernel.org>; Wed, 27 Sep 2023 12:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1695817940;
        bh=mnuNNUsLpZylvESkeVLOMujZZ+EKcLcNBrXvtA9Br3k=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=jAFNNypt/qHMPApHwpc78QjMYXxz1wZpvdtG+Z9CCbPpQHo68PY+m92C92/fE4HL4
         zhIwVsry+I+IGmZT0YUCdJAJC17UjjdcilYv0eZwAhzlWgn8QeT9YhhoeRNmxuo9XJ
         RC7fBi56uZ1bU8mD/uYeW56SkBMMGbkfGyg/M+2KOK/dO9DaxadRx0BrYSK28ZZ42O
         xmNWf2sKnkxzJtB/4Bdunxcq9jrhceYhn0fVm0AZEnFr1IzufAhBIzEjp4A3BS+tuc
         WOCvufaMH9QZKiPWH4VZJEu75l01WTv9q15a9pHR4rbhpOwDzqzKsafjPEJT/JZKJR
         0hPZ8wAJw1qKg==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 3FBB57E01A
        for <linux-rdma@vger.kernel.org>; Wed, 27 Sep 2023 12:32:20 +0000 (UTC)
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
Subject: [recipe build #3608831] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169581794021.3355308.17738178700229502198.launchpad@juju-98d295-prod-launchpad-15>
Date:   Wed, 27 Sep 2023 12:32:20 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="d47b73632f1fccdd9fdd4e6145a4784874303779"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 0dd2536170761ac14da29de9b84047210d927bb3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
aily/+recipebuild/3608831/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-069

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3608831
Your team Linux RDMA is the requester of the build.

