Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310A33E1D0A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 21:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbhHETye (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 15:54:34 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251]:46976
        "EHLO smtp-relay-services-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240117AbhHETyb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 15:54:31 -0400
Received: from alphecca.canonical.com (alphecca.canonical.com [91.189.89.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 370573F31B
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 19:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1628193256;
        bh=o4f2I9D5eWhN0yvu+ZTrNuDZ/uFUt/3P26Ylztyjhks=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=cnhbWFFxsNs/GLm9V49zH2RZVo6RZ42g6HFeg1a/cOI3NAPrgWcil57xI/W/7VuQc
         JOFAIBxdJNebPqUrUEERYd0Uw3nec/bX3sf7IoWiEUpQXjvf+9DcHwDfpqVg+xBWdi
         uOHoYRioc/DDPPl2aCsJj1LlZc5K+iLGjLOSagsDXluAo82Io/Gbim+YZ94650zTKX
         H5OytE9862vR3O2g0Mld5KPm1NlYYJsS90+AR8orx637Yqve5SD9iVtnTkT79AHXzW
         aOiBvZdWFz0rBwyv7eXXwsCXRqXzcyM43Z+BIZYUJj314v0WM4c1/MBczFCuDiZQMV
         Y3nmC2tEAf+lg==
Received: from alphecca.canonical.com (localhost [IPv6:::1])
        by alphecca.canonical.com (Postfix) with ESMTP id 320D1E001FD
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 19:54:16 +0000 (UTC)
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
Subject: [recipe build #2846209] of ~linux-rdma rdma-core-daily in bionic: Failed to upload
Message-Id: <162819325620.9394.3350569295115769994.launchpad@alphecca.canonical.com>
Date:   Thu, 05 Aug 2021 19:54:16 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="c08a1e23be9b835a8d0e7a32b2e55270fac05933"; Instance="buildmaster"
X-Launchpad-Hash: 6c63b14735b50f963b0676fc22e1ebeb9f104a44
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 * State: Failed to upload
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: bionic
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/2846209/+files/buildlog.txt.gz
 * Upload Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-=
daily/+recipebuild/2846209/+files/upload_2846209_log.txt
 * Builder: https://launchpad.net/builders/lcy01-amd64-019

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/2846209
Your team Linux RDMA is the requester of the build.

