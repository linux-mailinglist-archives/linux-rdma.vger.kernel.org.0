Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912A73DFBD8
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 09:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbhHDHOV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Aug 2021 03:14:21 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250]:43298
        "EHLO smtp-relay-services-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235219AbhHDHOT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Aug 2021 03:14:19 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Aug 2021 03:14:19 EDT
Received: from alphecca.canonical.com (alphecca.canonical.com [91.189.89.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 926DC4058A
        for <linux-rdma@vger.kernel.org>; Wed,  4 Aug 2021 07:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1628060944;
        bh=yvovQsQTVHP0k10VP0uPI6s4U22l1csVjnCJfpIA8QY=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=BiHYOwa5IA1yf5gMn81d5cYyqJ3/oC1Ya4slvpNmx7YXAzCWnaS7IRz1SzN+NOyw7
         RkhMAgLJIwv+fQ+MPmVpNtrWq8si1HlD+41Oj8NRoVsiuIUNmcg8PCTgBkML77g5Ic
         yNaCZ48ggzAxFm14MyCRhCJJd6ZDFRa4W5xhC2j7fjJRK4ibIz5RLkmYZQVrpmaPVW
         IC7epK4XCUDLzqlH0UAmEniSk+KM66tUUL2b/kWkqn9ccMRKtKW0Yv5vEd73MtFjOv
         q4wO7oyLRt1qMl4x/EVNaRuyp6sksYs9JOzvIqVHHIRM8E2/D7kaRcb8HQ7hpH8m0T
         wEXrhE+zwFIKA==
Received: from alphecca.canonical.com (localhost [IPv6:::1])
        by alphecca.canonical.com (Postfix) with ESMTP id 8A77DE0012F
        for <linux-rdma@vger.kernel.org>; Wed,  4 Aug 2021 07:09:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Creator @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: package-build-status
X-Launchpad-Build-Arch: i386
X-Creator-Recipient: linux-rdma@vger.kernel.org
X-Launchpad-Build-State: FAILEDTOBUILD
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-Component: main
X-Launchpad-PPA: linux-rdma-rdma-core-daily
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   Launchpad Buildd System <noreply@launchpad.net>
Subject: [Build #21836398] i386 build of rdma-core 37.0~202108040620+git2d3dc48b~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <162806094456.10026.5482257625980750683.launchpad@alphecca.canonical.com>
Date:   Wed, 04 Aug 2021 07:09:04 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="8bd362bf86c4b35e805f897f03c203e3576a7006"; Instance="buildmaster"
X-Launchpad-Hash: bed0faf0db858e67aa48160cd5a7d7c0bfb6d765
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


 * Source Package: rdma-core
 * Version: 37.0~202108040620+git2d3dc48b~ubuntu18.04.1
 * Architecture: i386
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/21836398/+files/buildlog_ubuntu-bionic-i386.rdma-core_37.0~2021=
08040620+git2d3dc48b~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/lgw01-amd64-042
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
i386 build of rdma-core 37.0~202108040620+git2d3dc48b~ubuntu18.04.1 in ubun=
tu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/21=
836398

You are receiving this email because you created this version of this
package.

