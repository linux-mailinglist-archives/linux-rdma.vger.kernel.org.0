Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6602E7B70DE
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Oct 2023 20:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbjJCSbz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Oct 2023 14:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJCSby (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Oct 2023 14:31:54 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F7995
        for <linux-rdma@vger.kernel.org>; Tue,  3 Oct 2023 11:31:49 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id D8E713F0AF
        for <linux-rdma@vger.kernel.org>; Tue,  3 Oct 2023 18:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1696357907;
        bh=pehCVXTxA7hC8qS6zVJy2do5P3qjDFYaqzoHLzwmIbg=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=nFSOya/VKdCF9JZHc1snXnVG5VZpv45njj43Bnk9i5mtmm3DwuRtvkWMzUEzUNKIp
         OM5sAy/UTDq83/uig1otMZULIi0IHz+JWSN9jrRlLY5+V1e+gzNxS5bnb3UcxEt2tV
         ZGJe1qe7QyoRba0+HSR+rHDN2Qhgc64XEwhiBcdpEP1OZG+kGewIyrEgqc2+GiT8sd
         nzGe4zGP0IWOtJCEEH9jT1Ej0jVk7LBFxMKpZwyXCvLxCe0dolRLXMBbcm353tc54S
         rT/sLc54wEhAhrHETNd+rcE6Av/qzQA8fd8jZSDWtANCVyKgNVHbQGjF5RucC+AqeM
         0LaHG9ezrPYzA==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id C00E17E706
        for <linux-rdma@vger.kernel.org>; Tue,  3 Oct 2023 18:31:47 +0000 (UTC)
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
Subject: [recipe build #3612654] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169635790777.2566601.4260311231070547563.launchpad@juju-98d295-prod-launchpad-15>
Date:   Tue, 03 Oct 2023 18:31:47 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="bd6cfd0cfc024dbe1dcd7d5d91165fb4f6a6c596"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 9a460d2ac3579b4fb4edee21d8e3aa1c05d593aa
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
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3612654/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-084

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3612654
Your team Linux RDMA is the requester of the build.

