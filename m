Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FC23EA598
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Aug 2021 15:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbhHLNYA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Aug 2021 09:24:00 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251]:55018
        "EHLO smtp-relay-services-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237846AbhHLNXw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Aug 2021 09:23:52 -0400
Received: from alphecca.canonical.com (alphecca.canonical.com [91.189.89.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id B34E8405A7
        for <linux-rdma@vger.kernel.org>; Thu, 12 Aug 2021 13:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1628774605;
        bh=g7z9eUfHJ+52EzVpUp8rAJthlZI2QjEnuHwBR7URq90=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=BiXdzEFtstKjfFwZyPKlpqsJgxDoSdDrglB2AlkhbTqgH7J2TMVmMR5gLPLxpSXWb
         N6LTphlDYzUJkiS5rgNJKdqa/MZrp7y9d4YoXj9b1fbc2RKpEVXm1X7L4Cl5JV+4Xp
         fSmlukIyOhxKzyGByB9gIxMCDt0WYG8EdBz/HWbWwVTPyq2oSkpqs3pDPVNXQXx0CA
         oPhiblq0nhulvxp9li3HN6op9662jaSdExj9oxe1Me+QkcNJVSqYpW7HIqzMlgCN4V
         smkx0PTJGmmdUg+IoaQ08bY43O+uwOrcfxZT7Fncacnmj2vkKkKMsU9VTT6ij/0ZF+
         Dz4vybAqoqmiw==
Received: from alphecca.canonical.com (localhost [IPv6:::1])
        by alphecca.canonical.com (Postfix) with ESMTP id 0AB4DE005ED
        for <linux-rdma@vger.kernel.org>; Thu, 12 Aug 2021 13:23:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Creator @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: package-build-status
X-Launchpad-Build-Arch: i386
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Creator-Recipient: linux-rdma@vger.kernel.org
X-Launchpad-Build-Component: main
X-Launchpad-Build-State: FAILEDTOBUILD
X-Launchpad-PPA: linux-rdma-rdma-core-daily
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   Launchpad Buildd System <noreply@launchpad.net>
Subject: [Build #21971387] i386 build of rdma-core 37.0~202108120840+git02f78698~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <162877460502.22604.12718499135243475808.launchpad@alphecca.canonical.com>
Date:   Thu, 12 Aug 2021 13:23:25 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="70eb0c507aa7f0d883a0543623f177d263f0dd82"; Instance="buildmaster"
X-Launchpad-Hash: 2194e084cc5a6952ea96a410210ef87ab4547799
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


 * Source Package: rdma-core
 * Version: 37.0~202108120840+git02f78698~ubuntu18.04.1
 * Architecture: i386
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/21971387/+files/buildlog_ubuntu-bionic-i386.rdma-core_37.0~2021=
08120840+git02f78698~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/lcy01-amd64-017
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
i386 build of rdma-core 37.0~202108120840+git02f78698~ubuntu18.04.1 in ubun=
tu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/21=
971387

You are receiving this email because you created this version of this
package.

