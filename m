Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A23E1D09
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 21:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbhHETy1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 15:54:27 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250]:40896
        "EHLO smtp-relay-services-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239921AbhHETy1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 15:54:27 -0400
Received: from alphecca.canonical.com (alphecca.canonical.com [91.189.89.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 245B34203B
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 19:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1628193252;
        bh=lavN4UQ37kScqJuruLNIJ5NcHc8lkeN3iPbN3BawooA=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=qOXiuE8H6lcS/ghotGdIZBsBWVUDjw310VCz2eW7d4nAYNzpKfj2xVms78Aa1Qc+8
         EkKO8LJheKY7cr0NZvWVhBfo16/6gdEJNWcZrb7bsLTybgPi8INWIJNfzyXGqRBN2X
         7+Poy+oF3QbRg/QPgMVh4PMPr5gFAZgpOJMUPg/6KgunvDrMLpolW5l0pr2L8nvnY2
         ZUU3eBbDs0g9aSzDmcL7z1FaCbfN/MN3RGICx68TbpM3qGPo1IK2uhY/sthNajH1CE
         4CklI6RF/uTcRhdGdgdt/+h0ovUtw01aLMxyShIkwAT3N0C3xZn0VhL4ZFkT54tS09
         WsEz5gOk1oYCA==
Received: from alphecca.canonical.com (localhost [IPv6:::1])
        by alphecca.canonical.com (Postfix) with ESMTP id 1F159E001FD
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 19:54:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Requester @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: recipe-build-status
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: FAILEDTOUPLOAD
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   noreply@launchpad.net
Subject: [recipe build #2846212] of ~linux-rdma rdma-core-daily in impish: Failed to upload
Message-Id: <162819325212.9394.5994947993964758279.launchpad@alphecca.canonical.com>
Date:   Thu, 05 Aug 2021 19:54:12 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="c08a1e23be9b835a8d0e7a32b2e55270fac05933"; Instance="buildmaster"
X-Launchpad-Hash: cc05c7f16ce6fdb672516ebf62daf2ab3a068ffe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 * State: Failed to upload
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: impish
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/2846212/+files/buildlog.txt.gz
 * Upload Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-=
daily/+recipebuild/2846212/+files/upload_2846212_log.txt
 * Builder: https://launchpad.net/builders/lcy01-amd64-002

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/2846212
Your team Linux RDMA is the requester of the build.

