Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794997E109D
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Nov 2023 19:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjKDScI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Nov 2023 14:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKDScI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Nov 2023 14:32:08 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480AED42
        for <linux-rdma@vger.kernel.org>; Sat,  4 Nov 2023 11:32:05 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 9889C41E6A
        for <linux-rdma@vger.kernel.org>; Sat,  4 Nov 2023 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1699122723;
        bh=ljDtG3UKtq4GlJsgk7dQA958s4vtIlIxAQZVpOpcotA=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=T0D2A7LDRkVVXymeYkGx9xpj84v7dB1g2TnzvAT6aK6HTh0wCvgGMkoUHi97WorWX
         XTwlDlZcvdxQ8Cij0/X3m6ES9lPoQbQE/DlGqrEOrIPvHdxjkS/ApUqVAxctByuaH4
         1/uCw45npcetb0GtFZIP6eYXqctIzjxrmKbrQKAEugCOiZr0+rlTBMRhvu6CSyztX8
         kxK+zpVzszLjfZzZEu2gXZdt3RSEjoy7fvBEa/oYEO14nVJqp5460vCeWf5YNfSsY1
         AY8d8AjSTt4XvCFVp/zLnfkgPh1QAeKPOltIiLBkRBriW9gpxX5g5Krtd3Whvs9LjR
         +UtQUhC5GBZqw==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 6C1BE7F05C
        for <linux-rdma@vger.kernel.org>; Sat,  4 Nov 2023 18:32:03 +0000 (UTC)
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
Subject: [recipe build #3628316] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169912272343.2858600.9463395687120819066.launchpad@juju-98d295-prod-launchpad-15>
Date:   Sat, 04 Nov 2023 18:32:03 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="9412a8042fac354f9c42815196ef31c1d9358917"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 24b6d103344c47c3520a3b3953715f32036d8fd1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3628316/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-016

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3628316
Your team Linux RDMA is the requester of the build.

