Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AF43E1D03
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 21:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbhHETyR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 15:54:17 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250]:40890
        "EHLO smtp-relay-services-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239921AbhHETyP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 15:54:15 -0400
Received: from alphecca.canonical.com (alphecca.canonical.com [91.189.89.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 377204203B
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 19:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1628193239;
        bh=ugVjZubrhh47ofhwHU1Tm4j5soxdZmEnA3HHEj+t3BI=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=UxMsBvZMFN51SYDWkvSsbUSdrrt3ZSZkyYw9VgQdNdWa1XUbjfg2srMz7FE09z1Py
         zuTIzNTHRbMSeYBOrAXB0LybWQQ8Y7V2Xj/fuIOYfUfDyfX4BOFrnur9HXhjYPndos
         4HynKTti0f9ZzG4iwrXw2eBSu9DWzsz4yrHn4APs5UnxZMfJe7IX+auy7CBAWezaYp
         E5P7xz6vMTAmhJ1RYsCfNn0mpfTqX5hrVgyQVhHGuuMvjUZi5q8GdtyzrWLelZIlZR
         2n0R3WAO/r4D1njskieh7XnX4aF3zHKhTGEhpA+Oi/oAHA8Hbr03bDQI3Thhtn1cVi
         yKGjb7l6CJxTw==
Received: from alphecca.canonical.com (localhost [IPv6:::1])
        by alphecca.canonical.com (Postfix) with ESMTP id 31EF4E002AC
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 19:53:59 +0000 (UTC)
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
Subject: [recipe build #2846208] of ~linux-rdma rdma-core-daily in xenial: Failed to upload
Message-Id: <162819323920.9394.2562049811370600308.launchpad@alphecca.canonical.com>
Date:   Thu, 05 Aug 2021 19:53:59 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="c08a1e23be9b835a8d0e7a32b2e55270fac05933"; Instance="buildmaster"
X-Launchpad-Hash: 38e54c569f65ef4041a754d835b5f387a71dee29
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 * State: Failed to upload
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/2846208/+files/buildlog.txt.gz
 * Upload Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-=
daily/+recipebuild/2846208/+files/upload_2846208_log.txt
 * Builder: https://launchpad.net/builders/lgw01-amd64-058

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/2846208
Your team Linux RDMA is the requester of the build.

