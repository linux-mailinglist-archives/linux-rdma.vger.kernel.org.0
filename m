Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866303E091B
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 22:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240797AbhHDUBI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Aug 2021 16:01:08 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250]:41926
        "EHLO smtp-relay-services-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236868AbhHDUBH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Aug 2021 16:01:07 -0400
Received: from alphecca.canonical.com (alphecca.canonical.com [91.189.89.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 82EAB42674
        for <linux-rdma@vger.kernel.org>; Wed,  4 Aug 2021 20:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1628107253;
        bh=KZAsAS1Y/9P5hBrpg8IK93a30mFYLcN3tyJjkJEgUv4=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=KnA9jOxrixYS7rnAsOtJy6dUSSNs5GgVVGsM/0teG5AEzMSBhvk29pzJdFFrPAF+r
         XxL0480619L8pnuVPK9NPWQWvTVGrtFYn5ZgeKlnJVyyJt228kp8H/shTkUn4jRaWS
         BijSyQ9qHvuSb/vXNXxM2fEVq0rckH5yMzi20evfVGQbnrQQnuyXJJPpKTyGmIXUc4
         sCTGtrMYFyPpRRMjtuk7RUApyWbvU7mXxan9DD1MwfQGxBSQ1sKPxa6V7zwUw101Ql
         6qdNG3GABXWt8SvxF6KmSX4cGHMHo5pemsqE8EK43Ggus9XFv4imFEatzy9bW2igeC
         CvoV4OWeDtURA==
Received: from alphecca.canonical.com (localhost [IPv6:::1])
        by alphecca.canonical.com (Postfix) with ESMTP id 48C94E00342
        for <linux-rdma@vger.kernel.org>; Wed,  4 Aug 2021 20:00:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Owner @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: package-build-status
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: FAILEDTOBUILD
X-Creator-Recipient: bdrung@posteo.de
X-Launchpad-Build-Arch: i386
X-Launchpad-Build-Component: main
X-Launchpad-PPA: linux-rdma-rdma-core-daily
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   Launchpad Buildd System <noreply@launchpad.net>
Subject: [Build #21838531] i386 build of rdma-core 37.0~202108040743+git313509f8~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <162810725329.8972.6442681920407682185.launchpad@alphecca.canonical.com>
Date:   Wed, 04 Aug 2021 20:00:53 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="c08a1e23be9b835a8d0e7a32b2e55270fac05933"; Instance="buildmaster"
X-Launchpad-Hash: ad34ce6b90d79fb890a06cbf55163d064dd80630
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


 * Source Package: rdma-core
 * Version: 37.0~202108040743+git313509f8~ubuntu18.04.1
 * Architecture: i386
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/21838531/+files/buildlog_ubuntu-bionic-i386.rdma-core_37.0~2021=
08040743+git313509f8~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/lgw01-amd64-039
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
i386 build of rdma-core 37.0~202108040743+git313509f8~ubuntu18.04.1 in ubun=
tu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/21=
838531

You are receiving this email because your team Linux RDMA is the owner
of this archive.

