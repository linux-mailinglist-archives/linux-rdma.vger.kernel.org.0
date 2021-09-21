Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F08B4139DA
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Sep 2021 20:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhIUSQb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Sep 2021 14:16:31 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251]:35690
        "EHLO smtp-relay-services-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232597AbhIUSQa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Sep 2021 14:16:30 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2021 14:16:30 EDT
Received: from alphecca.canonical.com (alphecca.canonical.com [91.189.89.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 789F33F143
        for <linux-rdma@vger.kernel.org>; Tue, 21 Sep 2021 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1632247553;
        bh=el9h5JsbDoZLS0r3ZMlChkbUJj1x1njwwH6xEP76N8I=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=O4XJwLF+IuLS3v9SB+n+iAR14EbmkeKly394DacNJ1tHYOxX4kkzNVTmVuYx3K/oc
         KHkpt0+mhuii/TOo7l2csZr2i1pqbGdVOig8zaqCQAfGsN/eWFIluFg51uyasqvOnT
         3dN+1OjxdKY1QkIhC0EPTq9HQ7bWyYcwKmpuvrVabmDjsdO/pPjZXnuZoFMZUUZp3t
         YfMEjuLCz0Mcio25qWHH2UfraX+nm110z2WAyUvUyY4fzVXSV3Ca/ssK4Kgn07/14v
         i8JB9jQDjXY+68x8JWopT0SFf9UsLEMQLUBNeHU/nxhy8IecMpKpdvSulr3+Sr/sPW
         4n80V6GcIpIuA==
Received: from alphecca.canonical.com (localhost [IPv6:::1])
        by alphecca.canonical.com (Postfix) with ESMTP id 44ED8E002C3
        for <linux-rdma@vger.kernel.org>; Tue, 21 Sep 2021 18:05:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Requester @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: recipe-build-status
X-Launchpad-Build-State: FAILEDTOBUILD
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   noreply@launchpad.net
Subject: [recipe build #2871904] of ~linux-rdma rdma-core-daily in impish: Failed to build
Message-Id: <163224755327.1053.12332285110335765646.launchpad@alphecca.canonical.com>
Date:   Tue, 21 Sep 2021 18:05:53 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="1ebe1b0e212bc611a219cd41410c4d5143daacf0"; Instance="buildmaster"
X-Launchpad-Hash: a632291e360c1c3cbf569f4811af3f6004cf4690
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 * State: Failed to build
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: impish
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/2871904/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lgw01-amd64-022

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/2871904
Your team Linux RDMA is the requester of the build.

