Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF47798EC4
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 21:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjIHTMR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 15:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjIHTMR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 15:12:17 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEF0180
        for <linux-rdma@vger.kernel.org>; Fri,  8 Sep 2023 12:12:10 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 28D5B3F2A8
        for <linux-rdma@vger.kernel.org>; Fri,  8 Sep 2023 18:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1694197003;
        bh=nTdfJv1aKRaf3swJdCQXnNz5LcKUtVCpupRT4gBM4dA=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=BkhknKikQSQxXI86PMrfCkt0utG1UaHwmawEoOr4aOP6LdkOfJ3ARu33zQZeYEs2g
         YHvuR8kTG2Ny8M1RLu/sDnsYqGj05lC8l94lOyIURLBONNnUUM3fc8XhnbHBMQVzVa
         vf8AMcKdvXvGDahOsbShtpEuyI5TUFgyyZN/afqs39Wf6genGqmcq+GhhrQPdKLaUm
         1fzimajoPG+GLFzV8N3lesta8qDckdXrzR7aTr1s5jm5RCA5Ip2JkditSxE4f8tukx
         b63YsgSOfC9Noc/uTnY2V3Kli+6kgqhmaanpgXeCtMHd4U+3iUqvestcvbh8fp4u/0
         XfUGVM9Wfv76Q==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 154F67E027
        for <linux-rdma@vger.kernel.org>; Fri,  8 Sep 2023 18:16:43 +0000 (UTC)
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
Subject: [recipe build #3600755] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169419700307.3412063.7330991532946148023.launchpad@juju-98d295-prod-launchpad-15>
Date:   Fri, 08 Sep 2023 18:16:43 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="32eed776db4e1fe74faaa77122cde19862d565ac"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 6be628f2d80b579ced4e715ec2263b2a707a13e4
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
aily/+recipebuild/3600755/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-036

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3600755
Your team Linux RDMA is the requester of the build.

