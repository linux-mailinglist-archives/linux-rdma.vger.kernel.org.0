Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B707A8BC3
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 20:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjITScF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 14:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjITScF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 14:32:05 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCF7C6
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 11:31:58 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 9F3173F492
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1695234716;
        bh=H/hADblT+fi89UMWcm1lMm8P4TucXkF61mGmLMTbbEU=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=GQ31g4lIRfSYDonYXmvXAuUVr7Nvbgt0GtpLXYo4Glo4idJETt9094Ae4VHRDZc21
         BzhwWUH+XiqoHKTLO2wWu4CM+koiIQzR9RbfBTrxkIWlxkg7jHDIseLayErUpKktVT
         Ct7HMFjgcSndrXJ7BqOdYf5HkMJrg4ZQC4tgliF6+dx48wqlA6Q2QYy14XfuE3UA78
         oQpsBUZ3BRygxg8I5BIY4JBgYRLl/aNAXto4O5tTv+wWH9/E90ChtIw637hbNVrnDl
         BSOdNG+Ex/lr2UC4LbzRNiMlKJBt5u9icImjJ3tGw/WazWj60MTJY5P+5bFnW+i7lo
         R3gyEudwCtV7Q==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 6B0277E01A
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 18:31:56 +0000 (UTC)
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
Subject: [recipe build #3605963] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169523471642.3355308.713532482756806620.launchpad@juju-98d295-prod-launchpad-15>
Date:   Wed, 20 Sep 2023 18:31:56 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="d47b73632f1fccdd9fdd4e6145a4784874303779"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: e79ba87a13bf94012fe9539f35f06f6eae683b0a
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
aily/+recipebuild/3605963/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/bos03-amd64-027

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3605963
Your team Linux RDMA is the requester of the build.

