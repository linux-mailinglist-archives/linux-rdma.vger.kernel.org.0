Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF90758E9B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 09:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGSHRA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 03:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGSHQw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 03:16:52 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4059E43
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 00:16:50 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id BE72241458
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 07:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1689751007;
        bh=R7SjM9G9URP2J7V1J313EpkTEajvecocEgc9xQAcYBc=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=jxSciQDOhuQS56kvS0KKqCk6csMnMMj/lFKE/VFzu0m6WdKEDqayNutDjb5B+aVlZ
         ss2f4wP2aD/UShnEl0EvRyoY/31osaeiXpbwj9NaXjyxG20MkyMTZTz7wU/kgG/3IC
         jNodUrnOfsLOcuwMDRI4mUDj7IPnZiDB98FX50jEXsOQ8HA5TlV+vWiawSRjmO8IJG
         GDOSikMCCY5t999oQhGJe2/c2f32Q5rflX4rw7qvqfYm6u8jYA1EX6lhIXJNFAypk3
         eQiAzbZQcxY6mMbLqZH0ZLsyH1pmZvoTLkxBS5FLljLTOilaZYdHswfpF3uJLkWwR/
         Q5CT76G6D2Seg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id D0D3889759
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 07:16:41 +0000 (UTC)
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
Subject: [recipe build #3575474] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168975100182.476570.17278558539797616761.launchpad@buildd-manager.lp.internal>
Date:   Wed, 19 Jul 2023 07:16:41 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="cdf2f32bd157c68074f09bf6785543774a06f96c"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: b7542f6f6211e3ddaeb6eaabc6dc8538167d703d
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
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3575474/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-052

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3575474
Your team Linux RDMA is the requester of the build.

