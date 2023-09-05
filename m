Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829F2792507
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Sep 2023 18:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjIEQAy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Sep 2023 12:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354525AbjIEMUS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Sep 2023 08:20:18 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F464B8
        for <linux-rdma@vger.kernel.org>; Tue,  5 Sep 2023 05:20:14 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 29DF440663
        for <linux-rdma@vger.kernel.org>; Tue,  5 Sep 2023 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1693916406;
        bh=4PRpAOAyVnHbckj7TZ57C34Jz88Pkt6wbbGJ+/P3KXc=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=WAwn6p6NfvVVpFOrjiQZQJbFutekbUukooWuc8Hyqb5apsj0p4u8fdxwboZ1R6QqU
         8WnPq1pXKntrrs6YLgREQSmRRUyBlxH9IT5eeVyLJuMkLa/ahSoJ0DXEmAKANz/LDJ
         zfBGcivwLbLeESRzz6ro8G6BzN8Kz9kUbuZvlsAw5lw7RLiaCm6xy0lekjwwvHMzjp
         DI7cbZG+VMnZyu+FcdEcJ4qnOloriIv414fatvR3qwwrO6ALSgQmxgpT3DyP2YGen/
         CM2W4el/qxCZ8EhR9UmKM4OXUnLoHlVWydMIICgPeRl6fbBkDF6viuAmeuzAn5Etk1
         y783BI0RXhShQ==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 551F07E6D5
        for <linux-rdma@vger.kernel.org>; Tue,  5 Sep 2023 12:20:03 +0000 (UTC)
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
Subject: [recipe build #3599064] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169391640329.2078445.2416918068051291909.launchpad@juju-98d295-prod-launchpad-15>
Date:   Tue, 05 Sep 2023 12:20:03 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="203f35b713beed25421591e82c62fdfedf492fe3"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: fa5ba476b60d0d671c12bf66584c94ce9735fc2d
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
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3599064/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-071

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3599064
Your team Linux RDMA is the requester of the build.

