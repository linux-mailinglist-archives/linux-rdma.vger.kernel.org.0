Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7487D6BD6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 14:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343929AbjJYMdh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 08:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343906AbjJYMdg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 08:33:36 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2828F
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 05:33:33 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 5C2633F8B7
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 12:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1698237203;
        bh=dbhw9V0KWg8IZHEnuZ2iKKcmUIn1Mkb92r5X0avI9CI=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=WX17Z9wA8uWlgsPa/9B7U2SN4X+TojT2ONvkUTH9sSlc4Rd3P8E6CZsMjezS9fchV
         tdkvIfPPANYvBf28FGKGtpPctIFzBQg0IKPsSyK1r6K/y+hnIBLhicnjUF/BJqcjPo
         pyEbimeSlqOaDJHFkX5FB9fQIy702zKYwCaej31FKQWpHjb02ErLN3m2Y7ulOlco8u
         PXLHfyHenTuslyDMMfXTeNnN/IeVf0DDzOIjGqw6RMxEKfq8WMGFYYBWl65/gtK6Id
         wj2evraBRnrPk7vwf25CP7aAB4NVA23o3SguA61IFNxORTzS6Jcl2/zPc+vFQWAIv6
         YQm1Kq7gntxRg==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 6ECF17ED10
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 12:33:10 +0000 (UTC)
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
Subject: [recipe build #3622531] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169823719044.2106125.1593388500637007414.launchpad@juju-98d295-prod-launchpad-15>
Date:   Wed, 25 Oct 2023 12:33:10 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="eaf23562b7bd8a9b9944d0879f3f923a8aa43967"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 0b45d943ed93599b397c85ede3831e8da6349609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3622531/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-044

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3622531
Your team Linux RDMA is the requester of the build.

