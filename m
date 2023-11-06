Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C19E7E2193
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 13:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjKFMbq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Nov 2023 07:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjKFMbp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Nov 2023 07:31:45 -0500
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DD797
        for <linux-rdma@vger.kernel.org>; Mon,  6 Nov 2023 04:31:42 -0800 (PST)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 37E4C3F909
        for <linux-rdma@vger.kernel.org>; Mon,  6 Nov 2023 12:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1699273900;
        bh=Ih4Y1YqfGiu43/N83DvyP4QuPjnZ2SlH/4LxOVDiBrI=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=PWchd+tC79C6J5OaUS6hLqKOW+TGNIeJpqn/RAAf0g06dyyus5eyPneLaoqmeJsok
         3etODcp+Ei0KCXWNDT19hxYOibBk2hNshBgUuJUfNtmYKu0LuU8Rt5G+BoI5tgvEyt
         /cTRdPXSNfYS2LMcGNGlufCfBpCU4ry5Cy5c12c3tG/5DqHm+Vrykue6b6A+gd1pK1
         ExpMZzzaEW0J9EFxg+VOw0c3CmeEO1W2BrO2XdnxEBDPSifpp0gsHoAHHtlbnMiNQN
         PpriPkkXp1i6iSluL8LxubgPheghyLNdOu8lv8GC0+3HjMkbv5v7MjrCgDingMRhjA
         OxysNWze8gdrQ==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id D4F7E7F049
        for <linux-rdma@vger.kernel.org>; Mon,  6 Nov 2023 12:31:39 +0000 (UTC)
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
Subject: [recipe build #3629124] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169927389986.3978024.1696710583501335291.launchpad@juju-98d295-prod-launchpad-15>
Date:   Mon, 06 Nov 2023 12:31:39 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="f1e537f62ee3967c2b3f24dd10eacf1696334fe6"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: daeba63d694ba45aaeb309fcb0c6b55f6f7a7292
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
aily/+recipebuild/3629124/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-048

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3629124
Your team Linux RDMA is the requester of the build.

