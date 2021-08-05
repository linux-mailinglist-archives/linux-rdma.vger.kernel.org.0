Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AAE3E1D02
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 21:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbhHETyD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 15:54:03 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251]:46960
        "EHLO smtp-relay-services-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239656AbhHETyC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 15:54:02 -0400
Received: from alphecca.canonical.com (alphecca.canonical.com [91.189.89.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 885B740677
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 19:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1628193226;
        bh=Yf6hGWgs938Qn7rw7EuTtFNMvV78lyIw8S0xqKy7Ve4=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=C1In8T3puNmZedkynMcKnfAikp5jRFe4i14FHOWVhkEqD1FZ8QcWqMyHkvqpswr6a
         GX7tIjJ5Gztfd9uiXItt9l/dWSe2N8fxgpeyaoS/ZImz/1piSBf1jAO/t+WRSBxKU4
         +DsS/YTxeK50AlQZvW8/Byxbr6yN/I3y3BuJMgr5TphWCFznzEUlxyZB7xM9JmocWu
         jb1B8A4zCrj278kCQBKfZSWQYpYaBU0aKlZ2lLr8yTY45PbZMHD+hAPB6RmWNasIJZ
         4ysb2SqHhvCvueLJ5nlzNZbQ5rzCegEM9uW8MpZGP9XnFT9P4R1pxLOF7dxORmgCQt
         5CX0pN/AbIKRQ==
Received: from alphecca.canonical.com (localhost [IPv6:::1])
        by alphecca.canonical.com (Postfix) with ESMTP id 802FEE002AC
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 19:53:46 +0000 (UTC)
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
Subject: [recipe build #2846211] of ~linux-rdma rdma-core-daily in hirsute: Failed to upload
Message-Id: <162819322652.9394.5682684667730173329.launchpad@alphecca.canonical.com>
Date:   Thu, 05 Aug 2021 19:53:46 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="c08a1e23be9b835a8d0e7a32b2e55270fac05933"; Instance="buildmaster"
X-Launchpad-Hash: 772ecdc2fc4b9fb0a736916e0dc899c5dd9afb50
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 * State: Failed to upload
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: hirsute
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/2846211/+files/buildlog.txt.gz
 * Upload Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-=
daily/+recipebuild/2846211/+files/upload_2846211_log.txt
 * Builder: https://launchpad.net/builders/lcy01-amd64-005

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/2846211
Your team Linux RDMA is the requester of the build.

