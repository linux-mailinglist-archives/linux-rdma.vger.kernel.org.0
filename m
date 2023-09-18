Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31227A414F
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 08:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjIRGeK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 02:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239697AbjIRGdj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 02:33:39 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D373812D
        for <linux-rdma@vger.kernel.org>; Sun, 17 Sep 2023 23:32:56 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 017673F6D7
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 06:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1695018775;
        bh=ffA/TGhwJGwxizkBh9wENCCGT2ZESC7ih9YWzqOLNyY=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=WsW+EWc0l/VDIbCGnB04gvI4XYuDVk+ej2CHEkjkBck804xSQwuSSQmGUQv2goJa8
         3/9Uupbyi0g4guV6/A5ZCkbbinoG0PpOORvva5dN1qOcK9ixqtoIcUfeD+YU0PW4z8
         Pdvst5offSE4sOafgrkXwkVp4GstI/Q5uWW86NVhtH6yZSacbiAbmUEZtGdjlDzIWn
         5F/20tsP7vFK2vl4PeAY1wICKSyk2mOQpP0ZKFGwWCl9TIcg7aX3J7Ty8hkzebxiND
         RVxrno9km2oUvlquFq+dgCHjaO8ANxbH2PtE+v3OFqxNoy8qinhOsaBSENWkEntk5r
         ftdfeMtJUhKsA==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id E6A0F7E024
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 06:32:53 +0000 (UTC)
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
Subject: [recipe build #3604819] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169501877389.748405.13441775632704700395.launchpad@juju-98d295-prod-launchpad-15>
Date:   Mon, 18 Sep 2023 06:32:53 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="32eed776db4e1fe74faaa77122cde19862d565ac"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 77dd3c9a420ddca041da56094f196e26e6140aed
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
aily/+recipebuild/3604819/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/bos03-amd64-005

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3604819
Your team Linux RDMA is the requester of the build.

