Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D033E1D10
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 21:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbhHET6M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 15:58:12 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251]:47606
        "EHLO smtp-relay-services-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239501AbhHET6L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 15:58:11 -0400
Received: from alphecca.canonical.com (alphecca.canonical.com [91.189.89.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 2093C40673
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 19:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1628193476;
        bh=FRNTBIBbcglWPlaFNrCjodyO7s5hstbX8unR6gNNNA4=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=W9+U4m8zkViGbQ7HgryVpaAXcSHY75adjQORFauHKbAdGwMR8Vl5IphmyS1WtMVi0
         4CWTPqyJN6BZIxpxQPvt04okHzPCWV8ciQX8Vwp2z6eVtymYVI24wYC1/uirmJAQQO
         frF0oM8OkU/TzQE96Gk/p4nCKNp3qNOaokGX7dRva/mBuBPo8HWPWo4DqDu8F/zBFR
         e75CBJjYoxU33D8s+/9Ghk4avwdve8hiKA1gEKMY4v+oWsGFiS9KMP9JSMcmzXodVP
         K7cqzOq5KqhsGFdy/2uTAnjM8F5Qkk3PLgRvuT7T+FJ9fqdF56bwWMPndZYloXdB65
         Ms7Dg9WPXN9IQ==
Received: from alphecca.canonical.com (localhost [IPv6:::1])
        by alphecca.canonical.com (Postfix) with ESMTP id 1A4B4E002A9
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 19:57:56 +0000 (UTC)
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
Subject: [recipe build #2846210] of ~linux-rdma rdma-core-daily in focal: Failed to upload
Message-Id: <162819347610.13190.13436988298895398048.launchpad@alphecca.canonical.com>
Date:   Thu, 05 Aug 2021 19:57:56 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="c08a1e23be9b835a8d0e7a32b2e55270fac05933"; Instance="buildmaster"
X-Launchpad-Hash: 597bfc1f39aaa85b6ffb83cb560c44a672686ded
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 * State: Failed to upload
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: focal
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/2846210/+files/buildlog.txt.gz
 * Upload Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-=
daily/+recipebuild/2846210/+files/upload_2846210_log.txt
 * Builder: https://launchpad.net/builders/lgw01-amd64-036

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/2846210
Your team Linux RDMA is the requester of the build.

