Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685E7705F23
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 07:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjEQFRV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 May 2023 01:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjEQFRU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 May 2023 01:17:20 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E889B3A8D
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 22:17:18 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id D16FF3F13D
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 05:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1684300635;
        bh=tmAQmTSNyQs87zIgh6xozrjus0FFnPBjZUKxXz8snCg=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=VMDD6PJQXTW4Ta3kzObGaP5mpGOXfdIcaGuh2vwMnaatMLGU2iI7K1usNTq5G8U2L
         aErXwJ8Zcu3stUjCwG9zEanryO65gNgQYp0gZecia3IRusGUzNgfPFF7UZiGMwMyjH
         S7uDpV0tYXB0E/LqZLmNgRENr9mPEUzXBqP9ckaYSEHY5RSnwGQ4wAk+Eq1zH0dZpD
         M+TmddnGOVvKWMHE1GnkjtEqpJOB027+PPcxELt+933wqvR1DjCsPaEbDz8ajXZvcA
         EXaPgvGKugqcy9ZQ9MwBdcfc2YjFjtnlxmwpyF8jRVj0V+LzJ7uKLabcDGxivugBhW
         jirI9soFGXU1Q==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 0C629C078B
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 05:17:13 +0000 (UTC)
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
Subject: [recipe build #3541845] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168430063304.15361.3004658835322478276.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 17 May 2023 05:17:13 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="333bbdc825b25f14e50a980a2dbe4dc39f3d34d9"; Instance="buildmaster"
X-Launchpad-Hash: bbd3e114054d58ed780f0fe7cca3a05b26eaa0f0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
aily/+recipebuild/3541845/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-113

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3541845
Your team Linux RDMA is the requester of the build.

